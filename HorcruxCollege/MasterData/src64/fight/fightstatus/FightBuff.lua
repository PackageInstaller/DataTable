FightBuff = class("FightBuff")

local buff_data = require("data.buff_data")
local encrypt_data = require("data.encrypt_data")
local trigger_manager = require("fight.trigger_manager")
local fightstatus_manager = require("fight.fightstatus.fightstatus_manager")

function FightBuff.create(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7)
	local var_1_0 = FightBuff.new()

	var_1_0:init(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7)

	return var_1_0
end

function FightBuff:init(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6, arg_2_7)
	self.character = arg_2_2
	self.buffdata = buff_data[arg_2_1]
	self.id = arg_2_1
	self.effectadd = nil
	self.buff_stack = {}
	self._count = 0
	self._maxstack = self.buffdata.appendable

	self:pushBuff(arg_2_3, arg_2_4, arg_2_5, arg_2_6, arg_2_7)
	self:onBuffAdd()
end

function FightBuff:removeAllBuff(arg_3_1)
	self:onBuffRemove(arg_3_1)
end

function FightBuff:onBuffAdd()
	if self.buffdata.effect then
		self.effectadd = self.character:addBuffEffect(self.buffdata.effect, self.buffdata.ani, self.buffdata.offsetX, self.buffdata.offsetY, self.buffdata.offsetZ)
	end
end

function FightBuff:onBuffRemove(arg_5_1)
	if not self.character._instance then
		return
	end

	local var_5_0

	for iter_5_0 = 1, self._count do
		self.character:unregisterBuff(self.id, 1, self.buff_stack[iter_5_0]._source)

		var_5_0 = self.buff_stack[iter_5_0]
	end

	if not arg_5_1 and var_5_0 then
		self:triggerStatusOnFinish(var_5_0, self._count)
	end

	if self._count > 0 then
		self.character:popBuff(self.id, self._count)
	end

	if self.effectadd then
		self.character:removeBuffEffect(self.effectadd)
	end
end

function FightBuff:pushBuff(arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5)
	local var_6_0 = self._maxstack + self.character:getBuffStackAdd(self.id) + (arg_6_5 or 0)
	local var_6_1 = 1 + (arg_6_4 or 0) + self.character:getBuffTimeFac(self.buffdata.buff_or_debuff)

	if self.buffdata.buff_or_debuff == 0 and self.buffdata.cleanable > 1 then
		var_6_1 = var_6_1 * (1 - self.character:getAttribute("tenacity"))
	end

	if var_6_1 < 0.1 then
		var_6_1 = 0.1
	end

	if var_6_0 <= self._count then
		self:removeBuff(1)

		self.buff_stack[#self.buff_stack + 1] = self.buffdata.needattackcount and {
			_needattackcount = self.buffdata.needattackcount,
			_source = arg_6_2
		} or {
			_time = (self.buffdata.time + self.character:getBuffTimeAdd(self.id) + arg_6_3) * var_6_1,
			_totaltime = (self.buffdata.time + self.character:getBuffTimeAdd(self.id) + arg_6_3) * var_6_1,
			_source = arg_6_2
		}

		self.character:registerBuff(self.id, arg_6_2)

		self._count = self._count + 1

		self.character:pushBackBuff(self.id, 1)
	else
		local var_6_2 = 0

		while var_6_2 < arg_6_1 and var_6_0 > self._count do
			self.buff_stack[#self.buff_stack + 1] = self.buffdata.needattackcount and {
				_needattackcount = self.buffdata.needattackcount,
				_source = arg_6_2
			} or {
				_time = (self.buffdata.time + self.character:getBuffTimeAdd(self.id) + arg_6_3) * var_6_1,
				_totaltime = (self.buffdata.time + self.character:getBuffTimeAdd(self.id) + arg_6_3) * var_6_1,
				_source = arg_6_2
			}

			self.character:registerBuff(self.id, arg_6_2)

			self._count = self._count + 1
			var_6_2 = var_6_2 + 1
		end

		self.character:pushBackBuff(self.id, var_6_2)
	end

	if self.buffdata.unionbufftime then
		self.buff_stack[1]._time = (self.buffdata.time + self.character:getBuffTimeAdd(self.id) + arg_6_3) * var_6_1
	end
end

function FightBuff:removeBuff(arg_7_1)
	self.character:unregisterBuff(self.id, 1, self.buff_stack[arg_7_1]._source)

	self._count = self._count - 1

	self.character:popBuff(self.id, 1)

	return (table.remove(self.buff_stack, arg_7_1))
end

function FightBuff:removeBuffByCount(arg_8_1)
	arg_8_1 = math.min(arg_8_1, self._count)

	while self.buff_stack[1] and 1 <= arg_8_1 do
		self.character:unregisterBuff(self.id, 1, self.buff_stack[1]._source)

		self._count = self._count - 1

		table.remove(self.buff_stack, 1)
	end

	if arg_8_1 > 0 then
		self.character:popBuff(self.id, arg_8_1)
	end

	return self._count <= 0
end

function FightBuff:getBuffCount()
	return self._count
end

function FightBuff:getBuffTime()
	if not self.buff_stack[1] then
		return 0
	end

	if self.buff_stack[1]._needattackcount then
		return self.buff_stack[1]._needattackcount
	else
		return self.buff_stack[1]._time
	end
end

function FightBuff:update(arg_11_1)
	if not self.buff_stack[1] then
		self.character:removeBuff(self.id)

		return
	end

	if not self.buff_stack[1]._time then
		return
	end

	self.buff_stack[1]._time = self.buff_stack[1]._time - arg_11_1 * (1 + global_fight_speedup)

	if self.buffdata.unionbufftime then
		if self.buff_stack[1]._time <= 0 then
			self.character:removeBuff(self.id)
		end
	else
		if self.buff_stack[1]._time <= 0 then
			self:triggerStatusOnFinish(self:removeBuff(1), 1)
		end

		if self._count <= 0 then
			self.character:removeBuff(self.id)
		end
	end
end

function FightBuff:updateOnAttack()
	if not self.buff_stack[1] then
		self.character:removeBuff(self.id)

		return
	end

	if not self.buff_stack[1]._needattackcount then
		return
	end

	self.buff_stack[1]._needattackcount = self.buff_stack[1]._needattackcount - 1

	if self.buff_stack[1]._needattackcount < 0 then
		self:triggerStatusOnFinish(self:removeBuff(1), 1)

		if self._count <= 0 then
			self.character:removeBuff(self.id)
		end
	end
end

local function var_0_4(arg_13_0, arg_13_1)
	if arg_13_0 ~= -1 then
		return arg_13_0
	end

	if not arg_13_1 then
		return arg_13_0
	end

	local var_13_0 = FightManager.getCharacter(arg_13_1)

	if not var_13_0 then
		return arg_13_0
	end

	return var_13_0:getAttribute("range")
end

local function var_0_5(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4, arg_14_5, arg_14_6, arg_14_7, arg_14_8)
	if arg_14_6 == OWNERSELF then
		arg_14_3(arg_14_2, arg_14_1.index, arg_14_1.index, arg_14_4, arg_14_5, arg_14_8)
	elseif arg_14_6 == ALLTEAMMATE then
		for iter_14_0, iter_14_1 in pairs((arg_14_0:getAllTeammate())) do
			arg_14_3(arg_14_2, arg_14_1.index, iter_14_1.index, arg_14_4, arg_14_5, arg_14_8)
		end
	elseif arg_14_6 == TEAMMATE_IN_AREA_OF_SELF then
		for iter_14_2, iter_14_3 in pairs((arg_14_0:getAreaTeammate(arg_14_0:getStandardPosition(), var_0_4(arg_14_7.offset_left, arg_14_0.index), (var_0_4(arg_14_7.offset_right, arg_14_0.index))))) do
			arg_14_3(arg_14_2, arg_14_1.index, iter_14_3.index, arg_14_4, arg_14_5, arg_14_8)
		end
	elseif arg_14_6 == TEAMMATE_IN_AREA_OF_TARGET then
		for iter_14_4, iter_14_5 in pairs((arg_14_0:getAreaTeammate(arg_14_1:getStandardPosition(), var_0_4(arg_14_7.offset_left, arg_14_0.index), (var_0_4(arg_14_7.offset_right, arg_14_0.index))))) do
			arg_14_3(arg_14_2, arg_14_1.index, iter_14_5.index, arg_14_4, arg_14_5, arg_14_8)
		end
	elseif arg_14_6 == TARGET then
		arg_14_3(arg_14_2, arg_14_1.index, arg_14_1.index, arg_14_4, arg_14_5, arg_14_8)
	elseif arg_14_6 == ALLOPONENT then
		for iter_14_6, iter_14_7 in pairs((arg_14_0:getAllOponent())) do
			arg_14_3(arg_14_2, arg_14_1.index, iter_14_7.index, arg_14_4, arg_14_5, arg_14_8)
		end
	elseif arg_14_6 == OPONENT_IN_AREA_OF_SELF then
		for iter_14_8, iter_14_9 in pairs((arg_14_0:getAreaOponent(arg_14_0:getStandardPosition(), var_0_4(arg_14_7.offset_left, arg_14_0.index), (var_0_4(arg_14_7.offset_right, arg_14_0.index))))) do
			arg_14_3(arg_14_2, arg_14_1.index, iter_14_9.index, arg_14_4, arg_14_5, arg_14_8)
		end
	elseif arg_14_6 == OPONENT_IN_AREA_OF_TARGET then
		for iter_14_10, iter_14_11 in pairs((arg_14_0:getAreaOponent(arg_14_1:getStandardPosition(), var_0_4(arg_14_7.offset_left, arg_14_0.index), (var_0_4(arg_14_7.offset_right, arg_14_0.index))))) do
			arg_14_3(arg_14_2, arg_14_1.index, iter_14_11.index, arg_14_4, arg_14_5, arg_14_8)
		end
	elseif arg_14_6 == TEAMMATE_IN_AREA then
		return
	elseif arg_14_6 == OPONENT_IN_AREA then
		return
	elseif arg_14_6 == OPENENT_IN_AREA_OF_TARGET_WITHOUT_TARGET then
		for iter_14_12, iter_14_13 in pairs((arg_14_0:getAreaOponent(arg_14_1:getStandardPosition(), var_0_4(arg_14_7.offset_left, arg_14_0.index), (var_0_4(arg_14_7.offset_right, arg_14_0.index))))) do
			if iter_14_13.index ~= arg_14_1.index then
				arg_14_3(arg_14_2, arg_14_1.index, iter_14_13.index, arg_14_4, arg_14_5, arg_14_8)
			end
		end
	elseif arg_14_6 == TEAMMATE_WITHOUT_SELF then
		for iter_14_14, iter_14_15 in pairs((arg_14_0:getAllTeammate())) do
			if iter_14_15.index ~= self._owner then
				arg_14_3(arg_14_2, arg_14_1.index, iter_14_15.index, arg_14_4, arg_14_5, arg_14_8)
			end
		end
	elseif arg_14_6 == OPONENT_NEAREST then
		local var_14_1 = arg_14_0:getNearestOponent()

		if var_14_1 then
			arg_14_3(arg_14_2, arg_14_1.index, var_14_1.index, arg_14_4, arg_14_5, arg_14_8)
		end
	end
end

local var_0_6 = {
	[126] = true
}

local function var_0_7(arg_15_0, arg_15_1)
	if type(arg_15_1) ~= "number" then
		return arg_15_1
	end

	if var_0_6[arg_15_0] then
		return arg_15_1
	end

	return bit.bxor(arg_15_1, 11471007) / 10000
end

local var_0_8 = {
	[MAKE_ATTACK] = true,
	[MAKE_ENERGY_ATTACK] = true,
	[MAKE_HOLY_ATTACK] = true,
	[OLDMAKE_ATTACK] = true,
	[RECOVERY] = true
}

local function var_0_9(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5, arg_16_6, arg_16_7, arg_16_8, arg_16_9, arg_16_10, arg_16_11, arg_16_12)
	arg_16_6 = arg_16_6 or 1

	if arg_16_6 < math.random() then
		return
	end

	if arg_16_8 then
		local var_16_0 = trigger_manager.decode_judge_conditions(arg_16_8, arg_16_9, arg_16_10)

		if not trigger_manager.judge_conditions(var_16_0.conditions, var_16_0.param, var_16_0.target, arg_16_0, arg_16_1) then
			return
		end
	end

	local var_16_1 = encrypt_data[arg_16_4]

	assert(encrypt_data[arg_16_4], "status " .. arg_16_4 .. " is nil")

	if arg_16_3 == 0 then
		arg_16_1:registerStatus(arg_16_4, arg_16_2, arg_16_0.index, {
			exetype = 0,
			execonfig = {
				target = arg_16_5,
				area = arg_16_7
			}
		})
	else
		local var_16_2 = {
			param1 = var_16_1.param1,
			value1 = var_0_7(var_16_1.status_type, var_16_1.value1),
			target1 = var_16_1.target1,
			param2 = var_16_1.param2,
			value2 = var_0_7(var_16_1.status_type, var_16_1.value2),
			target2 = var_16_1.target2,
			param3 = var_16_1.param3,
			value3 = var_0_7(var_16_1.status_type, var_16_1.value3),
			target3 = var_16_1.target3,
			param4 = var_16_1.param4,
			value4 = var_0_7(var_16_1.status_type, var_16_1.value4),
			target4 = var_16_1.value4
		}

		var_0_5(arg_16_0, arg_16_1, arg_16_4, fightstatus_manager:getTriggerMethod(var_16_1.status_type), (var_0_8[statustype] or nil) and (fightstatus_manager:getRealSourceParam(var_16_2, arg_16_0) or fightstatus_manager:getTriggerSourceParam(var_16_2, arg_16_0)), {
			paramtbl = var_16_2,
			refrencecount = arg_16_11,
			exetarget = arg_16_5,
			sourceindex = arg_16_0.index
		}, arg_16_5, arg_16_7, arg_16_12)
	end
end

function FightBuff:triggerStatusOnFinish(arg_17_1, arg_17_2)
	if not self.buffdata.finish_status_add1 then
		return
	end

	local var_17_0 = FightManager.getCharacter(arg_17_1._source)

	if not var_17_0 then
		return
	end

	local var_17_1 = self.character
	local var_17_2 = self.buffdata
	local var_17_3 = {}

	var_17_3.bufftime = arg_17_1._needattackcount and math.max(0, arg_17_1._needattackcount / self.buffdata.needattackcount) or math.max(0, arg_17_1._time / arg_17_1._totaltime)

	local var_17_4 = 1

	while var_17_2["finish_status_add" .. var_17_4] do
		var_0_9(var_17_0, var_17_1, "finishbuff_" .. self.id, var_17_2["finish_exe_type" .. var_17_4], var_17_2["finish_status_add" .. var_17_4], var_17_2["finish_status_target" .. var_17_4], var_17_2["finish_status_prob" .. var_17_4], {
			offset_left = var_17_2["finish_status_area_offset_left" .. var_17_4],
			offset_right = var_17_2["finish_status_area_offset_right" .. var_17_4]
		}, var_17_2["finish_status_judge_type" .. var_17_4], var_17_2["finish_status_judge_target" .. var_17_4], var_17_2["finish_status_judge_param" .. var_17_4], arg_17_2, var_17_3)

		var_17_4 = var_17_4 + 1
	end
end

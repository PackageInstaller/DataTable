FightStatus = class("FightStatus")

local fightstatus_manager = require("fight.fightstatus.fightstatus_manager")
local trigger_manager = require("fight.trigger_manager")
local encrypt_data = require("data.encrypt_data")
local bit = require("bit")

function FightStatus.create(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6)
	return (FightStatus.new(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6))
end

function FightStatus:ctor(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6)
	self._index = arg_2_1
	self._id = arg_2_2
	self._ishorcrux = arg_2_5.ishorcrux
	self._statusaddsource = arg_2_6
	self._owner = arg_2_3
	self._source = arg_2_4

	self:initStatusConfig(arg_2_5)
	self:initStatusData()
	self:initExeMethods()
	self:pushStatus()
	self:registerToStatusPool()
end

function FightStatus:initStatusConfig(arg_3_1)
	self._exetype = arg_3_1.exetype
	self._globaltype = self._exetype == 0 and REGISTER_STATUS or TRIGGER_STATUS
	self._triggertbl = arg_3_1.triggertbl
	self._prob = arg_3_1.prob
	self._exetarget = arg_3_1.execonfig.target
	self._exetargetcount = arg_3_1.execonfig.count or 1
	self._exearea = arg_3_1.execonfig.area
	self._insidercd = arg_3_1.insider_cd or 0
	self._currentcd = self._insidercd
	self._public_cd = arg_3_1.public_cd
	self._statusaddtype = arg_3_1.add_type
	self._refrencecount = 0
	self._isunionprob = arg_3_1.isunionprob
end

local var_0_4 = {
	[126] = true
}

local function var_0_5(arg_4_0, arg_4_1)
	if type(arg_4_1) ~= "number" then
		return arg_4_1
	end

	if var_0_4[arg_4_0] then
		return arg_4_1
	end

	return bit.bxor(arg_4_1, 11471007) / 10000
end

function FightStatus:initStatusData()
	assert(encrypt_data[self._id], string.format("skill satus is nil ,self._id is %d", self._id))

	self._statustype = encrypt_data[self._id].status_type
	self._paramtbl = {
		param1 = encrypt_data[self._id].param1,
		value1 = var_0_5(self._statustype, encrypt_data[self._id].value1),
		target1 = encrypt_data[self._id].target1,
		max1 = encrypt_data[self._id].max1,
		sourcechange1 = encrypt_data[self._id].sourcechange1,
		sourcechange1 = encrypt_data[self._id].sourcechange1,
		param2 = encrypt_data[self._id].param2,
		value2 = var_0_5(self._statustype, encrypt_data[self._id].value2),
		target2 = encrypt_data[self._id].target2,
		max2 = encrypt_data[self._id].max2,
		sourcechange2 = encrypt_data[self._id].sourcechange2,
		param3 = encrypt_data[self._id].param3,
		value3 = var_0_5(self._statustype, encrypt_data[self._id].value3),
		target3 = encrypt_data[self._id].target3,
		max3 = encrypt_data[self._id].max3,
		sourcechange3 = encrypt_data[self._id].sourcechange3,
		param4 = encrypt_data[self._id].param4,
		value4 = var_0_5(self._statustype, encrypt_data[self._id].value4),
		target4 = encrypt_data[self._id].target4,
		max4 = encrypt_data[self._id].max4,
		sourcechange4 = encrypt_data[self._id].sourcechange4,
		param5 = encrypt_data[self._id].param5,
		value5 = encrypt_data[self._id].value5,
		target5 = encrypt_data[self._id].target5,
		max5 = encrypt_data[self._id].max5,
		sourcechange5 = encrypt_data[self._id].sourcechange5,
		param6 = encrypt_data[self._id].param6,
		value6 = encrypt_data[self._id].value6,
		target6 = encrypt_data[self._id].target6,
		max6 = encrypt_data[self._id].max6,
		sourcechange6 = encrypt_data[self._id].sourcechange6
	}
	self._effect = nil

	if encrypt_data[self._id].effect then
		self._effect = {
			filename = encrypt_data[self._id].effect,
			ani = encrypt_data[self._id].ani,
			offsetX = encrypt_data[self._id].offsetX,
			offsetY = encrypt_data[self._id].offsetY,
			offsetZ = encrypt_data[self._id].offsetZ,
			target = encrypt_data[self._id].effecttarget,
			dir = encrypt_data[self._id].effectdir
		}
	end

	self._ttl = encrypt_data[self._id].time
	self._curttl = self._ttl
	self._needattackcount = encrypt_data[self._id].needattackcount
	self._curattackcount = self._needattackcount
	self._statustarget = encrypt_data[self._id].statustarget

	self:fixStatusParams()
end

local function var_0_6(arg_6_0, arg_6_1)
	if arg_6_1 == "singlehp" then
		return arg_6_0 == "hp"
	else
		return arg_6_0 == arg_6_1
	end
end

function FightStatus:fixStatusParams()
	if self._globaltype ~= REGISTER_STATUS then
		return
	end

	self._useattrfac = nil
end

local var_0_8 = {
	[MAKE_ATTACK] = true,
	[MAKE_ENERGY_ATTACK] = true,
	[MAKE_HOLY_ATTACK] = true,
	[OLDMAKE_ATTACK] = true,
	[RECOVERY] = true,
	[OLDSHIELD] = true,
	[SHIELD] = true
}

function FightStatus:initExeMethods()
	if self._globaltype == REGISTER_STATUS then
		self._registermethod = fightstatus_manager:getRegisterMethod(self._statustype)
		self._unregistermethod = fightstatus_manager:getUnregisterMethod(self._statustype)
		self._registervalue = 0
		self._registerbasicvalue = nil
		self._registerattribute = nil
		self._sourceparam = var_0_8[self._statustype] and fightstatus_manager:getRealSourceParam(self._paramtbl, FightManager.getCharacter(self._source)) or fightstatus_manager:getSourceParam(self._paramtbl, FightManager.getCharacter(self._source))
	else
		self._triggermethod = fightstatus_manager:getTriggerMethod(self._statustype)
		self._sourceparam = var_0_8[self._statustype] and fightstatus_manager:getRealSourceParam(self._paramtbl, FightManager.getCharacter(self._source)) or fightstatus_manager:getTriggerSourceParam(self._paramtbl, FightManager.getCharacter(self._source))
	end
end

function FightStatus:registerToStatusPool()
	local var_10_0 = FightManager.getCharacter(self._owner)

	if not var_10_0 then
		return
	end

	local var_10_1 = {}

	if self._globaltype == REGISTER_STATUS then
		var_10_1.basicattr = {}

		for iter_10_0 = 1, 3 do
			if self._paramtbl["param" .. iter_10_0] and self._paramtbl["target" .. iter_10_0] ~= 1 then
				if baseAttr[self._paramtbl["param" .. iter_10_0]].relations then
					for iter_10_1, iter_10_2 in pairs(baseAttr[self._paramtbl["param" .. iter_10_0]].relations) do
						table.insert(var_10_1.basicattr, iter_10_2)
					end
				end
			end
		end
	elseif self._globaltype == TRIGGER_STATUS then
		var_10_1.condition = trigger_conditions[self._exetype]
	end

	var_10_0:registerToStatusPool(self._index, var_10_1)
end

function FightStatus:unregisterFromStatusPool()
	local var_11_0 = FightManager.getCharacter(self._owner)

	if not var_11_0 then
		return
	end

	local var_11_1 = {}

	if self._globaltype == REGISTER_STATUS then
		var_11_1.basicattr = {}

		for iter_11_0 = 1, 3 do
			if self._paramtbl["param" .. iter_11_0] and self._paramtbl["target" .. iter_11_0] ~= 1 then
				if baseAttr[self._paramtbl["param" .. iter_11_0]].relations then
					for iter_11_1, iter_11_2 in pairs(baseAttr[self._paramtbl["param" .. iter_11_0]].relations) do
						table.insert(var_11_1.basicattr, iter_11_2)
					end
				end
			end
		end
	elseif self._globaltype == TRIGGER_STATUS then
		var_11_1.condition = trigger_conditions[self._exetype]
	end

	var_11_0:unregisterFromStatusPool(self._index, var_11_1)
end

function FightStatus:getStatusCount()
	return self._refrencecount
end

function FightStatus:pushStatus()
	self._refrencecount = self._refrencecount + 1

	if self._globaltype == REGISTER_STATUS then
		self:register()
	end

	self._curttl = self._ttl
	self._curattackcount = self._needattackcount
end

function FightStatus:removeStatus()
	if self._globaltype == REGISTER_STATUS then
		self:unregister()
	end

	self._refrencecount = self._refrencecount - 1

	if self._refrencecount <= 0 then
		self:unregisterFromStatusPool()
	end
end

function FightStatus:removeAllStatus()
	if self._globaltype == REGISTER_STATUS then
		if self._unregistermethod then
			for iter_15_0 = 1, self._refrencecount do
				self._unregistermethod(self._id, self._owner, self._source, self._paramtbl, self._sourceparam)
			end
		else
			FightManager.getCharacter(self._owner):addAttribute(self._registerattribute, -self._registervalue)
		end
	end

	self:unregisterFromStatusPool()
end

function FightStatus:register()
	if not self._registermethod then
		return
	end

	local var_16_0 = self._registerbasicvalue
	local var_16_1 = self._registerattribute

	if not self._registerbasicvalue then
		var_16_0, var_16_1 = self._registermethod(self._id, self._owner, self._source, self._paramtbl, self._sourceparam, self._index)
		self._registerbasicvalue = var_16_0
		self._registerattribute = var_16_1
	end

	local var_16_2 = FightManager.getCharacter(self._owner)

	if not var_16_2 then
		return
	end

	if var_16_0 then
		var_16_2:addAttribute(var_16_1, var_16_0, {
			[self._index] = true
		})

		self._registervalue = self._registervalue + var_16_0
	end

	if self._effect then
		var_16_2:playStatusEffect(true, self._effect.filename, self._effect.ani, self._effect.offsetX, self._effect.offsetY, self._effect.offsetZ)
	end
end

function FightStatus:unregister()
	local var_17_0 = FightManager.getCharacter(self._owner)

	if not var_17_0 then
		return
	end

	if self._unregistermethod then
		self._unregistermethod(self._id, self._owner, self._source, self._paramtbl, self._sourceparam, self._index, self._registerbasicvalue)
	else
		local var_17_1 = self._registerbasicvalue or 0

		var_17_0:addAttribute(self._registerattribute, -1 * var_17_1, {
			[self._index] = true
		})

		self._registervalue = self._registervalue - var_17_1
	end

	if self._effect then
		var_17_0:removeBuffEffect(self._effect.filename .. "_" .. self._effect.ani)
	end
end

function FightStatus:checkTriggerCondition(arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = FightManager.getCharacter(self._owner)

	if not var_18_0 then
		return false
	end

	if self._insidercd - var_18_0:getTriggerCDAddition(self._index) > self._currentcd then
		return false
	end

	if self._public_cd and self._public_cd.cd > self._public_cd.curcd then
		return false
	end

	if self._isunionprob and not arg_18_3[self._statusaddsource] then
		return false
	end

	local var_18_1 = self._prob

	if self._statusaddtype == BUFF_ADD_BY_PROB then
		var_18_1 = var_18_1 * self._refrencecount
	end

	if math.random() > var_18_1 + var_18_0:getTriggerProbAddition(self._index) then
		return false
	end

	if not self._triggertbl or trigger_manager.judge_conditions(self._triggertbl.conditions, self._triggertbl.param, self._triggertbl.target, arg_18_1, arg_18_2) then
		return true
	else
		return false
	end
end

function FightStatus:trigger(arg_19_1, arg_19_2)
	self:lockTargetIndependent(arg_19_1, arg_19_2)

	self._currentcd = 0

	if self._public_cd then
		self._public_cd.curcd = 0
	end

	if self._ishorcrux then
		local var_19_0 = FightManager.getCharacter(self._source)

		if var_19_0 then
			var_19_0:playHorcruxTriggerEffect(self._ishorcrux)
		end
	end
end

function FightStatus:checkOffset(arg_20_1)
	if arg_20_1 ~= -1 then
		return arg_20_1
	end

	if not self._source then
		return arg_20_1
	end

	local var_20_0 = FightManager.getCharacter(self._source)

	if not var_20_0 then
		return arg_20_1
	end

	return var_20_0:getAttribute("range")
end

function FightStatus:lockTargetIndependent(arg_21_1, arg_21_2)
	if self._exetarget == OWNERSELF then
		self:exeTriggerMethod(self._owner, arg_21_2)
	elseif self._exetarget == ALLTEAMMATE then
		for iter_21_0, iter_21_1 in pairs((FightManager.getCharacter(self._owner):getAllTeammate())) do
			self:exeTriggerMethod(iter_21_1.index, arg_21_2)
		end
	elseif self._exetarget == TEAMMATE_IN_AREA_OF_SELF then
		local var_21_0 = FightManager.getCharacter(self._owner)

		for iter_21_2, iter_21_3 in pairs((var_21_0:getAreaTeammate(var_21_0:getStandardPosition(), self:checkOffset(self._exearea.offset_left), (self:checkOffset(self._exearea.offset_right))))) do
			self:exeTriggerMethod(iter_21_3.index, arg_21_2)
		end
	elseif self._exetarget == TEAMMATE_IN_AREA_OF_TARGET then
		local var_21_1 = FightManager.getCharacter(arg_21_1)

		if not var_21_1 or not var_21_1._instance then
			return
		end

		for iter_21_4, iter_21_5 in pairs((FightManager.getCharacter(self._owner):getAreaTeammate(var_21_1:getStandardPosition(), self:checkOffset(self._exearea.offset_left), (self:checkOffset(self._exearea.offset_right))))) do
			self:exeTriggerMethod(iter_21_5.index, arg_21_2)
		end
	elseif self._exetarget == TARGET then
		self:exeTriggerMethod(arg_21_1, arg_21_2)
	elseif self._exetarget == ALLOPONENT then
		for iter_21_6, iter_21_7 in pairs((FightManager.getCharacter(self._owner):getAllOponent())) do
			self:exeTriggerMethod(iter_21_7.index, arg_21_2)
		end
	elseif self._exetarget == OPONENT_IN_AREA_OF_SELF then
		local var_21_2 = FightManager.getCharacter(self._owner)

		for iter_21_8, iter_21_9 in pairs((var_21_2:getAreaOponent(var_21_2:getStandardPosition(), self:checkOffset(self._exearea.offset_left), (self:checkOffset(self._exearea.offset_right))))) do
			self:exeTriggerMethod(iter_21_9.index, arg_21_2)
		end
	elseif self._exetarget == OPONENT_IN_AREA_OF_TARGET then
		local var_21_3 = FightManager.getCharacter(arg_21_1)

		if not var_21_3 or not var_21_3._instance then
			return
		end

		for iter_21_10, iter_21_11 in pairs((FightManager.getCharacter(self._owner):getAreaOponent(var_21_3:getStandardPosition(), self:checkOffset(self._exearea.offset_left), (self:checkOffset(self._exearea.offset_right))))) do
			self:exeTriggerMethod(iter_21_11.index, arg_21_2)
		end
	elseif self._exetarget == TEAMMATE_IN_AREA then
		return
	elseif self._exetarget == OPONENT_IN_AREA then
		return
	elseif self._exetarget == OPENENT_IN_AREA_OF_TARGET_WITHOUT_TARGET then
		local var_21_4 = FightManager.getCharacter(arg_21_1)

		if not var_21_4 or not var_21_4._instance then
			return
		end

		for iter_21_12, iter_21_13 in pairs((FightManager.getCharacter(self._owner):getAreaOponent(var_21_4:getStandardPosition(), self:checkOffset(self._exearea.offset_left), (self:checkOffset(self._exearea.offset_right))))) do
			if iter_21_13.index ~= arg_21_1 then
				self:exeTriggerMethod(iter_21_13.index, arg_21_2)
			end
		end
	elseif self._exetarget == TEAMMATE_WITHOUT_SELF then
		for iter_21_14, iter_21_15 in pairs((FightManager.getCharacter(self._owner):getAllTeammate())) do
			if iter_21_15.index ~= self._owner then
				self:exeTriggerMethod(iter_21_15.index, arg_21_2)
			end
		end
	elseif self._exetarget == OPONENT_NEAREST then
		local var_21_5 = FightManager.getCharacter(self._owner):getNearestOponent()

		if var_21_5 then
			self:exeTriggerMethod(var_21_5.index, arg_21_2)
		end
	elseif self._exetarget == TEAMMATE_HPLOWEST then
		local var_21_6 = FightManager.getCharacter(self._owner):getTeammateByHP("hp_lowest", self._exetargetcount)

		if var_21_6 then
			for iter_21_16, iter_21_17 in pairs(var_21_6) do
				self:exeTriggerMethod(iter_21_17, arg_21_2)
			end
		end
	elseif self._exetarget == OPONENT_HPPER_LOWEST then
		local var_21_7 = FightManager.getCharacter(self._owner):getOponentByHpPercent("hp_percent_lowest", self._exetargetcount)

		if var_21_7 then
			for iter_21_18, iter_21_19 in pairs(var_21_7) do
				self:exeTriggerMethod(iter_21_19, arg_21_2)
			end
		end
	elseif self._exetarget == TEAMMATE_HPPER_LOWEST then
		local var_21_8 = FightManager.getCharacter(self._owner):getTeammateByHpPercent("hp_percent_lowest", self._exetargetcount)

		if var_21_8 then
			for iter_21_20, iter_21_21 in pairs(var_21_8) do
				self:exeTriggerMethod(iter_21_21, arg_21_2)
			end
		end
	elseif self._exetarget == OPONENT_HPLOWEST then
		local var_21_9 = FightManager.getCharacter(self._owner):getOponentByHp("hp_lowest", self._exetargetcount)

		if var_21_9 then
			for iter_21_22, iter_21_23 in pairs(var_21_9) do
				self:exeTriggerMethod(iter_21_23, arg_21_2)
			end
		end
	elseif self._exetarget == OPONENET_DAMAGELOWEST then
		local var_21_10 = FightManager.getCharacter(self._owner):getOponentByDamage("damage_highlest", self._exetargetcount)

		if var_21_10 then
			for iter_21_24, iter_21_25 in pairs(var_21_10) do
				self:exeTriggerMethod(iter_21_25, arg_21_2)
			end
		end
	elseif self._exetarget == TEAMMATE_DAMAGEHIGHEST then
		local var_21_11 = FightManager.getCharacter(self._owner):getTeammateByDamage("damage_highest", self._exetargetcount)

		if var_21_11 then
			for iter_21_26, iter_21_27 in pairs(var_21_11) do
				self:exeTriggerMethod(iter_21_27, arg_21_2)
			end
		end
	elseif self._exetarget == OPONENET_RANDOM_FROM_ALL then
		local var_21_12 = FightManager.getCharacter(self._owner):getOponentRandomFromAll(self._exetargetcount)

		if var_21_12 then
			for iter_21_28, iter_21_29 in pairs(var_21_12) do
				self:exeTriggerMethod(iter_21_29, arg_21_2)
			end
		end
	elseif self._exetarget == TEAMMATE_RANDOM_FROM_ALL then
		local var_21_13 = FightManager.getCharacter(self._owner):getTeammateRandomFromAll(self._exetargetcount)

		if var_21_13 then
			for iter_21_30, iter_21_31 in pairs(var_21_13) do
				self:exeTriggerMethod(iter_21_31, arg_21_2)
			end
		end
	elseif self._exetarget == TEAMMATE_HPHIGHEST then
		local var_21_14 = FightManager.getCharacter(self._owner):getTeammateByHP("hp_highest", self._exetargetcount)

		if var_21_14 then
			for iter_21_32, iter_21_33 in pairs(var_21_14) do
				self:exeTriggerMethod(iter_21_33, arg_21_2)
			end
		end
	elseif self._exetarget == TEAMMATE_HPPER_HIGHEST then
		local var_21_15 = FightManager.getCharacter(self._owner):getTeammateByHpPercent("hp_percent_highest", self._exetargetcount)

		if var_21_15 then
			for iter_21_34, iter_21_35 in pairs(var_21_15) do
				self:exeTriggerMethod(iter_21_35, arg_21_2)
			end
		end
	end
end

function FightStatus:exeTriggerMethod(arg_22_1, arg_22_2)
	if not self._triggermethod then
		return
	end

	local var_22_0 = {
		sourceindex = self._source,
		paramtbl = self._paramtbl
	}

	if self._statusaddtype == BUFF_ADD_BY_VALUE then
		var_22_0.refrencecount = self._refrencecount or 1
	end

	var_22_0.statustarget = self._statustarget

	if self._statusaddtype == BUFF_ADD_BY_VALUE then
		self._triggermethod(self._id, self._owner, arg_22_1, self._sourceparam, var_22_0, arg_22_2)
	else
		for iter_22_0 = 1, self._refrencecount do
			self._triggermethod(self._id, self._owner, arg_22_1, self._sourceparam, var_22_0, arg_22_2)
		end
	end

	self:playStatusTriggerEffect(arg_22_1)
end

function FightStatus:playStatusTriggerEffect(arg_23_1)
	if self._effect then
		local var_23_0 = self._effect

		if self._effect.target == 2 then
			local var_23_1 = FightManager.getCharacter(arg_23_1)

			var_23_1:playStatusEffect(false, var_23_0.filename, var_23_0.ani, var_23_0.offsetX, var_23_0.offsetY, var_23_0.offsetZ, var_23_0.dir == 1 and FightManager.getCharacter(self._owner):getRelativeDir(var_23_1) or var_23_0.dir == 3 and 1 or var_23_1:getDirection())
		else
			local var_23_3 = FightManager.getCharacter(self._owner)

			var_23_3:playStatusEffect(false, var_23_0.filename, var_23_0.ani, var_23_0.offsetX, var_23_0.offsetY, var_23_0.offsetZ, var_23_0.dir == 3 and 1 or var_23_3:getDirection())
		end
	end
end

function FightStatus:refresh(arg_24_1, arg_24_2)
	if self._globaltype == TRIGGER_STATUS then
		return
	end

	if arg_24_1 == self._registerattribute and self._useattrfac then
		return
	end

	local var_24_0 = FightManager.getCharacter(self._owner)
	local var_24_1 = self._registermethod(self._id, self._owner, self._source, self._paramtbl, self._sourceparam, self._index)

	if var_24_1 then
		var_24_0:addAttribute(self._registerattribute, (var_24_1 - self._registerbasicvalue) * self._refrencecount, arg_24_2)

		self._registerbasicvalue = var_24_1
		self._registervalue = var_24_1 * self._refrencecount
	end
end

function FightStatus:updateTriggerCD(arg_25_1)
	if self._globaltype == REGISTER_STATUS then
		return
	end

	local var_25_0 = FightManager.getCharacter(self._owner)

	if not var_25_0 then
		return
	end

	if self._insidercd - var_25_0:getTriggerCDAddition(self._index) > self._currentcd then
		self._currentcd = self._currentcd + arg_25_1
	end
end

function FightStatus:clearTriggerCD()
	if self._globaltype == REGISTER_STATUS then
		return
	end

	self._currentcd = self._insidercd
end

function FightStatus:update(arg_27_1)
	if self._ttl then
		self._curttl = self._curttl - arg_27_1 * (1 + global_fight_speedup)

		if self._curttl <= 0 then
			self:removeAllStatus()
		end
	end
end

function FightStatus:updateOnAttack()
	if self._needattackcount then
		self._curattackcount = self._curattackcount - 1

		if self._curattackcount <= 0 then
			self:removeAllStatus()
		end
	end
end

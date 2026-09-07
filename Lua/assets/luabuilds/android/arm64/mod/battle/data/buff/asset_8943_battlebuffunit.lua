ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleBuffEvent
local var_0_2 = ys.Battle.BattleConst.BuffEffectType
local var_0_3 = ys.Battle.BattleConfig
local BattleBuffUnit = class("BattleBuffUnit")

ys.Battle.BattleBuffUnit = BattleBuffUnit
BattleBuffUnit.__name = "BattleBuffUnit"
BattleBuffUnit.DEFAULT_ANI_FX_CONFIG = {
	effect = "jineng",
	offset = {
		0,
		-2,
		0
	}
}

function BattleBuffUnit:Ctor(arg_1_1, arg_1_2, arg_1_3)
	arg_1_2 = arg_1_2 or 1
	self._id = arg_1_1

	self:SetTemplate(arg_1_1, arg_1_2)

	self._time = self._tempData.time
	self._RemoveTime = 0
	self._effectList = {}
	self._triggerSearchTable = {}
	self._level = arg_1_2
	self._caster = arg_1_3
	self._forceStack = self._tempData.force_stack
	self._stackCap = self._tempData.stack_cap or self._tempData.stack

	for iter_1_0, iter_1_1 in ipairs(self._tempData.effect_list) do
		local var_1_0 = var_0_0.Battle[iter_1_1.type].New(iter_1_1)

		self._effectList[iter_1_0] = var_1_0

		for iter_1_2, iter_1_3 in ipairs(iter_1_1.trigger) do
			local var_1_1 = self._triggerSearchTable[iter_1_3]

			if self._triggerSearchTable[iter_1_3] == nil then
				var_1_1 = {}
				self._triggerSearchTable[iter_1_3] = var_1_1
			end

			var_1_1[#var_1_1 + 1] = var_1_0
		end
	end

	return
end

function BattleBuffUnit:GetTriggerPriority(arg_2_1)
	local var_2_0 = math.huge

	for iter_2_0, iter_2_1 in ipairs(self._tempData.effect_list) do
		var_2_0 = math.min(var_2_0, var_0_3.TRIGGER_PRIORITY[arg_2_1][iter_2_1.type] or var_0_3.TRIGGER_PRIORITY_LOWEST)
	end

	return var_2_0
end

function BattleBuffUnit:SetTemplate(arg_3_1, arg_3_2)
	self._tempData = var_0_0.Battle.BattleDataFunction.GetBuffTemplate(arg_3_1, arg_3_2)

	return
end

function BattleBuffUnit:Attach(arg_4_1)
	self._owner = arg_4_1
	self._stack = 1

	self:SetArgs(arg_4_1)
	self:onTrigger(var_0_2.ON_ATTACH, arg_4_1)
	self:SetRemoveTime()

	return
end

function BattleBuffUnit:Stack(arg_5_1)
	self._stack = math.min(self._stack + 1, self._tempData.stack)

	self:onTrigger(var_0_2.ON_STACK, arg_5_1)
	self:SetRemoveTime()

	return
end

function BattleBuffUnit:SetOrb(arg_6_1, arg_6_2)
	for iter_6_0, iter_6_1 in ipairs(self._effectList) do
		iter_6_1:SetOrb(self, arg_6_1, arg_6_2)
	end

	return
end

function BattleBuffUnit:SetOrbDuration(arg_7_1)
	self._time = arg_7_1 + self._time

	return
end

function BattleBuffUnit:SetOrbLevel(arg_8_1)
	self._level = arg_8_1

	return
end

function BattleBuffUnit:SetGroupLevel(arg_9_1)
	self._groupLevel = arg_9_1

	return
end

function BattleBuffUnit:GetGroupLevel()
	return self._groupLevel or 1
end

function BattleBuffUnit:SetInfection(arg_11_1)
	for iter_11_0, iter_11_1 in ipairs(self._effectList) do
		if iter_11_1.SetInfection then
			iter_11_1:SetInfection(arg_11_1)
		end
	end

	return
end

function BattleBuffUnit:SetCommander(arg_12_1)
	self._commander = arg_12_1

	for iter_12_0, iter_12_1 in ipairs(self._effectList) do
		iter_12_1:SetCommander(arg_12_1)
	end

	return
end

function BattleBuffUnit:GetEffectList()
	return self._effectList
end

function BattleBuffUnit:GetCommander()
	return self._commander
end

function BattleBuffUnit:UpdateStack(arg_15_1, arg_15_2)
	if self._stack == arg_15_2 then
		return
	end

	self._stack = math.min(arg_15_2, self._tempData.stack)

	self:onTrigger(var_0_2.ON_STACK, arg_15_1)
	self:SetRemoveTime()
	arg_15_1:DispatchEvent(var_0_0.Event.New(var_0_1.BUFF_STACK, {
		unit_id = arg_15_1:GetUniqueID(),
		buff_id = self._id,
		stack_count = self._stack
	}))

	return
end

function BattleBuffUnit:Remove(arg_16_1)
	self._owner:DispatchEvent(var_0_0.Event.New(var_0_1.BUFF_REMOVE, {
		unit_id = self._owner:GetUniqueID(),
		buff_id = self._id
	}))
	self:onTrigger(var_0_2.ON_REMOVE, self._owner)
	self:Clear()

	self._owner:GetBuffList()[self._id] = nil

	return
end

function BattleBuffUnit:Update(arg_17_1, arg_17_2)
	if self:IsTimeToRemove(arg_17_2) then
		self:Remove(arg_17_2)
	else
		self:onTrigger(var_0_2.ON_UPDATE, arg_17_1, {
			timeStamp = arg_17_2
		})
	end

	return
end

function BattleBuffUnit:SetArgs(arg_18_1)
	for iter_18_0, iter_18_1 in ipairs(self._effectList) do
		iter_18_1:SetCaster(self._caster)
		iter_18_1:SetArgs(arg_18_1, self)
	end

	return
end

function BattleBuffUnit:Trigger(arg_19_1, arg_19_2)
	local var_19_0 = {}

	for iter_19_0, iter_19_1 in pairs(self:GetBuffList() or {}) do
		if iter_19_1._triggerSearchTable[arg_19_1] ~= nil and #iter_19_1._triggerSearchTable[arg_19_1] > 0 then
			var_19_0[#var_19_0 + 1] = iter_19_1
		end
	end

	BattleBuffUnit.sortTriggerBuff(var_19_0, arg_19_1)

	for iter_19_2, iter_19_3 in ipairs(var_19_0) do
		iter_19_3:onTrigger(arg_19_1, self, arg_19_2)
	end

	return
end

function BattleBuffUnit:sortTriggerBuff(arg_20_1)
	if not var_0_3.TRIGGER_PRIORITY[arg_20_1] then
		return self
	end

	table.sort(self, function(arg_21_0, arg_21_1)
		return arg_21_0:GetTriggerPriority(arg_20_1) < arg_21_1:GetTriggerPriority(arg_20_1)
	end)

	return
end

function BattleBuffUnit:DisptachSkillFloat(arg_22_1, arg_22_2, arg_22_3)
	if arg_22_3.trigger == nil or table.contains(arg_22_3.trigger, arg_22_2) then
		arg_22_1:DispatchSkillFloat(getSkillName(arg_22_3.displayID or self._id), nil, (arg_22_3.painting and type(arg_22_3.painting) == "string" or nil) and arg_22_3)

		local var_22_1

		if arg_22_3.castCV ~= false then
			var_22_1 = arg_22_3.castCV or "skill"
		end

		local var_22_2 = type(var_22_1)

		if var_22_2 == "string" then
			arg_22_1:DispatchVoice(var_22_1)
		elseif var_22_2 == "table" then
			local var_22_3, var_22_4, var_22_5 = ShipWordHelper.GetWordAndCV(var_22_1.skinID, var_22_1.key)

			pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_22_4)
		end

		local var_22_6 = arg_22_3.aniEffect or BattleBuffUnit.DEFAULT_ANI_FX_CONFIG

		arg_22_1:DispatchEvent(var_0_0.Event.New(var_0_0.Battle.BattleUnitEvent.ADD_EFFECT, {
			effect = var_22_6.effect,
			offset = var_22_6.offset
		}))
	end

	return
end

function BattleBuffUnit:IsSubmarineSpecial()
	for iter_23_0, iter_23_1 in ipairs(self._triggerSearchTable[var_0_0.Battle.BattleConst.BuffEffectType.ON_SUBMARINE_FREE_SPECIAL] or {}) do
		if iter_23_1:HaveQuota() then
			return true
		end
	end

	return false
end

function BattleBuffUnit:onTrigger(arg_24_1, arg_24_2, arg_24_3)
	if self._triggerSearchTable[arg_24_1] == nil or #self._triggerSearchTable[arg_24_1] == 0 then
		return
	end

	for iter_24_0, iter_24_1 in ipairs(self._triggerSearchTable[arg_24_1]) do
		assert(type(iter_24_1[arg_24_1]) == "function", "buff效果的触发名字和触发函数不相符,buff id:>>" .. self._id .. "<<, trigger:>>" .. arg_24_1 .. "<<")

		if iter_24_1:HaveQuota() and iter_24_1:IsActive() then
			iter_24_1:NotActive()
			iter_24_1:Trigger(arg_24_1, arg_24_2, self, arg_24_3)

			local var_24_0 = iter_24_1:GetPopConfig()

			if var_24_0 then
				self:DisptachSkillFloat(arg_24_2, arg_24_1, var_24_0)
			end

			iter_24_1:SetActive()
		end

		if self._isCancel then
			break
		end
	end

	if self._isCancel then
		self._isCancel = nil

		self:Remove()
	end

	return
end

function BattleBuffUnit:SetRemoveTime()
	local var_25_0 = pg.TimeMgr.GetInstance():GetCombatTime()

	self._buffStartTimeStamp = var_25_0
	self._RemoveTime = var_25_0 + self._time
	self._cancelTime = nil

	return
end

function BattleBuffUnit:IsTimeToRemove(arg_26_1)
	if self._isCancel then
		return true
	elseif self._cancelTime and arg_26_1 >= self._cancelTime then
		return true
	elseif self._time == 0 then
		return false
	else
		return arg_26_1 >= self._RemoveTime
	end

	return
end

function BattleBuffUnit:GetBuffLifeTime()
	return self._time
end

function BattleBuffUnit:GetBuffStartTime()
	return self._buffStartTimeStamp
end

function BattleBuffUnit:Interrupt()
	for iter_29_0, iter_29_1 in ipairs(self._effectList) do
		iter_29_1:Interrupt()
	end

	return
end

function BattleBuffUnit:Clear()
	for iter_30_0, iter_30_1 in ipairs(self._effectList) do
		iter_30_1:Clear()
	end

	return
end

function BattleBuffUnit:GetID()
	return self._id
end

function BattleBuffUnit:GetCaster()
	return self._caster
end

function BattleBuffUnit:GetLv()
	return self._level or 1
end

function BattleBuffUnit:GetDuration()
	return self._time
end

function BattleBuffUnit:GetStack()
	return self._stack or 1
end

function BattleBuffUnit:IsForceStack()
	return self._forceStack
end

function BattleBuffUnit:SetToCancel(arg_37_1)
	if arg_37_1 then
		self._cancelTime = self._cancelTime or pg.TimeMgr.GetInstance():GetCombatTime() + arg_37_1
	else
		self._isCancel = true
	end

	return
end

function BattleBuffUnit:Dispose()
	self._triggerSearchTable = nil
	self._commander = nil

	return
end

return

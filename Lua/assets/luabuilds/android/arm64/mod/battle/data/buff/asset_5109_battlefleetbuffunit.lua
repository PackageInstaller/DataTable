ys = ys or {}

local var_0_0 = ys
local var_0_2 = ys.Battle.BattleConst.BuffEffectType
local BattleFleetBuffUnit = class("BattleFleetBuffUnit")

ys.Battle.BattleFleetBuffUnit = BattleFleetBuffUnit
BattleFleetBuffUnit.__name = "BattleFleetBuffUnit"

function BattleFleetBuffUnit:Ctor(arg_1_1, arg_1_2)
	arg_1_2 = arg_1_2 or 1
	self._id = arg_1_1
	self._tempData = var_0_0.Battle.BattleDataFunction.GetBuffTemplate(arg_1_1, arg_1_2)
	self._time = self._tempData.time
	self._RemoveTime = 0
	self._effectList = {}
	self._triggerSearchTable = {}
	self._level = arg_1_2

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

	self:SetActive()

	return
end

function BattleFleetBuffUnit:SetArgs(arg_2_1)
	self._host = arg_2_1

	for iter_2_0, iter_2_1 in ipairs(self._effectList) do
		iter_2_1:SetArgs(arg_2_1, self)
	end

	return
end

function BattleFleetBuffUnit:setRemoveTime()
	self._RemoveTime = pg.TimeMgr.GetInstance():GetCombatTime() + self._time
	self._cancelTime = nil

	return
end

function BattleFleetBuffUnit:Attach(arg_4_1)
	self._stack = 1

	self:SetArgs(arg_4_1)
	self:onTrigger(var_0_2.ON_ATTACH, arg_4_1)
	self:setRemoveTime()

	return
end

function BattleFleetBuffUnit:Stack(arg_5_1)
	self._stack = math.min(self._stack + 1, self._tempData.stack)

	self:onTrigger(var_0_2.ON_STACK, arg_5_1)
	self:setRemoveTime()

	return
end

function BattleFleetBuffUnit:UpdateStack(arg_6_1, arg_6_2)
	return
end

function BattleFleetBuffUnit:Remove()
	self:onTrigger(var_0_2.ON_REMOVE, self._host)

	self._host:GetFleetBuffList()[self._id] = nil

	self:Clear()

	return
end

function BattleFleetBuffUnit:Update(arg_8_1, arg_8_2)
	if self:IsTimeToRemove(arg_8_2) then
		self:Remove()
	else
		self:onTrigger(var_0_2.ON_UPDATE, arg_8_1, arg_8_2)
	end

	return
end

function BattleFleetBuffUnit:onTrigger(arg_9_1, arg_9_2, arg_9_3)
	if self._triggerSearchTable[arg_9_1] == nil or #self._triggerSearchTable[arg_9_1] == 0 then
		return
	end

	for iter_9_0, iter_9_1 in ipairs(self._triggerSearchTable[arg_9_1]) do
		assert(type(iter_9_1[arg_9_1]) == "function", "fleet buff效果的触发函数缺失,buff id:>>" .. self._id .. "<<, trigger:>>" .. arg_9_1 .. "<<")

		if iter_9_1:IsActive() then
			iter_9_1:NotActive()
			iter_9_1:Trigger(arg_9_1, arg_9_2, self, arg_9_3)
			iter_9_1:SetActive()
		end
	end

	return
end

function BattleFleetBuffUnit:IsTimeToRemove(arg_10_1)
	if self._time == 0 then
		return false
	else
		return arg_10_1 >= self._RemoveTime
	end

	return
end

function BattleFleetBuffUnit:IsActive()
	return self._isActive
end

function BattleFleetBuffUnit:SetActive()
	self._isActive = true

	return
end

function BattleFleetBuffUnit:NotActive()
	self._isActive = false

	return
end

function BattleFleetBuffUnit:GetCaster()
	return nil
end

function BattleFleetBuffUnit:GetID()
	return self._id
end

function BattleFleetBuffUnit:GetLv()
	return 1
end

function BattleFleetBuffUnit:Clear()
	self._host = nil

	for iter_17_0, iter_17_1 in ipairs(self._effectList) do
		iter_17_1:Clear()
	end

	return
end

return

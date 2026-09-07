ys = ys or {}

local var_0_0 = ys
local var_0_2 = ys.Battle.BattleConst.BuffEffectType
local var_0_3 = ys.Battle.BattleCardPuzzleFormulas
local BattleCardPuzzleFleetBuffUnit = class("BattleCardPuzzleFleetBuffUnit")

ys.Battle.BattleCardPuzzleFleetBuffUnit = BattleCardPuzzleFleetBuffUnit
BattleCardPuzzleFleetBuffUnit.__name = "BattleCardPuzzleFleetBuffUnit"

function BattleCardPuzzleFleetBuffUnit:Ctor(arg_1_1, arg_1_2)
	arg_1_2 = arg_1_2 or 1
	self._id = arg_1_1
	self._tempData = var_0_0.Battle.BattleDataFunction.GetBuffTemplate(arg_1_1, arg_1_2)
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

function BattleCardPuzzleFleetBuffUnit:IsResponTo(arg_2_1)
	if self._triggerSearchTable[arg_2_1] ~= nil and #self._triggerSearchTable[arg_2_1] > 0 then
		return true
	end

	return false
end

function BattleCardPuzzleFleetBuffUnit:SetArgs(arg_3_1)
	self._host = arg_3_1

	for iter_3_0, iter_3_1 in ipairs(self._effectList) do
		iter_3_1:SetArgs(arg_3_1, self)
	end

	return
end

function BattleCardPuzzleFleetBuffUnit:setRemoveTime()
	if self._tempData.time == nil then
		return
	end

	local var_4_0 = self._tempData.time

	self._duration = type(self._tempData.time) == "string" and math.max(0, var_0_3.parseFormula(var_4_0, self._host:GetAttrManager())) or var_4_0
	self._expireTimeStamp = pg.TimeMgr.GetInstance():GetCombatTime() + self._duration

	return
end

function BattleCardPuzzleFleetBuffUnit:Attach(arg_5_1)
	self._stack = 1

	self:SetArgs(arg_5_1)
	self:onTrigger(var_0_2.ON_ATTACH)
	self:setRemoveTime()

	return
end

function BattleCardPuzzleFleetBuffUnit:Stack()
	self._stack = self._tempData.stack == 0 and self._stack + 1 or math.min(self._stack + 1, self._tempData.stack)

	self:onTrigger(var_0_2.ON_STACK)
	self:setRemoveTime()

	return
end

function BattleCardPuzzleFleetBuffUnit:InitStack()
	return
end

function BattleCardPuzzleFleetBuffUnit:UpdateStack(arg_8_1)
	return
end

function BattleCardPuzzleFleetBuffUnit:Remove()
	self:onTrigger(var_0_2.ON_REMOVE)

	self._host:GetBuffManager():GetCardPuzzleBuffList()[self._id] = nil

	self:Clear()

	return
end

function BattleCardPuzzleFleetBuffUnit:Update(arg_10_1)
	if self:IsExpire(arg_10_1) then
		self:Remove()
	else
		self:onTrigger(var_0_2.ON_UPDATE, arg_10_1)
	end

	return
end

function BattleCardPuzzleFleetBuffUnit:onTrigger(arg_11_1, arg_11_2)
	if self._triggerSearchTable[arg_11_1] == nil or #self._triggerSearchTable[arg_11_1] == 0 then
		return
	end

	for iter_11_0, iter_11_1 in ipairs(self._triggerSearchTable[arg_11_1]) do
		assert(type(iter_11_1[arg_11_1]) == "function", "fleet buff效果的触发函数缺失,buff id:>>" .. self._id .. "<<, trigger:>>" .. arg_11_1 .. "<<")

		if iter_11_1:IsActive() then
			iter_11_1:NotActive()
			iter_11_1:Trigger(arg_11_1, arg_11_2)
			iter_11_1:SetActive()
		end
	end

	return
end

function BattleCardPuzzleFleetBuffUnit:IsExpire(arg_12_1)
	if self._expireTimeStamp == nil then
		return false
	else
		return arg_12_1 >= self._expireTimeStamp
	end

	return
end

function BattleCardPuzzleFleetBuffUnit:IsActive()
	return self._isActive
end

function BattleCardPuzzleFleetBuffUnit:SetActive()
	self._isActive = true

	return
end

function BattleCardPuzzleFleetBuffUnit:NotActive()
	self._isActive = false

	return
end

function BattleCardPuzzleFleetBuffUnit:GetCaster()
	return nil
end

function BattleCardPuzzleFleetBuffUnit:GetID()
	return self._id
end

function BattleCardPuzzleFleetBuffUnit:GetStack()
	return self._stack
end

function BattleCardPuzzleFleetBuffUnit:GetLv()
	return 1
end

function BattleCardPuzzleFleetBuffUnit:GetDurationRate()
	if self._expireTimeStamp == nil then
		return 1
	else
		return (self._expireTimeStamp - pg.TimeMgr.GetInstance():GetCombatTime()) / self._duration
	end

	return
end

function BattleCardPuzzleFleetBuffUnit:Clear()
	self._host = nil

	for iter_21_0, iter_21_1 in ipairs(self._effectList) do
		iter_21_1:Clear()
	end

	return
end

return

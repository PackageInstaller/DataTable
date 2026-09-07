ys = ys or {}

local var_0_0 = ys
local var_0_4 = ys.Battle.BattleAttr

ys.Battle.BattleNPCUnit = class("BattleNPCUnit", ys.Battle.BattleEnemyUnit)

local var_0_6 = ys.Battle.BattleNPCUnit

function ys.Battle.BattleNPCUnit:SetTemplate(arg_1_1, arg_1_2)
	var_0_6.super.SetTemplate(self, arg_1_1)

	self._tmpData = setmetatable({}, {
		__index = var_0_0.Battle.BattleDataFunction.GetMonsterTmpDataFromID(self._tmpID)
	})

	if arg_1_2.template then
		for iter_1_0, iter_1_1 in pairs(arg_1_2.template) do
			self._tmpData[iter_1_0] = iter_1_1
		end

		self._tmpData.id = arg_1_1
	end

	if arg_1_2.attr then
		var_0_4.SetAttr(self, arg_1_2.attr)
	else
		self:SetAttr()
	end

	self:SetCurrentHP(arg_1_2.currentHP or self:GetMaxHP())
	self:InitCldComponent()

	return
end

return

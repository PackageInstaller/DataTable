ys = ys or {}

local var_0_0 = ys
local var_0_4 = ys.Battle.BattleAttr

ys.Battle.BattleNPCUnit = class("BattleNPCUnit", ys.Battle.BattleEnemyUnit)

local var_0_6 = ys.Battle.BattleNPCUnit

function ys.Battle.BattleNPCUnit.SetTemplate(arg_1_0, arg_1_1, arg_1_2)
	var_0_6.super.SetTemplate(arg_1_0, arg_1_1)

	arg_1_0._tmpData = setmetatable({}, {
		__index = var_0_0.Battle.BattleDataFunction.GetMonsterTmpDataFromID(arg_1_0._tmpID)
	})

	if arg_1_2.template then
		for iter_1_0, iter_1_1 in pairs(arg_1_2.template) do
			arg_1_0._tmpData[iter_1_0] = iter_1_1
		end

		arg_1_0._tmpData.id = arg_1_1
	end

	if arg_1_2.attr then
		var_0_4.SetAttr(arg_1_0, arg_1_2.attr)
	else
		arg_1_0:SetAttr()
	end

	local var_1_0 = arg_1_2.currentHP or arg_1_0:GetMaxHP()

	arg_1_0:SetCurrentHP(var_1_0)
	arg_1_0:InitCldComponent()

	return
end

return

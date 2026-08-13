ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleDataFunction
local var_0_2 = var_0.Battle.BattleConst
local var_0_3 = var_0.Battle.BattleFormulas
local var_0_4 = var_0.Battle.BattleAttr
local var_0_5 = var_0.Battle.BattleUnitEvent
local var_0_6 = var_0.Battle

class = var_0_10007
var_0_6.BattleNPCUnit = var_0_10007("BattleNPCUnit", var_0.Battle.BattleEnemyUnit)

local var_0_7 = var_0.Battle.BattleNPCUnit

function var_0_7.SetTemplate(arg_1_0, arg_1_1, arg_1_2)
	var_0_7.super.SetTemplate(arg_1_0, arg_1_1)

	setmetatable = var_3
	arg_1_0._tmpData = var_3({}, {
		__index = var_0.Battle.BattleDataFunction.GetMonsterTmpDataFromID(arg_1_0._tmpID)
	})

	if arg_1_2.template then
		pairs = var_3

		for iter_1_0, iter_1_1 in var_3(arg_1_2.template) do
			arg_1_0._tmpData[iter_1_0] = iter_1_1
		end

		arg_1_0._tmpData.id = arg_1_1
	end

	if arg_1_2.attr then
		var_0_4.SetAttr(arg_1_0, arg_1_2.attr)
	else
		arg_1_0:SetAttr()
	end

	local var_1_0

	if not arg_1_2.currentHP then
		var_1_0 = arg_1_0:GetMaxHP()
	end

	arg_1_0:SetCurrentHP(var_1_0)
	arg_1_0:InitCldComponent()

	return
end

return

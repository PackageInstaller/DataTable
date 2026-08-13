ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleUnitEvent
local var_0_2 = var_0.Battle

class = var_0_10003
var_0_2.BattleNPCCharacter = var_0_10003("BattleNPCCharacter", var_0.Battle.BattleEnemyCharacter)
var_0.Battle.BattleNPCCharacter.__name = "BattleNPCCharacter"

local var_0_3 = var_0.Battle.BattleNPCCharacter

function var_0_3.Ctor(arg_1_0)
	var_0_3.super.Ctor(arg_1_0)

	arg_1_0._preCastBound = false

	return
end

function var_0_3.SetHPColor(arg_2_0, arg_2_1)
	arg_2_0._HPColor = arg_2_1

	return
end

function var_0_3.GetHPColor(arg_3_0)
	return arg_3_0._HPColor
end

function var_0_3.SetModleID(arg_4_0, arg_4_1)
	arg_4_0._prefab = arg_4_1

	return
end

function var_0_3.GetModleID(arg_5_0)
	if arg_5_0._prefab then
		return arg_5_0._prefab
	else
		local var_5_0 = arg_5_0._unitData

		return var_1.GetTemplate(var_5_0).prefab
	end

	return
end

function var_0_3.SetUnvisible(arg_6_0)
	arg_6_0._isUnvisible = true

	return
end

function var_0_3.MakeVisible(arg_7_0)
	if arg_7_0._isUnvisible then
		local var_7_0 = arg_7_0._go

		var_1.SetActive(var_7_0, false)

		local var_7_1 = arg_7_0._HPBar

		var_1.SetActive(var_7_1, false)

		local var_7_2 = arg_7_0._buffBar

		var_1.SetActive(var_7_2, false)
	end

	return
end

return

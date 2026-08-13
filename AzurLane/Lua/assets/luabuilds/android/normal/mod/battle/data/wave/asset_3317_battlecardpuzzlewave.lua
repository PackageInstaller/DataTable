ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConfig
local var_0_2 = var_0.Battle.BattleFleetCardPuzzleCardManageComponent
local var_0_3 = var_0.Battle

class = var_0_10004
var_0_3.BattleCardPuzzleWave = var_0_10004("BattleCardPuzzleWave", var_0.Battle.BattleWaveInfo)
var_0.Battle.BattleCardPuzzleWave.__name = "BattleCardPuzzleWave"

local var_0_4 = var_0.Battle.BattleCardPuzzleWave

function var_0_4.Ctor(arg_1_0)
	var_0_4.super.Ctor(arg_1_0)

	return
end

function var_0_4.SetWaveData(arg_2_0, arg_2_1)
	var_0_4.super.SetWaveData(arg_2_0, arg_2_1)

	arg_2_0._cardID = arg_2_0._param.card_id
	arg_2_0._moveTo = arg_2_0._param.move_to

	local var_2_0

	if not arg_2_0._param.move_op then
		var_2_0 = var_0_2.FUNC_NAME_ADD
	end

	arg_2_0._moveOP = var_2_0

	local var_2_1

	if not arg_2_0._param.shuffle then
		var_2_1 = 1
	end

	arg_2_0._op = var_2_1

	return
end

function var_0_4.DoWave(arg_3_0)
	var_0_4.super.DoWave(arg_3_0)

	local var_3_0 = var_0.Battle.BattleDataProxy.GetInstance()
	local var_3_1 = var_1.GetFleetByIFF(var_3_0, var_0_1.FRIENDLY_CODE)
	local var_3_2 = var_2.GetCardPuzzleComponent(var_3_1)
	local var_3_3 = var_2.GenerateCard(var_3_2, arg_3_0._cardID)

	var_2:GetCardPileByIndex(arg_3_0._moveTo)[arg_3_0._moveOP](var_4, var_3_3)

	if arg_3_0._op == 1 then
		var_4:Shuffle()
	end

	arg_3_0:doPass()

	return
end

return

ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleConfig
local var_0_2 = ys.Battle.BattleFleetCardPuzzleCardManageComponent

ys.Battle.BattleCardPuzzleWave = class("BattleCardPuzzleWave", ys.Battle.BattleWaveInfo)
ys.Battle.BattleCardPuzzleWave.__name = "BattleCardPuzzleWave"

local var_0_3 = ys.Battle.BattleCardPuzzleWave

function ys.Battle.BattleCardPuzzleWave.Ctor(arg_1_0)
	var_0_3.super.Ctor(arg_1_0)

	return
end

function ys.Battle.BattleCardPuzzleWave.SetWaveData(arg_2_0, arg_2_1)
	var_0_3.super.SetWaveData(arg_2_0, arg_2_1)

	arg_2_0._cardID = arg_2_0._param.card_id
	arg_2_0._moveTo = arg_2_0._param.move_to
	arg_2_0._moveOP = arg_2_0._param.move_op or var_0_2.FUNC_NAME_ADD
	arg_2_0._op = arg_2_0._param.shuffle or 1

	return
end

function ys.Battle.BattleCardPuzzleWave.DoWave(arg_3_0)
	local var_3_9000

	var_0_3.super.DoWave(arg_3_0)

	local var_3_0 = var_0_0.Battle.BattleDataProxy.GetInstance():GetFleetByIFF(var_0_1.FRIENDLY_CODE)
	local var_3_1 = var_3_0.GetCardPuzzleComponent(var_3_9000)
	local var_3_2 = var_3_1:GetCardPileByIndex(arg_3_0._moveTo)

	var_3_0[arg_3_0._moveOP](var_3_2, (var_3_1:GenerateCard(arg_3_0._cardID)))

	if arg_3_0._op == 1 then
		var_3_2:Shuffle()
	end

	arg_3_0:doPass()

	return
end

return

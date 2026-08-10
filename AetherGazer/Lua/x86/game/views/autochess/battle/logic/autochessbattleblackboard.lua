local var_0_0 = class("AutoChessBattleBlackboard")

function var_0_0.Ctor(arg_1_0)
	arg_1_0:Reset()
end

function var_0_0.Reset(arg_2_0)
	arg_2_0.gameType = AutoChessConst.GAME_TYPE.PVE
	arg_2_0.isOverBattle = false
	arg_2_0.isFightOver = false
	arg_2_0.deathWhispeAnimPlayedDic = {}
end

function var_0_0.Dispose(arg_3_0)
	arg_3_0:Reset()
end

function var_0_0.GetGameType(arg_4_0)
	return arg_4_0.gameType
end

function var_0_0.GetGameStatus(arg_5_0)
	return AutoChessData:GetGameStatus(arg_5_0.gameType)
end

function var_0_0.Init(arg_6_0, arg_6_1)
	arg_6_0.gameType = arg_6_1
end

function var_0_0.GetBattleData(arg_7_0)
	return AutoChessData:GetBattleData(arg_7_0.gameType)
end

function var_0_0.GetPrepareData(arg_8_0)
	return AutoChessData:GetPrepareData(arg_8_0.gameType)
end

function var_0_0.SetIsFightOver(arg_9_0)
	arg_9_0.isFightOver = true
end

function var_0_0.GetIsFightOver(arg_10_0)
	return arg_10_0.isFightOver
end

return var_0_0

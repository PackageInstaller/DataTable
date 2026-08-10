local var_0_0 = class("ChessGlobalAreaModel")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.areaMemory_ = {}
end

function var_0_0.SetUp(arg_2_0, arg_2_1)
	local var_2_0 = WarchessGlobalCfg[arg_2_1].params
	local var_2_1 = ChessTools.PhraseArea(var_2_0)

	arg_2_0.areaMemory_[arg_2_1] = var_2_1
end

function var_0_0.IsConditionCheck(arg_3_0, arg_3_1)
	local var_3_0 = WarChessData:GetCurrentIndex()

	if not arg_3_0.areaMemory_[arg_3_1] then
		return false
	end

	return arg_3_0.areaMemory_[arg_3_1][ChessTools.TwoDToOneD(var_3_0.x, var_3_0.z)]
end

function var_0_0.ExecutePhase(arg_4_0, arg_4_1)
	arg_4_0.areaMemory_[arg_4_1] = nil

	manager.ChessManager:StopMove()
end

function var_0_0.UpdateProgress(arg_5_0)
	return
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0.areaMemory_ = {}
end

return var_0_0

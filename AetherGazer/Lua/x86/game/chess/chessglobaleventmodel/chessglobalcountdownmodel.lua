local var_0_0 = class("ChessGlobalAreaModel")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.step = nil
	arg_1_0.curEventID_ = nil
	arg_1_0.handler_ = arg_1_1
end

function var_0_0.SetUp(arg_2_0, arg_2_1)
	if arg_2_0.curEventID_ and arg_2_0.curEventID_ ~= arg_2_1 then
		arg_2_0.handler_:ClearGlobalEventByID(arg_2_0.curEventID_)
	end

	arg_2_0.curEventID_ = arg_2_1

	local var_2_0 = WarChessData:GetGlobalEventProgress(arg_2_1) or WarchessGlobalCfg[arg_2_1].params[1]

	WarChessData:SetGlobalEventProgress(WarchessGlobalCfg[arg_2_0.curEventID_].type, arg_2_0.curEventID_, var_2_0)

	arg_2_0.step = var_2_0
end

function var_0_0.IsConditionCheck(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_2 == ChessConst.TIMING_WALK and arg_3_0.step and arg_3_0.step < 0 then
		return true
	end

	return false
end

function var_0_0.ExecutePhase(arg_4_0, arg_4_1)
	arg_4_0.step = nil
	arg_4_0.curEventID_ = nil
end

function var_0_0.UpdateProgress(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_2 == ChessConst.TIMING_WALK then
		arg_5_0.step = arg_5_0.step - 1

		local var_5_0 = WarchessGlobalCfg[arg_5_1].type

		WarChessData:SetGlobalEventProgress(var_5_0, arg_5_1, arg_5_0.step)
	end
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0.step = nil
	arg_6_0.curEventID_ = nil
end

return var_0_0

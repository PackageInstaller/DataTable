local var_0_0 = class("ChessForceBattleModel")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.battleProgress_ = false
	arg_1_0.battleResult_ = 0
	arg_1_0.battleTimes_ = 0
	arg_1_0.battleList_ = {}
end

function var_0_0.SetUp(arg_2_0, arg_2_1)
	arg_2_0.width_ = arg_2_1
end

function var_0_0.SetBattleIndex(arg_3_0)
	local var_3_0 = manager.ChessManager:GetExecutingChess()
	local var_3_1 = var_3_0.x
	local var_3_2 = var_3_0.z * arg_3_0.width_ + var_3_1 + 1

	WarChessData:SetBattleIndex(var_3_2)
end

function var_0_0.BattleResult(arg_4_0, arg_4_1)
	if not arg_4_0.battleProgress_ then
		return
	end

	arg_4_0.battleResult_ = arg_4_1 and 1 or 2
end

function var_0_0.IsMutiBattle(arg_5_0)
	return arg_5_0.battleProgress_ and true or false
end

function var_0_0.EnterMutiBattle(arg_6_0, arg_6_1, arg_6_2)
	if not arg_6_0.battleProgress_ then
		arg_6_0.battleTimes_ = arg_6_1
		arg_6_0.battleList_ = arg_6_2
		arg_6_0.battleProgress_ = 0

		local var_6_0 = manager.ChessManager:GetExecutingChess()
	end

	local var_6_1 = arg_6_0.battleList_[arg_6_0.battleProgress_ + 1]

	if not BattleChessStageCfg[var_6_1] then
		-- block empty
	end

	arg_6_0:BattleStart(var_6_1)
end

function var_0_0.BattleStart(arg_7_0, arg_7_1)
	arg_7_0.battleProgress_ = arg_7_0.battleProgress_ or 0
	arg_7_0.battleResult_ = 0
	arg_7_0.battleID_ = arg_7_1

	arg_7_0:SetBattleIndex()

	local var_7_0 = manager.ui.mainCamera:GetComponent("CameraExtension")

	if var_7_0 then
		arg_7_0.originShadowRotationImmediately = var_7_0.shadowRotationImmediately
		var_7_0.shadowRotationImmediately = true
	end

	ChessLuaBridge.SetCameraControlEnable(false)
end

function var_0_0.ExitMutiBattle(arg_8_0)
	arg_8_0.battleProgress_ = false
	arg_8_0.battleResult_ = 0

	manager.ChessManager:EventsEnd()
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0.battleProgress_ = false
	arg_9_0.battleResult_ = 0
	arg_9_0.battleTimes_ = 0
	arg_9_0.battleList_ = {}
end

return var_0_0

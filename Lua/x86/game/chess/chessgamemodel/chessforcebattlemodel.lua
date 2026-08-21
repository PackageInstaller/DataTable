local var_0_0 = class("ChessForceBattleModel")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.battleStart_ = false
	arg_1_0.battleResult_ = 0
	arg_1_0.battleID_ = nil
end

function var_0_0.SetUp(arg_2_0, arg_2_1)
	arg_2_0.width_ = arg_2_1
end

function var_0_0.BattleStart(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0.battleStart_ = true
	arg_3_0.battleResult_ = 0
	arg_3_0.battleID_ = arg_3_3

	arg_3_0:SetBattleIndex(arg_3_1, arg_3_2)

	local var_3_0 = manager.ui.mainCamera:GetComponent("CameraExtension")

	if var_3_0 then
		arg_3_0.originShadowRotationImmediately = var_3_0.shadowRotationImmediately
		var_3_0.shadowRotationImmediately = true
	end

	ChessLuaBridge.SetCameraControlEnable(false)
end

function var_0_0.SetBattleIndex(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_2 * arg_4_0.width_ + arg_4_1 + 1

	WarChessData:SetBattleIndex(var_4_0)
end

function var_0_0.BattleResult(arg_5_0, arg_5_1)
	if not arg_5_0.battleStart_ then
		return
	end

	arg_5_0.battleResult_ = arg_5_1 and 1 or 2
end

function var_0_0.IsForcingBattle(arg_6_0)
	return arg_6_0.battleStart_
end

function var_0_0.ForceEnterBossBattle(arg_7_0, arg_7_1)
	if arg_7_1 then
		arg_7_0.battleID_ = arg_7_1
	else
		arg_7_1 = arg_7_0.battleID_
	end

	if not BattleChessStageCfg[arg_7_1] then
		-- block empty
	end

	local var_7_0 = WarChessData:GetBossPos()
	local var_7_1 = var_7_0[1]
	local var_7_2 = var_7_0[2]
	local var_7_3 = WarChessData:GetGridLua(var_7_1, var_7_2)

	arg_7_0:BattleStart(var_7_1, var_7_2, arg_7_1)
	gameContext:Go("/sectionSelectHero", {
		section = arg_7_1,
		sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS,
		activityID = WarChessData:GetCurrentActivity(),
		customBarList = {
			BACK_BAR
		}
	})
end

function var_0_0.BattleFinish(arg_8_0)
	if arg_8_0.battleStart_ then
		ChessLuaBridge.SetCameraControlEnable(true)

		local var_8_0 = manager.ui.mainCamera:GetComponent("CameraExtension")

		if var_8_0 then
			var_8_0.shadowRotationImmediately = arg_8_0.originShadowRotationImmediately
		end

		if arg_8_0.battleResult_ == 0 then
			-- block empty
		elseif arg_8_0.battleResult_ == 1 then
			WarChessAction.CostShipHp(-30)

			if manager.ChessManager.current:ShipImmediatelyDie() then
				return
			end

			manager.ChessManager:DoNextEvent()

			arg_8_0.battleStart_ = false
			arg_8_0.battleResult_ = 0
		elseif arg_8_0.battleResult_ == 2 then
			WarChessAction.CostShipHp(-50)

			if manager.ChessManager.current:ShipImmediatelyDie() then
				return
			end

			manager.ChessManager:DoNextEvent()

			arg_8_0.battleStart_ = false
			arg_8_0.battleResult_ = 0
		end
	end
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0.battleStart_ = false
	arg_9_0.battleResult_ = 0
end

return var_0_0

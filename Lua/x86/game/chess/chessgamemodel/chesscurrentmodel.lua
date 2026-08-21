local var_0_0 = class("ChessCurrentModel")
local var_0_1 = {
	[0] = {
		1,
		1
	},
	{
		0,
		1
	},
	{
		-1,
		0
	},
	{
		-1,
		-1
	},
	{
		0,
		-1
	},
	{
		1,
		0
	}
}

function var_0_0.Ctor(arg_1_0)
	arg_1_0.currentEvent_ = false
	arg_1_0.isShow_ = false
	arg_1_0.isDetector_ = false
	arg_1_0.aboutToSlide_ = false
	arg_1_0.bugFix_ = false
	arg_1_0.aboutToDie_ = false
end

function var_0_0.SetUp(arg_2_0, arg_2_1)
	arg_2_0.blockerManager_ = arg_2_1
end

function var_0_0.ExtendSetup(arg_3_0)
	local var_3_0 = WarChessData:GetDetectorPos()

	if #var_3_0 > 0 then
		arg_3_0.isDetector_ = true

		ChessLuaBridge.LayDownChildBoatWithoutAnimation(var_3_0[1], var_3_0[2])
	end
end

function var_0_0.SlideByDirection(arg_4_0, arg_4_1)
	arg_4_0.blockerManager_:ShowBlocker()
	ChessLuaBridge.SlideByDirection(arg_4_1, 4)
	ChessLuaBridge.LookAtPlayer()

	arg_4_0.currentEvent_ = true
end

function var_0_0.SlideByDirectionInCurrentState(arg_5_0, arg_5_1)
	ChessLuaBridge.SlideByDirection(arg_5_1, 4)
end

function var_0_0.CurrentPatch(arg_6_0)
	arg_6_0.bugFix_ = true
end

function var_0_0.IsCurrentPatch(arg_7_0)
	local var_7_0
	local var_7_1 = arg_7_0.bugFix_

	arg_7_0.bugFix_ = false

	return var_7_1
end

function var_0_0.CurrentEnd(arg_8_0)
	arg_8_0.currentEvent_ = false

	arg_8_0.blockerManager_:HideBlocker()
end

function var_0_0.SetDetector(arg_9_0, arg_9_1)
	arg_9_0.isDetector_ = arg_9_1
end

function var_0_0.IsDetector(arg_10_0)
	return arg_10_0.isDetector_
end

function var_0_0.IsCurrentState(arg_11_0)
	return arg_11_0.currentEvent_
end

function var_0_0.LayDownOrUpShip(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0

	if arg_12_1 then
		arg_12_0.blockerManager_:ShowBlocker()

		local var_12_1 = ChessLuaBridge.GetPlayerDirection()

		WarChessData:SetCharacterDirection(var_12_1)

		var_12_0 = ChessLuaBridge.LayDownChildBoat(1, function()
			arg_12_2()
			arg_12_0.blockerManager_:HideBlocker()
		end)

		if not var_12_0 then
			arg_12_0.blockerManager_:HideBlocker()
			ShowTips("ACTIVITY_WARCHESS_RELIEVE")
		else
			arg_12_0:SetDetector(true)
			WarChessAction.SwitchShipControl(2)

			local var_12_2 = WarChessData:GetCurrentIndex()
			local var_12_3 = var_0_1[math.fmod(var_12_1 + 3, 6)]
			local var_12_4 = var_12_2.x + var_12_3[1]
			local var_12_5 = var_12_2.z + var_12_3[2]

			WarChessData:SetDetectorPos(var_12_4, var_12_5)
		end
	else
		arg_12_0.blockerManager_:ShowBlocker()

		var_12_0 = ChessLuaBridge.PutUpChildBoat(function()
			arg_12_2()
			arg_12_0.blockerManager_:HideBlocker()
		end)

		if not var_12_0 then
			arg_12_0.blockerManager_:HideBlocker()
			ShowTips("ACTIVITY_WARCHESS_RECOVER")
		else
			arg_12_0:SetDetector(false)
			WarChessAction.SwitchShipControl(1)
			WarChessData:SetDetectorPos()
		end
	end

	return var_12_0
end

function var_0_0.AboutToSlide(arg_15_0, arg_15_1)
	arg_15_0.aboutToSlide_ = arg_15_1
end

function var_0_0.IsAboutToSlide(arg_16_0)
	local var_16_0 = arg_16_0.aboutToSlide_ or false

	arg_16_0.aboutToSlide_ = false

	return var_16_0
end

function var_0_0.ShipImmediatelyDie(arg_17_0)
	local var_17_0 = WarChessData:GetShipHp()

	if var_17_0 and var_17_0 <= 0 then
		arg_17_0.blockerManager_:ShowBlocker()
		ChessLuaBridge.PlayRoleAnimation("dead", function()
			manager.notify:CallUpdateFunc(SHIP_DIE)
			TimeTools.StartAfterSeconds(2, function()
				arg_17_0.blockerManager_:HideBlocker()
				OnExitChessScene(true)
			end, {})
		end)

		return true
	end
end

function var_0_0.ChessSuccess(arg_20_0)
	arg_20_0.blockerManager_:ShowBlocker()
	manager.notify:CallUpdateFunc(CHESS_SUCCESS)
	TimeTools.StartAfterSeconds(2, function()
		arg_20_0.blockerManager_:HideBlocker()
		OnExitChessScene(true)
	end, {})
end

function var_0_0.AboutToDie(arg_22_0, arg_22_1)
	if arg_22_1 == 1 then
		arg_22_0.aboutToDie_ = true
	elseif arg_22_1 == 2 and arg_22_0.aboutToDie_ then
		arg_22_0:ShipImmediatelyDie()
	else
		arg_22_0.aboutToDie_ = false
	end
end

function var_0_0.Dispose(arg_23_0)
	arg_23_0.currentEvent_ = false
	arg_23_0.isShow_ = false
	arg_23_0.isDetector_ = false
	arg_23_0.aboutToSlide_ = false
	arg_23_0.bugFix_ = false
	arg_23_0.aboutToDie_ = false
end

return var_0_0

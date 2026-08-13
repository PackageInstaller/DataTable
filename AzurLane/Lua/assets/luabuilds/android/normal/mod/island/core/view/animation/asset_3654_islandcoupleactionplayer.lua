class = var_0_10000

local var_0_0 = "IslandCoupleActionPlayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..IslandBaseUnit"))
local var_0_2 = 0
local var_0_3 = 1
local var_0_4 = 2

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.playing = false
	arg_1_0.phase = var_0_2

	arg_1_0:Init()

	return
end

function var_0_1.IsPlaying(arg_2_0)
	return arg_2_0.playing
end

function var_0_1.Stop(arg_3_0)
	if not arg_3_0:IsPlaying() then
		return
	end

	if arg_3_0.phase == var_0_2 then
		return
	end

	if arg_3_0.phase == var_0_3 and arg_3_0.playData then
		local var_3_0 = arg_3_0.playData[2]
		local var_3_1 = arg_3_0
		local var_3_2 = arg_3_0.NotifiyCore

		ISLAND_EVT = var_1_10004

		var_3_2(var_3_1, var_1_10004.REMOVE_PATH_FINDER, {
			unitId = var_3_0.id,
			unitType = var_3_0.unitType
		})
		arg_3_0:ResetAnimation()
	elseif arg_3_0.phase == var_0_4 and arg_3_0.playData then
		arg_3_0:ResetAnimation()
	end

	arg_3_0:WillExit(arg_3_0.playData[2], arg_3_0.playData[1])
	arg_3_0:Exit(arg_3_0.playData[2], arg_3_0.playData[1])

	return
end

function var_0_1.ResetAnimation(arg_4_0)
	local var_4_0 = arg_4_0.playData[1]
	local var_4_1 = arg_4_0.playData[2]
	local var_4_2 = arg_4_0:GetView()

	if var_3.GetUnitModuleWithType(var_4_2, var_4_0.unitType, var_4_0.id) then
		var_3:CheckMovement()
	end

	local var_4_3 = arg_4_0:GetView()

	if var_4.GetUnitModuleWithType(var_4_3, var_4_1.unitType, var_4_1.id) then
		var_4:CheckMovement()
	end

	return
end

function var_0_1.Play(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if not arg_5_2 or not arg_5_1 then
		return
	end

	arg_5_0.playData = {
		arg_5_2,
		arg_5_1
	}

	arg_5_0:EnableOrDisablePlayerOp(arg_5_2, arg_5_1, false)
	arg_5_0:EnableOrDisableUnitSyn(arg_5_2, arg_5_1, false)

	arg_5_0.playing = true

	arg_5_0:SendStartEvent(arg_5_2, arg_5_1)

	local var_5_0 = arg_5_0

	arg_5_0.ShowOrHideCancelableBtn(var_5_0, arg_5_2, arg_5_1, true)

	local var_5_1 = false

	Vector3 = var_5_0

	local var_5_2 = var_5_0(0, 0, 0)

	seriesAsync = var_6

	var_6({
		function(arg_6_0)
			local var_6_0 = arg_5_0

			var_5_1, var_5_2 = var_1.NavigateToPoint(var_6_0, arg_5_2, arg_5_1, arg_5_3, arg_6_0)

			return
		end,
		function(arg_7_0)
			onNextTick = var_2_10001

			var_2_10001(arg_7_0)

			return
		end,
		function(arg_8_0)
			if not arg_5_0.playing then
				return
			end

			local var_8_0 = arg_5_0

			var_1.EnableOrDisablePlayerSyn(var_8_0, arg_5_1, false)

			if not var_5_1 then
				arg_8_0()

				return
			end

			local var_8_1 = arg_5_0

			var_1.Face2Face(var_8_1, var_5_2, arg_5_2, arg_5_1, arg_8_0)

			return
		end,
		function(arg_9_0)
			if not arg_5_0.playing then
				return
			end

			if not var_5_1 then
				arg_9_0()

				return
			end

			local var_9_0 = arg_5_0

			var_1.PlayCoupleActions(var_9_0, arg_5_2, arg_5_1, arg_5_3, arg_9_0)

			return
		end,
		function(arg_10_0)
			if not arg_5_0.playing then
				return
			end

			IslandTaskHelper = var_1

			var_1.OnActionEnd(arg_5_3.id)

			local var_10_0 = arg_5_0

			var_1.WillExit(var_10_0, arg_5_1, arg_5_2)
			arg_10_0()

			return
		end
	}, function()
		local var_11_0 = arg_5_0

		var_0.Exit(var_11_0, arg_5_1, arg_5_2, arg_5_3)

		return
	end)

	return
end

function var_0_1.WillExit(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_1 then
		arg_12_0:EnableOrDisablePlayerSyn(arg_12_1, true)
	end

	if arg_12_2 and arg_12_1 then
		arg_12_0:EnableOrDisableUnitSyn(arg_12_2, arg_12_1, true)
		arg_12_0:EnableOrDisablePlayerOp(arg_12_2, arg_12_1, true)
	end

	return
end

function var_0_1.Exit(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_2 and arg_13_1 then
		arg_13_0:ShowOrHideCancelableBtn(arg_13_2, arg_13_1, false)
		arg_13_0:SendEndEvent(arg_13_2, arg_13_1)
	end

	arg_13_0.playing = false
	arg_13_0.phase = var_0_2
	arg_13_0.playData = nil

	return
end

function var_0_1.ShowOrHideCancelableBtn(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = arg_14_0:GetView()
	local var_14_2

	if not var_4.IsPlayer(var_14_0, arg_14_1.id) then
		local var_14_1 = arg_14_0:GetView()

		var_14_2 = var_4.IsPlayer(var_14_1, arg_14_2.id)
	end

	if not var_14_2 then
		return
	end

	if arg_14_3 then
		local var_14_3 = arg_14_0
		local var_14_4 = arg_14_0.NotifiyCore

		ISLAND_EVT = var_1_10007

		var_14_4(var_14_3, var_1_10007.START_DO_COUPLE_ACTION)
	else
		local var_14_5 = arg_14_0
		local var_14_6 = arg_14_0.NotifiyCore

		ISLAND_EVT = var_1_10007

		var_14_6(var_14_5, var_1_10007.END_DO_COUPLE_ACTION)
	end

	return
end

function var_0_1.SendStartEvent(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0:GetView()
	local var_15_2

	if not var_3.IsPlayer(var_15_0, arg_15_1.id) then
		local var_15_1 = arg_15_0:GetView()

		var_15_2 = var_3.IsPlayer(var_15_1, arg_15_2.id)
	end

	if var_15_2 then
		local var_15_3 = arg_15_0
		local var_15_4 = arg_15_0.NotifiyCore

		ISLAND_EVT = var_1_10006

		var_15_4(var_15_3, var_1_10006.START_COUPLE_ACTION)
	end

	return
end

function var_0_1.SendEndEvent(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0:GetView()
	local var_16_2

	if not var_3.IsPlayer(var_16_0, arg_16_1.id) then
		local var_16_1 = arg_16_0:GetView()

		var_16_2 = var_3.IsPlayer(var_16_1, arg_16_2.id)
	end

	if var_16_2 then
		local var_16_3 = arg_16_0
		local var_16_4 = arg_16_0.NotifiyCore

		ISLAND_EVT = var_1_10006

		var_16_4(var_16_3, var_1_10006.END_COUPLE_ACTION)
	end

	return
end

function var_0_1.NavigateToPoint(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	arg_17_0.phase = var_0_3

	local var_17_0

	if arg_17_3.respond_point then
		var_17_0 = arg_17_3.respond_point ~= ""
	end

	if var_17_0 then
		BuildVector3 = var_1_10006

		if not var_1_10006(arg_17_3.respond_point) then
			Vector3 = var_1_10006
			var_1_10006 = var_1_10006(0, 0, 2)
		end

		local var_17_1 = var_1_10006.magnitude
		local var_17_2 = arg_17_1._go.transform.rotation * var_1_10006
		local var_17_3 = arg_17_1._go.transform.position + var_17_2

		IslandCalcUtil = var_1_10011

		if not var_1_10011.GetCanReachOptPoint(arg_17_2._go.transform.position, var_17_1, arg_17_1.agent, arg_17_1._tf.position, var_17_3, 36) then
			arg_17_4()

			local var_17_4 = arg_17_0:GetView()

			if not var_12.IsPlayer(var_17_4, arg_17_1.id) then
				local var_17_5 = arg_17_0:GetView()

				if var_12.IsPlayer(var_17_5, arg_17_2.id) then
					arg_17_0:OnNavigateToPointFailed()
				end

				do return false end

				local var_17_6 = {
					speed = 5,
					hide = false,
					waitUntilDone = true,
					unitId = arg_17_2.id,
					unitType = arg_17_2.unitType,
					position = {
						var_11.x,
						var_11.y,
						var_11.z
					}
				}
				local var_17_7 = arg_17_0
				local var_17_8 = arg_17_0.NotifiyCore

				ISLAND_EVT = var_15

				var_17_8(var_17_7, var_15.GEN_PATH_FINDER, {
					navData = var_17_6,
					callback = arg_17_4
				})

				IslandCalcUtil = var_17_8

				local var_17_9 = var_17_8.RotationOffset(arg_17_1._go.transform.position, var_17_3, var_11)

				return true, var_17_9
			end
		end
	end
end

function var_0_1.OnNavigateToPointFailed(arg_18_0)
	pg = var_1_10001

	local var_18_0 = var_1_10001.TipsMgr.GetInstance()
	local var_18_1 = var_1.ShowTips

	i18n = var_1_10003

	var_18_1(var_18_0, var_1_10003("island_no_position_to_reponse_action"))

	return
end

function var_0_1.Face2Face(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	local var_19_0 = arg_19_3._go.transform
	local var_19_1 = arg_19_2._go.transform.position - var_19_0.position

	Quaternion = var_8

	local var_19_2 = var_8.LookRotation(var_19_1)

	Quaternion = var_9
	var_19_0.rotation = var_9.Euler(0, var_19_2.eulerAngles.y, 0)
	var_6.rotation = arg_19_1 * var_6.rotation
	isa = var_9

	local var_19_3 = arg_19_3

	IslandPlayerUnit = var_11

	if var_9(var_19_3, var_11) then
		arg_19_3.targetRotation = var_19_0.rotation
	end

	isa = var_9

	local var_19_4 = arg_19_2

	IslandPlayerUnit = var_11

	if var_9(var_19_4, var_11) then
		arg_19_2.targetRotation = var_6.rotation
	end

	arg_19_4()

	return
end

function var_0_1.PlayCoupleActions(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4)
	arg_20_0.phase = var_0_4
	parallelAsync = var_5

	var_5({
		function(arg_21_0)
			local var_21_0 = arg_20_2

			var_1.PlayAnimation(var_21_0, arg_20_3.responder_feedback, 0.25, arg_21_0)

			return
		end,
		function(arg_22_0)
			local var_22_0 = arg_20_1

			var_1.PlayAnimation(var_22_0, arg_20_3.resource .. "_end", 0.25, arg_22_0)

			return
		end
	}, arg_20_4)

	return
end

function var_0_1.EnableOrDisablePlayerSyn(arg_23_0, arg_23_1, arg_23_2)
	isa = var_1_10003

	local var_23_0 = arg_23_1

	IslandPlayerUnit = var_1_10005

	if var_1_10003(var_23_0, var_1_10005) then
		arg_23_1:ActiveOrDisactive(arg_23_2)
	end

	return
end

function var_0_1.EnableOrDisablePlayerOp(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	local var_24_0 = arg_24_0:GetView()
	local var_24_2

	if not var_4.IsPlayer(var_24_0, arg_24_1.id) then
		local var_24_1 = arg_24_0:GetView()

		var_24_2 = var_4.IsPlayer(var_24_1, arg_24_2.id)
	end

	if var_24_2 then
		if arg_24_3 then
			local var_24_3 = arg_24_0:GetView()

			var_5.EnablePlayerOp(var_24_3)
		else
			local var_24_4 = arg_24_0:GetView()

			var_5.DisablePlayerOp(var_24_4)

			IslandCameraMgr = var_5

			local var_24_5 = var_5.instance.gameObject
			local var_24_6 = var_5.GetComponent

			typeof = var_1_10007
			InputController = var_1_10008

			local var_24_7 = var_24_6(var_24_5, var_1_10007(var_1_10008))

			var_5.EnablePlayerLook(var_24_7)
		end
	end

	return
end

function var_0_1.EnableOrDisableUnitSyn(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	local function var_25_0(arg_26_0, arg_26_1)
		if arg_26_1 then
			arg_26_0:WakeUp()
		else
			arg_26_0:Sleep()
		end

		return
	end

	isa = var_1_10005

	local var_25_1 = arg_25_1

	IslandVisitorUnit = var_1_10007

	if var_1_10005(var_25_1, var_1_10007) then
		var_25_0(arg_25_1, arg_25_3)
	end

	isa = var_5

	local var_25_2 = arg_25_2

	IslandVisitorUnit = var_1_10007

	if var_5(var_25_2, var_1_10007) then
		var_25_0(arg_25_2, arg_25_3)
	end

	return
end

return var_0_1

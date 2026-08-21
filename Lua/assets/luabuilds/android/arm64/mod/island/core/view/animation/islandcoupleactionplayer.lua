local var_0_0 = class("IslandCoupleActionPlayer", import("..IslandBaseUnit"))
local var_0_1 = 0
local var_0_2 = 1
local var_0_3 = 2

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.playing = false
	arg_1_0.phase = var_0_1

	arg_1_0:Init()

	return
end

function var_0_0.IsPlaying(arg_2_0)
	return arg_2_0.playing
end

function var_0_0.Stop(arg_3_0)
	if not arg_3_0:IsPlaying() then
		return
	end

	if arg_3_0.phase == var_0_1 then
		return
	end

	if arg_3_0.phase == var_0_2 and arg_3_0.playData then
		arg_3_0:NotifiyCore(ISLAND_EVT.REMOVE_PATH_FINDER, {
			unitId = arg_3_0.playData[2].id,
			unitType = arg_3_0.playData[2].unitType
		})
		arg_3_0:ResetAnimation()
	elseif arg_3_0.phase == var_0_3 and arg_3_0.playData then
		arg_3_0:ResetAnimation()
	end

	arg_3_0:WillExit(arg_3_0.playData[2], arg_3_0.playData[1])
	arg_3_0:Exit(arg_3_0.playData[2], arg_3_0.playData[1])

	return
end

function var_0_0.ResetAnimation(arg_4_0)
	local var_4_0 = arg_4_0:GetView():GetUnitModuleWithType(arg_4_0.playData[1].unitType, arg_4_0.playData[1].id)

	if var_4_0 then
		var_4_0:CheckMovement()
	end

	local var_4_1 = arg_4_0:GetView():GetUnitModuleWithType(arg_4_0.playData[2].unitType, arg_4_0.playData[2].id)

	if var_4_1 then
		var_4_1:CheckMovement()
	end

	return
end

function var_0_0.Play(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
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
	arg_5_0:ShowOrHideCancelableBtn(arg_5_2, arg_5_1, true)

	local var_5_0 = false
	local var_5_1 = Vector3(0, 0, 0)

	seriesAsync({
		function(arg_6_0)
			var_5_0, var_5_1 = arg_5_0:NavigateToPoint(arg_5_2, arg_5_1, arg_5_3, arg_6_0)

			return
		end,
		function(arg_7_0)
			onNextTick(arg_7_0)

			return
		end,
		function(arg_8_0)
			if not arg_5_0.playing then
				return
			end

			arg_5_0:EnableOrDisablePlayerSyn(arg_5_1, false)

			if not var_5_0 then
				arg_8_0()

				return
			end

			arg_5_0:Face2Face(var_5_1, arg_5_2, arg_5_1, arg_8_0)

			return
		end,
		function(arg_9_0)
			if not arg_5_0.playing then
				return
			end

			if not var_5_0 then
				arg_9_0()

				return
			end

			arg_5_0:PlayCoupleActions(arg_5_2, arg_5_1, arg_5_3, arg_9_0)

			return
		end,
		function(arg_10_0)
			if not arg_5_0.playing then
				return
			end

			IslandTaskHelper.OnActionEnd(arg_5_3.id)
			arg_5_0:WillExit(arg_5_1, arg_5_2)
			arg_10_0()

			return
		end
	}, function()
		arg_5_0:Exit(arg_5_1, arg_5_2, arg_5_3)

		return
	end)

	return
end

function var_0_0.WillExit(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_1 then
		arg_12_0:EnableOrDisablePlayerSyn(arg_12_1, true)
	end

	if arg_12_2 and arg_12_1 then
		arg_12_0:EnableOrDisableUnitSyn(arg_12_2, arg_12_1, true)
		arg_12_0:EnableOrDisablePlayerOp(arg_12_2, arg_12_1, true)
	end

	return
end

function var_0_0.Exit(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_2 and arg_13_1 then
		arg_13_0:ShowOrHideCancelableBtn(arg_13_2, arg_13_1, false)
		arg_13_0:SendEndEvent(arg_13_2, arg_13_1)
	end

	arg_13_0.playing = false
	arg_13_0.phase = var_0_1
	arg_13_0.playData = nil

	return
end

function var_0_0.ShowOrHideCancelableBtn(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = arg_14_0:GetView():IsPlayer(arg_14_1.id)

	var_14_0 = var_14_0 or arg_14_0:GetView():IsPlayer(arg_14_2.id)

	if not var_14_0 then
		return
	end

	if arg_14_3 then
		arg_14_0:NotifiyCore(ISLAND_EVT.START_DO_COUPLE_ACTION)
	else
		arg_14_0:NotifiyCore(ISLAND_EVT.END_DO_COUPLE_ACTION)
	end

	return
end

function var_0_0.SendStartEvent(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0:GetView():IsPlayer(arg_15_1.id)

	var_15_0 = var_15_0 or arg_15_0:GetView():IsPlayer(arg_15_2.id)

	if var_15_0 then
		arg_15_0:NotifiyCore(ISLAND_EVT.START_COUPLE_ACTION)
	end

	return
end

function var_0_0.SendEndEvent(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0:GetView():IsPlayer(arg_16_1.id)

	var_16_0 = var_16_0 or arg_16_0:GetView():IsPlayer(arg_16_2.id)

	if var_16_0 then
		arg_16_0:NotifiyCore(ISLAND_EVT.END_COUPLE_ACTION)
	end

	return
end

function var_0_0.NavigateToPoint(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	arg_17_0.phase = var_0_2

	local var_17_0 = arg_17_3.respond_point and arg_17_3.respond_point ~= ""
	local var_17_1 = var_17_0 and BuildVector3(arg_17_3.respond_point) or Vector3(0, 0, 2)
	local var_17_2 = IslandCalcUtil.GetCanReachOptPoint(arg_17_2._go.transform.position, var_17_1.magnitude, arg_17_1.agent, arg_17_1._tf.position, arg_17_1._go.transform.position + arg_17_1._go.transform.rotation * var_17_1, 36)

	if not var_17_2 then
		arg_17_4()

		if not arg_17_0:GetView():IsPlayer(arg_17_1.id) then
			if arg_17_0:GetView():IsPlayer(arg_17_2.id) then
				arg_17_0:OnNavigateToPointFailed()
			end

			do return false end

			;({}).navData = {
				speed = 5,
				hide = false,
				waitUntilDone = true,
				unitId = arg_17_2.id,
				unitType = arg_17_2.unitType,
				position = {
					var_17_2.x,
					var_17_2.y,
					var_17_2.z
				}
			}
			;({}).callback = arg_17_4

			arg_17_0:NotifiyCore(ISLAND_EVT.GEN_PATH_FINDER, {})

			return true, (IslandCalcUtil.RotationOffset(arg_17_1._go.transform.position, arg_17_1._go.transform.position + arg_17_1._go.transform.rotation * var_17_1, var_17_2))
		end
	end
end

function var_0_0.OnNavigateToPointFailed(arg_18_0)
	pg.TipsMgr.GetInstance():ShowTips(i18n("island_no_position_to_reponse_action"))

	return
end

function var_0_0.Face2Face(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	arg_19_3._go.transform.rotation = Quaternion.Euler(0, Quaternion.LookRotation(arg_19_2._go.transform.position - arg_19_3._go.transform.position).eulerAngles.y, 0)
	arg_19_2._go.transform.rotation = arg_19_1 * arg_19_2._go.transform.rotation

	if isa(arg_19_3, IslandPlayerUnit) then
		arg_19_3.targetRotation = arg_19_3._go.transform.rotation
	end

	if isa(arg_19_2, IslandPlayerUnit) then
		arg_19_2.targetRotation = arg_19_2._go.transform.rotation
	end

	arg_19_4()

	return
end

function var_0_0.PlayCoupleActions(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4)
	arg_20_0.phase = var_0_3

	parallelAsync({
		function(arg_21_0)
			arg_20_2:PlayAnimation(arg_20_3.responder_feedback, 0.25, arg_21_0)

			return
		end,
		function(arg_22_0)
			arg_20_1:PlayAnimation(arg_20_3.resource .. "_end", 0.25, arg_22_0)

			return
		end
	}, arg_20_4)

	return
end

function var_0_0.EnableOrDisablePlayerSyn(arg_23_0, arg_23_1, arg_23_2)
	if isa(arg_23_1, IslandPlayerUnit) then
		arg_23_1:ActiveOrDisactive(arg_23_2)
	end

	return
end

function var_0_0.EnableOrDisablePlayerOp(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	local var_24_0 = arg_24_0:GetView():IsPlayer(arg_24_1.id)

	var_24_0 = var_24_0 or arg_24_0:GetView():IsPlayer(arg_24_2.id)

	if var_24_0 then
		if arg_24_3 then
			arg_24_0:GetView():EnablePlayerOp()
		else
			arg_24_0:GetView():DisablePlayerOp()
			IslandCameraMgr.instance.gameObject:GetComponent(typeof(InputController)):EnablePlayerLook()
		end
	end

	return
end

function var_0_0.EnableOrDisableUnitSyn(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	if isa(arg_25_1, IslandVisitorUnit) then
		(function(arg_26_0, arg_26_1)
			if arg_26_1 then
				arg_26_0:WakeUp()
			else
				arg_26_0:Sleep()
			end

			return
		end)(arg_25_1, arg_25_3)
	end

	if isa(arg_25_2, IslandVisitorUnit) then
		(function(arg_26_0, arg_26_1)
			if arg_26_1 then
				arg_26_0:WakeUp()
			else
				arg_26_0:Sleep()
			end

			return
		end)(arg_25_2, arg_25_3)
	end

	return
end

return var_0_0

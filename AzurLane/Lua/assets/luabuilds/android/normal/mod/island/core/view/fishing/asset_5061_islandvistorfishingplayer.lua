class = var_0_10000

local var_0_0 = "IslandVistorFishingPlayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandFishingPlayer"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:InitArgs(arg_1_3, arg_1_4, arg_1_5)

	return
end

function var_0_1.IsSameFishPoint(arg_2_0, arg_2_1)
	return arg_2_0.fishPointId == arg_2_1
end

function var_0_1.Play(arg_3_0)
	local var_3_0 = arg_3_0.fishPointId

	seriesAsync = var_1_10002

	var_1_10002({
		function(arg_4_0)
			local var_4_0 = arg_3_0

			var_1.TurnToFishPoistion(var_4_0, var_3_0, arg_4_0)

			return
		end,
		function(arg_5_0)
			local var_5_0 = arg_3_0

			var_1.LoadFishRodModel(var_5_0, arg_5_0)

			return
		end,
		function(arg_6_0)
			local var_6_0 = arg_3_0

			var_1.PreloadEffects(var_6_0, arg_6_0)

			return
		end,
		function(arg_7_0)
			local var_7_0 = arg_3_0
			local var_7_1 = var_1.PlayEffect

			IslandFishingEffectMgr = var_2_10003

			local var_7_2 = var_2_10003.EFFECT_ENTER

			IslandFishingEffectMgr = var_2_10004

			var_7_1(var_7_0, var_7_2, var_2_10004.EFFECT_ENTER_TIME)

			local var_7_3 = arg_3_0

			var_1.PlayCastAnimation(var_7_3, arg_7_0)

			return
		end,
		function(arg_8_0)
			local var_8_0 = arg_3_0
			local var_8_1 = var_1.PlayEffect

			IslandFishingEffectMgr = var_2_10003

			var_8_1(var_8_0, var_2_10003.EFFECT_WAITING)

			onDelayTick = var_8_1

			var_8_1(arg_8_0, 2)

			return
		end,
		function(arg_9_0)
			local var_9_0 = arg_3_0
			local var_9_1 = var_1.PlayEffect

			IslandFishingEffectMgr = var_2_10003

			var_9_1(var_9_0, var_2_10003.EFFECT_HOOKED)

			local var_9_2 = arg_3_0

			var_1.PlayHookedAnimation(var_9_2)

			onDelayTick = var_1

			var_1(arg_9_0, 1)

			return
		end,
		function(arg_10_0)
			local var_10_0 = arg_3_0
			local var_10_1 = var_1.PlayEffect

			IslandFishingEffectMgr = var_2_10003

			var_10_1(var_10_0, var_2_10003.EFFECT_SHAKE)
			arg_10_0()

			return
		end
	})

	return
end

function var_0_1.OnSuccess(arg_11_0, arg_11_1)
	seriesAsync = var_1_10002

	var_1_10002({
		function(arg_12_0)
			onDelayTick = var_2_10001

			var_2_10001(arg_12_0, 1)

			return
		end,
		function(arg_13_0)
			local var_13_0 = arg_11_0

			var_1.LoadFishModel(var_13_0, arg_13_0)

			return
		end,
		function(arg_14_0)
			local var_14_0 = arg_11_0
			local var_14_1 = var_1.PlayEffect

			IslandFishingEffectMgr = var_2_10003

			local var_14_2 = var_2_10003.EFFECT_LEAVE

			IslandFishingEffectMgr = var_2_10004

			var_14_1(var_14_0, var_14_2, var_2_10004.EFFECT_LEAVE_TIME)

			local var_14_3 = arg_11_0

			var_1.PlayHookEndAnimation(var_14_3, arg_14_0)

			return
		end,
		function(arg_15_0)
			local var_15_0 = arg_11_0

			var_1.WaitForExit(var_15_0, arg_15_0)

			return
		end
	}, arg_11_1)

	return
end

function var_0_1.WaitForExit(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0

	arg_16_0.RemoveWaitForExit(var_16_0)

	pg = var_2

	local var_16_1 = var_2.island_set.island_fishing_success_exit_time.key_value_int

	Timer = var_16_0

	local var_16_2 = var_16_0.New
	local var_16_3 = arg_16_1

	math = var_1_10005
	arg_16_0.exitTimer = var_16_2(var_16_3, var_1_10005.max(0.01, var_16_1), 1)

	local var_16_4 = arg_16_0.exitTimer

	var_3.Start(var_16_4)

	return
end

function var_0_1.RemoveWaitForExit(arg_17_0)
	if arg_17_0.exitTimer then
		local var_17_0 = arg_17_0.exitTimer

		var_1.Stop(var_17_0)

		arg_17_0.exitTimer = nil
	end

	return
end

function var_0_1.OnFailed(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0
	local var_18_1 = arg_18_0.PlayEffect

	IslandFishingEffectMgr = var_1_10004

	var_18_1(var_18_0, var_1_10004.EFFECT_NORMAL)
	arg_18_0:PlayFailAnimation(arg_18_1)

	return
end

function var_0_1.OnCancel(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0
	local var_19_1 = arg_19_0.PlayEffect

	IslandFishingEffectMgr = var_1_10004

	var_19_1(var_19_0, var_1_10004.EFFECT_NORMAL)
	arg_19_0:PlayCancelAnimation(arg_19_1)

	return
end

function var_0_1.OnDestroy(arg_20_0)
	local var_20_0 = arg_20_0
	local var_20_1 = arg_20_0.PlayEffect

	IslandFishingEffectMgr = var_1_10003

	var_20_1(var_20_0, var_1_10003.EFFECT_NORMAL)
	arg_20_0:RemoveWaitForExit()
	arg_20_0:UnLoadFishModel()
	arg_20_0:UnLoadFishRodModel()
	arg_20_0:PlayMovementAnimation()
	var_0_1.super.OnDestroy(arg_20_0)

	return
end

return var_0_1

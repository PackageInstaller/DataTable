local var_0_0 = class("IslandVistorFishingPlayer", import(".IslandFishingPlayer"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:InitArgs(arg_1_3, arg_1_4, arg_1_5)

	return
end

function var_0_0.IsSameFishPoint(arg_2_0, arg_2_1)
	return arg_2_0.fishPointId == arg_2_1
end

function var_0_0.Play(arg_3_0)
	local var_3_0 = arg_3_0.fishPointId

	seriesAsync({
		function(arg_4_0)
			arg_3_0:TurnToFishPoistion(var_3_0, arg_4_0)

			return
		end,
		function(arg_5_0)
			arg_3_0:LoadFishRodModel(arg_5_0)

			return
		end,
		function(arg_6_0)
			arg_3_0:PreloadEffects(arg_6_0)

			return
		end,
		function(arg_7_0)
			arg_3_0:PlayEffect(IslandFishingEffectMgr.EFFECT_ENTER, IslandFishingEffectMgr.EFFECT_ENTER_TIME)
			arg_3_0:PlayCastAnimation(arg_7_0)

			return
		end,
		function(arg_8_0)
			arg_3_0:PlayEffect(IslandFishingEffectMgr.EFFECT_WAITING)
			onDelayTick(arg_8_0, 2)

			return
		end,
		function(arg_9_0)
			arg_3_0:PlayEffect(IslandFishingEffectMgr.EFFECT_HOOKED)
			arg_3_0:PlayHookedAnimation()
			onDelayTick(arg_9_0, 1)

			return
		end,
		function(arg_10_0)
			arg_3_0:PlayEffect(IslandFishingEffectMgr.EFFECT_SHAKE)
			arg_10_0()

			return
		end
	})

	return
end

function var_0_0.OnSuccess(arg_11_0, arg_11_1)
	seriesAsync({
		function(arg_12_0)
			onDelayTick(arg_12_0, 1)

			return
		end,
		function(arg_13_0)
			arg_11_0:LoadFishModel(arg_13_0)

			return
		end,
		function(arg_14_0)
			arg_11_0:PlayEffect(IslandFishingEffectMgr.EFFECT_LEAVE, IslandFishingEffectMgr.EFFECT_LEAVE_TIME)
			arg_11_0:PlayHookEndAnimation(arg_14_0)

			return
		end,
		function(arg_15_0)
			arg_11_0:WaitForExit(arg_15_0)

			return
		end
	}, arg_11_1)

	return
end

function var_0_0.WaitForExit(arg_16_0, arg_16_1)
	arg_16_0:RemoveWaitForExit()

	arg_16_0.exitTimer = Timer.New(arg_16_1, math.max(0.01, pg.island_set.island_fishing_success_exit_time.key_value_int), 1)

	arg_16_0.exitTimer:Start()

	return
end

function var_0_0.RemoveWaitForExit(arg_17_0)
	if arg_17_0.exitTimer then
		arg_17_0.exitTimer:Stop()

		arg_17_0.exitTimer = nil
	end

	return
end

function var_0_0.OnFailed(arg_18_0, arg_18_1)
	arg_18_0:PlayEffect(IslandFishingEffectMgr.EFFECT_NORMAL)
	arg_18_0:PlayFailAnimation(arg_18_1)

	return
end

function var_0_0.OnCancel(arg_19_0, arg_19_1)
	arg_19_0:PlayEffect(IslandFishingEffectMgr.EFFECT_NORMAL)
	arg_19_0:PlayCancelAnimation(arg_19_1)

	return
end

function var_0_0.OnDestroy(arg_20_0)
	arg_20_0:PlayEffect(IslandFishingEffectMgr.EFFECT_NORMAL)
	arg_20_0:RemoveWaitForExit()
	arg_20_0:UnLoadFishModel()
	arg_20_0:UnLoadFishRodModel()
	arg_20_0:PlayMovementAnimation()
	var_0_0.super.OnDestroy(arg_20_0)

	return
end

return var_0_0

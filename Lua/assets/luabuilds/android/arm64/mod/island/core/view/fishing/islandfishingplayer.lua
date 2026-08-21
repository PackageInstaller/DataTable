local var_0_0 = class("IslandFishingPlayer", import("Mod.Island.Core.View.IslandBaseUnit"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.player = arg_1_2
	arg_1_0.effectMgr = IslandFishingEffectMgr.New(arg_1_0:GetView())
	arg_1_0.animator = IslandFishingAnimator.New(arg_1_2)

	return
end

function var_0_0.InitArgs(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.fishPointId = arg_2_1
	arg_2_0.fishRodId = arg_2_2
	arg_2_0.fishId = arg_2_3

	return
end

function var_0_0.PreloadEffects(arg_3_0, arg_3_1)
	assert(arg_3_0.fishPointId, "call InitArgs first")
	arg_3_0.effectMgr:Preload(arg_3_0.fishPointId, arg_3_1)

	return
end

function var_0_0.PlayEffect(arg_4_0, arg_4_1, arg_4_2)
	if not arg_4_2 or arg_4_2 <= 0 then
		arg_4_0.effectMgr:Play(arg_4_1)
	else
		arg_4_0.effectMgr:DelayPlay(arg_4_2, arg_4_1)
	end

	return
end

function var_0_0.PlayCastAnimation(arg_5_0, arg_5_1)
	arg_5_0.animator:Trigger(IslandFishingAnimator.STATE_THROW, 0.25, arg_5_1)

	return
end

function var_0_0.PlayHookedAnimation(arg_6_0)
	arg_6_0.animator:Trigger(IslandFishingAnimator.STATE_HOOKED, 0.25)

	return
end

function var_0_0.PlayMovementAnimation(arg_7_0)
	arg_7_0.animator:Trigger(IslandFishingAnimator.STATE_MOVEMENT, 0)

	return
end

function var_0_0.PlayHookEndAnimation(arg_8_0, arg_8_1)
	arg_8_0.animator:Trigger(IslandFishingAnimator.STATE_HOOKED_5, 0.25, arg_8_1)

	return
end

function var_0_0.PlayHookMiddleAnimation(arg_9_0)
	arg_9_0.animator:Trigger(IslandFishingAnimator.STATE_HOOKED_3, 0)

	return
end

function var_0_0.PlayCancelAnimation(arg_10_0, arg_10_1)
	arg_10_0.animator:Trigger(IslandFishingAnimator.STATE_CANCEL, 0.25, arg_10_1)

	return
end

function var_0_0.PlayFailAnimation(arg_11_0, arg_11_1)
	arg_11_0.animator:Trigger(IslandFishingAnimator.STATE_FAIL, 0.25, arg_11_1)

	return
end

function var_0_0.TurnToFishPoistion(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0:GetView():GetUnitModuleWithType(IslandConst.UNIT_LIST_FISH_POINT, arg_12_1)

	assert(var_12_0, "unit should be exist>>>." .. arg_12_1)

	;(var_12_0._go.transform.position - arg_12_0.player._tf.position).y = 0
	arg_12_0.player._tf.rotation = Quaternion.LookRotation(var_12_0._go.transform.position - arg_12_0.player._tf.position)

	arg_12_2()

	return
end

function var_0_0.LoadFishRodModel(arg_13_0, arg_13_1)
	assert(arg_13_0.fishRodId, "call InitArgs first")

	if not arg_13_0.fishRodId then
		arg_13_1()

		return
	end

	arg_13_0:GetPoolMgr():GetFishRod(pg.island_animation_attachments[arg_13_0.fishRodId].model, pg.island_animation_attachments[arg_13_0.fishRodId].animator, function(arg_14_0)
		arg_13_0.fishRodAnimator = arg_14_0:GetComponent(typeof(Animator))

		local var_14_0 = arg_14_0:GetComponent(typeof(FishingLineVerlet))

		if var_14_0 then
			arg_13_0.effectMgr:SetFishHook(var_14_0.hook)
		end

		setParent(arg_14_0, arg_13_0.player._tf)
		arg_13_0.animator:SetFishRod(arg_13_0.fishRodAnimator)
		arg_13_1()

		return
	end)

	return
end

function var_0_0.UnLoadFishRodModel(arg_15_0)
	if arg_15_0.fishRodId and arg_15_0.fishRodAnimator and arg_15_0.fishRodAnimator.gameObject then
		arg_15_0:GetPoolMgr():ReturnFishRod(pg.island_animation_attachments[arg_15_0.fishRodId].model, pg.island_animation_attachments[arg_15_0.fishRodId].animator, arg_15_0.fishRodAnimator.gameObject)

		arg_15_0.fishRodId = nil

		arg_15_0.animator:ClearFishRod()

		arg_15_0.fishRodAnimator = nil
	end

	return
end

function var_0_0.LoadFishModel(arg_16_0, arg_16_1)
	assert(arg_16_0.fishId, "call InitArgs first")

	if not arg_16_0.fishId or not arg_16_0.fishRodAnimator then
		arg_16_1()

		return
	end

	arg_16_0:GetPoolMgr():GetFish(pg.island_unit_character[pg.island_fish[arg_16_0.fishId].unit_id].model, pg.island_unit_character[pg.island_fish[arg_16_0.fishId].unit_id].animator, function(arg_17_0)
		arg_16_0.fishAnimator = arg_17_0:GetComponent(typeof(Animator))

		setParent(arg_17_0, arg_16_0.fishRodAnimator.gameObject.transform:Find("all/fish_bone/fish1_mount"))
		arg_16_1()

		return
	end)

	return
end

function var_0_0.UnLoadFishModel(arg_18_0)
	if arg_18_0.fishAnimator then
		arg_18_0:GetPoolMgr():ReturnFish(pg.island_unit_character[pg.island_fish[arg_18_0.fishId].unit_id].model, pg.island_unit_character[pg.island_fish[arg_18_0.fishId].unit_id].animator, arg_18_0.fishAnimator.gameObject)

		arg_18_0.fishAnimator = nil
	end

	return
end

function var_0_0.OnDestroy(arg_19_0)
	if arg_19_0.effectMgr then
		arg_19_0.effectMgr:Dispose()

		arg_19_0.effectMgr = nil
	end

	if arg_19_0.animator then
		arg_19_0.animator:Dispose()

		arg_19_0.animator = nil
	end

	return
end

return var_0_0

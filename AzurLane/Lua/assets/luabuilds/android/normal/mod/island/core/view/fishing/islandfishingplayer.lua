class = var_0_10000

local var_0_0 = "IslandFishingPlayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("Mod.Island.Core.View.IslandBaseUnit"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.player = arg_1_2
	IslandFishingEffectMgr = var_3
	arg_1_0.effectMgr = var_3.New(arg_1_0:GetView())
	IslandFishingAnimator = var_3
	arg_1_0.animator = var_3.New(arg_1_2)

	return
end

function var_0_1.InitArgs(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.fishPointId = arg_2_1
	arg_2_0.fishRodId = arg_2_2
	arg_2_0.fishId = arg_2_3

	return
end

function var_0_1.PreloadEffects(arg_3_0, arg_3_1)
	assert = var_1_10002

	var_1_10002(arg_3_0.fishPointId, "call InitArgs first")

	local var_3_0 = arg_3_0.effectMgr

	var_2.Preload(var_3_0, arg_3_0.fishPointId, arg_3_1)

	return
end

function var_0_1.PlayEffect(arg_4_0, arg_4_1, arg_4_2)
	if not arg_4_2 or arg_4_2 <= 0 then
		local var_4_0 = arg_4_0.effectMgr

		var_3.Play(var_4_0, arg_4_1)
	else
		local var_4_1 = arg_4_0.effectMgr

		var_3.DelayPlay(var_4_1, arg_4_2, arg_4_1)
	end

	return
end

function var_0_1.PlayCastAnimation(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0.animator
	local var_5_1 = var_2.Trigger

	IslandFishingAnimator = var_1_10004

	var_5_1(var_5_0, var_1_10004.STATE_THROW, 0.25, arg_5_1)

	return
end

function var_0_1.PlayHookedAnimation(arg_6_0)
	local var_6_0 = arg_6_0.animator
	local var_6_1 = var_1.Trigger

	IslandFishingAnimator = var_1_10003

	var_6_1(var_6_0, var_1_10003.STATE_HOOKED, 0.25)

	return
end

function var_0_1.PlayMovementAnimation(arg_7_0)
	local var_7_0 = arg_7_0.animator
	local var_7_1 = var_1.Trigger

	IslandFishingAnimator = var_1_10003

	var_7_1(var_7_0, var_1_10003.STATE_MOVEMENT, 0)

	return
end

function var_0_1.PlayHookEndAnimation(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.animator
	local var_8_1 = var_2.Trigger

	IslandFishingAnimator = var_1_10004

	var_8_1(var_8_0, var_1_10004.STATE_HOOKED_5, 0.25, arg_8_1)

	return
end

function var_0_1.PlayHookMiddleAnimation(arg_9_0)
	local var_9_0 = arg_9_0.animator
	local var_9_1 = var_1.Trigger

	IslandFishingAnimator = var_1_10003

	var_9_1(var_9_0, var_1_10003.STATE_HOOKED_3, 0)

	return
end

function var_0_1.PlayCancelAnimation(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.animator
	local var_10_1 = var_2.Trigger

	IslandFishingAnimator = var_1_10004

	var_10_1(var_10_0, var_1_10004.STATE_CANCEL, 0.25, arg_10_1)

	return
end

function var_0_1.PlayFailAnimation(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0.animator
	local var_11_1 = var_2.Trigger

	IslandFishingAnimator = var_1_10004

	var_11_1(var_11_0, var_1_10004.STATE_FAIL, 0.25, arg_11_1)

	return
end

function var_0_1.TurnToFishPoistion(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0:GetView()
	local var_12_1 = var_3.GetUnitModuleWithType

	IslandConst = var_1_10005

	local var_12_2 = var_12_1(var_12_0, var_1_10005.UNIT_LIST_FISH_POINT, arg_12_1)

	assert = var_12_0

	var_12_0(var_12_2, "unit should be exist>>>." .. arg_12_1)

	local var_12_3 = arg_12_0.player._tf
	local var_12_4 = var_12_2._go.transform.position - var_12_3.position

	var_12_4.y = 0
	Quaternion = var_7
	var_12_3.rotation = var_7.LookRotation(var_12_4)

	arg_12_2()

	return
end

function var_0_1.LoadFishRodModel(arg_13_0, arg_13_1)
	assert = var_1_10002

	var_1_10002(arg_13_0.fishRodId, "call InitArgs first")

	if not arg_13_0.fishRodId then
		arg_13_1()

		return
	end

	pg = var_2

	local var_13_0 = var_2.island_animation_attachments[arg_13_0.fishRodId]
	local var_13_1 = arg_13_0:GetPoolMgr()

	var_3.GetFishRod(var_13_1, var_13_0.model, var_13_0.animator, function(arg_14_0)
		local var_14_0 = arg_13_0
		local var_14_1 = arg_14_0
		local var_14_2 = arg_14_0.GetComponent

		typeof = var_2_10004
		Animator = var_2_10005
		var_14_0.fishRodAnimator = var_14_2(var_14_1, var_2_10004(var_2_10005))

		local var_14_3 = arg_14_0
		local var_14_4 = arg_14_0.GetComponent

		typeof = var_14_1
		FishingLineVerlet = var_4

		if var_14_4(var_14_3, var_14_1(var_4)) then
			local var_14_5 = arg_13_0.effectMgr

			var_14_3.SetFishHook(var_14_5, var_1.hook)
		end

		setParent = var_14_3

		var_14_3(arg_14_0, arg_13_0.player._tf)

		local var_14_6 = arg_13_0.animator

		var_2.SetFishRod(var_14_6, arg_13_0.fishRodAnimator)
		arg_13_1()

		return
	end)

	return
end

function var_0_1.UnLoadFishRodModel(arg_15_0)
	if arg_15_0.fishRodId and arg_15_0.fishRodAnimator and arg_15_0.fishRodAnimator.gameObject then
		pg = var_1

		local var_15_0 = var_1.island_animation_attachments[arg_15_0.fishRodId]
		local var_15_1 = arg_15_0:GetPoolMgr()

		var_2.ReturnFishRod(var_15_1, var_15_0.model, var_15_0.animator, arg_15_0.fishRodAnimator.gameObject)

		arg_15_0.fishRodId = nil

		local var_15_2 = arg_15_0.animator

		var_2.ClearFishRod(var_15_2)

		arg_15_0.fishRodAnimator = nil
	end

	return
end

function var_0_1.LoadFishModel(arg_16_0, arg_16_1)
	assert = var_1_10002

	var_1_10002(arg_16_0.fishId, "call InitArgs first")

	if not arg_16_0.fishId or not arg_16_0.fishRodAnimator then
		arg_16_1()

		return
	end

	pg = var_2

	local var_16_0 = var_2.island_fish[arg_16_0.fishId]

	pg = var_3

	local var_16_1 = var_3.island_unit_character[var_16_0.unit_id]
	local var_16_2 = arg_16_0:GetPoolMgr()

	var_4.GetFish(var_16_2, var_16_1.model, var_16_1.animator, function(arg_17_0)
		local var_17_0 = arg_16_0
		local var_17_1 = arg_17_0
		local var_17_2 = arg_17_0.GetComponent

		typeof = var_2_10004
		Animator = var_2_10005
		var_17_0.fishAnimator = var_17_2(var_17_1, var_2_10004(var_2_10005))
		setParent = var_17_0

		local var_17_3 = arg_17_0
		local var_17_4 = arg_16_0.fishRodAnimator.gameObject.transform

		var_17_0(var_17_3, var_3.Find(var_17_4, "all/fish_bone/fish1_mount"))
		arg_16_1()

		return
	end)

	return
end

function var_0_1.UnLoadFishModel(arg_18_0)
	if arg_18_0.fishAnimator then
		pg = var_1

		local var_18_0 = var_1.island_fish[arg_18_0.fishId]

		pg = var_2

		local var_18_1 = var_2.island_unit_character[var_18_0.unit_id]
		local var_18_2 = arg_18_0:GetPoolMgr()

		var_3.ReturnFish(var_18_2, var_18_1.model, var_18_1.animator, arg_18_0.fishAnimator.gameObject)

		arg_18_0.fishAnimator = nil
	end

	return
end

function var_0_1.OnDestroy(arg_19_0)
	if arg_19_0.effectMgr then
		local var_19_0 = arg_19_0.effectMgr

		var_1.Dispose(var_19_0)

		arg_19_0.effectMgr = nil
	end

	if arg_19_0.animator then
		local var_19_1 = arg_19_0.animator

		var_1.Dispose(var_19_1)

		arg_19_0.animator = nil
	end

	return
end

return var_0_1

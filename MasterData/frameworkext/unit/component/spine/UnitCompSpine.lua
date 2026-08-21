module("frameworkext.unit.component.spine.UnitCompSpine", package.seeall)

local var_0_0 = class("UnitCompSpine", UnitComponentBase)

if Spine then
	var_0_0.SkeletonAnimationType = typeof(Spine.Unity.SkeletonAnimation)
end

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1)

	arg_1_0._url = nil
	arg_1_0._skeletonLoader = PrefabLoader.Get(arg_1_1.go)
	arg_1_0._skeletonAnimation = nil
	arg_1_0._defaultAnimState = "idle"
	arg_1_0._curAnimState = nil
	arg_1_0._isLoop = true
	arg_1_0._isFlipX = false
	arg_1_0._playSpeed = 1
	arg_1_0._scale = nil
	arg_1_0._transfigurationScale = nil
end

function var_0_0.setPlaySpeed(arg_2_0, arg_2_1)
	if arg_2_0._playSpeed == arg_2_1 then
		return
	end

	arg_2_0._playSpeed = arg_2_1

	arg_2_0:_updatePlaySpeed()
end

function var_0_0.getPlaySpeed(arg_3_0)
	return arg_3_0._playSpeed
end

function var_0_0._updatePlaySpeed(arg_4_0)
	if not arg_4_0._skeletonAnimation then
		return
	end

	arg_4_0._skeletonAnimation.timeScale = arg_4_0._playSpeed
end

function var_0_0.setDefaultAnimState(arg_5_0, arg_5_1)
	arg_5_0._defaultAnimState = arg_5_1
end

function var_0_0.getDefaultAnimState(arg_6_0)
	return arg_6_0._defaultAnimState
end

function var_0_0.getAnimState(arg_7_0)
	return arg_7_0._curAnimState or arg_7_0._defaultAnimState
end

function var_0_0.resetCurAnimState(arg_8_0)
	arg_8_0._curAnimState = nil
	arg_8_0._skeletonAnimation.AnimationName = nil
end

function var_0_0.getSkeletonAnimation(arg_9_0)
	return arg_9_0._skeletonAnimation
end

function var_0_0.setDirection(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1 ~= UnitSpineDir.Default

	if arg_10_0._isFlipX == var_10_0 then
		return
	end

	arg_10_0._isFlipX = var_10_0

	if arg_10_0._skeletonAnimation then
		local var_10_1 = arg_10_0._skeletonAnimation.Skeleton

		if var_10_1 then
			var_10_1.FlipX = arg_10_0._isFlipX
		end
	end
end

function var_0_0.getDirection(arg_11_0)
	if not arg_11_0._isFlipX then
		return UnitSpineDir.Default
	elseif UnitSpineDir.Default == UnitSpineDir.Right then
		return UnitSpineDir.Left
	else
		return UnitSpineDir.Right
	end
end

function var_0_0.setScale(arg_12_0, arg_12_1)
	if arg_12_1 and arg_12_0._scale ~= arg_12_1 then
		arg_12_0._scale = arg_12_1

		arg_12_0:updateScale()
	end
end

function var_0_0.setTransfigurationScale(arg_13_0, arg_13_1)
	if arg_13_1 and arg_13_0._transfigurationScale ~= arg_13_1 then
		arg_13_0._transfigurationScale = arg_13_1

		arg_13_0:updateScale()
	end
end

function var_0_0.getTransfigurationScale(arg_14_0)
	return arg_14_0._transfigurationScale
end

function var_0_0.getRealScale(arg_15_0)
	return arg_15_0._transfigurationScale and arg_15_0._transfigurationScale ~= 1 and arg_15_0._transfigurationScale or arg_15_0._scale
end

function var_0_0.updateScale(arg_16_0)
	local var_16_0 = arg_16_0:getRealScale()

	if var_16_0 and not goutil.isNil(arg_16_0._unit.go) then
		Astral.TransformUtil.SetLocalScale(arg_16_0._unit.go.transform, var_16_0, var_16_0, 1)
	end
end

function var_0_0.setBody(arg_17_0, arg_17_1)
	if arg_17_0._url == arg_17_1 then
		return
	end

	arg_17_0:clear()

	if not arg_17_1 then
		return
	end

	arg_17_0._url = arg_17_1

	arg_17_0._skeletonLoader:load(arg_17_1, arg_17_0._onBodyLoaded, arg_17_0, true)
end

function var_0_0.getInst(arg_18_0)
	return arg_18_0._skeletonLoader:getInst()
end

function var_0_0._onBodyLoaded(arg_19_0, arg_19_1)
	arg_19_0._skeletonAnimation = arg_19_0._skeletonLoader:getInst():GetComponent(var_0_0.SkeletonAnimationType)

	arg_19_0._skeletonAnimation:Initialize(false)

	arg_19_0._skeletonAnimation.Skeleton.FlipX = arg_19_0._isFlipX

	if arg_19_0._curAnimState then
		local var_19_0 = arg_19_0._curAnimState

		arg_19_0._curAnimState = nil

		arg_19_0:play(var_19_0, arg_19_0._isLoop)
	elseif arg_19_0._defaultAnimState then
		arg_19_0:play(arg_19_0._defaultAnimState, arg_19_0._isLoop)
	end

	arg_19_0:_updatePlaySpeed()
	arg_19_0:updateScale()
	arg_19_0._unit:dispatchInnerEvent(UnitActionType.SpineLoaded)
end

function var_0_0.play(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	arg_20_2 = arg_20_2 or false

	if not arg_20_1 then
		return
	end

	if arg_20_0._isLoop == arg_20_2 and arg_20_2 == true and arg_20_0._curAnimState == arg_20_1 then
		return
	end

	arg_20_0._curAnimState = arg_20_1
	arg_20_0._isLoop = arg_20_2

	if arg_20_0._skeletonAnimation then
		if arg_20_3 then
			arg_20_0._skeletonAnimation:PlayAnimation(arg_20_1, arg_20_0._isLoop, true)
		else
			arg_20_0._skeletonAnimation.loop = arg_20_0._isLoop
			arg_20_0._skeletonAnimation.AnimationName = arg_20_1
		end
	end
end

function var_0_0.clear(arg_21_0)
	if arg_21_0._skeletonLoader then
		arg_21_0._skeletonLoader:clear()
	end

	arg_21_0._skeletonAnimation = nil
	arg_21_0._url = nil
end

function var_0_0.onDestroy(arg_22_0)
	arg_22_0._skeletonLoader = nil
	arg_22_0._skeletonAnimation = nil
	arg_22_0._url = nil
	arg_22_0._scale = nil
	arg_22_0._transfigurationScale = nil
end

return var_0_0

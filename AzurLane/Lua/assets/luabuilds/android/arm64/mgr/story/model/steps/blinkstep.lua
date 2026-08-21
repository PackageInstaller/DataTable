local var_0_0 = class("BlinkStep", import(".StoryStep"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.openRange = arg_1_1.openRange or {
		1,
		0.6
	}
	arg_1_0.openTime = arg_1_1.open or 1
	arg_1_0.closeRange = arg_1_1.closeRange or {
		0.6,
		1
	}
	arg_1_0.closeTime = arg_1_1.close or 1
	arg_1_0.holdRange = arg_1_1.holdRange or {
		1,
		1
	}
	arg_1_0.holdTime = arg_1_1.hold or 1
	arg_1_0.ease = arg_1_1.ease or LeanTweenType.easeInOutQuad
	arg_1_0.nextBgName = arg_1_1.nextBgName
	arg_1_0.blurTimeFactor = arg_1_1.blurTimeFactor or {
		0.7,
		0.9
	}

	return
end

function var_0_0.GetMode(arg_2_0)
	return Story.MODE_BLINK
end

function var_0_0.GetOpenEyeData(arg_3_0)
	return {
		open = Vector3(arg_3_0.openRange[1], arg_3_0.openRange[2], arg_3_0.openTime),
		close = Vector3(arg_3_0.closeRange[1], arg_3_0.closeRange[2], arg_3_0.closeTime),
		hold = Vector3(arg_3_0.holdRange[1], arg_3_0.holdRange[2], arg_3_0.holdTime),
		ease = arg_3_0.ease
	}
end

function var_0_0.GetNextBgName(arg_4_0)
	return arg_4_0.nextBgName
end

return var_0_0

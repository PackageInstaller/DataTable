class = var_0_10000

local var_0_0 = "BlinkStep"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".StoryStep"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	local var_1_0

	if not arg_1_1.openRange then
		var_1_0 = {
			1,
			0.6
		}
	end

	arg_1_0.openRange = var_1_0

	local var_1_1

	if not arg_1_1.open then
		var_1_1 = 1
	end

	arg_1_0.openTime = var_1_1

	local var_1_2

	if not arg_1_1.closeRange then
		var_1_2 = {
			0.6,
			1
		}
	end

	arg_1_0.closeRange = var_1_2

	local var_1_3

	if not arg_1_1.close then
		var_1_3 = 1
	end

	arg_1_0.closeTime = var_1_3

	local var_1_4

	if not arg_1_1.holdRange then
		var_1_4 = {
			1,
			1
		}
	end

	arg_1_0.holdRange = var_1_4

	local var_1_5

	if not arg_1_1.hold then
		var_1_5 = 1
	end

	arg_1_0.holdTime = var_1_5

	local var_1_6

	if not arg_1_1.ease then
		LeanTweenType = var_1_6
		var_1_6 = var_1_6.easeInOutQuad
	end

	arg_1_0.ease = var_1_6
	arg_1_0.nextBgName = arg_1_1.nextBgName

	local var_1_7

	if not arg_1_1.blurTimeFactor then
		var_1_7 = {
			0.7,
			0.9
		}
	end

	arg_1_0.blurTimeFactor = var_1_7

	return
end

function var_0_1.GetMode(arg_2_0)
	Story = var_1_10001

	return var_1_10001.MODE_BLINK
end

function var_0_1.GetOpenEyeData(arg_3_0)
	local var_3_0 = {}

	Vector3 = var_1_10002
	var_3_0.open = var_1_10002(arg_3_0.openRange[1], arg_3_0.openRange[2], arg_3_0.openTime)
	Vector3 = var_2
	var_3_0.close = var_2(arg_3_0.closeRange[1], arg_3_0.closeRange[2], arg_3_0.closeTime)
	Vector3 = var_2
	var_3_0.hold = var_2(arg_3_0.holdRange[1], arg_3_0.holdRange[2], arg_3_0.holdTime)
	var_3_0.ease = arg_3_0.ease

	return var_3_0
end

function var_0_1.GetNextBgName(arg_4_0)
	return arg_4_0.nextBgName
end

return var_0_1

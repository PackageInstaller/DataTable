class = var_0_10000

local var_0_0 = "BlinkStoryPlayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".StoryPlayer"))

function var_0_1.UpdateBg(arg_1_0, arg_1_1)
	var_0_1.super.UpdateBg(arg_1_0, arg_1_1)

	pg = var_2

	local var_1_0 = var_2.UIMgr.GetInstance().cameraBlurs

	pg = var_1_10003
	arg_1_0.blurOptimized = var_1_0[var_1_10003.UIMgr.CameraOverlay][1]
	arg_1_0.blurFlag = false

	local var_1_1 = arg_1_0.blurOptimized.downsample
	local var_1_2 = arg_1_0.blurOptimized.blurSize
	local var_1_3 = arg_1_0.blurOptimized.blurIteration

	arg_1_0.defaultBlueValues = {
		downsample = var_1_1,
		blurSize = var_1_2,
		blurIteration = var_1_3
	}

	return
end

function var_0_1.LoadEffects(arg_2_0, arg_2_1, arg_2_2)
	parallelAsync = var_1_10003

	var_1_10003({
		function(arg_3_0)
			local var_3_0 = arg_2_0

			var_1.PlayOpenEyeEffect(var_3_0, arg_2_1, arg_3_0)

			return
		end,
		function(arg_4_0)
			var_0_1.super.LoadEffects(arg_2_0, arg_2_1, arg_4_0)

			return
		end
	}, arg_2_2)

	return
end

function var_0_1.PlayOpenEyeEffect(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_1:GetOpenEyeData()

	seriesAsync = var_1_10004

	var_1_10004({
		function(arg_6_0)
			local var_6_0 = arg_5_0

			var_1.LoadOpenEyeEffect(var_6_0, function(arg_7_0)
				arg_5_0.targetGo = arg_7_0

				arg_6_0()

				return
			end)

			return
		end,
		function(arg_8_0)
			local var_8_0 = arg_5_0

			var_1.ApplyOpenEyeEffect(var_8_0, arg_5_1, var_5_0, arg_5_0.targetGo, arg_8_0)

			return
		end,
		function(arg_9_0)
			local var_9_0 = arg_5_0

			var_1.ClearTarget(var_9_0)
			arg_9_0()

			return
		end
	}, arg_5_2)

	return
end

function var_0_1.ClearTarget(arg_10_0)
	if arg_10_0.targetGo then
		local var_10_0 = arg_10_0.targetGo
		local var_10_1 = var_1.GetComponent

		typeof = var_1_10004
		Image = var_1_10006

		local var_10_2 = var_10_1(var_10_0, var_1_10004(var_1_10006)).material

		var_1.SetFloat(var_10_2, "_EyeClose", 1)

		Object = var_2

		var_2.Destroy(arg_10_0.targetGo)

		arg_10_0.targetGo = nil
	end

	return
end

function var_0_1.LoadOpenEyeEffect(arg_11_0, arg_11_1)
	LoadAndInstantiateAsync = var_1_10002

	var_1_10002("effect", "openEye", function(arg_12_0)
		setParent = var_2_10001

		var_2_10001(arg_12_0, arg_11_0.topEffectTr)

		local var_12_0 = arg_12_0.transform

		Vector3 = var_2_10002
		var_12_0.localScale = var_2_10002.one
		setActive = var_12_0

		var_12_0(arg_12_0, true)
		arg_11_1(arg_12_0)

		return
	end)

	return
end

local function var_0_2(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	arg_13_0:TweenValueWithEase(arg_13_0._go, arg_13_2.x, arg_13_2.y, arg_13_2.z, 0, arg_13_3, function(arg_14_0)
		local var_14_0 = arg_13_1

		var_1.SetFloat(var_14_0, "_EyeClose", arg_14_0)

		return
	end, arg_13_4)

	return
end

function var_0_1.ApplyOpenEyeEffect(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	setActive = var_1_10005

	var_1_10005(arg_15_0.bgPanel, true)

	local var_15_0 = arg_15_2.open
	local var_15_1 = arg_15_2.close
	local var_15_2 = arg_15_2.hold
	local var_15_3 = arg_15_2.ease
	local var_15_4 = arg_15_3
	local var_15_5 = arg_15_3.GetComponent

	typeof = var_1_10012
	Image = var_1_10014

	local var_15_6 = var_15_5(var_15_4, var_1_10012(var_1_10014)).material

	seriesAsync = var_1_10010

	var_1_10010({
		function(arg_16_0)
			parallelAsync = var_2_10001

			var_2_10001({
				function(arg_17_0)
					var_0_2(arg_15_0, var_15_6, var_15_1, var_15_3, arg_17_0)

					return
				end,
				function(arg_18_0)
					local var_18_0 = arg_15_0

					var_1.ClearToBlur(var_18_0, arg_15_1, arg_18_0)

					return
				end
			}, arg_16_0)

			return
		end,
		function(arg_19_0)
			parallelAsync = var_2_10001

			var_2_10001({
				function(arg_20_0)
					local var_20_0 = arg_15_0

					var_1.UpdateNextBg(var_20_0, arg_15_1, arg_20_0)

					return
				end,
				function(arg_21_0)
					var_0_2(arg_15_0, var_15_6, var_15_2, var_15_3, arg_21_0)

					return
				end
			}, arg_19_0)

			return
		end,
		function(arg_22_0)
			parallelAsync = var_2_10001

			var_2_10001({
				function(arg_23_0)
					var_0_2(arg_15_0, var_15_6, var_15_0, var_15_3, arg_23_0)

					return
				end,
				function(arg_24_0)
					local var_24_0 = arg_15_0

					var_1.BlurToClear(var_24_0, arg_15_1, arg_24_0)

					return
				end
			}, arg_22_0)

			return
		end
	}, arg_15_4)

	return
end

function var_0_1.ClearToBlur(arg_25_0, arg_25_1, arg_25_2)
	arg_25_0.blurFlag = true
	arg_25_0.blurOptimized.downsample = 0
	arg_25_0.blurOptimized.blurSize = 0
	arg_25_0.blurOptimized.blurIteration = 0
	arg_25_0.blurOptimized.enabled = true

	local var_25_0 = arg_25_1.closeTime
	local var_25_1 = arg_25_1.ease
	local var_25_2 = arg_25_1.blurTimeFactor[1]

	arg_25_0:TweenValueWithEase(arg_25_0._go, 0, 3, var_25_0 * var_25_2, 0, var_25_1, function(arg_26_0)
		arg_25_0.blurOptimized.blurSize = arg_26_0
		arg_25_0.blurOptimized.blurIteration = arg_26_0

		return
	end, arg_25_2)

	return
end

function var_0_1.BlurToClear(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = arg_27_1.openTime
	local var_27_1 = arg_27_1.ease
	local var_27_2 = arg_27_1.blurTimeFactor[2]

	arg_27_0:TweenValueWithEase(arg_27_0._go, 3, 0, var_27_0 * var_27_2, 0, var_27_1, function(arg_28_0)
		arg_27_0.blurOptimized.blurSize = arg_28_0
		arg_27_0.blurOptimized.blurIteration = arg_28_0

		return
	end, function()
		local var_29_0 = arg_27_0

		var_0.ClearBlur(var_29_0)
		arg_27_2()

		return
	end)

	return
end

function var_0_1.ClearBlur(arg_30_0)
	if arg_30_0.blurFlag then
		arg_30_0.blurOptimized.enabled = false
		arg_30_0.blurOptimized.downsample = arg_30_0.defaultBlueValues.downsample
		arg_30_0.blurOptimized.blurSize = arg_30_0.defaultBlueValues.blurSize
		arg_30_0.blurOptimized.blurIteration = arg_30_0.defaultBlueValues.blurIteration
		arg_30_0.blurFlag = false
	end

	return
end

function var_0_1.UpdateNextBg(arg_31_0, arg_31_1, arg_31_2)
	if not arg_31_1:GetNextBgName() then
		arg_31_2()

		return
	end

	setActive = var_1_10004

	var_1_10004(arg_31_0.bgPanel, true)

	arg_31_0.bgPanelCg.alpha = 1

	local var_31_0 = arg_31_0.bgImage

	Color = var_5
	var_31_0.color = var_5.New(1, 1, 1)
	var_31_0.sprite = arg_31_0:GetBg(var_3)

	arg_31_2()

	return
end

function var_0_1.RegisetEvent(arg_32_0, arg_32_1, arg_32_2)
	arg_32_2()

	return
end

function var_0_1.OnClear(arg_33_0)
	arg_33_0:ClearTarget()
	arg_33_0:ClearBlur()

	return
end

function var_0_1.OnEnd(arg_34_0)
	arg_34_0:ClearTarget()
	arg_34_0:ClearBlur()

	return
end

return var_0_1

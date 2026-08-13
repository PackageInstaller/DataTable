class = var_0_10000

local var_0_0 = "CourtYardFurnitureAnimatorAgent"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".CourtYardAgent"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.maskSpineAnimUIs = {}
	pairs = var_2

	for iter_1_0, iter_1_1 in var_2(arg_1_0.masks) do
		GetOrAddComponent = var_1_10007

		local var_1_0 = iter_1_1
		local var_1_1 = iter_1_1.Find(var_1_0, "spine")

		typeof = var_1_0
		SpineAnimUI = var_10
		var_1_10007 = var_1_10007(var_1_1, var_1_0(var_10))
		table = var_1_1

		var_1_1.insert(arg_1_0.maskSpineAnimUIs, var_1_10007)
	end

	local var_1_2 = arg_1_0._tf

	arg_1_0.spineTF = var_2.Find(var_1_2, "spine_icon")
	GetOrAddComponent = var_2

	local var_1_3 = arg_1_0.spineTF
	local var_1_4 = var_3.Find(var_1_3, "spine")

	typeof = var_1_3
	SpineAnimUI = var_5
	arg_1_0.spineAnimUI = var_2(var_1_4, var_1_3(var_5))

	local var_1_5 = arg_1_0
	local var_1_6 = arg_1_0.SetState

	CourtYardFurniture = var_4

	var_1_6(var_1_5, var_4.STATE_IDLE)

	return
end

function var_0_1.State2Action(arg_2_0, arg_2_1)
	CourtYardFurniture = var_1_10002

	if arg_2_1 == var_1_10002.STATE_IDLE then
		local var_2_0 = arg_2_0.data
		local var_2_1 = var_2.GetFirstSlot(var_2_0)

		return var_2.GetSpineDefaultAction(var_2_1), true
	else
		CourtYardFurniture = var_2

		if arg_2_1 == var_2.STATE_TOUCH then
			local var_2_2 = arg_2_0.data

			return var_2.GetTouchAction(var_2_2)
		else
			CourtYardFurniture = var_2

			if arg_2_1 == var_2.STATE_TOUCH_PREPARE then
				local var_2_3 = arg_2_0.data

				return var_2.GetTouchPrepareAction(var_2_3)
			else
				CourtYardFurniture = var_2

				if arg_2_1 == var_2.STATE_PLAY_MUSIC then
					local var_2_4 = arg_2_0.data

					return var_2.GetMusicData(var_2_4).action, true
				end
			end
		end
	end

	return
end

function var_0_1.SetState(arg_3_0, arg_3_1)
	local var_3_0, var_3_1 = arg_3_0:State2Action(arg_3_1)

	if not var_3_0 or var_3_0 == "" then
		return
	end

	arg_3_0:_PlayAction(var_3_0, var_3_1, function()
		local var_4_0 = arg_3_0

		var_0.OnAnimtionFinish(var_4_0, arg_3_1)

		return
	end)

	CourtYardFurniture = var_4

	if arg_3_1 == var_4.STATE_IDLE then
		ipairs = var_4

		for iter_3_0, iter_3_1 in var_4(arg_3_0.maskSpineAnimUIs) do
			iter_3_1:SetAction(var_3_0, 0)
		end
	end

	return
end

function var_0_1.GetNormalAnimationName(arg_5_0)
	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.State2Action

	CourtYardFurniture = var_1_10003

	return var_5_1(var_5_0, var_1_10003.STATE_IDLE)
end

function var_0_1.RestartAnimation(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0.spineAnimUI

	var_2.SetAction(var_6_0, arg_6_1, 0)

	return
end

function var_0_1._PlayAction(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0

	if arg_7_2 or not function(arg_8_0)
		if arg_8_0 == "finish" then
			local var_8_0 = arg_7_0.spineAnimUI

			var_1.SetActionCallBack(var_8_0, nil)
			arg_7_3()
		end

		return
	end then
		var_7_0 = nil
	end

	local var_7_1 = arg_7_0.spineAnimUI

	var_5.SetActionCallBack(var_7_1, var_7_0)

	local var_7_2 = arg_7_0.spineAnimUI

	var_5.SetAction(var_7_2, arg_7_1, 0)

	return
end

function var_0_1.PlayInteractioAnim(arg_9_0, arg_9_1)
	parallelAsync = var_1_10002

	var_1_10002({
		function(arg_10_0)
			local var_10_0 = arg_9_0

			var_1.PlayMaskAction(var_10_0, arg_9_1, arg_10_0)

			return
		end,
		function(arg_11_0)
			local var_11_0 = arg_9_0

			var_1._PlayAction(var_11_0, arg_9_1, false, arg_11_0)

			return
		end
	}, function()
		local var_12_0 = arg_9_0
		local var_12_1 = var_0.OnAnimtionFinish

		CourtYardFurniture = var_2_10002

		var_12_1(var_12_0, var_2_10002.STATE_INTERACT)

		return
	end)

	return
end

function var_0_1.PlayMaskAction(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = {}

	ipairs = var_1_10004

	for iter_13_0, iter_13_1 in var_1_10004(arg_13_0.maskSpineAnimUIs) do
		table = var_1_10009

		var_1_10009.insert(var_13_0, function(arg_14_0)
			local var_14_0 = iter_13_1

			var_1.SetActionCallBack(var_14_0, function(arg_15_0)
				if arg_15_0 == "finish" then
					local var_15_0 = iter_13_1

					var_1.SetActionCallBack(var_15_0, nil)
					arg_14_0()
				end

				return
			end)

			local var_14_1 = iter_13_1

			var_1.SetAction(var_14_1, arg_13_1, 0)

			return
		end)
	end

	parallelAsync = var_4

	var_4(var_13_0, arg_13_2)

	return
end

function var_0_1.Dispose(arg_16_0)
	local var_16_0 = arg_16_0.spineAnimUI

	var_1.SetActionCallBack(var_16_0, nil)

	Object = var_1

	var_1.Destroy(arg_16_0.spineAnimUI)

	arg_16_0.spineAnimUI = nil
	Object = var_1

	var_1.Destroy(arg_16_0.spineTF.gameObject)

	arg_16_0.spineTF = nil
	ipairs = var_1

	for iter_16_0, iter_16_1 in var_1(arg_16_0.maskSpineAnimUIs) do
		iter_16_1:SetActionCallBack(nil)

		Object = var_6

		var_6.Destroy(iter_16_1)
	end

	arg_16_0.maskSpineAnimUIs = nil

	var_0_1.super.Dispose()

	return
end

return var_0_1

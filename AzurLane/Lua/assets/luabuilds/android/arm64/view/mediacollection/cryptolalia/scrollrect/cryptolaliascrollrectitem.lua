class = var_0_10000

local var_0_0 = var_0_10000("CryptolaliaScrollRectItem")

Vector3 = var_0_10001

local var_0_1 = var_0_10001(490, -35, 0)

Vector3 = var_2

local var_0_2 = var_2(297, 297, 0)

local function var_0_3(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0.midIndex - arg_1_1
	local var_1_1 = var_0_2 * var_1_0

	return var_0_1 + var_1_1
end

function var_0_0.Ctor(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0._go = arg_2_1
	arg_2_0._tf = arg_2_1.transform
	arg_2_0.initIndex = arg_2_3
	arg_2_0.midIndex = arg_2_2

	local var_2_0 = arg_2_0._go
	local var_2_1 = var_4.GetComponent

	typeof = var_1_10007
	Image = var_1_10009
	arg_2_0.img = var_2_1(var_2_0, var_1_10007(var_1_10009))

	local var_2_2 = arg_2_0._tf

	arg_2_0.text = var_4.Find(var_2_2, "Text")
	arg_2_0.index = arg_2_3

	local var_2_3 = var_0_3(arg_2_0, arg_2_3)

	arg_2_0:SetPosition(var_2_3)

	return
end

function var_0_0.Interactable(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0.img

	var_3_0.raycastTarget = arg_3_1
	setActive = var_3_0

	var_3_0(arg_3_0.text, not arg_3_1)

	return
end

function var_0_0.CanInteractable(arg_4_0)
	return arg_4_0.img.raycastTarget
end

function var_0_0.UpdateIndexWithAnim(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	math = var_1_10004

	local var_5_0 = var_1_10004.abs(arg_5_1 - arg_5_0.index) > 1

	local function var_5_1(arg_6_0, arg_6_1)
		LeanTween = var_2_10002

		local var_6_0 = var_2_10002.moveLocal(arg_5_0._go, arg_6_0, 0.594)
		local var_6_1 = var_2.setEase

		LeanTweenType = var_5

		local var_6_2 = var_6_1(var_6_0, var_5.easeInOutCirc)
		local var_6_3 = var_2.setOnComplete

		System = var_5

		var_6_3(var_6_2, var_5.Action(arg_6_1))

		return
	end

	if var_5_0 then
		local var_5_2 = var_0_3(arg_5_0, arg_5_2)

		var_5_1(var_5_2, function()
			local var_7_0 = arg_5_0

			var_0.UpdateIndex(var_7_0, arg_5_1)
			arg_5_3()

			return
		end)
	else
		local var_5_3 = var_0_3(arg_5_0, arg_5_1)

		var_5_1(var_5_3, function()
			local var_8_0 = arg_5_0

			var_0.UpdateIndex(var_8_0, arg_5_1)

			return
		end)
	end

	return
end

function var_0_0.UpdateIndex(arg_9_0, arg_9_1)
	arg_9_0.index = arg_9_1
	arg_9_0._go.name = arg_9_1

	local var_9_0 = var_0_3(arg_9_0, arg_9_1)

	arg_9_0:SetPosition(var_9_0)

	return
end

function var_0_0.UpdateIndexSilence(arg_10_0, arg_10_1)
	arg_10_0.index = arg_10_1
	arg_10_0._go.name = arg_10_1

	return
end

function var_0_0.Refresh(arg_11_0)
	local var_11_0 = arg_11_0:GetIndex()

	arg_11_0:UpdateIndex(var_11_0)

	return
end

function var_0_0.ClearAnimation(arg_12_0)
	LeanTween = var_1_10001

	if var_1_10001.isTweening(arg_12_0._go) then
		LeanTween = var_1

		var_1.cancel(arg_12_0._go)
	end

	arg_12_0:SetPosition(var_0_3(arg_12_0, arg_12_0.index))

	return
end

function var_0_0.GetIndex(arg_13_0)
	return arg_13_0.index
end

function var_0_0.GetInitIndex(arg_14_0)
	return arg_14_0.initIndex
end

function var_0_0.IsMidIndex(arg_15_0)
	return arg_15_0:GetIndex() == arg_15_0.midIndex
end

function var_0_0.UpdateSprite(arg_16_0, arg_16_1)
	arg_16_0.img.sprite = arg_16_1

	local var_16_0 = arg_16_0.img

	var_2.SetNativeSize(var_16_0)

	return
end

function var_0_0.SetPosition(arg_17_0, arg_17_1)
	arg_17_0._tf.localPosition = arg_17_1

	return
end

function var_0_0.GetPosition(arg_18_0)
	return arg_18_0._tf.localPosition
end

function var_0_0.Dispose(arg_19_0)
	arg_19_0:ClearAnimation()

	return
end

return var_0_0

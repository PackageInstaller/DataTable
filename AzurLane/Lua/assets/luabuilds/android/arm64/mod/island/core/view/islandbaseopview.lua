class = var_0_10000

local var_0_0 = "IslandBaseOpView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandBaseSubView"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)
	arg_1_0:Init()

	arg_1_0.enableCnt = 0

	return
end

function var_0_1.DoInit(arg_2_0, arg_2_1, arg_2_2)
	var_0_1.super.DoInit(arg_2_0, arg_2_1, arg_2_2)

	if arg_2_0:GetEnterAnimationName() or arg_2_0:GetExitAnimationName() then
		local var_2_0 = arg_2_1
		local var_2_1 = arg_2_1.GetComponent

		typeof = var_6
		Animation = var_1_10008
		arg_2_0.animataion = var_2_1(var_2_0, var_6(var_1_10008))

		local var_2_2 = arg_2_0.animataion
		local var_2_3 = var_3.GetComponent

		typeof = var_6
		DftAniEvent = var_1_10008
		arg_2_0.dftAniEvent = var_2_3(var_2_2, var_6(var_1_10008))
	end

	return
end

function var_0_1.GetUIParent(arg_3_0, arg_3_1)
	return arg_3_0:GetView().opContainer
end

function var_0_1.TryDisable(arg_4_0, arg_4_1)
	if arg_4_0.exiting then
		return
	end

	arg_4_0.enableCnt = arg_4_0.enableCnt - 1

	if arg_4_0.enableCnt == 0 then
		arg_4_0.exiting = true

		arg_4_0:HideUI(arg_4_1, function()
			arg_4_0.exiting = false

			local var_5_0 = arg_4_0

			var_0.OnDisable(var_5_0)

			return
		end)
	end

	return
end

function var_0_1.CloseAndReset(arg_6_0)
	if arg_6_0.enableCnt <= 0 then
		return
	end

	arg_6_0.enableCnt = 1

	arg_6_0:TryDisable()

	return
end

function var_0_1.TryEnable(arg_7_0)
	arg_7_0.enableCnt = arg_7_0.enableCnt + 1

	if arg_7_0.enableCnt == 1 then
		arg_7_0:ShowUI()
		arg_7_0:OnEnable()
	end

	return
end

function var_0_1.ShowOrHideGameObject(arg_8_0, arg_8_1, arg_8_2)
	GetOrAddComponent = var_1_10003

	local var_8_0 = arg_8_1

	typeof = var_1_10006
	CanvasGroup = var_1_10008

	local var_8_1 = var_1_10003(var_8_0, var_1_10006(var_1_10008))

	var_8_1.alpha = arg_8_2 and 1 or 0
	var_8_1.blocksRaycasts = arg_8_2

	return
end

function var_0_1.HideUI(arg_9_0, arg_9_1, arg_9_2)
	defaultValue = var_1_10003

	if var_1_10003(arg_9_1, true) then
		arg_9_0:PlayExitAnimation(function()
			local var_10_0 = arg_9_0

			var_0.ShowOrHideGameObject(var_10_0, arg_9_0._go, false)
			arg_9_2()

			return
		end)
	else
		arg_9_0:ShowOrHideGameObject(arg_9_0._go, false)
		arg_9_2()
	end

	return
end

function var_0_1.ShowUI(arg_11_0)
	arg_11_0:PlayeEnterAnimation()
	arg_11_0:ShowOrHideGameObject(arg_11_0._go, true)

	return
end

function var_0_1.PlayeEnterAnimation(arg_12_0)
	if arg_12_0:GetEnterAnimationName() then
		local var_12_0 = arg_12_0.animataion

		var_2.Play(var_12_0, var_1)
	end

	return
end

function var_0_1.PlayExitAnimation(arg_13_0, arg_13_1)
	if arg_13_0:GetExitAnimationName() then
		local var_13_0 = arg_13_0.dftAniEvent

		var_3.SetEndEvent(var_13_0, function()
			local var_14_0 = arg_13_0.dftAniEvent

			var_0.SetEndEvent(var_14_0, nil)
			arg_13_1()

			return
		end)

		local var_13_1 = arg_13_0.animataion

		var_3.Play(var_13_1, var_2)
	else
		arg_13_1()
	end

	return
end

function var_0_1.OnBeforeLoaded(arg_15_0)
	arg_15_0.enableCnt = 1

	return
end

function var_0_1.OnDispose(arg_16_0)
	var_0_1.super.OnDispose(arg_16_0)

	if arg_16_0.dftAniEvent then
		local var_16_0 = arg_16_0.dftAniEvent

		var_1.SetEndEvent(var_16_0, nil)
	end

	return
end

function var_0_1.OnDisable(arg_17_0)
	return
end

function var_0_1.OnEnable(arg_18_0)
	return
end

function var_0_1.GetEnterAnimationName(arg_19_0)
	return nil
end

function var_0_1.GetExitAnimationName(arg_20_0)
	return nil
end

return var_0_1

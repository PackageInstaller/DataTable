local var_0_0 = class("IslandBaseOpView", import(".IslandBaseSubView"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)
	arg_1_0:Init()

	arg_1_0.enableCnt = 0

	return
end

function var_0_0.DoInit(arg_2_0, arg_2_1, arg_2_2)
	var_0_0.super.DoInit(arg_2_0, arg_2_1, arg_2_2)

	if arg_2_0:GetEnterAnimationName() or arg_2_0:GetExitAnimationName() then
		arg_2_0.animataion = arg_2_1:GetComponent(typeof(Animation))
		arg_2_0.dftAniEvent = arg_2_0.animataion:GetComponent(typeof(DftAniEvent))
	end

	return
end

function var_0_0.GetUIParent(arg_3_0, arg_3_1)
	return arg_3_0:GetView().opContainer
end

function var_0_0.TryDisable(arg_4_0, arg_4_1)
	if arg_4_0.exiting then
		return
	end

	arg_4_0.enableCnt = arg_4_0.enableCnt - 1

	if arg_4_0.enableCnt == 0 then
		arg_4_0.exiting = true

		arg_4_0:HideUI(arg_4_1, function()
			arg_4_0.exiting = false

			arg_4_0:OnDisable()

			return
		end)
	end

	return
end

function var_0_0.CloseAndReset(arg_6_0)
	if arg_6_0.enableCnt <= 0 then
		return
	end

	arg_6_0.enableCnt = 1

	arg_6_0:TryDisable()

	return
end

function var_0_0.TryEnable(arg_7_0)
	arg_7_0.enableCnt = arg_7_0.enableCnt + 1

	if arg_7_0.enableCnt == 1 then
		arg_7_0:ShowUI()
		arg_7_0:OnEnable()
	end

	return
end

function var_0_0.ShowOrHideGameObject(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = GetOrAddComponent(arg_8_1, typeof(CanvasGroup))

	var_8_0.alpha = arg_8_2 and 1 or 0
	var_8_0.blocksRaycasts = arg_8_2

	return
end

function var_0_0.HideUI(arg_9_0, arg_9_1, arg_9_2)
	arg_9_1 = defaultValue(arg_9_1, true)

	if arg_9_1 then
		arg_9_0:PlayExitAnimation(function()
			arg_9_0:ShowOrHideGameObject(arg_9_0._go, false)
			arg_9_2()

			return
		end)
	else
		arg_9_0:ShowOrHideGameObject(arg_9_0._go, false)
		arg_9_2()
	end

	return
end

function var_0_0.ShowUI(arg_11_0)
	arg_11_0:PlayeEnterAnimation()
	arg_11_0:ShowOrHideGameObject(arg_11_0._go, true)

	return
end

function var_0_0.PlayeEnterAnimation(arg_12_0)
	local var_12_0 = arg_12_0:GetEnterAnimationName()

	if var_12_0 then
		arg_12_0.animataion:Play(var_12_0)
	end

	return
end

function var_0_0.PlayExitAnimation(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0:GetExitAnimationName()

	if var_13_0 then
		arg_13_0.dftAniEvent:SetEndEvent(function()
			arg_13_0.dftAniEvent:SetEndEvent(nil)
			arg_13_1()

			return
		end)
		arg_13_0.animataion:Play(var_13_0)
	else
		arg_13_1()
	end

	return
end

function var_0_0.OnBeforeLoaded(arg_15_0)
	arg_15_0.enableCnt = 1

	return
end

function var_0_0.OnDispose(arg_16_0)
	var_0_0.super.OnDispose(arg_16_0)

	if arg_16_0.dftAniEvent then
		arg_16_0.dftAniEvent:SetEndEvent(nil)
	end

	return
end

function var_0_0.OnDisable(arg_17_0)
	return
end

function var_0_0.OnEnable(arg_18_0)
	return
end

function var_0_0.GetEnterAnimationName(arg_19_0)
	return nil
end

function var_0_0.GetExitAnimationName(arg_20_0)
	return nil
end

return var_0_0

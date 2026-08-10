local var_0_0 = class("ObtainOathRingView", ObtainBaseView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = Object.Instantiate(arg_1_1, arg_1_2)

	arg_1_0.gameObject_ = var_1_0
	arg_1_0.transform_ = var_1_0.transform
	arg_1_0.obtainView = arg_1_3.obtainView
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddBtnListener(arg_2_0.jumpBtn_, nil, function()
		arg_2_0.obtainView:Back()
		JumpTools.GoToSystem("/adminHomePageView", nil, ViewConst.SYSTEM_ID.ADMIN_SYSTEM)
	end)
	arg_2_0:AddBtnListener(arg_2_0.maskBtn_, nil, function()
		arg_2_0.obtainView:OnMaskBtnClick()
	end)
end

function var_0_0.Dispose(arg_5_0)
	arg_5_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_5_0)
end

function var_0_0.OnClick(arg_6_0)
	return true
end

function var_0_0.NeedHandleInput(arg_7_0)
	return true
end

function var_0_0.NeedHideShare(arg_8_0)
	return true
end

function var_0_0.NeedGaussianBg(arg_9_0)
	return true
end

function var_0_0.SetInfo(arg_10_0, arg_10_1)
	local var_10_0 = ItemTools.getItemSprite(arg_10_1)

	arg_10_0.icon_.sprite = var_10_0

	local var_10_1 = GetTipsF("WEEDING_RING_OBTAIN_DESC", ItemTools.getItemName(arg_10_1))

	arg_10_0.title_.text = var_10_1
	arg_10_0.title2_.text = var_10_1

	SetActive(arg_10_0.jumpBtn_, arg_10_1 == ItemConst.OATH_RING)
end

return var_0_0

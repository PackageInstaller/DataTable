local ObtainOathRingView = class("ObtainOathRingView", ObtainBaseView)

function ObtainOathRingView:Ctor(arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = Object.Instantiate(arg_1_1, arg_1_2)

	self.gameObject_ = var_1_0
	self.transform_ = var_1_0.transform
	self.obtainView = arg_1_3.obtainView
end

function ObtainOathRingView:Init()
	self:BindCfgUI()
	self:AddBtnListener(self.jumpBtn_, nil, function()
		self.obtainView:Back()
		JumpTools.GoToSystem("/adminHomePageView", nil, ViewConst.SYSTEM_ID.ADMIN_SYSTEM)
	end)
	self:AddBtnListener(self.maskBtn_, nil, function()
		self.obtainView:OnMaskBtnClick()
	end)
end

function ObtainOathRingView:Dispose()
	self:RemoveAllListeners()
	ObtainOathRingView.super.Dispose(self)
end

function ObtainOathRingView:OnClick()
	return true
end

function ObtainOathRingView:NeedHandleInput()
	return true
end

function ObtainOathRingView:NeedHideShare()
	return true
end

function ObtainOathRingView:NeedGaussianBg()
	return true
end

function ObtainOathRingView:SetInfo(arg_10_1)
	self.icon_.sprite = ItemTools.getItemSprite(arg_10_1)

	local var_10_0 = GetTipsF("WEEDING_RING_OBTAIN_DESC", ItemTools.getItemName(arg_10_1))

	self.title_.text = var_10_0
	self.title2_.text = var_10_0

	SetActive(self.jumpBtn_, arg_10_1 == ItemConst.OATH_RING)
end

return ObtainOathRingView

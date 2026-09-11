local HeroPortraitView = class("HeroPortraitView", ReduxView)

function HeroPortraitView:UIName()
	return "Widget/System/ObtainUI/HeroMovie/PortraitPanel"
end

function HeroPortraitView:UIParent()
	return manager.ui.uiMain.transform
end

function HeroPortraitView:Init()
	self:InitUI()
	self:AddUIListener()
end

function HeroPortraitView:InitUI()
	self:BindCfgUI()

	self.portriatImg_.immediate = true
	self.scaleImage_ = self:FindCom("UIScaleImage", nil, self.portriatTrans_)
	self.scaleMax_ = self.scaleImage_.maxScale
	self.scaleMin_ = self.scaleImage_.minScale
	self.scaleLength_ = self.scaleMax_ - self.scaleMin_
	self.timer_ = Timer.New(function()
		self:OnHidenTimerReached()
	end, 2, -1)
end

function HeroPortraitView:AddUIListener()
	self:AddBtnListener(self.closeBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.addBtn_, nil, function()
		self:ChangeSliderValue(0.05)
	end)
	self:AddBtnListener(self.subBtn_, nil, function()
		self:ChangeSliderValue(-0.05)
	end)
	self.slider_.onValueChanged:AddListener(function(arg_10_0)
		self:OnSliderValueChanged(arg_10_0)
	end)
	self.scaleImage_.onScaleEvent:AddListener(function(arg_11_0)
		self:OnImageScaled(arg_11_0)
	end)
	self.scaleImage_.onValueChanged:AddListener(function()
		self:RestartAvatarBar()
	end)
end

function HeroPortraitView:OnEnter()
	self.scaleImage_.enabled = true
	self.heroID_ = self.params_.heroID
	self.skinID_ = self.params_.skinID
	self.portriatImg_.spriteSync = "TextureConfig/Character/Portrait/" .. (self.skinID_ ~= nil and SkinCfg[self.skinID_].picture_id or HeroTools.HeroUsingSkinInfo(self.heroID_).picture_id)

	self:OnImageScaled(1)
end

function HeroPortraitView:ChangeSliderValue(arg_14_1)
	local var_14_0 = self.slider_.value + arg_14_1

	if self.slider_.value + arg_14_1 > 1 then
		var_14_0 = 1
	end

	if var_14_0 < 0 then
		var_14_0 = 0
	end

	self.slider_.value = var_14_0
end

function HeroPortraitView:OnSliderValueChanged(arg_15_1)
	self.scaleImage_:SetScale(arg_15_1 * self.scaleLength_ + self.scaleMin_)
	self:RestartTimer()
end

function HeroPortraitView:OnImageScaled(arg_16_1)
	self:RestartAvatarBar()

	self.slider_.value = (arg_16_1 - self.scaleMin_) / self.scaleLength_
end

function HeroPortraitView:RestartAvatarBar()
	SetActive(self.sliderGo_, true)
	self:RestartTimer()
end

function HeroPortraitView:RestartTimer()
	self.timer_:Stop()

	self.timer_ = Timer.New(function()
		self:OnHidenTimerReached()
	end, 2, -1)

	self.timer_:Start()
end

function HeroPortraitView:OnHidenTimerReached()
	SetActive(self.sliderGo_, false)
	self.timer_:Stop()
end

function HeroPortraitView:OnTop()
	manager.windowBar:HideBar()
end

function HeroPortraitView:OnExit()
	if self.timer_ then
		self.timer_:Stop()
	end

	self.portriatImg_.spriteSync = nil

	self.scaleImage_:ResetContent()

	self.scaleImage_.enabled = false
end

function HeroPortraitView:Dispose()
	self:RemoveAllListeners()
	self.slider_.onValueChanged:RemoveAllListeners()
	self.scaleImage_.onScaleEvent:RemoveAllListeners()
	self.scaleImage_.onValueChanged:RemoveAllListeners()

	self.scaleImage_ = nil

	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end

	HeroPortraitView.super.Dispose(self)
end

return HeroPortraitView

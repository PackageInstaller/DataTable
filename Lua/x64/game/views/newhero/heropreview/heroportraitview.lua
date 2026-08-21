local var_0_0 = class("HeroPortraitView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/ObtainUI/HeroMovie/PortraitPanel"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.portriatImg_.immediate = true
	arg_4_0.scaleImage_ = arg_4_0:FindCom("UIScaleImage", nil, arg_4_0.portriatTrans_)
	arg_4_0.scaleMax_ = arg_4_0.scaleImage_.maxScale
	arg_4_0.scaleMin_ = arg_4_0.scaleImage_.minScale
	arg_4_0.scaleLength_ = arg_4_0.scaleMax_ - arg_4_0.scaleMin_
	arg_4_0.timer_ = Timer.New(function()
		arg_4_0:OnHidenTimerReached()
	end, 2, -1)
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.closeBtn_, nil, function()
		arg_6_0:Back()
	end)
	arg_6_0:AddBtnListener(arg_6_0.addBtn_, nil, function()
		arg_6_0:ChangeSliderValue(0.05)
	end)
	arg_6_0:AddBtnListener(arg_6_0.subBtn_, nil, function()
		arg_6_0:ChangeSliderValue(-0.05)
	end)
	arg_6_0.slider_.onValueChanged:AddListener(function(arg_10_0)
		arg_6_0:OnSliderValueChanged(arg_10_0)
	end)
	arg_6_0.scaleImage_.onScaleEvent:AddListener(function(arg_11_0)
		arg_6_0:OnImageScaled(arg_11_0)
	end)
	arg_6_0.scaleImage_.onValueChanged:AddListener(function()
		arg_6_0:RestartAvatarBar()
	end)
end

function var_0_0.OnEnter(arg_13_0)
	arg_13_0.scaleImage_.enabled = true
	arg_13_0.heroID_ = arg_13_0.params_.heroID
	arg_13_0.skinID_ = arg_13_0.params_.skinID

	local var_13_0

	if arg_13_0.skinID_ ~= nil then
		var_13_0 = SkinCfg[arg_13_0.skinID_].picture_id
	else
		var_13_0 = HeroTools.HeroUsingSkinInfo(arg_13_0.heroID_).picture_id
	end

	arg_13_0.portriatImg_.spriteSync = "TextureConfig/Character/Portrait/" .. var_13_0

	arg_13_0:OnImageScaled(1)
end

function var_0_0.ChangeSliderValue(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0.slider_.value + arg_14_1

	if var_14_0 > 1 then
		var_14_0 = 1
	end

	if var_14_0 < 0 then
		var_14_0 = 0
	end

	arg_14_0.slider_.value = var_14_0
end

function var_0_0.OnSliderValueChanged(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1 * arg_15_0.scaleLength_ + arg_15_0.scaleMin_

	arg_15_0.scaleImage_:SetScale(var_15_0)
	arg_15_0:RestartTimer()
end

function var_0_0.OnImageScaled(arg_16_0, arg_16_1)
	arg_16_0:RestartAvatarBar()

	local var_16_0 = (arg_16_1 - arg_16_0.scaleMin_) / arg_16_0.scaleLength_

	arg_16_0.slider_.value = var_16_0
end

function var_0_0.RestartAvatarBar(arg_17_0)
	SetActive(arg_17_0.sliderGo_, true)
	arg_17_0:RestartTimer()
end

function var_0_0.RestartTimer(arg_18_0)
	arg_18_0.timer_:Stop()

	arg_18_0.timer_ = Timer.New(function()
		arg_18_0:OnHidenTimerReached()
	end, 2, -1)

	arg_18_0.timer_:Start()
end

function var_0_0.OnHidenTimerReached(arg_20_0)
	SetActive(arg_20_0.sliderGo_, false)
	arg_20_0.timer_:Stop()
end

function var_0_0.OnTop(arg_21_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnExit(arg_22_0)
	if arg_22_0.timer_ then
		arg_22_0.timer_:Stop()
	end

	arg_22_0.portriatImg_.spriteSync = nil

	arg_22_0.scaleImage_:ResetContent()

	arg_22_0.scaleImage_.enabled = false
end

function var_0_0.Dispose(arg_23_0)
	arg_23_0:RemoveAllListeners()
	arg_23_0.slider_.onValueChanged:RemoveAllListeners()
	arg_23_0.scaleImage_.onScaleEvent:RemoveAllListeners()
	arg_23_0.scaleImage_.onValueChanged:RemoveAllListeners()

	arg_23_0.scaleImage_ = nil

	if arg_23_0.timer_ then
		arg_23_0.timer_:Stop()

		arg_23_0.timer_ = nil
	end

	var_0_0.super.Dispose(arg_23_0)
end

return var_0_0

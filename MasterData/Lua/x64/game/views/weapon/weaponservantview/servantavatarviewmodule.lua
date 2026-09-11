local ServantAvatarViewModule = class("ServantAvatarViewModule", ReduxView)

function ServantAvatarViewModule:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function ServantAvatarViewModule:Init()
	self:BindCfgUI()
	self:BuildContext()
	self:AddUIListener()
end

function ServantAvatarViewModule:BuildContext()
	local var_3_0 = self:FindCom("UIScaleImage", nil, self.scaleImageObj_)

	self.staticVar = {
		isInView = false,
		sliderIsHiden = true,
		scaleImage = var_3_0,
		minValue = var_3_0.minScale,
		maxValue = var_3_0.maxScale,
		ScaleLen = var_3_0.maxScale - var_3_0.minScale,
		hidenTimer = Timer.New(function()
			self:OnHidenTimerReached()
		end, 2, -1)
	}
	self.controller = {
		comps = self.controller_,
		state = {
			checkView = {
				False = "false",
				name = "checkView",
				True = "true",
				comps = self.controller_:GetController("checkView")
			}
		}
	}
	self.servantId = nil
end

function ServantAvatarViewModule:AddUIListener()
	self:AddBtnListener(self.closeBtn_, nil, function()
		self:OnCloseBtnClick()
	end)
	self.avatarSlider_.onValueChanged:AddListener(function(arg_7_0)
		self:OnAvatarSliderChanged(arg_7_0)
	end)
	self.staticVar.scaleImage.onScaleEvent:AddListener(function(arg_8_0)
		self:OnAvatarScale(arg_8_0)
	end)
	self.staticVar.scaleImage.onValueChanged:AddListener(function()
		self:RestartAvatarBar()
	end)
	self:AddBtnListener(self.subBtn_, nil, function()
		self:OnSliderBtnChange(-0.05)
	end)
	self:AddBtnListener(self.addBtn_, nil, function()
		self:OnSliderBtnChange(0.05)
	end)
end

function ServantAvatarViewModule:Dispose()
	self:RemoveAllListeners()
	self.staticVar.scaleImage.onScaleEvent:RemoveAllListeners()
	self.staticVar.scaleImage.onValueChanged:RemoveAllListeners()

	self.staticVar.scaleImage = nil

	self.avatarSlider_.onValueChanged:RemoveAllListeners()
	self.staticVar.hidenTimer:Stop()

	self.staticVar.hidenTimer = nil

	ServantAvatarViewModule.super.Dispose(self)
end

function ServantAvatarViewModule:RegisterCloseCallback(arg_13_1)
	self.staticVar.closeCallback = arg_13_1
end

function ServantAvatarViewModule:EnterAvatarView(arg_14_1)
	self.staticVar.isInView = arg_14_1

	if arg_14_1 then
		self:SwitchControllerState(self.controller.state.checkView.name, self.controller.state.checkView.True)

		self.staticVar.scaleImage.enabled = true
		self.staticVar.sliderIsHiden = true

		self:RefreshAvatar()
		self:OnAvatarScale(1)
		self:RestartTimer()
		SetActive(self.gameObject_, true)
	else
		self:SwitchControllerState(self.controller.state.checkView.name, self.controller.state.checkView.False)

		self.staticVar.scaleImage.enabled = false

		self:ResetAvatar()
		self.staticVar.hidenTimer:Stop()
		SetActive(self.gameObject_, false)
	end
end

function ServantAvatarViewModule:OnCloseBtnClick()
	if self.staticVar.closeCallback then
		self.staticVar.closeCallback()
	end
end

function ServantAvatarViewModule:OnSliderBtnChange(arg_16_1)
	local var_16_0 = self.avatarSlider_.value + arg_16_1

	if self.avatarSlider_.value + arg_16_1 > 1 then
		var_16_0 = 1
	end

	if var_16_0 < 0 then
		var_16_0 = 0
	end

	self.avatarSlider_.value = var_16_0
end

function ServantAvatarViewModule:SetAvatarSprite(arg_17_1)
	self.servantId = arg_17_1

	self:RefreshAvatar()
end

function ServantAvatarViewModule:RefreshAvatar()
	if self.servantId and self.staticVar.isInView then
		self.avatarIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/WeaponServant/Portrait/" .. self.servantId)
	end
end

function ServantAvatarViewModule:ResetAvatar()
	self.staticVar.scaleImage:ResetContent()
end

function ServantAvatarViewModule:OnAvatarSliderChanged(arg_20_1)
	self.staticVar.scaleImage:SetScale(self.staticVar.ScaleLen * arg_20_1 + self.staticVar.minValue)
	self:RestartTimer()
end

function ServantAvatarViewModule:OnAvatarScale(arg_21_1)
	self:RestartAvatarBar()

	self.avatarSlider_.value = (arg_21_1 - self.staticVar.minValue) / self.staticVar.ScaleLen
end

function ServantAvatarViewModule:RestartAvatarBar()
	SetActive(self.sliderObj_, true)

	self.staticVar.sliderIsHiden = false

	self:RestartTimer()
end

function ServantAvatarViewModule:SwitchControllerState(arg_23_1, arg_23_2)
	if self.controller.state[arg_23_1] and self.controller.state[arg_23_1].comps then
		self.controller.state[arg_23_1].comps:SetSelectedState(arg_23_2)
	end
end

function ServantAvatarViewModule:OnHidenTimerReached()
	SetActive(self.sliderObj_, false)

	self.staticVar.sliderIsHiden = true

	self.staticVar.hidenTimer:Stop()
end

function ServantAvatarViewModule:RestartTimer()
	self.staticVar.hidenTimer:Stop()

	self.staticVar.hidenTimer = Timer.New(function()
		self:OnHidenTimerReached()
	end, 2, -1)

	self.staticVar.hidenTimer:Start()
end

return ServantAvatarViewModule

local FishingInfoPopView = class("FishingInfoPopView", ReduxView)

function FishingInfoPopView:UIName()
	return "UI/Fishing/FishingInfoPopUI"
end

function FishingInfoPopView:UIParent()
	return manager.ui.uiPop.transform
end

function FishingInfoPopView:OnCtor()
	return
end

function FishingInfoPopView:Init()
	self:InitUI()
	self:AddUIListener()
end

function FishingInfoPopView:InitUI()
	self:BindCfgUI()

	self.bgController_ = ControllerUtil.GetController(self.talkBgTransform_, "talkbg")
	self.unlockController_ = ControllerUtil.GetController(self.gameObject_.transform, "unlock")
	self.rareController_ = ControllerUtil.GetController(self.gameObject_.transform, "rare")
end

function FishingInfoPopView:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
end

function FishingInfoPopView:AddEventListeners()
	return
end

function FishingInfoPopView:OnTop()
	self:UpdateBar()
end

function FishingInfoPopView:UpdateBar()
	return
end

function FishingInfoPopView:OnEnter()
	self:AddEventListeners()

	self.rect_ = self.params_.rect
	self.id_ = self.params_.id
	self.cfg_ = RareFishCfg[self.params_.id]

	self:UpdateView()
end

function FishingInfoPopView:UpdateView()
	local var_12_0 = FishingData:GetFish(self.id_)
	local var_12_1 = 0

	if var_12_0 ~= nil then
		self.unlockController_:SetSelectedState("true")

		var_12_1 = var_12_0.len
	else
		self.unlockController_:SetSelectedState("false")
	end

	self.nameLabel_.text = GetI18NText(self.cfg_.name)
	self.descLabel_.text = GetI18NText(self.cfg_.desc)

	self.rareController_:SetSelectedState(FishingData:GetRareLabel(self.cfg_.rare))

	self.tipLabel_.text = GetI18NText(self.cfg_.talk)
	self.sizeDescLabel_.text = string.format("%d-%dcm", self.cfg_.size[1], self.cfg_.size[2])
	self.maxSizeLabel_.text = string.format("%dcm", var_12_1)
	self.container_.transform.localPosition.x = self.params_.rect.x * (1080 / Screen.height) + self.params_.rect.width * (1080 / Screen.height) + 5

	self.bgController_:SetSelectedState("leftBg")

	if self.container_.transform.localPosition.x + self.container_.transform.rect.width > Screen.width * (1080 / Screen.height) then
		self.container_.transform.localPosition.x = self.params_.rect.x * (1080 / Screen.height) - self.container_.transform.rect.width - 5

		self.bgController_:SetSelectedState("rightBg")
	end

	self.container_.transform.localPosition.y = self.params_.rect.y * (1080 / Screen.height) - self.params_.rect.height * (1080 / Screen.height)
	self.container_.transform.localPosition = self.container_.transform.localPosition

	CustomLog.Log(string.format("%s", tostring(self.params_.rect)))
end

function FishingInfoPopView:OnExit()
	self:RemoveAllEventListener()
end

function FishingInfoPopView:OnMainHomeViewTop()
	return
end

function FishingInfoPopView:Dispose()
	FishingInfoPopView.super.Dispose(self)
end

return FishingInfoPopView

local KagutsuchiWorkEntrustHeroItem = class("KagutsuchiWorkEntrustHeroItem", ReduxView)

function KagutsuchiWorkEntrustHeroItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
	self:AddUIListener()
end

function KagutsuchiWorkEntrustHeroItem:InitUI()
	self:BindCfgUI()

	self.selController = ControllerUtil.GetController(self.transform_, "state")
end

function KagutsuchiWorkEntrustHeroItem:AddUIListener()
	self:AddBtnListener(self.heroItemBtn_, nil, function()
		if self.onClickHandler_ then
			self.onClickHandler_(self.heroID, self.heroData)
		end
	end)
end

function KagutsuchiWorkEntrustHeroItem:SetClickHandler(arg_5_1)
	if arg_5_1 then
		self.onClickHandler_ = arg_5_1
	end
end

function KagutsuchiWorkEntrustHeroItem:SetHeroData(arg_6_1)
	self.heroID = arg_6_1
end

function KagutsuchiWorkEntrustHeroItem:GetHeroData()
	return HeroData:GetHeroData(self.heroID)
end

function KagutsuchiWorkEntrustHeroItem:TrySetSelected(arg_8_1)
	if self:IsLocked() or self:IsLevelLimited() or self:IsEntrusted() then
		return false
	end

	self.selected_ = arg_8_1

	return self.selected_
end

function KagutsuchiWorkEntrustHeroItem:RefreshUI()
	self.heroIcon_.sprite = HeroTools.GetHeadSprite(self.heroID)
	self.raceIcon_.sprite = HeroTools.GetHeroRaceIcon(self.heroID)
	self.levelText_.text = self:GetHeroData().level
	self.imageLv_.sprite = getSprite("Atlas/Common", "star_" .. HeroCfg[self.heroID].rare)

	if self:IsLocked() then
		self.selController:SetSelectedState("absence")
	elseif self:IsLevelLimited() then
		self.selController:SetSelectedState("levelLimited")
	elseif self:IsEntrusted() then
		self.selController:SetSelectedState("entrusted")
	elseif self.selected_ then
		self.selController:SetSelectedState("selected")
	else
		self.selController:SetSelectedState("unselected")
	end
end

function KagutsuchiWorkEntrustHeroItem:IsLocked()
	return self:GetHeroData().unlock == 0
end

function KagutsuchiWorkEntrustHeroItem:IsLevelLimited()
	return self:GetHeroData().level < KagutsuchiWorkData:GetMinEntrustHeroLevel()
end

function KagutsuchiWorkEntrustHeroItem:IsEntrusted()
	return KagutsuchiWorkData:IsEntrusted(self.heroID)
end

function KagutsuchiWorkEntrustHeroItem:Dispose()
	KagutsuchiWorkEntrustHeroItem.super.Dispose(self)
end

return KagutsuchiWorkEntrustHeroItem

local HodurChallengeSelectAffixItem = class("HodurChallengeSelectAffixItem", ReduxView)

function HodurChallengeSelectAffixItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
	self:AddUIListener()
end

function HodurChallengeSelectAffixItem:InitUI()
	self:BindCfgUI()

	self.selectController_ = self.mainControllerEx_:GetController("default0")
end

function HodurChallengeSelectAffixItem:SetData(arg_3_1)
	self.affixID_ = arg_3_1

	self:SetSelected(false)
	self:RefreshUI()
end

function HodurChallengeSelectAffixItem:AddUIListener()
	self:AddBtnListener(self.affixBtn_, nil, function()
		if self.onClickHandler_ then
			self.onClickHandler_(self.affixID_)
		end
	end)
end

function HodurChallengeSelectAffixItem:SetClickHandler(arg_6_1)
	self.onClickHandler_ = arg_6_1
end

function HodurChallengeSelectAffixItem:SetSelected(arg_7_1)
	self.selectController_:SetSelectedState(arg_7_1 and "select" or "Default")

	if self.selected_ == arg_7_1 then
		return
	end

	self.selected_ = arg_7_1

	manager.notify:CallUpdateFunc(HODUR_SELECT_AFFIX, arg_7_1)
	self:RefreshUI()
end

function HodurChallengeSelectAffixItem:RefreshUI()
	self.affixImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Activity_Hodur/Debufficon/" .. self.affixID_)
	self.nameText_.text = AffixTypeCfg[self.affixID_].name
end

function HodurChallengeSelectAffixItem:SetActive(arg_9_1)
	SetActive(self.gameObject_, arg_9_1)
end

function HodurChallengeSelectAffixItem:Dispose()
	HodurChallengeSelectAffixItem.super.Dispose(self)
end

return HodurChallengeSelectAffixItem

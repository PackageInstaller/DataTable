local RogueTeamItemInfoSettingView = class("RogueTeamItemInfoSettingView", ReduxView)

function RogueTeamItemInfoSettingView:SetActive(arg_1_1)
	if self.gameObject_ then
		SetActive(self.gameObject_, arg_1_1)
	end
end

function RogueTeamItemInfoSettingView:Ctor(arg_2_1, arg_2_2, arg_2_3)
	self.hander_ = arg_2_1
	self.transform_ = arg_2_2.transform
	self.gameObject_ = arg_2_2
	self.stageData_ = arg_2_3

	self:Init()

	self.selectType_ = ChallengeRogueTeamConst.ITEM_TYPE.TREASURE

	self.btnController_:SetSelectedState("treasure")
	self:RefreshUI()
end

function RogueTeamItemInfoSettingView:Init()
	self:InitUI()
	self:AddUIListener()
end

function RogueTeamItemInfoSettingView:InitUI()
	self:BindCfgUI()

	self.treasureView_ = RogueTeamItemInfoSettingTreasureView.New(self.treasureGo_)
	self.relicView_ = RogueTeamItemInfoSettingRelicView.New(self.relicGo_)
	self.optionalAffixView_ = RogueTeamItemInfoSettingOptionalAffixView.New(self.optionalAffixGo_)
	self.btnController_ = self.btnControllerEx_:GetController("tab")
end

function RogueTeamItemInfoSettingView:AddUIListener()
	self:AddBtnListener(self.treasureBtn_, nil, function()
		if self.selectType_ == ChallengeRogueTeamConst.ITEM_TYPE.TREASURE then
			return
		end

		self.selectType_ = ChallengeRogueTeamConst.ITEM_TYPE.TREASURE

		self.btnController_:SetSelectedState("treasure")
		self:RefreshUI()
	end)
	self:AddBtnListener(self.relicBtn_, nil, function()
		if self.selectType_ == ChallengeRogueTeamConst.ITEM_TYPE.RELIC then
			return
		end

		self.selectType_ = ChallengeRogueTeamConst.ITEM_TYPE.RELIC

		self.btnController_:SetSelectedState("relic")
		self:RefreshUI()
	end)
	self:AddBtnListener(self.optionalAffixBtn_, nil, function()
		if self.selectType_ == ChallengeRogueTeamConst.ITEM_TYPE.AFFIX then
			return
		end

		self.selectType_ = ChallengeRogueTeamConst.ITEM_TYPE.AFFIX

		self.btnController_:SetSelectedState("affix")
		self:RefreshUI()
	end)
end

function RogueTeamItemInfoSettingView:RefreshUI()
	if self.selectType_ == ChallengeRogueTeamConst.ITEM_TYPE.TREASURE then
		self.treasureView_:RefreshUI()
	elseif self.selectType_ == ChallengeRogueTeamConst.ITEM_TYPE.RELIC then
		self.relicView_:RefreshUI()
	elseif self.selectType_ == ChallengeRogueTeamConst.ITEM_TYPE.AFFIX then
		self.optionalAffixView_:RefreshUI()
	end
end

function RogueTeamItemInfoSettingView:Dispose()
	self.treasureView_:Dispose()

	self.treasureView_ = nil

	self.relicView_:Dispose()

	self.relicView_ = nil

	self.optionalAffixView_:Dispose()

	self.optionalAffixView_ = nil

	RogueTeamItemInfoSettingView.super.Dispose(self)

	self.transform_ = nil
	self.gameObject_ = nil
end

return RogueTeamItemInfoSettingView

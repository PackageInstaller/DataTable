local CoreVerificationChallengeTeamInfoItem = class("CoreVerificationChallengeTeamInfoItem", ReduxView)

function CoreVerificationChallengeTeamInfoItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()

	self.heroHeadItem_ = {}
end

function CoreVerificationChallengeTeamInfoItem:Init()
	self:InitUI()
end

function CoreVerificationChallengeTeamInfoItem:InitUI()
	self:BindCfgUI()

	self.tabController_ = self.controller:GetController("state01")
end

function CoreVerificationChallengeTeamInfoItem:AddUIListener()
	self:AddBtnListener(self.mainBtn_, nil, function()
		return
	end)
end

function CoreVerificationChallengeTeamInfoItem:SetData(arg_6_1, arg_6_2)
	self.heroId = arg_6_1
	self.icon.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.HeroIcon.path .. arg_6_1)
	self.name.text = GetI18NText(HeroCfg[arg_6_1].name)
	self.type.text = CharactorParamCfg[self.heroId].RangeType == 0 and GetTips("RANGETYPE_CLOSE") or GetTips("RANGETYPE_LONG")

	self.tabController_:SetSelectedIndex(arg_6_2 == 1 and 0 or 1)
end

function CoreVerificationChallengeTeamInfoItem:Dispose()
	CoreVerificationChallengeTeamInfoItem.super.Dispose(self)
end

return CoreVerificationChallengeTeamInfoItem

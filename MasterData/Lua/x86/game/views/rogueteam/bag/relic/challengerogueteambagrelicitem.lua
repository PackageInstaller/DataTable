local ChallengeRogueTeamBagRelicItem = class("ChallengeRogueTeamBagRelicItem", ReduxView)

function ChallengeRogueTeamBagRelicItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.selectController_ = self.controller_:GetController("select")
end

function ChallengeRogueTeamBagRelicItem:Dispose()
	ChallengeRogueTeamBagRelicItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

function ChallengeRogueTeamBagRelicItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		manager.notify:Invoke(CHALLENGER_ROGUE_TEAM_BAG_RELIC_SELECTED, self.id_)
	end)
end

function ChallengeRogueTeamBagRelicItem:SetData(arg_5_1)
	self.id_ = arg_5_1
	self.icon_.sprite = pureGetSpriteWithoutAtlas(ChallengeRogueTeamTools.GetItemIcon(arg_5_1))
	self.name_.text = RogueTeamItemCfg[arg_5_1].name

	self:Show(true)
	self.selectController_:SetSelectedState(tostring(self.id_ == self.selectID_))
end

function ChallengeRogueTeamBagRelicItem:SetSelectID(arg_6_1)
	self.selectID_ = arg_6_1

	self.selectController_:SetSelectedState(tostring(self.id_ == arg_6_1))
end

function ChallengeRogueTeamBagRelicItem:Show(arg_7_1)
	SetActive(self.gameObject_, arg_7_1)
end

return ChallengeRogueTeamBagRelicItem

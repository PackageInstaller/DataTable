local RogueCardGameChallengeSettleView = class("RogueCardGameChallengeSettleView", ReduxView)

function RogueCardGameChallengeSettleView:UIName()
	return "Widget/System/Activity_JokerCard/Activity_JokerCard_ChallengeSettle"
end

function RogueCardGameChallengeSettleView:UIParent()
	return manager.ui.uiPop.transform
end

function RogueCardGameChallengeSettleView:Init()
	self:BindCfgUI()
	self:AddUIListener()
end

function RogueCardGameChallengeSettleView:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.okBtn_, nil, function()
		self:Back()
	end)
end

function RogueCardGameChallengeSettleView:OnEnter()
	self.deck = self.params_.deck
	self.diff = self.params_.diff
	self.settle_data = RogueCardGameData:GetSettleData()

	self:Refresh()

	if self.params_.enterAction then
		self.params_.enterAction()
	end
end

function RogueCardGameChallengeSettleView:Refresh()
	self.topTitleText_.text = GetTips("ROGUE_CARD_COMMUNICATION_LOCK_TITLE")
	self.titleText_.text = GetTips("ROGUE_CARD_LOSE_TITLE_EX")
	self.diffText_.text = System.String.Format(GetTips("ROGUE_CARD_DIFFICULT"), self.diff)
	self.cardIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_JokerCard/itembg/rogue_card_back_" .. self.diff)
	self.multText_.text = System.String.Format(GetTips("ROGUE_CARD_CALCULATION_POINT_RANK"), RogueCardDeckCfg[self.deck].score_rate * RogueCardDifficultyCfg[self.diff].score_rate / 100)
	self.scoreText_.text = self.settle_data.score
	self.cardTypeText_.text = self.settle_data.most_hand_type > 0 and GetI18NText(RogueCardHandTypeCfg[self.settle_data.most_hand_type].name) .. "(" .. self.settle_data.hand_type_use_num[#self.settle_data.hand_type_use_num - self.settle_data.most_hand_type + 1] .. ")" or 0
	self.roundText_.text = self.settle_data.round
	self.roundScoreText_.text = self.settle_data.max_score
	self.useCardText_.text = self.settle_data.use_card_num
	self.depCardText_.text = self.settle_data.discard_num
	self.blackChangeText_.text = self.settle_data.black_wu_chang_num
	self.whiteChangeText_.text = self.settle_data.white_wu_chang_num
	self.goldText_.text = self.settle_data.gain_gold_num
end

function RogueCardGameChallengeSettleView:OnExit()
	return
end

function RogueCardGameChallengeSettleView:Dispose()
	RogueCardGameChallengeSettleView.super.Dispose(self)
end

return RogueCardGameChallengeSettleView

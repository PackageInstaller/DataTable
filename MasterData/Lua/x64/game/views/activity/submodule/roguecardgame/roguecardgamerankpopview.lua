local RogueCardGameRankPopView = class("RogueCardGameRankPopView", ReduxView)

function RogueCardGameRankPopView:UIName()
	return "Widget/System/Activity_JokerCard/Activity_JokerCard_RankPopUI"
end

function RogueCardGameRankPopView:UIParent()
	return manager.ui.uiPop.transform
end

function RogueCardGameRankPopView:Init()
	self:BindCfgUI()
	self:AddUIListener()
end

function RogueCardGameRankPopView:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
end

function RogueCardGameRankPopView:OnEnter()
	self.list = self.params_.dataList or {}
	self.extraInfo = self.list.extraInfo

	self:Refresh()
end

function RogueCardGameRankPopView:Refresh()
	self.diffText_.text = self.extraInfo[11]
	self.cardIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_JokerCard/itembg/rogue_card_back_" .. self.extraInfo[10])
	self.multText_.text = System.String.Format(GetTips("ROGUE_CARD_CALCULATION_POINT_RANK"), self.extraInfo[9] / 100)
	self.scoreText_.text = self.list.score
	self.cardTypeText_.text = GetI18NText(RogueCardHandTypeCfg[self.extraInfo[1]].name) .. "(" .. self.extraInfo[12] .. ")"
	self.roundText_.text = self.extraInfo[2]
	self.roundScoreText_.text = self.extraInfo[3]
	self.useCardText_.text = self.extraInfo[4]
	self.depCardText_.text = self.extraInfo[5]
	self.blackChangeText_.text = self.extraInfo[6]
	self.whiteChangeText_.text = self.extraInfo[7]
	self.goldText_.text = self.extraInfo[8]
end

function RogueCardGameRankPopView:OnExit()
	return
end

function RogueCardGameRankPopView:Dispose()
	RogueCardGameRankPopView.super.Dispose(self)
end

return RogueCardGameRankPopView

local RogueCardGameTwicePopView = class("RogueCardGameTwicePopView", ReduxView)

function RogueCardGameTwicePopView:UIName()
	return "Widget/System/Activity_JokerCard/Activity_JokerCard_TwicePopUI"
end

function RogueCardGameTwicePopView:UIParent()
	return manager.ui.uiPop.transform
end

function RogueCardGameTwicePopView:Init()
	self:InitUI()
	self:AddUIListener()
end

function RogueCardGameTwicePopView:InitUI()
	self:BindCfgUI()

	self.tipsCon_ = self.controllerEx_:GetController("tips")
	self.singleCon_ = self.controllerEx_:GetController("single")
	self.typeCon_ = self.controllerEx_:GetController("type")
end

function RogueCardGameTwicePopView:AddUIListener()
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.okBtn_, nil, function()
		self:Back()

		if RogueCard.RogueCardGameMain.Instance:CheckShowPause() then
			RogueCardGameAction.InGameInterruptPost((RogueCardGameTools.GetCurPostingId()))
		else
			RogueCard.RogueCardGameMain.Instance:ConfirmGame()
		end
	end)
	self:AddBtnListener(self.cancelBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.interruptBtn_, nil, function()
		if RogueCardPostingCfg[RogueCardGameTools.GetCurPostingId()].type == 1 then
			RogueCardGameBridge.FinishRogueCardGame(function()
				OpenPageUntilLoaded("/rogueCardGameForumView", {
					isTips = true
				})
			end)
		else
			RogueCardGameBridge.FinishRogueCardGame(function()
				OpenPageUntilLoaded("/rogueCardGameChallengeSelectView")
			end)
		end
	end)
end

function RogueCardGameTwicePopView:OnEnter()
	self.tipContent_.text = GetTips("ROGUE_CARD_TERMINATE_INVESTIGATION")

	if RogueCardGameBridge.InGame() and RogueCard.RogueCardGameMain.Instance:CheckShowPause() then
		self.singleCon_:SetSelectedIndex(0)
	else
		self.singleCon_:SetSelectedIndex(1)
	end
end

function RogueCardGameTwicePopView:OnExit()
	self:RemoveAllEventListener()
end

function RogueCardGameTwicePopView:Dispose()
	self:RemoveAllEventListener()
	RogueCardGameTwicePopView.super.Dispose(self)
end

return RogueCardGameTwicePopView

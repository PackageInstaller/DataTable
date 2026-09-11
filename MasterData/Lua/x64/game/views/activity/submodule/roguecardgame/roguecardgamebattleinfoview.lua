local RogueCardGameBattleInfoView = class("RogueCardGameBattleInfoView", ReduxView)

function RogueCardGameBattleInfoView:UIName()
	return "Widget/System/Activity_JokerCard/Gameplay/Activity_JokerCard_battleInfoPopUI"
end

function RogueCardGameBattleInfoView:UIParent()
	return manager.ui.uiMain.transform
end

function RogueCardGameBattleInfoView:Init()
	self:InitUI()
	self:AddUIListener()
end

function RogueCardGameBattleInfoView:InitUI()
	self:BindCfgUI()
end

function RogueCardGameBattleInfoView:AddUIListener()
	self:AddBtnListener(self.backBtn_, nil, function()
		self:Back()
	end)
end

function RogueCardGameBattleInfoView:OnEnter()
	return
end

function RogueCardGameBattleInfoView:OnTop()
	manager.windowBar:HideBar()
end

function RogueCardGameBattleInfoView:OnExit()
	manager.windowBar:HideBar()
end

function RogueCardGameBattleInfoView:Dispose()
	RogueCardGameBattleInfoView.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return RogueCardGameBattleInfoView

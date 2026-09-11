local RogueCardGameDeckInfoView = class("RogueCardGameDeckInfoView", ReduxView)

function RogueCardGameDeckInfoView:UIName()
	return "Widget/System/Activity_JokerCard/Gameplay/Activity_JokerCard_CheckCardPopUI"
end

function RogueCardGameDeckInfoView:UIParent()
	return manager.ui.uiMain.transform
end

function RogueCardGameDeckInfoView:Init()
	self:InitUI()
	self:AddUIListener()
end

function RogueCardGameDeckInfoView:InitUI()
	self:BindCfgUI()
end

function RogueCardGameDeckInfoView:AddUIListener()
	self:AddBtnListener(self.backBtn_, nil, function()
		self:Back()
	end)
end

function RogueCardGameDeckInfoView:OnEnter()
	return
end

function RogueCardGameDeckInfoView:OnTop()
	manager.windowBar:HideBar()
end

function RogueCardGameDeckInfoView:OnExit()
	manager.windowBar:HideBar()
end

function RogueCardGameDeckInfoView:Dispose()
	RogueCardGameDeckInfoView.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return RogueCardGameDeckInfoView

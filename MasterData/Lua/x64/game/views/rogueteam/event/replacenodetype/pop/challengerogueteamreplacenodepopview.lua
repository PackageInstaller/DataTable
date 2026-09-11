local ChallengeRogueTeamReplaceNodePopView = class("ChallengeRogueTeamReplaceNodePopView", ReduxView)

function ChallengeRogueTeamReplaceNodePopView:UIName()
	return "Widget/System/RogueTeam/RogueTeamReplaceNodePopUI"
end

function ChallengeRogueTeamReplaceNodePopView:UIParent()
	return manager.ui.uiMain.transform
end

function ChallengeRogueTeamReplaceNodePopView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.onSelectedTypeHandler_ = handler(self, self.OnSelectedType)
	self.uiList_ = LuaList.New(handler(self, self.IndexItem), self.uiListGo_, ChallengeRogueTeamReplaceNodePopItem)
end

function ChallengeRogueTeamReplaceNodePopView:OnEnter()
	self.nodeID_ = self.params_.selectNodeID

	manager.notify:RegistListener(CHALLENGE_ROGUE_TEAM_SELECTED_NODE_TYPE, self.onSelectedTypeHandler_)

	self.roomTypeList_ = RogueTeamRoomTypeCfg.get_id_list_by_can_replace[1]

	self.uiList_:StartScroll(#self.roomTypeList_)

	self.okBtn_.interactable = false
end

function ChallengeRogueTeamReplaceNodePopView:OnExit()
	manager.notify:RemoveListener(CHALLENGE_ROGUE_TEAM_SELECTED_NODE_TYPE, self.onSelectedTypeHandler_)

	self.selectID_ = nil
end

function ChallengeRogueTeamReplaceNodePopView:Dispose()
	self.onSelectedTypeHandler_ = nil

	self.uiList_:Dispose()

	self.uiList_ = nil

	ChallengeRogueTeamReplaceNodePopView.super.Dispose(self)
end

function ChallengeRogueTeamReplaceNodePopView:AddListeners()
	self:AddBtnListener(self.okBtn_, nil, function()
		ChallengeRogueTeamAction.CloseNodeReplaceWindow(self.nodeID_, self.selectID_, function()
			self:Back(2)
		end)
	end)
end

function ChallengeRogueTeamReplaceNodePopView:IndexItem(arg_10_1, arg_10_2)
	arg_10_2:SetData(self.roomTypeList_[arg_10_1], self.selectID_)
end

function ChallengeRogueTeamReplaceNodePopView:OnSelectedType(arg_11_1)
	self.selectID_ = arg_11_1
	self.okBtn_.interactable = true

	self.uiList_:Refresh()
end

return ChallengeRogueTeamReplaceNodePopView

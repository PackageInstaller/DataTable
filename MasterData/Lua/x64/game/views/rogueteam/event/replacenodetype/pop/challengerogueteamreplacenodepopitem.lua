local ChallengeRogueTeamReplaceNodePopItem = class("ChallengeRogueTeamReplaceNodePopItem", ReduxView)

function ChallengeRogueTeamReplaceNodePopItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.selectController_ = self.controllerEx_:GetController("selected")
end

function ChallengeRogueTeamReplaceNodePopItem:Dispose()
	ChallengeRogueTeamReplaceNodePopItem.super.Dispose(self)
end

function ChallengeRogueTeamReplaceNodePopItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if self.selectedID_ == self.id_ then
			return
		end

		manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_SELECTED_NODE_TYPE, self.id_)
	end)
end

function ChallengeRogueTeamReplaceNodePopItem:SetData(arg_5_1, arg_5_2)
	self.id_ = arg_5_1
	self.selectedID_ = arg_5_2

	self.selectController_:SetSelectedState(tostring(arg_5_2 == arg_5_1))

	self.nameText_.text = RogueTeamRoomTypeCfg[arg_5_1].name
end

return ChallengeRogueTeamReplaceNodePopItem

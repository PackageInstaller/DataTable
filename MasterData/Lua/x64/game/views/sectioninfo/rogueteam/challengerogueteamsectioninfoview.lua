local ChallengeRogueTeamSectionInfoView = class("ChallengeRogueTeamSectionInfoView", ReduxView)

function ChallengeRogueTeamSectionInfoView:UIName()
	return "Widget/System/Activity_Roulike/RoulikeNodeInfoUI"
end

function ChallengeRogueTeamSectionInfoView:UIParent()
	return manager.ui.uiMain.transform
end

function ChallengeRogueTeamSectionInfoView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.rogueTeamSureBtnView_ = ChallengeRogueTeamButton.New(self.sureGo_, handler(self, self.OnClickBtn))
	self.stateController_ = self.controllerEx_:GetController("state")
end

function ChallengeRogueTeamSectionInfoView:OnEnter()
	self.rogueTeamSureBtnView_:RefreshBtnState(ChallengeRogueTeamButton.ENABLE_CLICK)
	self:RefreshUI()
end

function ChallengeRogueTeamSectionInfoView:OnUpdate()
	self:RefreshUI()
end

function ChallengeRogueTeamSectionInfoView:OnExit()
	self:StopBuffTimer()
end

function ChallengeRogueTeamSectionInfoView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.rogueTeamMapPreviewBtnBar:ShowState(ChallengeRogueTeamConst.MAP_BTN_WINDOW.MAIN)
end

function ChallengeRogueTeamSectionInfoView:Dispose()
	self.rogueTeamSureBtnView_:Dispose()

	self.rogueTeamSureBtnView_ = nil

	ChallengeRogueTeamSectionInfoView.super.Dispose(self)
end

function ChallengeRogueTeamSectionInfoView:AddListeners()
	return
end

function ChallengeRogueTeamSectionInfoView:RefreshUI()
	local var_10_0 = ChallengeRogueTeamData:PathGetNodeData(self.params_.nodeID)

	self.nameText_.text = RogueTeamRoomTypeCfg[var_10_0.nodeType].name
	self.descText_.text = RogueTeamRoomTypeCfg[var_10_0.nodeType].desc

	self.stateController_:SetSelectedState("nomal")

	if ChallengeRogueTeamTools.IsBattleNode(var_10_0.nodeType) then
		self:RefreshBattleEffectPanel()
	elseif var_10_0.nodeType == ChallengeRogueTeamConst.NODE_TYPE.EVENT then
		self:RefreshEventEffectPanel()
	elseif var_10_0.nodeType == ChallengeRogueTeamConst.NODE_TYPE.SHOP then
		self:RefreshShopEffectPanel()
	end
end

function ChallengeRogueTeamSectionInfoView:OnClickBtn()
	local var_11_0 = ChallengeRogueTeamData:PathGetNodeData(self.params_.nodeID)

	if ChallengeRogueTeamTools.IsBattleNode(var_11_0.nodeType) then
		if var_11_0.param ~= 0 and var_11_0.param ~= nil then
			self:GoToNextWindow()
		else
			local var_11_1 = ChallengeRogueTeamData:AttributeGetValue(ChallengeRogueTeamConst.ATTRIBUTE_ENUM.BATTLE_EXEMPT)

			ChallengeRogueTeamAction.SelectedNode(self.params_.nodeID, function()
				if var_11_1 > 0 then
					self:AddBuffTimer(var_11_1)
				else
					self:GoToNextWindow()
				end
			end)
		end
	elseif var_11_0.nodeType == ChallengeRogueTeamConst.NODE_TYPE.REST then
		self:Back()
		ChallengeRogueTeamAction.SelectedNode(self.params_.nodeID)
	else
		self:Back()
		ChallengeRogueTeamAction.SelectedNode(self.params_.nodeID)
	end
end

function ChallengeRogueTeamSectionInfoView:GoToNextWindow()
	ChallengeRogueTeamAction.GotoRogueTeamReserve(self.params_.nodeID, ChallengeRogueTeamData:PathGetNodeData(self.params_.nodeID).param)
end

function ChallengeRogueTeamSectionInfoView:RefreshBattleEffectPanel()
	local var_14_0 = ChallengeRogueTeamData:AttributeGetValue(ChallengeRogueTeamConst.ATTRIBUTE_ENUM.BATTLE_EXEMPT)

	if var_14_0 > 0 then
		self.stateController_:SetSelectedState("skill")

		self.buffText_.text = string.format(GetTips("ROGUE_TEAM_NODE_BATTLE_EFFECT"), var_14_0)
		self.buffIcon_.sprite = pureGetSpriteWithoutAtlas(RogueTeamSkillTreeCfg[ChallengeRogueTeamTools.GetBattleEffectTreeID()].icon)
	end
end

function ChallengeRogueTeamSectionInfoView:RefreshShopEffectPanel()
	if ChallengeRogueTeamData:AttributeGetValue(ChallengeRogueTeamConst.ATTRIBUTE_ENUM.SHOP_DISCOUNT) > 0 then
		self.stateController_:SetSelectedState("event")

		self.eventText_.text = string.format(GetTips("ROGUE_TEAM_NODE_SHOP_EFFECT"))
		self.eventIcon_.sprite = pureGetSpriteWithoutAtlas(ChallengeRogueTeamTools.GetItemIcon((ChallengeRogueTeamTools.GetShopDiscountMechanismID())))
	end
end

function ChallengeRogueTeamSectionInfoView:RefreshEventEffectPanel()
	if ChallengeRogueTeamData:AttributeGetValue(ChallengeRogueTeamConst.ATTRIBUTE_ENUM.EVENT_ONECE_MORE) > 0 then
		self.stateController_:SetSelectedState("event")

		self.eventText_.text = string.format(GetTips("ROGUE_TEAM_NODE_EVENT_EFFECT"))
		self.eventIcon_.sprite = pureGetSpriteWithoutAtlas(ChallengeRogueTeamTools.GetItemIcon((ChallengeRogueTeamTools.GetEventMoreMechanismID())))
	end
end

function ChallengeRogueTeamSectionInfoView:AddBuffTimer(arg_17_1)
	self:StopBuffTimer()
	manager.ui:UIEventEnabled(false)

	self.buffText_.text = string.format(GetTips("ROGUE_TEAM_NODE_BATTLE_EFFECT"), arg_17_1 - 1)

	self.buffAnimator_:Play("UI_bgSkill_cx", -1, 0)
	self.rogueTeamSureBtnView_:RefreshBtnState(ChallengeRogueTeamButton.FINISH, ChallengeRogueTeamButton.BUTTON_TEXT.CLEAN_MISSION)

	self.buffTimer_ = Timer.New(function()
		self:StopBuffTimer()
		self:Back()
	end, 1.5, 1)

	self.buffTimer_:Start()
end

function ChallengeRogueTeamSectionInfoView:StopBuffTimer()
	if self.buffTime_ then
		manager.ui:UIEventEnabled(true)
		self.buffTimer_:Stop()

		self.buffTimer_ = nil
	end
end

return ChallengeRogueTeamSectionInfoView

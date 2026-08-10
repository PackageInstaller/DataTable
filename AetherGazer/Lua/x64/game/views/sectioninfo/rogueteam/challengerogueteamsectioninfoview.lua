local var_0_0 = class("ChallengeRogueTeamSectionInfoView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Roulike/RoulikeNodeInfoUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.rogueTeamSureBtnView_ = ChallengeRogueTeamButton.New(arg_3_0.sureGo_, handler(arg_3_0, arg_3_0.OnClickBtn))
	arg_3_0.stateController_ = arg_3_0.controllerEx_:GetController("state")
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0.rogueTeamSureBtnView_:RefreshBtnState(ChallengeRogueTeamButton.ENABLE_CLICK)
	arg_4_0:RefreshUI()
end

function var_0_0.OnUpdate(arg_5_0)
	arg_5_0:RefreshUI()
end

function var_0_0.OnExit(arg_6_0)
	arg_6_0:StopBuffTimer()
end

function var_0_0.OnTop(arg_7_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.rogueTeamMapPreviewBtnBar:ShowState(ChallengeRogueTeamConst.MAP_BTN_WINDOW.MAIN)
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0.rogueTeamSureBtnView_:Dispose()

	arg_8_0.rogueTeamSureBtnView_ = nil

	var_0_0.super.Dispose(arg_8_0)
end

function var_0_0.AddListeners(arg_9_0)
	return
end

function var_0_0.RefreshUI(arg_10_0)
	local var_10_0 = arg_10_0.params_.nodeID
	local var_10_1 = ChallengeRogueTeamData:PathGetNodeData(var_10_0)
	local var_10_2 = var_10_1.nodeType
	local var_10_3 = RogueTeamRoomTypeCfg[var_10_2]

	arg_10_0.nameText_.text = var_10_3.name
	arg_10_0.descText_.text = var_10_3.desc

	arg_10_0.stateController_:SetSelectedState("nomal")

	if ChallengeRogueTeamTools.IsBattleNode(var_10_1.nodeType) then
		arg_10_0:RefreshBattleEffectPanel()
	elseif var_10_1.nodeType == ChallengeRogueTeamConst.NODE_TYPE.EVENT then
		arg_10_0:RefreshEventEffectPanel()
	elseif var_10_1.nodeType == ChallengeRogueTeamConst.NODE_TYPE.SHOP then
		arg_10_0:RefreshShopEffectPanel()
	end
end

function var_0_0.OnClickBtn(arg_11_0)
	local var_11_0 = arg_11_0.params_.nodeID
	local var_11_1 = ChallengeRogueTeamData:PathGetNodeData(var_11_0)

	if ChallengeRogueTeamTools.IsBattleNode(var_11_1.nodeType) then
		if var_11_1.param ~= 0 and var_11_1.param ~= nil then
			arg_11_0:GoToNextWindow()
		else
			local var_11_2 = ChallengeRogueTeamData:AttributeGetValue(ChallengeRogueTeamConst.ATTRIBUTE_ENUM.BATTLE_EXEMPT)

			ChallengeRogueTeamAction.SelectedNode(var_11_0, function()
				if var_11_2 > 0 then
					arg_11_0:AddBuffTimer(var_11_2)
				else
					arg_11_0:GoToNextWindow()
				end
			end)
		end
	elseif var_11_1.nodeType == ChallengeRogueTeamConst.NODE_TYPE.REST then
		arg_11_0:Back()
		ChallengeRogueTeamAction.SelectedNode(var_11_0)
	else
		arg_11_0:Back()
		ChallengeRogueTeamAction.SelectedNode(var_11_0)
	end
end

function var_0_0.GoToNextWindow(arg_13_0)
	local var_13_0 = ChallengeRogueTeamData:PathGetNodeData(arg_13_0.params_.nodeID)

	ChallengeRogueTeamAction.GotoRogueTeamReserve(arg_13_0.params_.nodeID, var_13_0.param)
end

function var_0_0.RefreshBattleEffectPanel(arg_14_0)
	local var_14_0 = ChallengeRogueTeamData:AttributeGetValue(ChallengeRogueTeamConst.ATTRIBUTE_ENUM.BATTLE_EXEMPT)

	if var_14_0 > 0 then
		arg_14_0.stateController_:SetSelectedState("skill")

		arg_14_0.buffText_.text = string.format(GetTips("ROGUE_TEAM_NODE_BATTLE_EFFECT"), var_14_0)

		local var_14_1 = ChallengeRogueTeamTools.GetBattleEffectTreeID()
		local var_14_2 = RogueTeamSkillTreeCfg[var_14_1]

		arg_14_0.buffIcon_.sprite = pureGetSpriteWithoutAtlas(var_14_2.icon)
	end
end

function var_0_0.RefreshShopEffectPanel(arg_15_0)
	if ChallengeRogueTeamData:AttributeGetValue(ChallengeRogueTeamConst.ATTRIBUTE_ENUM.SHOP_DISCOUNT) > 0 then
		arg_15_0.stateController_:SetSelectedState("event")

		arg_15_0.eventText_.text = string.format(GetTips("ROGUE_TEAM_NODE_SHOP_EFFECT"))

		local var_15_0 = ChallengeRogueTeamTools.GetShopDiscountMechanismID()

		arg_15_0.eventIcon_.sprite = pureGetSpriteWithoutAtlas(ChallengeRogueTeamTools.GetItemIcon(var_15_0))
	end
end

function var_0_0.RefreshEventEffectPanel(arg_16_0)
	if ChallengeRogueTeamData:AttributeGetValue(ChallengeRogueTeamConst.ATTRIBUTE_ENUM.EVENT_ONECE_MORE) > 0 then
		arg_16_0.stateController_:SetSelectedState("event")

		arg_16_0.eventText_.text = string.format(GetTips("ROGUE_TEAM_NODE_EVENT_EFFECT"))

		local var_16_0 = ChallengeRogueTeamTools.GetEventMoreMechanismID()

		arg_16_0.eventIcon_.sprite = pureGetSpriteWithoutAtlas(ChallengeRogueTeamTools.GetItemIcon(var_16_0))
	end
end

function var_0_0.AddBuffTimer(arg_17_0, arg_17_1)
	arg_17_0:StopBuffTimer()
	manager.ui:UIEventEnabled(false)

	arg_17_0.buffText_.text = string.format(GetTips("ROGUE_TEAM_NODE_BATTLE_EFFECT"), arg_17_1 - 1)

	arg_17_0.buffAnimator_:Play("UI_bgSkill_cx", -1, 0)
	arg_17_0.rogueTeamSureBtnView_:RefreshBtnState(ChallengeRogueTeamButton.FINISH, ChallengeRogueTeamButton.BUTTON_TEXT.CLEAN_MISSION)

	arg_17_0.buffTimer_ = Timer.New(function()
		arg_17_0:StopBuffTimer()
		arg_17_0:Back()
	end, 1.5, 1)

	arg_17_0.buffTimer_:Start()
end

function var_0_0.StopBuffTimer(arg_19_0)
	if arg_19_0.buffTime_ then
		manager.ui:UIEventEnabled(true)
		arg_19_0.buffTimer_:Stop()

		arg_19_0.buffTimer_ = nil
	end
end

return var_0_0

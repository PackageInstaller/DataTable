local var_0_0 = class("ChallengeRogueTeamTreasureSelectView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Roulike/RoulikeSelectPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.treasureItemList_ = {}
	arg_3_0.selectTreasureHandler_ = handler(arg_3_0, arg_3_0.OnSelectTreasure)
	arg_3_0.updateOperateHandler_ = handler(arg_3_0, arg_3_0.UpdateOperate)
	arg_3_0.showResetPanelController_ = arg_3_0.controllerEx_:GetController("showResetPanel")
	arg_3_0.initRewardController_ = arg_3_0.controllerEx_:GetController("fristbg")
	arg_3_0.emptyController_ = arg_3_0.controllerEx_:GetController("empty")
	arg_3_0.colorController_ = arg_3_0.colorControllerEx_:GetController("color")
	arg_3_0.rogueTeamSureBtnView_ = ChallengeRogueTeamButton.New(arg_3_0.sureBtnGo_, handler(arg_3_0, arg_3_0.OnClickBtn))
end

function var_0_0.OnEnter(arg_4_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:SetAsLastSibling()
	ChallengeRogueTeamTools.RegistWindowBarClick()
	ChallengeRogueTeamTools.ShowBarList()
	arg_4_0:RefreshUI()
	manager.notify:RegistListener(CHALLENGE_ROGUE_TEAM_UPDATE_OPERATE_WINDOW, arg_4_0.updateOperateHandler_)
	manager.notify:RegistListener(CHALLENGE_ROGUE_TEAM_SELECTED_TREASURE, arg_4_0.selectTreasureHandler_)
end

function var_0_0.OnExit(arg_5_0)
	arg_5_0.selectedIndex_ = nil

	manager.notify:RemoveListener(CHALLENGE_ROGUE_TEAM_SELECTED_TREASURE, arg_5_0.selectTreasureHandler_)
	manager.notify:RemoveListener(CHALLENGE_ROGUE_TEAM_UPDATE_OPERATE_WINDOW, arg_5_0.updateOperateHandler_)

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.treasureItemList_) do
		iter_5_1:OnExit()
	end
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0.rogueTeamSureBtnView_:Dispose()

	arg_6_0.rogueTeamSureBtnView_ = nil

	var_0_0.super.Dispose(arg_6_0)

	arg_6_0.selectTreasureHandler_ = nil
	arg_6_0.updateOperateHandler_ = nil

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.treasureItemList_) do
		iter_6_1:Dispose()
	end

	arg_6_0.treasureItemList_ = nil
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.resetBtn_, nil, function()
		ChallengeRogueTeamAction.ResetOperateData(ChallengeRogueTeamConst.RESET_OPERATE_TYPE.TREASURE, function()
			arg_7_0:RefreshUI()
		end)
	end)
end

function var_0_0.OnClickBtn(arg_10_0)
	local var_10_0 = ChallengeRogueTeamData:GetUnOperateData().paramList
	local var_10_1 = 0
	local var_10_2 = ChallengeRogueTeamData:GetUnOperateData()

	if #var_10_0 <= 0 then
		ChallengeRogueTeamAction.SelectedEventValue(var_10_2.eventType, 0, function()
			ChallengeRogueTeamData:RemoveServerTriggerQueue()
			arg_10_0:Back()
			ChallengeRogueTeamAction.RemovePopWindowCnt()
		end)

		return
	end

	if arg_10_0.selectedIndex_ == nil then
		return
	end

	if #var_10_0 > 0 then
		var_10_1 = ChallengeRogueTeamData:GetUnOperateData().paramList[arg_10_0.selectedIndex_].index
	end

	ChallengeRogueTeamAction.SelectedEventValue(var_10_2.eventType, var_10_1, function()
		ChallengeRogueTeamData:RemoveServerTriggerQueue()
		arg_10_0:Back()
		ChallengeRogueTeamAction.RemovePopWindowCnt()
	end)
end

function var_0_0.OnSelectTreasure(arg_13_0, arg_13_1)
	arg_13_0.selectedIndex_ = arg_13_1

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.treasureItemList_) do
		iter_13_1:SelectTreasure(arg_13_1)
	end

	arg_13_0:RefreshSelectBtn()
end

function var_0_0.UpdateOperate(arg_14_0)
	arg_14_0:RefreshUI()

	for iter_14_0, iter_14_1 in ipairs(arg_14_0.treasureItemList_) do
		iter_14_1:PlayAnimator()
	end
end

function var_0_0.RefreshUI(arg_15_0)
	local var_15_0 = ChallengeRogueTeamData:GetUnOperateData()
	local var_15_1 = var_15_0.paramList

	if var_15_0.eventType == ChallengeRogueTeamConst.NODE_UNOPERATE_EVENT.MECHANISM then
		arg_15_0.itemPanelAnimator_:Play("UI_SelectItem", -1, 0)
		ChallengeRogueTeamTools.PlayAudio("mechanism_audio_id")
	else
		arg_15_0.itemPanelAnimator_:Play("UI_SelectItem", -1, 1)
		ChallengeRogueTeamTools.PlayAudio("item_select_audio_id")
	end

	arg_15_0.titleText_.text = ChallengeRogueTeamTools.GetSelectItemText(var_15_0)

	for iter_15_0, iter_15_1 in ipairs(var_15_1) do
		if arg_15_0.treasureItemList_[iter_15_0] == nil then
			arg_15_0.treasureItemList_[iter_15_0] = ChallengeRogueTeamTreasureItem.New(arg_15_0.parent_, iter_15_0)
		end

		iter_15_1.needShowCampFlag = true

		arg_15_0.treasureItemList_[iter_15_0]:SetData(iter_15_1)
	end

	for iter_15_2 = #arg_15_0.treasureItemList_, #var_15_1 + 1, -1 do
		arg_15_0.treasureItemList_[iter_15_2]:Dispose()

		arg_15_0.treasureItemList_[iter_15_2] = nil
	end

	if #var_15_1 > 0 then
		local var_15_2 = var_15_1[1].id
		local var_15_3 = RogueTeamItemCfg[var_15_2].type

		if var_15_3 == ChallengeRogueTeamConst.ITEM_TYPE.INIT_REWARD then
			arg_15_0.initRewardController_:SetSelectedState("friston")
		elseif var_15_3 == ChallengeRogueTeamConst.ITEM_TYPE.MECHANISM then
			arg_15_0.initRewardController_:SetSelectedState("themeEffect")
		else
			arg_15_0.initRewardController_:SetSelectedState("off")
		end
	else
		arg_15_0.titleText_.text = ""
	end

	arg_15_0.selectedIndex_ = nil

	arg_15_0:RefreshSelectBtn()
	arg_15_0:RefreshReset()
end

function var_0_0.RefreshSelectBtn(arg_16_0)
	if #ChallengeRogueTeamData:GetUnOperateData().paramList <= 0 then
		arg_16_0.rogueTeamSureBtnView_:RefreshBtnState(ChallengeRogueTeamButton.ENABLE_CLICK, ChallengeRogueTeamButton.BUTTON_TEXT.EXIT)

		return
	end

	if arg_16_0.selectedIndex_ ~= nil then
		arg_16_0.rogueTeamSureBtnView_:RefreshBtnState(ChallengeRogueTeamButton.ENABLE_CLICK)
	else
		arg_16_0.rogueTeamSureBtnView_:RefreshBtnState(ChallengeRogueTeamButton.DISENABLE_CLICK, ChallengeRogueTeamButton.BUTTON_TEXT.MAKE_CHOICE)
	end
end

function var_0_0.RefreshReset(arg_17_0)
	local var_17_0 = ChallengeRogueTeamData:GetUnOperateData()

	if #var_17_0.paramList <= 0 then
		arg_17_0.showResetPanelController_:SetSelectedState("false")
		arg_17_0.emptyController_:SetSelectedState("on")

		local var_17_1 = ChallengeRogueTeamTools.GetItemTypeByEventType(var_17_0.eventType)
		local var_17_2 = ChallengeRogueTeamTools.GetItemTypeText(var_17_1)

		arg_17_0.tipsText_.text = string.format(GetTips("ROGUE_TEAM_ITEM_UNAVAILABLE"), var_17_2)

		return
	else
		arg_17_0.emptyController_:SetSelectedState("off")
	end

	if var_17_0.eventType == ChallengeRogueTeamConst.NODE_UNOPERATE_EVENT.TREASURE and not ChallengeRogueTeamTools.IsGuideFloor() then
		arg_17_0.showResetPanelController_:SetSelectedState("true")

		local var_17_3 = ChallengeRogueTeamData:AttributeGetValue(ChallengeRogueTeamConst.ATTRIBUTE_ENUM.TREASURE_RESET_CNT)

		arg_17_0.resetBtn_.interactable = var_17_3 > 0
		arg_17_0.resetCntText_.text = string.format("x<color=#%s>%s</color>", var_17_3 > 0 and "FFFFFF" or "E97B74", var_17_3)
	else
		arg_17_0.showResetPanelController_:SetSelectedState("false")
	end
end

return var_0_0

local var_0_0 = class("ChallengeRogueTeamEventView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Roulike/Event/EventPanelUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.optionItemList_ = {}
	arg_3_0.tipsItemList_ = {}
	arg_3_0.onEventOptionSelectHandler_ = handler(arg_3_0, arg_3_0.OnEventOptionSelect)
	arg_3_0.checkUnfinishOperateHandler_ = handler(arg_3_0, arg_3_0.OnCheckUnfinishOperate)
	arg_3_0.onClickWindowBarItemHandler_ = handler(arg_3_0, arg_3_0.OnClickWindowBarItem)
	arg_3_0.rogueTeamSureBtnView_ = ChallengeRogueTeamButton.New(arg_3_0.sureGo_, handler(arg_3_0, arg_3_0.OnClickBtn))
	arg_3_0.textEffect_ = arg_3_0.contentText_.transform:GetComponent("UITypewriterEffect")
	arg_3_0.tipsController_ = arg_3_0.controllerEx_:GetController("tips")
	arg_3_0.effectController_ = arg_3_0.controllerEx_:GetController("themeEffect")
end

function var_0_0.OnEnter(arg_4_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	ChallengeRogueTeamTools.RegistWindowBarClick()
	manager.notify:RegistListener(CHALLENGE_ROGUE_TEAM_EVENT_OPTION_SELECT, arg_4_0.onEventOptionSelectHandler_)
	manager.notify:RegistListener(CHALLENGE_ROGUE_TEAM_UPDATE_WINDOW, arg_4_0.checkUnfinishOperateHandler_)
	manager.notify:RegistListener(CHALLENGE_ROGUE_TEAM_POP_ITEM_INFO, arg_4_0.onClickWindowBarItemHandler_)
	arg_4_0:RefreshBGM()
end

function var_0_0.OnTop(arg_5_0)
	if arg_5_0.clickWindowBarItemFlag_ then
		arg_5_0.clickWindowBarItemFlag_ = false

		return
	end

	ChallengeRogueTeamTools.ShowBarList()
	manager.rogueTeamMapPreviewBtnBar:ShowState(ChallengeRogueTeamConst.MAP_BTN_WINDOW.OTHER)

	if ChallengeRogueTeamData:EventGetCurrentID() == 0 then
		arg_5_0:Back()

		return
	end

	arg_5_0:DoNextStep()
end

function var_0_0.OnExit(arg_6_0)
	arg_6_0:StopTimer()
	arg_6_0:StopTipsTimer()
	manager.windowBar:HideBar()
	ChallengeRogueTeamTools.HideBarList()
	manager.notify:RemoveListener(CHALLENGE_ROGUE_TEAM_EVENT_OPTION_SELECT, arg_6_0.onEventOptionSelectHandler_)
	manager.notify:RemoveListener(CHALLENGE_ROGUE_TEAM_UPDATE_WINDOW, arg_6_0.checkUnfinishOperateHandler_)
	manager.notify:RemoveListener(CHALLENGE_ROGUE_TEAM_POP_ITEM_INFO, arg_6_0.onClickWindowBarItemHandler_)
end

function var_0_0.Dispose(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0.optionItemList_) do
		iter_7_1:Dispose()
	end

	arg_7_0.optionItemList_ = nil

	for iter_7_2, iter_7_3 in ipairs(arg_7_0.tipsItemList_) do
		iter_7_3:Dispose()
	end

	arg_7_0.tipsItemList_ = nil

	arg_7_0.rogueTeamSureBtnView_:Dispose()

	arg_7_0.rogueTeamSureBtnView_ = nil
	arg_7_0.onEventOptionSelectHandler_ = nil
	arg_7_0.checkUnfinishOperateHandler_ = nil
	arg_7_0.onClickWindowBarItemHandler_ = nil

	var_0_0.super.Dispose(arg_7_0)
end

function var_0_0.AddListeners(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.maskBtn_, nil, function()
		local var_9_0 = ChallengeRogueTeamData:EventGetCurrrentOptionList()

		if arg_8_0.playAnimatorState_ then
			if #var_9_0 <= 0 then
				arg_8_0:StopAnimatorOnStep1()
			else
				arg_8_0:PlayAnimator2()
			end
		elseif #var_9_0 <= 0 then
			arg_8_0:OnClickBtn()
		elseif arg_8_0.showTipsFlag_ == true then
			arg_8_0:ShowTips(arg_8_0.selectOptionData_)
		end
	end)
end

function var_0_0.OnClickBtn(arg_10_0)
	if #ChallengeRogueTeamData:EventGetCurrrentOptionList() <= 0 then
		ChallengeRogueTeamData:UISetPlayEventAnimator(ChallengeRogueTeamData:EventGetCurrentID())
		ChallengeRogueTeamAction.ChooiseEventOptionID(0, function()
			return
		end)
	else
		if arg_10_0.selectOptionData_.id == 0 then
			return
		end

		local var_10_0 = arg_10_0.selectOptionData_.id
		local var_10_1 = ChallengeRogueTeamData:EventGetCurrentID()

		ChallengeRogueTeamData:UISetPlayEventAnimator(var_10_1)
		ChallengeRogueTeamAction.ChooiseEventOptionID(var_10_0, function()
			local var_12_0 = RogueTeamEventOptionCfg[var_10_0]
			local var_12_1 = ChallengeRogueTeamTools.GetRogueTeamEventStageID(var_10_0)

			ChallengeRogueTeamData:UISetSelectEventOption(var_10_1, var_10_0)

			if var_12_0.need_play_effect_decide == 1 then
				JumpTools.OpenPageByJump("challengeRogueTeamEventDecide", {
					stageID = var_12_1
				})
			else
				ChallengeRogueTeamAction.GotoRogueTeamEventReserve(var_12_1)
			end
		end)
	end
end

function var_0_0.RefreshUI(arg_13_0)
	local var_13_0 = ChallengeRogueTeamData:EventGetCurrentID()

	arg_13_0.tipsController_:SetSelectedState("off")

	if var_13_0 == 0 then
		arg_13_0:Back()

		return
	end

	ChallengeRogueTeamAction.AddPopWindowCnt()

	local var_13_1 = RogueTeamEventCfg[var_13_0]
	local var_13_2 = ChallengeRogueTeamData:EventGetCurrrentOptionList()

	for iter_13_0, iter_13_1 in ipairs(var_13_2) do
		if arg_13_0.optionItemList_[iter_13_0] == nil then
			arg_13_0.optionItemList_[iter_13_0] = ChallengeRogueTeamEventItem.New(arg_13_0.itemGo_, arg_13_0.itemParent_)
		end

		arg_13_0.optionItemList_[iter_13_0]:SetData(iter_13_1)
	end

	for iter_13_2 = #var_13_2 + 1, #arg_13_0.optionItemList_ do
		arg_13_0.optionItemList_[iter_13_2]:Show(false)
	end

	arg_13_0.descScrollView_.normalizedPosition = Vector2(0, 1)
	arg_13_0.titleText_.text = var_13_1.title
	arg_13_0.contentText_.text = var_13_1.desc

	if not string.isNullOrEmpty(var_13_1.image) then
		SetSpriteWithoutAtlasAsync(arg_13_0.image_, var_13_1.image)
	end

	arg_13_0:RefreshEventEffectPanel()

	local var_13_3, var_13_4 = ChallengeRogueTeamData:UIGetEventIDAnimator()

	if var_13_3 ~= 0 then
		arg_13_0.selectOptionData_ = ChallengeRogueTeamData:GetOptionData(var_13_4)

		arg_13_0:OnEventOptionSelect(arg_13_0.selectOptionData_, true)
		arg_13_0:SkipAnimator()
		arg_13_0.textAnimator_:Update(1)

		return
	else
		arg_13_0.selectOptionData_ = {
			id = 0
		}
	end

	if #var_13_2 <= 0 then
		arg_13_0.rogueTeamSureBtnView_:RefreshBtnState(ChallengeRogueTeamButton.ENABLE_CLICK, ChallengeRogueTeamButton.BUTTON_TEXT.EXIT)
	else
		arg_13_0.rogueTeamSureBtnView_:RefreshBtnState(ChallengeRogueTeamButton.DISENABLE_CLICK, ChallengeRogueTeamButton.BUTTON_TEXT.MAKE_CHOICE)
	end

	if ChallengeRogueTeamData:UIGetPlayEventAnimator() == var_13_0 then
		if #var_13_2 <= 0 then
			arg_13_0:StopAnimatorOnStep1()
		else
			arg_13_0:PlayAnimator2()
		end

		return
	end

	ChallengeRogueTeamTools.HideBarList()
	arg_13_0.animator_:Play("UI_EventPanelUI_step1")

	local var_13_5 = utf8.len(var_13_1.desc)

	arg_13_0.textEffect_.percent = 0

	arg_13_0.textEffect_:SetDirty()
	arg_13_0:StopTimer()
	arg_13_0:PlayTextAnimator()

	local var_13_6 = ChallengeRogueTeamData:EventGetCurrentID()

	ChallengeRogueTeamData:UISetEventIDAnimator(var_13_6, 0)

	local var_13_7 = 0

	arg_13_0.playAnimatorState_ = true
	arg_13_0.textEffect_.needAutoScroll = true
	arg_13_0.textTimer_ = FrameTimer.New(function()
		var_13_7 = var_13_7 + 1

		if var_13_7 >= var_13_5 then
			if #var_13_2 <= 0 then
				arg_13_0:StopAnimatorOnStep1()
			else
				arg_13_0:PlayAnimator2()
			end
		else
			arg_13_0.textEffect_.percent = var_13_7 / var_13_5

			arg_13_0.textEffect_:SetDirty()

			if arg_13_0.itemParentTf_.localPosition.y > 2 then
				arg_13_0.textEffect_.needAutoScroll = false
				arg_13_0.itemParentTf_.localPosition = Vector3(0, 0, 0)
				var_13_7 = var_13_5
			end
		end
	end, 1, -1)

	arg_13_0.textTimer_:Start()
end

function var_0_0.StopAnimatorOnStep1(arg_15_0)
	arg_15_0.playAnimatorState_ = false
	arg_15_0.textEffect_.needAutoScroll = false
	arg_15_0.textEffect_.percent = 1

	arg_15_0.textEffect_:SetDirty()

	arg_15_0.itemParentTf_.localPosition = Vector3(0, 0, 0)

	arg_15_0.animator_:Update(1)
	arg_15_0.textAnimator_:Update(1)
	ChallengeRogueTeamTools.ShowBarList()
	arg_15_0:StopTimer()
	ChallengeRogueTeamAction.RemovePopWindowCnt()
	ChallengeRogueTeamAction.PopWindowProcessSystem()
end

function var_0_0.PlayAnimator2(arg_16_0)
	arg_16_0.playAnimatorState_ = false

	arg_16_0:StopTimer()

	arg_16_0.textEffect_.needAutoScroll = false
	arg_16_0.textEffect_.percent = 1

	arg_16_0.textEffect_:SetDirty()

	arg_16_0.itemParentTf_.localPosition = Vector3(0, 0, 0)

	arg_16_0.animator_:Play("UI_EventPanelUI_step2")
	ChallengeRogueTeamTools.ShowBarList()
	arg_16_0.textAnimator_:Update(1)
	ChallengeRogueTeamAction.RemovePopWindowCnt()
	ChallengeRogueTeamAction.PopWindowProcessSystem()
end

function var_0_0.SkipAnimator(arg_17_0)
	arg_17_0.playAnimatorState_ = false

	arg_17_0:StopTimer()

	arg_17_0.textEffect_.needAutoScroll = false
	arg_17_0.textEffect_.percent = 1

	arg_17_0.textEffect_:SetDirty()

	arg_17_0.itemParentTf_.localPosition = Vector3(0, 0, 0)

	if #ChallengeRogueTeamData:EventGetCurrrentOptionList() <= 0 then
		arg_17_0.animator_:Play("UI_EventPanelUI_step1", 0, 1)
	else
		arg_17_0.animator_:Play("UI_EventPanelUI_step2", 0, 1)
	end

	arg_17_0.textAnimator_:Update(1)
	ChallengeRogueTeamTools.ShowBarList()
	ChallengeRogueTeamAction.RemovePopWindowCnt()
	ChallengeRogueTeamAction.PopWindowProcessSystem()
end

function var_0_0.PlayTextAnimator(arg_18_0)
	local var_18_0, var_18_1 = ChallengeRogueTeamData:UIGetEventIDAnimator()
	local var_18_2 = ChallengeRogueTeamData:EventGetCurrentID()

	if var_18_0 == 0 then
		arg_18_0.textAnimator_:Update(0)
	else
		local var_18_3 = RogueTeamEventCfg[var_18_0]
		local var_18_4 = RogueTeamEventCfg[var_18_2]

		if var_18_3.image == var_18_4.image then
			arg_18_0.textAnimator_:Update(1)
		else
			arg_18_0.textAnimator_:Update(0)
		end
	end
end

function var_0_0.StopTimer(arg_19_0)
	if arg_19_0.textTimer_ then
		arg_19_0.textTimer_:Stop()

		arg_19_0.textTimer_ = nil
	end
end

function var_0_0.RefreshTipsList(arg_20_0)
	local var_20_0 = arg_20_0.selectOptionData_
	local var_20_1 = var_20_0.id

	if var_20_1 == 0 then
		for iter_20_0 = 1, #arg_20_0.tipsItemList_ do
			arg_20_0.tipsItemList_[iter_20_0]:Show(false)
		end

		return
	end

	local var_20_2 = {}

	for iter_20_1, iter_20_2 in ipairs(var_20_0.itemList) do
		arg_20_0.tipsItemList_[iter_20_1] = arg_20_0.tipsItemList_[iter_20_1] or ChallengeRogueTeamEventPopItem.New(arg_20_0.tipsItemGo_, arg_20_0.tipsParent_)

		arg_20_0.tipsItemList_[iter_20_1]:SetData(iter_20_2)
	end

	for iter_20_3 = #var_20_0.itemList + 1, #arg_20_0.tipsItemList_ do
		arg_20_0.tipsItemList_[iter_20_3]:Show(false)
	end

	local var_20_3 = ChallengeRogueTeamData:EventGetCurrentID()
	local var_20_4 = table.keyof(RogueTeamEventCfg[var_20_3].option_list, var_20_1)
	local var_20_5 = arg_20_0.rootTf_:InverseTransformPoint(arg_20_0.optionItemList_[var_20_4].transform_:TransformPoint(Vector3(0, 0, 0)))

	arg_20_0.tipsTf_.localPosition = Vector3(arg_20_0.tipsTf_.localPosition.x, var_20_5.y + 83, var_20_5.z)
end

function var_0_0.OnEventOptionSelect(arg_21_0, arg_21_1, arg_21_2)
	for iter_21_0, iter_21_1 in ipairs(arg_21_0.optionItemList_) do
		iter_21_1:RefreshState(arg_21_1.id)
	end

	if arg_21_1.id == 0 then
		if arg_21_0.selectOptionData_.id ~= arg_21_1.id then
			arg_21_0.rogueTeamSureBtnView_:RefreshBtnState(ChallengeRogueTeamButton.DISENABLE_CLICK, ChallengeRogueTeamButton.BUTTON_TEXT.MAKE_CHOICE)
		end

		arg_21_0.selectOptionData_ = arg_21_1
	else
		arg_21_0.rogueTeamSureBtnView_:RefreshBtnState(ChallengeRogueTeamButton.ENABLE_CLICK)

		arg_21_0.selectOptionData_ = arg_21_1

		arg_21_0:RefreshTipsList()
	end

	if not arg_21_2 then
		arg_21_0.showTipsFlag_ = false
	else
		arg_21_0.showTipsFlag_ = not arg_21_0.showTipsFlag_
	end

	arg_21_0:ShowTips(arg_21_1)
end

function var_0_0.ShowTips(arg_22_0, arg_22_1)
	if arg_22_1.itemList and #arg_22_1.itemList > 0 and not arg_22_0.showTipsFlag_ then
		arg_22_0.tipsController_:SetSelectedState("on")

		arg_22_0.showTipsFlag_ = true
	else
		arg_22_0.showTipsFlag_ = false

		arg_22_0.tipsController_:SetSelectedState("off")
	end
end

function var_0_0.OnCheckUnfinishOperate(arg_23_0)
	if not arg_23_0:IsTop() then
		return
	end

	arg_23_0:DoNextStep()
end

function var_0_0.DoNextStep(arg_24_0)
	if (ChallengeRogueTeamTools.HasMapSwitchEffect() or not ChallengeRogueTeamAction.PopWindowProcessSystem()) and ChallengeRogueTeamData:UIGetEventPause() == false then
		arg_24_0:RefreshUI()
	end
end

function var_0_0.OnClickWindowBarItem(arg_25_0)
	arg_25_0.clickWindowBarItemFlag_ = true
end

function var_0_0.RefreshEventEffectPanel(arg_26_0)
	if ChallengeRogueTeamData:EventGetTriggerType() ~= 0 then
		arg_26_0.effectText_.text = string.format(GetTips("ROGUE_TEAM_NODE_EVENT_EFFECT"))

		local var_26_0 = ChallengeRogueTeamTools.GetEventMoreMechanismID()

		arg_26_0.effectIcon_.sprite = pureGetSpriteWithoutAtlas(ChallengeRogueTeamTools.GetItemIcon(var_26_0))

		ChallengeRogueTeamData:EventSetTriggerType(0)
		arg_26_0:AddTipsTimer()
	else
		arg_26_0.effectController_:SetSelectedState("off")
	end
end

function var_0_0.AddTipsTimer(arg_27_0)
	arg_27_0:StopTipsTimer()
	arg_27_0.effectController_:SetSelectedState("on")

	arg_27_0.tipsTimer_ = Timer.New(function()
		arg_27_0:StopTipsTimer()
	end, 2, 1)

	arg_27_0.tipsTimer_:Start()
end

function var_0_0.StopTipsTimer(arg_29_0)
	if arg_29_0.tipsTimer_ then
		arg_29_0.effectController_:SetSelectedState("off")
		arg_29_0.tipsTimer_:Stop()

		arg_29_0.tipsTimer_ = nil
	end
end

function var_0_0.RefreshBGM(arg_30_0)
	local var_30_0 = ChallengeRogueTeamData:PathGetSelectedNodeID()

	if var_30_0 == 0 then
		return
	end

	local var_30_1 = ChallengeRogueTeamData:PathGetNodeData(var_30_0).nodeType
	local var_30_2 = ChallengeRogueTeamData:GetCacheTemplateID()
	local var_30_3 = RogueTeamCfg[var_30_2].room_temp
	local var_30_4 = RogueTeamRoomTypeCfg.get_id_list_by_temp_id_id[var_30_3][var_30_1][1]
	local var_30_5 = RogueTeamRoomTypeCfg[var_30_4]

	if var_30_5.cue_sheet ~= "" then
		manager.audio:PlayBGM(var_30_5.cue_sheet, var_30_5.cue_name, var_30_5.awb)
	end
end

return var_0_0

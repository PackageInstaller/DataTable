local ChallengeRogueTeamEventView = class("ChallengeRogueTeamEventView", ReduxView)

function ChallengeRogueTeamEventView:UIName()
	return "Widget/System/Activity_Roulike/Event/EventPanelUI"
end

function ChallengeRogueTeamEventView:UIParent()
	return manager.ui.uiMain.transform
end

function ChallengeRogueTeamEventView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.optionItemList_ = {}
	self.tipsItemList_ = {}
	self.onEventOptionSelectHandler_ = handler(self, self.OnEventOptionSelect)
	self.checkUnfinishOperateHandler_ = handler(self, self.OnCheckUnfinishOperate)
	self.onClickWindowBarItemHandler_ = handler(self, self.OnClickWindowBarItem)
	self.rogueTeamSureBtnView_ = ChallengeRogueTeamButton.New(self.sureGo_, handler(self, self.OnClickBtn))
	self.textEffect_ = self.contentText_.transform:GetComponent("UITypewriterEffect")
	self.tipsController_ = self.controllerEx_:GetController("tips")
	self.effectController_ = self.controllerEx_:GetController("themeEffect")
end

function ChallengeRogueTeamEventView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	ChallengeRogueTeamTools.RegistWindowBarClick()
	manager.notify:RegistListener(CHALLENGE_ROGUE_TEAM_EVENT_OPTION_SELECT, self.onEventOptionSelectHandler_)
	manager.notify:RegistListener(CHALLENGE_ROGUE_TEAM_UPDATE_WINDOW, self.checkUnfinishOperateHandler_)
	manager.notify:RegistListener(CHALLENGE_ROGUE_TEAM_POP_ITEM_INFO, self.onClickWindowBarItemHandler_)
	self:RefreshBGM()
end

function ChallengeRogueTeamEventView:OnTop()
	if self.clickWindowBarItemFlag_ then
		self.clickWindowBarItemFlag_ = false

		return
	end

	ChallengeRogueTeamTools.ShowBarList()
	manager.rogueTeamMapPreviewBtnBar:ShowState(ChallengeRogueTeamConst.MAP_BTN_WINDOW.OTHER)

	if ChallengeRogueTeamData:EventGetCurrentID() == 0 then
		self:Back()

		return
	end

	self:DoNextStep()
end

function ChallengeRogueTeamEventView:OnExit()
	self:StopTimer()
	self:StopTipsTimer()
	manager.windowBar:HideBar()
	ChallengeRogueTeamTools.HideBarList()
	manager.notify:RemoveListener(CHALLENGE_ROGUE_TEAM_EVENT_OPTION_SELECT, self.onEventOptionSelectHandler_)
	manager.notify:RemoveListener(CHALLENGE_ROGUE_TEAM_UPDATE_WINDOW, self.checkUnfinishOperateHandler_)
	manager.notify:RemoveListener(CHALLENGE_ROGUE_TEAM_POP_ITEM_INFO, self.onClickWindowBarItemHandler_)
end

function ChallengeRogueTeamEventView:Dispose()
	for iter_7_0, iter_7_1 in ipairs(self.optionItemList_) do
		iter_7_1:Dispose()
	end

	self.optionItemList_ = nil

	for iter_7_2, iter_7_3 in ipairs(self.tipsItemList_) do
		iter_7_3:Dispose()
	end

	self.tipsItemList_ = nil

	self.rogueTeamSureBtnView_:Dispose()

	self.rogueTeamSureBtnView_ = nil
	self.onEventOptionSelectHandler_ = nil
	self.checkUnfinishOperateHandler_ = nil
	self.onClickWindowBarItemHandler_ = nil

	ChallengeRogueTeamEventView.super.Dispose(self)
end

function ChallengeRogueTeamEventView:AddListeners()
	self:AddBtnListener(self.maskBtn_, nil, function()
		local var_9_0 = ChallengeRogueTeamData:EventGetCurrrentOptionList()

		if self.playAnimatorState_ then
			if #var_9_0 <= 0 then
				self:StopAnimatorOnStep1()
			else
				self:PlayAnimator2()
			end
		elseif #var_9_0 <= 0 then
			self:OnClickBtn()
		elseif self.showTipsFlag_ == true then
			self:ShowTips(self.selectOptionData_)
		end
	end)
end

function ChallengeRogueTeamEventView:OnClickBtn()
	if #ChallengeRogueTeamData:EventGetCurrrentOptionList() <= 0 then
		ChallengeRogueTeamData:UISetPlayEventAnimator(ChallengeRogueTeamData:EventGetCurrentID())
		ChallengeRogueTeamAction.ChooiseEventOptionID(0, function()
			return
		end)
	else
		if self.selectOptionData_.id == 0 then
			return
		end

		local var_10_0 = self.selectOptionData_.id
		local var_10_1 = ChallengeRogueTeamData:EventGetCurrentID()

		ChallengeRogueTeamData:UISetPlayEventAnimator(var_10_1)
		ChallengeRogueTeamAction.ChooiseEventOptionID(var_10_0, function()
			local var_12_0 = ChallengeRogueTeamTools.GetRogueTeamEventStageID(var_10_0)

			ChallengeRogueTeamData:UISetSelectEventOption(var_10_1, var_10_0)

			if RogueTeamEventOptionCfg[var_10_0].need_play_effect_decide == 1 then
				JumpTools.OpenPageByJump("challengeRogueTeamEventDecide", {
					stageID = var_12_0
				})
			else
				ChallengeRogueTeamAction.GotoRogueTeamEventReserve(var_12_0)
			end
		end)
	end
end

function ChallengeRogueTeamEventView:RefreshUI()
	local var_13_0 = ChallengeRogueTeamData:EventGetCurrentID()

	self.tipsController_:SetSelectedState("off")

	if var_13_0 == 0 then
		self:Back()

		return
	end

	ChallengeRogueTeamAction.AddPopWindowCnt()

	local var_13_1 = RogueTeamEventCfg[var_13_0]
	local var_13_2 = ChallengeRogueTeamData:EventGetCurrrentOptionList()

	for iter_13_0, iter_13_1 in ipairs(var_13_2) do
		if self.optionItemList_[iter_13_0] == nil then
			self.optionItemList_[iter_13_0] = ChallengeRogueTeamEventItem.New(self.itemGo_, self.itemParent_)
		end

		self.optionItemList_[iter_13_0]:SetData(iter_13_1)
	end

	for iter_13_2 = #var_13_2 + 1, #self.optionItemList_ do
		self.optionItemList_[iter_13_2]:Show(false)
	end

	self.descScrollView_.normalizedPosition = Vector2(0, 1)
	self.titleText_.text = var_13_1.title
	self.contentText_.text = var_13_1.desc

	if not string.isNullOrEmpty(var_13_1.image) then
		SetSpriteWithoutAtlasAsync(self.image_, var_13_1.image)
	end

	self:RefreshEventEffectPanel()

	local var_13_3, var_13_4 = ChallengeRogueTeamData:UIGetEventIDAnimator()

	if var_13_3 ~= 0 then
		self.selectOptionData_ = ChallengeRogueTeamData:GetOptionData(var_13_4)

		self:OnEventOptionSelect(self.selectOptionData_, true)
		self:SkipAnimator()
		self.textAnimator_:Update(1)

		return
	else
		self.selectOptionData_ = {
			id = 0
		}
	end

	if #var_13_2 <= 0 then
		self.rogueTeamSureBtnView_:RefreshBtnState(ChallengeRogueTeamButton.ENABLE_CLICK, ChallengeRogueTeamButton.BUTTON_TEXT.EXIT)
	else
		self.rogueTeamSureBtnView_:RefreshBtnState(ChallengeRogueTeamButton.DISENABLE_CLICK, ChallengeRogueTeamButton.BUTTON_TEXT.MAKE_CHOICE)
	end

	if ChallengeRogueTeamData:UIGetPlayEventAnimator() == var_13_0 then
		if #var_13_2 <= 0 then
			self:StopAnimatorOnStep1()
		else
			self:PlayAnimator2()
		end

		return
	end

	ChallengeRogueTeamTools.HideBarList()
	self.animator_:Play("UI_EventPanelUI_step1")

	local var_13_5 = utf8.len(var_13_1.desc)

	self.textEffect_.percent = 0

	self.textEffect_:SetDirty()
	self:StopTimer()
	self:PlayTextAnimator()
	ChallengeRogueTeamData:UISetEventIDAnimator(ChallengeRogueTeamData:EventGetCurrentID(), 0)

	local var_13_6 = 0

	self.playAnimatorState_ = true
	self.textEffect_.needAutoScroll = true
	self.textTimer_ = FrameTimer.New(function()
		var_13_6 = var_13_6 + 1

		if var_13_6 >= var_13_5 then
			if #var_13_2 <= 0 then
				self:StopAnimatorOnStep1()
			else
				self:PlayAnimator2()
			end
		else
			self.textEffect_.percent = var_13_6 / var_13_5

			self.textEffect_:SetDirty()

			if self.itemParentTf_.localPosition.y > 2 then
				self.textEffect_.needAutoScroll = false
				self.itemParentTf_.localPosition = Vector3(0, 0, 0)
				var_13_6 = var_13_5
			end
		end
	end, 1, -1)

	self.textTimer_:Start()
end

function ChallengeRogueTeamEventView:StopAnimatorOnStep1()
	self.playAnimatorState_ = false
	self.textEffect_.needAutoScroll = false
	self.textEffect_.percent = 1

	self.textEffect_:SetDirty()

	self.itemParentTf_.localPosition = Vector3(0, 0, 0)

	self.animator_:Update(1)
	self.textAnimator_:Update(1)
	ChallengeRogueTeamTools.ShowBarList()
	self:StopTimer()
	ChallengeRogueTeamAction.RemovePopWindowCnt()
	ChallengeRogueTeamAction.PopWindowProcessSystem()
end

function ChallengeRogueTeamEventView:PlayAnimator2()
	self.playAnimatorState_ = false

	self:StopTimer()

	self.textEffect_.needAutoScroll = false
	self.textEffect_.percent = 1

	self.textEffect_:SetDirty()

	self.itemParentTf_.localPosition = Vector3(0, 0, 0)

	self.animator_:Play("UI_EventPanelUI_step2")
	ChallengeRogueTeamTools.ShowBarList()
	self.textAnimator_:Update(1)
	ChallengeRogueTeamAction.RemovePopWindowCnt()
	ChallengeRogueTeamAction.PopWindowProcessSystem()
end

function ChallengeRogueTeamEventView:SkipAnimator()
	self.playAnimatorState_ = false

	self:StopTimer()

	self.textEffect_.needAutoScroll = false
	self.textEffect_.percent = 1

	self.textEffect_:SetDirty()

	self.itemParentTf_.localPosition = Vector3(0, 0, 0)

	if #ChallengeRogueTeamData:EventGetCurrrentOptionList() <= 0 then
		self.animator_:Play("UI_EventPanelUI_step1", 0, 1)
	else
		self.animator_:Play("UI_EventPanelUI_step2", 0, 1)
	end

	self.textAnimator_:Update(1)
	ChallengeRogueTeamTools.ShowBarList()
	ChallengeRogueTeamAction.RemovePopWindowCnt()
	ChallengeRogueTeamAction.PopWindowProcessSystem()
end

function ChallengeRogueTeamEventView:PlayTextAnimator()
	local var_18_0, var_18_1 = ChallengeRogueTeamData:UIGetEventIDAnimator()

	if var_18_0 == 0 then
		self.textAnimator_:Update(0)
	elseif RogueTeamEventCfg[var_18_0].image == RogueTeamEventCfg[ChallengeRogueTeamData:EventGetCurrentID()].image then
		self.textAnimator_:Update(1)
	else
		self.textAnimator_:Update(0)
	end
end

function ChallengeRogueTeamEventView:StopTimer()
	if self.textTimer_ then
		self.textTimer_:Stop()

		self.textTimer_ = nil
	end
end

function ChallengeRogueTeamEventView:RefreshTipsList()
	if self.selectOptionData_.id == 0 then
		for iter_20_0 = 1, #self.tipsItemList_ do
			self.tipsItemList_[iter_20_0]:Show(false)
		end

		return
	end

	for iter_20_1, iter_20_2 in ipairs(self.selectOptionData_.itemList) do
		self.tipsItemList_[iter_20_1] = self.tipsItemList_[iter_20_1] or ChallengeRogueTeamEventPopItem.New(self.tipsItemGo_, self.tipsParent_)

		self.tipsItemList_[iter_20_1]:SetData(iter_20_2)
	end

	for iter_20_3 = #self.selectOptionData_.itemList + 1, #self.tipsItemList_ do
		self.tipsItemList_[iter_20_3]:Show(false)
	end

	local var_20_1 = self.rootTf_:InverseTransformPoint(self.optionItemList_[table.keyof(RogueTeamEventCfg[ChallengeRogueTeamData:EventGetCurrentID()].option_list, self.selectOptionData_.id)].transform_:TransformPoint(Vector3(0, 0, 0)))

	self.tipsTf_.localPosition = Vector3(self.tipsTf_.localPosition.x, var_20_1.y + 83, var_20_1.z)
end

function ChallengeRogueTeamEventView:OnEventOptionSelect(arg_21_1, arg_21_2)
	for iter_21_0, iter_21_1 in ipairs(self.optionItemList_) do
		iter_21_1:RefreshState(arg_21_1.id)
	end

	if arg_21_1.id == 0 then
		if self.selectOptionData_.id ~= arg_21_1.id then
			self.rogueTeamSureBtnView_:RefreshBtnState(ChallengeRogueTeamButton.DISENABLE_CLICK, ChallengeRogueTeamButton.BUTTON_TEXT.MAKE_CHOICE)
		end

		self.selectOptionData_ = arg_21_1
	else
		self.rogueTeamSureBtnView_:RefreshBtnState(ChallengeRogueTeamButton.ENABLE_CLICK)

		self.selectOptionData_ = arg_21_1

		self:RefreshTipsList()
	end

	if not arg_21_2 then
		self.showTipsFlag_ = false
	else
		self.showTipsFlag_ = not self.showTipsFlag_
	end

	self:ShowTips(arg_21_1)
end

function ChallengeRogueTeamEventView:ShowTips(arg_22_1)
	if arg_22_1.itemList and #arg_22_1.itemList > 0 and not self.showTipsFlag_ then
		self.tipsController_:SetSelectedState("on")

		self.showTipsFlag_ = true
	else
		self.showTipsFlag_ = false

		self.tipsController_:SetSelectedState("off")
	end
end

function ChallengeRogueTeamEventView:OnCheckUnfinishOperate()
	if not self:IsTop() then
		return
	end

	self:DoNextStep()
end

function ChallengeRogueTeamEventView:DoNextStep()
	if (ChallengeRogueTeamTools.HasMapSwitchEffect() or not ChallengeRogueTeamAction.PopWindowProcessSystem()) and ChallengeRogueTeamData:UIGetEventPause() == false then
		self:RefreshUI()
	end
end

function ChallengeRogueTeamEventView:OnClickWindowBarItem()
	self.clickWindowBarItemFlag_ = true
end

function ChallengeRogueTeamEventView:RefreshEventEffectPanel()
	if ChallengeRogueTeamData:EventGetTriggerType() ~= 0 then
		self.effectText_.text = string.format(GetTips("ROGUE_TEAM_NODE_EVENT_EFFECT"))
		self.effectIcon_.sprite = pureGetSpriteWithoutAtlas(ChallengeRogueTeamTools.GetItemIcon((ChallengeRogueTeamTools.GetEventMoreMechanismID())))

		ChallengeRogueTeamData:EventSetTriggerType(0)
		self:AddTipsTimer()
	else
		self.effectController_:SetSelectedState("off")
	end
end

function ChallengeRogueTeamEventView:AddTipsTimer()
	self:StopTipsTimer()
	self.effectController_:SetSelectedState("on")

	self.tipsTimer_ = Timer.New(function()
		self:StopTipsTimer()
	end, 2, 1)

	self.tipsTimer_:Start()
end

function ChallengeRogueTeamEventView:StopTipsTimer()
	if self.tipsTimer_ then
		self.effectController_:SetSelectedState("off")
		self.tipsTimer_:Stop()

		self.tipsTimer_ = nil
	end
end

function ChallengeRogueTeamEventView:RefreshBGM()
	local var_30_0 = ChallengeRogueTeamData:PathGetSelectedNodeID()

	if var_30_0 == 0 then
		return
	end

	local var_30_1 = RogueTeamRoomTypeCfg[RogueTeamRoomTypeCfg.get_id_list_by_temp_id_id[RogueTeamCfg[ChallengeRogueTeamData:GetCacheTemplateID()].room_temp][ChallengeRogueTeamData:PathGetNodeData(var_30_0).nodeType][1]]

	if var_30_1.cue_sheet ~= "" then
		manager.audio:PlayBGM(var_30_1.cue_sheet, var_30_1.cue_name, var_30_1.awb)
	end
end

return ChallengeRogueTeamEventView

local ChallengeRogueTeamTreasureSelectView = class("ChallengeRogueTeamTreasureSelectView", ReduxView)

function ChallengeRogueTeamTreasureSelectView:UIName()
	return "Widget/System/Activity_Roulike/RoulikeSelectPopUI"
end

function ChallengeRogueTeamTreasureSelectView:UIParent()
	return manager.ui.uiPop.transform
end

function ChallengeRogueTeamTreasureSelectView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.treasureItemList_ = {}
	self.selectTreasureHandler_ = handler(self, self.OnSelectTreasure)
	self.updateOperateHandler_ = handler(self, self.UpdateOperate)
	self.showResetPanelController_ = self.controllerEx_:GetController("showResetPanel")
	self.initRewardController_ = self.controllerEx_:GetController("fristbg")
	self.emptyController_ = self.controllerEx_:GetController("empty")
	self.colorController_ = self.colorControllerEx_:GetController("color")
	self.rogueTeamSureBtnView_ = ChallengeRogueTeamButton.New(self.sureBtnGo_, handler(self, self.OnClickBtn))
end

function ChallengeRogueTeamTreasureSelectView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:SetAsLastSibling()
	ChallengeRogueTeamTools.RegistWindowBarClick()
	ChallengeRogueTeamTools.ShowBarList()
	self:RefreshUI()
	manager.notify:RegistListener(CHALLENGE_ROGUE_TEAM_UPDATE_OPERATE_WINDOW, self.updateOperateHandler_)
	manager.notify:RegistListener(CHALLENGE_ROGUE_TEAM_SELECTED_TREASURE, self.selectTreasureHandler_)
end

function ChallengeRogueTeamTreasureSelectView:OnExit()
	self.selectedIndex_ = nil

	manager.notify:RemoveListener(CHALLENGE_ROGUE_TEAM_SELECTED_TREASURE, self.selectTreasureHandler_)
	manager.notify:RemoveListener(CHALLENGE_ROGUE_TEAM_UPDATE_OPERATE_WINDOW, self.updateOperateHandler_)

	for iter_5_0, iter_5_1 in ipairs(self.treasureItemList_) do
		iter_5_1:OnExit()
	end
end

function ChallengeRogueTeamTreasureSelectView:Dispose()
	self.rogueTeamSureBtnView_:Dispose()

	self.rogueTeamSureBtnView_ = nil

	ChallengeRogueTeamTreasureSelectView.super.Dispose(self)

	self.selectTreasureHandler_ = nil
	self.updateOperateHandler_ = nil

	for iter_6_0, iter_6_1 in ipairs(self.treasureItemList_) do
		iter_6_1:Dispose()
	end

	self.treasureItemList_ = nil
end

function ChallengeRogueTeamTreasureSelectView:AddListeners()
	self:AddBtnListener(self.resetBtn_, nil, function()
		ChallengeRogueTeamAction.ResetOperateData(ChallengeRogueTeamConst.RESET_OPERATE_TYPE.TREASURE, function()
			self:RefreshUI()
		end)
	end)
end

function ChallengeRogueTeamTreasureSelectView:OnClickBtn()
	local var_10_0 = ChallengeRogueTeamData:GetUnOperateData().paramList
	local var_10_2 = ChallengeRogueTeamData:GetUnOperateData()

	if #var_10_0 <= 0 then
		ChallengeRogueTeamAction.SelectedEventValue(var_10_2.eventType, 0, function()
			ChallengeRogueTeamData:RemoveServerTriggerQueue()
			self:Back()
			ChallengeRogueTeamAction.RemovePopWindowCnt()
		end)

		return
	end

	if self.selectedIndex_ == nil then
		return
	end

	ChallengeRogueTeamAction.SelectedEventValue(var_10_2.eventType, (#var_10_0 > 0 or nil) and ChallengeRogueTeamData:GetUnOperateData().paramList[self.selectedIndex_].index, function()
		ChallengeRogueTeamData:RemoveServerTriggerQueue()
		self:Back()
		ChallengeRogueTeamAction.RemovePopWindowCnt()
	end)
end

function ChallengeRogueTeamTreasureSelectView:OnSelectTreasure(arg_13_1)
	self.selectedIndex_ = arg_13_1

	for iter_13_0, iter_13_1 in ipairs(self.treasureItemList_) do
		iter_13_1:SelectTreasure(arg_13_1)
	end

	self:RefreshSelectBtn()
end

function ChallengeRogueTeamTreasureSelectView:UpdateOperate()
	self:RefreshUI()

	for iter_14_0, iter_14_1 in ipairs(self.treasureItemList_) do
		iter_14_1:PlayAnimator()
	end
end

function ChallengeRogueTeamTreasureSelectView:RefreshUI()
	local var_15_0 = ChallengeRogueTeamData:GetUnOperateData()
	local var_15_1 = var_15_0.paramList

	if var_15_0.eventType == ChallengeRogueTeamConst.NODE_UNOPERATE_EVENT.MECHANISM then
		self.itemPanelAnimator_:Play("UI_SelectItem", -1, 0)
		ChallengeRogueTeamTools.PlayAudio("mechanism_audio_id")
	else
		self.itemPanelAnimator_:Play("UI_SelectItem", -1, 1)
		ChallengeRogueTeamTools.PlayAudio("item_select_audio_id")
	end

	self.titleText_.text = ChallengeRogueTeamTools.GetSelectItemText(var_15_0)

	for iter_15_0, iter_15_1 in ipairs(var_15_1) do
		if self.treasureItemList_[iter_15_0] == nil then
			self.treasureItemList_[iter_15_0] = ChallengeRogueTeamTreasureItem.New(self.parent_, iter_15_0)
		end

		iter_15_1.needShowCampFlag = true

		self.treasureItemList_[iter_15_0]:SetData(iter_15_1)
	end

	for iter_15_2 = #self.treasureItemList_, #var_15_1 + 1, -1 do
		self.treasureItemList_[iter_15_2]:Dispose()

		self.treasureItemList_[iter_15_2] = nil
	end

	if #var_15_1 > 0 then
		if RogueTeamItemCfg[var_15_1[1].id].type == ChallengeRogueTeamConst.ITEM_TYPE.INIT_REWARD then
			self.initRewardController_:SetSelectedState("friston")
		elseif RogueTeamItemCfg[var_15_1[1].id].type == ChallengeRogueTeamConst.ITEM_TYPE.MECHANISM then
			self.initRewardController_:SetSelectedState("themeEffect")
		else
			self.initRewardController_:SetSelectedState("off")
		end
	else
		self.titleText_.text = ""
	end

	self.selectedIndex_ = nil

	self:RefreshSelectBtn()
	self:RefreshReset()
end

function ChallengeRogueTeamTreasureSelectView:RefreshSelectBtn()
	if #ChallengeRogueTeamData:GetUnOperateData().paramList <= 0 then
		self.rogueTeamSureBtnView_:RefreshBtnState(ChallengeRogueTeamButton.ENABLE_CLICK, ChallengeRogueTeamButton.BUTTON_TEXT.EXIT)

		return
	end

	if self.selectedIndex_ ~= nil then
		self.rogueTeamSureBtnView_:RefreshBtnState(ChallengeRogueTeamButton.ENABLE_CLICK)
	else
		self.rogueTeamSureBtnView_:RefreshBtnState(ChallengeRogueTeamButton.DISENABLE_CLICK, ChallengeRogueTeamButton.BUTTON_TEXT.MAKE_CHOICE)
	end
end

function ChallengeRogueTeamTreasureSelectView:RefreshReset()
	local var_17_0 = ChallengeRogueTeamData:GetUnOperateData()

	if #var_17_0.paramList <= 0 then
		self.showResetPanelController_:SetSelectedState("false")
		self.emptyController_:SetSelectedState("on")

		self.tipsText_.text = string.format(GetTips("ROGUE_TEAM_ITEM_UNAVAILABLE"), (ChallengeRogueTeamTools.GetItemTypeText((ChallengeRogueTeamTools.GetItemTypeByEventType(var_17_0.eventType)))))

		return
	else
		self.emptyController_:SetSelectedState("off")
	end

	if var_17_0.eventType == ChallengeRogueTeamConst.NODE_UNOPERATE_EVENT.TREASURE and not ChallengeRogueTeamTools.IsGuideFloor() then
		self.showResetPanelController_:SetSelectedState("true")

		local var_17_1 = ChallengeRogueTeamData:AttributeGetValue(ChallengeRogueTeamConst.ATTRIBUTE_ENUM.TREASURE_RESET_CNT)

		self.resetBtn_.interactable = var_17_1 > 0
		self.resetCntText_.text = string.format("x<color=#%s>%s</color>", var_17_1 > 0 and "FFFFFF" or "E97B74", var_17_1)
	else
		self.showResetPanelController_:SetSelectedState("false")
	end
end

return ChallengeRogueTeamTreasureSelectView

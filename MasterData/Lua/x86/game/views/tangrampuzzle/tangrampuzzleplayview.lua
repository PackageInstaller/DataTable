local TangramPuzzlePlayView = class("TangramPuzzlePlayView", ReduxView)

function TangramPuzzlePlayView:UIName()
	return TangramPuzzleTools.GetPlayViewUIName(self.params_.activityID)
end

function TangramPuzzlePlayView:UIParent()
	return manager.ui.uiMain.transform
end

function TangramPuzzlePlayView:Init()
	self.puzzleItemList_ = {}
	self.puzzleGlobalIndexListByRegionTypeAndLocalIndex_ = {}
	self.regionContentItemList_ = {}
	self.regionItemList_ = {}
	self.clueItemList_ = {}
	self.statusConst_ = {
		PLAY = 0,
		EDIT = 1,
		FINAL = 2,
		NONE = -1
	}

	self:InitUI()
	self:AddUIListener()

	self.statusController_ = ControllerUtil.GetController(self.transform_, "status")
	self.autoPutBtnController_ = self.autoBtnContoller_:GetController("status")
	self.finalRewardController_ = ControllerUtil.GetController(self.finalRewardPanelTrans_, "status")
	self.dragController_ = ControllerUtil.GetController(self.transform_, "drag")
	self.beginDragPuzzleHandler_ = handler(self, self.OnBeginDragPuzzle)
	self.endDragPuzzleHandler_ = handler(self, self.OnDragPuzzleEnd)
	self.onClickPuzzleHandler_ = handler(self, self.OnClickPuzzle)

	self:InitAnimNode()
end

function TangramPuzzlePlayView:InitUI()
	self:BindCfgUI()
end

function TangramPuzzlePlayView:AddUIListener()
	self:AddBtnListener(self.exitEditBtn_, nil, function()
		self:ExitEdit()
		self:SwitchToPlay()
	end)
	self:AddBtnListener(self.rollClockwiseBtn_, nil, function()
		if not self.editPuzzleIndex_ then
			ShowTips("ACTIVITY_PUZZLE_III_SELECT")

			return
		end

		local var_7_0, var_7_1 = self.puzzleItemList_[self.editPuzzleIndex_]:GetCurRegion()

		TangramPuzzleAction.RotateRegion(self.activityID_, var_7_0, 1)
	end)
	self:AddBtnListener(self.rollAntiClockwiseBtn_, nil, function()
		if not self.editPuzzleIndex_ then
			ShowTips("ACTIVITY_PUZZLE_III_SELECT")

			return
		end

		local var_8_0, var_8_1 = self.puzzleItemList_[self.editPuzzleIndex_]:GetCurRegion()

		TangramPuzzleAction.RotateRegion(self.activityID_, var_8_0, -1)
	end)
	self:AddBtnListener(self.autoBtn_, nil, function()
		if not self:IsActivityTime() then
			return
		end

		if self.isPlayingFirstTips_ == true then
			self:ClickFirstTips()
		end

		if ItemTools.getItemNum(self.puzzleCfg_.coin_id[1][1]) < self.puzzleCfg_.coin_id[1][2] then
			ShowTips("ACTIVITY_PUZZLE_III_NOT_ENOUGH")

			return
		end

		local var_9_0 = TangramPuzzleData:GetUnlockRegionDic(self.activityID_)
		local var_9_1 = TangramPuzzleTools.GetRegionCfg(self.activityID_)

		for iter_9_0, iter_9_1 in pairs(var_9_1) do
			if not var_9_0[iter_9_0] then
				ShowTips("ACTIVITY_PUZZLE_III_AUTO_AREA")

				return
			end
		end

		local var_9_2 = false

		for iter_9_2, iter_9_3 in pairs(var_9_1) do
			if TangramPuzzleTools.CheckWrongSideByRegionID(self.activityID_, iter_9_2) then
				var_9_2 = true

				break
			end
		end

		if var_9_2 == true then
			TangramPuzzleAction.Operation(self.activityID_, TangramPuzzleAction.OPERATION_TYPE.FULL_AUTO_PUT)
		end
	end)
	self:AddBtnListener(self.rewardBtn_, nil, function()
		if not self:IsActivityTime() then
			return
		end

		manager.windowBar:HideBar()
		JumpTools.OpenPageByJump("tangramPuzzleReward", {
			activityID = self.activityID_
		})
	end)
	self:AddBtnListener(self.firstTipsBtn_, nil, function()
		self:ClickFirstTips()
	end)

	self.clueMaskListener_.isPassEvent = true
	self.clueMaskListener_.isPassAll = false
	self.clueMaskListener_.isExecuteHierarchy = true

	self.clueMaskListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerClick, LuaHelper.EventTriggerAction1(handler(self, self.OnClickClueMask)))
end

function TangramPuzzlePlayView:ClickFirstTips()
	self.isPlayingFirstTips_ = false

	TangramPuzzleData:SetFirstTips(self.activityID_, true)
	SetActive(self.firstTipsPanelGo_, false)
end

function TangramPuzzlePlayView:OnEnter()
	Input.multiTouchEnabled = false

	local var_13_0 = ActivityData:GetActivityData(self.params_.activityID)

	self.startTime_ = var_13_0.startTime
	self.stopTime_ = var_13_0.stopTime
	self.refreshTime_ = ActivityData:GetActivityRefreshTime(self.params_.activityID)

	if self.refreshTimeText_ then
		self.refreshTimeText_.text = GetTipsF("OPEN_SUFFIX", manager.time:FormatTime(self.refreshTime_))
	end

	if self.activityID_ ~= self.params_.activityID then
		self.activityID_ = self.params_.activityID
		self.puzzleCfg_ = TangramPuzzleCfg[self.params_.activityID]

		self:Spawn()
	end

	self:RefreshUI()
	SetActive(self.maskGo_, false)
	SetActive(self.autoPutPanelGo_, false)
	self.dragController_:SetSelectedState("false")

	local var_13_1, var_13_2 = self:CheckFirstEnter()

	if var_13_1 == true then
		for iter_13_0, iter_13_1 in ipairs(var_13_2) do
			TangramPuzzleData:SetFirstEnterRegionType(self.activityID_, iter_13_1, true)
		end

		self:PlayFirstEnterAnim(var_13_2)
	elseif TangramPuzzleData:GetFirstTips(self.activityID_) ~= true then
		SetActive(self.firstEnterPanelGo_, false)
		self:PlayFirstTipsAnim()
	else
		SetActive(self.firstEnterPanelGo_, false)
		SetActive(self.firstTipsPanelGo_, false)

		self.isPlayingFirstTips_ = false
	end

	self:AddTimer()
	self:RegistEventListener(ACTIVITY_UPDATE, handler(self, self.OnPuzzleActivityUpdate))
end

function TangramPuzzlePlayView:OnExit()
	Input.multiTouchEnabled = true

	manager.windowBar:HideBar()
	self:ExitEdit()
	self:StopTimer()

	if self.animtimer_ ~= nil then
		self.animtimer_:Stop()

		self.animtimer_ = nil
	end

	if self.firstAnimTimer_ then
		self.firstAnimTimer_:Stop()

		self.firstAnimTimer_ = nil
	end

	self:StopAnimNode()

	for iter_14_0, iter_14_1 in pairs(self.regionContentItemList_) do
		iter_14_1:OnExit()
	end

	for iter_14_2, iter_14_3 in pairs(self.regionItemList_) do
		iter_14_3:OnExit()
	end

	for iter_14_4, iter_14_5 in pairs(self.puzzleItemList_) do
		iter_14_5:OnExit()
	end

	self:RemoveAllEventListener()
end

function TangramPuzzlePlayView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		self.puzzleCfg_.coin_id[1][1]
	})
	manager.windowBar:SetBarCanClick(self.puzzleCfg_.coin_id[1][1], true)
	manager.windowBar:RegistBackCallBack(function()
		JumpTools.Back()
	end)
	manager.windowBar:RegistHomeCallBack(function()
		gameContext:Go("/home", nil, nil, true)
	end)
	manager.windowBar:RegistInfoCallBack(function()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = string.format(GetTips("ACTIVITY_PUZZLE_III_EXPLAIN"), ItemTools.getItemName(self.puzzleCfg_.coin_id[1][1]))
		})
	end)
end

function TangramPuzzlePlayView:Dispose()
	self.beginDragPuzzleHandler_ = nil
	self.endDragPuzzleHandler_ = nil
	self.onClickPuzzleHandler_ = nil

	self.clueMaskListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerClick)
	self:DespawnPuzzle()
	self:DespawnClue()
	self:DisposeAnimNode()
	TangramPuzzlePlayView.super.Dispose(self)
end

function TangramPuzzlePlayView:Spawn()
	self:DespawnPuzzle()
	self:SpawnPuzzle()
	self:DespawnClue()
	self:SpawnClue()
end

function TangramPuzzlePlayView:RefreshUI()
	if not TangramPuzzleTools.CheckRegionAllRight(self.activityID_) then
		self:SwitchToPlay()
		self:CheckRegionReward()
	else
		self:SwitchToFinal()
		self:CheckFinalReward()
	end

	self.completeImg_.sprite = pureGetSpriteWithoutAtlas(self.puzzleCfg_.path .. self.puzzleCfg_.album_id)

	self:RefreshTitle()
end

function TangramPuzzlePlayView:RefreshTitle()
	self.titleText_.text = ActivityToggleCfg[ActivityToggleCfg.get_id_list_by_activity_id[self.activityID_][1]].name
end

function TangramPuzzlePlayView:SwitchToPlay()
	self.curStatus_ = self.statusConst_.PLAY

	self.statusController_:SetSelectedIndex(self.curStatus_)
	self:RefreshPlayUI()
end

function TangramPuzzlePlayView:SwitchToEdit()
	self.curStatus_ = self.statusConst_.EDIT

	self.statusController_:SetSelectedIndex(self.curStatus_)
	self:RefreshEditUI()
end

function TangramPuzzlePlayView:SwitchToFinal()
	self.curStatus_ = self.statusConst_.FINAL

	self.statusController_:SetSelectedIndex(self.curStatus_)
	self:RefreshFinalUI()
end

function TangramPuzzlePlayView:RefreshPlayUI()
	self:RefreshRegionContentList()
	self:RefreshRegionList()
	self:RefreshPuzzleList()
	self:RefreshClueList()
	self:RefreshAutoPutCost()
end

function TangramPuzzlePlayView:RefreshEditUI()
	self.puzzleItemList_[self.editPuzzleIndex_]:SetSelect(true)

	local var_27_0, var_27_1 = self.puzzleItemList_[self.editPuzzleIndex_]:GetCurRegion()

	self.curValidPuzzleList_ = self.puzzleGlobalIndexListByRegionTypeAndLocalIndex_[TangramPuzzleTools.GetRegionType(self.activityID_, var_27_0)][var_27_1]

	for iter_27_0, iter_27_1 in ipairs(self.curValidPuzzleList_) do
		if self.puzzleItemList_[iter_27_1] ~= self.puzzleItemList_[self.editPuzzleIndex_] then
			self.puzzleItemList_[iter_27_1]:SetHighLight(true)
		end
	end
end

function TangramPuzzlePlayView:CanEnterEdit(arg_28_1)
	local var_28_0, var_28_1 = self.puzzleItemList_[arg_28_1]:GetCurRegion()

	if TangramPuzzleTools.CheckRegionAllRightByType(self.activityID_, (TangramPuzzleTools.GetRegionType(self.activityID_, var_28_0))) then
		return false
	end

	return true
end

function TangramPuzzlePlayView:EnterEdit(arg_29_1)
	self.editPuzzleIndex_ = arg_29_1

	self:SwitchToEdit()
end

function TangramPuzzlePlayView:ExitEdit()
	if self.curStatus_ == self.statusConst_.EDIT then
		self:ResetEditPuzzle()

		self.curStatus_ = self.statusConst_.NONE
	end
end

function TangramPuzzlePlayView:SwitchEditTarget(arg_31_1)
	if self.curStatus_ == self.statusConst_.EDIT then
		self:ResetEditPuzzle()

		self.editPuzzleIndex_ = arg_31_1

		self:RefreshEditUI()
	end
end

function TangramPuzzlePlayView:ResetEditPuzzle()
	if self.curValidPuzzleList_ then
		for iter_32_0, iter_32_1 in ipairs(self.curValidPuzzleList_) do
			self.puzzleItemList_[iter_32_1]:SetHighLight(false)
		end

		self.curValidPuzzleList_ = nil
	end

	if self.editPuzzleIndex_ then
		self.puzzleItemList_[self.editPuzzleIndex_]:SetSelect(false)

		self.editPuzzleIndex_ = nil
	end
end

function TangramPuzzlePlayView:RefreshFinalUI()
	self:RefreshClueList()

	self.finalRewardIcon_.sprite = ItemTools.getItemSprite(self.puzzleCfg_.final_reward[1][1])

	if TangramPuzzleTools.IsAllClueCompleted(self.activityID_) then
		if TangramPuzzleData:GetRegionReceivedDic(self.activityID_)[0] then
			self.finalRewardTipsText_.text = string.format(GetTips("ACTIVITY_PUZZLE_III_FINALREWARD_GET"), self.puzzleCfg_.final_reward[1][2])

			self.finalRewardController_:SetSelectedState("received")
		end
	else
		self.finalRewardTipsText_.text = string.format(GetTips("ACTIVITY_PUZZLE_III_FINALREWARD_SHOW"), self.puzzleCfg_.final_reward[1][2])

		self.finalRewardController_:SetSelectedState("normal")
	end
end

function TangramPuzzlePlayView:OnPuzzleActivityUpdate(arg_34_1)
	if arg_34_1 == self.activityID_ then
		if not self.alreadyFirstPiece then
			self:RefreshPlayUI()
		end

		local var_34_0, var_34_1 = self:CheckFirstEnter()

		if var_34_0 == true then
			self.alreadyFirstPiece = true

			for iter_34_0, iter_34_1 in ipairs(var_34_1) do
				TangramPuzzleData:SetFirstEnterRegionType(self.activityID_, iter_34_1, true)
			end

			self:PlayFirstEnterAnim(var_34_1)
		elseif TangramPuzzleData:GetFirstTips(self.activityID_) ~= true then
			SetActive(self.firstEnterPanelGo_, false)
			self:PlayFirstTipsAnim()
		else
			SetActive(self.firstEnterPanelGo_, false)
			SetActive(self.firstTipsPanelGo_, false)

			self.isPlayingFirstTips_ = false
		end
	end
end

function TangramPuzzlePlayView:OnPuzzleAutoPut()
	self:ExitEdit()

	self.blackboard_.isAutoPutPuzzle_ = true

	if not self:CheckRegionReward() then
		self:CreateAnimNodeList()
		self:StartRunAnimNode()
	end
end

function TangramPuzzlePlayView:RefreshPuzzleList()
	local var_36_0 = TangramPuzzleData:GetCurPuzzleDic(self.activityID_)

	for iter_36_0, iter_36_1 in ipairs(self.puzzleItemList_) do
		if var_36_0[iter_36_0] then
			self.puzzleItemList_[iter_36_0]:SetData(var_36_0[iter_36_0], self.activityID_)
		else
			self.puzzleItemList_[iter_36_0]:SetData(0, self.activityID_)
		end
	end
end

function TangramPuzzlePlayView:RefreshAutoPutCost()
	local var_37_0 = self.puzzleCfg_.coin_id[1]
	local var_37_1 = self.puzzleCfg_.coin_id[1][2]

	self.autoPutCostText_.text = "x" .. self.puzzleCfg_.coin_id[1][2]
	self.autoPutCostImg_.sprite = ItemTools.getItemSprite(var_37_0[1])

	self.autoPutBtnController_:SetSelectedIndex(ItemTools.getItemNum(var_37_0[1]) < var_37_1 and 1 or 0)
end

function TangramPuzzlePlayView:MovePuzzle(arg_38_1, arg_38_2, arg_38_3)
	self.blackboard_.isMoveImmediately_ = arg_38_3

	TangramPuzzleAction.MovePuzzle(self.activityID_, arg_38_1, arg_38_2)
end

function TangramPuzzlePlayView:OnMovePuzzle(arg_39_1, arg_39_2)
	self:ExitEdit()

	self.blackboard_.isMovePuzzle_ = true
	self.blackboard_.moveOriginPuzzleIndex_ = arg_39_1
	self.blackboard_.moveTargetPuzzleIndex_ = arg_39_2
	self.blackboard_.needCheckAllRightRegionType_ = true
	self.blackboard_.checkAllRightRegionTypeDic_ = self.blackboard_.checkAllRightRegionTypeDic_ or {}
	self.blackboard_.checkAllRightRegionTypeDic_[TangramPuzzleTools.GetRegionType(self.activityID_, (self.puzzleItemList_[arg_39_1]:GetCurRegion()))] = true

	if not self:CheckRegionReward() then
		self:CreateAnimNodeList()
		self:StartRunAnimNode()
	end
end

function TangramPuzzlePlayView:UpdatePuzzleData(arg_40_1)
	local var_40_0 = self.puzzleItemList_[arg_40_1]

	self.puzzleItemList_[arg_40_1]:SetData(TangramPuzzleData:GetCurPuzzleDic(self.activityID_)[arg_40_1] or 0, self.activityID_)
	var_40_0:RecoverTrans()
end

function TangramPuzzlePlayView:OnBeginDragPuzzle(arg_41_1)
	self.dragController_:SetSelectedState("true")

	if self.isPlayingFirstTips_ == true then
		self:ClickFirstTips()
	end

	self:OnClickClueMask()

	if self:CanEnterEdit(arg_41_1) then
		if self.curStatus_ == self.statusConst_.EDIT then
			self:SwitchEditTarget(arg_41_1)
		else
			self:EnterEdit(arg_41_1)
		end

		local var_41_0 = self.puzzleItemList_[arg_41_1]
		local var_41_1, var_41_2 = self.puzzleItemList_[arg_41_1]:GetCurRegion()

		self.curValidPuzzleList_ = self.puzzleGlobalIndexListByRegionTypeAndLocalIndex_[TangramPuzzleTools.GetRegionType(self.activityID_, var_41_1)][var_41_2]
		self.curValidPuzzlePosList_ = {}

		for iter_41_0, iter_41_1 in ipairs(self.curValidPuzzleList_) do
			self.curValidPuzzlePosList_[#self.curValidPuzzlePosList_ + 1] = self.puzzleItemList_[iter_41_1].transform_.position
		end

		var_41_0:SetTransParent(self.dragPanelTrans_)

		return true
	else
		return false
	end
end

function TangramPuzzlePlayView:OnDragPuzzleEnd(arg_42_1, arg_42_2)
	self.dragController_:SetSelectedState("false")

	local var_42_0, var_42_1 = TangramPuzzleTools.FindClosestTarget(self.curValidPuzzlePosList_, arg_42_2)

	if not TangramPuzzleTools.CheckValidDistanceForExchangePuzzle(self.activityID_, var_42_1) or self.puzzleItemList_[self.curValidPuzzleList_[var_42_0]] == self.puzzleItemList_[arg_42_1] then
		self.puzzleItemList_[arg_42_1]:RecoverTrans()
	else
		self:MovePuzzle(arg_42_1, self.puzzleItemList_[self.curValidPuzzleList_[var_42_0]]:GetGlobalIndex(), true)
	end
end

function TangramPuzzlePlayView:OnClickPuzzle(arg_43_1)
	if self.isPlayingFirstTips_ == true then
		self:ClickFirstTips()
	end

	self:OnClickClueMask()

	if self.curStatus_ == self.statusConst_.PLAY and self.curStatus_ ~= self.statusConst_.EDIT then
		if self:CanEnterEdit(arg_43_1) then
			self:EnterEdit(arg_43_1)
		end
	elseif self.puzzleItemList_[arg_43_1] ~= self.puzzleItemList_[self.editPuzzleIndex_] then
		self:SwitchEditTarget(arg_43_1)
	else
		self:ExitEdit()
		self:SwitchToPlay()
	end
end

function TangramPuzzlePlayView:SpawnPuzzle()
	self.regionContentItemList_ = self.regionContentItemList_ or {}
	self.regionItemList_ = self.regionItemList_ or {}
	self.puzzleItemList_ = self.puzzleItemList_ or {}

	local var_44_0 = 0
	local var_44_1 = 0

	for iter_44_0 = 1, self.regionContetnPanelTrans_.childCount do
		self.regionContentItemList_[self.puzzleCfg_.area_type_list[iter_44_0][1]] = self.regionContentItemList_[self.puzzleCfg_.area_type_list[iter_44_0][1]] or TangramRegionContentItem.New(self.regionContetnPanelTrans_:GetChild(iter_44_0 - 1).gameObject, self.puzzleCfg_.area_type_list[iter_44_0][1], self.puzzleCfg_.area_type_list[iter_44_0][2])

		local var_44_2 = self.regionContentItemList_[self.puzzleCfg_.area_type_list[iter_44_0][1]]:GetRegionContentTrans()

		for iter_44_1 = 1, var_44_2.childCount do
			var_44_0 = var_44_0 + 1
			self.regionItemList_[self.puzzleCfg_.area_type_list[iter_44_0][2][iter_44_1]] = self.regionItemList_[self.puzzleCfg_.area_type_list[iter_44_0][2][iter_44_1]] or TangramRegionItem.New(var_44_2:GetChild(iter_44_1 - 1).gameObject)
			self.regionItemList_[self.puzzleCfg_.area_type_list[iter_44_0][2][iter_44_1]].gameObject_.name = self.puzzleCfg_.area_type_list[iter_44_0][2][iter_44_1]

			local var_44_3 = self.regionItemList_[self.puzzleCfg_.area_type_list[iter_44_0][2][iter_44_1]]:GetPuzzleContent()

			for iter_44_2 = 1, var_44_3.childCount do
				var_44_1 = var_44_1 + 1

				if not self.puzzleItemList_[var_44_1] then
					local var_44_4 = TangramPuzzlePiece.New(var_44_3:GetChild(iter_44_2 - 1).gameObject, var_44_1, self.puzzleCfg_.correct_array[var_44_0][iter_44_2])

					var_44_4:RegistBeginDragCallback(self.beginDragPuzzleHandler_)
					var_44_4:RegistEndDragCallback(self.endDragPuzzleHandler_)
					var_44_4:RegistClickCallback(self.onClickPuzzleHandler_)
					var_44_4:SetRegionID(self.puzzleCfg_.area_type_list[iter_44_0][2][iter_44_1], iter_44_2)

					var_44_4.gameObject_.name = var_44_1
					self.puzzleItemList_[var_44_1] = var_44_4
					self.puzzleGlobalIndexListByRegionTypeAndLocalIndex_[self.puzzleCfg_.area_type_list[iter_44_0][1]] = self.puzzleGlobalIndexListByRegionTypeAndLocalIndex_[self.puzzleCfg_.area_type_list[iter_44_0][1]] or {}
					self.puzzleGlobalIndexListByRegionTypeAndLocalIndex_[self.puzzleCfg_.area_type_list[iter_44_0][1]][iter_44_2] = self.puzzleGlobalIndexListByRegionTypeAndLocalIndex_[self.puzzleCfg_.area_type_list[iter_44_0][1]][iter_44_2] or {}

					table.insert(self.puzzleGlobalIndexListByRegionTypeAndLocalIndex_[self.puzzleCfg_.area_type_list[iter_44_0][1]][iter_44_2], var_44_1)
				end
			end
		end
	end
end

function TangramPuzzlePlayView:DespawnPuzzle()
	for iter_45_0, iter_45_1 in pairs(self.regionContentItemList_) do
		iter_45_1:Dispose()
	end

	self.regionContentItemList_ = nil

	for iter_45_2, iter_45_3 in pairs(self.regionItemList_) do
		iter_45_3:Dispose()
	end

	self.regionItemList_ = nil

	for iter_45_4, iter_45_5 in pairs(self.puzzleItemList_) do
		iter_45_5:Dispose()
	end

	self.puzzleItemList_ = nil
end

function TangramPuzzlePlayView:RefreshRegionContentList()
	for iter_46_0, iter_46_1 in ipairs(self.regionContentItemList_) do
		iter_46_1:SetData(self.activityID_)
	end
end

function TangramPuzzlePlayView:RefreshRegionList()
	for iter_47_0, iter_47_1 in ipairs(self.regionItemList_) do
		iter_47_1:SetData(self.activityID_)
	end
end

function TangramPuzzlePlayView:OnRegionRotate(arg_48_1, arg_48_2)
	local var_48_0, var_48_1 = self.puzzleItemList_[self.editPuzzleIndex_]:GetCurRegion()
	local var_48_2 = TangramPuzzleTools.GetPuzzleGlobalIndexListByRegionID(self.activityID_)[arg_48_1]
	local var_48_3 = #var_48_2
	local var_48_4 = var_48_1 + arg_48_2

	if arg_48_2 > 0 == true and var_48_3 < var_48_4 then
		var_48_4 = var_48_4 % var_48_3
	elseif arg_48_2 > 0 == false and var_48_4 <= 0 then
		var_48_4 = var_48_4 + var_48_3
	end

	self.blackboard_.newEditIndex_ = var_48_2[var_48_4]

	self:ExitEdit()

	self.blackboard_.isRotateRegion_ = true
	self.blackboard_.rotateRegionID_ = arg_48_1
	self.blackboard_.rotateTimes_ = arg_48_2
	self.blackboard_.needCheckAllRightRegionType_ = true
	self.blackboard_.checkAllRightRegionTypeDic_ = self.blackboard_.checkAllRightRegionTypeDic_ or {}
	self.blackboard_.checkAllRightRegionTypeDic_[TangramPuzzleTools.GetRegionType(self.activityID_, arg_48_1)] = true

	if not self:CheckRegionReward() then
		self:CreateAnimNodeList()
		self:StartRunAnimNode()
	end
end

function TangramPuzzlePlayView:OnRegionReceived(arg_49_1, arg_49_2)
	self.blackboard_.isReceivedRegionReward_ = true
	self.blackboard_.receivedRegionList_ = arg_49_1
	self.blackboard_.rewardList_ = arg_49_2
	self.blackboard_.needCheckAllRightRegionType_ = true
	self.blackboard_.checkAllRightRegionTypeDic_ = self.blackboard_.checkAllRightRegionTypeDic_ or {}

	for iter_49_0, iter_49_1 in ipairs(arg_49_1) do
		self.blackboard_.checkAllRightRegionTypeDic_[TangramPuzzleTools.GetRegionType(self.activityID_, iter_49_1)] = true
	end

	self:CreateAnimNodeList()
	self:StartRunAnimNode()
end

function TangramPuzzlePlayView:CheckRegionAllRgithByRegionType(arg_50_1)
	return (TangramPuzzleTools.CheckRegionAllRightByType(self.activityID_, arg_50_1))
end

function TangramPuzzlePlayView:CheckRegionAllRight()
	return (TangramPuzzleTools.CheckRegionAllRight(self.activityID_))
end

function TangramPuzzlePlayView:CheckRegionReward()
	local var_52_0, var_52_1 = TangramPuzzleTools.CheckRegionReward(self.activityID_)

	if #var_52_0 > 0 then
		TangramPuzzleAction.ReceiveRegionReward(self.activityID_, var_52_0, var_52_1)

		return true
	end

	return false
end

function TangramPuzzlePlayView:OnClueUpdate()
	self:CheckFinalReward()
end

function TangramPuzzlePlayView:RefreshClueList()
	for iter_54_0, iter_54_1 in pairs(self.clueItemList_) do
		iter_54_1:SetData(self.activityID_, iter_54_0)
	end
end

function TangramPuzzlePlayView:OnClickClueMask()
	for iter_55_0, iter_55_1 in pairs(self.clueItemList_) do
		iter_55_1:SetTipsController(false)
	end
end

function TangramPuzzlePlayView:CheckFinalReward()
	if TangramPuzzleTools.IsAllClueCompleted(self.activityID_) and not TangramPuzzleData:IsReceivedFinalReward(self.activityID_) then
		TangramPuzzleAction.ReceiveFinalReward(self.activityID_)
	end
end

function TangramPuzzlePlayView:OnReceivedFinalReward()
	self:RefreshFinalUI()
end

function TangramPuzzlePlayView:SpawnClue()
	local var_58_0 = PuzzleNewClueCfg.get_id_list_by_main_activity_id[self.activityID_] or {}

	self.clueItemList_ = {}

	for iter_58_0 = 1, self.cluePanelTrans_.childCount do
		local var_58_1 = self.cluePanelTrans_:GetChild(iter_58_0 - 1).gameObject
		local var_58_2 = var_58_0[iter_58_0] or iter_58_0

		var_58_1.name = var_58_2
		self.clueItemList_[var_58_2] = self.clueItemList_[var_58_2] or TangramPuzzleClueItem.New(var_58_1)
	end
end

function TangramPuzzlePlayView:DespawnClue()
	for iter_59_0, iter_59_1 in pairs(self.clueItemList_) do
		iter_59_1:Dispose()
	end

	self.clueItemList_ = nil
end

function TangramPuzzlePlayView:CheckFirstEnter()
	local var_60_0 = false
	local var_60_1 = {}
	local var_60_2 = TangramPuzzleData:GetUnlockRegionDic(self.activityID_)

	for iter_60_0, iter_60_1 in pairs((TangramPuzzleTools.GetRegionListByType(self.activityID_))) do
		if not TangramPuzzleData:GetFirstEnterRegionType(self.activityID_, iter_60_0) then
			local var_60_3 = true

			for iter_60_2, iter_60_3 in ipairs(iter_60_1) do
				if not var_60_2[iter_60_3] then
					var_60_3 = false

					break
				end
			end

			if var_60_3 == true and not TangramPuzzleTools.IsAllRegionReceived(self.activityID_, iter_60_0) then
				var_60_0 = true
				var_60_1[#var_60_1 + 1] = iter_60_0
			end
		end
	end

	return var_60_0, var_60_1
end

function TangramPuzzlePlayView:PlayFirstEnterAnim(arg_61_1)
	SetActive(self.maskGo_, true)
	SetActive(self.firstEnterPanelGo_, false)
	SetActive(self.firstTipsPanelGo_, false)

	local var_61_0 = {}
	local var_61_1 = TangramPuzzleTools.GetRegionListByType(self.activityID_)

	for iter_61_0, iter_61_1 in ipairs(arg_61_1) do
		for iter_61_2, iter_61_3 in ipairs(var_61_1[iter_61_1]) do
			for iter_61_4, iter_61_5 in ipairs(TangramPuzzleTools.GetPuzzleGlobalIndexListByRegionID(self.activityID_)[iter_61_3]) do
				var_61_0[#var_61_0 + 1] = self.puzzleItemList_[iter_61_5]
			end
		end
	end

	if #var_61_0 == 0 then
		return
	end

	for iter_61_6, iter_61_7 in ipairs(var_61_0) do
		iter_61_7:SetActive(false)
	end

	self:PlayPuzzlePieceEnterAnim(var_61_0, 1)

	self.firstTipsText_.text = GetTips("ACTIVITY_PUZZLE_III_FIRSTSHOW")
end

function TangramPuzzlePlayView:PlayPuzzlePieceEnterAnim(arg_62_1, arg_62_2)
	if arg_62_2 > #arg_62_1 then
		SetActive(self.maskGo_, false)

		if not TangramPuzzleData:GetFirstEnter(self.activityID_) then
			TangramPuzzleData:SetFirstEnter(self.activityID_, true)
			SetActive(self.firstEnterPanelGo_, true)
			self:PlayAnim(self.firstEnterAnim_, "JigsawPuzzleUI_firstEnterPanel", function()
				SetActive(self.firstEnterPanelGo_, false)
				self:PlayFirstTipsAnim()
			end)
		elseif not TangramPuzzleData:GetFirstTips(self.activityID_) then
			self:PlayFirstTipsAnim()
		end

		self.alreadyFirstPiece = false

		return
	end

	arg_62_1[arg_62_2]:PlayEnterAnim(function()
		arg_62_2 = arg_62_2 + 1

		self:PlayPuzzlePieceEnterAnim(arg_62_1, arg_62_2)
	end)
	manager.audio:PlayEffect("minigame_activity_2_1", "minigame_activity_2_1_connect_cancel", "")
end

function TangramPuzzlePlayView:PlayFirstTipsAnim()
	if self.curStatus_ == self.statusConst_.FINAL then
		return
	end

	self.isPlayingFirstTips_ = true

	SetActive(self.firstTipsPanelGo_, true)

	self.firstTipsText_.text = GetTips("ACTIVITY_PUZZLE_III_FIRSTSHOW")
end

function TangramPuzzlePlayView:PlayAnim(arg_66_1, arg_66_2, arg_66_3)
	if not arg_66_1 then
		if arg_66_3 then
			arg_66_3()
		end

		return
	end

	SetActive(self.maskGo_, true)

	arg_66_1.enabled = true

	arg_66_1:Play(arg_66_2, -1, 0)
	arg_66_1:Update(0)

	if self.animtimer_ then
		self.animtimer_:Stop()

		self.animtimer_ = nil
	end

	self.animtimer_ = Timer.New(function()
		local var_67_0 = arg_66_1:GetCurrentAnimatorStateInfo(0)

		if var_67_0:IsName(arg_66_2) and var_67_0.normalizedTime >= 1 then
			if self.animtimer_ ~= nil then
				self.animtimer_:Stop()

				self.animtimer_ = nil
			end

			SetActive(self.maskGo_, false)

			if arg_66_3 then
				arg_66_3()
			end
		end
	end, 0.033, -1)

	self.animtimer_:Start()
end

function TangramPuzzlePlayView:InitAnimNode()
	self.blackboard_ = TangramPuzzleBlackboard.New()
	self.nodeDic_ = {}
	self.nodeDic_.autoPutNode = TangramAutoPutNode.New(self, self.blackboard_)
	self.nodeDic_.movePuzzleNode = TangramMovePuzzleNode.New(self, self.blackboard_)
	self.nodeDic_.movePuzzleImmediateltNode = TangramMovePuzzleImmediatelyNode.New(self, self.blackboard_)
	self.nodeDic_.rotateRegionNode = TangramRotateRegionNode.New(self, self.blackboard_)
	self.nodeDic_.receiveRegionNode = TangramRegionReceiveNode.New(self, self.blackboard_)
	self.nodeDic_.regionTypeAllRightNode = TangramRegionTypeAllRightNode.New(self, self.blackboard_)
	self.nodeDic_.switchToPlayNode = TangramSwitchToPlayNode.New(self, self.blackboard_)
	self.nodeDic_.switchToEditNode = TangramSwitchToEditNode.New(self, self.blackboard_)
	self.nodeDic_.switchToFinalNode = TangramSwitchToFinalNode.New(self, self.blackboard_)
end

function TangramPuzzlePlayView:CreateAnimNodeList()
	self.nodeList_ = {}

	if self.blackboard_.isAutoPutPuzzle_ == true then
		local var_69_0 = TangramAnimGroup.New()

		var_69_0:Init(self, self.blackboard_, self)

		local var_69_1 = self:TryToCreateAutoPutNode()

		var_69_1:Init(var_69_0, self.blackboard_, self)

		local var_69_2 = self:TryToCreateRegionTypeAllRightNode()

		var_69_2:Init(var_69_0, self.blackboard_, self)
		var_69_0:Add(var_69_1)
		var_69_0:Add(var_69_2)

		self.nodeList_[#self.nodeList_ + 1] = var_69_0
		self.blackboard_.isOnlyRegionRewardPop_ = true

		local var_69_3 = self:TryToCreateReceiveRegionNode()

		if var_69_3 then
			var_69_3:Init(self, self.blackboard_, self)

			self.nodeList_[#self.nodeList_ + 1] = var_69_3
		end

		self.blackboard_.needSwitchToPlay_ = false
		self.blackboard_.needSwitchToEdit_ = false
		self.blackboard_.needSwitchToFinal_ = true

		local var_69_4 = self:TryToCreateSwitchNode()

		if var_69_4 then
			var_69_4:Init(self, self.blackboard_, self)

			self.nodeList_[#self.nodeList_ + 1] = var_69_4
		end

		return
	end

	local var_69_5 = self:TryToCreateMovePuzzleNode()

	if var_69_5 then
		self.nodeList_[#self.nodeList_ + 1] = var_69_5
	end

	local var_69_6 = self:TryToCreateRotateRegionNode()

	if var_69_6 then
		self.nodeList_[#self.nodeList_ + 1] = var_69_6
	end

	local var_69_7 = self:TryToCreateReceiveRegionNode()

	if var_69_7 then
		self.nodeList_[#self.nodeList_ + 1] = var_69_7
	end

	local var_69_8 = self:TryToCreateRegionTypeAllRightNode()

	if var_69_8 then
		self.nodeList_[#self.nodeList_ + 1] = var_69_8
	end

	local var_69_9 = self:TryToCreateSwitchNode()

	if var_69_9 then
		self.nodeList_[#self.nodeList_ + 1] = var_69_9
	end

	for iter_69_0, iter_69_1 in ipairs(self.nodeList_) do
		iter_69_1:Init(self, self.blackboard_, self)
	end
end

function TangramPuzzlePlayView:TryToCreateAutoPutNode()
	if self.blackboard_.isAutoPutPuzzle_ == true then
		self.blackboard_.isAutoPutPuzzle_ = false
		self.blackboard_.needSwitchToFinal_ = true

		return self.nodeDic_.autoPutNode
	end
end

function TangramPuzzlePlayView:TryToCreateMovePuzzleNode()
	if self.blackboard_.isMovePuzzle_ == true then
		self.blackboard_.isMovePuzzle_ = false
		self.blackboard_.needSwitchToPlay_ = true

		return self.blackboard_.isMoveImmediately_ == true and self.nodeDic_.movePuzzleImmediateltNode or self.nodeDic_.movePuzzleNode
	end
end

function TangramPuzzlePlayView:TryToCreateRotateRegionNode()
	if self.blackboard_.isRotateRegion_ == true then
		self.blackboard_.isRotateRegion_ = false
		self.blackboard_.needSwitchToEdit_ = true

		return self.nodeDic_.rotateRegionNode
	end
end

function TangramPuzzlePlayView:TryToCreateReceiveRegionNode()
	if self.blackboard_.isReceivedRegionReward_ == true then
		self.blackboard_.isReceivedRegionReward_ = false
		self.blackboard_.needSwitchToPlay_ = true

		return self.nodeDic_.receiveRegionNode
	end
end

function TangramPuzzlePlayView:TryToCreateRegionTypeAllRightNode()
	if self.blackboard_.needCheckAllRightRegionType_ == true then
		self.blackboard_.needCheckAllRightRegionType_ = false

		local var_74_0 = {}

		for iter_74_0, iter_74_1 in pairs(self.blackboard_.checkAllRightRegionTypeDic_) do
			if self:CheckRegionAllRgithByRegionType(iter_74_0) == true then
				table.insert(var_74_0, iter_74_0)
			end
		end

		if #var_74_0 > 0 then
			self.blackboard_.allRightRegionTypeList_ = var_74_0
			self.blackboard_.needSwitchToPlay_ = true

			if self:CheckRegionAllRight() == true then
				self.blackboard_.needSwitchToPlay_ = false
				self.blackboard_.needSwitchToEdit_ = false
				self.blackboard_.needSwitchToFinal_ = true
			end

			return self.nodeDic_.regionTypeAllRightNode
		end
	end
end

function TangramPuzzlePlayView:TryToCreateSwitchNode()
	if self.blackboard_.needSwitchToPlay_ == true then
		self.blackboard_.needSwitchToPlay_ = false

		return self.nodeDic_.switchToPlayNode
	elseif self.blackboard_.needSwitchToEdit_ == true then
		self.blackboard_.needSwitchToEdit_ = false

		return self.nodeDic_.switchToEditNode
	elseif self.blackboard_.needSwitchToFinal_ == true then
		self.blackboard_.needSwitchToFinal_ = false

		return self.nodeDic_.switchToFinalNode
	end
end

function TangramPuzzlePlayView:StartRunAnimNode()
	SetActive(self.maskGo_, true)

	self.animNodeRunning_ = true
	self.curNodeIndex_ = 0

	self:RunNode()
end

function TangramPuzzlePlayView:StopAnimNode()
	SetActive(self.maskGo_, false)

	self.animNodeRunning_ = false
	self.nodeList_ = nil

	self.blackboard_:Reset()
end

function TangramPuzzlePlayView:RunNode()
	if not self.animNodeRunning_ then
		return
	end

	self.curNodeIndex_ = self.curNodeIndex_ + 1

	self.nodeList_[self.curNodeIndex_]:RunFunc()
end

function TangramPuzzlePlayView:SetNodeRunComplete()
	if not self.animNodeRunning_ or self.curNodeIndex_ >= #self.nodeList_ then
		self:StopAnimNode()

		return
	end

	self:RunNode()
end

function TangramPuzzlePlayView:DisposeAnimNode()
	if self.nodeDic_ then
		for iter_80_0, iter_80_1 in pairs(self.nodeDic_) do
			iter_80_1:Dispose()
		end

		self.nodeDic_ = nil
	end
end

function TangramPuzzlePlayView:AddTimer()
	self:StopTimer()
	self:RefreshTimeText()

	self.timer_ = Timer.New(function()
		if manager.time:GetServerTime() > self.stopTime_ then
			self.timeText_.text = GetTips("TIME_OVER")

			return
		end

		self:RefreshTimeText()
	end, 1, -1)

	self.timer_:Start()
end

function TangramPuzzlePlayView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function TangramPuzzlePlayView:RefreshTimeText()
	if self.timeText_ then
		self.timeText_.text = manager.time:GetLostTimeStr2(self.stopTime_, nil, true)
	end
end

function TangramPuzzlePlayView:IsActivityTime()
	if manager.time:GetServerTime() < self.startTime_ then
		ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr2(self.startTime_, nil, true)))

		return false
	end

	if manager.time:GetServerTime() >= self.stopTime_ then
		ShowTips("TIME_OVER")

		return false
	end

	return true
end

return TangramPuzzlePlayView

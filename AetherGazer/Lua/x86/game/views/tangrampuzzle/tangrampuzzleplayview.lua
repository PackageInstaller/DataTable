local var_0_0 = class("TangramPuzzlePlayView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return TangramPuzzleTools.GetPlayViewUIName(arg_1_0.params_.activityID)
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0.puzzleItemList_ = {}
	arg_3_0.puzzleGlobalIndexListByRegionTypeAndLocalIndex_ = {}
	arg_3_0.regionContentItemList_ = {}
	arg_3_0.regionItemList_ = {}
	arg_3_0.clueItemList_ = {}
	arg_3_0.statusConst_ = {
		PLAY = 0,
		EDIT = 1,
		FINAL = 2,
		NONE = -1
	}

	arg_3_0:InitUI()
	arg_3_0:AddUIListener()

	arg_3_0.statusController_ = ControllerUtil.GetController(arg_3_0.transform_, "status")
	arg_3_0.autoPutBtnController_ = arg_3_0.autoBtnContoller_:GetController("status")
	arg_3_0.finalRewardController_ = ControllerUtil.GetController(arg_3_0.finalRewardPanelTrans_, "status")
	arg_3_0.dragController_ = ControllerUtil.GetController(arg_3_0.transform_, "drag")
	arg_3_0.beginDragPuzzleHandler_ = handler(arg_3_0, arg_3_0.OnBeginDragPuzzle)
	arg_3_0.endDragPuzzleHandler_ = handler(arg_3_0, arg_3_0.OnDragPuzzleEnd)
	arg_3_0.onClickPuzzleHandler_ = handler(arg_3_0, arg_3_0.OnClickPuzzle)

	arg_3_0:InitAnimNode()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.exitEditBtn_, nil, function()
		arg_5_0:ExitEdit()
		arg_5_0:SwitchToPlay()
	end)
	arg_5_0:AddBtnListener(arg_5_0.rollClockwiseBtn_, nil, function()
		if not arg_5_0.editPuzzleIndex_ then
			ShowTips("ACTIVITY_PUZZLE_III_SELECT")

			return
		end

		local var_7_0, var_7_1 = arg_5_0.puzzleItemList_[arg_5_0.editPuzzleIndex_]:GetCurRegion()

		TangramPuzzleAction.RotateRegion(arg_5_0.activityID_, var_7_0, 1)
	end)
	arg_5_0:AddBtnListener(arg_5_0.rollAntiClockwiseBtn_, nil, function()
		if not arg_5_0.editPuzzleIndex_ then
			ShowTips("ACTIVITY_PUZZLE_III_SELECT")

			return
		end

		local var_8_0, var_8_1 = arg_5_0.puzzleItemList_[arg_5_0.editPuzzleIndex_]:GetCurRegion()

		TangramPuzzleAction.RotateRegion(arg_5_0.activityID_, var_8_0, -1)
	end)
	arg_5_0:AddBtnListener(arg_5_0.autoBtn_, nil, function()
		if not arg_5_0:IsActivityTime() then
			return
		end

		if arg_5_0.isPlayingFirstTips_ == true then
			arg_5_0:ClickFirstTips()
		end

		local var_9_0 = arg_5_0.puzzleCfg_.coin_id[1]
		local var_9_1 = var_9_0[1]

		if ItemTools.getItemNum(var_9_1) < var_9_0[2] then
			ShowTips("ACTIVITY_PUZZLE_III_NOT_ENOUGH")

			return
		end

		local var_9_2 = TangramPuzzleData:GetUnlockRegionDic(arg_5_0.activityID_)
		local var_9_3 = TangramPuzzleTools.GetRegionCfg(arg_5_0.activityID_)

		for iter_9_0, iter_9_1 in pairs(var_9_3) do
			if not var_9_2[iter_9_0] then
				ShowTips("ACTIVITY_PUZZLE_III_AUTO_AREA")

				return
			end
		end

		local var_9_4 = false

		for iter_9_2, iter_9_3 in pairs(var_9_3) do
			if TangramPuzzleTools.CheckWrongSideByRegionID(arg_5_0.activityID_, iter_9_2) then
				var_9_4 = true

				break
			end
		end

		if var_9_4 == true then
			TangramPuzzleAction.Operation(arg_5_0.activityID_, TangramPuzzleAction.OPERATION_TYPE.FULL_AUTO_PUT)
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.rewardBtn_, nil, function()
		if not arg_5_0:IsActivityTime() then
			return
		end

		manager.windowBar:HideBar()
		JumpTools.OpenPageByJump("tangramPuzzleReward", {
			activityID = arg_5_0.activityID_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.firstTipsBtn_, nil, function()
		arg_5_0:ClickFirstTips()
	end)

	arg_5_0.clueMaskListener_.isPassEvent = true
	arg_5_0.clueMaskListener_.isPassAll = false
	arg_5_0.clueMaskListener_.isExecuteHierarchy = true

	arg_5_0.clueMaskListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerClick, LuaHelper.EventTriggerAction1(handler(arg_5_0, arg_5_0.OnClickClueMask)))
end

function var_0_0.ClickFirstTips(arg_12_0)
	arg_12_0.isPlayingFirstTips_ = false

	TangramPuzzleData:SetFirstTips(arg_12_0.activityID_, true)
	SetActive(arg_12_0.firstTipsPanelGo_, false)
end

function var_0_0.OnEnter(arg_13_0)
	Input.multiTouchEnabled = false

	local var_13_0 = ActivityData:GetActivityData(arg_13_0.params_.activityID)

	arg_13_0.startTime_ = var_13_0.startTime
	arg_13_0.stopTime_ = var_13_0.stopTime
	arg_13_0.refreshTime_ = ActivityData:GetActivityRefreshTime(arg_13_0.params_.activityID)

	if arg_13_0.refreshTimeText_ then
		arg_13_0.refreshTimeText_.text = GetTipsF("OPEN_SUFFIX", manager.time:FormatTime(arg_13_0.refreshTime_))
	end

	if arg_13_0.activityID_ ~= arg_13_0.params_.activityID then
		arg_13_0.activityID_ = arg_13_0.params_.activityID
		arg_13_0.puzzleCfg_ = TangramPuzzleCfg[arg_13_0.params_.activityID]

		arg_13_0:Spawn()
	end

	arg_13_0:RefreshUI()
	SetActive(arg_13_0.maskGo_, false)
	SetActive(arg_13_0.autoPutPanelGo_, false)
	arg_13_0.dragController_:SetSelectedState("false")

	local var_13_1, var_13_2 = arg_13_0:CheckFirstEnter()

	if var_13_1 == true then
		for iter_13_0, iter_13_1 in ipairs(var_13_2) do
			TangramPuzzleData:SetFirstEnterRegionType(arg_13_0.activityID_, iter_13_1, true)
		end

		arg_13_0:PlayFirstEnterAnim(var_13_2)
	elseif TangramPuzzleData:GetFirstTips(arg_13_0.activityID_) ~= true then
		SetActive(arg_13_0.firstEnterPanelGo_, false)
		arg_13_0:PlayFirstTipsAnim()
	else
		SetActive(arg_13_0.firstEnterPanelGo_, false)
		SetActive(arg_13_0.firstTipsPanelGo_, false)

		arg_13_0.isPlayingFirstTips_ = false
	end

	arg_13_0:AddTimer()
	arg_13_0:RegistEventListener(ACTIVITY_UPDATE, handler(arg_13_0, arg_13_0.OnPuzzleActivityUpdate))
end

function var_0_0.OnExit(arg_14_0)
	Input.multiTouchEnabled = true

	manager.windowBar:HideBar()
	arg_14_0:ExitEdit()
	arg_14_0:StopTimer()

	if arg_14_0.animtimer_ ~= nil then
		arg_14_0.animtimer_:Stop()

		arg_14_0.animtimer_ = nil
	end

	if arg_14_0.firstAnimTimer_ then
		arg_14_0.firstAnimTimer_:Stop()

		arg_14_0.firstAnimTimer_ = nil
	end

	arg_14_0:StopAnimNode()

	for iter_14_0, iter_14_1 in pairs(arg_14_0.regionContentItemList_) do
		iter_14_1:OnExit()
	end

	for iter_14_2, iter_14_3 in pairs(arg_14_0.regionItemList_) do
		iter_14_3:OnExit()
	end

	for iter_14_4, iter_14_5 in pairs(arg_14_0.puzzleItemList_) do
		iter_14_5:OnExit()
	end

	arg_14_0:RemoveAllEventListener()
end

function var_0_0.OnTop(arg_15_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		arg_15_0.puzzleCfg_.coin_id[1][1]
	})
	manager.windowBar:SetBarCanClick(arg_15_0.puzzleCfg_.coin_id[1][1], true)
	manager.windowBar:RegistBackCallBack(function()
		JumpTools.Back()
	end)
	manager.windowBar:RegistHomeCallBack(function()
		gameContext:Go("/home", nil, nil, true)
	end)
	manager.windowBar:RegistInfoCallBack(function()
		local var_18_0 = arg_15_0.puzzleCfg_.coin_id[1][1]
		local var_18_1 = string.format(GetTips("ACTIVITY_PUZZLE_III_EXPLAIN"), ItemTools.getItemName(var_18_0))

		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = var_18_1
		})
	end)
end

function var_0_0.Dispose(arg_19_0)
	arg_19_0.beginDragPuzzleHandler_ = nil
	arg_19_0.endDragPuzzleHandler_ = nil
	arg_19_0.onClickPuzzleHandler_ = nil

	arg_19_0.clueMaskListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerClick)
	arg_19_0:DespawnPuzzle()
	arg_19_0:DespawnClue()
	arg_19_0:DisposeAnimNode()
	var_0_0.super.Dispose(arg_19_0)
end

function var_0_0.Spawn(arg_20_0)
	arg_20_0:DespawnPuzzle()
	arg_20_0:SpawnPuzzle()
	arg_20_0:DespawnClue()
	arg_20_0:SpawnClue()
end

function var_0_0.RefreshUI(arg_21_0)
	if not TangramPuzzleTools.CheckRegionAllRight(arg_21_0.activityID_) then
		arg_21_0:SwitchToPlay()
		arg_21_0:CheckRegionReward()
	else
		arg_21_0:SwitchToFinal()
		arg_21_0:CheckFinalReward()
	end

	arg_21_0.completeImg_.sprite = pureGetSpriteWithoutAtlas(arg_21_0.puzzleCfg_.path .. arg_21_0.puzzleCfg_.album_id)

	arg_21_0:RefreshTitle()
end

function var_0_0.RefreshTitle(arg_22_0)
	local var_22_0 = ActivityToggleCfg.get_id_list_by_activity_id[arg_22_0.activityID_][1]

	arg_22_0.titleText_.text = ActivityToggleCfg[var_22_0].name
end

function var_0_0.SwitchToPlay(arg_23_0)
	arg_23_0.curStatus_ = arg_23_0.statusConst_.PLAY

	arg_23_0.statusController_:SetSelectedIndex(arg_23_0.curStatus_)
	arg_23_0:RefreshPlayUI()
end

function var_0_0.SwitchToEdit(arg_24_0)
	arg_24_0.curStatus_ = arg_24_0.statusConst_.EDIT

	arg_24_0.statusController_:SetSelectedIndex(arg_24_0.curStatus_)
	arg_24_0:RefreshEditUI()
end

function var_0_0.SwitchToFinal(arg_25_0)
	arg_25_0.curStatus_ = arg_25_0.statusConst_.FINAL

	arg_25_0.statusController_:SetSelectedIndex(arg_25_0.curStatus_)
	arg_25_0:RefreshFinalUI()
end

function var_0_0.RefreshPlayUI(arg_26_0)
	arg_26_0:RefreshRegionContentList()
	arg_26_0:RefreshRegionList()
	arg_26_0:RefreshPuzzleList()
	arg_26_0:RefreshClueList()
	arg_26_0:RefreshAutoPutCost()
end

function var_0_0.RefreshEditUI(arg_27_0)
	local var_27_0 = arg_27_0.puzzleItemList_[arg_27_0.editPuzzleIndex_]

	var_27_0:SetSelect(true)

	local var_27_1, var_27_2 = var_27_0:GetCurRegion()
	local var_27_3 = TangramPuzzleTools.GetRegionType(arg_27_0.activityID_, var_27_1)

	arg_27_0.curValidPuzzleList_ = arg_27_0.puzzleGlobalIndexListByRegionTypeAndLocalIndex_[var_27_3][var_27_2]

	for iter_27_0, iter_27_1 in ipairs(arg_27_0.curValidPuzzleList_) do
		local var_27_4 = arg_27_0.puzzleItemList_[iter_27_1]

		if var_27_4 ~= var_27_0 then
			var_27_4:SetHighLight(true)
		end
	end
end

function var_0_0.CanEnterEdit(arg_28_0, arg_28_1)
	local var_28_0, var_28_1 = arg_28_0.puzzleItemList_[arg_28_1]:GetCurRegion()
	local var_28_2 = TangramPuzzleTools.GetRegionType(arg_28_0.activityID_, var_28_0)

	if TangramPuzzleTools.CheckRegionAllRightByType(arg_28_0.activityID_, var_28_2) then
		return false
	end

	return true
end

function var_0_0.EnterEdit(arg_29_0, arg_29_1)
	arg_29_0.editPuzzleIndex_ = arg_29_1

	arg_29_0:SwitchToEdit()
end

function var_0_0.ExitEdit(arg_30_0)
	if arg_30_0.curStatus_ == arg_30_0.statusConst_.EDIT then
		arg_30_0:ResetEditPuzzle()

		arg_30_0.curStatus_ = arg_30_0.statusConst_.NONE
	end
end

function var_0_0.SwitchEditTarget(arg_31_0, arg_31_1)
	if arg_31_0.curStatus_ == arg_31_0.statusConst_.EDIT then
		arg_31_0:ResetEditPuzzle()

		arg_31_0.editPuzzleIndex_ = arg_31_1

		arg_31_0:RefreshEditUI()
	end
end

function var_0_0.ResetEditPuzzle(arg_32_0)
	if arg_32_0.curValidPuzzleList_ then
		for iter_32_0, iter_32_1 in ipairs(arg_32_0.curValidPuzzleList_) do
			arg_32_0.puzzleItemList_[iter_32_1]:SetHighLight(false)
		end

		arg_32_0.curValidPuzzleList_ = nil
	end

	if arg_32_0.editPuzzleIndex_ then
		arg_32_0.puzzleItemList_[arg_32_0.editPuzzleIndex_]:SetSelect(false)

		arg_32_0.editPuzzleIndex_ = nil
	end
end

function var_0_0.RefreshFinalUI(arg_33_0)
	arg_33_0:RefreshClueList()

	local var_33_0 = arg_33_0.puzzleCfg_.final_reward[1][1]
	local var_33_1 = arg_33_0.puzzleCfg_.final_reward[1][2]

	arg_33_0.finalRewardIcon_.sprite = ItemTools.getItemSprite(var_33_0)

	if TangramPuzzleTools.IsAllClueCompleted(arg_33_0.activityID_) then
		if TangramPuzzleData:GetRegionReceivedDic(arg_33_0.activityID_)[0] then
			arg_33_0.finalRewardTipsText_.text = string.format(GetTips("ACTIVITY_PUZZLE_III_FINALREWARD_GET"), var_33_1)

			arg_33_0.finalRewardController_:SetSelectedState("received")
		end
	else
		arg_33_0.finalRewardTipsText_.text = string.format(GetTips("ACTIVITY_PUZZLE_III_FINALREWARD_SHOW"), var_33_1)

		arg_33_0.finalRewardController_:SetSelectedState("normal")
	end
end

function var_0_0.OnPuzzleActivityUpdate(arg_34_0, arg_34_1)
	if arg_34_1 == arg_34_0.activityID_ then
		if not arg_34_0.alreadyFirstPiece then
			arg_34_0:RefreshPlayUI()
		end

		local var_34_0, var_34_1 = arg_34_0:CheckFirstEnter()

		if var_34_0 == true then
			arg_34_0.alreadyFirstPiece = true

			for iter_34_0, iter_34_1 in ipairs(var_34_1) do
				TangramPuzzleData:SetFirstEnterRegionType(arg_34_0.activityID_, iter_34_1, true)
			end

			arg_34_0:PlayFirstEnterAnim(var_34_1)
		elseif TangramPuzzleData:GetFirstTips(arg_34_0.activityID_) ~= true then
			SetActive(arg_34_0.firstEnterPanelGo_, false)
			arg_34_0:PlayFirstTipsAnim()
		else
			SetActive(arg_34_0.firstEnterPanelGo_, false)
			SetActive(arg_34_0.firstTipsPanelGo_, false)

			arg_34_0.isPlayingFirstTips_ = false
		end
	end
end

function var_0_0.OnPuzzleAutoPut(arg_35_0)
	arg_35_0:ExitEdit()

	arg_35_0.blackboard_.isAutoPutPuzzle_ = true

	if not arg_35_0:CheckRegionReward() then
		arg_35_0:CreateAnimNodeList()
		arg_35_0:StartRunAnimNode()
	end
end

function var_0_0.RefreshPuzzleList(arg_36_0)
	local var_36_0 = TangramPuzzleData:GetCurPuzzleDic(arg_36_0.activityID_)

	for iter_36_0, iter_36_1 in ipairs(arg_36_0.puzzleItemList_) do
		if var_36_0[iter_36_0] then
			arg_36_0.puzzleItemList_[iter_36_0]:SetData(var_36_0[iter_36_0], arg_36_0.activityID_)
		else
			arg_36_0.puzzleItemList_[iter_36_0]:SetData(0, arg_36_0.activityID_)
		end
	end
end

function var_0_0.RefreshAutoPutCost(arg_37_0)
	local var_37_0 = arg_37_0.puzzleCfg_.coin_id[1]
	local var_37_1 = var_37_0[2]

	arg_37_0.autoPutCostText_.text = "x" .. var_37_1
	arg_37_0.autoPutCostImg_.sprite = ItemTools.getItemSprite(var_37_0[1])

	local var_37_2 = ItemTools.getItemNum(var_37_0[1])

	arg_37_0.autoPutBtnController_:SetSelectedIndex(var_37_2 < var_37_1 and 1 or 0)
end

function var_0_0.MovePuzzle(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
	arg_38_0.blackboard_.isMoveImmediately_ = arg_38_3

	TangramPuzzleAction.MovePuzzle(arg_38_0.activityID_, arg_38_1, arg_38_2)
end

function var_0_0.OnMovePuzzle(arg_39_0, arg_39_1, arg_39_2)
	arg_39_0:ExitEdit()

	arg_39_0.blackboard_.isMovePuzzle_ = true
	arg_39_0.blackboard_.moveOriginPuzzleIndex_ = arg_39_1
	arg_39_0.blackboard_.moveTargetPuzzleIndex_ = arg_39_2

	local var_39_0 = arg_39_0.puzzleItemList_[arg_39_1]:GetCurRegion()
	local var_39_1 = TangramPuzzleTools.GetRegionType(arg_39_0.activityID_, var_39_0)

	arg_39_0.blackboard_.needCheckAllRightRegionType_ = true
	arg_39_0.blackboard_.checkAllRightRegionTypeDic_ = arg_39_0.blackboard_.checkAllRightRegionTypeDic_ or {}
	arg_39_0.blackboard_.checkAllRightRegionTypeDic_[var_39_1] = true

	if not arg_39_0:CheckRegionReward() then
		arg_39_0:CreateAnimNodeList()
		arg_39_0:StartRunAnimNode()
	end
end

function var_0_0.UpdatePuzzleData(arg_40_0, arg_40_1)
	local var_40_0 = TangramPuzzleData:GetCurPuzzleDic(arg_40_0.activityID_)[arg_40_1] or 0
	local var_40_1 = arg_40_0.puzzleItemList_[arg_40_1]

	var_40_1:SetData(var_40_0, arg_40_0.activityID_)
	var_40_1:RecoverTrans()
end

function var_0_0.OnBeginDragPuzzle(arg_41_0, arg_41_1)
	arg_41_0.dragController_:SetSelectedState("true")

	if arg_41_0.isPlayingFirstTips_ == true then
		arg_41_0:ClickFirstTips()
	end

	arg_41_0:OnClickClueMask()

	if arg_41_0:CanEnterEdit(arg_41_1) then
		if arg_41_0.curStatus_ == arg_41_0.statusConst_.EDIT then
			arg_41_0:SwitchEditTarget(arg_41_1)
		else
			arg_41_0:EnterEdit(arg_41_1)
		end

		local var_41_0 = arg_41_0.puzzleItemList_[arg_41_1]
		local var_41_1, var_41_2 = var_41_0:GetCurRegion()
		local var_41_3 = TangramPuzzleTools.GetRegionType(arg_41_0.activityID_, var_41_1)

		arg_41_0.curValidPuzzleList_ = arg_41_0.puzzleGlobalIndexListByRegionTypeAndLocalIndex_[var_41_3][var_41_2]
		arg_41_0.curValidPuzzlePosList_ = {}

		for iter_41_0, iter_41_1 in ipairs(arg_41_0.curValidPuzzleList_) do
			arg_41_0.curValidPuzzlePosList_[#arg_41_0.curValidPuzzlePosList_ + 1] = arg_41_0.puzzleItemList_[iter_41_1].transform_.position
		end

		var_41_0:SetTransParent(arg_41_0.dragPanelTrans_)

		return true
	else
		return false
	end
end

function var_0_0.OnDragPuzzleEnd(arg_42_0, arg_42_1, arg_42_2)
	arg_42_0.dragController_:SetSelectedState("false")

	local var_42_0 = arg_42_0.puzzleItemList_[arg_42_1]
	local var_42_1, var_42_2 = TangramPuzzleTools.FindClosestTarget(arg_42_0.curValidPuzzlePosList_, arg_42_2)
	local var_42_3 = arg_42_0.curValidPuzzleList_[var_42_1]
	local var_42_4 = arg_42_0.puzzleItemList_[var_42_3]

	if not TangramPuzzleTools.CheckValidDistanceForExchangePuzzle(arg_42_0.activityID_, var_42_2) or var_42_4 == var_42_0 then
		var_42_0:RecoverTrans()
	else
		local var_42_5 = var_42_4:GetGlobalIndex()

		arg_42_0:MovePuzzle(arg_42_1, var_42_5, true)
	end
end

function var_0_0.OnClickPuzzle(arg_43_0, arg_43_1)
	if arg_43_0.isPlayingFirstTips_ == true then
		arg_43_0:ClickFirstTips()
	end

	arg_43_0:OnClickClueMask()

	if arg_43_0.curStatus_ == arg_43_0.statusConst_.PLAY and arg_43_0.curStatus_ ~= arg_43_0.statusConst_.EDIT then
		if arg_43_0:CanEnterEdit(arg_43_1) then
			arg_43_0:EnterEdit(arg_43_1)
		end
	elseif arg_43_0.puzzleItemList_[arg_43_1] ~= arg_43_0.puzzleItemList_[arg_43_0.editPuzzleIndex_] then
		arg_43_0:SwitchEditTarget(arg_43_1)
	else
		arg_43_0:ExitEdit()
		arg_43_0:SwitchToPlay()
	end
end

function var_0_0.SpawnPuzzle(arg_44_0)
	local var_44_0 = arg_44_0.puzzleCfg_.area_type_list

	arg_44_0.regionContentItemList_ = arg_44_0.regionContentItemList_ or {}
	arg_44_0.regionItemList_ = arg_44_0.regionItemList_ or {}
	arg_44_0.puzzleItemList_ = arg_44_0.puzzleItemList_ or {}

	local var_44_1 = 0
	local var_44_2 = 0
	local var_44_3 = arg_44_0.regionContetnPanelTrans_.childCount

	for iter_44_0 = 1, var_44_3 do
		local var_44_4 = arg_44_0.regionContetnPanelTrans_:GetChild(iter_44_0 - 1).gameObject
		local var_44_5 = var_44_0[iter_44_0][1]
		local var_44_6 = var_44_0[iter_44_0][2]

		if not arg_44_0.regionContentItemList_[var_44_5] then
			arg_44_0.regionContentItemList_[var_44_5] = TangramRegionContentItem.New(var_44_4, var_44_5, var_44_6)
		end

		local var_44_7 = arg_44_0.regionContentItemList_[var_44_5]:GetRegionContentTrans()
		local var_44_8 = var_44_7.childCount

		for iter_44_1 = 1, var_44_8 do
			var_44_1 = var_44_1 + 1

			local var_44_9 = var_44_7:GetChild(iter_44_1 - 1).gameObject
			local var_44_10 = var_44_6[iter_44_1]

			if not arg_44_0.regionItemList_[var_44_10] then
				arg_44_0.regionItemList_[var_44_10] = TangramRegionItem.New(var_44_9)
			end

			arg_44_0.regionItemList_[var_44_10].gameObject_.name = var_44_10

			local var_44_11 = arg_44_0.puzzleCfg_.correct_array[var_44_1]
			local var_44_12 = arg_44_0.regionItemList_[var_44_10]:GetPuzzleContent()
			local var_44_13 = var_44_12.childCount

			for iter_44_2 = 1, var_44_13 do
				var_44_2 = var_44_2 + 1

				local var_44_14 = var_44_12:GetChild(iter_44_2 - 1).gameObject

				if not arg_44_0.puzzleItemList_[var_44_2] then
					local var_44_15 = var_44_11[iter_44_2]
					local var_44_16 = TangramPuzzlePiece.New(var_44_14, var_44_2, var_44_15)

					var_44_16:RegistBeginDragCallback(arg_44_0.beginDragPuzzleHandler_)
					var_44_16:RegistEndDragCallback(arg_44_0.endDragPuzzleHandler_)
					var_44_16:RegistClickCallback(arg_44_0.onClickPuzzleHandler_)
					var_44_16:SetRegionID(var_44_10, iter_44_2)

					var_44_16.gameObject_.name = var_44_2
					arg_44_0.puzzleItemList_[var_44_2] = var_44_16
					arg_44_0.puzzleGlobalIndexListByRegionTypeAndLocalIndex_[var_44_5] = arg_44_0.puzzleGlobalIndexListByRegionTypeAndLocalIndex_[var_44_5] or {}
					arg_44_0.puzzleGlobalIndexListByRegionTypeAndLocalIndex_[var_44_5][iter_44_2] = arg_44_0.puzzleGlobalIndexListByRegionTypeAndLocalIndex_[var_44_5][iter_44_2] or {}

					table.insert(arg_44_0.puzzleGlobalIndexListByRegionTypeAndLocalIndex_[var_44_5][iter_44_2], var_44_2)
				end
			end
		end
	end
end

function var_0_0.DespawnPuzzle(arg_45_0)
	for iter_45_0, iter_45_1 in pairs(arg_45_0.regionContentItemList_) do
		iter_45_1:Dispose()
	end

	arg_45_0.regionContentItemList_ = nil

	for iter_45_2, iter_45_3 in pairs(arg_45_0.regionItemList_) do
		iter_45_3:Dispose()
	end

	arg_45_0.regionItemList_ = nil

	for iter_45_4, iter_45_5 in pairs(arg_45_0.puzzleItemList_) do
		iter_45_5:Dispose()
	end

	arg_45_0.puzzleItemList_ = nil
end

function var_0_0.RefreshRegionContentList(arg_46_0)
	for iter_46_0, iter_46_1 in ipairs(arg_46_0.regionContentItemList_) do
		iter_46_1:SetData(arg_46_0.activityID_)
	end
end

function var_0_0.RefreshRegionList(arg_47_0)
	for iter_47_0, iter_47_1 in ipairs(arg_47_0.regionItemList_) do
		iter_47_1:SetData(arg_47_0.activityID_)
	end
end

function var_0_0.OnRegionRotate(arg_48_0, arg_48_1, arg_48_2)
	local var_48_0, var_48_1 = arg_48_0.puzzleItemList_[arg_48_0.editPuzzleIndex_]:GetCurRegion()
	local var_48_2 = TangramPuzzleTools.GetPuzzleGlobalIndexListByRegionID(arg_48_0.activityID_)[arg_48_1]
	local var_48_3 = #var_48_2
	local var_48_4 = arg_48_2 > 0
	local var_48_5 = var_48_1 + arg_48_2

	if var_48_4 == true and var_48_3 < var_48_5 then
		var_48_5 = var_48_5 % var_48_3
	elseif var_48_4 == false and var_48_5 <= 0 then
		var_48_5 = var_48_5 + var_48_3
	end

	local var_48_6 = var_48_2[var_48_5]

	arg_48_0.blackboard_.newEditIndex_ = var_48_6

	arg_48_0:ExitEdit()

	arg_48_0.blackboard_.isRotateRegion_ = true
	arg_48_0.blackboard_.rotateRegionID_ = arg_48_1
	arg_48_0.blackboard_.rotateTimes_ = arg_48_2

	local var_48_7 = TangramPuzzleTools.GetRegionType(arg_48_0.activityID_, arg_48_1)

	arg_48_0.blackboard_.needCheckAllRightRegionType_ = true
	arg_48_0.blackboard_.checkAllRightRegionTypeDic_ = arg_48_0.blackboard_.checkAllRightRegionTypeDic_ or {}
	arg_48_0.blackboard_.checkAllRightRegionTypeDic_[var_48_7] = true

	if not arg_48_0:CheckRegionReward() then
		arg_48_0:CreateAnimNodeList()
		arg_48_0:StartRunAnimNode()
	end
end

function var_0_0.OnRegionReceived(arg_49_0, arg_49_1, arg_49_2)
	arg_49_0.blackboard_.isReceivedRegionReward_ = true
	arg_49_0.blackboard_.receivedRegionList_ = arg_49_1
	arg_49_0.blackboard_.rewardList_ = arg_49_2
	arg_49_0.blackboard_.needCheckAllRightRegionType_ = true
	arg_49_0.blackboard_.checkAllRightRegionTypeDic_ = arg_49_0.blackboard_.checkAllRightRegionTypeDic_ or {}

	for iter_49_0, iter_49_1 in ipairs(arg_49_1) do
		local var_49_0 = TangramPuzzleTools.GetRegionType(arg_49_0.activityID_, iter_49_1)

		arg_49_0.blackboard_.checkAllRightRegionTypeDic_[var_49_0] = true
	end

	arg_49_0:CreateAnimNodeList()
	arg_49_0:StartRunAnimNode()
end

function var_0_0.CheckRegionAllRgithByRegionType(arg_50_0, arg_50_1)
	return (TangramPuzzleTools.CheckRegionAllRightByType(arg_50_0.activityID_, arg_50_1))
end

function var_0_0.CheckRegionAllRight(arg_51_0)
	return (TangramPuzzleTools.CheckRegionAllRight(arg_51_0.activityID_))
end

function var_0_0.CheckRegionReward(arg_52_0)
	local var_52_0, var_52_1 = TangramPuzzleTools.CheckRegionReward(arg_52_0.activityID_)

	if #var_52_0 > 0 then
		TangramPuzzleAction.ReceiveRegionReward(arg_52_0.activityID_, var_52_0, var_52_1)

		return true
	end

	return false
end

function var_0_0.OnClueUpdate(arg_53_0)
	arg_53_0:CheckFinalReward()
end

function var_0_0.RefreshClueList(arg_54_0)
	for iter_54_0, iter_54_1 in pairs(arg_54_0.clueItemList_) do
		iter_54_1:SetData(arg_54_0.activityID_, iter_54_0)
	end
end

function var_0_0.OnClickClueMask(arg_55_0)
	for iter_55_0, iter_55_1 in pairs(arg_55_0.clueItemList_) do
		iter_55_1:SetTipsController(false)
	end
end

function var_0_0.CheckFinalReward(arg_56_0)
	if TangramPuzzleTools.IsAllClueCompleted(arg_56_0.activityID_) and not TangramPuzzleData:IsReceivedFinalReward(arg_56_0.activityID_) then
		TangramPuzzleAction.ReceiveFinalReward(arg_56_0.activityID_)
	end
end

function var_0_0.OnReceivedFinalReward(arg_57_0)
	arg_57_0:RefreshFinalUI()
end

function var_0_0.SpawnClue(arg_58_0)
	local var_58_0 = PuzzleNewClueCfg.get_id_list_by_main_activity_id[arg_58_0.activityID_] or {}

	arg_58_0.clueItemList_ = {}

	local var_58_1 = arg_58_0.cluePanelTrans_.childCount

	for iter_58_0 = 1, var_58_1 do
		local var_58_2 = arg_58_0.cluePanelTrans_:GetChild(iter_58_0 - 1).gameObject
		local var_58_3 = var_58_0[iter_58_0] or iter_58_0

		var_58_2.name = var_58_3

		if not arg_58_0.clueItemList_[var_58_3] then
			arg_58_0.clueItemList_[var_58_3] = TangramPuzzleClueItem.New(var_58_2)
		end
	end
end

function var_0_0.DespawnClue(arg_59_0)
	for iter_59_0, iter_59_1 in pairs(arg_59_0.clueItemList_) do
		iter_59_1:Dispose()
	end

	arg_59_0.clueItemList_ = nil
end

function var_0_0.CheckFirstEnter(arg_60_0)
	local var_60_0 = false
	local var_60_1 = {}
	local var_60_2 = TangramPuzzleData:GetUnlockRegionDic(arg_60_0.activityID_)
	local var_60_3 = TangramPuzzleTools.GetRegionListByType(arg_60_0.activityID_)

	for iter_60_0, iter_60_1 in pairs(var_60_3) do
		if not TangramPuzzleData:GetFirstEnterRegionType(arg_60_0.activityID_, iter_60_0) then
			local var_60_4 = true

			for iter_60_2, iter_60_3 in ipairs(iter_60_1) do
				if not var_60_2[iter_60_3] then
					var_60_4 = false

					break
				end
			end

			if var_60_4 == true and not TangramPuzzleTools.IsAllRegionReceived(arg_60_0.activityID_, iter_60_0) then
				var_60_0 = true
				var_60_1[#var_60_1 + 1] = iter_60_0
			end
		end
	end

	return var_60_0, var_60_1
end

function var_0_0.PlayFirstEnterAnim(arg_61_0, arg_61_1)
	SetActive(arg_61_0.maskGo_, true)
	SetActive(arg_61_0.firstEnterPanelGo_, false)
	SetActive(arg_61_0.firstTipsPanelGo_, false)

	local var_61_0 = {}
	local var_61_1 = TangramPuzzleTools.GetRegionListByType(arg_61_0.activityID_)

	for iter_61_0, iter_61_1 in ipairs(arg_61_1) do
		local var_61_2 = var_61_1[iter_61_1]

		for iter_61_2, iter_61_3 in ipairs(var_61_2) do
			local var_61_3 = TangramPuzzleTools.GetPuzzleGlobalIndexListByRegionID(arg_61_0.activityID_)[iter_61_3]

			for iter_61_4, iter_61_5 in ipairs(var_61_3) do
				var_61_0[#var_61_0 + 1] = arg_61_0.puzzleItemList_[iter_61_5]
			end
		end
	end

	if #var_61_0 == 0 then
		return
	end

	for iter_61_6, iter_61_7 in ipairs(var_61_0) do
		iter_61_7:SetActive(false)
	end

	arg_61_0:PlayPuzzlePieceEnterAnim(var_61_0, 1)

	arg_61_0.firstTipsText_.text = GetTips("ACTIVITY_PUZZLE_III_FIRSTSHOW")
end

function var_0_0.PlayPuzzlePieceEnterAnim(arg_62_0, arg_62_1, arg_62_2)
	if arg_62_2 > #arg_62_1 then
		SetActive(arg_62_0.maskGo_, false)

		if not TangramPuzzleData:GetFirstEnter(arg_62_0.activityID_) then
			TangramPuzzleData:SetFirstEnter(arg_62_0.activityID_, true)
			SetActive(arg_62_0.firstEnterPanelGo_, true)
			arg_62_0:PlayAnim(arg_62_0.firstEnterAnim_, "JigsawPuzzleUI_firstEnterPanel", function()
				SetActive(arg_62_0.firstEnterPanelGo_, false)
				arg_62_0:PlayFirstTipsAnim()
			end)
		elseif not TangramPuzzleData:GetFirstTips(arg_62_0.activityID_) then
			arg_62_0:PlayFirstTipsAnim()
		end

		arg_62_0.alreadyFirstPiece = false

		return
	end

	arg_62_1[arg_62_2]:PlayEnterAnim(function()
		arg_62_2 = arg_62_2 + 1

		arg_62_0:PlayPuzzlePieceEnterAnim(arg_62_1, arg_62_2)
	end)
	manager.audio:PlayEffect("minigame_activity_2_1", "minigame_activity_2_1_connect_cancel", "")
end

function var_0_0.PlayFirstTipsAnim(arg_65_0)
	if arg_65_0.curStatus_ == arg_65_0.statusConst_.FINAL then
		return
	end

	arg_65_0.isPlayingFirstTips_ = true

	SetActive(arg_65_0.firstTipsPanelGo_, true)

	arg_65_0.firstTipsText_.text = GetTips("ACTIVITY_PUZZLE_III_FIRSTSHOW")
end

function var_0_0.PlayAnim(arg_66_0, arg_66_1, arg_66_2, arg_66_3)
	if not arg_66_1 then
		if arg_66_3 then
			arg_66_3()
		end

		return
	end

	SetActive(arg_66_0.maskGo_, true)

	arg_66_1.enabled = true

	arg_66_1:Play(arg_66_2, -1, 0)
	arg_66_1:Update(0)

	if arg_66_0.animtimer_ then
		arg_66_0.animtimer_:Stop()

		arg_66_0.animtimer_ = nil
	end

	arg_66_0.animtimer_ = Timer.New(function()
		local var_67_0 = arg_66_1:GetCurrentAnimatorStateInfo(0)

		if var_67_0:IsName(arg_66_2) and var_67_0.normalizedTime >= 1 then
			if arg_66_0.animtimer_ ~= nil then
				arg_66_0.animtimer_:Stop()

				arg_66_0.animtimer_ = nil
			end

			SetActive(arg_66_0.maskGo_, false)

			if arg_66_3 then
				arg_66_3()
			end
		end
	end, 0.033, -1)

	arg_66_0.animtimer_:Start()
end

function var_0_0.InitAnimNode(arg_68_0)
	arg_68_0.blackboard_ = TangramPuzzleBlackboard.New()
	arg_68_0.nodeDic_ = {}
	arg_68_0.nodeDic_.autoPutNode = TangramAutoPutNode.New(arg_68_0, arg_68_0.blackboard_)
	arg_68_0.nodeDic_.movePuzzleNode = TangramMovePuzzleNode.New(arg_68_0, arg_68_0.blackboard_)
	arg_68_0.nodeDic_.movePuzzleImmediateltNode = TangramMovePuzzleImmediatelyNode.New(arg_68_0, arg_68_0.blackboard_)
	arg_68_0.nodeDic_.rotateRegionNode = TangramRotateRegionNode.New(arg_68_0, arg_68_0.blackboard_)
	arg_68_0.nodeDic_.receiveRegionNode = TangramRegionReceiveNode.New(arg_68_0, arg_68_0.blackboard_)
	arg_68_0.nodeDic_.regionTypeAllRightNode = TangramRegionTypeAllRightNode.New(arg_68_0, arg_68_0.blackboard_)
	arg_68_0.nodeDic_.switchToPlayNode = TangramSwitchToPlayNode.New(arg_68_0, arg_68_0.blackboard_)
	arg_68_0.nodeDic_.switchToEditNode = TangramSwitchToEditNode.New(arg_68_0, arg_68_0.blackboard_)
	arg_68_0.nodeDic_.switchToFinalNode = TangramSwitchToFinalNode.New(arg_68_0, arg_68_0.blackboard_)
end

function var_0_0.CreateAnimNodeList(arg_69_0)
	arg_69_0.nodeList_ = {}

	if arg_69_0.blackboard_.isAutoPutPuzzle_ == true then
		local var_69_0 = TangramAnimGroup.New()

		var_69_0:Init(arg_69_0, arg_69_0.blackboard_, arg_69_0)

		local var_69_1 = arg_69_0:TryToCreateAutoPutNode()

		var_69_1:Init(var_69_0, arg_69_0.blackboard_, arg_69_0)

		local var_69_2 = arg_69_0:TryToCreateRegionTypeAllRightNode()

		var_69_2:Init(var_69_0, arg_69_0.blackboard_, arg_69_0)
		var_69_0:Add(var_69_1)
		var_69_0:Add(var_69_2)

		arg_69_0.nodeList_[#arg_69_0.nodeList_ + 1] = var_69_0
		arg_69_0.blackboard_.isOnlyRegionRewardPop_ = true

		local var_69_3 = arg_69_0:TryToCreateReceiveRegionNode()

		if var_69_3 then
			var_69_3:Init(arg_69_0, arg_69_0.blackboard_, arg_69_0)

			arg_69_0.nodeList_[#arg_69_0.nodeList_ + 1] = var_69_3
		end

		arg_69_0.blackboard_.needSwitchToPlay_ = false
		arg_69_0.blackboard_.needSwitchToEdit_ = false
		arg_69_0.blackboard_.needSwitchToFinal_ = true

		local var_69_4 = arg_69_0:TryToCreateSwitchNode()

		if var_69_4 then
			var_69_4:Init(arg_69_0, arg_69_0.blackboard_, arg_69_0)

			arg_69_0.nodeList_[#arg_69_0.nodeList_ + 1] = var_69_4
		end

		return
	end

	local var_69_5 = arg_69_0:TryToCreateMovePuzzleNode()

	if var_69_5 then
		arg_69_0.nodeList_[#arg_69_0.nodeList_ + 1] = var_69_5
	end

	local var_69_6 = arg_69_0:TryToCreateRotateRegionNode()

	if var_69_6 then
		arg_69_0.nodeList_[#arg_69_0.nodeList_ + 1] = var_69_6
	end

	local var_69_7 = arg_69_0:TryToCreateReceiveRegionNode()

	if var_69_7 then
		arg_69_0.nodeList_[#arg_69_0.nodeList_ + 1] = var_69_7
	end

	local var_69_8 = arg_69_0:TryToCreateRegionTypeAllRightNode()

	if var_69_8 then
		arg_69_0.nodeList_[#arg_69_0.nodeList_ + 1] = var_69_8
	end

	local var_69_9 = arg_69_0:TryToCreateSwitchNode()

	if var_69_9 then
		arg_69_0.nodeList_[#arg_69_0.nodeList_ + 1] = var_69_9
	end

	for iter_69_0, iter_69_1 in ipairs(arg_69_0.nodeList_) do
		iter_69_1:Init(arg_69_0, arg_69_0.blackboard_, arg_69_0)
	end
end

function var_0_0.TryToCreateAutoPutNode(arg_70_0)
	if arg_70_0.blackboard_.isAutoPutPuzzle_ == true then
		arg_70_0.blackboard_.isAutoPutPuzzle_ = false
		arg_70_0.blackboard_.needSwitchToFinal_ = true

		return arg_70_0.nodeDic_.autoPutNode
	end
end

function var_0_0.TryToCreateMovePuzzleNode(arg_71_0)
	if arg_71_0.blackboard_.isMovePuzzle_ == true then
		arg_71_0.blackboard_.isMovePuzzle_ = false
		arg_71_0.blackboard_.needSwitchToPlay_ = true

		local var_71_0

		if arg_71_0.blackboard_.isMoveImmediately_ == true then
			var_71_0 = arg_71_0.nodeDic_.movePuzzleImmediateltNode
		else
			var_71_0 = arg_71_0.nodeDic_.movePuzzleNode
		end

		return var_71_0
	end
end

function var_0_0.TryToCreateRotateRegionNode(arg_72_0)
	if arg_72_0.blackboard_.isRotateRegion_ == true then
		arg_72_0.blackboard_.isRotateRegion_ = false
		arg_72_0.blackboard_.needSwitchToEdit_ = true

		return arg_72_0.nodeDic_.rotateRegionNode
	end
end

function var_0_0.TryToCreateReceiveRegionNode(arg_73_0)
	if arg_73_0.blackboard_.isReceivedRegionReward_ == true then
		arg_73_0.blackboard_.isReceivedRegionReward_ = false
		arg_73_0.blackboard_.needSwitchToPlay_ = true

		return arg_73_0.nodeDic_.receiveRegionNode
	end
end

function var_0_0.TryToCreateRegionTypeAllRightNode(arg_74_0)
	if arg_74_0.blackboard_.needCheckAllRightRegionType_ == true then
		arg_74_0.blackboard_.needCheckAllRightRegionType_ = false

		local var_74_0 = {}

		for iter_74_0, iter_74_1 in pairs(arg_74_0.blackboard_.checkAllRightRegionTypeDic_) do
			if arg_74_0:CheckRegionAllRgithByRegionType(iter_74_0) == true then
				table.insert(var_74_0, iter_74_0)
			end
		end

		if #var_74_0 > 0 then
			arg_74_0.blackboard_.allRightRegionTypeList_ = var_74_0
			arg_74_0.blackboard_.needSwitchToPlay_ = true

			if arg_74_0:CheckRegionAllRight() == true then
				arg_74_0.blackboard_.needSwitchToPlay_ = false
				arg_74_0.blackboard_.needSwitchToEdit_ = false
				arg_74_0.blackboard_.needSwitchToFinal_ = true
			end

			return arg_74_0.nodeDic_.regionTypeAllRightNode
		end
	end
end

function var_0_0.TryToCreateSwitchNode(arg_75_0)
	if arg_75_0.blackboard_.needSwitchToPlay_ == true then
		arg_75_0.blackboard_.needSwitchToPlay_ = false

		return arg_75_0.nodeDic_.switchToPlayNode
	elseif arg_75_0.blackboard_.needSwitchToEdit_ == true then
		arg_75_0.blackboard_.needSwitchToEdit_ = false

		return arg_75_0.nodeDic_.switchToEditNode
	elseif arg_75_0.blackboard_.needSwitchToFinal_ == true then
		arg_75_0.blackboard_.needSwitchToFinal_ = false

		return arg_75_0.nodeDic_.switchToFinalNode
	end
end

function var_0_0.StartRunAnimNode(arg_76_0)
	SetActive(arg_76_0.maskGo_, true)

	arg_76_0.animNodeRunning_ = true
	arg_76_0.curNodeIndex_ = 0

	arg_76_0:RunNode()
end

function var_0_0.StopAnimNode(arg_77_0)
	SetActive(arg_77_0.maskGo_, false)

	arg_77_0.animNodeRunning_ = false
	arg_77_0.nodeList_ = nil

	arg_77_0.blackboard_:Reset()
end

function var_0_0.RunNode(arg_78_0)
	if not arg_78_0.animNodeRunning_ then
		return
	end

	arg_78_0.curNodeIndex_ = arg_78_0.curNodeIndex_ + 1

	arg_78_0.nodeList_[arg_78_0.curNodeIndex_]:RunFunc()
end

function var_0_0.SetNodeRunComplete(arg_79_0)
	if not arg_79_0.animNodeRunning_ or arg_79_0.curNodeIndex_ >= #arg_79_0.nodeList_ then
		arg_79_0:StopAnimNode()

		return
	end

	arg_79_0:RunNode()
end

function var_0_0.DisposeAnimNode(arg_80_0)
	if arg_80_0.nodeDic_ then
		for iter_80_0, iter_80_1 in pairs(arg_80_0.nodeDic_) do
			iter_80_1:Dispose()
		end

		arg_80_0.nodeDic_ = nil
	end
end

function var_0_0.AddTimer(arg_81_0)
	arg_81_0:StopTimer()
	arg_81_0:RefreshTimeText()

	arg_81_0.timer_ = Timer.New(function()
		if manager.time:GetServerTime() > arg_81_0.stopTime_ then
			arg_81_0.timeText_.text = GetTips("TIME_OVER")

			return
		end

		arg_81_0:RefreshTimeText()
	end, 1, -1)

	arg_81_0.timer_:Start()
end

function var_0_0.StopTimer(arg_83_0)
	if arg_83_0.timer_ then
		arg_83_0.timer_:Stop()

		arg_83_0.timer_ = nil
	end
end

function var_0_0.RefreshTimeText(arg_84_0)
	if arg_84_0.timeText_ then
		arg_84_0.timeText_.text = manager.time:GetLostTimeStr2(arg_84_0.stopTime_, nil, true)
	end
end

function var_0_0.IsActivityTime(arg_85_0)
	if manager.time:GetServerTime() < arg_85_0.startTime_ then
		local var_85_0 = GetTips("OPEN_TIME")

		ShowTips(string.format(var_85_0, manager.time:GetLostTimeStr2(arg_85_0.startTime_, nil, true)))

		return false
	end

	if manager.time:GetServerTime() >= arg_85_0.stopTime_ then
		ShowTips("TIME_OVER")

		return false
	end

	return true
end

return var_0_0

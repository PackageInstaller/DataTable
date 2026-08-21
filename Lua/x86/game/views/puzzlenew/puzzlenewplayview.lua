local var_0_0 = class("PuzzleNewPlayView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return PuzzleNewTools.GetPlayViewUIName(arg_1_0.params_.activityID)
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0.puzzleItemList_ = {}
	arg_3_0.puzzleItemDicByID_ = {}
	arg_3_0.regionItemList_ = {}
	arg_3_0.statusConst_ = {
		PLAY = 0,
		CHECK = 1
	}

	arg_3_0:InitUI()
	arg_3_0:AddUIListener()

	arg_3_0.statusController_ = ControllerUtil.GetController(arg_3_0.transform_, "status")
	arg_3_0.putBtnController_ = ControllerUtil.GetController(arg_3_0.putBtn_.transform, "status")
	arg_3_0.checkBtnController_ = ControllerUtil.GetController(arg_3_0.checkTipsBtn_.transform, "status")
	arg_3_0.checkPointStateController_ = arg_3_0.controller_:GetController("checkShowState")
	arg_3_0.checkPointList_ = {}
	arg_3_0.endDragHandler_ = handler(arg_3_0, arg_3_0.OnDragPuzzleEnd)
	arg_3_0.onClickHandler_ = handler(arg_3_0, arg_3_0.OnClick)
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.autoBtn_, nil, function()
		if not arg_5_0:IsActivityTime() then
			return
		end

		if not PuzzleNewTools.CheckWrongSide(false, arg_5_0.activityID_) then
			ShowTips("ACTIVITY_PUZZLE_GUIDE_ENOUGH")

			return
		end

		local var_6_0 = arg_5_0.puzzleCfg_.coin_id[1]
		local var_6_1 = var_6_0[1]

		if ItemTools.getItemNum(var_6_1) < var_6_0[2] then
			ShowTips("ACTIVITY_PUZZLE_COIN_NOT_ENOUGH")

			return
		end

		SetActive(arg_5_0.maskGo_, true)
		PuzzleNewAction.Operation(arg_5_0.activityID_, PuzzleNewAction.OPERATION_TYPE.AUTO_PUT)
	end)
	arg_5_0:AddBtnListener(arg_5_0.putBtn_, nil, function()
		if not arg_5_0:IsActivityTime() then
			return
		end

		if not PuzzleNewTools.CheckWrongSide(true, arg_5_0.activityID_) then
			ShowTips("ACTIVITY_PUZZLE_ENOUGH")

			return
		end

		local var_7_0 = arg_5_0.puzzleCfg_.fragment_id[1]
		local var_7_1 = var_7_0[1]

		if ItemTools.getItemNum(var_7_1) < var_7_0[2] then
			ShowTips("ACTIVITY_PUZZLE_FRAGMENT_NOT_ENOUGH")

			return
		end

		PuzzleNewData:SetPutBtnSelected(arg_5_0.activityID_)
		SetActive(arg_5_0.maskGo_, true)
		PuzzleNewAction.Operation(arg_5_0.activityID_, PuzzleNewAction.OPERATION_TYPE.PUT)
	end)
	arg_5_0:AddBtnListener(arg_5_0.rewardBtn_, nil, function()
		if not arg_5_0:IsActivityTime() then
			return
		end

		manager.windowBar:HideBar()
		JumpTools.OpenPageByJump("puzzleNewReward", {
			activityID = arg_5_0.activityID_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.previewBtn_, nil, function()
		if not arg_5_0:IsActivityTime() then
			return
		end

		manager.windowBar:HideBar()
		JumpTools.OpenPageByJump("puzzleNewPreview", {
			activityID = arg_5_0.activityID_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.checkTipsBtn_, nil, function()
		if not arg_5_0:IsActivityTime() then
			return
		end

		local var_10_0 = PuzzleNewData:GetCurCheckList(arg_5_0.activityID_)
		local var_10_1 = PuzzleNewData:GetCheckTipsList(arg_5_0.activityID_)
		local var_10_2 = arg_5_0.puzzleCfg_.clue_id
		local var_10_3 = false
		local var_10_4 = 0

		for iter_10_0, iter_10_1 in ipairs(var_10_2) do
			if var_10_0[iter_10_1] == nil and var_10_1[iter_10_1] == nil then
				var_10_3 = true
				var_10_4 = iter_10_1

				break
			end
		end

		if not var_10_3 then
			ShowTips("ACTIVITY_PUZZLE_CULE")

			return
		end

		local var_10_5 = arg_5_0.puzzleCfg_.clue_tips_id[1]
		local var_10_6 = var_10_5[1]

		if ItemTools.getItemNum(var_10_6) < var_10_5[2] then
			ShowTips("ACTIVITY_PUZZLE_FRAGMENT_NOT_ENOUGH")

			return
		end

		SetActive(arg_5_0.maskGo_, true)
		PuzzleNewAction.Operation(arg_5_0.activityID_, PuzzleNewAction.OPERATION_TYPE.CHECK_TIPS, nil, var_10_4)
	end)
	arg_5_0:AddBtnListener(arg_5_0.checkPreviewBtn_, nil, function()
		if not arg_5_0:IsActivityTime() then
			return
		end

		manager.windowBar:HideBar()
		JumpTools.OpenPageByJump("puzzleNewCheckPreview", {
			activityID = arg_5_0.activityID_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.shareBtn_, nil, function()
		manager.share:Share(function()
			arg_5_0:HideAllUI()
		end, function()
			arg_5_0:RecoverAllUI()
		end, function()
			return
		end)
	end)
	arg_5_0:AddBtnListener(arg_5_0.hideCheckBtn_, nil, function()
		local var_16_0 = arg_5_0.checkPointStateController_:GetSelectedState()

		if var_16_0 == "btn_show_hide" then
			arg_5_0.checkPointStateController_:SetSelectedState("btn_show_show")
		elseif var_16_0 == "btn_show_show" then
			arg_5_0.checkPointStateController_:SetSelectedState("btn_show_hide")
		end
	end)
end

function var_0_0.OnEnter(arg_17_0)
	Input.multiTouchEnabled = false

	local var_17_0 = ActivityData:GetActivityData(arg_17_0.params_.activityID)

	arg_17_0.startTime_ = var_17_0.startTime
	arg_17_0.stopTime_ = var_17_0.stopTime

	if arg_17_0.activityID_ ~= arg_17_0.params_.activityID then
		arg_17_0.activityID_ = arg_17_0.params_.activityID
		arg_17_0.puzzleCfg_ = PuzzleNewCfg[arg_17_0.params_.activityID]

		arg_17_0:Spawn()
	end

	arg_17_0.params_.isEnter = true

	arg_17_0:SwitchStatus()
	SetActive(arg_17_0.maskGo_, false)
	manager.redPoint:bindUIandKey(arg_17_0.putBtn_.transform, string.format("%s_%s", RedPointConst.PUZZLE_NEW_PIECE, arg_17_0.activityID_))
end

function var_0_0.OnExit(arg_18_0)
	Input.multiTouchEnabled = true

	manager.windowBar:HideBar()

	if arg_18_0.checkAnimtimer_ ~= nil then
		arg_18_0.checkAnimtimer_:Stop()

		arg_18_0.checkAnimtimer_ = nil
	end

	arg_18_0.params_.isEnter = false

	SetActive(arg_18_0.maskGo_, false)
	manager.redPoint:unbindUIandKey(arg_18_0.putBtn_.transform, string.format("%s_%s", RedPointConst.PUZZLE_NEW_PIECE, arg_18_0.activityID_))
end

function var_0_0.OnTop(arg_19_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		arg_19_0.puzzleCfg_.coin_id[1][1],
		arg_19_0.puzzleCfg_.fragment_id[1][1]
	})
	manager.windowBar:SetBarCanClick(arg_19_0.puzzleCfg_.coin_id[1][1], true)
	manager.windowBar:SetBarCanClick(arg_19_0.puzzleCfg_.fragment_id[1][1], true)
end

function var_0_0.Dispose(arg_20_0)
	arg_20_0.endDragHandler_ = nil
	arg_20_0.onClickHandler_ = nil

	arg_20_0:DespawnPuzzle()
	arg_20_0:DespawnRegion()
	arg_20_0:DespawnCheckPoint()
	var_0_0.super.Dispose(arg_20_0)
end

function var_0_0.Spawn(arg_21_0)
	if not PuzzleNewData:IsCompleted(arg_21_0.activityID_) then
		arg_21_0:DespawnPuzzle()
		arg_21_0:SpawnPuzzle()
		arg_21_0:DespawnRegion()
		arg_21_0:SpawnRegion()

		return
	end

	arg_21_0:DespawnCheckPoint()
	arg_21_0:SpawnCheckPoint()
end

function var_0_0.SwitchStatus(arg_22_0)
	if not PuzzleNewData:IsCompleted(arg_22_0.activityID_) then
		arg_22_0:SwitchToPlay()

		return
	end

	arg_22_0:SwitchToCheck()
end

function var_0_0.SwitchToPlay(arg_23_0)
	arg_23_0.statusController_:SetSelectedIndex(arg_23_0.statusConst_.PLAY)
	arg_23_0:RefreshPuzzle()
	arg_23_0:CheckRegionResult()
end

function var_0_0.SwitchToCheck(arg_24_0)
	arg_24_0.statusController_:SetSelectedIndex(arg_24_0.statusConst_.CHECK)
	arg_24_0:RefreshCheckPoint()
	arg_24_0.checkAnim_:Play("puzzlePieceTemplate_ImagePanel", -1, 999)

	for iter_24_0, iter_24_1 in ipairs(arg_24_0.puzzleItemList_) do
		iter_24_1:StopAnim()
	end

	arg_24_0.checkGoalText_.text = string.format(GetTips("PUZZLE_CHECK_GOAL_TIP"), #arg_24_0.puzzleCfg_.clue_id)
end

function var_0_0.OnPuzzleNewUpdate(arg_25_0)
	SetActive(arg_25_0.maskGo_, false)
	arg_25_0:RefreshPuzzle()
	arg_25_0:CheckRegionResult()
end

function var_0_0.RefreshPuzzle(arg_26_0)
	local var_26_0 = arg_26_0.params_.isEnter

	arg_26_0.params_.isEnter = false

	local var_26_1 = PuzzleNewData:GetCurPuzzleList(arg_26_0.activityID_)

	for iter_26_0, iter_26_1 in ipairs(arg_26_0.puzzleItemList_) do
		if var_26_1[iter_26_0] then
			arg_26_0.puzzleItemList_[iter_26_0]:SetData(var_26_1[iter_26_0], arg_26_0.activityID_, not var_26_0)
		else
			arg_26_0.puzzleItemList_[iter_26_0]:SetData(0, arg_26_0.activityID_, false)
		end
	end

	arg_26_0:RefreshPuzzleCost()
end

function var_0_0.MovePuzzle(arg_27_0, arg_27_1, arg_27_2)
	SetActive(arg_27_0.maskGo_, true)

	local var_27_0 = arg_27_0.puzzleItemList_[arg_27_1]:GetCurID()

	PuzzleNewAction.MovePuzzle(arg_27_0.activityID_, var_27_0, arg_27_2, function()
		SetActive(arg_27_0.maskGo_, false)

		local var_28_0 = arg_27_0.puzzleItemList_[arg_27_1]
		local var_28_1 = arg_27_0.puzzleItemList_[arg_27_2]
		local var_28_2 = var_28_0:GetCurID()

		var_28_0:SetData(var_28_1:GetCurID(), arg_27_0.activityID_, true)
		var_28_1:SetData(var_28_2, arg_27_0.activityID_, true)
		PuzzleNewData:SetPuzzle(arg_27_0.activityID_, var_28_0:GetCurID(), arg_27_1)
		PuzzleNewData:SetPuzzle(arg_27_0.activityID_, var_28_1:GetCurID(), arg_27_2)
		arg_27_0:CheckRegionResult()
	end)
end

function var_0_0.OnDragPuzzleEnd(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0, var_29_1 = PuzzleNewTools.FindPuzzleByScreenPos(arg_29_0.puzzleContentTrans_, arg_29_0.col_, arg_29_0.row_, arg_29_2)

	if var_29_0 == true then
		local var_29_2 = arg_29_0.puzzleItemList_[var_29_1]

		if arg_29_1 ~= var_29_1 and not var_29_2:IsRightSide() then
			arg_29_0:MovePuzzle(arg_29_1, var_29_1)
		else
			arg_29_0.puzzleItemList_[arg_29_1]:Recover()
		end
	else
		arg_29_0.puzzleItemList_[arg_29_1]:Recover()
	end
end

function var_0_0.SpawnPuzzle(arg_30_0)
	arg_30_0.row_ = arg_30_0.puzzleCfg_.size[1]
	arg_30_0.col_ = arg_30_0.puzzleCfg_.size[2]

	local var_30_0 = arg_30_0.puzzleCfg_.correct_array
	local var_30_1 = arg_30_0.puzzleContentTrans_.childCount

	arg_30_0.puzzleItemList_ = arg_30_0.puzzleItemList_ or {}

	for iter_30_0 = 1, var_30_1 do
		local var_30_2 = arg_30_0.puzzleContentTrans_:GetChild(iter_30_0 - 1)

		if not arg_30_0.puzzleItemList_[iter_30_0] then
			local var_30_3 = var_30_0[iter_30_0]

			arg_30_0.puzzleItemList_[iter_30_0] = PuzzleNewPiece.New(arg_30_0.puzzleContentTrans_, var_30_2, iter_30_0, var_30_3)

			arg_30_0.puzzleItemList_[iter_30_0]:RegistEndDragCallback(arg_30_0.endDragHandler_)

			arg_30_0.puzzleItemDicByID_[var_30_3] = arg_30_0.puzzleItemList_[iter_30_0]
		end
	end
end

function var_0_0.DespawnPuzzle(arg_31_0)
	for iter_31_0, iter_31_1 in pairs(arg_31_0.puzzleItemList_) do
		iter_31_1:Dispose()
	end

	arg_31_0.puzzleItemList_ = nil
end

function var_0_0.RefreshPuzzleCost(arg_32_0)
	local var_32_0 = arg_32_0.puzzleCfg_.fragment_id[1]
	local var_32_1 = var_32_0[2]

	arg_32_0.putCostText_.text = "x" .. var_32_1
	arg_32_0.putCostImg_.sprite = ItemTools.getItemSprite(var_32_0[1])

	local var_32_2 = ItemTools.getItemNum(var_32_0[1])

	arg_32_0.putBtnController_:SetSelectedIndex(var_32_2 < var_32_1 and 1 or 0)
end

function var_0_0.SpawnRegion(arg_33_0)
	local var_33_0 = arg_33_0.puzzleCfg_.area_fragment_list
	local var_33_1 = arg_33_0.puzzleCfg_.reward_area_list
	local var_33_2 = PuzzleNewTools.GetRegionPosDic(arg_33_0.activityID_)

	arg_33_0.regionItemList_ = arg_33_0.regionItemList_ or {}

	local var_33_3 = arg_33_0.regionPanelTrans_.childCount

	for iter_33_0 = 1, var_33_3 do
		local var_33_4 = arg_33_0.regionPanelTrans_:GetChild(iter_33_0 - 1)
		local var_33_5 = tonumber(var_33_4.name)
		local var_33_6 = var_33_0[var_33_2[var_33_5]][2]

		if not arg_33_0.regionItemList_[var_33_5] then
			arg_33_0.regionItemList_[var_33_5] = PuzzleNewRegionAnimItem.New(var_33_4)
		end

		for iter_33_1, iter_33_2 in ipairs(var_33_6) do
			arg_33_0.puzzleItemDicByID_[iter_33_2]:SetRegionID(var_33_5)
		end
	end
end

function var_0_0.DespawnRegion(arg_34_0)
	for iter_34_0, iter_34_1 in pairs(arg_34_0.regionItemList_) do
		iter_34_1:Dispose()
	end

	arg_34_0.regionItemList_ = nil
end

function var_0_0.OnRegionReceived(arg_35_0, arg_35_1, arg_35_2)
	for iter_35_0 = 1, #arg_35_1 do
		if iter_35_0 == #arg_35_1 then
			arg_35_0.regionItemList_[arg_35_1[iter_35_0]]:PlayAnim(function()
				SetActive(arg_35_0.maskGo_, false)
				arg_35_0:OnRegionAnimEnd(arg_35_2)
			end)
		else
			arg_35_0.regionItemList_[iter_35_0]:PlayAnim()
		end
	end
end

function var_0_0.OnRegionAnimEnd(arg_37_0, arg_37_1)
	getReward2(arg_37_1, nil, function()
		if PuzzleNewData:IsCompleted(arg_37_0.activityID_) then
			arg_37_0:Spawn()
			arg_37_0:SwitchStatus()
			SetActive(arg_37_0.maskGo_, true)

			local var_38_0 = "puzzlePieceTemplate_ImagePanel"

			arg_37_0.checkAnim_:Play(var_38_0, -1, 0)
			arg_37_0.checkAnim_:Update(0)

			arg_37_0.checkAnimtimer_ = Timer.New(function()
				local var_39_0 = arg_37_0.checkAnim_:GetCurrentAnimatorStateInfo(0)

				if var_39_0:IsName(var_38_0) and var_39_0.normalizedTime >= 1 then
					if arg_37_0.checkAnimtimer_ ~= nil then
						arg_37_0.checkAnimtimer_:Stop()

						arg_37_0.checkAnimtimer_ = nil
					end

					SetActive(arg_37_0.maskGo_, false)
				end
			end, 0.033, -1)

			arg_37_0.checkAnimtimer_:Start()
			manager.audio:PlayEffect("minigame_activity_2_1", "minigame_activity_2_1_puzzle_complete", "")
		end
	end)
end

function var_0_0.CheckRegionResult(arg_40_0)
	local var_40_0, var_40_1 = PuzzleNewTools.CheckRegionResult(arg_40_0.activityID_)

	if #var_40_0 > 0 then
		SetActive(arg_40_0.maskGo_, true)
		PuzzleNewAction.ReceiveRegionReward(arg_40_0.activityID_, var_40_0, var_40_1)

		for iter_40_0, iter_40_1 in pairs(arg_40_0.puzzleItemList_) do
			iter_40_1:StopAnim()
		end
	end
end

function var_0_0.OnPuzzleNewCheckUpdate(arg_41_0)
	SetActive(arg_41_0.maskGo_, false)
	arg_41_0:RefreshCheckPoint()
end

function var_0_0.RefreshCheckPoint(arg_42_0)
	for iter_42_0, iter_42_1 in pairs(arg_42_0.checkPointList_) do
		iter_42_1:SetData(arg_42_0.activityID_, iter_42_0)
	end

	arg_42_0:RefreshCheckProgress()
	arg_42_0:RefreshCheckCost()
end

function var_0_0.RefreshCheckProgress(arg_43_0)
	local var_43_0 = #arg_43_0.puzzleCfg_.clue_id
	local var_43_1 = false
	local var_43_2 = PuzzleNewData:GetCurCheckList(arg_43_0.activityID_)
	local var_43_3 = 0

	for iter_43_0, iter_43_1 in pairs(var_43_2) do
		var_43_3 = var_43_3 + 1
		var_43_1 = true
	end

	arg_43_0.progressText_.text = string.format("%d/%d", var_43_3, var_43_0)

	local var_43_4 = PuzzleNewData:GetCheckTipsList(arg_43_0.activityID_)

	for iter_43_2, iter_43_3 in pairs(var_43_4) do
		var_43_1 = true
	end

	if var_43_1 then
		if arg_43_0.checkPointStateController_:GetSelectedState() == "none" then
			arg_43_0.checkPointStateController_:SetSelectedState("btn_show_hide")
		end
	else
		arg_43_0.checkPointStateController_:SetSelectedState("none")
	end
end

function var_0_0.OnClick(arg_44_0, arg_44_1)
	arg_44_0:RefreshCheckProgress()
end

function var_0_0.SpawnCheckPoint(arg_45_0)
	local var_45_0 = arg_45_0.puzzleCfg_.clueContainerUIPath

	if var_45_0 ~= "" then
		arg_45_0.checkPointContent_ = Object.Instantiate(Asset.Load(var_45_0), arg_45_0.checkPointContent_).transform
	end

	local var_45_1 = arg_45_0.puzzleCfg_.clue_id
	local var_45_2 = arg_45_0.checkPointContent_.childCount

	arg_45_0.checkPointList_ = arg_45_0.checkPointList_ or {}

	for iter_45_0 = 1, var_45_2 do
		local var_45_3 = arg_45_0.checkPointContent_:GetChild(iter_45_0 - 1)
		local var_45_4 = var_45_1[iter_45_0]

		if not arg_45_0.checkPointList_[var_45_4] then
			arg_45_0.checkPointList_[var_45_4] = PuzzleNewCheckPoint.New(var_45_3)
		end
	end

	arg_45_0.originImage_.sprite = pureGetSpriteWithoutAtlas(arg_45_0.puzzleCfg_.album_id)
	arg_45_0.checkPanelImage_.sprite = pureGetSpriteWithoutAtlas(arg_45_0.puzzleCfg_.album_id)
end

function var_0_0.DespawnCheckPoint(arg_46_0)
	for iter_46_0, iter_46_1 in pairs(arg_46_0.checkPointList_) do
		iter_46_1:Dispose()
	end

	arg_46_0.checkPointList_ = nil
end

function var_0_0.RefreshCheckCost(arg_47_0)
	local var_47_0 = arg_47_0.puzzleCfg_.clue_tips_id[1]
	local var_47_1 = var_47_0[2]

	arg_47_0.checkCostText_.text = "x" .. var_47_1
	arg_47_0.checkCostImg_.sprite = ItemTools.getItemSprite(var_47_0[1])

	local var_47_2 = ItemTools.getItemNum(var_47_0[1])

	arg_47_0.checkBtnController_:SetSelectedIndex(var_47_2 < var_47_1 and 1 or 0)
end

function var_0_0.HideAllUI(arg_48_0)
	manager.windowBar:HideBar()
	SetActive(arg_48_0.btnPanelGo_, false)
end

function var_0_0.RecoverAllUI(arg_49_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		arg_49_0.puzzleCfg_.coin_id[1][1],
		arg_49_0.puzzleCfg_.fragment_id[1][1]
	})
	SetActive(arg_49_0.btnPanelGo_, true)
end

function var_0_0.IsActivityTime(arg_50_0)
	if manager.time:GetServerTime() < arg_50_0.startTime_ then
		local var_50_0 = GetTips("OPEN_TIME")

		ShowTips(string.format(var_50_0, manager.time:GetLostTimeStr2(arg_50_0.startTime_, nil, true)))

		return false
	end

	if manager.time:GetServerTime() >= arg_50_0.stopTime_ then
		ShowTips("TIME_OVER")

		return false
	end

	return true
end

return var_0_0

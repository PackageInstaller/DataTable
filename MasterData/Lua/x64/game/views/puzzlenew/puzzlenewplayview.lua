local PuzzleNewPlayView = class("PuzzleNewPlayView", ReduxView)

function PuzzleNewPlayView:UIName()
	return PuzzleNewTools.GetPlayViewUIName(self.params_.activityID)
end

function PuzzleNewPlayView:UIParent()
	return manager.ui.uiMain.transform
end

function PuzzleNewPlayView:Init()
	self.puzzleItemList_ = {}
	self.puzzleItemDicByID_ = {}
	self.regionItemList_ = {}
	self.statusConst_ = {
		PLAY = 0,
		CHECK = 1
	}

	self:InitUI()
	self:AddUIListener()

	self.statusController_ = ControllerUtil.GetController(self.transform_, "status")
	self.putBtnController_ = ControllerUtil.GetController(self.putBtn_.transform, "status")
	self.checkBtnController_ = ControllerUtil.GetController(self.checkTipsBtn_.transform, "status")
	self.checkPointStateController_ = self.controller_:GetController("checkShowState")
	self.checkPointList_ = {}
	self.endDragHandler_ = handler(self, self.OnDragPuzzleEnd)
	self.onClickHandler_ = handler(self, self.OnClick)
end

function PuzzleNewPlayView:InitUI()
	self:BindCfgUI()
end

function PuzzleNewPlayView:AddUIListener()
	self:AddBtnListener(self.autoBtn_, nil, function()
		if not self:IsActivityTime() then
			return
		end

		if not PuzzleNewTools.CheckWrongSide(false, self.activityID_) then
			ShowTips("ACTIVITY_PUZZLE_GUIDE_ENOUGH")

			return
		end

		if ItemTools.getItemNum(self.puzzleCfg_.coin_id[1][1]) < self.puzzleCfg_.coin_id[1][2] then
			ShowTips("ACTIVITY_PUZZLE_COIN_NOT_ENOUGH")

			return
		end

		SetActive(self.maskGo_, true)
		PuzzleNewAction.Operation(self.activityID_, PuzzleNewAction.OPERATION_TYPE.AUTO_PUT)
	end)
	self:AddBtnListener(self.putBtn_, nil, function()
		if not self:IsActivityTime() then
			return
		end

		if not PuzzleNewTools.CheckWrongSide(true, self.activityID_) then
			ShowTips("ACTIVITY_PUZZLE_ENOUGH")

			return
		end

		if ItemTools.getItemNum(self.puzzleCfg_.fragment_id[1][1]) < self.puzzleCfg_.fragment_id[1][2] then
			ShowTips("ACTIVITY_PUZZLE_FRAGMENT_NOT_ENOUGH")

			return
		end

		PuzzleNewData:SetPutBtnSelected(self.activityID_)
		SetActive(self.maskGo_, true)
		PuzzleNewAction.Operation(self.activityID_, PuzzleNewAction.OPERATION_TYPE.PUT)
	end)
	self:AddBtnListener(self.rewardBtn_, nil, function()
		if not self:IsActivityTime() then
			return
		end

		manager.windowBar:HideBar()
		JumpTools.OpenPageByJump("puzzleNewReward", {
			activityID = self.activityID_
		})
	end)
	self:AddBtnListener(self.previewBtn_, nil, function()
		if not self:IsActivityTime() then
			return
		end

		manager.windowBar:HideBar()
		JumpTools.OpenPageByJump("puzzleNewPreview", {
			activityID = self.activityID_
		})
	end)
	self:AddBtnListener(self.checkTipsBtn_, nil, function()
		if not self:IsActivityTime() then
			return
		end

		local var_10_0 = PuzzleNewData:GetCurCheckList(self.activityID_)
		local var_10_1 = PuzzleNewData:GetCheckTipsList(self.activityID_)
		local var_10_2 = false
		local var_10_3 = 0

		for iter_10_0, iter_10_1 in ipairs(self.puzzleCfg_.clue_id) do
			if var_10_0[iter_10_1] == nil and var_10_1[iter_10_1] == nil then
				var_10_2 = true
				var_10_3 = iter_10_1

				break
			end
		end

		if not var_10_2 then
			ShowTips("ACTIVITY_PUZZLE_CULE")

			return
		end

		if ItemTools.getItemNum(self.puzzleCfg_.clue_tips_id[1][1]) < self.puzzleCfg_.clue_tips_id[1][2] then
			ShowTips("ACTIVITY_PUZZLE_FRAGMENT_NOT_ENOUGH")

			return
		end

		SetActive(self.maskGo_, true)
		PuzzleNewAction.Operation(self.activityID_, PuzzleNewAction.OPERATION_TYPE.CHECK_TIPS, nil, var_10_3)
	end)
	self:AddBtnListener(self.checkPreviewBtn_, nil, function()
		if not self:IsActivityTime() then
			return
		end

		manager.windowBar:HideBar()
		JumpTools.OpenPageByJump("puzzleNewCheckPreview", {
			activityID = self.activityID_
		})
	end)
	self:AddBtnListener(self.shareBtn_, nil, function()
		manager.share:Share(function()
			self:HideAllUI()
		end, function()
			self:RecoverAllUI()
		end, function()
			return
		end)
	end)
	self:AddBtnListener(self.hideCheckBtn_, nil, function()
		local var_16_0 = self.checkPointStateController_:GetSelectedState()

		if var_16_0 == "btn_show_hide" then
			self.checkPointStateController_:SetSelectedState("btn_show_show")
		elseif var_16_0 == "btn_show_show" then
			self.checkPointStateController_:SetSelectedState("btn_show_hide")
		end
	end)
end

function PuzzleNewPlayView:OnEnter()
	Input.multiTouchEnabled = false

	local var_17_0 = ActivityData:GetActivityData(self.params_.activityID)

	self.startTime_ = var_17_0.startTime
	self.stopTime_ = var_17_0.stopTime

	if self.activityID_ ~= self.params_.activityID then
		self.activityID_ = self.params_.activityID
		self.puzzleCfg_ = PuzzleNewCfg[self.params_.activityID]

		self:Spawn()
	end

	self.params_.isEnter = true

	self:SwitchStatus()
	SetActive(self.maskGo_, false)
	manager.redPoint:bindUIandKey(self.putBtn_.transform, string.format("%s_%s", RedPointConst.PUZZLE_NEW_PIECE, self.activityID_))
end

function PuzzleNewPlayView:OnExit()
	Input.multiTouchEnabled = true

	manager.windowBar:HideBar()

	if self.checkAnimtimer_ ~= nil then
		self.checkAnimtimer_:Stop()

		self.checkAnimtimer_ = nil
	end

	self.params_.isEnter = false

	SetActive(self.maskGo_, false)
	manager.redPoint:unbindUIandKey(self.putBtn_.transform, string.format("%s_%s", RedPointConst.PUZZLE_NEW_PIECE, self.activityID_))
end

function PuzzleNewPlayView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		self.puzzleCfg_.coin_id[1][1],
		self.puzzleCfg_.fragment_id[1][1]
	})
	manager.windowBar:SetBarCanClick(self.puzzleCfg_.coin_id[1][1], true)
	manager.windowBar:SetBarCanClick(self.puzzleCfg_.fragment_id[1][1], true)
end

function PuzzleNewPlayView:Dispose()
	self.endDragHandler_ = nil
	self.onClickHandler_ = nil

	self:DespawnPuzzle()
	self:DespawnRegion()
	self:DespawnCheckPoint()
	PuzzleNewPlayView.super.Dispose(self)
end

function PuzzleNewPlayView:Spawn()
	if not PuzzleNewData:IsCompleted(self.activityID_) then
		self:DespawnPuzzle()
		self:SpawnPuzzle()
		self:DespawnRegion()
		self:SpawnRegion()

		return
	end

	self:DespawnCheckPoint()
	self:SpawnCheckPoint()
end

function PuzzleNewPlayView:SwitchStatus()
	if not PuzzleNewData:IsCompleted(self.activityID_) then
		self:SwitchToPlay()

		return
	end

	self:SwitchToCheck()
end

function PuzzleNewPlayView:SwitchToPlay()
	self.statusController_:SetSelectedIndex(self.statusConst_.PLAY)
	self:RefreshPuzzle()
	self:CheckRegionResult()
end

function PuzzleNewPlayView:SwitchToCheck()
	self.statusController_:SetSelectedIndex(self.statusConst_.CHECK)
	self:RefreshCheckPoint()
	self.checkAnim_:Play("puzzlePieceTemplate_ImagePanel", -1, 999)

	for iter_24_0, iter_24_1 in ipairs(self.puzzleItemList_) do
		iter_24_1:StopAnim()
	end

	self.checkGoalText_.text = string.format(GetTips("PUZZLE_CHECK_GOAL_TIP"), #self.puzzleCfg_.clue_id)
end

function PuzzleNewPlayView:OnPuzzleNewUpdate()
	SetActive(self.maskGo_, false)
	self:RefreshPuzzle()
	self:CheckRegionResult()
end

function PuzzleNewPlayView:RefreshPuzzle()
	self.params_.isEnter = false

	local var_26_0 = PuzzleNewData:GetCurPuzzleList(self.activityID_)

	for iter_26_0, iter_26_1 in ipairs(self.puzzleItemList_) do
		if var_26_0[iter_26_0] then
			self.puzzleItemList_[iter_26_0]:SetData(var_26_0[iter_26_0], self.activityID_, not self.params_.isEnter)
		else
			self.puzzleItemList_[iter_26_0]:SetData(0, self.activityID_, false)
		end
	end

	self:RefreshPuzzleCost()
end

function PuzzleNewPlayView:MovePuzzle(arg_27_1, arg_27_2)
	SetActive(self.maskGo_, true)
	PuzzleNewAction.MovePuzzle(self.activityID_, self.puzzleItemList_[arg_27_1]:GetCurID(), arg_27_2, function()
		SetActive(self.maskGo_, false)
		self.puzzleItemList_[arg_27_1]:SetData(self.puzzleItemList_[arg_27_2]:GetCurID(), self.activityID_, true)
		self.puzzleItemList_[arg_27_2]:SetData(self.puzzleItemList_[arg_27_1]:GetCurID(), self.activityID_, true)
		PuzzleNewData:SetPuzzle(self.activityID_, self.puzzleItemList_[arg_27_1]:GetCurID(), arg_27_1)
		PuzzleNewData:SetPuzzle(self.activityID_, self.puzzleItemList_[arg_27_2]:GetCurID(), arg_27_2)
		self:CheckRegionResult()
	end)
end

function PuzzleNewPlayView:OnDragPuzzleEnd(arg_29_1, arg_29_2)
	local var_29_0, var_29_1 = PuzzleNewTools.FindPuzzleByScreenPos(self.puzzleContentTrans_, self.col_, self.row_, arg_29_2)

	if var_29_0 == true then
		if arg_29_1 ~= var_29_1 and not self.puzzleItemList_[var_29_1]:IsRightSide() then
			self:MovePuzzle(arg_29_1, var_29_1)
		else
			self.puzzleItemList_[arg_29_1]:Recover()
		end
	else
		self.puzzleItemList_[arg_29_1]:Recover()
	end
end

function PuzzleNewPlayView:SpawnPuzzle()
	self.row_ = self.puzzleCfg_.size[1]
	self.col_ = self.puzzleCfg_.size[2]
	self.puzzleItemList_ = self.puzzleItemList_ or {}

	for iter_30_0 = 1, self.puzzleContentTrans_.childCount do
		if not self.puzzleItemList_[iter_30_0] then
			self.puzzleItemList_[iter_30_0] = PuzzleNewPiece.New(self.puzzleContentTrans_, self.puzzleContentTrans_:GetChild(iter_30_0 - 1), iter_30_0, self.puzzleCfg_.correct_array[iter_30_0])

			self.puzzleItemList_[iter_30_0]:RegistEndDragCallback(self.endDragHandler_)

			self.puzzleItemDicByID_[self.puzzleCfg_.correct_array[iter_30_0]] = self.puzzleItemList_[iter_30_0]
		end
	end
end

function PuzzleNewPlayView:DespawnPuzzle()
	for iter_31_0, iter_31_1 in pairs(self.puzzleItemList_) do
		iter_31_1:Dispose()
	end

	self.puzzleItemList_ = nil
end

function PuzzleNewPlayView:RefreshPuzzleCost()
	local var_32_0 = self.puzzleCfg_.fragment_id[1]
	local var_32_1 = self.puzzleCfg_.fragment_id[1][2]

	self.putCostText_.text = "x" .. self.puzzleCfg_.fragment_id[1][2]
	self.putCostImg_.sprite = ItemTools.getItemSprite(var_32_0[1])

	self.putBtnController_:SetSelectedIndex(ItemTools.getItemNum(var_32_0[1]) < var_32_1 and 1 or 0)
end

function PuzzleNewPlayView:SpawnRegion()
	local var_33_1 = PuzzleNewTools.GetRegionPosDic(self.activityID_)

	self.regionItemList_ = self.regionItemList_ or {}

	for iter_33_0 = 1, self.regionPanelTrans_.childCount do
		local var_33_2 = self.regionPanelTrans_:GetChild(iter_33_0 - 1)
		local var_33_3 = tonumber(var_33_2.name)

		self.regionItemList_[var_33_3] = self.regionItemList_[var_33_3] or PuzzleNewRegionAnimItem.New(var_33_2)

		for iter_33_1, iter_33_2 in ipairs(self.puzzleCfg_.area_fragment_list[var_33_1[var_33_3]][2]) do
			self.puzzleItemDicByID_[iter_33_2]:SetRegionID(var_33_3)
		end
	end
end

function PuzzleNewPlayView:DespawnRegion()
	for iter_34_0, iter_34_1 in pairs(self.regionItemList_) do
		iter_34_1:Dispose()
	end

	self.regionItemList_ = nil
end

function PuzzleNewPlayView:OnRegionReceived(arg_35_1, arg_35_2)
	for iter_35_0 = 1, #arg_35_1 do
		if iter_35_0 == #arg_35_1 then
			self.regionItemList_[arg_35_1[iter_35_0]]:PlayAnim(function()
				SetActive(self.maskGo_, false)
				self:OnRegionAnimEnd(arg_35_2)
			end)
		else
			self.regionItemList_[iter_35_0]:PlayAnim()
		end
	end
end

function PuzzleNewPlayView:OnRegionAnimEnd(arg_37_1)
	getReward2(arg_37_1, nil, function()
		if PuzzleNewData:IsCompleted(self.activityID_) then
			self:Spawn()
			self:SwitchStatus()
			SetActive(self.maskGo_, true)

			local var_38_0 = "puzzlePieceTemplate_ImagePanel"

			self.checkAnim_:Play("puzzlePieceTemplate_ImagePanel", -1, 0)
			self.checkAnim_:Update(0)

			self.checkAnimtimer_ = Timer.New(function()
				local var_39_0 = self.checkAnim_:GetCurrentAnimatorStateInfo(0)

				if var_39_0:IsName(var_38_0) and var_39_0.normalizedTime >= 1 then
					if self.checkAnimtimer_ ~= nil then
						self.checkAnimtimer_:Stop()

						self.checkAnimtimer_ = nil
					end

					SetActive(self.maskGo_, false)
				end
			end, 0.033, -1)

			self.checkAnimtimer_:Start()
			manager.audio:PlayEffect("minigame_activity_2_1", "minigame_activity_2_1_puzzle_complete", "")
		end
	end)
end

function PuzzleNewPlayView:CheckRegionResult()
	local var_40_0, var_40_1 = PuzzleNewTools.CheckRegionResult(self.activityID_)

	if #var_40_0 > 0 then
		SetActive(self.maskGo_, true)
		PuzzleNewAction.ReceiveRegionReward(self.activityID_, var_40_0, var_40_1)

		for iter_40_0, iter_40_1 in pairs(self.puzzleItemList_) do
			iter_40_1:StopAnim()
		end
	end
end

function PuzzleNewPlayView:OnPuzzleNewCheckUpdate()
	SetActive(self.maskGo_, false)
	self:RefreshCheckPoint()
end

function PuzzleNewPlayView:RefreshCheckPoint()
	for iter_42_0, iter_42_1 in pairs(self.checkPointList_) do
		iter_42_1:SetData(self.activityID_, iter_42_0)
	end

	self:RefreshCheckProgress()
	self:RefreshCheckCost()
end

function PuzzleNewPlayView:RefreshCheckProgress()
	local var_43_0 = false
	local var_43_1 = 0

	for iter_43_0, iter_43_1 in pairs((PuzzleNewData:GetCurCheckList(self.activityID_))) do
		var_43_1 = var_43_1 + 1
		var_43_0 = true
	end

	self.progressText_.text = string.format("%d/%d", var_43_1, #self.puzzleCfg_.clue_id)

	for iter_43_2, iter_43_3 in pairs((PuzzleNewData:GetCheckTipsList(self.activityID_))) do
		var_43_0 = true
	end

	if var_43_0 then
		if self.checkPointStateController_:GetSelectedState() == "none" then
			self.checkPointStateController_:SetSelectedState("btn_show_hide")
		end
	else
		self.checkPointStateController_:SetSelectedState("none")
	end
end

function PuzzleNewPlayView:OnClick(arg_44_1)
	self:RefreshCheckProgress()
end

function PuzzleNewPlayView:SpawnCheckPoint()
	if self.puzzleCfg_.clueContainerUIPath ~= "" then
		self.checkPointContent_ = Object.Instantiate(Asset.Load(self.puzzleCfg_.clueContainerUIPath), self.checkPointContent_).transform
	end

	local var_45_0 = self.puzzleCfg_.clue_id

	self.checkPointList_ = self.checkPointList_ or {}

	for iter_45_0 = 1, self.checkPointContent_.childCount do
		self.checkPointList_[var_45_0[iter_45_0]] = self.checkPointList_[var_45_0[iter_45_0]] or PuzzleNewCheckPoint.New((self.checkPointContent_:GetChild(iter_45_0 - 1)))
	end

	self.originImage_.sprite = pureGetSpriteWithoutAtlas(self.puzzleCfg_.album_id)
	self.checkPanelImage_.sprite = pureGetSpriteWithoutAtlas(self.puzzleCfg_.album_id)
end

function PuzzleNewPlayView:DespawnCheckPoint()
	for iter_46_0, iter_46_1 in pairs(self.checkPointList_) do
		iter_46_1:Dispose()
	end

	self.checkPointList_ = nil
end

function PuzzleNewPlayView:RefreshCheckCost()
	local var_47_0 = self.puzzleCfg_.clue_tips_id[1]
	local var_47_1 = self.puzzleCfg_.clue_tips_id[1][2]

	self.checkCostText_.text = "x" .. self.puzzleCfg_.clue_tips_id[1][2]
	self.checkCostImg_.sprite = ItemTools.getItemSprite(var_47_0[1])

	self.checkBtnController_:SetSelectedIndex(ItemTools.getItemNum(var_47_0[1]) < var_47_1 and 1 or 0)
end

function PuzzleNewPlayView:HideAllUI()
	manager.windowBar:HideBar()
	SetActive(self.btnPanelGo_, false)
end

function PuzzleNewPlayView:RecoverAllUI()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		self.puzzleCfg_.coin_id[1][1],
		self.puzzleCfg_.fragment_id[1][1]
	})
	SetActive(self.btnPanelGo_, true)
end

function PuzzleNewPlayView:IsActivityTime()
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

return PuzzleNewPlayView

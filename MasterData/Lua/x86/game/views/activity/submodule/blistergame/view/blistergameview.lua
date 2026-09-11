local BlisterGameView = class("BlisterGameView", ReduxView)

function BlisterGameView:UIName()
	return "Widget/System/Summer2024/Summer2024_BlisterGame/BlisterGame01"
end

function BlisterGameView:UIParent()
	return manager.ui.uiMain.transform
end

function BlisterGameView:OnCtor()
	self.selectIndex = 0
	self.nowIndex = 1
	self.isStopAni = true
	self.passIndex = 0
end

function BlisterGameView:Init()
	self:InitUI()
	self:AddListeners()
end

function BlisterGameView:InitUI()
	self:BindCfgUI()

	self.tabController_ = self.choicebtnControllerexcollection_:GetController("tab")
	self.nodeList = {}
	self.pointlist = {}
	self.btnList_ = {}
	self.btnContrllerList_ = {}

	for iter_5_0 = 1, 2 do
		self.btnList_[iter_5_0] = self[string.format("nextbtn0%sBtn_", iter_5_0)]
		self.btnContrllerList_[iter_5_0] = self["btnCon_" .. iter_5_0]:GetController("lock")
	end
end

function BlisterGameView:AddListeners()
	self:AddBtnListener(self.taskbtnBtn_, nil, "OnTask")

	for iter_6_0 = 1, 2 do
		self:AddBtnListener(self.btnList_[iter_6_0], nil, function()
			self:ChangeTab(iter_6_0)
		end)
	end
end

function BlisterGameView:StopLeanTween()
	if self.moveLeanTween_ then
		self.moveLeanTween_:setOnComplete(nil):setEase(nil)
		LeanTween.cancel(self.moveLeanTween_.id)

		self.moveLeanTween_ = nil
	end
end

function BlisterGameView:SetSelect(arg_9_1)
	if self.selectIndex and self.nodeList[self.selectIndex] then
		self.nodeList[self.selectIndex]:SetSelect(false)
	end

	self.selectIndex = arg_9_1

	BlisterGameData:SaveSetlectIndx(self.selectIndex)

	if self.nodeList[self.selectIndex] then
		self.nodeList[self.selectIndex]:SetSelect(true)
	end

	local var_9_0 = self.scrollviewTrs_.rect.width
	local var_9_1 = self.selectIndex * 300 - self.scrollviewTrs_.rect.width / 2

	if self.isStopAni then
		var_9_1 = math.min(math.max(self.selectIndex * 300 - var_9_0 / 2, 0), #self.nodeList * 300 - var_9_0)
		self.isStopAni = false
	end

	self.moveLeanTween_ = LeanTween.moveLocalX(self.bubbleparentTrs_.gameObject, -var_9_1, 0.3):setEase(LeanTweenType.easeOutCubic):setOnComplete(LuaHelper.VoidAction(function()
		self:StopLeanTween()
	end))
end

function BlisterGameView:ChangeBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_BLISTER_DESCRIPE")
end

function BlisterGameView:OnTop()
	self.scrollviewSr_.enabled = true
	self.isStopAni = false

	if self.selectIndex ~= 0 and self.nodeList[self.selectIndex] then
		self.nodeList[self.selectIndex]:SetSelect(false)

		self.selectIndex = 0

		BlisterGameData:SaveSetlectIndx(self.selectIndex)
	end

	self:ChangeBar()
	self:UpdateActivityTab()
end

function BlisterGameView:GotoHelp()
	JumpTools.OpenPageByJump("gameHelpPro", {
		isPrefab = true,
		pages = (GameSetting["blister_game_describe" .. self.nowIndex] or nil) and (GameSetting["blister_game_describe" .. self.nowIndex].value or {})
	})
end

function BlisterGameView:OnEnter()
	if BlisterGameData.selectIndex ~= 0 then
		self.selectIndex = BlisterGameData.selectIndex
	end

	if BlisterGameData.pointIndex ~= 0 then
		self.nowIndex = BlisterGameData.pointIndex
	end

	if self.params_.targetSessionIndex then
		self.nowIndex = self.params_.targetSessionIndex
		self.params_.targetSessionIndex = nil
	end

	self.activityID_ = BlisterGameData:GetActivityId()
	self.bActivityIDCfg = BlisterGameTool.GetSubActiveID(self.activityID_)

	self:ChangeBar()
	BlisterGameView.super.OnEnter(self)
	self:RegistEventListener(BLISTERGAME_INFO_UPDATE, function()
		self:OnUpdatePoint()
		self:UpdateActivityTab()
	end)
	self:ChangeTab(self.nowIndex or 1)

	local var_14_0 = ActivityData:GetActivityData(self.activityID_)

	self.startTime_ = var_14_0.startTime
	self.stopTime_ = var_14_0.stopTime

	self:RefreshTimeText()
	self:AddTimer()
	self:AddRedPoint()

	self.textdescribeText_.text = GetTips("ACTIVITY_BUBBLES_DES1")
end

function BlisterGameView:UpdateActivityTab()
	for iter_16_0 = 1, 2 do
		self.btnContrllerList_[iter_16_0]:SetSelectedState(not BlisterGameTool.GetSessionIsLock(self.activityID_, iter_16_0) and ActivityData:GetActivityIsOpen(self.bActivityIDCfg[iter_16_0]) and "unlock" or "lock")
	end
end

function BlisterGameView:AddRedPoint()
	for iter_17_0 = 1, 2 do
		manager.redPoint:bindUIandKey(self.btnList_[iter_17_0].transform, string.format("%s_%s", RedPointConst.BLISTER_GAME, self.bActivityIDCfg[iter_17_0]))
	end

	manager.redPoint:bindUIandKey(self.taskbtnBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_TASK, BlisterGameData.taskActivityId))
end

function BlisterGameView:RemoveRedPoint()
	for iter_18_0 = 1, 2 do
		manager.redPoint:unbindUIandKey(self.btnList_[iter_18_0].transform)
	end

	manager.redPoint:unbindUIandKey(self.taskbtnBtn_.transform)
end

function BlisterGameView:ChangeTab(arg_19_1)
	if BlisterGameTool.GetSessionIsLock(self.activityID_, arg_19_1) then
		ShowTips(GetTips("ACTIVITY_ZUMA_OPEN_FRONT"))

		return
	end

	self.passIndex = 0
	self.nowIndex = arg_19_1

	BlisterGameData:SavePointIndx(self.nowIndex)
	self.tabController_:SetSelectedIndex(arg_19_1 - 1)
	self:UpdateData(self.bActivityIDCfg[arg_19_1])
	self:UpdatePoint()
	self:UpdateSelectMove()
end

function BlisterGameView:UpdateSelectMove()
	self.scrollviewSr_.horizontalNormalizedPosition = self.passIndex / #self.pointlist
end

function BlisterGameView:OnUpdatePoint()
	if self.nowIndex then
		self:ChangeTab(self.nowIndex)
	end
end

function BlisterGameView:OnTask()
	JumpTools.OpenPageByJump("/summerChessBoardTask", {
		taskActivityID = ActivityConst.ACTIVITY_3_4_BLISTER_TASK
	})
end

function BlisterGameView:AddTimer()
	self:StopTimer()
	self:RefreshTimeText()

	self.timer_ = Timer.New(function()
		if manager.time:GetServerTime() > self.stopTime_ then
			return
		end

		self:RefreshTimeText()
	end, 1, -1)

	self.timer_:Start()
end

function BlisterGameView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function BlisterGameView:RefreshTimeText()
	if self.texttimeText_ then
		self.texttimeText_.text = GetTips("REMAINING_TIME") .. manager.time:GetLostTimeStrWith2Unit(self.stopTime_, true)
	end
end

function BlisterGameView:UpdateData(arg_27_1)
	self.pointlist = BlisterGameData:GetShowPointList(arg_27_1) or {}
end

function BlisterGameView:UpdatePoint()
	for iter_28_0 = 1, #self.pointlist do
		self.nodeList[iter_28_0] = self.nodeList[iter_28_0] or BlisterPointItem.New((Object.Instantiate(self.bubblebtn01Go_, self.bubbleparentTrs_)))

		self.nodeList[iter_28_0]:SetData(self.pointlist[iter_28_0], iter_28_0, self)

		if self.pointlist[iter_28_0].isPass then
			self.passIndex = math.max(iter_28_0, self.passIndex)
		end
	end
end

function BlisterGameView:OnExit()
	BlisterGameView.super.OnExit(self)
	self:StopTimer()
	self:RemoveRedPoint()
	manager.windowBar:HideBar()

	for iter_29_0, iter_29_1 in ipairs(self.nodeList) do
		if iter_29_1 and iter_29_1.OnExit then
			iter_29_1:OnExit()
		end
	end

	self.isStopAni = true
end

function BlisterGameView:Dispose()
	BlisterGameView.super.Dispose(self)

	for iter_30_0, iter_30_1 in ipairs(self.nodeList) do
		if iter_30_1 and iter_30_1.Dispose then
			iter_30_1:Dispose()
		end
	end

	self:StopLeanTween()
end

return BlisterGameView

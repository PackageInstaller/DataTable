local WhackMoleMainView = class("WhackMoleMainView", ReduxView)

function WhackMoleMainView:UIName()
	return "Widget/System/Summer2024/Summer2024_WhackMoleUI/CrazyDuckEntranceUI"
end

function WhackMoleMainView:UIParent()
	return manager.ui.uiMain.transform
end

function WhackMoleMainView:Init()
	self:InitUI()
	self:AddUIListener()
end

function WhackMoleMainView:InitUI()
	self:BindCfgUI()
	self:InitStageItem()
	self:InitScrollView()
	self:InitController()
end

function WhackMoleMainView:InitStageItem()
	self.clickStageHandler_ = handler(self, self.OnClickStage)
	self.firstStageItemList_ = {}

	for iter_5_0 = 1, self.firstStageContentTrans_.childCount do
		self.firstStageItemList_[iter_5_0] = WhackMoleStageItem.New(self.firstStageContentTrans_:GetChild(iter_5_0 - 1).gameObject)

		self.firstStageItemList_[iter_5_0]:SetClickCallback(self.clickStageHandler_)
	end

	self.secondStageItemList_ = {}

	for iter_5_1 = 1, self.secondStageContentTrans_.childCount do
		local var_5_0 = self.secondStageContentTrans_:GetChild(iter_5_1 - 1).gameObject

		self.secondStageItemList_[iter_5_1] = iter_5_1 ~= self.secondStageContentTrans_.childCount and WhackMoleStageItem.New(var_5_0) or WhackMoleInfinityStageItem.New(var_5_0)

		self.secondStageItemList_[iter_5_1]:SetClickCallback(self.clickStageHandler_)
	end
end

function WhackMoleMainView:InitScrollView()
	self.scrollView_ = StageScrollView.New(self.scrollViewGo_)

	self.scrollView_:RegistPointerUp(handler(self, self.TryCloseSectionView))
	self.scrollView_:RegistBeginDrag(handler(self, self.TryCloseSectionView))
end

function WhackMoleMainView:InitController()
	self.sessionController_ = self.sessionControllerEx_:GetController("session")
	self.sessionUnlockController_ = self.sessionControllerEx_:GetController("sessionUnlock")
end

function WhackMoleMainView:AddUIListener()
	self:AddBtnListener(self.taskBtn_, nil, function()
		if not ActivityTools.ActivityOpenCheck(self.activityID_) then
			return
		end

		if self:IsOpenSectionView() then
			JumpTools.Back()
		end

		JumpTools.OpenPageByJump("/summerChessBoardTask", {
			taskActivityID = WhackMoleTools.GetTaskID(self.activityID_)
		})
	end)
	self:AddBtnListener(self.firstStageBtn_, nil, function()
		if not ActivityTools.ActivityOpenCheck(self.activityID_) then
			return
		end

		if WhackMoleTools.GetSessionIsLock(self.activityID_, WhackMoleConst.SESSION_INDEX.FIRST) then
			return
		end

		self:SwitchSession(WhackMoleConst.SESSION_INDEX.FIRST)
	end)
	self:AddBtnListener(self.secondStageBtn_, nil, function()
		if not ActivityTools.ActivityOpenCheck(self.activityID_) then
			return
		end

		if WhackMoleTools.GetSessionIsLock(self.activityID_, WhackMoleConst.SESSION_INDEX.SECOND) then
			return
		end

		self:SwitchSession(WhackMoleConst.SESSION_INDEX.SECOND)
	end)
end

function WhackMoleMainView:OnEnter()
	self.activityID_ = self.params_.activityID

	if not ActivityData:GetActivityIsOpen(self.activityID_) then
		ShowTips("TIME_OVER")
	end

	self:RefreshSessionUnLock()
	self:SwitchSession(self:InitSessionIndex())
	self:BindRedPoint()
	self:UpdateBar()
	self:AddTimer()
end

function WhackMoleMainView:OnTop()
	self.curSelectWhackMoleID_ = nil

	self:RefreshSelectStage()
	self.scrollView_:Recover()
end

function WhackMoleMainView:InitSessionIndex()
	local var_14_0

	if self.params_.targetSessionIndex then
		var_14_0 = self.params_.targetSessionIndex
	else
		var_14_0 = WhackMoleTools.GetLastSessionIndex() or WhackMoleConst.SESSION_INDEX.FIRST

		if WhackMoleTools.GetSessionIsFirstEnter(self.activityID_, WhackMoleConst.SESSION_INDEX.SECOND) then
			var_14_0 = WhackMoleConst.SESSION_INDEX.SECOND
		end
	end

	return var_14_0
end

function WhackMoleMainView:OnExit()
	self:SaveTempContentPos()
	WhackMoleTools.SetLastSessionIndex(self.sessionIndex_)
	self.scrollView_:OnExit()
	self:StopAnim()
	self:UnbindRedPoint()
	manager.windowBar:HideBar()
	self:StopTimer()
end

function WhackMoleMainView:SaveTempContentPos()
	if not self.sessionIndex_ then
		return
	end

	WhackMoleData:SetLastContentPosX(self.activityID_, self.sessionIndex_, (self.scrollContentTrans_:GetAnchoredPositionX(nil)))
end

function WhackMoleMainView:Dispose()
	for iter_17_0, iter_17_1 in ipairs(self.firstStageItemList_) do
		iter_17_1:Dispose()
	end

	self.firstStageItemList_ = nil

	for iter_17_2, iter_17_3 in ipairs(self.secondStageItemList_) do
		iter_17_3:Dispose()
	end

	self.secondStageItemList_ = nil

	self.scrollView_:Dispose()

	self.scrollView_ = nil

	WhackMoleMainView.super.Dispose(self)
end

function WhackMoleMainView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_WHACK_MOLE_DESCRIPE")
end

function WhackMoleMainView:RefreshSessionUnLock()
	if WhackMoleTools.GetSessionIsLock(self.activityID_, WhackMoleConst.SESSION_INDEX.SECOND) then
		self.sessionUnlockController_:SetSelectedState(tostring(WhackMoleConst.SESSION_INDEX.FIRST))
	else
		self.sessionUnlockController_:SetSelectedState(tostring(WhackMoleConst.SESSION_INDEX.SECOND))

		self.sessionBtnAnim_.enabled = true

		self.sessionBtnAnim_:Play("ui_btnAnim_cx", -1, 0)
		self.sessionBtnAnim_:Update(0)
	end
end

function WhackMoleMainView:SwitchSession(arg_20_1)
	if self.sessionIndex_ == arg_20_1 then
		return
	end

	if self:IsOpenSectionView() then
		JumpTools.Back()
	end

	self:SaveTempContentPos()
	self:SetSessionIndex(arg_20_1)
	self:ProcessScrollPos()
	self:RefreshItemList()
end

function WhackMoleMainView:SetSessionIndex(arg_21_1)
	self.sessionIndex_ = arg_21_1

	WhackMoleData:SetHadEntered(self.activityID_, self.sessionIndex_)
	self.sessionController_:SetSelectedState(tostring(self.sessionIndex_))
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.scrollContentTrans_)
end

function WhackMoleMainView:ProcessScrollPos()
	local var_22_0 = WhackMoleData:GetLastContentPosX(self.activityID_, self.sessionIndex_)

	if var_22_0 then
		self.scrollContentTrans_:SetAnchoredPositionX(var_22_0)
	else
		self.scrollContentTrans_:SetAnchoredPositionX(0)
	end
end

function WhackMoleMainView:RefreshItemList()
	self.whackMoleIDList_ = WhackMoleTools.GetSessionStageList(self.activityID_, self.sessionIndex_)

	local var_23_0

	if self.sessionIndex_ == WhackMoleConst.SESSION_INDEX.FIRST then
		var_23_0 = self.firstStageItemList_ or self.secondStageItemList_
	end

	for iter_23_0, iter_23_1 in ipairs(var_23_0) do
		iter_23_1:SetActive(true)
		iter_23_1:SetData(self.activityID_, self.whackMoleIDList_[iter_23_0])
	end

	for iter_23_2 = #self.whackMoleIDList_ + 1, #var_23_0 do
		var_23_0[iter_23_2]:SetActive(false)
	end

	self:RefreshSelectStage()
end

function WhackMoleMainView:OnClickStage(arg_24_1, arg_24_2)
	if self.curSelectWhackMoleID_ == arg_24_1 then
		return
	end

	self.curSelectWhackMoleID_ = arg_24_1

	self:RefreshSelectStage(arg_24_1)
	self:MoveStageContent(arg_24_2)
	JumpTools.OpenPageByJump("whackMoleSectionInfo", {
		activityID = self.activityID_,
		whackMoleID = arg_24_1
	})
end

function WhackMoleMainView:RefreshSelectStage(arg_25_1)
	for iter_25_0, iter_25_1 in ipairs((self.sessionIndex_ == WhackMoleConst.SESSION_INDEX.FIRST or nil) and (self.firstStageItemList_ or self.secondStageItemList_)) do
		iter_25_1:RefreshSelect(arg_25_1)
	end
end

function WhackMoleMainView:MoveStageContent(arg_26_1)
	self.scrollView_:MoveContentScreenPosXDelta(UnityEngine.RectTransformUtility.WorldToScreenPoint(manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera, arg_26_1).x - Screen.width / 2)
end

function WhackMoleMainView:AddTimer()
	self:StopTimer()

	self.remainTimeText_.text = GetTips("REMAINING_TIME") .. ActivityTools.GetActivityLostTimeStrWith2Unit(self.activityID_)
	self.timer_ = Timer.New(function()
		self.remainTimeText_.text = GetTips("REMAINING_TIME") .. ActivityTools.GetActivityLostTimeStrWith2Unit(self.activityID_)
	end, 1, -1)

	self.timer_:Start()
end

function WhackMoleMainView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function WhackMoleMainView:IsOpenSectionView()
	return self:IsOpenRoute("whackMoleSectionInfo")
end

function WhackMoleMainView:TryCloseSectionView()
	if self:IsOpenSectionView() then
		JumpTools.Back()
	end
end

function WhackMoleMainView:BindRedPoint()
	manager.redPoint:bindUIandKey(self.taskBtn_.transform, (string.format("%s_%s", RedPointConst.ACTIVITY_TASK, (WhackMoleTools.GetTaskID(self.activityID_)))))
end

function WhackMoleMainView:UnbindRedPoint()
	manager.redPoint:unbindUIandKey(self.taskBtn_.transform, (string.format("%s_%s", RedPointConst.ACTIVITY_TASK, (WhackMoleTools.GetTaskID(self.activityID_)))))
end

function WhackMoleMainView:StopAnim()
	AnimatorTools.Stop()

	self.sessionBtnAnim_.enabled = false
end

return WhackMoleMainView

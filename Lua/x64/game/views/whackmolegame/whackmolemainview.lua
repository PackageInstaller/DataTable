local var_0_0 = class("WhackMoleMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Summer2024/Summer2024_WhackMoleUI/CrazyDuckEntranceUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:InitStageItem()
	arg_4_0:InitScrollView()
	arg_4_0:InitController()
end

function var_0_0.InitStageItem(arg_5_0)
	arg_5_0.clickStageHandler_ = handler(arg_5_0, arg_5_0.OnClickStage)
	arg_5_0.firstStageItemList_ = {}

	local var_5_0 = arg_5_0.firstStageContentTrans_.childCount

	for iter_5_0 = 1, var_5_0 do
		local var_5_1 = arg_5_0.firstStageContentTrans_:GetChild(iter_5_0 - 1).gameObject

		arg_5_0.firstStageItemList_[iter_5_0] = WhackMoleStageItem.New(var_5_1)

		arg_5_0.firstStageItemList_[iter_5_0]:SetClickCallback(arg_5_0.clickStageHandler_)
	end

	arg_5_0.secondStageItemList_ = {}

	local var_5_2 = arg_5_0.secondStageContentTrans_.childCount

	for iter_5_1 = 1, var_5_2 do
		local var_5_3 = arg_5_0.secondStageContentTrans_:GetChild(iter_5_1 - 1).gameObject
		local var_5_4

		if iter_5_1 ~= var_5_2 then
			var_5_4 = WhackMoleStageItem.New(var_5_3)
		else
			var_5_4 = WhackMoleInfinityStageItem.New(var_5_3)
		end

		arg_5_0.secondStageItemList_[iter_5_1] = var_5_4

		arg_5_0.secondStageItemList_[iter_5_1]:SetClickCallback(arg_5_0.clickStageHandler_)
	end
end

function var_0_0.InitScrollView(arg_6_0)
	arg_6_0.scrollView_ = StageScrollView.New(arg_6_0.scrollViewGo_)

	arg_6_0.scrollView_:RegistPointerUp(handler(arg_6_0, arg_6_0.TryCloseSectionView))
	arg_6_0.scrollView_:RegistBeginDrag(handler(arg_6_0, arg_6_0.TryCloseSectionView))
end

function var_0_0.InitController(arg_7_0)
	arg_7_0.sessionController_ = arg_7_0.sessionControllerEx_:GetController("session")
	arg_7_0.sessionUnlockController_ = arg_7_0.sessionControllerEx_:GetController("sessionUnlock")
end

function var_0_0.AddUIListener(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.taskBtn_, nil, function()
		if not ActivityTools.ActivityOpenCheck(arg_8_0.activityID_) then
			return
		end

		if arg_8_0:IsOpenSectionView() then
			JumpTools.Back()
		end

		JumpTools.OpenPageByJump("/summerChessBoardTask", {
			taskActivityID = WhackMoleTools.GetTaskID(arg_8_0.activityID_)
		})
	end)
	arg_8_0:AddBtnListener(arg_8_0.firstStageBtn_, nil, function()
		if not ActivityTools.ActivityOpenCheck(arg_8_0.activityID_) then
			return
		end

		if WhackMoleTools.GetSessionIsLock(arg_8_0.activityID_, WhackMoleConst.SESSION_INDEX.FIRST) then
			return
		end

		arg_8_0:SwitchSession(WhackMoleConst.SESSION_INDEX.FIRST)
	end)
	arg_8_0:AddBtnListener(arg_8_0.secondStageBtn_, nil, function()
		if not ActivityTools.ActivityOpenCheck(arg_8_0.activityID_) then
			return
		end

		if WhackMoleTools.GetSessionIsLock(arg_8_0.activityID_, WhackMoleConst.SESSION_INDEX.SECOND) then
			return
		end

		arg_8_0:SwitchSession(WhackMoleConst.SESSION_INDEX.SECOND)
	end)
end

function var_0_0.OnEnter(arg_12_0)
	arg_12_0.activityID_ = arg_12_0.params_.activityID

	if not ActivityData:GetActivityIsOpen(arg_12_0.activityID_) then
		ShowTips("TIME_OVER")
	end

	arg_12_0:RefreshSessionUnLock()
	arg_12_0:SwitchSession(arg_12_0:InitSessionIndex())
	arg_12_0:BindRedPoint()
	arg_12_0:UpdateBar()
	arg_12_0:AddTimer()
end

function var_0_0.OnTop(arg_13_0)
	arg_13_0.curSelectWhackMoleID_ = nil

	arg_13_0:RefreshSelectStage()
	arg_13_0.scrollView_:Recover()
end

function var_0_0.InitSessionIndex(arg_14_0)
	local var_14_0

	if arg_14_0.params_.targetSessionIndex then
		var_14_0 = arg_14_0.params_.targetSessionIndex
	else
		var_14_0 = WhackMoleTools.GetLastSessionIndex() or WhackMoleConst.SESSION_INDEX.FIRST

		if WhackMoleTools.GetSessionIsFirstEnter(arg_14_0.activityID_, WhackMoleConst.SESSION_INDEX.SECOND) then
			var_14_0 = WhackMoleConst.SESSION_INDEX.SECOND
		end
	end

	return var_14_0
end

function var_0_0.OnExit(arg_15_0)
	arg_15_0:SaveTempContentPos()
	WhackMoleTools.SetLastSessionIndex(arg_15_0.sessionIndex_)
	arg_15_0.scrollView_:OnExit()
	arg_15_0:StopAnim()
	arg_15_0:UnbindRedPoint()
	manager.windowBar:HideBar()
	arg_15_0:StopTimer()
end

function var_0_0.SaveTempContentPos(arg_16_0)
	if not arg_16_0.sessionIndex_ then
		return
	end

	local var_16_0 = arg_16_0.scrollContentTrans_:GetAnchoredPositionX(nil)

	WhackMoleData:SetLastContentPosX(arg_16_0.activityID_, arg_16_0.sessionIndex_, var_16_0)
end

function var_0_0.Dispose(arg_17_0)
	for iter_17_0, iter_17_1 in ipairs(arg_17_0.firstStageItemList_) do
		iter_17_1:Dispose()
	end

	arg_17_0.firstStageItemList_ = nil

	for iter_17_2, iter_17_3 in ipairs(arg_17_0.secondStageItemList_) do
		iter_17_3:Dispose()
	end

	arg_17_0.secondStageItemList_ = nil

	arg_17_0.scrollView_:Dispose()

	arg_17_0.scrollView_ = nil

	var_0_0.super.Dispose(arg_17_0)
end

function var_0_0.UpdateBar(arg_18_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_WHACK_MOLE_DESCRIPE")
end

function var_0_0.RefreshSessionUnLock(arg_19_0)
	if WhackMoleTools.GetSessionIsLock(arg_19_0.activityID_, WhackMoleConst.SESSION_INDEX.SECOND) then
		arg_19_0.sessionUnlockController_:SetSelectedState(tostring(WhackMoleConst.SESSION_INDEX.FIRST))
	else
		arg_19_0.sessionUnlockController_:SetSelectedState(tostring(WhackMoleConst.SESSION_INDEX.SECOND))

		arg_19_0.sessionBtnAnim_.enabled = true

		arg_19_0.sessionBtnAnim_:Play("ui_btnAnim_cx", -1, 0)
		arg_19_0.sessionBtnAnim_:Update(0)
	end
end

function var_0_0.SwitchSession(arg_20_0, arg_20_1)
	if arg_20_0.sessionIndex_ == arg_20_1 then
		return
	end

	if arg_20_0:IsOpenSectionView() then
		JumpTools.Back()
	end

	arg_20_0:SaveTempContentPos()
	arg_20_0:SetSessionIndex(arg_20_1)
	arg_20_0:ProcessScrollPos()
	arg_20_0:RefreshItemList()
end

function var_0_0.SetSessionIndex(arg_21_0, arg_21_1)
	arg_21_0.sessionIndex_ = arg_21_1

	WhackMoleData:SetHadEntered(arg_21_0.activityID_, arg_21_0.sessionIndex_)
	arg_21_0.sessionController_:SetSelectedState(tostring(arg_21_0.sessionIndex_))
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_0.scrollContentTrans_)
end

function var_0_0.ProcessScrollPos(arg_22_0)
	local var_22_0 = WhackMoleData:GetLastContentPosX(arg_22_0.activityID_, arg_22_0.sessionIndex_)

	if var_22_0 then
		arg_22_0.scrollContentTrans_:SetAnchoredPositionX(var_22_0)
	else
		arg_22_0.scrollContentTrans_:SetAnchoredPositionX(0)
	end
end

function var_0_0.RefreshItemList(arg_23_0)
	arg_23_0.whackMoleIDList_ = WhackMoleTools.GetSessionStageList(arg_23_0.activityID_, arg_23_0.sessionIndex_)

	local var_23_0 = arg_23_0.sessionIndex_ == WhackMoleConst.SESSION_INDEX.FIRST and arg_23_0.firstStageItemList_ or arg_23_0.secondStageItemList_

	for iter_23_0, iter_23_1 in ipairs(var_23_0) do
		iter_23_1:SetActive(true)
		iter_23_1:SetData(arg_23_0.activityID_, arg_23_0.whackMoleIDList_[iter_23_0])
	end

	for iter_23_2 = #arg_23_0.whackMoleIDList_ + 1, #var_23_0 do
		var_23_0[iter_23_2]:SetActive(false)
	end

	arg_23_0:RefreshSelectStage()
end

function var_0_0.OnClickStage(arg_24_0, arg_24_1, arg_24_2)
	if arg_24_0.curSelectWhackMoleID_ == arg_24_1 then
		return
	end

	arg_24_0.curSelectWhackMoleID_ = arg_24_1

	arg_24_0:RefreshSelectStage(arg_24_1)
	arg_24_0:MoveStageContent(arg_24_2)
	JumpTools.OpenPageByJump("whackMoleSectionInfo", {
		activityID = arg_24_0.activityID_,
		whackMoleID = arg_24_1
	})
end

function var_0_0.RefreshSelectStage(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0.sessionIndex_ == WhackMoleConst.SESSION_INDEX.FIRST and arg_25_0.firstStageItemList_ or arg_25_0.secondStageItemList_

	for iter_25_0, iter_25_1 in ipairs(var_25_0) do
		iter_25_1:RefreshSelect(arg_25_1)
	end
end

function var_0_0.MoveStageContent(arg_26_0, arg_26_1)
	local var_26_0 = UnityEngine.RectTransformUtility.WorldToScreenPoint(manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera, arg_26_1).x - Screen.width / 2

	arg_26_0.scrollView_:MoveContentScreenPosXDelta(var_26_0)
end

function var_0_0.AddTimer(arg_27_0)
	arg_27_0:StopTimer()

	arg_27_0.remainTimeText_.text = GetTips("REMAINING_TIME") .. ActivityTools.GetActivityLostTimeStrWith2Unit(arg_27_0.activityID_)
	arg_27_0.timer_ = Timer.New(function()
		arg_27_0.remainTimeText_.text = GetTips("REMAINING_TIME") .. ActivityTools.GetActivityLostTimeStrWith2Unit(arg_27_0.activityID_)
	end, 1, -1)

	arg_27_0.timer_:Start()
end

function var_0_0.StopTimer(arg_29_0)
	if arg_29_0.timer_ then
		arg_29_0.timer_:Stop()

		arg_29_0.timer_ = nil
	end
end

function var_0_0.IsOpenSectionView(arg_30_0)
	return arg_30_0:IsOpenRoute("whackMoleSectionInfo")
end

function var_0_0.TryCloseSectionView(arg_31_0)
	if arg_31_0:IsOpenSectionView() then
		JumpTools.Back()
	end
end

function var_0_0.BindRedPoint(arg_32_0)
	local var_32_0 = WhackMoleTools.GetTaskID(arg_32_0.activityID_)
	local var_32_1 = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, var_32_0)

	manager.redPoint:bindUIandKey(arg_32_0.taskBtn_.transform, var_32_1)
end

function var_0_0.UnbindRedPoint(arg_33_0)
	local var_33_0 = WhackMoleTools.GetTaskID(arg_33_0.activityID_)
	local var_33_1 = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, var_33_0)

	manager.redPoint:unbindUIandKey(arg_33_0.taskBtn_.transform, var_33_1)
end

function var_0_0.StopAnim(arg_34_0)
	AnimatorTools.Stop()

	arg_34_0.sessionBtnAnim_.enabled = false
end

return var_0_0

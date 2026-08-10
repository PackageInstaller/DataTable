local var_0_0 = class("BlisterGameView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Summer2024/Summer2024_BlisterGame/BlisterGame01"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	arg_3_0.selectIndex = 0
	arg_3_0.nowIndex = 1
	arg_3_0.isStopAni = true
	arg_3_0.passIndex = 0
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddListeners()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.tabController_ = arg_5_0.choicebtnControllerexcollection_:GetController("tab")
	arg_5_0.nodeList = {}
	arg_5_0.pointlist = {}
	arg_5_0.btnList_ = {}
	arg_5_0.btnContrllerList_ = {}

	for iter_5_0 = 1, 2 do
		arg_5_0.btnList_[iter_5_0] = arg_5_0[string.format("nextbtn0%sBtn_", iter_5_0)]
		arg_5_0.btnContrllerList_[iter_5_0] = arg_5_0["btnCon_" .. iter_5_0]:GetController("lock")
	end
end

function var_0_0.AddListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.taskbtnBtn_, nil, "OnTask")

	for iter_6_0 = 1, 2 do
		arg_6_0:AddBtnListener(arg_6_0.btnList_[iter_6_0], nil, function()
			arg_6_0:ChangeTab(iter_6_0)
		end)
	end
end

function var_0_0.StopLeanTween(arg_8_0)
	if arg_8_0.moveLeanTween_ then
		arg_8_0.moveLeanTween_:setOnComplete(nil):setEase(nil)
		LeanTween.cancel(arg_8_0.moveLeanTween_.id)

		arg_8_0.moveLeanTween_ = nil
	end
end

function var_0_0.SetSelect(arg_9_0, arg_9_1)
	if arg_9_0.selectIndex and arg_9_0.nodeList[arg_9_0.selectIndex] then
		arg_9_0.nodeList[arg_9_0.selectIndex]:SetSelect(false)
	end

	arg_9_0.selectIndex = arg_9_1

	BlisterGameData:SaveSetlectIndx(arg_9_0.selectIndex)

	if arg_9_0.nodeList[arg_9_0.selectIndex] then
		arg_9_0.nodeList[arg_9_0.selectIndex]:SetSelect(true)
	end

	local var_9_0 = arg_9_0.scrollviewTrs_.rect.width
	local var_9_1 = arg_9_0.selectIndex * 300
	local var_9_2 = var_9_1 - var_9_0 / 2

	if arg_9_0.isStopAni then
		var_9_2 = math.min(math.max(var_9_1 - var_9_0 / 2, 0), #arg_9_0.nodeList * 300 - var_9_0)
		arg_9_0.isStopAni = false
	end

	arg_9_0.moveLeanTween_ = LeanTween.moveLocalX(arg_9_0.bubbleparentTrs_.gameObject, -var_9_2, 0.3):setEase(LeanTweenType.easeOutCubic):setOnComplete(LuaHelper.VoidAction(function()
		arg_9_0:StopLeanTween()
	end))
end

function var_0_0.ChangeBar(arg_11_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_BLISTER_DESCRIPE")
end

function var_0_0.OnTop(arg_12_0)
	arg_12_0.scrollviewSr_.enabled = true
	arg_12_0.isStopAni = false

	if arg_12_0.selectIndex ~= 0 and arg_12_0.nodeList[arg_12_0.selectIndex] then
		arg_12_0.nodeList[arg_12_0.selectIndex]:SetSelect(false)

		arg_12_0.selectIndex = 0

		BlisterGameData:SaveSetlectIndx(arg_12_0.selectIndex)
	end

	arg_12_0:ChangeBar()
	arg_12_0:UpdateActivityTab()
end

function var_0_0.GotoHelp(arg_13_0)
	local var_13_0 = "blister_game_describe" .. arg_13_0.nowIndex
	local var_13_1 = GameSetting[var_13_0] and GameSetting[var_13_0].value or {}

	JumpTools.OpenPageByJump("gameHelpPro", {
		isPrefab = true,
		pages = var_13_1
	})
end

function var_0_0.OnEnter(arg_14_0)
	if BlisterGameData.selectIndex ~= 0 then
		arg_14_0.selectIndex = BlisterGameData.selectIndex
	end

	if BlisterGameData.pointIndex ~= 0 then
		arg_14_0.nowIndex = BlisterGameData.pointIndex
	end

	if arg_14_0.params_.targetSessionIndex then
		arg_14_0.nowIndex = arg_14_0.params_.targetSessionIndex
		arg_14_0.params_.targetSessionIndex = nil
	end

	arg_14_0.activityID_ = BlisterGameData:GetActivityId()
	arg_14_0.bActivityIDCfg = BlisterGameTool.GetSubActiveID(arg_14_0.activityID_)

	arg_14_0:ChangeBar()
	var_0_0.super.OnEnter(arg_14_0)
	arg_14_0:RegistEventListener(BLISTERGAME_INFO_UPDATE, function()
		arg_14_0:OnUpdatePoint()
		arg_14_0:UpdateActivityTab()
	end)
	arg_14_0:ChangeTab(arg_14_0.nowIndex or 1)

	local var_14_0 = ActivityData:GetActivityData(arg_14_0.activityID_)

	arg_14_0.startTime_ = var_14_0.startTime
	arg_14_0.stopTime_ = var_14_0.stopTime

	arg_14_0:RefreshTimeText()
	arg_14_0:AddTimer()
	arg_14_0:AddRedPoint()

	arg_14_0.textdescribeText_.text = GetTips("ACTIVITY_BUBBLES_DES1")
end

function var_0_0.UpdateActivityTab(arg_16_0)
	for iter_16_0 = 1, 2 do
		local var_16_0 = ActivityData:GetActivityIsOpen(arg_16_0.bActivityIDCfg[iter_16_0])
		local var_16_1 = not BlisterGameTool.GetSessionIsLock(arg_16_0.activityID_, iter_16_0)

		arg_16_0.btnContrllerList_[iter_16_0]:SetSelectedState(var_16_1 and var_16_0 and "unlock" or "lock")
	end
end

function var_0_0.AddRedPoint(arg_17_0)
	for iter_17_0 = 1, 2 do
		manager.redPoint:bindUIandKey(arg_17_0.btnList_[iter_17_0].transform, string.format("%s_%s", RedPointConst.BLISTER_GAME, arg_17_0.bActivityIDCfg[iter_17_0]))
	end

	manager.redPoint:bindUIandKey(arg_17_0.taskbtnBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_TASK, BlisterGameData.taskActivityId))
end

function var_0_0.RemoveRedPoint(arg_18_0)
	for iter_18_0 = 1, 2 do
		manager.redPoint:unbindUIandKey(arg_18_0.btnList_[iter_18_0].transform)
	end

	manager.redPoint:unbindUIandKey(arg_18_0.taskbtnBtn_.transform)
end

function var_0_0.ChangeTab(arg_19_0, arg_19_1)
	if BlisterGameTool.GetSessionIsLock(arg_19_0.activityID_, arg_19_1) then
		ShowTips(GetTips("ACTIVITY_ZUMA_OPEN_FRONT"))

		return
	end

	arg_19_0.passIndex = 0
	arg_19_0.nowIndex = arg_19_1

	BlisterGameData:SavePointIndx(arg_19_0.nowIndex)
	arg_19_0.tabController_:SetSelectedIndex(arg_19_1 - 1)
	arg_19_0:UpdateData(arg_19_0.bActivityIDCfg[arg_19_1])
	arg_19_0:UpdatePoint()
	arg_19_0:UpdateSelectMove()
end

function var_0_0.UpdateSelectMove(arg_20_0)
	arg_20_0.scrollviewSr_.horizontalNormalizedPosition = arg_20_0.passIndex / #arg_20_0.pointlist
end

function var_0_0.OnUpdatePoint(arg_21_0)
	if arg_21_0.nowIndex then
		arg_21_0:ChangeTab(arg_21_0.nowIndex)
	end
end

function var_0_0.OnTask(arg_22_0)
	JumpTools.OpenPageByJump("/summerChessBoardTask", {
		taskActivityID = ActivityConst.ACTIVITY_3_4_BLISTER_TASK
	})
end

function var_0_0.AddTimer(arg_23_0)
	arg_23_0:StopTimer()
	arg_23_0:RefreshTimeText()

	arg_23_0.timer_ = Timer.New(function()
		if manager.time:GetServerTime() > arg_23_0.stopTime_ then
			return
		end

		arg_23_0:RefreshTimeText()
	end, 1, -1)

	arg_23_0.timer_:Start()
end

function var_0_0.StopTimer(arg_25_0)
	if arg_25_0.timer_ then
		arg_25_0.timer_:Stop()

		arg_25_0.timer_ = nil
	end
end

function var_0_0.RefreshTimeText(arg_26_0)
	if arg_26_0.texttimeText_ then
		arg_26_0.texttimeText_.text = GetTips("REMAINING_TIME") .. manager.time:GetLostTimeStrWith2Unit(arg_26_0.stopTime_, true)
	end
end

function var_0_0.UpdateData(arg_27_0, arg_27_1)
	arg_27_0.pointlist = BlisterGameData:GetShowPointList(arg_27_1) or {}
end

function var_0_0.UpdatePoint(arg_28_0)
	for iter_28_0 = 1, #arg_28_0.pointlist do
		if not arg_28_0.nodeList[iter_28_0] then
			local var_28_0 = Object.Instantiate(arg_28_0.bubblebtn01Go_, arg_28_0.bubbleparentTrs_)

			arg_28_0.nodeList[iter_28_0] = BlisterPointItem.New(var_28_0)
		end

		arg_28_0.nodeList[iter_28_0]:SetData(arg_28_0.pointlist[iter_28_0], iter_28_0, arg_28_0)

		if arg_28_0.pointlist[iter_28_0].isPass then
			arg_28_0.passIndex = math.max(iter_28_0, arg_28_0.passIndex)
		end
	end
end

function var_0_0.OnExit(arg_29_0)
	var_0_0.super.OnExit(arg_29_0)
	arg_29_0:StopTimer()
	arg_29_0:RemoveRedPoint()
	manager.windowBar:HideBar()

	for iter_29_0, iter_29_1 in ipairs(arg_29_0.nodeList) do
		if iter_29_1 and iter_29_1.OnExit then
			iter_29_1:OnExit()
		end
	end

	arg_29_0.isStopAni = true
end

function var_0_0.Dispose(arg_30_0)
	var_0_0.super.Dispose(arg_30_0)

	for iter_30_0, iter_30_1 in ipairs(arg_30_0.nodeList) do
		if iter_30_1 and iter_30_1.Dispose then
			iter_30_1:Dispose()
		end
	end

	arg_30_0:StopLeanTween()
end

return var_0_0

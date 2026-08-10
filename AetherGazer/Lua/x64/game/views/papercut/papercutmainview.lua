local var_0_0 = class("PaperCutMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/EmptyDream/PaperCut/PaperCutMainUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0.clickSwitchItemHandler_ = handler(arg_3_0, arg_3_0.OnClickSwitchItem)
	arg_3_0.onSenceLoadedHandler_ = handler(arg_3_0, arg_3_0.OnSceneLoaded)

	arg_3_0:InitUI()
	arg_3_0:AddUIListener()

	arg_3_0.sceneLoaded_ = false
	arg_3_0.switchList_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexItem), arg_3_0.listGo_, PaperCutSelectItem)
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.rewardBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_5_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if manager.time:GetServerTime() >= arg_5_0.stopTime_ then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("paperCutReward", {
			activityID = arg_5_0.activityID_
		})
	end)
end

function var_0_0.OnEnter(arg_7_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_CUT_DESCRIPE")
	manager.windowBar:RegistBackCallBack(function()
		arg_7_0:UnLoadPaperCutScene()
		arg_7_0:Back()
	end)
	manager.windowBar:RegistHomeCallBack(function()
		arg_7_0:UnLoadPaperCutScene()
		gameContext:Go("/home", nil, nil, true)
	end)

	if arg_7_0.sceneLoaded_ == false then
		arg_7_0:LoadPaperCutScene()
	end

	arg_7_0.activityID_ = arg_7_0.params_.activityID
	arg_7_0.stopTime_ = ActivityData:GetActivityData(arg_7_0.activityID_).stopTime

	arg_7_0:RefreshUI()
	arg_7_0:AddTimer()
	manager.redPoint:bindUIandKey(arg_7_0.rewardBtnTrans_, string.format("%s_%s_Reward", RedPointConst.PAPER_CUT, arg_7_0.activityID_))
end

function var_0_0.OnExit(arg_10_0)
	manager.windowBar:HideBar()
	arg_10_0:StopTimer()
	manager.redPoint:unbindUIandKey(arg_10_0.rewardBtnTrans_, string.format("%s_%s_Reward", RedPointConst.PAPER_CUT, arg_10_0.activityID_))

	arg_10_0.scrollPos_ = arg_10_0.switchList_:GetScrolledPosition()
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0.onSenceLoadedHandler_ = nil
	arg_11_0.clickSwitchItemHandler_ = nil

	arg_11_0.switchList_:Dispose()
	var_0_0.super.Dispose(arg_11_0)
end

function var_0_0.LoadPaperCutScene(arg_12_0)
	manager.ui:SetMainCamera("paperCut")

	manager.ui.mainCameraCom_.orthographic = true

	PaperCutTool:LoadScene(arg_12_0.onSenceLoadedHandler_)
end

function var_0_0.OnSceneLoaded(arg_13_0)
	arg_13_0.sceneLoaded_ = true
end

function var_0_0.UnLoadPaperCutScene(arg_14_0)
	arg_14_0.sceneLoaded_ = false

	manager.ui:ResetMainCamera()

	manager.ui.mainCameraCom_.orthographic = false

	PaperCutTool:UnLoadScene()
end

function var_0_0.RefreshUI(arg_15_0)
	arg_15_0.subActivityList_ = ActivityCfg[arg_15_0.activityID_].sub_activity_list

	if arg_15_0.scrollPos_ ~= nil then
		arg_15_0.switchList_:StartScrollByPosition(#arg_15_0.subActivityList_, arg_15_0.scrollPos_)
	else
		arg_15_0.switchList_:StartScroll(#arg_15_0.subActivityList_)
	end
end

function var_0_0.IndexItem(arg_16_0, arg_16_1, arg_16_2)
	arg_16_2:SetData(arg_16_0.activityID_, arg_16_0.subActivityList_[arg_16_1])
	arg_16_2:SetClickCallBack(arg_16_0.clickSwitchItemHandler_)
end

function var_0_0.AddTimer(arg_17_0)
	if manager.time:GetServerTime() >= arg_17_0.stopTime_ then
		arg_17_0.remainTimeText_.text = GetTips("TIME_OVER")

		return
	end

	arg_17_0.remainTimeText_.text = manager.time:GetLostTimeStr(arg_17_0.stopTime_)

	local var_17_0 = arg_17_0.switchList_:GetItemList()

	for iter_17_0, iter_17_1 in ipairs(var_17_0) do
		iter_17_1:RefreshLock()
	end

	arg_17_0:StopTimer()

	arg_17_0.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= arg_17_0.stopTime_ then
			arg_17_0:StopTimer()

			arg_17_0.remainTimeText_.text = GetTips("TIME_OVER")

			return
		end

		var_17_0 = arg_17_0.switchList_:GetItemList()

		for iter_18_0, iter_18_1 in ipairs(var_17_0) do
			iter_18_1:RefreshLock()
		end

		arg_17_0.remainTimeText_.text = manager.time:GetLostTimeStr(arg_17_0.stopTime_)
	end, 1, -1)

	arg_17_0.timer_:Start()
end

function var_0_0.StopTimer(arg_19_0)
	if arg_19_0.timer_ then
		arg_19_0.timer_:Stop()

		arg_19_0.timer_ = nil
	end
end

function var_0_0.OnClickSwitchItem(arg_20_0, arg_20_1)
	arg_20_0.selectActivityID_ = arg_20_1

	arg_20_0:Go("/paperCutPlay", {
		activityID = arg_20_1,
		mainActivityID = arg_20_0.activityID_,
		goHomeHandler = handler(arg_20_0, arg_20_0.OnGoHome)
	})
	PaperCutTool:GameStart(arg_20_1)
end

function var_0_0.OnGoHome(arg_21_0)
	arg_21_0:UnLoadPaperCutScene()
	gameContext:Go("/home", nil, nil, true)
end

return var_0_0

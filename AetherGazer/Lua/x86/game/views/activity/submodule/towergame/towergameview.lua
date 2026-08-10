local var_0_0 = class("TowerGameView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/MardukUI/snakeactive/MardukSnakemainUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.selectStageItemHandler_ = handler(arg_4_0, arg_4_0.OnSelectStageItem)
	arg_4_0.list_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.uiList_, TowerGameItem)
end

function var_0_0.IndexItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:SetData(arg_5_1)
	arg_5_2:SetSelectCallBack(arg_5_0.selectStageItemHandler_)
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0:RefreshUI()

	arg_6_0.stopTime_ = ActivityData:GetActivityData(ActivityConst.FACTORY_TOWERGAME).stopTime
	arg_6_0.timer_ = Timer.New(function()
		if manager.time:GetServerTime() < arg_6_0.stopTime_ then
			arg_6_0.timeText_.text = manager.time:GetLostTimeStr(arg_6_0.stopTime_)

			arg_6_0:RefreshItemTime()
		else
			arg_6_0:StopTimer()

			arg_6_0.timeText_.text = GetTips("TIME_OVER")

			return
		end
	end, 1, -1)

	arg_6_0.timer_:Start()
end

function var_0_0.OnTop(arg_8_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_TOWER_DEFENSE_DESC")
	manager.windowBar:RegistBackCallBack(function()
		if arg_8_0:IsOpenSectionView() then
			arg_8_0:RefreshSelectStageItem(0)

			arg_8_0.m_scrollCom.horizontal = true
		end

		JumpTools.Back()
	end)
end

function var_0_0.OnTowerGameBack(arg_10_0)
	if arg_10_0:IsOpenSectionView() then
		arg_10_0:RefreshSelectStageItem(0)

		arg_10_0.m_scrollCom.horizontal = true
	end
end

function var_0_0.OnTowerGameRefresh(arg_11_0)
	arg_11_0.list_:Refresh()
end

function var_0_0.RefreshUI(arg_12_0)
	arg_12_0.stopTime_ = ActivityData:GetActivityData(ActivityConst.FACTORY_TOWERGAME).stopTime

	if manager.time:GetServerTime() < arg_12_0.stopTime_ then
		arg_12_0.timeText_.text = manager.time:GetLostTimeStr(arg_12_0.stopTime_)
	else
		arg_12_0.timeText_.text = GetTips("TIME_OVER")
	end

	arg_12_0.list_:StartScroll(#TowerGameCfg.all)
	arg_12_0:RefreshSelectStageItem(0)
	arg_12_0:RefreshItemTime()
	manager.redPoint:bindUIandKey(arg_12_0.rewardbtntrans_, RedPointConst.MARDUK_TOWERGAME_REWARD)
end

function var_0_0.RefreshItemTime(arg_13_0)
	local var_13_0 = arg_13_0.list_:GetItemList()

	for iter_13_0, iter_13_1 in pairs(var_13_0) do
		iter_13_1:UpdateTime()
	end
end

function var_0_0.AddUIListeners(arg_14_0)
	arg_14_0:AddBtnListener(arg_14_0.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("towerGameRewardView", {
			activityId = arg_14_0.activityID_
		})
	end)
	arg_14_0:AddBtnListener(arg_14_0.planeBtn_, nil, function()
		JumpTools.OpenPageByJump("towerGamePlaneView", {
			activityId = arg_14_0.activityID_
		})
	end)
	arg_14_0:AddBtnListener(arg_14_0.bgbtn_, nil, function()
		arg_14_0:TryToCloseSectionView()
	end)
	arg_14_0.scrollViewEvent_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function(arg_18_0, arg_18_1)
		arg_14_0:TryToCloseSectionView()
	end))
	arg_14_0.scrollViewEvent_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function(arg_19_0, arg_19_1)
		arg_14_0:TryToCloseSectionView()
	end))
end

function var_0_0.IsOpenSectionView(arg_20_0)
	return arg_20_0:IsOpenRoute("towerGameSectionInfoView")
end

function var_0_0.OnBehind(arg_21_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnExit(arg_22_0)
	manager.windowBar:HideBar()
	arg_22_0:StopTimer()
	arg_22_0:RemoveTween()
	manager.redPoint:unbindUIandKey(arg_22_0.rewardbtntrans_, RedPointConst.MARDUK_TOWERGAME_REWARD)
end

function var_0_0.OnSelectStageItem(arg_23_0, arg_23_1, arg_23_2)
	arg_23_0:RefreshSelectStageItem(arg_23_1)
	TowerGameData:SetLevleClick(arg_23_1)

	local var_23_0 = arg_23_0.list_:GetItemList()[arg_23_2]

	if var_23_0 then
		local var_23_1 = -var_23_0.transform_.localPosition.x + arg_23_0.m_scrollViewTrans.rect.width / 3 - var_23_0.transform_.rect.width / 2

		arg_23_0.m_scrollCom.horizontal = false

		arg_23_0:RemoveTween()

		arg_23_0.tween_ = LeanTween.value(arg_23_0.m_scrollContent, arg_23_0.m_scrollContent.transform.localPosition.x, var_23_1, 0.2):setOnUpdate(LuaHelper.FloatAction(function(arg_24_0)
			arg_23_0.m_scrollContent.transform.localPosition = Vector3(arg_24_0, 0, 0)
		end))
	else
		arg_23_0.m_scrollCom.horizontal = true
	end

	if arg_23_0:IsOpenSectionView() then
		JumpTools.Back()
	end
end

function var_0_0.RemoveTween(arg_25_0)
	if arg_25_0.tween_ then
		arg_25_0.tween_:setOnUpdate(nil)
		LeanTween.cancel(arg_25_0.m_scrollContent)

		arg_25_0.tween_ = nil
	end
end

function var_0_0.TryToCloseSectionView(arg_26_0)
	if arg_26_0:IsOpenSectionView() then
		arg_26_0:RefreshSelectStageItem(0)

		arg_26_0.m_scrollCom.horizontal = true

		JumpTools.Back()
	end
end

function var_0_0.RefreshSelectStageItem(arg_27_0, arg_27_1)
	arg_27_0.selectStageID_ = arg_27_1

	local var_27_0 = arg_27_0.list_:GetItemList()

	for iter_27_0, iter_27_1 in pairs(var_27_0) do
		iter_27_1:RefreshSelect(arg_27_0.selectStageID_)
	end
end

function var_0_0.StopTimer(arg_28_0)
	if arg_28_0.timer_ then
		arg_28_0.timer_:Stop()

		arg_28_0.timer_ = nil
	end
end

function var_0_0.Dispose(arg_29_0)
	var_0_0.super.Dispose(arg_29_0)
	arg_29_0.scrollViewEvent_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerDown)
	arg_29_0.scrollViewEvent_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.BeginDrag)
	arg_29_0:StopTimer()

	if arg_29_0.list_ then
		arg_29_0.list_:Dispose()

		arg_29_0.list_ = nil
	end

	arg_29_0.selectStageItemHandler_ = nil
end

return var_0_0

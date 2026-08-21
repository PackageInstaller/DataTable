local var_0_0 = class("MardukSpecialMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/MardukUI/special/MardukSpecialUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0.items_ = {}

	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.rankLockController_ = ControllerUtil.GetController(arg_5_0.rankBtn_.transform, "rankLock")
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("mardukSpecialReward", {
			activityID = arg_6_0.params_.activityID
		})
	end)
	arg_6_0:AddBtnListener(arg_6_0.rankBtn_, nil, function()
		if not arg_6_0.rankOpen_ then
			return
		end

		local var_8_0 = arg_6_0.activityIds_[arg_6_0.curIndex_]

		JumpTools.OpenPageByJump("/mardukSpecialRank", {
			activityID = arg_6_0.params_.activityID,
			subActivityId = var_8_0
		})
	end)
end

function var_0_0.AddEventListeners(arg_9_0)
	return
end

function var_0_0.OnTop(arg_10_0)
	arg_10_0:UpdateBar()
end

function var_0_0.OnBehind(arg_11_0)
	manager.windowBar:HideBar()
end

function var_0_0.UpdateBar(arg_12_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("MARDUK_SPECIAL_NOTE")
end

function var_0_0.OnEnter(arg_13_0)
	arg_13_0:AddEventListeners()

	arg_13_0.activityIds_ = ActivityCfg[arg_13_0.params_.activityID].sub_activity_list

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.activityIds_) do
		if not arg_13_0.items_[iter_13_0] then
			arg_13_0.items_[iter_13_0] = arg_13_0:CreateItem(iter_13_0)
		end

		arg_13_0.items_[iter_13_0]:SetData(iter_13_0, arg_13_0.params_.activityID, iter_13_1)
	end

	manager.redPoint:bindUIandKey(arg_13_0.rewardbtntrans_, string.format("%s_%d", RedPointConst.MARDUK_SPECIAL_REWARD, ActivityConst.FACTORY_MARDUK))
	arg_13_0:StartTimer()
	arg_13_0:UpdateTimer()
end

function var_0_0.OnExit(arg_14_0)
	AnimatorTools.Stop()
	arg_14_0:StopTimer()
	arg_14_0:RemoveAllEventListener()
	manager.redPoint:unbindUIandKey(arg_14_0.rewardbtntrans_, string.format("%s_%d", RedPointConst.MARDUK_SPECIAL_REWARD, ActivityConst.FACTORY_MARDUK))
	manager.windowBar:HideBar()
end

function var_0_0.StartTimer(arg_15_0)
	if arg_15_0.timer_ == nil then
		arg_15_0.timer_ = Timer.New(function()
			arg_15_0:UpdateTimer()
		end, 1, -1)
	end

	arg_15_0.timer_:Start()
end

function var_0_0.StopTimer(arg_17_0)
	if arg_17_0.timer_ then
		arg_17_0.timer_:Stop()

		arg_17_0.timer_ = nil
	end
end

function var_0_0.CreateItem(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0["item" .. arg_18_1 .. "Go_"]
	local var_18_1 = MardukSpecialItemView.New(var_18_0)

	var_18_1:SetItemSelectHandler(handler(arg_18_0, arg_18_0.OnNodeSelect))

	return var_18_1
end

function var_0_0.OnNodeSelect(arg_19_0, arg_19_1, arg_19_2)
	if not arg_19_2 then
		arg_19_0.items_[arg_19_0.curIndex_]:ShowSelect(false)

		arg_19_0.curIndex_ = nil

		arg_19_0:UpdateView()

		return
	end

	if arg_19_0.curIndex_ ~= nil and arg_19_1 == arg_19_0.curIndex_ then
		return
	end

	arg_19_0:SetSelect(arg_19_1)
end

function var_0_0.SetSelect(arg_20_0, arg_20_1)
	if arg_20_0.curIndex_ then
		arg_20_0.items_[arg_20_0.curIndex_]:ShowSelect(false)
	end

	arg_20_0.curIndex_ = arg_20_1

	if arg_20_0.curIndex_ then
		arg_20_0:ScrollToItem(arg_20_1)
	end

	arg_20_0:UpdateView()
end

function var_0_0.ScrollToItem(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0.container_.rect.width
	local var_21_1 = 491
	local var_21_2 = 1091
	local var_21_3 = arg_21_0.scrollViewTransform_.rect.width
	local var_21_4 = 21 + var_21_1 * (arg_21_1 - 1) + var_21_2 / 2 - var_21_3 / 2

	if var_21_4 < 0 then
		var_21_4 = 0
	end

	arg_21_0.container_.localPosition.x = -var_21_4

	LeanTween.moveLocalX(arg_21_0.container_.gameObject, -var_21_4, 0.2)
	arg_21_0.items_[arg_21_1]:ShowSelect(true)
end

function var_0_0.UpdateView(arg_22_0)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_0.contenttrans_)

	local var_22_0 = ActivityData:GetActivityData(arg_22_0.params_.activityID).stopTime

	arg_22_0.lastTimeLabel_.text = manager.time:GetLostTimeStr(var_22_0)
end

function var_0_0.UpdateTimer(arg_23_0)
	local var_23_0 = false
	local var_23_1 = 0

	for iter_23_0, iter_23_1 in ipairs(arg_23_0.activityIds_) do
		if #ActivityCfg[iter_23_1].sub_activity_list > 0 then
			if var_23_1 == 0 then
				var_23_1 = iter_23_1
			end

			if ActivityData:GetActivityIsOpen(iter_23_1) then
				var_23_0 = true

				break
			end
		end
	end

	arg_23_0.rankOpen_ = var_23_0

	if var_23_0 then
		arg_23_0.rankLockController_:SetSelectedState("false")
	else
		arg_23_0.rankLockController_:SetSelectedState("true")

		local var_23_2 = ActivityData:GetActivityData(var_23_1).stopTime

		if ActivityData:GetActivityData(var_23_1).stopTime < manager.time:GetServerTime() then
			arg_23_0.timeLabel_.text = GetTips("TIME_OVER")
		else
			local var_23_3 = manager.time:GetLostTimeStr(ActivityData:GetActivityData(var_23_1).startTime)

			arg_23_0.timeLabel_.text = string.format(GetTips("OPEN_TIME"), var_23_3)
		end
	end

	local var_23_4 = ActivityData:GetActivityData(arg_23_0.params_.activityID).stopTime

	if var_23_4 > manager.time:GetServerTime() then
		arg_23_0.lastTimeLabel_.text = manager.time:GetLostTimeStr(var_23_4)
	else
		arg_23_0.lastTimeLabel_.text = GetTips("TIME_OVER")
	end

	for iter_23_2, iter_23_3 in pairs(arg_23_0.items_) do
		iter_23_3:UpdateTime()
	end
end

function var_0_0.OnMainHomeViewTop(arg_24_0)
	return
end

function var_0_0.Dispose(arg_25_0)
	if arg_25_0.items_ then
		for iter_25_0, iter_25_1 in pairs(arg_25_0.items_) do
			iter_25_1:Dispose()
		end

		arg_25_0.items_ = nil
	end

	if arg_25_0.timer_ then
		arg_25_0.timer_:Stop()

		arg_25_0.timer_ = nil
	end

	var_0_0.super.Dispose(arg_25_0)
end

return var_0_0

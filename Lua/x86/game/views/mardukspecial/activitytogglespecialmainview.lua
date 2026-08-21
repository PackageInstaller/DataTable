local var_0_0 = import("game.views.activity.Main.toggle.ActivityMainBasePanel")
local var_0_1 = class("ActivityToggleSpecialMainView", var_0_0)
local var_0_2 = "MARDUK_SPECIAL_NOTE_1"

function var_0_1.GetUIName(arg_1_0)
	return "UI/VersionUI/XuHeng3rdUI/XH3rdEscortUI/XH3rdEscortUI"
end

function var_0_1.Init(arg_2_0)
	arg_2_0.items_ = {}

	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_1.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.rankLockController_ = ControllerUtil.GetController(arg_3_0.rankBtn_.transform, "rankLock")
end

function var_0_1.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("activityToggleSpecialRewardView", {
			activityId = arg_4_0.activityID_
		})
	end)
	arg_4_0:AddBtnListener(arg_4_0.rankBtn_, nil, function()
		if not arg_4_0.rankOpen_ then
			return
		end

		local var_6_0 = arg_4_0.activityIds_[arg_4_0.curIndex_]

		JumpTools.OpenPageByJump("/mardukSpecialRank", {
			activityId = arg_4_0.activityID_,
			subActivityId = var_6_0
		})
	end)
	arg_4_0:AddBtnListener(arg_4_0.tipsBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips(var_0_2),
			key = var_0_2
		})
	end)
end

function var_0_1.OnTop(arg_8_0)
	arg_8_0:UpdateBar()
end

function var_0_1.OnEnter(arg_9_0)
	var_0_1.super.OnEnter(arg_9_0)

	arg_9_0.activityIds_ = ActivityCfg[arg_9_0.activityID_].sub_activity_list

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.activityIds_) do
		if not arg_9_0.items_[iter_9_0] then
			arg_9_0.items_[iter_9_0] = arg_9_0:CreateItem(iter_9_0)
		end

		arg_9_0.items_[iter_9_0]:SetData(iter_9_0, arg_9_0.activityID_, iter_9_1)
		arg_9_0.items_[iter_9_0]:OnEnter()
	end

	manager.redPoint:bindUIandKey(arg_9_0.rewardbtntrans_, string.format("%s_%d", RedPointConst.MARDUK_SPECIAL_REWARD, ActivityConst.ACTIVITY_2_2_SPECIAL))
	arg_9_0:StartMyTimer()
	arg_9_0:UpdateTimer()
end

function var_0_1.OnExit(arg_10_0)
	var_0_1.super.OnExit(arg_10_0)

	arg_10_0.curIndex_ = nil

	for iter_10_0, iter_10_1 in pairs(arg_10_0.items_) do
		iter_10_1:OnExit()
	end

	AnimatorTools.Stop()
	arg_10_0:StopMyTimer()
	manager.redPoint:unbindUIandKey(arg_10_0.rewardbtntrans_, string.format("%s_%d", RedPointConst.MARDUK_SPECIAL_REWARD, ActivityConst.ACTIVITY_2_2_SPECIAL))
	manager.windowBar:HideBar()
end

function var_0_1.StartMyTimer(arg_11_0)
	if arg_11_0.mytimer_ == nil then
		arg_11_0.mytimer_ = Timer.New(function()
			arg_11_0:UpdateTimer()
		end, 1, -1)
	end

	arg_11_0.mytimer_:Start()
end

function var_0_1.StopMyTimer(arg_13_0)
	if arg_13_0.mytimer_ then
		arg_13_0.mytimer_:Stop()

		arg_13_0.mytimer_ = nil
	end
end

function var_0_1.CreateItem(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0["item" .. arg_14_1 .. "Go_"]
	local var_14_1 = ActivityToggleSpecialItem.New(var_14_0)

	var_14_1:SetItemSelectHandler(handler(arg_14_0, arg_14_0.OnNodeSelect))

	return var_14_1
end

function var_0_1.OnNodeSelect(arg_15_0, arg_15_1, arg_15_2)
	if not arg_15_2 then
		arg_15_0.items_[arg_15_0.curIndex_]:ShowSelect(false)

		arg_15_0.curIndex_ = nil

		arg_15_0:UpdateView()

		return
	end

	if arg_15_0.curIndex_ ~= nil and arg_15_1 == arg_15_0.curIndex_ then
		return
	end

	arg_15_0:SetSelect(arg_15_1)
end

function var_0_1.SetSelect(arg_16_0, arg_16_1)
	if arg_16_0.curIndex_ then
		arg_16_0.items_[arg_16_0.curIndex_]:ShowSelect(false)
	end

	arg_16_0.curIndex_ = arg_16_1

	if arg_16_0.curIndex_ then
		arg_16_0:ScrollToItem(arg_16_1)
	end

	arg_16_0.items_[arg_16_1]:ShowSelect(true)
	arg_16_0:UpdateView()
end

function var_0_1.ScrollToItem(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0.container_.rect.width
	local var_17_1 = 140
	local var_17_2 = 470
	local var_17_3 = arg_17_0.scrollViewTransform_.rect.height
	local var_17_4 = 0 + var_17_1 * (arg_17_1 - 1) + var_17_2 / 2 - var_17_3 / 2

	if var_17_4 < 0 then
		var_17_4 = 0
	end

	if var_17_4 > var_17_0 + var_17_2 / 2 then
		var_17_4 = var_17_0 + var_17_2 / 2
	end

	arg_17_0.container_.localPosition.y = var_17_4

	LeanTween.moveLocalY(arg_17_0.container_.gameObject, var_17_4, 0.2)
end

function var_0_1.UpdateView(arg_18_0)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_0.contenttrans_)

	local var_18_0 = ActivityData:GetActivityData(arg_18_0.activityID_).stopTime

	arg_18_0.lastTimeLabel_.text = manager.time:GetLostTimeStrWith2Unit(var_18_0)
end

function var_0_1.UpdateTimer(arg_19_0)
	local var_19_0 = false
	local var_19_1 = 0

	for iter_19_0, iter_19_1 in ipairs(arg_19_0.activityIds_) do
		if #ActivityCfg[iter_19_1].sub_activity_list > 0 then
			if var_19_1 == 0 then
				var_19_1 = iter_19_1
			end

			if ActivityData:GetActivityIsOpen(iter_19_1) then
				var_19_0 = true

				break
			end
		end
	end

	arg_19_0.rankOpen_ = var_19_0

	if var_19_0 then
		arg_19_0.rankLockController_:SetSelectedState("false")
	else
		arg_19_0.rankLockController_:SetSelectedState("true")

		local var_19_2 = ActivityData:GetActivityData(var_19_1).stopTime

		if ActivityData:GetActivityData(var_19_1).stopTime < manager.time:GetServerTime() then
			arg_19_0.timeLabel_.text = GetTips("TIME_OVER")
		else
			local var_19_3 = manager.time:GetLostTimeStrWith2Unit(ActivityData:GetActivityData(var_19_1).startTime)

			arg_19_0.timeLabel_.text = string.format(GetTips("OPEN_TIME"), var_19_3)
		end
	end

	local var_19_4 = ActivityData:GetActivityData(arg_19_0.activityID_).stopTime

	if var_19_4 > manager.time:GetServerTime() then
		arg_19_0.lastTimeLabel_.text = manager.time:GetLostTimeStrWith2Unit(var_19_4)
	else
		arg_19_0.lastTimeLabel_.text = GetTips("TIME_OVER")
	end

	for iter_19_2, iter_19_3 in pairs(arg_19_0.items_) do
		iter_19_3:UpdateTime()
	end
end

function var_0_1.Dispose(arg_20_0)
	if arg_20_0.items_ then
		for iter_20_0, iter_20_1 in pairs(arg_20_0.items_) do
			iter_20_1:Dispose()
		end

		arg_20_0.items_ = nil
	end

	if arg_20_0.timer_ then
		arg_20_0.timer_:Stop()

		arg_20_0.timer_ = nil
	end

	arg_20_0.activityOpenHandler_ = nil

	var_0_1.super.Dispose(arg_20_0)
end

return var_0_1

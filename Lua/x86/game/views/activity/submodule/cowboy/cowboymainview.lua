local var_0_0 = class("CowboyMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return CowboyTools.GetMainUIName(arg_1_0.params_.activityID)
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

	arg_4_0.list_ = {}
	arg_4_0.scrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.listGo_, CowboyItem)
end

function var_0_0.IndexItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:RefreshUI(arg_5_0.activityID_, arg_5_0.list_[arg_5_1])
	arg_5_2:RefreshLevelText(arg_5_1)
end

function var_0_0.AddUIListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("cowBoyReward", {
			activityID = arg_6_0.activityID_
		})
	end)
	arg_6_0:AddBtnListener(arg_6_0.backBtn_, nil, function()
		arg_6_0:Back()
	end)
	arg_6_0:AddBtnListener(arg_6_0.infoBtn_, nil, function()
		JumpTools.OpenPageByJump("cowBoyInfo", {
			activityID = arg_6_0.activityID_
		})
	end)
end

function var_0_0.OnEnter(arg_10_0)
	manager.audio:PlayEffect("minigame_activity_1_3", "minigame_entrance_animation", "")
	arg_10_0:GetActivityData()
	arg_10_0:RefreshUI()
	arg_10_0:BindUIRedPoint()
end

function var_0_0.GetActivityData(arg_11_0)
	arg_11_0.activityID_ = arg_11_0.params_.activityID
	arg_11_0.activityData_ = ActivityData:GetActivityData(arg_11_0.activityID_)
	arg_11_0.startTime_ = arg_11_0.activityData_.startTime
	arg_11_0.stopTime_ = arg_11_0.activityData_.stopTime
end

function var_0_0.RefreshUI(arg_12_0)
	arg_12_0:RefreshList()
	arg_12_0:RefreshTime()
end

function var_0_0.RefreshList(arg_13_0)
	arg_13_0.list_ = ActivityCfg[arg_13_0.activityID_].sub_activity_list
	arg_13_0.lastLevel_ = CowboyData:GetLastLevel(arg_13_0.activityID_)

	if not arg_13_0.lastLevel_ or not table.indexof(arg_13_0.list_, arg_13_0.lastLevel_) then
		arg_13_0.scrollHelper_:StartScroll(#arg_13_0.list_)
	else
		local var_13_0 = table.indexof(arg_13_0.list_, arg_13_0.lastLevel_)

		arg_13_0.scrollHelper_:StartScroll(#arg_13_0.list_, var_13_0)
	end
end

function var_0_0.RefreshTime(arg_14_0)
	local var_14_0
	local var_14_1 = manager.time:GetServerTime()

	arg_14_0:StopTimer()

	if var_14_1 < arg_14_0.startTime_ and arg_14_0.activityData_:IsActivitying() == false then
		arg_14_0.timeTxt_.text = GetTips("SOLO_NOT_OPEN")
		arg_14_0.timer_ = Timer.New(function()
			var_14_0 = arg_14_0.startTime_ - manager.time:GetServerTime()

			if var_14_0 <= 0 then
				arg_14_0:StopTimer()
				arg_14_0:RefreshTime()

				return
			end
		end, 1, -1)

		arg_14_0.timer_:Start()
	elseif var_14_1 < arg_14_0.stopTime_ then
		arg_14_0.timeTxt_.text = string.format(GetTips("LEFT_TIME"), manager.time:GetLostTimeStr(arg_14_0.stopTime_))
		arg_14_0.timer_ = Timer.New(function()
			var_14_0 = arg_14_0.stopTime_ - manager.time:GetServerTime()

			if var_14_0 <= 0 then
				arg_14_0:StopTimer()
				arg_14_0:RefreshTime()

				return
			end

			arg_14_0.timeTxt_.text = string.format(GetTips("LEFT_TIME"), manager.time:GetLostTimeStr(arg_14_0.stopTime_))
		end, 1, -1)

		arg_14_0.timer_:Start()
	else
		arg_14_0.timeTxt_.text = GetTips("TIME_OVER")
	end
end

function var_0_0.StopTimer(arg_17_0)
	if arg_17_0.timer_ then
		arg_17_0.timer_:Stop()

		arg_17_0.timer_ = nil
	end
end

function var_0_0.BindUIRedPoint(arg_18_0)
	manager.redPoint:bindUIandKey(arg_18_0.rewardBtn_.transform, RedPointConst.COWBOY_REWARD .. "_" .. arg_18_0.activityID_)
end

function var_0_0.UnBindUIRedPoint(arg_19_0)
	manager.redPoint:unbindUIandKey(arg_19_0.rewardBtn_.transform, RedPointConst.COWBOY_REWARD .. "_" .. arg_19_0.activityID_)
end

function var_0_0.OnTop(arg_20_0)
	return
end

function var_0_0.OnExit(arg_21_0)
	arg_21_0:StopTimer()
	arg_21_0:UnBindUIRedPoint()

	for iter_21_0, iter_21_1 in pairs(arg_21_0.scrollHelper_:GetItemList()) do
		iter_21_1:OnExit()
	end

	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_22_0)
	arg_22_0:RemoveAllListeners()
	arg_22_0.scrollHelper_:Dispose()
	var_0_0.super.Dispose(arg_22_0)
end

return var_0_0

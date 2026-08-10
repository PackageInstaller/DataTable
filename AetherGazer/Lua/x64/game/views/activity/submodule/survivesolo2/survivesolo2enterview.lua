ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local var_0_0 = class("SurviveSolo2EnterView", ActivityMainBasePanel)

function var_0_0.GetUIName(arg_1_0)
	return SurviveSolo2Tools.GetEnterUIName(arg_1_0.activityID_)
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.scrollHelper_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexItem), arg_3_0.listGo_, SurviveSolo2EnterItem)
end

function var_0_0.IndexItem(arg_4_0, arg_4_1, arg_4_2)
	arg_4_2:RefreshData(arg_4_0.activityID_, arg_4_0.activityList_[arg_4_1])

	local var_4_0 = manager.time:GetServerTime()

	arg_4_2:RefreshTime(var_4_0)
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("surviveSoloReward2", {
			activityId = arg_5_0.activityID_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.infoBtn_, nil, function()
		local var_7_0 = SurviveSolo2Tools.GetGameHelpKey(arg_5_0.activityID_)

		if var_7_0 ~= "" then
			JumpTools.OpenPageByJump("gameHelp", {
				icon = "icon_i",
				iconColor = Color(1, 1, 1),
				title = GetTips("STAGE_DESCRIPE"),
				content = GetTips(var_7_0),
				key = var_7_0
			})
		end
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0:BindUIRedPoint()
	arg_8_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_9_0)
	arg_9_0:RefreshActivityData()
	arg_9_0:RefreshTime()
	arg_9_0:RefreshList()
end

function var_0_0.RefreshActivityData(arg_10_0)
	arg_10_0.activityData_ = ActivityData:GetActivityData(arg_10_0.activityID_)
	arg_10_0.startTime_ = arg_10_0.activityData_.startTime
	arg_10_0.stopTime_ = arg_10_0.activityData_.stopTime
end

function var_0_0.RefreshTime(arg_11_0)
	local var_11_0
	local var_11_1 = manager.time:GetServerTime()

	arg_11_0:StopTimer()

	if var_11_1 < arg_11_0.startTime_ then
		arg_11_0.timeLable_.text = GetTips("SOLO_NOT_OPEN")
		arg_11_0.timer_ = Timer.New(function()
			var_11_0 = arg_11_0.startTime_ - manager.time:GetServerTime()

			if var_11_0 <= 0 then
				arg_11_0:StopTimer()
				arg_11_0:RefreshTime()

				return
			end
		end, 1, -1)

		arg_11_0.timer_:Start()
	elseif var_11_1 < arg_11_0.stopTime_ then
		arg_11_0.timeLable_.text = manager.time:GetLostTimeStrWith2Unit(arg_11_0.stopTime_)
		arg_11_0.timer_ = Timer.New(function()
			var_11_1 = manager.time:GetServerTime()

			if arg_11_0.stopTime_ <= var_11_1 then
				arg_11_0:StopTimer()
				arg_11_0:RefreshTime()

				return
			else
				arg_11_0.timeLable_.text = manager.time:GetLostTimeStrWith2Unit(arg_11_0.stopTime_)
			end
		end, 1, -1)

		arg_11_0.timer_:Start()
	else
		arg_11_0.timeLable_.text = GetTips("TIME_OVER")
	end
end

function var_0_0.StopTimer(arg_14_0)
	if arg_14_0.timer_ then
		arg_14_0.timer_:Stop()

		arg_14_0.timer_ = nil
	end
end

function var_0_0.RefreshList(arg_15_0)
	arg_15_0.activityList_ = ActivitySoloSlayerCfg.get_id_list_by_main_activity_id[arg_15_0.activityID_]

	arg_15_0.scrollHelper_:StartScroll(#arg_15_0.activityList_)
	arg_15_0:StartItemTimer()
end

function var_0_0.StartItemTimer(arg_16_0)
	arg_16_0:StopItemTimer()

	arg_16_0.itemTimer_ = Timer.New(function()
		local var_17_0 = manager.time:GetServerTime()

		for iter_17_0, iter_17_1 in pairs(arg_16_0.scrollHelper_:GetItemList()) do
			iter_17_1:RefreshTime(var_17_0)
		end
	end, 1, -1)

	arg_16_0.itemTimer_:Start()
end

function var_0_0.StopItemTimer(arg_18_0)
	if arg_18_0.itemTimer_ then
		arg_18_0.itemTimer_:Stop()

		arg_18_0.itemTimer_ = nil
	end
end

function var_0_0.Show(arg_19_0, arg_19_1)
	var_0_0.super.Show(arg_19_0, arg_19_1)

	if arg_19_1 then
		arg_19_0:RefreshList()
	end
end

function var_0_0.BindUIRedPoint(arg_20_0)
	manager.redPoint:bindUIandKey(arg_20_0.rewardBtn_.transform, RedPointConst.SOLO_SURVIVE_REWARD .. "_" .. arg_20_0.activityID_)
end

function var_0_0.UnbindUIRedPoint(arg_21_0)
	manager.redPoint:unbindUIandKey(arg_21_0.rewardBtn_.gameObject.transform, RedPointConst.SOLO_SURVIVE_REWARD .. "_" .. arg_21_0.activityID_)
end

function var_0_0.OnExit(arg_22_0)
	arg_22_0:RemoveAllEventListener()
	arg_22_0:UnbindUIRedPoint()
	arg_22_0:StopItemTimer()
	arg_22_0:StopTimer()

	for iter_22_0, iter_22_1 in ipairs(arg_22_0.scrollHelper_:GetItemList()) do
		iter_22_1:OnExit()
	end
end

function var_0_0.Dispose(arg_23_0)
	arg_23_0:RemoveAllListeners()
	arg_23_0.scrollHelper_:Dispose()
	arg_23_0.super.Dispose(arg_23_0)
end

return var_0_0

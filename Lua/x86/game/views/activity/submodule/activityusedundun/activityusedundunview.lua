ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local var_0_0 = class("ActivityUseDunDunView", ActivityMainBasePanel)
local var_0_1 = "USE_DUNDUN_INFO"

function var_0_0.GetUIName(arg_1_0)
	return ActivityUseDunDunTools.GetUINameKey(arg_1_0.activityID_)
end

function var_0_0.Init(arg_2_0)
	var_0_0.super.Init(arg_2_0)

	arg_2_0.rewardController1_ = arg_2_0.rewardControllerEx1_:GetController("reward")
	arg_2_0.rewardController2_ = arg_2_0.rewardControllerEx2_:GetController("reward")
	arg_2_0.pointList_ = {}
end

function var_0_0.OnEnter(arg_3_0)
	var_0_0.super.OnEnter(arg_3_0)
	arg_3_0:RefreshUI()
end

function var_0_0.BindRedPoint(arg_4_0)
	local var_4_0 = ActivityPointRewardCfg.get_id_list_by_activity_id[arg_4_0.activityID_]

	for iter_4_0, iter_4_1 in pairs(var_4_0) do
		local var_4_1 = RedPointConst.ACTIVITY_USE_DUNDUN_REWARD .. iter_4_1

		manager.redPoint:bindUIandKey(arg_4_0["rewardBtn" .. iter_4_0 .. "_"], var_4_1)
	end
end

function var_0_0.RefreshTimeText(arg_5_0)
	arg_5_0.timeText_.text = manager.time.WrapTimeStrWithTips(manager.time:GetLostTimeStrWith2Unit(arg_5_0.stopTime_))
end

function var_0_0.RefreshUI(arg_6_0)
	local var_6_0 = ActivityToggleCfg.get_id_list_by_activity_id[arg_6_0.activityID_][1]

	arg_6_0.desText_.text = ActivityToggleCfg[var_6_0].desc
	arg_6_0.activityNameText_.text = ActivityToggleCfg[var_6_0].name

	local var_6_1 = ActivityPointData:GetCurDunDunPoint(arg_6_0.activityID_)

	arg_6_0.sliderText_.text = var_6_1

	local var_6_2 = ActivityPointRewardCfg[ActivityPointRewardCfg.get_id_list_by_activity_id[arg_6_0.activityID_][1]].reward_item_list[1][1]

	arg_6_0.heroText_.text = HeroTools.GetHeroFullName(var_6_2)

	local var_6_3 = 0
	local var_6_4 = {}

	for iter_6_0, iter_6_1 in pairs(ActivityPointRewardCfg.get_id_list_by_activity_id[arg_6_0.activityID_]) do
		local var_6_5 = ActivityPointRewardCfg[iter_6_1]

		if var_6_3 < var_6_5.need then
			var_6_3 = var_6_5.need
		end

		table.insert(var_6_4, var_6_5.need)
	end

	table.sort(var_6_4)

	arg_6_0.pointList_ = var_6_4
	arg_6_0.slider_.value = var_6_1 / var_6_3
	arg_6_0.rewardText1_.text = arg_6_0.pointList_[1]

	if var_6_1 >= arg_6_0.pointList_[1] then
		local var_6_6

		for iter_6_2, iter_6_3 in pairs(ActivityPointRewardCfg.get_id_list_by_activity_id[arg_6_0.activityID_]) do
			if ActivityPointRewardCfg[iter_6_3].need == arg_6_0.pointList_[1] then
				var_6_6 = iter_6_3
			end
		end

		if ActivityPointData:GetUseDunDunRewardIsGet(arg_6_0.activityID_, var_6_6) then
			arg_6_0.rewardController1_:SetSelectedState("received")
		else
			arg_6_0.rewardController1_:SetSelectedState("select")
		end
	else
		arg_6_0.rewardController1_:SetSelectedState("normal")
	end

	arg_6_0.rewardText2_.text = arg_6_0.pointList_[2]

	if var_6_1 >= arg_6_0.pointList_[2] then
		local var_6_7

		for iter_6_4, iter_6_5 in pairs(ActivityPointRewardCfg.get_id_list_by_activity_id[arg_6_0.activityID_]) do
			if ActivityPointRewardCfg[iter_6_5].need == arg_6_0.pointList_[2] then
				var_6_7 = iter_6_5
			end
		end

		if ActivityPointData:GetUseDunDunRewardIsGet(arg_6_0.activityID_, var_6_7) then
			arg_6_0.rewardController2_:SetSelectedState("received")
		else
			arg_6_0.rewardController2_:SetSelectedState("select")
		end
	else
		arg_6_0.rewardController2_:SetSelectedState("normal")
	end

	local var_6_8, var_6_9 = ActivityMultiRewardData:GetMultiRatioByChapterOrToggle(2, nil)

	if var_6_8 > 0 then
		local var_6_10, var_6_11 = ActivityMultiRewardData:GetCountByActivityID(var_6_9)

		arg_6_0.multiCountText_.text = var_6_10 .. "/" .. var_6_11
		arg_6_0.multiRatioText_.text = var_6_8 / 100

		SetActive(arg_6_0.multiGo_, true)
	else
		SetActive(arg_6_0.multiGo_, false)
	end
end

function var_0_0.OnExit(arg_7_0)
	var_0_0.super.OnExit(arg_7_0)
end

function var_0_0.UnBindRedPoint(arg_8_0)
	local var_8_0 = ActivityPointRewardCfg.get_id_list_by_activity_id[arg_8_0.activityID_]

	for iter_8_0, iter_8_1 in pairs(var_8_0) do
		local var_8_1 = RedPointConst.ACTIVITY_USE_DUNDUN_REWARD .. iter_8_1

		manager.redPoint:unbindUIandKey(arg_8_0["rewardBtn" .. iter_8_0 .. "_"], var_8_1)
	end
end

function var_0_0.AddListeners(arg_9_0)
	arg_9_0:AddBtnListener(arg_9_0.descBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			content = GetTips(var_0_1),
			key = var_0_1
		})
	end)
	arg_9_0:AddBtnListener(arg_9_0.startBtn_, nil, function()
		JumpTools.OpenPageByJump("/chapterMap", {
			chapterToggle = 2
		})
		OperationRecorder.RecordButtonTouch("activity" .. arg_9_0.activityID_ .. "_jump_combat")
	end)
	arg_9_0:AddBtnListener(arg_9_0.rewardBtn1_, nil, function()
		local var_12_0 = ActivityPointData:GetCurDunDunPoint(arg_9_0.activityID_)
		local var_12_1

		for iter_12_0, iter_12_1 in pairs(ActivityPointRewardCfg.get_id_list_by_activity_id[arg_9_0.activityID_]) do
			if ActivityPointRewardCfg[iter_12_1].need == arg_9_0.pointList_[1] then
				var_12_1 = iter_12_1
			end
		end

		if var_12_0 >= arg_9_0.pointList_[1] then
			if ActivityPointData:GetUseDunDunRewardIsGet(arg_9_0.activityID_, var_12_1) then
				return
			else
				ActivityAction.ReceivePointRewardWithCallBack({
					var_12_1
				}, function(arg_13_0)
					arg_9_0:OnReceivePointReward(arg_13_0)
				end)
			end
		end
	end)
	arg_9_0:AddBtnListener(arg_9_0.rewardBtn2_, nil, function()
		local var_14_0 = ActivityPointData:GetCurDunDunPoint(arg_9_0.activityID_)
		local var_14_1

		for iter_14_0, iter_14_1 in pairs(ActivityPointRewardCfg.get_id_list_by_activity_id[arg_9_0.activityID_]) do
			if ActivityPointRewardCfg[iter_14_1].need == arg_9_0.pointList_[2] then
				var_14_1 = iter_14_1
			end
		end

		if var_14_0 >= arg_9_0.pointList_[2] then
			if ActivityPointData:GetUseDunDunRewardIsGet(arg_9_0.activityID_, var_14_1) then
				return
			else
				ActivityAction.ReceivePointRewardWithCallBack({
					var_14_1
				}, function(arg_15_0)
					arg_9_0:OnReceivePointReward(arg_15_0)
				end)
			end
		end
	end)
end

function var_0_0.OnReceivePointReward(arg_16_0, arg_16_1)
	ActivityPointData:GetUseDunDunReward(arg_16_0.activityID_, arg_16_1)
	arg_16_0:RefreshUI()
end

return var_0_0

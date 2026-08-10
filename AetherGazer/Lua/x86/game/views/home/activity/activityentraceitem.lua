local var_0_0 = class("ActivityEntraceItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()
end

function var_0_0.OnEnter(arg_2_0)
	if JumpTools.GetLinkIsLocked(ActivityEntraceCfg[arg_2_0.activityID_].jump_system) then
		SetActive(arg_2_0.redPointGo_, false)
	else
		SetActive(arg_2_0.redPointGo_, true)
	end

	manager.redPoint:bindUIandKey(arg_2_0.redPointGo_.transform, string.format("%s%s", RedPointConst.MAIN_ACTIVITY, arg_2_0.activityID_))
	arg_2_0:RefreshUI()
end

function var_0_0.OnExit(arg_3_0)
	manager.redPoint:unbindUIandKey(arg_3_0.redPointGo_.transform, string.format("%s%s", RedPointConst.MAIN_ACTIVITY, arg_3_0.activityID_))
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)

	arg_4_0.transform_ = nil
	arg_4_0.gameObject_ = nil
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.button_, nil, function()
		if ActivityTools.CheckActivityIsSuspended(arg_5_0.activityID_) then
			return
		end

		local var_6_0 = "btn_homepage_activity" .. arg_5_0.activityID_
		local var_6_1 = getData("SDK", var_6_0)
		local var_6_2 = TimeMgr:GetServerTime()

		if var_6_1 == nil or not TimeMgr:IsSameDay(var_6_1, var_6_2) then
			saveData("SDK", var_6_0, TimeMgr:GetServerTime())
			OperationRecorder.RecordButtonTouch("homepage_activity_" .. arg_5_0.activityID_)
		end

		local var_6_3 = ActivityEntraceCfg[arg_5_0.activityID_]

		ActivityVersionData:SetReprintField(var_6_3.reprint_field)
		JumpTools.JumpToPage2(var_6_3.jump_system)
	end)
end

function var_0_0.SetData(arg_7_0, arg_7_1)
	if arg_7_0.activityID_ then
		arg_7_0:OnExit()
	end

	arg_7_0.activityID_ = arg_7_1

	arg_7_0:OnEnter()
end

function var_0_0.RefreshUI(arg_8_0)
	local var_8_0 = ActivityData:GetActivityData(arg_8_0.activityID_).startTime
	local var_8_1 = ActivityEntraceCfg[arg_8_0.activityID_]
	local var_8_2 = arg_8_0:GetIndex()
	local var_8_3 = var_8_1.icon_list[var_8_2]

	arg_8_0.image_.sprite = getSpriteViaConfig("ActivityBannerTextures", var_8_3)
end

function var_0_0.GetIndex(arg_9_0)
	local var_9_0 = ActivityData:GetActivityData(arg_9_0.activityID_).startTime
	local var_9_1 = ActivityEntraceCfg[arg_9_0.activityID_]
	local var_9_2 = manager.time:GetServerTime()

	for iter_9_0 = #var_9_1.day_list, 1, -1 do
		if var_9_2 >= var_9_0 + var_9_1.day_list[iter_9_0] * 24 * 3600 then
			return iter_9_0 + 1
		end
	end

	return 1
end

return var_0_0

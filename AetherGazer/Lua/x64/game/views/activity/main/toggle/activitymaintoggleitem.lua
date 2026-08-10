local var_0_0 = class("ActivityMainToggleItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.toggleID_ = arg_1_3
	arg_1_0.activityID_ = arg_1_4
	arg_1_0.redPointActivityID_ = arg_1_5 or arg_1_4

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	if arg_1_0.itemCon_ then
		arg_1_0.controller_ = arg_1_0.itemCon_:GetController("lock")
	end

	arg_1_0.selectController_ = ControllerUtil.GetController(arg_1_0.transform_, "select")
	arg_1_0.subTitleController_ = ControllerUtil.GetController(arg_1_0.transform_, "subTitle")
	arg_1_0.updateHandler_ = handler(arg_1_0, arg_1_0.UpdateActivity)

	arg_1_0:RefreshUI()
end

function var_0_0.OnEnter(arg_2_0)
	arg_2_0.activiteData_ = ActivityData:GetActivityData(arg_2_0.activityID_)
	arg_2_0.startTime_ = arg_2_0.activiteData_.startTime

	if ActivityShopCfg[arg_2_0.activityID_] then
		local var_2_0 = ActivityShopCfg[arg_2_0.activityID_].shop_id
		local var_2_1 = ShopListCfg[var_2_0].activity_id

		arg_2_0.stopTime_ = ActivityData:GetActivityData(var_2_1).stopTime
	else
		arg_2_0.stopTime_ = arg_2_0.activiteData_.stopTime
	end

	arg_2_0:UpdateResidentTime()
	manager.notify:RegistListener(ACTIVITY_UPDATE, arg_2_0.updateHandler_)
	manager.redPoint:bindUIandKey(arg_2_0.transform_, ActivityTools.GetRedPointKey(arg_2_0.redPointActivityID_) .. arg_2_0.redPointActivityID_)
	arg_2_0:AddTimer()
end

function var_0_0.UpdateResidentTime(arg_3_0)
	local var_3_0, var_3_1 = ChapterResidentTools.GetResidentMainActTime(arg_3_0.activityID_)

	if var_3_0 and var_3_1 then
		arg_3_0.startTime_ = var_3_0
		arg_3_0.stopTime_ = var_3_1
	end
end

function var_0_0.OnExit(arg_4_0)
	manager.redPoint:unbindUIandKey(arg_4_0.transform_, ActivityTools.GetRedPointKey(arg_4_0.redPointActivityID_) .. arg_4_0.redPointActivityID_)
	manager.notify:RemoveListener(ACTIVITY_UPDATE, arg_4_0.updateHandler_)
	arg_4_0:StopTimer()
end

function var_0_0.Dispose(arg_5_0)
	var_0_0.super.Dispose(arg_5_0)

	arg_5_0.updateHandler_ = nil

	Object.Destroy(arg_5_0.gameObject_)

	arg_5_0.gameObject_ = nil
end

function var_0_0.AddListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.button_, nil, function()
		if manager.time:GetServerTime() < arg_6_0.startTime_ then
			local var_7_0 = GetTips("OPEN_TIME")

			ShowTips(string.format(var_7_0, manager.time:GetLostTimeStr(arg_6_0.startTime_)))

			return
		end

		if manager.time:GetServerTime() >= arg_6_0.stopTime_ then
			ShowTips("TIME_OVER")

			return
		end

		manager.notify:Invoke(ACTIVITY_MAIN_TOGGLE_CLICK, arg_6_0.activityID_)
	end)
end

function var_0_0.SdkRecord(arg_8_0)
	local var_8_0 = getData("activity_last_click", "activity_" .. arg_8_0.activityID_) or 0

	if not manager.time:IsToday(var_8_0) then
		OperationRecorder.RecordButtonTouch("activity_homepage_" .. arg_8_0.activityID_)

		local var_8_1 = manager.time:GetServerTime()

		saveData("activity_last_click", "activity_" .. arg_8_0.activityID_, var_8_1)
	end
end

function var_0_0.OnSelect(arg_9_0, arg_9_1)
	arg_9_0.selectController_:SetSelectedState(tostring(arg_9_1))

	if arg_9_1 then
		if arg_9_0.redPointActivityID_ and arg_9_0.redPointActivityID_ ~= arg_9_0.activityID_ then
			ActivityRedPoint:CancelSubActivityNewTag(arg_9_0.redPointActivityID_)

			local var_9_0 = ActivityTools.GetRedPointKey(arg_9_0.redPointActivityID_) .. arg_9_0.redPointActivityID_

			manager.redPoint:setTip(var_9_0, 0, RedPointStyle.SHOW_NEW_TAG)
		else
			local var_9_1 = ActivityTools.GetRedPointKey(arg_9_0.activityID_) .. arg_9_0.activityID_

			ActivityRedPoint:CancelSubActivityNewTag(arg_9_0.activityID_)
			manager.redPoint:setTip(var_9_1, 0, RedPointStyle.SHOW_NEW_TAG)
		end
	end

	if arg_9_1 then
		arg_9_0:SdkRecord()
	end
end

function var_0_0.RefreshLock(arg_10_0)
	local var_10_0 = manager.time:GetServerTime() < arg_10_0.startTime_
	local var_10_1 = manager.time:GetServerTime() >= arg_10_0.stopTime_
	local var_10_2 = ActivityData:GetActivityData(arg_10_0.activityID_)

	if arg_10_0.controller_ then
		if var_10_1 then
			arg_10_0.controller_:SetSelectedState("true")
		elseif var_10_2.template == ActivityTemplateConst.ACTIVITY_ADVANCE_PRE_OPEN then
			arg_10_0.controller_:SetSelectedState("true")
		else
			arg_10_0.controller_:SetSelectedState("false")
		end
	end

	if var_10_0 or var_10_1 then
		if arg_10_0.gameObject_.activeSelf == true then
			SetActive(arg_10_0.gameObject_, false)
		end
	elseif arg_10_0.gameObject_.activeSelf == false then
		SetActive(arg_10_0.gameObject_, true)
	end
end

function var_0_0.RefreshTime(arg_11_0)
	if arg_11_0.textTime_ then
		arg_11_0.textTime_.text = manager.time:GetLostTimeStr(arg_11_0.stopTime_)
	end
end

function var_0_0.UpdateActivity(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0:GetTempActivityID()

	if var_12_0 == arg_12_1 then
		local var_12_1 = ActivityData:GetActivityData(var_12_0)

		arg_12_0.startTime_ = var_12_1.startTime
		arg_12_0.stopTime_ = var_12_1.stopTime

		arg_12_0:UpdateResidentTime()
		arg_12_0:AddTimer()
	end
end

function var_0_0.GetTempActivityID(arg_13_0)
	if ActivityShopCfg[arg_13_0.activityID_] then
		local var_13_0 = ActivityShopCfg[arg_13_0.activityID_].shop_id

		return ShopListCfg[var_13_0].activity_id
	end

	return arg_13_0.activityID_
end

function var_0_0.AddTimer(arg_14_0)
	arg_14_0:StopTimer()
	arg_14_0:RefreshLock()
	arg_14_0:RefreshTime()

	local var_14_0 = manager.time:GetServerTime() < arg_14_0.startTime_

	if manager.time:GetServerTime() >= arg_14_0.stopTime_ then
		manager.notify:Invoke(ACTIVITY_MAIN_TOGGLE_OVER, arg_14_0.activityID_)

		return
	end

	arg_14_0.timer_ = Timer.New(function()
		local var_15_0 = manager.time:GetServerTime()

		if var_14_0 and var_15_0 > arg_14_0.startTime_ then
			arg_14_0:RefreshLock()

			var_14_0 = false
		elseif var_15_0 >= arg_14_0.stopTime_ then
			arg_14_0:RefreshLock()
			arg_14_0:StopTimer()
			manager.notify:Invoke(ACTIVITY_MAIN_TOGGLE_OVER, arg_14_0.activityID_)

			return
		end

		arg_14_0:RefreshTime()
	end, 1, -1)

	arg_14_0.timer_:Start()
end

function var_0_0.StopTimer(arg_16_0)
	if arg_16_0.timer_ then
		arg_16_0.timer_:Stop()

		arg_16_0.timer_ = nil
	end
end

function var_0_0.RefreshUI(arg_17_0)
	local var_17_0 = ActivityToggleCfg[arg_17_0.toggleID_]
	local var_17_1 = var_17_0.sub_title_type

	if var_17_1 == 0 then
		arg_17_0.subTitleController_:SetSelectedState("false")
	else
		arg_17_0.subTitleController_:SetSelectedState("true")

		if var_17_1 == 1 then
			arg_17_0.subTitleText_.text = GetTips("MAIN_PLOT_TEXT")
		elseif var_17_1 == 2 then
			arg_17_0.subTitleText_.text = GetTips("SUB_PLOT_TEXT")
		elseif var_17_1 == 3 then
			arg_17_0.subTitleText_.text = GetTips("WELFARE_TEXT")
		elseif var_17_1 == 4 then
			arg_17_0.subTitleText_.text = GetTips("SKIN_TEXT")
		end
	end

	arg_17_0.nameText_.text = GetI18NText(var_17_0.name)
	arg_17_0.iconImage_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/ActivityiconUI/" .. var_17_0.icon)
end

function var_0_0.Show(arg_18_0, arg_18_1)
	SetActive(arg_18_0.gameObject_, arg_18_1)
end

return var_0_0

local var_0_0 = class("ChapterVariantBaseItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.controller_ = ControllerUtil.GetController(arg_1_0.transform_, "lockState")
end

function var_0_0.OnEnter(arg_2_0, arg_2_1)
	arg_2_0.chapterID_ = arg_2_1

	local var_2_0 = ChapterCfg[arg_2_1].section_id_list[1]

	if BattleStageData:GetStageData()[var_2_0] then
		arg_2_0.isLock_ = false
	else
		arg_2_0.isLock_ = true
	end

	arg_2_0:BindRedPoint()

	if ChapterCfg[arg_2_1].unlock_activity_id ~= 0 then
		arg_2_0:AddTimer()
	else
		arg_2_0:RefreshControllerState()
	end
end

function var_0_0.OnExit(arg_3_0)
	arg_3_0:UnBindRedPoint()
	arg_3_0:StopTimer()
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.button_, nil, function()
		if arg_5_0.timeLock_ then
			local var_6_0 = ChapterCfg[arg_5_0.chapterID_].unlock_activity_id
			local var_6_1 = ActivityData:GetActivityData(var_6_0)

			ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(var_6_1.startTime)))

			return
		end

		if arg_5_0.chapterID_ == 11112 and not SkuldTravelData:IsCollectAllPhoto() then
			ShowTips(GetTips("TRAVEL_SKULD_COLLECT_ALL_PHOTO"))

			return
		end

		if arg_5_0.isLock_ then
			ShowTips("NEED_FINISH_PRE_NORMAL_STAGE")

			return
		end

		arg_5_0:Go("/chapterSection", {
			chapterID = arg_5_0.chapterID_
		})
	end)
end

function var_0_0.BindRedPoint(arg_7_0)
	manager.redPoint:bindUIandKey(arg_7_0.transform_, string.format("%s_%s", RedPointConst.COMBAT_PLOT_CHAPTER, arg_7_0.chapterID_))
end

function var_0_0.UnBindRedPoint(arg_8_0)
	manager.redPoint:unbindUIandKey(arg_8_0.transform_, string.format("%s_%s", RedPointConst.COMBAT_PLOT_CHAPTER, arg_8_0.chapterID_))
end

function var_0_0.AddTimer(arg_9_0)
	arg_9_0:StopTimer()

	local var_9_0 = ChapterCfg[arg_9_0.chapterID_].unlock_activity_id
	local var_9_1 = ActivityData:GetActivityData(var_9_0)

	arg_9_0.timeLock_ = false

	if manager.time:GetServerTime() > var_9_1.startTime then
		arg_9_0:RefreshControllerState()

		return
	end

	arg_9_0.controller_:SetSelectedState("timeLock")

	arg_9_0.timerText_.text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(var_9_1.startTime))
	arg_9_0.timeLock_ = true
	arg_9_0.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= var_9_1.startTime then
			arg_9_0.timeLock_ = false

			arg_9_0:RefreshControllerState()
			arg_9_0:StopTimer()
		else
			arg_9_0.timerText_.text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(var_9_1.startTime))
		end
	end, 1, -1)

	arg_9_0.timer_:Start()
end

function var_0_0.StopTimer(arg_11_0)
	if arg_11_0.timer_ then
		arg_11_0.timer_:Stop()

		arg_11_0.timer_ = nil
	end
end

function var_0_0.RefreshControllerState(arg_12_0)
	if arg_12_0.timeLock_ then
		arg_12_0.controller_:SetSelectedState("timeLock")
	elseif arg_12_0.isLock_ then
		arg_12_0.controller_:SetSelectedState("lock")
	else
		arg_12_0.controller_:SetSelectedState("normal")
	end
end

return var_0_0

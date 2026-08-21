local var_0_0 = class("SequentialBattleChapterItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.activityID_ = arg_1_3

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.selectController_ = ControllerUtil.GetController(arg_1_0.transform_, "name")
	arg_1_0.lockController_ = ControllerUtil.GetController(arg_1_0.transform_, "lock")
	arg_1_0.finishController_ = ControllerUtil.GetController(arg_1_0.transform_, "finish")

	if SequentialBattleData:GetChapterData(arg_1_0.activityID_) == nil then
		SequentialBattleData:InitChapterData(arg_1_0.activityID_)
	end
end

function var_0_0.OnEnter(arg_2_0)
	manager.redPoint:bindUIandKey(arg_2_0.transform_, string.format("%s_%s", RedPointConst.SEQUENTIAL_BATTLE_DAY, arg_2_0.activityID_))
	arg_2_0:AddTimer()

	arg_2_0.nameText1_.text = GetI18NText(SequentialBattleChapterCfg[arg_2_0.activityID_].stage_name)
	arg_2_0.nameText2_.text = GetI18NText(SequentialBattleChapterCfg[arg_2_0.activityID_].stage_name)

	arg_2_0:RefreshFinishStatus()
	SetActive(arg_2_0.gameObject_, true)
end

function var_0_0.OnExit(arg_3_0)
	arg_3_0:StopTimer()
	manager.redPoint:unbindUIandKey(arg_3_0.transform_, string.format("%s_%s", RedPointConst.SEQUENTIAL_BATTLE_DAY, arg_3_0.activityID_))
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.button_, nil, function()
		if arg_4_0.lock_ then
			local var_5_0 = ActivityData:GetActivityData(arg_4_0.activityID_)

			if manager.time:GetServerTime() < var_5_0.startTime then
				local var_5_1 = GetTips("OPEN_TIME")

				ShowTips(string.format(var_5_1, manager.time:GetLostTimeStr(var_5_0.startTime)))
			else
				ShowTips("TIME_OVER")
			end

			return
		else
			local var_5_2 = SequentialBattleChapterCfg[arg_4_0.activityID_].main_id

			SequentialBattleData:SetSelectChapterID(var_5_2, arg_4_0.activityID_)
			manager.notify:Invoke(SEQUENTIAL_BATTLE_SELECT_CHAPTER)
		end
	end)
end

function var_0_0.RefreshSelect(arg_6_0, arg_6_1)
	if arg_6_0.activityID_ == arg_6_1 then
		arg_6_0.selectController_:SetSelectedState("Select")
	else
		arg_6_0.selectController_:SetSelectedState("no")
	end
end

function var_0_0.RefreshLock(arg_7_0)
	if arg_7_0.lock_ then
		arg_7_0.lockController_:SetSelectedState("on")
	else
		arg_7_0.lockController_:SetSelectedState("off")
	end
end

function var_0_0.RefreshFinishStatus(arg_8_0)
	local var_8_0 = arg_8_0.activityID_

	if table.length(SequentialBattleData:GetChapterData(var_8_0).historyFinishStage) < #SequentialBattleChapterCfg[var_8_0].stage_id then
		arg_8_0.finishController_:SetSelectedState("false")
	else
		arg_8_0.finishController_:SetSelectedState("true")
	end
end

function var_0_0.Dispose(arg_9_0)
	var_0_0.super.Dispose(arg_9_0)
	Object.Destroy(arg_9_0.gameObject_)

	arg_9_0.transform_ = nil
	arg_9_0.gameObject_ = nil
end

function var_0_0.AddTimer(arg_10_0)
	arg_10_0:StopTimer()

	local var_10_0 = ActivityData:GetActivityData(arg_10_0.activityID_)

	if manager.time:GetServerTime() < var_10_0.startTime or manager.time:GetServerTime() > var_10_0.stopTime then
		arg_10_0.lock_ = true
	else
		arg_10_0.lock_ = false
	end

	arg_10_0:RefreshLock()

	local var_10_1 = GetTips("OPEN_TIME")

	if manager.time:GetServerTime() > var_10_0.stopTime then
		arg_10_0.unlockText_.text = GetTips("TIME_OVER")
	else
		arg_10_0.unlockText_.text = string.format(var_10_1, manager.time:GetLostTimeStr(var_10_0.startTime))
	end

	arg_10_0.timer_ = Timer.New(function()
		local var_11_0 = manager.time:GetServerTime()

		if var_11_0 >= var_10_0.startTime and var_11_0 < var_10_0.stopTime then
			if arg_10_0.lock_ == true then
				arg_10_0.lock_ = false

				arg_10_0:RefreshLock()
			else
				arg_10_0.lock_ = false
			end
		elseif var_11_0 > var_10_0.stopTime then
			arg_10_0:StopTimer()

			arg_10_0.lock_ = true

			arg_10_0:RefreshLock()

			arg_10_0.unlockText_.text = GetTips("TIME_OVER")
		elseif var_11_0 < var_10_0.startTime then
			arg_10_0.unlockText_.text = string.format(var_10_1, manager.time:GetLostTimeStr(var_10_0.startTime))
		end
	end, 1, -1)

	arg_10_0.timer_:Start()
end

function var_0_0.StopTimer(arg_12_0)
	if arg_12_0.timer_ then
		arg_12_0.timer_:Stop()

		arg_12_0.timer_ = nil
	end
end

return var_0_0

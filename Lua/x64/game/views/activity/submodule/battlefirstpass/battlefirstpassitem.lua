local var_0_0 = class("BattleFirstPassItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	var_0_0.gameObject_ = arg_1_1
	var_0_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.typeCon_ = ControllerUtil.GetController(arg_3_0.transform_, "type")
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.Btn_, nil, function()
		local var_5_0 = manager.time:GetServerTime()

		if var_5_0 < arg_4_0.startTime_ then
			ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(arg_4_0.startTime_)))
		elseif var_5_0 < arg_4_0.stopTime_ then
			if arg_4_0.clickFunc_ then
				arg_4_0.clickFunc_(arg_4_0.id_)
			end
		else
			ShowTips("TIP_EXPIRED")
		end
	end)
end

function var_0_0.OnEnter(arg_6_0)
	return
end

function var_0_0.RefreshUI(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.activityID_ = arg_7_1
	arg_7_0.id_ = arg_7_2
	arg_7_0.cfg_ = ActivityFirstClearCfg[arg_7_0.id_]
	arg_7_0.startTime_ = arg_7_0:GetStarTime()
	arg_7_0.stopTime_ = arg_7_0:GetStopTime()

	arg_7_0:RefreshTitle()
	arg_7_0:RefreshTime()
	arg_7_0:RefreshRedPoint()
	arg_7_0:RefreshClear()
end

function var_0_0.GetStarTime(arg_8_0)
	return ActivityData:GetActivityData(arg_8_0.id_).startTime
end

function var_0_0.GetStopTime(arg_9_0)
	return ActivityData:GetActivityData(arg_9_0.id_).stopTime
end

function var_0_0.RefreshTitle(arg_10_0)
	arg_10_0.title_.text = "「" .. GetI18NText(arg_10_0.cfg_.name) .. "」"
end

function var_0_0.RefreshTime(arg_11_0)
	local var_11_0
	local var_11_1 = manager.time:GetServerTime()

	arg_11_0:StopTimer()

	if var_11_1 < arg_11_0.startTime_ then
		arg_11_0.timeCntText_.text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(arg_11_0.startTime_))
		arg_11_0.timer_ = Timer.New(function()
			var_11_0 = arg_11_0.startTime_ - manager.time:GetServerTime()

			if var_11_0 <= 0 then
				arg_11_0:StopTimer()
				arg_11_0:SetSelected(arg_11_0.select_)
				arg_11_0:RefreshTime()

				return
			end

			arg_11_0.timeCntText_.text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(arg_11_0.startTime_))
		end, 1, -1)

		arg_11_0.timer_:Start()
	elseif var_11_1 < arg_11_0.stopTime_ then
		arg_11_0.timer_ = Timer.New(function()
			var_11_0 = arg_11_0.stopTime_ - manager.time:GetServerTime()

			if var_11_0 <= 0 then
				arg_11_0:StopTimer()
				arg_11_0:SetSelected(arg_11_0.select_)
				arg_11_0:RefreshTime()

				return
			end
		end, 1, -1)

		arg_11_0.timer_:Start()
	else
		arg_11_0.timeCntText_.text = GetTips("TIME_OVER")
	end
end

function var_0_0.RefreshRedPoint(arg_14_0)
	local var_14_0 = manager.redPoint:getTipValue(RedPointConst.BATTLE_FIRST_PASS .. arg_14_0.id_)

	SetActive(arg_14_0.redGo_, var_14_0 > 0)
end

function var_0_0.RefreshClear(arg_15_0)
	local var_15_0 = BattleFirstPassData:GetBattleData(arg_15_0.activityID_, arg_15_0.id_)

	if var_15_0 then
		SetActive(arg_15_0.clearGo_, var_15_0.battleState ~= ActivityConst.BATTLE_FIRST_PASS_STATE.UNFINISHED)
	end
end

function var_0_0.GetID(arg_16_0)
	return arg_16_0.id_
end

function var_0_0.GetTitle(arg_17_0)
	return arg_17_0.cfg_.name
end

function var_0_0.SetSelected(arg_18_0, arg_18_1)
	arg_18_0.select_ = arg_18_1

	local var_18_0 = manager.time:GetServerTime()

	if var_18_0 < arg_18_0.startTime_ or var_18_0 >= arg_18_0.stopTime_ then
		arg_18_0.typeCon_:SetSelectedState("close")

		return
	elseif arg_18_1 then
		arg_18_0.typeCon_:SetSelectedState("selected")
		BattleFirstPassAction:SetOnceRedPointOff(arg_18_0.activityID_, arg_18_0.id_)
		arg_18_0:RefreshRedPoint()
	else
		arg_18_0.typeCon_:SetSelectedState("open")
	end
end

function var_0_0.StopTimer(arg_19_0)
	if arg_19_0.timer_ then
		arg_19_0.timer_:Stop()

		arg_19_0.timer_ = nil
	end
end

function var_0_0.RegisterClickListener(arg_20_0, arg_20_1)
	arg_20_0.clickFunc_ = arg_20_1
end

function var_0_0.OnExit(arg_21_0)
	arg_21_0:StopTimer()

	arg_21_0.clickFunc_ = nil
end

function var_0_0.Dispose(arg_22_0)
	arg_22_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_22_0)
end

return var_0_0

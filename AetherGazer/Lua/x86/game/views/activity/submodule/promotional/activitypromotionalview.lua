ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local var_0_0 = class("ActivityPromotionalView", ActivityMainBasePanel)

function var_0_0.GetUIName(arg_1_0)
	return "Widget/System/Activity_Resident/Activity_HeroPubliciz/Activity_HeroPublicizMainUI"
end

function var_0_0.Init(arg_2_0)
	var_0_0.super.Init(arg_2_0)

	arg_2_0.trailShowController_ = arg_2_0.tansCon_:GetController("show1")
	arg_2_0.skinShowController_ = arg_2_0.tansCon_:GetController("show2")
	arg_2_0.heroController_ = arg_2_0.tansCon_:GetController("complete1")
	arg_2_0.skinController_ = arg_2_0.tansCon_:GetController("complete2")
end

function var_0_0.OnEnter(arg_3_0)
	var_0_0.super.OnEnter(arg_3_0)

	arg_3_0.promotionalCfg_ = ActivityPromotionalCfg[arg_3_0.activityID_]

	arg_3_0:AddTimer()
	arg_3_0:BindRedPoint()
end

function var_0_0.BindRedPoint(arg_4_0)
	local var_4_0 = ActivityPromotionalCfg[arg_4_0.activityID_].hero_trial_id

	manager.redPoint:bindUIandKey(arg_4_0.heroTrialBtn_.transform, RedPointConst.ACTIVITY_TRIAL .. var_4_0)

	local var_4_1 = ActivityPromotionalCfg[arg_4_0.activityID_].hero_skin_id

	manager.redPoint:bindUIandKey(arg_4_0.heroSkinBtn_.transform, RedPointConst.ACTIVITY_TRIAL .. var_4_1)
end

function var_0_0.OnExit(arg_5_0)
	var_0_0.super.OnExit(arg_5_0)
	arg_5_0:StopTimer()
	arg_5_0:UnBindRedPoint()
end

function var_0_0.UnBindRedPoint(arg_6_0)
	local var_6_0 = ActivityPromotionalCfg[arg_6_0.activityID_].hero_trial_id

	manager.redPoint:unbindUIandKey(arg_6_0.heroTrialBtn_.transform, RedPointConst.ACTIVITY_TRIAL .. var_6_0)

	local var_6_1 = ActivityPromotionalCfg[arg_6_0.activityID_].hero_skin_id

	manager.redPoint:unbindUIandKey(arg_6_0.heroSkinBtn_.transform, RedPointConst.ACTIVITY_TRIAL .. var_6_1)
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)
end

function var_0_0.AddListeners(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.heroTrialBtn_, nil, function()
		SDKTools.SendMessageToSDK("hero_publicize_page_jump", {
			type = 1
		})

		local var_9_0 = arg_8_0.promotionalCfg_.hero_trial_navigation[3]
		local var_9_1 = arg_8_0.promotionalCfg_.hero_trial_id

		HeroTrialData:SetSelectActivityHeroID(var_9_0, var_9_1)
		JumpTools.JumpToPage2(arg_8_0.promotionalCfg_.hero_trial_navigation)
	end)
	arg_8_0:AddBtnListener(arg_8_0.heroSkinBtn_, nil, function()
		SDKTools.SendMessageToSDK("hero_publicize_page_jump", {
			type = 2
		})
		JumpTools.JumpToPage2(arg_8_0.promotionalCfg_.hero_skin_navigation)
	end)
	arg_8_0:AddBtnListener(arg_8_0.heroDrawBtn_, nil, function()
		SDKTools.SendMessageToSDK("hero_publicize_page_jump", {
			type = 3
		})
		OperationRecorder.RecordButtonTouch("activity_hero_" .. arg_8_0.activityID_)
		JumpTools.JumpToPage2(arg_8_0.promotionalCfg_.hero_draw_navigation)
	end)

	local var_8_0 = 1

	while arg_8_0[string.format("extraJumpBtn_%s", var_8_0)] ~= nil do
		local var_8_1 = var_8_0

		arg_8_0:AddBtnListener(arg_8_0[string.format("extraJumpBtn_%s", var_8_1)], nil, function()
			local var_12_0 = arg_8_0.promotionalCfg_

			if type(var_12_0.extra_jump_list) == "table" and var_12_0.extra_jump_list[var_8_1] then
				JumpTools.JumpToPage2(var_12_0.extra_jump_list[var_8_1])
			else
				Debug.LogError(string.format("ActivityPromotionalCfg[%s]的extra_jump_list[%s]没有配", arg_8_0.activityID_, var_8_1))
			end
		end)

		var_8_0 = var_8_0 + 1
	end
end

function var_0_0.HideRedPoint(arg_13_0)
	local var_13_0 = arg_13_0.activityID_

	if not RedPointData:GetIsRedPointOpen(RedPointConst.ACTIVITY_RANGE + var_13_0) then
		RedPointAction.HandleRedPoint(RedPointConst.ACTIVITY_RANGE + var_13_0)
		manager.redPoint:setTip(string.format("%s%s", ActivityTools.GetRedPointKey(var_13_0), var_13_0), 0)
	end
end

function var_0_0.Show(arg_14_0, arg_14_1)
	var_0_0.super.Show(arg_14_0, arg_14_1)

	if arg_14_1 then
		arg_14_0:RefreshHeroView()
		arg_14_0:RefreshHeroTrialState()
		arg_14_0:RefreshHeroSkinState()
	end
end

function var_0_0.RefreshHeroView(arg_15_0)
	local var_15_0 = Asset.Load(arg_15_0.promotionalCfg_.background)

	if not isNil(var_15_0) and not arg_15_0.bgGo_ then
		arg_15_0.bgGo_ = GameObject.Instantiate(var_15_0, arg_15_0.bgContent_, false)
	end

	arg_15_0.imgRace_.sprite = HeroTools.GetHeroRaceIcon(arg_15_0.promotionalCfg_.hero_id)
	arg_15_0.textName_.text = HeroTools.GetHeroFullName(arg_15_0.promotionalCfg_.hero_id)
end

function var_0_0.RefreshHeroTrialState(arg_16_0)
	local var_16_0 = arg_16_0.promotionalCfg_.hero_trial_id

	if var_16_0 then
		local var_16_1 = HeroTrialData:GetHeroTrialStateList()[var_16_0]

		arg_16_0.heroController_:SetSelectedState((var_16_1 == 1 or var_16_1 == 2) and "show" or "hide")
		arg_16_0.trailShowController_:SetSelectedState("on")

		local var_16_2 = RedPointConst.ACTIVITY_TRIAL .. var_16_0

		if var_16_1 == 1 then
			manager.redPoint:setTip(var_16_2, 1)
		else
			manager.redPoint:setTip(var_16_2, 0)
		end
	else
		arg_16_0.trailShowController_:SetSelectedState("off")
	end
end

function var_0_0.RefreshHeroSkinState(arg_17_0)
	local var_17_0 = arg_17_0.promotionalCfg_.hero_skin_id
	local var_17_1 = SkinTrialData:GetSkinTrialStatus(var_17_0)

	if var_17_0 and var_17_0 ~= 0 then
		arg_17_0.skinController_:SetSelectedState((var_17_1 == 1 or var_17_1 == 2) and "show" or "hide")
		arg_17_0.skinShowController_:SetSelectedState("on")

		local var_17_2 = RedPointConst.ACTIVITY_TRIAL .. var_17_0

		if var_17_1 == 2 then
			manager.redPoint:setTip(var_17_2, 1)
		else
			manager.redPoint:setTip(var_17_2, 0)
		end
	else
		arg_17_0.skinShowController_:SetSelectedState("off")
	end
end

function var_0_0.RefreshTime(arg_18_0)
	local var_18_0 = ActivityData:GetActivityData(arg_18_0.activityID_)
	local var_18_1 = manager.time:GetServerTime()

	arg_18_0.timeText_.text = manager.time:GetLostTimeStr2(var_18_0.stopTime, true)
end

function var_0_0.AddTimer(arg_19_0)
	arg_19_0:StopTimer()
	arg_19_0:RefreshTime()

	arg_19_0.timer_ = Timer.New(function()
		arg_19_0:RefreshTime()
	end, 1, -1)

	arg_19_0.timer_:Start()
end

function var_0_0.StopTimer(arg_21_0)
	if arg_21_0.timer_ then
		arg_21_0.timer_:Stop()

		arg_21_0.timer_ = nil
	end
end

return var_0_0

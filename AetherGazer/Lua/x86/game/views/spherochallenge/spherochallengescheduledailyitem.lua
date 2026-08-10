local var_0_0 = class("SPHeroChallengeScheduleDailyItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.gameObject_ = GameObject.Instantiate(arg_1_1, arg_1_2)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.scheduleID = arg_1_3

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.stateController = arg_3_0.controller:GetController("state")
	arg_3_0.sliderController = arg_3_0.controller:GetController("infinite")
	arg_3_0.selectController = arg_3_0.controller:GetController("Selected")
end

function var_0_0.RefreshUI(arg_4_0)
	arg_4_0.selectController:SetSelectedState("Unselected")

	local var_4_0 = arg_4_0.scheduleID

	arg_4_0:RefreshBaseInfo(var_4_0)

	local var_4_1, var_4_2, var_4_3 = SPHeroChallengeTools:CheckScheduleCanAddInlist(arg_4_0.scheduleID)

	arg_4_0.state = var_4_3

	local var_4_4, var_4_5 = SPHeroChallengeTools:GetScheduleProgress(var_4_0)

	arg_4_0.sliderController:SetSelectedState("normal")

	if var_4_4 < 0 then
		arg_4_0.sliderController:SetSelectedState("infinite")

		arg_4_0.progressText_.text = GetTips("ACTIVITY_HERO_CHALLENGE_SCHEDULE_INFINITE")
	else
		arg_4_0.sliderSlr_.value = math.min(var_4_4 / var_4_5, 1)
		arg_4_0.progressText_.text = string.format(GetTips("ACTIVITY_HERO_CHALLENGE_SCHEDULE_PROGRESS"), var_4_4, var_4_5)
	end

	if arg_4_0.state == "finish" then
		arg_4_0.stateController:SetSelectedState("finish")

		return true
	elseif arg_4_0.state == "unlock" then
		arg_4_0.stateController:SetSelectedState("unlock")
	elseif arg_4_0.state == "lock" then
		arg_4_0.lockdescText_.text = var_4_2

		arg_4_0.stateController:SetSelectedState("lock")
	end
end

function var_0_0.RefreshBaseInfo(arg_5_0, arg_5_1)
	arg_5_0.scheduleID = arg_5_1
	arg_5_0.iconImg_.sprite = SPHeroChallengeTools:GetScheduleIcon(arg_5_1)
	arg_5_0.name.text = ActivityHeroChallengeScheduleCfg[arg_5_1].name
	arg_5_0.desc.text = ActivityHeroChallengeScheduleCfg[arg_5_1].linkgame_des

	local var_5_0 = SPHeroChallengeTools:GetSameScheduleNum(arg_5_1)

	if var_5_0 > 0 then
		arg_5_0.selectController:SetSelectedState("Selected")

		arg_5_0.numText_.text = "x" .. var_5_0
	else
		arg_5_0.numText_.text = ""
	end
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.itemBtn, nil, function()
		local var_7_0, var_7_1 = SPHeroChallengeTools:CheckScheduleCanAddInlist(arg_6_0.scheduleID)

		if var_7_0 then
			local var_7_2 = SPHeroChallengeData:GetCurActivityInfo(arg_6_0.scheduleID)

			if var_7_2 then
				var_7_2:AddScheduleInDailyList(arg_6_0.scheduleID)
			end
		elseif var_7_1 then
			ShowTips(var_7_1)
		end
	end)
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0.gameObject_ = nil
	arg_8_0.transform_ = nil
	arg_8_0.scheduleID = nil

	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0

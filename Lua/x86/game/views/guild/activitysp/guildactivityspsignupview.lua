local var_0_0 = class("GuildActivitySPSignUpView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/GuildActivitySPUI/GuildActivitySPSignupUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.isSignedUpController_ = ControllerUtil.GetController(arg_5_0.gameObject_.transform, "isSignedUp")
	arg_5_0.statusController_ = ControllerUtil.GetController(arg_5_0.gameObject_.transform, "status")
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.signupBtn_, nil, function()
		if PlayerData:GetPlayerInfo().userLevel >= GameSetting.activity_club_sp_user_level_limit.value[1] then
			GuildActivitySPAction.Register(function()
				local var_8_0 = GuildActivitySPData:GetCurRunActivityID()

				if ActivityData:GetActivityIsOpen(var_8_0) then
					StartGuildActivitySP(GuildActivitySPData:GetCurrentGrid())
				else
					arg_6_0:UpdateView()
				end
			end)
		else
			ShowTips("ACTIVITY_CLUB_REGISTER_CANT_TIP")
		end
	end)
end

function var_0_0.AddEventListeners(arg_9_0)
	return
end

function var_0_0.OnTop(arg_10_0)
	arg_10_0:UpdateBar()
end

function var_0_0.OnBehind(arg_11_0)
	manager.windowBar:HideBar()
end

function var_0_0.UpdateBar(arg_12_0)
	arg_12_0:ShowDefaultBar()
end

function var_0_0.OnEnter(arg_13_0)
	arg_13_0:AddEventListeners()
	arg_13_0:StartTimer()
	arg_13_0:UpdateTimer()
	arg_13_0:UpdateView()
end

function var_0_0.OnExit(arg_14_0)
	arg_14_0:RemoveAllEventListener()
	manager.windowBar:HideBar()
	arg_14_0:StopTimer()
end

function var_0_0.UpdateView(arg_15_0)
	arg_15_0.isSignedUpController_:SetSelectedState(GuildActivitySPData:HaveRegister() and "true" or "false")

	local var_15_0
	local var_15_1 = PlayerData:GetPlayerInfo().userLevel
	local var_15_2 = GameSetting.activity_club_sp_user_level_limit.value[1]

	if var_15_2 <= var_15_1 then
		var_15_0 = string.format(GetTips("UPGRADE_LIMIT_LEVEL"), var_15_2)
	else
		var_15_0 = string.format(GetTips("UPGRADE_LIMIT_LEVEL_RED"), var_15_2)
	end

	arg_15_0.conditionLabel_.text = var_15_0
end

function var_0_0.StartTimer(arg_16_0)
	if arg_16_0.timer_ == nil then
		arg_16_0.timer_ = Timer.New(function()
			arg_16_0:UpdateTimer()
		end, 1, -1)
	end

	arg_16_0.timer_:Start()
end

function var_0_0.StopTimer(arg_18_0)
	if arg_18_0.timer_ then
		arg_18_0.timer_:Stop()

		arg_18_0.timer_ = nil
	end
end

function var_0_0.UpdateTimer(arg_19_0)
	local var_19_0
	local var_19_1
	local var_19_2 = GuildActivitySPData:GetCurMainActivityID()
	local var_19_3 = ActivityData:GetActivityData(var_19_2).stopTime

	arg_19_0.lastTimeLabel_.text = manager.time:GetLostTimeStr(var_19_3)

	local var_19_4 = GuildActivitySPData:GetCurRunActivityID()

	if ActivityData:GetActivityIsOpen(var_19_4) then
		arg_19_0.statusController_:SetSelectedState("resignup")
	else
		arg_19_0.statusController_:SetSelectedState("signup")
	end
end

function var_0_0.OnMainHomeViewTop(arg_20_0)
	return
end

function var_0_0.Dispose(arg_21_0)
	arg_21_0:StopTimer()
	var_0_0.super.Dispose(arg_21_0)
end

return var_0_0

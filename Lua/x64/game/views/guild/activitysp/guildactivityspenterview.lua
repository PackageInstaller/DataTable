GuildActivitySpTools = import("game.tools.GuildActivitySPTools")
ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local var_0_0 = class("GuildActivitySpEnterView", ActivityMainBasePanel)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.activityID_ = arg_1_2

	local var_1_0 = GuildActivitySpTools.GetActivityEnterViewPrefab(arg_1_2)

	arg_1_0.gameObject_ = Object.Instantiate(var_1_0, arg_1_1.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.phaseController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "phase")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.goBtn_, nil, function()
		local var_5_0 = GuildActivitySPData:HaveRegister()
		local var_5_1, var_5_2 = GuildActivitySpTools.CheckActivityCurState(arg_4_0.mainActivityID)

		if var_5_1 == "start" then
			if var_5_0 then
				StartGuildActivitySP(GuildActivitySPData:GetCurrentGrid())
			else
				arg_4_0:DoSignup()
			end
		elseif var_5_1 == "register" then
			arg_4_0:DoSignup()
		end

		if not var_5_0 and manager.redPoint:getTipValue(RedPointConst.GUILD_ACTIVITY_SP_UNREGISTER) == 1 then
			GuildActivitySPAction.SetUnRegisterRedPointClicked(true)
		end

		GuildActivitySPAction.SetCoinRedPointClicked(true, arg_4_0.activityID_)
	end)
	arg_4_0:AddBtnListener(arg_4_0.helpBtn_, nil, function()
		local var_6_0, var_6_1 = GuildActivitySpTools.GetCurActivityDescribe()

		JumpTools.OpenPageByJump("gameHelpPro", {
			pages = var_6_0,
			isPrefab = var_6_1
		})
	end)
	arg_4_0:AddBtnListener(arg_4_0.shopBtn_, nil, function()
		local var_7_0 = {}
		local var_7_1 = ShopListCfg[arg_4_0.shopID].display_group

		for iter_7_0, iter_7_1 in ipairs(ShopListCfg.all) do
			if ShopListCfg[iter_7_1].display_group == var_7_1 then
				table.insert(var_7_0, iter_7_1)
			end
		end

		JumpTools.GoToSystem("/shop", {
			hideHomeBtn = 1,
			shopId = arg_4_0.shopID,
			showShops = var_7_0
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
end

function var_0_0.DoSignup(arg_8_0)
	if PlayerData:GetPlayerInfo().userLevel >= GameSetting.activity_club_sp_user_level_limit.value[1] then
		GuildActivitySPAction.Register(function()
			if ActivityData:GetActivityIsOpen(arg_8_0.startActivityID) then
				StartGuildActivitySP(GuildActivitySPData:GetCurrentGrid())
			else
				arg_8_0:UpdateView()
			end
		end)
	else
		ShowTips("ACTIVITY_CLUB_REGISTER_CANT_TIP")
	end
end

function var_0_0.OnTop(arg_10_0)
	arg_10_0:UpdateBar()
end

function var_0_0.OnBehind(arg_11_0)
	manager.windowBar:HideBar()
end

function var_0_0.UpdateBar(arg_12_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.StartTimer(arg_13_0)
	if arg_13_0.timer_ == nil then
		arg_13_0.timer_ = Timer.New(function()
			arg_13_0:UpdateView()
		end, 1, -1)
	end

	arg_13_0.timer_:Start()
end

function var_0_0.StopTimer(arg_15_0)
	if arg_15_0.timer_ then
		arg_15_0.timer_:Stop()

		arg_15_0.timer_ = nil
	end
end

function var_0_0.OnEnter(arg_16_0)
	arg_16_0.mainActivityID = GuildActivitySPData:GetCurMainActivityID()
	arg_16_0.activityInfo = GuildActivitySpTools.GetCurActivityIDInfo(arg_16_0.mainActivityID)

	if arg_16_0.activityInfo then
		arg_16_0.startActivityID = arg_16_0.activityInfo.start
		arg_16_0.registerActivityID = arg_16_0.activityInfo.register
		arg_16_0.shopID = arg_16_0.activityInfo.shopID
	end

	arg_16_0:StartTimer()
	arg_16_0:UpdateView()
	arg_16_0:BindRedPoint()
end

function var_0_0.OnExit(arg_17_0)
	arg_17_0:StopTimer()
	arg_17_0:UnBindRedPoint()
end

function var_0_0.BindRedPoint(arg_18_0)
	manager.redPoint:bindUIandKey(arg_18_0.goBtn_.transform, string.format("%s_%d", RedPointConst.GUILD_ACTIVITY_SP, arg_18_0.mainActivityID))
end

function var_0_0.UnBindRedPoint(arg_19_0)
	manager.redPoint:unbindUIandKey(arg_19_0.goBtn_.transform, string.format("%s_%d", RedPointConst.GUILD_ACTIVITY_SP, arg_19_0.mainActivityID))
end

function var_0_0.UpdateView(arg_20_0)
	local var_20_0 = manager.time:GetServerTime()
	local var_20_1 = GuildActivitySPData:HaveRegister()
	local var_20_2 = GuildActivitySpTools.GetCurOpenActivityStateInfo()

	if ActivityData:GetActivityIsOpen(arg_20_0.startActivityID) then
		local var_20_3 = ActivityData:GetActivityData(arg_20_0.startActivityID)
		local var_20_4 = var_20_3.startTime + GameSetting.activity_club_sp_phase_two_open.value[1] * 24 * 3600
		local var_20_5 = var_20_3.stopTime

		if var_20_4 < var_20_0 then
			arg_20_0.stageLabel_.text = string.format(GetTips("ACTIVITY_CLUB_SP_LAST_TIME_TIP2"))
			arg_20_0.lastDayLabel_.text = manager.time:GetLostTimeStrWith2Unit(var_20_5)
		else
			arg_20_0.stageLabel_.text = string.format(GetTips("ACTIVITY_CLUB_SP_LAST_TIME_TIP1"))
			arg_20_0.lastDayLabel_.text = manager.time:GetLostTimeStrWith2Unit(var_20_4)
		end

		if var_20_1 then
			arg_20_0.activityDesc.text = string.format(GetTips(var_20_2.introduction))

			arg_20_0.phaseController_:SetSelectedState("setout")
		else
			arg_20_0.activityDesc.text = string.format(GetTips(var_20_2.application_2))

			arg_20_0.phaseController_:SetSelectedState("replenish")
		end
	else
		local var_20_6 = ActivityData:GetActivityData(arg_20_0.registerActivityID).stopTime

		arg_20_0.stageLabel_.text = string.format(GetTips("ACTIVITY_CLUB_SP_LAST_TIME_TIP0"))
		arg_20_0.lastDayLabel_.text = manager.time:GetLostTimeStrWith2Unit(var_20_6)

		local var_20_7 = ActivityData:GetActivityData(arg_20_0.startActivityID).startTime
		local var_20_8 = manager.time:STimeDescS(var_20_7, GetTips("!%Y/%m/%d %H:%M:%S"))

		arg_20_0.activityDesc.text = string.format(GetTips(var_20_2.application_1), var_20_8)

		if var_20_1 then
			arg_20_0.phaseController_:SetSelectedState("setout")
		else
			arg_20_0.phaseController_:SetSelectedState("replenish")
		end

		if var_20_1 then
			arg_20_0.phaseController_:SetSelectedState("registered")
		else
			arg_20_0.phaseController_:SetSelectedState("unregistered")
		end
	end

	local var_20_9
	local var_20_10 = PlayerData:GetPlayerInfo().userLevel
	local var_20_11 = GameSetting.activity_club_sp_user_level_limit.value[1]

	if var_20_11 <= var_20_10 then
		var_20_9 = string.format(GetTips("UPGRADE_LIMIT_LEVEL"), var_20_11)
	else
		var_20_9 = string.format(GetTips("UPGRADE_LIMIT_LEVEL_RED"), var_20_11)
	end

	arg_20_0.conditionLabel_.text = var_20_9
end

function var_0_0.Show(arg_21_0, arg_21_1)
	SetActive(arg_21_0.gameObject_, arg_21_1)
end

function var_0_0.Dispose(arg_22_0)
	arg_22_0:StopTimer()
	var_0_0.super.Dispose(arg_22_0)
end

return var_0_0

GuildActivitySpTools = import("game.tools.GuildActivitySPTools")
ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local GuildActivitySpEnterView = class("GuildActivitySpEnterView", ActivityMainBasePanel)

function GuildActivitySpEnterView:Ctor(arg_1_1, arg_1_2)
	self.activityID_ = arg_1_2
	self.gameObject_ = Object.Instantiate(GuildActivitySpTools.GetActivityEnterViewPrefab(arg_1_2), arg_1_1.transform)
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function GuildActivitySpEnterView:Init()
	self:InitUI()
	self:AddUIListener()
end

function GuildActivitySpEnterView:InitUI()
	self:BindCfgUI()

	self.phaseController_ = ControllerUtil.GetController(self.gameObject_.transform, "phase")
end

function GuildActivitySpEnterView:AddUIListener()
	self:AddBtnListener(self.goBtn_, nil, function()
		local var_5_0 = GuildActivitySPData:HaveRegister()
		local var_5_1, var_5_2 = GuildActivitySpTools.CheckActivityCurState(self.mainActivityID)

		if var_5_1 == "start" then
			if var_5_0 then
				StartGuildActivitySP(GuildActivitySPData:GetCurrentGrid())
			else
				self:DoSignup()
			end
		elseif var_5_1 == "register" then
			self:DoSignup()
		end

		if not var_5_0 and manager.redPoint:getTipValue(RedPointConst.GUILD_ACTIVITY_SP_UNREGISTER) == 1 then
			GuildActivitySPAction.SetUnRegisterRedPointClicked(true)
		end

		GuildActivitySPAction.SetCoinRedPointClicked(true, self.activityID_)
	end)
	self:AddBtnListener(self.helpBtn_, nil, function()
		local var_6_0, var_6_1 = GuildActivitySpTools.GetCurActivityDescribe()

		JumpTools.OpenPageByJump("gameHelpPro", {
			pages = var_6_0,
			isPrefab = var_6_1
		})
	end)
	self:AddBtnListener(self.shopBtn_, nil, function()
		local var_7_0 = {}

		for iter_7_0, iter_7_1 in ipairs(ShopListCfg.all) do
			if ShopListCfg[iter_7_1].display_group == ShopListCfg[self.shopID].display_group then
				table.insert(var_7_0, iter_7_1)
			end
		end

		JumpTools.GoToSystem("/shop", {
			hideHomeBtn = 1,
			shopId = self.shopID,
			showShops = var_7_0
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
end

function GuildActivitySpEnterView:DoSignup()
	if PlayerData:GetPlayerInfo().userLevel >= GameSetting.activity_club_sp_user_level_limit.value[1] then
		GuildActivitySPAction.Register(function()
			if ActivityData:GetActivityIsOpen(self.startActivityID) then
				StartGuildActivitySP(GuildActivitySPData:GetCurrentGrid())
			else
				self:UpdateView()
			end
		end)
	else
		ShowTips("ACTIVITY_CLUB_REGISTER_CANT_TIP")
	end
end

function GuildActivitySpEnterView:OnTop()
	self:UpdateBar()
end

function GuildActivitySpEnterView:OnBehind()
	manager.windowBar:HideBar()
end

function GuildActivitySpEnterView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function GuildActivitySpEnterView:StartTimer()
	if self.timer_ == nil then
		self.timer_ = Timer.New(function()
			self:UpdateView()
		end, 1, -1)
	end

	self.timer_:Start()
end

function GuildActivitySpEnterView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function GuildActivitySpEnterView:OnEnter()
	self.mainActivityID = GuildActivitySPData:GetCurMainActivityID()
	self.activityInfo = GuildActivitySpTools.GetCurActivityIDInfo(self.mainActivityID)

	if self.activityInfo then
		self.startActivityID = self.activityInfo.start
		self.registerActivityID = self.activityInfo.register
		self.shopID = self.activityInfo.shopID
	end

	self:StartTimer()
	self:UpdateView()
	self:BindRedPoint()
end

function GuildActivitySpEnterView:OnExit()
	self:StopTimer()
	self:UnBindRedPoint()
end

function GuildActivitySpEnterView:BindRedPoint()
	manager.redPoint:bindUIandKey(self.goBtn_.transform, string.format("%s_%d", RedPointConst.GUILD_ACTIVITY_SP, self.mainActivityID))
end

function GuildActivitySpEnterView:UnBindRedPoint()
	manager.redPoint:unbindUIandKey(self.goBtn_.transform, string.format("%s_%d", RedPointConst.GUILD_ACTIVITY_SP, self.mainActivityID))
end

function GuildActivitySpEnterView:UpdateView()
	local var_20_0 = GuildActivitySPData:HaveRegister()
	local var_20_1 = GuildActivitySpTools.GetCurOpenActivityStateInfo()

	if ActivityData:GetActivityIsOpen(self.startActivityID) then
		local var_20_2 = ActivityData:GetActivityData(self.startActivityID)

		if var_20_2.startTime + GameSetting.activity_club_sp_phase_two_open.value[1] * 24 * 3600 < manager.time:GetServerTime() then
			self.stageLabel_.text = string.format(GetTips("ACTIVITY_CLUB_SP_LAST_TIME_TIP2"))
			self.lastDayLabel_.text = manager.time:GetLostTimeStrWith2Unit(var_20_2.stopTime)
		else
			self.stageLabel_.text = string.format(GetTips("ACTIVITY_CLUB_SP_LAST_TIME_TIP1"))
			self.lastDayLabel_.text = manager.time:GetLostTimeStrWith2Unit(var_20_2.startTime + GameSetting.activity_club_sp_phase_two_open.value[1] * 24 * 3600)
		end

		if var_20_0 then
			self.activityDesc.text = string.format(GetTips(var_20_1.introduction))

			self.phaseController_:SetSelectedState("setout")
		else
			self.activityDesc.text = string.format(GetTips(var_20_1.application_2))

			self.phaseController_:SetSelectedState("replenish")
		end
	else
		local var_20_3 = ActivityData:GetActivityData(self.registerActivityID).stopTime

		self.stageLabel_.text = string.format(GetTips("ACTIVITY_CLUB_SP_LAST_TIME_TIP0"))
		self.lastDayLabel_.text = manager.time:GetLostTimeStrWith2Unit(var_20_3)
		self.activityDesc.text = string.format(GetTips(var_20_1.application_1), (manager.time:STimeDescS(ActivityData:GetActivityData(self.startActivityID).startTime, GetTips("!%Y/%m/%d %H:%M:%S"))))

		if var_20_0 then
			self.phaseController_:SetSelectedState("setout")
		else
			self.phaseController_:SetSelectedState("replenish")
		end

		if var_20_0 then
			self.phaseController_:SetSelectedState("registered")
		else
			self.phaseController_:SetSelectedState("unregistered")
		end
	end

	self.conditionLabel_.text = GameSetting.activity_club_sp_user_level_limit.value[1] <= PlayerData:GetPlayerInfo().userLevel and string.format(GetTips("UPGRADE_LIMIT_LEVEL"), GameSetting.activity_club_sp_user_level_limit.value[1]) or string.format(GetTips("UPGRADE_LIMIT_LEVEL_RED"), GameSetting.activity_club_sp_user_level_limit.value[1])
end

function GuildActivitySpEnterView:Show(arg_21_1)
	SetActive(self.gameObject_, arg_21_1)
end

function GuildActivitySpEnterView:Dispose()
	self:StopTimer()
	GuildActivitySpEnterView.super.Dispose(self)
end

return GuildActivitySpEnterView

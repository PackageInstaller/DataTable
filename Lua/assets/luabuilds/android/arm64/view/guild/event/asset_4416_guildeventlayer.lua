local GuildEventLayer = class("GuildEventLayer", import("...base.BaseUI"))

GuildEventLayer.OPEN_EVENT_INFO = "GuildEventLayer:OPEN_EVENT_INFO"
GuildEventLayer.ON_OPEN_FORMATION = "GuildEventLayer:ON_OPEN_FORMATION"
GuildEventLayer.ON_OPEN_MISSION = "GuildEventLayer:ON_OPEN_MISSION"
GuildEventLayer.OPEN_MISSION_FORAMTION = "GuildEventLayer:OPEN_MISSION_FORAMTION"
GuildEventLayer.ON_OPEN_BOSS = "GuildEventLayer:ON_OPEN_BOSS"
GuildEventLayer.ON_OPEN_BOSS_FORMATION = "GuildEventLayer:ON_OPEN_BOSS_FORMATION"
GuildEventLayer.OPEN_BOSS_ASSULT = "GuildEventLayer:OPEN_BOSS_ASSULT"
GuildEventLayer.SHOW_SHIP_EQUIPMENTS = "GuildEventLayer:SHOW_SHIP_EQUIPMENTS"

function GuildEventLayer:getUIName()
	return "GuildEmptyUI"
end

function GuildEventLayer:SetPlayer(arg_2_1)
	self.player = arg_2_1

	return
end

function GuildEventLayer:SetGuild(arg_3_1)
	self.guildVO = arg_3_1
	self.events = {}
	self.activeEvent = nil

	self:SetEvents(arg_3_1:GetEvents())

	self.myAssaultFleet = arg_3_1:getMemberById(self.player.id):GetExternalAssaultFleet()

	return
end

function GuildEventLayer:SetEvents(arg_4_1)
	self.events = arg_4_1
	self.activeEvent = _.detect(self.events, function(arg_5_0)
		return arg_5_0:IsActive()
	end)

	return
end

function GuildEventLayer:UpdateFleet()
	if self.formationPage:GetLoaded() then
		self.formationPage:ExecuteAction("OnFleetUpdated", self.myAssaultFleet)
	end

	return
end

function GuildEventLayer:preload(arg_7_1)
	seriesAsync({
		function(arg_8_0)
			pg.m02:sendNotification(GAME.GET_GUILD_REPORT, {
				callback = arg_8_0
			})

			return
		end,
		function(arg_9_0)
			local var_9_0 = getProxy(GuildProxy):getRawData():GetActiveEvent()

			if not var_9_0 then
				pg.m02:sendNotification(GAME.GUILD_GET_ACTIVATION_EVENT, {
					force = false,
					callback = arg_9_0
				})
			elseif var_9_0 and var_9_0:IsExpired() then
				pg.m02:sendNotification(GAME.GUILD_GET_ACTIVATION_EVENT, {
					force = true,
					callback = arg_9_0
				})
			else
				arg_9_0()
			end

			return
		end
	}, arg_7_1)

	return
end

function GuildEventLayer:UpdateGuild(arg_10_1)
	self:SetGuild(arg_10_1)

	if self.formationPage and self.formationPage:GetLoaded() then
		self.formationPage:UpdateData(self.guildVO, self.player, {
			fleet = self.myAssaultFleet
		})
	end

	if self.eventPage and self.eventPage:GetLoaded() then
		self.eventPage:UpdateData(self.guildVO, self.player, self.events)
	end

	if self.eventInfoPage and self.eventInfoPage:GetLoaded() and self.eventInfoPage:isShowing() then
		self.eventInfoPage:Refresh(arg_10_1, self.player)
	end

	if self.showAssultShipPage and self.showAssultShipPage:GetLoaded() and self.showAssultShipPage:isShowing() then
		self:OnMemberAssultFleetUpdate()
	end

	return
end

function GuildEventLayer:RefreshMission(arg_11_1)
	local var_11_0 = self.activeEvent:GetMissionById(arg_11_1)

	if self.eventPage and self.eventPage:GetLoaded() then
		self.eventPage:OnRefreshNode(self.activeEvent, var_11_0)
	end

	if self.missionInfoPage and self.missionInfoPage:GetLoaded() then
		self.missionInfoPage:OnRefreshMission(var_11_0)
	end

	if self.missionFormationPage and self.missionFormationPage:GetLoaded() then
		self.missionFormationPage:OnRefreshMission(var_11_0)
	end

	return
end

function GuildEventLayer:RefreshBossMission(arg_12_1)
	local var_12_0 = self.activeEvent:GetBossMission()

	if self.eventPage and self.eventPage:GetLoaded() then
		self.eventPage:OnRefreshNode(self.activeEvent, var_12_0)
	end

	if self.missionBossPage and self.missionBossPage:GetLoaded() then
		self.missionBossPage:UpdateMission(var_12_0)
		self.missionBossPage:UpdateView()
	end

	return
end

function GuildEventLayer:OnBossRankUpdate()
	if self.missionBossPage and self.missionBossPage:GetLoaded() then
		self.missionBossPage:UpdateMission((self.activeEvent:GetBossMission()))
		self.missionBossPage:UpdateRank()
	end

	return
end

function GuildEventLayer:OnBossMissionFormationChanged()
	local var_14_0 = self.activeEvent:GetBossMission()

	if self.missionBossPage and self.missionBossPage:GetLoaded() then
		self.missionBossPage:UpdateMission(var_14_0)
	end

	if self.missBossForamtionPage and self.missBossForamtionPage:GetLoaded() then
		self.missBossForamtionPage:UpdateMission(var_14_0, false)
	end

	return
end

function GuildEventLayer:OnMemberAssultFleetUpdate()
	if self.showAssultShipPage and self.showAssultShipPage:GetLoaded() then
		self.showAssultShipPage:UpdateData(self.guildVO, self.player)
	end

	return
end

function GuildEventLayer:OnMyAssultFleetUpdate()
	if self.formationPage and self.formationPage:GetLoaded() then
		self.formationPage:OnFleetUpdated(self.myAssaultFleet)
	end

	return
end

function GuildEventLayer:OnMyAssultFleetFormationDone()
	if self.formationPage and self.formationPage:GetLoaded() then
		self.formationPage:OnFleetFormationDone()
	end

	return
end

function GuildEventLayer:OnReportUpdated()
	if self.eventPage and self.eventPage:GetLoaded() then
		self.eventPage:OnReportUpdated()
	end

	if self.missionBossPage and self.missionBossPage:GetLoaded() then
		self.missionBossPage:OnReportUpdated()
	end

	return
end

function GuildEventLayer:OnMissionFormationDone()
	if self.missionFormationPage and self.missionFormationPage:GetLoaded() and self.missionFormationPage:isShowing() then
		self.missionFormationPage:OnFormationDone()
	end

	return
end

function GuildEventLayer:OnMemberDeleted()
	if self.missionBossPage and self.missionBossPage:GetLoaded() then
		self.missionBossPage:CheckFleetShipState()
	end

	return
end

function GuildEventLayer:OnAssultShipBeRecommanded(arg_21_1)
	if self.showAssultShipPage and self.showAssultShipPage:GetLoaded() then
		self.showAssultShipPage:OnAssultShipBeRecommanded(arg_21_1)
	end

	return
end

function GuildEventLayer:OnRefreshAllAssultShipRecommandState()
	if self.showAssultShipPage and self.showAssultShipPage:GetLoaded() then
		self.showAssultShipPage:OnRefreshAll()
	end

	return
end

function GuildEventLayer:OnBossCommanderFormationChange()
	if self.missBossForamtionPage and self.missBossForamtionPage:GetLoaded() then
		self.missBossForamtionPage:OnBossCommanderFormationChange()
	end

	return
end

function GuildEventLayer:OnBossCommanderPrefabFormationChange()
	if self.missBossForamtionPage and self.missBossForamtionPage:GetLoaded() then
		self.missBossForamtionPage:OnBossCommanderPrefabFormationChange()
	end

	return
end

function GuildEventLayer:init()
	self:bind(GuildEventLayer.OPEN_EVENT_INFO, function(arg_26_0, arg_26_1)
		self.eventInfoPage:ExecuteAction("Show", self.guildVO, self.player, {
			gevent = arg_26_1
		})

		return
	end)
	self:bind(GuildEventLayer.ON_OPEN_FORMATION, function(arg_27_0)
		self.formationPage:ExecuteAction("Show", self.guildVO, self.player, {
			fleet = self.myAssaultFleet
		})

		return
	end)
	self:bind(GuildEventLayer.ON_OPEN_MISSION, function(arg_28_0, arg_28_1)
		self.missionInfoPage:ExecuteAction("Show", self.guildVO, self.player, {
			mission = arg_28_1
		})

		return
	end)
	self:bind(GuildEventLayer.OPEN_MISSION_FORAMTION, function(arg_29_0, arg_29_1)
		self.missionFormationPage:ExecuteAction("Show", self.guildVO, self.player, {
			mission = arg_29_1,
			shipCnt = GuildConst.MISSION_MAX_SHIP_CNT
		})

		return
	end)
	self:bind(GuildEventLayer.ON_OPEN_BOSS, function(arg_30_0, arg_30_1)
		self.missionBossPage:ExecuteAction("Show", arg_30_1)

		return
	end)
	self:bind(GuildEventLayer.ON_OPEN_BOSS_FORMATION, function(arg_31_0, arg_31_1)
		self.missBossForamtionPage:ExecuteAction("Show", self.guildVO, self.player, {
			mission = arg_31_1
		})

		return
	end)
	self:bind(GuildEventLayer.OPEN_BOSS_ASSULT, function()
		self.showAssultShipPage:ExecuteAction("Show", self.guildVO, self.player)

		return
	end)
	self:bind(GuildEventLayer.SHOW_SHIP_EQUIPMENTS, function(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
		self.shipEquipmentsPage:ExecuteAction("Show", arg_33_1, arg_33_2, arg_33_3)

		return
	end)

	self.eventPage = GuildEventPage.New(self._tf, self.event, self.contextData)
	self.eventInfoPage = GuildEventInfoPage.New(self._tf, self.event, self.contextData)
	self.formationPage = GuildEventFormationPage.New(self._tf, self.event, self.contextData)
	self.missionInfoPage = GuildMissionInfoPage.New(self._tf, self.event, self.contextData)
	self.missionFormationPage = GuildMissionFormationPage.New(self._tf, self.event, self.contextData)
	self.missionBossPage = GuildMissionBossPage.New(self._tf, self.event, self.contextData)
	self.missBossForamtionPage = GuildMissionBossFormationPage.New(self._tf, self.event, self.contextData)
	self.showAssultShipPage = GuildShowAssultShipPage.New(self._tf, self.event, self.contextData)
	self.shipEquipmentsPage = GuildShipEquipmentsPage.New(self._tf, self.event, self.contextData)
	self.helpBtn = self._tf:Find("frame/help")

	return
end

function GuildEventLayer:didEnter()
	getProxy(GuildProxy):SetBattleBtnRecord()
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.guild_event_help_tip.tip
		})

		return
	end, SFX_PANEL)
	self:EnterEvent()
	self:TryPlayGuide()

	return
end

function GuildEventLayer:TryPlayGuide()
	pg.SystemGuideMgr.GetInstance():PlayGuildAssaultFleet()

	return
end

function GuildEventLayer:EnterEvent()
	if not self:isLoaded() then
		return
	end

	local var_37_0 = self.activeEvent and self.activeEvent:GetBossMission()

	if self.activeEvent and var_37_0 and var_37_0:IsActive() and not var_37_0:IsDeath() and self.activeEvent:IsParticipant() then
		self.missionBossPage:ExecuteAction("Show", var_37_0)
	else
		self.eventPage:ExecuteAction("Show", self.guildVO, self.player, self.events)
	end

	if self.missionBossPage and self.missionBossPage:GetLoaded() and not self.activeEvent then
		self.missionBossPage:Destroy()

		self.missionBossPage = nil
	end

	if self.activeEvent and self.eventInfoPage and self.eventInfoPage:GetLoaded() and self.activeEvent:IsParticipant() then
		self.eventInfoPage:Destroy()

		self.eventInfoPage = nil
	end

	return
end

function GuildEventLayer:OnEventEnd()
	self:EnterEvent()

	return
end

function GuildEventLayer:onBackPressed()
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)
	self:emit(GuildEventLayer.ON_BACK)

	return
end

function GuildEventLayer:willExit()
	if self.eventInfoPage then
		self.eventInfoPage:Destroy()
	end

	self.missBossForamtionPage:Destroy()
	self.formationPage:Destroy()
	self.missionFormationPage:Destroy()
	self.missionInfoPage:Destroy()
	self.showAssultShipPage:Destroy()
	self.eventPage:Destroy()
	self.shipEquipmentsPage:Destroy()

	if self.missionBossPage then
		self.missionBossPage:Destroy()
	end

	if isActive(pg.MsgboxMgr.GetInstance()._go) then
		triggerButton(pg.MsgboxMgr.GetInstance()._closeBtn)
	end

	return
end

return GuildEventLayer

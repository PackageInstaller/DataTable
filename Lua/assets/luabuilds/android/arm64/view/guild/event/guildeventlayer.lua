local var_0_0 = class("GuildEventLayer", import("...base.BaseUI"))

var_0_0.OPEN_EVENT_INFO = "GuildEventLayer:OPEN_EVENT_INFO"
var_0_0.ON_OPEN_FORMATION = "GuildEventLayer:ON_OPEN_FORMATION"
var_0_0.ON_OPEN_MISSION = "GuildEventLayer:ON_OPEN_MISSION"
var_0_0.OPEN_MISSION_FORAMTION = "GuildEventLayer:OPEN_MISSION_FORAMTION"
var_0_0.ON_OPEN_BOSS = "GuildEventLayer:ON_OPEN_BOSS"
var_0_0.ON_OPEN_BOSS_FORMATION = "GuildEventLayer:ON_OPEN_BOSS_FORMATION"
var_0_0.OPEN_BOSS_ASSULT = "GuildEventLayer:OPEN_BOSS_ASSULT"
var_0_0.SHOW_SHIP_EQUIPMENTS = "GuildEventLayer:SHOW_SHIP_EQUIPMENTS"

function var_0_0.getUIName(arg_1_0)
	return "GuildEmptyUI"
end

function var_0_0.SetPlayer(arg_2_0, arg_2_1)
	arg_2_0.player = arg_2_1

	return
end

function var_0_0.SetGuild(arg_3_0, arg_3_1)
	arg_3_0.guildVO = arg_3_1
	arg_3_0.events = {}
	arg_3_0.activeEvent = nil

	arg_3_0:SetEvents(arg_3_1:GetEvents())

	arg_3_0.myAssaultFleet = arg_3_1:getMemberById(arg_3_0.player.id):GetExternalAssaultFleet()

	return
end

function var_0_0.SetEvents(arg_4_0, arg_4_1)
	arg_4_0.events = arg_4_1
	arg_4_0.activeEvent = _.detect(arg_4_0.events, function(arg_5_0)
		return arg_5_0:IsActive()
	end)

	return
end

function var_0_0.UpdateFleet(arg_6_0)
	if arg_6_0.formationPage:GetLoaded() then
		arg_6_0.formationPage:ExecuteAction("OnFleetUpdated", arg_6_0.myAssaultFleet)
	end

	return
end

function var_0_0.preload(arg_7_0, arg_7_1)
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

function var_0_0.UpdateGuild(arg_10_0, arg_10_1)
	arg_10_0:SetGuild(arg_10_1)

	if arg_10_0.formationPage and arg_10_0.formationPage:GetLoaded() then
		arg_10_0.formationPage:UpdateData(arg_10_0.guildVO, arg_10_0.player, {
			fleet = arg_10_0.myAssaultFleet
		})
	end

	if arg_10_0.eventPage and arg_10_0.eventPage:GetLoaded() then
		arg_10_0.eventPage:UpdateData(arg_10_0.guildVO, arg_10_0.player, arg_10_0.events)
	end

	if arg_10_0.eventInfoPage and arg_10_0.eventInfoPage:GetLoaded() and arg_10_0.eventInfoPage:isShowing() then
		arg_10_0.eventInfoPage:Refresh(arg_10_1, arg_10_0.player)
	end

	if arg_10_0.showAssultShipPage and arg_10_0.showAssultShipPage:GetLoaded() and arg_10_0.showAssultShipPage:isShowing() then
		arg_10_0:OnMemberAssultFleetUpdate()
	end

	return
end

function var_0_0.RefreshMission(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0.activeEvent:GetMissionById(arg_11_1)

	if arg_11_0.eventPage and arg_11_0.eventPage:GetLoaded() then
		arg_11_0.eventPage:OnRefreshNode(arg_11_0.activeEvent, var_11_0)
	end

	if arg_11_0.missionInfoPage and arg_11_0.missionInfoPage:GetLoaded() then
		arg_11_0.missionInfoPage:OnRefreshMission(var_11_0)
	end

	if arg_11_0.missionFormationPage and arg_11_0.missionFormationPage:GetLoaded() then
		arg_11_0.missionFormationPage:OnRefreshMission(var_11_0)
	end

	return
end

function var_0_0.RefreshBossMission(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0.activeEvent:GetBossMission()

	if arg_12_0.eventPage and arg_12_0.eventPage:GetLoaded() then
		arg_12_0.eventPage:OnRefreshNode(arg_12_0.activeEvent, var_12_0)
	end

	if arg_12_0.missionBossPage and arg_12_0.missionBossPage:GetLoaded() then
		arg_12_0.missionBossPage:UpdateMission(var_12_0)
		arg_12_0.missionBossPage:UpdateView()
	end

	return
end

function var_0_0.OnBossRankUpdate(arg_13_0)
	if arg_13_0.missionBossPage and arg_13_0.missionBossPage:GetLoaded() then
		arg_13_0.missionBossPage:UpdateMission((arg_13_0.activeEvent:GetBossMission()))
		arg_13_0.missionBossPage:UpdateRank()
	end

	return
end

function var_0_0.OnBossMissionFormationChanged(arg_14_0)
	local var_14_0 = arg_14_0.activeEvent:GetBossMission()

	if arg_14_0.missionBossPage and arg_14_0.missionBossPage:GetLoaded() then
		arg_14_0.missionBossPage:UpdateMission(var_14_0)
	end

	if arg_14_0.missBossForamtionPage and arg_14_0.missBossForamtionPage:GetLoaded() then
		arg_14_0.missBossForamtionPage:UpdateMission(var_14_0, false)
	end

	return
end

function var_0_0.OnMemberAssultFleetUpdate(arg_15_0)
	if arg_15_0.showAssultShipPage and arg_15_0.showAssultShipPage:GetLoaded() then
		arg_15_0.showAssultShipPage:UpdateData(arg_15_0.guildVO, arg_15_0.player)
	end

	return
end

function var_0_0.OnMyAssultFleetUpdate(arg_16_0)
	if arg_16_0.formationPage and arg_16_0.formationPage:GetLoaded() then
		arg_16_0.formationPage:OnFleetUpdated(arg_16_0.myAssaultFleet)
	end

	return
end

function var_0_0.OnMyAssultFleetFormationDone(arg_17_0)
	if arg_17_0.formationPage and arg_17_0.formationPage:GetLoaded() then
		arg_17_0.formationPage:OnFleetFormationDone()
	end

	return
end

function var_0_0.OnReportUpdated(arg_18_0)
	if arg_18_0.eventPage and arg_18_0.eventPage:GetLoaded() then
		arg_18_0.eventPage:OnReportUpdated()
	end

	if arg_18_0.missionBossPage and arg_18_0.missionBossPage:GetLoaded() then
		arg_18_0.missionBossPage:OnReportUpdated()
	end

	return
end

function var_0_0.OnMissionFormationDone(arg_19_0)
	if arg_19_0.missionFormationPage and arg_19_0.missionFormationPage:GetLoaded() and arg_19_0.missionFormationPage:isShowing() then
		arg_19_0.missionFormationPage:OnFormationDone()
	end

	return
end

function var_0_0.OnMemberDeleted(arg_20_0)
	if arg_20_0.missionBossPage and arg_20_0.missionBossPage:GetLoaded() then
		arg_20_0.missionBossPage:CheckFleetShipState()
	end

	return
end

function var_0_0.OnAssultShipBeRecommanded(arg_21_0, arg_21_1)
	if arg_21_0.showAssultShipPage and arg_21_0.showAssultShipPage:GetLoaded() then
		arg_21_0.showAssultShipPage:OnAssultShipBeRecommanded(arg_21_1)
	end

	return
end

function var_0_0.OnRefreshAllAssultShipRecommandState(arg_22_0)
	if arg_22_0.showAssultShipPage and arg_22_0.showAssultShipPage:GetLoaded() then
		arg_22_0.showAssultShipPage:OnRefreshAll()
	end

	return
end

function var_0_0.OnBossCommanderFormationChange(arg_23_0)
	if arg_23_0.missBossForamtionPage and arg_23_0.missBossForamtionPage:GetLoaded() then
		arg_23_0.missBossForamtionPage:OnBossCommanderFormationChange()
	end

	return
end

function var_0_0.OnBossCommanderPrefabFormationChange(arg_24_0)
	if arg_24_0.missBossForamtionPage and arg_24_0.missBossForamtionPage:GetLoaded() then
		arg_24_0.missBossForamtionPage:OnBossCommanderPrefabFormationChange()
	end

	return
end

function var_0_0.init(arg_25_0)
	arg_25_0:bind(var_0_0.OPEN_EVENT_INFO, function(arg_26_0, arg_26_1)
		arg_25_0.eventInfoPage:ExecuteAction("Show", arg_25_0.guildVO, arg_25_0.player, {
			gevent = arg_26_1
		})

		return
	end)
	arg_25_0:bind(var_0_0.ON_OPEN_FORMATION, function(arg_27_0)
		arg_25_0.formationPage:ExecuteAction("Show", arg_25_0.guildVO, arg_25_0.player, {
			fleet = arg_25_0.myAssaultFleet
		})

		return
	end)
	arg_25_0:bind(var_0_0.ON_OPEN_MISSION, function(arg_28_0, arg_28_1)
		arg_25_0.missionInfoPage:ExecuteAction("Show", arg_25_0.guildVO, arg_25_0.player, {
			mission = arg_28_1
		})

		return
	end)
	arg_25_0:bind(var_0_0.OPEN_MISSION_FORAMTION, function(arg_29_0, arg_29_1)
		arg_25_0.missionFormationPage:ExecuteAction("Show", arg_25_0.guildVO, arg_25_0.player, {
			mission = arg_29_1,
			shipCnt = GuildConst.MISSION_MAX_SHIP_CNT
		})

		return
	end)
	arg_25_0:bind(var_0_0.ON_OPEN_BOSS, function(arg_30_0, arg_30_1)
		arg_25_0.missionBossPage:ExecuteAction("Show", arg_30_1)

		return
	end)
	arg_25_0:bind(var_0_0.ON_OPEN_BOSS_FORMATION, function(arg_31_0, arg_31_1)
		arg_25_0.missBossForamtionPage:ExecuteAction("Show", arg_25_0.guildVO, arg_25_0.player, {
			mission = arg_31_1
		})

		return
	end)
	arg_25_0:bind(var_0_0.OPEN_BOSS_ASSULT, function()
		arg_25_0.showAssultShipPage:ExecuteAction("Show", arg_25_0.guildVO, arg_25_0.player)

		return
	end)
	arg_25_0:bind(var_0_0.SHOW_SHIP_EQUIPMENTS, function(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
		arg_25_0.shipEquipmentsPage:ExecuteAction("Show", arg_33_1, arg_33_2, arg_33_3)

		return
	end)

	arg_25_0.eventPage = GuildEventPage.New(arg_25_0._tf, arg_25_0.event, arg_25_0.contextData)
	arg_25_0.eventInfoPage = GuildEventInfoPage.New(arg_25_0._tf, arg_25_0.event, arg_25_0.contextData)
	arg_25_0.formationPage = GuildEventFormationPage.New(arg_25_0._tf, arg_25_0.event, arg_25_0.contextData)
	arg_25_0.missionInfoPage = GuildMissionInfoPage.New(arg_25_0._tf, arg_25_0.event, arg_25_0.contextData)
	arg_25_0.missionFormationPage = GuildMissionFormationPage.New(arg_25_0._tf, arg_25_0.event, arg_25_0.contextData)
	arg_25_0.missionBossPage = GuildMissionBossPage.New(arg_25_0._tf, arg_25_0.event, arg_25_0.contextData)
	arg_25_0.missBossForamtionPage = GuildMissionBossFormationPage.New(arg_25_0._tf, arg_25_0.event, arg_25_0.contextData)
	arg_25_0.showAssultShipPage = GuildShowAssultShipPage.New(arg_25_0._tf, arg_25_0.event, arg_25_0.contextData)
	arg_25_0.shipEquipmentsPage = GuildShipEquipmentsPage.New(arg_25_0._tf, arg_25_0.event, arg_25_0.contextData)
	arg_25_0.helpBtn = arg_25_0._tf:Find("frame/help")

	return
end

function var_0_0.didEnter(arg_34_0)
	getProxy(GuildProxy):SetBattleBtnRecord()
	onButton(arg_34_0, arg_34_0.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.guild_event_help_tip.tip
		})

		return
	end, SFX_PANEL)
	arg_34_0:EnterEvent()
	arg_34_0:TryPlayGuide()

	return
end

function var_0_0.TryPlayGuide(arg_36_0)
	pg.SystemGuideMgr.GetInstance():PlayGuildAssaultFleet()

	return
end

function var_0_0.EnterEvent(arg_37_0)
	if not arg_37_0:isLoaded() then
		return
	end

	local var_37_0 = arg_37_0.activeEvent and arg_37_0.activeEvent:GetBossMission()

	if arg_37_0.activeEvent and var_37_0 and var_37_0:IsActive() and not var_37_0:IsDeath() and arg_37_0.activeEvent:IsParticipant() then
		arg_37_0.missionBossPage:ExecuteAction("Show", var_37_0)
	else
		arg_37_0.eventPage:ExecuteAction("Show", arg_37_0.guildVO, arg_37_0.player, arg_37_0.events)
	end

	if arg_37_0.missionBossPage and arg_37_0.missionBossPage:GetLoaded() and not arg_37_0.activeEvent then
		arg_37_0.missionBossPage:Destroy()

		arg_37_0.missionBossPage = nil
	end

	if arg_37_0.activeEvent and arg_37_0.eventInfoPage and arg_37_0.eventInfoPage:GetLoaded() and arg_37_0.activeEvent:IsParticipant() then
		arg_37_0.eventInfoPage:Destroy()

		arg_37_0.eventInfoPage = nil
	end

	return
end

function var_0_0.OnEventEnd(arg_38_0)
	arg_38_0:EnterEvent()

	return
end

function var_0_0.onBackPressed(arg_39_0)
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)
	arg_39_0:emit(var_0_0.ON_BACK)

	return
end

function var_0_0.willExit(arg_40_0)
	if arg_40_0.eventInfoPage then
		arg_40_0.eventInfoPage:Destroy()
	end

	arg_40_0.missBossForamtionPage:Destroy()
	arg_40_0.formationPage:Destroy()
	arg_40_0.missionFormationPage:Destroy()
	arg_40_0.missionInfoPage:Destroy()
	arg_40_0.showAssultShipPage:Destroy()
	arg_40_0.eventPage:Destroy()
	arg_40_0.shipEquipmentsPage:Destroy()

	if arg_40_0.missionBossPage then
		arg_40_0.missionBossPage:Destroy()
	end

	if isActive(pg.MsgboxMgr.GetInstance()._go) then
		triggerButton(pg.MsgboxMgr.GetInstance()._closeBtn)
	end

	return
end

return var_0_0

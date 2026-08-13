class = var_0_10000

local var_0_0 = "GuildEventLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseUI"))

var_0_1.OPEN_EVENT_INFO = "GuildEventLayer:OPEN_EVENT_INFO"
var_0_1.ON_OPEN_FORMATION = "GuildEventLayer:ON_OPEN_FORMATION"
var_0_1.ON_OPEN_MISSION = "GuildEventLayer:ON_OPEN_MISSION"
var_0_1.OPEN_MISSION_FORAMTION = "GuildEventLayer:OPEN_MISSION_FORAMTION"
var_0_1.ON_OPEN_BOSS = "GuildEventLayer:ON_OPEN_BOSS"
var_0_1.ON_OPEN_BOSS_FORMATION = "GuildEventLayer:ON_OPEN_BOSS_FORMATION"
var_0_1.OPEN_BOSS_ASSULT = "GuildEventLayer:OPEN_BOSS_ASSULT"
var_0_1.SHOW_SHIP_EQUIPMENTS = "GuildEventLayer:SHOW_SHIP_EQUIPMENTS"

function var_0_1.getUIName(arg_1_0)
	return "GuildEmptyUI"
end

function var_0_1.SetPlayer(arg_2_0, arg_2_1)
	arg_2_0.player = arg_2_1

	return
end

function var_0_1.SetGuild(arg_3_0, arg_3_1)
	arg_3_0.guildVO = arg_3_1
	arg_3_0.events = {}
	arg_3_0.activeEvent = nil

	arg_3_0:SetEvents(arg_3_1:GetEvents())

	local var_3_0 = arg_3_1:getMemberById(arg_3_0.player.id)

	arg_3_0.myAssaultFleet = var_2.GetExternalAssaultFleet(var_3_0)

	return
end

function var_0_1.SetEvents(arg_4_0, arg_4_1)
	arg_4_0.events = arg_4_1
	_ = var_1_10002
	arg_4_0.activeEvent = var_1_10002.detect(arg_4_0.events, function(arg_5_0)
		return arg_5_0:IsActive()
	end)

	return
end

function var_0_1.UpdateFleet(arg_6_0)
	local var_6_0 = arg_6_0.formationPage

	if var_1.GetLoaded(var_6_0) then
		local var_6_1 = arg_6_0.formationPage

		var_1.ExecuteAction(var_6_1, "OnFleetUpdated", arg_6_0.myAssaultFleet)
	end

	return
end

function var_0_1.preload(arg_7_0, arg_7_1)
	seriesAsync = var_1_10002

	var_1_10002({
		function(arg_8_0)
			pg = var_2_10001

			local var_8_0 = var_2_10001.m02
			local var_8_1 = var_1.sendNotification

			GAME = var_2_10003

			var_8_1(var_8_0, var_2_10003.GET_GUILD_REPORT, {
				callback = arg_8_0
			})

			return
		end,
		function(arg_9_0)
			getProxy = var_2_10001
			GuildProxy = var_2_10002

			local var_9_0 = var_2_10001(var_2_10002)
			local var_9_1 = var_1.getRawData(var_9_0)

			if not var_1.GetActiveEvent(var_9_1) then
				pg = var_9_1

				local var_9_2 = var_9_1.m02
				local var_9_3 = var_2.sendNotification

				GAME = var_2_10004

				var_9_3(var_9_2, var_2_10004.GUILD_GET_ACTIVATION_EVENT, {
					force = false,
					callback = arg_9_0
				})
			elseif var_1 and var_1:IsExpired() then
				pg = var_2

				local var_9_4 = var_2.m02
				local var_9_5 = var_2.sendNotification

				GAME = var_2_10004

				var_9_5(var_9_4, var_2_10004.GUILD_GET_ACTIVATION_EVENT, {
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

function var_0_1.UpdateGuild(arg_10_0, arg_10_1)
	arg_10_0:SetGuild(arg_10_1)

	if arg_10_0.formationPage then
		local var_10_0 = arg_10_0.formationPage

		if var_2.GetLoaded(var_10_0) then
			local var_10_1 = arg_10_0.formationPage

			var_2.UpdateData(var_10_1, arg_10_0.guildVO, arg_10_0.player, {
				fleet = arg_10_0.myAssaultFleet
			})
		end
	end

	if arg_10_0.eventPage then
		local var_10_2 = arg_10_0.eventPage

		if var_2.GetLoaded(var_10_2) then
			local var_10_3 = arg_10_0.eventPage

			var_2.UpdateData(var_10_3, arg_10_0.guildVO, arg_10_0.player, arg_10_0.events)
		end
	end

	if arg_10_0.eventInfoPage then
		local var_10_4 = arg_10_0.eventInfoPage

		if var_2.GetLoaded(var_10_4) then
			local var_10_5 = arg_10_0.eventInfoPage

			if var_2.isShowing(var_10_5) then
				local var_10_6 = arg_10_0.eventInfoPage

				var_2.Refresh(var_10_6, arg_10_1, arg_10_0.player)
			end
		end
	end

	if arg_10_0.showAssultShipPage then
		local var_10_7 = arg_10_0.showAssultShipPage

		if var_2.GetLoaded(var_10_7) then
			local var_10_8 = arg_10_0.showAssultShipPage

			if var_2.isShowing(var_10_8) then
				arg_10_0:OnMemberAssultFleetUpdate()
			end
		end
	end

	return
end

function var_0_1.RefreshMission(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0.activeEvent
	local var_11_1 = var_2.GetMissionById(var_11_0, arg_11_1)

	if arg_11_0.eventPage then
		local var_11_2 = arg_11_0.eventPage

		if var_3.GetLoaded(var_11_2) then
			local var_11_3 = arg_11_0.eventPage

			var_3.OnRefreshNode(var_11_3, arg_11_0.activeEvent, var_11_1)
		end
	end

	if arg_11_0.missionInfoPage then
		local var_11_4 = arg_11_0.missionInfoPage

		if var_3.GetLoaded(var_11_4) then
			local var_11_5 = arg_11_0.missionInfoPage

			var_3.OnRefreshMission(var_11_5, var_11_1)
		end
	end

	if arg_11_0.missionFormationPage then
		local var_11_6 = arg_11_0.missionFormationPage

		if var_3.GetLoaded(var_11_6) then
			local var_11_7 = arg_11_0.missionFormationPage

			var_3.OnRefreshMission(var_11_7, var_11_1)
		end
	end

	return
end

function var_0_1.RefreshBossMission(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0.activeEvent
	local var_12_1 = var_2.GetBossMission(var_12_0)

	if arg_12_0.eventPage then
		local var_12_2 = arg_12_0.eventPage

		if var_3.GetLoaded(var_12_2) then
			local var_12_3 = arg_12_0.eventPage

			var_3.OnRefreshNode(var_12_3, arg_12_0.activeEvent, var_12_1)
		end
	end

	if arg_12_0.missionBossPage then
		local var_12_4 = arg_12_0.missionBossPage

		if var_3.GetLoaded(var_12_4) then
			local var_12_5 = arg_12_0.missionBossPage

			var_3.UpdateMission(var_12_5, var_12_1)

			local var_12_6 = arg_12_0.missionBossPage

			var_3.UpdateView(var_12_6)
		end
	end

	return
end

function var_0_1.OnBossRankUpdate(arg_13_0)
	local var_13_0 = arg_13_0.activeEvent
	local var_13_1 = var_1.GetBossMission(var_13_0)

	if arg_13_0.missionBossPage then
		local var_13_2 = arg_13_0.missionBossPage

		if var_2.GetLoaded(var_13_2) then
			local var_13_3 = arg_13_0.missionBossPage

			var_2.UpdateMission(var_13_3, var_13_1)

			local var_13_4 = arg_13_0.missionBossPage

			var_2.UpdateRank(var_13_4)
		end
	end

	return
end

function var_0_1.OnBossMissionFormationChanged(arg_14_0)
	local var_14_0 = arg_14_0.activeEvent
	local var_14_1 = var_1.GetBossMission(var_14_0)

	if arg_14_0.missionBossPage then
		local var_14_2 = arg_14_0.missionBossPage

		if var_2.GetLoaded(var_14_2) then
			local var_14_3 = arg_14_0.missionBossPage

			var_2.UpdateMission(var_14_3, var_14_1)
		end
	end

	if arg_14_0.missBossForamtionPage then
		local var_14_4 = arg_14_0.missBossForamtionPage

		if var_2.GetLoaded(var_14_4) then
			local var_14_5 = arg_14_0.missBossForamtionPage

			var_2.UpdateMission(var_14_5, var_14_1, false)
		end
	end

	return
end

function var_0_1.OnMemberAssultFleetUpdate(arg_15_0)
	if arg_15_0.showAssultShipPage then
		local var_15_0 = arg_15_0.showAssultShipPage

		if var_1.GetLoaded(var_15_0) then
			local var_15_1 = arg_15_0.showAssultShipPage

			var_1.UpdateData(var_15_1, arg_15_0.guildVO, arg_15_0.player)
		end
	end

	return
end

function var_0_1.OnMyAssultFleetUpdate(arg_16_0)
	if arg_16_0.formationPage then
		local var_16_0 = arg_16_0.formationPage

		if var_1.GetLoaded(var_16_0) then
			local var_16_1 = arg_16_0.formationPage

			var_1.OnFleetUpdated(var_16_1, arg_16_0.myAssaultFleet)
		end
	end

	return
end

function var_0_1.OnMyAssultFleetFormationDone(arg_17_0)
	if arg_17_0.formationPage then
		local var_17_0 = arg_17_0.formationPage

		if var_1.GetLoaded(var_17_0) then
			local var_17_1 = arg_17_0.formationPage

			var_1.OnFleetFormationDone(var_17_1)
		end
	end

	return
end

function var_0_1.OnReportUpdated(arg_18_0)
	if arg_18_0.eventPage then
		local var_18_0 = arg_18_0.eventPage

		if var_1.GetLoaded(var_18_0) then
			local var_18_1 = arg_18_0.eventPage

			var_1.OnReportUpdated(var_18_1)
		end
	end

	if arg_18_0.missionBossPage then
		local var_18_2 = arg_18_0.missionBossPage

		if var_1.GetLoaded(var_18_2) then
			local var_18_3 = arg_18_0.missionBossPage

			var_1.OnReportUpdated(var_18_3)
		end
	end

	return
end

function var_0_1.OnMissionFormationDone(arg_19_0)
	if arg_19_0.missionFormationPage then
		local var_19_0 = arg_19_0.missionFormationPage

		if var_1.GetLoaded(var_19_0) then
			local var_19_1 = arg_19_0.missionFormationPage

			if var_1.isShowing(var_19_1) then
				local var_19_2 = arg_19_0.missionFormationPage

				var_1.OnFormationDone(var_19_2)
			end
		end
	end

	return
end

function var_0_1.OnMemberDeleted(arg_20_0)
	if arg_20_0.missionBossPage then
		local var_20_0 = arg_20_0.missionBossPage

		if var_1.GetLoaded(var_20_0) then
			local var_20_1 = arg_20_0.missionBossPage

			var_1.CheckFleetShipState(var_20_1)
		end
	end

	return
end

function var_0_1.OnAssultShipBeRecommanded(arg_21_0, arg_21_1)
	if arg_21_0.showAssultShipPage then
		local var_21_0 = arg_21_0.showAssultShipPage

		if var_2.GetLoaded(var_21_0) then
			local var_21_1 = arg_21_0.showAssultShipPage

			var_2.OnAssultShipBeRecommanded(var_21_1, arg_21_1)
		end
	end

	return
end

function var_0_1.OnRefreshAllAssultShipRecommandState(arg_22_0)
	if arg_22_0.showAssultShipPage then
		local var_22_0 = arg_22_0.showAssultShipPage

		if var_1.GetLoaded(var_22_0) then
			local var_22_1 = arg_22_0.showAssultShipPage

			var_1.OnRefreshAll(var_22_1)
		end
	end

	return
end

function var_0_1.OnBossCommanderFormationChange(arg_23_0)
	if arg_23_0.missBossForamtionPage then
		local var_23_0 = arg_23_0.missBossForamtionPage

		if var_1.GetLoaded(var_23_0) then
			local var_23_1 = arg_23_0.missBossForamtionPage

			var_1.OnBossCommanderFormationChange(var_23_1)
		end
	end

	return
end

function var_0_1.OnBossCommanderPrefabFormationChange(arg_24_0)
	if arg_24_0.missBossForamtionPage then
		local var_24_0 = arg_24_0.missBossForamtionPage

		if var_1.GetLoaded(var_24_0) then
			local var_24_1 = arg_24_0.missBossForamtionPage

			var_1.OnBossCommanderPrefabFormationChange(var_24_1)
		end
	end

	return
end

function var_0_1.init(arg_25_0)
	arg_25_0:bind(var_0_1.OPEN_EVENT_INFO, function(arg_26_0, arg_26_1)
		local var_26_0 = arg_25_0.eventInfoPage

		var_2.ExecuteAction(var_26_0, "Show", arg_25_0.guildVO, arg_25_0.player, {
			gevent = arg_26_1
		})

		return
	end)
	arg_25_0:bind(var_0_1.ON_OPEN_FORMATION, function(arg_27_0)
		local var_27_0 = arg_25_0.formationPage

		var_1.ExecuteAction(var_27_0, "Show", arg_25_0.guildVO, arg_25_0.player, {
			fleet = arg_25_0.myAssaultFleet
		})

		return
	end)
	arg_25_0:bind(var_0_1.ON_OPEN_MISSION, function(arg_28_0, arg_28_1)
		local var_28_0 = arg_25_0.missionInfoPage

		var_2.ExecuteAction(var_28_0, "Show", arg_25_0.guildVO, arg_25_0.player, {
			mission = arg_28_1
		})

		return
	end)
	arg_25_0:bind(var_0_1.OPEN_MISSION_FORAMTION, function(arg_29_0, arg_29_1)
		local var_29_0 = arg_25_0.missionFormationPage
		local var_29_1 = var_2.ExecuteAction
		local var_29_2 = "Show"
		local var_29_3 = arg_25_0.guildVO
		local var_29_4 = arg_25_0.player
		local var_29_5 = {
			mission = arg_29_1
		}

		GuildConst = var_2_10008
		var_29_5.shipCnt = var_2_10008.MISSION_MAX_SHIP_CNT

		var_29_1(var_29_0, var_29_2, var_29_3, var_29_4, var_29_5)

		return
	end)
	arg_25_0:bind(var_0_1.ON_OPEN_BOSS, function(arg_30_0, arg_30_1)
		local var_30_0 = arg_25_0.missionBossPage

		var_2.ExecuteAction(var_30_0, "Show", arg_30_1)

		return
	end)
	arg_25_0:bind(var_0_1.ON_OPEN_BOSS_FORMATION, function(arg_31_0, arg_31_1)
		local var_31_0 = arg_25_0.missBossForamtionPage

		var_2.ExecuteAction(var_31_0, "Show", arg_25_0.guildVO, arg_25_0.player, {
			mission = arg_31_1
		})

		return
	end)
	arg_25_0:bind(var_0_1.OPEN_BOSS_ASSULT, function()
		local var_32_0 = arg_25_0.showAssultShipPage

		var_0.ExecuteAction(var_32_0, "Show", arg_25_0.guildVO, arg_25_0.player)

		return
	end)
	arg_25_0:bind(var_0_1.SHOW_SHIP_EQUIPMENTS, function(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
		local var_33_0 = arg_25_0.shipEquipmentsPage

		var_4.ExecuteAction(var_33_0, "Show", arg_33_1, arg_33_2, arg_33_3)

		return
	end)

	GuildEventPage = var_1
	arg_25_0.eventPage = var_1.New(arg_25_0._tf, arg_25_0.event, arg_25_0.contextData)
	GuildEventInfoPage = var_1
	arg_25_0.eventInfoPage = var_1.New(arg_25_0._tf, arg_25_0.event, arg_25_0.contextData)
	GuildEventFormationPage = var_1
	arg_25_0.formationPage = var_1.New(arg_25_0._tf, arg_25_0.event, arg_25_0.contextData)
	GuildMissionInfoPage = var_1
	arg_25_0.missionInfoPage = var_1.New(arg_25_0._tf, arg_25_0.event, arg_25_0.contextData)
	GuildMissionFormationPage = var_1
	arg_25_0.missionFormationPage = var_1.New(arg_25_0._tf, arg_25_0.event, arg_25_0.contextData)
	GuildMissionBossPage = var_1
	arg_25_0.missionBossPage = var_1.New(arg_25_0._tf, arg_25_0.event, arg_25_0.contextData)
	GuildMissionBossFormationPage = var_1
	arg_25_0.missBossForamtionPage = var_1.New(arg_25_0._tf, arg_25_0.event, arg_25_0.contextData)
	GuildShowAssultShipPage = var_1
	arg_25_0.showAssultShipPage = var_1.New(arg_25_0._tf, arg_25_0.event, arg_25_0.contextData)
	GuildShipEquipmentsPage = var_1
	arg_25_0.shipEquipmentsPage = var_1.New(arg_25_0._tf, arg_25_0.event, arg_25_0.contextData)

	local var_25_0 = arg_25_0._tf

	arg_25_0.helpBtn = var_1.Find(var_25_0, "frame/help")

	return
end

function var_0_1.didEnter(arg_34_0)
	getProxy = var_1_10001
	GuildProxy = var_1_10002

	local var_34_0 = var_1_10001(var_1_10002)

	var_1.SetBattleBtnRecord(var_34_0)

	onButton = var_1

	local var_34_1 = arg_34_0
	local var_34_2 = arg_34_0.helpBtn

	local function var_34_3()
		pg = var_2_10000

		local var_35_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_35_1 = var_0.ShowMsgBox
		local var_35_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_35_2.type = var_2_10003
		pg = var_2_10003
		var_35_2.helps = var_2_10003.gametip.guild_event_help_tip.tip

		var_35_1(var_35_0, var_35_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_34_1, var_34_2, var_34_3, var_1_10005)
	arg_34_0:EnterEvent()
	arg_34_0:TryPlayGuide()

	return
end

function var_0_1.TryPlayGuide(arg_36_0)
	pg = var_1_10001

	local var_36_0 = var_1_10001.SystemGuideMgr.GetInstance()

	var_1.PlayGuildAssaultFleet(var_36_0)

	return
end

function var_0_1.EnterEvent(arg_37_0)
	if not arg_37_0:isLoaded() then
		return
	end

	local var_37_1

	if arg_37_0.activeEvent then
		local var_37_0 = arg_37_0.activeEvent

		var_37_1 = var_1.GetBossMission(var_37_0)
	end

	if arg_37_0.activeEvent and var_37_1 and var_37_1:IsActive() and not var_37_1:IsDeath() then
		local var_37_2 = arg_37_0.activeEvent

		if var_2.IsParticipant(var_37_2) then
			local var_37_3 = arg_37_0.missionBossPage

			var_2.ExecuteAction(var_37_3, "Show", var_37_1)

			goto label_37_0
		end
	end

	do
		local var_37_4 = arg_37_0.eventPage

		var_2.ExecuteAction(var_37_4, "Show", arg_37_0.guildVO, arg_37_0.player, arg_37_0.events)
	end

	::label_37_0::

	if arg_37_0.missionBossPage then
		local var_37_5 = arg_37_0.missionBossPage

		if var_2.GetLoaded(var_37_5) and not arg_37_0.activeEvent then
			local var_37_6 = arg_37_0.missionBossPage

			var_2.Destroy(var_37_6)

			arg_37_0.missionBossPage = nil
		end
	end

	if arg_37_0.activeEvent and arg_37_0.eventInfoPage then
		local var_37_7 = arg_37_0.eventInfoPage

		if var_2.GetLoaded(var_37_7) then
			local var_37_8 = arg_37_0.activeEvent

			if var_2.IsParticipant(var_37_8) then
				local var_37_9 = arg_37_0.eventInfoPage

				var_2.Destroy(var_37_9)

				arg_37_0.eventInfoPage = nil
			end
		end
	end

	return
end

function var_0_1.OnEventEnd(arg_38_0)
	arg_38_0:EnterEvent()

	return
end

function var_0_1.onBackPressed(arg_39_0)
	pg = var_1_10001

	local var_39_0 = var_1_10001.CriMgr.GetInstance()
	local var_39_1 = var_1.PlaySoundEffect_V3

	SFX_CANCEL = var_1_10003

	var_39_1(var_39_0, var_1_10003)
	arg_39_0:emit(var_0_1.ON_BACK)

	return
end

function var_0_1.willExit(arg_40_0)
	if arg_40_0.eventInfoPage then
		local var_40_0 = arg_40_0.eventInfoPage

		var_1.Destroy(var_40_0)
	end

	local var_40_1 = arg_40_0.missBossForamtionPage

	var_1.Destroy(var_40_1)

	local var_40_2 = arg_40_0.formationPage

	var_1.Destroy(var_40_2)

	local var_40_3 = arg_40_0.missionFormationPage

	var_1.Destroy(var_40_3)

	local var_40_4 = arg_40_0.missionInfoPage

	var_1.Destroy(var_40_4)

	local var_40_5 = arg_40_0.showAssultShipPage

	var_1.Destroy(var_40_5)

	local var_40_6 = arg_40_0.eventPage

	var_1.Destroy(var_40_6)

	local var_40_7 = arg_40_0.shipEquipmentsPage

	var_1.Destroy(var_40_7)

	if arg_40_0.missionBossPage then
		var_40_7 = arg_40_0.missionBossPage

		var_1.Destroy(var_40_7)
	end

	isActive = var_1
	pg = var_40_7

	if var_1(var_40_7.MsgboxMgr.GetInstance()._go) then
		triggerButton = var_1
		pg = var_2

		var_1(var_2.MsgboxMgr.GetInstance()._closeBtn)
	end

	return
end

return var_0_1

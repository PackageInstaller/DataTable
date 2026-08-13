class = var_0_10000

local var_0_0 = "ActivityBossMediatorTemplate"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

var_0_1.ON_SUBMIT_TASK = "ActivityBossMediatorTemplate ON_SUBMIT_TASK"
var_0_1.ON_RANK = "ActivityBossMediatorTemplate ON_RANK"
var_0_1.ON_PRECOMBAT = "ActivityBossMediatorTemplate ON_PRECOMBAT"
var_0_1.ON_EX_PRECOMBAT = "ActivityBossMediatorTemplate ON_EX_PRECOMBAT"
var_0_1.ON_SP_PRECOMBAT = "ActivityBossMediatorTemplate ON_SP_PRECOMBAT"
var_0_1.ON_COMMIT_FLEET = "ActivityBossMediatorTemplate ON_COMMIT_FLEET"
var_0_1.ON_FLEET_RECOMMEND = "ActivityBossMediatorTemplate ON_FLEET_RECOMMEND"
var_0_1.ON_FLEET_CLEAR = "ActivityBossMediatorTemplate ON_FLEET_CLEAR"
var_0_1.ON_OPEN_DOCK = "ActivityBossMediatorTemplate ON_OPEN_DOCK"
var_0_1.ON_FLEET_SHIPINFO = "ActivityBossMediatorTemplate ON_FLEET_SHIPINFO"
var_0_1.ON_SELECT_COMMANDER = "ActivityBossMediatorTemplate ON_SELECT_COMMANDER"
var_0_1.ON_PERFORM_COMBAT = "ActivityBossMediatorTemplate ON_PERFORM_COMBAT"
var_0_1.ONEN_BUFF_SELECT = "ActivityBossMediatorTemplate ONEN_BUFF_SELECT"
var_0_1.COMMANDER_FORMATION_OP = "ActivityBossMediatorTemplate COMMANDER_FORMATION_OP"
var_0_1.ON_COMMANDER_SKILL = "ActivityBossMediatorTemplate ON_COMMANDER_SKILL"

local var_0_2 = {
	"word_easy",
	"word_normal_junhe",
	"word_hard"
}

function var_0_1.GetPairedFleetIndex(arg_1_0)
	Fleet = var_1_10001

	if arg_1_0 < var_1_10001.SUBMARINE_FLEET_ID then
		return arg_1_0 + 10
	else
		return arg_1_0 - 10
	end

	return
end

function var_0_1.register(arg_2_0)
	local var_2_0 = arg_2_0.contextData

	var_2_0.mediatorClass = arg_2_0.class
	getProxy = var_2_0
	ActivityProxy = var_2
	arg_2_0.activityProxy = var_2_0(var_2)
	pg = var_1
	arg_2_0.timeMgr = var_1.TimeMgr.GetInstance()

	local var_2_1 = arg_2_0.activityProxy
	local var_2_2 = var_1.getActivityByType

	ActivityConst = var_1_10003

	if not var_2_2(var_2_1, var_1_10003.ACTIVITY_TYPE_BOSS_BATTLE_MARK_2) then
		return
	end

	local var_2_3 = arg_2_0

	arg_2_0.BindEvent(var_2_3)

	getProxy = var_2
	FleetProxy = var_2_3

	local var_2_4 = var_2(var_2_3)

	arg_2_0:UpdateActivityData(var_1)

	arg_2_0.contextData.activityID = var_1 and var_1.id

	local var_2_5 = var_1:GetBossConfig()

	arg_2_0.contextData.TicketID = var_2_5:GetTicketID()
	arg_2_0.contextData.exStageID = var_2_5:GetEXStageID()
	arg_2_0.contextData.normalStageIDs = var_2_5:GetNormalStageIDs()
	arg_2_0.contextData.ticketInitPools = var_2_5:GetInitTicketPools()
	arg_2_0.contextData.useOilLimit = var_2_5:GetOilLimits()
	arg_2_0.contextData.DisplayItems = var_2_5:GetMilestoneRewards()
	arg_2_0.contextData.spStageID = var_2_5:GetSPStageID()

	arg_2_0:RequestAndUpdateView()

	local var_2_6 = var_2_4:getActivityFleets()[var_1.id]

	arg_2_0.contextData.actFleets = var_2_6

	local var_2_7 = var_1:GetBindPtActID()

	arg_2_0.contextData.ptActId = var_2_7

	local var_2_8 = arg_2_0.activityProxy

	if var_7.getActivityById(var_2_8, var_2_7) then
		var_2_8 = arg_2_0.contextData
		ActivityBossPtData = var_9
		var_2_8.ptData = var_9.New(var_7)
	else
		errorMsg = var_2_8

		var_2_8("没有找到当期BossPT活动 activity_event_pt link_id 未找到id: " .. var_1.id)
	end

	local var_2_9 = arg_2_0.activityProxy
	local var_2_10 = var_8.getActivityByType

	ActivityConst = var_1_10010

	local var_2_11

	if var_2_10(var_2_9, var_1_10010.ACTIVITY_TYPE_BOSS_RANK) then
		var_2_11 = var_8

		if not var_8.isEnd(var_2_11) then
			getProxy = var_2_9
			BillboardProxy = var_2_11
			var_2_9 = var_2_9(var_2_11)
			PowerRank = var_2_11
			var_2_11 = var_2_11.TYPE_ACT_BOSS_BATTLE

			local var_2_12 = var_8.id

			if var_2_9:canFetch(var_2_11, var_2_12) then
				local var_2_13 = arg_2_0
				local var_2_14 = arg_2_0.sendNotification

				GAME = var_14

				var_2_14(var_2_13, var_14.GET_POWERRANK, {
					type = var_2_11,
					activityId = var_2_12
				})
			else
				local var_2_15 = var_2_9:getRankList(var_2_11, var_2_12)

				arg_2_0:UpdateRankData(var_2_15)
			end
		end
	end

	getProxy = var_2_9
	CommanderProxy = var_2_11

	local var_2_16 = var_2_9(var_2_11)
	local var_2_17 = var_9.getPrefabFleet(var_2_16)
	local var_2_18 = arg_2_0.viewComponent

	var_10.setCommanderPrefabs(var_2_18, var_2_17)

	pg = var_10

	local var_2_19 = var_10.GuildMsgBoxMgr.GetInstance()

	var_10.NotificationForBattle(var_2_19)

	return
end

function var_0_1.BindEvent(arg_3_0)
	getProxy = var_1_10001
	FleetProxy = var_1_10002

	local var_3_0 = var_1_10001(var_1_10002)
	local var_3_1 = arg_3_0.activityProxy
	local var_3_2 = var_2.getActivityByType

	ActivityConst = var_1_10004

	local var_3_3 = var_3_2(var_3_1, var_1_10004.ACTIVITY_TYPE_BOSS_BATTLE_MARK_2)

	assert = var_3_1

	var_3_1(var_3_3)
	arg_3_0:bind(var_0_1.ON_RANK, function(arg_4_0)
		local var_4_0 = arg_3_0
		local var_4_1 = var_1.sendNotification

		GAME = var_2_10003

		local var_4_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		local var_4_3 = var_2_10004.BILLBOARD
		local var_4_4 = {}

		PowerRank = var_2_10006
		var_4_4.index = var_2_10006.TYPE_ACT_BOSS_BATTLE

		var_4_1(var_4_0, var_4_2, var_4_3, var_4_4)

		return
	end)

	local var_3_4 = arg_3_0
	local var_3_5 = arg_3_0.bind

	ActivityMediator = var_5

	var_3_5(var_3_4, var_5.EVENT_PT_OPERATION, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_3_0
		local var_5_1 = var_2.sendNotification

		GAME = var_2_10004

		var_5_1(var_5_0, var_2_10004.ACT_NEW_PT, arg_5_1)

		return
	end)
	arg_3_0:bind(var_0_1.ON_SUBMIT_TASK, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_3_0
		local var_6_1 = var_2.sendNotification

		GAME = var_2_10004

		var_6_1(var_6_0, var_2_10004.SUBMIT_TASK, arg_6_1)

		return
	end)
	arg_3_0:bind(var_0_1.ON_PRECOMBAT, function(arg_7_0, arg_7_1)
		local var_7_0 = var_3_0

		if not var_2.getActivityFleets(var_7_0)[var_3_3.id] then
			pg = var_3

			local var_7_1 = var_3.TipsMgr.GetInstance()
			local var_7_2 = var_3.ShowTips

			i18n = var_2_10005

			var_7_2(var_7_1, var_2_10005("elite_disable_no_fleet"))

			return
		end

		local var_7_3 = var_2[arg_7_1]

		var_3.RemoveUnusedItems(var_7_3)

		local var_7_4 = var_2[arg_7_1]

		if var_3.isLegalToFight(var_7_4) ~= true then
			pg = var_3

			local var_7_5 = var_3.TipsMgr.GetInstance()
			local var_7_6 = var_3.ShowTips

			i18n = var_2_10005

			var_7_6(var_7_5, var_2_10005("elite_disable_formation_unsatisfied"))

			return
		end

		local var_7_7 = var_2[arg_7_1 + 10]

		var_3.RemoveUnusedItems(var_7_7)

		local var_7_8 = {
			var_2[arg_7_1],
			var_2[arg_7_1 + 10]
		}
		local var_7_9 = var_3_3.id

		_ = var_2_10005

		if var_2_10005.any(var_7_8, function(arg_8_0)
			local var_8_0, var_8_1 = arg_8_0:HaveShipsInEvent()

			if var_8_0 then
				pg = var_3_10003

				local var_8_2 = var_3_10003.TipsMgr.GetInstance()

				var_3_10003.ShowTips(var_8_2, var_8_1)

				return true
			end

			_ = var_3_10003

			return var_3_10003.any(arg_8_0:getShipIds(), function(arg_9_0)
				getProxy = var_4_10001
				BayProxy = var_4_10002

				local var_9_0 = var_4_10001(var_4_10002)

				if not var_1.RawGetShipById(var_9_0, arg_9_0) then
					return
				end

				ShipStatus = var_9_0

				local var_9_1, var_9_2 = var_9_0.ShipStatusCheck("inActivity", var_1, nil, {
					inActivity = var_7_9
				})

				if not var_9_1 then
					pg = var_4

					local var_9_3 = var_4.TipsMgr.GetInstance()

					var_4.ShowTips(var_9_3, var_9_2)

					return true
				end

				return
			end)
		end) then
			return
		end

		local var_7_10
		local var_7_11

		SYSTEM_ACT_BOSS = var_7_10

		local var_7_12 = arg_3_0.contextData.normalStageIDs[arg_7_1]
		local var_7_13 = arg_3_0.contextData.useOilLimit[arg_7_1]
		local var_7_14 = arg_3_0.contextData.activity

		if not var_8.IsOilLimit(var_7_14, var_7_12) then
			var_7_13 = {
				0,
				0
			}
		end

		local var_7_15 = arg_3_0
		local var_7_16 = var_9.addSubLayers

		Context = var_2_10011

		local var_7_17 = var_2_10011.New
		local var_7_18 = {}

		ActivityBossPreCombatMediator = var_2_10013
		var_7_18.mediator = var_2_10013
		ActivityBossPreCombatLayer = var_2_10013
		var_7_18.viewComponent = var_2_10013
		var_7_18.data = {
			system = var_7_10,
			stageId = var_7_12,
			actId = var_3_3.id,
			fleets = var_7_8,
			costLimit = var_7_13,
			OnConfirm = function(arg_10_0)
				local var_10_0 = arg_3_0.contextData.activity
				local var_10_1

				if not var_1.checkBattleTimeInBossAct(var_10_0) then
					pg = var_10_1
					var_10_0 = var_10_1.TipsMgr.GetInstance()
					var_10_1 = var_10_1.ShowTips
					i18n = var_3_10003

					var_10_1(var_10_0, var_3_10003("common_activity_end"))

					return
				end

				getProxy = var_10_1
				SettingsProxy = var_10_0

				local var_10_2 = var_10_1(var_10_0)
				local var_10_3 = var_1.isTipActBossExchangeTicket(var_10_2)

				getProxy = var_10_2
				PlayerProxy = var_3_10003

				local var_10_4 = var_10_2(var_3_10003)
				local var_10_5 = var_2.getRawData(var_10_4)
				local var_10_6 = var_2.getResource(var_10_5, arg_3_0.contextData.TicketID)

				if 0 < var_10_6 then
					local var_10_7

					if not arg_3_0.contextData.stageTickets[var_7_12] then
						var_10_7 = 0
					end

					local var_10_8

					if not (var_10_7 <= 0) then
						var_10_8 = false
					else
						var_10_8 = true
					end

					if var_10_3 == nil and var_10_8 then
						Drop = var_3

						local var_10_9 = var_3.New
						local var_10_10 = {}

						DROP_TYPE_RESOURCE = var_3_10005
						var_10_10.type = var_3_10005

						local var_10_11

						if not arg_3_0.contextData.TicketID then
							var_10_11 = 1
						end

						var_10_10.id = var_10_11

						local var_10_12 = var_10_9(var_10_10)
						local var_10_13 = var_3.getIcon(var_10_12)

						pg = var_10_12

						local var_10_14 = var_10_12.MsgboxMgr.GetInstance()
						local var_10_15 = var_4.ShowMsgBox

						var_3_10006 = {
							noText = "text_inconsume",
							hideYes = true
						}
						i18n = var_3_10007

						local var_10_16 = "tip_exchange_ticket"

						i18n = var_3_10009
						var_3_10006.content = var_3_10007(var_10_16, var_3_10009(var_0_2[arg_7_1]))

						local var_10_17 = {}
						local var_10_18 = {
							text = "text_consume"
						}

						SFX_CONFIRM = var_9
						var_10_18.sound = var_9

						function var_10_18.onCallback()
							getProxy = var_4_10000
							SettingsProxy = var_4_10001

							local var_11_0 = var_4_10000(var_4_10001)

							var_0.setActBossExchangeTicketTip(var_11_0, 1)

							arg_3_0.contextData.ready2battleCb = arg_10_0

							local var_11_1 = arg_3_0
							local var_11_2 = var_0.sendNotification

							GAME = var_2

							var_11_2(var_11_1, var_2.ACT_BOSS_EXCHANGE_TICKET, {
								stageId = var_7_12
							})

							return
						end

						pg = var_9
						var_10_18.btnType = var_9.MsgboxMgr.BUTTON_BLUE_WITH_ICON
						var_10_18.iconName = {
							var_10_13
						}
						var_10_17[1] = var_10_18
						var_3_10006.custom = var_10_17

						function var_3_10006.onNo()
							getProxy = var_4_10000
							SettingsProxy = var_4_10001

							local var_12_0 = var_4_10000(var_4_10001)

							var_0.setActBossExchangeTicketTip(var_12_0, 0)
							arg_10_0()

							return
						end

						function var_3_10006.onClose()
							return
						end

						var_10_15(var_10_14, var_3_10006)
					else
						local var_10_19 = var_10_3 == 1

						if var_10_8 and var_10_19 then
							arg_3_0.contextData.ready2battleCb = arg_10_0

							local var_10_20 = arg_3_0
							local var_10_21 = var_4.sendNotification

							GAME = var_3_10006

							var_10_21(var_10_20, var_3_10006.ACT_BOSS_EXCHANGE_TICKET, {
								stageId = var_7_12
							})
						else
							arg_10_0()
						end
					end

					return
				end
			end
		}

		function var_7_18.onRemoved()
			local var_14_0 = arg_3_0.viewComponent

			var_0.updateEditPanel(var_14_0)

			return
		end

		var_7_16(var_7_15, var_7_17(var_7_18))

		return
	end)
	arg_3_0:bind(var_0_1.ON_EX_PRECOMBAT, function(arg_15_0, arg_15_1, arg_15_2)
		local var_15_0 = var_3_0

		if not var_3.getActivityFleets(var_15_0)[var_3_3.id] then
			pg = var_4

			local var_15_1 = var_4.TipsMgr.GetInstance()
			local var_15_2 = var_4.ShowTips

			i18n = var_2_10006

			var_15_2(var_15_1, var_2_10006("elite_disable_no_fleet"))

			return
		end

		local var_15_3 = var_3[arg_15_1]

		var_4.RemoveUnusedItems(var_15_3)

		local var_15_4 = var_3[arg_15_1]

		if var_4.isLegalToFight(var_15_4) ~= true then
			pg = var_4

			local var_15_5 = var_4.TipsMgr.GetInstance()
			local var_15_6 = var_4.ShowTips

			i18n = var_2_10006

			var_15_6(var_15_5, var_2_10006("elite_disable_formation_unsatisfied"))

			return
		end

		local var_15_7 = var_3[arg_15_1 + 10]

		var_4.RemoveUnusedItems(var_15_7)

		local var_15_8 = {
			var_3[arg_15_1],
			var_3[arg_15_1 + 10]
		}
		local var_15_9 = var_3_3.id

		_ = var_2_10006

		if var_2_10006.any(var_15_8, function(arg_16_0)
			local var_16_0, var_16_1 = arg_16_0:HaveShipsInEvent()

			if var_16_0 then
				pg = var_3_10003

				local var_16_2 = var_3_10003.TipsMgr.GetInstance()

				var_3_10003.ShowTips(var_16_2, var_16_1)

				return true
			end

			_ = var_3_10003

			return var_3_10003.any(arg_16_0:getShipIds(), function(arg_17_0)
				getProxy = var_4_10001
				BayProxy = var_4_10002

				local var_17_0 = var_4_10001(var_4_10002)

				if not var_1.RawGetShipById(var_17_0, arg_17_0) then
					return
				end

				ShipStatus = var_17_0

				local var_17_1, var_17_2 = var_17_0.ShipStatusCheck("inActivity", var_1, nil, {
					inActivity = var_15_9
				})

				if not var_17_1 then
					pg = var_4

					local var_17_3 = var_4.TipsMgr.GetInstance()

					var_4.ShowTips(var_17_3, var_17_2)

					return true
				end

				return
			end)
		end) then
			return
		end

		seriesAsync = var_6

		var_6({
			function(arg_18_0)
				local var_18_0 = "NG0017"

				if not arg_15_2 then
					pg = var_2

					local var_18_1 = var_2.NewStoryMgr.GetInstance()

					if not var_2.IsPlayed(var_18_1, var_18_0) then
						pg = var_2

						local var_18_2 = var_2.MsgboxMgr.GetInstance()
						local var_18_3 = var_2.ShowMsgBox
						local var_18_4 = {
							hideYes = false,
							showStopRemind = true,
							hideNo = false
						}

						pg = var_3_10005
						var_18_4.helps = var_3_10005.gametip.worldbossex_help.tip
						MSGBOX_TYPE_HELP = var_5
						var_18_4.type = var_5
						i18n = var_5
						var_18_4.stopRamindContent = var_5("dont_remind")

						function var_18_4.onYes()
							pg = var_4_10000

							if var_4_10000.MsgboxMgr.GetInstance().stopRemindToggle.isOn then
								pg = var_4_10001

								local var_19_0 = var_4_10001.m02
								local var_19_1 = var_1.sendNotification

								GAME = var_4_10003

								var_19_1(var_19_0, var_4_10003.STORY_UPDATE, {
									storyId = var_18_0
								})
							end

							arg_18_0()

							return
						end

						function var_18_4.onNo()
							pg = var_4_10000

							if var_4_10000.MsgboxMgr.GetInstance().stopRemindToggle.isOn then
								pg = var_4_10001

								local var_20_0 = var_4_10001.m02
								local var_20_1 = var_1.sendNotification

								GAME = var_4_10003

								var_20_1(var_20_0, var_4_10003.STORY_UPDATE, {
									storyId = var_18_0
								})
							end

							return
						end

						var_18_3(var_18_2, var_18_4)

						goto label_18_0
					end
				end

				arg_18_0()

				::label_18_0::

				return
			end,
			function(arg_21_0)
				local var_21_0
				local var_21_1

				if arg_15_2 then
					SYSTEM_BOSS_EXPERIMENT = var_3

					if not var_3 then
						::label_21_0::

						SYSTEM_HP_SHARE_ACT_BOSS = var_21_0
					end

					local var_21_2 = arg_3_0.contextData.exStageID
					local var_21_3 = arg_3_0.contextData.useOilLimit[4]
					local var_21_4 = arg_3_0.contextData.activity

					if not var_4.IsOilLimit(var_21_4, var_21_2) then
						var_21_3 = {
							0,
							0
						}
					end

					local var_21_5 = arg_3_0
					local var_21_6 = var_5.addSubLayers

					Context = var_3_10007

					local var_21_7 = var_3_10007.New
					local var_21_8 = {}

					ActivityBossPreCombatMediator = var_3_10009
					var_21_8.mediator = var_3_10009
					ActivityBossPreCombatLayer = var_3_10009
					var_21_8.viewComponent = var_3_10009
					var_21_8.data = {
						system = var_21_0,
						stageId = var_21_2,
						actId = var_3_3.id,
						fleets = var_15_8,
						costLimit = var_21_3,
						OnConfirm = function(arg_22_0)
							local var_22_0 = arg_3_0.contextData.activity

							if not var_1.checkBattleTimeInBossAct(var_22_0) then
								pg = var_1

								local var_22_1 = var_1.TipsMgr.GetInstance()
								local var_22_2 = var_1.ShowTips

								i18n = var_4_10003

								var_22_2(var_22_1, var_4_10003("common_activity_end"))

								return
							end

							arg_22_0()

							return
						end
					}

					var_21_6(var_21_5, var_21_7(var_21_8))

					return
				end
			end
		})

		return
	end)
	arg_3_0:bind(var_0_1.ON_SP_PRECOMBAT, function(arg_23_0, arg_23_1)
		local var_23_0 = var_3_0

		if not var_2.getActivityFleets(var_23_0)[var_3_3.id] then
			pg = var_3

			local var_23_1 = var_3.TipsMgr.GetInstance()
			local var_23_2 = var_3.ShowTips

			i18n = var_2_10005

			var_23_2(var_23_1, var_2_10005("elite_disable_no_fleet"))

			return
		end

		local var_23_3 = var_2[arg_23_1]

		var_3.RemoveUnusedItems(var_23_3)

		local var_23_4 = var_2[arg_23_1]

		if var_3.isLegalToFight(var_23_4) ~= true then
			pg = var_3

			local var_23_5 = var_3.TipsMgr.GetInstance()
			local var_23_6 = var_3.ShowTips

			i18n = var_2_10005

			var_23_6(var_23_5, var_2_10005("elite_disable_formation_unsatisfied"))

			return
		end

		local var_23_7 = var_2[arg_23_1 + 10]

		var_3.RemoveUnusedItems(var_23_7)

		local var_23_8 = {
			var_2[arg_23_1],
			var_2[arg_23_1 + 10]
		}
		local var_23_9 = var_3_3.id

		_ = var_2_10005

		if var_2_10005.any(var_23_8, function(arg_24_0)
			local var_24_0, var_24_1 = arg_24_0:HaveShipsInEvent()

			if var_24_0 then
				pg = var_3_10003

				local var_24_2 = var_3_10003.TipsMgr.GetInstance()

				var_3_10003.ShowTips(var_24_2, var_24_1)

				return true
			end

			_ = var_3_10003

			return var_3_10003.any(arg_24_0:getShipIds(), function(arg_25_0)
				getProxy = var_4_10001
				BayProxy = var_4_10002

				local var_25_0 = var_4_10001(var_4_10002)

				if not var_1.RawGetShipById(var_25_0, arg_25_0) then
					return
				end

				ShipStatus = var_25_0

				local var_25_1, var_25_2 = var_25_0.ShipStatusCheck("inActivity", var_1, nil, {
					inActivity = var_23_9
				})

				if not var_25_1 then
					pg = var_4

					local var_25_3 = var_4.TipsMgr.GetInstance()

					var_4.ShowTips(var_25_3, var_25_2)

					return true
				end

				return
			end)
		end) then
			return
		end

		seriesAsync = var_5

		var_5({
			function(arg_26_0)
				local var_26_0
				local var_26_1

				SYSTEM_ACT_BOSS_SP = var_26_0

				local var_26_2 = arg_3_0.contextData.spStageID
				local var_26_3 = {
					0,
					0
				}
				local var_26_4 = arg_3_0
				local var_26_5 = var_4.addSubLayers

				Context = var_3_10006

				local var_26_6 = var_3_10006.New
				local var_26_7 = {}

				ActivityBossPreCombatMediator = var_3_10008
				var_26_7.mediator = var_3_10008
				ActivityBossPreCombatLayer = var_3_10008
				var_26_7.viewComponent = var_3_10008
				var_26_7.data = {
					system = var_26_0,
					stageId = var_26_2,
					actId = var_3_3.id,
					fleets = var_23_8,
					costLimit = var_26_3,
					OnConfirm = function(arg_27_0)
						local var_27_0 = arg_3_0.contextData.activity

						if not var_1.checkBattleTimeInBossAct(var_27_0) then
							pg = var_1

							local var_27_1 = var_1.TipsMgr.GetInstance()
							local var_27_2 = var_1.ShowTips

							i18n = var_4_10003

							var_27_2(var_27_1, var_4_10003("common_activity_end"))

							return
						end

						arg_27_0()

						return
					end
				}

				var_26_5(var_26_4, var_26_6(var_26_7))

				return
			end
		})

		return
	end)
	arg_3_0:bind(var_0_1.ON_COMMIT_FLEET, function()
		local var_28_0 = var_3_0

		var_0.commitActivityFleet(var_28_0, var_3_3.id)

		return
	end)
	arg_3_0:bind(var_0_1.ON_FLEET_RECOMMEND, function(arg_29_0, arg_29_1)
		local var_29_0 = var_3_0

		var_2.recommendActivityFleet(var_29_0, var_3_3.id, arg_29_1)

		local var_29_1 = var_3_0
		local var_29_2 = var_2.getActivityFleets(var_29_1)[var_3_3.id]

		arg_3_0.contextData.actFleets = var_29_2

		local var_29_3 = arg_3_0.viewComponent

		var_4.updateEditPanel(var_29_3)

		return
	end)
	arg_3_0:bind(var_0_1.ON_FLEET_CLEAR, function(arg_30_0, arg_30_1)
		local var_30_0 = var_3_0
		local var_30_1 = var_2.getActivityFleets(var_30_0)[var_3_3.id][arg_30_1]

		var_3.clearFleet(var_30_1)

		local var_30_2 = var_3_0

		var_4.updateActivityFleet(var_30_2, var_3_3.id, arg_30_1, var_3)

		arg_3_0.contextData.actFleets = var_2

		local var_30_3 = arg_3_0.viewComponent

		var_4.updateEditPanel(var_30_3)

		return
	end)
	arg_3_0:bind(var_0_1.ON_OPEN_DOCK, function(arg_31_0, arg_31_1)
		local var_31_0 = arg_31_1.fleetIndex
		local var_31_1 = arg_31_1.shipVO
		local var_31_2 = arg_31_1.fleet
		local var_31_3 = arg_31_1.teamType
		local var_31_4, var_31_5, var_31_6 = arg_3_0.getDockCallbackFuncs4ActicityFleet(var_31_1, var_31_0, var_31_3)
		local var_31_7 = arg_3_0
		local var_31_8 = var_9.sendNotification

		GAME = var_2_10011

		local var_31_9 = var_2_10011.GO_SCENE

		SCENE = var_2_10012

		local var_31_10 = var_2_10012.DOCKYARD
		local var_31_11 = {
			selectedMin = 0,
			useBlackBlock = true,
			selectedMax = 1
		}

		i18n = var_2_10014
		var_31_11.leastLimitMsg = var_2_10014("ship_formationMediator_leastLimit")
		var_31_11.quitTeam = var_31_1 ~= nil
		var_31_11.teamFilter = var_31_3
		i18n = var_14
		var_31_11.leftTopInfo = var_14("word_formation")
		var_31_11.onShip = var_31_4
		var_31_11.confirmSelect = var_31_5
		var_31_11.onSelected = var_31_6
		setmetatable = var_14

		local var_31_12 = {
			inActivity = var_3_3.id
		}
		local var_31_13 = {}

		ShipStatus = var_2_10017
		var_31_13.__index = var_2_10017.TAG_HIDE_ACTIVITY_BOSS
		var_31_11.hideTagFlags = var_14(var_31_12, var_31_13)
		var_31_11.otherSelectedIds = var_31_2
		pg = var_14

		local var_31_14 = var_14.ShipFlagMgr.GetInstance()

		var_31_11.ignoredIds = var_14.FilterShips(var_31_14, {
			isActivityNpc = true
		})

		var_31_8(var_31_7, var_31_9, var_31_10, var_31_11)

		return
	end)
	arg_3_0:bind(var_0_1.ON_FLEET_SHIPINFO, function(arg_32_0, arg_32_1)
		local var_32_0 = arg_3_0
		local var_32_1 = var_2.sendNotification

		GAME = var_2_10004

		local var_32_2 = var_2_10004.GO_SCENE

		SCENE = var_2_10005

		var_32_1(var_32_0, var_32_2, var_2_10005.SHIPINFO, {
			shipId = arg_32_1.shipId,
			shipVOs = arg_32_1.shipVOs
		})

		return
	end)
	arg_3_0:bind(var_0_1.COMMANDER_FORMATION_OP, function(arg_33_0, arg_33_1)
		local var_33_0 = arg_3_0
		local var_33_1 = var_2.sendNotification

		GAME = var_2_10004

		var_33_1(var_33_0, var_2_10004.COMMANDER_FORMATION_OP, {
			data = arg_33_1
		})

		return
	end)
	arg_3_0:bind(var_0_1.ON_COMMANDER_SKILL, function(arg_34_0, arg_34_1)
		local var_34_0 = arg_3_0
		local var_34_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_34_2 = var_2_10004.New
		local var_34_3 = {}

		CommanderSkillMediator = var_2_10006
		var_34_3.mediator = var_2_10006
		CommanderSkillLayer = var_2_10006
		var_34_3.viewComponent = var_2_10006
		var_34_3.data = {
			skill = arg_34_1
		}

		var_34_1(var_34_0, var_34_2(var_34_3))

		return
	end)
	arg_3_0:bind(var_0_1.ON_SELECT_COMMANDER, function(arg_35_0, arg_35_1, arg_35_2)
		local var_35_0 = var_3_0
		local var_35_1 = var_3.getActivityFleets(var_35_0)[var_3_3.id][arg_35_1]
		local var_35_2 = var_4.getCommanders(var_35_1)
		local var_35_3 = arg_3_0
		local var_35_4 = var_6.sendNotification

		GAME = var_2_10008

		local var_35_5 = var_2_10008.GO_SCENE

		SCENE = var_2_10009

		local var_35_6 = var_2_10009.COMMANDERCAT
		local var_35_7 = {
			maxCount = 1
		}

		CommanderCatScene = var_2_10011
		var_35_7.mode = var_2_10011.MODE_SELECT
		var_35_7.activeCommander = var_35_2[arg_35_2]
		CommanderCatScene = var_11
		var_35_7.fleetType = var_11.FLEET_TYPE_ACTBOSS
		var_35_7.ignoredIds = {}

		function var_35_7.onCommander(arg_36_0)
			return true
		end

		function var_35_7.onSelected(arg_37_0, arg_37_1)
			local var_37_0 = arg_37_0[1]

			getProxy = var_3_10003
			CommanderProxy = var_3_10004

			local var_37_1 = var_3_10003(var_3_10004)
			local var_37_2 = var_3.getCommanderById(var_37_1, var_37_0)

			pairs = var_37_1

			for iter_37_0, iter_37_1 in var_37_1(var_0) do
				if iter_37_0 == arg_35_1 then
					pairs = var_10

					for iter_37_2, iter_37_3 in var_10(var_35_2) do
						if iter_37_3.groupId == var_37_2.groupId and iter_37_2 ~= arg_35_2 then
							pg = var_15

							local var_37_3 = var_15.TipsMgr.GetInstance()
							local var_37_4 = var_15.ShowTips

							i18n = var_3_10017

							var_37_4(var_37_3, var_3_10017("commander_can_not_select_same_group"))

							return
						end
					end
				elseif iter_37_0 == var_0_1.GetPairedFleetIndex(arg_35_1) then
					local var_37_5 = iter_37_1
					local var_37_6 = iter_37_1.getCommanders(var_37_5)

					pairs = var_37_5

					for iter_37_4, iter_37_5 in var_37_5(var_37_6) do
						if var_37_0 == iter_37_5.id then
							pg = var_16
							var_3_10017 = var_16.TipsMgr.GetInstance()

							local var_37_7 = var_16.ShowTips

							i18n = var_3_10018

							var_37_7(var_3_10017, var_3_10018("commander_is_in_fleet_already"))

							return
						end
					end
				end
			end

			local var_37_8 = var_0

			var_5.updateCommanderByPos(var_37_8, arg_35_2, var_37_2)

			local var_37_9 = var_3_0

			var_5.updateActivityFleet(var_37_9, var_3_3.id, arg_35_1, var_0)
			arg_37_1()

			return
		end

		function var_35_7.onQuit(arg_38_0)
			local var_38_0 = var_0

			var_1.updateCommanderByPos(var_38_0, arg_35_2, nil)

			local var_38_1 = var_3_0

			var_1.updateActivityFleet(var_38_1, var_3_3.id, arg_35_1, var_0)
			arg_38_0()

			return
		end

		var_35_4(var_35_3, var_35_5, var_35_6, var_35_7)

		return
	end)
	arg_3_0:bind(var_0_1.ON_PERFORM_COMBAT, function(arg_39_0, arg_39_1, arg_39_2)
		local var_39_0 = arg_3_0
		local var_39_1 = var_3.sendNotification

		GAME = var_2_10005

		local var_39_2 = var_2_10005.BEGIN_STAGE
		local var_39_3 = {
			memory = true,
			mainFleetId = 1
		}

		SYSTEM_PERFORM = var_2_10007
		var_39_3.system = var_2_10007
		var_39_3.stageId = arg_39_1
		var_39_3.exitCallback = arg_39_2

		var_39_1(var_39_0, var_39_2, var_39_3)

		return
	end)

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.bind

	PreCombatMediator = var_5

	var_3_7(var_3_6, var_5.BEGIN_STAGE_PROXY, function(arg_40_0, arg_40_1)
		local var_40_0 = arg_3_0
		local var_40_1 = var_2.sendNotification

		PreCombatMediator = var_2_10004

		var_40_1(var_40_0, var_2_10004.BEGIN_STAGE_PROXY, {
			curFleetId = arg_40_1
		})

		return
	end)
	arg_3_0:bind(var_0_1.ONEN_BUFF_SELECT, function(arg_41_0)
		ActivityBossBuffSelectLayer = var_2_10001
		ActivityBossBuffSelectMediator = var_2_10002

		;(function(arg_42_0)
			if not arg_42_0 or arg_42_0:isEnd() then
				return
			end

			local var_42_0 = arg_42_0

			if not arg_42_0.getConfig(var_42_0, "config_client").buff_scene then
				return
			end

			_G = var_42_0
			var_2_10001 = var_42_0[var_1]

			return
		end)(arg_3_0.contextData.activity)

		local var_41_0 = arg_3_0
		local var_41_1 = var_4.addSubLayers

		Context = var_2_10006

		local var_41_2 = var_2_10006.New
		local var_41_3 = {
			mediator = var_2_10002,
			viewComponent = var_2_10001
		}
		local var_41_4 = {}
		local var_41_5 = arg_3_0.contextData.activity
		local var_41_6 = var_9.GetBossConfig(var_41_5)

		var_41_4.spEnemyInfo = var_9.GetSPEnemy(var_41_6)

		local var_41_7 = arg_3_0.contextData.activity

		var_41_4.score = var_9.GetHighestScore(var_41_7)
		var_41_3.data = var_41_4

		var_41_1(var_41_0, var_41_2(var_41_3))

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_43_0)
	local var_43_0 = {}

	ActivityProxy = var_1_10002
	var_43_0[1] = var_1_10002.ACTIVITY_ADDED
	ActivityProxy = var_2
	var_43_0[2] = var_2.ACTIVITY_UPDATED
	GAME = var_2
	var_43_0[3] = var_2.SUBMIT_TASK_DONE
	PlayerProxy = var_2
	var_43_0[4] = var_2.UPDATED
	GAME = var_2
	var_43_0[5] = var_2.BEGIN_STAGE_DONE
	GAME = var_2
	var_43_0[6] = var_2.ACT_NEW_PT_DONE
	GAME = var_2
	var_43_0[7] = var_2.ACT_BOSS_EXCHANGE_TICKET_DONE
	GAME = var_2
	var_43_0[8] = var_2.GET_POWERRANK_DONE
	ActivityBossBuffSelectMediator = var_2
	var_43_0[9] = var_2.ON_START
	GAME = var_2
	var_43_0[10] = var_2.COMMANDER_ACTIVITY_FORMATION_OP_DONE
	CommanderProxy = var_2
	var_43_0[11] = var_2.PREFAB_FLEET_UPDATE

	return var_43_0
end

function var_0_1.handleNotification(arg_44_0, arg_44_1)
	local var_44_0 = arg_44_1:getName()
	local var_44_1 = arg_44_1
	local var_44_2 = arg_44_1.getBody(var_44_1)

	ActivityProxy = var_44_1

	if var_44_0 ~= var_44_1.ACTIVITY_ADDED then
		ActivityProxy = var_44_3

		local var_44_3

		if var_44_0 == var_44_3.ACTIVITY_UPDATED then
			if var_44_2.id == arg_44_0.contextData.ptActId then
				if arg_44_0.contextData.ptData then
					var_1_10005 = arg_44_0.contextData.ptData

					var_44_3.Update(var_1_10005, var_44_2)
				else
					var_44_3 = arg_44_0.contextData
					ActivityBossPtData = var_1_10005
					var_44_3.ptData = var_1_10005.New(var_44_2)
				end

				var_1_10005 = arg_44_0

				arg_44_0.UpdateView(var_1_10005)
			elseif var_44_2.id == arg_44_0.contextData.activityID then
				var_1_10005 = arg_44_0

				arg_44_0.UpdateActivityData(var_1_10005, var_44_2)

				var_1_10005 = arg_44_0

				arg_44_0.UpdateView(var_1_10005)
			end
		else
			PlayerProxy = var_44_3

			if var_44_0 == var_44_3.UPDATED then
				var_1_10005 = arg_44_0

				arg_44_0.RequestAndUpdateView(var_1_10005)
			else
				GAME = var_4

				local var_44_4

				if var_44_0 == var_4.BEGIN_STAGE_DONE then
					var_44_4 = arg_44_0.contextData
					var_44_4.editFleet = nil
					getProxy = var_44_4
					ContextProxy = var_1_10005
					var_1_10006 = var_44_4(var_1_10005)
					var_1_10005 = var_44_4.getContextByMediator
					PreCombatMediator = var_1_10007

					if not var_1_10005(var_1_10006, var_1_10007) then
						var_1_10006 = arg_44_0
						var_1_10005 = arg_44_0.sendNotification
						GAME = var_1_10007

						local var_44_5 = var_1_10007.GO_SCENE

						SCENE = var_1_10008

						var_1_10005(var_1_10006, var_44_5, var_1_10008.COMBATLOAD, var_44_2)
					end
				else
					GAME = var_44_4

					local var_44_6

					if var_44_0 == var_44_4.ACT_BOSS_EXCHANGE_TICKET_DONE then
						if arg_44_0.contextData.ready2battleCb then
							arg_44_0.contextData.ready2battleCb()

							var_44_6 = arg_44_0.contextData
							var_44_6.ready2battleCb = nil
						end
					else
						GAME = var_44_6

						local var_44_7

						if var_44_0 == var_44_6.GET_POWERRANK_DONE then
							var_44_7 = var_44_2.type
							PowerRank = var_1_10005

							if var_44_7 == var_1_10005.TYPE_ACT_BOSS_BATTLE then
								var_1_10005 = arg_44_0

								arg_44_0.UpdateRankData(var_1_10005, var_44_2.list)
							end
						else
							GAME = var_44_7

							local var_44_8

							if var_44_0 == var_44_7.ACT_NEW_PT_DONE then
								var_1_10005 = arg_44_0.viewComponent
								var_44_8 = var_44_8.emit
								BaseUI = var_1_10006

								var_44_8(var_1_10005, var_1_10006.ON_ACHIEVE, var_44_2.awards)
							else
								GAME = var_44_8

								local var_44_9

								if var_44_0 == var_44_8.COMMANDER_ACTIVITY_FORMATION_OP_DONE then
									getProxy = var_44_9
									FleetProxy = var_1_10005
									var_1_10005 = var_44_9(var_1_10005)
									var_44_9 = var_44_9.getActivityFleets(var_1_10005)[var_44_2.actId]
									var_1_10005 = arg_44_0.contextData
									var_1_10005.actFleets = var_44_9

									local var_44_10 = arg_44_0.viewComponent

									var_1_10005.updateEditPanel(var_44_10)

									local var_44_11 = arg_44_0.viewComponent

									var_1_10005.updateCommanderFleet(var_44_11, var_44_9[var_44_2.fleetId])
								else
									CommanderProxy = var_44_9

									local var_44_13

									if var_44_0 == var_44_9.PREFAB_FLEET_UPDATE then
										getProxy = var_44_13
										CommanderProxy = var_1_10005

										local var_44_12 = var_44_13(var_1_10005)

										var_44_13 = var_44_13.getPrefabFleet(var_44_12)

										local var_44_14 = arg_44_0.viewComponent

										var_5.setCommanderPrefabs(var_44_14, var_44_13)

										local var_44_15 = arg_44_0.viewComponent

										var_5.updateCommanderPrefab(var_44_15)
									else
										ActivityBossBuffSelectMediator = var_44_13

										if var_44_0 == var_44_13.ON_START then
											local var_44_16 = arg_44_0.viewComponent

											var_4.ShowSPFleet(var_44_16)
										end
									end
								end
							end
						end
					end
				end
			end
		end

		return
	end
end

function var_0_1.RequestAndUpdateView(arg_45_0)
	local var_45_0 = arg_45_0
	local var_45_1 = arg_45_0.sendNotification

	GAME = var_1_10003

	var_45_1(var_45_0, var_1_10003.ACTIVITY_BOSS_PAGE_UPDATE, {
		activity_id = arg_45_0.contextData.activityID
	})

	return
end

function var_0_1.UpdateView(arg_46_0)
	local var_46_0 = arg_46_0.viewComponent

	var_1.UpdateView(var_46_0)

	return
end

function var_0_1.UpdateRankData(arg_47_0, arg_47_1)
	local var_47_0 = arg_47_0.viewComponent

	var_2.UpdateRank(var_47_0, arg_47_1)

	return
end

function var_0_1.UpdateActivityData(arg_48_0, arg_48_1)
	arg_48_0.contextData.activity = arg_48_1
	arg_48_0.contextData.bossHP = arg_48_1:GetBossHP()
	arg_48_0.contextData.mileStones = arg_48_1:GetMileStones()
	arg_48_0.contextData.stageTickets = arg_48_1:GetTickets()

	return
end

function var_0_1.getDockCallbackFuncs4ActicityFleet(arg_49_0, arg_49_1, arg_49_2)
	getProxy = var_1_10003
	BayProxy = var_1_10004

	local var_49_0 = var_1_10003(var_1_10004)

	getProxy = var_1_10004
	FleetProxy = var_1_10005

	local var_49_1 = var_1_10004(var_1_10005)

	getProxy = var_1_10005
	ActivityProxy = var_1_10006

	local var_49_2 = var_1_10005(var_1_10006)
	local var_49_3 = var_5.getActivityByType

	ActivityConst = var_1_10007

	local var_49_4 = var_49_3(var_49_2, var_1_10007.ACTIVITY_TYPE_BOSS_BATTLE_MARK_2)
	local var_49_5 = var_49_1:getActivityFleets()[var_49_4.id][arg_49_1]

	local function var_49_6(arg_50_0, arg_50_1)
		ShipStatus = var_2_10002

		local var_50_0, var_50_1 = var_2_10002.ShipStatusCheck("inActivity", arg_50_0, arg_50_1, {
			inActivity = var_49_4.id
		})

		if not var_50_0 then
			return var_50_0, var_50_1
		end

		if arg_49_0 then
			local var_50_2 = arg_49_0

			if var_4.isSameKind(var_50_2, arg_50_0) then
				return true
			end
		end

		ipairs = var_4

		for iter_50_0, iter_50_1 in var_4(var_49_5.ships) do
			local var_50_3 = arg_50_0
			local var_50_4 = arg_50_0.isSameKind
			local var_50_5 = var_49_0

			if var_50_4(var_50_3, var_11.getShipById(var_50_5, iter_50_1)) then
				local var_50_6 = false

				i18n = var_50_3

				local var_50_7 = var_50_3("ship_formationMediator_changeNameError_sameShip")

				return
			end
		end

		return true
	end

	local function var_49_7(arg_51_0, arg_51_1, arg_51_2)
		arg_51_1()

		return
	end

	local function var_49_8(arg_52_0)
		if arg_49_0 then
			local var_52_0 = var_49_5

			var_1.removeShip(var_52_0, arg_49_0)
		end

		if #arg_52_0 > 0 then
			local var_52_1 = var_49_0
			local var_52_2 = var_1.getShipById(var_52_1, arg_52_0[1])
			local var_52_3 = var_49_5

			if not var_2.containShip(var_52_3, var_52_2) then
				local var_52_4 = var_49_5

				var_2.insertShip(var_52_4, var_52_2, nil, arg_49_2)
			elseif arg_49_0 then
				local var_52_5 = var_49_5

				var_2.insertShip(var_52_5, arg_49_0, nil, arg_49_2)
			end

			local var_52_6 = var_49_5

			var_2.RemoveUnusedItems(var_52_6)
		end

		local var_52_7 = var_49_1

		var_1.updateActivityFleet(var_52_7, var_49_4.id, arg_49_1, var_49_5)

		return
	end

	return var_49_6, var_49_7, var_49_8
end

return var_0_1

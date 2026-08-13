class = var_0_10000

local var_0_0 = "GuildEventMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.ContextMediator"))

var_0_1.ON_ACTIVE_EVENT = "GuildEventMediator:ON_ACTIVE_EVENT"
var_0_1.ON_OPEN_REPORT = "GuildEventMediator:ON_OPEN_REPORT"
var_0_1.ON_GET_FORMATION = "GuildEventMediator:ON_GET_FORMATION"
var_0_1.UPDATE_FORMATION = "GuildEventMediator:UPDATE_FORMATION"
var_0_1.ON_SELECT_SHIP = "GuildEventMediator:ON_SELECT_SHIP"
var_0_1.ON_SELECT_MISSION_SHIP = "GuildEventMediator:ON_SELECT_MISSION_SHIP"
var_0_1.REFRESH_MISSION = "GuildEventMediator:REFRESH_MISSION"
var_0_1.JOIN_MISSION = "GuildEventMediator:JOIN_MISSION"
var_0_1.ON_GET_BOSS_INFO = "GuildEventMediator:ON_GET_BOSS_INFO"
var_0_1.ON_REFRESH_BOSS_RANK = "GuildEventMediator:ON_REFRESH_BOSS_RANK"
var_0_1.ON_UPDATE_NODE_ANIM_FLAG = "GuildEventMediator:ON_UPDATE_NODE_ANIM_FLAG"
var_0_1.ON_SELECT_BOSS_SHIP = "GuildEventMediator:ON_SELECT_BOSS_SHIP"
var_0_1.ON_UPDATE_BOSS_FLEET = "GuildEventMediator:ON_UPDATE_BOSS_FLEET"
var_0_1.ON_RECOMM_BOSS_BATTLE_SHIPS = "GuildEventMediator:ON_RECOMM_BOSS_BATTLE_SHIPS"
var_0_1.ON_GET_ALL_ASSULT_FLEET = "GuildEventMediator:ON_GET_ALL_ASSULT_FLEET"
var_0_1.ON_SELECT_COMMANDER = "GuildEventMediator:ON_SELECT_COMMANDER"
var_0_1.FORCE_REFRESH_MISSION = "GuildEventMediator:FORCE_REFRESH_MISSION"
var_0_1.ON_SAVE_FORMATION = "GuildEventMediator:ON_SAVE_FORMATION"
var_0_1.ON_JOIN_EVENT = "GuildEventMediator:ON_JOIN_EVENT"
var_0_1.ON_RECOMM_ASSULT_SHIP = "GuildEventMediator:ON_RECOMM_ASSULT_SHIP"
var_0_1.REFRESH_RECOMMAND_SHIPS = "GuildEventMediator:REFRESH_RECOMMAND_SHIPS"
var_0_1.ON_CLEAR_BOSS_FLEET_INVAILD_SHIP = "GuildEventMediator:ON_CLEAR_BOSS_FLEET_INVAILD_SHIP"
var_0_1.ON_CMD_SKILL = "GuildEventMediator:ON_CMD_SKILL"
var_0_1.COMMANDER_FORMATION_OP = "GuildEventMediator:COMMANDER_FORMATION_OP"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.COMMANDER_FORMATION_OP, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0

		var_2.OnComanderOP(var_2_0, arg_2_1)

		return
	end)
	arg_1_0:bind(var_0_1.ON_CMD_SKILL, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.addSubLayers

		Context = var_2_10005

		local var_3_2 = var_2_10005.New
		local var_3_3 = {}

		CommanderSkillMediator = var_2_10008
		var_3_3.mediator = var_2_10008
		CommanderSkillLayer = var_2_10008
		var_3_3.viewComponent = var_2_10008
		var_3_3.data = {
			skill = arg_3_1
		}

		var_3_1(var_3_0, var_3_2(var_3_3))

		return
	end)
	arg_1_0:bind(var_0_1.REFRESH_RECOMMAND_SHIPS, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0
		local var_4_1 = var_2.sendNotification

		GAME = var_2_10005

		var_4_1(var_4_0, var_2_10005.REFRESH_ALL_ASSULT_SHIP_RECOMMAND_STATE, {
			callback = arg_4_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_RECOMM_ASSULT_SHIP, function(arg_5_0, arg_5_1, arg_5_2)
		local var_5_0 = arg_1_0
		local var_5_1 = var_3.sendNotification

		GAME = var_2_10006

		var_5_1(var_5_0, var_2_10006.GUILD_RECOMMAND_ASSULT_SHIP, {
			shipId = arg_5_1,
			cmd = arg_5_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_JOIN_EVENT, function()
		local var_6_0 = arg_1_0
		local var_6_1 = var_0.sendNotification

		GAME = var_2_10003

		var_6_1(var_6_0, var_2_10003.ON_GUILD_JOIN_EVENT)

		return
	end)
	arg_1_0:bind(var_0_1.ON_SELECT_COMMANDER, function(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
		local var_7_0 = arg_1_0

		var_4.SelectBossBattleCommander(var_7_0, arg_7_1, arg_7_2, arg_7_3)

		return
	end)
	arg_1_0:bind(var_0_1.ON_GET_ALL_ASSULT_FLEET, function(arg_8_0, arg_8_1)
		local var_8_0 = arg_1_0
		local var_8_1 = var_2.sendNotification

		GAME = var_2_10005

		var_8_1(var_8_0, var_2_10005.GUILD_GET_ASSAULT_FLEET, {
			callback = arg_8_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_RECOMM_BOSS_BATTLE_SHIPS, function(arg_9_0, arg_9_1)
		local var_9_0 = arg_1_0
		local var_9_1 = var_2.sendNotification

		GAME = var_2_10005

		var_9_1(var_9_0, var_2_10005.GUILD_GET_ASSAULT_FLEET, {
			callback = function()
				local var_10_0 = arg_1_0

				var_0.RecommShipsForBossBattle(var_10_0, arg_9_1)

				return
			end
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_SAVE_FORMATION, function(arg_11_0, arg_11_1)
		local var_11_0 = arg_1_0
		local var_11_1 = var_2.sendNotification

		GAME = var_2_10005

		var_11_1(var_11_0, var_2_10005.GUILD_UPDATE_BOSS_FORMATION, {
			editFleet = arg_1_0.contextData.editBossFleet,
			callback = arg_11_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_CLEAR_BOSS_FLEET_INVAILD_SHIP, function(arg_12_0)
		local var_12_0 = arg_1_0
		local var_12_1 = var_1.sendNotification

		GAME = var_2_10004

		var_12_1(var_12_0, var_2_10004.GUILD_UPDATE_BOSS_FORMATION, {
			force = true,
			editFleet = arg_1_0.contextData.editBossFleet
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_UPDATE_BOSS_FLEET, function(arg_13_0)
		if not arg_1_0.contextData.editBossFleet then
			local var_13_0 = arg_1_0

			var_1.StartBossBattle(var_13_0)
		else
			local var_13_1 = arg_1_0.viewComponent

			var_1.emit(var_13_1, var_0_1.ON_SAVE_FORMATION, function()
				local var_14_0 = arg_1_0

				var_0.StartBossBattle(var_14_0)

				return
			end)
		end

		return
	end)
	arg_1_0:bind(var_0_1.ON_SELECT_BOSS_SHIP, function(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
		local var_15_0 = arg_1_0
		local var_15_1 = var_4.sendNotification

		GAME = var_2_10007

		var_15_1(var_15_0, var_2_10007.GUILD_GET_ASSAULT_FLEET, {
			callback = function()
				local var_16_0 = arg_1_0

				var_0.SelectBossBattleShip(var_16_0, arg_15_1, arg_15_2, arg_15_3)

				return
			end
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_UPDATE_NODE_ANIM_FLAG, function(arg_17_0, arg_17_1, arg_17_2)
		local var_17_0 = arg_1_0
		local var_17_1 = var_3.sendNotification

		GAME = var_2_10006

		var_17_1(var_17_0, var_2_10006.GUILD_UPDATE_NODE_ANIM_FLAG, {
			id = arg_17_1,
			position = arg_17_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_REFRESH_BOSS_RANK, function(arg_18_0)
		local var_18_0 = arg_1_0
		local var_18_1 = var_1.sendNotification

		GAME = var_2_10004

		var_18_1(var_18_0, var_2_10004.GET_GUILD_BOSS_RANK, {})

		return
	end)
	arg_1_0:bind(var_0_1.ON_GET_BOSS_INFO, function(arg_19_0)
		local var_19_0 = arg_1_0
		local var_19_1 = var_1.sendNotification

		GAME = var_2_10004

		var_19_1(var_19_0, var_2_10004.GUILD_GET_BOSS_INFO)

		return
	end)
	arg_1_0:bind(var_0_1.JOIN_MISSION, function(arg_20_0, arg_20_1, arg_20_2)
		local var_20_0 = arg_1_0
		local var_20_1 = var_3.sendNotification

		GAME = var_2_10006

		var_20_1(var_20_0, var_2_10006.GUILD_JOIN_MISSION, {
			id = arg_20_1,
			shipIds = arg_20_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_SELECT_MISSION_SHIP, function(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
		local var_21_0 = arg_1_0.viewComponent

		var_4.emit(var_21_0, var_0_1.ON_GET_FORMATION, function()
			local var_22_0 = arg_1_0

			var_0.OnSelectMissionShips(var_22_0, arg_21_1, arg_21_2, arg_21_3)

			return
		end)

		return
	end)
	arg_1_0:bind(var_0_1.REFRESH_MISSION, function(arg_23_0, arg_23_1, arg_23_2)
		local var_23_0 = arg_1_0
		local var_23_1 = var_3.sendNotification

		GAME = var_2_10006

		var_23_1(var_23_0, var_2_10006.GUILD_REFRESH_MISSION, {
			force = false,
			id = arg_23_1,
			callback = arg_23_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.FORCE_REFRESH_MISSION, function(arg_24_0, arg_24_1, arg_24_2)
		local var_24_0 = arg_1_0
		local var_24_1 = var_3.sendNotification

		GAME = var_2_10006

		var_24_1(var_24_0, var_2_10006.GUILD_REFRESH_MISSION, {
			force = true,
			id = arg_24_1,
			callback = arg_24_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_SELECT_SHIP, function(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
		local var_25_0 = arg_1_0

		var_4.OnSelectShips(var_25_0, arg_25_1, arg_25_2, arg_25_3)

		return
	end)
	arg_1_0:bind(var_0_1.ON_GET_FORMATION, function(arg_26_0, arg_26_1)
		getProxy = var_2_10002
		GuildProxy = var_2_10004

		local var_26_0 = var_2_10002(var_2_10004)
		local var_26_1 = var_2.getRawData(var_26_0)
		local var_26_2 = var_2.GetActiveEvent(var_26_1)
		local var_26_3 = {}

		if var_26_2 then
			table = var_26_1

			var_26_1.insert(var_26_3, function(arg_27_0)
				local var_27_0 = arg_1_0.viewComponent

				var_1.emit(var_27_0, var_0_1.ON_GET_ALL_ASSULT_FLEET, arg_27_0)

				return
			end)
		end

		getProxy = var_26_1
		GuildProxy = var_2_10007

		if not var_26_1(var_2_10007).isFetchAssaultFleet then
			table = var_5

			var_5.insert(var_26_3, function(arg_28_0)
				local var_28_0 = arg_1_0
				local var_28_1 = var_1.sendNotification

				GAME = var_3_10004

				var_28_1(var_28_0, var_3_10004.GUILD_GET_MY_ASSAULT_FLEET, {
					callback = arg_28_0
				})

				return
			end)
		end

		seriesAsync = var_5

		var_5(var_26_3, arg_26_1)

		return
	end)
	arg_1_0:bind(var_0_1.UPDATE_FORMATION, function(arg_29_0)
		if not arg_1_0.contextData.editFleet then
			return
		end

		local var_29_0 = arg_1_0
		local var_29_1 = var_1.sendNotification

		GAME = var_2_10004

		var_29_1(var_29_0, var_2_10004.GUILD_UPDATE_MY_ASSAULT_FLEET, {
			fleet = arg_1_0.contextData.editFleet
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_ACTIVE_EVENT, function(arg_30_0, arg_30_1)
		local var_30_0 = arg_1_0
		local var_30_1 = var_2.sendNotification

		GAME = var_2_10005

		var_30_1(var_30_0, var_2_10005.GUILD_ACTIVE_EVENT, {
			eventId = arg_30_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_OPEN_REPORT, function(arg_31_0)
		local var_31_0 = arg_1_0
		local var_31_1 = var_1.sendNotification

		GAME = var_2_10004

		var_31_1(var_31_0, var_2_10004.GUILD_OPEN_EVENT_REPORT)

		return
	end)

	local var_1_0 = arg_1_0.viewComponent
	local var_1_1 = var_1.SetPlayer

	getProxy = var_4
	PlayerProxy = var_1_10006

	local var_1_2 = var_4(var_1_10006)

	var_1_1(var_1_0, var_4.getRawData(var_1_2))

	getProxy = var_1_1
	GuildProxy = var_1_0

	local var_1_3 = var_1_1(var_1_0)
	local var_1_4 = arg_1_0.viewComponent

	var_2.SetGuild(var_1_4, var_1_3:getData())

	return
end

function var_0_1.StartBossBattle(arg_32_0)
	getProxy = var_1_10001
	GuildProxy = var_1_10003

	local var_32_0 = var_1_10001(var_1_10003)
	local var_32_1 = var_1.getRawData(var_32_0)

	if not var_1.GetActiveEvent(var_32_1) or var_2 and var_2:IsExpired() then
		pg = var_32_0

		local var_32_2 = var_32_0.TipsMgr.GetInstance()
		local var_32_3 = var_3.ShowTips

		i18n = var_1_10006

		var_32_3(var_32_2, var_1_10006("guild_battle_is_end"))

		return
	end

	if not var_2:GetBossMission() then
		return
	end

	local var_32_4 = var_3:GetMainFleet()
	local var_32_5, var_32_6 = var_4.IsLegal(var_32_4)

	if not var_32_5 then
		pg = var_32_4

		local var_32_7 = var_32_4.TipsMgr.GetInstance()

		var_7.ShowTips(var_32_7, var_32_6)

		return
	end

	local var_32_8 = var_3:GetSubFleet()
	local var_32_9, var_32_10 = var_7.IsLegal(var_32_8)

	if not var_32_9 then
		pg = var_32_8

		local var_32_11 = var_32_8.TipsMgr.GetInstance()

		var_9.ShowTips(var_32_11, var_32_10)

		return
	end

	local var_32_12 = var_4
	local var_32_13 = var_4.GetDownloadResShips(var_32_12)
	local var_32_14 = {}

	ipairs = var_32_12

	for iter_32_0, iter_32_1 in var_32_12(var_32_13) do
		PaintingGroupConst = var_1_10016

		var_1_10016.AddPaintingNameWithFilteMap(var_32_14, iter_32_1)
	end

	local function var_32_15()
		local var_33_0 = arg_32_0
		local var_33_1 = var_0.sendNotification

		GAME = var_2_10003

		local var_33_2 = var_2_10003.BEGIN_STAGE
		local var_33_3 = {}

		SYSTEM_GUILD = var_2_10005
		var_33_3.system = var_2_10005

		var_33_1(var_33_0, var_33_2, var_33_3)

		return
	end

	PaintingGroupConst = var_12

	var_12.PaintingDownload({
		isShowBox = true,
		paintingNameList = var_32_14,
		finishFunc = var_32_15
	})

	return
end

function var_0_1.SelectBossBattleCommander(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
	local var_34_0

	if not arg_34_0.contextData.editBossFleet then
		var_34_0 = arg_34_0.contextData
		var_34_0.editBossFleet = {}
	end

	getProxy = var_34_0
	GuildProxy = var_1_10006

	local var_34_1 = var_34_0(var_1_10006)
	local var_34_2 = var_4.getData(var_34_1)

	if not var_4.GetActiveEvent(var_34_2) then
		return
	end

	local var_34_3 = var_5
	local var_34_4 = var_5.GetBossMission(var_34_3)

	if not arg_34_0.contextData.editBossFleet[arg_34_1] then
		local var_34_5 = arg_34_0.contextData.editBossFleet

		Clone = var_34_3
		var_34_5[arg_34_1] = var_34_3(var_34_4:GetFleetByIndex(arg_34_1))
	end

	local var_34_6 = arg_34_0.contextData.editBossFleet[arg_34_1]
	local var_34_7 = var_7.getCommanders(var_34_6)
	local var_34_8 = {}

	if arg_34_3 then
		table = var_34_6

		var_34_6.insert(var_34_8, arg_34_3.id)
	end

	pg = var_34_6

	local var_34_9 = var_34_6.m02
	local var_34_10 = var_10.sendNotification

	GAME = var_1_10013

	local var_34_11 = var_1_10013.GO_SCENE

	SCENE = var_1_10014

	local var_34_12 = var_1_10014.COMMANDERCAT
	local var_34_13 = {
		maxCount = 1
	}

	CommanderCatScene = var_1_10016
	var_34_13.mode = var_1_10016.MODE_SELECT
	CommanderCatScene = var_16
	var_34_13.fleetType = var_16.FLEET_TYPE_GUILDBOSS
	var_34_13.activeCommander = arg_34_3
	var_34_13.ignoredIds = var_34_8
	var_34_13.fleets = arg_34_0.contextData.editBossFleet

	function var_34_13.onCommander(arg_35_0)
		return true
	end

	function var_34_13.onSelected(arg_36_0, arg_36_1)
		local var_36_0 = arg_34_0

		var_2.OnDockSelectCommander(var_36_0, true, var_0, arg_34_2, var_34_4, arg_36_0, arg_36_1)

		return
	end

	function var_34_13.onQuit(arg_37_0)
		local var_37_0 = var_0

		var_1.RemoveCommander(var_37_0, arg_34_2)
		arg_37_0()

		return
	end

	var_34_10(var_34_9, var_34_11, var_34_12, var_34_13)

	return
end

function var_0_1.OnDockSelectCommander(arg_38_0, arg_38_1, arg_38_2, arg_38_3, arg_38_4, arg_38_5, arg_38_6)
	local var_38_0 = arg_38_5[1]

	getProxy = var_1_10008
	CommanderProxy = var_1_10010

	local var_38_1 = var_1_10008(var_1_10010)

	if not var_8.getCommanderById(var_38_1, var_38_0) then
		arg_38_6()

		return
	end

	local var_38_2 = {}
	local var_38_3 = {}
	local var_38_4 = arg_38_0.contextData.editBossFleet

	GuildBossMission = var_1_10012

	local var_38_5

	if not var_38_4[var_1_10012.SUB_FLEET_ID] then
		var_1_10013 = arg_38_4
		var_38_5 = arg_38_4.GetSubFleet(var_1_10013)
	end

	local var_38_6 = arg_38_0.contextData.editBossFleet

	GuildBossMission = var_1_10013

	local var_38_7

	if not var_38_6[var_1_10013.MAIN_FLEET_ID] then
		var_38_7 = arg_38_4:GetMainFleet()
	end

	local var_38_8 = arg_38_2:IsMainFleet() and var_38_7 or var_38_5
	local var_38_9 = var_14.getCommanders(var_38_8)

	if arg_38_1 then
		pairs = var_15

		for iter_38_0, iter_38_1 in var_15(var_38_9) do
			if arg_38_3 ~= iter_38_0 and iter_38_1:isSameGroup(var_8.groupId) then
				pg = var_20

				local var_38_10 = var_20.TipsMgr.GetInstance()
				local var_38_11 = var_20.ShowTips

				i18n = var_23

				var_38_11(var_38_10, var_23("commander_can_not_select_same_group"))

				return
			end
		end
	end

	local var_38_12 = var_13 and var_38_5 or var_38_7
	local var_38_13 = var_15.getCommanders(var_38_12)

	pairs = var_16

	for iter_38_2, iter_38_3 in var_16(var_38_13) do
		if iter_38_3.id == var_8.id then
			arg_38_0:SwopCommanderForBossBattle(arg_38_4, var_8, arg_38_3, iter_38_2, var_14, var_15, arg_38_6)

			return
		end
	end

	arg_38_2:AddCommander(arg_38_3, var_8)
	arg_38_6()

	return
end

function var_0_1.SwopCommanderForBossBattle(arg_39_0, arg_39_1, arg_39_2, arg_39_3, arg_39_4, arg_39_5, arg_39_6, arg_39_7)
	local var_39_0

	if not arg_39_0.contextData.editBossFleet[arg_39_6.id] then
		var_39_0 = arg_39_0.contextData.editBossFleet

		local var_39_1 = arg_39_6.id

		Clone = var_1_10010
		var_1_10014 = arg_39_1
		var_39_0[var_39_1] = var_1_10010(arg_39_1.GetFleetByIndex(var_1_10014, arg_39_6.id))
		arg_39_6 = arg_39_0.contextData.editBossFleet[arg_39_6.id]
	end

	if arg_39_4 == 1 then
		i18n = var_39_0

		if not var_39_0("commander_main_pos") then
			i18n = var_39_0
			var_39_0 = var_39_0("commander_assistant_pos")
		end

		local var_39_2 = arg_39_5:GetName()

		pg = var_1_10010

		local var_39_3 = var_1_10010.MsgboxMgr.GetInstance()
		local var_39_4 = var_10.ShowMsgBox
		local var_39_5 = {}

		i18n = var_1_10014
		var_39_5.content = var_1_10014("comander_repalce_tip", var_39_2, var_39_0)

		function var_39_5.onYes()
			local var_40_0 = arg_39_6

			var_0.RemoveCommander(var_40_0, arg_39_4)

			local var_40_1 = arg_39_5

			var_0.AddCommander(var_40_1, arg_39_3, arg_39_2)

			if arg_39_7 then
				arg_39_7()
			end

			return
		end

		var_39_4(var_39_3, var_39_5)

		return
	end
end

function var_0_1.RecommShipsForBossBattle(arg_41_0, arg_41_1)
	if not arg_41_0.contextData.editBossFleet then
		arg_41_0.contextData.editBossFleet = {}
	end

	local var_41_0 = {}
	local var_41_1 = {}
	local var_41_2 = {}

	getProxy = var_1_10005
	GuildProxy = var_1_10007

	local var_41_3 = var_1_10005(var_1_10007)
	local var_41_4 = var_5.getData(var_41_3)

	getProxy = var_1_10006
	PlayerProxy = var_1_10008

	local var_41_5 = var_1_10006(var_1_10008)
	local var_41_6 = var_6.getRawData(var_41_5)

	if not var_41_4:GetActiveEvent() then
		return
	end

	local var_41_7 = var_7
	local var_41_8 = var_7.GetBossMission(var_41_7)

	if not arg_41_0.contextData.editBossFleet[arg_41_1] then
		local var_41_9 = arg_41_0.contextData.editBossFleet

		Clone = var_41_7
		var_41_9[arg_41_1] = var_41_7(var_41_8:GetFleetByIndex(arg_41_1))
	end

	local var_41_10 = arg_41_0.contextData.editBossFleet[arg_41_1]

	var_9.RemoveAll(var_41_10)

	local function var_41_11(arg_42_0, arg_42_1)
		TeamType = var_2_10002

		if arg_42_0 == var_2_10002.Main then
			table = var_2

			var_2.insert(var_41_0, arg_42_1)
		else
			TeamType = var_2

			if arg_42_0 == var_2.Vanguard then
				table = var_2

				var_2.insert(var_41_1, arg_42_1)
			else
				TeamType = var_2

				if arg_42_0 == var_2.Submarine then
					table = var_2

					var_2.insert(var_41_2, arg_42_1)
				end
			end
		end

		return
	end

	getProxy = var_1_10011
	BayProxy = var_1_10013

	local var_41_12 = var_1_10011(var_1_10013)
	local var_41_13 = var_11.getData(var_41_12)

	pairs = var_41_10

	for iter_41_0, iter_41_1 in var_41_10(var_41_13) do
		pg = var_1_10017

		local var_41_14 = var_1_10017.ShipFlagMgr.GetInstance()

		if not var_1_10017.GetShipFlag(var_41_14, iter_41_1.id, "inEvent") and not iter_41_1:isActivityNpc() then
			GuildAssaultFleet = var_1_10017
			iter_41_1.id = var_1_10017.GetVirtualId(var_41_6.id, iter_41_1.id)
			var_1_10017 = iter_41_1:getShipCombatPower()

			var_41_11(iter_41_1:getTeamType(), {
				power = var_1_10017,
				id = iter_41_1.id
			})
		end
	end

	local var_41_15 = 0
	local var_41_16 = 0
	local var_41_17 = 0

	local function var_41_18(arg_43_0, arg_43_1)
		GuildAssaultFleet = var_2_10002

		local var_43_0 = var_2_10002.GetRealId(arg_43_0)
		local var_43_1 = var_41_13[var_43_0]
		local var_43_2 = var_0

		if not var_4.ExistSameKindShip(var_43_2, var_43_1) then
			GuildAssaultFleet = var_4

			local var_43_3 = var_4.GetUserId(arg_43_0)
			local var_43_4 = var_0

			var_5.AddUserShip(var_43_4, var_43_3, var_43_0)

			TeamType = var_5

			if arg_43_1 == var_5.Main then
				var_41_15 = var_41_15 + 1
			end

			TeamType = var_5

			if arg_43_1 == var_5.Vanguard then
				var_41_16 = var_41_16 + 1
			end

			TeamType = var_5

			if arg_43_1 == var_5.Submarine then
				var_41_17 = var_41_17 + 1
			end
		end

		return
	end

	if var_9:IsMainFleet() then
		table = var_16

		var_16.sort(var_41_0, function(arg_44_0, arg_44_1)
			return arg_44_0.power > arg_44_1.power
		end)

		table = var_16

		var_16.sort(var_41_1, function(arg_45_0, arg_45_1)
			return arg_45_0.power > arg_45_1.power
		end)

		for iter_41_2 = 1, #var_41_0 do
			if var_41_15 == 3 then
				break
			end

			local var_41_19 = var_41_18
			local var_41_20 = var_41_0[iter_41_2].id

			TeamType = var_1_10023

			var_41_19(var_41_20, var_1_10023.Main)
		end

		for iter_41_3 = 1, #var_41_1 do
			if var_41_16 == 3 then
				break
			end

			local var_41_21 = var_41_18
			local var_41_22 = var_41_1[iter_41_3].id

			TeamType = var_1_10023

			var_41_21(var_41_22, var_1_10023.Vanguard)
		end
	else
		table = var_16

		var_16.sort(var_41_2, function(arg_46_0, arg_46_1)
			return arg_46_0.power > arg_46_1.power
		end)

		for iter_41_4 = 1, #var_41_2 do
			if var_41_17 == 3 then
				break
			end

			local var_41_23 = var_41_18
			local var_41_24 = var_41_2[iter_41_4].id

			TeamType = var_1_10023

			var_41_23(var_41_24, var_1_10023.Submarine)
		end
	end

	if arg_41_0.viewComponent.missBossForamtionPage and var_16:GetLoaded() then
		var_16:UpdateFleet(arg_41_1)
	end

	return
end

function var_0_1.SelectBossBattleShip(arg_47_0, arg_47_1, arg_47_2, arg_47_3)
	if not arg_47_0.contextData.editBossFleet then
		arg_47_0.contextData.editBossFleet = {}
	end

	local var_47_0 = {}

	getProxy = var_1_10005
	GuildProxy = var_1_10007

	local var_47_1 = var_1_10005(var_1_10007)
	local var_47_2 = var_5.getData(var_47_1)

	if not var_5.GetActiveEvent(var_47_2) then
		return
	end

	local var_47_3 = var_6
	local var_47_4 = var_6.GetBossMission(var_47_3)
	local var_47_5 = var_7.GetFleetByIndex(var_47_4, arg_47_2)

	assert = var_47_3

	var_47_3(var_47_5, arg_47_2)

	local var_47_6

	if not arg_47_0.contextData.editBossFleet[arg_47_2] then
		Clone = var_10
		var_47_6 = var_10(var_47_5)
	else
		Clone = var_10
		var_47_6 = var_10(arg_47_0.contextData.editBossFleet[arg_47_2])
	end

	local var_47_7
	local var_47_8

	if arg_47_3 then
		var_47_8 = arg_47_3.member.id
		GuildAssaultFleet = var_12

		local var_47_9 = var_12.GetRealId(arg_47_3.ship.id)

		var_47_7 = var_47_6:RemoveUserShip(var_47_8, var_47_9)
	end

	getProxy = var_47_8
	PlayerProxy = var_1_10013

	local var_47_10 = var_47_8(var_1_10013)
	local var_47_11 = var_11.getRawData(var_47_10)
	local var_47_12 = 0

	if var_47_6:IsMainFleet() then
		local var_47_13 = arg_47_0.contextData.editBossFleet

		GuildBossMission = var_1_10014

		local var_47_15

		if not var_47_13[var_1_10014.SUB_FLEET_ID] then
			local var_47_14 = var_7

			var_47_15 = var_7.GetFleetByIndex
			GuildBossMission = var_1_10016
			var_47_15 = var_47_15(var_47_14, var_1_10016.SUB_FLEET_ID)
		end

		var_1_10016 = var_47_15
		var_47_12 = var_47_15.GetOtherMemberShipCnt(var_1_10016, var_47_11.id)
	else
		local var_47_16 = arg_47_0.contextData.editBossFleet

		GuildBossMission = var_1_10014

		local var_47_18

		if not var_47_16[var_1_10014.MAIN_FLEET_ID] then
			local var_47_17 = var_7

			var_47_18 = var_7.GetFleetByIndex
			GuildBossMission = var_1_10016
			var_47_18 = var_47_18(var_47_17, var_1_10016.MAIN_FLEET_ID)
		end

		var_47_12 = var_47_18:GetOtherMemberShipCnt(var_47_11.id)
	end

	local var_47_19

	pairs = var_1_10014

	for iter_47_0, iter_47_1 in var_1_10014(var_5.member) do
		var_1_10021 = iter_47_1

		local var_47_20 = iter_47_1.GetAssaultFleet(var_1_10021)

		if var_47_11.id ~= iter_47_1.id then
			local var_47_21 = var_47_20:GetShipList()

			pairs = var_1_10021

			for iter_47_2, iter_47_3 in var_1_10021(var_47_21) do
				if iter_47_3:getTeamType() == arg_47_1 then
					iter_47_3.user = iter_47_1
					table = var_26

					var_26.insert(var_47_0, iter_47_3)
				end
			end
		else
			var_47_19 = var_47_20
		end
	end

	getProxy = var_14
	BayProxy = var_16

	local var_47_22 = var_14(var_16)
	local var_47_23 = var_14.getData(var_47_22)

	pairs = var_15

	for iter_47_4, iter_47_5 in var_15(var_47_23) do
		iter_47_5.user = var_47_11

		local var_47_24 = var_47_19:GetShipByRealId(var_47_11.id, iter_47_5.id)

		GuildAssaultFleet = var_1_10021
		iter_47_5.id = var_1_10021.GetVirtualId(var_47_11.id, iter_47_5.id)

		if var_47_24 then
			iter_47_5.guildRecommand = var_47_24.guildRecommand
		end

		table = var_1_10021
		var_1_10021 = var_1_10021.insert
		var_1_10023 = var_47_0
		GuildAssaultShip = iter_47_2

		var_1_10021(var_1_10023, iter_47_2.ConverteFromShip(iter_47_5))
	end

	local var_47_25 = {}

	if arg_47_3 then
		table = var_16

		var_16.insert(var_47_25, arg_47_3.ship.id)
	end

	ipairs = var_16

	for iter_47_6, iter_47_7 in var_16(var_47_6:GetShipIds()) do
		if iter_47_7 then
			table = var_1_10021
			var_1_10021 = var_1_10021.insert
			var_1_10023 = var_47_25
			GuildAssaultFleet = iter_47_2

			var_1_10021(var_1_10023, iter_47_2.GetVirtualId(iter_47_7.uid, iter_47_7.id))
		end
	end

	local var_47_26 = var_47_6:GetShips()
	local var_47_27 = arg_47_0
	local var_47_28 = arg_47_0.sendNotification

	GAME = iter_47_7

	local var_47_29 = iter_47_7.GO_SCENE

	SCENE = var_1_10021

	local var_47_30 = var_1_10021.DOCKYARD
	local var_47_31 = {
		selectedMin = 1,
		selectedMax = 1,
		quitTeam = arg_47_3,
		ignoredIds = var_47_25,
		teamFilter = arg_47_1,
		shipVOs = var_47_0
	}

	DockyardScene = var_1_10023
	var_47_31.mode = var_1_10023.MODE_GUILD_BOSS
	ShipStatus = var_23
	var_47_31.hideTagFlags = var_23.TAG_HIDE_CHALLENGE

	function var_47_31.onShip(arg_48_0, arg_48_1, arg_48_2)
		local var_48_0 = var_47_6

		if var_3.GetOtherMemberShipCnt(var_48_0, var_47_11.id) + var_47_12 >= 3 and arg_48_0.user.id ~= var_47_11.id then
			local var_48_1 = false

			i18n = var_5

			local var_48_2 = var_5("guild_boss_formation_1")

			return
		end

		local var_48_4

		if arg_48_0.user.id ~= var_47_11.id then
			local var_48_3 = var_47_6

			if var_4.ExistUserShip(var_48_3, arg_48_0.user.id) then
				var_48_4 = false
				i18n = var_48_3

				local var_48_5 = var_48_3("guild_boss_formation_2")

				return
			end
		end

		_ = var_4

		local var_48_6

		if var_4.any(var_47_26, function(arg_49_0)
			local var_49_0 = arg_49_0.ship

			return var_1.isSameKind(var_49_0, arg_48_0)
		end) then
			var_48_6 = false
			i18n = var_48_4
			var_48_4 = var_48_4("guild_boss_formation_3")

			return
		end

		GuildAssaultFleet = var_48_6

		local var_48_7 = var_48_6.GetRealId(arg_48_0.id)

		pg = var_48_4

		local var_48_8 = var_48_4.ShipFlagMgr.GetInstance()
		local var_48_10

		if var_5.GetShipFlag(var_48_8, var_48_7, "inEvent") then
			local var_48_9 = false

			i18n = var_48_10
			var_48_10 = var_48_10("word_shipState_collect")

			return
		end

		if arg_48_0:isActivityNpc() then
			local var_48_11 = false

			i18n = var_48_10

			local var_48_12 = var_48_10("common_npc_formation_tip")

			return
		end

		return true
	end

	function var_47_31.onSelected(arg_50_0, arg_50_1)
		if arg_50_0[1] then
			GuildAssaultFleet = var_2_10003

			local var_50_0 = var_2_10003.GetRealId(var_2)

			GuildAssaultFleet = var_2_10004

			local var_50_1 = var_2_10004.GetUserId(var_2)
			local var_50_2 = var_47_6

			var_5.AddUserShip(var_50_2, var_50_1, var_50_0, var_47_7)
		end

		arg_47_0.contextData.editBossFleet[arg_47_2] = var_47_6

		return
	end

	var_47_28(var_47_27, var_47_29, var_47_30, var_47_31)

	return
end

function var_0_1.OnSelectShips(arg_51_0, arg_51_1, arg_51_2, arg_51_3)
	local var_51_0 = arg_51_3
	local var_51_1 = arg_51_3.GetShipList(var_51_0)
	local var_51_2 = arg_51_0.contextData

	Clone = var_51_0
	var_51_2.editFleet = var_51_0(arg_51_3)
	getProxy = var_51_2
	BayProxy = var_1_10007

	local var_51_3 = var_51_2(var_1_10007)
	local var_51_4 = var_5.getData(var_51_3)
	local var_51_5 = {}

	if arg_51_2 then
		table = var_51_3

		var_51_3.insert(var_51_5, arg_51_2.id)
	end

	local var_51_6 = arg_51_0
	local var_51_7 = arg_51_0.sendNotification

	GAME = var_1_10011

	local var_51_8 = var_1_10011.GO_SCENE

	SCENE = var_1_10012

	var_51_7(var_51_6, var_51_8, var_1_10012.DOCKYARD, {
		selectedMin = 1,
		selectedMax = 1,
		ignoredIds = var_51_5,
		onShip = function(arg_52_0, arg_52_1, arg_52_2)
			pairs = var_2_10003

			for iter_52_0, iter_52_1 in var_2_10003(var_51_1) do
				GuildAssaultFleet = var_2_10008
				var_2_10008 = var_2_10008.GetRealId(iter_52_1.id)

				if iter_52_0 ~= arg_51_1 and var_2_10008 == arg_52_0.id then
					local var_52_0 = false

					i18n = var_10

					local var_52_1 = var_10("guild_fleet_exist_same_kind_ship")

					return
				end
			end

			if arg_52_0:isActivityNpc() then
				local var_52_2 = false

				i18n = var_4

				local var_52_3 = var_4("common_npc_formation_tip")

				return
			end

			return true
		end,
		onSelected = function(arg_53_0, arg_53_1)
			local var_53_0 = arg_53_0[1]
			local var_53_1 = var_51_4[var_53_0]
			local var_53_2 = arg_51_0.contextData.editFleet

			var_4.InsertBayShip(var_53_2, arg_51_1, var_53_1)

			return
		end
	})

	return
end

function var_0_1.OnCheckMissionShip(arg_54_0, arg_54_1, arg_54_2)
	getProxy = var_1_10003
	GuildProxy = var_1_10005

	local var_54_0 = var_1_10003(var_1_10005)
	local var_54_1 = var_3.getData(var_54_0)

	getProxy = var_1_10004
	PlayerProxy = var_1_10006

	local var_54_2 = var_1_10004(var_1_10006)
	local var_54_3 = var_4.getRawData(var_54_2).id
	local var_54_4 = var_54_1:getMemberById(var_54_3)
	local var_54_5 = var_5.GetAssaultFleet(var_54_4)
	local var_54_6 = var_5:GetExternalAssaultFleet()
	local var_54_7 = var_54_1
	local var_54_8 = var_54_1.GetActiveEvent(var_54_7)
	local var_54_9 = var_8.GetJoinShips(var_54_8)

	getProxy = var_54_7
	BayProxy = var_1_10012

	local var_54_10 = var_54_7(var_1_10012)
	local var_54_11 = var_10.getData(var_54_10)

	_ = var_1_10012

	local var_54_12 = var_1_10012.map(arg_54_1, function(arg_55_0)
		return var_54_11[arg_55_0]
	end)

	if arg_54_2:isActivityNpc() then
		local var_54_13 = false

		i18n = var_14

		local var_54_14 = var_14("common_npc_formation_tip")

		return
	end

	local var_54_15 = var_8
	local var_54_16 = var_8.GetMissionById(var_54_15, arg_54_0)
	local var_54_17 = var_13.GetMyShips(var_54_16)

	_ = var_54_15

	local var_54_18

	if var_54_15.any(var_54_17, function(arg_56_0)
		local var_56_1

		if var_54_11[arg_56_0] then
			local var_56_0 = var_54_11[arg_56_0]

			var_56_1 = var_1.isSameKind(var_56_0, arg_54_2)
		end

		return var_56_1
	end) then
		var_54_18 = false
		i18n = var_54_16
		var_54_16 = var_54_16("guild_event_exist_same_kind_ship")

		return
	end

	_ = var_54_18

	local var_54_19

	if var_54_18.any(var_54_12, function(arg_57_0)
		return arg_57_0:isSameKind(arg_54_2)
	end) then
		var_54_19 = false
		i18n = var_54_16

		local var_54_20 = var_54_16("guild_event_exist_same_kind_ship")

		return
	end

	GuildAssaultFleet = var_54_19

	local var_54_21 = var_54_19.GetVirtualId(var_54_3, arg_54_2.id)
	local var_54_23

	if var_54_5:ExistShip(var_54_21) then
		local var_54_22 = false

		i18n = var_54_23
		var_54_23 = var_54_23("guild_event_exist_assult_ship")

		return
	end

	local var_54_24

	if var_54_6:ExistShip(var_54_21) then
		var_54_24 = false
		i18n = var_54_23
		var_54_23 = var_54_23("guild_event_exist_assult_ship")

		return
	end

	_ = var_54_24

	if var_54_24.any(var_54_9, function(arg_58_0)
		return arg_54_2.id == arg_58_0
	end) then
		local var_54_25 = false

		i18n = var_54_23

		local var_54_26 = var_54_23("guidl_event_ship_in_event")

		return
	end

	return true
end

function var_0_1.OnSelectMissionShips(arg_59_0, arg_59_1, arg_59_2, arg_59_3)
	local var_59_0

	if not arg_59_0.contextData.missionShips then
		var_59_0 = arg_59_0.contextData
		Clone = var_1_10005
		var_59_0.missionShips = var_1_10005(arg_59_3)
	end

	getProxy = var_59_0
	GuildProxy = var_1_10006

	local var_59_1 = var_59_0(var_1_10006)
	local var_59_2 = var_4.getData(var_59_1)

	getProxy = var_1_10005
	PlayerProxy = var_1_10007

	local var_59_3 = var_1_10005(var_1_10007)
	local var_59_4 = var_5.getRawData(var_59_3).id
	local var_59_5 = var_59_2
	local var_59_6 = var_59_2.getMemberById(var_59_5, var_59_4)
	local var_59_7 = var_6.GetAssaultFleet(var_59_6)

	_ = var_59_5

	local var_59_8 = var_59_5.map(var_59_7:GetShipIds(), function(arg_60_0)
		GuildAssaultFleet = var_2_10001

		return var_2_10001.GetRealId(arg_60_0)
	end)

	_ = var_59_6

	var_59_6.each(arg_59_3, function(arg_61_0)
		table = var_2_10001

		var_2_10001.insert(var_59_8, arg_61_0)

		return
	end)

	local var_59_9 = var_59_2
	local var_59_10 = var_59_2.GetActiveEvent(var_59_9)
	local var_59_11 = var_9.GetJoinShips(var_59_10)

	_ = var_59_9

	var_59_9.each(var_59_11, function(arg_62_0)
		table = var_2_10001

		var_2_10001.insert(var_59_8, arg_62_0)

		return
	end)

	local var_59_12 = arg_59_0
	local var_59_13 = arg_59_0.sendNotification

	GAME = var_14

	local var_59_14 = var_14.GO_SCENE

	SCENE = var_1_10015

	var_59_13(var_59_12, var_59_14, var_1_10015.DOCKYARD, {
		selectedMin = 1,
		selectedMax = 1,
		quitTeam = arg_59_3[arg_59_2],
		ignoredIds = var_59_8,
		onShip = function(arg_63_0)
			return var_0_1.OnCheckMissionShip(arg_59_1, arg_59_3, arg_63_0)
		end,
		onSelected = function(arg_64_0, arg_64_1)
			if arg_59_3[arg_59_2] then
				ipairs = var_2

				for iter_64_0, iter_64_1 in var_2(arg_59_0.contextData.missionShips) do
					if iter_64_1 == arg_59_3[arg_59_2] then
						table = var_7

						var_7.remove(arg_59_0.contextData.missionShips, iter_64_0)
					end
				end
			end

			table = var_2

			var_2.insert(arg_59_0.contextData.missionShips, arg_64_0[1])

			return
		end
	})

	return
end

function var_0_1.OnComanderOP(arg_65_0, arg_65_1)
	local var_65_0 = arg_65_1.data.type

	LevelUIConst = var_1_10004

	local var_65_2

	if var_65_0 == var_1_10004.COMMANDER_OP_RENAME then
		local var_65_1 = var_2.id

		var_65_2 = var_2.str

		local var_65_3 = var_2.onFailed

		var_1_10008 = arg_65_0

		local var_65_4 = arg_65_0.sendNotification

		GAME = var_1_10009

		var_65_4(var_1_10008, var_1_10009.SET_COMMANDER_PREFAB_NAME, {
			id = var_65_1,
			name = var_65_2,
			onFailed = var_65_3
		})
	else
		local var_65_5 = var_2.type

		LevelUIConst = var_65_2

		if var_65_5 == var_65_2.COMMANDER_OP_RECORD_PREFAB then
			local var_65_6 = var_2.id

			var_1_10007 = var_2.fleet

			local var_65_7 = var_4.getCommanders(var_1_10007)

			var_1_10008 = arg_65_0

			local var_65_8 = arg_65_0.sendNotification

			GAME = var_1_10009

			local var_65_9 = var_1_10009.SET_COMMANDER_PREFAB
			local var_65_10 = {
				id = var_65_6
			}

			Clone = var_1_10011
			var_65_10.commanders = var_1_10011(var_65_7)

			var_65_8(var_1_10008, var_65_9, var_65_10)
		else
			local var_65_11 = var_2.id
			local var_65_12 = var_2.fleet

			if not arg_65_0.contextData.editBossFleet then
				arg_65_0.contextData.editBossFleet = {}
			end

			if not arg_65_0.contextData.editBossFleet[var_65_12.id] then
				local var_65_13 = arg_65_0.contextData.editBossFleet
				local var_65_14 = var_65_12.id

				Clone = var_1_10007
				var_65_13[var_65_14] = var_1_10007(var_65_12)
			end

			local var_65_15 = arg_65_0.contextData.editBossFleet[var_65_12.id]
			local var_65_16 = var_2.type

			LevelUIConst = var_1_10007

			if var_65_16 == var_1_10007.COMMANDER_OP_USE_PREFAB then
				getProxy = var_65_16
				GuildProxy = var_1_10008

				local var_65_17 = var_65_16(var_1_10008)
				local var_65_18 = var_6.getData(var_65_17)
				local var_65_19 = var_6.GetActiveEvent(var_65_18)
				local var_65_20 = var_6.GetBossMission(var_65_19)
				local var_65_21 = var_65_15

				var_65_15.ClearCommanders(var_65_21)

				getProxy = var_7
				CommanderProxy = var_65_21

				local var_65_22 = var_7(var_65_21)
				local var_65_23 = var_7.getPrefabFleetById(var_65_22, var_65_11)
				local var_65_24 = var_7.getCommander(var_65_23)
				local var_65_25 = {}

				pairs = var_65_23

				for iter_65_0, iter_65_1 in var_65_23(var_65_24) do
					table = var_1_10015

					var_1_10015.insert(var_65_25, function(arg_66_0)
						local var_66_0 = arg_65_0

						var_1.OnDockSelectCommander(var_66_0, false, var_65_15, iter_65_0, var_65_20, {
							iter_65_1.id
						}, arg_66_0)

						return
					end)
				end

				seriesAsync = var_10

				var_10(var_65_25, function()
					local var_67_0 = arg_65_0.viewComponent

					var_0.OnBossCommanderFormationChange(var_67_0)

					return
				end)
			else
				local var_65_26 = var_2.type

				LevelUIConst = var_7

				if var_65_26 == var_7.COMMANDER_OP_REST_ALL then
					var_65_15:ClearCommanders()

					local var_65_27 = arg_65_0.viewComponent

					var_6.OnBossCommanderFormationChange(var_65_27)
				end
			end
		end
	end

	return
end

function var_0_1.listNotificationInterests(arg_68_0)
	local var_68_0 = {}

	PlayerProxy = var_1_10002
	var_68_0[1] = var_1_10002.UPDATED
	GuildProxy = var_2
	var_68_0[2] = var_2.GUILD_UPDATED
	GAME = var_2
	var_68_0[3] = var_2.GUILD_ACTIVE_EVENT_DONE
	GuildProxy = var_2
	var_68_0[4] = var_2.GUILD_BATTLE_STARTED
	GAME = var_2
	var_68_0[5] = var_2.GUILD_UPDATE_MY_ASSAULT_FLEET_DONE
	GAME = var_2
	var_68_0[6] = var_2.GUILD_JOIN_MISSION_DONE
	GAME = var_2
	var_68_0[7] = var_2.GUILD_REFRESH_MISSION_DONE
	GAME = var_2
	var_68_0[8] = var_2.GUILD_GET_BOSS_INFO_DONE
	GAME = var_2
	var_68_0[9] = var_2.GET_GUILD_BOSS_RANK_DONE
	GAME = var_2
	var_68_0[10] = var_2.GUILD_UPDATE_NODE_ANIM_FLAG_DONE
	GAME = var_2
	var_68_0[11] = var_2.GUILD_UPDATE_BOSS_FORMATION_DONE
	GAME = var_2
	var_68_0[12] = var_2.GUILD_GET_ASSAULT_FLEET_DONE
	GAME = var_2
	var_68_0[13] = var_2.GUILD_GET_MY_ASSAULT_FLEET_DONE
	GAME = var_2
	var_68_0[14] = var_2.SUBMIT_GUILD_REPORT_DONE
	GAME = var_2
	var_68_0[15] = var_2.ON_GUILD_JOIN_EVENT_DONE
	GAME = var_2
	var_68_0[16] = var_2.GUILD_END_BATTLE
	GuildProxy = var_2
	var_68_0[17] = var_2.ON_EXIST_DELETED_MEMBER
	GAME = var_2
	var_68_0[18] = var_2.GUILD_RECOMMAND_ASSULT_SHIP_DONE
	GAME = var_2
	var_68_0[19] = var_2.REFRESH_ALL_ASSULT_SHIP_RECOMMAND_STATE_DONE
	TaskProxy = var_2
	var_68_0[20] = var_2.TASK_PROGRESS_UPDATE
	GAME = var_2
	var_68_0[21] = var_2.SET_COMMANDER_PREFAB_NAME_DONE
	GAME = var_2
	var_68_0[22] = var_2.SET_COMMANDER_PREFAB_DONE
	GAME = var_2
	var_68_0[23] = var_2.ON_GUILD_EVENT_END

	return var_68_0
end

function var_0_1.handleNotification(arg_69_0, arg_69_1)
	local var_69_0 = arg_69_1
	local var_69_1 = arg_69_1.getName(var_69_0)
	local var_69_2 = arg_69_1
	local var_69_3 = arg_69_1.getBody(var_69_2)

	PlayerProxy = var_69_0

	if var_69_1 == var_69_0.UPDATED then
		var_1_10006 = arg_69_0.viewComponent

		var_4.SetPlayer(var_1_10006, var_69_3)

		goto label_69_0
	end

	GuildProxy = var_4

	if var_69_1 == var_4.GUILD_UPDATED then
		var_1_10006 = arg_69_0.viewComponent

		var_4.UpdateGuild(var_1_10006, var_69_3)

		goto label_69_0
	end

	GAME = var_4

	local var_69_4

	if var_69_1 == var_4.GUILD_ACTIVE_EVENT_DONE then
		var_1_10006 = arg_69_0
		var_69_4 = arg_69_0.sendNotification
		GAME = var_1_10007

		var_69_4(var_1_10006, var_1_10007.GUILD_GET_ACTIVATION_EVENT, {
			force = true,
			callback = function()
				local var_70_0 = arg_69_0.viewComponent

				var_0.EnterEvent(var_70_0)

				return
			end
		})

		goto label_69_0
	end

	GAME = var_69_4

	local var_69_5

	if var_69_1 == var_69_4.GUILD_UPDATE_MY_ASSAULT_FLEET_DONE then
		var_69_5 = arg_69_0.contextData
		var_69_5.editFleet = nil
		var_1_10006 = arg_69_0.viewComponent

		var_69_5.OnMyAssultFleetFormationDone(var_1_10006)

		pg = var_69_5
		var_1_10006 = var_69_5.TipsMgr.GetInstance()
		var_69_5 = var_69_5.ShowTips
		i18n = var_1_10007

		var_69_5(var_1_10006, var_1_10007("guild_event_start_done"))

		goto label_69_0
	end

	GAME = var_69_5

	local var_69_6

	if var_69_1 == var_69_5.GUILD_JOIN_MISSION_DONE then
		var_69_6 = arg_69_0.contextData
		var_69_6.missionShips = nil
		var_1_10006 = arg_69_0
		var_69_6 = arg_69_0.sendNotification
		GAME = var_1_10007

		var_69_6(var_1_10006, var_1_10007.GUILD_REFRESH_MISSION, {
			force = true,
			id = var_69_3.id
		})

		var_1_10006 = arg_69_0.viewComponent

		var_69_6.OnMissionFormationDone(var_1_10006)

		goto label_69_0
	end

	GAME = var_69_6

	if var_69_1 == var_69_6.GUILD_REFRESH_MISSION_DONE then
		var_1_10006 = arg_69_0.viewComponent

		var_4.RefreshMission(var_1_10006, var_69_3.id)

		goto label_69_0
	end

	GAME = var_4

	if var_69_1 == var_4.GUILD_GET_BOSS_INFO_DONE then
		var_1_10006 = arg_69_0.viewComponent

		var_4.RefreshBossMission(var_1_10006)

		goto label_69_0
	end

	GAME = var_4

	if var_69_1 == var_4.GET_GUILD_BOSS_RANK_DONE then
		var_1_10006 = arg_69_0.viewComponent

		var_4.OnBossRankUpdate(var_1_10006)

		goto label_69_0
	end

	GAME = var_4

	if var_69_1 == var_4.GUILD_UPDATE_NODE_ANIM_FLAG_DONE then
		var_1_10006 = arg_69_0.viewComponent

		var_4.RefreshMission(var_1_10006, var_69_3.id)

		goto label_69_0
	end

	GAME = var_4

	local var_69_7

	if var_69_1 == var_4.GUILD_UPDATE_BOSS_FORMATION_DONE then
		var_69_7 = arg_69_0.contextData
		var_69_7.editBossFleet = nil
		pg = var_69_7
		var_1_10006 = var_69_7.TipsMgr.GetInstance()
		var_69_7 = var_69_7.ShowTips
		i18n = var_1_10007

		var_69_7(var_1_10006, var_1_10007("guild_fleet_update_done"))

		var_1_10006 = arg_69_0.viewComponent

		var_69_7.OnBossMissionFormationChanged(var_1_10006)

		goto label_69_0
	end

	GAME = var_69_7

	if var_69_1 == var_69_7.GUILD_GET_ASSAULT_FLEET_DONE then
		var_1_10006 = arg_69_0.viewComponent

		var_4.OnMemberAssultFleetUpdate(var_1_10006)

		goto label_69_0
	end

	GAME = var_4

	if var_69_1 == var_4.GUILD_GET_MY_ASSAULT_FLEET_DONE then
		var_1_10006 = arg_69_0.viewComponent

		var_4.OnMyAssultFleetUpdate(var_1_10006)

		goto label_69_0
	end

	GAME = var_4

	if var_69_1 == var_4.SUBMIT_GUILD_REPORT_DONE then
		var_1_10006 = arg_69_0.viewComponent

		var_4.OnReportUpdated(var_1_10006)

		goto label_69_0
	end

	GuildProxy = var_4

	local var_69_10

	if var_69_1 == var_4.GUILD_BATTLE_STARTED then
		getProxy = var_69_10
		GuildProxy = var_1_10006

		local var_69_8 = var_69_10(var_1_10006)
		local var_69_9 = var_69_10.getRawData(var_69_8)

		var_69_10 = var_69_10.IsAdministrator(var_69_9)
		i18n = var_69_2

		local var_69_11 = var_69_2("guild_event_start_tip1")

		if var_69_10 and arg_69_0.viewComponent.eventInfoPage then
			local var_69_12 = arg_69_0.viewComponent.eventInfoPage

			if var_69_9.GetLoaded(var_69_12) then
				local var_69_13 = arg_69_0.viewComponent.eventInfoPage

				if var_69_9.isShowing(var_69_13) then
					i18n = var_69_9
					var_69_11 = var_69_9("guild_event_start_tip2")
				end
			end
		end

		pg = var_69_9

		local var_69_14 = var_69_9.MsgboxMgr.GetInstance()

		var_6.ShowMsgBox(var_69_14, {
			hideNo = true,
			content = var_69_11,
			onYes = function()
				local var_71_0 = arg_69_0
				local var_71_1 = var_0.sendNotification

				GAME = var_2_10003

				var_71_1(var_71_0, var_2_10003.GUILD_GET_ACTIVATION_EVENT, {
					force = true,
					callback = function()
						local var_72_0 = arg_69_0.viewComponent

						var_0.EnterEvent(var_72_0)

						return
					end
				})

				return
			end
		})

		goto label_69_0
	end

	GAME = var_69_10

	if var_69_1 == var_69_10.ON_GUILD_JOIN_EVENT_DONE then
		local var_69_15 = arg_69_0.viewComponent

		var_4.EnterEvent(var_69_15)

		goto label_69_0
	end

	GAME = var_4

	if var_69_1 == var_4.GUILD_END_BATTLE then
		local var_69_16 = arg_69_0.viewComponent

		var_4.EnterEvent(var_69_16)

		goto label_69_0
	end

	GuildProxy = var_4

	if var_69_1 == var_4.ON_EXIST_DELETED_MEMBER then
		local var_69_17 = arg_69_0.viewComponent

		var_4.OnMemberDeleted(var_69_17)

		goto label_69_0
	end

	GAME = var_4

	if var_69_1 == var_4.GUILD_RECOMMAND_ASSULT_SHIP_DONE then
		local var_69_18 = arg_69_0.viewComponent

		var_4.OnAssultShipBeRecommanded(var_69_18, var_69_3.shipId)

		goto label_69_0
	end

	GAME = var_4

	if var_69_1 == var_4.REFRESH_ALL_ASSULT_SHIP_RECOMMAND_STATE_DONE then
		local var_69_19 = arg_69_0.viewComponent

		var_4.OnRefreshAllAssultShipRecommandState(var_69_19)

		goto label_69_0
	end

	TaskProxy = var_4

	if var_69_1 == var_4.TASK_PROGRESS_UPDATE then
		pg = var_4

		local var_69_20 = var_4.GuildMsgBoxMgr.GetInstance()

		var_4.NotificationForGuildEvent(var_69_20, var_69_3)

		goto label_69_0
	end

	GAME = var_4

	if var_69_1 ~= var_4.SET_COMMANDER_PREFAB_NAME_DONE then
		GAME = var_4

		if var_69_1 == var_4.SET_COMMANDER_PREFAB_DONE then
			local var_69_21 = arg_69_0.viewComponent

			var_4.OnBossCommanderPrefabFormationChange(var_69_21)
		else
			GAME = var_4

			if var_69_1 == var_4.ON_GUILD_EVENT_END then
				local var_69_22 = arg_69_0.viewComponent

				var_4.OnEventEnd(var_69_22)
			end
		end

		::label_69_0::

		return
	end
end

return var_0_1

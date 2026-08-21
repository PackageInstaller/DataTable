local var_0_0 = class("GuildEventMediator", import("...base.ContextMediator"))

var_0_0.ON_ACTIVE_EVENT = "GuildEventMediator:ON_ACTIVE_EVENT"
var_0_0.ON_OPEN_REPORT = "GuildEventMediator:ON_OPEN_REPORT"
var_0_0.ON_GET_FORMATION = "GuildEventMediator:ON_GET_FORMATION"
var_0_0.UPDATE_FORMATION = "GuildEventMediator:UPDATE_FORMATION"
var_0_0.ON_SELECT_SHIP = "GuildEventMediator:ON_SELECT_SHIP"
var_0_0.ON_SELECT_MISSION_SHIP = "GuildEventMediator:ON_SELECT_MISSION_SHIP"
var_0_0.REFRESH_MISSION = "GuildEventMediator:REFRESH_MISSION"
var_0_0.JOIN_MISSION = "GuildEventMediator:JOIN_MISSION"
var_0_0.ON_GET_BOSS_INFO = "GuildEventMediator:ON_GET_BOSS_INFO"
var_0_0.ON_REFRESH_BOSS_RANK = "GuildEventMediator:ON_REFRESH_BOSS_RANK"
var_0_0.ON_UPDATE_NODE_ANIM_FLAG = "GuildEventMediator:ON_UPDATE_NODE_ANIM_FLAG"
var_0_0.ON_SELECT_BOSS_SHIP = "GuildEventMediator:ON_SELECT_BOSS_SHIP"
var_0_0.ON_UPDATE_BOSS_FLEET = "GuildEventMediator:ON_UPDATE_BOSS_FLEET"
var_0_0.ON_RECOMM_BOSS_BATTLE_SHIPS = "GuildEventMediator:ON_RECOMM_BOSS_BATTLE_SHIPS"
var_0_0.ON_GET_ALL_ASSULT_FLEET = "GuildEventMediator:ON_GET_ALL_ASSULT_FLEET"
var_0_0.ON_SELECT_COMMANDER = "GuildEventMediator:ON_SELECT_COMMANDER"
var_0_0.FORCE_REFRESH_MISSION = "GuildEventMediator:FORCE_REFRESH_MISSION"
var_0_0.ON_SAVE_FORMATION = "GuildEventMediator:ON_SAVE_FORMATION"
var_0_0.ON_JOIN_EVENT = "GuildEventMediator:ON_JOIN_EVENT"
var_0_0.ON_RECOMM_ASSULT_SHIP = "GuildEventMediator:ON_RECOMM_ASSULT_SHIP"
var_0_0.REFRESH_RECOMMAND_SHIPS = "GuildEventMediator:REFRESH_RECOMMAND_SHIPS"
var_0_0.ON_CLEAR_BOSS_FLEET_INVAILD_SHIP = "GuildEventMediator:ON_CLEAR_BOSS_FLEET_INVAILD_SHIP"
var_0_0.ON_CMD_SKILL = "GuildEventMediator:ON_CMD_SKILL"
var_0_0.COMMANDER_FORMATION_OP = "GuildEventMediator:COMMANDER_FORMATION_OP"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.COMMANDER_FORMATION_OP, function(arg_2_0, arg_2_1)
		arg_1_0:OnComanderOP(arg_2_1)

		return
	end)
	arg_1_0:bind(var_0_0.ON_CMD_SKILL, function(arg_3_0, arg_3_1)
		arg_1_0:addSubLayers(Context.New({
			mediator = CommanderSkillMediator,
			viewComponent = CommanderSkillLayer,
			data = {
				skill = arg_3_1
			}
		}))

		return
	end)
	arg_1_0:bind(var_0_0.REFRESH_RECOMMAND_SHIPS, function(arg_4_0, arg_4_1)
		arg_1_0:sendNotification(GAME.REFRESH_ALL_ASSULT_SHIP_RECOMMAND_STATE, {
			callback = arg_4_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_RECOMM_ASSULT_SHIP, function(arg_5_0, arg_5_1, arg_5_2)
		arg_1_0:sendNotification(GAME.GUILD_RECOMMAND_ASSULT_SHIP, {
			shipId = arg_5_1,
			cmd = arg_5_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_JOIN_EVENT, function()
		arg_1_0:sendNotification(GAME.ON_GUILD_JOIN_EVENT)

		return
	end)
	arg_1_0:bind(var_0_0.ON_SELECT_COMMANDER, function(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
		arg_1_0:SelectBossBattleCommander(arg_7_1, arg_7_2, arg_7_3)

		return
	end)
	arg_1_0:bind(var_0_0.ON_GET_ALL_ASSULT_FLEET, function(arg_8_0, arg_8_1)
		arg_1_0:sendNotification(GAME.GUILD_GET_ASSAULT_FLEET, {
			callback = arg_8_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_RECOMM_BOSS_BATTLE_SHIPS, function(arg_9_0, arg_9_1)
		arg_1_0:sendNotification(GAME.GUILD_GET_ASSAULT_FLEET, {
			callback = function()
				arg_1_0:RecommShipsForBossBattle(arg_9_1)

				return
			end
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_SAVE_FORMATION, function(arg_11_0, arg_11_1)
		arg_1_0:sendNotification(GAME.GUILD_UPDATE_BOSS_FORMATION, {
			editFleet = arg_1_0.contextData.editBossFleet,
			callback = arg_11_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_CLEAR_BOSS_FLEET_INVAILD_SHIP, function(arg_12_0)
		arg_1_0:sendNotification(GAME.GUILD_UPDATE_BOSS_FORMATION, {
			force = true,
			editFleet = arg_1_0.contextData.editBossFleet
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_UPDATE_BOSS_FLEET, function(arg_13_0)
		if not arg_1_0.contextData.editBossFleet then
			arg_1_0:StartBossBattle()
		else
			arg_1_0.viewComponent:emit(var_0_0.ON_SAVE_FORMATION, function()
				arg_1_0:StartBossBattle()

				return
			end)
		end

		return
	end)
	arg_1_0:bind(var_0_0.ON_SELECT_BOSS_SHIP, function(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
		arg_1_0:sendNotification(GAME.GUILD_GET_ASSAULT_FLEET, {
			callback = function()
				arg_1_0:SelectBossBattleShip(arg_15_1, arg_15_2, arg_15_3)

				return
			end
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_UPDATE_NODE_ANIM_FLAG, function(arg_17_0, arg_17_1, arg_17_2)
		arg_1_0:sendNotification(GAME.GUILD_UPDATE_NODE_ANIM_FLAG, {
			id = arg_17_1,
			position = arg_17_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_REFRESH_BOSS_RANK, function(arg_18_0)
		arg_1_0:sendNotification(GAME.GET_GUILD_BOSS_RANK, {})

		return
	end)
	arg_1_0:bind(var_0_0.ON_GET_BOSS_INFO, function(arg_19_0)
		arg_1_0:sendNotification(GAME.GUILD_GET_BOSS_INFO)

		return
	end)
	arg_1_0:bind(var_0_0.JOIN_MISSION, function(arg_20_0, arg_20_1, arg_20_2)
		arg_1_0:sendNotification(GAME.GUILD_JOIN_MISSION, {
			id = arg_20_1,
			shipIds = arg_20_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_SELECT_MISSION_SHIP, function(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
		arg_1_0.viewComponent:emit(var_0_0.ON_GET_FORMATION, function()
			arg_1_0:OnSelectMissionShips(arg_21_1, arg_21_2, arg_21_3)

			return
		end)

		return
	end)
	arg_1_0:bind(var_0_0.REFRESH_MISSION, function(arg_23_0, arg_23_1, arg_23_2)
		arg_1_0:sendNotification(GAME.GUILD_REFRESH_MISSION, {
			force = false,
			id = arg_23_1,
			callback = arg_23_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.FORCE_REFRESH_MISSION, function(arg_24_0, arg_24_1, arg_24_2)
		arg_1_0:sendNotification(GAME.GUILD_REFRESH_MISSION, {
			force = true,
			id = arg_24_1,
			callback = arg_24_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_SELECT_SHIP, function(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
		arg_1_0:OnSelectShips(arg_25_1, arg_25_2, arg_25_3)

		return
	end)
	arg_1_0:bind(var_0_0.ON_GET_FORMATION, function(arg_26_0, arg_26_1)
		if getProxy(GuildProxy):getRawData():GetActiveEvent() then
			table.insert({}, function(arg_27_0)
				arg_1_0.viewComponent:emit(var_0_0.ON_GET_ALL_ASSULT_FLEET, arg_27_0)

				return
			end)
		end

		if not getProxy(GuildProxy).isFetchAssaultFleet then
			table.insert({}, function(arg_28_0)
				arg_1_0:sendNotification(GAME.GUILD_GET_MY_ASSAULT_FLEET, {
					callback = arg_28_0
				})

				return
			end)
		end

		seriesAsync({}, arg_26_1)

		return
	end)
	arg_1_0:bind(var_0_0.UPDATE_FORMATION, function(arg_29_0)
		if not arg_1_0.contextData.editFleet then
			return
		end

		arg_1_0:sendNotification(GAME.GUILD_UPDATE_MY_ASSAULT_FLEET, {
			fleet = arg_1_0.contextData.editFleet
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_ACTIVE_EVENT, function(arg_30_0, arg_30_1)
		arg_1_0:sendNotification(GAME.GUILD_ACTIVE_EVENT, {
			eventId = arg_30_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_OPEN_REPORT, function(arg_31_0)
		arg_1_0:sendNotification(GAME.GUILD_OPEN_EVENT_REPORT)

		return
	end)
	arg_1_0.viewComponent:SetPlayer(getProxy(PlayerProxy):getRawData())
	arg_1_0.viewComponent:SetGuild(getProxy(GuildProxy):getData())

	return
end

function var_0_0.StartBossBattle(arg_32_0)
	local var_32_0 = getProxy(GuildProxy):getRawData():GetActiveEvent()

	if not var_32_0 or var_32_0 and var_32_0:IsExpired() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("guild_battle_is_end"))

		return
	end

	local var_32_1 = var_32_0:GetBossMission()

	if not var_32_1 then
		return
	end

	local var_32_2 = var_32_1:GetMainFleet()
	local var_32_3, var_32_4 = var_32_2:IsLegal()

	if not var_32_3 then
		pg.TipsMgr.GetInstance():ShowTips(var_32_4)

		return
	end

	local var_32_5, var_32_6 = var_32_1:GetSubFleet():IsLegal()

	if not var_32_5 then
		pg.TipsMgr.GetInstance():ShowTips(var_32_6)

		return
	end

	for iter_32_0, iter_32_1 in ipairs((var_32_2:GetDownloadResShips())) do
		PaintingGroupConst.AddPaintingNameWithFilteMap({}, iter_32_1)
	end

	PaintingGroupConst.PaintingDownload({
		isShowBox = true,
		paintingNameList = {},
		finishFunc = function()
			arg_32_0:sendNotification(GAME.BEGIN_STAGE, {
				system = SYSTEM_GUILD
			})

			return
		end
	})

	return
end

function var_0_0.SelectBossBattleCommander(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
	arg_34_0.contextData.editBossFleet = arg_34_0.contextData.editBossFleet or {}

	local var_34_0 = getProxy(GuildProxy):getData():GetActiveEvent()

	if not var_34_0 then
		return
	end

	local var_34_1 = var_34_0:GetBossMission()

	arg_34_0.contextData.editBossFleet[arg_34_1] = arg_34_0.contextData.editBossFleet[arg_34_1] or Clone(var_34_1:GetFleetByIndex(arg_34_1))

	local var_34_2 = arg_34_0.contextData.editBossFleet[arg_34_1]:getCommanders()

	if arg_34_3 then
		table.insert({}, arg_34_3.id)
	end

	pg.m02:sendNotification(GAME.GO_SCENE, SCENE.COMMANDERCAT, {
		maxCount = 1,
		mode = CommanderCatScene.MODE_SELECT,
		fleetType = CommanderCatScene.FLEET_TYPE_GUILDBOSS,
		activeCommander = arg_34_3,
		ignoredIds = {},
		fleets = arg_34_0.contextData.editBossFleet,
		onCommander = function(arg_35_0)
			return true
		end,
		onSelected = function(arg_36_0, arg_36_1)
			arg_34_0:OnDockSelectCommander(true, var_0, arg_34_2, var_34_1, arg_36_0, arg_36_1)

			return
		end,
		onQuit = function(arg_37_0)
			var_0:RemoveCommander(arg_34_2)
			arg_37_0()

			return
		end
	})

	return
end

function var_0_0.OnDockSelectCommander(arg_38_0, arg_38_1, arg_38_2, arg_38_3, arg_38_4, arg_38_5, arg_38_6)
	local var_38_0 = getProxy(CommanderProxy):getCommanderById(arg_38_5[1])

	if not var_38_0 then
		arg_38_6()

		return
	end

	local var_38_3 = arg_38_0.contextData.editBossFleet[GuildBossMission.SUB_FLEET_ID] or arg_38_4:GetSubFleet()
	local var_38_4 = arg_38_0.contextData.editBossFleet[GuildBossMission.MAIN_FLEET_ID] or arg_38_4:GetMainFleet()
	local var_38_5 = arg_38_2:IsMainFleet()
	local var_38_6 = var_38_5 and var_38_4 or var_38_3
	local var_38_7 = (var_38_5 and var_38_4 or var_38_3):getCommanders()

	if arg_38_1 then
		for iter_38_0, iter_38_1 in pairs(var_38_7) do
			if arg_38_3 ~= iter_38_0 and iter_38_1:isSameGroup(var_38_0.groupId) then
				pg.TipsMgr.GetInstance():ShowTips(i18n("commander_can_not_select_same_group"))

				return
			end
		end
	end

	local var_38_8 = var_38_5 and var_38_3 or var_38_4

	for iter_38_2, iter_38_3 in pairs(((var_38_5 and var_38_3 or var_38_4):getCommanders())) do
		if iter_38_3.id == var_38_0.id then
			arg_38_0:SwopCommanderForBossBattle(arg_38_4, var_38_0, arg_38_3, iter_38_2, var_38_6, var_38_8, arg_38_6)

			return
		end
	end

	arg_38_2:AddCommander(arg_38_3, var_38_0)
	arg_38_6()

	return
end

function var_0_0.SwopCommanderForBossBattle(arg_39_0, arg_39_1, arg_39_2, arg_39_3, arg_39_4, arg_39_5, arg_39_6, arg_39_7)
	if not arg_39_0.contextData.editBossFleet[arg_39_6.id] then
		arg_39_0.contextData.editBossFleet[arg_39_6.id] = Clone(arg_39_1:GetFleetByIndex(arg_39_6.id))
		arg_39_6 = arg_39_0.contextData.editBossFleet[arg_39_6.id]
	end

	local var_39_0 = arg_39_4 == 1 and i18n("commander_main_pos") or i18n("commander_assistant_pos")

	pg.MsgboxMgr.GetInstance():ShowMsgBox({
		content = i18n("comander_repalce_tip", arg_39_5:GetName(), var_39_0),
		onYes = function()
			arg_39_6:RemoveCommander(arg_39_4)
			arg_39_5:AddCommander(arg_39_3, arg_39_2)

			if arg_39_7 then
				arg_39_7()
			end

			return
		end
	})

	return
end

function var_0_0.RecommShipsForBossBattle(arg_41_0, arg_41_1)
	local var_41_9000

	arg_41_0.contextData.editBossFleet = arg_41_0.contextData.editBossFleet or {}

	local var_41_0 = {}
	local var_41_1 = {}
	local var_41_2 = {}
	local var_41_3 = getProxy(GuildProxy)
	local var_41_4 = getProxy(PlayerProxy):getRawData()

	if not var_41_3 then
		return
	end

	local var_41_5 = var_41_3.getData(var_41_9000):GetActiveEvent():GetBossMission()

	arg_41_0.contextData.editBossFleet[arg_41_1] = arg_41_0.contextData.editBossFleet[arg_41_1] or Clone(var_41_5:GetFleetByIndex(arg_41_1))

	local var_41_6 = arg_41_0.contextData.editBossFleet[arg_41_1]

	arg_41_0.contextData.editBossFleet[arg_41_1]:RemoveAll()

	for iter_41_0, iter_41_1 in pairs((getProxy(BayProxy):getData())) do
		local var_41_7 = pg.ShipFlagMgr.GetInstance()

		if not var_41_7:GetShipFlag(iter_41_1.id, "inEvent") and not iter_41_1:isActivityNpc() then
			iter_41_1.id = GuildAssaultFleet.GetVirtualId(var_41_4.id, iter_41_1.id)

			;(function(arg_42_0, arg_42_1)
				if arg_42_0 == TeamType.Main then
					table.insert(var_41_0, arg_42_1)
				elseif arg_42_0 == TeamType.Vanguard then
					table.insert(var_41_1, arg_42_1)
				elseif arg_42_0 == TeamType.Submarine then
					table.insert(var_41_2, arg_42_1)
				end

				return
			end)(iter_41_1:getTeamType(), {
				power = iter_41_1:getShipCombatPower(),
				id = iter_41_1.id
			})
		end
	end

	local var_41_8 = 0
	local var_41_9 = 0
	local var_41_10 = 0

	if var_41_6:IsMainFleet() then
		table.sort(var_41_0, function(arg_44_0, arg_44_1)
			return arg_44_0.power > arg_44_1.power
		end)
		table.sort({}, function(arg_45_0, arg_45_1)
			return arg_45_0.power > arg_45_1.power
		end)

		for iter_41_2 = 1, #var_41_0 do
			if 0 == 3 then
				break
			end

			;(function(arg_43_0, arg_43_1)
				local var_43_0 = GuildAssaultFleet.GetRealId(arg_43_0)

				if not var_41_6:ExistSameKindShip(var_0[var_43_0]) then
					var_41_6:AddUserShip(GuildAssaultFleet.GetUserId(arg_43_0), var_43_0)

					if arg_43_1 == TeamType.Main then
						var_41_8 = var_41_8 + 1
					end

					if arg_43_1 == TeamType.Vanguard then
						var_41_9 = var_41_9 + 1
					end

					if arg_43_1 == TeamType.Submarine then
						var_41_10 = var_41_10 + 1
					end
				end

				return
			end)(var_41_0[iter_41_2].id, TeamType.Main)
		end

		for iter_41_3 = 1, #{} do
			if 0 == 3 then
				break
			end

			;(function(arg_43_0, arg_43_1)
				local var_43_0 = GuildAssaultFleet.GetRealId(arg_43_0)

				if not var_41_6:ExistSameKindShip(var_0[var_43_0]) then
					var_41_6:AddUserShip(GuildAssaultFleet.GetUserId(arg_43_0), var_43_0)

					if arg_43_1 == TeamType.Main then
						var_41_8 = var_41_8 + 1
					end

					if arg_43_1 == TeamType.Vanguard then
						var_41_9 = var_41_9 + 1
					end

					if arg_43_1 == TeamType.Submarine then
						var_41_10 = var_41_10 + 1
					end
				end

				return
			end)(({})[iter_41_3].id, TeamType.Vanguard)
		end
	else
		table.sort({}, function(arg_46_0, arg_46_1)
			return arg_46_0.power > arg_46_1.power
		end)

		for iter_41_4 = 1, #{} do
			if 0 == 3 then
				break
			end

			;(function(arg_43_0, arg_43_1)
				local var_43_0 = GuildAssaultFleet.GetRealId(arg_43_0)

				if not var_41_6:ExistSameKindShip(var_0[var_43_0]) then
					var_41_6:AddUserShip(GuildAssaultFleet.GetUserId(arg_43_0), var_43_0)

					if arg_43_1 == TeamType.Main then
						var_41_8 = var_41_8 + 1
					end

					if arg_43_1 == TeamType.Vanguard then
						var_41_9 = var_41_9 + 1
					end

					if arg_43_1 == TeamType.Submarine then
						var_41_10 = var_41_10 + 1
					end
				end

				return
			end)(({})[iter_41_4].id, TeamType.Submarine)
		end
	end

	if arg_41_0.viewComponent.missBossForamtionPage and var_41_11:GetLoaded() then
		var_41_11:UpdateFleet(arg_41_1)
	end

	return
end

function var_0_0.SelectBossBattleShip(arg_47_0, arg_47_1, arg_47_2, arg_47_3)
	arg_47_0.contextData.editBossFleet = arg_47_0.contextData.editBossFleet or {}

	local var_47_0 = {}
	local var_47_1 = getProxy(GuildProxy):getData()
	local var_47_2 = var_47_1:GetActiveEvent()

	if not var_47_2 then
		return
	end

	local var_47_3 = var_47_2:GetBossMission()
	local var_47_4 = var_47_3:GetFleetByIndex(arg_47_2)

	assert(var_47_4, arg_47_2)

	local var_47_5 = not arg_47_0.contextData.editBossFleet[arg_47_2] and Clone(var_47_4) or Clone(arg_47_0.contextData.editBossFleet[arg_47_2])
	local var_47_6

	if arg_47_3 then
		var_47_6 = var_47_5:RemoveUserShip(arg_47_3.member.id, (GuildAssaultFleet.GetRealId(arg_47_3.ship.id)))
	end

	local var_47_7 = getProxy(PlayerProxy):getRawData()
	local var_47_8 = 0

	if var_47_5:IsMainFleet() then
		if not arg_47_0.contextData.editBossFleet[GuildBossMission.SUB_FLEET_ID] then
			-- block empty
		end

		var_47_8 = var_47_3:GetFleetByIndex(GuildBossMission.SUB_FLEET_ID):GetOtherMemberShipCnt(var_47_7.id)
	else
		if not arg_47_0.contextData.editBossFleet[GuildBossMission.MAIN_FLEET_ID] then
			-- block empty
		end

		var_47_8 = var_47_3:GetFleetByIndex(GuildBossMission.MAIN_FLEET_ID):GetOtherMemberShipCnt(var_47_7.id)
	end

	local var_47_11

	for iter_47_0, iter_47_1 in pairs(var_47_1.member) do
		local var_47_12 = iter_47_1:GetAssaultFleet()

		if var_47_7.id ~= iter_47_1.id then
			for iter_47_2, iter_47_3 in pairs((var_47_12:GetShipList())) do
				if iter_47_3:getTeamType() == arg_47_1 then
					iter_47_3.user = iter_47_1

					table.insert(var_47_0, iter_47_3)
				end
			end
		else
			var_47_11 = var_47_12
		end
	end

	for iter_47_4, iter_47_5 in pairs((getProxy(BayProxy):getData())) do
		iter_47_5.user = var_47_7

		local var_47_13 = var_47_11:GetShipByRealId(var_47_7.id, iter_47_5.id)

		iter_47_5.id = GuildAssaultFleet.GetVirtualId(var_47_7.id, iter_47_5.id)

		if var_47_13 then
			iter_47_5.guildRecommand = var_47_13.guildRecommand
		end

		table.insert(var_47_0, GuildAssaultShip.ConverteFromShip(iter_47_5))
	end

	if arg_47_3 then
		table.insert({}, arg_47_3.ship.id)
	end

	for iter_47_6, iter_47_7 in ipairs(var_47_5:GetShipIds()) do
		if iter_47_7 then
			table.insert({}, GuildAssaultFleet.GetVirtualId(iter_47_7.uid, iter_47_7.id))
		end
	end

	local var_47_14 = var_47_5:GetShips()

	arg_47_0:sendNotification(GAME.GO_SCENE, SCENE.DOCKYARD, {
		selectedMin = 1,
		selectedMax = 1,
		quitTeam = arg_47_3,
		ignoredIds = {},
		teamFilter = arg_47_1,
		shipVOs = var_47_0,
		mode = DockyardScene.MODE_GUILD_BOSS,
		hideTagFlags = ShipStatus.TAG_HIDE_CHALLENGE,
		onShip = function(arg_48_0, arg_48_1, arg_48_2)
			if var_47_5:GetOtherMemberShipCnt(var_47_7.id) + var_47_8 >= 3 and arg_48_0.user.id ~= var_47_7.id then
				local var_48_1 = i18n("guild_boss_formation_1")

				return
			end

			if arg_48_0.user.id ~= var_47_7.id and var_47_5:ExistUserShip(arg_48_0.user.id) then
				local var_48_3 = i18n("guild_boss_formation_2")

				return
			end

			if _.any(var_47_14, function(arg_49_0)
				return arg_49_0.ship:isSameKind(arg_48_0)
			end) then
				local var_48_5 = i18n("guild_boss_formation_3")

				return
			end

			if pg.ShipFlagMgr.GetInstance():GetShipFlag(GuildAssaultFleet.GetRealId(arg_48_0.id), "inEvent") then
				local var_48_7 = i18n("word_shipState_collect")

				return
			end

			if arg_48_0:isActivityNpc() then
				local var_48_9 = i18n("common_npc_formation_tip")

				return
			end

			return true
		end,
		onSelected = function(arg_50_0, arg_50_1)
			if arg_50_0[1] then
				var_47_5:AddUserShip(GuildAssaultFleet.GetUserId(arg_50_0[1]), GuildAssaultFleet.GetRealId(arg_50_0[1]), var_47_6)
			end

			arg_47_0.contextData.editBossFleet[arg_47_2] = var_47_5

			return
		end
	})

	return
end

function var_0_0.OnSelectShips(arg_51_0, arg_51_1, arg_51_2, arg_51_3)
	local var_51_0 = arg_51_3:GetShipList()

	arg_51_0.contextData.editFleet = Clone(arg_51_3)

	local var_51_1 = getProxy(BayProxy):getData()

	if arg_51_2 then
		table.insert({}, arg_51_2.id)
	end

	arg_51_0:sendNotification(GAME.GO_SCENE, SCENE.DOCKYARD, {
		selectedMin = 1,
		selectedMax = 1,
		ignoredIds = {},
		onShip = function(arg_52_0, arg_52_1, arg_52_2)
			for iter_52_0, iter_52_1 in pairs(var_51_0) do
				local var_52_0 = GuildAssaultFleet.GetRealId(iter_52_1.id)

				if iter_52_0 ~= arg_51_1 and var_52_0 == arg_52_0.id then
					local var_52_2 = i18n("guild_fleet_exist_same_kind_ship")

					return
				end
			end

			if arg_52_0:isActivityNpc() then
				local var_52_4 = i18n("common_npc_formation_tip")

				return
			end

			return true
		end,
		onSelected = function(arg_53_0, arg_53_1)
			arg_51_0.contextData.editFleet:InsertBayShip(arg_51_1, var_51_1[arg_53_0[1]])

			return
		end
	})

	return
end

function var_0_0.OnCheckMissionShip(arg_54_0, arg_54_1, arg_54_2)
	local var_54_9000
	local var_54_0 = getProxy(GuildProxy)
	local var_54_1 = var_54_0.getData(var_54_9000)
	local var_54_2 = getProxy(PlayerProxy):getRawData().id
	local var_54_3 = var_54_1:getMemberById(var_54_2)
	local var_54_4 = var_54_1:GetActiveEvent()
	local var_54_5 = getProxy(BayProxy):getData()

	if arg_54_2:isActivityNpc() then
		local var_54_7 = i18n("common_npc_formation_tip")

		return
	end

	local var_54_8 = var_54_4:GetMissionById(arg_54_0)

	if _.any(var_54_8:GetMyShips(), function(arg_56_0)
		return var_54_5[arg_56_0] and var_54_5[arg_56_0]:isSameKind(arg_54_2)
	end) then
		local var_54_10 = i18n("guild_event_exist_same_kind_ship")

		return
	end

	if _.any(_.map(arg_54_1, function(arg_55_0)
		return var_54_5[arg_55_0]
	end), function(arg_57_0)
		return arg_57_0:isSameKind(arg_54_2)
	end) then
		local var_54_12 = i18n("guild_event_exist_same_kind_ship")

		return
	end

	local var_54_13 = GuildAssaultFleet.GetVirtualId(var_54_2, arg_54_2.id)

	if var_54_3.GetAssaultFleet(var_54_0):ExistShip(var_54_13) then
		local var_54_15 = i18n("guild_event_exist_assult_ship")

		return
	end

	if var_54_3:GetExternalAssaultFleet():ExistShip(var_54_13) then
		local var_54_17 = i18n("guild_event_exist_assult_ship")

		return
	end

	if _.any(var_54_4:GetJoinShips(), function(arg_58_0)
		return arg_54_2.id == arg_58_0
	end) then
		local var_54_19 = i18n("guidl_event_ship_in_event")

		return
	end

	return true
end

function var_0_0.OnSelectMissionShips(arg_59_0, arg_59_1, arg_59_2, arg_59_3)
	local var_59_9001
	local var_59_9000

	arg_59_0.contextData.missionShips = arg_59_0.contextData.missionShips or Clone(arg_59_3)

	local var_59_0 = getProxy(GuildProxy)
	local var_59_1 = var_59_0.getData(var_59_9001)
	local var_59_2 = getProxy(PlayerProxy)
	local var_59_3 = _.map(var_59_1:getMemberById(var_59_2.getRawData(var_59_9000).id).GetAssaultFleet(var_59_0).GetShipIds(var_59_2), function(arg_60_0)
		return GuildAssaultFleet.GetRealId(arg_60_0)
	end)

	_.each(arg_59_3, function(arg_61_0)
		table.insert(var_59_3, arg_61_0)

		return
	end)
	_.each(var_59_1:GetActiveEvent():GetJoinShips(), function(arg_62_0)
		table.insert(var_59_3, arg_62_0)

		return
	end)
	arg_59_0:sendNotification(GAME.GO_SCENE, SCENE.DOCKYARD, {
		selectedMin = 1,
		selectedMax = 1,
		quitTeam = arg_59_3[arg_59_2],
		ignoredIds = _.map(var_59_1:getMemberById(var_59_2.getRawData(var_59_9000).id).GetAssaultFleet(var_59_0).GetShipIds(var_59_2), function(arg_60_0)
			return GuildAssaultFleet.GetRealId(arg_60_0)
		end),
		onShip = function(arg_63_0)
			return var_0_0.OnCheckMissionShip(arg_59_1, arg_59_3, arg_63_0)
		end,
		onSelected = function(arg_64_0, arg_64_1)
			if arg_59_3[arg_59_2] then
				for iter_64_0, iter_64_1 in ipairs(arg_59_0.contextData.missionShips) do
					if iter_64_1 == arg_59_3[arg_59_2] then
						table.remove(arg_59_0.contextData.missionShips, iter_64_0)
					end
				end
			end

			table.insert(arg_59_0.contextData.missionShips, arg_64_0[1])

			return
		end
	})

	return
end

function var_0_0.OnComanderOP(arg_65_0, arg_65_1)
	if arg_65_1.data.type == LevelUIConst.COMMANDER_OP_RENAME then
		arg_65_0:sendNotification(GAME.SET_COMMANDER_PREFAB_NAME, {
			id = arg_65_1.data.id,
			name = arg_65_1.data.str,
			onFailed = arg_65_1.data.onFailed
		})
	elseif arg_65_1.data.type == LevelUIConst.COMMANDER_OP_RECORD_PREFAB then
		arg_65_0:sendNotification(GAME.SET_COMMANDER_PREFAB, {
			id = arg_65_1.data.id,
			commanders = Clone((arg_65_1.data.fleet:getCommanders()))
		})
	else
		arg_65_0.contextData.editBossFleet = arg_65_0.contextData.editBossFleet or {}
		arg_65_0.contextData.editBossFleet[arg_65_1.data.fleet.id] = arg_65_0.contextData.editBossFleet[arg_65_1.data.fleet.id] or Clone(arg_65_1.data.fleet)

		local var_65_1 = arg_65_0.contextData.editBossFleet[arg_65_1.data.fleet.id]

		if arg_65_1.data.type == LevelUIConst.COMMANDER_OP_USE_PREFAB then
			local var_65_2 = getProxy(GuildProxy):getData():GetActiveEvent():GetBossMission()

			var_65_1:ClearCommanders()

			for iter_65_0, iter_65_1 in pairs((getProxy(CommanderProxy):getPrefabFleetById(var_65_0):getCommander())) do
				table.insert({}, function(arg_66_0)
					arg_65_0:OnDockSelectCommander(false, var_65_1, iter_65_0, var_65_2, {
						iter_65_1.id
					}, arg_66_0)

					return
				end)
			end

			seriesAsync({}, function()
				arg_65_0.viewComponent:OnBossCommanderFormationChange()

				return
			end)
		elseif arg_65_1.data.type == LevelUIConst.COMMANDER_OP_REST_ALL then
			var_65_1:ClearCommanders()
			arg_65_0.viewComponent:OnBossCommanderFormationChange()
		end
	end

	return
end

function var_0_0.listNotificationInterests(arg_68_0)
	return {
		PlayerProxy.UPDATED,
		GuildProxy.GUILD_UPDATED,
		GAME.GUILD_ACTIVE_EVENT_DONE,
		GuildProxy.GUILD_BATTLE_STARTED,
		GAME.GUILD_UPDATE_MY_ASSAULT_FLEET_DONE,
		GAME.GUILD_JOIN_MISSION_DONE,
		GAME.GUILD_REFRESH_MISSION_DONE,
		GAME.GUILD_GET_BOSS_INFO_DONE,
		GAME.GET_GUILD_BOSS_RANK_DONE,
		GAME.GUILD_UPDATE_NODE_ANIM_FLAG_DONE,
		GAME.GUILD_UPDATE_BOSS_FORMATION_DONE,
		GAME.GUILD_GET_ASSAULT_FLEET_DONE,
		GAME.GUILD_GET_MY_ASSAULT_FLEET_DONE,
		GAME.SUBMIT_GUILD_REPORT_DONE,
		GAME.ON_GUILD_JOIN_EVENT_DONE,
		GAME.GUILD_END_BATTLE,
		GuildProxy.ON_EXIST_DELETED_MEMBER,
		GAME.GUILD_RECOMMAND_ASSULT_SHIP_DONE,
		GAME.REFRESH_ALL_ASSULT_SHIP_RECOMMAND_STATE_DONE,
		TaskProxy.TASK_PROGRESS_UPDATE,
		GAME.SET_COMMANDER_PREFAB_NAME_DONE,
		GAME.SET_COMMANDER_PREFAB_DONE,
		GAME.ON_GUILD_EVENT_END
	}
end

function var_0_0.handleNotification(arg_69_0, arg_69_1)
	local var_69_0 = arg_69_1:getName()
	local var_69_1 = arg_69_1:getBody()

	if var_69_0 == PlayerProxy.UPDATED then
		arg_69_0.viewComponent:SetPlayer(var_69_1)
	elseif var_69_0 == GuildProxy.GUILD_UPDATED then
		arg_69_0.viewComponent:UpdateGuild(var_69_1)
	elseif var_69_0 == GAME.GUILD_ACTIVE_EVENT_DONE then
		arg_69_0:sendNotification(GAME.GUILD_GET_ACTIVATION_EVENT, {
			force = true,
			callback = function()
				arg_69_0.viewComponent:EnterEvent()

				return
			end
		})
	elseif var_69_0 == GAME.GUILD_UPDATE_MY_ASSAULT_FLEET_DONE then
		arg_69_0.contextData.editFleet = nil

		arg_69_0.viewComponent:OnMyAssultFleetFormationDone()
		pg.TipsMgr.GetInstance():ShowTips(i18n("guild_event_start_done"))
	elseif var_69_0 == GAME.GUILD_JOIN_MISSION_DONE then
		arg_69_0.contextData.missionShips = nil

		arg_69_0:sendNotification(GAME.GUILD_REFRESH_MISSION, {
			force = true,
			id = var_69_1.id
		})
		arg_69_0.viewComponent:OnMissionFormationDone()
	elseif var_69_0 == GAME.GUILD_REFRESH_MISSION_DONE then
		arg_69_0.viewComponent:RefreshMission(var_69_1.id)
	elseif var_69_0 == GAME.GUILD_GET_BOSS_INFO_DONE then
		arg_69_0.viewComponent:RefreshBossMission()
	elseif var_69_0 == GAME.GET_GUILD_BOSS_RANK_DONE then
		arg_69_0.viewComponent:OnBossRankUpdate()
	elseif var_69_0 == GAME.GUILD_UPDATE_NODE_ANIM_FLAG_DONE then
		arg_69_0.viewComponent:RefreshMission(var_69_1.id)
	elseif var_69_0 == GAME.GUILD_UPDATE_BOSS_FORMATION_DONE then
		arg_69_0.contextData.editBossFleet = nil

		pg.TipsMgr.GetInstance():ShowTips(i18n("guild_fleet_update_done"))
		arg_69_0.viewComponent:OnBossMissionFormationChanged()
	elseif var_69_0 == GAME.GUILD_GET_ASSAULT_FLEET_DONE then
		arg_69_0.viewComponent:OnMemberAssultFleetUpdate()
	elseif var_69_0 == GAME.GUILD_GET_MY_ASSAULT_FLEET_DONE then
		arg_69_0.viewComponent:OnMyAssultFleetUpdate()
	elseif var_69_0 == GAME.SUBMIT_GUILD_REPORT_DONE then
		arg_69_0.viewComponent:OnReportUpdated()
	elseif var_69_0 == GuildProxy.GUILD_BATTLE_STARTED then
		local var_69_2 = i18n("guild_event_start_tip1")

		if getProxy(GuildProxy):getRawData():IsAdministrator() and arg_69_0.viewComponent.eventInfoPage and arg_69_0.viewComponent.eventInfoPage:GetLoaded() and arg_69_0.viewComponent.eventInfoPage:isShowing() then
			var_69_2 = i18n("guild_event_start_tip2")
		end

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			hideNo = true,
			content = var_69_2,
			onYes = function()
				arg_69_0:sendNotification(GAME.GUILD_GET_ACTIVATION_EVENT, {
					force = true,
					callback = function()
						arg_69_0.viewComponent:EnterEvent()

						return
					end
				})

				return
			end
		})
	elseif var_69_0 == GAME.ON_GUILD_JOIN_EVENT_DONE then
		arg_69_0.viewComponent:EnterEvent()
	elseif var_69_0 == GAME.GUILD_END_BATTLE then
		arg_69_0.viewComponent:EnterEvent()
	elseif var_69_0 == GuildProxy.ON_EXIST_DELETED_MEMBER then
		arg_69_0.viewComponent:OnMemberDeleted()
	elseif var_69_0 == GAME.GUILD_RECOMMAND_ASSULT_SHIP_DONE then
		arg_69_0.viewComponent:OnAssultShipBeRecommanded(var_69_1.shipId)
	elseif var_69_0 == GAME.REFRESH_ALL_ASSULT_SHIP_RECOMMAND_STATE_DONE then
		arg_69_0.viewComponent:OnRefreshAllAssultShipRecommandState()
	elseif var_69_0 == TaskProxy.TASK_PROGRESS_UPDATE then
		pg.GuildMsgBoxMgr.GetInstance():NotificationForGuildEvent(var_69_1)
	elseif var_69_0 == GAME.SET_COMMANDER_PREFAB_NAME_DONE or var_69_0 == GAME.SET_COMMANDER_PREFAB_DONE then
		arg_69_0.viewComponent:OnBossCommanderPrefabFormationChange()
	elseif var_69_0 == GAME.ON_GUILD_EVENT_END then
		arg_69_0.viewComponent:OnEventEnd()
	end

	return
end

return var_0_0

class = var_0_10000

local var_0_0 = "WorldBossFormationMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.ContextMediator"))

var_0_1.ON_START = "WorldBossFormationMediator:ON_START"
var_0_1.ON_COMMIT_EDIT = "WorldBossFormationMediator:ON_COMMIT_EDIT"
var_0_1.OPEN_SHIP_INFO = "WorldBossFormationMediator:OPEN_SHIP_INFO"
var_0_1.REMOVE_SHIP = "WorldBossFormationMediator:REMOVE_SHIP"
var_0_1.CHANGE_FLEET_SHIP = "WorldBossFormationMediator:CHANGE_FLEET_SHIPs"
var_0_1.ON_AUTO = "WorldBossFormationMediator:ON_AUTO"
var_0_1.CHANGE_FLEET_SHIPS_ORDER = "WorldBossFormationMediator:CHANGE_FLEET_SHIPS_ORDER"

function var_0_1.register(arg_1_0)
	getProxy = var_1_10001
	BayProxy = var_1_10002

	local var_1_0 = var_1_10001(var_1_10002)

	arg_1_0.ships = var_1.getRawData(var_1_0)

	local var_1_1 = arg_1_0.viewComponent

	var_2.SetShips(var_1_1, arg_1_0.ships)

	nowWorld = var_2

	local var_1_2 = var_2()
	local var_1_3 = var_2.GetBossProxy(var_1_2)
	local var_1_4

	if not arg_1_0.contextData.editingFleetVO then
		Clone = var_1_4
		var_1_4 = var_1_4(var_1_3:GetFleet(arg_1_0.contextData.bossId))
	end

	local var_1_5 = arg_1_0.viewComponent

	var_5.SetBossProxy(var_1_5, var_1_3, arg_1_0.contextData.bossId)
	var_1_3:LockCacheBoss(arg_1_0.contextData.bossId)

	local var_1_6 = arg_1_0.viewComponent

	var_5.SetCurrentFleet(var_1_6, var_1_4)

	getProxy = var_5
	PlayerProxy = var_1_6

	local var_1_7 = var_5(var_1_6)
	local var_1_8 = var_5.getData(var_1_7)
	local var_1_9 = arg_1_0.viewComponent

	var_7.SetPlayerInfo(var_1_9, var_1_8)
	arg_1_0:bind(var_0_1.REMOVE_SHIP, function(arg_2_0, arg_2_1, arg_2_2)
		if not arg_2_2:canRemove(arg_2_1) then
			local var_2_0, var_2_1 = arg_2_2:getShipPos(arg_2_1)

			pg = var_5

			local var_2_2 = var_5.TipsMgr.GetInstance()
			local var_2_3 = var_5.ShowTips

			i18n = var_2_10007

			local var_2_4 = "ship_formationUI_removeError_onlyShip"
			local var_2_5 = arg_2_1:getConfigTable().name
			local var_2_6 = arg_2_2.name

			Fleet = var_2_10011

			var_2_3(var_2_2, var_2_10007(var_2_4, var_2_5, var_2_6, var_2_10011.C_TEAM_NAME[var_2_1]))

			return
		end

		arg_2_2:removeShip(arg_2_1)

		local var_2_7 = arg_1_0.viewComponent

		var_3.UpdateFleetView(var_2_7, true)

		return
	end)
	arg_1_0:bind(var_0_1.CHANGE_FLEET_SHIPS_ORDER, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0.viewComponent

		var_2.UpdateFleetView(var_3_0)

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_SHIP_INFO, function(arg_4_0, arg_4_1, arg_4_2)
		local var_4_0 = arg_1_0.contextData

		PreCombatLayer = var_2_10004
		var_4_0.form = var_2_10004.FORM_EDIT

		local var_4_1 = arg_1_0.viewComponent._currentFleetVO
		local var_4_2 = {}

		ipairs = var_2_10005

		for iter_4_0, iter_4_1 in var_2_10005(arg_4_2.ships) do
			table = var_2_10010

			var_2_10010.insert(var_4_2, arg_1_0.ships[iter_4_1])
		end

		local var_4_3 = arg_1_0
		local var_4_4 = var_5.sendNotification

		GAME = var_7

		local var_4_5 = var_7.GO_SCENE

		SCENE = iter_4_0

		var_4_4(var_4_3, var_4_5, iter_4_0.SHIPINFO, {
			shipId = arg_4_1,
			shipVOs = var_4_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_COMMIT_EDIT, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_1_0.viewComponent._currentFleetVO
		local var_5_1 = var_1_3

		var_3.UpdateFleet(var_5_1, arg_1_0.contextData.bossId, var_5_0)

		local var_5_2 = var_1_3

		var_3.SavaCacheShips(var_5_2, arg_1_0.contextData.bossId, var_5_0)
		arg_5_1()

		return
	end)
	arg_1_0:bind(var_0_1.ON_AUTO, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_1_0

		var_2.onAutoBtn(var_6_0, arg_6_1)

		return
	end)
	arg_1_0:bind(var_0_1.ON_START, function(arg_7_0)
		SYSTEM_WORLD_BOSS = var_2_10001

		if not arg_1_0.contextData.isSimulate then
			local var_7_0 = var_1_3
			local var_7_1 = var_2.GetFleet(var_7_0, arg_1_0.contextData.bossId)
			local var_7_2, var_7_3 = var_2.isLegalToFight(var_7_1)

			if var_7_2 ~= true then
				pg = var_2_10004

				local var_7_4 = var_2_10004.TipsMgr.GetInstance()

				var_2_10004 = var_2_10004.ShowTips
				i18n = var_2_10006

				var_2_10004(var_7_4, var_2_10006("elite_disable_no_fleet"))

				return
			end

			nowWorld = var_2_10004

			local var_7_5 = var_2_10004()
			local var_7_6 = var_2_10004.GetBossProxy(var_7_5)

			if not var_5.GetBossById(var_7_6, arg_1_0.contextData.bossId) then
				pg = var_7_6

				local var_7_7 = var_7_6.TipsMgr.GetInstance()
				local var_7_8 = var_6.ShowTips

				i18n = var_2_10008

				var_7_8(var_7_7, var_2_10008("world_joint_boss_not_found"))

				return
			end

			if arg_1_0.contextData.isOther then
				local var_7_9 = var_1_3

				if var_6.GetPt(var_7_9) <= 0 then
					WorldBossConst = var_6

					if var_6._IsCurrBoss(var_5) then
						pg = var_6

						local var_7_10 = var_6.TipsMgr.GetInstance()
						local var_7_11 = var_6.ShowTips

						i18n = var_2_10008

						var_7_11(var_7_10, var_2_10008("world_joint_count_no_enough"))

						return
					end
				end
			end

			if arg_1_0.contextData.isOther then
				WorldBossScene = var_6
				var_6.inOtherBossBattle = arg_1_0.contextData.bossId
			end
		else
			SYSTEM_WORLD_BOSS_SIMULATE = var_2_10001
		end

		local var_7_12 = arg_1_0
		local var_7_13 = var_2.sendNotification

		GAME = var_2_10004

		local var_7_14 = var_2_10004.BEGIN_STAGE
		local var_7_15 = {
			actId = 0,
			bossId = arg_1_0.contextData.bossId,
			system = var_2_10001,
			hpRate = arg_1_0.contextData.hpRate
		}

		isSimulate = var_6
		var_7_15.isSimulate = var_6

		var_7_13(var_7_12, var_7_14, var_7_15)

		return
	end)
	arg_1_0:bind(var_0_1.CHANGE_FLEET_SHIP, function(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
		local var_8_0 = arg_1_0.contextData

		WorldBossFormationLayer = var_2_10005
		var_8_0.form = var_2_10005.FORM_EDIT
		CurrentWorldBossDetailPage = var_8_0
		var_8_0.formDock = true
		tobool = var_8_0

		local var_8_1 = var_8_0(arg_8_1)
		local var_8_2

		if not arg_8_1 or not arg_8_1.id then
			var_8_2 = nil
		end

		local var_8_3

		if not arg_8_2.ships then
			var_8_3 = {}
		end

		local var_8_4 = arg_1_0
		local var_8_5 = var_7.sendNotification

		GAME = var_2_10009

		local var_8_6 = var_2_10009.GO_SCENE

		SCENE = var_2_10010

		local var_8_7 = var_2_10010.DOCKYARD
		local var_8_8 = {
			selectedMin = 1,
			selectedMax = 1,
			ignoredIds = var_8_3
		}

		i18n = var_2_10012
		var_8_8.leastLimitMsg = var_2_10012("ship_formationMediator_leastLimit")
		var_8_8.quitTeam = var_8_1
		var_8_8.teamFilter = arg_8_3
		i18n = var_12
		var_8_8.leftTopInfo = var_12("word_formation")

		function var_8_8.onShip(arg_9_0)
			_ = var_3_10001

			if var_3_10001.any(arg_8_2.ships, function(arg_10_0)
				local var_10_0 = arg_9_0
				local var_10_1 = var_1.isSameKind
				local var_10_2 = var_0

				return var_10_1(var_10_0, var_3.getShipById(var_10_2, arg_10_0))
			end) then
				local var_9_0 = false

				i18n = var_2

				local var_9_1 = var_2("event_same_type_not_allowed")

				return
			end

			return true
		end

		function var_8_8.onSelected(arg_11_0)
			local var_11_0 = arg_11_0[1]

			getProxy = var_3_10002
			BayProxy = var_3_10003

			local var_11_1 = var_3_10002(var_3_10003)

			if var_2.getShipById(var_11_1, var_11_0) then
				local var_11_2 = var_1_4

				if var_3.containShip(var_11_2, var_2) then
					return
				end
			end

			if var_8_2 == nil then
				local var_11_3 = arg_8_2

				var_3.insertShip(var_11_3, var_2, nil, arg_8_3)
			else
				local var_11_4 = var_1_4
				local var_11_5 = var_3.getShipPos(var_11_4, arg_8_1)
				local var_11_6 = arg_8_2

				var_4.removeShipById(var_11_6, var_8_2)

				if var_2 and var_11_5 then
					local var_11_7 = arg_8_2

					var_4.insertShip(var_11_7, var_2, var_11_5, arg_8_3)
				end
			end

			return
		end

		var_8_8.preView = arg_1_0.viewComponent.__cname
		ShipStatus = var_12
		var_8_8.hideTagFlags = var_12.TAG_HIDE_ALL

		var_8_5(var_8_4, var_8_6, var_8_7, var_8_8)

		return
	end)

	return
end

function var_0_1.onAutoBtn(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1.isOn
	local var_12_1 = arg_12_1.toggle
	local var_12_2 = arg_12_0
	local var_12_3 = arg_12_0.sendNotification

	GAME = var_1_10006

	local var_12_4 = var_1_10006.AUTO_BOT
	local var_12_5 = {
		isActiveBot = var_12_0,
		toggle = var_12_1
	}

	SYSTEM_WORLD = var_1_10008
	var_12_5.system = var_1_10008

	var_12_3(var_12_2, var_12_4, var_12_5)

	return
end

function var_0_1.listNotificationInterests(arg_13_0)
	local var_13_0 = {}

	GAME = var_1_10002
	var_13_0[1] = var_1_10002.BEGIN_STAGE_DONE
	GAME = var_2
	var_13_0[2] = var_2.WORLD_BOSS_START_BATTLE_FIALED
	PlayerProxy = var_2
	var_13_0[3] = var_2.UPDATED
	GAME = var_2
	var_13_0[4] = var_2.END_GUIDE

	return var_13_0
end

function var_0_1.handleNotification(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_1:getName()
	local var_14_1 = arg_14_1
	local var_14_2 = arg_14_1.getBody(var_14_1)

	GAME = var_14_1

	local var_14_4

	if var_14_0 == var_14_1.BEGIN_STAGE_DONE then
		local var_14_3 = arg_14_0

		var_14_4 = arg_14_0.sendNotification
		GAME = var_1_10006
		var_1_10006 = var_1_10006.GO_SCENE
		SCENE = var_1_10007

		var_14_4(var_14_3, var_1_10006, var_1_10007.COMBATLOAD, var_14_2)
	else
		GAME = var_14_4

		local var_14_6

		if var_14_0 == var_14_4.WORLD_BOSS_START_BATTLE_FIALED then
			local var_14_5 = arg_14_0.viewComponent

			var_14_6 = var_14_6.emit
			BaseUI = var_1_10006

			var_14_6(var_14_5, var_1_10006.ON_CLOSE)
		else
			PlayerProxy = var_14_6

			local var_14_8

			if var_14_0 == var_14_6.UPDATED then
				local var_14_7 = arg_14_0.viewComponent

				var_14_8 = var_14_8.SetPlayerInfo
				getProxy = var_1_10006
				PlayerProxy = var_1_10007

				local var_14_9 = var_1_10006(var_1_10007)

				var_14_8(var_14_7, var_6.getData(var_14_9))
			else
				GAME = var_14_8

				if var_14_0 == var_14_8.END_GUIDE then
					local var_14_10 = arg_14_0.viewComponent

					var_4.TryPlayGuide(var_14_10)
				end
			end
		end
	end

	return
end

return var_0_1

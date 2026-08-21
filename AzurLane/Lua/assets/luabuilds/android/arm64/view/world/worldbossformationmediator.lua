local var_0_0 = class("WorldBossFormationMediator", import("..base.ContextMediator"))

var_0_0.ON_START = "WorldBossFormationMediator:ON_START"
var_0_0.ON_COMMIT_EDIT = "WorldBossFormationMediator:ON_COMMIT_EDIT"
var_0_0.OPEN_SHIP_INFO = "WorldBossFormationMediator:OPEN_SHIP_INFO"
var_0_0.REMOVE_SHIP = "WorldBossFormationMediator:REMOVE_SHIP"
var_0_0.CHANGE_FLEET_SHIP = "WorldBossFormationMediator:CHANGE_FLEET_SHIPs"
var_0_0.ON_AUTO = "WorldBossFormationMediator:ON_AUTO"
var_0_0.CHANGE_FLEET_SHIPS_ORDER = "WorldBossFormationMediator:CHANGE_FLEET_SHIPS_ORDER"

function var_0_0.register(arg_1_0)
	local var_1_0 = getProxy(BayProxy)

	arg_1_0.ships = getProxy(BayProxy):getRawData()

	arg_1_0.viewComponent:SetShips(arg_1_0.ships)

	local var_1_1 = nowWorld():GetBossProxy()
	local var_1_2 = arg_1_0.contextData.editingFleetVO or Clone(var_1_1:GetFleet(arg_1_0.contextData.bossId))

	arg_1_0.viewComponent:SetBossProxy(var_1_1, arg_1_0.contextData.bossId)
	var_1_1:LockCacheBoss(arg_1_0.contextData.bossId)
	arg_1_0.viewComponent:SetCurrentFleet(var_1_2)
	arg_1_0.viewComponent:SetPlayerInfo((getProxy(PlayerProxy):getData()))
	arg_1_0:bind(var_0_0.REMOVE_SHIP, function(arg_2_0, arg_2_1, arg_2_2)
		if not arg_2_2:canRemove(arg_2_1) then
			local var_2_0, var_2_1 = arg_2_2:getShipPos(arg_2_1)

			pg.TipsMgr.GetInstance():ShowTips(i18n("ship_formationUI_removeError_onlyShip", arg_2_1:getConfigTable().name, arg_2_2.name, Fleet.C_TEAM_NAME[var_2_1]))

			return
		end

		arg_2_2:removeShip(arg_2_1)
		arg_1_0.viewComponent:UpdateFleetView(true)

		return
	end)
	arg_1_0:bind(var_0_0.CHANGE_FLEET_SHIPS_ORDER, function(arg_3_0, arg_3_1)
		arg_1_0.viewComponent:UpdateFleetView()

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_SHIP_INFO, function(arg_4_0, arg_4_1, arg_4_2)
		arg_1_0.contextData.form = PreCombatLayer.FORM_EDIT

		for iter_4_0, iter_4_1 in ipairs(arg_4_2.ships) do
			table.insert({}, arg_1_0.ships[iter_4_1])
		end

		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.SHIPINFO, {
			shipId = arg_4_1,
			shipVOs = {}
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_COMMIT_EDIT, function(arg_5_0, arg_5_1)
		var_1_1:UpdateFleet(arg_1_0.contextData.bossId, arg_1_0.viewComponent._currentFleetVO)
		var_1_1:SavaCacheShips(arg_1_0.contextData.bossId, arg_1_0.viewComponent._currentFleetVO)
		arg_5_1()

		return
	end)
	arg_1_0:bind(var_0_0.ON_AUTO, function(arg_6_0, arg_6_1)
		arg_1_0:onAutoBtn(arg_6_1)

		return
	end)
	arg_1_0:bind(var_0_0.ON_START, function(arg_7_0)
		local var_7_0 = SYSTEM_WORLD_BOSS

		if not arg_1_0.contextData.isSimulate then
			local var_7_1, var_7_2 = var_1_1:GetFleet(arg_1_0.contextData.bossId):isLegalToFight()

			if var_7_1 ~= true then
				pg.TipsMgr.GetInstance():ShowTips(i18n("elite_disable_no_fleet"))

				return
			end

			local var_7_3 = nowWorld():GetBossProxy():GetBossById(arg_1_0.contextData.bossId)

			if not var_7_3 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("world_joint_boss_not_found"))

				return
			end

			if arg_1_0.contextData.isOther and var_1_1:GetPt() <= 0 and WorldBossConst._IsCurrBoss(var_7_3) then
				pg.TipsMgr.GetInstance():ShowTips(i18n("world_joint_count_no_enough"))

				return
			end

			if arg_1_0.contextData.isOther then
				WorldBossScene.inOtherBossBattle = arg_1_0.contextData.bossId
			end
		else
			var_7_0 = SYSTEM_WORLD_BOSS_SIMULATE
		end

		arg_1_0:sendNotification(GAME.BEGIN_STAGE, {
			actId = 0,
			bossId = arg_1_0.contextData.bossId,
			system = var_7_0,
			hpRate = arg_1_0.contextData.hpRate,
			isSimulate = isSimulate
		})

		return
	end)
	arg_1_0:bind(var_0_0.CHANGE_FLEET_SHIP, function(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
		arg_1_0.contextData.form = WorldBossFormationLayer.FORM_EDIT
		CurrentWorldBossDetailPage.formDock = true

		local var_8_0 = tobool(arg_8_1)
		local var_8_1 = arg_8_1 and arg_8_1.id or nil
		local var_8_2 = arg_8_2.ships or {}

		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.DOCKYARD, {
			selectedMin = 1,
			selectedMax = 1,
			ignoredIds = var_8_2,
			leastLimitMsg = i18n("ship_formationMediator_leastLimit"),
			quitTeam = var_8_0,
			teamFilter = arg_8_3,
			leftTopInfo = i18n("word_formation"),
			onShip = function(arg_9_0)
				if _.any(arg_8_2.ships, function(arg_10_0)
					return arg_9_0:isSameKind(var_1_0:getShipById(arg_10_0))
				end) then
					local var_9_1 = i18n("event_same_type_not_allowed")

					return
				end

				return true
			end,
			onSelected = function(arg_11_0)
				local var_11_0 = getProxy(BayProxy):getShipById(arg_11_0[1])

				if var_11_0 and var_1_2:containShip(var_11_0) then
					return
				end

				if var_8_1 == nil then
					arg_8_2:insertShip(var_11_0, nil, arg_8_3)
				else
					local var_11_1 = var_1_2:getShipPos(arg_8_1)

					arg_8_2:removeShipById(var_8_1)

					if var_11_0 and var_11_1 then
						arg_8_2:insertShip(var_11_0, var_11_1, arg_8_3)
					end
				end

				return
			end,
			preView = arg_1_0.viewComponent.__cname,
			hideTagFlags = ShipStatus.TAG_HIDE_ALL
		})

		return
	end)

	return
end

function var_0_0.onAutoBtn(arg_12_0, arg_12_1)
	arg_12_0:sendNotification(GAME.AUTO_BOT, {
		isActiveBot = arg_12_1.isOn,
		toggle = arg_12_1.toggle,
		system = SYSTEM_WORLD
	})

	return
end

function var_0_0.listNotificationInterests(arg_13_0)
	return {
		GAME.BEGIN_STAGE_DONE,
		GAME.WORLD_BOSS_START_BATTLE_FIALED,
		PlayerProxy.UPDATED,
		GAME.END_GUIDE
	}
end

function var_0_0.handleNotification(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_1:getName()

	if var_14_0 == GAME.BEGIN_STAGE_DONE then
		arg_14_0:sendNotification(GAME.GO_SCENE, SCENE.COMBATLOAD, (arg_14_1:getBody()))
	elseif var_14_0 == GAME.WORLD_BOSS_START_BATTLE_FIALED then
		arg_14_0.viewComponent:emit(BaseUI.ON_CLOSE)
	elseif var_14_0 == PlayerProxy.UPDATED then
		arg_14_0.viewComponent:SetPlayerInfo(getProxy(PlayerProxy):getData())
	elseif var_14_0 == GAME.END_GUIDE then
		arg_14_0.viewComponent:TryPlayGuide()
	end

	return
end

return var_0_0

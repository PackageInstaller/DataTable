class = var_0_10000

local var_0_0 = "WorldFleetSelectMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.ContextMediator"))

var_0_1.OnSelectShip = "WorldFleetSelectMediator.OnSelectShip"
var_0_1.OnGO = "WorldFleetSelectMediator.OnGO"
var_0_1.OnShipDetail = "WorldFleetSelectMediator.OnShipDetail"
var_0_1.OnSelectEliteCommander = "WorldFleetSelectMediator.OnSelectEliteCommander"
var_0_1.OnCommanderFormationOp = "WorldFleetSelectMediator.OnCommanderFormationOp"
var_0_1.OnCommanderSkill = "WorldFleetSelectMediator.OnCommanderSkill"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.OnSelectShip, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		tobool = var_2_10004

		local var_2_0 = var_2_10004(arg_2_2[arg_2_3])
		local var_2_1 = {}

		pairs = var_6

		for iter_2_0, iter_2_1 in var_6(arg_1_0.contextData.fleets) do
			ipairs = var_2_10011

			for iter_2_2, iter_2_3 in var_2_10011(iter_2_1) do
				for iter_2_4 = 1, 3 do
					if iter_2_3[arg_2_1][iter_2_4] then
						table = var_20

						var_20.insert(var_2_1, iter_2_3[arg_2_1][iter_2_4])
					end
				end
			end
		end

		local var_2_2 = arg_1_0
		local var_2_3, var_2_4, var_2_5 = var_6.GetDockCallbackFuncs(var_2_2, arg_2_2, arg_2_3, var_2_1)
		local var_2_6 = arg_1_0
		local var_2_7 = var_9.sendNotification

		GAME = var_2_10012

		local var_2_8 = var_2_10012.GO_SCENE

		SCENE = var_2_10013

		local var_2_9 = var_2_10013.DOCKYARD
		local var_2_10 = {
			selectedMin = 0,
			useBlackBlock = true,
			selectedMax = 1
		}

		i18n = iter_2_3
		var_2_10.leastLimitMsg = iter_2_3("ship_formationMediator_leastLimit")
		var_2_10.quitTeam = var_2_0
		var_2_10.teamFilter = arg_2_1
		i18n = var_15
		var_2_10.leftTopInfo = var_15("word_formation")
		var_2_10.onShip = var_2_3
		var_2_10.confirmSelect = var_2_4
		var_2_10.onSelected = var_2_5
		ShipStatus = var_15
		var_2_10.hideTagFlags = var_15.TAG_HIDE_WORLD
		var_2_10.otherSelectedIds = var_2_1

		var_2_7(var_2_6, var_2_8, var_2_9, var_2_10)

		return
	end)
	arg_1_0:bind(var_0_1.OnGO, function(arg_3_0)
		nowWorld = var_2_10001

		local var_3_0 = var_2_10001()
		local var_3_1 = arg_1_0.contextData.fleets

		if arg_1_0.contextData.mapId then
			local var_3_2 = arg_1_0
			local var_3_3 = var_3.sendNotification

			GAME = var_2_10006

			var_3_3(var_3_2, var_2_10006.WORLD_ACTIVATE, {
				id = arg_1_0.contextData.mapId,
				enter_map_id = arg_1_0.contextData.entranceId,
				elite_fleet_list = var_3_0:FormationIds2NetIds(var_3_1),
				camp = var_3_0:GetRealm()
			})
		else
			local var_3_4 = {}

			if not var_3_0:CompareRedeploy(var_3_1) then
				table = var_4

				var_4.insert(var_3_4, function(arg_4_0)
					pg = var_3_10001

					local var_4_0 = var_3_10001.MsgboxMgr.GetInstance()
					local var_4_1 = var_1.ShowMsgBox
					local var_4_2 = {}

					i18n = var_3_10005
					var_4_2.content = var_3_10005("world_redeploy_not_change")
					var_4_2.onYes = arg_4_0

					var_4_1(var_4_0, var_4_2)

					return
				end)
			end

			table = var_4

			var_4.insert(var_3_4, function(arg_5_0)
				local var_5_0 = var_3_0
				local var_5_1 = var_1.CalcOrderCost

				WorldConst = var_3_10004

				local var_5_2 = var_5_1(var_5_0, var_3_10004.OpReqRedeploy)
				local var_5_3 = var_3_0.staminaMgr
				local var_5_4 = var_2.GetTotalStamina(var_5_3)

				pg = var_5_0

				local var_5_5 = var_5_0.MsgboxMgr.GetInstance()
				local var_5_6 = var_3.ShowMsgBox
				local var_5_7 = {}

				i18n = var_3_10007

				local var_5_8 = "world_redeploy_cost_tip"

				setColorStr = var_3_10010

				local var_5_9 = var_5_2

				COLOR_GREEN = var_3_10013

				local var_5_10 = var_3_10010(var_5_9, var_3_10013)

				setColorStr = var_3_10011

				local var_5_11 = var_5_4

				if var_5_2 <= var_5_4 then
					COLOR_GREEN = var_3_10014

					if not var_3_10014 then
						COLOR_RED = var_3_10014
					end

					var_5_7.content = var_3_10007(var_5_8, var_5_10, var_3_10011(var_5_11, var_3_10014))

					function var_5_7.onYes()
						local var_6_0 = var_3_0.staminaMgr

						if var_0.GetTotalStamina(var_6_0) < var_5_2 then
							local var_6_1 = var_3_0.staminaMgr

							var_0.Show(var_6_1)
						else
							arg_5_0()
						end

						return
					end

					var_5_6(var_5_5, var_5_7)

					return
				end
			end)

			seriesAsync = var_4

			var_4(var_3_4, function()
				local var_7_0 = arg_1_0
				local var_7_1 = var_0.sendNotification

				GAME = var_3_10003

				local var_7_2 = var_3_10003.WORLD_FLEET_REDEPLOY
				local var_7_3 = {}
				local var_7_4 = var_3_0

				var_7_3.elite_fleet_list = var_5.FormationIds2NetIds(var_7_4, var_3_1)

				var_7_1(var_7_0, var_7_2, var_7_3)

				return
			end)
		end

		return
	end)
	arg_1_0:bind(var_0_1.OnShipDetail, function(arg_8_0, arg_8_1)
		local var_8_0 = arg_1_0
		local var_8_1 = var_2.sendNotification

		GAME = var_2_10005

		local var_8_2 = var_2_10005.GO_SCENE

		SCENE = var_2_10006

		var_8_1(var_8_0, var_8_2, var_2_10006.SHIPINFO, {
			shipId = arg_8_1.shipId,
			shipVOs = arg_8_1.shipVOs
		})

		return
	end)
	arg_1_0:bind(var_0_1.OnCommanderFormationOp, function(arg_9_0, arg_9_1)
		local var_9_0 = arg_1_0
		local var_9_1 = var_2.sendNotification

		GAME = var_2_10005

		var_9_1(var_9_0, var_2_10005.COMMANDER_FORMATION_OP, {
			data = arg_9_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.OnCommanderSkill, function(arg_10_0, arg_10_1)
		local var_10_0 = arg_1_0
		local var_10_1 = var_2.addSubLayers

		Context = var_2_10005

		local var_10_2 = var_2_10005.New
		local var_10_3 = {}

		CommanderSkillMediator = var_2_10008
		var_10_3.mediator = var_2_10008
		CommanderSkillLayer = var_2_10008
		var_10_3.viewComponent = var_2_10008
		var_10_3.data = {
			isWorld = true,
			skill = arg_10_1
		}

		var_10_1(var_10_0, var_10_2(var_10_3))

		return
	end)

	local var_1_0 = arg_1_0

	arg_1_0.bind(var_1_0, var_0_1.OnSelectEliteCommander, function(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
		local var_11_0 = arg_1_0.contextData.fleets[arg_11_1][arg_11_2]

		Fleet = var_2_10005

		local var_11_1 = var_2_10005.New({
			ship_list = {},
			commanders = var_11_0.commanders
		})
		local var_11_2 = var_5.getCommanders(var_11_1)
		local var_11_3 = arg_1_0
		local var_11_4 = var_7.sendNotification

		GAME = var_2_10010

		local var_11_5 = var_2_10010.GO_SCENE

		SCENE = var_2_10011

		local var_11_6 = var_2_10011.COMMANDERCAT
		local var_11_7 = {
			maxCount = 1
		}

		CommanderCatScene = var_2_10013
		var_11_7.mode = var_2_10013.MODE_SELECT
		CommanderCatScene = var_13
		var_11_7.fleetType = var_13.FLEET_TYPE_WORLD
		var_11_7.fleets = arg_1_0.contextData.fleets
		var_11_7.activeCommander = var_11_2[arg_11_3]
		var_11_7.ignoredIds = {}

		function var_11_7.onCommander(arg_12_0)
			return true
		end

		function var_11_7.onSelected(arg_13_0, arg_13_1)
			local var_13_0 = arg_13_0[1]

			getProxy = var_3_10003
			CommanderProxy = var_3_10005

			local var_13_1 = var_3_10003(var_3_10005)
			local var_13_2 = var_3.getCommanderById(var_13_1, var_13_0)

			pairs = var_3_10005

			for iter_13_0, iter_13_1 in var_3_10005(arg_1_0.contextData.fleets) do
				ipairs = var_3_10010

				for iter_13_2, iter_13_3 in var_3_10010(iter_13_1) do
					if iter_13_0 == arg_11_1 and iter_13_2 == arg_11_2 then
						pairs = var_15

						for iter_13_4, iter_13_5 in var_15(var_11_2) do
							if iter_13_5.groupId == var_13_2.groupId and iter_13_4 ~= arg_11_3 then
								pg = var_20

								local var_13_3 = var_20.TipsMgr.GetInstance()
								local var_13_4 = var_20.ShowTips

								i18n = var_3_10023

								var_13_4(var_13_3, var_3_10023("commander_can_not_select_same_group"))

								return
							end
						end
					else
						pairs = var_15

						for iter_13_6, iter_13_7 in var_15(iter_13_3.commanders) do
							if var_13_0 == iter_13_7.id then
								pg = var_20

								local var_13_5 = var_20.TipsMgr.GetInstance()
								local var_13_6 = var_20.ShowTips

								i18n = var_3_10023

								var_13_6(var_13_5, var_3_10023("commander_is_in_fleet_already"))

								return
							end
						end
					end
				end
			end

			local var_13_7 = var_0

			var_5.updateCommanderByPos(var_13_7, arg_11_3, var_13_2)

			local var_13_8 = var_11_0
			local var_13_9 = var_0

			var_13_8.commanders = var_6.outputCommanders(var_13_9)

			arg_13_1()

			return
		end

		function var_11_7.onQuit(arg_14_0)
			local var_14_0 = var_0

			var_1.updateCommanderByPos(var_14_0, arg_11_3, nil)

			local var_14_1 = var_11_0
			local var_14_2 = var_0

			var_14_1.commanders = var_2.outputCommanders(var_14_2)

			arg_14_0()

			return
		end

		var_11_4(var_11_3, var_11_5, var_11_6, var_11_7)

		arg_1_0.contextData.editFleet = true

		return
	end)

	getProxy = var_1
	CommanderProxy = var_1_0

	local var_1_1 = var_1(var_1_0)
	local var_1_2 = var_1.getPrefabFleet(var_1_1)
	local var_1_3 = arg_1_0.viewComponent

	var_2.setCommanderPrefabs(var_1_3, var_1_2)

	return
end

function var_0_1.listNotificationInterests(arg_15_0)
	local var_15_0 = {}

	GAME = var_1_10002
	var_15_0[1] = var_1_10002.WORLD_ACTIVATE_DONE
	GAME = var_2
	var_15_0[2] = var_2.WORLD_FLEET_REDEPLOY_DONE
	CommanderProxy = var_2
	var_15_0[3] = var_2.PREFAB_FLEET_UPDATE
	GAME = var_2
	var_15_0[4] = var_2.COMMANDER_WORLD_FORMATION_OP_DONE

	return var_15_0
end

function var_0_1.handleNotification(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_1
	local var_16_1 = arg_16_1.getName(var_16_0)
	local var_16_2 = arg_16_1:getBody()

	GAME = var_16_0

	local var_16_3

	if var_16_1 == var_16_0.WORLD_ACTIVATE_DONE then
		nowWorld = var_16_3
		var_16_3 = var_16_3()

		local var_16_4 = {}
		local var_16_5 = var_16_3

		var_1_10006 = var_16_3.IsSystemOpen
		WorldConst = var_1_10009

		if var_1_10006(var_16_5, var_1_10009.SystemDailyTask) then
			table = var_1_10006

			var_1_10006.insert(var_16_4, function(arg_17_0)
				local var_17_0 = var_16_3
				local var_17_1 = var_1.GetTaskProxy(var_17_0)

				var_1.checkDailyTask(var_17_1, arg_17_0)

				return
			end)
		end

		seriesAsync = var_1_10006

		var_1_10006(var_16_4, function()
			local var_18_0 = arg_16_0

			var_0.SetFleetSuccess(var_18_0)

			return
		end)
	else
		GAME = var_16_3

		if var_16_1 == var_16_3.WORLD_FLEET_REDEPLOY_DONE then
			var_1_10006 = arg_16_0

			arg_16_0.SetFleetSuccess(var_1_10006)
		else
			CommanderProxy = var_4

			local var_16_7

			if var_16_1 == var_4.PREFAB_FLEET_UPDATE then
				getProxy = var_16_7
				CommanderProxy = var_1_10006

				local var_16_6 = var_16_7(var_1_10006)

				var_16_7 = var_16_7.getPrefabFleet(var_16_6)

				local var_16_8 = arg_16_0.viewComponent

				var_5.setCommanderPrefabs(var_16_8, var_16_7)

				local var_16_9 = arg_16_0.viewComponent

				var_5.updateCommanderPrefab(var_16_9)
			else
				GAME = var_16_7

				if var_16_1 == var_16_7.COMMANDER_WORLD_FORMATION_OP_DONE then
					local var_16_10 = arg_16_0.viewComponent

					var_4.UpdateFleets(var_16_10)

					local var_16_11 = arg_16_0.viewComponent

					var_4.updateCommanderFleet(var_16_11, var_16_2.fleet)
				end
			end
		end
	end

	return
end

function var_0_1.GetDockCallbackFuncs(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	getProxy = var_1_10004
	BayProxy = var_1_10006

	local var_19_0 = var_1_10004(var_1_10006)

	local function var_19_1(arg_20_0, arg_20_1)
		ShipStatus = var_2_10002

		local var_20_0, var_20_1 = var_2_10002.ShipStatusCheck("inWorld", arg_20_0, arg_20_1)

		if not var_20_0 then
			return var_20_0, var_20_1
		end

		ipairs = var_4

		for iter_20_0, iter_20_1 in var_4(arg_19_3) do
			if arg_20_0.id ~= iter_20_1 then
				local var_20_2 = arg_20_0
				local var_20_3 = arg_20_0.isSameKind
				local var_20_4 = var_19_0

				if var_20_3(var_20_2, var_12.getShipById(var_20_4, iter_20_1)) then
					local var_20_5 = false

					i18n = var_2_10010
					var_2_10010 = var_2_10010("event_same_type_not_allowed")

					return
				end
			end
		end

		return true
	end

	local function var_19_2(arg_21_0, arg_21_1, arg_21_2)
		arg_21_1()

		return
	end

	local function var_19_3(arg_22_0)
		pairs = var_2_10001

		for iter_22_0, iter_22_1 in var_2_10001(arg_19_0.contextData.fleets) do
			ipairs = var_2_10006

			for iter_22_2, iter_22_3 in var_2_10006(iter_22_1) do
				pairs = var_2_10011

				for iter_22_4, iter_22_5 in var_2_10011(iter_22_3) do
					for iter_22_6 = 3, 1, -1 do
						if arg_19_1 == iter_22_5 and iter_22_6 == arg_19_2 then
							iter_22_5[iter_22_6] = arg_22_0[1]
						elseif iter_22_5[iter_22_6] == arg_22_0[1] then
							iter_22_5[iter_22_6] = nil
						end
					end
				end
			end
		end

		return
	end

	return var_19_1, var_19_2, var_19_3
end

function var_0_1.SetFleetSuccess(arg_23_0)
	local var_23_0 = {
		inPort = true
	}

	if arg_23_0.contextData.mapId then
		nowWorld = var_2
		var_1_10004 = var_2()

		if var_2.IsReseted(var_1_10004) then
			var_23_0 = {
				inShop = true
			}
		end
	end

	getProxy = var_2
	ContextProxy = var_1_10004

	local var_23_1 = var_2(var_1_10004)
	local var_23_2 = var_2.getContextByMediator

	WorldMediator = var_1_10005

	if var_23_2(var_23_1, var_1_10005) then
		var_2:extendData(var_23_0)

		local var_23_3 = arg_23_0.viewComponent

		var_3.closeView(var_23_3)
	else
		local var_23_4 = arg_23_0
		local var_23_5 = arg_23_0.sendNotification

		GAME = var_1_10006

		local var_23_6 = var_1_10006.CHANGE_SCENE

		SCENE = var_1_10007

		var_23_5(var_23_4, var_23_6, var_1_10007.WORLD, var_23_0)
	end

	return
end

return var_0_1

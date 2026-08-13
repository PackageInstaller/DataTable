class = var_0_10000

local var_0_0 = "BossSingleSceneTemplate"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	error = var_1_10001

	var_1_10001("Need Complete")

	return
end

function var_0_1.init(arg_2_0)
	arg_2_0:buildCommanderPanel()

	return
end

function var_0_1.GetFleetEditPanel(arg_3_0)
	if not arg_3_0.fleetEditPanel then
		BossSingleBattleFleetSelectSubPanel = var_1
		arg_3_0.fleetEditPanel = var_1.New(arg_3_0)

		local var_3_0 = arg_3_0.fleetEditPanel

		var_1.Load(var_3_0)
	end

	return arg_3_0.fleetEditPanel
end

function var_0_1.DestroyFleetEditPanel(arg_4_0)
	if arg_4_0.fleetEditPanel then
		local var_4_0 = arg_4_0.fleetEditPanel

		var_1.Destroy(var_4_0)

		arg_4_0.fleetEditPanel = nil
	end

	return
end

function var_0_1.didEnter(arg_5_0)
	if arg_5_0.contextData.editFleet then
		arg_5_0:ShowNormalFleet(arg_5_0.contextData.editFleet)
	end

	return
end

function var_0_1.ShowNormalFleet(arg_6_0, arg_6_1)
	if not arg_6_0.contextData.actFleets[arg_6_1] then
		arg_6_0.contextData.actFleets[arg_6_1] = arg_6_0:CreateNewFleet(arg_6_1)
	end

	if not arg_6_0.contextData.actFleets[arg_6_1 + 10] then
		arg_6_0.contextData.actFleets[arg_6_1 + 10] = arg_6_0:CreateNewFleet(arg_6_1 + 10)
	end

	local var_6_0 = arg_6_0.contextData.actFleets[arg_6_1]
	local var_6_1 = arg_6_0:GetFleetEditPanel()
	local var_6_2 = arg_6_0.contextData.bossActivity
	local var_6_3 = var_4.GetEnemyDataByFleetIdx(var_6_2, arg_6_1)
	local var_6_4 = var_6_1.buffer

	var_5.SetSettings(var_6_4, 1, 1, false, var_6_3:GetPropertyLimitation(), arg_6_1)

	local var_6_5 = var_6_1.buffer

	var_5.SetFleets(var_6_5, {
		arg_6_0.contextData.actFleets[arg_6_1],
		arg_6_0.contextData.actFleets[arg_6_1 + 10]
	})

	local var_6_6 = arg_6_0.contextData.useOilLimit[arg_6_1]
	local var_6_7 = arg_6_0.contextData.stageIDs[arg_6_1]
	local var_6_8 = var_6_1.buffer

	var_7.SetOilLimit(var_6_8, var_6_6)

	arg_6_0.contextData.editFleet = arg_6_1

	local var_6_9 = var_6_1.buffer

	var_7.UpdateView(var_6_9)

	local var_6_10 = var_6_1.buffer

	var_7.Show(var_6_10)

	return
end

function var_0_1.commitEdit(arg_7_0)
	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0.emit

	BossSingleMediatorTemplate = var_1_10004

	var_7_1(var_7_0, var_1_10004.ON_COMMIT_FLEET)

	return
end

function var_0_1.commitCombat(arg_8_0)
	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_0.emit

	BossSingleMediatorTemplate = var_1_10004

	var_8_1(var_8_0, var_1_10004.ON_PRECOMBAT, arg_8_0.contextData.editFleet)

	return
end

function var_0_1.updateEditPanel(arg_9_0)
	if arg_9_0.fleetEditPanel then
		local var_9_0 = arg_9_0.fleetEditPanel.buffer

		var_1.UpdateView(var_9_0)
	end

	return
end

function var_0_1.hideFleetEdit(arg_10_0)
	if arg_10_0.fleetEditPanel then
		local var_10_0 = arg_10_0.fleetEditPanel.buffer

		var_1.Hide(var_10_0)
	end

	arg_10_0.contextData.editFleet = nil

	return
end

function var_0_1.openShipInfo(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0.contextData.actFleets[arg_11_2]
	local var_11_1 = {}

	getProxy = var_1_10005
	BayProxy = var_1_10007

	local var_11_2 = var_1_10005(var_1_10007)

	ipairs = var_1_10006

	local var_11_3

	if not var_11_0 or not var_11_0.ships then
		var_11_3 = {}
	end

	for iter_11_0, iter_11_1 in var_1_10006(var_11_3) do
		table = var_1_10011

		var_1_10011.insert(var_11_1, var_11_2:getShipById(iter_11_1))
	end

	local var_11_4 = arg_11_0
	local var_11_5 = arg_11_0.emit

	BossSingleMediatorTemplate = iter_11_0

	var_11_5(var_11_4, iter_11_0.ON_FLEET_SHIPINFO, {
		shipId = arg_11_1,
		shipVOs = var_11_1
	})

	return
end

function var_0_1.setCommanderPrefabs(arg_12_0, arg_12_1)
	arg_12_0.commanderPrefabs = arg_12_1

	return
end

function var_0_1.openCommanderPanel(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0.contextData.activityID
	local var_13_1 = arg_13_0.levelCMDFormationView

	var_4.setCallback(var_13_1, function(arg_14_0)
		local var_14_0 = arg_14_0.type

		LevelUIConst = var_2_10002

		if var_14_0 == var_2_10002.COMMANDER_OP_SHOW_SKILL then
			local var_14_1 = arg_13_0
			local var_14_2 = var_1.emit

			BossSingleMediatorTemplate = var_2_10004

			var_14_2(var_14_1, var_2_10004.ON_COMMANDER_SKILL, arg_14_0.skill)
		else
			local var_14_3 = arg_14_0.type

			LevelUIConst = var_2

			if var_14_3 == var_2.COMMANDER_OP_ADD then
				arg_13_0.contextData.eliteCommanderSelected = {
					fleetIndex = arg_13_2,
					cmdPos = arg_14_0.pos,
					mode = arg_13_0.curMode
				}

				local var_14_4 = arg_13_0
				local var_14_5 = var_1.emit

				BossSingleMediatorTemplate = var_2_10004

				var_14_5(var_14_4, var_2_10004.ON_SELECT_COMMANDER, arg_13_2, arg_14_0.pos)
			else
				local var_14_6 = arg_13_0
				local var_14_7 = var_1.emit

				BossSingleMediatorTemplate = var_2_10004

				local var_14_8 = var_2_10004.COMMANDER_FORMATION_OP
				local var_14_9 = {}

				LevelUIConst = var_2_10006
				var_14_9.FleetType = var_2_10006.FLEET_TYPE_ACTIVITY
				var_14_9.data = arg_14_0
				var_14_9.fleetId = arg_13_1.id
				var_14_9.actId = var_13_0

				var_14_7(var_14_6, var_14_8, var_14_9)
			end
		end

		return
	end)

	local var_13_2 = arg_13_0.levelCMDFormationView

	var_4.Load(var_13_2)

	local var_13_3 = arg_13_0.levelCMDFormationView

	var_4.ActionInvoke(var_13_3, "update", arg_13_1, arg_13_0.commanderPrefabs)

	local var_13_4 = arg_13_0.levelCMDFormationView

	var_4.ActionInvoke(var_13_4, "Show")

	return
end

function var_0_1.updateCommanderFleet(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0.levelCMDFormationView

	if var_2.isShowing(var_15_0) then
		local var_15_1 = arg_15_0.levelCMDFormationView

		var_2.ActionInvoke(var_15_1, "updateFleet", arg_15_1)
	end

	return
end

function var_0_1.updateCommanderPrefab(arg_16_0)
	local var_16_0 = arg_16_0.levelCMDFormationView

	if var_1.isShowing(var_16_0) then
		local var_16_1 = arg_16_0.levelCMDFormationView

		var_1.ActionInvoke(var_16_1, "updatePrefabs", arg_16_0.commanderPrefabs)
	end

	return
end

function var_0_1.closeCommanderPanel(arg_17_0)
	local var_17_0 = arg_17_0.levelCMDFormationView

	if var_1.isShowing(var_17_0) then
		local var_17_1 = arg_17_0.levelCMDFormationView

		var_1.ActionInvoke(var_17_1, "Hide")
	end

	return
end

function var_0_1.buildCommanderPanel(arg_18_0)
	LevelCMDFormationView = var_1_10001
	arg_18_0.levelCMDFormationView = var_1_10001.New(arg_18_0._tf, arg_18_0.event, arg_18_0.contextData)

	return
end

function var_0_1.destroyCommanderPanel(arg_19_0)
	local var_19_0 = arg_19_0.levelCMDFormationView

	var_1.Destroy(var_19_0)

	arg_19_0.levelCMDFormationView = nil

	return
end

function var_0_1.CreateNewFleet(arg_20_0, arg_20_1)
	TypedFleet = var_1_10002

	local var_20_0 = var_1_10002.New
	local var_20_1 = {
		id = arg_20_1,
		ship_list = {},
		commanders = {}
	}

	if 10 < arg_20_1 then
		FleetType = var_20_2

		local var_20_2

		if not var_20_2.Submarine then
			FleetType = var_20_2
			var_20_2 = var_20_2.Normal
		end

		var_20_1.fleetType = var_20_2

		return var_20_0(var_20_1)
	end
end

function var_0_1.willExit(arg_21_0)
	arg_21_0:DestroyFleetEditPanel()
	arg_21_0:destroyCommanderPanel()

	return
end

return var_0_1

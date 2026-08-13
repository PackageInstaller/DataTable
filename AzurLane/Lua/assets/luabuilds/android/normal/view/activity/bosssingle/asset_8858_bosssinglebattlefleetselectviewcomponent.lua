class = var_0_10000

local var_0_0 = var_0_10000("BossSingleBattleFleetSelectViewComponent")

var_0_0.FUNC_NAME_GET_FLEET_EDIT_PANEL = "GetFleetEditPanel"
var_0_0.FUNC_NAME_DESTROY_FLEET_EDIT_PANEL = "DestroyFleetEditPanel"
var_0_0.FUNC_NAME_SHOW_NORMAL_FLEET = "ShowNormalFleet"
var_0_0.FUNC_NAME_COMMIT_EDIT = "commitEdit"
var_0_0.FUNC_NAME_COMMIT_COMBAT = "commitCombat"
var_0_0.FUNC_NAME_UPDATE_EDIT_PANEL = "updateEditPanel"
var_0_0.FUNC_NAME_HIDE_FLEET_EDIT = "hideFleetEdit"
var_0_0.FUNC_NAME_OPEN_SHIP_INFO = "openShipInfo"
var_0_0.FUNC_NAME_SET_COMMANDER_PREFABS = "setCommanderPrefabs"
var_0_0.FUNC_NAME_OPEN_COMMANDER_PANEL = "openCommanderPanel"
var_0_0.FUNC_NAME_UPDATE_COMMANDER_FLEET = "updateCommanderFleet"
var_0_0.FUNC_NAME_UPDATE_COMMANDER_PREFAB = "updateCommanderPrefab"
var_0_0.FUNC_NAME_CLOSE_COMMANDER_PANEL = "closeCommanderPanel"
var_0_0.FUNC_NAME_BUILD_COMMANDER_PANEL = "buildCommanderPanel"
var_0_0.FUNC_NAME_DESTROY_COMMANDER_PANEL = "DestroyCommanderPanel"
var_0_0.FUNC_NAME_CREATE_NEW_FLEET = "CreateNewFleet"

function var_0_0.AttachFleetSelect(arg_1_0, arg_1_1)
	var_0_0.New(arg_1_0, arg_1_1)

	return
end

function var_0_0.DetachFleetSelect(arg_2_0)
	if arg_2_0._IFleetSelect == nil then
		return
	end

	local var_2_0 = arg_2_0._IFleetSelect

	var_1._Destory_(var_2_0)

	arg_2_0._IFleetSelect = nil

	return
end

function var_0_0.Ctor(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._target_ = arg_3_1
	arg_3_0._mediatorClass_ = arg_3_2

	arg_3_0:_Init_()

	return
end

function var_0_0._Init_(arg_4_0)
	arg_4_0._target_[var_0_0.FUNC_NAME_GET_FLEET_EDIT_PANEL] = var_0_0._GetFleetEditPanel_
	arg_4_0._target_[var_0_0.FUNC_NAME_DESTROY_FLEET_EDIT_PANEL] = var_0_0._DestroyFleetEditPanel_
	arg_4_0._target_[var_0_0.FUNC_NAME_SHOW_NORMAL_FLEET] = var_0_0._ShowNormalFleet_
	arg_4_0._target_[var_0_0.FUNC_NAME_COMMIT_EDIT] = var_0_0._commitEdit_
	arg_4_0._target_[var_0_0.FUNC_NAME_COMMIT_COMBAT] = var_0_0._commitCombat_
	arg_4_0._target_[var_0_0.FUNC_NAME_UPDATE_EDIT_PANEL] = var_0_0._updateEditPanel_
	arg_4_0._target_[var_0_0.FUNC_NAME_HIDE_FLEET_EDIT] = var_0_0._hideFleetEdit_
	arg_4_0._target_[var_0_0.FUNC_NAME_OPEN_SHIP_INFO] = var_0_0._openShipInfo_
	arg_4_0._target_[var_0_0.FUNC_NAME_SET_COMMANDER_PREFABS] = var_0_0._setCommanderPrefabs_
	arg_4_0._target_[var_0_0.FUNC_NAME_OPEN_COMMANDER_PANEL] = var_0_0._openCommanderPanel_
	arg_4_0._target_[var_0_0.FUNC_NAME_UPDATE_COMMANDER_FLEET] = var_0_0._updateCommanderFleet_
	arg_4_0._target_[var_0_0.FUNC_NAME_UPDATE_COMMANDER_PREFAB] = var_0_0._updateCommanderPrefab_
	arg_4_0._target_[var_0_0.FUNC_NAME_CLOSE_COMMANDER_PANEL] = var_0_0._closeCommanderPanel_
	arg_4_0._target_[var_0_0.FUNC_NAME_BUILD_COMMANDER_PANEL] = var_0_0._buildCommanderPanel_
	arg_4_0._target_[var_0_0.FUNC_NAME_DESTROY_COMMANDER_PANEL] = var_0_0._DestroyCommanderPanel_
	arg_4_0._target_[var_0_0.FUNC_NAME_CREATE_NEW_FLEET] = var_0_0._CreateNewFleet_
	arg_4_0._target_._IFleetSelect = arg_4_0
	arg_4_0._originalFunc = {}
	arg_4_0._originalFunc.willExit = arg_4_0._target_.willExit

	function arg_4_0._target_.willExit()
		local var_5_0 = arg_4_0._target_

		var_0.DestroyFleetEditPanel(var_5_0)

		local var_5_1 = arg_4_0._target_

		var_0.DestroyCommanderPanel(var_5_1)
		arg_4_0._originalFunc.willExit(arg_4_0._target_)

		return
	end

	arg_4_0.contextData = arg_4_0._target_.contextData
	arg_4_0.emit = arg_4_0._target_.emit
	arg_4_0._tf = arg_4_0._target_._tf
	arg_4_0.event = arg_4_0._target_.event

	arg_4_0:_buildCommanderPanel_()

	return
end

function var_0_0._Destory_(arg_6_0)
	arg_6_0._target_ = nil

	return
end

function var_0_0._buildCommanderPanel_(arg_7_0)
	LevelCMDFormationView = var_1_10001
	arg_7_0.levelCMDFormationView = var_1_10001.New(arg_7_0._target_._tf, arg_7_0._target_.event, arg_7_0._target_.contextData)

	return
end

function var_0_0._GetFleetEditPanel_(arg_8_0)
	if not arg_8_0._IFleetSelect.fleetEditPanel then
		local var_8_0 = arg_8_0._IFleetSelect

		BossSingleBattleFleetSelectSubPanel = var_1_10002
		var_8_0.fleetEditPanel = var_1_10002.New(arg_8_0)

		local var_8_1 = arg_8_0._IFleetSelect.fleetEditPanel

		var_1.Load(var_8_1)
	end

	return arg_8_0._IFleetSelect.fleetEditPanel
end

function var_0_0._DestroyFleetEditPanel_(arg_9_0)
	if arg_9_0._IFleetSelect.fleetEditPanel then
		local var_9_0 = arg_9_0._IFleetSelect.fleetEditPanel

		var_1.Destroy(var_9_0)

		arg_9_0._IFleetSelect.fleetEditPanel = nil
	end

	return
end

function var_0_0._DestroyCommanderPanel_(arg_10_0)
	if arg_10_0._IFleetSelect.levelCMDFormationView then
		local var_10_0 = arg_10_0._IFleetSelect.levelCMDFormationView

		var_1.Destroy(var_10_0)

		arg_10_0._IFleetSelect.levelCMDFormationView = nil
	end

	return
end

function var_0_0._ShowNormalFleet_(arg_11_0, arg_11_1)
	pg = var_1_10002

	local var_11_0 = var_1_10002.activity_single_enemy[arg_11_1]

	getProxy = var_1_10003
	FleetProxy = var_1_10004

	local var_11_1 = var_1_10003(var_1_10004)
	local var_11_2 = var_3.getActivityFleets(var_11_1)

	ActivityConst = var_11_1

	if not var_11_2[var_11_1.Valleyhospital_ACT_ID][arg_11_1 - 2000] then
		var_4[var_5] = arg_11_0.CreateNewFleet(var_5)
	end

	Fleet = var_6

	if not var_4[var_5 + var_6.MEGA_SUBMARINE_FLEET_OFFSET] then
		Fleet = var_6

		local var_11_3 = var_5 + var_6.MEGA_SUBMARINE_FLEET_OFFSET
		local var_11_4 = arg_11_0.CreateNewFleet

		Fleet = var_1_10008
		var_4[var_11_3] = var_11_4(var_5 + var_1_10008.MEGA_SUBMARINE_FLEET_OFFSET)
	end

	local var_11_5 = var_4[var_5]
	local var_11_6 = arg_11_0:GetFleetEditPanel().buffer

	var_8.SetSettings(var_11_6, 1, 1, false, var_11_0.property_limitation, var_5)

	local var_11_7 = var_7.buffer
	local var_11_8 = var_8.SetFleets
	local var_11_9 = {
		var_4[var_5]
	}

	Fleet = var_11
	var_11_9[2] = var_4[var_5 + var_11.MEGA_SUBMARINE_FLEET_OFFSET]

	var_11_8(var_11_7, var_11_9)

	local var_11_10 = var_7.buffer

	var_8.SetOilLimit(var_11_10, var_11_0.use_oil_limit)

	arg_11_0.contextData.editFleet = var_5

	local var_11_11 = var_7.buffer

	var_8.UpdateView(var_11_11)

	local var_11_12 = var_7.buffer

	var_8.Show(var_11_12)

	return
end

function var_0_0._commitEdit_(arg_12_0)
	arg_12_0:emit(arg_12_0._IFleetSelect._mediatorClass_.ON_COMMIT_FLEET)

	return
end

function var_0_0._commitCombat_(arg_13_0)
	arg_13_0:emit(arg_13_0._IFleetSelect._mediatorClass_.ON_PRECOMBAT, arg_13_0.contextData.editFleet)

	return
end

function var_0_0._updateEditPanel_(arg_14_0)
	if arg_14_0._IFleetSelect.fleetEditPanel then
		local var_14_0 = arg_14_0._IFleetSelect.fleetEditPanel.buffer

		var_1.UpdateView(var_14_0)
	end

	return
end

function var_0_0._hideFleetEdit_(arg_15_0)
	if arg_15_0._IFleetSelect.fleetEditPanel then
		local var_15_0 = arg_15_0._IFleetSelect.fleetEditPanel.buffer

		var_1.Hide(var_15_0)
		arg_15_0:show()
	end

	arg_15_0.contextData.editFleet = nil

	return
end

function var_0_0._openShipInfo_(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0.contextData.actFleets[arg_16_2]
	local var_16_1 = {}

	getProxy = var_1_10005
	BayProxy = var_1_10006

	local var_16_2 = var_1_10005(var_1_10006)

	ipairs = var_1_10006

	local var_16_3

	if not var_16_0 or not var_16_0.ships then
		var_16_3 = {}
	end

	for iter_16_0, iter_16_1 in var_1_10006(var_16_3) do
		table = var_1_10011

		var_1_10011.insert(var_16_1, var_16_2:getShipById(iter_16_1))
	end

	arg_16_0:emit(arg_16_0._IFleetSelect._mediatorClass_.ON_FLEET_SHIPINFO, {
		shipId = arg_16_1,
		shipVOs = var_16_1
	})

	return
end

function var_0_0._setCommanderPrefabs_(arg_17_0, arg_17_1)
	arg_17_0._IFleetSelect.commanderPrefabs = arg_17_1

	return
end

function var_0_0._openCommanderPanel_(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_0.contextData.activityID
	local var_18_1 = arg_18_0._IFleetSelect.levelCMDFormationView

	var_4.setCallback(var_18_1, function(arg_19_0)
		local var_19_0 = arg_19_0.type

		LevelUIConst = var_2_10002

		local var_19_1

		if var_19_0 == var_2_10002.COMMANDER_OP_SHOW_SKILL then
			var_19_1 = arg_18_0

			var_1.emit(var_19_1, arg_18_0._IFleetSelect._mediatorClass_.ON_COMMANDER_SKILL, arg_19_0.skill)
		else
			local var_19_2 = arg_19_0.type

			LevelUIConst = var_19_1

			if var_19_2 == var_19_1.COMMANDER_OP_ADD then
				arg_18_0.contextData.eliteCommanderSelected = {
					fleetIndex = arg_18_2,
					cmdPos = arg_19_0.pos,
					mode = arg_18_0.curMode
				}

				local var_19_3 = arg_18_0

				var_1.emit(var_19_3, arg_18_0._IFleetSelect._mediatorClass_.ON_SELECT_COMMANDER, arg_18_2, arg_19_0.pos)
			else
				local var_19_4 = arg_18_0
				local var_19_5 = var_1.emit
				local var_19_6 = arg_18_0._IFleetSelect._mediatorClass_.COMMANDER_FORMATION_OP
				local var_19_7 = {}

				LevelUIConst = var_2_10005
				var_19_7.FleetType = var_2_10005.FLEET_TYPE_ACTIVITY
				var_19_7.data = arg_19_0
				var_19_7.fleetId = arg_18_1.id
				var_19_7.actId = var_18_0

				var_19_5(var_19_4, var_19_6, var_19_7)
			end
		end

		return
	end)

	local var_18_2 = arg_18_0._IFleetSelect.levelCMDFormationView

	var_4.Load(var_18_2)

	local var_18_3 = arg_18_0._IFleetSelect.levelCMDFormationView

	var_4.ActionInvoke(var_18_3, "update", arg_18_1, arg_18_0._IFleetSelect.commanderPrefabs)

	local var_18_4 = arg_18_0._IFleetSelect.levelCMDFormationView

	var_4.ActionInvoke(var_18_4, "Show")

	return
end

function var_0_0._updateCommanderFleet_(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0._IFleetSelect.levelCMDFormationView

	if var_2.isShowing(var_20_0) then
		local var_20_1 = arg_20_0._IFleetSelect.levelCMDFormationView

		var_2.ActionInvoke(var_20_1, "updateFleet", arg_20_1)
	end

	return
end

function var_0_0._updateCommanderPrefab_(arg_21_0)
	local var_21_0 = arg_21_0._IFleetSelect.levelCMDFormationView

	if var_1.isShowing(var_21_0) then
		local var_21_1 = arg_21_0._IFleetSelect.levelCMDFormationView

		var_1.ActionInvoke(var_21_1, "updatePrefabs", arg_21_0._IFleetSelect.commanderPrefabs)
	end

	return
end

function var_0_0._closeCommanderPanel_(arg_22_0)
	local var_22_0 = arg_22_0._IFleetSelect.levelCMDFormationView

	if var_1.isShowing(var_22_0) then
		local var_22_1 = arg_22_0._IFleetSelect.levelCMDFormationView

		var_1.ActionInvoke(var_22_1, "Hide")
	end

	return
end

function var_0_0._CreateNewFleet_(arg_23_0)
	TypedFleet = var_1_10001

	local var_23_0 = var_1_10001.New
	local var_23_1 = {
		id = arg_23_0,
		ship_list = {},
		commanders = {}
	}

	Fleet = var_3

	if var_3.MEGA_SUBMARINE_FLEET_OFFSET < arg_23_0 then
		FleetType = var_23_2

		local var_23_2

		if not var_23_2.Submarine then
			FleetType = var_23_2
			var_23_2 = var_23_2.Normal
		end

		var_23_1.fleetType = var_23_2

		return var_23_0(var_23_1)
	end
end

return var_0_0

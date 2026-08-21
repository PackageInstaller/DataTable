local var_0_0 = class("BossSingleBattleFleetSelectViewComponent")

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

	arg_2_0._IFleetSelect:_Destory_()

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
		arg_4_0._target_:DestroyFleetEditPanel()
		arg_4_0._target_:DestroyCommanderPanel()
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
	arg_7_0.levelCMDFormationView = LevelCMDFormationView.New(arg_7_0._target_._tf, arg_7_0._target_.event, arg_7_0._target_.contextData)

	return
end

function var_0_0._GetFleetEditPanel_(arg_8_0)
	if not arg_8_0._IFleetSelect.fleetEditPanel then
		arg_8_0._IFleetSelect.fleetEditPanel = BossSingleBattleFleetSelectSubPanel.New(arg_8_0)

		arg_8_0._IFleetSelect.fleetEditPanel:Load()
	end

	return arg_8_0._IFleetSelect.fleetEditPanel
end

function var_0_0._DestroyFleetEditPanel_(arg_9_0)
	if arg_9_0._IFleetSelect.fleetEditPanel then
		arg_9_0._IFleetSelect.fleetEditPanel:Destroy()

		arg_9_0._IFleetSelect.fleetEditPanel = nil
	end

	return
end

function var_0_0._DestroyCommanderPanel_(arg_10_0)
	if arg_10_0._IFleetSelect.levelCMDFormationView then
		arg_10_0._IFleetSelect.levelCMDFormationView:Destroy()

		arg_10_0._IFleetSelect.levelCMDFormationView = nil
	end

	return
end

function var_0_0._ShowNormalFleet_(arg_11_0, arg_11_1)
	local var_11_0 = getProxy(FleetProxy):getActivityFleets()[ActivityConst.Valleyhospital_ACT_ID]

	var_11_0[arg_11_1 - 2000] = var_11_0[arg_11_1 - 2000] or arg_11_0.CreateNewFleet(arg_11_1 - 2000)
	var_11_0[arg_11_1 - 2000 + Fleet.MEGA_SUBMARINE_FLEET_OFFSET] = var_11_0[arg_11_1 - 2000 + Fleet.MEGA_SUBMARINE_FLEET_OFFSET] or arg_11_0.CreateNewFleet(arg_11_1 - 2000 + Fleet.MEGA_SUBMARINE_FLEET_OFFSET)

	local var_11_2 = arg_11_0:GetFleetEditPanel()

	var_11_2.buffer:SetSettings(1, 1, false, pg.activity_single_enemy[arg_11_1].property_limitation, arg_11_1 - 2000)
	var_11_2.buffer:SetFleets({
		var_11_0[arg_11_1 - 2000],
		var_11_0[arg_11_1 - 2000 + Fleet.MEGA_SUBMARINE_FLEET_OFFSET]
	})
	var_11_2.buffer:SetOilLimit(pg.activity_single_enemy[arg_11_1].use_oil_limit)

	arg_11_0.contextData.editFleet = arg_11_1 - 2000

	var_11_2.buffer:UpdateView()
	var_11_2.buffer:Show()

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
		arg_14_0._IFleetSelect.fleetEditPanel.buffer:UpdateView()
	end

	return
end

function var_0_0._hideFleetEdit_(arg_15_0)
	if arg_15_0._IFleetSelect.fleetEditPanel then
		arg_15_0._IFleetSelect.fleetEditPanel.buffer:Hide()
		arg_15_0:show()
	end

	arg_15_0.contextData.editFleet = nil

	return
end

function var_0_0._openShipInfo_(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = {}
	local var_16_1 = getProxy(BayProxy)

	if arg_16_0.contextData.actFleets[arg_16_2] then
		local var_16_3 = arg_16_0.contextData.actFleets[arg_16_2].ships or {}

		for iter_16_0, iter_16_1 in var_16_2(var_16_3) do
			table.insert(var_16_0, var_16_1:getShipById(iter_16_1))
		end

		arg_16_0:emit(arg_16_0._IFleetSelect._mediatorClass_.ON_FLEET_SHIPINFO, {
			shipId = arg_16_1,
			shipVOs = var_16_0
		})

		return
	end
end

function var_0_0._setCommanderPrefabs_(arg_17_0, arg_17_1)
	arg_17_0._IFleetSelect.commanderPrefabs = arg_17_1

	return
end

function var_0_0._openCommanderPanel_(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_0.contextData.activityID

	arg_18_0._IFleetSelect.levelCMDFormationView:setCallback(function(arg_19_0)
		if arg_19_0.type == LevelUIConst.COMMANDER_OP_SHOW_SKILL then
			arg_18_0:emit(arg_18_0._IFleetSelect._mediatorClass_.ON_COMMANDER_SKILL, arg_19_0.skill)
		elseif arg_19_0.type == LevelUIConst.COMMANDER_OP_ADD then
			arg_18_0.contextData.eliteCommanderSelected = {
				fleetIndex = arg_18_2,
				cmdPos = arg_19_0.pos,
				mode = arg_18_0.curMode
			}

			arg_18_0:emit(arg_18_0._IFleetSelect._mediatorClass_.ON_SELECT_COMMANDER, arg_18_2, arg_19_0.pos)
		else
			arg_18_0:emit(arg_18_0._IFleetSelect._mediatorClass_.COMMANDER_FORMATION_OP, {
				FleetType = LevelUIConst.FLEET_TYPE_ACTIVITY,
				data = arg_19_0,
				fleetId = arg_18_1.id,
				actId = var_18_0
			})
		end

		return
	end)
	arg_18_0._IFleetSelect.levelCMDFormationView:Load()
	arg_18_0._IFleetSelect.levelCMDFormationView:ActionInvoke("update", arg_18_1, arg_18_0._IFleetSelect.commanderPrefabs)
	arg_18_0._IFleetSelect.levelCMDFormationView:ActionInvoke("Show")

	return
end

function var_0_0._updateCommanderFleet_(arg_20_0, arg_20_1)
	if arg_20_0._IFleetSelect.levelCMDFormationView:isShowing() then
		arg_20_0._IFleetSelect.levelCMDFormationView:ActionInvoke("updateFleet", arg_20_1)
	end

	return
end

function var_0_0._updateCommanderPrefab_(arg_21_0)
	if arg_21_0._IFleetSelect.levelCMDFormationView:isShowing() then
		arg_21_0._IFleetSelect.levelCMDFormationView:ActionInvoke("updatePrefabs", arg_21_0._IFleetSelect.commanderPrefabs)
	end

	return
end

function var_0_0._closeCommanderPanel_(arg_22_0)
	if arg_22_0._IFleetSelect.levelCMDFormationView:isShowing() then
		arg_22_0._IFleetSelect.levelCMDFormationView:ActionInvoke("Hide")
	end

	return
end

function var_0_0._CreateNewFleet_(arg_23_0)
	local var_23_1 = {
		id = arg_23_0,
		ship_list = {},
		commanders = {}
	}

	if arg_23_0 > Fleet.MEGA_SUBMARINE_FLEET_OFFSET then
		var_23_1.fleetType = FleetType.Submarine or FleetType.Normal

		return var_23_0(var_23_1)
	end
end

return var_0_0

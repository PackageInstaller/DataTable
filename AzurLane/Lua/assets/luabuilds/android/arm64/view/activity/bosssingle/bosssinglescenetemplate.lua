local var_0_0 = class("BossSingleSceneTemplate", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	error("Need Complete")

	return
end

function var_0_0.init(arg_2_0)
	arg_2_0:buildCommanderPanel()

	return
end

function var_0_0.GetFleetEditPanel(arg_3_0)
	if not arg_3_0.fleetEditPanel then
		arg_3_0.fleetEditPanel = BossSingleBattleFleetSelectSubPanel.New(arg_3_0)

		arg_3_0.fleetEditPanel:Load()
	end

	return arg_3_0.fleetEditPanel
end

function var_0_0.DestroyFleetEditPanel(arg_4_0)
	if arg_4_0.fleetEditPanel then
		arg_4_0.fleetEditPanel:Destroy()

		arg_4_0.fleetEditPanel = nil
	end

	return
end

function var_0_0.didEnter(arg_5_0)
	if arg_5_0.contextData.editFleet then
		arg_5_0:ShowNormalFleet(arg_5_0.contextData.editFleet)
	end

	return
end

function var_0_0.ShowNormalFleet(arg_6_0, arg_6_1)
	arg_6_0.contextData.actFleets[arg_6_1] = arg_6_0.contextData.actFleets[arg_6_1] or arg_6_0:CreateNewFleet(arg_6_1)
	arg_6_0.contextData.actFleets[arg_6_1 + 10] = arg_6_0.contextData.actFleets[arg_6_1 + 10] or arg_6_0:CreateNewFleet(arg_6_1 + 10)

	local var_6_1 = arg_6_0:GetFleetEditPanel()

	var_6_1.buffer:SetSettings(1, 1, false, arg_6_0.contextData.bossActivity:GetEnemyDataByFleetIdx(arg_6_1):GetPropertyLimitation(), arg_6_1)
	var_6_1.buffer:SetFleets({
		arg_6_0.contextData.actFleets[arg_6_1],
		arg_6_0.contextData.actFleets[arg_6_1 + 10]
	})
	var_6_1.buffer:SetOilLimit(arg_6_0.contextData.useOilLimit[arg_6_1])

	arg_6_0.contextData.editFleet = arg_6_1

	var_6_1.buffer:UpdateView()
	var_6_1.buffer:Show()

	return
end

function var_0_0.commitEdit(arg_7_0)
	arg_7_0:emit(BossSingleMediatorTemplate.ON_COMMIT_FLEET)

	return
end

function var_0_0.commitCombat(arg_8_0)
	arg_8_0:emit(BossSingleMediatorTemplate.ON_PRECOMBAT, arg_8_0.contextData.editFleet)

	return
end

function var_0_0.updateEditPanel(arg_9_0)
	if arg_9_0.fleetEditPanel then
		arg_9_0.fleetEditPanel.buffer:UpdateView()
	end

	return
end

function var_0_0.hideFleetEdit(arg_10_0)
	if arg_10_0.fleetEditPanel then
		arg_10_0.fleetEditPanel.buffer:Hide()
	end

	arg_10_0.contextData.editFleet = nil

	return
end

function var_0_0.openShipInfo(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = {}
	local var_11_1 = getProxy(BayProxy)

	if arg_11_0.contextData.actFleets[arg_11_2] then
		local var_11_3 = arg_11_0.contextData.actFleets[arg_11_2].ships or {}

		for iter_11_0, iter_11_1 in var_11_2(var_11_3) do
			table.insert(var_11_0, var_11_1:getShipById(iter_11_1))
		end

		arg_11_0:emit(BossSingleMediatorTemplate.ON_FLEET_SHIPINFO, {
			shipId = arg_11_1,
			shipVOs = var_11_0
		})

		return
	end
end

function var_0_0.setCommanderPrefabs(arg_12_0, arg_12_1)
	arg_12_0.commanderPrefabs = arg_12_1

	return
end

function var_0_0.openCommanderPanel(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0.contextData.activityID

	arg_13_0.levelCMDFormationView:setCallback(function(arg_14_0)
		if arg_14_0.type == LevelUIConst.COMMANDER_OP_SHOW_SKILL then
			arg_13_0:emit(BossSingleMediatorTemplate.ON_COMMANDER_SKILL, arg_14_0.skill)
		elseif arg_14_0.type == LevelUIConst.COMMANDER_OP_ADD then
			arg_13_0.contextData.eliteCommanderSelected = {
				fleetIndex = arg_13_2,
				cmdPos = arg_14_0.pos,
				mode = arg_13_0.curMode
			}

			arg_13_0:emit(BossSingleMediatorTemplate.ON_SELECT_COMMANDER, arg_13_2, arg_14_0.pos)
		else
			arg_13_0:emit(BossSingleMediatorTemplate.COMMANDER_FORMATION_OP, {
				FleetType = LevelUIConst.FLEET_TYPE_ACTIVITY,
				data = arg_14_0,
				fleetId = arg_13_1.id,
				actId = var_13_0
			})
		end

		return
	end)
	arg_13_0.levelCMDFormationView:Load()
	arg_13_0.levelCMDFormationView:ActionInvoke("update", arg_13_1, arg_13_0.commanderPrefabs)
	arg_13_0.levelCMDFormationView:ActionInvoke("Show")

	return
end

function var_0_0.updateCommanderFleet(arg_15_0, arg_15_1)
	if arg_15_0.levelCMDFormationView:isShowing() then
		arg_15_0.levelCMDFormationView:ActionInvoke("updateFleet", arg_15_1)
	end

	return
end

function var_0_0.updateCommanderPrefab(arg_16_0)
	if arg_16_0.levelCMDFormationView:isShowing() then
		arg_16_0.levelCMDFormationView:ActionInvoke("updatePrefabs", arg_16_0.commanderPrefabs)
	end

	return
end

function var_0_0.closeCommanderPanel(arg_17_0)
	if arg_17_0.levelCMDFormationView:isShowing() then
		arg_17_0.levelCMDFormationView:ActionInvoke("Hide")
	end

	return
end

function var_0_0.buildCommanderPanel(arg_18_0)
	arg_18_0.levelCMDFormationView = LevelCMDFormationView.New(arg_18_0._tf, arg_18_0.event, arg_18_0.contextData)

	return
end

function var_0_0.destroyCommanderPanel(arg_19_0)
	arg_19_0.levelCMDFormationView:Destroy()

	arg_19_0.levelCMDFormationView = nil

	return
end

function var_0_0.CreateNewFleet(arg_20_0, arg_20_1)
	local var_20_1 = {
		id = arg_20_1,
		ship_list = {},
		commanders = {}
	}

	if arg_20_1 > 10 then
		var_20_1.fleetType = FleetType.Submarine or FleetType.Normal

		return var_20_0(var_20_1)
	end
end

function var_0_0.willExit(arg_21_0)
	arg_21_0:DestroyFleetEditPanel()
	arg_21_0:destroyCommanderPanel()

	return
end

return var_0_0

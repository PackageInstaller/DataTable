local BossSingleSceneTemplate = class("BossSingleSceneTemplate", import("view.base.BaseUI"))

function BossSingleSceneTemplate:getUIName()
	error("Need Complete")

	return
end

function BossSingleSceneTemplate:init()
	self:buildCommanderPanel()

	return
end

function BossSingleSceneTemplate:GetFleetEditPanel()
	if not self.fleetEditPanel then
		self.fleetEditPanel = BossSingleBattleFleetSelectSubPanel.New(self)

		self.fleetEditPanel:Load()
	end

	return self.fleetEditPanel
end

function BossSingleSceneTemplate:DestroyFleetEditPanel()
	if self.fleetEditPanel then
		self.fleetEditPanel:Destroy()

		self.fleetEditPanel = nil
	end

	return
end

function BossSingleSceneTemplate:didEnter()
	if self.contextData.editFleet then
		self:ShowNormalFleet(self.contextData.editFleet)
	end

	return
end

function BossSingleSceneTemplate:ShowNormalFleet(arg_6_1)
	self.contextData.actFleets[arg_6_1] = self.contextData.actFleets[arg_6_1] or self:CreateNewFleet(arg_6_1)
	self.contextData.actFleets[arg_6_1 + 10] = self.contextData.actFleets[arg_6_1 + 10] or self:CreateNewFleet(arg_6_1 + 10)

	local var_6_1 = self:GetFleetEditPanel()

	var_6_1.buffer:SetSettings(1, 1, false, self.contextData.bossActivity:GetEnemyDataByFleetIdx(arg_6_1):GetPropertyLimitation(), arg_6_1)
	var_6_1.buffer:SetFleets({
		self.contextData.actFleets[arg_6_1],
		self.contextData.actFleets[arg_6_1 + 10]
	})
	var_6_1.buffer:SetOilLimit(self.contextData.useOilLimit[arg_6_1])

	self.contextData.editFleet = arg_6_1

	var_6_1.buffer:UpdateView()
	var_6_1.buffer:Show()

	return
end

function BossSingleSceneTemplate:commitEdit()
	self:emit(BossSingleMediatorTemplate.ON_COMMIT_FLEET)

	return
end

function BossSingleSceneTemplate:commitCombat()
	self:emit(BossSingleMediatorTemplate.ON_PRECOMBAT, self.contextData.editFleet)

	return
end

function BossSingleSceneTemplate:updateEditPanel()
	if self.fleetEditPanel then
		self.fleetEditPanel.buffer:UpdateView()
	end

	return
end

function BossSingleSceneTemplate:hideFleetEdit()
	if self.fleetEditPanel then
		self.fleetEditPanel.buffer:Hide()
	end

	self.contextData.editFleet = nil

	return
end

function BossSingleSceneTemplate:openShipInfo(arg_11_1, arg_11_2)
	local var_11_0 = {}
	local var_11_1 = getProxy(BayProxy)

	for iter_11_0, iter_11_1 in ipairs((self.contextData.actFleets[arg_11_2] or nil) and (self.contextData.actFleets[arg_11_2].ships or {})) do
		table.insert(var_11_0, var_11_1:getShipById(iter_11_1))
	end

	self:emit(BossSingleMediatorTemplate.ON_FLEET_SHIPINFO, {
		shipId = arg_11_1,
		shipVOs = var_11_0
	})

	return
end

function BossSingleSceneTemplate:setCommanderPrefabs(arg_12_1)
	self.commanderPrefabs = arg_12_1

	return
end

function BossSingleSceneTemplate:openCommanderPanel(arg_13_1, arg_13_2)
	local var_13_0 = self.contextData.activityID

	self.levelCMDFormationView:setCallback(function(arg_14_0)
		if arg_14_0.type == LevelUIConst.COMMANDER_OP_SHOW_SKILL then
			self:emit(BossSingleMediatorTemplate.ON_COMMANDER_SKILL, arg_14_0.skill)
		elseif arg_14_0.type == LevelUIConst.COMMANDER_OP_ADD then
			self.contextData.eliteCommanderSelected = {
				fleetIndex = arg_13_2,
				cmdPos = arg_14_0.pos,
				mode = self.curMode
			}

			self:emit(BossSingleMediatorTemplate.ON_SELECT_COMMANDER, arg_13_2, arg_14_0.pos)
		else
			self:emit(BossSingleMediatorTemplate.COMMANDER_FORMATION_OP, {
				FleetType = LevelUIConst.FLEET_TYPE_ACTIVITY,
				data = arg_14_0,
				fleetId = arg_13_1.id,
				actId = var_13_0
			})
		end

		return
	end)
	self.levelCMDFormationView:Load()
	self.levelCMDFormationView:ActionInvoke("update", arg_13_1, self.commanderPrefabs)
	self.levelCMDFormationView:ActionInvoke("Show")

	return
end

function BossSingleSceneTemplate:updateCommanderFleet(arg_15_1)
	if self.levelCMDFormationView:isShowing() then
		self.levelCMDFormationView:ActionInvoke("updateFleet", arg_15_1)
	end

	return
end

function BossSingleSceneTemplate:updateCommanderPrefab()
	if self.levelCMDFormationView:isShowing() then
		self.levelCMDFormationView:ActionInvoke("updatePrefabs", self.commanderPrefabs)
	end

	return
end

function BossSingleSceneTemplate:closeCommanderPanel()
	if self.levelCMDFormationView:isShowing() then
		self.levelCMDFormationView:ActionInvoke("Hide")
	end

	return
end

function BossSingleSceneTemplate:buildCommanderPanel()
	self.levelCMDFormationView = LevelCMDFormationView.New(self._tf, self.event, self.contextData)

	return
end

function BossSingleSceneTemplate:destroyCommanderPanel()
	self.levelCMDFormationView:Destroy()

	self.levelCMDFormationView = nil

	return
end

function BossSingleSceneTemplate:CreateNewFleet(arg_20_1)
	local var_20_0 = {
		id = arg_20_1,
		ship_list = {},
		commanders = {}
	}

	if arg_20_1 > 10 then
		var_20_0.fleetType = FleetType.Submarine or FleetType.Normal
	end

	return TypedFleet.New(var_20_0)
end

function BossSingleSceneTemplate:willExit()
	self:DestroyFleetEditPanel()
	self:destroyCommanderPanel()

	return
end

return BossSingleSceneTemplate

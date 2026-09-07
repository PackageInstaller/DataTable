local BossSingleBattleFleetSelectViewComponent = class("BossSingleBattleFleetSelectViewComponent")

BossSingleBattleFleetSelectViewComponent.FUNC_NAME_GET_FLEET_EDIT_PANEL = "GetFleetEditPanel"
BossSingleBattleFleetSelectViewComponent.FUNC_NAME_DESTROY_FLEET_EDIT_PANEL = "DestroyFleetEditPanel"
BossSingleBattleFleetSelectViewComponent.FUNC_NAME_SHOW_NORMAL_FLEET = "ShowNormalFleet"
BossSingleBattleFleetSelectViewComponent.FUNC_NAME_COMMIT_EDIT = "commitEdit"
BossSingleBattleFleetSelectViewComponent.FUNC_NAME_COMMIT_COMBAT = "commitCombat"
BossSingleBattleFleetSelectViewComponent.FUNC_NAME_UPDATE_EDIT_PANEL = "updateEditPanel"
BossSingleBattleFleetSelectViewComponent.FUNC_NAME_HIDE_FLEET_EDIT = "hideFleetEdit"
BossSingleBattleFleetSelectViewComponent.FUNC_NAME_OPEN_SHIP_INFO = "openShipInfo"
BossSingleBattleFleetSelectViewComponent.FUNC_NAME_SET_COMMANDER_PREFABS = "setCommanderPrefabs"
BossSingleBattleFleetSelectViewComponent.FUNC_NAME_OPEN_COMMANDER_PANEL = "openCommanderPanel"
BossSingleBattleFleetSelectViewComponent.FUNC_NAME_UPDATE_COMMANDER_FLEET = "updateCommanderFleet"
BossSingleBattleFleetSelectViewComponent.FUNC_NAME_UPDATE_COMMANDER_PREFAB = "updateCommanderPrefab"
BossSingleBattleFleetSelectViewComponent.FUNC_NAME_CLOSE_COMMANDER_PANEL = "closeCommanderPanel"
BossSingleBattleFleetSelectViewComponent.FUNC_NAME_BUILD_COMMANDER_PANEL = "buildCommanderPanel"
BossSingleBattleFleetSelectViewComponent.FUNC_NAME_DESTROY_COMMANDER_PANEL = "DestroyCommanderPanel"
BossSingleBattleFleetSelectViewComponent.FUNC_NAME_CREATE_NEW_FLEET = "CreateNewFleet"

function BossSingleBattleFleetSelectViewComponent:AttachFleetSelect(arg_1_1)
	BossSingleBattleFleetSelectViewComponent.New(self, arg_1_1)

	return
end

function BossSingleBattleFleetSelectViewComponent:DetachFleetSelect()
	if self._IFleetSelect == nil then
		return
	end

	self._IFleetSelect:_Destory_()

	self._IFleetSelect = nil

	return
end

function BossSingleBattleFleetSelectViewComponent:Ctor(arg_3_1, arg_3_2)
	self._target_ = arg_3_1
	self._mediatorClass_ = arg_3_2

	self:_Init_()

	return
end

function BossSingleBattleFleetSelectViewComponent:_Init_()
	self._target_[BossSingleBattleFleetSelectViewComponent.FUNC_NAME_GET_FLEET_EDIT_PANEL] = BossSingleBattleFleetSelectViewComponent._GetFleetEditPanel_
	self._target_[BossSingleBattleFleetSelectViewComponent.FUNC_NAME_DESTROY_FLEET_EDIT_PANEL] = BossSingleBattleFleetSelectViewComponent._DestroyFleetEditPanel_
	self._target_[BossSingleBattleFleetSelectViewComponent.FUNC_NAME_SHOW_NORMAL_FLEET] = BossSingleBattleFleetSelectViewComponent._ShowNormalFleet_
	self._target_[BossSingleBattleFleetSelectViewComponent.FUNC_NAME_COMMIT_EDIT] = BossSingleBattleFleetSelectViewComponent._commitEdit_
	self._target_[BossSingleBattleFleetSelectViewComponent.FUNC_NAME_COMMIT_COMBAT] = BossSingleBattleFleetSelectViewComponent._commitCombat_
	self._target_[BossSingleBattleFleetSelectViewComponent.FUNC_NAME_UPDATE_EDIT_PANEL] = BossSingleBattleFleetSelectViewComponent._updateEditPanel_
	self._target_[BossSingleBattleFleetSelectViewComponent.FUNC_NAME_HIDE_FLEET_EDIT] = BossSingleBattleFleetSelectViewComponent._hideFleetEdit_
	self._target_[BossSingleBattleFleetSelectViewComponent.FUNC_NAME_OPEN_SHIP_INFO] = BossSingleBattleFleetSelectViewComponent._openShipInfo_
	self._target_[BossSingleBattleFleetSelectViewComponent.FUNC_NAME_SET_COMMANDER_PREFABS] = BossSingleBattleFleetSelectViewComponent._setCommanderPrefabs_
	self._target_[BossSingleBattleFleetSelectViewComponent.FUNC_NAME_OPEN_COMMANDER_PANEL] = BossSingleBattleFleetSelectViewComponent._openCommanderPanel_
	self._target_[BossSingleBattleFleetSelectViewComponent.FUNC_NAME_UPDATE_COMMANDER_FLEET] = BossSingleBattleFleetSelectViewComponent._updateCommanderFleet_
	self._target_[BossSingleBattleFleetSelectViewComponent.FUNC_NAME_UPDATE_COMMANDER_PREFAB] = BossSingleBattleFleetSelectViewComponent._updateCommanderPrefab_
	self._target_[BossSingleBattleFleetSelectViewComponent.FUNC_NAME_CLOSE_COMMANDER_PANEL] = BossSingleBattleFleetSelectViewComponent._closeCommanderPanel_
	self._target_[BossSingleBattleFleetSelectViewComponent.FUNC_NAME_BUILD_COMMANDER_PANEL] = BossSingleBattleFleetSelectViewComponent._buildCommanderPanel_
	self._target_[BossSingleBattleFleetSelectViewComponent.FUNC_NAME_DESTROY_COMMANDER_PANEL] = BossSingleBattleFleetSelectViewComponent._DestroyCommanderPanel_
	self._target_[BossSingleBattleFleetSelectViewComponent.FUNC_NAME_CREATE_NEW_FLEET] = BossSingleBattleFleetSelectViewComponent._CreateNewFleet_
	self._target_._IFleetSelect = self
	self._originalFunc = {}
	self._originalFunc.willExit = self._target_.willExit

	function self._target_.willExit()
		self._target_:DestroyFleetEditPanel()
		self._target_:DestroyCommanderPanel()
		self._originalFunc.willExit(self._target_)

		return
	end

	self.contextData = self._target_.contextData
	self.emit = self._target_.emit
	self._tf = self._target_._tf
	self.event = self._target_.event

	self:_buildCommanderPanel_()

	return
end

function BossSingleBattleFleetSelectViewComponent:_Destory_()
	self._target_ = nil

	return
end

function BossSingleBattleFleetSelectViewComponent:_buildCommanderPanel_()
	self.levelCMDFormationView = LevelCMDFormationView.New(self._target_._tf, self._target_.event, self._target_.contextData)

	return
end

function BossSingleBattleFleetSelectViewComponent:_GetFleetEditPanel_()
	if not self._IFleetSelect.fleetEditPanel then
		self._IFleetSelect.fleetEditPanel = BossSingleBattleFleetSelectSubPanel.New(self)

		self._IFleetSelect.fleetEditPanel:Load()
	end

	return self._IFleetSelect.fleetEditPanel
end

function BossSingleBattleFleetSelectViewComponent:_DestroyFleetEditPanel_()
	if self._IFleetSelect.fleetEditPanel then
		self._IFleetSelect.fleetEditPanel:Destroy()

		self._IFleetSelect.fleetEditPanel = nil
	end

	return
end

function BossSingleBattleFleetSelectViewComponent:_DestroyCommanderPanel_()
	if self._IFleetSelect.levelCMDFormationView then
		self._IFleetSelect.levelCMDFormationView:Destroy()

		self._IFleetSelect.levelCMDFormationView = nil
	end

	return
end

function BossSingleBattleFleetSelectViewComponent:_ShowNormalFleet_(arg_11_1)
	local var_11_0 = getProxy(FleetProxy):getActivityFleets()[ActivityConst.Valleyhospital_ACT_ID]

	var_11_0[arg_11_1 - 2000] = var_11_0[arg_11_1 - 2000] or self.CreateNewFleet(arg_11_1 - 2000)
	var_11_0[arg_11_1 - 2000 + Fleet.MEGA_SUBMARINE_FLEET_OFFSET] = var_11_0[arg_11_1 - 2000 + Fleet.MEGA_SUBMARINE_FLEET_OFFSET] or self.CreateNewFleet(arg_11_1 - 2000 + Fleet.MEGA_SUBMARINE_FLEET_OFFSET)

	local var_11_2 = self:GetFleetEditPanel()

	var_11_2.buffer:SetSettings(1, 1, false, pg.activity_single_enemy[arg_11_1].property_limitation, arg_11_1 - 2000)
	var_11_2.buffer:SetFleets({
		var_11_0[arg_11_1 - 2000],
		var_11_0[arg_11_1 - 2000 + Fleet.MEGA_SUBMARINE_FLEET_OFFSET]
	})
	var_11_2.buffer:SetOilLimit(pg.activity_single_enemy[arg_11_1].use_oil_limit)

	self.contextData.editFleet = arg_11_1 - 2000

	var_11_2.buffer:UpdateView()
	var_11_2.buffer:Show()

	return
end

function BossSingleBattleFleetSelectViewComponent:_commitEdit_()
	self:emit(self._IFleetSelect._mediatorClass_.ON_COMMIT_FLEET)

	return
end

function BossSingleBattleFleetSelectViewComponent:_commitCombat_()
	self:emit(self._IFleetSelect._mediatorClass_.ON_PRECOMBAT, self.contextData.editFleet)

	return
end

function BossSingleBattleFleetSelectViewComponent:_updateEditPanel_()
	if self._IFleetSelect.fleetEditPanel then
		self._IFleetSelect.fleetEditPanel.buffer:UpdateView()
	end

	return
end

function BossSingleBattleFleetSelectViewComponent:_hideFleetEdit_()
	if self._IFleetSelect.fleetEditPanel then
		self._IFleetSelect.fleetEditPanel.buffer:Hide()
		self:show()
	end

	self.contextData.editFleet = nil

	return
end

function BossSingleBattleFleetSelectViewComponent:_openShipInfo_(arg_16_1, arg_16_2)
	local var_16_0 = {}
	local var_16_1 = getProxy(BayProxy)

	for iter_16_0, iter_16_1 in ipairs((self.contextData.actFleets[arg_16_2] or nil) and (self.contextData.actFleets[arg_16_2].ships or {})) do
		table.insert(var_16_0, var_16_1:getShipById(iter_16_1))
	end

	self:emit(self._IFleetSelect._mediatorClass_.ON_FLEET_SHIPINFO, {
		shipId = arg_16_1,
		shipVOs = var_16_0
	})

	return
end

function BossSingleBattleFleetSelectViewComponent:_setCommanderPrefabs_(arg_17_1)
	self._IFleetSelect.commanderPrefabs = arg_17_1

	return
end

function BossSingleBattleFleetSelectViewComponent:_openCommanderPanel_(arg_18_1, arg_18_2)
	local var_18_0 = self.contextData.activityID

	self._IFleetSelect.levelCMDFormationView:setCallback(function(arg_19_0)
		if arg_19_0.type == LevelUIConst.COMMANDER_OP_SHOW_SKILL then
			self:emit(self._IFleetSelect._mediatorClass_.ON_COMMANDER_SKILL, arg_19_0.skill)
		elseif arg_19_0.type == LevelUIConst.COMMANDER_OP_ADD then
			self.contextData.eliteCommanderSelected = {
				fleetIndex = arg_18_2,
				cmdPos = arg_19_0.pos,
				mode = self.curMode
			}

			self:emit(self._IFleetSelect._mediatorClass_.ON_SELECT_COMMANDER, arg_18_2, arg_19_0.pos)
		else
			self:emit(self._IFleetSelect._mediatorClass_.COMMANDER_FORMATION_OP, {
				FleetType = LevelUIConst.FLEET_TYPE_ACTIVITY,
				data = arg_19_0,
				fleetId = arg_18_1.id,
				actId = var_18_0
			})
		end

		return
	end)
	self._IFleetSelect.levelCMDFormationView:Load()
	self._IFleetSelect.levelCMDFormationView:ActionInvoke("update", arg_18_1, self._IFleetSelect.commanderPrefabs)
	self._IFleetSelect.levelCMDFormationView:ActionInvoke("Show")

	return
end

function BossSingleBattleFleetSelectViewComponent:_updateCommanderFleet_(arg_20_1)
	if self._IFleetSelect.levelCMDFormationView:isShowing() then
		self._IFleetSelect.levelCMDFormationView:ActionInvoke("updateFleet", arg_20_1)
	end

	return
end

function BossSingleBattleFleetSelectViewComponent:_updateCommanderPrefab_()
	if self._IFleetSelect.levelCMDFormationView:isShowing() then
		self._IFleetSelect.levelCMDFormationView:ActionInvoke("updatePrefabs", self._IFleetSelect.commanderPrefabs)
	end

	return
end

function BossSingleBattleFleetSelectViewComponent:_closeCommanderPanel_()
	if self._IFleetSelect.levelCMDFormationView:isShowing() then
		self._IFleetSelect.levelCMDFormationView:ActionInvoke("Hide")
	end

	return
end

function BossSingleBattleFleetSelectViewComponent:_CreateNewFleet_()
	local var_23_0 = {
		id = self,
		ship_list = {},
		commanders = {}
	}

	if self > Fleet.MEGA_SUBMARINE_FLEET_OFFSET then
		var_23_0.fleetType = FleetType.Submarine or FleetType.Normal
	end

	return TypedFleet.New(var_23_0)
end

return BossSingleBattleFleetSelectViewComponent

local LimitChallengePreCombatLayer = class("LimitChallengePreCombatLayer", import("view.base.BaseUI"))
local FormationUI = import("view.ship.FormationUI")
local var_0_2 = {
	[99] = true
}

function LimitChallengePreCombatLayer:getUIName()
	return "LimitChallengePreCombatUI"
end

function LimitChallengePreCombatLayer:tempCache()
	return true
end

function LimitChallengePreCombatLayer:init()
	self:CommonInit()

	self._formationLogic = BaseFormation.New(self._tf, self._heroContainer, self._heroInfo, self._gridTFs)

	self:Register()

	return
end

function LimitChallengePreCombatLayer:CommonInit()
	self.eventTriggers = {}

	setActive(self._fleetInfo, true)

	self._gridTFs = {
		[TeamType.Vanguard] = {},
		[TeamType.Main] = {},
		[TeamType.Submarine] = {}
	}

	for iter_4_0 = 1, 3 do
		self._gridTFs[TeamType.Main][iter_4_0] = self._gridFrame:Find("main_" .. iter_4_0)
		self._gridTFs[TeamType.Vanguard][iter_4_0] = self._gridFrame:Find("vanguard_" .. iter_4_0)
		self._gridTFs[TeamType.Submarine][iter_4_0] = self._gridFrame:Find("submarine_" .. iter_4_0)
	end

	SetActive(self._item, false)
	SetActive(self._heroInfo, false)
	SetActive(self._starTplsa, false)
	setText(self._gearScore:Find("vanguard/line/Image/Text1"), i18n("pre_combat_vanguard"))
	setText(self._gearScore:Find("main/line/Image/Text1"), i18n("pre_combat_main"))
	setText(self._gearScore:Find("submarine/line/Image/text1"), i18n("pre_combat_submarine"))
	setText(self._costContainer:Find("title"), i18n("pre_combat_consume"))
	setText(self._infomation:Find("target/title/GameObject"), i18n("pre_combat_targets"))
	setText(self._infomation:Find("atlasloot/atlasloot/title/GameObject"), i18n("pre_combat_atlasloot"))
	setText(self._startBtn:Find("text"), i18n("pre_combat_start"))
	setText(self._startBtn:Find("text_en"), i18n("pre_combat_start_en"))
	setText(self.btnRegular:Find("fleet/CnFleet"), Fleet.DEFAULT_NAME[1])
	setText(self.btnSub:Find("fleet/CnFleet"), Fleet.DEFAULT_NAME[1])
	setAnchoredPosition(self._middle, {
		x = -840
	})
	setAnchoredPosition(self._right, {
		x = 470
	})
	self:SetStageID(self.contextData.stageId)

	self.commanderFormationPanel = LimitChallengeCommanderFormationPage.New(self._tf, self.event, self.contextData)

	self.commanderFormationPanel:RegisterView(self)

	return
end

function LimitChallengePreCombatLayer:Register()
	self._formationLogic:AddLoadComplete(function()
		return
	end)
	self._formationLogic:AddHeroInfoModify(function(arg_7_0, arg_7_1)
		setAnchoredPosition(arg_7_0, {
			x = 0,
			y = 0
		})
		SetActive(arg_7_0, true)

		arg_7_0.name = "info"

		local var_7_0 = findTF(arg_7_0, "info")
		local var_7_1 = findTF(var_7_0, "stars")
		local var_7_2 = arg_7_1.energy <= Ship.ENERGY_MID
		local var_7_3 = findTF(var_7_0, "energy")

		if arg_7_1.energy <= Ship.ENERGY_MID then
			local var_7_4, var_7_5 = arg_7_1:getEnergyPrint()
			local var_7_6 = GetSpriteFromAtlas("energy", var_7_4)

			if not var_7_6 then
				warning("找不到疲劳")
			end

			setImageSprite(var_7_3, var_7_6)
		end

		setActive(var_7_3, var_7_2 and self.contextData.system ~= SYSTEM_DUEL)

		for iter_7_0 = 1, arg_7_1:getStar() do
			cloneTplTo(self._starTplsa, var_7_1)
		end

		local var_7_7 = GetSpriteFromAtlas("shiptype", shipType2print(arg_7_1:getShipType()))

		if not var_7_7 then
			warning("找不到船形, shipConfigId: " .. arg_7_1.configId)
		end

		setImageSprite(findTF(var_7_0, "type"), var_7_7, true)
		setText(findTF(var_7_0, "frame/lv_contain/lv"), arg_7_1.level)
		setActive(var_7_0:Find("expbuff"), false)

		return
	end)
	self._formationLogic:AddLongPress(function(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
		self:emit(LimitChallengePreCombatMediator.OPEN_SHIP_INFO, arg_8_1.id, arg_8_2)

		return
	end)
	self._formationLogic:AddBeginDrag(function(arg_9_0)
		SetActive(findTF(arg_9_0, "info"), false)

		return
	end)
	self._formationLogic:AddEndDrag(function(arg_10_0)
		SetActive(findTF(arg_10_0, "info"), true)

		return
	end)
	self._formationLogic:AddClick(function(arg_11_0, arg_11_1, arg_11_2)
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_CLICK)
		self:emit(LimitChallengePreCombatMediator.CHANGE_FLEET_SHIP, arg_11_0, arg_11_2, arg_11_1)

		return
	end)
	self._formationLogic:AddShiftOnly(function(arg_12_0)
		self:emit(LimitChallengePreCombatMediator.CHANGE_FLEET_SHIPS_ORDER, arg_12_0)

		return
	end)
	self._formationLogic:AddRemoveShip(function(arg_13_0, arg_13_1)
		self:emit(LimitChallengePreCombatMediator.REMOVE_SHIP, arg_13_0, arg_13_1)

		return
	end)
	self._formationLogic:AddCheckRemove(function(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
		if not arg_14_3:canRemove(arg_14_2) then
			local var_14_0, var_14_1 = arg_14_3:getShipPos(arg_14_2)

			pg.TipsMgr.GetInstance():ShowTips(i18n("ship_formationUI_removeError_onlyShip", arg_14_2:getConfigTable().name, arg_14_3.name, Fleet.C_TEAM_NAME[var_14_1]))
			arg_14_0()
		else
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				hideNo = false,
				zIndex = -100,
				content = i18n("battle_preCombatLayer_quest_leaveFleet", arg_14_2:getConfigTable().name),
				onYes = arg_14_1,
				onNo = arg_14_0
			})
		end

		return
	end)
	self._formationLogic:AddSwitchToDisplayMode(function()
		return
	end)
	self._formationLogic:AddSwitchToShiftMode(function()
		self:SetFleetStepper()

		return
	end)
	self._formationLogic:AddSwitchToPreviewMode(function()
		self:SetFleetStepper()

		return
	end)
	self._formationLogic:AddGridTipClick(function(arg_18_0, arg_18_1)
		self:emit(LimitChallengePreCombatMediator.CHANGE_FLEET_SHIP, nil, self._currentFleetVO, arg_18_0)

		return
	end)

	return
end

function LimitChallengePreCombatLayer:SetPlayerInfo(arg_19_1)
	return
end

function LimitChallengePreCombatLayer:SetSubFlag(arg_20_1)
	self._subUseable = arg_20_1 or false

	self:UpdateSubToggle()

	return
end

function LimitChallengePreCombatLayer:SetShips(arg_21_1)
	self._shipVOs = arg_21_1

	self._formationLogic:SetShipVOs(self._shipVOs)

	return
end

function LimitChallengePreCombatLayer:SetStageID(arg_22_1)
	removeAllChildren(self._spoilsContainer)

	self._stageID = arg_22_1

	local var_22_0 = Clone(pg.expedition_data_template[arg_22_1].award_display)
	local var_22_1 = checkExist(pg.expedition_activity_template[arg_22_1], {
		"pt_drop_display"
	})

	if var_22_1 and type(var_22_1) == "table" then
		local var_22_2 = getProxy(ActivityProxy)

		for iter_22_0 = #var_22_1, 1, -1 do
			local var_22_3 = var_22_2:getActivityById(var_22_1[iter_22_0][1])

			if var_22_3 and not var_22_3:isEnd() then
				table.insert(var_22_0, 1, {
					2,
					id2ItemId(var_22_1[iter_22_0][2])
				})
			end
		end
	end

	for iter_22_1, iter_22_2 in ipairs(var_22_0) do
		local var_22_4 = cloneTplTo(self._item, self._spoilsContainer)
		local var_22_5 = {
			id = iter_22_2[2],
			type = iter_22_2[1]
		}

		updateDrop(var_22_4, var_22_5)
		onButton(self, var_22_4, function()
			local var_23_0 = Item.getConfigData(iter_22_2[2])

			if var_23_0 and var_0_2[var_23_0.type] then
				local var_23_1 = {}

				for iter_23_0, iter_23_1 in ipairs(var_23_0.display_icon) do
					var_23_1[#var_23_1 + 1] = {
						hideName = true,
						type = iter_23_1[1],
						id = iter_23_1[2]
					}
				end

				self:emit(LimitChallengePreCombatLayer.ON_DROP_LIST, {
					item2Row = true,
					itemList = var_23_1,
					content = var_23_0.display
				})
			else
				self:emit(LimitChallengePreCombatLayer.ON_DROP, var_22_5)
			end

			return
		end, SFX_PANEL)
	end

	local function var_22_6(arg_24_0, arg_24_1)
		if type(arg_24_0) == "table" then
			setActive(arg_24_1, true)
			setWidgetText(arg_24_1, (i18n(PreCombatLayer.ObjectiveList[arg_24_0[1]], arg_24_0[2])))
		else
			setActive(arg_24_1, false)
		end

		return
	end

	local var_22_7 = {
		findTF(self._goals, "goal_tpl"),
		findTF(self._goals, "goal_sink"),
		findTF(self._goals, "goal_time")
	}
	local var_22_8 = 1

	for iter_22_3, iter_22_4 in ipairs({
		pg.expedition_data_template[arg_22_1].objective_1,
		pg.expedition_data_template[arg_22_1].objective_2,
		pg.expedition_data_template[arg_22_1].objective_3
	}) do
		if type(iter_22_4) ~= "string" then
			var_22_6(iter_22_4, var_22_7[var_22_8])

			var_22_8 = var_22_8 + 1
		end
	end

	for iter_22_5 = var_22_8, #var_22_7 do
		var_22_6("", var_22_7[iter_22_5])
	end

	return
end

function LimitChallengePreCombatLayer:SetFleets(arg_25_1)
	self._fleetVOs = {}
	self._legalFleetIdList = {}

	_.each(arg_25_1, function(arg_26_0)
		self._fleetVOs[arg_26_0.id] = arg_26_0

		table.insert(self._legalFleetIdList, arg_26_0.id)

		return
	end)

	return
end

function LimitChallengePreCombatLayer:SetCurrentFleet(arg_27_1)
	self._currentFleetVO = self._fleetVOs[arg_27_1]

	self._formationLogic:SetFleetVO(self._currentFleetVO)

	for iter_27_0, iter_27_1 in ipairs(self._legalFleetIdList) do
		if self._currentFleetVO.id == iter_27_1 then
			self._curFleetIndex = iter_27_0

			break
		end
	end

	self:updateCommanderFormation()

	return
end

function LimitChallengePreCombatLayer:SetOpenCommander(arg_28_1)
	self.isOpenCommander = arg_28_1

	return
end

function LimitChallengePreCombatLayer:CheckLegalFleet()
	assert(false)

	return
end

function LimitChallengePreCombatLayer:UpdateFleetView(arg_30_1)
	self:displayFleetInfo()
	self:updateFleetBg()
	self._formationLogic:UpdateGridVisibility()
	self._formationLogic:ResetGrid(TeamType.Vanguard)
	self._formationLogic:ResetGrid(TeamType.Main)
	self._formationLogic:ResetGrid(TeamType.Submarine)
	self:resetFormationComponent()

	if arg_30_1 then
		self._formationLogic:LoadAllCharacter()
	else
		self._formationLogic:SetAllCharacterPos()
	end

	local var_30_0 = self._currentFleetVO:getFleetType()

	setActive(self.btnRegular:Find("on"), var_30_0 == FleetType.Normal)
	setActive(self.btnRegular:Find("off"), var_30_0 ~= FleetType.Normal)
	setActive(self.btnSub:Find("on"), var_30_0 == FleetType.Submarine)
	setActive(self.btnSub:Find("off"), var_30_0 ~= FleetType.Submarine)

	return
end

function LimitChallengePreCombatLayer:updateFleetBg()
	local var_31_0 = self._currentFleetVO:getFleetType()

	setActive(self._bgFleet, var_31_0 == FleetType.Normal)
	setActive(self._bgSub, var_31_0 == FleetType.Submarine)

	return
end

function LimitChallengePreCombatLayer:resetFormationComponent()
	SetActive(self._gridTFs.main[1]:Find("flag"), #self._currentFleetVO:getTeamByName(TeamType.Main) ~= 0)
	SetActive(self._gridTFs.submarine[1]:Find("flag"), #self._currentFleetVO:getTeamByName(TeamType.Submarine) ~= 0)

	return
end

function LimitChallengePreCombatLayer:uiStartAnimating()
	shiftPanel(self._middle, 0, nil, 0.3, 0, true, true)
	shiftPanel(self._right, 0, nil, 0.3, 0, true, true)

	return
end

function LimitChallengePreCombatLayer:uiExitAnimating()
	shiftPanel(self._middle, -840, nil, nil, nil, true, true)
	shiftPanel(self._right, 470, nil, nil, nil, true, true)

	return
end

function LimitChallengePreCombatLayer:didEnter()
	GetOrAddComponent(self._tf, typeof(CanvasGroup)).interactable = true

	onButton(self, self._backBtn, function()
		self:emit(LimitChallengePreCombatMediator.ON_UPDATE_CUSTOM_FLEET)

		GetOrAddComponent(self._tf, typeof(CanvasGroup)).interactable = false

		self:uiExitAnimating()
		LeanTween.delayedCall(0.3, System.Action(function()
			self:closeView()

			return
		end))

		return
	end, SFX_CANCEL)
	onButton(self, self._option, function()
		self:emit(LimitChallengePreCombatMediator.ON_UPDATE_CUSTOM_FLEET)
		self:quickExitFunc()

		return
	end, SFX_PANEL)
	onButton(self, self._startBtn, function()
		self:emit(LimitChallengePreCombatMediator.ON_START)

		return
	end, SFX_UI_WEIGHANCHOR)
	onButton(self, self._nextPage, function()
		self:emit(LimitChallengePreCombatMediator.ON_CHANGE_FLEET, self._legalFleetIdList[self._curFleetIndex + 1])

		return
	end, SFX_PANEL)
	onButton(self, self._prevPage, function()
		self:emit(LimitChallengePreCombatMediator.ON_CHANGE_FLEET, self._legalFleetIdList[self._curFleetIndex - 1])

		return
	end, SFX_PANEL)
	self:UpdateFleetView(true)
	setActive(self._autoToggle, true)
	onToggle(self, self._autoToggle, function(arg_42_0)
		self:emit(LimitChallengePreCombatMediator.ON_AUTO, {
			isOn = not arg_42_0,
			toggle = self._autoToggle
		})

		self.autoFlag = arg_42_0

		self:UpdateSubToggle()

		return
	end, SFX_PANEL, SFX_PANEL)
	onToggle(self, self._autoSubToggle, function(arg_43_0)
		self:emit(LimitChallengePreCombatMediator.ON_SUB_AUTO, {
			isOn = not arg_43_0,
			toggle = self._autoSubToggle
		})

		return
	end, SFX_PANEL, SFX_PANEL)
	onButton(self, self.btnRegular, function()
		self:emit(LimitChallengePreCombatMediator.ON_CHANGE_FLEET, FleetProxy.CHALLENGE_FLEET_ID)

		return
	end, SFX_PANEL)
	onButton(self, self.btnSub, function()
		self:emit(LimitChallengePreCombatMediator.ON_CHANGE_FLEET, FleetProxy.CHALLENGE_SUB_FLEET_ID)

		return
	end, SFX_PANEL)

	if self.isOpenCommander then
		self.commanderFormationPanel:ActionInvoke("Show")
	end

	triggerToggle(self._autoToggle, ys.Battle.BattleState.IsAutoBotActive())
	onNextTick(function()
		self:uiStartAnimating()

		return
	end)
	self:SetFleetStepper()
	self:OverlayPanel(self._tf)

	return
end

function LimitChallengePreCombatLayer:UpdateSubToggle()
	if self.autoFlag and self._subUseable == true then
		setActive(self._autoSubToggle, true)
		triggerToggle(self._autoSubToggle, ys.Battle.BattleState.IsAutoSubActive())
	else
		setActive(self._autoSubToggle, false)
	end

	return
end

function LimitChallengePreCombatLayer:displayFleetInfo()
	local var_48_0 = self._currentFleetVO:getFleetType()

	setActive(self._vanguardGS.parent, var_48_0 == FleetType.Normal)
	setActive(self._mainGS.parent, var_48_0 == FleetType.Normal)

	local var_48_1 = math.floor(self._currentFleetVO:GetGearScoreSum(TeamType.Vanguard))
	local var_48_2 = math.floor(self._currentFleetVO:GetGearScoreSum(TeamType.Main))

	setActive(self._subGS.parent, var_48_0 == FleetType.Submarine)

	local var_48_3 = math.floor(self._currentFleetVO:GetGearScoreSum(TeamType.Submarine))
	local var_48_4 = self.contextData.system

	setActive(self._costContainer, self.contextData.system ~= SYSTEM_DUEL)
	FormationUI.tweenNumText(self._vanguardGS, var_48_1)
	FormationUI.tweenNumText(self._mainGS, var_48_2)
	FormationUI.tweenNumText(self._subGS, var_48_3)
	setText(self._fleetNameText, self._currentFleetVO:GetName())
	setText(self._fleetNumText, self._curFleetIndex)

	local var_48_5 = self.contextData.fleets[#self.contextData.fleets]
	local var_48_6 = _.slice(self.contextData.fleets, 1, #self.contextData.fleets - 1)

	FormationUI.tweenNumText(self._costText, ((function()
		local var_49_0 = pg.battle_cost_template[var_48_4].oil_cost > 0

		local function var_49_1(arg_50_0, arg_50_1)
			local var_50_0 = 0

			if var_49_0 then
				var_50_0 = arg_50_0:GetCostSum().oil

				if arg_50_1 > 0 then
					var_50_0 = math.min(arg_50_1, var_50_0)
				end
			end

			return var_50_0
		end

		return 0 + var_49_1(var_48_6[1], 0) + var_49_1(var_48_5, 0)
	end)()))

	return
end

function LimitChallengePreCombatLayer:SetFleetStepper()
	SetActive(self._nextPage, self._curFleetIndex < #self._legalFleetIdList)
	SetActive(self._prevPage, self._curFleetIndex > 1)

	return
end

function LimitChallengePreCombatLayer:updateCommanderFormation()
	if self.isOpenCommander then
		self.commanderFormationPanel:Load()
		self.commanderFormationPanel:ActionInvoke("Update", self._currentFleetVO)
	end

	return
end

function LimitChallengePreCombatLayer:onBackPressed()
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)
	triggerButton(self._backBtn)

	return
end

function LimitChallengePreCombatLayer:willExit()
	self.commanderFormationPanel:Destroy()
	self._formationLogic:Destroy()

	self._formationLogic = nil

	self:UnOverlayPanel(self._tf)

	return
end

return LimitChallengePreCombatLayer

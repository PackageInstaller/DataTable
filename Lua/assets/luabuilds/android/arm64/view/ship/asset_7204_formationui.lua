local FormationUI = class("FormationUI", import("..base.BaseUI"))

FormationUI.RADIUS = 60
FormationUI.LONGPRESS_Y = 30
FormationUI.INTERVAL = math.pi / 2 / 6
FormationUI.MAX_FLEET_NUM = 6
FormationUI.MAX_SHIPP_NUM = 5
FormationUI.TOGGLE_DETAIL = "_detailToggle"
FormationUI.TOGGLE_FORMATION = "_formationToggle"
FormationUI.BUFF_TYEP = {
	blue = "blue",
	pink = "pink",
	cyan = "cyan"
}
FormationUI.TeamNum = {
	"FIRST",
	"SECOND",
	"THIRD",
	"FOURTH",
	"FIFTH",
	"SIXTH"
}

function FormationUI:getUIName()
	return "FormationUI"
end

function FormationUI:preloadUIList()
	return {
		self:getUIName(),
		"CommanderFormationUI"
	}
end

function FormationUI:setPlayer(arg_3_1)
	self.player = arg_3_1

	return
end

function FormationUI:setCommanderPrefabFleet(arg_4_1)
	self.commanderPrefabFleets = arg_4_1

	return
end

function FormationUI:init()
	self.eventTriggers = {}
	self.backBtn = self._blurLayer:Find("top/back_btn")
	self._bgFleet = self._adapt:Find("bg_fleet")
	self._bgSub = self._adapt:Find("bg_sub")
	self._bottomPanel = self._blurLayer:Find("bottom")
	self._detailToggle = self._bottomPanel:Find("toggle_list/detail_toggle")
	self._formationToggle = self._bottomPanel:Find("toggle_list/formation_toggle")
	self._nextPage = self._adapt:Find("nextPage")
	self._prevPage = self._adapt:Find("prevPage")
	self._starTpl = self._tf:Find("star_tpl")
	self._heroInfoTpl = self._tf:Find("heroInfo")
	self.topPanel = self._blurLayer:Find("top")
	self._gridTFs = {
		[TeamType.Vanguard] = {},
		[TeamType.Main] = {},
		[TeamType.Submarine] = {}
	}
	self._gridFrame = self._adapt:Find("GridFrame")

	for iter_5_0 = 1, 3 do
		self._gridTFs[TeamType.Main][iter_5_0] = self._gridFrame:Find("main_" .. iter_5_0)
		self._gridTFs[TeamType.Vanguard][iter_5_0] = self._gridFrame:Find("vanguard_" .. iter_5_0)
		self._gridTFs[TeamType.Submarine][iter_5_0] = self._gridFrame:Find("submarine_" .. iter_5_0)
	end

	self._heroContainer = self._adapt:Find("HeroContainer")
	self._formationLogic = BaseFormation.New(self._tf, self._heroContainer, self._heroInfoTpl, self._gridTFs)
	self._fleetInfo = self._blurLayer:Find("fleet_info")
	self._fleetNumText = self._fleetInfo:Find("fleet_number")
	self._fleetNameText = self._fleetInfo:Find("fleet_name/Text")
	self._fleetNameEditBtn = self._fleetInfo:Find("edit_btn")
	self._renamePanel = self._tf:Find("changeName_panel")
	self._renameConfirmBtn = self._renamePanel:Find("frame/queren")
	self._renameCancelBtn = self._renamePanel:Find("frame/cancel")

	setLocalPosition(self._renamePanel, {
		z = -45
	})

	self._propertyFrame = self._blurLayer:Find("property_frame")
	self._cannonPower = self._propertyFrame:Find("cannon/Text")
	self._torpedoPower = self._propertyFrame:Find("torpedo/Text")
	self._AAPower = self._propertyFrame:Find("antiaircraft/Text")
	self._airPower = self._propertyFrame:Find("air/Text")
	self._airDominance = self._propertyFrame:Find("ac/Text")
	self._cost = self._propertyFrame:Find("cost/Text")
	self._mainGS = self._adapt:Find("gear_score/main")
	self._vanguardGS = self._adapt:Find("gear_score/vanguard")
	self._subGS = self._adapt:Find("gear_score/submarine")
	self._arrUpVan = self._vanguardGS:Find("up")
	self._arrDownVan = self._vanguardGS:Find("down")
	self._arrUpMain = self._mainGS:Find("up")
	self._arrDownMain = self._mainGS:Find("down")
	self._arrUpSub = self._subGS:Find("up")
	self._arrDownSub = self._subGS:Find("down")
	self._attrFrame = self._blurLayer:Find("attr_frame")
	self._cardTpl = self._tf:Find("RectShipCardTpl")
	self._cards = {}
	self._cards[TeamType.Main] = {}
	self._cards[TeamType.Vanguard] = {}
	self._cards[TeamType.Submarine] = {}

	setActive(self._attrFrame, false)
	setActive(self._cardTpl, false)

	self.btnRegular = self._bottomPanel:Find("fleet_select/regular")
	self._regularEnFllet = self.btnRegular:Find("fleet/enFleet")
	self._regularNum = self.btnRegular:Find("fleet/num")
	self._regualrCnFleet = self.btnRegular:Find("fleet/CnFleet")
	self.btnSub = self._bottomPanel:Find("fleet_select/sub")
	self._subEnFllet = self.btnSub:Find("fleet/enFleet")
	self._subNum = self.btnSub:Find("fleet/num")
	self._subCnFleet = self.btnSub:Find("fleet/CnFleet")
	self.fleetToggleMask = self._tf:Find("blur_panel/list_mask")
	self.fleetToggleList = self.fleetToggleMask:Find("list")
	self.fleetToggles = {}

	for iter_5_1 = 1, FormationUI.MAX_FLEET_NUM do
		self.fleetToggles[iter_5_1] = self.fleetToggleList:Find("item" .. iter_5_1)
	end

	self._vanGSTxt = self._vanguardGS:Find("Text"):GetComponent("Text")
	self._mainGSTxt = self._mainGS:Find("Text"):GetComponent("Text")
	self._subGSTxt = self._subGS:Find("Text"):GetComponent("Text")
	self.prevMainGS = self.contextData.mainGS
	self.prevVanGS = self.contextData.vanGS
	self.prevSubGS = self.contextData.subGS
	self.mainGSInited = not not self.contextData.mainGS
	self.VanGSInited = not not self.contextData.vanGS
	self.SubGSInited = not not self.contextData.subGS
	self._vanGSTxt.text = self.prevVanGS or 0
	self._mainGSTxt.text = self.prevMainGS or 0
	self._subGSTxt.text = self.prevSubGS or 0
	self.commanderFormationPanel = CommanderFormationPage.New(self._tf, self.event, self.contextData)
	self.index = {
		[FleetType.Normal] = 1,
		[FleetType.Submarine] = 1
	}

	setText(self._adapt:Find("gear_score/main/line/Image/text1"), i18n("pre_combat_main"))
	setText(self._adapt:Find("gear_score/vanguard/line/Image/text1"), i18n("pre_combat_vanguard"))
	setText(self._adapt:Find("gear_score/submarine/line/Image/text1"), i18n("pre_combat_submarine"))

	return
end

function FormationUI:setShips(arg_6_1)
	self.shipVOs = arg_6_1

	self._formationLogic:SetShipVOs(self.shipVOs)

	return
end

function FormationUI:SetFleets(arg_7_1)
	self._fleetVOs = _(arg_7_1):chain():values():filter(function(arg_8_0)
		return arg_8_0:isRegularFleet()
	end):sort(function(arg_9_0, arg_9_1)
		return arg_9_0.id < arg_9_1.id
	end):value()

	if self._currentFleetVO then
		self._currentFleetVO = self:getFleetById(self._currentFleetVO.id)

		self._formationLogic:SetFleetVO(self._currentFleetVO)
	end

	return
end

function FormationUI:getFleetById(arg_10_1)
	return _.detect(self._fleetVOs, function(arg_11_0)
		return arg_11_0.id == arg_10_1
	end)
end

function FormationUI:UpdateFleetView(arg_12_1)
	self:displayFleetInfo()
	self:updateFleetBg()
	self._formationLogic:UpdateGridVisibility()
	self._formationLogic:ResetGrid(TeamType.Vanguard)
	self._formationLogic:ResetGrid(TeamType.Main)
	self._formationLogic:ResetGrid(TeamType.Submarine)
	self:resetFormationComponent()
	self:updateAttrFrame()
	self:updateFleetButton()

	if arg_12_1 then
		self._formationLogic:LoadAllCharacter()
	else
		self._formationLogic:SetAllCharacterPos()
	end

	return
end

function FormationUI:updateFleetBg()
	local var_13_0 = self._currentFleetVO:getFleetType()

	setActive(self._bgFleet, var_13_0 == FleetType.Normal)
	setActive(self._bgSub, var_13_0 == FleetType.Submarine)

	return
end

function FormationUI:updateFleetButton()
	local var_14_1 = self._currentFleetVO:getFleetType()

	self.index[var_14_1] = self._currentFleetVO:getIndex()

	setText(self._regularEnFllet, FormationUI.TeamNum[self.index[FleetType.Normal]] .. " FLEET")
	setText(self._regualrCnFleet, Fleet.DEFAULT_NAME[self.index[FleetType.Normal]])
	setText(self._regularNum, self.index[FleetType.Normal])
	setText(self._subEnFllet, FormationUI.TeamNum[self.index[FleetType.Submarine]] .. " FLEET")
	setText(self._subCnFleet, Fleet.DEFAULT_NAME[self.index[FleetType.Submarine]])
	setText(self._subNum, self.index[FleetType.Submarine])
	setActive(self.btnRegular:Find("on"), var_14_1 == FleetType.Normal)
	setActive(self.btnRegular:Find("off"), var_14_1 ~= FleetType.Normal)
	setActive(self.btnSub:Find("on"), var_14_1 == FleetType.Submarine)
	setActive(self.btnSub:Find("off"), var_14_1 ~= FleetType.Submarine)

	return
end

function FormationUI:SetFleetNameLabel()
	setText(self._fleetNameText, self.defaultFleetName(self._currentFleetVO))

	return
end

function FormationUI:ForceDropChar()
	self._formationLogic:ForceDropChar()

	if self._currentDragDelegate then
		self._forceDropCharacter = true

		LuaHelper.triggerEndDrag(self._currentDragDelegate)
	end

	return
end

function FormationUI:quickExitFunc()
	self:ForceDropChar()
	self:emit(FormationMediator.COMMIT_FLEET, function()
		GetOrAddComponent(self._tf, typeof(CanvasGroup)).interactable = false

		self:emit(FormationUI.ON_HOME)

		return
	end)

	return
end

function FormationUI:didEnter()
	local var_19_0 = pg.SystemOpenMgr.GetInstance():isOpenSystem(self.player.level, "CommanderCatMediator")

	var_19_0 = var_19_0 and not LOCK_COMMANDER
	self.isOpenCommander = var_19_0

	local var_19_1 = getProxy(ActivityProxy):getBuffShipList()

	self._formationLogic:AddHeroInfoModify(function(arg_20_0, arg_20_1)
		local var_20_0 = arg_20_1:getConfigTable()
		local var_20_2 = findTF(arg_20_0, "info")
		local var_20_3 = findTF(var_20_2, "stars")
		local var_20_4 = findTF(var_20_2, "energy")

		for iter_20_0 = 1, arg_20_1:getStar() do
			cloneTplTo(self._starTpl, var_20_3)
		end

		local var_20_5 = GetSpriteFromAtlas("shiptype", shipType2print(arg_20_1:getShipType()))

		if not var_20_5 then
			warning("找不到船形, shipConfigId: " .. arg_20_1.configId)
		end

		setImageSprite(findTF(var_20_2, "type"), var_20_5, true)
		setText(findTF(var_20_2, "frame/lv_contain/lv"), arg_20_1.level)

		if arg_20_1.energy <= Ship.ENERGY_MID then
			setImageSprite(var_20_4, (GetSpriteFromAtlas("energy", arg_20_1:getEnergyPrint())))
			setActive(var_20_4, true)
		end

		local var_20_6 = var_19_1[arg_20_1:getGroupId()]
		local var_20_7 = var_20_2:Find("expbuff")

		setActive(var_20_7, var_20_6 ~= nil)

		if var_20_6 then
			local var_20_8 = tostring(var_20_6 / 100)

			if var_20_6 % 100 > 0 then
				var_20_8 = var_20_8 .. "." .. tostring(var_20_6 % 100)
			end

			setText(var_20_7:Find("text"), string.format("EXP +%s%%", var_20_8))
		end

		return
	end)
	self._formationLogic:AddLongPress(function(arg_21_0, arg_21_1, arg_21_2)
		self:emit(FormationMediator.OPEN_SHIP_INFO, arg_21_1.id, self._currentFleetVO, FormationUI.TOGGLE_FORMATION)
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_PANEL)

		return
	end)
	self._formationLogic:AddClick(function(arg_22_0, arg_22_1)
		self:emit(FormationMediator.CHANGE_FLEET_SHIP, arg_22_0, self._currentFleetVO, FormationUI.TOGGLE_FORMATION, arg_22_1)
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_PANEL)

		return
	end)
	self._formationLogic:AddBeginDrag(function(arg_23_0)
		SetActive(findTF(arg_23_0, "info"), false)

		return
	end)
	self._formationLogic:AddEndDrag(function(arg_24_0)
		SetActive(findTF(arg_24_0, "info"), true)

		return
	end)
	self._formationLogic:AddShiftOnly(function(arg_25_0)
		self:emit(FormationMediator.CHANGE_FLEET_SHIPS_ORDER, arg_25_0)

		return
	end)
	self._formationLogic:AddRemoveShip(function(arg_26_0, arg_26_1)
		self:emit(FormationMediator.REMOVE_SHIP, arg_26_0, arg_26_1)

		return
	end)
	self._formationLogic:AddCheckRemove(function(arg_27_0, arg_27_1, arg_27_2, arg_27_3, arg_27_4)
		if not arg_27_3:canRemove(arg_27_2) then
			local var_27_0, var_27_1 = arg_27_3:getShipPos(arg_27_2)

			pg.TipsMgr.GetInstance():ShowTips(i18n("ship_formationUI_removeError_onlyShip", arg_27_2:getConfigTable().name, arg_27_3.name, Fleet.C_TEAM_NAME[var_27_1]))
			arg_27_0()
		else
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				hideNo = false,
				zIndex = -30,
				content = i18n("ship_formationUI_quest_remove", arg_27_2:getName()),
				onYes = arg_27_1,
				onNo = arg_27_0
			})
		end

		return
	end)
	self._formationLogic:AddGridTipClick(function(arg_28_0, arg_28_1)
		self:emit(FormationMediator.CHANGE_FLEET_SHIP, nil, arg_28_1, FormationUI.TOGGLE_FORMATION, arg_28_0)

		return
	end)
	onButton(self, self.backBtn, function()
		self:ForceDropChar()

		if self._attrFrame.gameObject.activeSelf then
			triggerToggle(self._formationToggle, true)
		else
			self:emit(FormationMediator.COMMIT_FLEET, function()
				GetOrAddComponent(self._tf, typeof(CanvasGroup)).interactable = false

				self:emit(FormationUI.ON_BACK)

				return
			end)
		end

		return
	end, SOUND_BACK)

	self._stamp = self._adapt:Find("stamp")

	local var_19_2 = setActive
	local var_19_3 = self._stamp
	local var_19_4 = not LOCK_CLICK_MINGSHI and (BATTLE_DEBUG or getProxy(TaskProxy):mingshiTouchFlagEnabled()) or false

	var_19_2(var_19_3, (false or nil) and true)
	onButton(self, self._stamp, function()
		if BATTLE_DEBUG then
			print(self._currentFleetVO:genRobotDataString())
		end

		getProxy(TaskProxy):dealMingshiTouchFlag(6)

		return
	end, SFX_CONFIRM)
	onButton(self, self._fleetNameEditBtn, function()
		self:DisplayRenamePanel(true)

		return
	end, SFX_PANEL)
	onButton(self, self._renameConfirmBtn, function()
		self:emit(FormationMediator.CHANGE_FLEET_NAME, self._currentFleetVO.id, (getInputText(findTF(self._renamePanel, "frame/name_field"))))

		return
	end, SFX_CONFIRM)
	onButton(self, self._renameCancelBtn, function()
		self:DisplayRenamePanel(false)

		return
	end, SFX_CANCEL)
	onToggle(self, self._detailToggle, function(arg_35_0)
		self:ForceDropChar()

		if arg_35_0 then
			self:displayAttrFrame()
		end

		return
	end, SFX_PANEL)
	onToggle(self, self._formationToggle, function(arg_36_0)
		self:ForceDropChar()

		if arg_36_0 then
			self:hideAttrFrame()
		end

		return
	end, SFX_PANEL)
	onButton(self, self._attrFrame, function()
		triggerToggle(self._formationToggle, true)

		return
	end, SFX_PANEL)
	onButton(self, self.fleetToggleMask, function()
		setActive(self.fleetToggleMask, false)
		self:tweenTabArrow(true)

		return
	end, SFX_CANCEL)
	onButton(self, self.btnRegular, function()
		self:updateToggleList(_.filter(self._fleetVOs, function(arg_40_0)
			return arg_40_0:getFleetType() == FleetType.Normal
		end))

		local var_39_0 = self._currentFleetVO:getFleetType() == FleetType.Normal

		triggerToggle(self.fleetToggles[self.index[FleetType.Normal]], true)

		if var_39_0 then
			setActive(self.fleetToggleMask, true)
			self:tweenTabArrow(false)
			setAnchoredPosition(self.fleetToggleList, Vector3.New(209, 129))
		end

		return
	end, SFX_PANEL)
	onButton(self, self.btnSub, function()
		self:updateToggleList(_.filter(self._fleetVOs, function(arg_42_0)
			return arg_42_0:getFleetType() == FleetType.Submarine
		end))

		local var_41_0 = self._currentFleetVO:getFleetType() == FleetType.Submarine

		triggerToggle(self.fleetToggles[self.index[FleetType.Submarine]], true)

		if var_41_0 then
			setActive(self.fleetToggleMask, true)
			self:tweenTabArrow(false)
			setAnchoredPosition(self.fleetToggleList, Vector3.New(755, 129))
		end

		return
	end, SFX_PANEL)
	onButton(self, self._prevPage, function()
		self:ForceDropChar()
		self:emit(FormationMediator.ON_CHANGE_FLEET, (self:selectFleetByStep(-1)))

		return
	end, SFX_PANEL)
	onButton(self, self._nextPage, function()
		self:ForceDropChar()
		self:emit(FormationMediator.ON_CHANGE_FLEET, (self:selectFleetByStep(1)))

		return
	end, SFX_PANEL)
	self:SetCurrentFleetID((defaultValue(self.contextData.number, 1)))

	if self.isOpenCommander then
		self.commanderFormationPanel:ActionInvoke("Show")
	end

	self:UpdateFleetView(true)
	triggerToggle(self[self.contextData.toggle or FormationUI.TOGGLE_FORMATION], true)
	self:tweenTabArrow(true)
	onButton(self, self._vanguardGS:Find("SonarTip"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.fleet_antisub_range_tip.tip
		})

		return
	end, SFX_PANEL)

	return
end

function FormationUI:SetCurrentFleetID(arg_46_1)
	self._currentFleetVO = self:getFleetById(arg_46_1)

	self._formationLogic:SetFleetVO(self._currentFleetVO)
	self:updateCommanderFormation()

	return
end

function FormationUI:updateCommanderFormation()
	if self.isOpenCommander then
		self.commanderFormationPanel:Load()
		self.commanderFormationPanel:ActionInvoke("Update", self._currentFleetVO, self.commanderPrefabFleets)
	end

	return
end

function FormationUI:selectFleetByStep(arg_48_1)
	local var_48_0 = table.indexof(self._fleetVOs, self._currentFleetVO)

	while true do
		var_48_0 = var_48_0 + arg_48_1

		if var_48_0 < 1 or var_48_0 > #self._fleetVOs then
			break
		end

		if self._fleetVOs[var_48_0]:isUnlock() then
			return self._fleetVOs[var_48_0].id
		end
	end

	return
end

function FormationUI:updateToggleList(arg_49_1)
	local var_49_0 = self.fleetToggleList:GetComponent(typeof(ToggleGroup))

	var_49_0.allowSwitchOff = true

	local var_49_1 = self._currentFleetVO.id

	for iter_49_0 = 1, #self.fleetToggles do
		local var_49_2 = self.fleetToggles[iter_49_0]
		local var_49_3 = arg_49_1[iter_49_0]

		setActive(self.fleetToggles[iter_49_0], arg_49_1[iter_49_0])

		if var_49_3 then
			local var_49_4 = var_49_2:GetComponent(typeof(Toggle))
			local var_49_5 = var_49_2:Find("lock")
			local var_49_6, var_49_7 = var_49_3:isUnlock()

			setToggleEnabled(var_49_2, var_49_6)
			setActive(var_49_5, not var_49_6)
			setActive(var_49_2:Find("on"), var_49_6 and var_49_1 == var_49_3.id)
			setActive(var_49_2:Find("off"), var_49_6 and var_49_1 ~= var_49_3.id)

			if var_49_6 then
				var_49_4.isOn = var_49_3.id == var_49_1

				onToggle(self, var_49_2, function(arg_50_0)
					if arg_50_0 then
						setActive(self.fleetToggleMask, false)
						self:tweenTabArrow(true)

						if var_49_3.id ~= var_49_1 then
							self:ForceDropChar()
							self:emit(FormationMediator.ON_CHANGE_FLEET, var_49_3.id)
						end
					end

					return
				end, SFX_UI_TAG)
			else
				onButton(self, var_49_5, function()
					pg.TipsMgr.GetInstance():ShowTips(var_49_7)

					return
				end, SFX_UI_CLICK)
			end
		end
	end

	var_49_0.allowSwitchOff = false

	return
end

function FormationUI:resetFormationComponent()
	SetActive(self._gridTFs.main[1]:Find("flag"), #self._currentFleetVO:getTeamByName(TeamType.Main) ~= 0)
	SetActive(self._gridTFs.submarine[1]:Find("flag"), #self._currentFleetVO:getTeamByName(TeamType.Submarine) ~= 0)

	return
end

function FormationUI:sortCardSiblingIndex()
	_.each({
		TeamType.Main,
		TeamType.Vanguard,
		TeamType.Submarine
	}, function(arg_54_0)
		if #self._cards[arg_54_0] > 0 then
			for iter_54_0 = 1, #self._cards[arg_54_0] do
				self._cards[arg_54_0][iter_54_0].tr:SetSiblingIndex(iter_54_0 - 1)
			end
		end

		return
	end)

	return
end

function FormationUI:displayFleetInfo()
	SetActive(self._prevPage, self:selectFleetByStep(-1))
	SetActive(self._nextPage, self:selectFleetByStep(1))
	setActive(self._adapt:Find("gear_score"), true)
	setActive(self._vanguardGS, false)
	setActive(self._mainGS, false)
	setActive(self._subGS, false)

	local var_55_0 = self._currentFleetVO:GetPropertiesSum()
	local var_55_1 = math.floor(self._currentFleetVO:GetGearScoreSum(TeamType.Vanguard))
	local var_55_2 = math.floor(self._currentFleetVO:GetGearScoreSum(TeamType.Main))
	local var_55_3 = math.floor(self._currentFleetVO:GetGearScoreSum(TeamType.Submarine))

	self.tweenNumText(self._cannonPower, var_55_0.cannon)
	self.tweenNumText(self._torpedoPower, var_55_0.torpedo)
	self.tweenNumText(self._AAPower, var_55_0.antiAir)
	self.tweenNumText(self._airPower, var_55_0.air)
	self.tweenNumText(self._cost, self._currentFleetVO:GetCostSum().oil)

	if OPEN_AIR_DOMINANCE then
		setActive(self._airDominance.parent, true)
		self.tweenNumText(self._airDominance, self._currentFleetVO:getFleetAirDominanceValue())
	else
		setActive(self._airDominance.parent, false)
	end

	local var_55_4 = self._currentFleetVO:getFleetType()

	if var_55_4 == FleetType.Normal then
		setActive(self._vanguardGS, true)
		setActive(self._mainGS, true)
		setActive(self._arrUpVan, false)
		setActive(self._arrDownVan, false)
		setActive(self._arrUpMain, false)
		setActive(self._arrDownMain, false)

		self.prevVanGS = tonumber(self._vanGSTxt.text)

		self.tweenNumText(self._vanguardGS:Find("Text"), var_55_1)

		if self.VanGSInited then
			setActive(self._arrUpVan, var_55_1 > self.prevVanGS)
			setActive(self._arrDownVan, var_55_1 < self.prevVanGS)
		end

		self.prevMainGS = tonumber(self._mainGSTxt.text)

		self.tweenNumText(self._mainGS:Find("Text"), var_55_2)

		if self.mainGSInited then
			setActive(self._arrUpMain, var_55_2 > self.prevMainGS)
			setActive(self._arrDownMain, var_55_2 < self.prevMainGS)
		end

		self.contextData.mainGS = var_55_2
		self.contextData.vanGS = var_55_1
		self.mainGSInited = true
		self.VanGSInited = true

		local var_55_5 = self._currentFleetVO:GetFleetSonarRange()

		setActive(self._vanguardGS:Find("SonarActive"), var_55_5 > 0)
		setActive(self._vanguardGS:Find("SonarInactive"), var_55_5 <= 0)

		local function var_55_6()
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				type = MSGBOX_TYPE_HELP,
				helps = pg.gametip.fleet_antisub_range_tip.tip
			})

			return
		end

		if var_55_5 > 0 then
			setText(self._vanguardGS:Find("SonarActive/Text"), math.floor(var_55_5))
			onButton(self, self._vanguardGS:Find("SonarActive"), var_55_6, SFX_PANEL)
		else
			onButton(self, self._vanguardGS:Find("SonarInactive"), var_55_6, SFX_PANEL)
		end
	elseif var_55_4 == FleetType.Submarine then
		setActive(self._arrUpSub, false)
		setActive(self._arrDownSub, false)
		setActive(self._subGS, true)

		self.prevSubGS = tonumber(self._subGSTxt.text)

		self.tweenNumText(self._subGS:Find("Text"), var_55_3)

		if self.SubGSInited then
			setActive(self._arrUpSub, var_55_3 > self.prevSubGS)
			setActive(self._arrDownSub, var_55_3 < self.prevSubGS)
		end

		self.contextData.subGS = var_55_3
		self.SubGSInited = true
	end

	self:SetFleetNameLabel()
	setText(self._fleetNumText, self._currentFleetVO:getIndex())

	return
end

function FormationUI:DisplayRenamePanel(arg_57_1)
	SetActive(self._renamePanel, arg_57_1)

	if arg_57_1 then
		pg.UIMgr.GetInstance():BlurPanel(self._renamePanel)
		setInputText(findTF(self._renamePanel, "frame/name_field"), (getText(self._fleetNameText)))
	else
		pg.UIMgr.GetInstance():UnOverlayPanel(self._renamePanel, self._tf)
	end

	return
end

function FormationUI:hideAttrFrame()
	SetActive(self._attrFrame, false)
	pg.UIMgr.GetInstance():UnOverlayPanel(self._blurLayer, self._tf)

	return
end

function FormationUI:displayAttrFrame()
	pg.UIMgr.GetInstance():BlurPanel(self._blurLayer)
	SetActive(self._attrFrame, true)
	self:initAttrFrame()

	return
end

function FormationUI:initAttrFrame()
	local var_60_0 = false

	for iter_60_0, iter_60_1 in pairs({
		[TeamType.Main] = self._currentFleetVO.mainShips,
		[TeamType.Vanguard] = self._currentFleetVO.vanguardShips,
		[TeamType.Submarine] = self._currentFleetVO.subShips
	}) do
		if #self._cards[iter_60_0] == 0 then
			local var_60_1 = self._attrFrame:Find(iter_60_0 .. "/list")

			for iter_60_2 = 1, 3 do
				table.insert(self._cards[iter_60_0], FormationDetailCard.New(cloneTplTo(self._cardTpl, var_60_1).gameObject))
			end

			var_60_0 = true
		end
	end

	if var_60_0 then
		self:updateAttrFrame()
	end

	return
end

function FormationUI:updateAttrFrame()
	local var_61_0 = self._currentFleetVO:getFleetType()

	for iter_61_0, iter_61_1 in pairs({
		[TeamType.Main] = self._currentFleetVO.mainShips,
		[TeamType.Vanguard] = self._currentFleetVO.vanguardShips,
		[TeamType.Submarine] = self._currentFleetVO.subShips
	}) do
		local var_61_1 = self._cards[iter_61_0]

		if #self._cards[iter_61_0] > 0 then
			local var_61_2 = var_61_0 == FleetType.Submarine and iter_61_0 == TeamType.Vanguard

			for iter_61_2 = 1, 3 do
				if iter_61_2 <= #iter_61_1 then
					var_61_1[iter_61_2]:update(self.shipVOs[iter_61_1[iter_61_2]], var_61_2)
					var_61_1[iter_61_2]:updateProps(self:getCardAttrProps(self.shipVOs[iter_61_1[iter_61_2]]))
				else
					var_61_1[iter_61_2]:update(nil, var_61_2)
				end

				self:detachOnCardButton(var_61_1[iter_61_2])

				if not var_61_2 then
					self:attachOnCardButton(var_61_1[iter_61_2], iter_61_0)
				end
			end
		end
	end

	setActive(self._attrFrame:Find(TeamType.Main), var_61_0 == FleetType.Normal)
	setActive(self._attrFrame:Find(TeamType.Submarine), var_61_0 == FleetType.Submarine)
	setActive(self._attrFrame:Find(TeamType.Vanguard .. "/vanguard"), var_61_0 ~= FleetType.Submarine)
	self:updateUltimateTitle()

	return
end

function FormationUI:updateUltimateTitle()
	local var_62_0 = self._cards[TeamType.Main]

	if #self._cards[TeamType.Main] > 0 then
		for iter_62_0 = 1, #var_62_0 do
			go(var_62_0[iter_62_0].shipState):SetActive(iter_62_0 == 1)
		end
	end

	return
end

function FormationUI:getCardAttrProps(arg_63_1)
	return {
		{
			i18n("word_attr_durability"),
			tostring(math.floor(arg_63_1:getProperties().durability))
		},
		{
			i18n("word_attr_luck"),
			"" .. tostring(math.floor((arg_63_1:getBattleTotalExpend())))
		},
		{
			i18n("word_synthesize_power"),
			"<color=#ffff00>" .. arg_63_1:getShipCombatPower() .. "</color>"
		}
	}
end

function FormationUI:detachOnCardButton(arg_64_1)
	local var_64_0 = GetOrAddComponent(arg_64_1.go, "EventTriggerListener")

	var_64_0:RemovePointClickFunc()
	var_64_0:RemoveBeginDragFunc()
	var_64_0:RemoveDragFunc()
	var_64_0:RemoveDragEndFunc()

	return
end

function FormationUI:attachOnCardButton(arg_65_1, arg_65_2)
	local var_65_0 = GetOrAddComponent(arg_65_1.go, "EventTriggerListener")

	self.eventTriggers[var_65_0] = true

	var_65_0:AddPointClickFunc(function(arg_66_0, arg_66_1)
		if not self.carddrag and arg_66_0 == arg_65_1.go then
			if arg_65_1.shipVO then
				self:emit(FormationMediator.OPEN_SHIP_INFO, arg_65_1.shipVO.id, self._currentFleetVO, FormationUI.TOGGLE_DETAIL)
			else
				self:emit(FormationMediator.CHANGE_FLEET_SHIP, arg_65_1.shipVO, self._currentFleetVO, FormationUI.TOGGLE_DETAIL, arg_65_2)
			end

			pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_PANEL)
		end

		return
	end)

	if arg_65_1.shipVO then
		local var_65_1 = self._cards[arg_65_2]
		local var_65_2 = arg_65_1.tr.parent:GetComponent("ContentSizeFitter")
		local var_65_3 = arg_65_1.tr.parent:GetComponent("HorizontalLayoutGroup")
		local var_65_4 = arg_65_1.tr.rect.width * 0.5
		local var_65_5 = {}

		var_65_0:AddBeginDragFunc(function()
			if self.carddrag then
				return
			end

			self._currentDragDelegate = var_65_0
			self.carddrag = arg_65_1
			var_65_2.enabled = false
			var_65_3.enabled = false

			arg_65_1.tr:SetSiblingIndex(#var_65_1)

			for iter_67_0 = 1, #var_65_1 do
				if var_65_1[iter_67_0] == arg_65_1 then
					self._shiftIndex = iter_67_0
				end

				var_65_5[iter_67_0] = var_65_1[iter_67_0].tr.anchoredPosition
			end

			LeanTween.scale(arg_65_1.paintingTr, Vector3(1.1, 1.1, 0), 0.3)

			return
		end)
		var_65_0:AddDragFunc(function(arg_68_0, arg_68_1)
			if self.carddrag ~= arg_65_1 then
				return
			end

			local var_68_0 = arg_65_1.tr.localPosition

			var_68_0.x = self:change2ScrPos(arg_65_1.tr.parent, arg_68_1.position).x
			arg_65_1.tr.localPosition = var_68_0

			local var_68_1 = 1

			for iter_68_0 = 1, #var_65_1 do
				if var_65_1[iter_68_0] ~= arg_65_1 and var_65_1[iter_68_0].shipVO and arg_65_1.tr.localPosition.x > var_65_1[iter_68_0].tr.localPosition.x + (var_68_1 < self._shiftIndex and 1.1 or -1.1) * var_65_4 then
					var_68_1 = var_68_1 + 1
				end
			end

			if self._shiftIndex ~= var_68_1 then
				self._formationLogic:Shift(self._shiftIndex, var_68_1, arg_65_2)
				self:shiftCard(self._shiftIndex, var_68_1, arg_65_2)

				for iter_68_1 = 1, #var_65_1 do
					if var_65_1[iter_68_1] and var_65_1[iter_68_1] ~= arg_65_1 then
						var_65_1[iter_68_1].tr.anchoredPosition = var_65_5[iter_68_1]
					end
				end
			end

			return
		end)
		var_65_0:AddDragEndFunc(function(arg_69_0, arg_69_1)
			if self.carddrag ~= arg_65_1 then
				return
			end

			function resetCard()
				for iter_70_0 = 1, #var_65_1 do
					var_65_1[iter_70_0].tr.anchoredPosition = var_65_5[iter_70_0]
				end

				var_65_2.enabled = true
				var_65_3.enabled = true
				self._shiftIndex = nil

				self:updateUltimateTitle()
				self._formationLogic:SortSiblingIndex()
				self:sortCardSiblingIndex()
				self:emit(FormationMediator.CHANGE_FLEET_SHIPS_ORDER, self._currentFleetVO)

				var_65_0.enabled = true
				self.carddrag = nil

				return
			end

			self._forceDropCharacter = nil
			self._currentDragDelegate = nil
			var_65_0.enabled = false

			if self._forceDropCharacter then
				resetCard()

				arg_65_1.paintingTr.localScale = Vector3(1, 1, 0)
			else
				LeanTween.value(arg_65_1.go, arg_65_1.tr.anchoredPosition.x, var_65_5[self._shiftIndex].x, math.min(math.abs(arg_65_1.tr.anchoredPosition.x - var_65_5[self._shiftIndex].x) / 200, 1) * 0.3):setEase(LeanTweenType.easeOutCubic):setOnUpdate(System.Action_float(function(arg_71_0)
					arg_65_1.tr.anchoredPosition.x = arg_71_0
					arg_65_1.tr.anchoredPosition = arg_65_1.tr.anchoredPosition

					return
				end)):setOnComplete(System.Action(function()
					resetCard()
					LeanTween.scale(arg_65_1.paintingTr, Vector3(1, 1, 0), 0.3)

					return
				end))
			end

			return
		end)
	end

	return
end

function FormationUI:shiftCard(arg_73_1, arg_73_2, arg_73_3)
	local var_73_0 = self._cards[arg_73_3]

	if #self._cards[arg_73_3] > 0 then
		var_73_0[arg_73_1], var_73_0[arg_73_2] = self._cards[arg_73_3][arg_73_2], self._cards[arg_73_3][arg_73_1]
	end

	self._shiftIndex = arg_73_2

	return
end

function FormationUI:change2ScrPos(arg_74_1, arg_74_2)
	return (LuaHelper.ScreenToLocal(arg_74_1, arg_74_2, pg.UIMgr.GetInstance().overlayCameraComp))
end

function FormationUI:tweenNumText(arg_75_1, arg_75_2, arg_75_3, arg_75_4)
	LeanTween.value(go(self), arg_75_4 or 0, math.floor(arg_75_1), arg_75_2 or 0.7):setOnUpdate(System.Action_float(function(arg_76_0)
		setText(self, math.floor(arg_76_0))

		return
	end)):setOnComplete(System.Action(function()
		if arg_75_3 then
			arg_75_3()
		end

		return
	end))

	return
end

function FormationUI:defaultFleetName()
	if self.name == "" or self.name == nil then
		return Fleet.DEFAULT_NAME[self.id]
	else
		return self.name
	end

	return
end

function FormationUI:GetFleetCount()
	local var_79_0 = 0

	for iter_79_0, iter_79_1 in pairs(self._fleetVOs) do
		var_79_0 = var_79_0 + 1
	end

	return var_79_0
end

function FormationUI:tweenTabArrow(arg_80_1)
	local var_80_0 = self.btnRegular:Find("arr")
	local var_80_1 = self.btnSub:Find("arr")

	setActive(var_80_0, arg_80_1)
	setActive(var_80_1, arg_80_1)

	if arg_80_1 then
		LeanTween.moveLocalY(go(var_80_0), var_80_0.localPosition.y + 8, 0.8):setEase(LeanTweenType.easeInOutSine):setLoopPingPong(-1)
		LeanTween.moveLocalY(go(var_80_1), var_80_1.localPosition.y + 8, 0.8):setEase(LeanTweenType.easeInOutSine):setLoopPingPong(-1)
	else
		LeanTween.cancel(go(var_80_0))
		LeanTween.cancel(go(var_80_1))

		var_80_0.localPosition.y = 80
		var_80_0.localPosition = var_80_0.localPosition
		var_80_1.localPosition.y = 80
		var_80_1.localPosition = var_80_1.localPosition
	end

	return
end

function FormationUI:recyclePainting()
	for iter_81_0, iter_81_1 in pairs(self._cards) do
		for iter_81_2, iter_81_3 in ipairs(iter_81_1) do
			iter_81_3:clear()
		end
	end

	return
end

function FormationUI:onBackPressed()
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)

	if isActive(self._renamePanel) then
		self:DisplayRenamePanel(false)
	else
		triggerButton(self.backBtn)
	end

	return
end

function FormationUI:willExit()
	self.commanderFormationPanel:Destroy()

	if self._attrFrame.gameObject.activeSelf then
		pg.UIMgr.GetInstance():UnOverlayPanel(self._blurLayer, self._tf)
	end

	self._formationLogic:Destroy()
	self:recyclePainting()
	self:DisplayRenamePanel(false)
	self:tweenTabArrow(false)

	if self.tweens then
		cancelTweens(self.tweens)
	end

	if self.eventTriggers then
		for iter_83_0, iter_83_1 in pairs(self.eventTriggers) do
			ClearEventTrigger(iter_83_0)
		end

		self.eventTriggers = nil
	end

	return
end

return FormationUI

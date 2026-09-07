local BossSinglePreCombatLayer = class("BossSinglePreCombatLayer", import("view.base.BaseUI"))
local FormationUI = import("view.ship.FormationUI")
local var_0_2 = {
	[99] = true
}

function BossSinglePreCombatLayer:getUIName()
	return "BossSinglePreCombatUI"
end

function BossSinglePreCombatLayer:ResUISettings()
	return {
		anim = true,
		order = 5,
		showType = PlayerResUI.TYPE_ALL
	}
end

function BossSinglePreCombatLayer:init()
	self:CommonInit()

	self._formationLogic = BaseFormation.New(self._tf, self._heroContainer, self._heroInfo, self._gridTFs)

	self:Register()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function BossSinglePreCombatLayer:CommonInit()
	self.eventTriggers = {}
	self._startBtn = self.rtAdapt:Find("right/start")
	self._costContainer = self.rtAdapt:Find("right/start/cost_container")
	self._popup = self._costContainer:Find("popup")
	self._costText = self._popup:Find("Text")
	self._moveLayer = self._tf:Find("moveLayer")

	local var_4_0 = self.rtAdapt:Find("middle")

	self._autoToggle = self.rtAdapt:Find("auto_toggle")
	self._autoSubToggle = self.rtAdapt:Find("sub_toggle_container/sub_toggle")
	self._fleetInfo = var_4_0:Find("fleet_info")
	self._fleetNameText = var_4_0:Find("fleet_info/fleet_name/Text")
	self._fleetNumText = var_4_0:Find("fleet_info/fleet_number")

	setActive(self._fleetInfo, true)

	self._mainGS = var_4_0:Find("gear_score/main/Text")
	self._vanguardGS = var_4_0:Find("gear_score/vanguard/Text")
	self._subGS = var_4_0:Find("gear_score/submarine/Text")
	self._bgFleet = var_4_0:Find("mask/grid_bg")
	self._bgSub = var_4_0:Find("mask/bg_sub")
	self._gridTFs = {
		[TeamType.Vanguard] = {},
		[TeamType.Main] = {},
		[TeamType.Submarine] = {}
	}
	self._gridFrame = var_4_0:Find("mask/GridFrame")

	for iter_4_0 = 1, 3 do
		self._gridTFs[TeamType.Main][iter_4_0] = self._gridFrame:Find("main_" .. iter_4_0)
		self._gridTFs[TeamType.Vanguard][iter_4_0] = self._gridFrame:Find("vanguard_" .. iter_4_0)
		self._gridTFs[TeamType.Submarine][iter_4_0] = self._gridFrame:Find("submarine_" .. iter_4_0)
	end

	self._nextPage = self.rtAdapt:Find("middle/nextPage")
	self._prevPage = self.rtAdapt:Find("middle/prevPage")
	self._heroContainer = var_4_0:Find("HeroContainer")
	self._checkBtn = var_4_0:Find("checkBtn")
	self._blurPanel = self._tf:Find("blur_panel")
	self.topPanel = self._blurPanel:Find("top")
	self.topPanelBg = self._blurPanel:Find("top_bg")
	self._backBtn = self.topPanel:Find("back_btn")
	self._spoilsContainer = self.rtAdapt:Find("right/infomation/atlasloot/spoils/items/items_container")
	self._item = self.rtAdapt:Find("right/infomation/atlasloot/spoils/items/item_tpl")

	SetActive(self._item, false)

	self._goals = self.rtAdapt:Find("right/infomation/target/goal")
	self._heroInfo = self:getTpl("heroInfo")
	self._starTpl = self:getTpl("star_tpl")

	setText(findTF(self.rtAdapt, "middle/gear_score/vanguard/line/Image/Text1"), i18n("pre_combat_vanguard"))
	setText(findTF(self.rtAdapt, "middle/gear_score/main/line/Image/Text1"), i18n("pre_combat_main"))
	setText(findTF(self.rtAdapt, "middle/gear_score/submarine/line/Image/text1"), i18n("pre_combat_submarine"))
	setText(self._costContainer:Find("title"), i18n("pre_combat_consume"))
	setText(findTF(self.rtAdapt, "right/infomation/target/title/GameObject"), i18n("pre_combat_targets"))
	setText(findTF(self.rtAdapt, "right/infomation/atlasloot/atlasloot/title/GameObject"), i18n("pre_combat_atlasloot"))
	setText(self._startBtn:Find("text"), i18n("pre_combat_start"))
	setText(self._startBtn:Find("text_en"), i18n("pre_combat_start_en"))

	self._middle = self.rtAdapt:Find("middle")
	self._right = self.rtAdapt:Find("right")

	setAnchoredPosition(self._middle, {
		x = -840
	})
	setAnchoredPosition(self._right, {
		x = 470
	})

	self.guideDesc = self._middle:Find("guideDesc")

	if self.contextData.stageId then
		self:SetStageID(self.contextData.stageId)
	end

	self._costTip = self._startBtn:Find("cost_container/popup/tip")
	self._continuousBtn = self.rtAdapt:Find("right/multiple")

	setText(self._continuousBtn:Find("text"), i18n("multiple_sorties_title"))
	setText(self._continuousBtn:Find("text_en"), i18n("multiple_sorties_title_eng"))

	return
end

function BossSinglePreCombatLayer:Register()
	self._formationLogic:AddLoadComplete(function()
		if self._currentForm ~= PreCombatLayer.FORM_EDIT then
			self._formationLogic:SwitchToPreviewMode()
		end

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

		local var_7_7 = pg.battle_cost_template[self.contextData.system]

		setActive(var_7_3, var_7_2 and var_7_7.enter_energy_cost > 0)

		for iter_7_0 = 1, arg_7_1:getStar() do
			cloneTplTo(self._starTpl, var_7_1)
		end

		local var_7_8 = GetSpriteFromAtlas("shiptype", shipType2print(arg_7_1:getShipType()))

		if not var_7_8 then
			warning("找不到船形, shipConfigId: " .. arg_7_1.configId)
		end

		setImageSprite(findTF(var_7_0, "type"), var_7_8, true)
		setText(findTF(var_7_0, "frame/lv_contain/lv"), arg_7_1.level)

		if var_7_7.ship_exp_award > 0 then
			local var_7_9 = getProxy(ActivityProxy):getBuffShipList()[arg_7_1:getGroupId()]
			local var_7_10 = var_7_0:Find("expbuff")

			setActive(var_7_10, var_7_9 ~= nil)

			if var_7_9 then
				local var_7_11 = tostring(var_7_9 / 100)

				if var_7_9 % 100 > 0 then
					var_7_11 = var_7_11 .. "." .. tostring(var_7_9 % 100)
				end

				setText(var_7_10:Find("text"), string.format("EXP +%s%%", var_7_11))
			end
		else
			setActive(var_7_0:Find("expbuff"), false)
		end

		return
	end)
	self._formationLogic:AddLongPress(function(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
		self:emit(BossSinglePreCombatMediator.OPEN_SHIP_INFO, arg_8_1.id, arg_8_2)

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
		return
	end)
	self._formationLogic:AddShiftOnly(function(arg_12_0)
		self:emit(BossSinglePreCombatMediator.CHANGE_FLEET_SHIPS_ORDER, arg_12_0)

		return
	end)
	self._formationLogic:AddRemoveShip(function(arg_13_0, arg_13_1)
		return
	end)
	self._formationLogic:AddCheckRemove(function(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
		arg_14_0()

		return
	end)
	self._formationLogic:AddSwitchToDisplayMode(function()
		self._currentForm = PreCombatLayer.FORM_EDIT
		self._checkBtn:GetComponent("Button").interactable = true

		self:SetFleetStepper()
		setActive(self._checkBtn:Find("save"), true)
		setActive(self._checkBtn:Find("edit"), false)

		return
	end)
	self._formationLogic:AddSwitchToShiftMode(function()
		self:SetFleetStepper()

		self._checkBtn:GetComponent("Button").interactable = false

		return
	end)
	self._formationLogic:AddSwitchToPreviewMode(function()
		self._currentForm = PreCombatLayer.FORM_PREVIEW
		self._checkBtn:GetComponent("Button").interactable = true

		self:SetFleetStepper()
		setActive(self._checkBtn:Find("save"), false)
		setActive(self._checkBtn:Find("edit"), true)

		return
	end)
	self._formationLogic:AddGridTipClick(function(arg_18_0, arg_18_1)
		return
	end)
	self._formationLogic:DisableTip()

	return
end

function BossSinglePreCombatLayer:SetPlayerInfo(arg_19_1)
	return
end

function BossSinglePreCombatLayer:SetSubFlag(arg_20_1)
	self._subUseable = arg_20_1 or false

	return
end

function BossSinglePreCombatLayer:SetShips(arg_21_1)
	self._shipVOs = arg_21_1

	self._formationLogic:SetShipVOs(self._shipVOs)

	return
end

function BossSinglePreCombatLayer:SetStageID(arg_22_1)
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

	if self.contextData.system ~= SYSTEM_BOSS_EXPERIMENT then
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

					self:emit(BossSinglePreCombatLayer.ON_DROP_LIST, {
						item2Row = true,
						itemList = var_23_1,
						content = var_23_0.display
					})
				else
					self:emit(BossSinglePreCombatLayer.ON_DROP, var_22_5)
				end

				return
			end, SFX_PANEL)
		end
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

	local var_22_9 = pg.expedition_data_template[arg_22_1].guide_desc and #pg.expedition_data_template[arg_22_1].guide_desc > 0

	setActive(self.guideDesc, var_22_9)

	if var_22_9 then
		setText(self.guideDesc, pg.expedition_data_template[arg_22_1].guide_desc)
	end

	return
end

function BossSinglePreCombatLayer:SetFleets(arg_25_1)
	self._fleetVOs = {}

	_.each(_.filter(_.values(arg_25_1), function(arg_26_0)
		return arg_26_0:getFleetType() == FleetType.Normal
	end), function(arg_27_0)
		self._fleetVOs[arg_27_0.id] = arg_27_0

		return
	end)
	self:CheckLegalFleet()

	return
end

function BossSinglePreCombatLayer:SetCurrentFleet(arg_28_1)
	self._currentFleetVO = self._fleetVOs[arg_28_1]

	self._formationLogic:SetFleetVO(self._currentFleetVO)
	self:CheckLegalFleet()

	for iter_28_0, iter_28_1 in ipairs(self._legalFleetIdList) do
		if self._currentFleetVO.id == iter_28_1 then
			self._curFleetIndex = iter_28_0

			break
		end
	end

	return
end

function BossSinglePreCombatLayer:CheckLegalFleet()
	self._legalFleetIdList = {}

	for iter_29_0, iter_29_1 in pairs(self._fleetVOs) do
		if #iter_29_1.ships > 0 and iter_29_1.id ~= FleetProxy.PVP_FLEET_ID then
			table.insert(self._legalFleetIdList, iter_29_1.id)
		end
	end

	table.sort(self._legalFleetIdList)

	return
end

function BossSinglePreCombatLayer:UpdateFleetView(arg_30_1)
	self:displayFleetInfo()
	self:updateFleetBg()
	self._formationLogic:UpdateGridVisibility()
	self._formationLogic:ResetGrid(TeamType.Vanguard, self._currentForm ~= PreCombatLayer.FORM_EDIT)
	self._formationLogic:ResetGrid(TeamType.Main, self._currentForm ~= PreCombatLayer.FORM_EDIT)
	self._formationLogic:ResetGrid(TeamType.Submarine, self._currentForm ~= PreCombatLayer.FORM_EDIT)
	self:resetFormationComponent()

	if arg_30_1 then
		self._formationLogic:LoadAllCharacter()
	else
		self._formationLogic:SetAllCharacterPos()
	end

	return
end

function BossSinglePreCombatLayer:updateFleetBg()
	local var_31_0 = self._currentFleetVO:getFleetType()

	setActive(self._bgFleet, var_31_0 == FleetType.Normal)
	setActive(self._bgSub, var_31_0 == FleetType.Submarine)

	return
end

function BossSinglePreCombatLayer:resetFormationComponent()
	SetActive(self._gridTFs.main[1]:Find("flag"), #self._currentFleetVO:getTeamByName(TeamType.Main) ~= 0)
	SetActive(self._gridTFs.submarine[1]:Find("flag"), #self._currentFleetVO:getTeamByName(TeamType.Submarine) ~= 0)

	return
end

function BossSinglePreCombatLayer:uiStartAnimating()
	shiftPanel(self._middle, 0, nil, 0.3, 0, true, true)
	shiftPanel(self._right, 0, nil, 0.3, 0, true, true)

	return
end

function BossSinglePreCombatLayer:uiExitAnimating()
	shiftPanel(self._middle, -840, nil, nil, nil, true, true)
	shiftPanel(self._right, 470, nil, nil, nil, true, true)

	return
end

function BossSinglePreCombatLayer:quickExitFunc()
	if self._currentForm == PreCombatLayer.FORM_EDIT then
		self:emit(BossSinglePreCombatMediator.ON_ABORT_EDIT)
	end

	BossSinglePreCombatLayer.super.quickExitFunc(self)

	return
end

function BossSinglePreCombatLayer:didEnter()
	onButton(self, self._backBtn, function()
		local var_37_0 = {}

		if self._currentForm == PreCombatLayer.FORM_EDIT then
			table.insert(var_37_0, function(arg_38_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					hideNo = false,
					zIndex = -100,
					content = i18n("battle_preCombatLayer_save_confirm"),
					onYes = function()
						self:emit(BossSinglePreCombatMediator.ON_COMMIT_EDIT, function()
							pg.TipsMgr.GetInstance():ShowTips(i18n("battle_preCombatLayer_save_success"))
							arg_38_0()

							return
						end)

						return
					end,
					onNo = function()
						self:emit(BossSinglePreCombatMediator.ON_ABORT_EDIT)
						arg_38_0()

						return
					end
				})

				return
			end)
		end

		seriesAsync(var_37_0, function()
			GetOrAddComponent(self._tf, typeof(CanvasGroup)).interactable = false

			self:uiExitAnimating()
			LeanTween.delayedCall(0.3, System.Action(function()
				self:closeView()

				return
			end))

			return
		end)

		return
	end, SFX_CANCEL)
	onButton(self, self._startBtn, function()
		local var_44_0 = {}

		if self._currentForm == PreCombatLayer.FORM_EDIT then
			table.insert(var_44_0, function(arg_45_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					hideNo = false,
					zIndex = -100,
					content = i18n("battle_preCombatLayer_save_march"),
					onYes = function()
						self:emit(BossSinglePreCombatMediator.ON_COMMIT_EDIT, function()
							pg.TipsMgr.GetInstance():ShowTips(i18n("battle_preCombatLayer_save_success"))
							arg_45_0()

							return
						end)

						return
					end
				})

				return
			end)
		end

		seriesAsync(var_44_0, function()
			self:emit(BossSinglePreCombatMediator.ON_START, self._currentFleetVO.id)

			return
		end)

		return
	end, SFX_UI_WEIGHANCHOR)
	onButton(self, self._checkBtn, function()
		if self._currentForm == PreCombatLayer.FORM_EDIT then
			self:emit(BossSinglePreCombatMediator.ON_COMMIT_EDIT, function()
				pg.TipsMgr.GetInstance():ShowTips(i18n("battle_preCombatLayer_save_success"))
				self._formationLogic:SwitchToPreviewMode()

				return
			end)
		elseif self._currentForm == PreCombatLayer.FORM_PREVIEW then
			self._formationLogic:SwitchToDisplayMode()
		else
			assert("currentForm error")
		end

		return
	end, SFX_PANEL)

	self._currentForm = self.contextData.form
	self.contextData.form = nil

	self:UpdateFleetView(true)

	if self._currentForm == PreCombatLayer.FORM_EDIT then
		self._formationLogic:SwitchToDisplayMode()
	else
		self._formationLogic:SwitchToPreviewMode()
	end

	setActive(self._autoToggle, true)
	onToggle(self, self._autoToggle, function(arg_51_0)
		self:emit(BossSinglePreCombatMediator.ON_AUTO, {
			isOn = not arg_51_0,
			toggle = self._autoToggle
		})

		if arg_51_0 and self._subUseable == true then
			setActive(self._autoSubToggle, true)
			onToggle(self, self._autoSubToggle, function(arg_52_0)
				self:emit(BossSinglePreCombatMediator.ON_SUB_AUTO, {
					isOn = not arg_52_0,
					toggle = self._autoSubToggle
				})

				return
			end, SFX_PANEL, SFX_PANEL)
			triggerToggle(self._autoSubToggle, ys.Battle.BattleState.IsAutoSubActive())
		else
			setActive(self._autoSubToggle, false)
		end

		return
	end, SFX_PANEL, SFX_PANEL)
	triggerToggle(self._autoToggle, ys.Battle.BattleState.IsAutoBotActive())
	onNextTick(function()
		self:uiStartAnimating()

		return
	end)

	local var_36_0 = getProxy(ActivityProxy)
	local var_36_1 = var_36_0:getActivityById(self.contextData.actId)
	local var_36_2 = var_36_0 and var_36_1:HasPassStage(self.contextData.stageId)

	setActive(self._continuousBtn, (var_36_1:GetEnemyDataByStageId(self.contextData.stageId):IsContinuousType()))
	setActive(self._continuousBtn:Find("lock"), not var_36_2)

	local var_36_3

	if var_36_2 then
		var_36_3 = Color.white or Color.New(0.2980392156862745, 0.2980392156862745, 0.2980392156862745)
	end

	setImageColor(self._continuousBtn, var_36_3)
	setTextColor(self._continuousBtn:Find("text"), var_36_3)
	setTextColor(self._continuousBtn:Find("text_en"), var_36_3)
	onButton(self, self._continuousBtn, function()
		if var_36_2 then
			self:emit(BossSinglePreCombatMediator.SHOW_CONTINUOUS_OPERATION_WINDOW, self._currentFleetVO.id)
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("multiple_sorties_locked_tip"))
		end

		return
	end, SFX_PANEL)

	return
end

function BossSinglePreCombatLayer:displayFleetInfo()
	local var_55_0 = self._currentFleetVO:getFleetType()

	setActive(self._vanguardGS.parent, var_55_0 == FleetType.Normal)
	setActive(self._mainGS.parent, var_55_0 == FleetType.Normal)

	local var_55_1 = math.floor(self._currentFleetVO:GetGearScoreSum(TeamType.Vanguard))
	local var_55_2 = math.floor(self._currentFleetVO:GetGearScoreSum(TeamType.Main))

	setActive(self._subGS.parent, var_55_0 == FleetType.Submarine)

	local var_55_3 = math.floor(self._currentFleetVO:GetGearScoreSum(TeamType.Submarine))
	local var_55_4 = self.contextData.system
	local var_55_5 = pg.battle_cost_template[self.contextData.system].oil_cost == 0 and 0 or self._currentFleetVO:GetCostSum().oil

	setActive(self._costContainer, true)
	FormationUI.tweenNumText(self._costText, var_55_5)
	FormationUI.tweenNumText(self._vanguardGS, var_55_1)
	FormationUI.tweenNumText(self._mainGS, var_55_2)
	FormationUI.tweenNumText(self._subGS, var_55_3)
	setText(self._fleetNameText, ((getProxy(ActivityProxy):getActivityById(self.contextData.actId):getConfig("type") == ActivityConst.ACTIVITY_TYPE_BOSSSINGLE_VARIABLE or nil) and (Fleet.DEFAULT_NAME_BOSS_SINGLE_VARIABLE_ACT or Fleet.DEFAULT_NAME_BOSS_SINGLE_ACT))[self._currentFleetVO.id])
	setText(self._fleetNumText, self._currentFleetVO.id)

	local var_55_7 = pg.battle_cost_template[var_55_4].oil_cost > 0
	local var_55_8 = 0
	local var_55_9 = 0
	local var_55_10 = false

	for iter_55_0, iter_55_1 in ipairs({
		self.contextData.fleets[1]
	}) do
		local var_55_11 = iter_55_1:GetCostSum().oil

		if not var_55_7 then
			var_55_11 = 0
		end

		var_55_9 = var_55_9 + var_55_11

		local var_55_12 = self.contextData.costLimit[iter_55_0 == 1 and 1 or 2]

		if self.contextData.costLimit[iter_55_0 == 1 and 1 or 2] > 0 then
			var_55_10 = var_55_10 or var_55_12 < var_55_11
			var_55_11 = math.min(var_55_11, var_55_12)
		end

		var_55_8 = var_55_8 + var_55_11
	end

	setTextColor(self._costText, var_55_10 and Color(0.9803921568627451, 0.39215686274509803, 0.39215686274509803) or Color.white)
	FormationUI.tweenNumText(self._costText, var_55_8)
	setActive(self._costTip, var_55_10)

	if var_55_10 then
		onButton(self, self._costTip, function()
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				hideNo = true,
				content = i18n("use_oil_limit_help", var_55_9, var_55_8)
			})

			return
		end)
	end

	return
end

function BossSinglePreCombatLayer:SetFleetStepper()
	SetActive(self._nextPage, false)
	SetActive(self._prevPage, false)

	return
end

function BossSinglePreCombatLayer:onBackPressed()
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)
	triggerButton(self._backBtn)

	return
end

function BossSinglePreCombatLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)
	self._formationLogic:Destroy()

	self._formationLogic = nil

	return
end

return BossSinglePreCombatLayer

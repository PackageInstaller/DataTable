local BossRushPreCombatLayer = class("BossRushPreCombatLayer", import("view.base.BaseUI"))
local FormationUI = import("view.ship.FormationUI")
local var_0_2 = {
	[99] = true
}

function BossRushPreCombatLayer:getUIName()
	return "BossRushPreCombatUI"
end

function BossRushPreCombatLayer:ResUISettings()
	return true
end

function BossRushPreCombatLayer:tempCache()
	return true
end

function BossRushPreCombatLayer:init()
	self:CommonInit()

	self._formationLogic = BaseFormation.New(self._tf, self._heroContainer, self._heroInfo, self._gridTFs)

	self:Register()

	return
end

function BossRushPreCombatLayer:CommonInit()
	self.eventTriggers = {}

	local var_5_0 = self._tf:Find("adapt")

	self._startBtn = var_5_0:Find("right/start")
	self._costContainer = var_5_0:Find("right/start/cost_container")
	self._popup = self._costContainer:Find("popup")
	self._costText = self._popup:Find("Text")
	self._moveLayer = var_5_0:Find("moveLayer")

	local var_5_1 = var_5_0:Find("middle")

	self._autoToggle = var_5_0:Find("auto_toggle")
	self._autoSubToggle = var_5_0:Find("sub_toggle_container/sub_toggle")
	self._fleetInfo = var_5_1:Find("fleet_info")
	self._fleetNameText = var_5_1:Find("fleet_info/fleet_name/Text")
	self._fleetNumText = var_5_1:Find("fleet_info/fleet_number")

	setActive(self._fleetInfo, self.contextData.system ~= SYSTEM_DUEL)

	self._mainGS = var_5_1:Find("gear_score/main/Text")
	self._vanguardGS = var_5_1:Find("gear_score/vanguard/Text")
	self._subGS = var_5_1:Find("gear_score/submarine/Text")
	self._bgFleet = var_5_1:Find("mask/grid_bg")
	self._bgSub = var_5_1:Find("mask/bg_sub")
	self._gridTFs = {
		[TeamType.Vanguard] = {},
		[TeamType.Main] = {},
		[TeamType.Submarine] = {}
	}
	self._gridFrame = var_5_1:Find("mask/GridFrame")

	for iter_5_0 = 1, 3 do
		self._gridTFs[TeamType.Main][iter_5_0] = self._gridFrame:Find("main_" .. iter_5_0)
		self._gridTFs[TeamType.Vanguard][iter_5_0] = self._gridFrame:Find("vanguard_" .. iter_5_0)
		self._gridTFs[TeamType.Submarine][iter_5_0] = self._gridFrame:Find("submarine_" .. iter_5_0)
	end

	self._nextPage = var_5_0:Find("middle/nextPage")
	self._prevPage = var_5_0:Find("middle/prevPage")
	self._heroContainer = var_5_1:Find("HeroContainer")
	self._checkBtn = var_5_1:Find("checkBtn")
	self._blurPanel = self._tf:Find("blur_panel")
	self.topPanel = self._blurPanel:Find("top")
	self.topPanelBg = self._blurPanel:Find("top_bg")
	self._backBtn = self.topPanel:Find("back_btn")
	self._spoilsContainer = var_5_0:Find("right/infomation/atlasloot/spoils/items/items_container")
	self._item = var_5_0:Find("right/infomation/atlasloot/spoils/items/item_tpl")

	SetActive(self._item, false)

	self._goals = var_5_0:Find("right/infomation/target/goal")
	self._heroInfo = self:getTpl("heroInfo")
	self._starTpl = self:getTpl("star_tpl")

	setText(findTF(var_5_0, "middle/gear_score/vanguard/line/Image/Text1"), i18n("pre_combat_vanguard"))
	setText(findTF(var_5_0, "middle/gear_score/main/line/Image/Text1"), i18n("pre_combat_main"))
	setText(findTF(var_5_0, "middle/gear_score/submarine/line/Image/text1"), i18n("pre_combat_submarine"))
	setText(self._costContainer:Find("title"), i18n("pre_combat_consume"))
	setText(findTF(var_5_0, "right/infomation/target/title/GameObject"), i18n("pre_combat_targets"))
	setText(findTF(var_5_0, "right/infomation/atlasloot/atlasloot/title/GameObject"), i18n("pre_combat_atlasloot"))
	setText(self._startBtn:Find("text"), i18n("pre_combat_start"))
	setText(self._startBtn:Find("text_en"), i18n("pre_combat_start_en"))

	self._middle = var_5_0:Find("middle")
	self._right = var_5_0:Find("right")

	setAnchoredPosition(self._middle, {
		x = -840
	})
	setAnchoredPosition(self._right, {
		x = 470
	})

	self.guideDesc = self._middle:Find("guideDesc")
	self._costTip = self._startBtn:Find("cost_container/popup/tip")
	self._continuousBtn = var_5_0:Find("right/multiple")

	setText(self._continuousBtn:Find("text"), i18n("multiple_sorties_title"))
	setText(self._continuousBtn:Find("text_en"), i18n("multiple_sorties_title_eng"))

	return
end

function BossRushPreCombatLayer:Register()
	self._formationLogic:AddLoadComplete(function()
		return
	end)
	self._formationLogic:AddHeroInfoModify(function(arg_8_0, arg_8_1)
		setAnchoredPosition(arg_8_0, {
			x = 0,
			y = 0
		})
		SetActive(arg_8_0, true)

		arg_8_0.name = "info"

		local var_8_0 = findTF(arg_8_0, "info")
		local var_8_1 = findTF(var_8_0, "stars")
		local var_8_2 = arg_8_1.energy <= Ship.ENERGY_MID
		local var_8_3 = findTF(var_8_0, "energy")

		if arg_8_1.energy <= Ship.ENERGY_MID then
			local var_8_4, var_8_5 = arg_8_1:getEnergyPrint()
			local var_8_6 = GetSpriteFromAtlas("energy", var_8_4)

			if not var_8_6 then
				warning("找不到疲劳")
			end

			setImageSprite(var_8_3, var_8_6)
		end

		setActive(var_8_3, var_8_2 and self.contextData.system ~= SYSTEM_DUEL)

		for iter_8_0 = 1, arg_8_1:getStar() do
			cloneTplTo(self._starTpl, var_8_1)
		end

		local var_8_7 = GetSpriteFromAtlas("shiptype", shipType2print(arg_8_1:getShipType()))

		if not var_8_7 then
			warning("找不到船形, shipConfigId: " .. arg_8_1.configId)
		end

		setImageSprite(findTF(var_8_0, "type"), var_8_7, true)
		setText(findTF(var_8_0, "frame/lv_contain/lv"), arg_8_1.level)
		setActive(var_8_0:Find("expbuff"), false)

		return
	end)
	self._formationLogic:AddLongPress(function(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
		self:emit(BossRushPreCombatMediator.OPEN_SHIP_INFO, arg_9_1.id, arg_9_2)

		return
	end)
	self._formationLogic:AddBeginDrag(function(arg_10_0)
		SetActive(findTF(arg_10_0, "info"), false)

		return
	end)
	self._formationLogic:AddEndDrag(function(arg_11_0)
		SetActive(findTF(arg_11_0, "info"), true)

		return
	end)
	self._formationLogic:AddClick(function(arg_12_0, arg_12_1, arg_12_2)
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_CLICK)
		self:emit(BossRushPreCombatMediator.CHANGE_FLEET_SHIP, arg_12_0, arg_12_2, arg_12_1)

		return
	end)
	self._formationLogic:AddShiftOnly(function(arg_13_0)
		self:emit(BossRushPreCombatMediator.CHANGE_FLEET_SHIPS_ORDER, arg_13_0)

		return
	end)
	self._formationLogic:AddRemoveShip(function(arg_14_0, arg_14_1)
		self:emit(BossRushPreCombatMediator.REMOVE_SHIP, arg_14_0, arg_14_1)

		return
	end)
	self._formationLogic:AddCheckRemove(function(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4)
		if not arg_15_3:canRemove(arg_15_2) then
			local var_15_0, var_15_1 = arg_15_3:getShipPos(arg_15_2)

			pg.TipsMgr.GetInstance():ShowTips(i18n("ship_formationUI_removeError_onlyShip", arg_15_2:getConfigTable().name, arg_15_3.name or "", Fleet.C_TEAM_NAME[var_15_1]))
			arg_15_0()
		else
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				hideNo = false,
				zIndex = -100,
				content = i18n("battle_preCombatLayer_quest_leaveFleet", arg_15_2:getConfigTable().name),
				onYes = arg_15_1,
				onNo = arg_15_0
			})
		end

		return
	end)
	self._formationLogic:AddSwitchToDisplayMode(function()
		self:SetFleetStepper()

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
	self._formationLogic:AddGridTipClick(function(arg_19_0, arg_19_1)
		self:emit(BossRushPreCombatMediator.CHANGE_FLEET_SHIP, nil, self._currentFleetVO, arg_19_0)

		return
	end)

	return
end

function BossRushPreCombatLayer:SetPlayerInfo(arg_20_1)
	return
end

function BossRushPreCombatLayer:SetSubFlag(arg_21_1)
	self._subUseable = arg_21_1 or false

	self:UpdateSubToggle()

	return
end

function BossRushPreCombatLayer:SetShips(arg_22_1)
	self._shipVOs = arg_22_1

	self._formationLogic:SetShipVOs(self._shipVOs)

	return
end

function BossRushPreCombatLayer:SetStageIds(arg_23_1)
	removeAllChildren(self._spoilsContainer)

	local var_23_0 = {}

	table.Foreach(arg_23_1, function(arg_24_0, arg_24_1)
		local var_24_0 = Clone(pg.expedition_data_template[arg_24_1].award_display)
		local var_24_1 = checkExist(pg.expedition_activity_template[arg_24_1], {
			"pt_drop_display"
		})

		if var_24_1 and type(var_24_1) == "table" then
			local var_24_2 = getProxy(ActivityProxy)

			for iter_24_0 = #var_24_1, 1, -1 do
				local var_24_3 = var_24_2:getActivityById(var_24_1[iter_24_0][1])

				if var_24_3 and not var_24_3:isEnd() then
					table.insert(var_24_0, 1, {
						2,
						id2ItemId(var_24_1[iter_24_0][2])
					})
				end
			end
		end

		table.insertto(var_23_0, var_24_0)

		if arg_24_0 > 1 then
			return
		end

		local function var_24_4(arg_25_0, arg_25_1)
			if type(arg_25_0) == "table" then
				setActive(arg_25_1, true)
				setWidgetText(arg_25_1, (i18n(PreCombatLayer.ObjectiveList[arg_25_0[1]], arg_25_0[2])))
			else
				setActive(arg_25_1, false)
			end

			return
		end

		local var_24_5 = {
			findTF(self._goals, "goal_tpl"),
			findTF(self._goals, "goal_sink"),
			findTF(self._goals, "goal_time")
		}
		local var_24_6 = 1

		for iter_24_1, iter_24_2 in ipairs({
			pg.expedition_data_template[arg_24_1].objective_1,
			pg.expedition_data_template[arg_24_1].objective_2,
			pg.expedition_data_template[arg_24_1].objective_3
		}) do
			if type(iter_24_2) ~= "string" then
				var_24_4(iter_24_2, var_24_5[var_24_6])

				var_24_6 = var_24_6 + 1
			end
		end

		for iter_24_3 = var_24_6, #var_24_5 do
			var_24_4("", var_24_5[iter_24_3])
		end

		return
	end)

	local var_23_1 = {}

	for iter_23_0, iter_23_1 in ipairs(var_23_0) do
		if (function()
			for iter_26_0, iter_26_1 in ipairs(var_23_1) do
				if iter_23_1[1] == iter_26_1[1] and iter_23_1[2] == iter_26_1[2] then
					return false
				end
			end

			return true
		end)() then
			table.insert(var_23_1, iter_23_1)
		end
	end

	var_23_0 = var_23_1

	for iter_23_2, iter_23_3 in ipairs(var_23_1) do
		local var_23_2 = cloneTplTo(self._item, self._spoilsContainer)
		local var_23_3 = {
			id = iter_23_3[2],
			type = iter_23_3[1]
		}

		updateDrop(var_23_2, var_23_3)
		onButton(self, var_23_2, function()
			local var_27_0 = Item.getConfigData(iter_23_3[2])

			if var_27_0 and var_0_2[var_27_0.type] then
				local var_27_1 = {}

				for iter_27_0, iter_27_1 in ipairs(var_27_0.display_icon) do
					var_27_1[#var_27_1 + 1] = {
						hideName = true,
						type = iter_27_1[1],
						id = iter_27_1[2]
					}
				end

				self:emit(BossRushPreCombatLayer.ON_DROP_LIST, {
					item2Row = true,
					itemList = var_27_1,
					content = var_27_0.display
				})
			else
				self:emit(BossRushPreCombatLayer.ON_DROP, var_23_3)
			end

			return
		end, SFX_PANEL)
	end

	return
end

function BossRushPreCombatLayer:SetFleets(arg_28_1)
	self._fleetVOs = {}
	self._legalFleetIdList = {}

	_.each(arg_28_1, function(arg_29_0)
		self._fleetVOs[arg_29_0.id] = arg_29_0

		table.insert(self._legalFleetIdList, arg_29_0.id)

		return
	end)

	return
end

function BossRushPreCombatLayer:SetCurrentFleet(arg_30_1)
	self._currentFleetVO = self._fleetVOs[arg_30_1]

	self._formationLogic:SetFleetVO(self._currentFleetVO)

	for iter_30_0, iter_30_1 in ipairs(self._legalFleetIdList) do
		if self._currentFleetVO.id == iter_30_1 then
			self._curFleetIndex = iter_30_0

			break
		end
	end

	return
end

function BossRushPreCombatLayer:CheckLegalFleet()
	assert(false)

	return
end

function BossRushPreCombatLayer:UpdateFleetView(arg_32_1)
	self:displayFleetInfo()
	self:updateFleetBg()
	self._formationLogic:UpdateGridVisibility()
	self._formationLogic:ResetGrid(TeamType.Vanguard, false)
	self._formationLogic:ResetGrid(TeamType.Main, false)
	self._formationLogic:ResetGrid(TeamType.Submarine, false)
	self:resetFormationComponent()

	if arg_32_1 then
		self._formationLogic:LoadAllCharacter()
	else
		self._formationLogic:SetAllCharacterPos()
	end

	return
end

function BossRushPreCombatLayer:updateFleetBg()
	local var_33_0 = self._currentFleetVO:getFleetType()

	setActive(self._bgFleet, var_33_0 == FleetType.Normal)
	setActive(self._bgSub, var_33_0 == FleetType.Submarine)

	return
end

function BossRushPreCombatLayer:resetFormationComponent()
	SetActive(self._gridTFs.main[1]:Find("flag"), #self._currentFleetVO:getTeamByName(TeamType.Main) ~= 0)
	SetActive(self._gridTFs.submarine[1]:Find("flag"), #self._currentFleetVO:getTeamByName(TeamType.Submarine) ~= 0)

	return
end

function BossRushPreCombatLayer:uiStartAnimating()
	shiftPanel(self._middle, 0, nil, 0.3, 0, true, true)
	shiftPanel(self._right, 0, nil, 0.3, 0, true, true)

	return
end

function BossRushPreCombatLayer:uiExitAnimating()
	shiftPanel(self._middle, -840, nil, nil, nil, true, true)
	shiftPanel(self._right, 470, nil, nil, nil, true, true)

	return
end

function BossRushPreCombatLayer:didEnter()
	onButton(self, self._backBtn, function()
		GetOrAddComponent(self._tf, typeof(CanvasGroup)).interactable = false

		self:uiExitAnimating()
		LeanTween.delayedCall(0.3, System.Action(function()
			self:emit(BossRushPreCombatLayer.ON_CLOSE)

			return
		end))
		self:emit(BossRushPreCombatMediator.ON_UPDATE_CUSTOM_FLEET)

		return
	end, SFX_CANCEL)
	onButton(self, self._tf:Find("blur_panel/top/option"), function()
		self:quickExitFunc()
		self:emit(BossRushPreCombatMediator.ON_UPDATE_CUSTOM_FLEET)

		return
	end, SFX_PANEL)
	onButton(self, self._startBtn, function()
		self:emit(BossRushPreCombatMediator.ON_START)

		return
	end, SFX_UI_WEIGHANCHOR)
	onButton(self, self._nextPage, function()
		self:emit(BossRushPreCombatMediator.ON_CHANGE_FLEET, self._legalFleetIdList[self._curFleetIndex + 1])

		return
	end, SFX_PANEL)
	onButton(self, self._prevPage, function()
		self:emit(BossRushPreCombatMediator.ON_CHANGE_FLEET, self._legalFleetIdList[self._curFleetIndex - 1])

		return
	end, SFX_PANEL)
	self:UpdateFleetView(true)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	GetOrAddComponent(self._tf, typeof(CanvasGroup)).interactable = true

	setActive(self._autoToggle, true)
	onToggle(self, self._autoToggle, function(arg_44_0)
		self:emit(BossRushPreCombatMediator.ON_AUTO, {
			isOn = not arg_44_0,
			toggle = self._autoToggle
		})

		self.autoFlag = arg_44_0

		self:UpdateSubToggle()

		return
	end, SFX_PANEL, SFX_PANEL)
	onToggle(self, self._autoSubToggle, function(arg_45_0)
		self:emit(BossRushPreCombatMediator.ON_SUB_AUTO, {
			isOn = not arg_45_0,
			toggle = self._autoSubToggle
		})

		return
	end, SFX_PANEL, SFX_PANEL)
	triggerToggle(self._autoToggle, ys.Battle.BattleState.IsAutoBotActive())
	onNextTick(function()
		self:uiStartAnimating()

		return
	end)

	local var_37_0 = getProxy(ActivityProxy):getActivityById(self.contextData.actId)
	local var_37_1 = self.contextData.seriesData

	;(function()
		local var_47_0 = var_37_1:GetType() == BossRushSeriesData.TYPE.NORMAL

		setActive(self._continuousBtn, var_47_0)

		if not var_47_0 then
			return
		end

		local var_47_1 = var_37_0:getConfig("type") == ActivityConst.ACTIVITY_TYPE_BOSS_RUSH_DAL_COLLAB and var_37_0:HasPlayerDefeatSeries(var_37_1.id) or var_37_0:HasPassSeries(var_37_1.id)

		setActive(self._continuousBtn:Find("lock"), not var_47_1)

		local var_47_2

		if var_47_1 then
			var_47_2 = Color.white or Color.New(0.2980392156862745, 0.2980392156862745, 0.2980392156862745)
		end

		setImageColor(self._continuousBtn, var_47_2)
		setTextColor(self._continuousBtn:Find("text"), var_47_2)
		setTextColor(self._continuousBtn:Find("text_en"), var_47_2)
		onButton(self, self._continuousBtn, function()
			if var_47_1 then
				self:emit(BossRushPreCombatMediator.SHOW_CONTINUOUS_OPERATION_WINDOW, self._currentFleetVO.id)
			else
				pg.TipsMgr.GetInstance():ShowTips(i18n("multiple_sorties_locked_tip"))
			end

			return
		end, SFX_PANEL)

		return
	end)()

	local var_37_2 = self.contextData.seriesData:GetExpeditionIds()
	local var_37_3 = self.contextData.seriesData:GetBossIcons()
	local var_37_4 = self._tf:Find("adapt/middle/Boss")

	UIItemList.StaticAlign(var_37_4, var_37_4:GetChild(0), #var_37_2, function(arg_49_0, arg_49_1, arg_49_2)
		if arg_49_0 ~= UIItemList.EventUpdate then
			return
		end

		local var_49_1 = arg_49_2:Find("shiptpl")

		SetCompomentEnabled(findTF(var_49_1, "icon_bg"), "Image", false)
		SetCompomentEnabled(findTF(var_49_1, "icon_bg/frame"), "Image", false)
		setActive(arg_49_2:Find("shiptpl/icon_bg/lv"), false)
		GetImageSpriteFromAtlasAsync("SquareIcon/" .. var_37_3[arg_49_1 + 1][1], "", (arg_49_2:Find("shiptpl/icon_bg/icon")))

		local var_49_2 = findTF(var_49_1, "ship_type")

		if var_49_2 then
			setActive(var_49_2, true)
			setImageSprite(var_49_2, GetSpriteFromAtlas("shiptype", shipType2print(var_37_3[arg_49_1 + 1][2])))
		end

		return
	end)
	self:SetFleetStepper()
	self:SetStageIds(self.contextData.stageIds)

	return
end

function BossRushPreCombatLayer:UpdateSubToggle()
	if self.autoFlag and self._subUseable == true then
		setActive(self._autoSubToggle, true)
		triggerToggle(self._autoSubToggle, ys.Battle.BattleState.IsAutoSubActive())
	else
		setActive(self._autoSubToggle, false)
	end

	return
end

function BossRushPreCombatLayer:displayFleetInfo()
	local var_51_0 = self._currentFleetVO:getFleetType()

	setActive(self._vanguardGS.parent, var_51_0 == FleetType.Normal)
	setActive(self._mainGS.parent, var_51_0 == FleetType.Normal)

	local var_51_1 = math.floor(self._currentFleetVO:GetGearScoreSum(TeamType.Vanguard))
	local var_51_2 = math.floor(self._currentFleetVO:GetGearScoreSum(TeamType.Main))

	setActive(self._subGS.parent, var_51_0 == FleetType.Submarine)

	local var_51_3 = math.floor(self._currentFleetVO:GetGearScoreSum(TeamType.Submarine))
	local var_51_4 = self.contextData.system

	setActive(self._costContainer, self.contextData.system ~= SYSTEM_DUEL)
	FormationUI.tweenNumText(self._vanguardGS, var_51_1)
	FormationUI.tweenNumText(self._mainGS, var_51_2)
	FormationUI.tweenNumText(self._subGS, var_51_3)
	setText(self._fleetNameText, Fleet.DEFAULT_NAME[self._curFleetIndex])
	setText(self._fleetNumText, self._curFleetIndex)

	local var_51_5 = self.contextData.seriesData
	local var_51_6 = self.contextData.seriesData:GetExpeditionIds()
	local var_51_7 = self._tf:Find("adapt/middle/Boss")

	UIItemList.StaticAlign(var_51_7, var_51_7:GetChild(0), #var_51_6, function(arg_52_0, arg_52_1, arg_52_2)
		if arg_52_0 ~= UIItemList.EventUpdate then
			return
		end

		local var_52_0 = arg_52_1 + 1 == self._curFleetIndex or self._curFleetIndex > #var_51_6 or self.contextData.mode == BossRushSeriesData.MODE.SINGLE

		setActive(arg_52_2:Find("Select"), arg_52_1 + 1 == self._curFleetIndex or self._curFleetIndex > #var_51_6 or self.contextData.mode == BossRushSeriesData.MODE.SINGLE)
		setActive(arg_52_2:Find("Image"), var_52_0)

		return
	end)

	local var_51_9 = underscore.to_array(self.contextData.fleets)
	local var_51_10 = table.remove(var_51_9)
	local var_51_11 = false
	local var_51_12 = (function()
		local var_53_1 = var_51_5:GetOilLimit()
		local var_53_2 = pg.battle_cost_template[var_51_4].oil_cost > 0

		local function var_53_3(arg_54_0, arg_54_1)
			local var_54_0 = 0

			if var_53_2 then
				var_54_0 = arg_54_0:GetCostSum().oil

				if arg_54_1 > 0 then
					var_54_0 = math.min(arg_54_1, var_54_0)
					var_51_11 = var_51_11 and var_54_0 < arg_54_1
				end
			end

			return var_54_0
		end

		local var_53_4 = #var_51_5:GetExpeditionIds()
		local var_53_5 = var_53_3(var_51_10, var_53_1[2]) * var_53_4

		for iter_53_0 = 1, var_53_4 do
			var_53_5 = var_53_5 + var_53_3(var_51_9[iter_53_0] or var_51_9[1], var_53_1[1])
		end

		return var_53_5
	end)()
	local var_51_13 = 0

	FormationUI.tweenNumText(self._costText, var_51_12)
	setActive(self._costTip, false)

	return
end

function BossRushPreCombatLayer:SetFleetStepper()
	SetActive(self._nextPage, self._curFleetIndex < #self._legalFleetIdList)
	SetActive(self._prevPage, self._curFleetIndex > 1)

	return
end

function BossRushPreCombatLayer:onBackPressed()
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)
	triggerButton(self._backBtn)

	return
end

function BossRushPreCombatLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)
	self._formationLogic:Destroy()

	self._formationLogic = nil

	return
end

return BossRushPreCombatLayer

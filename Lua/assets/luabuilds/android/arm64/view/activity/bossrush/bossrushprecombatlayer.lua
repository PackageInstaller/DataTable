local var_0_0 = class("BossRushPreCombatLayer", import("view.base.BaseUI"))
local var_0_1 = import("view.ship.FormationUI")
local var_0_2 = {
	[99] = true
}

function var_0_0.getUIName(arg_1_0)
	return "BossRushPreCombatUI"
end

function var_0_0.ResUISettings(arg_2_0)
	return true
end

function var_0_0.tempCache(arg_3_0)
	return true
end

function var_0_0.init(arg_4_0)
	arg_4_0:CommonInit()

	arg_4_0._formationLogic = BaseFormation.New(arg_4_0._tf, arg_4_0._heroContainer, arg_4_0._heroInfo, arg_4_0._gridTFs)

	arg_4_0:Register()

	return
end

function var_0_0.CommonInit(arg_5_0)
	arg_5_0.eventTriggers = {}

	local var_5_0 = arg_5_0._tf:Find("adapt")

	arg_5_0._startBtn = var_5_0:Find("right/start")
	arg_5_0._costContainer = var_5_0:Find("right/start/cost_container")
	arg_5_0._popup = arg_5_0._costContainer:Find("popup")
	arg_5_0._costText = arg_5_0._popup:Find("Text")
	arg_5_0._moveLayer = var_5_0:Find("moveLayer")

	local var_5_1 = var_5_0:Find("middle")

	arg_5_0._autoToggle = var_5_0:Find("auto_toggle")
	arg_5_0._autoSubToggle = var_5_0:Find("sub_toggle_container/sub_toggle")
	arg_5_0._fleetInfo = var_5_1:Find("fleet_info")
	arg_5_0._fleetNameText = var_5_1:Find("fleet_info/fleet_name/Text")
	arg_5_0._fleetNumText = var_5_1:Find("fleet_info/fleet_number")

	setActive(arg_5_0._fleetInfo, arg_5_0.contextData.system ~= SYSTEM_DUEL)

	arg_5_0._mainGS = var_5_1:Find("gear_score/main/Text")
	arg_5_0._vanguardGS = var_5_1:Find("gear_score/vanguard/Text")
	arg_5_0._subGS = var_5_1:Find("gear_score/submarine/Text")
	arg_5_0._bgFleet = var_5_1:Find("mask/grid_bg")
	arg_5_0._bgSub = var_5_1:Find("mask/bg_sub")
	arg_5_0._gridTFs = {
		[TeamType.Vanguard] = {},
		[TeamType.Main] = {},
		[TeamType.Submarine] = {}
	}
	arg_5_0._gridFrame = var_5_1:Find("mask/GridFrame")

	for iter_5_0 = 1, 3 do
		arg_5_0._gridTFs[TeamType.Main][iter_5_0] = arg_5_0._gridFrame:Find("main_" .. iter_5_0)
		arg_5_0._gridTFs[TeamType.Vanguard][iter_5_0] = arg_5_0._gridFrame:Find("vanguard_" .. iter_5_0)
		arg_5_0._gridTFs[TeamType.Submarine][iter_5_0] = arg_5_0._gridFrame:Find("submarine_" .. iter_5_0)
	end

	arg_5_0._nextPage = var_5_0:Find("middle/nextPage")
	arg_5_0._prevPage = var_5_0:Find("middle/prevPage")
	arg_5_0._heroContainer = var_5_1:Find("HeroContainer")
	arg_5_0._checkBtn = var_5_1:Find("checkBtn")
	arg_5_0._blurPanel = arg_5_0._tf:Find("blur_panel")
	arg_5_0.topPanel = arg_5_0._blurPanel:Find("top")
	arg_5_0.topPanelBg = arg_5_0._blurPanel:Find("top_bg")
	arg_5_0._backBtn = arg_5_0.topPanel:Find("back_btn")
	arg_5_0._spoilsContainer = var_5_0:Find("right/infomation/atlasloot/spoils/items/items_container")
	arg_5_0._item = var_5_0:Find("right/infomation/atlasloot/spoils/items/item_tpl")

	SetActive(arg_5_0._item, false)

	arg_5_0._goals = var_5_0:Find("right/infomation/target/goal")
	arg_5_0._heroInfo = arg_5_0:getTpl("heroInfo")
	arg_5_0._starTpl = arg_5_0:getTpl("star_tpl")

	setText(findTF(var_5_0, "middle/gear_score/vanguard/line/Image/Text1"), i18n("pre_combat_vanguard"))
	setText(findTF(var_5_0, "middle/gear_score/main/line/Image/Text1"), i18n("pre_combat_main"))
	setText(findTF(var_5_0, "middle/gear_score/submarine/line/Image/text1"), i18n("pre_combat_submarine"))
	setText(arg_5_0._costContainer:Find("title"), i18n("pre_combat_consume"))
	setText(findTF(var_5_0, "right/infomation/target/title/GameObject"), i18n("pre_combat_targets"))
	setText(findTF(var_5_0, "right/infomation/atlasloot/atlasloot/title/GameObject"), i18n("pre_combat_atlasloot"))
	setText(arg_5_0._startBtn:Find("text"), i18n("pre_combat_start"))
	setText(arg_5_0._startBtn:Find("text_en"), i18n("pre_combat_start_en"))

	arg_5_0._middle = var_5_0:Find("middle")
	arg_5_0._right = var_5_0:Find("right")

	setAnchoredPosition(arg_5_0._middle, {
		x = -840
	})
	setAnchoredPosition(arg_5_0._right, {
		x = 470
	})

	arg_5_0.guideDesc = arg_5_0._middle:Find("guideDesc")
	arg_5_0._costTip = arg_5_0._startBtn:Find("cost_container/popup/tip")
	arg_5_0._continuousBtn = var_5_0:Find("right/multiple")

	setText(arg_5_0._continuousBtn:Find("text"), i18n("multiple_sorties_title"))
	setText(arg_5_0._continuousBtn:Find("text_en"), i18n("multiple_sorties_title_eng"))

	return
end

function var_0_0.Register(arg_6_0)
	arg_6_0._formationLogic:AddLoadComplete(function()
		return
	end)
	arg_6_0._formationLogic:AddHeroInfoModify(function(arg_8_0, arg_8_1)
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

		setActive(var_8_3, var_8_2 and arg_6_0.contextData.system ~= SYSTEM_DUEL)

		for iter_8_0 = 1, arg_8_1:getStar() do
			cloneTplTo(arg_6_0._starTpl, var_8_1)
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
	arg_6_0._formationLogic:AddLongPress(function(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
		arg_6_0:emit(BossRushPreCombatMediator.OPEN_SHIP_INFO, arg_9_1.id, arg_9_2)

		return
	end)
	arg_6_0._formationLogic:AddBeginDrag(function(arg_10_0)
		SetActive(findTF(arg_10_0, "info"), false)

		return
	end)
	arg_6_0._formationLogic:AddEndDrag(function(arg_11_0)
		SetActive(findTF(arg_11_0, "info"), true)

		return
	end)
	arg_6_0._formationLogic:AddClick(function(arg_12_0, arg_12_1, arg_12_2)
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_CLICK)
		arg_6_0:emit(BossRushPreCombatMediator.CHANGE_FLEET_SHIP, arg_12_0, arg_12_2, arg_12_1)

		return
	end)
	arg_6_0._formationLogic:AddShiftOnly(function(arg_13_0)
		arg_6_0:emit(BossRushPreCombatMediator.CHANGE_FLEET_SHIPS_ORDER, arg_13_0)

		return
	end)
	arg_6_0._formationLogic:AddRemoveShip(function(arg_14_0, arg_14_1)
		arg_6_0:emit(BossRushPreCombatMediator.REMOVE_SHIP, arg_14_0, arg_14_1)

		return
	end)
	arg_6_0._formationLogic:AddCheckRemove(function(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4)
		if not arg_15_3:canRemove(arg_15_2) then
			local var_15_0, var_15_1 = arg_15_3:getShipPos(arg_15_2)

			pg.TipsMgr.GetInstance():ShowTips(i18n("ship_formationUI_removeError_onlyShip", arg_15_2:getConfigTable().name, var_15_2, Fleet.C_TEAM_NAME[var_15_1]))
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
	arg_6_0._formationLogic:AddSwitchToDisplayMode(function()
		arg_6_0:SetFleetStepper()

		return
	end)
	arg_6_0._formationLogic:AddSwitchToShiftMode(function()
		arg_6_0:SetFleetStepper()

		return
	end)
	arg_6_0._formationLogic:AddSwitchToPreviewMode(function()
		arg_6_0:SetFleetStepper()

		return
	end)
	arg_6_0._formationLogic:AddGridTipClick(function(arg_19_0, arg_19_1)
		arg_6_0:emit(BossRushPreCombatMediator.CHANGE_FLEET_SHIP, nil, arg_6_0._currentFleetVO, arg_19_0)

		return
	end)

	return
end

function var_0_0.SetPlayerInfo(arg_20_0, arg_20_1)
	return
end

function var_0_0.SetSubFlag(arg_21_0, arg_21_1)
	arg_21_0._subUseable = arg_21_1 or false

	arg_21_0:UpdateSubToggle()

	return
end

function var_0_0.SetShips(arg_22_0, arg_22_1)
	arg_22_0._shipVOs = arg_22_1

	arg_22_0._formationLogic:SetShipVOs(arg_22_0._shipVOs)

	return
end

function var_0_0.SetStageIds(arg_23_0, arg_23_1)
	removeAllChildren(arg_23_0._spoilsContainer)

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

		local var_24_5 = {
			findTF(arg_23_0._goals, "goal_tpl"),
			findTF(arg_23_0._goals, "goal_sink"),
			findTF(arg_23_0._goals, "goal_time")
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

	for iter_23_0, iter_23_1 in ipairs({}) do
		if (function()
			for iter_26_0, iter_26_1 in ipairs(var_23_1) do
				if iter_23_1[1] == iter_26_1[1] and iter_23_1[2] == iter_26_1[2] then
					return false
				end
			end

			return true
		end)() then
			table.insert({}, iter_23_1)
		end
	end

	var_23_0 = {}

	for iter_23_2, iter_23_3 in ipairs({}) do
		local var_23_2 = cloneTplTo(arg_23_0._item, arg_23_0._spoilsContainer)

		updateDrop(var_23_2, {
			id = iter_23_3[2],
			type = iter_23_3[1]
		})
		onButton(arg_23_0, var_23_2, function()
			local var_27_0 = Item.getConfigData(iter_23_3[2])

			if var_27_0 and var_0_2[var_27_0.type] then
				for iter_27_0, iter_27_1 in ipairs(var_27_0.display_icon) do
					({})[#{} + 1] = {
						hideName = true,
						type = iter_27_1[1],
						id = iter_27_1[2]
					}
				end

				arg_23_0:emit(var_0_0.ON_DROP_LIST, {
					item2Row = true,
					itemList = {},
					content = var_27_0.display
				})
			else
				arg_23_0:emit(var_0_0.ON_DROP, var_0)
			end

			return
		end, SFX_PANEL)
	end

	return
end

function var_0_0.SetFleets(arg_28_0, arg_28_1)
	arg_28_0._fleetVOs = {}
	arg_28_0._legalFleetIdList = {}

	_.each(arg_28_1, function(arg_29_0)
		arg_28_0._fleetVOs[arg_29_0.id] = arg_29_0

		table.insert(arg_28_0._legalFleetIdList, arg_29_0.id)

		return
	end)

	return
end

function var_0_0.SetCurrentFleet(arg_30_0, arg_30_1)
	arg_30_0._currentFleetVO = arg_30_0._fleetVOs[arg_30_1]

	arg_30_0._formationLogic:SetFleetVO(arg_30_0._currentFleetVO)

	for iter_30_0, iter_30_1 in ipairs(arg_30_0._legalFleetIdList) do
		if arg_30_0._currentFleetVO.id == iter_30_1 then
			arg_30_0._curFleetIndex = iter_30_0

			break
		end
	end

	return
end

function var_0_0.CheckLegalFleet(arg_31_0)
	assert(false)

	return
end

function var_0_0.UpdateFleetView(arg_32_0, arg_32_1)
	arg_32_0:displayFleetInfo()
	arg_32_0:updateFleetBg()
	arg_32_0._formationLogic:UpdateGridVisibility()
	arg_32_0._formationLogic:ResetGrid(TeamType.Vanguard, false)
	arg_32_0._formationLogic:ResetGrid(TeamType.Main, false)
	arg_32_0._formationLogic:ResetGrid(TeamType.Submarine, false)
	arg_32_0:resetFormationComponent()

	if arg_32_1 then
		arg_32_0._formationLogic:LoadAllCharacter()
	else
		arg_32_0._formationLogic:SetAllCharacterPos()
	end

	return
end

function var_0_0.updateFleetBg(arg_33_0)
	local var_33_0 = arg_33_0._currentFleetVO:getFleetType()

	setActive(arg_33_0._bgFleet, var_33_0 == FleetType.Normal)
	setActive(arg_33_0._bgSub, var_33_0 == FleetType.Submarine)

	return
end

function var_0_0.resetFormationComponent(arg_34_0)
	SetActive(arg_34_0._gridTFs.main[1]:Find("flag"), #arg_34_0._currentFleetVO:getTeamByName(TeamType.Main) ~= 0)
	SetActive(arg_34_0._gridTFs.submarine[1]:Find("flag"), #arg_34_0._currentFleetVO:getTeamByName(TeamType.Submarine) ~= 0)

	return
end

function var_0_0.uiStartAnimating(arg_35_0)
	shiftPanel(arg_35_0._middle, 0, nil, 0.3, 0, true, true)
	shiftPanel(arg_35_0._right, 0, nil, 0.3, 0, true, true)

	return
end

function var_0_0.uiExitAnimating(arg_36_0)
	shiftPanel(arg_36_0._middle, -840, nil, nil, nil, true, true)
	shiftPanel(arg_36_0._right, 470, nil, nil, nil, true, true)

	return
end

function var_0_0.didEnter(arg_37_0)
	onButton(arg_37_0, arg_37_0._backBtn, function()
		GetOrAddComponent(arg_37_0._tf, typeof(CanvasGroup)).interactable = false

		arg_37_0:uiExitAnimating()
		LeanTween.delayedCall(0.3, System.Action(function()
			arg_37_0:emit(var_0_0.ON_CLOSE)

			return
		end))
		arg_37_0:emit(BossRushPreCombatMediator.ON_UPDATE_CUSTOM_FLEET)

		return
	end, SFX_CANCEL)
	onButton(arg_37_0, arg_37_0._tf:Find("blur_panel/top/option"), function()
		arg_37_0:quickExitFunc()
		arg_37_0:emit(BossRushPreCombatMediator.ON_UPDATE_CUSTOM_FLEET)

		return
	end, SFX_PANEL)
	onButton(arg_37_0, arg_37_0._startBtn, function()
		arg_37_0:emit(BossRushPreCombatMediator.ON_START)

		return
	end, SFX_UI_WEIGHANCHOR)
	onButton(arg_37_0, arg_37_0._nextPage, function()
		arg_37_0:emit(BossRushPreCombatMediator.ON_CHANGE_FLEET, arg_37_0._legalFleetIdList[arg_37_0._curFleetIndex + 1])

		return
	end, SFX_PANEL)
	onButton(arg_37_0, arg_37_0._prevPage, function()
		arg_37_0:emit(BossRushPreCombatMediator.ON_CHANGE_FLEET, arg_37_0._legalFleetIdList[arg_37_0._curFleetIndex - 1])

		return
	end, SFX_PANEL)
	arg_37_0:UpdateFleetView(true)
	pg.UIMgr.GetInstance():BlurPanel(arg_37_0._tf)

	GetOrAddComponent(arg_37_0._tf, typeof(CanvasGroup)).interactable = true

	setActive(arg_37_0._autoToggle, true)
	onToggle(arg_37_0, arg_37_0._autoToggle, function(arg_44_0)
		arg_37_0:emit(BossRushPreCombatMediator.ON_AUTO, {
			isOn = not arg_44_0,
			toggle = arg_37_0._autoToggle
		})

		arg_37_0.autoFlag = arg_44_0

		arg_37_0:UpdateSubToggle()

		return
	end, SFX_PANEL, SFX_PANEL)
	onToggle(arg_37_0, arg_37_0._autoSubToggle, function(arg_45_0)
		arg_37_0:emit(BossRushPreCombatMediator.ON_SUB_AUTO, {
			isOn = not arg_45_0,
			toggle = arg_37_0._autoSubToggle
		})

		return
	end, SFX_PANEL, SFX_PANEL)
	triggerToggle(arg_37_0._autoToggle, ys.Battle.BattleState.IsAutoBotActive())
	onNextTick(function()
		arg_37_0:uiStartAnimating()

		return
	end)

	local var_37_0 = getProxy(ActivityProxy):getActivityById(arg_37_0.contextData.actId)
	local var_37_1 = arg_37_0.contextData.seriesData

	;(function()
		local var_47_0 = var_37_1:GetType() == BossRushSeriesData.TYPE.NORMAL

		setActive(arg_37_0._continuousBtn, var_47_0)

		if not var_47_0 then
			return
		end

		local var_47_1 = var_37_0:getConfig("type") == ActivityConst.ACTIVITY_TYPE_BOSS_RUSH_DAL_COLLAB and var_37_0:HasPlayerDefeatSeries(var_37_1.id) or var_37_0:HasPassSeries(var_37_1.id)

		setActive(arg_37_0._continuousBtn:Find("lock"), not var_47_1)

		if var_47_1 then
			local var_47_2 = Color.white or Color.New(0.2980392156862745, 0.2980392156862745, 0.2980392156862745)

			setImageColor(arg_37_0._continuousBtn, var_47_2)
			setTextColor(arg_37_0._continuousBtn:Find("text"), var_47_2)
			setTextColor(arg_37_0._continuousBtn:Find("text_en"), var_47_2)
			onButton(arg_37_0, arg_37_0._continuousBtn, function()
				if var_47_1 then
					arg_37_0:emit(BossRushPreCombatMediator.SHOW_CONTINUOUS_OPERATION_WINDOW, arg_37_0._currentFleetVO.id)
				else
					pg.TipsMgr.GetInstance():ShowTips(i18n("multiple_sorties_locked_tip"))
				end

				return
			end, SFX_PANEL)

			return
		end
	end)()

	local var_37_2 = arg_37_0.contextData.seriesData:GetBossIcons()
	local var_37_3 = arg_37_0._tf:Find("adapt/middle/Boss")

	UIItemList.StaticAlign(var_37_3, var_37_3:GetChild(0), #arg_37_0.contextData.seriesData:GetExpeditionIds(), function(arg_49_0, arg_49_1, arg_49_2)
		if arg_49_0 ~= UIItemList.EventUpdate then
			return
		end

		local var_49_1 = arg_49_2:Find("shiptpl")

		SetCompomentEnabled(findTF(var_49_1, "icon_bg"), "Image", false)
		SetCompomentEnabled(findTF(var_49_1, "icon_bg/frame"), "Image", false)
		setActive(arg_49_2:Find("shiptpl/icon_bg/lv"), false)
		GetImageSpriteFromAtlasAsync("SquareIcon/" .. var_37_2[arg_49_1 + 1][1], "", (arg_49_2:Find("shiptpl/icon_bg/icon")))

		local var_49_2 = findTF(var_49_1, "ship_type")

		if var_49_2 then
			setActive(var_49_2, true)
			setImageSprite(var_49_2, GetSpriteFromAtlas("shiptype", shipType2print(var_37_2[arg_49_1 + 1][2])))
		end

		return
	end)
	arg_37_0:SetFleetStepper()
	arg_37_0:SetStageIds(arg_37_0.contextData.stageIds)

	return
end

function var_0_0.UpdateSubToggle(arg_50_0)
	if arg_50_0.autoFlag and arg_50_0._subUseable == true then
		setActive(arg_50_0._autoSubToggle, true)
		triggerToggle(arg_50_0._autoSubToggle, ys.Battle.BattleState.IsAutoSubActive())
	else
		setActive(arg_50_0._autoSubToggle, false)
	end

	return
end

function var_0_0.displayFleetInfo(arg_51_0)
	local var_51_0 = arg_51_0._currentFleetVO:getFleetType()

	setActive(arg_51_0._vanguardGS.parent, var_51_0 == FleetType.Normal)
	setActive(arg_51_0._mainGS.parent, var_51_0 == FleetType.Normal)

	local var_51_1 = math.floor(arg_51_0._currentFleetVO:GetGearScoreSum(TeamType.Vanguard))
	local var_51_2 = math.floor(arg_51_0._currentFleetVO:GetGearScoreSum(TeamType.Main))

	setActive(arg_51_0._subGS.parent, var_51_0 == FleetType.Submarine)

	local var_51_3 = math.floor(arg_51_0._currentFleetVO:GetGearScoreSum(TeamType.Submarine))

	setActive(arg_51_0._costContainer, arg_51_0.contextData.system ~= SYSTEM_DUEL)
	var_0_1.tweenNumText(arg_51_0._vanguardGS, var_51_1)
	var_0_1.tweenNumText(arg_51_0._mainGS, var_51_2)
	var_0_1.tweenNumText(arg_51_0._subGS, var_51_3)
	setText(arg_51_0._fleetNameText, Fleet.DEFAULT_NAME[arg_51_0._curFleetIndex])
	setText(arg_51_0._fleetNumText, arg_51_0._curFleetIndex)

	local var_51_4 = arg_51_0._tf:Find("adapt/middle/Boss")

	UIItemList.StaticAlign(var_51_4, var_51_4:GetChild(0), #arg_51_0.contextData.seriesData:GetExpeditionIds(), function(arg_52_0, arg_52_1, arg_52_2)
		if arg_52_0 ~= UIItemList.EventUpdate then
			return
		end

		local var_52_0 = arg_52_1 + 1 == arg_51_0._curFleetIndex or arg_51_0._curFleetIndex > #var_0 or arg_51_0.contextData.mode == BossRushSeriesData.MODE.SINGLE

		setActive(arg_52_2:Find("Select"), arg_52_1 + 1 == arg_51_0._curFleetIndex or arg_51_0._curFleetIndex > #var_0 or arg_51_0.contextData.mode == BossRushSeriesData.MODE.SINGLE)
		setActive(arg_52_2:Find("Image"), var_52_0)

		return
	end)

	local var_51_6 = table.remove((underscore.to_array(arg_51_0.contextData.fleets)))
	local var_51_7 = false
	local var_51_8 = (function()
		local var_53_1 = var_0:GetOilLimit()
		local var_53_2 = pg.battle_cost_template[var_0].oil_cost > 0
		local var_53_4 = #var_0:GetExpeditionIds()
		local var_53_5 = (function(arg_54_0, arg_54_1)
			local var_54_0 = 0

			if var_53_2 then
				var_54_0 = arg_54_0:GetCostSum().oil

				if arg_54_1 > 0 then
					var_54_0 = math.min(arg_54_1, var_54_0)
					var_51_7 = var_51_7 and var_54_0 < arg_54_1
				end
			end

			return var_54_0
		end)(var_51_6, var_53_1[2]) * var_53_4

		for iter_53_0 = 1, var_53_4 do
			local var_53_7 = var_0[iter_53_0] or var_0[1]

			var_53_5 = var_53_5 + var_53_3(var_53_7, var_53_1[1])
		end

		return var_53_5
	end)()
	local var_51_9 = 0

	if false then
		var_51_9 = (function()
			local var_55_1 = var_0:GetOilLimit()
			local var_55_2 = pg.battle_cost_template[var_0].oil_cost > 0
			local var_55_4 = #var_0:GetExpeditionIds()
			local var_55_5 = (function(arg_56_0, arg_56_1)
				local var_56_0 = 0

				if var_55_2 then
					var_56_0 = arg_56_0:GetCostSum().oil
				end

				return var_56_0
			end)(var_51_6, var_55_1[2]) * var_55_4

			for iter_55_0 = 1, var_55_4 do
				local var_55_7 = var_0[iter_55_0] or var_0[1]

				var_55_5 = var_55_5 + var_55_3(var_55_7, var_55_1[1])
			end

			return var_55_5
		end)()
	end

	var_0_1.tweenNumText(arg_51_0._costText, ((function()
		local var_53_1 = var_0:GetOilLimit()
		local var_53_2 = pg.battle_cost_template[var_0].oil_cost > 0
		local var_53_4 = #var_0:GetExpeditionIds()
		local var_53_5 = (function(arg_54_0, arg_54_1)
			local var_54_0 = 0

			if var_53_2 then
				var_54_0 = arg_54_0:GetCostSum().oil

				if arg_54_1 > 0 then
					var_54_0 = math.min(arg_54_1, var_54_0)
					var_51_7 = var_51_7 and var_54_0 < arg_54_1
				end
			end

			return var_54_0
		end)(var_51_6, var_53_1[2]) * var_53_4

		for iter_53_0 = 1, var_53_4 do
			local var_53_7 = var_0[iter_53_0] or var_0[1]

			var_53_5 = var_53_5 + var_53_3(var_53_7, var_53_1[1])
		end

		return var_53_5
	end)()))
	setActive(arg_51_0._costTip, false)

	if false then
		onButton(arg_51_0, arg_51_0._costTip, function()
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				hideNo = true,
				content = i18n("use_oil_limit_help", var_51_9, var_51_8)
			})

			return
		end)
	end

	return
end

function var_0_0.SetFleetStepper(arg_58_0)
	SetActive(arg_58_0._nextPage, arg_58_0._curFleetIndex < #arg_58_0._legalFleetIdList)
	SetActive(arg_58_0._prevPage, arg_58_0._curFleetIndex > 1)

	return
end

function var_0_0.onBackPressed(arg_59_0)
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)
	triggerButton(arg_59_0._backBtn)

	return
end

function var_0_0.willExit(arg_60_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_60_0._tf)
	arg_60_0._formationLogic:Destroy()

	arg_60_0._formationLogic = nil

	return
end

return var_0_0

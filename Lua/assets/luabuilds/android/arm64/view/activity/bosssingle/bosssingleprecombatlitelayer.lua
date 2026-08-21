local var_0_0 = class("BossSinglePreCombatLiteLayer", import(".BossSinglePreCombatLayer"))
local var_0_1 = import("view.ship.FormationUI")
local var_0_2 = {
	[99] = true
}

function var_0_0.getUIName(arg_1_0)
	return "BossSinglePreCombatUI"
end

function var_0_0.ResUISettings(arg_2_0)
	return {
		anim = true,
		order = 5,
		showType = PlayerResUI.TYPE_ALL
	}
end

function var_0_0.init(arg_3_0)
	arg_3_0:CommonInit()

	arg_3_0._formationLogic = BaseFormation.New(arg_3_0._tf, arg_3_0._heroContainer, arg_3_0._heroInfo, arg_3_0._gridTFs)

	arg_3_0:Register()
	pg.UIMgr.GetInstance():BlurPanel(arg_3_0._tf)

	return
end

function var_0_0.CommonInit(arg_4_0)
	arg_4_0.eventTriggers = {}
	arg_4_0._startBtn = arg_4_0.rtAdapt:Find("right/start")
	arg_4_0._costContainer = arg_4_0.rtAdapt:Find("right/start/cost_container")
	arg_4_0._popup = arg_4_0._costContainer:Find("popup")
	arg_4_0._costText = arg_4_0._popup:Find("Text")
	arg_4_0._moveLayer = arg_4_0._tf:Find("moveLayer")

	local var_4_0 = arg_4_0.rtAdapt:Find("middle")

	arg_4_0._autoToggle = arg_4_0.rtAdapt:Find("auto_toggle")
	arg_4_0._autoSubToggle = arg_4_0.rtAdapt:Find("sub_toggle_container/sub_toggle")
	arg_4_0._fleetInfo = var_4_0:Find("fleet_info")
	arg_4_0._fleetNameText = var_4_0:Find("fleet_info/fleet_name/Text")
	arg_4_0._fleetNumText = var_4_0:Find("fleet_info/fleet_number")

	setActive(arg_4_0._fleetInfo, true)

	arg_4_0._mainGS = var_4_0:Find("gear_score/main/Text")
	arg_4_0._vanguardGS = var_4_0:Find("gear_score/vanguard/Text")
	arg_4_0._subGS = var_4_0:Find("gear_score/submarine/Text")
	arg_4_0._bgFleet = var_4_0:Find("mask/grid_bg")
	arg_4_0._bgSub = var_4_0:Find("mask/bg_sub")
	arg_4_0._gridTFs = {
		[TeamType.Vanguard] = {},
		[TeamType.Main] = {},
		[TeamType.Submarine] = {}
	}
	arg_4_0._gridFrame = var_4_0:Find("mask/GridFrame")

	for iter_4_0 = 1, 3 do
		arg_4_0._gridTFs[TeamType.Main][iter_4_0] = arg_4_0._gridFrame:Find("main_" .. iter_4_0)
		arg_4_0._gridTFs[TeamType.Vanguard][iter_4_0] = arg_4_0._gridFrame:Find("vanguard_" .. iter_4_0)
		arg_4_0._gridTFs[TeamType.Submarine][iter_4_0] = arg_4_0._gridFrame:Find("submarine_" .. iter_4_0)
	end

	arg_4_0._nextPage = arg_4_0.rtAdapt:Find("middle/nextPage")
	arg_4_0._prevPage = arg_4_0.rtAdapt:Find("middle/prevPage")
	arg_4_0._heroContainer = var_4_0:Find("HeroContainer")
	arg_4_0._checkBtn = var_4_0:Find("checkBtn")
	arg_4_0._blurPanel = arg_4_0._tf:Find("blur_panel")
	arg_4_0.topPanel = arg_4_0._blurPanel:Find("top")
	arg_4_0.topPanelBg = arg_4_0._blurPanel:Find("top_bg")
	arg_4_0._backBtn = arg_4_0.topPanel:Find("back_btn")
	arg_4_0._spoilsContainer = arg_4_0.rtAdapt:Find("right/infomation/atlasloot/spoils/items/items_container")
	arg_4_0._item = arg_4_0.rtAdapt:Find("right/infomation/atlasloot/spoils/items/item_tpl")

	SetActive(arg_4_0._item, false)

	arg_4_0._goals = arg_4_0.rtAdapt:Find("right/infomation/target/goal")
	arg_4_0._heroInfo = arg_4_0:getTpl("heroInfo")
	arg_4_0._starTpl = arg_4_0:getTpl("star_tpl")

	setText(findTF(arg_4_0.rtAdapt, "middle/gear_score/vanguard/line/Image/Text1"), i18n("pre_combat_vanguard"))
	setText(findTF(arg_4_0.rtAdapt, "middle/gear_score/main/line/Image/Text1"), i18n("pre_combat_main"))
	setText(findTF(arg_4_0.rtAdapt, "middle/gear_score/submarine/line/Image/text1"), i18n("pre_combat_submarine"))
	setText(arg_4_0._costContainer:Find("title"), i18n("pre_combat_consume"))
	setText(findTF(arg_4_0.rtAdapt, "right/infomation/target/title/GameObject"), i18n("pre_combat_targets"))
	setText(findTF(arg_4_0.rtAdapt, "right/infomation/atlasloot/atlasloot/title/GameObject"), i18n("pre_combat_atlasloot"))
	setText(arg_4_0._startBtn:Find("text"), i18n("pre_combat_start"))
	setText(arg_4_0._startBtn:Find("text_en"), i18n("pre_combat_start_en"))

	arg_4_0._middle = arg_4_0.rtAdapt:Find("middle")
	arg_4_0._right = arg_4_0.rtAdapt:Find("right")

	setAnchoredPosition(arg_4_0._middle, {
		x = -840
	})
	setAnchoredPosition(arg_4_0._right, {
		x = 470
	})

	arg_4_0.guideDesc = arg_4_0._middle:Find("guideDesc")

	if arg_4_0.contextData.stageId then
		arg_4_0:SetStageID(arg_4_0.contextData.stageId)
	end

	arg_4_0._costTip = arg_4_0._startBtn:Find("cost_container/popup/tip")
	arg_4_0._continuousBtn = arg_4_0.rtAdapt:Find("right/multiple")

	setText(arg_4_0._continuousBtn:Find("text"), i18n("multiple_sorties_title"))
	setText(arg_4_0._continuousBtn:Find("text_en"), i18n("multiple_sorties_title_eng"))
	setActive(arg_4_0._checkBtn, false)
	setActive(arg_4_0._continuousBtn, false)

	return
end

function var_0_0.Register(arg_5_0)
	arg_5_0._formationLogic:AddLoadComplete(function()
		if arg_5_0._currentForm ~= PreCombatLayer.FORM_EDIT then
			arg_5_0._formationLogic:SwitchToPreviewMode()
		end

		return
	end)
	arg_5_0._formationLogic:AddHeroInfoModify(function(arg_7_0, arg_7_1)
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

		local var_7_7 = pg.battle_cost_template[arg_5_0.contextData.system]

		setActive(var_7_3, var_7_2 and var_7_7.enter_energy_cost > 0)

		for iter_7_0 = 1, arg_7_1:getStar() do
			cloneTplTo(arg_5_0._starTpl, var_7_1)
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
	arg_5_0._formationLogic:AddLongPress(function(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
		arg_5_0:emit(BossSinglePreCombatMediator.OPEN_SHIP_INFO, arg_8_1.id, arg_8_2)

		return
	end)
	arg_5_0._formationLogic:AddBeginDrag(function(arg_9_0)
		SetActive(findTF(arg_9_0, "info"), false)

		return
	end)
	arg_5_0._formationLogic:AddEndDrag(function(arg_10_0)
		SetActive(findTF(arg_10_0, "info"), true)

		return
	end)
	arg_5_0._formationLogic:AddClick(function(arg_11_0, arg_11_1, arg_11_2)
		return
	end)
	arg_5_0._formationLogic:AddShiftOnly(function(arg_12_0)
		arg_5_0:emit(BossSinglePreCombatMediator.CHANGE_FLEET_SHIPS_ORDER, arg_12_0)

		return
	end)
	arg_5_0._formationLogic:AddRemoveShip(function(arg_13_0, arg_13_1)
		return
	end)
	arg_5_0._formationLogic:AddCheckRemove(function(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
		arg_14_0()

		return
	end)
	arg_5_0._formationLogic:AddSwitchToDisplayMode(function()
		arg_5_0._currentForm = PreCombatLayer.FORM_EDIT
		arg_5_0._checkBtn:GetComponent("Button").interactable = true

		arg_5_0:SetFleetStepper()
		setActive(arg_5_0._checkBtn:Find("save"), true)
		setActive(arg_5_0._checkBtn:Find("edit"), false)

		return
	end)
	arg_5_0._formationLogic:AddSwitchToShiftMode(function()
		arg_5_0:SetFleetStepper()

		arg_5_0._checkBtn:GetComponent("Button").interactable = false

		return
	end)
	arg_5_0._formationLogic:AddSwitchToPreviewMode(function()
		arg_5_0._currentForm = PreCombatLayer.FORM_PREVIEW
		arg_5_0._checkBtn:GetComponent("Button").interactable = true

		arg_5_0:SetFleetStepper()
		setActive(arg_5_0._checkBtn:Find("save"), false)
		setActive(arg_5_0._checkBtn:Find("edit"), true)

		return
	end)
	arg_5_0._formationLogic:AddGridTipClick(function(arg_18_0, arg_18_1)
		return
	end)
	arg_5_0._formationLogic:DisableTip()

	return
end

function var_0_0.SetPlayerInfo(arg_19_0, arg_19_1)
	return
end

function var_0_0.SetSubFlag(arg_20_0, arg_20_1)
	arg_20_0._subUseable = arg_20_1 or false

	return
end

function var_0_0.SetShips(arg_21_0, arg_21_1)
	arg_21_0._shipVOs = arg_21_1

	arg_21_0._formationLogic:SetShipVOs(arg_21_0._shipVOs)

	return
end

function var_0_0.SetStageID(arg_22_0, arg_22_1)
	removeAllChildren(arg_22_0._spoilsContainer)

	arg_22_0._stageID = arg_22_1

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

	if arg_22_0.contextData.system ~= SYSTEM_BOSS_EXPERIMENT then
		for iter_22_1, iter_22_2 in ipairs(var_22_0) do
			local var_22_4 = cloneTplTo(arg_22_0._item, arg_22_0._spoilsContainer)

			updateDrop(var_22_4, {
				id = iter_22_2[2],
				type = iter_22_2[1]
			})
			onButton(arg_22_0, var_22_4, function()
				local var_23_0 = Item.getConfigData(iter_22_2[2])

				if var_23_0 and var_0_2[var_23_0.type] then
					for iter_23_0, iter_23_1 in ipairs(var_23_0.display_icon) do
						({})[#{} + 1] = {
							hideName = true,
							type = iter_23_1[1],
							id = iter_23_1[2]
						}
					end

					arg_22_0:emit(var_0_0.ON_DROP_LIST, {
						item2Row = true,
						itemList = {},
						content = var_23_0.display
					})
				else
					arg_22_0:emit(var_0_0.ON_DROP, var_0)
				end

				return
			end, SFX_PANEL)
		end
	end

	local var_22_6 = {
		findTF(arg_22_0._goals, "goal_tpl"),
		findTF(arg_22_0._goals, "goal_sink"),
		findTF(arg_22_0._goals, "goal_time")
	}
	local var_22_7 = 1

	for iter_22_3, iter_22_4 in ipairs({
		pg.expedition_data_template[arg_22_1].objective_1,
		pg.expedition_data_template[arg_22_1].objective_2,
		pg.expedition_data_template[arg_22_1].objective_3
	}) do
		if type(iter_22_4) ~= "string" then
			var_22_5(iter_22_4, var_22_6[var_22_7])

			var_22_7 = var_22_7 + 1
		end
	end

	for iter_22_5 = var_22_7, #var_22_6 do
		var_22_5("", var_22_6[iter_22_5])
	end

	local var_22_8 = pg.expedition_data_template[arg_22_1].guide_desc and #pg.expedition_data_template[arg_22_1].guide_desc > 0

	setActive(arg_22_0.guideDesc, var_22_8)

	if var_22_8 then
		setText(arg_22_0.guideDesc, pg.expedition_data_template[arg_22_1].guide_desc)
	end

	return
end

function var_0_0.SetFleets(arg_25_0, arg_25_1)
	arg_25_0._fleetVOs = {}

	_.each(_.filter(_.values(arg_25_1), function(arg_26_0)
		return arg_26_0:getFleetType() == FleetType.Normal
	end), function(arg_27_0)
		arg_25_0._fleetVOs[arg_27_0.id] = arg_27_0

		return
	end)
	arg_25_0:CheckLegalFleet()

	return
end

function var_0_0.SetCurrentFleet(arg_28_0, arg_28_1)
	arg_28_0._currentFleetVO = arg_28_0._fleetVOs[arg_28_1]

	arg_28_0._formationLogic:SetFleetVO(arg_28_0._currentFleetVO)
	arg_28_0:CheckLegalFleet()

	for iter_28_0, iter_28_1 in ipairs(arg_28_0._legalFleetIdList) do
		if arg_28_0._currentFleetVO.id == iter_28_1 then
			arg_28_0._curFleetIndex = iter_28_0

			break
		end
	end

	return
end

function var_0_0.CheckLegalFleet(arg_29_0)
	arg_29_0._legalFleetIdList = {}

	for iter_29_0, iter_29_1 in pairs(arg_29_0._fleetVOs) do
		if #iter_29_1.ships > 0 and iter_29_1.id ~= FleetProxy.PVP_FLEET_ID then
			table.insert(arg_29_0._legalFleetIdList, iter_29_1.id)
		end
	end

	table.sort(arg_29_0._legalFleetIdList)

	return
end

function var_0_0.UpdateFleetView(arg_30_0, arg_30_1)
	arg_30_0:displayFleetInfo()
	arg_30_0:updateFleetBg()
	arg_30_0._formationLogic:UpdateGridVisibility()
	arg_30_0._formationLogic:ResetGrid(TeamType.Vanguard, arg_30_0._currentForm ~= PreCombatLayer.FORM_EDIT)
	arg_30_0._formationLogic:ResetGrid(TeamType.Main, arg_30_0._currentForm ~= PreCombatLayer.FORM_EDIT)
	arg_30_0._formationLogic:ResetGrid(TeamType.Submarine, arg_30_0._currentForm ~= PreCombatLayer.FORM_EDIT)
	arg_30_0:resetFormationComponent()

	if arg_30_1 then
		arg_30_0._formationLogic:LoadAllCharacter()
	else
		arg_30_0._formationLogic:SetAllCharacterPos()
	end

	return
end

function var_0_0.updateFleetBg(arg_31_0)
	local var_31_0 = arg_31_0._currentFleetVO:getFleetType()

	setActive(arg_31_0._bgFleet, var_31_0 == FleetType.Normal)
	setActive(arg_31_0._bgSub, var_31_0 == FleetType.Submarine)

	return
end

function var_0_0.resetFormationComponent(arg_32_0)
	SetActive(arg_32_0._gridTFs.main[1]:Find("flag"), #arg_32_0._currentFleetVO:getTeamByName(TeamType.Main) ~= 0)
	SetActive(arg_32_0._gridTFs.submarine[1]:Find("flag"), #arg_32_0._currentFleetVO:getTeamByName(TeamType.Submarine) ~= 0)

	return
end

function var_0_0.uiStartAnimating(arg_33_0)
	shiftPanel(arg_33_0._middle, 0, nil, 0.3, 0, true, true)
	shiftPanel(arg_33_0._right, 0, nil, 0.3, 0, true, true)

	return
end

function var_0_0.uiExitAnimating(arg_34_0)
	shiftPanel(arg_34_0._middle, -840, nil, nil, nil, true, true)
	shiftPanel(arg_34_0._right, 470, nil, nil, nil, true, true)

	return
end

function var_0_0.quickExitFunc(arg_35_0)
	if arg_35_0._currentForm == PreCombatLayer.FORM_EDIT then
		arg_35_0:emit(BossSinglePreCombatMediator.ON_ABORT_EDIT)
	end

	var_0_0.super.quickExitFunc(arg_35_0)

	return
end

function var_0_0.didEnter(arg_36_0)
	onButton(arg_36_0, arg_36_0._backBtn, function()
		if arg_36_0._currentForm == PreCombatLayer.FORM_EDIT then
			table.insert({}, function(arg_38_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					hideNo = false,
					zIndex = -100,
					content = i18n("battle_preCombatLayer_save_confirm"),
					onYes = function()
						arg_36_0:emit(BossSinglePreCombatMediator.ON_COMMIT_EDIT, function()
							pg.TipsMgr.GetInstance():ShowTips(i18n("battle_preCombatLayer_save_success"))
							arg_38_0()

							return
						end)

						return
					end,
					onNo = function()
						arg_36_0:emit(BossSinglePreCombatMediator.ON_ABORT_EDIT)
						arg_38_0()

						return
					end
				})

				return
			end)
		end

		seriesAsync({}, function()
			GetOrAddComponent(arg_36_0._tf, typeof(CanvasGroup)).interactable = false

			arg_36_0:uiExitAnimating()
			LeanTween.delayedCall(0.3, System.Action(function()
				arg_36_0:closeView()

				return
			end))

			return
		end)

		return
	end, SFX_CANCEL)
	onButton(arg_36_0, arg_36_0._startBtn, function()
		if arg_36_0._currentForm == PreCombatLayer.FORM_EDIT then
			table.insert({}, function(arg_45_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					hideNo = false,
					zIndex = -100,
					content = i18n("battle_preCombatLayer_save_march"),
					onYes = function()
						arg_36_0:emit(BossSinglePreCombatMediator.ON_COMMIT_EDIT, function()
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

		seriesAsync({}, function()
			arg_36_0:emit(BossSinglePreCombatMediator.ON_START, arg_36_0._currentFleetVO.id)

			return
		end)

		return
	end, SFX_UI_WEIGHANCHOR)
	onButton(arg_36_0, arg_36_0._checkBtn, function()
		if arg_36_0._currentForm == PreCombatLayer.FORM_EDIT then
			arg_36_0:emit(BossSinglePreCombatMediator.ON_COMMIT_EDIT, function()
				pg.TipsMgr.GetInstance():ShowTips(i18n("battle_preCombatLayer_save_success"))
				arg_36_0._formationLogic:SwitchToPreviewMode()

				return
			end)
		elseif arg_36_0._currentForm == PreCombatLayer.FORM_PREVIEW then
			arg_36_0._formationLogic:SwitchToDisplayMode()
		else
			assert("currentForm error")
		end

		return
	end, SFX_PANEL)

	arg_36_0._currentForm = arg_36_0.contextData.form
	arg_36_0.contextData.form = nil

	arg_36_0:UpdateFleetView(true)

	if arg_36_0._currentForm == PreCombatLayer.FORM_EDIT then
		arg_36_0._formationLogic:SwitchToDisplayMode()
	else
		arg_36_0._formationLogic:SwitchToPreviewMode()
	end

	setActive(arg_36_0._autoToggle, true)
	onToggle(arg_36_0, arg_36_0._autoToggle, function(arg_51_0)
		arg_36_0:emit(BossSinglePreCombatMediator.ON_AUTO, {
			isOn = not arg_51_0,
			toggle = arg_36_0._autoToggle
		})

		if arg_51_0 and arg_36_0._subUseable == true then
			setActive(arg_36_0._autoSubToggle, true)
			onToggle(arg_36_0, arg_36_0._autoSubToggle, function(arg_52_0)
				arg_36_0:emit(BossSinglePreCombatMediator.ON_SUB_AUTO, {
					isOn = not arg_52_0,
					toggle = arg_36_0._autoSubToggle
				})

				return
			end, SFX_PANEL, SFX_PANEL)
			triggerToggle(arg_36_0._autoSubToggle, ys.Battle.BattleState.IsAutoSubActive())
		else
			setActive(arg_36_0._autoSubToggle, false)
		end

		return
	end, SFX_PANEL, SFX_PANEL)
	triggerToggle(arg_36_0._autoToggle, ys.Battle.BattleState.IsAutoBotActive())
	onNextTick(function()
		arg_36_0:uiStartAnimating()

		return
	end)

	return
end

function var_0_0.displayFleetInfo(arg_54_0)
	local var_54_0 = arg_54_0._currentFleetVO:getFleetType()

	setActive(arg_54_0._vanguardGS.parent, var_54_0 == FleetType.Normal)
	setActive(arg_54_0._mainGS.parent, var_54_0 == FleetType.Normal)

	local var_54_1 = math.floor(arg_54_0._currentFleetVO:GetGearScoreSum(TeamType.Vanguard))
	local var_54_2 = math.floor(arg_54_0._currentFleetVO:GetGearScoreSum(TeamType.Main))

	setActive(arg_54_0._subGS.parent, var_54_0 == FleetType.Submarine)

	local var_54_3 = math.floor(arg_54_0._currentFleetVO:GetGearScoreSum(TeamType.Submarine))
	local var_54_4 = arg_54_0._currentFleetVO:GetCostSum()
	local var_54_5 = arg_54_0.contextData.system
	local var_54_6 = pg.battle_cost_template[arg_54_0.contextData.system].oil_cost == 0 and 0 or arg_54_0._currentFleetVO:GetCostSum().oil

	setActive(arg_54_0._costContainer, true)
	var_0_1.tweenNumText(arg_54_0._costText, var_54_6)
	var_0_1.tweenNumText(arg_54_0._vanguardGS, var_54_1)
	var_0_1.tweenNumText(arg_54_0._mainGS, var_54_2)
	var_0_1.tweenNumText(arg_54_0._subGS, var_54_3)
	setText(arg_54_0._fleetNameText, arg_54_0._currentFleetVO:GetName())
	setText(arg_54_0._fleetNumText, arg_54_0._currentFleetVO.id)

	if arg_54_0.contextData.costLimit then
		local var_54_8 = pg.battle_cost_template[var_54_5].oil_cost > 0
		local var_54_9 = 0
		local var_54_10 = false

		for iter_54_0, iter_54_1 in ipairs({
			arg_54_0.contextData.fleets[1]
		}) do
			local var_54_11 = iter_54_1:GetCostSum().oil

			if not var_54_8 then
				var_54_11 = 0
			end

			local var_54_13 = arg_54_0.contextData.costLimit[iter_54_0 == 1 and 1 or 2]

			if arg_54_0.contextData.costLimit[iter_54_0 == 1 and 1 or 2] > 0 then
				var_54_10 = var_54_10 or var_54_13 < var_54_11
				var_54_11 = math.min(var_54_11, var_54_13)
			end

			var_54_9 = var_54_9 + var_54_11
		end

		local var_54_14 = var_54_10 and Color(0.9803921568627451, 0.39215686274509803, 0.39215686274509803) or Color.white

		setTextColor(arg_54_0._costText, var_54_14)
		var_0_1.tweenNumText(arg_54_0._costText, var_54_9)
	end

	setActive(arg_54_0._costTip, isCostOver)

	if isCostOver then
		onButton(arg_54_0, arg_54_0._costTip, function()
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				hideNo = true,
				content = i18n("use_oil_limit_help", baseCost, var_54_4)
			})

			return
		end)
	end

	return
end

function var_0_0.SetFleetStepper(arg_56_0)
	SetActive(arg_56_0._nextPage, false)
	SetActive(arg_56_0._prevPage, false)

	return
end

function var_0_0.onBackPressed(arg_57_0)
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)
	triggerButton(arg_57_0._backBtn)

	return
end

function var_0_0.willExit(arg_58_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_58_0._tf)
	arg_58_0._formationLogic:Destroy()

	arg_58_0._formationLogic = nil

	return
end

return var_0_0

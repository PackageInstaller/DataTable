local var_0_0 = class("ChapterPreCombatLayer", import("..base.BaseUI"))
local var_0_1 = import("..ship.FormationUI")
local var_0_2 = {
	[99] = true
}

var_0_0.optionsPath = {
	"adapt/top/option"
}

function var_0_0.getUIName(arg_1_0)
	return "ChapterPreCombatUI"
end

function var_0_0.ResUISettings(arg_2_0)
	return true
end

function var_0_0.init(arg_3_0)
	arg_3_0._startBtn = arg_3_0.rtAdapt:Find("right/start")
	arg_3_0._popup = arg_3_0.rtAdapt:Find("right/popup")
	arg_3_0._costText = arg_3_0.rtAdapt:Find("right/popup/Text")
	arg_3_0._costTip = arg_3_0.rtAdapt:Find("right/popup/tip")
	arg_3_0._extraCostBuffIcon = arg_3_0.rtAdapt:Find("right/operation_buff_icon")
	arg_3_0._backBtn = arg_3_0.rtAdapt:Find("top/back_btn")
	arg_3_0._moveLayer = arg_3_0._tf:Find("moveLayer")

	local var_3_0 = arg_3_0.rtAdapt:Find("middle")

	arg_3_0._mainGS = var_3_0:Find("gear_score/main/Text")
	arg_3_0._vanguardGS = var_3_0:Find("gear_score/vanguard/Text")

	setText(arg_3_0._mainGS, 0)
	setText(arg_3_0._vanguardGS, 0)

	arg_3_0._gridTFs = {
		vanguard = {},
		main = {}
	}
	arg_3_0._gridFrame = var_3_0:Find("mask/GridFrame")

	for iter_3_0 = 1, 3 do
		arg_3_0._gridTFs[TeamType.Vanguard][iter_3_0] = arg_3_0._gridFrame:Find("vanguard_" .. iter_3_0)
		arg_3_0._gridTFs[TeamType.Main][iter_3_0] = arg_3_0._gridFrame:Find("main_" .. iter_3_0)
	end

	arg_3_0._heroContainer = var_3_0:Find("HeroContainer")
	arg_3_0._strategy = var_3_0:Find("strategy")

	setActive(arg_3_0._strategy, true)

	arg_3_0._spoilsContainer = arg_3_0.rtAdapt:Find("right/infomation/spoils/items/items_container")
	arg_3_0._goals = arg_3_0.rtAdapt:Find("right/infomation/goal")
	arg_3_0._item = arg_3_0:getTpl("right/infomation/spoils/items/item_tpl", arg_3_0.rtAdapt)
	arg_3_0._heroInfo = arg_3_0:getTpl("heroInfo")
	arg_3_0._starTpl = arg_3_0:getTpl("star_tpl")
	arg_3_0._middle = arg_3_0.rtAdapt:Find("middle")
	arg_3_0._right = arg_3_0.rtAdapt:Find("right")
	arg_3_0._formationLogic = BaseFormation.New(arg_3_0._tf, arg_3_0._heroContainer, arg_3_0._heroInfo, arg_3_0._gridTFs)

	setmetatable({
		Shift = function(arg_4_0, arg_4_1, arg_4_2)
			return
		end
	}, arg_3_0._formationLogic)
	setText(arg_3_0.rtAdapt:Find("middle/gear_score/vanguard/line/Image/Text1"), i18n("pre_combat_vanguard"))
	setText(arg_3_0.rtAdapt:Find("middle/gear_score/main/line/Image/Text1"), i18n("pre_combat_main"))

	arg_3_0._fleet = arg_3_0.rtAdapt:Find("middle/fleet")

	setText(arg_3_0._fleet:Find("title_bg/Text"), i18n("pre_combat_team"))

	arg_3_0._ship_tpl = arg_3_0._fleet:Find("shiptpl")
	arg_3_0._empty_tpl = arg_3_0._fleet:Find("emptytpl")

	setActive(arg_3_0._ship_tpl, false)
	setActive(arg_3_0._empty_tpl, false)

	arg_3_0._autoToggle = arg_3_0.rtAdapt:Find("middle/auto_toggle")
	arg_3_0._autoSubToggle = arg_3_0.rtAdapt:Find("middle/sub_toggle_container/sub_toggle")
	arg_3_0.topPanel = arg_3_0.rtAdapt:Find("top")
	arg_3_0.strategyInfo = arg_3_0._tf:Find("strategy_info")

	setActive(arg_3_0.strategyInfo, false)

	arg_3_0._operaionBuffTips = arg_3_0._extraCostBuffIcon:Find("popup")

	setAnchoredPosition(arg_3_0._middle, {
		x = -840
	})
	setAnchoredPosition(arg_3_0._right, {
		x = 470
	})
	arg_3_0:Register()

	return
end

function var_0_0.uiStartAnimating(arg_5_0)
	setAnchoredPosition(arg_5_0.topPanel, {
		y = 100
	})
	shiftPanel(arg_5_0._middle, 0, nil, 0.3, 0, true, true)
	shiftPanel(arg_5_0._right, 0, nil, 0.3, 0, true, true, nil)
	shiftPanel(arg_5_0.topPanel, nil, 0, 0.3, 0, true, true, nil, nil)

	return
end

function var_0_0.uiExitAnimating(arg_6_0)
	shiftPanel(arg_6_0._middle, -840, nil, 0.3, 0, true, true)
	shiftPanel(arg_6_0._right, 470, nil, 0.3, 0, true, true)
	shiftPanel(arg_6_0.topPanel, nil, arg_6_0.topPanel.rect.height, 0.3, 0, true, true, nil, nil)

	return
end

function var_0_0.didEnter(arg_7_0)
	onButton(arg_7_0, arg_7_0._backBtn, function()
		GetOrAddComponent(arg_7_0._tf, typeof(CanvasGroup)).interactable = false

		arg_7_0:uiExitAnimating()
		LeanTween.delayedCall(0.3, System.Action(function()
			arg_7_0:emit(var_0_0.ON_CLOSE)

			return
		end))

		return
	end, SFX_CANCEL)
	onButton(arg_7_0, arg_7_0._startBtn, function()
		arg_7_0:emit(ChapterPreCombatMediator.ON_START)

		return
	end, SFX_UI_WEIGHANCHOR)
	onToggle(arg_7_0, arg_7_0._autoToggle, function(arg_11_0)
		arg_7_0:emit(ChapterPreCombatMediator.ON_AUTO, {
			isOn = not arg_11_0,
			toggle = arg_7_0._autoToggle
		})

		if arg_11_0 and arg_7_0.subUseable == true then
			setActive(arg_7_0._autoSubToggle, true)
			onToggle(arg_7_0, arg_7_0._autoSubToggle, function(arg_12_0)
				arg_7_0:emit(ChapterPreCombatMediator.ON_SUB_AUTO, {
					isOn = not arg_12_0,
					toggle = arg_7_0._autoSubToggle
				})

				return
			end, SFX_PANEL, SFX_PANEL)
			triggerToggle(arg_7_0._autoSubToggle, ys.Battle.BattleState.IsAutoSubActive())
		else
			setActive(arg_7_0._autoSubToggle, false)
		end

		return
	end, SFX_PANEL, SFX_PANEL)
	pg.UIMgr.GetInstance():OverlayPanel(arg_7_0._tf)
	onNextTick(function()
		if arg_7_0.exited then
			return
		end

		triggerToggle(arg_7_0._autoToggle, ys.Battle.BattleState.IsAutoBotActive())

		return
	end)
	setAnchoredPosition(arg_7_0.topPanel, {
		y = arg_7_0.topPanel.rect.height
	})
	onNextTick(function()
		arg_7_0:uiStartAnimating()

		return
	end)
	onButton(arg_7_0, arg_7_0.rtAdapt:Find("middle/gear_score/vanguard/SonarTip"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.fleet_antisub_range_tip.tip
		})

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0._costTip, function()
		local var_16_0, var_16_1, var_16_2 = arg_7_0.chapter:isOverFleetCost(arg_7_0.chapter.fleet, (arg_7_0.chapter:getStageId(arg_7_0.chapter.fleet.line.row, arg_7_0.chapter.fleet.line.column)))

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			hideNo = true,
			content = i18n("use_oil_limit_help", var_16_2, var_16_1)
		})

		return
	end)

	return
end

function var_0_0.Register(arg_17_0)
	arg_17_0._formationLogic:AddHeroInfoModify(function(arg_18_0, arg_18_1, arg_18_2)
		local var_18_9000

		setAnchoredPosition(arg_18_0, {
			x = 0,
			y = 0
		})
		SetActive(arg_18_0, true)

		arg_18_0.name = "info"

		local var_18_0 = arg_18_0:Find("info")
		local var_18_1 = var_18_0:Find("stars")
		local var_18_2 = arg_18_1:getEnergy() <= Ship.ENERGY_MID
		local var_18_3 = var_18_0:Find("energy")

		if var_18_2 then
			local var_18_4, var_18_5 = arg_18_1:getEnergyPrint()
			local var_18_6 = GetSpriteFromAtlas("energy", var_18_4)

			if not var_18_6 then
				warning("找不到疲劳")
			end

			setImageSprite(var_18_3, var_18_6)
		end

		setActive(var_18_3, var_18_2)

		for iter_18_0 = 1, arg_18_1:getStar() do
			cloneTplTo(arg_17_0._starTpl, var_18_1)
		end

		local var_18_7 = GetSpriteFromAtlas("shiptype", shipType2print(arg_18_1:getShipType()))

		if not var_18_7 then
			warning("找不到船形, shipConfigId: " .. arg_18_1.configId)
		end

		setImageSprite(var_18_0:Find("type"), var_18_7, true)
		setText(var_18_0:Find("frame/lv_contain/lv"), arg_18_1.level)

		local var_18_8 = var_18_0:Find("blood")
		local var_18_9 = var_18_8:Find("fillarea/green")
		local var_18_10 = var_18_8:Find("fillarea/red")

		setActive(var_18_9, arg_18_1.hpRant >= ChapterConst.HpGreen)
		setActive(var_18_10, arg_18_1.hpRant < ChapterConst.HpGreen)

		;(arg_18_1.hpRant >= ChapterConst.HpGreen and var_18_9 or var_18_10):GetComponent("Image").fillAmount = arg_18_1.hpRant * 0.0001

		arg_18_2:SetVisible(arg_18_1.hpRant > 0)
		SetActive(arg_18_0, arg_18_1.hpRant > 0)

		local var_18_11 = getProxy(ActivityProxy)
		local var_18_12 = var_18_11.getBuffShipList(var_18_9000)[arg_18_1:getGroupId()]
		local var_18_13 = var_18_0:Find("expbuff")

		setActive(var_18_11, var_18_12 ~= nil)

		if var_18_12 then
			local var_18_14 = tostring(var_18_12 / 100)

			if var_18_12 % 100 > 0 then
				var_18_14 = var_18_14 .. "." .. tostring(var_18_12 % 100)
			end

			setText(var_18_13:Find("text"), string.format("EXP +%s%%", var_18_14))
		end

		return
	end)
	arg_17_0._formationLogic:AddShiftOnly(function(arg_19_0)
		arg_17_0:updateView(false)

		return
	end)
	arg_17_0._formationLogic:AddEndDrag(function()
		arg_17_0:emit(ChapterPreCombatMediator.ON_SWITCH_SHIP, arg_17_0.chapter.fleet)

		return
	end)
	arg_17_0._formationLogic:AddCheckRemove(function(arg_21_0, arg_21_1)
		arg_21_0()

		return
	end)
	arg_17_0._formationLogic:AddCheckSwitch(function(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4)
		if arg_22_3.ships[arg_22_3:getTeamByName(arg_22_4)[arg_22_2]].hpRant == 0 then
			return
		end

		arg_22_0()

		return
	end)
	arg_17_0._formationLogic:AddCheckBeginDrag(function(arg_23_0, arg_23_1, arg_23_2)
		return arg_23_0.hpRant > 0
	end)

	return
end

function var_0_0.setPlayerInfo(arg_24_0, arg_24_1)
	return
end

function var_0_0.updateChapter(arg_25_0, arg_25_1)
	arg_25_0.chapter = arg_25_1

	arg_25_0._formationLogic:SetFleetVO(arg_25_0.chapter.fleet)
	arg_25_0._formationLogic:SetShipVOs(arg_25_0.chapter.fleet.ships)
	arg_25_0:updateView(true)

	return
end

function var_0_0.setSubFlag(arg_26_0, arg_26_1)
	arg_26_0.subUseable = arg_26_1 or false

	return
end

function var_0_0.updateView(arg_27_0, arg_27_1)
	arg_27_0._formationLogic:ResetGrid(TeamType.Vanguard, true)
	arg_27_0._formationLogic:ResetGrid(TeamType.Main, true)
	SetActive(arg_27_0._gridTFs[TeamType.Main][1]:Find("flag"), true)

	if arg_27_1 then
		arg_27_0:updateStageView((arg_27_0.chapter:getStageId(arg_27_0.chapter.fleet.line.row, arg_27_0.chapter.fleet.line.column)))
		arg_27_0._formationLogic:LoadAllCharacter()
	else
		arg_27_0._formationLogic:SetAllCharacterPos()
	end

	arg_27_0:updateBattleFleetView()
	arg_27_0:updateStrategyIcon()
	arg_27_0:displayFleetInfo()

	return
end

function var_0_0.updateStageView(arg_28_0, arg_28_1)
	assert(pg.expedition_data_template[arg_28_1], "expedition_data_template not exist: " .. arg_28_1)

	local var_28_3 = Clone(pg.expedition_data_template[arg_28_1].award_display)
	local var_28_4 = checkExist(pg.expedition_activity_template[arg_28_1], {
		"pt_drop_display"
	})

	if var_28_4 and type(var_28_4) == "table" then
		local var_28_5 = getProxy(ActivityProxy)

		for iter_28_0 = #var_28_4, 1, -1 do
			local var_28_6 = var_28_5:getActivityById(var_28_4[iter_28_0][1])

			if var_28_6 and not var_28_6:isEnd() then
				table.insert(var_28_3, 1, {
					2,
					id2ItemId(var_28_4[iter_28_0][2])
				})
			end
		end
	end

	local var_28_7 = UIItemList.New(arg_28_0._spoilsContainer, arg_28_0._item)

	var_28_7:make(function(arg_29_0, arg_29_1, arg_29_2)
		updateDrop(arg_29_2, {
			type = var_28_3[arg_29_1 + 1][1],
			id = var_28_3[arg_29_1 + 1][2]
		})
		onButton(arg_28_0, arg_29_2, function()
			local var_30_0 = Item.getConfigData(var_0[2])

			if var_30_0 and var_0_2[var_30_0.type] then
				arg_28_0:emit(ChapterPreCombatMediator.GET_CHAPTER_DROP_SHIP_LIST, arg_28_0.chapter.id, function(arg_31_0)
					local var_31_0 = {}

					for iter_31_0, iter_31_1 in ipairs(var_30_0.display_icon) do
						local var_31_1 = iter_31_1[2]

						var_31_0[#var_31_0 + 1] = {
							type = iter_31_1[1],
							id = iter_31_1[2],
							anonymous = iter_31_1[1] == DROP_TYPE_SHIP and not table.contains(arg_31_0, var_31_1)
						}
					end

					arg_28_0:emit(var_0_0.ON_DROP_LIST, {
						item2Row = true,
						itemList = var_31_0,
						content = var_30_0.display
					})

					return
				end)
			else
				arg_28_0:emit(var_0_0.ON_DROP, var_0)
			end

			return
		end, SFX_PANEL)

		return
	end)
	var_28_7:align(math.min(#var_28_3, 6))

	local var_28_8 = {
		arg_28_0._goals:Find("goal_tpl"),
		arg_28_0._goals:Find("goal_sink"),
		arg_28_0._goals:Find("goal_time")
	}
	local var_28_9 = 1

	for iter_28_1, iter_28_2 in ipairs({
		pg.expedition_data_template[arg_28_1].objective_1,
		pg.expedition_data_template[arg_28_1].objective_2,
		pg.expedition_data_template[arg_28_1].objective_3
	}) do
		if type(iter_28_2) ~= "string" then
			(function(arg_32_0, arg_32_1)
				if type(arg_32_0) == "table" then
					setActive(arg_32_1, true)
					setWidgetText(arg_32_1, (i18n(PreCombatLayer.ObjectiveList[arg_32_0[1]], arg_32_0[2])))
				else
					setActive(arg_32_1, false)
				end

				return
			end)(iter_28_2, var_28_8[var_28_9])

			var_28_9 = var_28_9 + 1
		end
	end

	for iter_28_3 = var_28_9, #var_28_8 do
		(function(arg_32_0, arg_32_1)
			if type(arg_32_0) == "table" then
				setActive(arg_32_1, true)
				setWidgetText(arg_32_1, (i18n(PreCombatLayer.ObjectiveList[arg_32_0[1]], arg_32_0[2])))
			else
				setActive(arg_32_1, false)
			end

			return
		end)("", var_28_8[iter_28_3])
	end

	return
end

function var_0_0.updateBattleFleetView(arg_33_0)
	(function(arg_34_0, arg_34_1)
		removeAllChildren(arg_34_0)

		for iter_34_0 = 1, 3 do
			if arg_34_1[iter_34_0] then
				local var_34_0 = cloneTplTo(arg_33_0._ship_tpl, arg_34_0)

				updateShip(var_34_0, arg_34_1[iter_34_0])

				local var_34_1 = arg_34_1[iter_34_0].hpRant
				local var_34_2 = var_34_0:Find("blood")
				local var_34_3 = var_34_0:Find("blood/fillarea/green")
				local var_34_4 = var_34_0:Find("blood/fillarea/red")

				setActive(var_34_3, arg_34_1[iter_34_0].hpRant >= ChapterConst.HpGreen)
				setActive(var_34_4, var_34_1 < ChapterConst.HpGreen)

				;(var_34_1 >= ChapterConst.HpGreen and var_34_3 or var_34_4):GetComponent("Image").fillAmount = var_34_1 * 0.0001

				setActive(var_34_0:Find("broken"), var_34_1 == 0)
			end
		end

		return
	end)(arg_33_0._fleet:Find("main"), arg_33_0.chapter.fleet:getShipsByTeam(TeamType.Main, true))
	;(function(arg_34_0, arg_34_1)
		removeAllChildren(arg_34_0)

		for iter_34_0 = 1, 3 do
			if arg_34_1[iter_34_0] then
				local var_34_0 = cloneTplTo(arg_33_0._ship_tpl, arg_34_0)

				updateShip(var_34_0, arg_34_1[iter_34_0])

				local var_34_1 = arg_34_1[iter_34_0].hpRant
				local var_34_2 = var_34_0:Find("blood")
				local var_34_3 = var_34_0:Find("blood/fillarea/green")
				local var_34_4 = var_34_0:Find("blood/fillarea/red")

				setActive(var_34_3, arg_34_1[iter_34_0].hpRant >= ChapterConst.HpGreen)
				setActive(var_34_4, var_34_1 < ChapterConst.HpGreen)

				;(var_34_1 >= ChapterConst.HpGreen and var_34_3 or var_34_4):GetComponent("Image").fillAmount = var_34_1 * 0.0001

				setActive(var_34_0:Find("broken"), var_34_1 == 0)
			end
		end

		return
	end)(arg_33_0._fleet:Find("vanguard"), arg_33_0.chapter.fleet:getShipsByTeam(TeamType.Vanguard, true))

	return
end

function var_0_0.displayFleetInfo(arg_35_0)
	local var_35_0 = arg_35_0.chapter.fleet
	local var_35_1 = arg_35_0.chapter:getStageId(arg_35_0.chapter.fleet.line.row, arg_35_0.chapter.fleet.line.column)
	local var_35_2 = arg_35_0.chapter.fleet:getCommanders()
	local var_35_3 = _.reduce(arg_35_0.chapter.fleet:getShipsByTeam(TeamType.Vanguard, false), 0, function(arg_36_0, arg_36_1)
		return arg_36_0 + arg_36_1:getShipCombatPower(var_35_2)
	end)
	local var_35_4 = _.reduce(arg_35_0.chapter.fleet:getShipsByTeam(TeamType.Main, false), 0, function(arg_37_0, arg_37_1)
		return arg_37_0 + arg_37_1:getShipCombatPower(var_35_2)
	end)
	local var_35_5 = 0

	for iter_35_0, iter_35_1 in ipairs({
		arg_35_0.chapter:getFleetCost(arg_35_0.chapter.fleet, var_35_1)
	}) do
		var_35_5 = var_35_5 + iter_35_1.oil
	end

	local var_35_6 = arg_35_0.chapter:isOverFleetCost(var_35_0, var_35_1)

	setActive(arg_35_0._popup, true)
	setActive(arg_35_0._costTip, var_35_6)

	local var_35_7 = var_35_6 and Color(0.9803921568627451, 0.39215686274509803, 0.39215686274509803) or Color.white

	setTextColor(arg_35_0._costText, var_35_7)
	var_0_1.tweenNumText(arg_35_0._costText, var_35_5)
	var_0_1.tweenNumText(arg_35_0._vanguardGS, var_35_3)
	var_0_1.tweenNumText(arg_35_0._mainGS, var_35_4)

	local var_35_8, var_35_9 = arg_35_0.chapter:GetExtraCostRate()

	setActive(arg_35_0._extraCostBuffIcon, #var_35_9 > 0)

	for iter_35_2, iter_35_3 in ipairs(var_35_9) do
		if iter_35_3.benefit_type == Chapter.OPERATION_BUFF_TYPE_COST then
			setText(arg_35_0._extraCostBuffIcon:Find("text_cost"), tonumber(iter_35_3.benefit_effect) * 0.01 + 1)
		elseif iter_35_3.benefit_type == Chapter.OPERATION_BUFF_TYPE_EXP then
			setText(arg_35_0._extraCostBuffIcon:Find("text_reward"), tonumber(iter_35_3.benefit_effect) * 0.01 + 1)
		elseif iter_35_3.benefit_type == Chapter.OPERATION_BUFF_TYPE_DESC then
			onButton(arg_35_0, arg_35_0._extraCostBuffIcon, function()
				local var_38_0 = ActivityBuff.GetBenefitCondition(iter_35_3.benefit_condition)

				assert(var_38_0[1] == "item")
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					hideNo = true,
					type = MSGBOX_TYPE_SINGLE_ITEM,
					drop = {
						count = 1,
						type = DROP_TYPE_ITEM,
						id = var_38_0[2]
					},
					intro = pg.strategy_data_template[iter_35_3.id].desc
				})

				return
			end)
		end
	end

	local var_35_10 = arg_35_0.rtAdapt:Find("middle/gear_score/vanguard")
	local var_35_11 = ChapterFleet.StaticTransformChapterFleet2Fleet(var_35_0):GetFleetSonarRange()

	setActive(var_35_10:Find("SonarActive"), var_35_11 > 0)
	setActive(var_35_10:Find("SonarInactive"), var_35_11 <= 0)

	if var_35_11 > 0 then
		setText(var_35_10:Find("SonarActive/Text"), math.floor(var_35_11))
	end

	return
end

function var_0_0.updateStrategyIcon(arg_39_0)
	local var_39_0 = _.detect(arg_39_0.chapter.fleet:getStrategies(), function(arg_40_0)
		return arg_40_0.id == ChapterConst.StrategyRepair
	end)

	GetImageSpriteFromAtlasAsync("strategyicon/" .. pg.strategy_data_template[var_39_0.id].icon, "", arg_39_0._strategy:Find("icon"))
	onButton(arg_39_0, arg_39_0._strategy, function()
		arg_39_0:displayStrategyInfo(var_39_0)

		return
	end, SFX_PANEL)
	setText(arg_39_0._strategy:Find("nums"), var_39_0.count)
	setActive(arg_39_0._strategy:Find("mask"), var_39_0.count == 0)
	setActive(arg_39_0._strategy:Find("selected"), false)

	local var_39_1 = arg_39_0.rtAdapt:Find("middle/formation_list")
	local var_39_2 = var_39_1:Find("formation")

	setActive(var_39_2, false)

	local var_39_3 = ChapterConst.StrategyForms
	local var_39_4 = {}

	table.insert({}, 1, {
		id = arg_39_0.chapter.fleet:getFormationStg()
	})

	local var_39_5 = UIItemList.New(var_39_1, var_39_2)

	var_39_5:make(function(arg_42_0, arg_42_1, arg_42_2)
		if arg_42_0 == UIItemList.EventUpdate then
			local var_42_0 = pg.strategy_data_template[var_39_4[arg_42_1 + 1].id]

			if pg.strategy_data_template[var_39_4[arg_42_1 + 1].id].type ~= ChapterConst.StgTypeForm then
				return
			end

			GetImageSpriteFromAtlasAsync("strategyicon/" .. pg.strategy_data_template[var_39_4[arg_42_1 + 1].id].icon, "", arg_42_2:Find("icon"))
			onButton(arg_39_0, arg_42_2, function()
				if var_42_0.type == ChapterConst.StgTypeForm then
					arg_39_0:emit(ChapterPreCombatMediator.ON_OP, {
						type = ChapterConst.OpStrategy,
						id = arg_39_0.chapter.fleet:getNextStgUser(var_0.id),
						arg1 = var_39_3[table.indexof(var_39_3, var_0.id) % #var_39_3 + 1]
					})
				end

				return
			end, SFX_PANEL)
			setText(arg_42_2:Find("nums"), "")
			setActive(arg_42_2:Find("mask"), false)
			setActive(arg_42_2:Find("selected"), false)
		end

		return
	end)
	var_39_5:align(#{})

	return
end

function var_0_0.displayStrategyInfo(arg_44_0, arg_44_1)
	arg_44_0.strategyPanel = arg_44_0.strategyPanel or StrategyPanel.New(arg_44_0.strategyInfo)

	arg_44_0.strategyPanel:attach(arg_44_0)
	arg_44_0.strategyPanel:set(arg_44_1)
	pg.UIMgr.GetInstance():BlurPanel(arg_44_0.strategyPanel._tf)

	function arg_44_0.strategyPanel.onConfirm()
		if not arg_44_0.chapter.fleet:canUseStrategy(arg_44_1) then
			return
		end

		;({
			type = ChapterConst.OpStrategy
		}).id = arg_44_0.chapter.fleet:getNextStgUser(arg_44_1.id)
		;({
			type = ChapterConst.OpStrategy
		}).arg1 = arg_44_1.id

		arg_44_0:emit(ChapterPreCombatMediator.ON_OP, {
			type = ChapterConst.OpStrategy
		})
		arg_44_0:hideStrategyInfo()

		return
	end

	function arg_44_0.strategyPanel.onCancel()
		arg_44_0:hideStrategyInfo()

		return
	end

	return
end

function var_0_0.hideStrategyInfo(arg_47_0)
	if arg_47_0.strategyPanel then
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_47_0.strategyPanel._tf)
		arg_47_0.strategyPanel:detach()
	end

	return
end

function var_0_0.onBackPressed(arg_48_0)
	if arg_48_0.strategyPanel and arg_48_0.strategyPanel._go and isActive(arg_48_0.strategyPanel._go) then
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)
		arg_48_0:hideStrategyInfo()
	else
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)
		triggerButton(arg_48_0._backBtn)
	end

	return
end

function var_0_0.willExit(arg_49_0)
	if arg_49_0.strategyPanel and arg_49_0.strategyPanel._go and isActive(arg_49_0.strategyPanel._go) then
		arg_49_0:hideStrategyInfo()
	end

	arg_49_0._formationLogic:Destroy()

	arg_49_0._formationLogic = nil

	pg.UIMgr.GetInstance():UnOverlayPanel(arg_49_0._tf)

	return
end

return var_0_0

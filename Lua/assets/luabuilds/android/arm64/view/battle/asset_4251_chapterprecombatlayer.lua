local ChapterPreCombatLayer = class("ChapterPreCombatLayer", import("..base.BaseUI"))
local FormationUI = import("..ship.FormationUI")
local var_0_2 = {
	[99] = true
}

ChapterPreCombatLayer.optionsPath = {
	"adapt/top/option"
}

function ChapterPreCombatLayer:getUIName()
	return "ChapterPreCombatUI"
end

function ChapterPreCombatLayer:ResUISettings()
	return true
end

function ChapterPreCombatLayer:init()
	self._startBtn = self.rtAdapt:Find("right/start")
	self._popup = self.rtAdapt:Find("right/popup")
	self._costText = self.rtAdapt:Find("right/popup/Text")
	self._costTip = self.rtAdapt:Find("right/popup/tip")
	self._extraCostBuffIcon = self.rtAdapt:Find("right/operation_buff_icon")
	self._backBtn = self.rtAdapt:Find("top/back_btn")
	self._moveLayer = self._tf:Find("moveLayer")

	local var_3_0 = self.rtAdapt:Find("middle")

	self._mainGS = var_3_0:Find("gear_score/main/Text")
	self._vanguardGS = var_3_0:Find("gear_score/vanguard/Text")

	setText(self._mainGS, 0)
	setText(self._vanguardGS, 0)

	self._gridTFs = {
		vanguard = {},
		main = {}
	}
	self._gridFrame = var_3_0:Find("mask/GridFrame")

	for iter_3_0 = 1, 3 do
		self._gridTFs[TeamType.Vanguard][iter_3_0] = self._gridFrame:Find("vanguard_" .. iter_3_0)
		self._gridTFs[TeamType.Main][iter_3_0] = self._gridFrame:Find("main_" .. iter_3_0)
	end

	self._heroContainer = var_3_0:Find("HeroContainer")
	self._strategy = var_3_0:Find("strategy")

	setActive(self._strategy, true)

	self._spoilsContainer = self.rtAdapt:Find("right/infomation/spoils/items/items_container")
	self._goals = self.rtAdapt:Find("right/infomation/goal")
	self._item = self:getTpl("right/infomation/spoils/items/item_tpl", self.rtAdapt)
	self._heroInfo = self:getTpl("heroInfo")
	self._starTpl = self:getTpl("star_tpl")
	self._middle = self.rtAdapt:Find("middle")
	self._right = self.rtAdapt:Find("right")
	self._formationLogic = BaseFormation.New(self._tf, self._heroContainer, self._heroInfo, self._gridTFs)

	setmetatable({
		Shift = function(arg_4_0, arg_4_1, arg_4_2)
			return
		end
	}, self._formationLogic)
	setText(self.rtAdapt:Find("middle/gear_score/vanguard/line/Image/Text1"), i18n("pre_combat_vanguard"))
	setText(self.rtAdapt:Find("middle/gear_score/main/line/Image/Text1"), i18n("pre_combat_main"))

	self._fleet = self.rtAdapt:Find("middle/fleet")

	setText(self._fleet:Find("title_bg/Text"), i18n("pre_combat_team"))

	self._ship_tpl = self._fleet:Find("shiptpl")
	self._empty_tpl = self._fleet:Find("emptytpl")

	setActive(self._ship_tpl, false)
	setActive(self._empty_tpl, false)

	self._autoToggle = self.rtAdapt:Find("middle/auto_toggle")
	self._autoSubToggle = self.rtAdapt:Find("middle/sub_toggle_container/sub_toggle")
	self.topPanel = self.rtAdapt:Find("top")
	self.strategyInfo = self._tf:Find("strategy_info")

	setActive(self.strategyInfo, false)

	self._operaionBuffTips = self._extraCostBuffIcon:Find("popup")

	setAnchoredPosition(self._middle, {
		x = -840
	})
	setAnchoredPosition(self._right, {
		x = 470
	})
	self:Register()

	return
end

function ChapterPreCombatLayer:uiStartAnimating()
	setAnchoredPosition(self.topPanel, {
		y = 100
	})
	shiftPanel(self._middle, 0, nil, 0.3, 0, true, true)
	shiftPanel(self._right, 0, nil, 0.3, 0, true, true, nil)
	shiftPanel(self.topPanel, nil, 0, 0.3, 0, true, true, nil, nil)

	return
end

function ChapterPreCombatLayer:uiExitAnimating()
	shiftPanel(self._middle, -840, nil, 0.3, 0, true, true)
	shiftPanel(self._right, 470, nil, 0.3, 0, true, true)
	shiftPanel(self.topPanel, nil, self.topPanel.rect.height, 0.3, 0, true, true, nil, nil)

	return
end

function ChapterPreCombatLayer:didEnter()
	onButton(self, self._backBtn, function()
		GetOrAddComponent(self._tf, typeof(CanvasGroup)).interactable = false

		self:uiExitAnimating()
		LeanTween.delayedCall(0.3, System.Action(function()
			self:emit(ChapterPreCombatLayer.ON_CLOSE)

			return
		end))

		return
	end, SFX_CANCEL)
	onButton(self, self._startBtn, function()
		self:emit(ChapterPreCombatMediator.ON_START)

		return
	end, SFX_UI_WEIGHANCHOR)
	onToggle(self, self._autoToggle, function(arg_11_0)
		self:emit(ChapterPreCombatMediator.ON_AUTO, {
			isOn = not arg_11_0,
			toggle = self._autoToggle
		})

		if arg_11_0 and self.subUseable == true then
			setActive(self._autoSubToggle, true)
			onToggle(self, self._autoSubToggle, function(arg_12_0)
				self:emit(ChapterPreCombatMediator.ON_SUB_AUTO, {
					isOn = not arg_12_0,
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
	pg.UIMgr.GetInstance():OverlayPanel(self._tf)
	onNextTick(function()
		if self.exited then
			return
		end

		triggerToggle(self._autoToggle, ys.Battle.BattleState.IsAutoBotActive())

		return
	end)
	setAnchoredPosition(self.topPanel, {
		y = self.topPanel.rect.height
	})
	onNextTick(function()
		self:uiStartAnimating()

		return
	end)
	onButton(self, self.rtAdapt:Find("middle/gear_score/vanguard/SonarTip"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.fleet_antisub_range_tip.tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self._costTip, function()
		local var_16_0, var_16_1, var_16_2 = self.chapter:isOverFleetCost(self.chapter.fleet, (self.chapter:getStageId(self.chapter.fleet.line.row, self.chapter.fleet.line.column)))

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			hideNo = true,
			content = i18n("use_oil_limit_help", var_16_2, var_16_1)
		})

		return
	end)

	return
end

function ChapterPreCombatLayer:Register()
	self._formationLogic:AddHeroInfoModify(function(arg_18_0, arg_18_1, arg_18_2)
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
			cloneTplTo(self._starTpl, var_18_1)
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
		local var_18_12 = var_18_11:getBuffShipList()[arg_18_1:getGroupId()]
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
	self._formationLogic:AddShiftOnly(function(arg_19_0)
		self:updateView(false)

		return
	end)
	self._formationLogic:AddEndDrag(function()
		self:emit(ChapterPreCombatMediator.ON_SWITCH_SHIP, self.chapter.fleet)

		return
	end)
	self._formationLogic:AddCheckRemove(function(arg_21_0, arg_21_1)
		arg_21_0()

		return
	end)
	self._formationLogic:AddCheckSwitch(function(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4)
		if arg_22_3.ships[arg_22_3:getTeamByName(arg_22_4)[arg_22_2]].hpRant == 0 then
			return
		end

		arg_22_0()

		return
	end)
	self._formationLogic:AddCheckBeginDrag(function(arg_23_0, arg_23_1, arg_23_2)
		return arg_23_0.hpRant > 0
	end)

	return
end

function ChapterPreCombatLayer:setPlayerInfo(arg_24_1)
	return
end

function ChapterPreCombatLayer:updateChapter(arg_25_1)
	self.chapter = arg_25_1

	self._formationLogic:SetFleetVO(self.chapter.fleet)
	self._formationLogic:SetShipVOs(self.chapter.fleet.ships)
	self:updateView(true)

	return
end

function ChapterPreCombatLayer:setSubFlag(arg_26_1)
	self.subUseable = arg_26_1 or false

	return
end

function ChapterPreCombatLayer:updateView(arg_27_1)
	self._formationLogic:ResetGrid(TeamType.Vanguard, true)
	self._formationLogic:ResetGrid(TeamType.Main, true)
	SetActive(self._gridTFs[TeamType.Main][1]:Find("flag"), true)

	if arg_27_1 then
		self:updateStageView((self.chapter:getStageId(self.chapter.fleet.line.row, self.chapter.fleet.line.column)))
		self._formationLogic:LoadAllCharacter()
	else
		self._formationLogic:SetAllCharacterPos()
	end

	self:updateBattleFleetView()
	self:updateStrategyIcon()
	self:displayFleetInfo()

	return
end

function ChapterPreCombatLayer:updateStageView(arg_28_1)
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

	local var_28_7 = UIItemList.New(self._spoilsContainer, self._item)

	var_28_7:make(function(arg_29_0, arg_29_1, arg_29_2)
		local var_29_0 = var_28_3[arg_29_1 + 1]
		local var_29_1 = {
			type = var_28_3[arg_29_1 + 1][1],
			id = var_28_3[arg_29_1 + 1][2]
		}

		updateDrop(arg_29_2, var_29_1)
		onButton(self, arg_29_2, function()
			local var_30_0 = Item.getConfigData(var_29_0[2])

			if var_30_0 and var_0_2[var_30_0.type] then
				self:emit(ChapterPreCombatMediator.GET_CHAPTER_DROP_SHIP_LIST, self.chapter.id, function(arg_31_0)
					local var_31_0 = {}

					for iter_31_0, iter_31_1 in ipairs(var_30_0.display_icon) do
						local var_31_1 = iter_31_1[2]

						var_31_0[#var_31_0 + 1] = {
							type = iter_31_1[1],
							id = iter_31_1[2],
							anonymous = iter_31_1[1] == DROP_TYPE_SHIP and not table.contains(arg_31_0, var_31_1)
						}
					end

					self:emit(ChapterPreCombatLayer.ON_DROP_LIST, {
						item2Row = true,
						itemList = var_31_0,
						content = var_30_0.display
					})

					return
				end)
			else
				self:emit(ChapterPreCombatLayer.ON_DROP, var_29_1)
			end

			return
		end, SFX_PANEL)

		return
	end)
	var_28_7:align(math.min(#var_28_3, 6))

	local function var_28_8(arg_32_0, arg_32_1)
		if type(arg_32_0) == "table" then
			setActive(arg_32_1, true)
			setWidgetText(arg_32_1, (i18n(PreCombatLayer.ObjectiveList[arg_32_0[1]], arg_32_0[2])))
		else
			setActive(arg_32_1, false)
		end

		return
	end

	local var_28_9 = {
		self._goals:Find("goal_tpl"),
		self._goals:Find("goal_sink"),
		self._goals:Find("goal_time")
	}
	local var_28_10 = 1

	for iter_28_1, iter_28_2 in ipairs({
		pg.expedition_data_template[arg_28_1].objective_1,
		pg.expedition_data_template[arg_28_1].objective_2,
		pg.expedition_data_template[arg_28_1].objective_3
	}) do
		if type(iter_28_2) ~= "string" then
			var_28_8(iter_28_2, var_28_9[var_28_10])

			var_28_10 = var_28_10 + 1
		end
	end

	for iter_28_3 = var_28_10, #var_28_9 do
		var_28_8("", var_28_9[iter_28_3])
	end

	return
end

function ChapterPreCombatLayer:updateBattleFleetView()
	local function var_33_0(arg_34_0, arg_34_1)
		removeAllChildren(arg_34_0)

		for iter_34_0 = 1, 3 do
			if arg_34_1[iter_34_0] then
				local var_34_0 = cloneTplTo(self._ship_tpl, arg_34_0)

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
	end

	var_33_0(self._fleet:Find("main"), self.chapter.fleet:getShipsByTeam(TeamType.Main, true))
	var_33_0(self._fleet:Find("vanguard"), self.chapter.fleet:getShipsByTeam(TeamType.Vanguard, true))

	return
end

function ChapterPreCombatLayer:displayFleetInfo()
	local var_35_0 = self.chapter.fleet
	local var_35_1 = self.chapter:getStageId(self.chapter.fleet.line.row, self.chapter.fleet.line.column)
	local var_35_2 = self.chapter.fleet:getCommanders()
	local var_35_3 = _.reduce(self.chapter.fleet:getShipsByTeam(TeamType.Vanguard, false), 0, function(arg_36_0, arg_36_1)
		return arg_36_0 + arg_36_1:getShipCombatPower(var_35_2)
	end)
	local var_35_4 = _.reduce(self.chapter.fleet:getShipsByTeam(TeamType.Main, false), 0, function(arg_37_0, arg_37_1)
		return arg_37_0 + arg_37_1:getShipCombatPower(var_35_2)
	end)
	local var_35_5 = 0

	for iter_35_0, iter_35_1 in ipairs({
		self.chapter:getFleetCost(self.chapter.fleet, var_35_1)
	}) do
		var_35_5 = var_35_5 + iter_35_1.oil
	end

	local var_35_6 = self.chapter:isOverFleetCost(var_35_0, var_35_1)

	setActive(self._popup, true)
	setActive(self._costTip, var_35_6)
	setTextColor(self._costText, var_35_6 and Color(0.9803921568627451, 0.39215686274509803, 0.39215686274509803) or Color.white)
	FormationUI.tweenNumText(self._costText, var_35_5)
	FormationUI.tweenNumText(self._vanguardGS, var_35_3)
	FormationUI.tweenNumText(self._mainGS, var_35_4)

	local var_35_7, var_35_8 = self.chapter:GetExtraCostRate()

	setActive(self._extraCostBuffIcon, #var_35_8 > 0)

	for iter_35_2, iter_35_3 in ipairs(var_35_8) do
		if iter_35_3.benefit_type == Chapter.OPERATION_BUFF_TYPE_COST then
			setText(self._extraCostBuffIcon:Find("text_cost"), tonumber(iter_35_3.benefit_effect) * 0.01 + 1)
		elseif iter_35_3.benefit_type == Chapter.OPERATION_BUFF_TYPE_EXP then
			setText(self._extraCostBuffIcon:Find("text_reward"), tonumber(iter_35_3.benefit_effect) * 0.01 + 1)
		elseif iter_35_3.benefit_type == Chapter.OPERATION_BUFF_TYPE_DESC then
			onButton(self, self._extraCostBuffIcon, function()
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

	local var_35_9 = self.rtAdapt:Find("middle/gear_score/vanguard")
	local var_35_10 = ChapterFleet.StaticTransformChapterFleet2Fleet(var_35_0):GetFleetSonarRange()

	setActive(var_35_9:Find("SonarActive"), var_35_10 > 0)
	setActive(var_35_9:Find("SonarInactive"), var_35_10 <= 0)

	if var_35_10 > 0 then
		setText(var_35_9:Find("SonarActive/Text"), math.floor(var_35_10))
	end

	return
end

function ChapterPreCombatLayer:updateStrategyIcon()
	local var_39_0 = _.detect(self.chapter.fleet:getStrategies(), function(arg_40_0)
		return arg_40_0.id == ChapterConst.StrategyRepair
	end)

	GetImageSpriteFromAtlasAsync("strategyicon/" .. pg.strategy_data_template[var_39_0.id].icon, "", self._strategy:Find("icon"))
	onButton(self, self._strategy, function()
		self:displayStrategyInfo(var_39_0)

		return
	end, SFX_PANEL)
	setText(self._strategy:Find("nums"), var_39_0.count)
	setActive(self._strategy:Find("mask"), var_39_0.count == 0)
	setActive(self._strategy:Find("selected"), false)

	local var_39_1 = self.rtAdapt:Find("middle/formation_list")
	local var_39_2 = var_39_1:Find("formation")

	setActive(var_39_2, false)

	local var_39_3 = ChapterConst.StrategyForms
	local var_39_4 = {}

	table.insert(var_39_4, 1, {
		id = self.chapter.fleet:getFormationStg()
	})

	local var_39_5 = UIItemList.New(var_39_1, var_39_2)

	var_39_5:make(function(arg_42_0, arg_42_1, arg_42_2)
		if arg_42_0 == UIItemList.EventUpdate then
			local var_42_0 = var_39_4[arg_42_1 + 1]
			local var_42_1 = pg.strategy_data_template[var_39_4[arg_42_1 + 1].id]

			if pg.strategy_data_template[var_39_4[arg_42_1 + 1].id].type ~= ChapterConst.StgTypeForm then
				return
			end

			GetImageSpriteFromAtlasAsync("strategyicon/" .. pg.strategy_data_template[var_39_4[arg_42_1 + 1].id].icon, "", arg_42_2:Find("icon"))
			onButton(self, arg_42_2, function()
				if var_42_1.type == ChapterConst.StgTypeForm then
					self:emit(ChapterPreCombatMediator.ON_OP, {
						type = ChapterConst.OpStrategy,
						id = self.chapter.fleet:getNextStgUser(var_42_0.id),
						arg1 = var_39_3[table.indexof(var_39_3, var_42_0.id) % #var_39_3 + 1]
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
	var_39_5:align(#var_39_4)

	return
end

function ChapterPreCombatLayer:displayStrategyInfo(arg_44_1)
	self.strategyPanel = self.strategyPanel or StrategyPanel.New(self.strategyInfo)

	self.strategyPanel:attach(self)
	self.strategyPanel:set(arg_44_1)
	pg.UIMgr.GetInstance():BlurPanel(self.strategyPanel._tf)

	function self.strategyPanel.onConfirm()
		local var_45_1

		if not self.chapter.fleet:canUseStrategy(arg_44_1) then
			do return end

			var_45_1 = {
				type = ChapterConst.OpStrategy
			}
		end

		var_45_1.id = self.chapter.fleet:getNextStgUser(arg_44_1.id)
		var_45_1.arg1 = arg_44_1.id

		self:emit(ChapterPreCombatMediator.ON_OP, var_45_1)
		self:hideStrategyInfo()

		return
	end

	function self.strategyPanel.onCancel()
		self:hideStrategyInfo()

		return
	end

	return
end

function ChapterPreCombatLayer:hideStrategyInfo()
	if self.strategyPanel then
		pg.UIMgr.GetInstance():UnOverlayPanel(self.strategyPanel._tf)
		self.strategyPanel:detach()
	end

	return
end

function ChapterPreCombatLayer:onBackPressed()
	if self.strategyPanel and self.strategyPanel._go and isActive(self.strategyPanel._go) then
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)
		self:hideStrategyInfo()
	else
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)
		triggerButton(self._backBtn)
	end

	return
end

function ChapterPreCombatLayer:willExit()
	if self.strategyPanel and self.strategyPanel._go and isActive(self.strategyPanel._go) then
		self:hideStrategyInfo()
	end

	self._formationLogic:Destroy()

	self._formationLogic = nil

	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

return ChapterPreCombatLayer

class = var_0_10000

local var_0_0 = "WorldPreCombatLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))

import = var_0_0

local var_0_2 = var_0_0("..ship.FormationUI")
local var_0_3 = {
	[99] = true
}

var_0_1.optionsPath = {
	"adapt/top/option"
}

function var_0_1.getUIName(arg_1_0)
	return "WorldPreCombatUI"
end

function var_0_1.init(arg_2_0)
	arg_2_0.eventTriggers = {}

	local var_2_0 = arg_2_0._tf

	arg_2_0.middle = var_1.Find(var_2_0, "adapt/middle")

	local var_2_1 = arg_2_0._tf

	arg_2_0.right = var_1.Find(var_2_1, "adapt/right")

	local var_2_2 = arg_2_0._tf

	arg_2_0.top = var_1.Find(var_2_2, "adapt/top")

	local var_2_3 = arg_2_0._tf

	arg_2_0.moveLayer = var_1.Find(var_2_3, "adapt/moveLayer")

	local var_2_4 = arg_2_0.top

	arg_2_0.backBtn = var_1.Find(var_2_4, "back_btn")

	local var_2_5 = arg_2_0.top

	arg_2_0.playerResOb = var_1.Find(var_2_5, "playerRes")
	WorldResource = var_1
	arg_2_0.resPanel = var_1.New()
	tf = var_1

	local var_2_6 = var_1(arg_2_0.resPanel._go)
	local var_2_7 = var_1.SetParent

	tf = var_3

	var_2_7(var_2_6, var_3(arg_2_0.playerResOb), false)

	local var_2_8 = arg_2_0.top

	arg_2_0.strategyInfo = var_1.Find(var_2_8, "strategy_info")
	setActive = var_1

	var_1(arg_2_0.strategyInfo, false)

	local var_2_9 = arg_2_0.middle

	arg_2_0.mainGS = var_1.Find(var_2_9, "gear_score/main/Text")

	local var_2_10 = arg_2_0.middle

	arg_2_0.vanguardGS = var_1.Find(var_2_10, "gear_score/vanguard/Text")
	setText = var_1

	var_1(arg_2_0.mainGS, 0)

	setText = var_1

	var_1(arg_2_0.vanguardGS, 0)

	arg_2_0.gridTFs = {
		vanguard = {},
		main = {}
	}

	local var_2_11 = arg_2_0.middle

	arg_2_0.gridFrame = var_1.Find(var_2_11, "mask/GridFrame")

	for iter_2_0 = 1, 3 do
		local var_2_12 = arg_2_0.gridTFs

		TeamType = var_1_10006

		local var_2_13 = var_2_12[var_1_10006.Vanguard]
		local var_2_14 = arg_2_0.gridFrame

		var_2_13[iter_2_0] = var_1_10006.Find(var_2_14, "vanguard_" .. iter_2_0)

		local var_2_15 = arg_2_0.gridTFs

		TeamType = var_1_10006

		local var_2_16 = var_2_15[var_1_10006.Main]
		local var_2_17 = arg_2_0.gridFrame

		var_2_16[iter_2_0] = var_1_10006.Find(var_2_17, "main_" .. iter_2_0)
	end

	local var_2_18 = arg_2_0.middle

	arg_2_0.heroContainer = var_1.Find(var_2_18, "HeroContainer")

	local var_2_19 = arg_2_0.middle

	arg_2_0.strategy = var_1.Find(var_2_19, "strategy")
	setActive = var_1

	var_1(arg_2_0.strategy, false)

	local var_2_20 = arg_2_0.middle

	arg_2_0.fleet = var_1.Find(var_2_20, "fleet")
	findTF = var_1
	arg_2_0.ship_tpl = var_1(arg_2_0.fleet, "shiptpl")
	findTF = var_1
	arg_2_0.empty_tpl = var_1(arg_2_0.fleet, "emptytpl")
	setActive = var_1

	var_1(arg_2_0.ship_tpl, false)

	setActive = var_1

	var_1(arg_2_0.empty_tpl, false)

	local var_2_21 = arg_2_0.right

	arg_2_0.autoToggle = var_1.Find(var_2_21, "auto_toggle")

	local var_2_22 = arg_2_0.right

	arg_2_0.autoSubToggle = var_1.Find(var_2_22, "sub_toggle_container/sub_toggle")

	local var_2_23 = arg_2_0.right

	arg_2_0.startBtn = var_1.Find(var_2_23, "start")

	local var_2_24 = arg_2_0.right

	arg_2_0.infoBtn = var_1.Find(var_2_24, "information")
	arg_2_0.heroInfo = arg_2_0:getTpl("heroInfo")
	arg_2_0.starTpl = arg_2_0:getTpl("star_tpl")

	local var_2_25 = arg_2_0._tf

	arg_2_0.energyDescTF = var_1.Find(var_2_25, "energy_desc")

	local var_2_26 = arg_2_0._tf

	arg_2_0.energyDescTextTF = var_1.Find(var_2_26, "energy_desc/Text")

	local var_2_27 = arg_2_0.right

	arg_2_0.normaltab = var_1.Find(var_2_27, "normal")

	local var_2_28 = arg_2_0.right

	arg_2_0.informationtab = var_1.Find(var_2_28, "infomation")

	local var_2_29 = arg_2_0.normaltab

	arg_2_0.buffInfo = var_1.Find(var_2_29, "buff")

	local var_2_30 = arg_2_0.normaltab

	arg_2_0.bossInfo = var_1.Find(var_2_30, "boss")

	local var_2_31 = arg_2_0.normaltab

	arg_2_0.spoilsContainer = var_1.Find(var_2_31, "spoils/items/items_container")

	local var_2_32 = arg_2_0.normaltab

	arg_2_0.spoilsItem = var_1.Find(var_2_32, "spoils/items/item_tpl")

	local var_2_33 = arg_2_0.Clone2Full
	local var_2_34 = arg_2_0.informationtab

	arg_2_0.digits = var_2_33(var_2.Find(var_2_34, "target/simple/digits"), 3)

	local var_2_35 = arg_2_0.Clone2Full
	local var_2_36 = arg_2_0.informationtab

	arg_2_0.digitExtras = var_2_35(var_2.Find(var_2_36, "target/detail"), 3)

	local var_2_37 = arg_2_0.informationtab

	arg_2_0.dropright = var_1.Find(var_2_37, "spoils/right")

	local var_2_38 = arg_2_0.informationtab

	arg_2_0.dropleft = var_1.Find(var_2_38, "spoils/left")

	local var_2_39 = arg_2_0.Clone2Full
	local var_2_40 = arg_2_0.informationtab

	arg_2_0.dropitems = var_2_39(var_2.Find(var_2_40, "spoils/items_container"), 3)
	setActive = var_1

	local var_2_41 = arg_2_0.informationtab

	var_1(var_2.Find(var_2_41, "target/simple"), true)

	setActive = var_1

	local var_2_42 = arg_2_0.informationtab

	var_1(var_2.Find(var_2_42, "target/detail"), false)

	for iter_2_1 = 1, #arg_2_0.digitExtras do
		local var_2_43 = arg_2_0.digitExtras[iter_2_1]

		setText = var_1_10006

		local var_2_44 = var_2_43
		local var_2_45 = var_2_43.Find(var_2_44, "desc")

		i18n = var_2_44

		var_1_10006(var_2_45, var_2_44("world_mapbuff_compare_txt") .. "：")
	end

	return
end

function var_0_1.uiStartAnimating(arg_3_0)
	setAnchoredPosition = var_1_10001

	var_1_10001(arg_3_0.middle, {
		x = -840
	})

	setAnchoredPosition = var_1_10001

	var_1_10001(arg_3_0.right, {
		x = 470
	})

	setAnchoredPosition = var_1_10001

	var_1_10001(arg_3_0.top, {
		y = arg_3_0.top.rect.height
	})

	local var_3_0 = 0
	local var_3_1 = 0.3

	shiftPanel = var_3

	var_3(arg_3_0.middle, 0, nil, var_3_1, var_3_0, true, true)

	shiftPanel = var_3

	var_3(arg_3_0.right, 0, nil, var_3_1, var_3_0, true, true, nil)

	shiftPanel = var_3

	var_3(arg_3_0.top, nil, 0, var_3_1, var_3_0, true, true, nil, nil)

	return
end

function var_0_1.uiExitAnimating(arg_4_0)
	local var_4_0 = 0
	local var_4_1 = 0.3

	shiftPanel = var_1_10003

	var_1_10003(arg_4_0.middle, -840, nil, var_4_1, var_4_0, true, true)

	shiftPanel = var_1_10003

	var_1_10003(arg_4_0.right, 470, nil, var_4_1, var_4_0, true, true)

	shiftPanel = var_1_10003

	var_1_10003(arg_4_0.top, nil, arg_4_0.top.rect.height, var_4_1, var_4_0, true, true, nil, nil)

	return
end

function var_0_1.didEnter(arg_5_0)
	onButton = var_1_10001

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.backBtn

	local function var_5_2()
		GetOrAddComponent = var_2_10000

		local var_6_0 = arg_5_0._tf

		typeof = var_2_10002
		CanvasGroup = var_2_10003
		var_2_10000(var_6_0, var_2_10002(var_2_10003)).interactable = false

		local var_6_1 = arg_5_0

		var_1.uiExitAnimating(var_6_1)

		LeanTween = var_1

		local var_6_2 = var_1.delayedCall
		local var_6_3 = 0.3

		System = var_2_10003

		var_6_2(var_6_3, var_2_10003.Action(function()
			local var_7_0 = arg_5_0

			var_0.emit(var_7_0, var_0_1.ON_CLOSE)

			return
		end))

		return
	end

	SFX_CANCEL = var_1_10005

	var_1_10001(var_5_0, var_5_1, var_5_2, var_1_10005)

	onToggle = var_1_10001

	local var_5_3 = arg_5_0
	local var_5_4 = arg_5_0.autoToggle

	local function var_5_5(arg_8_0)
		local var_8_0 = arg_5_0
		local var_8_1 = var_1.emit

		WorldPreCombatMediator = var_2_10003

		var_8_1(var_8_0, var_2_10003.OnAuto, {
			isOn = not arg_8_0,
			toggle = arg_5_0.autoToggle
		})

		if arg_8_0 then
			nowWorld = var_8_1

			local var_8_2 = var_8_1()

			if var_8_1.GetSubAidFlag(var_8_2) then
				setActive = var_8_1

				var_8_1(arg_5_0.autoSubToggle, true)

				onToggle = var_8_1

				local var_8_3 = arg_5_0
				local var_8_4 = arg_5_0.autoSubToggle

				local function var_8_5(arg_9_0)
					local var_9_0 = arg_5_0
					local var_9_1 = var_1.emit

					WorldPreCombatMediator = var_3_10003

					var_9_1(var_9_0, var_3_10003.OnSubAuto, {
						isOn = not arg_9_0,
						toggle = arg_5_0.autoSubToggle
					})

					return
				end

				SFX_PANEL = var_5
				SFX_PANEL = var_2_10006

				var_8_1(var_8_3, var_8_4, var_8_5, var_5, var_2_10006)

				triggerToggle = var_8_1

				local var_8_6 = arg_5_0.autoSubToggle

				ys = var_8_4

				local var_8_7 = var_8_4.Battle.BattleState.IsAutoSubActive

				SYSTEM_WORLD = var_8_5

				var_8_1(var_8_6, var_8_7(var_8_5))

				goto label_8_0
			end
		end

		setActive = var_8_1

		var_8_1(arg_5_0.autoSubToggle, false)

		::label_8_0::

		return
	end

	SFX_PANEL = var_1_10005
	SFX_PANEL = var_1_10006

	var_1_10001(var_5_3, var_5_4, var_5_5, var_1_10005, var_1_10006)
	arg_5_0:OverlayPanel(arg_5_0._tf)
	arg_5_0:updateCharacters()
	arg_5_0:updateStageView()

	triggerToggle = var_1

	local var_5_6 = arg_5_0.autoToggle

	ys = var_3

	local var_5_7 = var_3.Battle.BattleState.IsAutoBotActive

	SYSTEM_WORLD = var_5_5

	var_1(var_5_6, var_5_7(var_5_5))

	local var_5_8 = arg_5_0:GetCurrentAttachment()
	local var_5_9 = var_1.GetBattleStageId(var_5_8)

	pg = var_5_8

	local var_5_10 = var_5_8.expedition_data_template[var_5_9]

	assert = var_5_5

	var_5_5(var_5_10, "expedition_data_template not exist: " .. var_5_9)

	pg = var_5_5

	local var_5_11

	if var_5_5.world_expedition_data[var_5_9] and var_4.battle_type then
		var_5_11 = var_4.battle_type ~= 0
	end

	onNextTick = var_6

	var_6(function()
		local var_10_0 = arg_5_0

		var_0.uiStartAnimating(var_10_0)

		return
	end)

	local var_5_12 = arg_5_0.contextData

	var_5_12.entetagain = true
	setActive = var_5_12

	var_5_12(arg_5_0.infoBtn, var_5_11)

	onButton = var_5_12

	var_5_12(arg_5_0, arg_5_0.infoBtn, function()
		local var_11_0 = arg_5_0
		local var_11_1 = var_0.emit

		WorldPreCombatMediator = var_2_10002

		local var_11_2 = var_2_10002.OnOpenSublayer

		Context = var_2_10003

		local var_11_3 = var_2_10003.New
		local var_11_4 = {}

		WorldBossInformationMediator = var_2_10005
		var_11_4.mediator = var_2_10005
		WorldBossInformationLayer = var_2_10005
		var_11_4.viewComponent = var_2_10005

		var_11_1(var_11_0, var_11_2, var_11_3(var_11_4), true, function()
			local var_12_0 = arg_5_0

			var_0.closeView(var_12_0)

			return
		end)

		return
	end)

	onButton = var_5_12

	local var_5_13 = arg_5_0
	local var_5_14 = arg_5_0.startBtn

	local function var_5_15()
		local var_13_0 = arg_5_0
		local var_13_1 = var_0.emit

		WorldPreCombatMediator = var_2_10002

		local var_13_2 = var_2_10002.OnStartBattle
		local var_13_3 = var_0
		local var_13_4 = var_3.GetBattleStageId(var_13_3)
		local var_13_5 = arg_5_0

		var_13_1(var_13_0, var_13_2, var_13_4, var_4.getCurrentFleet(var_13_5), var_0)

		return
	end

	SFX_UI_WEIGHANCHOR = var_1_10010

	var_5_12(var_5_13, var_5_14, var_5_15, var_1_10010)

	return
end

function var_0_1.onBackPressed(arg_14_0)
	local var_14_1

	if arg_14_0.strategyPanel and arg_14_0.strategyPanel._go then
		isActive = var_14_1

		if var_14_1(arg_14_0.strategyPanel._go) then
			pg = var_14_1

			local var_14_0 = var_14_1.CriMgr.GetInstance()

			var_14_1 = var_14_1.PlaySoundEffect_V3
			SFX_CANCEL = var_1_10003

			var_14_1(var_14_0, var_1_10003)
			arg_14_0:hideStrategyInfo()

			goto label_14_0
		end
	end

	pg = var_14_1

	do
		local var_14_2 = var_14_1.CriMgr.GetInstance()
		local var_14_3 = var_1.PlaySoundEffect_V3

		SFX_CANCEL = var_1_10003

		var_14_3(var_14_2, var_1_10003)

		triggerButton = var_14_3

		var_14_3(arg_14_0.backBtn)
	end

	::label_14_0::

	return
end

function var_0_1.setPlayerInfo(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0.resPanel

	var_2.setPlayer(var_15_0, arg_15_1)

	setActive = var_2

	local var_15_1 = arg_15_0.resPanel._tf

	nowWorld = var_4

	local var_15_2 = var_4()
	local var_15_3 = var_4.IsSystemOpen

	WorldConst = var_1_10006

	var_2(var_15_1, var_15_3(var_15_2, var_1_10006.SystemResource))

	return
end

function var_0_1.getCurrentFleet(arg_16_0)
	nowWorld = var_1_10001

	local var_16_0 = var_1_10001()

	return var_1.GetFleet(var_16_0)
end

function var_0_1.GetCurrentAttachment(arg_17_0)
	nowWorld = var_1_10001

	local var_17_0 = var_1_10001()
	local var_17_1 = var_1.GetActiveMap(var_17_0)
	local var_17_2 = var_1.GetFleet(var_17_1)
	local var_17_3 = var_1:GetCell(var_17_2.row, var_17_2.column)

	return var_3.GetAliveAttachment(var_17_3), var_1.config.difficulty
end

function var_0_1.updateStageView(arg_18_0)
	setActive = var_1_10001

	var_1_10001(arg_18_0.normaltab, false)

	setActive = var_1_10001

	var_1_10001(arg_18_0.informationtab, true)
	arg_18_0:UpdateInformationtab()

	return
end

function var_0_1.UpdateNormaltab(arg_19_0)
	local var_19_0, var_19_1 = arg_19_0:GetCurrentAttachment()
	local var_19_2 = var_19_0
	local var_19_3 = var_19_0.GetBattleStageId(var_19_2)

	pg = var_19_2

	local var_19_4 = var_19_2.world_expedition_data[var_19_3]
	local var_19_5 = {}

	ipairs = var_1_10006

	for iter_19_0, iter_19_1 in var_1_10006(var_19_4.award_display_world) do
		if var_19_1 == iter_19_1[1] then
			var_19_5 = iter_19_1[2]
		end
	end

	UIItemList = var_6

	local var_19_6 = var_6.New(arg_19_0.spoilsContainer, arg_19_0.spoilsItem)

	var_6.make(var_19_6, function(arg_20_0, arg_20_1, arg_20_2)
		local var_20_0 = arg_20_2
		local var_20_1 = var_19_5[arg_20_1 + 1]
		local var_20_2 = {
			type = var_20_1[1],
			id = var_20_1[2]
		}

		updateDrop = var_6

		var_6(var_20_0, var_20_2)

		onButton = var_6

		local var_20_3 = arg_19_0
		local var_20_4 = var_20_0

		local function var_20_5()
			local var_21_0 = arg_19_0

			var_0.emit(var_21_0, var_0_1.ON_DROP, var_20_2)

			return
		end

		SFX_PANEL = var_2_10010

		var_6(var_20_3, var_20_4, var_20_5, var_2_10010)

		return
	end)
	var_6:align(#var_19_5)

	return
end

local var_0_4 = "fe2222"
local var_0_5 = "92fc63"

function var_0_1.UpdateInformationtab(arg_22_0)
	local var_22_0, var_22_1 = arg_22_0:GetCurrentAttachment()
	local var_22_2 = var_22_0
	local var_22_3 = var_22_0.GetBattleStageId(var_22_2)

	pg = var_22_2

	local var_22_4 = var_22_2.world_expedition_data[var_22_3]

	assert = var_1_10005

	var_1_10005(var_22_4, "world_expedition_data not exist: " .. var_22_3)

	local var_22_5 = {}

	ipairs = var_6

	for iter_22_0, iter_22_1 in var_6(var_22_4.award_display_world) do
		if var_22_1 == iter_22_1[1] then
			var_22_5 = iter_22_1[2]
		end
	end

	local var_22_6 = 0

	local function var_22_7()
		for iter_23_0 = 1, #arg_22_0.dropitems do
			local var_23_0 = arg_22_0.dropitems[iter_23_0]
			local var_23_1 = var_4.Find(var_23_0, "item_tpl")
			local var_23_2 = var_22_5[iter_23_0 + var_22_6]

			setActive = var_6

			var_6(var_23_1, var_23_2 ~= nil)

			if var_23_2 then
				local var_23_3 = {
					type = var_23_2[1],
					id = var_23_2[2]
				}

				updateDrop = var_7

				var_7(var_23_1, var_23_3)

				setScrollText = var_7

				var_7(var_23_1:Find("ScrollMask/DropName"), var_23_3:getConfig("name"))

				onButton = var_7

				local var_23_4 = arg_22_0
				local var_23_5 = var_23_1

				local function var_23_6()
					local var_24_0 = arg_22_0

					var_0.emit(var_24_0, var_0_1.ON_DROP, var_23_3)

					return
				end

				SFX_PANEL = var_11

				var_7(var_23_4, var_23_5, var_23_6, var_11)
			end
		end

		setActive = var_0

		var_0(arg_22_0.dropleft, var_22_6 > 0)

		setActive = var_0

		var_0(arg_22_0.dropright, #var_22_5 - var_22_6 > #arg_22_0.dropitems)

		return
	end

	onButton = var_8

	var_8(arg_22_0, arg_22_0.dropright, function()
		var_22_6 = var_22_6 + 1

		var_22_7()

		return
	end)

	onButton = var_8

	var_8(arg_22_0, arg_22_0.dropleft, function()
		var_22_6 = var_22_6 - 1

		var_22_7()

		return
	end)
	var_22_7()

	nowWorld = var_8

	local var_22_8 = var_8()

	ys = var_9

	local var_22_9 = var_9.Battle.BattleFormulas
	local var_22_10 = var_22_8:GetWorldMapDifficultyBuffLevel()
	local var_22_11 = {
		var_22_10[1] * (1 + var_22_4.expedition_sairenvalueA / 16),
		var_22_10[2] * (1 + var_22_4.expedition_sairenvalueB / 16),
		var_22_10[3] * (1 + var_22_4.expedition_sairenvalueC / 16)
	}
	local var_22_12 = var_22_8:GetWorldMapBuffLevel()
	local var_22_13, var_22_14, var_22_15 = var_22_9.WorldMapRewardAttrEnhance(var_22_11, var_22_12)
	local var_22_16 = 1 - var_22_9.WorldMapRewardHealingRate(var_22_11, var_22_12)
	local var_22_17 = {
		var_22_13,
		var_22_14,
		var_22_16
	}

	for iter_22_2 = 1, #arg_22_0.digits do
		local var_22_18 = arg_22_0.digits[iter_22_2]

		setText = var_1_10023

		local var_22_19 = var_22_18
		local var_22_20 = var_22_18.Find(var_22_19, "digit")

		string = var_22_19

		var_1_10023(var_22_20, var_22_19.format("%d", var_22_11[iter_22_2]))

		if iter_22_2 ~= 3 or not (1 - var_22_17[iter_22_2]) then
			var_1_10023 = var_22_17[iter_22_2] + 1
		end

		setText = var_22_20

		local var_22_21 = var_22_18
		local var_22_22 = var_22_18.Find(var_22_21, "desc")

		i18n = var_22_21

		local var_22_23 = var_22_21("world_mapbuff_attrtxt_" .. iter_22_2)

		string = var_27

		var_22_20(var_22_22, var_22_23 .. var_27.format("%3d%%", var_1_10023 * 100))
	end

	for iter_22_3 = 1, #arg_22_0.digitExtras do
		local var_22_24 = arg_22_0.digitExtras[iter_22_3]

		setText = var_1_10023

		local var_22_25 = var_22_24
		local var_22_26 = var_22_24.Find(var_22_25, "enemy")

		string = var_22_25

		var_1_10023(var_22_26, var_22_25.format("%d", var_22_11[iter_22_3]))

		setText = var_1_10023

		local var_22_27 = var_22_24
		local var_22_28 = var_22_24.Find(var_22_27, "ally")

		string = var_22_27

		var_1_10023(var_22_28, var_22_27.format("%d", var_22_12[iter_22_3]))

		setText = var_1_10023

		local var_22_29 = var_22_24
		local var_22_30 = var_22_24.Find(var_22_29, "result")

		string = var_22_29

		var_1_10023(var_22_30, var_22_29.format("%d%%", var_22_17[iter_22_3] * 100))

		setTextColor = var_1_10023

		local var_22_31 = var_22_24:Find("result")
		local var_22_32

		if not (var_22_17[iter_22_3] > 0) or not arg_22_0.TransformColor(var_0_4) then
			var_22_32 = arg_22_0.TransformColor(var_0_5)
		end

		var_1_10023(var_22_31, var_22_32)

		setText = var_1_10023

		var_1_10023(var_22_24:Find("result/arrow"), var_22_17[iter_22_3] == 0 and "" or var_22_17[iter_22_3] > 0 and "↑" or "↓")

		if var_22_17[iter_22_3] ~= 0 then
			setTextColor = var_1_10023

			local var_22_33 = var_22_24:Find("result/arrow")
			local var_22_34

			if not (var_22_17[iter_22_3] > 0) or not arg_22_0.TransformColor(var_0_4) then
				var_22_34 = arg_22_0.TransformColor(var_0_5)
			end

			var_1_10023(var_22_33, var_22_34)
		end
	end

	onButton = var_18

	local var_22_35 = arg_22_0
	local var_22_36 = arg_22_0.informationtab
	local var_22_37 = var_20.Find(var_22_36, "target/bg")

	local function var_22_38()
		local var_27_0 = arg_22_0.informationtab
		local var_27_1 = var_0.Find(var_27_0, "target/simple")
		local var_27_2 = arg_22_0.informationtab
		local var_27_3 = var_1.Find(var_27_2, "target/detail")

		go = var_27_2

		local var_27_4 = var_27_2(var_27_1).activeSelf

		setActive = var_3

		var_3(var_27_1, not var_27_4)

		setActive = var_3

		var_3(var_27_3, var_27_4)

		return
	end

	SFX_PANEL = var_22

	var_18(var_22_35, var_22_37, var_22_38, var_22)

	return
end

function var_0_1.updateCharacters(arg_28_0)
	pg = var_1_10001

	local var_28_0 = var_1_10001.UIMgr.GetInstance()

	var_1.LoadingOn(var_28_0)

	local var_28_1 = arg_28_0
	local var_28_2 = arg_28_0.resetGrid

	TeamType = var_1_10003

	var_28_2(var_28_1, var_1_10003.Vanguard)

	local var_28_3 = arg_28_0
	local var_28_4 = arg_28_0.resetGrid

	TeamType = var_3

	var_28_4(var_28_3, var_3.Main)
	arg_28_0:loadAllCharacter(function()
		local var_29_0 = arg_28_0

		var_0.updateFleetView(var_29_0)

		local var_29_1 = arg_28_0

		var_0.displayFleetInfo(var_29_1)

		pg = var_0

		local var_29_2 = var_0.UIMgr.GetInstance()

		var_0.LoadingOff(var_29_2)

		return
	end)

	return
end

function var_0_1.flushCharacters(arg_30_0)
	local var_30_0 = arg_30_0
	local var_30_1 = arg_30_0.resetGrid

	TeamType = var_1_10003

	var_30_1(var_30_0, var_1_10003.Vanguard)

	local var_30_2 = arg_30_0
	local var_30_3 = arg_30_0.resetGrid

	TeamType = var_3

	var_30_3(var_30_2, var_3.Main)
	arg_30_0:setAllCharacterPos(true)
	arg_30_0:updateFleetView()

	return
end

function var_0_1.updateFleetView(arg_31_0)
	local function var_31_0(arg_32_0, arg_32_1)
		removeAllChildren = var_2_10002

		var_2_10002(arg_32_0)

		for iter_32_0 = 1, 3 do
			if arg_32_1[iter_32_0] then
				cloneTplTo = var_6

				local var_32_0 = var_6(arg_31_0.ship_tpl, arg_32_0)

				updateShip = var_7

				var_7(var_32_0, arg_32_1[iter_32_0])

				WorldConst = var_7

				local var_32_1 = var_7.FetchWorldShip(arg_32_1[iter_32_0].id)
				local var_32_2 = var_7.IsHpSafe(var_32_1)
				local var_32_3 = var_7
				local var_32_4 = var_7.IsAlive(var_32_3)

				findTF = var_32_3

				local var_32_5 = var_32_3(var_32_0, "blood/fillarea/green")

				findTF = var_11

				local var_32_6 = var_11(var_32_0, "blood/fillarea/red")

				setActive = var_12

				var_12(var_32_5, var_32_2)

				setActive = var_12

				var_12(var_32_6, not var_32_2)

				local var_32_7 = var_32_2 and var_32_5 or var_32_6
				local var_32_8 = var_12.GetComponent(var_32_7, "Image")

				var_32_8.fillAmount = var_7.hpRant * 0.0001
				setActive = var_32_8

				var_32_8(var_32_0:Find("broken"), var_7:IsBroken())

				setActive = var_32_8

				var_32_8(var_32_0:Find("mask"), not var_32_4)
			end
		end

		return
	end

	local var_31_1 = arg_31_0:getCurrentFleet()
	local var_31_2 = var_31_0
	local var_31_3 = arg_31_0.fleet
	local var_31_4 = var_4.Find(var_31_3, "main")
	local var_31_5 = var_31_1
	local var_31_6 = var_31_1.GetTeamShipVOs

	TeamType = var_1_10007

	var_31_2(var_31_4, var_31_6(var_31_5, var_1_10007.Main, true))

	local var_31_7 = var_31_0
	local var_31_8 = arg_31_0.fleet
	local var_31_9 = var_4.Find(var_31_8, "vanguard")
	local var_31_10 = var_31_1
	local var_31_11 = var_31_1.GetTeamShipVOs

	TeamType = var_7

	var_31_7(var_31_9, var_31_11(var_31_10, var_7.Vanguard, true))

	return
end

function var_0_1.loadAllCharacter(arg_33_0, arg_33_1)
	removeAllChildren = var_1_10002

	var_1_10002(arg_33_0.heroContainer)

	local var_33_0 = {}

	TeamType = var_3
	var_33_0[var_3.Vanguard] = {}
	TeamType = var_3
	var_33_0[var_3.Main] = {}
	arg_33_0.characterList = var_33_0

	local function var_33_1(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
		if arg_33_0.exited then
			arg_34_0:Dispose()

			return
		end

		local var_34_0 = arg_34_0
		local var_34_1 = arg_34_0.GetRootModel(var_34_0)

		WorldConst = var_34_0

		local var_34_2 = var_34_0.FetchWorldShip(arg_34_1.id)

		arg_33_0.characterList[arg_34_2][arg_34_3] = arg_34_0

		arg_34_0:SetParent(arg_33_0.heroContainer, false)

		local var_34_3 = arg_34_0
		local var_34_4 = arg_34_0.SetModelScale

		Vector3 = var_8

		var_34_4(var_34_3, var_8(0.65, 0.65, 1))

		pg = var_34_4

		local var_34_5 = var_34_4.ViewUtils.SetLayer

		tf = var_34_3

		local var_34_6 = var_34_3(var_34_1)

		Layer = var_8

		var_34_5(var_34_6, var_8.UI)

		local var_34_7 = arg_33_0

		var_6.enabledCharacter(var_34_7, arg_34_0, true, arg_34_2)

		local var_34_8 = arg_33_0

		var_6.setCharacterPos(var_34_8, arg_34_2, arg_34_3, arg_34_0)

		local var_34_9 = arg_33_0

		var_6.sortSiblingIndex(var_34_9)

		cloneTplTo = var_6

		local var_34_10 = var_6(arg_33_0.heroInfo, var_34_1)

		setAnchoredPosition = var_7

		var_7(var_34_10, {
			x = 0,
			y = 0
		})

		Vector3 = var_7
		var_34_10.localScale = var_7(2, 2, 1)
		SetActive = var_7

		var_7(var_34_10, true)

		var_34_10.name = "info"
		findTF = var_7

		local var_34_11 = var_7(var_34_10, "info")

		findTF = var_8

		local var_34_12 = var_8(var_34_11, "stars")
		local var_34_13 = arg_34_1
		local var_34_14 = arg_34_1.getEnergy(var_34_13)

		Ship = var_34_13

		local var_34_15 = var_34_14 <= var_34_13.ENERGY_MID

		findTF = var_10

		local var_34_16 = var_10(var_34_11, "energy")
		local var_34_17

		if var_34_15 then
			local var_34_18

			var_34_17, var_34_18 = arg_34_1:getEnergyPrint()
			GetSpriteFromAtlas = var_2_10013

			if not var_2_10013("energy", var_34_17) then
				warning = var_14

				var_14("找不到疲劳")
			end

			setImageSprite = var_14

			var_14(var_34_16, var_13)
		end

		setActive = var_34_17

		var_34_17(var_34_16, var_34_15)

		local var_34_19 = arg_34_1:getStar()

		for iter_34_0 = 1, var_34_19 do
			cloneTplTo = var_2_10016

			var_2_10016(arg_33_0.starTpl, var_34_12)
		end

		GetSpriteFromAtlas = var_12

		local var_34_20 = "shiptype"

		shipType2print = var_14

		if not var_12(var_34_20, var_14(arg_34_1:getShipType())) then
			warning = var_34_20

			var_34_20("找不到船形, shipConfigId: " .. arg_34_1.configId)
		end

		setImageSprite = var_34_20
		findTF = var_14

		var_34_20(var_14(var_34_11, "type"), var_12, true)

		setText = var_34_20
		findTF = var_14

		var_34_20(var_14(var_34_11, "frame/lv_contain/lv"), arg_34_1.level)

		local var_34_21 = var_34_2
		local var_34_22 = var_34_2.IsHpSafe(var_34_21)

		findTF = var_34_21

		local var_34_23 = var_34_21(var_34_11, "blood")

		findTF = var_15

		local var_34_24 = var_15(var_34_23, "fillarea/green")

		findTF = var_16

		local var_34_25 = var_16(var_34_23, "fillarea/red")

		setActive = var_17

		var_17(var_34_24, var_34_22)

		setActive = var_17

		var_17(var_34_25, not var_34_22)

		local var_34_26 = var_34_23
		local var_34_27 = var_34_23.GetComponent

		typeof = var_19
		Slider = var_2_10020

		local var_34_28 = var_34_27(var_34_26, var_19(var_2_10020))

		var_34_28.fillRect = var_34_22 and var_34_24 or var_34_25
		setSlider = var_34_28

		var_34_28(var_34_23, 0, 10000, var_34_2.hpRant)

		setActive = var_34_28

		var_34_28(var_34_23:Find("broken"), var_34_2:IsBroken())

		getProxy = var_34_28
		ActivityProxy = var_18

		local var_34_29 = var_34_28(var_18)
		local var_34_30 = var_17.getBuffShipList(var_34_29)[arg_34_1:getGroupId()]
		local var_34_31 = var_34_11
		local var_34_32 = var_34_11.Find(var_34_31, "expbuff")

		setActive = var_34_31

		var_34_31(var_34_32, var_34_30 ~= nil)

		if var_34_30 then
			local var_34_33 = var_34_30 / 100
			local var_34_34 = var_34_30 % 100

			tostring = var_22

			local var_34_35 = var_22(var_34_33)
			local var_34_36

			if 0 < var_34_34 then
				var_34_36 = var_34_35

				local var_34_37 = "."

				tostring = var_2_10025
				var_34_35 = var_34_36 .. var_34_37 .. var_2_10025(var_34_34)
			end

			setText = var_34_36

			local var_34_38 = var_34_32
			local var_34_39 = var_34_32.Find(var_34_38, "text")

			string = var_34_38

			var_34_36(var_34_39, var_34_38.format("EXP +%s%%", var_34_35))
		end

		return
	end

	local var_33_2 = {}

	local function var_33_3(arg_35_0)
		local var_35_0 = arg_33_0
		local var_35_1 = var_1.getCurrentFleet(var_35_0)
		local var_35_2 = var_1.GetTeamShipVOs(var_35_1, arg_35_0, false)

		ipairs = var_35_1

		for iter_35_0, iter_35_1 in var_35_1(var_35_2) do
			table = var_2_10008

			var_2_10008.insert(var_33_2, function(arg_36_0)
				SpineRole = var_3_10001

				local var_36_0 = var_3_10001.New(iter_35_1)

				var_1.LoadLite(var_36_0, function()
					var_33_1(var_0, iter_35_1, arg_35_0, iter_35_0)

					onNextTick = var_0

					var_0(arg_36_0)

					return
				end)

				return
			end)
		end

		return
	end

	TeamType = var_1_10006

	var_33_3(var_1_10006.Vanguard)

	local var_33_4 = var_4

	TeamType = var_6

	var_33_4(var_6.Main)

	seriesAsync = var_33_4

	var_33_4(var_33_2, function(arg_38_0)
		if arg_33_0.exited then
			return
		end

		if arg_33_1 then
			arg_33_1()
		end

		return
	end)

	return
end

function var_0_1.showEnergyDesc(arg_39_0, arg_39_1, arg_39_2)
	LeanTween = var_1_10003

	local var_39_0 = var_1_10003.isTweening

	go = var_1_10004

	local var_39_1

	if var_39_0(var_1_10004(arg_39_0.energyDescTF)) then
		LeanTween = var_39_1
		var_39_1 = var_39_1.cancel
		go = var_4

		var_39_1(var_4(arg_39_0.energyDescTF))

		var_39_1 = arg_39_0.energyDescTF
		Vector3 = var_4
		var_39_1.localScale = var_4.one
	end

	setText = var_39_1

	var_39_1(arg_39_0.energyDescTextTF, arg_39_2)

	local var_39_2 = arg_39_0.energyDescTF

	var_39_2.position = arg_39_1
	setActive = var_39_2

	var_39_2(arg_39_0.energyDescTF, true)

	LeanTween = var_39_2

	local var_39_3 = var_39_2.scale
	local var_39_4 = arg_39_0.energyDescTF

	Vector3 = var_5

	local var_39_5 = var_39_3(var_39_4, var_5.zero, 0.2)
	local var_39_6 = var_3.setDelay(var_39_5, 1)
	local var_39_7 = var_3.setFrom

	Vector3 = var_5

	local var_39_8 = var_39_7(var_39_6, var_5.one)
	local var_39_9 = var_3.setOnComplete

	System = var_5

	var_39_9(var_39_8, var_5.Action(function()
		local var_40_0 = arg_39_0.energyDescTF

		Vector3 = var_2_10001
		var_40_0.localScale = var_2_10001.one
		setActive = var_40_0

		var_40_0(arg_39_0.energyDescTF, false)

		return
	end))

	return
end

function var_0_1.setAllCharacterPos(arg_41_0, arg_41_1)
	ipairs = var_1_10002

	local var_41_0 = arg_41_0.characterList

	TeamType = var_1_10004

	for iter_41_0, iter_41_1 in var_1_10002(var_41_0[var_1_10004.Vanguard]) do
		local var_41_1 = arg_41_0
		local var_41_2 = arg_41_0.setCharacterPos

		TeamType = var_1_10009

		var_41_2(var_41_1, var_1_10009.Vanguard, iter_41_0, iter_41_1, arg_41_1)
	end

	ipairs = var_2

	local var_41_3 = arg_41_0.characterList

	TeamType = var_4

	for iter_41_2, iter_41_3 in var_2(var_41_3[var_4.Main]) do
		local var_41_4 = arg_41_0
		local var_41_5 = arg_41_0.setCharacterPos

		TeamType = var_1_10009

		var_41_5(var_41_4, var_1_10009.Main, iter_41_2, iter_41_3, arg_41_1)
	end

	arg_41_0:sortSiblingIndex()

	return
end

function var_0_1.setCharacterPos(arg_42_0, arg_42_1, arg_42_2, arg_42_3, arg_42_4)
	local var_42_0 = arg_42_3
	local var_42_1 = arg_42_3.GetRootModel(var_42_0)

	SetActive = var_42_0

	var_42_0(var_42_1, true)

	local var_42_2 = arg_42_0.gridTFs[arg_42_1][arg_42_2].localPosition

	LeanTween = var_8

	local var_42_3 = var_8.cancel

	go = var_1_10009

	var_42_3(var_1_10009(var_42_1))

	if arg_42_4 then
		tf = var_42_3
		var_42_3 = var_42_3(var_42_1)
		Vector3 = var_9
		var_42_3.localPosition = var_9(var_42_2.x + 2, var_42_2.y - 80, var_42_2.z)
		LeanTween = var_42_3
		var_42_3 = var_42_3.moveLocalY
		go = var_9

		local var_42_4 = var_42_3(var_9(var_42_1), var_42_2.y - 110, 0.5)

		var_42_3.setDelay(var_42_4, 0.5)
	else
		tf = var_42_3
		var_42_3 = var_42_3(var_42_1)
		Vector3 = var_9
		var_42_3.localPosition = var_9(var_42_2.x + 2, var_42_2.y - 110, var_42_2.z)
	end

	SetActive = var_42_3

	var_42_3(var_6:Find("shadow"), true)
	arg_42_3:SetAction("stand", 0)

	return
end

function var_0_1.resetGrid(arg_43_0, arg_43_1)
	local var_43_0 = arg_43_0.gridTFs[arg_43_1]

	ipairs = var_1_10003

	for iter_43_0, iter_43_1 in var_1_10003(var_43_0) do
		SetActive = var_1_10008

		var_1_10008(iter_43_1:Find("shadow"), false)
	end

	return
end

function var_0_1.switchToEditMode(arg_44_0)
	local function var_44_0(arg_45_0)
		ipairs = var_2_10001

		for iter_45_0, iter_45_1 in var_2_10001(arg_45_0) do
			local var_45_0 = iter_45_1
			local var_45_1 = iter_45_1.GetRootModel(var_45_0)

			tf = var_45_0

			local var_45_2 = var_45_0(var_45_1)

			if var_7.Find(var_45_2, "mouseChild") then
				local var_45_3 = var_7:GetComponent("EventTriggerListener")

				arg_44_0.eventTriggers[var_45_3] = true

				if var_45_3 then
					var_45_3:RemovePointEnterFunc()
				end

				if iter_45_0 == arg_44_0._shiftIndex then
					local var_45_4 = var_7
					local var_45_5 = var_7.GetComponent

					typeof = var_2_10011
					Image = var_2_10012
					var_45_5(var_45_4, var_2_10011(var_2_10012)).enabled = true
				end
			end
		end

		return
	end

	local var_44_1 = arg_44_0.characterList

	TeamType = var_1_10004

	var_44_0(var_44_1[var_1_10004.Vanguard])

	local var_44_2 = var_1
	local var_44_3 = arg_44_0.characterList

	TeamType = var_4

	var_44_2(var_44_3[var_4.Main])

	arg_44_0._shiftIndex = nil

	arg_44_0:flushCharacters()

	return
end

function var_0_1.switchToShiftMode(arg_46_0, arg_46_1, arg_46_2)
	for iter_46_0 = 1, 3 do
		local var_46_0 = arg_46_0.gridTFs

		TeamType = var_1_10008

		local var_46_1 = var_46_0[var_1_10008.Vanguard][iter_46_0]

		var_1_10008 = arg_46_0.gridTFs
		TeamType = var_1_10009
		var_1_10008 = var_1_10008[var_1_10009.Main][iter_46_0]
		setActive = var_1_10009
		var_1_10011 = var_46_1

		var_1_10009(var_46_1.Find(var_1_10011, "tip"), false)

		setActive = var_1_10009
		var_1_10011 = var_1_10008

		var_1_10009(var_1_10008.Find(var_1_10011, "tip"), false)

		setActive = var_1_10009
		var_1_10011 = arg_46_0.gridTFs[arg_46_2][iter_46_0]

		var_1_10009(var_10.Find(var_1_10011, "shadow"), false)
	end

	local var_46_2 = arg_46_0.characterList[arg_46_2]

	ipairs = var_4

	for iter_46_1, iter_46_2 in var_4(var_46_2) do
		local var_46_3 = iter_46_2

		if iter_46_2.GetRootModel(var_46_3) ~= arg_46_1 then
			var_46_3 = arg_46_0.gridTFs[arg_46_2][iter_46_1]
			LeanTween = var_1_10011

			var_1_10011.moveLocalY(var_9, var_46_3.localPosition.y - 80, 0.5)

			tf = var_1_10011

			local var_46_4 = var_1_10011(var_9)
			local var_46_5 = var_1_10011.Find(var_46_4, "mouseChild")

			var_1_10011 = var_1_10011.GetComponent(var_46_5, "EventTriggerListener")
			arg_46_0.eventTriggers[var_1_10011] = true
			var_1_10013 = var_1_10011

			var_1_10011.AddPointEnterFunc(var_1_10013, function()
				ipairs = var_2_10000

				for iter_47_0, iter_47_1 in var_2_10000(var_46_2) do
					if iter_47_1:GetRootModel() == var_0 then
						local var_47_0 = arg_46_0

						var_5.shift(var_47_0, arg_46_0._shiftIndex, iter_47_0, arg_46_2)

						break
					end
				end

				return
			end)
		else
			arg_46_0._shiftIndex = iter_46_1
			tf = var_46_3
			var_1_10011 = var_46_3(var_9)
			var_1_10011 = var_10.Find(var_1_10011, "mouseChild")

			local var_46_6 = var_10.GetComponent

			typeof = var_12
			Image = var_1_10013
			var_46_6(var_1_10011, var_12(var_1_10013)).enabled = false
		end

		var_1_10011 = iter_46_2

		iter_46_2.SetAction(var_1_10011, "normal", 0)
	end

	return
end

function var_0_1.shift(arg_48_0, arg_48_1, arg_48_2, arg_48_3)
	local var_48_0 = arg_48_0.characterList[arg_48_3]
	local var_48_1 = arg_48_0.gridTFs[arg_48_3]
	local var_48_2 = var_48_0[arg_48_2]
	local var_48_3 = var_6.GetRootModel(var_48_2)
	local var_48_4 = var_48_1[arg_48_1].localPosition

	tf = var_1_10009

	local var_48_5 = var_1_10009(var_48_3)

	Vector3 = var_10
	var_48_5.localPosition = var_10(var_48_4.x + 2, var_48_4.y - 80, var_48_4.z)
	LeanTween = var_48_5

	var_48_5.cancel(var_48_3)

	var_48_0[arg_48_1], var_48_0[arg_48_2] = var_48_0[arg_48_2], var_48_0[arg_48_1]

	local var_48_6 = arg_48_0:getCurrentFleet()
	local var_48_7 = var_9.GetTeamShips(var_48_6, arg_48_3, false)

	var_9:SwitchShip(var_48_7[arg_48_1].id, var_48_7[arg_48_2].id)

	arg_48_0._shiftIndex = arg_48_2

	arg_48_0:sortSiblingIndex()

	return
end

function var_0_1.sortSiblingIndex(arg_49_0)
	local var_49_0 = 3
	local var_49_1 = 0

	while var_49_0 > 0 do
		local var_49_2 = arg_49_0.characterList

		TeamType = var_1_10004

		local var_49_3 = var_49_2[var_1_10004.Main][var_49_0]

		var_1_10004 = arg_49_0.characterList
		TeamType = var_1_10005
		var_1_10004 = var_1_10004[var_1_10005.Vanguard][var_49_0]

		if var_49_3 then
			local var_49_4 = var_49_3

			var_1_10005 = var_49_3.GetRootModel(var_49_4)
			tf = var_49_4

			local var_49_5 = var_49_4(var_1_10005)

			var_6.SetSiblingIndex(var_49_5, var_49_1)

			var_49_1 = var_49_1 + 1
		end

		if var_1_10004 then
			local var_49_6 = var_1_10004

			var_1_10005 = var_1_10004.GetRootModel(var_49_6)
			tf = var_49_6

			local var_49_7 = var_49_6(var_1_10005)

			var_6.SetSiblingIndex(var_49_7, var_49_1)

			var_49_1 = var_49_1 + 1
		end

		var_49_0 = var_49_0 - 1
	end

	return
end

function var_0_1.enabledTeamCharacter(arg_50_0, arg_50_1, arg_50_2)
	local var_50_0 = arg_50_0.characterList[arg_50_1]

	ipairs = var_1_10004

	for iter_50_0, iter_50_1 in var_1_10004(var_50_0) do
		arg_50_0:enabledCharacter(iter_50_1, arg_50_2, arg_50_1)
	end

	return
end

function var_0_1.enabledCharacter(arg_51_0, arg_51_1, arg_51_2, arg_51_3)
	if arg_51_2 then
		var_1_10005 = arg_51_1
		var_1_10004 = arg_51_1.GetRootModel(var_1_10005)
		tf = var_1_10005
		var_1_10006 = var_1_10005(var_1_10004)

		local var_51_0

		var_1_10005, var_1_10006, var_51_0 = var_1_10005.Find(var_1_10006, "mouseChild")

		if var_1_10005 then
			SetActive = var_1_10008

			var_1_10008(var_1_10005, true)
		else
			GameObject = var_1_10008
			var_1_10005 = var_1_10008("mouseChild")
			tf = var_8

			local var_51_1 = var_8(var_1_10005)
			local var_51_2 = var_8.SetParent

			tf = var_1_10010

			var_51_2(var_51_1, var_1_10010(var_1_10004))

			tf = var_51_2

			local var_51_3 = var_51_2(var_1_10005)

			Vector3 = var_9
			var_51_3.localPosition = var_9.zero
			GetOrAddComponent = var_51_3
			var_1_10006 = var_51_3(var_1_10005, "ModelDrag")
			GetOrAddComponent = var_8

			local var_51_4 = var_8(var_1_10005, "EventTriggerListener")

			arg_51_0.eventTriggers[var_51_4] = true

			var_1_10006:Init()

			local var_51_5 = var_1_10005
			local var_51_6 = var_1_10005.GetComponent

			typeof = var_10
			RectTransform = var_11

			local var_51_7 = var_51_6(var_51_5, var_10(var_11))

			Vector2 = var_51_5
			var_51_7.sizeDelta = var_51_5(2.5, 2.5)
			Vector2 = var_9
			var_51_7.pivot = var_9(0.5, 0)
			Vector2 = var_9
			var_51_7.anchoredPosition = var_9(0, 0)

			local var_51_8
			local var_51_9
			local var_51_10
			local var_51_11

			var_51_4:AddBeginDragFunc(function()
				UnityEngine = var_2_10000
				var_51_8 = var_2_10000.Screen.width
				UnityEngine = var_0
				var_51_9 = var_0.Screen.height
				rtf = var_0
				var_51_10 = var_0(arg_51_0._tf).rect.width / var_51_8
				rtf = var_0
				var_51_11 = var_0(arg_51_0._tf).rect.height / var_51_9
				LeanTween = var_0

				local var_52_0 = var_0.cancel

				go = var_1

				var_52_0(var_1(var_1_10004))

				local var_52_1 = arg_51_0

				var_0.switchToShiftMode(var_52_1, var_1_10004, arg_51_3)

				local var_52_2 = arg_51_1

				var_0.SetAction(var_52_2, "tuozhuai", 0)

				local var_52_3 = arg_51_1

				var_0.SetParent(var_52_3, arg_51_0.moveLayer, false)

				pg = var_0

				local var_52_4 = var_0.CriMgr.GetInstance()
				local var_52_5 = var_0.PlaySoundEffect_V3

				SFX_UI_HOME_DRAG = var_2

				var_52_5(var_52_4, var_2)

				return
			end)
			var_51_4:AddDragFunc(function(arg_53_0, arg_53_1)
				rtf = var_2_10002

				local var_53_0 = var_2_10002(var_1_10004)

				Vector2 = var_3
				var_53_0.anchoredPosition = var_3((arg_53_1.position.x - var_51_8 / 2) * var_51_10 + 20, (arg_53_1.position.y - var_51_9 / 2) * var_51_11 - 20)

				return
			end)
			var_51_4:AddDragEndFunc(function(arg_54_0, arg_54_1)
				local var_54_0 = arg_51_1

				var_2.SetAction(var_54_0, "tuozhuai", 0)

				tf = var_2

				local var_54_1 = var_2(var_1_10004)

				var_2.SetParent(var_54_1, arg_51_0.heroContainer, false)

				local var_54_2 = arg_51_0

				var_2.switchToEditMode(var_54_2)

				local var_54_3 = arg_51_0

				var_2.sortSiblingIndex(var_54_3)

				pg = var_2

				local var_54_4 = var_2.CriMgr.GetInstance()
				local var_54_5 = var_2.PlaySoundEffect_V3

				SFX_UI_HOME_PUT = var_4

				var_54_5(var_54_4, var_4)

				return
			end)
		end
	else
		SetActive = var_1_10004
		tf = var_1_10005
		model = var_1_10006

		local var_51_12 = var_1_10005(var_1_10006)

		var_1_10004(var_5.Find(var_51_12, "mouseChild"), false)
	end

	return
end

function var_0_1.displayFleetInfo(arg_55_0)
	local var_55_0 = arg_55_0
	local var_55_1 = arg_55_0.getCurrentFleet(var_55_0)

	_ = var_55_0

	local var_55_2 = var_55_0.reduce
	local var_55_3 = var_55_1
	local var_55_4 = var_55_1.GetTeamShipVOs

	TeamType = var_1_10005

	local var_55_5 = var_55_2(var_55_4(var_55_3, var_1_10005.Vanguard, false), 0, function(arg_56_0, arg_56_1)
		return arg_56_0 + arg_56_1:getShipCombatPower()
	end)

	_ = var_3

	local var_55_6 = var_3.reduce
	local var_55_7 = var_55_1
	local var_55_8 = var_55_1.GetTeamShipVOs

	TeamType = var_6

	local var_55_9 = var_55_6(var_55_8(var_55_7, var_6.Main, false), 0, function(arg_57_0, arg_57_1)
		return arg_57_0 + arg_57_1:getShipCombatPower()
	end)

	var_0_2.tweenNumText(arg_55_0.vanguardGS, var_55_5)
	var_0_2.tweenNumText(arg_55_0.mainGS, var_55_9)

	return
end

function var_0_1.hideStrategyInfo(arg_58_0)
	if arg_58_0.strategyPanel then
		local var_58_0 = arg_58_0.strategyPanel

		var_1.detach(var_58_0)
	end

	return
end

function var_0_1.recycleCharacterList(arg_59_0, arg_59_1, arg_59_2)
	ipairs = var_1_10003

	for iter_59_0, iter_59_1 in var_1_10003(arg_59_1) do
		if arg_59_2[iter_59_0] then
			local var_59_0 = arg_59_2[iter_59_0]

			var_8.Dispose(var_59_0)

			arg_59_2[iter_59_0] = nil
		end
	end

	return
end

function var_0_1.willExit(arg_60_0)
	arg_60_0:UnOverlayPanel(arg_60_0._tf)

	if arg_60_0.resPanel then
		local var_60_0 = arg_60_0.resPanel

		var_1.exit(var_60_0)

		arg_60_0.resPanel = nil
	end

	if arg_60_0.eventTriggers then
		pairs = var_1

		for iter_60_0, iter_60_1 in var_1(arg_60_0.eventTriggers) do
			ClearEventTrigger = var_1_10006

			var_1_10006(iter_60_0)
		end

		arg_60_0.eventTriggers = nil
	end

	if arg_60_0.tweens then
		cancelTweens = var_1

		var_1(arg_60_0.tweens)
	end

	local var_60_1 = arg_60_0:getCurrentFleet()
	local var_60_2 = arg_60_0
	local var_60_3 = arg_60_0.recycleCharacterList
	local var_60_4 = var_60_1
	local var_60_5 = var_60_1.GetTeamShipVOs

	TeamType = var_1_10006

	local var_60_6 = var_60_5(var_60_4, var_1_10006.Main, false)
	local var_60_7 = arg_60_0.characterList

	TeamType = var_6

	var_60_3(var_60_2, var_60_6, var_60_7[var_6.Main])

	local var_60_8 = arg_60_0
	local var_60_9 = arg_60_0.recycleCharacterList
	local var_60_10 = var_60_1
	local var_60_11 = var_60_1.GetTeamShipVOs

	TeamType = var_6

	local var_60_12 = var_60_11(var_60_10, var_6.Vanguard, false)
	local var_60_13 = arg_60_0.characterList

	TeamType = var_6

	var_60_9(var_60_8, var_60_12, var_60_13[var_6.Vanguard])

	return
end

function var_0_1.Clone2Full(arg_61_0, arg_61_1)
	local var_61_0 = {}
	local var_61_1 = arg_61_0:GetChild(0)
	local var_61_2 = arg_61_0.childCount

	for iter_61_0 = 0, var_61_2 - 1 do
		table = var_1_10009
		var_1_10009 = var_1_10009.insert

		local var_61_3 = var_61_0

		var_1_10012 = arg_61_0

		var_1_10009(var_61_3, arg_61_0.GetChild(var_1_10012, iter_61_0))
	end

	for iter_61_1 = var_61_2, arg_61_1 - 1 do
		cloneTplTo = var_1_10009
		var_1_10009 = var_1_10009(var_61_1, arg_61_0)
		table = var_10

		local var_61_4 = var_10.insert
		local var_61_5 = var_61_0

		tf = var_1_10012

		var_61_4(var_61_5, var_1_10012(var_1_10009))
	end

	return var_61_0
end

function var_0_1.TransformColor(arg_62_0)
	tonumber = var_1_10001
	string = var_1_10002

	local var_62_0 = var_1_10001(var_1_10002.sub(arg_62_0, 1, 2), 16)

	tonumber = var_2
	string = var_3

	local var_62_1 = var_2(var_3.sub(arg_62_0, 3, 4), 16)

	tonumber = var_3
	string = var_4

	local var_62_2 = var_3(var_4.sub(arg_62_0, 5, 6), 16)

	Color = var_4

	return var_4.New(var_62_0 / 255, var_62_1 / 255, var_62_2 / 255)
end

return var_0_1

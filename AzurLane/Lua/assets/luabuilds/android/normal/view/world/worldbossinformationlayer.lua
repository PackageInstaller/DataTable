class = var_0_10000

local var_0_0 = "WorldBossInformationLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))
local var_0_2 = 25
local var_0_3 = 7.2

function var_0_1.getUIName(arg_1_0)
	return "WorldBossInformationUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.bg = var_1.Find(var_2_0, "bg")

	local var_2_1 = arg_2_0._tf

	arg_2_0.layer = var_1.Find(var_2_1, "fixed")

	local var_2_2 = arg_2_0.layer

	arg_2_0.top = var_1.Find(var_2_2, "top")

	local var_2_3 = arg_2_0.top

	arg_2_0.backBtn = var_1.Find(var_2_3, "back_btn")

	local var_2_4 = arg_2_0.top

	arg_2_0.homeBtn = var_1.Find(var_2_4, "option")

	local var_2_5 = arg_2_0.top

	arg_2_0.playerResOb = var_1.Find(var_2_5, "playerRes")
	WorldResource = var_1
	arg_2_0.resPanel = var_1.New()
	tf = var_1

	local var_2_6 = var_1(arg_2_0.resPanel._go)
	local var_2_7 = var_1.SetParent

	tf = var_3

	var_2_7(var_2_6, var_3(arg_2_0.playerResOb), false)

	local var_2_8 = arg_2_0.layer

	arg_2_0.startBtn = var_1.Find(var_2_8, "battle")

	local var_2_9 = arg_2_0.layer

	arg_2_0.retreatBtn = var_1.Find(var_2_9, "retreat")

	local var_2_10 = arg_2_0.layer

	arg_2_0.hpbar = var_1.Find(var_2_10, "hp")

	local var_2_11 = arg_2_0.layer
	local var_2_12 = var_1.Find(var_2_11, "drop")

	CustomIndexLayer = var_2_11
	arg_2_0.dropitems = var_2_11.Clone2Full(var_2_12:Find("items"), 5)
	arg_2_0.dropright = var_2_12:Find("right")
	arg_2_0.dropleft = var_2_12:Find("left")

	local var_2_13 = arg_2_0.layer

	arg_2_0.awardBtn = var_2.Find(var_2_13, "showAward")

	local var_2_14 = arg_2_0.layer

	arg_2_0.weaknesstext = var_2.Find(var_2_14, "text")

	local var_2_15 = arg_2_0.layer

	arg_2_0.weaknessbg = var_2.Find(var_2_15, "boss_ruodian")

	local var_2_16 = arg_2_0.layer

	arg_2_0.downBG = var_2.Find(var_2_16, "BlurBG")

	local var_2_17 = arg_2_0.layer

	arg_2_0.buffListTF = var_2.Find(var_2_17, "BuffList")

	local var_2_18 = arg_2_0.buffListTF
	local var_2_19 = var_2.GetComponent

	typeof = var_4
	Animator = var_5
	arg_2_0.buffListAnimator = var_2_19(var_2_18, var_4(var_5))

	local var_2_20 = arg_2_0.layer

	arg_2_0.AdditionBuffTF = var_2.Find(var_2_20, "BuffList/tezhuangmokuai")

	local var_2_21 = arg_2_0.AdditionBuffTF

	arg_2_0.AdditionBuffContainer = var_2.Find(var_2_21, "buff")

	local var_2_22 = arg_2_0.layer

	arg_2_0.EquipmentBuffTF = var_2.Find(var_2_22, "BuffList/wuzhuangjiexi")

	local var_2_23 = arg_2_0.EquipmentBuffTF

	arg_2_0.EquipmentBuffContainer = var_2.Find(var_2_23, "buff")

	local var_2_24 = arg_2_0.layer

	arg_2_0.switchBuffBtn = var_2.Find(var_2_24, "BuffList/Switcher")
	arg_2_0.ShowBuffIndex = 0

	local var_2_25 = arg_2_0.layer

	arg_2_0.attributeRoot = var_2.Find(var_2_25, "attributes")
	arg_2_0.attributeRootAnchorY = arg_2_0.attributeRoot.anchoredPosition.y
	CustomIndexLayer = var_2

	local var_2_26 = var_2.Clone2Full
	local var_2_27 = arg_2_0.layer

	arg_2_0.attributes = var_2_26(var_3.Find(var_2_27, "attributes"), 3)

	for iter_2_0 = 1, #arg_2_0.attributes do
		local var_2_28 = arg_2_0.attributes[iter_2_0]
		local var_2_29 = var_1_10006.Find(var_2_28, "extra").gameObject

		var_1_10006.SetActive(var_2_29, false)

		setText = var_1_10006

		local var_2_30 = arg_2_0.attributes[iter_2_0]
		local var_2_31 = var_7.Find(var_2_30, "extra/desc")

		i18n = var_2_30

		var_1_10006(var_2_31, var_2_30("world_mapbuff_compare_txt") .. "：")
	end

	local var_2_32 = arg_2_0.layer
	local var_2_33 = var_2.Find(var_2_32, "bossname")
	local var_2_34 = var_2.Find(var_2_33, "name")
	local var_2_35 = var_3.GetComponent

	typeof = var_5
	Text = var_1_10006
	arg_2_0.bossnameText = var_2_35(var_2_34, var_5(var_1_10006))
	arg_2_0.bossNameBanner = var_2:Find("name/banner")

	local var_2_36 = arg_2_0.bossNameBanner

	arg_2_0.bosslevel = var_3.Find(var_2_36, "level")
	arg_2_0.bosslogos = {
		var_2:Find("name/bosslogo_01"),
		(var_2:Find("name/bosslogo_02"))
	}

	local var_2_37 = arg_2_0.bossNameBanner

	arg_2_0.bossTypeIcon = var_3.Find(var_2_37, "Type/Icon")

	local var_2_38 = arg_2_0.bossNameBanner

	arg_2_0.bossArmorText = var_3.Find(var_2_38, "Type/Armor")

	local var_2_39 = arg_2_0.layer

	arg_2_0.saomiaoxian = var_3.Find(var_2_39, "saomiao")

	local var_2_40 = arg_2_0.saomiaoxian

	arg_2_0.bosssprite = var_3.Find(var_2_40, "qimage")

	local var_2_41 = arg_2_0.layer

	arg_2_0.dangerMark = var_3.Find(var_2_41, "danger_mark")
	AutoLoader = var_3
	arg_2_0.loader = var_3.New()
	arg_2_0.dungeonDict = {}

	return
end

function var_0_1.didEnter(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.backBtn

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.closeView(var_4_0)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.homeBtn

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.quickExitFunc(var_5_0)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10005)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.startBtn

	local function var_3_8()
		local var_6_0 = arg_3_0
		local var_6_1 = var_0.emit

		WorldBossInformationMediator = var_2_10002

		local var_6_2 = var_2_10002.OnOpenSublayer

		Context = var_2_10003

		local var_6_3 = var_2_10003.New
		local var_6_4 = {}

		WorldPreCombatMediator = var_2_10005
		var_6_4.mediator = var_2_10005
		WorldPreCombatLayer = var_2_10005
		var_6_4.viewComponent = var_2_10005

		var_6_1(var_6_0, var_6_2, var_6_3(var_6_4), true, function()
			local var_7_0 = arg_3_0

			var_0.closeView(var_7_0)

			return
		end)

		return
	end

	SFX_UI_WEIGHANCHOR = var_1_10005

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10005)

	onButton = var_1_10001

	local var_3_9 = arg_3_0
	local var_3_10 = arg_3_0.retreatBtn

	local function var_3_11()
		local var_8_0 = arg_3_0
		local var_8_1 = var_0.emit

		WorldBossInformationMediator = var_2_10002

		var_8_1(var_8_0, var_2_10002.RETREAT_FLEET)

		local var_8_2 = arg_3_0

		var_0.closeView(var_8_2)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1_10001(var_3_9, var_3_10, var_3_11, var_1_10005)

	onButton = var_1_10001

	local var_3_12 = arg_3_0
	local var_3_13 = arg_3_0.switchBuffBtn

	local function var_3_14()
		arg_3_0.ShowBuffIndex = 1 - arg_3_0.ShowBuffIndex

		local var_9_0 = arg_3_0.ShowBuffIndex == 1 and "switchOn" or "switchOff"
		local var_9_1 = arg_3_0.buffListAnimator

		var_1.Play(var_9_1, var_9_0, -1, 0)

		if var_9_0 == "switchOn" then
			local var_9_2 = arg_3_0.EquipmentBuffTF

			var_1.SetAsLastSibling(var_9_2)
		else
			local var_9_3 = arg_3_0.AdditionBuffTF

			var_1.SetAsLastSibling(var_9_3)
		end

		local var_9_4 = arg_3_0.switchBuffBtn

		var_1.SetAsLastSibling(var_9_4)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_12, var_3_13, var_3_14, var_1_10005)

	onButton = var_1_10001

	local var_3_15 = arg_3_0
	local var_3_16 = arg_3_0.awardBtn

	local function var_3_17()
		local var_10_0 = arg_3_0
		local var_10_1 = var_0.GetAwardPanel(var_10_0).buffer
		local var_10_2 = var_0.UpdateView
		local var_10_3 = arg_3_0

		var_10_2(var_10_1, var_2.GetCurrentAttachment(var_10_3))

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_15, var_3_16, var_3_17, var_1_10005)
	arg_3_0:updateStageView()

	local var_3_18 = arg_3_0.loader

	var_1.LoadPrefab(var_3_18, "ui/xuetiao01", "", nil, function(arg_11_0)
		setParent = var_2_10001

		var_2_10001(arg_11_0, arg_3_0.layer)

		tf = var_2_10001

		local var_11_0 = var_2_10001(arg_11_0)
		local var_11_1 = var_1.Find(var_11_0, "qipao")

		setParent = var_11_0

		local var_11_2 = var_11_1
		local var_11_3 = arg_3_0.hpbar

		var_11_0(var_11_2, var_4.Find(var_11_3, "hp"), false)

		setLocalPosition = var_11_0

		var_11_0(var_11_1, {
			x = 0,
			y = 0
		})

		tf = var_11_0

		local var_11_4 = var_11_0(arg_11_0)
		local var_11_5 = var_2.Find(var_11_4, "xuetiao01")
		local var_11_6 = arg_3_0
		local var_11_7 = var_11_5
		local var_11_8 = var_11_5.GetComponent

		typeof = var_6
		Renderer = var_2_10007
		var_11_6.hpeffectmat = var_11_8(var_11_7, var_6(var_2_10007)).material
		setParent = var_11_6

		var_11_6(var_11_5, arg_3_0.hpbar, false)

		setLocalPosition = var_11_6

		var_11_6(var_11_5, {
			x = 0,
			y = 0
		})

		local var_11_9 = arg_3_0

		var_3.UpdateHpbar(var_11_9)

		return
	end)

	pg = var_1

	local var_3_19 = var_1.UIMgr.GetInstance()

	var_1.OverlayPanel(var_3_19, arg_3_0._tf)

	pg = var_1

	local var_3_20 = var_1.UIMgr.GetInstance()

	var_1.OverlayPanel(var_3_20, arg_3_0.layer, {
		pbList = {
			arg_3_0.downBG,
			arg_3_0.attributes[1],
			arg_3_0.attributes[2],
			arg_3_0.attributes[3],
			arg_3_0.top,
			arg_3_0.AdditionBuffTF,
			arg_3_0.EquipmentBuffTF
		}
	})

	return
end

function var_0_1.setPlayerInfo(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0.resPanel

	var_2.setPlayer(var_12_0, arg_12_1)

	setActive = var_2

	local var_12_1 = arg_12_0.resPanel._tf

	nowWorld = var_4

	local var_12_2 = var_4()
	local var_12_3 = var_4.IsSystemOpen

	WorldConst = var_1_10006

	var_2(var_12_1, var_12_3(var_12_2, var_1_10006.SystemResource))

	return
end

function var_0_1.getCurrentFleet(arg_13_0)
	nowWorld = var_1_10001

	local var_13_0 = var_1_10001()

	return var_1.GetFleet(var_13_0)
end

function var_0_1.GetCurrentAttachment(arg_14_0)
	nowWorld = var_1_10001

	local var_14_0 = var_1_10001()
	local var_14_1 = var_1.GetActiveMap(var_14_0)
	local var_14_2 = var_1.GetFleet(var_14_1)
	local var_14_3 = var_1:GetCell(var_14_2.row, var_14_2.column)

	return var_3.GetAliveAttachment(var_14_3), var_1.config.difficulty
end

function var_0_1.GetEnemyLevel(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1.difficulty

	ys = var_1_10003

	if var_15_0 == var_1_10003.Battle.BattleConst.Difficulty.WORLD then
		nowWorld = var_15_0

		local var_15_1 = var_15_0()
		local var_15_2 = var_2.GetActiveMap(var_15_1)

		WorldConst = var_15_1

		return var_15_1.WorldLevelCorrect(var_15_2.config.expedition_level, arg_15_1.type)
	else
		return arg_15_1.level
	end

	return
end

function var_0_1.UpdateHpbar(arg_16_0)
	local var_16_0 = arg_16_0:GetCurrentAttachment()
	local var_16_1 = arg_16_0:GetDungeonBossData(var_16_0).bossData.hpBarNum
	local var_16_2

	if not var_16_0:GetHP() then
		var_16_2 = 10000
	end

	local var_16_3 = var_16_1 * var_16_2 / 16

	math = var_1_10005

	local var_16_4 = var_1_10005.ceil(var_16_3)

	setSlider = var_5

	var_5(arg_16_0.hpbar, 0, var_16_1, var_16_4)

	setText = var_5

	local var_16_5 = arg_16_0.hpbar
	local var_16_6 = var_6.Find(var_16_5, "hpcur")

	string = var_16_5

	var_5(var_16_6, var_16_5.format("%d", var_16_4))

	setText = var_5

	local var_16_7 = arg_16_0.hpbar

	var_5(var_6.Find(var_16_7, "hpamount"), var_16_1)

	local var_16_8 = arg_16_0.hpbar
	local var_16_9 = var_5.Find(var_16_8, "hp/mask")

	if arg_16_0.hpeffectmat then
		local var_16_10 = arg_16_0.hpeffectmat

		var_6.SetFloat(var_16_10, "_Mask", var_16_2 / 100)

		local var_16_11 = arg_16_0.hpbar
		local var_16_12 = var_6.Find(var_16_11, "hp").rect

		Vector3 = var_16_11
		var_16_9.localScale = var_16_11(var_16_12.width * var_0_2, var_16_12.height * var_0_2, 1)
		Vector3 = var_7
		var_16_9.localPosition = var_7.zero
		math = var_7

		local var_16_13 = var_7.clamp

		Screen = var_8

		local var_16_14 = var_8.width

		Screen = var_9

		local var_16_15 = var_16_13(var_16_14 / var_9.height, 1.7777777777777777, 2) / 1.7777777777777777

		setLocalScale = var_9

		local var_16_16 = arg_16_0.hpbar

		var_9(var_1_10010.Find(var_16_16, "xuetiao01"), {
			x = var_16_15
		})
	end

	local var_16_17 = arg_16_0.hpbar
	local var_16_18 = var_6.Find(var_16_17, "rewards")
	local var_16_19 = var_16_0
	local var_16_20 = var_16_0.GetBattleStageId(var_16_19)

	pg = var_16_19

	local var_16_21 = var_16_19.world_expedition_data[var_16_20] and var_8.phase_drop

	setActive = var_1_10010

	local var_16_22 = var_16_18
	local var_16_24

	if var_16_21 then
		::label_16_0::

		local var_16_23 = #var_16_21

		var_16_24 = 0 < var_16_23
	end

	var_1_10010(var_16_22, var_16_24)

	local var_16_25 = var_16_2
	local var_16_26

	if var_16_0:IsPeriodEnemy() then
		math = var_16_26
		var_16_26 = var_16_26.min

		local var_16_27 = var_16_25

		nowWorld = var_1_10013

		local var_16_28 = var_1_10013()

		var_16_25 = var_16_26(var_16_27, var_13.GetHistoryLowestHP(var_16_28, var_16_0.id))
	end

	UIItemList = var_16_26

	local var_16_29 = var_16_26.StaticAlign
	local var_16_30 = var_16_18
	local var_16_31 = var_16_18:GetChild(0)
	local var_16_32

	if not var_16_21 or not #var_16_21 then
		var_16_32 = 0
	end

	var_16_29(var_16_30, var_16_31, var_16_32, function(arg_17_0, arg_17_1, arg_17_2)
		UIItemList = var_2_10003

		if arg_17_0 ~= var_2_10003.EventUpdate then
			return
		end

		local var_17_0 = var_16_21[arg_17_1 + 1][1] / 16

		Vector2 = var_2_10005
		arg_17_2.anchorMin = var_2_10005(var_17_0, 0.5)
		Vector2 = var_5
		arg_17_2.anchorMax = var_5(var_17_0, 0.5)
		setAnchoredPosition = var_5

		var_5(arg_17_2, {
			x = 0
		})

		local var_17_1 = var_16_25 <= var_3[1] and "reward_empty" or "reward"
		local var_17_2 = arg_16_0.loader

		var_6.GetSprite(var_17_2, "ui/worldbossinformationui_atlas", var_17_1, arg_17_2)

		return
	end)

	local var_16_33 = arg_16_0.hpbar
	local var_16_34 = var_11.Find(var_16_33, "kedu")

	setLocalScale = var_16_33

	var_16_33(var_16_34, {
		x = arg_16_0.hpbar.rect.width / var_16_34.rect.width
	})

	return
end

function var_0_1.GetDungeonBossData(arg_18_0, arg_18_1)
	assert = var_1_10002

	var_1_10002(arg_18_1, "Attachment is null")

	local var_18_0 = arg_18_1.config.dungeon_id
	local var_18_1 = arg_18_0:GetDungeonFile(var_18_0).stages[1].waves
	local var_18_2

	_ = var_1_10006

	var_1_10006.any(var_18_1, function(arg_19_0)
		if not arg_19_0.spawn then
			return
		end

		_ = var_1

		return var_1.any(arg_19_0.spawn, function(arg_20_0)
			if arg_20_0.bossData then
				var_18_2 = arg_20_0

				return true
			end

			return
		end)
	end)

	assert = var_6

	var_6(var_18_2, "Cant Find Boss Data in Dungeon: " .. (var_18_0 or "NIL"))

	return var_18_2
end

function var_0_1.GetDungeonFile(arg_21_0, arg_21_1)
	if arg_21_0.dungeonDict[arg_21_1] then
		return arg_21_0.dungeonDict[arg_21_1]
	end

	ys = var_2

	local var_21_0 = var_2.Battle.BattleDataFunction.GetDungeonTmpDataByID(arg_21_1)

	arg_21_0.dungeonDict[arg_21_1] = var_21_0

	return var_21_0
end

local var_0_4 = 212
local var_0_5 = 40
local var_0_6 = "fe2222"
local var_0_7 = "92fc63"
local var_0_8 = 70

function var_0_1.updateStageView(arg_22_0)
	local var_22_0, var_22_1 = arg_22_0:GetCurrentAttachment()
	local var_22_2 = var_22_0
	local var_22_3 = var_22_0.GetBattleStageId(var_22_2)

	pg = var_22_2

	local var_22_4 = var_22_2.expedition_data_template[var_22_3]

	pg = var_1_10005

	local var_22_5 = var_1_10005.world_expedition_data[var_22_3]

	assert = var_1_10006

	var_1_10006(var_22_4, "expedition_data_template not exist: " .. var_22_3)

	local var_22_6 = {}

	ipairs = var_7

	for iter_22_0, iter_22_1 in var_7(var_22_5.award_display_world) do
		if var_22_1 == iter_22_1[1] then
			var_22_6 = iter_22_1[2]
		end
	end

	local var_22_7 = 0

	local function var_22_8()
		for iter_23_0 = 1, #arg_22_0.dropitems do
			local var_23_0 = arg_22_0.dropitems[iter_23_0]
			local var_23_1 = var_4.Find(var_23_0, "item_tpl")
			local var_23_2 = var_22_6[iter_23_0 + var_22_7]

			setActive = var_6

			var_6(var_23_1, var_23_2 ~= nil)

			if var_23_2 then
				local var_23_3 = {
					type = var_23_2[1],
					id = var_23_2[2]
				}

				updateDrop = var_7

				var_7(var_23_1, var_23_3)

				onButton = var_7

				local var_23_4 = arg_22_0
				local var_23_5 = var_23_1

				local function var_23_6()
					local var_24_0 = arg_22_0

					var_0.emit(var_24_0, var_0_1.ON_DROP, var_23_3)

					return
				end

				SFX_PANEL = var_2_10011

				var_7(var_23_4, var_23_5, var_23_6, var_2_10011)
			end
		end

		setActive = var_0

		var_0(arg_22_0.dropleft, var_22_7 > 0)

		setActive = var_0

		var_0(arg_22_0.dropright, #var_22_6 - var_22_7 > #arg_22_0.dropitems)

		return
	end

	onButton = var_9

	var_9(arg_22_0, arg_22_0.dropright, function()
		var_22_7 = var_22_7 + 1

		var_22_8()

		return
	end)

	onButton = var_9

	var_9(arg_22_0, arg_22_0.dropleft, function()
		var_22_7 = var_22_7 - 1

		var_22_8()

		return
	end)
	var_22_8()

	setActive = var_9

	local var_22_9 = arg_22_0.awardBtn
	local var_22_10

	if var_22_5.phase_drop_display then
		var_22_10 = #var_22_5.phase_drop_display > 0
	end

	var_9(var_22_9, var_22_10)

	local var_22_11 = var_22_0
	local var_22_12 = var_22_0.GetWeaknessBuffId(var_22_11)

	pg = var_22_11

	local var_22_13 = var_22_11.world_SLGbuff_data[var_22_12]

	setActive = var_22_10

	var_22_10(arg_22_0.weaknesstext, var_22_13 ~= nil)

	setActive = var_22_10

	var_22_10(arg_22_0.weaknessbg, var_22_13 ~= nil)

	local var_22_14

	if var_22_13 then
		setText = var_22_10
		var_22_14 = arg_22_0.weaknesstext
		i18n = var_13

		var_22_10(var_22_14, var_13("word_weakness") .. ": " .. var_22_13.desc)
	end

	local var_22_15

	if var_22_13 ~= nil or not var_0_8 then
		var_22_15 = 0
	end

	setAnchoredPosition = var_22_14

	var_22_14(arg_22_0.attributeRoot, {
		y = arg_22_0.attributeRootAnchorY - var_22_15
	})
	;(function()
		nowWorld = var_2_10000

		local var_27_0 = var_2_10000()
		local var_27_1 = var_0.GetActiveMap(var_27_0)

		table = var_27_0

		local var_27_2 = var_27_0.mergeArray
		local var_27_3 = var_22_0
		local var_27_4 = var_2.GetBuffList(var_27_3)
		local var_27_5 = var_27_1
		local var_27_6 = var_27_1.GetBuffList

		WorldMap = var_2_10005

		local var_27_7 = var_27_2(var_27_4, var_27_6(var_27_5, var_2_10005.FactionEnemy, var_22_0))

		_ = var_27_4

		local var_27_8 = var_27_4.filter(var_27_7, function(arg_28_0)
			return arg_28_0.id ~= var_22_12
		end)

		UIItemList = var_2

		local var_27_9 = var_2.StaticAlign
		local var_27_10 = arg_22_0.AdditionBuffContainer
		local var_27_11 = arg_22_0.AdditionBuffContainer

		var_27_9(var_27_10, var_4.GetChild(var_27_11, 0), #var_27_8, function(arg_29_0, arg_29_1, arg_29_2)
			UIItemList = var_3_10003

			if arg_29_0 ~= var_3_10003.EventUpdate then
				return
			end

			local var_29_0 = var_27_8[arg_29_1 + 1]

			setActive = var_4

			var_4(arg_29_2, var_29_0)

			if var_29_0 then
				local var_29_1 = arg_22_0.loader

				var_4.GetSprite(var_29_1, "world/buff/" .. var_29_0.config.icon, "", arg_29_2:Find("icon"))

				setText = var_4

				var_4(arg_29_2:Find("desc"), var_29_0.config.desc)
			end

			return
		end)

		return
	end)()
	;(function()
		local var_30_0

		if not var_22_5.special_buff_display or #var_30_0 == 0 then
			var_30_0 = nil
		end

		setActive = var_2_10001

		var_2_10001(arg_22_0.EquipmentBuffTF, var_30_0)

		setActive = var_2_10001

		var_2_10001(arg_22_0.switchBuffBtn, var_30_0)

		if not var_30_0 then
			return
		end

		_ = var_2_10001

		local var_30_1 = var_2_10001.map(var_30_0, function(arg_31_0)
			assert = var_3_10001

			var_3_10001("world_SLGbuff_data Missing ID: " .. (arg_31_0 or "NIL"))

			pg = var_3_10001

			return var_3_10001.world_SLGbuff_data[arg_31_0]
		end)

		UIItemList = var_2

		local var_30_2 = var_2.StaticAlign
		local var_30_3 = arg_22_0.EquipmentBuffContainer
		local var_30_4 = arg_22_0.EquipmentBuffContainer

		var_30_2(var_30_3, var_4.GetChild(var_30_4, 0), #var_30_1, function(arg_32_0, arg_32_1, arg_32_2)
			UIItemList = var_3_10003

			if arg_32_0 ~= var_3_10003.EventUpdate then
				return
			end

			local var_32_0 = var_30_1[arg_32_1 + 1]

			setActive = var_4

			var_4(arg_32_2, var_32_0)

			if var_32_0 then
				local var_32_1 = arg_22_0.loader

				var_4.GetSprite(var_32_1, "world/buff/" .. var_32_0.icon, "", arg_32_2:Find("icon"))

				setText = var_4

				var_4(arg_32_2:Find("desc"), var_32_0.desc)
			end

			return
		end)

		return
	end)()

	Canvas = var_14

	var_14.ForceUpdateCanvases()

	local var_22_16 = arg_22_0.AdditionBuffTF.rect.height
	local var_22_17 = arg_22_0.EquipmentBuffTF.rect.height

	math = var_1_10016

	local var_22_18

	var_22_18.y, var_22_18 = var_1_10016.max(var_22_16, var_22_17) + 50, arg_22_0.buffListTF.sizeDelta
	arg_22_0.buffListTF.sizeDelta = var_22_18

	local var_22_19 = arg_22_0

	arg_22_0.UpdateHpbar(var_22_19)

	ys = var_18

	local var_22_20 = var_18.Battle.BattleFormulas

	nowWorld = var_22_19

	local var_22_21 = var_22_19()
	local var_22_22 = var_19.GetWorldMapDifficultyBuffLevel(var_22_21)
	local var_22_23 = {
		var_22_22[1] * (1 + var_22_5.expedition_sairenvalueA / 16),
		var_22_22[2] * (1 + var_22_5.expedition_sairenvalueB / 16),
		var_22_22[3] * (1 + var_22_5.expedition_sairenvalueC / 16)
	}
	local var_22_24 = var_19:GetWorldMapBuffLevel()
	local var_22_25, var_22_26, var_22_27 = var_22_20.WorldMapRewardAttrEnhance(var_22_23, var_22_24)
	local var_22_28 = 1 - var_22_20.WorldMapRewardHealingRate(var_22_23, var_22_24)
	local var_22_29 = {
		var_22_25,
		var_22_26,
		var_22_28
	}

	for iter_22_2 = 1, #arg_22_0.attributes do
		var_1_10032 = arg_22_0.attributes[iter_22_2]
		setText = var_1_10033
		var_1_10035 = var_1_10032

		local var_22_30 = var_1_10032.Find(var_1_10035, "digit")

		string = var_1_10035

		var_1_10033(var_22_30, var_1_10035.format("%d", var_22_23[iter_22_2]))

		if iter_22_2 ~= 3 or not (1 - var_22_29[iter_22_2]) then
			var_1_10033 = var_22_29[iter_22_2] + 1
		end

		setText = var_22_30
		var_1_10036 = var_1_10032
		var_1_10035 = var_1_10032.Find(var_1_10036, "desc")
		i18n = var_1_10036
		var_1_10036 = var_1_10036("world_mapbuff_attrtxt_" .. iter_22_2)
		string = var_37

		var_22_30(var_1_10035, var_1_10036 .. var_37.format(" %d%%", var_1_10033 * 100))

		GetOrAddComponent = var_22_30
		var_1_10035 = var_1_10032
		typeof = var_1_10036
		UILongPressTrigger = var_37
		var_1_10036 = var_22_30(var_1_10035, var_1_10036(var_37)).onPressed

		var_1_10035.RemoveAllListeners(var_1_10036)

		var_1_10036 = var_34.onReleased

		var_1_10035.RemoveAllListeners(var_1_10036)

		var_1_10035 = nil
		var_1_10036 = nil

		local var_22_31 = var_34.onPressed

		var_37.AddListener(var_22_31, function()
			go = var_2_10000

			local var_33_0 = var_1_10032

			var_1_10035 = var_2_10000(var_1.Find(var_33_0, "extra")).activeSelf
			setActive = var_0

			local var_33_1 = var_1_10032

			var_0(var_1.Find(var_33_1, "extra"), true)

			Time = var_0
			var_1_10036 = var_0.realtimeSinceStartup

			return
		end)

		local var_22_32 = var_34.onReleased

		var_37.AddListener(var_22_32, function()
			if var_1_10036 then
				Time = var_0

				if var_0.realtimeSinceStartup - var_1_10036 < 0.3 then
					setActive = var_0

					local var_34_0 = var_1_10032

					var_0(var_1.Find(var_34_0, "extra"), not var_1_10035)
				else
					setActive = var_0

					local var_34_1 = var_1_10032

					var_0(var_1.Find(var_34_1, "extra"), false)
				end

				return
			end
		end)

		setText = var_37

		var_37(var_1_10032:Find("extra/enemy"), var_22_23[iter_22_2])

		setText = var_37

		var_37(var_1_10032:Find("extra/ally"), var_22_24[iter_22_2])

		setText = var_37

		local var_22_33 = var_1_10032
		local var_22_34 = var_1_10032.Find(var_22_33, "extra/result")

		string = var_22_33

		var_37(var_22_34, var_22_33.format("%d%%", var_22_29[iter_22_2] * 100))

		setTextColor = var_37

		local var_22_35 = var_1_10032:Find("extra/result")
		local var_22_36

		if not (var_22_29[iter_22_2] > 0) or not arg_22_0.TransformColor(var_0_6) then
			var_22_36 = arg_22_0.TransformColor(var_0_7)
		end

		var_37(var_22_35, var_22_36)

		setText = var_37

		var_37(var_1_10032:Find("extra/result/arrow"), var_22_29[iter_22_2] == 0 and "" or var_22_29[iter_22_2] > 0 and "↑" or "↓")

		if var_22_29[iter_22_2] ~= 0 then
			setTextColor = var_37

			local var_22_37 = var_1_10032:Find("extra/result/arrow")
			local var_22_38

			if not (var_22_29[iter_22_2] > 0) or not arg_22_0.TransformColor(var_0_6) then
				var_22_38 = arg_22_0.TransformColor(var_0_7)
			end

			var_37(var_22_37, var_22_38)
		end

		local var_22_39 = var_1_10032:Find("extra/allybar")
		local var_22_40 = var_1_10032
		local var_22_41 = var_1_10032.Find(var_22_40, "extra/enemybar")

		math = var_22_40

		local var_22_42 = var_22_40.clamp(1 + var_22_29[iter_22_2], 0.75, 3)
		local var_22_43 = var_1_10032
		local var_22_44 = var_1_10032.Find(var_22_43, "extra").rect.width

		Vector2 = var_22_43
		var_22_41.sizeDelta = var_22_43(var_22_42 * var_22_44 / (var_22_42 + 1) + var_0_3 * 0.5, var_22_41.sizeDelta.y)
		Vector2 = var_41
		var_22_39.sizeDelta = var_41(1 * var_22_44 / (var_22_42 + 1) + var_0_3 * 0.5, var_22_39.sizeDelta.y)
	end

	local var_22_45 = var_22_5.battle_character and #var_22_45 > 0 and var_22_45 or "world_boss_0"
	local var_22_46 = arg_22_0.bg
	local var_22_47 = var_30.GetComponent

	typeof = var_1_10032
	Image = var_1_10033

	local var_22_48 = var_22_47(var_22_46, var_1_10032(var_1_10033))

	var_22_48.enabled = true
	setImageSprite = var_22_48

	local var_22_49 = arg_22_0.bg

	GetSpriteFromAtlas = var_32

	var_22_48(var_22_49, var_32("commonbg/" .. var_22_45, var_22_45))
	;(function()
		local var_35_0 = var_22_4.name

		arg_22_0.bossnameText.text = var_35_0

		local var_35_1 = false
		local var_35_2

		if arg_22_0.bossnameText.preferredWidth > arg_22_0.bossnameText.transform.rect.width then
			string = var_35_2
			var_35_2.text, var_35_2 = var_35_2.gsub(var_35_0, "「.-」", "\n%1"), arg_22_0.bossnameText
			var_35_1 = true
		end

		setAnchoredPosition = var_35_2

		var_35_2(arg_22_0.bossNameBanner, {
			y = var_35_1 and -18 or 0
		})

		setText = var_35_2

		local var_35_3 = arg_22_0.bosslevel

		i18n = var_4

		local var_35_4 = "world_level_prefix"
		local var_35_5 = arg_22_0
		local var_35_6

		if not var_6.GetEnemyLevel(var_35_5, var_22_4) then
			var_35_6 = 1
		end

		var_35_2(var_35_3, var_4(var_35_4, var_35_6))

		setActive = var_35_2

		var_35_2(arg_22_0.bosslogos[1], var_0)

		setActive = var_35_2

		var_35_2(arg_22_0.bosslogos[2], not var_0)

		setActive = var_35_2

		var_35_2(arg_22_0.saomiaoxian, not var_0)

		local var_35_7 = arg_22_0
		local var_35_8 = var_2.GetDungeonBossData(var_35_7, var_22_0).monsterTemplateID

		ys = var_35_7

		local var_35_9 = var_35_7.Battle.BattleDataFunction.GetMonsterTmpDataFromID(var_35_8)
		local var_35_10 = arg_22_0.loader
		local var_35_11 = var_4.GetSprite
		local var_35_12 = "shiptype"

		ShipType = var_35_5

		var_35_11(var_35_10, var_35_12, var_35_5.Type2BattlePrint(var_35_9.type), arg_22_0.bossTypeIcon, true)

		setText = var_35_11

		local var_35_13 = arg_22_0.bossArmorText

		ArmorType = var_35_12

		var_35_11(var_35_13, var_35_12.Type2Name(var_35_9.armor_type))

		return
	end)()

	ys = var_31

	local var_22_50 = var_31.Battle.BattleAttr.IsWorldMapRewardAttrWarning(var_22_23, var_22_24)

	setActive = var_32

	var_32(arg_22_0.dangerMark, var_22_50)

	if var_22_50 then
		setAnchoredPosition = var_32

		local var_22_51 = arg_22_0.dangerMark
		local var_22_52 = {}

		if not var_28 or not var_0_5 then
			var_1_10035 = var_0_4
		end

		var_22_52.x = var_1_10035

		var_32(var_22_51, var_22_52)
	end

	if not var_28 then
		if var_22_4.icon_type == 1 then
			local var_22_53 = arg_22_0.loader

			var_33.GetSprite(var_22_53, "enemies/" .. var_22_4.icon, nil, arg_22_0.bosssprite)
		elseif var_32 == 2 then
			local var_22_54 = arg_22_0.bosssprite
			local var_22_55 = var_33.GetComponent

			typeof = var_1_10035
			Image = var_1_10036
			var_22_55(var_22_54, var_1_10035(var_1_10036)).enabled = false

			local var_22_56 = arg_22_0.loader

			var_33.GetSpine(var_22_56, var_22_4.icon, function(arg_36_0)
				local var_36_0 = var_22_5.battle_spine_size * 0.01
				local var_36_1 = arg_36_0
				local var_36_2 = arg_36_0.SetLocalScale

				Vector3 = var_2_10004

				var_36_2(var_36_1, var_2_10004(var_36_0, var_36_0, 1))

				local var_36_3 = arg_36_0
				local var_36_4 = arg_36_0.SetAnchoredPosition

				Vector3 = var_4

				var_36_4(var_36_3, var_4.New(0, -150, 0))

				local var_36_5 = arg_36_0
				local var_36_6 = arg_36_0.SetAction

				ChapterConst = var_4

				var_36_6(var_36_5, var_4.ShipIdleAction, 0)

				arg_36_0:GetSkeletonGraphic().raycastTarget = false

				arg_36_0:SetParent(arg_22_0.bosssprite)

				return
			end, arg_22_0.bosssprite)
		end
	end

	return
end

function var_0_1.onBackPressed(arg_37_0)
	if arg_37_0.awardPanel then
		local var_37_0 = arg_37_0.awardPanel

		if var_1.isShowing(var_37_0) then
			local var_37_1 = arg_37_0.awardPanel

			var_1.Hide(var_37_1)

			return
		end
	end

	triggerButton = var_1

	var_1(arg_37_0.backBtn)

	return
end

function var_0_1.willExit(arg_38_0)
	arg_38_0:DestroyAwardPanel()

	pg = var_1

	local var_38_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_38_0, arg_38_0.layer, arg_38_0._tf)

	pg = var_1

	local var_38_1 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_38_1, arg_38_0._tf)

	if arg_38_0.resPanel then
		local var_38_2 = arg_38_0.resPanel

		var_1.exit(var_38_2)

		arg_38_0.resPanel = nil
	end

	pairs = var_1

	for iter_38_0, iter_38_1 in var_1(arg_38_0.dungeonDict) do
		ys = var_1_10006

		var_1_10006.Battle.BattleDataFunction.ClearDungeonCfg(iter_38_0)
	end

	table = var_1

	var_1.clear(arg_38_0.dungeonDict)

	local var_38_3 = arg_38_0.loader

	var_1.Clear(var_38_3)

	return
end

function var_0_1.GetAwardPanel(arg_39_0)
	local var_39_0

	if not arg_39_0.awardPanel then
		WorldBossHPAwardPanel = var_39_0
		var_39_0 = var_39_0.New(arg_39_0._tf, arg_39_0.event, arg_39_0.contextData)
	end

	arg_39_0.awardPanel = var_39_0

	local var_39_1 = arg_39_0.awardPanel

	var_1.Load(var_39_1)

	return arg_39_0.awardPanel
end

function var_0_1.DestroyAwardPanel(arg_40_0)
	if not arg_40_0.awardPanel then
		return
	end

	local var_40_0 = arg_40_0.awardPanel

	var_1.Destroy(var_40_0)

	arg_40_0.awardPanel = nil

	return
end

function var_0_1.TransformColor(arg_41_0)
	tonumber = var_1_10001
	string = var_1_10002

	local var_41_0 = var_1_10001(var_1_10002.sub(arg_41_0, 1, 2), 16)

	tonumber = var_2
	string = var_3

	local var_41_1 = var_2(var_3.sub(arg_41_0, 3, 4), 16)

	tonumber = var_3
	string = var_4

	local var_41_2 = var_3(var_4.sub(arg_41_0, 5, 6), 16)

	Color = var_4

	return var_4.New(var_41_0 / 255, var_41_1 / 255, var_41_2 / 255)
end

return var_0_1

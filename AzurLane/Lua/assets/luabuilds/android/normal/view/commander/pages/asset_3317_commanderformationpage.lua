class = var_0_10000

local var_0_0 = "CommanderFormationPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "CommanderFormationUI"
end

function var_0_1.OnInit(arg_2_0)
	setActive = var_1_10001

	var_1_10001(arg_2_0.samllTF, true)

	local var_2_0 = arg_2_0.samllTF

	arg_2_0.pos1 = var_1.Find(var_2_0, "commander1")

	local var_2_1 = arg_2_0.samllTF

	arg_2_0.pos2 = var_1.Find(var_2_1, "commander2")
	setActive = var_1

	var_1(arg_2_0.descPanel, false)

	local var_2_2 = arg_2_0.descPanel

	arg_2_0.descFrameTF = var_1.Find(var_2_2, "frame")

	local var_2_3 = arg_2_0.descFrameTF

	arg_2_0.descPos1 = var_1.Find(var_2_3, "commander1/frame/info")

	local var_2_4 = arg_2_0.descFrameTF

	arg_2_0.descPos2 = var_1.Find(var_2_4, "commander2/frame/info")

	local var_2_5 = arg_2_0.descFrameTF

	arg_2_0.skillTFPos1 = var_1.Find(var_2_5, "commander1/skill_info")

	local var_2_6 = arg_2_0.descFrameTF

	arg_2_0.skillTFPos2 = var_1.Find(var_2_6, "commander2/skill_info")
	UIItemList = var_1

	local var_2_7 = var_1.New
	local var_2_8 = arg_2_0.descFrameTF
	local var_2_9 = var_2.Find(var_2_8, "atttr_panel/abilitys/mask/content")
	local var_2_10 = arg_2_0.descFrameTF

	arg_2_0.abilitysTF = var_2_7(var_2_9, var_3.Find(var_2_10, "atttr_panel/abilitys/mask/content/attr"))
	UIItemList = var_1

	local var_2_11 = var_1.New
	local var_2_12 = arg_2_0.descFrameTF
	local var_2_13 = var_2.Find(var_2_12, "atttr_panel/talents/mask/content")
	local var_2_14 = arg_2_0.descFrameTF

	arg_2_0.talentsTF = var_2_11(var_2_13, var_3.Find(var_2_14, "atttr_panel/talents/mask/content/attr"))

	local var_2_15 = arg_2_0.descPanel

	arg_2_0.abilityArr = var_1.Find(var_2_15, "frame/atttr_panel/abilitys/arr")

	local var_2_16 = arg_2_0.descPanel

	arg_2_0.talentsArr = var_1.Find(var_2_16, "frame/atttr_panel/talents/arr")

	local var_2_17 = arg_2_0.descFrameTF

	arg_2_0.restAllBtn = var_1.Find(var_2_17, "rest_all")

	local var_2_18 = arg_2_0.descFrameTF

	arg_2_0.quickBtn = var_1.Find(var_2_18, "quick_btn")

	local var_2_19 = {}
	local var_2_20 = arg_2_0.recordPanel

	var_2_19[1] = var_2.Find(var_2_20, "current/commanders/commander1/frame/info")

	local var_2_21 = arg_2_0.recordPanel

	var_2_19[2] = var_2.Find(var_2_21, "current/commanders/commander2/frame/info")
	arg_2_0.recordCommanders = var_2_19

	local var_2_22 = {}
	local var_2_23 = arg_2_0.recordPanel

	var_2_22[1] = var_2.Find(var_2_23, "current/commanders/commander1/skill_info")

	local var_2_24 = arg_2_0.recordPanel

	var_2_22[2] = var_2.Find(var_2_24, "current/commanders/commander2/skill_info")
	arg_2_0.reocrdSkills = var_2_22
	UIItemList = var_2_22

	local var_2_25 = var_2_22.New
	local var_2_26 = arg_2_0.recordPanel
	local var_2_27 = var_2.Find(var_2_26, "record/content")
	local var_2_28 = arg_2_0.recordPanel

	arg_2_0.recordList = var_2_25(var_2_27, var_3.Find(var_2_28, "record/content/commanders"))
	onButton = var_1

	local var_2_29 = arg_2_0
	local var_2_30 = arg_2_0.samllTF

	local function var_2_31()
		local var_3_0 = arg_2_0

		var_0.openDescPanel(var_3_0)

		return
	end

	SFX_PANEL = var_5

	var_1(var_2_29, var_2_30, var_2_31, var_5)

	onButton = var_1

	local var_2_32 = arg_2_0
	local var_2_33 = arg_2_0.quickBtn

	local function var_2_34()
		local var_4_0 = arg_2_0

		var_0.OpenRecordPanel(var_4_0)

		return
	end

	SFX_PANEL = var_5

	var_1(var_2_32, var_2_33, var_2_34, var_5)

	onButton = var_1

	local var_2_35 = arg_2_0
	local var_2_36 = arg_2_0._tf
	local var_2_37 = var_3.Find(var_2_36, "bg")

	local function var_2_38()
		isActive = var_2_10000

		if var_2_10000(arg_2_0.recordPanel) then
			local var_5_0 = arg_2_0

			var_0.CloseRecordPanel(var_5_0)
		else
			isActive = var_0

			if var_0(arg_2_0.descPanel) then
				local var_5_1 = arg_2_0

				var_0.closeDescPanel(var_5_1)
			end
		end

		return
	end

	SFX_PANEL = var_5

	var_1(var_2_35, var_2_37, var_2_38, var_5)

	onButton = var_1

	local var_2_39 = arg_2_0
	local var_2_40 = arg_2_0.restAllBtn

	local function var_2_41()
		local var_6_0 = arg_2_0
		local var_6_1 = var_0.emit

		FormationMediator = var_2_10002

		local var_6_2 = var_2_10002.COMMANDER_FORMATION_OP
		local var_6_3 = {}

		LevelUIConst = var_2_10004
		var_6_3.FleetType = var_2_10004.FLEET_TYPE_SELECT

		local var_6_4 = {}

		LevelUIConst = var_2_10005
		var_6_4.type = var_2_10005.COMMANDER_OP_REST_ALL
		var_6_3.data = var_6_4
		var_6_3.fleetId = arg_2_0.fleet.id

		var_6_1(var_6_0, var_6_2, var_6_3)

		return
	end

	SFX_PANEL = var_5

	var_1(var_2_39, var_2_40, var_2_41, var_5)

	setText = var_1

	local var_2_42 = arg_2_0.descPanel
	local var_2_43 = var_2.Find(var_2_42, "frame/atttr_panel/abilitys/title/Text")

	i18n = var_2_42

	var_1(var_2_43, var_2_42("commander_subtile_ablity"))

	setText = var_1

	local var_2_44 = arg_2_0.descPanel
	local var_2_45 = var_2.Find(var_2_44, "frame/atttr_panel/talents/title/Text")

	i18n = var_2_44

	var_1(var_2_45, var_2_44("commander_subtile_talent"))

	setText = var_1

	local var_2_46 = arg_2_0.recordPanel
	local var_2_47 = var_2.Find(var_2_46, "current/title/Text")

	i18n = var_2_46

	var_1(var_2_47, var_2_46("commander_formation_prefab_fleet"))

	return
end

function var_0_1.Update(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.fleet = arg_7_1
	arg_7_0.prefabFleets = arg_7_2

	local var_7_0 = arg_7_0.fleet
	local var_7_1 = var_3.getCommanders(var_7_0)
	local var_7_2 = 1

	CommanderConst = var_1_10005

	for iter_7_0 = var_7_2, var_1_10005.MAX_FORMATION_POS do
		local var_7_3 = var_7_1[iter_7_0]

		assert = var_1_10009

		var_1_10009(arg_7_0["pos" .. iter_7_0], "pos tf can not nil")
		arg_7_0:updateCommander(arg_7_0["pos" .. iter_7_0], iter_7_0, var_7_3)
	end

	arg_7_0:updateDesc()
	arg_7_0:updateRecordPanel()

	return
end

function var_0_1.openDescPanel(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1 or 0.2

	LeanTween = var_1_10003

	local var_8_1 = var_1_10003.isTweening

	go = var_1_10004

	if not var_8_1(var_1_10004(arg_8_0.samllTF)) then
		LeanTween = var_8_2

		local var_8_2 = var_8_2.isTweening

		go = var_4

		if var_8_2(var_4(arg_8_0.descFrameTF)) then
			return
		end

		setAnchoredPosition = var_8_2

		var_8_2(arg_8_0.samllTF, {
			x = 0
		})

		LeanTween = var_8_2

		local var_8_3 = var_8_2.moveX(arg_8_0.samllTF, 800, var_8_0)
		local var_8_4 = var_3.setOnComplete

		System = var_5

		var_8_4(var_8_3, var_5.Action(function()
			setActive = var_2_10000

			var_2_10000(arg_8_0.descPanel, true)

			setActive = var_2_10000

			var_2_10000(arg_8_0.descBg, true)

			pg = var_2_10000

			local var_9_0 = var_2_10000.UIMgr.GetInstance()

			var_0.OverlayPanel(var_9_0, arg_8_0._tf)

			setAnchoredPosition = var_0

			var_0(arg_8_0.descFrameTF, {
				x = 800
			})

			LeanTween = var_0

			var_0.moveX(arg_8_0.descFrameTF, 0, var_8_0)

			return
		end))

		arg_8_0.contextData.inDescPage = true

		return
	end
end

function var_0_1.closeDescPanel(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1 or 0.2

	LeanTween = var_1_10003

	local var_10_1 = var_1_10003.isTweening

	go = var_1_10004

	if not var_10_1(var_1_10004(arg_10_0.samllTF)) then
		LeanTween = var_10_2

		local var_10_2 = var_10_2.isTweening

		go = var_4

		if var_10_2(var_4(arg_10_0.descFrameTF)) then
			return
		end

		setAnchoredPosition = var_10_2

		var_10_2(arg_10_0.descFrameTF, {
			x = 0
		})

		LeanTween = var_10_2

		local var_10_3 = var_10_2.moveX(arg_10_0.descFrameTF, 800, var_10_0)
		local var_10_4 = var_3.setOnComplete

		System = var_5

		var_10_4(var_10_3, var_5.Action(function()
			setActive = var_2_10000

			var_2_10000(arg_10_0.descPanel, false)

			setActive = var_2_10000

			var_2_10000(arg_10_0.descBg, false)

			pg = var_2_10000

			local var_11_0 = var_2_10000.UIMgr.GetInstance()

			var_0.UnOverlayPanel(var_11_0, arg_10_0._tf, arg_10_0._parentTf)

			setAnchoredPosition = var_0

			var_0(arg_10_0.samllTF, {
				x = 800
			})

			LeanTween = var_0

			var_0.moveX(arg_10_0.samllTF, 0, var_10_0)

			return
		end))

		arg_10_0.contextData.inDescPage = false

		return
	end
end

function var_0_1.updateDesc(arg_12_0)
	local var_12_0 = arg_12_0.fleet
	local var_12_1 = var_1.getCommanders(var_12_0)
	local var_12_2 = 1

	CommanderConst = var_1_10003

	for iter_12_0 = var_12_2, var_1_10003.MAX_FORMATION_POS do
		local var_12_3 = var_12_1[iter_12_0]

		assert = var_1_10007

		var_1_10007(arg_12_0["pos" .. iter_12_0], "pos tf can not nil")
		arg_12_0:updateCommander(arg_12_0["descPos" .. iter_12_0], iter_12_0, var_12_3, true)
		arg_12_0:updateSkillTF(var_12_3, arg_12_0["skillTFPos" .. iter_12_0])
	end

	arg_12_0:updateAdditions()

	return
end

function var_0_1.updateAdditions(arg_13_0)
	local var_13_0 = arg_13_0.fleet

	_ = var_1_10002

	local var_13_1 = var_1_10002.values(var_13_0:getCommandersTalentDesc())
	local var_13_2, var_13_3 = var_13_0:getCommandersAddition()
	local var_13_4 = arg_13_0.abilitysTF

	var_5.make(var_13_4, function(arg_14_0, arg_14_1, arg_14_2)
		UIItemList = var_2_10003

		if arg_14_0 == var_2_10003.EventUpdate then
			local var_14_0 = var_13_2[arg_14_1 + 1]

			setText = var_4

			local var_14_1 = arg_14_2
			local var_14_2 = arg_14_2.Find(var_14_1, "name")

			AttributeType = var_14_1

			var_4(var_14_2, var_14_1.Type2Name(var_14_0.attrName))

			setText = var_4

			local var_14_3 = arg_14_2:Find("Text")
			local var_14_4 = "+"

			math = var_7

			var_4(var_14_3, (var_14_4 .. var_7.floor(var_14_0.value * 1000) / 1000) .. "%")

			GetImageSpriteFromAtlasAsync = var_4

			var_4("attricon", var_14_0.attrName, arg_14_2:Find("icon"), false)

			setImageAlpha = var_4

			var_4(arg_14_2:Find("bg"), arg_14_1 % 2)
		end

		return
	end)

	local var_13_5 = arg_13_0.abilitysTF

	var_5.align(var_13_5, #var_13_2)

	setActive = var_5

	var_5(arg_13_0.abilityArr, #var_13_2 > 4)

	local var_13_6 = arg_13_0.talentsTF

	var_5.make(var_13_6, function(arg_15_0, arg_15_1, arg_15_2)
		UIItemList = var_2_10003

		if arg_15_0 == var_2_10003.EventUpdate then
			local var_15_0 = var_13_1[arg_15_1 + 1]

			setScrollText = var_4
			findTF = var_2_10005

			var_4(var_2_10005(arg_15_2, "name_mask/name"), var_15_0.name)

			local var_15_1 = var_15_0.type

			CommanderConst = var_5

			local var_15_2 = var_15_1 == var_5.TALENT_ADDITION_RATIO and "%" or ""

			setText = var_5

			var_5(arg_15_2:Find("Text"), (var_15_0.value > 0 and "+" or "") .. var_15_0.value .. var_15_2)

			setImageAlpha = var_5

			var_5(arg_15_2:Find("bg"), arg_15_1 % 2)
		end

		return
	end)

	local var_13_7 = arg_13_0.talentsTF

	var_5.align(var_13_7, #var_13_1)

	setActive = var_5

	var_5(arg_13_0.talentsArr, #var_13_1 > 4)

	Canvas = var_5

	var_5.ForceUpdateCanvases()

	return
end

function var_0_1.updateSkillTF(arg_16_0, arg_16_1, arg_16_2)
	setActive = var_1_10003

	var_1_10003(arg_16_2, arg_16_1)

	if arg_16_1 then
		local var_16_0 = arg_16_1

		var_1_10003 = arg_16_1.getSkills(var_16_0)[1]
		GetImageSpriteFromAtlasAsync = var_16_0

		var_16_0("CommanderSkillIcon/" .. var_1_10003:getConfig("icon"), "", arg_16_2:Find("icon"))

		setText = var_16_0

		local var_16_1 = arg_16_2:Find("level")
		local var_16_2 = "Lv."
		local var_16_3 = var_1_10003

		var_16_0(var_16_1, var_16_2 .. var_1_10003.getLevel(var_16_3))

		onButton = var_16_0

		local var_16_4 = arg_16_0
		local var_16_5 = arg_16_2

		local function var_16_6()
			local var_17_0 = arg_16_0
			local var_17_1 = var_0.emit

			FormationMediator = var_2_10002

			var_17_1(var_17_0, var_2_10002.ON_CMD_SKILL, var_1_10003)

			return
		end

		SFX_PANEL = var_16_3

		var_16_0(var_16_4, var_16_5, var_16_6, var_16_3)
	else
		removeOnButton = var_1_10003

		var_1_10003(arg_16_2)
	end

	return
end

function var_0_1.updateCommander(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	local var_18_0 = arg_18_1:Find("add")
	local var_18_1 = arg_18_1
	local var_18_2 = arg_18_1.Find(var_18_1, "info")

	if arg_18_3 then
		var_18_1 = arg_18_1:Find("info/mask/icon")

		local var_18_3 = arg_18_1
		local var_18_4 = arg_18_1.Find(var_18_3, "info/frame")

		GetImageSpriteFromAtlasAsync = var_18_3

		var_18_3("CommanderHrz/" .. arg_18_3:getPainting(), "", var_18_1)

		local var_18_5 = arg_18_1

		if arg_18_1.Find(var_18_5, "info/name") then
			setText = var_18_5
			var_1_10011 = var_9
			var_1_10013 = arg_18_3

			var_18_5(var_1_10011, arg_18_3.getName(var_1_10013))
		end

		Commander = var_18_5

		local var_18_6 = var_18_5.rarity2Frame(arg_18_3:getRarity())

		setImageSprite = var_1_10011

		local var_18_7 = var_18_4

		GetSpriteFromAtlas = var_1_10013

		var_1_10011(var_18_7, var_1_10013("weaponframes", "commander_" .. var_18_6))
	end

	if arg_18_4 then
		onButton = var_18_1

		local var_18_8 = arg_18_0
		local var_18_9 = var_18_2

		local function var_18_10()
			local var_19_0 = arg_18_0
			local var_19_1 = var_0.emit

			FormationMediator = var_2_10002

			var_19_1(var_19_0, var_2_10002.ON_SELECT_COMMANDER, arg_18_2, arg_18_0.fleet.id)

			return
		end

		SFX_PANEL = var_1_10011

		var_18_1(var_18_8, var_18_9, var_18_10, var_1_10011)

		onButton = var_18_1

		local var_18_11 = arg_18_0
		local var_18_12 = var_18_0

		local function var_18_13()
			local var_20_0 = arg_18_0
			local var_20_1 = var_0.emit

			FormationMediator = var_2_10002

			var_20_1(var_20_0, var_2_10002.ON_SELECT_COMMANDER, arg_18_2, arg_18_0.fleet.id)

			return
		end

		SFX_PANEL = var_1_10011

		var_18_1(var_18_11, var_18_12, var_18_13, var_1_10011)
	end

	setActive = var_18_1

	var_18_1(var_18_0, not arg_18_3)

	setActive = var_18_1

	var_18_1(var_18_2, arg_18_3)

	return
end

function var_0_1.OpenRecordPanel(arg_21_0)
	setActive = var_1_10001

	var_1_10001(arg_21_0.descFrameTF, false)

	setActive = var_1_10001

	var_1_10001(arg_21_0.recordPanel, true)

	return
end

function var_0_1.updateRecordPanel(arg_22_0)
	local var_22_0 = arg_22_0.fleet
	local var_22_1 = var_1.getCommanders(var_22_0)

	ipairs = var_22_0

	for iter_22_0, iter_22_1 in var_22_0(arg_22_0.recordCommanders) do
		local var_22_2 = var_22_1[iter_22_0]

		arg_22_0:updateCommander(iter_22_1, iter_22_0, var_22_2)
		arg_22_0:updateSkillTF(var_22_2, arg_22_0.reocrdSkills[iter_22_0])
	end

	local var_22_3 = arg_22_0.recordList

	var_2.make(var_22_3, function(arg_23_0, arg_23_1, arg_23_2)
		UIItemList = var_2_10003

		if arg_23_0 == var_2_10003.EventUpdate then
			local var_23_0 = arg_22_0.prefabFleets[arg_23_1 + 1]
			local var_23_1 = arg_22_0

			var_4.UpdatePrefabFleet(var_23_1, var_23_0, arg_23_2, var_22_1)
		end

		return
	end)

	local var_22_4 = arg_22_0.recordList

	var_2.align(var_22_4, #arg_22_0.prefabFleets)

	return
end

function var_0_1.UpdatePrefabFleet(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	local var_24_0 = arg_24_2:Find("fleet_name")
	local var_24_1 = arg_24_1
	local var_24_2 = arg_24_1.getName(var_24_1)

	onInputEndEdit = var_24_1

	var_24_1(arg_24_0, var_24_0, function()
		getInputText = var_2_10000

		local var_25_0 = var_2_10000(var_24_0)
		local var_25_1 = arg_24_0
		local var_25_2 = var_1.emit

		FormationMediator = var_2_10003

		local var_25_3 = var_2_10003.COMMANDER_FORMATION_OP
		local var_25_4 = {}

		LevelUIConst = var_2_10005
		var_25_4.FleetType = var_2_10005.FLEET_TYPE_SELECT

		local var_25_5 = {}

		LevelUIConst = var_2_10006
		var_25_5.type = var_2_10006.COMMANDER_OP_RENAME
		var_25_5.id = arg_24_1.id
		var_25_5.str = var_25_0

		function var_25_5.onFailed()
			setInputText = var_3_10000

			var_3_10000(var_24_0, var_24_2)

			return
		end

		var_25_4.data = var_25_5
		var_25_4.fleetId = arg_24_0.fleet.id

		var_25_2(var_25_1, var_25_3, var_25_4)

		return
	end)

	setInputText = var_24_1

	var_24_1(var_24_0, var_24_2)

	onButton = var_24_1

	local var_24_3 = arg_24_0
	local var_24_4 = arg_24_2:Find("use_btn")

	local function var_24_5()
		local var_27_0 = arg_24_0
		local var_27_1 = var_0.emit

		FormationMediator = var_2_10002

		local var_27_2 = var_2_10002.COMMANDER_FORMATION_OP
		local var_27_3 = {}

		LevelUIConst = var_2_10004
		var_27_3.FleetType = var_2_10004.FLEET_TYPE_SELECT

		local var_27_4 = {}

		LevelUIConst = var_2_10005
		var_27_4.type = var_2_10005.COMMANDER_OP_USE_PREFAB
		var_27_4.id = arg_24_1.id
		var_27_3.data = var_27_4
		var_27_3.fleetId = arg_24_0.fleet.id

		var_27_1(var_27_0, var_27_2, var_27_3)

		local var_27_5 = arg_24_0

		var_0.CloseRecordPanel(var_27_5)

		return
	end

	SFX_PANEL = var_10

	var_24_1(var_24_3, var_24_4, var_24_5, var_10)

	onButton = var_24_1

	local var_24_6 = arg_24_0
	local var_24_7 = arg_24_2:Find("record_btn")

	local function var_24_8()
		local var_28_0 = arg_24_0
		local var_28_1 = var_0.emit

		FormationMediator = var_2_10002

		local var_28_2 = var_2_10002.COMMANDER_FORMATION_OP
		local var_28_3 = {}

		LevelUIConst = var_2_10004
		var_28_3.FleetType = var_2_10004.FLEET_TYPE_SELECT

		local var_28_4 = {}

		LevelUIConst = var_2_10005
		var_28_4.type = var_2_10005.COMMANDER_OP_RECORD_PREFAB
		var_28_4.id = arg_24_1.id
		var_28_3.data = var_28_4
		var_28_3.fleetId = arg_24_0.fleet.id

		var_28_1(var_28_0, var_28_2, var_28_3)

		return
	end

	SFX_PANEL = var_10

	var_24_1(var_24_6, var_24_7, var_24_8, var_10)

	local var_24_9 = {
		arg_24_2:Find("commander1/frame/info"),
		arg_24_2:Find("commander2/frame/info")
	}
	local var_24_10 = {
		arg_24_2:Find("commander1/skill_info"),
		arg_24_2:Find("commander2/skill_info")
	}

	ipairs = var_8

	for iter_24_0, iter_24_1 in var_8(var_24_9) do
		local var_24_11 = arg_24_1:getCommanderByPos(iter_24_0)

		arg_24_0:updateCommander(iter_24_1, iter_24_0, var_24_11)
		arg_24_0:updateSkillTF(var_24_11, var_24_10[iter_24_0])
	end

	return
end

function var_0_1.CloseRecordPanel(arg_29_0)
	setActive = var_1_10001

	var_1_10001(arg_29_0.descFrameTF, true)

	setActive = var_1_10001

	var_1_10001(arg_29_0.recordPanel, false)

	return
end

function var_0_1.OnDestroy(arg_30_0)
	local var_30_0 = arg_30_0

	if arg_30_0.isShowing(var_30_0) then
		LeanTween = var_1

		local var_30_1 = var_1.cancel

		go = var_30_0

		var_30_1(var_30_0(arg_30_0.samllTF))

		LeanTween = var_30_1

		local var_30_2 = var_30_1.cancel

		go = var_2

		var_30_2(var_2(arg_30_0.descFrameTF))

		isActive = var_30_2

		if var_30_2(arg_30_0.descPanel) then
			pg = var_1

			local var_30_3 = var_1.UIMgr.GetInstance()

			var_1.UnOverlayPanel(var_30_3, arg_30_0._tf, arg_30_0._parentTf)
		end
	end

	return
end

return var_0_1

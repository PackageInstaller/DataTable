class = var_0_10000

local var_0_0 = "GuildCommanderFormationPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("....base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "GuildCommanderFormationUI"
end

function var_0_1.OnInit(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.samllTF = var_1.Find(var_2_0, "small")
	setActive = var_1

	var_1(arg_2_0.samllTF, true)

	local var_2_1 = arg_2_0._tf

	arg_2_0.pos1 = var_1.Find(var_2_1, "small/commander1")

	local var_2_2 = arg_2_0._tf

	arg_2_0.pos2 = var_1.Find(var_2_2, "small/commander2")

	local var_2_3 = arg_2_0._tf

	arg_2_0.descPanel = var_1.Find(var_2_3, "desc")
	setActive = var_1

	var_1(arg_2_0.descPanel, false)

	local var_2_4 = arg_2_0._tf

	arg_2_0.descFrameTF = var_1.Find(var_2_4, "desc/frame")

	local var_2_5 = arg_2_0.descFrameTF

	arg_2_0.descPos1 = var_1.Find(var_2_5, "commander1/frame/info")

	local var_2_6 = arg_2_0.descFrameTF

	arg_2_0.descPos2 = var_1.Find(var_2_6, "commander2/frame/info")

	local var_2_7 = arg_2_0.descFrameTF

	arg_2_0.skillTFPos1 = var_1.Find(var_2_7, "commander1/skill_info")

	local var_2_8 = arg_2_0.descFrameTF

	arg_2_0.skillTFPos2 = var_1.Find(var_2_8, "commander2/skill_info")
	UIItemList = var_1

	local var_2_9 = var_1.New
	local var_2_10 = arg_2_0.descFrameTF
	local var_2_11 = var_3.Find(var_2_10, "atttr_panel/abilitys/mask/content")
	local var_2_12 = arg_2_0.descFrameTF

	arg_2_0.abilitysTF = var_2_9(var_2_11, var_4.Find(var_2_12, "atttr_panel/abilitys/mask/content/attr"))
	UIItemList = var_1

	local var_2_13 = var_1.New
	local var_2_14 = arg_2_0.descFrameTF
	local var_2_15 = var_3.Find(var_2_14, "atttr_panel/talents/mask/content")
	local var_2_16 = arg_2_0.descFrameTF

	arg_2_0.talentsTF = var_2_13(var_2_15, var_4.Find(var_2_16, "atttr_panel/talents/mask/content/attr"))

	local var_2_17 = arg_2_0._tf

	arg_2_0.abilityArr = var_1.Find(var_2_17, "desc/frame/atttr_panel/abilitys/arr")

	local var_2_18 = arg_2_0._tf

	arg_2_0.talentsArr = var_1.Find(var_2_18, "desc/frame/atttr_panel/talents/arr")

	local var_2_19 = arg_2_0.descFrameTF

	arg_2_0.restAllBtn = var_1.Find(var_2_19, "rest_all")

	local var_2_20 = arg_2_0.descFrameTF

	arg_2_0.quickBtn = var_1.Find(var_2_20, "quick_btn")

	local var_2_21 = arg_2_0._tf

	arg_2_0.recordPanel = var_1.Find(var_2_21, "record_panel")

	local var_2_22 = {}
	local var_2_23 = arg_2_0.recordPanel

	var_2_22[1] = var_2.Find(var_2_23, "current/commanders/commander1/frame/info")

	local var_2_24 = arg_2_0.recordPanel

	var_2_22[2] = var_2.Find(var_2_24, "current/commanders/commander2/frame/info")
	arg_2_0.recordCommanders = var_2_22

	local var_2_25 = {}
	local var_2_26 = arg_2_0.recordPanel

	var_2_25[1] = var_2.Find(var_2_26, "current/commanders/commander1/skill_info")

	local var_2_27 = arg_2_0.recordPanel

	var_2_25[2] = var_2.Find(var_2_27, "current/commanders/commander2/skill_info")
	arg_2_0.reocrdSkills = var_2_25
	UIItemList = var_2_25

	local var_2_28 = var_2_25.New
	local var_2_29 = arg_2_0.recordPanel
	local var_2_30 = var_3.Find(var_2_29, "record/content")
	local var_2_31 = arg_2_0.recordPanel

	arg_2_0.recordList = var_2_28(var_2_30, var_4.Find(var_2_31, "record/content/commanders"))
	onButton = var_1

	local var_2_32 = arg_2_0
	local var_2_33 = arg_2_0.samllTF

	local function var_2_34()
		local var_3_0 = arg_2_0

		var_0.openDescPanel(var_3_0)

		return
	end

	SFX_PANEL = var_2_31

	var_1(var_2_32, var_2_33, var_2_34, var_2_31)

	onButton = var_1

	local var_2_35 = arg_2_0
	local var_2_36 = arg_2_0.descPanel

	local function var_2_37()
		local var_4_0 = arg_2_0

		var_0.closeDescPanel(var_4_0)

		return
	end

	SFX_PANEL = var_2_31

	var_1(var_2_35, var_2_36, var_2_37, var_2_31)

	onButton = var_1

	local var_2_38 = arg_2_0
	local var_2_39 = arg_2_0.restAllBtn

	local function var_2_40()
		local var_5_0 = arg_2_0.fleet

		if not var_0.ExistAnyCommander(var_5_0) then
			return
		end

		local var_5_1 = arg_2_0
		local var_5_2 = var_0.emit

		GuildEventMediator = var_2_10003

		local var_5_3 = var_2_10003.COMMANDER_FORMATION_OP
		local var_5_4 = {}
		local var_5_5 = {
			fleet = arg_2_0.fleet
		}

		LevelUIConst = var_6
		var_5_5.type = var_6.COMMANDER_OP_REST_ALL
		var_5_4.data = var_5_5
		var_5_4.fleetId = arg_2_0.fleet.id

		var_5_2(var_5_1, var_5_3, var_5_4)

		return
	end

	SFX_PANEL = var_2_31

	var_1(var_2_38, var_2_39, var_2_40, var_2_31)

	onButton = var_1

	local var_2_41 = arg_2_0
	local var_2_42 = arg_2_0.quickBtn

	local function var_2_43()
		local var_6_0 = arg_2_0

		var_0.OpenRecordPanel(var_6_0)

		return
	end

	SFX_PANEL = var_2_31

	var_1(var_2_41, var_2_42, var_2_43, var_2_31)

	onButton = var_1

	local var_2_44 = arg_2_0
	local var_2_45 = arg_2_0.recordPanel
	local var_2_46 = var_4.Find(var_2_45, "back")

	local function var_2_47()
		local var_7_0 = arg_2_0

		var_0.CloseRecordPanel(var_7_0)

		return
	end

	SFX_PANEL = var_2_45

	var_1(var_2_44, var_2_46, var_2_47, var_2_45)
	arg_2_0:Show()

	return
end

function var_0_1.Update(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.fleet = arg_8_1
	arg_8_0.prefabFleets = arg_8_2

	local var_8_0 = arg_8_0.fleet
	local var_8_1 = var_3.getCommanders(var_8_0)
	local var_8_2 = 1

	CommanderConst = var_8_0

	for iter_8_0 = var_8_2, var_8_0.MAX_FORMATION_POS do
		local var_8_3 = var_8_1[iter_8_0]

		assert = var_1_10009

		var_1_10009(arg_8_0["pos" .. iter_8_0], "pos tf can not nil")
		arg_8_0:updateCommander(arg_8_0["pos" .. iter_8_0], iter_8_0, var_8_3)
	end

	arg_8_0:updateDesc()
	arg_8_0:updateRecordPanel()

	return
end

function var_0_1.openDescPanel(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1 or 0.2

	LeanTween = var_1_10003

	local var_9_1 = var_1_10003.isTweening

	go = var_1_10005

	if not var_9_1(var_1_10005(arg_9_0.samllTF)) then
		LeanTween = var_9_2

		local var_9_2 = var_9_2.isTweening

		go = var_5

		if var_9_2(var_5(arg_9_0.descFrameTF)) then
			return
		end

		setAnchoredPosition = var_9_2

		var_9_2(arg_9_0.samllTF, {
			x = -108
		})

		LeanTween = var_9_2

		local var_9_3 = var_9_2.moveX(arg_9_0.samllTF, 1500, var_9_0)
		local var_9_4 = var_3.setOnComplete

		System = var_6

		var_9_4(var_9_3, var_6.Action(function()
			setActive = var_2_10000

			var_2_10000(arg_9_0.descPanel, true)

			setAnchoredPosition = var_2_10000

			var_2_10000(arg_9_0.descFrameTF, {
				x = 1500
			})

			LeanTween = var_2_10000

			var_2_10000.moveX(arg_9_0.descFrameTF, -108, var_9_0)

			return
		end))

		arg_9_0.contextData.inDescPage = true

		local var_9_5 = arg_9_0._tf

		var_3.SetAsLastSibling(var_9_5)

		return
	end
end

function var_0_1.closeDescPanel(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1 or 0.2

	LeanTween = var_1_10003

	local var_11_1 = var_1_10003.isTweening

	go = var_1_10005

	if not var_11_1(var_1_10005(arg_11_0.samllTF)) then
		LeanTween = var_11_2

		local var_11_2 = var_11_2.isTweening

		go = var_5

		if var_11_2(var_5(arg_11_0.descFrameTF)) then
			return
		end

		setAnchoredPosition = var_11_2

		var_11_2(arg_11_0.descFrameTF, {
			x = -108
		})

		LeanTween = var_11_2

		local var_11_3 = var_11_2.moveX(arg_11_0.descFrameTF, 1500, var_11_0)
		local var_11_4 = var_3.setOnComplete

		System = var_6

		var_11_4(var_11_3, var_6.Action(function()
			setActive = var_2_10000

			var_2_10000(arg_11_0.descPanel, false)

			pg = var_2_10000

			local var_12_0 = var_2_10000.UIMgr.GetInstance()

			var_0.UnOverlayPanel(var_12_0, arg_11_0._tf, arg_11_0._parentTf)

			setAnchoredPosition = var_0

			var_0(arg_11_0.samllTF, {
				x = 1500
			})

			LeanTween = var_0

			var_0.moveX(arg_11_0.samllTF, -108, var_11_0)

			return
		end))

		arg_11_0.contextData.inDescPage = false

		return
	end
end

function var_0_1.updateDesc(arg_13_0)
	local var_13_0 = arg_13_0.fleet
	local var_13_1 = var_1.getCommanders(var_13_0)
	local var_13_2 = 1

	CommanderConst = var_13_0

	for iter_13_0 = var_13_2, var_13_0.MAX_FORMATION_POS do
		local var_13_3 = var_13_1[iter_13_0]

		assert = var_1_10007

		var_1_10007(arg_13_0["pos" .. iter_13_0], "pos tf can not nil")
		arg_13_0:updateCommander(arg_13_0["descPos" .. iter_13_0], iter_13_0, var_13_3, true)
		arg_13_0:updateSkillTF(var_13_3, arg_13_0["skillTFPos" .. iter_13_0])
	end

	arg_13_0:updateAdditions()

	return
end

function var_0_1.updateAdditions(arg_14_0)
	local var_14_0 = arg_14_0.fleet

	_ = var_1_10002

	local var_14_1 = var_1_10002.values(var_14_0:getCommandersTalentDesc())
	local var_14_2, var_14_3 = var_14_0:getCommandersAddition()
	local var_14_4 = arg_14_0.abilitysTF

	var_5.make(var_14_4, function(arg_15_0, arg_15_1, arg_15_2)
		UIItemList = var_2_10003

		if arg_15_0 == var_2_10003.EventUpdate then
			local var_15_0 = var_14_2[arg_15_1 + 1]

			setText = var_4

			local var_15_1 = arg_15_2:Find("name")

			AttributeType = var_2_10007

			var_4(var_15_1, var_2_10007.Type2Name(var_15_0.attrName))

			setText = var_4

			local var_15_2 = arg_15_2
			local var_15_3 = arg_15_2.Find(var_15_2, "Text")
			local var_15_4 = "+"

			math = var_15_2

			var_4(var_15_3, (var_15_4 .. var_15_2.floor(var_15_0.value * 1000) / 1000) .. "%")

			GetImageSpriteFromAtlasAsync = var_4

			var_4("attricon", var_15_0.attrName, arg_15_2:Find("icon"), false)

			setImageAlpha = var_4

			var_4(arg_15_2:Find("bg"), arg_15_1 % 2)
		end

		return
	end)

	local var_14_5 = arg_14_0.abilitysTF

	var_5.align(var_14_5, #var_14_2)

	setActive = var_5

	var_5(arg_14_0.abilityArr, #var_14_2 > 4)

	local var_14_6 = arg_14_0.talentsTF

	var_5.make(var_14_6, function(arg_16_0, arg_16_1, arg_16_2)
		UIItemList = var_2_10003

		if arg_16_0 == var_2_10003.EventUpdate then
			local var_16_0 = var_14_1[arg_16_1 + 1]

			setScrollText = var_4
			findTF = var_2_10006

			var_4(var_2_10006(arg_16_2, "name_mask/name"), var_16_0.name)

			local var_16_1 = var_16_0.type

			CommanderConst = var_2_10005

			local var_16_2 = var_16_1 == var_2_10005.TALENT_ADDITION_RATIO and "%" or ""

			setText = var_5

			var_5(arg_16_2:Find("Text"), (var_16_0.value > 0 and "+" or "") .. var_16_0.value .. var_16_2)

			setImageAlpha = var_5

			var_5(arg_16_2:Find("bg"), arg_16_1 % 2)
		end

		return
	end)

	local var_14_7 = arg_14_0.talentsTF

	var_5.align(var_14_7, #var_14_1)

	setActive = var_5

	var_5(arg_14_0.talentsArr, #var_14_1 > 4)

	Canvas = var_5

	var_5.ForceUpdateCanvases()

	return
end

function var_0_1.updateSkillTF(arg_17_0, arg_17_1, arg_17_2)
	setActive = var_1_10003

	var_1_10003(arg_17_2, arg_17_1)

	if arg_17_1 then
		var_1_10003 = arg_17_1:getSkills()[1]
		GetImageSpriteFromAtlasAsync = var_1_10004

		var_1_10004("CommanderSkillIcon/" .. var_1_10003:getConfig("icon"), "", arg_17_2:Find("icon"))

		setText = var_1_10004

		var_1_10004(arg_17_2:Find("level"), "Lv." .. var_1_10003:getLevel())

		onButton = var_1_10004

		local var_17_0 = arg_17_0
		local var_17_1 = arg_17_2

		local function var_17_2()
			local var_18_0 = arg_17_0
			local var_18_1 = var_0.emit

			GuildEventMediator = var_2_10003

			var_18_1(var_18_0, var_2_10003.ON_CMD_SKILL, var_1_10003)

			return
		end

		SFX_PANEL = var_9

		var_1_10004(var_17_0, var_17_1, var_17_2, var_9)
	else
		removeOnButton = var_1_10003

		var_1_10003(arg_17_2)
	end

	return
end

function var_0_1.updateCommander(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	local var_19_0 = arg_19_1
	local var_19_1 = arg_19_1.Find(var_19_0, "add")
	local var_19_2 = arg_19_1:Find("info")

	if arg_19_3 then
		local var_19_3 = arg_19_1

		var_19_0 = arg_19_1.Find(var_19_3, "info/mask/icon")

		local var_19_4 = arg_19_1
		local var_19_5 = arg_19_1.Find(var_19_4, "info/frame")

		GetImageSpriteFromAtlasAsync = var_19_3

		var_19_3("CommanderHrz/" .. arg_19_3:getPainting(), "", var_19_0)

		local var_19_6 = arg_19_1

		if arg_19_1.Find(var_19_6, "info/name") then
			setText = var_19_4

			var_19_4(var_9, arg_19_3:getName())
		end

		Commander = var_19_4

		local var_19_7 = var_19_4.rarity2Frame
		local var_19_8 = arg_19_3
		local var_19_9 = var_19_7(arg_19_3.getRarity(var_19_8))

		setImageSprite = var_19_6

		local var_19_10 = var_19_5

		GetSpriteFromAtlas = var_19_8

		var_19_6(var_19_10, var_19_8("weaponframes", "commander_" .. var_19_9))
	end

	if arg_19_4 then
		onButton = var_19_0

		local var_19_11 = arg_19_0
		local var_19_12 = var_19_2

		local function var_19_13()
			local var_20_0 = arg_19_0
			local var_20_1 = var_0.emit

			GuildEventMediator = var_2_10003

			var_20_1(var_20_0, var_2_10003.ON_SELECT_COMMANDER, arg_19_0.fleet.id, arg_19_2, arg_19_3)

			return
		end

		SFX_PANEL = var_1_10012

		var_19_0(var_19_11, var_19_12, var_19_13, var_1_10012)

		onButton = var_19_0

		local var_19_14 = arg_19_0
		local var_19_15 = var_19_1

		local function var_19_16()
			local var_21_0 = arg_19_0
			local var_21_1 = var_0.emit

			GuildEventMediator = var_2_10003

			var_21_1(var_21_0, var_2_10003.ON_SELECT_COMMANDER, arg_19_0.fleet.id, arg_19_2, arg_19_3)

			return
		end

		SFX_PANEL = var_1_10012

		var_19_0(var_19_14, var_19_15, var_19_16, var_1_10012)
	end

	setActive = var_19_0

	var_19_0(var_19_1, not arg_19_3)

	setActive = var_19_0

	var_19_0(var_19_2, arg_19_3)

	return
end

function var_0_1.OpenRecordPanel(arg_22_0)
	setActive = var_1_10001

	var_1_10001(arg_22_0.descFrameTF, false)

	setActive = var_1_10001

	var_1_10001(arg_22_0.recordPanel, true)

	return
end

function var_0_1.updateRecordPanel(arg_23_0)
	local var_23_0 = arg_23_0.fleet
	local var_23_1 = var_1.getCommanders(var_23_0)

	ipairs = var_1_10002

	for iter_23_0, iter_23_1 in var_1_10002(arg_23_0.recordCommanders) do
		local var_23_2 = var_23_1[iter_23_0]

		arg_23_0:updateCommander(iter_23_1, iter_23_0, var_23_2)
		arg_23_0:updateSkillTF(var_23_2, arg_23_0.reocrdSkills[iter_23_0])
	end

	local var_23_3 = arg_23_0.recordList

	var_2.make(var_23_3, function(arg_24_0, arg_24_1, arg_24_2)
		UIItemList = var_2_10003

		if arg_24_0 == var_2_10003.EventUpdate then
			local var_24_0 = arg_23_0.prefabFleets[arg_24_1 + 1]
			local var_24_1 = arg_23_0

			var_4.UpdatePrefabFleet(var_24_1, var_24_0, arg_24_2, var_23_1)
		end

		return
	end)

	local var_23_4 = arg_23_0.recordList

	var_2.align(var_23_4, #arg_23_0.prefabFleets)

	return
end

function var_0_1.UpdatePrefabFleet(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	local var_25_0 = arg_25_2
	local var_25_1 = arg_25_2.Find(var_25_0, "fleet_name")
	local var_25_2 = arg_25_1:getName()

	onInputEndEdit = var_25_0

	var_25_0(arg_25_0, var_25_1, function()
		getInputText = var_2_10000

		local var_26_0 = var_2_10000(var_25_1)
		local var_26_1 = arg_25_0
		local var_26_2 = var_1.emit

		GuildEventMediator = var_2_10004

		local var_26_3 = var_2_10004.COMMANDER_FORMATION_OP
		local var_26_4 = {}
		local var_26_5 = {
			fleet = arg_25_0.fleet
		}

		LevelUIConst = var_7
		var_26_5.type = var_7.COMMANDER_OP_RENAME
		var_26_5.id = arg_25_1.id
		var_26_5.str = var_26_0

		function var_26_5.onFailed()
			setInputText = var_3_10000

			var_3_10000(var_25_1, var_25_2)

			return
		end

		var_26_4.data = var_26_5
		var_26_4.fleetId = arg_25_0.fleet.id

		var_26_2(var_26_1, var_26_3, var_26_4)

		return
	end)

	setInputText = var_25_0

	var_25_0(var_25_1, var_25_2)

	onButton = var_25_0

	local var_25_3 = arg_25_0
	local var_25_4 = arg_25_2
	local var_25_5 = arg_25_2.Find(var_25_4, "use_btn")

	local function var_25_6()
		local var_28_0 = arg_25_0
		local var_28_1 = var_0.emit

		GuildEventMediator = var_2_10003

		local var_28_2 = var_2_10003.COMMANDER_FORMATION_OP
		local var_28_3 = {}
		local var_28_4 = {
			fleet = arg_25_0.fleet
		}

		LevelUIConst = var_6
		var_28_4.type = var_6.COMMANDER_OP_USE_PREFAB
		var_28_4.id = arg_25_1.id
		var_28_3.data = var_28_4
		var_28_3.fleetId = arg_25_0.fleet.id

		var_28_1(var_28_0, var_28_2, var_28_3)

		local var_28_5 = arg_25_0

		var_0.CloseRecordPanel(var_28_5)

		return
	end

	SFX_PANEL = var_25_4

	var_25_0(var_25_3, var_25_5, var_25_6, var_25_4)

	onButton = var_25_0

	local var_25_7 = arg_25_0
	local var_25_8 = arg_25_2
	local var_25_9 = arg_25_2.Find(var_25_8, "record_btn")

	local function var_25_10()
		local var_29_0 = arg_25_0
		local var_29_1 = var_0.emit

		GuildEventMediator = var_2_10003

		local var_29_2 = var_2_10003.COMMANDER_FORMATION_OP
		local var_29_3 = {}
		local var_29_4 = {
			fleet = arg_25_0.fleet
		}

		LevelUIConst = var_6
		var_29_4.type = var_6.COMMANDER_OP_RECORD_PREFAB
		var_29_4.id = arg_25_1.id
		var_29_3.data = var_29_4
		var_29_3.fleetId = arg_25_0.fleet.id

		var_29_1(var_29_0, var_29_2, var_29_3)

		return
	end

	SFX_PANEL = var_25_8

	var_25_0(var_25_7, var_25_9, var_25_10, var_25_8)

	local var_25_11 = {
		arg_25_2:Find("commander1/frame/info"),
		arg_25_2:Find("commander2/frame/info")
	}
	local var_25_12 = {
		arg_25_2:Find("commander1/skill_info"),
		arg_25_2:Find("commander2/skill_info")
	}

	ipairs = var_8

	for iter_25_0, iter_25_1 in var_8(var_25_11) do
		local var_25_13 = arg_25_1:getCommanderByPos(iter_25_0)

		arg_25_0:updateCommander(iter_25_1, iter_25_0, var_25_13)
		arg_25_0:updateSkillTF(var_25_13, var_25_12[iter_25_0])
	end

	return
end

function var_0_1.CloseRecordPanel(arg_30_0)
	setActive = var_1_10001

	var_1_10001(arg_30_0.descFrameTF, true)

	setActive = var_1_10001

	var_1_10001(arg_30_0.recordPanel, false)

	return
end

function var_0_1.OnDestroy(arg_31_0)
	local var_31_0 = arg_31_0

	if arg_31_0.isShowing(var_31_0) then
		LeanTween = var_1

		local var_31_1 = var_1.cancel

		go = var_31_0

		var_31_1(var_31_0(arg_31_0.samllTF))

		LeanTween = var_31_1

		local var_31_2 = var_31_1.cancel

		go = var_3

		var_31_2(var_3(arg_31_0.descFrameTF))
	end

	return
end

return var_0_1

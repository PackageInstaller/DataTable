class = var_0_10000

local var_0_0 = "LevelCMDFormationView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "LevelCommanderView"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.descFrameTF = var_1.Find(var_2_0, "frame")

	local var_2_1 = arg_2_0.descFrameTF

	arg_2_0.descPos1 = var_1.Find(var_2_1, "commander1/frame/info")

	local var_2_2 = arg_2_0.descFrameTF

	arg_2_0.descPos2 = var_1.Find(var_2_2, "commander2/frame/info")

	local var_2_3 = arg_2_0.descFrameTF

	arg_2_0.skillTFPos1 = var_1.Find(var_2_3, "commander1/skill_info")

	local var_2_4 = arg_2_0.descFrameTF

	arg_2_0.skillTFPos2 = var_1.Find(var_2_4, "commander2/skill_info")
	UIItemList = var_1

	local var_2_5 = var_1.New
	local var_2_6 = arg_2_0.descFrameTF
	local var_2_7 = var_2.Find(var_2_6, "atttr_panel/abilitys/mask/content")
	local var_2_8 = arg_2_0.descFrameTF

	arg_2_0.abilitysTF = var_2_5(var_2_7, var_3.Find(var_2_8, "atttr_panel/abilitys/mask/content/attr"))
	UIItemList = var_1

	local var_2_9 = var_1.New
	local var_2_10 = arg_2_0.descFrameTF
	local var_2_11 = var_2.Find(var_2_10, "atttr_panel/talents/mask/content")
	local var_2_12 = arg_2_0.descFrameTF

	arg_2_0.talentsTF = var_2_9(var_2_11, var_3.Find(var_2_12, "atttr_panel/talents/mask/content/attr"))

	local var_2_13 = arg_2_0._tf

	arg_2_0.abilityArr = var_1.Find(var_2_13, "frame/atttr_panel/abilitys/arr")

	local var_2_14 = arg_2_0._tf

	arg_2_0.talentsArr = var_1.Find(var_2_14, "frame/atttr_panel/talents/arr")

	local var_2_15 = arg_2_0.descFrameTF

	arg_2_0.restAllBtn = var_1.Find(var_2_15, "rest_all")

	local var_2_16 = arg_2_0.descFrameTF

	arg_2_0.quickBtn = var_1.Find(var_2_16, "quick_btn")

	local var_2_17 = arg_2_0._tf

	arg_2_0.recordPanel = var_1.Find(var_2_17, "record_panel")

	local var_2_18 = {}
	local var_2_19 = arg_2_0.recordPanel

	var_2_18[1] = var_2.Find(var_2_19, "current/commanders/commander1/frame/info")

	local var_2_20 = arg_2_0.recordPanel

	var_2_18[2] = var_2.Find(var_2_20, "current/commanders/commander2/frame/info")
	arg_2_0.recordCommanders = var_2_18

	local var_2_21 = {}
	local var_2_22 = arg_2_0.recordPanel

	var_2_21[1] = var_2.Find(var_2_22, "current/commanders/commander1/skill_info")

	local var_2_23 = arg_2_0.recordPanel

	var_2_21[2] = var_2.Find(var_2_23, "current/commanders/commander2/skill_info")
	arg_2_0.reocrdSkills = var_2_21
	UIItemList = var_2_21

	local var_2_24 = var_2_21.New
	local var_2_25 = arg_2_0.recordPanel
	local var_2_26 = var_2.Find(var_2_25, "record/content")
	local var_2_27 = arg_2_0.recordPanel

	arg_2_0.recordList = var_2_24(var_2_26, var_3.Find(var_2_27, "record/content/commanders"))
	onButton = var_1

	local var_2_28 = arg_2_0
	local var_2_29 = arg_2_0.restAllBtn

	local function var_2_30()
		local var_3_0 = arg_2_0.callback
		local var_3_1 = {}

		LevelUIConst = var_2_10002
		var_3_1.type = var_2_10002.COMMANDER_OP_REST_ALL

		var_3_0(var_3_1)

		return
	end

	SFX_PANEL = var_5

	var_1(var_2_28, var_2_29, var_2_30, var_5)

	onButton = var_1

	local var_2_31 = arg_2_0
	local var_2_32 = arg_2_0.quickBtn

	local function var_2_33()
		local var_4_0 = arg_2_0

		var_0.OpenRecordPanel(var_4_0)

		return
	end

	SFX_PANEL = var_5

	var_1(var_2_31, var_2_32, var_2_33, var_5)

	onButton = var_1

	local var_2_34 = arg_2_0
	local var_2_35 = arg_2_0.recordPanel
	local var_2_36 = var_3.Find(var_2_35, "back")

	local function var_2_37()
		local var_5_0 = arg_2_0

		var_0.CloseRecordPanel(var_5_0)

		return
	end

	SFX_PANEL = var_5

	var_1(var_2_34, var_2_36, var_2_37, var_5)

	onButton = var_1

	local var_2_38 = arg_2_0
	local var_2_39 = arg_2_0._tf
	local var_2_40 = var_3.Find(var_2_39, "bg")

	local function var_2_41()
		local var_6_0 = arg_2_0

		var_0.onBackPressed(var_6_0)

		return
	end

	SFX_PANEL = var_5

	var_1(var_2_38, var_2_40, var_2_41, var_5)

	return
end

function var_0_1.didEnter(arg_7_0)
	pg = var_1_10001

	local var_7_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_7_0, arg_7_0._tf)

	return
end

function var_0_1.willExit(arg_8_0)
	pg = var_1_10001

	local var_8_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_8_0, arg_8_0._tf)

	return
end

function var_0_1.setCallback(arg_9_0, arg_9_1)
	arg_9_0.callback = arg_9_1

	return
end

function var_0_1.updateFleet(arg_10_0, arg_10_1)
	arg_10_0.fleet = arg_10_1

	arg_10_0:updateDesc()
	arg_10_0:updateRecordFleet()

	return
end

function var_0_1.setCommanderPrefabs(arg_11_0, arg_11_1)
	arg_11_0.prefabFleets = arg_11_1

	arg_11_0:updateRecordPanel()

	return
end

function var_0_1.updateRecordFleet(arg_12_0)
	local var_12_0 = arg_12_0.fleet
	local var_12_1 = var_1.getCommanders(var_12_0)

	ipairs = var_12_0

	for iter_12_0, iter_12_1 in var_12_0(arg_12_0.recordCommanders) do
		local var_12_2 = var_12_1[iter_12_0]

		arg_12_0:updateCommander(iter_12_1, iter_12_0, var_12_2)
		arg_12_0:updateSkillTF(var_12_2, arg_12_0.reocrdSkills[iter_12_0])
	end

	return
end

function var_0_1.updateRecordPanel(arg_13_0)
	local var_13_0 = arg_13_0.fleet
	local var_13_1 = var_1.getCommanders(var_13_0)
	local var_13_2 = arg_13_0.recordList

	var_2.make(var_13_2, function(arg_14_0, arg_14_1, arg_14_2)
		UIItemList = var_2_10003

		if arg_14_0 == var_2_10003.EventUpdate then
			local var_14_0 = arg_13_0.prefabFleets[arg_14_1 + 1]
			local var_14_1 = arg_13_0

			var_4.UpdatePrefabFleet(var_14_1, var_14_0, arg_14_2, var_13_1)
		end

		return
	end)

	local var_13_3 = arg_13_0.recordList

	var_2.align(var_13_3, #arg_13_0.prefabFleets)

	return
end

function var_0_1.UpdatePrefabFleet(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = arg_15_2:Find("fleet_name")
	local var_15_1 = arg_15_1
	local var_15_2 = arg_15_1.getName(var_15_1)

	onInputEndEdit = var_15_1

	var_15_1(arg_15_0, var_15_0, function()
		getInputText = var_2_10000

		local var_16_0 = var_2_10000(var_15_0)
		local var_16_1 = arg_15_0.callback
		local var_16_2 = {}

		LevelUIConst = var_2_10003
		var_16_2.type = var_2_10003.COMMANDER_OP_RENAME
		var_16_2.id = arg_15_1.id
		var_16_2.str = var_16_0

		function var_16_2.onFailed()
			setInputText = var_3_10000

			var_3_10000(var_15_0, var_15_2)

			return
		end

		var_16_1(var_16_2)

		return
	end)

	setInputText = var_15_1

	var_15_1(var_15_0, var_15_2)

	onButton = var_15_1

	local var_15_3 = arg_15_0
	local var_15_4 = arg_15_2:Find("use_btn")

	local function var_15_5()
		local var_18_0 = arg_15_0.callback
		local var_18_1 = {}

		LevelUIConst = var_2_10002
		var_18_1.type = var_2_10002.COMMANDER_OP_USE_PREFAB
		var_18_1.id = arg_15_1.id

		var_18_0(var_18_1)

		local var_18_2 = arg_15_0

		var_0.CloseRecordPanel(var_18_2)

		return
	end

	SFX_PANEL = var_10

	var_15_1(var_15_3, var_15_4, var_15_5, var_10)

	onButton = var_15_1

	local var_15_6 = arg_15_0
	local var_15_7 = arg_15_2:Find("record_btn")

	local function var_15_8()
		local var_19_0 = arg_15_0.callback
		local var_19_1 = {}

		LevelUIConst = var_2_10002
		var_19_1.type = var_2_10002.COMMANDER_OP_RECORD_PREFAB
		var_19_1.id = arg_15_1.id

		var_19_0(var_19_1)

		return
	end

	SFX_PANEL = var_10

	var_15_1(var_15_6, var_15_7, var_15_8, var_10)

	local var_15_9 = {
		arg_15_2:Find("commander1/frame/info"),
		arg_15_2:Find("commander2/frame/info")
	}
	local var_15_10 = {
		arg_15_2:Find("commander1/skill_info"),
		arg_15_2:Find("commander2/skill_info")
	}

	ipairs = var_8

	for iter_15_0, iter_15_1 in var_8(var_15_9) do
		local var_15_11 = arg_15_1:getCommanderByPos(iter_15_0)

		arg_15_0:updateCommander(iter_15_1, iter_15_0, var_15_11)
		arg_15_0:updateSkillTF(var_15_11, var_15_10[iter_15_0])
	end

	return
end

function var_0_1.updateDesc(arg_20_0)
	local var_20_0 = arg_20_0.fleet
	local var_20_1 = var_1.getCommanders(var_20_0)
	local var_20_2 = 1

	CommanderConst = var_1_10003

	for iter_20_0 = var_20_2, var_1_10003.MAX_FORMATION_POS do
		local var_20_3 = var_20_1[iter_20_0]

		arg_20_0:updateCommander(arg_20_0["descPos" .. iter_20_0], iter_20_0, var_20_3, true)
		arg_20_0:updateSkillTF(var_20_3, arg_20_0["skillTFPos" .. iter_20_0])
	end

	arg_20_0:updateAdditions()

	return
end

function var_0_1.updateAdditions(arg_21_0)
	local var_21_0 = arg_21_0.fleet

	_ = var_1_10002

	local var_21_1 = var_1_10002.values(var_21_0:getCommandersTalentDesc())
	local var_21_2, var_21_3 = var_21_0:getCommandersAddition()
	local var_21_4 = arg_21_0.abilitysTF

	var_5.make(var_21_4, function(arg_22_0, arg_22_1, arg_22_2)
		UIItemList = var_2_10003

		if arg_22_0 == var_2_10003.EventUpdate then
			local var_22_0 = var_21_2[arg_22_1 + 1]

			setText = var_4

			local var_22_1 = arg_22_2
			local var_22_2 = arg_22_2.Find(var_22_1, "name")

			AttributeType = var_22_1

			var_4(var_22_2, var_22_1.Type2Name(var_22_0.attrName))

			setText = var_4

			local var_22_3 = arg_22_2
			local var_22_4 = arg_22_2.Find(var_22_3, "Text")

			string = var_22_3

			var_4(var_22_4, var_22_3.format("%0.3f", var_22_0.value) .. "%")

			GetImageSpriteFromAtlasAsync = var_4

			var_4("attricon", var_22_0.attrName, arg_22_2:Find("icon"), false)

			setImageAlpha = var_4

			var_4(arg_22_2:Find("bg"), arg_22_1 % 2)
		end

		return
	end)

	local var_21_5 = arg_21_0.abilitysTF

	var_5.align(var_21_5, #var_21_2)

	setActive = var_5

	var_5(arg_21_0.abilityArr, #var_21_2 > 4)

	local var_21_6 = arg_21_0.talentsTF

	var_5.make(var_21_6, function(arg_23_0, arg_23_1, arg_23_2)
		UIItemList = var_2_10003

		if arg_23_0 == var_2_10003.EventUpdate then
			local var_23_0 = var_21_1[arg_23_1 + 1]

			setScrollText = var_4
			findTF = var_2_10005

			var_4(var_2_10005(arg_23_2, "name_mask/name"), var_23_0.name)

			local var_23_1 = var_23_0.type

			CommanderConst = var_5

			local var_23_2 = var_23_1 == var_5.TALENT_ADDITION_RATIO and "%" or ""

			setText = var_5

			var_5(arg_23_2:Find("Text"), var_23_0.value .. var_23_2)

			setImageAlpha = var_5

			var_5(arg_23_2:Find("bg"), arg_23_1 % 2)
		end

		return
	end)

	local var_21_7 = arg_21_0.talentsTF

	var_5.align(var_21_7, #var_21_1)

	setActive = var_5

	var_5(arg_21_0.talentsArr, #var_21_1 > 4)

	return
end

function var_0_1.updateSkillTF(arg_24_0, arg_24_1, arg_24_2)
	setActive = var_1_10003

	var_1_10003(arg_24_2, arg_24_1)

	if arg_24_1 then
		local var_24_0 = arg_24_1

		var_1_10003 = arg_24_1.getSkills(var_24_0)[1]
		GetImageSpriteFromAtlasAsync = var_24_0

		var_24_0("CommanderSkillIcon/" .. var_1_10003:getConfig("icon"), "", arg_24_2:Find("icon"))

		setText = var_24_0

		local var_24_1 = arg_24_2:Find("level")
		local var_24_2 = "Lv."
		local var_24_3 = var_1_10003

		var_24_0(var_24_1, var_24_2 .. var_1_10003.getLevel(var_24_3))

		onButton = var_24_0

		local var_24_4 = arg_24_0
		local var_24_5 = arg_24_2

		local function var_24_6()
			local var_25_0 = arg_24_0.callback
			local var_25_1 = {}

			LevelUIConst = var_2_10002
			var_25_1.type = var_2_10002.COMMANDER_OP_SHOW_SKILL
			var_25_1.skill = var_1_10003

			var_25_0(var_25_1)

			return
		end

		SFX_PANEL = var_24_3

		var_24_0(var_24_4, var_24_5, var_24_6, var_24_3)
	else
		removeOnButton = var_1_10003

		var_1_10003(arg_24_2)
	end

	return
end

function var_0_1.updateCommander(arg_26_0, arg_26_1, arg_26_2, arg_26_3, arg_26_4)
	local var_26_0 = arg_26_1:Find("add")
	local var_26_1 = arg_26_1
	local var_26_2 = arg_26_1.Find(var_26_1, "info")

	if arg_26_3 then
		var_26_1 = arg_26_1:Find("info/mask/icon")

		local var_26_3 = arg_26_1
		local var_26_4 = arg_26_1.Find(var_26_3, "info/frame")

		GetImageSpriteFromAtlasAsync = var_26_3

		var_26_3("CommanderHrz/" .. arg_26_3:getPainting(), "", var_26_1)

		local var_26_5 = arg_26_1

		if arg_26_1.Find(var_26_5, "info/name") then
			setText = var_26_5
			var_1_10011 = var_9
			var_1_10013 = arg_26_3

			var_26_5(var_1_10011, arg_26_3.getName(var_1_10013))
		end

		Commander = var_26_5

		local var_26_6 = var_26_5.rarity2Frame(arg_26_3:getRarity())

		setImageSprite = var_1_10011

		local var_26_7 = var_26_4

		GetSpriteFromAtlas = var_1_10013

		var_1_10011(var_26_7, var_1_10013("weaponframes", "commander_" .. var_26_6))
	end

	if arg_26_4 then
		onButton = var_26_1

		local var_26_8 = arg_26_0
		local var_26_9 = var_26_2

		local function var_26_10()
			local var_27_0 = arg_26_0.callback
			local var_27_1 = {}

			LevelUIConst = var_2_10002
			var_27_1.type = var_2_10002.COMMANDER_OP_ADD
			var_27_1.pos = arg_26_2

			var_27_0(var_27_1)

			return
		end

		SFX_PANEL = var_1_10011

		var_26_1(var_26_8, var_26_9, var_26_10, var_1_10011)

		onButton = var_26_1

		local var_26_11 = arg_26_0
		local var_26_12 = var_26_0

		local function var_26_13()
			local var_28_0 = arg_26_0.callback
			local var_28_1 = {}

			LevelUIConst = var_2_10002
			var_28_1.type = var_2_10002.COMMANDER_OP_ADD
			var_28_1.pos = arg_26_2

			var_28_0(var_28_1)

			return
		end

		SFX_PANEL = var_1_10011

		var_26_1(var_26_11, var_26_12, var_26_13, var_1_10011)
	end

	setActive = var_26_1

	var_26_1(var_26_0, not arg_26_3)

	setActive = var_26_1

	var_26_1(var_26_2, arg_26_3)

	return
end

function var_0_1.OpenRecordPanel(arg_29_0)
	setActive = var_1_10001

	var_1_10001(arg_29_0.descFrameTF, false)

	setActive = var_1_10001

	var_1_10001(arg_29_0.recordPanel, true)

	return
end

function var_0_1.CloseRecordPanel(arg_30_0)
	setActive = var_1_10001

	var_1_10001(arg_30_0.descFrameTF, true)

	setActive = var_1_10001

	var_1_10001(arg_30_0.recordPanel, false)

	return
end

return var_0_1

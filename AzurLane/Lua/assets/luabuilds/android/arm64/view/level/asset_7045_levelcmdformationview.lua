class = var_0_10000

local var_0_0 = "LevelCMDFormationView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "LevelCommanderView"
end

function var_0_1.OnInit(arg_2_0)
	arg_2_0:InitUI()

	return
end

function var_0_1.OnDestroy(arg_3_0)
	if arg_3_0:isShowing() then
		arg_3_0:Hide()
	end

	arg_3_0.callback = nil

	return
end

function var_0_1.Show(arg_4_0)
	pg = var_1_10001

	local var_4_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_4_0, arg_4_0._tf)

	setActive = var_1

	var_1(arg_4_0._tf, true)

	return
end

function var_0_1.Hide(arg_5_0)
	setActive = var_1_10001

	var_1_10001(arg_5_0._go, false)

	pg = var_1_10001

	local var_5_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_5_0, arg_5_0._tf, arg_5_0._parentTf)

	return
end

function var_0_1.InitUI(arg_6_0)
	local var_6_0 = arg_6_0._tf

	arg_6_0.descFrameTF = var_1.Find(var_6_0, "frame")

	local var_6_1 = arg_6_0.descFrameTF

	arg_6_0.descPos1 = var_1.Find(var_6_1, "commander1/frame/info")

	local var_6_2 = arg_6_0.descFrameTF

	arg_6_0.descPos2 = var_1.Find(var_6_2, "commander2/frame/info")

	local var_6_3 = arg_6_0.descFrameTF

	arg_6_0.skillTFPos1 = var_1.Find(var_6_3, "commander1/skill_info")

	local var_6_4 = arg_6_0.descFrameTF

	arg_6_0.skillTFPos2 = var_1.Find(var_6_4, "commander2/skill_info")
	UIItemList = var_1

	local var_6_5 = var_1.New
	local var_6_6 = arg_6_0.descFrameTF
	local var_6_7 = var_3.Find(var_6_6, "atttr_panel/abilitys/mask/content")
	local var_6_8 = arg_6_0.descFrameTF

	arg_6_0.abilitysTF = var_6_5(var_6_7, var_4.Find(var_6_8, "atttr_panel/abilitys/mask/content/attr"))
	UIItemList = var_1

	local var_6_9 = var_1.New
	local var_6_10 = arg_6_0.descFrameTF
	local var_6_11 = var_3.Find(var_6_10, "atttr_panel/talents/mask/content")
	local var_6_12 = arg_6_0.descFrameTF

	arg_6_0.talentsTF = var_6_9(var_6_11, var_4.Find(var_6_12, "atttr_panel/talents/mask/content/attr"))

	local var_6_13 = arg_6_0._tf

	arg_6_0.abilityArr = var_1.Find(var_6_13, "frame/atttr_panel/abilitys/arr")

	local var_6_14 = arg_6_0._tf

	arg_6_0.talentsArr = var_1.Find(var_6_14, "frame/atttr_panel/talents/arr")

	local var_6_15 = arg_6_0.descFrameTF

	arg_6_0.restAllBtn = var_1.Find(var_6_15, "rest_all")

	local var_6_16 = arg_6_0.descFrameTF

	arg_6_0.quickBtn = var_1.Find(var_6_16, "quick_btn")

	local var_6_17 = arg_6_0._tf

	arg_6_0.recordPanel = var_1.Find(var_6_17, "record_panel")

	local var_6_18 = {}
	local var_6_19 = arg_6_0.recordPanel

	var_6_18[1] = var_2.Find(var_6_19, "current/commanders/commander1/frame/info")

	local var_6_20 = arg_6_0.recordPanel

	var_6_18[2] = var_2.Find(var_6_20, "current/commanders/commander2/frame/info")
	arg_6_0.recordCommanders = var_6_18

	local var_6_21 = {}
	local var_6_22 = arg_6_0.recordPanel

	var_6_21[1] = var_2.Find(var_6_22, "current/commanders/commander1/skill_info")

	local var_6_23 = arg_6_0.recordPanel

	var_6_21[2] = var_2.Find(var_6_23, "current/commanders/commander2/skill_info")
	arg_6_0.reocrdSkills = var_6_21
	UIItemList = var_6_21

	local var_6_24 = var_6_21.New
	local var_6_25 = arg_6_0.recordPanel
	local var_6_26 = var_3.Find(var_6_25, "record/content")
	local var_6_27 = arg_6_0.recordPanel

	arg_6_0.recordList = var_6_24(var_6_26, var_4.Find(var_6_27, "record/content/commanders"))
	onButton = var_1

	local var_6_28 = arg_6_0
	local var_6_29 = arg_6_0.restAllBtn

	local function var_6_30()
		local var_7_0 = arg_6_0.callback
		local var_7_1 = {}

		LevelUIConst = var_2_10003
		var_7_1.type = var_2_10003.COMMANDER_OP_REST_ALL

		var_7_0(var_7_1)

		return
	end

	SFX_PANEL = var_6_27

	var_1(var_6_28, var_6_29, var_6_30, var_6_27)

	onButton = var_1

	local var_6_31 = arg_6_0
	local var_6_32 = arg_6_0.quickBtn

	local function var_6_33()
		local var_8_0 = arg_6_0

		var_0.OpenRecordPanel(var_8_0)

		return
	end

	SFX_PANEL = var_6_27

	var_1(var_6_31, var_6_32, var_6_33, var_6_27)

	onButton = var_1

	local var_6_34 = arg_6_0
	local var_6_35 = arg_6_0.recordPanel
	local var_6_36 = var_4.Find(var_6_35, "back")

	local function var_6_37()
		local var_9_0 = arg_6_0

		var_0.CloseRecordPanel(var_9_0)

		return
	end

	SFX_PANEL = var_6_35

	var_1(var_6_34, var_6_36, var_6_37, var_6_35)

	onButton = var_1

	local var_6_38 = arg_6_0
	local var_6_39 = arg_6_0._tf
	local var_6_40 = var_4.Find(var_6_39, "bg")

	local function var_6_41()
		local var_10_0 = arg_6_0

		var_0.Hide(var_10_0)

		return
	end

	SFX_PANEL = var_6_39

	var_1(var_6_38, var_6_40, var_6_41, var_6_39)

	return
end

function var_0_1.setCallback(arg_11_0, arg_11_1)
	arg_11_0.callback = arg_11_1

	return
end

function var_0_1.update(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0:updateFleet(arg_12_1)
	arg_12_0:updatePrefabs(arg_12_2)

	return
end

function var_0_1.updateFleet(arg_13_0, arg_13_1)
	arg_13_0.fleet = arg_13_1

	arg_13_0:updateDesc()
	arg_13_0:updateRecordFleet()

	return
end

function var_0_1.updatePrefabs(arg_14_0, arg_14_1)
	arg_14_0.prefabFleets = arg_14_1

	arg_14_0:updateRecordPanel()

	return
end

function var_0_1.updateRecordFleet(arg_15_0)
	local var_15_0 = arg_15_0.fleet
	local var_15_1 = var_1.getCommanders(var_15_0)

	ipairs = var_1_10002

	for iter_15_0, iter_15_1 in var_1_10002(arg_15_0.recordCommanders) do
		local var_15_2 = var_15_1[iter_15_0]

		arg_15_0:updateCommander(iter_15_1, iter_15_0, var_15_2)
		arg_15_0:updateSkillTF(var_15_2, arg_15_0.reocrdSkills[iter_15_0])
	end

	return
end

function var_0_1.updateRecordPanel(arg_16_0)
	local var_16_0 = arg_16_0.fleet
	local var_16_1 = var_1.getCommanders(var_16_0)
	local var_16_2 = arg_16_0.recordList

	var_2.make(var_16_2, function(arg_17_0, arg_17_1, arg_17_2)
		UIItemList = var_2_10003

		if arg_17_0 == var_2_10003.EventUpdate then
			local var_17_0 = arg_16_0.prefabFleets[arg_17_1 + 1]
			local var_17_1 = arg_16_0

			var_4.UpdatePrefabFleet(var_17_1, var_17_0, arg_17_2, var_16_1)
		end

		return
	end)

	local var_16_3 = arg_16_0.recordList

	var_2.align(var_16_3, #arg_16_0.prefabFleets)

	return
end

function var_0_1.UpdatePrefabFleet(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = arg_18_2
	local var_18_1 = arg_18_2.Find(var_18_0, "fleet_name")
	local var_18_2 = arg_18_1:getName()

	onInputEndEdit = var_18_0

	var_18_0(arg_18_0, var_18_1, function()
		getInputText = var_2_10000

		local var_19_0 = var_2_10000(var_18_1)
		local var_19_1 = arg_18_0.callback
		local var_19_2 = {}

		LevelUIConst = var_2_10004
		var_19_2.type = var_2_10004.COMMANDER_OP_RENAME
		var_19_2.id = arg_18_1.id
		var_19_2.str = var_19_0

		function var_19_2.onFailed()
			setInputText = var_3_10000

			var_3_10000(var_18_1, var_18_2)

			return
		end

		var_19_1(var_19_2)

		return
	end)

	setInputText = var_18_0

	var_18_0(var_18_1, var_18_2)

	onButton = var_18_0

	local var_18_3 = arg_18_0
	local var_18_4 = arg_18_2
	local var_18_5 = arg_18_2.Find(var_18_4, "use_btn")

	local function var_18_6()
		local var_21_0 = arg_18_0.callback
		local var_21_1 = {}

		LevelUIConst = var_2_10003
		var_21_1.type = var_2_10003.COMMANDER_OP_USE_PREFAB
		var_21_1.id = arg_18_1.id

		var_21_0(var_21_1)

		local var_21_2 = arg_18_0

		var_0.CloseRecordPanel(var_21_2)

		return
	end

	SFX_PANEL = var_18_4

	var_18_0(var_18_3, var_18_5, var_18_6, var_18_4)

	onButton = var_18_0

	local var_18_7 = arg_18_0
	local var_18_8 = arg_18_2
	local var_18_9 = arg_18_2.Find(var_18_8, "record_btn")

	local function var_18_10()
		local var_22_0 = arg_18_0.callback
		local var_22_1 = {}

		LevelUIConst = var_2_10003
		var_22_1.type = var_2_10003.COMMANDER_OP_RECORD_PREFAB
		var_22_1.id = arg_18_1.id

		var_22_0(var_22_1)

		return
	end

	SFX_PANEL = var_18_8

	var_18_0(var_18_7, var_18_9, var_18_10, var_18_8)

	local var_18_11 = {
		arg_18_2:Find("commander1/frame/info"),
		arg_18_2:Find("commander2/frame/info")
	}
	local var_18_12 = {
		arg_18_2:Find("commander1/skill_info"),
		arg_18_2:Find("commander2/skill_info")
	}

	ipairs = var_8

	for iter_18_0, iter_18_1 in var_8(var_18_11) do
		local var_18_13 = arg_18_1:getCommanderByPos(iter_18_0)

		arg_18_0:updateCommander(iter_18_1, iter_18_0, var_18_13)
		arg_18_0:updateSkillTF(var_18_13, var_18_12[iter_18_0])
	end

	return
end

function var_0_1.updateDesc(arg_23_0)
	local var_23_0 = arg_23_0.fleet
	local var_23_1 = var_1.getCommanders(var_23_0)
	local var_23_2 = 1

	CommanderConst = var_23_0

	for iter_23_0 = var_23_2, var_23_0.MAX_FORMATION_POS do
		local var_23_3 = var_23_1[iter_23_0]

		arg_23_0:updateCommander(arg_23_0["descPos" .. iter_23_0], iter_23_0, var_23_3, true)
		arg_23_0:updateSkillTF(var_23_3, arg_23_0["skillTFPos" .. iter_23_0])
	end

	arg_23_0:updateAdditions()

	return
end

function var_0_1.updateAdditions(arg_24_0)
	local var_24_0 = arg_24_0.fleet

	_ = var_1_10002

	local var_24_1 = var_1_10002.values(var_24_0:getCommandersTalentDesc())
	local var_24_2, var_24_3 = var_24_0:getCommandersAddition()
	local var_24_4 = arg_24_0.abilitysTF

	var_5.make(var_24_4, function(arg_25_0, arg_25_1, arg_25_2)
		UIItemList = var_2_10003

		if arg_25_0 == var_2_10003.EventUpdate then
			local var_25_0 = var_24_2[arg_25_1 + 1]

			setText = var_4

			local var_25_1 = arg_25_2:Find("name")

			AttributeType = var_2_10007

			var_4(var_25_1, var_2_10007.Type2Name(var_25_0.attrName))

			setText = var_4

			local var_25_2 = arg_25_2:Find("Text")

			string = var_7

			var_4(var_25_2, var_7.format("%0.3f", var_25_0.value) .. "%")

			GetImageSpriteFromAtlasAsync = var_4

			var_4("attricon", var_25_0.attrName, arg_25_2:Find("icon"), false)

			setImageAlpha = var_4

			var_4(arg_25_2:Find("bg"), arg_25_1 % 2)
		end

		return
	end)

	local var_24_5 = arg_24_0.abilitysTF

	var_5.align(var_24_5, #var_24_2)

	setActive = var_5

	var_5(arg_24_0.abilityArr, #var_24_2 > 4)

	local var_24_6 = arg_24_0.talentsTF

	var_5.make(var_24_6, function(arg_26_0, arg_26_1, arg_26_2)
		UIItemList = var_2_10003

		if arg_26_0 == var_2_10003.EventUpdate then
			local var_26_0 = var_24_1[arg_26_1 + 1]

			setScrollText = var_4
			findTF = var_2_10006

			var_4(var_2_10006(arg_26_2, "name_mask/name"), var_26_0.name)

			local var_26_1 = var_26_0.type

			CommanderConst = var_2_10005

			local var_26_2 = var_26_1 == var_2_10005.TALENT_ADDITION_RATIO and "%" or ""

			setText = var_5

			var_5(arg_26_2:Find("Text"), var_26_0.value .. var_26_2)

			setImageAlpha = var_5

			var_5(arg_26_2:Find("bg"), arg_26_1 % 2)
		end

		return
	end)

	local var_24_7 = arg_24_0.talentsTF

	var_5.align(var_24_7, #var_24_1)

	setActive = var_5

	var_5(arg_24_0.talentsArr, #var_24_1 > 4)

	return
end

function var_0_1.updateSkillTF(arg_27_0, arg_27_1, arg_27_2)
	setActive = var_1_10003

	var_1_10003(arg_27_2, arg_27_1)

	if arg_27_1 then
		var_1_10003 = arg_27_1:getSkills()[1]
		GetImageSpriteFromAtlasAsync = var_1_10004

		var_1_10004("CommanderSkillIcon/" .. var_1_10003:getConfig("icon"), "", arg_27_2:Find("icon"))

		setText = var_1_10004

		var_1_10004(arg_27_2:Find("level"), "Lv." .. var_1_10003:getLevel())

		onButton = var_1_10004

		local var_27_0 = arg_27_0
		local var_27_1 = arg_27_2

		local function var_27_2()
			local var_28_0 = arg_27_0.callback
			local var_28_1 = {}

			LevelUIConst = var_2_10003
			var_28_1.type = var_2_10003.COMMANDER_OP_SHOW_SKILL
			var_28_1.skill = var_1_10003

			var_28_0(var_28_1)

			return
		end

		SFX_PANEL = var_9

		var_1_10004(var_27_0, var_27_1, var_27_2, var_9)
	else
		removeOnButton = var_1_10003

		var_1_10003(arg_27_2)
	end

	return
end

function var_0_1.updateCommander(arg_29_0, arg_29_1, arg_29_2, arg_29_3, arg_29_4)
	local var_29_0 = arg_29_1
	local var_29_1 = arg_29_1.Find(var_29_0, "add")
	local var_29_2 = arg_29_1:Find("info")

	if arg_29_3 then
		local var_29_3 = arg_29_1

		var_29_0 = arg_29_1.Find(var_29_3, "info/mask/icon")

		local var_29_4 = arg_29_1
		local var_29_5 = arg_29_1.Find(var_29_4, "info/frame")

		GetImageSpriteFromAtlasAsync = var_29_3

		var_29_3("CommanderHrz/" .. arg_29_3:getPainting(), "", var_29_0)

		local var_29_6 = arg_29_1

		if arg_29_1.Find(var_29_6, "info/name") then
			setText = var_29_4

			var_29_4(var_9, arg_29_3:getName())
		end

		Commander = var_29_4

		local var_29_7 = var_29_4.rarity2Frame
		local var_29_8 = arg_29_3
		local var_29_9 = var_29_7(arg_29_3.getRarity(var_29_8))

		setImageSprite = var_29_6

		local var_29_10 = var_29_5

		GetSpriteFromAtlas = var_29_8

		var_29_6(var_29_10, var_29_8("weaponframes", "commander_" .. var_29_9))
	end

	if arg_29_4 then
		onButton = var_29_0

		local var_29_11 = arg_29_0
		local var_29_12 = var_29_2

		local function var_29_13()
			local var_30_0 = arg_29_0.callback
			local var_30_1 = {}

			LevelUIConst = var_2_10003
			var_30_1.type = var_2_10003.COMMANDER_OP_ADD
			var_30_1.pos = arg_29_2

			var_30_0(var_30_1)

			return
		end

		SFX_PANEL = var_1_10012

		var_29_0(var_29_11, var_29_12, var_29_13, var_1_10012)

		onButton = var_29_0

		local var_29_14 = arg_29_0
		local var_29_15 = var_29_1

		local function var_29_16()
			local var_31_0 = arg_29_0.callback
			local var_31_1 = {}

			LevelUIConst = var_2_10003
			var_31_1.type = var_2_10003.COMMANDER_OP_ADD
			var_31_1.pos = arg_29_2

			var_31_0(var_31_1)

			return
		end

		SFX_PANEL = var_1_10012

		var_29_0(var_29_14, var_29_15, var_29_16, var_1_10012)
	end

	setActive = var_29_0

	var_29_0(var_29_1, not arg_29_3)

	setActive = var_29_0

	var_29_0(var_29_2, arg_29_3)

	return
end

function var_0_1.OpenRecordPanel(arg_32_0)
	setActive = var_1_10001

	var_1_10001(arg_32_0.descFrameTF, false)

	setActive = var_1_10001

	var_1_10001(arg_32_0.recordPanel, true)

	return
end

function var_0_1.CloseRecordPanel(arg_33_0)
	setActive = var_1_10001

	var_1_10001(arg_33_0.descFrameTF, true)

	setActive = var_1_10001

	var_1_10001(arg_33_0.recordPanel, false)

	return
end

return var_0_1

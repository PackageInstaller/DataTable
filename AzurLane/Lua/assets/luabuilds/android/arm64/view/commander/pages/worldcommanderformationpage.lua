class = var_0_10000

local var_0_0 = "WorldCommanderFormationPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "WorldCommanderFormationUI"
end

function var_0_1.OnInit(arg_2_0)
	local var_2_0 = arg_2_0.rtAdapt

	arg_2_0.samllTF = var_1.Find(var_2_0, "small")
	setActive = var_1

	var_1(arg_2_0.samllTF, true)

	local var_2_1 = arg_2_0.samllTF

	arg_2_0.pos1 = var_1.Find(var_2_1, "commander1")

	local var_2_2 = arg_2_0.samllTF

	arg_2_0.pos2 = var_1.Find(var_2_2, "commander2")

	local var_2_3 = arg_2_0.samllTF

	arg_2_0.smallSalvageMask = var_1.Find(var_2_3, "salvage_mask")
	setText = var_1

	local var_2_4 = arg_2_0.smallSalvageMask
	local var_2_5 = var_3.Find(var_2_4, "text_bg/Text")

	i18n = var_4

	var_1(var_2_5, var_4("world_catsearch_help_4"))

	local var_2_6 = arg_2_0.rtAdapt

	arg_2_0.descPanel = var_1.Find(var_2_6, "desc")
	setActive = var_1

	var_1(arg_2_0.descPanel, false)

	local var_2_7 = arg_2_0.rtAdapt

	arg_2_0.descFrameTF = var_1.Find(var_2_7, "desc/frame")

	local var_2_8 = arg_2_0.descFrameTF

	arg_2_0.descSalvageMask = var_1.Find(var_2_8, "salvage_mask")
	setText = var_1

	local var_2_9 = arg_2_0.descSalvageMask
	local var_2_10 = var_3.Find(var_2_9, "text_bg/Text")

	i18n = var_4

	var_1(var_2_10, var_4("world_catsearch_help_5"))

	local var_2_11 = arg_2_0.descFrameTF

	arg_2_0.descPos1 = var_1.Find(var_2_11, "commander1/frame/info")

	local var_2_12 = arg_2_0.descFrameTF

	arg_2_0.descPos2 = var_1.Find(var_2_12, "commander2/frame/info")

	local var_2_13 = arg_2_0.descFrameTF

	arg_2_0.skillTFPos1 = var_1.Find(var_2_13, "commander1/skill_info")

	local var_2_14 = arg_2_0.descFrameTF

	arg_2_0.skillTFPos2 = var_1.Find(var_2_14, "commander2/skill_info")
	UIItemList = var_1

	local var_2_15 = var_1.New
	local var_2_16 = arg_2_0.descFrameTF
	local var_2_17 = var_3.Find(var_2_16, "atttr_panel/abilitys/mask/content")
	local var_2_18 = arg_2_0.descFrameTF

	arg_2_0.abilitysTF = var_2_15(var_2_17, var_4.Find(var_2_18, "atttr_panel/abilitys/mask/content/attr"))
	UIItemList = var_1

	local var_2_19 = var_1.New
	local var_2_20 = arg_2_0.descFrameTF
	local var_2_21 = var_3.Find(var_2_20, "atttr_panel/talents/mask/content")
	local var_2_22 = arg_2_0.descFrameTF

	arg_2_0.talentsTF = var_2_19(var_2_21, var_4.Find(var_2_22, "atttr_panel/talents/mask/content/attr"))

	local var_2_23 = arg_2_0.rtAdapt

	arg_2_0.abilityArr = var_1.Find(var_2_23, "desc/frame/atttr_panel/abilitys/arr")

	local var_2_24 = arg_2_0.rtAdapt

	arg_2_0.talentsArr = var_1.Find(var_2_24, "desc/frame/atttr_panel/talents/arr")

	local var_2_25 = arg_2_0.descFrameTF

	arg_2_0.restAllBtn = var_1.Find(var_2_25, "rest_all")
	setActive = var_1

	var_1(arg_2_0.restAllBtn, false)

	local var_2_26 = arg_2_0.descFrameTF

	arg_2_0.quickBtn = var_1.Find(var_2_26, "quick_btn")
	setActive = var_1

	var_1(arg_2_0.quickBtn, false)

	onButton = var_1

	local var_2_27 = arg_2_0
	local var_2_28 = arg_2_0.samllTF

	local function var_2_29()
		local var_3_0 = arg_2_0

		var_0.openDescPanel(var_3_0)

		return
	end

	SFX_PANEL = var_2_22

	var_1(var_2_27, var_2_28, var_2_29, var_2_22)

	onButton = var_1

	local var_2_30 = arg_2_0
	local var_2_31 = arg_2_0.descPanel

	local function var_2_32()
		local var_4_0 = arg_2_0

		var_0.closeDescPanel(var_4_0)

		return
	end

	SFX_PANEL = var_2_22

	var_1(var_2_30, var_2_31, var_2_32, var_2_22)

	setText = var_1

	local var_2_33 = arg_2_0.rtAdapt
	local var_2_34 = var_3.Find(var_2_33, "desc/frame/atttr_panel/abilitys/title/Text")

	i18n = var_2_31

	var_1(var_2_34, var_2_31("commander_subtile_ablity"))

	setText = var_1

	local var_2_35 = arg_2_0.rtAdapt
	local var_2_36 = var_3.Find(var_2_35, "desc/frame/atttr_panel/talents/title/Text")

	i18n = var_4

	var_1(var_2_36, var_4("commander_subtile_talent"))

	return
end

function var_0_1.Update(arg_5_0, arg_5_1)
	arg_5_0.fleet = arg_5_1

	local var_5_0 = arg_5_0.fleet
	local var_5_1 = var_2.getCommanders(var_5_0)
	local var_5_2 = 1

	CommanderConst = var_5_0

	for iter_5_0 = var_5_2, var_5_0.MAX_FORMATION_POS do
		local var_5_3 = var_5_1[iter_5_0]

		assert = var_1_10008

		var_1_10008(arg_5_0["pos" .. iter_5_0], "pos tf can not nil")
		arg_5_0:updateCommander(arg_5_0["pos" .. iter_5_0], iter_5_0, var_5_3)
	end

	arg_5_0:updateDesc()

	setActive = var_3

	local var_5_4 = arg_5_0.smallSalvageMask
	local var_5_5 = arg_5_0.fleet

	var_3(var_5_4, var_6.IsCatSalvage(var_5_5))

	setActive = var_3

	local var_5_6 = arg_5_0.descSalvageMask
	local var_5_7 = arg_5_0.fleet

	var_3(var_5_6, var_6.IsCatSalvage(var_5_7))

	return
end

function var_0_1.openDescPanel(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1 or 0.2

	LeanTween = var_1_10003

	local var_6_1 = var_1_10003.isTweening

	go = var_1_10005

	if not var_6_1(var_1_10005(arg_6_0.samllTF)) then
		LeanTween = var_6_2

		local var_6_2 = var_6_2.isTweening

		go = var_5

		if var_6_2(var_5(arg_6_0.descFrameTF)) then
			return
		end

		setAnchoredPosition = var_6_2

		var_6_2(arg_6_0.samllTF, {
			x = 0
		})

		LeanTween = var_6_2

		local var_6_3 = var_6_2.moveX(arg_6_0.samllTF, 800, var_6_0)
		local var_6_4 = var_3.setOnComplete

		System = var_6

		var_6_4(var_6_3, var_6.Action(function()
			setActive = var_2_10000

			var_2_10000(arg_6_0.descPanel, true)

			pg = var_2_10000

			local var_7_0 = var_2_10000.UIMgr.GetInstance()

			var_0.OverlayPanel(var_7_0, arg_6_0._tf)

			setAnchoredPosition = var_0

			var_0(arg_6_0.descFrameTF, {
				x = 800
			})

			LeanTween = var_0

			var_0.moveX(arg_6_0.descFrameTF, 0, var_6_0)

			return
		end))

		arg_6_0.contextData.inDescPage = true

		local var_6_5 = arg_6_0._tf

		var_3.SetAsLastSibling(var_6_5)

		return
	end
end

function var_0_1.closeDescPanel(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1 or 0.2

	LeanTween = var_1_10003

	local var_8_1 = var_1_10003.isTweening

	go = var_1_10005

	if not var_8_1(var_1_10005(arg_8_0.samllTF)) then
		LeanTween = var_8_2

		local var_8_2 = var_8_2.isTweening

		go = var_5

		if var_8_2(var_5(arg_8_0.descFrameTF)) then
			return
		end

		setAnchoredPosition = var_8_2

		var_8_2(arg_8_0.descFrameTF, {
			x = 0
		})

		LeanTween = var_8_2

		local var_8_3 = var_8_2.moveX(arg_8_0.descFrameTF, 800, var_8_0)
		local var_8_4 = var_3.setOnComplete

		System = var_6

		var_8_4(var_8_3, var_6.Action(function()
			setActive = var_2_10000

			var_2_10000(arg_8_0.descPanel, false)

			pg = var_2_10000

			local var_9_0 = var_2_10000.UIMgr.GetInstance()

			var_0.UnOverlayPanel(var_9_0, arg_8_0._tf, arg_8_0._parentTf)

			setAnchoredPosition = var_0

			var_0(arg_8_0.samllTF, {
				x = 800
			})

			LeanTween = var_0

			var_0.moveX(arg_8_0.samllTF, 0, var_8_0)

			return
		end))

		arg_8_0.contextData.inDescPage = false

		return
	end
end

function var_0_1.updateDesc(arg_10_0)
	local var_10_0 = arg_10_0.fleet
	local var_10_1 = var_1.getCommanders(var_10_0)
	local var_10_2 = 1

	CommanderConst = var_10_0

	for iter_10_0 = var_10_2, var_10_0.MAX_FORMATION_POS do
		local var_10_3 = var_10_1[iter_10_0]

		assert = var_1_10007

		var_1_10007(arg_10_0["pos" .. iter_10_0], "pos tf can not nil")
		arg_10_0:updateCommander(arg_10_0["descPos" .. iter_10_0], iter_10_0, var_10_3, true)
		arg_10_0:updateSkillTF(var_10_3, arg_10_0["skillTFPos" .. iter_10_0])
	end

	arg_10_0:updateAdditions()

	return
end

function var_0_1.updateAdditions(arg_11_0)
	local var_11_0 = arg_11_0.fleet

	_ = var_1_10002

	local var_11_1 = var_1_10002.values(var_11_0:getCommandersTalentDesc())
	local var_11_2, var_11_3 = var_11_0:getCommandersAddition()
	local var_11_4 = arg_11_0.abilitysTF

	var_5.make(var_11_4, function(arg_12_0, arg_12_1, arg_12_2)
		UIItemList = var_2_10003

		if arg_12_0 == var_2_10003.EventUpdate then
			local var_12_0 = var_11_2[arg_12_1 + 1]

			setText = var_4

			local var_12_1 = arg_12_2:Find("name")

			AttributeType = var_2_10007

			var_4(var_12_1, var_2_10007.Type2Name(var_12_0.attrName))

			setText = var_4

			local var_12_2 = arg_12_2
			local var_12_3 = arg_12_2.Find(var_12_2, "Text")
			local var_12_4 = "+"

			math = var_12_2

			var_4(var_12_3, (var_12_4 .. var_12_2.floor(var_12_0.value * 1000) / 1000) .. "%")

			GetImageSpriteFromAtlasAsync = var_4

			var_4("attricon", var_12_0.attrName, arg_12_2:Find("icon"), false)

			setImageAlpha = var_4

			var_4(arg_12_2:Find("bg"), arg_12_1 % 2)
		end

		return
	end)

	local var_11_5 = arg_11_0.abilitysTF

	var_5.align(var_11_5, #var_11_2)

	setActive = var_5

	var_5(arg_11_0.abilityArr, #var_11_2 > 4)

	local var_11_6 = arg_11_0.talentsTF

	var_5.make(var_11_6, function(arg_13_0, arg_13_1, arg_13_2)
		UIItemList = var_2_10003

		if arg_13_0 == var_2_10003.EventUpdate then
			local var_13_0 = var_11_1[arg_13_1 + 1]

			setScrollText = var_4
			findTF = var_2_10006

			var_4(var_2_10006(arg_13_2, "name_mask/name"), var_13_0.name)

			local var_13_1 = var_13_0.type

			CommanderConst = var_2_10005

			local var_13_2 = var_13_1 == var_2_10005.TALENT_ADDITION_RATIO and "%" or ""

			setText = var_5

			var_5(arg_13_2:Find("Text"), (var_13_0.value > 0 and "+" or "") .. var_13_0.value .. var_13_2)

			setImageAlpha = var_5

			var_5(arg_13_2:Find("bg"), arg_13_1 % 2)
		end

		return
	end)

	local var_11_7 = arg_11_0.talentsTF

	var_5.align(var_11_7, #var_11_1)

	setActive = var_5

	var_5(arg_11_0.talentsArr, #var_11_1 > 4)

	return
end

function var_0_1.updateSkillTF(arg_14_0, arg_14_1, arg_14_2)
	setActive = var_1_10003

	var_1_10003(arg_14_2, arg_14_1)

	if arg_14_1 then
		var_1_10003 = arg_14_1:getSkills()[1]
		GetImageSpriteFromAtlasAsync = var_1_10004

		var_1_10004("CommanderSkillIcon/" .. var_1_10003:getConfig("icon"), "", arg_14_2:Find("icon"))

		setText = var_1_10004

		var_1_10004(arg_14_2:Find("level"), "Lv." .. var_1_10003:getLevel())

		onButton = var_1_10004

		local var_14_0 = arg_14_0
		local var_14_1 = arg_14_2

		local function var_14_2()
			local var_15_0 = arg_14_0
			local var_15_1 = var_0.emit

			WorldDetailMediator = var_2_10003

			var_15_1(var_15_0, var_2_10003.OnCmdSkill, var_1_10003)

			return
		end

		SFX_PANEL = var_9

		var_1_10004(var_14_0, var_14_1, var_14_2, var_9)
	else
		removeOnButton = var_1_10003

		var_1_10003(arg_14_2)
	end

	return
end

function var_0_1.updateCommander(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	local var_16_0 = arg_16_1
	local var_16_1 = arg_16_1.Find(var_16_0, "add")
	local var_16_2 = arg_16_1:Find("info")

	if arg_16_3 then
		local var_16_3 = arg_16_1

		var_16_0 = arg_16_1.Find(var_16_3, "info/mask/icon")

		local var_16_4 = arg_16_1
		local var_16_5 = arg_16_1.Find(var_16_4, "info/frame")

		GetImageSpriteFromAtlasAsync = var_16_3

		var_16_3("CommanderHrz/" .. arg_16_3:getPainting(), "", var_16_0)

		local var_16_6 = arg_16_1

		if arg_16_1.Find(var_16_6, "info/name") then
			setText = var_16_4

			var_16_4(var_9, arg_16_3:getName())
		end

		Commander = var_16_4

		local var_16_7 = var_16_4.rarity2Frame
		local var_16_8 = arg_16_3
		local var_16_9 = var_16_7(arg_16_3.getRarity(var_16_8))

		setImageSprite = var_16_6

		local var_16_10 = var_16_5

		GetSpriteFromAtlas = var_16_8

		var_16_6(var_16_10, var_16_8("weaponframes", "commander_" .. var_16_9))
	end

	setActive = var_16_0

	var_16_0(var_16_1, not arg_16_3)

	setActive = var_16_0

	var_16_0(var_16_2, arg_16_3)

	return
end

function var_0_1.OnDestroy(arg_17_0)
	local var_17_0 = arg_17_0

	if arg_17_0.isShowing(var_17_0) then
		LeanTween = var_1

		local var_17_1 = var_1.cancel

		go = var_17_0

		var_17_1(var_17_0(arg_17_0.samllTF))

		LeanTween = var_17_1

		local var_17_2 = var_17_1.cancel

		go = var_3

		var_17_2(var_3(arg_17_0.descFrameTF))

		isActive = var_17_2

		if var_17_2(arg_17_0.descPanel) then
			pg = var_1

			local var_17_3 = var_1.UIMgr.GetInstance()

			var_1.UnOverlayPanel(var_17_3, arg_17_0._tf, arg_17_0._parentTf)
		end
	end

	return
end

return var_0_1

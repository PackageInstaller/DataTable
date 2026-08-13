class = var_0_10000

local var_0_0 = "LimitChallengeCommanderFormationPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

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
	setActive = var_1

	var_1(arg_2_0.restAllBtn, false)

	local var_2_18 = arg_2_0.descFrameTF

	arg_2_0.quickBtn = var_1.Find(var_2_18, "quick_btn")
	setActive = var_1

	var_1(arg_2_0.quickBtn, false)

	onButton = var_1

	local var_2_19 = arg_2_0
	local var_2_20 = arg_2_0.samllTF

	local function var_2_21()
		local var_3_0 = arg_2_0

		var_0.openDescPanel(var_3_0)

		return
	end

	SFX_PANEL = var_5

	var_1(var_2_19, var_2_20, var_2_21, var_5)

	onButton = var_1

	local var_2_22 = arg_2_0
	local var_2_23 = arg_2_0.descPanel

	local function var_2_24()
		local var_4_0 = arg_2_0

		var_0.closeDescPanel(var_4_0)

		return
	end

	SFX_PANEL = var_5

	var_1(var_2_22, var_2_23, var_2_24, var_5)

	return
end

function var_0_1.Update(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.fleet = arg_5_1
	arg_5_0.prefabFleets = arg_5_2

	local var_5_0 = arg_5_0.fleet
	local var_5_1 = var_3.getCommanders(var_5_0)
	local var_5_2 = 1

	CommanderConst = var_1_10005

	for iter_5_0 = var_5_2, var_1_10005.MAX_FORMATION_POS do
		local var_5_3 = var_5_1[iter_5_0]

		assert = var_1_10009

		var_1_10009(arg_5_0["pos" .. iter_5_0], "pos tf can not nil")
		arg_5_0:updateCommander(arg_5_0["pos" .. iter_5_0], iter_5_0, var_5_3)
	end

	arg_5_0:updateDesc()

	return
end

function var_0_1.openDescPanel(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1 or 0.2

	LeanTween = var_1_10003

	local var_6_1 = var_1_10003.isTweening

	go = var_1_10004

	if not var_6_1(var_1_10004(arg_6_0.samllTF)) then
		LeanTween = var_6_2

		local var_6_2 = var_6_2.isTweening

		go = var_4

		if var_6_2(var_4(arg_6_0.descFrameTF)) then
			return
		end

		setAnchoredPosition = var_6_2

		var_6_2(arg_6_0.samllTF, {
			x = 0
		})

		LeanTween = var_6_2

		local var_6_3 = var_6_2.moveX(arg_6_0.samllTF, 800, var_6_0)
		local var_6_4 = var_3.setOnComplete

		System = var_5

		var_6_4(var_6_3, var_5.Action(function()
			setActive = var_2_10000

			var_2_10000(arg_6_0.descPanel, true)

			local var_7_0 = arg_6_0

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

	go = var_1_10004

	if not var_8_1(var_1_10004(arg_8_0.samllTF)) then
		LeanTween = var_8_2

		local var_8_2 = var_8_2.isTweening

		go = var_4

		if var_8_2(var_4(arg_8_0.descFrameTF)) then
			return
		end

		setAnchoredPosition = var_8_2

		var_8_2(arg_8_0.descFrameTF, {
			x = 0
		})

		LeanTween = var_8_2

		local var_8_3 = var_8_2.moveX(arg_8_0.descFrameTF, 800, var_8_0)
		local var_8_4 = var_3.setOnComplete

		System = var_5

		var_8_4(var_8_3, var_5.Action(function()
			setActive = var_2_10000

			var_2_10000(arg_8_0.descPanel, false)

			local var_9_0 = arg_8_0

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

	CommanderConst = var_1_10003

	for iter_10_0 = var_10_2, var_1_10003.MAX_FORMATION_POS do
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

			local var_12_1 = arg_12_2
			local var_12_2 = arg_12_2.Find(var_12_1, "name")

			AttributeType = var_12_1

			var_4(var_12_2, var_12_1.Type2Name(var_12_0.attrName))

			setText = var_4

			local var_12_3 = arg_12_2:Find("Text")
			local var_12_4 = "+"

			math = var_7

			var_4(var_12_3, (var_12_4 .. var_7.floor(var_12_0.value * 1000) / 1000) .. "%")

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
			findTF = var_2_10005

			var_4(var_2_10005(arg_13_2, "name_mask/name"), var_13_0.name)

			local var_13_1 = var_13_0.type

			CommanderConst = var_5

			local var_13_2 = var_13_1 == var_5.TALENT_ADDITION_RATIO and "%" or ""

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
		local var_14_0 = arg_14_1

		var_1_10003 = arg_14_1.getSkills(var_14_0)[1]
		GetImageSpriteFromAtlasAsync = var_14_0

		var_14_0("CommanderSkillIcon/" .. var_1_10003:getConfig("icon"), "", arg_14_2:Find("icon"))

		setText = var_14_0

		local var_14_1 = arg_14_2:Find("level")
		local var_14_2 = "Lv."
		local var_14_3 = var_1_10003

		var_14_0(var_14_1, var_14_2 .. var_1_10003.getLevel(var_14_3))

		onButton = var_14_0

		local var_14_4 = arg_14_0
		local var_14_5 = arg_14_2

		local function var_14_6()
			local var_15_0 = arg_14_0
			local var_15_1 = var_0.emit

			LimitChallengePreCombatMediator = var_2_10002

			var_15_1(var_15_0, var_2_10002.ON_CMD_SKILL, var_1_10003)

			return
		end

		SFX_PANEL = var_14_3

		var_14_0(var_14_4, var_14_5, var_14_6, var_14_3)
	else
		removeOnButton = var_1_10003

		var_1_10003(arg_14_2)
	end

	return
end

function var_0_1.updateCommander(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	local var_16_0 = arg_16_1:Find("add")
	local var_16_1 = arg_16_1
	local var_16_2 = arg_16_1.Find(var_16_1, "info")

	if arg_16_3 then
		var_16_1 = arg_16_1:Find("info/mask/icon")

		local var_16_3 = arg_16_1
		local var_16_4 = arg_16_1.Find(var_16_3, "info/frame")

		GetImageSpriteFromAtlasAsync = var_16_3

		var_16_3("CommanderHrz/" .. arg_16_3:getPainting(), "", var_16_1)

		local var_16_5 = arg_16_1

		if arg_16_1.Find(var_16_5, "info/name") then
			setText = var_16_5
			var_1_10011 = var_9
			var_1_10013 = arg_16_3

			var_16_5(var_1_10011, arg_16_3.getName(var_1_10013))
		end

		Commander = var_16_5

		local var_16_6 = var_16_5.rarity2Frame(arg_16_3:getRarity())

		setImageSprite = var_1_10011

		local var_16_7 = var_16_4

		GetSpriteFromAtlas = var_1_10013

		var_1_10011(var_16_7, var_1_10013("weaponframes", "commander_" .. var_16_6))
	end

	if arg_16_4 then
		onButton = var_16_1

		local var_16_8 = arg_16_0
		local var_16_9 = var_16_2

		local function var_16_10()
			local var_17_0 = arg_16_0
			local var_17_1 = var_0.emit

			LimitChallengePreCombatMediator = var_2_10002

			var_17_1(var_17_0, var_2_10002.ON_SELECT_COMMANDER, arg_16_2, arg_16_0.fleet.id)

			return
		end

		SFX_PANEL = var_1_10011

		var_16_1(var_16_8, var_16_9, var_16_10, var_1_10011)

		onButton = var_16_1

		local var_16_11 = arg_16_0
		local var_16_12 = var_16_0

		local function var_16_13()
			local var_18_0 = arg_16_0
			local var_18_1 = var_0.emit

			LimitChallengePreCombatMediator = var_2_10002

			var_18_1(var_18_0, var_2_10002.ON_SELECT_COMMANDER, arg_16_2, arg_16_0.fleet.id)

			return
		end

		SFX_PANEL = var_1_10011

		var_16_1(var_16_11, var_16_12, var_16_13, var_1_10011)
	end

	setActive = var_16_1

	var_16_1(var_16_0, not arg_16_3)

	setActive = var_16_1

	var_16_1(var_16_2, arg_16_3)

	return
end

function var_0_1.OnDestroy(arg_19_0)
	local var_19_0 = arg_19_0

	if arg_19_0.isShowing(var_19_0) then
		LeanTween = var_1

		local var_19_1 = var_1.cancel

		go = var_19_0

		var_19_1(var_19_0(arg_19_0.samllTF))

		LeanTween = var_19_1

		local var_19_2 = var_19_1.cancel

		go = var_2

		var_19_2(var_2(arg_19_0.descFrameTF))

		isActive = var_19_2

		if var_19_2(arg_19_0.descPanel) then
			arg_19_0:UnOverlayPanel(arg_19_0._tf, arg_19_0._parentTf)
		end
	end

	return
end

return var_0_1

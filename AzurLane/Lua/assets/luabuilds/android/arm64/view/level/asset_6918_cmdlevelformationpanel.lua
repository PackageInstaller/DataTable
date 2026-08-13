class = var_0_10000

local var_0_0 = "CmdLevelFormationPanel"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BasePanel"))

function var_0_1.init(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.descPanel = var_1.Find(var_1_0, "desc")

	local var_1_1 = arg_1_0._tf

	arg_1_0.descFrameTF = var_1.Find(var_1_1, "desc/frame")

	local var_1_2 = arg_1_0.descFrameTF

	arg_1_0.descPos1 = var_1.Find(var_1_2, "commander1/frame/info")

	local var_1_3 = arg_1_0.descFrameTF

	arg_1_0.descPos2 = var_1.Find(var_1_3, "commander2/frame/info")

	local var_1_4 = arg_1_0.descFrameTF

	arg_1_0.skillTFPos1 = var_1.Find(var_1_4, "commander1/skill_info")

	local var_1_5 = arg_1_0.descFrameTF

	arg_1_0.skillTFPos2 = var_1.Find(var_1_5, "commander2/skill_info")
	UIItemList = var_1

	local var_1_6 = var_1.New
	local var_1_7 = arg_1_0.descFrameTF
	local var_1_8 = var_3.Find(var_1_7, "atttr_panel/abilitys/mask/content")
	local var_1_9 = arg_1_0.descFrameTF

	arg_1_0.abilitysTF = var_1_6(var_1_8, var_4.Find(var_1_9, "atttr_panel/abilitys/mask/content/attr"))
	UIItemList = var_1

	local var_1_10 = var_1.New
	local var_1_11 = arg_1_0.descFrameTF
	local var_1_12 = var_3.Find(var_1_11, "atttr_panel/talents/mask/content")
	local var_1_13 = arg_1_0.descFrameTF

	arg_1_0.talentsTF = var_1_10(var_1_12, var_4.Find(var_1_13, "atttr_panel/talents/mask/content/attr"))

	local var_1_14 = arg_1_0._tf

	arg_1_0.abilityArr = var_1.Find(var_1_14, "desc/frame/atttr_panel/abilitys/arr")

	local var_1_15 = arg_1_0._tf

	arg_1_0.talentsArr = var_1.Find(var_1_15, "desc/frame/atttr_panel/talents/arr")

	local var_1_16 = arg_1_0.descPanel

	arg_1_0.animtion = var_1.GetComponent(var_1_16, "Animation")

	local var_1_17 = arg_1_0._tf
	local var_1_18 = var_1.Find(var_1_17, "desc")
	local var_1_19 = var_1.GetComponent

	typeof = var_4
	DftAniEvent = var_1_13
	arg_1_0.animtionEvent = var_1_19(var_1_18, var_4(var_1_13))

	return
end

function var_0_1.update(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.callback = arg_2_2
	assert = var_1_10003

	var_1_10003(arg_2_1)

	arg_2_0.fleet = arg_2_1

	arg_2_0:updateDesc()

	return
end

function var_0_1.attach(arg_3_0, arg_3_1)
	var_0_1.super.attach(arg_3_0, arg_3_1)

	setActive = var_2

	var_2(arg_3_0._go, false)

	onButton = var_2

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.close(var_4_0)

		return
	end

	SFX_PANEL = var_1_10007

	var_2(var_3_0, var_3_1, var_3_2, var_1_10007)

	return
end

function var_0_1.playAnim(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0.animtion

	var_2.Play(var_5_0, arg_5_1)

	return
end

function var_0_1.open(arg_6_0)
	arg_6_0:playAnim("cmdopen")

	setActive = var_1

	var_1(arg_6_0._go, true)

	setParent = var_1

	local var_6_0 = arg_6_0._go

	pg = var_4

	var_1(var_6_0, var_4.UIMgr.GetInstance().OverlayMain)

	local var_6_1 = arg_6_0._tf

	var_1.SetAsLastSibling(var_6_1)

	return
end

function var_0_1.close(arg_7_0)
	arg_7_0:playAnim("cmdclose")

	setActive = var_1

	var_1(arg_7_0._go, false)

	return
end

function var_0_1.updateDesc(arg_8_0)
	local var_8_0 = arg_8_0.fleet
	local var_8_1 = var_1.getCommanders(var_8_0)
	local var_8_2 = 1

	CommanderConst = var_8_0

	for iter_8_0 = var_8_2, var_8_0.MAX_FORMATION_POS do
		local var_8_3 = var_8_1[iter_8_0]

		arg_8_0:updateCommander(arg_8_0["descPos" .. iter_8_0], iter_8_0, var_8_3)
		arg_8_0:updateSkillTF(var_8_3, arg_8_0["skillTFPos" .. iter_8_0])
	end

	arg_8_0:updateAdditions()

	return
end

function var_0_1.updateAdditions(arg_9_0)
	local var_9_0 = arg_9_0.fleet

	_ = var_1_10002

	local var_9_1 = var_1_10002.values(var_9_0:getCommandersTalentDesc())
	local var_9_2, var_9_3 = var_9_0:getCommandersAddition()
	local var_9_4 = arg_9_0.abilitysTF

	var_5.make(var_9_4, function(arg_10_0, arg_10_1, arg_10_2)
		UIItemList = var_2_10003

		if arg_10_0 == var_2_10003.EventUpdate then
			local var_10_0 = var_9_2[arg_10_1 + 1]

			setText = var_4

			local var_10_1 = arg_10_2:Find("name")

			AttributeType = var_2_10007

			var_4(var_10_1, var_2_10007.Type2Name(var_10_0.attrName))

			setText = var_4

			local var_10_2 = arg_10_2:Find("Text")

			string = var_7

			var_4(var_10_2, var_7.format("%0.3f", var_10_0.value) .. "%")

			GetImageSpriteFromAtlasAsync = var_4

			var_4("attricon", var_10_0.attrName, arg_10_2:Find("icon"), false)

			setActive = var_4

			var_4(arg_10_2:Find("bg"), arg_10_1 % 2 ~= 0)
		end

		return
	end)

	local var_9_5 = arg_9_0.abilitysTF

	var_5.align(var_9_5, #var_9_2)

	setActive = var_5

	var_5(arg_9_0.abilityArr, #var_9_2 > 4)

	local var_9_6 = arg_9_0.talentsTF

	var_5.make(var_9_6, function(arg_11_0, arg_11_1, arg_11_2)
		UIItemList = var_2_10003

		if arg_11_0 == var_2_10003.EventUpdate then
			local var_11_0 = var_9_1[arg_11_1 + 1]

			setScrollText = var_4
			findTF = var_2_10006

			var_4(var_2_10006(arg_11_2, "name_mask/name"), var_11_0.name)

			local var_11_1 = var_11_0.type

			CommanderConst = var_2_10005

			local var_11_2 = var_11_1 == var_2_10005.TALENT_ADDITION_RATIO and "%" or ""

			setText = var_5

			var_5(arg_11_2:Find("Text"), var_11_0.value .. var_11_2)

			setActive = var_5

			var_5(arg_11_2:Find("bg"), arg_11_1 % 2 ~= 0)
		end

		return
	end)

	local var_9_7 = arg_9_0.talentsTF

	var_5.align(var_9_7, #var_9_1)

	setActive = var_5

	var_5(arg_9_0.talentsArr, #var_9_1 > 4)

	return
end

function var_0_1.updateSkillTF(arg_12_0, arg_12_1, arg_12_2)
	setActive = var_1_10003

	var_1_10003(arg_12_2, arg_12_1)

	if arg_12_1 then
		local var_12_0 = arg_12_1:getSkills()[1]

		GetImageSpriteFromAtlasAsync = var_1_10004

		var_1_10004("CommanderSkillIcon/" .. var_12_0:getConfig("icon"), "", arg_12_2:Find("icon"))

		setText = var_1_10004

		var_1_10004(arg_12_2:Find("level"), "Lv." .. var_12_0:getLevel())
	end

	return
end

function var_0_1.updateCommander(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = arg_13_1
	local var_13_1 = arg_13_1.Find(var_13_0, "add")
	local var_13_2 = arg_13_1:Find("info")

	if arg_13_3 then
		local var_13_3 = arg_13_1

		var_13_0 = arg_13_1.Find(var_13_3, "info/mask/icon")

		local var_13_4 = arg_13_1
		local var_13_5 = arg_13_1.Find(var_13_4, "info/frame")

		GetImageSpriteFromAtlasAsync = var_13_3

		var_13_3("CommanderHrz/" .. arg_13_3:getPainting(), "", var_13_0)

		local var_13_6 = arg_13_1

		if arg_13_1.Find(var_13_6, "info/name") then
			setText = var_13_4

			var_13_4(var_8, arg_13_3:getName())
		end

		Commander = var_13_4

		local var_13_7 = var_13_4.rarity2Frame
		local var_13_8 = arg_13_3
		local var_13_9 = var_13_7(arg_13_3.getRarity(var_13_8))

		setImageSprite = var_13_6

		local var_13_10 = var_13_5

		GetSpriteFromAtlas = var_13_8

		var_13_6(var_13_10, var_13_8("weaponframes", "commander_" .. var_13_9))
	end

	onButton = var_13_0

	local var_13_11 = arg_13_0
	local var_13_12 = var_13_2

	local function var_13_13()
		if arg_13_0.callback then
			arg_13_0.callback(arg_13_2)
		end

		return
	end

	SFX_PANEL = var_1_10011

	var_13_0(var_13_11, var_13_12, var_13_13, var_1_10011)

	onButton = var_13_0

	local var_13_14 = arg_13_0
	local var_13_15 = var_13_1

	local function var_13_16()
		if arg_13_0.callback then
			arg_13_0.callback(arg_13_2)
		end

		return
	end

	SFX_PANEL = var_1_10011

	var_13_0(var_13_14, var_13_15, var_13_16, var_1_10011)

	setActive = var_13_0

	var_13_0(var_13_1, not arg_13_3)

	setActive = var_13_0

	var_13_0(var_13_2, arg_13_3)

	return
end

function var_0_1.enable(arg_16_0, arg_16_1)
	setActive = var_1_10002

	var_1_10002(arg_16_0._go, arg_16_1)

	return
end

function var_0_1.clear(arg_17_0)
	setActive = var_1_10001

	var_1_10001(arg_17_0._go, false)

	setParent = var_1_10001

	var_1_10001(arg_17_0._go, arg_17_0.parent.topPanel)

	return
end

return var_0_1

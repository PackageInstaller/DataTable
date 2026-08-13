class = var_0_10000

local var_0_0 = "CommanderCatPlayPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "CommanderCatPlayui"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.skillTF = var_1.Find(var_2_0, "skill/frame")

	local var_2_1 = arg_2_0.skillTF
	local var_2_2 = var_1.Find(var_2_1, "name")
	local var_2_3 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.skillNameTxt = var_2_3(var_2_2, var_4(var_1_10006))

	local var_2_4 = arg_2_0.skillTF

	arg_2_0.skillIcon = var_1.Find(var_2_4, "icon/Image")

	local var_2_5 = arg_2_0.skillTF
	local var_2_6 = var_1.Find(var_2_5, "level_container/level")
	local var_2_7 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.skillLvTxt = var_2_7(var_2_6, var_4(var_1_10006))

	local var_2_8 = arg_2_0.skillTF
	local var_2_9 = var_1.Find(var_2_8, "level_container/addition")
	local var_2_10 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.skillAdditionTxt = var_2_10(var_2_9, var_4(var_1_10006))

	local var_2_11 = arg_2_0.skillTF
	local var_2_12 = var_1.Find(var_2_11, "exp/Text")
	local var_2_13 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.expTxt = var_2_13(var_2_12, var_4(var_1_10006))

	local var_2_14 = arg_2_0._tf

	arg_2_0.descBtn = var_1.Find(var_2_14, "skill/frame/desc")

	local var_2_15 = arg_2_0._tf

	arg_2_0.descPage = var_1.Find(var_2_15, "skill_desc")

	local var_2_16 = arg_2_0.descPage

	arg_2_0.descToggle = var_1.Find(var_2_16, "tags")

	local var_2_17 = arg_2_0.descToggle

	arg_2_0.descToggleMark = var_1.Find(var_2_17, "sel")
	UIItemList = var_1

	local var_2_18 = var_1.New
	local var_2_19 = arg_2_0.descPage
	local var_2_20 = var_3.Find(var_2_19, "content/list")
	local var_2_21 = arg_2_0.descPage

	arg_2_0.skillDescList = var_2_18(var_2_20, var_4.Find(var_2_21, "content/list/tpl"))
	setActive = var_1

	var_1(arg_2_0.descPage, false)

	local var_2_22 = arg_2_0._tf
	local var_2_23 = var_1.Find(var_2_22, "select_panel/exp_bg/level_bg/Text")
	local var_2_24 = var_1.GetComponent

	typeof = var_4
	Text = var_2_21
	arg_2_0.commanderLvTxt = var_2_24(var_2_23, var_4(var_2_21))

	local var_2_25 = arg_2_0._tf
	local var_2_26 = var_1.Find(var_2_25, "select_panel/exp_bg/level_bg/addition")
	local var_2_27 = var_1.GetComponent

	typeof = var_4
	Text = var_2_21
	arg_2_0.levelAdditionTxt = var_2_27(var_2_26, var_4(var_2_21))

	local var_2_28 = arg_2_0._tf
	local var_2_29 = var_1.Find(var_2_28, "select_panel/exp_bg/slider")
	local var_2_30 = var_1.GetComponent

	typeof = var_4
	Slider = var_2_21
	arg_2_0.preExpSlider = var_2_30(var_2_29, var_4(var_2_21))

	local var_2_31 = arg_2_0._tf
	local var_2_32 = var_1.Find(var_2_31, "select_panel/exp_bg/slider/exp")
	local var_2_33 = var_1.GetComponent

	typeof = var_4
	Slider = var_2_21
	arg_2_0.expSlider = var_2_33(var_2_32, var_4(var_2_21))

	local var_2_34 = arg_2_0._tf
	local var_2_35 = var_1.Find(var_2_34, "select_panel/exp_bg/slider/Text")
	local var_2_36 = var_1.GetComponent

	typeof = var_4
	Text = var_2_21
	arg_2_0.sliderExpTxt = var_2_36(var_2_35, var_4(var_2_21))
	UIItemList = var_1

	local var_2_37 = var_1.New
	local var_2_38 = arg_2_0._tf
	local var_2_39 = var_3.Find(var_2_38, "select_panel/frame/list")
	local var_2_40 = arg_2_0._tf

	arg_2_0.uilist = var_2_37(var_2_39, var_4.Find(var_2_40, "select_panel/frame/list/commandeTF"))

	local var_2_41 = arg_2_0._tf
	local var_2_42 = var_1.Find(var_2_41, "select_panel/consume/Text")
	local var_2_43 = var_1.GetComponent

	typeof = var_4
	Text = var_2_40
	arg_2_0.consumeTxt = var_2_43(var_2_42, var_4(var_2_40))

	local var_2_44 = arg_2_0._tf

	arg_2_0.confirmBtn = var_1.Find(var_2_44, "select_panel/confirm_btn")
	CommanderCatPlayAnimation = var_1
	arg_2_0.animation = var_1.New(arg_2_0.expSlider)
	setText = var_1

	local var_2_45 = arg_2_0._tf
	local var_2_46 = var_3.Find(var_2_45, "select_panel/title")

	i18n = var_4

	var_1(var_2_46, var_4("commander_confirm_tip"))

	setText = var_1

	local var_2_47 = arg_2_0._tf
	local var_2_48 = var_3.Find(var_2_47, "skill_desc/title")

	i18n = var_4

	var_1(var_2_48, var_4("commander_skill_effect"))

	return
end

function var_0_1.OnInit(arg_3_0)
	arg_3_0:RegisterEvent()

	onButton = var_1

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.descBtn

	local function var_3_2()
		local var_4_1

		if arg_3_0.isOpenDescPage then
			local var_4_0 = arg_3_0

			var_4_1.CloseDescPage(var_4_0)

			var_4_1 = arg_3_0
			var_4_1.isOpenDescPage = false
		else
			var_4_1 = arg_3_0
			var_4_1.isOpenDescPage = true

			local var_4_2 = arg_3_0

			var_4_1.UpdateDescPage(var_4_2)

			local var_4_3 = arg_3_0

			var_4_1 = var_4_1.emit
			CommanderCatScene = var_2_10003

			var_4_1(var_4_3, var_2_10003.EVENT_CLOSE_DESC)
		end

		setActive = var_4_1

		local var_4_4 = arg_3_0.descBtn

		var_4_1(var_2.Find(var_4_4, "sel"), arg_3_0.isOpenDescPage)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_3_0, var_3_1, var_3_2, var_1_10006)

	setActive = var_1

	local var_3_3 = arg_3_0.descBtn

	var_1(var_3.Find(var_3_3, "sel"), false)

	arg_3_0.commonFlag = true
	onButton = var_1

	local var_3_4 = arg_3_0
	local var_3_5 = arg_3_0.descToggle

	local function var_3_6()
		arg_3_0.commonFlag = not arg_3_0.commonFlag

		local var_5_0 = arg_3_0.commonFlag and 0 or arg_3_0.descToggleMark.rect.width

		setAnchoredPosition = var_1

		var_1(arg_3_0.descToggleMark, {
			x = var_5_0
		})

		local var_5_1 = arg_3_0

		var_1.UpdateDescPage(var_5_1)

		return
	end

	SFX_PANEL = var_6

	var_1(var_3_4, var_3_5, var_3_6, var_6)

	return
end

function var_0_1.RegisterEvent(arg_6_0)
	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.bind

	CommanderCatScene = var_1_10004

	var_6_1(var_6_0, var_1_10004.EVENT_OPEN_DESC, function(arg_7_0)
		if arg_6_0.isOpenDescPage then
			triggerButton = var_1

			var_1(arg_6_0.descBtn)
		end

		return
	end)

	local var_6_2 = arg_6_0
	local var_6_3 = arg_6_0.bind

	CommanderCatScene = var_4

	var_6_3(var_6_2, var_4.MSG_UPGRADE, function(arg_8_0, arg_8_1, arg_8_2)
		local var_8_0 = arg_6_0.preExpSlider

		var_8_0.value = 0
		pg = var_8_0

		local var_8_1 = var_8_0.UIMgr.GetInstance()

		var_3.LoadingOn(var_8_1, false)

		local var_8_2 = arg_6_0.animation

		var_3.Action(var_8_2, arg_8_1, arg_8_2, function()
			pg = var_3_10000

			local var_9_0 = var_3_10000.UIMgr.GetInstance()

			var_0.LoadingOff(var_9_0)

			local var_9_1 = arg_6_0

			var_0.Flush(var_9_1, arg_8_2)

			local var_9_2 = arg_6_0
			local var_9_3 = var_0.emit

			CommanderCatScene = var_3

			var_9_3(var_9_2, var_3.EVENT_UPGRADE)

			return
		end)

		return
	end)

	local var_6_4 = arg_6_0
	local var_6_5 = arg_6_0.bind

	CommanderCatScene = var_4

	var_6_5(var_6_4, var_4.EVENT_FOLD, function(arg_10_0, arg_10_1)
		if arg_10_1 then
			LeanTween = var_2_10002
			var_2_10002 = var_2_10002.moveX
			rtf = var_2_10004

			var_2_10002(var_2_10004(arg_6_0._tf), 1000, 0.5)
		else
			LeanTween = var_2_10002

			local var_10_0 = var_2_10002.moveX

			rtf = var_2_10004

			var_10_0(var_2_10004(arg_6_0._tf), -410, 0.5)
		end

		return
	end)

	local var_6_6 = arg_6_0
	local var_6_7 = arg_6_0.bind

	CommanderCatScene = var_4

	var_6_7(var_6_6, var_4.EVENT_SWITCH_PAGE, function(arg_11_0, arg_11_1)
		CommanderCatScene = var_2_10002

		if arg_11_1 == var_2_10002.PAGE_DOCK then
			local var_11_0 = arg_6_0

			var_2.ClearSortData(var_11_0)
		end

		return
	end)

	local var_6_8 = arg_6_0
	local var_6_9 = arg_6_0.bind

	CommanderCatScene = var_4

	var_6_9(var_6_8, var_4.EVENT_SELECTED, function(arg_12_0, arg_12_1)
		local var_12_0 = arg_6_0

		var_2.Flush(var_12_0, arg_12_1)

		return
	end)

	return
end

function var_0_1.Flush(arg_13_0, arg_13_1)
	arg_13_0.commander = arg_13_1
	arg_13_0.contextData.materialIds = {}

	arg_13_0:UpdateMaterials()

	return
end

function var_0_1.Show(arg_14_0, arg_14_1)
	var_0_1.super.Show(arg_14_0)

	arg_14_0.commander = arg_14_1

	arg_14_0:UpdateMaterials()

	if arg_14_0.isOpenDescPage then
		arg_14_0:UpdateDescPage()
	end

	return
end

function var_0_1.UpdateMaterials(arg_15_0)
	local var_15_0 = arg_15_0.uilist

	var_1.make(var_15_0, function(arg_16_0, arg_16_1, arg_16_2)
		UIItemList = var_2_10003

		if arg_16_0 == var_2_10003.EventUpdate then
			local var_16_0 = arg_15_0

			var_3.UpdateCard(var_16_0, arg_16_1, arg_16_2)
		end

		return
	end)

	local var_15_1 = arg_15_0.uilist
	local var_15_2 = var_1.align

	CommanderConst = var_4

	var_15_2(var_15_1, var_4.PLAY_MAX_COUNT)
	arg_15_0:UpdateMainView()

	return
end

function var_0_1.UpdateMainView(arg_17_0)
	local var_17_0

	if not arg_17_0.contextData.materialIds then
		var_17_0 = {}
	end

	CommanderCatUtil = var_1_10002

	local var_17_1, var_17_2 = var_1_10002.GetSkillExpAndCommanderExp(arg_17_0.commander, var_17_0)

	arg_17_0:UpdateSkillTF(var_17_2)
	arg_17_0:UpdateCommanderTF(var_17_1)

	local var_17_3 = arg_17_0

	arg_17_0.UpdateConsume(var_17_3, var_17_0, var_17_2)

	setActive = var_4
	go = var_17_3

	var_4(var_17_3(arg_17_0.skillAdditionTxt), #var_17_0 > 0)

	setActive = var_4
	go = var_6

	var_4(var_6(arg_17_0.levelAdditionTxt), #var_17_0 > 0)

	return
end

function var_0_1.UpdateDescPage(arg_18_0)
	local function var_18_0(arg_19_0, arg_19_1)
		if not arg_19_0 and arg_19_1.desc_world and arg_19_1.desc_world ~= "" then
			return arg_19_1.desc_world
		else
			return arg_19_1.desc
		end

		return
	end

	setActive = var_1_10002

	var_1_10002(arg_18_0.descPage, true)

	local var_18_1 = arg_18_0.commander
	local var_18_2 = var_2.getSkills(var_18_1)[1]
	local var_18_3 = var_3.GetSkillGroup(var_18_2)
	local var_18_4 = var_3:getConfig("lv")
	local var_18_5 = arg_18_0.skillDescList

	var_6.make(var_18_5, function(arg_20_0, arg_20_1, arg_20_2)
		UIItemList = var_2_10003

		if arg_20_0 == var_2_10003.EventUpdate then
			local var_20_0 = var_18_3[arg_20_1 + 1]
			local var_20_1 = var_18_0(arg_18_0.commonFlag, var_20_0)
			local var_20_2 = var_18_4 >= var_20_0.lv and "#66472a" or "#a3a2a2"

			if var_18_4 < var_20_0.lv then
				local var_20_3 = "(Lv."
				local var_20_4 = var_20_0.lv

				i18n = var_2_10008

				local var_20_5

				if not (var_20_3 .. var_20_4 .. var_2_10008("word_take_effect") .. ")") then
					var_20_5 = ""
				end

				setText = var_20_4

				var_20_4(arg_20_2, "<color=" .. var_20_2 .. ">" .. var_20_1 .. "</color>" .. var_20_5)

				setText = var_20_4

				var_20_4(arg_20_2:Find("level"), "<color=" .. var_20_2 .. ">" .. "Lv." .. var_20_0.lv .. "</color>")

				return
			end
		end
	end)

	local var_18_6 = arg_18_0.skillDescList

	var_6.align(var_18_6, #var_18_3)

	return
end

function var_0_1.CloseDescPage(arg_21_0)
	setActive = var_1_10001

	var_1_10001(arg_21_0.descPage, false)

	return
end

function var_0_1.SimulateAddSkillExp(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0.commander
	local var_22_1 = var_2.getSkills(var_22_0)[1]

	Clone = var_22_0

	local var_22_2 = var_22_0(var_22_1)

	var_4.addExp(var_22_2, arg_22_1)

	return var_4, var_22_1
end

function var_0_1.UpdateSkillTF(arg_23_0, arg_23_1)
	local var_23_0, var_23_1 = arg_23_0:SimulateAddSkillExp(arg_23_1)
	local var_23_2 = var_23_1:getConfig("lv")

	GetImageSpriteFromAtlasAsync = var_5

	var_5("CommanderSkillIcon/" .. var_23_1:getConfig("icon"), "", arg_23_0.skillIcon)

	arg_23_0.skillNameTxt.text = var_23_1:getConfig("name")
	arg_23_0.skillLvTxt.text = "Lv." .. var_23_1:getLevel()
	arg_23_0.skillAdditionTxt.text = "+" .. var_23_0:getLevel() - var_23_1:getLevel()

	if var_23_1:isMaxLevel() then
		arg_23_0.expTxt.text = "0/0"
	else
		arg_23_0.expTxt.text = var_23_1.exp .. (arg_23_1 == 0 and "" or "<color=#A9F548FF>(+" .. arg_23_1 .. ")</color>") .. "/" .. var_23_1:getNextLevelExp()
	end

	return
end

function var_0_1.SimulateAddCommanderExp(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0.commander

	Clone = var_1_10003

	local var_24_1 = var_1_10003(var_24_0)

	var_3.addExp(var_24_1, arg_24_1)

	return var_3, var_24_0
end

function var_0_1.UpdateCommanderTF(arg_25_0, arg_25_1)
	local var_25_0, var_25_1 = arg_25_0:SimulateAddCommanderExp(arg_25_1)
	local var_25_2 = arg_25_0
	local var_25_3 = arg_25_0.emit

	CommanderCatScene = var_1_10007

	var_25_3(var_25_2, var_1_10007.EVENT_PREVIEW_REVERSE, var_25_1, var_25_0)

	arg_25_0.commanderLvTxt.text = "LV." .. var_25_1.level

	if var_25_1:isMaxLevel() then
		arg_25_0.expSlider.value = 1
		arg_25_0.sliderExpTxt.text = "EXP: +0/MAX"
		arg_25_0.preExpSlider.value = 1
		arg_25_0.levelAdditionTxt.text = "+0"
	else
		arg_25_0.expSlider.value = arg_25_1 > 0 and 0 or var_25_1.exp / var_25_1:getNextLevelExp()

		local var_25_4

		if not (arg_25_1 > 0) or not ("<color=#A9F548FF>" .. var_25_1.exp + arg_25_1 .. "</color>") then
			var_25_4 = var_25_1.exp
		end

		arg_25_0.sliderExpTxt.text = "EXP: " .. var_25_4 .. "/" .. var_25_1:getNextLevelExp()

		if var_25_0:isMaxLevel() then
			arg_25_0.preExpSlider.value = 1
		else
			arg_25_0.preExpSlider.value = var_25_0.exp / var_25_0:getNextLevelExp()
		end

		arg_25_0.levelAdditionTxt.text = "+" .. var_25_0.level - var_25_1.level
	end

	return
end

function var_0_1.UpdateConsume(arg_26_0, arg_26_1, arg_26_2)
	getProxy = var_1_10003
	PlayerProxy = var_1_10005

	local var_26_0 = var_1_10003(var_1_10005)
	local var_26_1 = var_3.getRawData(var_26_0)

	CommanderCatUtil = var_1_10004
	arg_26_0.total = var_1_10004.CalcCommanderConsume(arg_26_1)

	local var_26_2 = arg_26_0.consumeTxt

	if var_26_1.gold < arg_26_0.total then
		local var_26_3 = "<color="

		COLOR_RED = var_6

		local var_26_4

		if not (var_26_3 .. var_6 .. ">" .. arg_26_0.total .. "</color>") then
			var_26_4 = arg_26_0.total
		end

		var_26_2.text = var_26_4

		local function var_26_5()
			if var_26_1.gold < arg_26_0.total then
				GoShoppingMsgBox = var_0
				i18n = var_2_10002

				local var_27_0 = "switch_to_shop_tip_2"

				i18n = var_2_10005

				local var_27_1 = var_2_10002(var_27_0, var_2_10005("word_gold"))

				ChargeScene = var_2_10003

				var_0(var_27_1, var_2_10003.TYPE_ITEM, {
					{
						59001,
						arg_26_0.total - var_26_1.gold,
						arg_26_0.total
					}
				})

				return
			end

			local var_27_2 = arg_26_0.commander
			local var_27_3 = var_0.getSkills(var_27_2)[1]
			local var_27_4 = arg_26_0
			local var_27_5 = var_2.emit

			CommanderCatMediator = var_2_10005

			var_27_5(var_27_4, var_2_10005.UPGRADE, arg_26_0.commander.id, arg_26_1, var_27_3.id)

			return
		end

		onButton = var_26_4

		local var_26_6 = arg_26_0
		local var_26_7 = arg_26_0.confirmBtn

		local function var_26_8()
			if not arg_26_1 or #arg_26_1 <= 0 then
				return
			end

			local var_28_0 = arg_26_0

			var_0.CheckTip(var_28_0, arg_26_1, arg_26_2, var_26_5)

			return
		end

		SFX_PANEL = var_1_10010

		var_26_4(var_26_6, var_26_7, var_26_8, var_1_10010)

		return
	end
end

function var_0_1.CheckTip(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	local var_29_0 = {}

	CommanderCatUtil = var_1_10005

	if var_1_10005.AnySSRCommander(arg_29_1) then
		table = var_5

		var_5.insert(var_29_0, function(arg_30_0)
			local var_30_0 = arg_29_0.contextData.msgBox
			local var_30_1 = var_1.ExecuteAction
			local var_30_2 = "Show"
			local var_30_3 = {}

			i18n = var_2_10006
			var_30_3.content = var_2_10006("commander_material_is_rarity")
			var_30_3.onYes = arg_30_0

			var_30_1(var_30_0, var_30_2, var_30_3)

			return
		end)
	end

	local var_29_1, var_29_2 = arg_29_0:SimulateAddSkillExp(arg_29_2)
	local var_29_4

	if var_29_1:isMaxLevel() then
		local var_29_3 = var_29_1.exp

		var_29_4 = 0 < var_29_3 and not var_29_2:isMaxLevel()
	end

	if var_29_4 then
		table = var_8

		var_8.insert(var_29_0, function(arg_31_0)
			local var_31_0 = arg_29_0.contextData.msgBox
			local var_31_1 = var_1.ExecuteAction
			local var_31_2 = "Show"
			local var_31_3 = {}

			i18n = var_2_10006
			var_31_3.content = var_2_10006("commander_exp_overflow_tip")
			var_31_3.onYes = arg_31_0

			var_31_1(var_31_0, var_31_2, var_31_3)

			return
		end)
	end

	local var_29_5 = arg_29_0.commander

	if var_8.isMaxLevel(var_29_5) then
		table = var_8

		var_8.insert(var_29_0, function(arg_32_0)
			local var_32_0 = arg_29_0.contextData.msgBox
			local var_32_1 = var_1.ExecuteAction
			local var_32_2 = "Show"
			local var_32_3 = {}

			i18n = var_2_10006
			var_32_3.content = var_2_10006("commander_material_is_maxLevel")
			var_32_3.onYes = arg_32_0

			var_32_1(var_32_0, var_32_2, var_32_3)

			return
		end)
	end

	seriesAsync = var_8

	var_8(var_29_0, arg_29_3)

	return
end

function var_0_1.UpdateCard(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0

	if not arg_33_0.contextData.materialIds then
		var_33_0 = {}
	end

	local var_33_1 = var_33_0[arg_33_1 + 1]
	local var_33_2 = arg_33_2
	local var_33_3 = arg_33_2.Find(var_33_2, "add")
	local var_33_4 = arg_33_2
	local var_33_5 = arg_33_2.Find(var_33_4, "icon")

	if var_33_1 then
		onButton = var_33_2

		local var_33_6 = arg_33_0
		local var_33_7 = var_33_5

		local function var_33_8()
			table = var_2_10000

			local var_34_0 = var_2_10000.indexof(var_33_0, var_33_1)

			table = var_2_10001

			var_2_10001.remove(var_33_0, var_34_0)

			local var_34_1 = arg_33_0

			var_1.UpdateMaterials(var_34_1)

			return
		end

		SFX_PANEL = var_1_10012

		var_33_2(var_33_6, var_33_7, var_33_8, var_1_10012)

		getProxy = var_33_2
		CommanderProxy = var_33_6

		local var_33_9 = var_33_2(var_33_6)

		var_33_2 = var_33_2.getCommanderById(var_33_9, var_33_1)
		GetImageSpriteFromAtlasAsync = var_33_4

		var_33_4("commandericon/" .. var_33_2:getPainting(), "", var_33_5)

		setActive = var_33_4
		var_1_10012 = var_33_5

		local var_33_10 = var_33_5.Find(var_1_10012, "up")
		local var_33_11 = arg_33_0.commander

		var_33_4(var_33_10, var_11.isSameGroup(var_33_11, var_33_2.groupId))

		setActive = var_33_4
		var_1_10012 = var_33_5

		var_33_4(var_33_5.Find(var_1_10012, "formation"), var_33_2.inFleet)

		setText = var_33_4
		var_1_10012 = var_33_5

		var_33_4(var_33_5.Find(var_1_10012, "level_bg/Text"), var_33_2.level)
	else
		onButton = var_33_2

		local var_33_12 = arg_33_0
		local var_33_13 = var_33_3

		local function var_33_14()
			table = var_2_10000

			local var_35_0 = var_2_10000.getCount

			getProxy = var_2_10002
			CommanderProxy = var_2_10004

			local var_35_1 = var_2_10002(var_2_10004)

			if var_35_0(var_2.getRawData(var_35_1)) == 1 then
				pg = var_0

				local var_35_2 = var_0.TipsMgr.GetInstance()
				local var_35_3 = var_0.ShowTips

				i18n = var_2_10003

				var_35_3(var_35_2, var_2_10003("commander_material_noenough"))

				return
			end

			local var_35_4 = arg_33_0.commander
			local var_35_5 = var_0.getSkills(var_35_4)[1]

			if var_1.isMaxLevel(var_35_5) then
				local var_35_6 = arg_33_0.commander

				if not var_2.isMaxLevel(var_35_6) then
					local var_35_7 = arg_33_0
					local var_35_8 = var_2.emit

					CommanderCatMediator = var_2_10005

					local var_35_9 = var_2_10005.ON_SELECT
					local var_35_10 = arg_33_0

					var_35_8(var_35_7, var_35_9, var_6.GenSelectData(var_35_10))
				end

				return
			end
		end

		SFX_PANEL = var_1_10012

		var_33_2(var_33_12, var_33_13, var_33_14, var_1_10012)
	end

	setActive = var_33_2

	var_33_2(var_33_3, not var_33_1)

	setActive = var_33_2

	var_33_2(var_33_5, var_33_1)

	return
end

function var_0_1.GenSelectData(arg_36_0)
	local var_36_0 = arg_36_0.commander
	local var_36_1 = {
		activeCommander = var_36_0
	}
	local var_36_2

	if not arg_36_0.contextData.materialIds then
		var_36_2 = {}
	end

	var_36_1.selectedIds = var_36_2

	function var_36_1.onSelected(arg_37_0, arg_37_1)
		arg_36_0.contextData.materialIds = arg_37_0

		local var_37_0 = arg_36_0

		var_2.UpdateMaterials(var_37_0)
		arg_37_1()

		return
	end

	function var_36_1.OnSort(arg_38_0)
		local var_38_0 = arg_36_0

		var_1.SaveSortData(var_38_0, arg_38_0)

		return
	end

	var_36_1.sortData = arg_36_0:GetSortData()

	return var_36_1
end

function var_0_1.Hide(arg_39_0)
	var_0_1.super.Hide(arg_39_0)

	return
end

function var_0_1.OnDestroy(arg_40_0)
	if arg_40_0.animation then
		local var_40_0 = arg_40_0.animation

		var_1.Dispose(var_40_0)

		arg_40_0.animation = nil
	end

	arg_40_0:ClearSortData()

	return
end

function var_0_1.GetSortData(arg_41_0)
	if not var_0_1.SortData then
		local var_41_0 = var_0_1

		Clone = var_1_10002

		local var_41_1

		if not var_1_10002(arg_41_0.contextData.sortData) then
			var_41_1 = {
				asc = true,
				sortData = "Rarity",
				nationData = {},
				rarityData = {}
			}
		end

		var_41_0.SortData = var_41_1
	end

	return var_0_1.SortData
end

function var_0_1.SaveSortData(arg_42_0, arg_42_1)
	var_0_1.SortData = arg_42_1

	return
end

function var_0_1.ClearSortData(arg_43_0)
	var_0_1.SortData = nil

	return
end

return var_0_1

class = var_0_10000

local var_0_0 = "SkillInfoLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "SkillInfoUI"
end

function var_0_1.init(arg_2_0)
	pg = var_1_10001

	local var_2_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_2_0, arg_2_0._tf)

	local var_2_1 = arg_2_0._tf

	arg_2_0.backBtn = var_1.Find(var_2_1, "panel/top/btnBack")

	local var_2_2 = arg_2_0._tf

	arg_2_0.skillInfoName = var_1.Find(var_2_2, "panel/bg/skill_name")

	local var_2_3 = arg_2_0._tf

	arg_2_0.skillInfoLv = var_1.Find(var_2_3, "panel/bg/skill_lv")

	local var_2_4 = arg_2_0._tf

	arg_2_0.skillInfoIntro = var_1.Find(var_2_4, "panel/bg/help_panel/skill_intro")

	local var_2_5 = arg_2_0._tf

	arg_2_0.skillInfoIcon = var_1.Find(var_2_5, "panel/bg/skill_icon")

	local var_2_6 = arg_2_0._tf

	arg_2_0.btnTypeNormal = var_1.Find(var_2_6, "panel/bg/btn_type_normal")

	local var_2_7 = arg_2_0._tf

	arg_2_0.btnTypeWorld = var_1.Find(var_2_7, "panel/bg/btn_type_world")

	local var_2_8 = arg_2_0._tf

	arg_2_0.buttonList = var_1.Find(var_2_8, "panel/buttonList")

	local var_2_9 = arg_2_0._tf

	arg_2_0.upgradeBtn = var_1.Find(var_2_9, "panel/buttonList/level_button")

	local var_2_10 = arg_2_0._tf

	arg_2_0.metaBtn = var_1.Find(var_2_10, "panel/buttonList/meta_button")
	setText = var_1

	local var_2_11 = arg_2_0.metaBtn
	local var_2_12 = var_3.Find(var_2_11, "Image")

	i18n = var_4

	var_1(var_2_12, var_4("meta_skillbtn_tactics"))

	setText = var_1

	local var_2_13 = arg_2_0._tf
	local var_2_14 = var_3.Find(var_2_13, "panel/top/title_list/infomation/title")

	i18n = var_4

	var_1(var_2_14, var_4("words_information"))

	setText = var_1

	local var_2_15 = arg_2_0.buttonList
	local var_2_16 = var_3.Find(var_2_15, "ok_button/Image")

	i18n = var_4

	var_1(var_2_16, var_4("text_confirm"))

	PLATFORM_CODE = var_1
	PLATFORM_JP = var_1_10002

	if var_1 == var_1_10002 then
		setText = var_1

		local var_2_17 = arg_2_0.buttonList
		local var_2_18 = var_3.Find(var_2_17, "level_button/Image")

		i18n = var_4

		var_1(var_2_18, var_4("msgbox_text_noPos_intensify"))
	else
		setText = var_1

		local var_2_19 = arg_2_0.buttonList
		local var_2_20 = var_3.Find(var_2_19, "level_button/Image")

		i18n = var_4

		var_1(var_2_20, var_4("msgbox_text_upgrade"))
	end

	return
end

function var_0_1.didEnter(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.emit(var_4_0, var_0_1.ON_CLOSE)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.backBtn

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.emit(var_5_0, var_0_1.ON_CLOSE)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10006)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0._tf
	local var_3_8 = var_4.Find(var_3_7, "panel/buttonList/ok_button")

	local function var_3_9()
		local var_6_0 = arg_3_0

		var_0.emit(var_6_0, var_0_1.ON_CLOSE)

		return
	end

	SFX_CONFIRM = var_3_7

	var_1_10001(var_3_6, var_3_8, var_3_9, var_3_7)

	onButton = var_1_10001

	local var_3_10 = arg_3_0
	local var_3_11 = arg_3_0.upgradeBtn

	local function var_3_12()
		local var_7_0 = arg_3_0
		local var_7_1 = var_0.emit

		SkillInfoMediator = var_2_10003

		var_7_1(var_7_0, var_2_10003.WARP_TO_TACTIC)

		return
	end

	SFX_UI_CLICK = var_3_7

	var_1_10001(var_3_10, var_3_11, var_3_12, var_3_7)

	onButton = var_1_10001

	local var_3_13 = arg_3_0
	local var_3_14 = arg_3_0.metaBtn

	local function var_3_15()
		local var_8_0 = arg_3_0.contextData.shipId
		local var_8_1
		local var_8_2

		if var_8_0 then
			getProxy = var_2_10003
			BayProxy = var_2_10005

			local var_8_3 = var_2_10003(var_2_10005)
			local var_8_4 = var_3.getShipById(var_8_3, arg_3_0.contextData.shipId)

			var_8_1 = var_8_2.isMetaShip(var_8_4)
		end

		if var_8_1 then
			local var_8_5 = arg_3_0
			local var_8_6 = var_3.emit

			SkillInfoMediator = var_2_10006

			var_8_6(var_8_5, var_2_10006.WARP_TO_META_TACTICS, var_8_2.configId)
		end

		return
	end

	SFX_PANEL = var_3_7

	var_1_10001(var_3_13, var_3_14, var_3_15, var_3_7)

	onButton = var_1_10001

	local var_3_16 = arg_3_0
	local var_3_17 = arg_3_0.btnTypeNormal

	local function var_3_18()
		local var_9_0 = arg_3_0

		var_0.showInfo(var_9_0, false)

		local var_9_1 = arg_3_0

		var_0.flushTypeBtn(var_9_1)

		return
	end

	SFX_PANEL = var_3_7

	var_1_10001(var_3_16, var_3_17, var_3_18, var_3_7)

	onButton = var_1_10001

	local var_3_19 = arg_3_0
	local var_3_20 = arg_3_0.btnTypeWorld

	local function var_3_21()
		local var_10_0 = arg_3_0

		var_0.showInfo(var_10_0, true)

		local var_10_1 = arg_3_0

		var_0.flushTypeBtn(var_10_1)

		return
	end

	SFX_PANEL = var_3_7

	var_1_10001(var_3_19, var_3_20, var_3_21, var_3_7)

	tobool = var_1_10001
	pg = var_3_19

	if var_1_10001(var_3_19.skill_world_display[arg_3_0.contextData.skillId]) then
		arg_3_0:flushTypeBtn()
	else
		setActive = var_1

		var_1(arg_3_0.btnTypeNormal, false)

		setActive = var_1

		var_1(arg_3_0.btnTypeWorld, false)
	end

	arg_3_0:showBase()
	arg_3_0:showInfo(false)

	return
end

function var_0_1.flushTypeBtn(arg_11_0)
	setActive = var_1_10001

	var_1_10001(arg_11_0.btnTypeNormal, arg_11_0.isWorld)

	setActive = var_1_10001

	var_1_10001(arg_11_0.btnTypeWorld, not arg_11_0.isWorld)

	return
end

function var_0_1.showBase(arg_12_0)
	local var_12_0 = arg_12_0.contextData.skillId
	local var_12_1 = arg_12_0.contextData.skillOnShip

	setText = var_1_10003

	local var_12_2 = arg_12_0.skillInfoName

	getSkillName = var_1_10006

	var_1_10003(var_12_2, var_1_10006(var_12_0))

	getSkillConfig = var_1_10003

	local var_12_3 = var_1_10003(var_12_0)

	LoadImageSpriteAsync = var_1_10004

	var_1_10004("skillicon/" .. var_12_3.icon, arg_12_0.skillInfoIcon)

	local var_12_4 = not arg_12_0.contextData.fromNewShip and var_12_1 and var_12_1.level < #var_12_3 and var_12_1.id ~= 22262 and var_12_1.id ~= 22261

	setActive = var_5

	var_5(arg_12_0.upgradeBtn, var_12_4)

	local var_12_5 = arg_12_0.contextData.shipId
	local var_12_6
	local var_12_7

	if var_12_5 then
		getProxy = var_8
		BayProxy = var_1_10010

		local var_12_8 = var_8(var_1_10010)
		local var_12_9 = var_8.getShipById(var_12_8, arg_12_0.contextData.shipId)

		var_12_6 = var_7.isMetaShip(var_12_9)
	end

	MetaCharacterConst = var_8

	local var_12_10 = var_8.isMetaTaskSkillID(var_12_0)

	setActive = var_1_10009

	var_1_10009(arg_12_0.metaBtn, var_12_6 and var_12_10)

	if var_12_6 then
		setActive = var_1_10009

		var_1_10009(arg_12_0.upgradeBtn, false)
	end

	return
end

function var_0_1.showInfo(arg_13_0, arg_13_1)
	arg_13_0.isWorld = arg_13_1

	local var_13_0 = arg_13_0.contextData.skillId
	local var_13_1

	if not arg_13_0.contextData.skillOnShip or not var_3.level then
		var_13_1 = 1
	end

	setText = var_1_10005

	var_1_10005(arg_13_0.skillInfoLv, "Lv." .. var_13_1)

	if arg_13_0.contextData.fromNewShip then
		setText = var_5

		local var_13_2 = arg_13_0.skillInfoIntro

		getSkillDescGet = var_8

		var_5(var_13_2, var_8(var_13_0, arg_13_1))
	else
		setText = var_5

		local var_13_3 = arg_13_0.skillInfoIntro

		getSkillDesc = var_8

		var_5(var_13_3, var_8(var_13_0, var_13_1, arg_13_1))
	end

	return
end

function var_0_1.close(arg_14_0)
	arg_14_0:emit(var_0_1.ON_CLOSE)

	return
end

function var_0_1.willExit(arg_15_0)
	pg = var_1_10001

	local var_15_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_15_0, arg_15_0._tf)

	if arg_15_0.contextData.onExit then
		arg_15_0.contextData.onExit()
	end

	return
end

function var_0_1.inOutAnim(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_1 then
		local var_16_0 = arg_16_0._tf
		local var_16_1 = var_3.Find(var_16_0, "panel/bg_decorations")
		local var_16_2 = var_3.GetComponent

		typeof = var_1_10007
		Animation = var_1_10009

		local var_16_3 = var_16_2(var_16_1, var_1_10007(var_1_10009))

		var_4.Stop(var_16_3)
		var_4:Play("anim_window_bg")

		local var_16_4 = arg_16_0._tf
		local var_16_5 = var_5.Find(var_16_4, "panel/top")
		local var_16_6 = var_5.GetComponent

		typeof = var_1_10009
		Animation = var_1_10011

		local var_16_7 = var_16_6(var_16_5, var_1_10009(var_1_10011))

		var_6.Stop(var_16_7)
		var_6:Play("anim_top")

		local var_16_8 = arg_16_0._tf
		local var_16_9 = var_7.Find(var_16_8, "panel/bg")
		local var_16_10 = var_7.GetComponent

		typeof = var_1_10011
		Animation = var_1_10013

		local var_16_11 = var_16_10(var_16_9, var_1_10011(var_1_10013))

		var_8.Stop(var_16_11)
		var_8:Play("anim_content")

		local var_16_12 = arg_16_0._tf
		local var_16_13 = var_9.Find(var_16_12, "bg")
		local var_16_14 = var_9.GetComponent

		typeof = var_1_10013
		Animation = var_1_10015

		local var_16_15 = var_16_14(var_16_13, var_1_10013(var_1_10015))

		var_10.Stop(var_16_15)
		var_10:Play("anim_bg_plus")

		local var_16_16 = arg_16_0._tf
		local var_16_17 = var_11.Find(var_16_16, "panel/buttonList")
		local var_16_18 = var_11.GetComponent

		typeof = var_1_10015
		Animation = var_1_10017

		local var_16_19 = var_16_18(var_16_17, var_1_10015(var_1_10017))

		var_12.Stop(var_16_19)
		var_12:Play("anim_button_container")
	end

	arg_16_2()

	return
end

return var_0_1

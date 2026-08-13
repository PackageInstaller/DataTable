class = var_0_10000

local var_0_0 = "SpWeaponSkillInfoLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.ship.SkillInfoLayer"))

function var_0_1.getUIName(arg_1_0)
	return "SkillInfoUI"
end

function var_0_1.didEnter(arg_2_0)
	onButton = var_1_10001

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0._tf

	local function var_2_2()
		local var_3_0 = arg_2_0

		var_0.emit(var_3_0, var_0_1.ON_CLOSE)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1_10001(var_2_0, var_2_1, var_2_2, var_1_10006)

	onButton = var_1_10001

	local var_2_3 = arg_2_0
	local var_2_4 = arg_2_0.backBtn

	local function var_2_5()
		local var_4_0 = arg_2_0

		var_0.emit(var_4_0, var_0_1.ON_CLOSE)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1_10001(var_2_3, var_2_4, var_2_5, var_1_10006)

	onButton = var_1_10001

	local var_2_6 = arg_2_0
	local var_2_7 = arg_2_0._tf
	local var_2_8 = var_4.Find(var_2_7, "panel/buttonList/ok_button")

	local function var_2_9()
		local var_5_0 = arg_2_0

		var_0.emit(var_5_0, var_0_1.ON_CLOSE)

		return
	end

	SFX_CONFIRM = var_2_7

	var_1_10001(var_2_6, var_2_8, var_2_9, var_2_7)

	onButton = var_1_10001

	local var_2_10 = arg_2_0
	local var_2_11 = arg_2_0.upgradeBtn

	local function var_2_12()
		local var_6_0 = arg_2_0
		local var_6_1 = var_0.emit

		SkillInfoMediator = var_2_10003

		var_6_1(var_6_0, var_2_10003.WARP_TO_TACTIC)

		return
	end

	SFX_UI_CLICK = var_2_7

	var_1_10001(var_2_10, var_2_11, var_2_12, var_2_7)

	onButton = var_1_10001

	local var_2_13 = arg_2_0
	local var_2_14 = arg_2_0.metaBtn

	local function var_2_15()
		local var_7_0 = arg_2_0.contextData.shipId
		local var_7_1
		local var_7_2

		if var_7_0 then
			getProxy = var_2_10003
			BayProxy = var_2_10005

			local var_7_3 = var_2_10003(var_2_10005)
			local var_7_4 = var_3.getShipById(var_7_3, arg_2_0.contextData.shipId)

			var_7_1 = var_7_2.isMetaShip(var_7_4)
		end

		if var_7_1 then
			local var_7_5 = arg_2_0
			local var_7_6 = var_3.emit

			SkillInfoMediator = var_2_10006

			var_7_6(var_7_5, var_2_10006.WARP_TO_META_TACTICS, var_7_2.configId)
		end

		return
	end

	SFX_PANEL = var_2_7

	var_1_10001(var_2_13, var_2_14, var_2_15, var_2_7)

	onButton = var_1_10001

	local var_2_16 = arg_2_0
	local var_2_17 = arg_2_0.btnTypeNormal

	local function var_2_18()
		local var_8_0 = arg_2_0

		var_0.showInfo(var_8_0, false)

		local var_8_1 = arg_2_0

		var_0.flushTypeBtn(var_8_1)

		return
	end

	SFX_PANEL = var_2_7

	var_1_10001(var_2_16, var_2_17, var_2_18, var_2_7)

	onButton = var_1_10001

	local var_2_19 = arg_2_0
	local var_2_20 = arg_2_0.btnTypeWorld

	local function var_2_21()
		local var_9_0 = arg_2_0

		var_0.showInfo(var_9_0, true)

		local var_9_1 = arg_2_0

		var_0.flushTypeBtn(var_9_1)

		return
	end

	SFX_PANEL = var_2_7

	var_1_10001(var_2_19, var_2_20, var_2_21, var_2_7)

	tobool = var_1_10001
	pg = var_2_19

	if var_1_10001(var_2_19.skill_world_display[arg_2_0.contextData.skillId]) then
		arg_2_0:flushTypeBtn()
	else
		setActive = var_1

		var_1(arg_2_0.btnTypeNormal, false)

		setActive = var_1

		var_1(arg_2_0.btnTypeWorld, false)
	end

	arg_2_0:showBase()
	arg_2_0:showInfo(false)

	setText = var_1

	local var_2_22 = arg_2_0._tf
	local var_2_23 = var_3.Find(var_2_22, "panel/top/title_list/infomation/title")

	i18n = var_4

	var_1(var_2_23, var_4("words_information"))

	setText = var_1

	local var_2_24 = arg_2_0.buttonList
	local var_2_25 = var_3.Find(var_2_24, "ok_button/Image")

	i18n = var_4

	var_1(var_2_25, var_4("text_confirm"))

	setText = var_1

	local var_2_26 = arg_2_0.buttonList
	local var_2_27 = var_3.Find(var_2_26, "level_button/Image")

	i18n = var_4

	var_1(var_2_27, var_4("msgbox_text_upgrade"))

	return
end

function var_0_1.flushTypeBtn(arg_10_0)
	setActive = var_1_10001

	var_1_10001(arg_10_0.btnTypeNormal, arg_10_0.isWorld)

	setActive = var_1_10001

	var_1_10001(arg_10_0.btnTypeWorld, not arg_10_0.isWorld)

	return
end

function var_0_1.showBase(arg_11_0)
	local var_11_0 = arg_11_0.contextData.skillId
	local var_11_1 = arg_11_0.contextData.unlock

	getSkillName = var_1_10003

	local var_11_2 = var_1_10003(var_11_0)

	if not var_11_1 then
		setColorStr = var_1_10004
		var_11_2 = var_1_10004(var_11_2, "#a2a2a2")
	end

	setText = var_1_10004

	var_1_10004(arg_11_0.skillInfoName, var_11_2)

	getSkillConfig = var_1_10004

	local var_11_3 = var_1_10004(var_11_0)

	assert = var_5

	var_5(var_11_3)

	LoadImageSpriteAsync = var_5

	var_5("skillicon/" .. var_11_3.icon, arg_11_0.skillInfoIcon)

	setActive = var_5

	var_5(arg_11_0.upgradeBtn, false)

	setActive = var_5

	var_5(arg_11_0.metaBtn, false)

	return
end

function var_0_1.showInfo(arg_12_0, arg_12_1)
	arg_12_0.isWorld = arg_12_1

	local var_12_0 = arg_12_0.contextData.skillId
	local var_12_1 = arg_12_0.contextData.skillOnShip
	local var_12_2 = arg_12_0.contextData.unlock
	local var_12_3

	if not var_12_1 or not var_12_1.level then
		var_12_3 = 1
	end

	setText = var_1_10006

	var_1_10006(arg_12_0.skillInfoLv, "Lv." .. var_12_3)

	getSkillDesc = var_1_10006

	local var_12_4 = var_1_10006(var_12_0, var_12_3, arg_12_1)

	if not var_12_2 then
		setColorStr = var_1_10007
		i18n = var_9
		var_12_4 = var_1_10007(var_9("spweapon_tip_skill_locked") .. var_12_4, "#a2a2a2")
	end

	setText = var_1_10007

	var_1_10007(arg_12_0.skillInfoIntro, var_12_4)

	return
end

function var_0_1.willExit(arg_13_0)
	pg = var_1_10001

	local var_13_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_13_0, arg_13_0._tf)

	if arg_13_0.contextData.onExit then
		arg_13_0.contextData.onExit()
	end

	return
end

return var_0_1

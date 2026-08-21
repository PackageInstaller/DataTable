local var_0_0 = class("SkillInfoLayer", import("..base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "SkillInfoUI"
end

function var_0_0.init(arg_2_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_2_0._tf)

	arg_2_0.backBtn = arg_2_0._tf:Find("panel/top/btnBack")
	arg_2_0.skillInfoName = arg_2_0._tf:Find("panel/bg/skill_name")
	arg_2_0.skillInfoLv = arg_2_0._tf:Find("panel/bg/skill_lv")
	arg_2_0.skillInfoIntro = arg_2_0._tf:Find("panel/bg/help_panel/skill_intro")
	arg_2_0.skillInfoIcon = arg_2_0._tf:Find("panel/bg/skill_icon")
	arg_2_0.btnTypeNormal = arg_2_0._tf:Find("panel/bg/btn_type_normal")
	arg_2_0.btnTypeWorld = arg_2_0._tf:Find("panel/bg/btn_type_world")
	arg_2_0.buttonList = arg_2_0._tf:Find("panel/buttonList")
	arg_2_0.upgradeBtn = arg_2_0._tf:Find("panel/buttonList/level_button")
	arg_2_0.metaBtn = arg_2_0._tf:Find("panel/buttonList/meta_button")

	setText(arg_2_0.metaBtn:Find("Image"), i18n("meta_skillbtn_tactics"))
	setText(arg_2_0._tf:Find("panel/top/title_list/infomation/title"), i18n("words_information"))
	setText(arg_2_0.buttonList:Find("ok_button/Image"), i18n("text_confirm"))

	if PLATFORM_CODE == PLATFORM_JP then
		setText(arg_2_0.buttonList:Find("level_button/Image"), i18n("msgbox_text_noPos_intensify"))
	else
		setText(arg_2_0.buttonList:Find("level_button/Image"), i18n("msgbox_text_upgrade"))
	end

	return
end

function var_0_0.didEnter(arg_3_0)
	onButton(arg_3_0, arg_3_0._tf, function()
		arg_3_0:emit(var_0_0.ON_CLOSE)

		return
	end, SFX_CANCEL)
	onButton(arg_3_0, arg_3_0.backBtn, function()
		arg_3_0:emit(var_0_0.ON_CLOSE)

		return
	end, SFX_CANCEL)
	onButton(arg_3_0, arg_3_0._tf:Find("panel/buttonList/ok_button"), function()
		arg_3_0:emit(var_0_0.ON_CLOSE)

		return
	end, SFX_CONFIRM)
	onButton(arg_3_0, arg_3_0.upgradeBtn, function()
		arg_3_0:emit(SkillInfoMediator.WARP_TO_TACTIC)

		return
	end, SFX_UI_CLICK)
	onButton(arg_3_0, arg_3_0.metaBtn, function()
		local var_8_0
		local var_8_1

		if arg_3_0.contextData.shipId then
			var_8_1 = getProxy(BayProxy):getShipById(arg_3_0.contextData.shipId)
			var_8_0 = var_8_1:isMetaShip()
		end

		if var_8_0 then
			arg_3_0:emit(SkillInfoMediator.WARP_TO_META_TACTICS, var_8_1.configId)
		end

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.btnTypeNormal, function()
		arg_3_0:showInfo(false)
		arg_3_0:flushTypeBtn()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.btnTypeWorld, function()
		arg_3_0:showInfo(true)
		arg_3_0:flushTypeBtn()

		return
	end, SFX_PANEL)

	if tobool(pg.skill_world_display[arg_3_0.contextData.skillId]) then
		arg_3_0:flushTypeBtn()
	else
		setActive(arg_3_0.btnTypeNormal, false)
		setActive(arg_3_0.btnTypeWorld, false)
	end

	arg_3_0:showBase()
	arg_3_0:showInfo(false)

	return
end

function var_0_0.flushTypeBtn(arg_11_0)
	setActive(arg_11_0.btnTypeNormal, arg_11_0.isWorld)
	setActive(arg_11_0.btnTypeWorld, not arg_11_0.isWorld)

	return
end

function var_0_0.showBase(arg_12_0)
	local var_12_0 = arg_12_0.contextData.skillId
	local var_12_1 = arg_12_0.contextData.skillOnShip

	setText(arg_12_0.skillInfoName, getSkillName(arg_12_0.contextData.skillId))

	local var_12_2 = getSkillConfig(var_12_0)

	LoadImageSpriteAsync("skillicon/" .. var_12_2.icon, arg_12_0.skillInfoIcon)
	setActive(arg_12_0.upgradeBtn, not arg_12_0.contextData.fromNewShip and var_12_1 and var_12_1.level < #var_12_2 and var_12_1.id ~= 22262 and var_12_1.id ~= 22261)

	local var_12_3

	if arg_12_0.contextData.shipId then
		var_12_3 = getProxy(BayProxy):getShipById(arg_12_0.contextData.shipId):isMetaShip()
	end

	local var_12_5 = MetaCharacterConst.isMetaTaskSkillID(var_12_0)

	setActive(arg_12_0.metaBtn, var_12_3 and var_12_5)

	if var_12_3 then
		setActive(arg_12_0.upgradeBtn, false)
	end

	return
end

function var_0_0.showInfo(arg_13_0, arg_13_1)
	arg_13_0.isWorld = arg_13_1

	if arg_13_0.contextData.skillOnShip then
		local var_13_1 = arg_13_0.contextData.skillOnShip.level or 1

		setText(arg_13_0.skillInfoLv, "Lv." .. var_13_1)

		if arg_13_0.contextData.fromNewShip then
			setText(arg_13_0.skillInfoIntro, getSkillDescGet(var_13_0, arg_13_1))
		else
			setText(arg_13_0.skillInfoIntro, getSkillDesc(var_13_0, var_13_1, arg_13_1))
		end

		return
	end
end

function var_0_0.close(arg_14_0)
	arg_14_0:emit(var_0_0.ON_CLOSE)

	return
end

function var_0_0.willExit(arg_15_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_15_0._tf)

	if arg_15_0.contextData.onExit then
		arg_15_0.contextData.onExit()
	end

	return
end

function var_0_0.inOutAnim(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_1 then
		local var_16_0 = arg_16_0._tf:Find("panel/bg_decorations"):GetComponent(typeof(Animation))

		var_16_0:Stop()
		var_16_0:Play("anim_window_bg")

		local var_16_1 = arg_16_0._tf:Find("panel/top"):GetComponent(typeof(Animation))

		var_16_1:Stop()
		var_16_1:Play("anim_top")

		local var_16_2 = arg_16_0._tf:Find("panel/bg"):GetComponent(typeof(Animation))

		var_16_2:Stop()
		var_16_2:Play("anim_content")

		local var_16_3 = arg_16_0._tf:Find("bg"):GetComponent(typeof(Animation))

		var_16_3:Stop()
		var_16_3:Play("anim_bg_plus")

		local var_16_4 = arg_16_0._tf:Find("panel/buttonList"):GetComponent(typeof(Animation))

		var_16_4:Stop()
		var_16_4:Play("anim_button_container")
	end

	arg_16_2()

	return
end

return var_0_0

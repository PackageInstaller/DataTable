local var_0_0 = class("CommanderSkillLayer", import("..base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "CommanderSkillUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.backBtn = arg_2_0._tf:Find("top/btnBack")
	arg_2_0.skillInfoName = arg_2_0._tf:Find("panel/bg/skill_name")
	arg_2_0.skillInfoLv = arg_2_0._tf:Find("panel/bg/skill_lv")
	arg_2_0.skillInfoIntro = arg_2_0._tf:Find("panel/bg/help_panel/skill_intro")
	arg_2_0.skillInfoIcon = arg_2_0._tf:Find("panel/bg/skill_icon")
	arg_2_0.buttonList = arg_2_0._tf:Find("panel/buttonList")
	arg_2_0.skillDescTF = arg_2_0._tf:Find("panel/bg/help_panel/Viewport/content/introTF")
	arg_2_0.skillDescContent = arg_2_0._tf:Find("panel/bg/help_panel/Viewport/content")

	setText(arg_2_0.skillInfoName, arg_2_0.contextData.skill:getConfig("name"))
	setText(arg_2_0.skillInfoLv, "Lv." .. arg_2_0.contextData.skill:getLevel())

	arg_2_0.skillDescList = UIItemList.New(arg_2_0.skillDescContent, arg_2_0.skillDescTF)

	GetImageSpriteFromAtlasAsync("commanderskillicon/" .. arg_2_0.contextData.skill:getConfig("icon"), "", arg_2_0.skillInfoIcon)
	arg_2_0:SetLocaliza()

	return
end

function var_0_0.SetLocaliza(arg_3_0)
	setText(arg_3_0._tf:Find("top/title_list/infomation/title"), i18n("words_information"))
	setText(arg_3_0._tf:Find("panel/buttonList/ok_button/Image"), i18n("word_ok"))

	return
end

function var_0_0.didEnter(arg_4_0)
	onButton(arg_4_0, arg_4_0._tf, function()
		arg_4_0:emit(var_0_0.ON_CLOSE)

		return
	end, SFX_CANCEL)
	onButton(arg_4_0, arg_4_0.backBtn, function()
		arg_4_0:emit(var_0_0.ON_CLOSE)

		return
	end, SFX_CANCEL)
	onButton(arg_4_0, arg_4_0._tf:Find("panel/buttonList/ok_button"), function()
		arg_4_0:emit(var_0_0.ON_CLOSE)

		return
	end, SFX_CONFIRM)
	pg.UIMgr.GetInstance():BlurPanel(arg_4_0._tf)

	arg_4_0.commonFlag = defaultValue(arg_4_0.contextData.commonFlag, true)

	arg_4_0:UpdateList()

	return
end

function var_0_0.UpdateList(arg_8_0)
	local var_8_0 = arg_8_0.contextData.skill:getConfig("lv")
	local var_8_1 = arg_8_0.contextData.skill:GetSkillGroup()
	local var_8_2 = arg_8_0.contextData.skill:getConfig("lv")

	arg_8_0.skillDescList:make(function(arg_9_0, arg_9_1, arg_9_2)
		if arg_9_0 == UIItemList.EventUpdate then
			local var_9_0 = var_8_1[arg_9_1 + 1]
			local var_9_1 = arg_8_0:GetColor(var_8_2 >= var_8_1[arg_9_1 + 1].lv)
			local var_9_2 = var_8_2 < var_8_1[arg_9_1 + 1].lv and "(Lv." .. var_9_0.lv .. i18n("word_take_effect") .. ")" or ""

			setText(arg_9_2, "<color=" .. var_9_1 .. ">" .. arg_8_0:GetDesc(arg_8_0.commonFlag, var_8_1[arg_9_1 + 1]) .. var_9_2 .. "</color>")
			setText(arg_9_2:Find("level"), "<color=" .. var_9_1 .. ">" .. "Lv." .. var_9_0.lv .. "</color>")
		end

		return
	end)
	arg_8_0.skillDescList:align(#arg_8_0.contextData.skill:GetSkillGroup())

	return
end

function var_0_0.GetDesc(arg_10_0, arg_10_1, arg_10_2)
	if not arg_10_1 and arg_10_2.desc_world and arg_10_2.desc_world ~= "" then
		return arg_10_2.desc_world
	else
		return arg_10_2.desc
	end

	return
end

function var_0_0.GetColor(arg_11_0, arg_11_1)
	return "#FFFFFFFF"
end

function var_0_0.willExit(arg_12_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_12_0._tf)

	return
end

function var_0_0.onBackPressed(arg_13_0)
	triggerButton(arg_13_0.backBtn)

	return
end

return var_0_0

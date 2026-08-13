class = var_0_10000

local var_0_0 = "CommanderSkillLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "CommanderSkillUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0.contextData.skill
	local var_2_1 = arg_2_0._tf

	arg_2_0.backBtn = var_2.Find(var_2_1, "top/btnBack")

	local var_2_2 = arg_2_0._tf

	arg_2_0.skillInfoName = var_2.Find(var_2_2, "panel/bg/skill_name")

	local var_2_3 = arg_2_0._tf

	arg_2_0.skillInfoLv = var_2.Find(var_2_3, "panel/bg/skill_lv")

	local var_2_4 = arg_2_0._tf

	arg_2_0.skillInfoIntro = var_2.Find(var_2_4, "panel/bg/help_panel/skill_intro")

	local var_2_5 = arg_2_0._tf

	arg_2_0.skillInfoIcon = var_2.Find(var_2_5, "panel/bg/skill_icon")

	local var_2_6 = arg_2_0._tf

	arg_2_0.buttonList = var_2.Find(var_2_6, "panel/buttonList")

	local var_2_7 = arg_2_0._tf

	arg_2_0.skillDescTF = var_2.Find(var_2_7, "panel/bg/help_panel/Viewport/content/introTF")

	local var_2_8 = arg_2_0._tf

	arg_2_0.skillDescContent = var_2.Find(var_2_8, "panel/bg/help_panel/Viewport/content")
	setText = var_2

	var_2(arg_2_0.skillInfoName, var_2_0:getConfig("name"))

	setText = var_2

	var_2(arg_2_0.skillInfoLv, "Lv." .. var_2_0:getLevel())

	UIItemList = var_2
	arg_2_0.skillDescList = var_2.New(arg_2_0.skillDescContent, arg_2_0.skillDescTF)
	GetImageSpriteFromAtlasAsync = var_2

	var_2("commanderskillicon/" .. var_2_0:getConfig("icon"), "", arg_2_0.skillInfoIcon)
	arg_2_0:SetLocaliza()

	return
end

function var_0_1.SetLocaliza(arg_3_0)
	setText = var_1_10001

	local var_3_0 = arg_3_0._tf
	local var_3_1 = var_2.Find(var_3_0, "top/title_list/infomation/title")

	i18n = var_3_0

	var_1_10001(var_3_1, var_3_0("words_information"))

	setText = var_1_10001

	local var_3_2 = arg_3_0._tf
	local var_3_3 = var_2.Find(var_3_2, "panel/buttonList/ok_button/Image")

	i18n = var_3_2

	var_1_10001(var_3_3, var_3_2("word_ok"))

	return
end

function var_0_1.didEnter(arg_4_0)
	onButton = var_1_10001

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0._tf

	local function var_4_2()
		local var_5_0 = arg_4_0

		var_0.emit(var_5_0, var_0_1.ON_CLOSE)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1_10001(var_4_0, var_4_1, var_4_2, var_1_10005)

	onButton = var_1_10001

	local var_4_3 = arg_4_0
	local var_4_4 = arg_4_0.backBtn

	local function var_4_5()
		local var_6_0 = arg_4_0

		var_0.emit(var_6_0, var_0_1.ON_CLOSE)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1_10001(var_4_3, var_4_4, var_4_5, var_1_10005)

	onButton = var_1_10001

	local var_4_6 = arg_4_0
	local var_4_7 = arg_4_0._tf
	local var_4_8 = var_3.Find(var_4_7, "panel/buttonList/ok_button")

	local function var_4_9()
		local var_7_0 = arg_4_0

		var_0.emit(var_7_0, var_0_1.ON_CLOSE)

		return
	end

	SFX_CONFIRM = var_5

	var_1_10001(var_4_6, var_4_8, var_4_9, var_5)

	pg = var_1_10001

	local var_4_10 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_4_10, arg_4_0._tf)

	defaultValue = var_1
	arg_4_0.commonFlag = var_1(arg_4_0.contextData.commonFlag, true)

	arg_4_0:UpdateList()

	return
end

function var_0_1.UpdateList(arg_8_0)
	local var_8_0 = arg_8_0.contextData.skill
	local var_8_1 = var_1.getConfig(var_8_0, "lv")
	local var_8_2 = var_1:GetSkillGroup()
	local var_8_3 = var_1:getConfig("lv")
	local var_8_4 = arg_8_0.skillDescList

	var_5.make(var_8_4, function(arg_9_0, arg_9_1, arg_9_2)
		UIItemList = var_2_10003

		if arg_9_0 == var_2_10003.EventUpdate then
			local var_9_0 = var_8_2[arg_9_1 + 1]
			local var_9_1 = arg_8_0
			local var_9_2 = var_4.GetDesc(var_9_1, arg_8_0.commonFlag, var_9_0)
			local var_9_3 = arg_8_0
			local var_9_4 = var_5.GetColor
			local var_9_5 = var_8_3
			local var_9_6 = var_9_4(var_9_3, var_9_0.lv <= var_9_5)

			if var_8_3 < var_9_0.lv then
				local var_9_7 = "(Lv."
				local var_9_8 = var_9_0.lv

				i18n = var_8

				local var_9_9

				if not (var_9_7 .. var_9_8 .. var_8("word_take_effect") .. ")") then
					var_9_9 = ""
				end

				setText = var_9_8

				var_9_8(arg_9_2, "<color=" .. var_9_6 .. ">" .. var_9_2 .. var_9_9 .. "</color>")

				setText = var_9_8

				var_9_8(arg_9_2:Find("level"), "<color=" .. var_9_6 .. ">" .. "Lv." .. var_9_0.lv .. "</color>")

				return
			end
		end
	end)

	local var_8_5 = arg_8_0.skillDescList

	var_5.align(var_8_5, #var_8_2)

	return
end

function var_0_1.GetDesc(arg_10_0, arg_10_1, arg_10_2)
	if not arg_10_1 and arg_10_2.desc_world and arg_10_2.desc_world ~= "" then
		return arg_10_2.desc_world
	else
		return arg_10_2.desc
	end

	return
end

function var_0_1.GetColor(arg_11_0, arg_11_1)
	return "#FFFFFFFF"
end

function var_0_1.willExit(arg_12_0)
	pg = var_1_10001

	local var_12_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_12_0, arg_12_0._tf)

	return
end

function var_0_1.onBackPressed(arg_13_0)
	triggerButton = var_1_10001

	var_1_10001(arg_13_0.backBtn)

	return
end

return var_0_1

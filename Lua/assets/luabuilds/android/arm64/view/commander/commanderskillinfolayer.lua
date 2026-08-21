local var_0_0 = class("CommanderSkillInfoLayer", import("..base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "CommanderSkillInfoUI"
end

function var_0_0.init(arg_2_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_2_0._tf)

	arg_2_0.skillNameTxt = arg_2_0._tf:Find("panel/bg/skill_name"):GetComponent(typeof(Text))
	arg_2_0.skillLevelTxt = arg_2_0._tf:Find("panel/bg/skill_lv"):GetComponent(typeof(Text))
	arg_2_0.skillDescTxt = arg_2_0._tf:Find("panel/bg/help_panel/skill_intro"):GetComponent(typeof(Text))
	arg_2_0.skillIcon = arg_2_0._tf:Find("panel/bg/skill_icon")

	return
end

function var_0_0.didEnter(arg_3_0)
	onButton(arg_3_0, arg_3_0._tf, function()
		arg_3_0:emit(var_0_0.ON_CLOSE)

		return
	end, SFX_CANCEL)
	onButton(arg_3_0, arg_3_0._tf:Find("panel/top/btnBack"), function()
		arg_3_0:emit(var_0_0.ON_CLOSE)

		return
	end, SFX_CANCEL)
	onButton(arg_3_0, arg_3_0._tf:Find("panel/ok_button"), function()
		arg_3_0:emit(var_0_0.ON_CLOSE)

		return
	end, SFX_CONFIRM)
	arg_3_0:updateSkill()

	return
end

function var_0_0.updateSkill(arg_7_0)
	arg_7_0.skillNameTxt.text = arg_7_0.contextData.skill:getConfig("name")
	arg_7_0.skillLevelTxt.text = "Lv." .. arg_7_0.contextData.skill:getLevel()
	arg_7_0.skillDescTxt.text = arg_7_0.contextData.skill:getConfig("desc")

	GetImageSpriteFromAtlasAsync("CommanderSkillIcon/" .. arg_7_0.contextData.skill:getConfig("icon"), "", arg_7_0.skillIcon)

	return
end

function var_0_0.close(arg_8_0)
	arg_8_0:emit(var_0_0.ON_CLOSE)

	return
end

function var_0_0.willExit(arg_9_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_9_0._tf)

	return
end

return var_0_0

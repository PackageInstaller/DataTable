local var_0_0 = class("IslandShipSkillMsgboxWindow", import(".IslandBaseMsgboxWindow"))

function var_0_0.getUIName(arg_1_0)
	return "IslandCommonMsgBoxForShipSkill"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.closeBtn = arg_2_0._tf:Find("close")
	arg_2_0.nameTxt = arg_2_0._tf:Find("name"):GetComponent(typeof(Text))
	arg_2_0.levelTxt = arg_2_0._tf:Find("level"):GetComponent(typeof(Text))
	arg_2_0.descTxt = arg_2_0._tf:Find("content/Text"):GetComponent(typeof(Text))
	arg_2_0.iconTr = arg_2_0._tf:Find("icon")

	setText(arg_2_0._tf:Find("title"), i18n("island_skill_desc"))

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0.closeBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnShow(arg_5_0)
	assert(arg_5_0.settings.skill)

	arg_5_0.nameTxt.text = arg_5_0.settings.skill:GetName()
	arg_5_0.descTxt.text = arg_5_0.settings.skill:GetEffectDesc()
	arg_5_0.levelTxt.text = "[Lv." .. arg_5_0.settings.skill:GetLevel() .. "]"

	GetImageSpriteFromAtlasAsync("island/IslandSkillIcon/" .. arg_5_0.settings.skill:GetIcon(), "", arg_5_0.iconTr)

	return
end

function var_0_0.OnHide(arg_6_0)
	return
end

return var_0_0

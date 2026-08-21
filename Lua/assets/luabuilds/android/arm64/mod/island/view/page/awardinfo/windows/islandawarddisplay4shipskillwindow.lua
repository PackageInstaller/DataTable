local var_0_0 = class("IslandAwardDisplay4ShipSkillWindow", import(".IslandAwardDisplayWindow"))

function var_0_0.getUIName(arg_1_0)
	return "IslandAwardDisplayForShipSkillUI"
end

function var_0_0.OnLoaded(arg_2_0)
	var_0_0.super.OnLoaded(arg_2_0)

	arg_2_0.nameTxt = arg_2_0._tf:Find("frame/bg/item/name"):GetComponent(typeof(Text))
	arg_2_0.levelTxt = arg_2_0._tf:Find("frame/bg/item/level"):GetComponent(typeof(Text))
	arg_2_0.descTxt = arg_2_0._tf:Find("frame/bg/item/desc"):GetComponent(typeof(Text))
	arg_2_0.iconTr = arg_2_0._tf:Find("frame/bg/item/icon")
	arg_2_0.uiNewStart = UIItemList.New(arg_2_0._tf:Find("frame/bg/starts"), arg_2_0._tf:Find("frame/bg/starts/tpl"))

	return
end

function var_0_0.Show(arg_3_0, arg_3_1)
	arg_3_1.awards = {}

	var_0_0.super.Show(arg_3_0, arg_3_1)

	arg_3_0.title.text = i18n("island_unlock_skill")
	arg_3_0.nameTxt.text = arg_3_1.skill:GetName()
	arg_3_0.levelTxt.text = "[Lv." .. arg_3_1.skill:GetLevel() .. "]"
	arg_3_0.descTxt.text = arg_3_1.skill:GetEffectDesc()

	GetImageSpriteFromAtlasAsync("island/IslandSkillIcon/" .. arg_3_1.skill:GetIcon(), "", arg_3_0.iconTr)
	arg_3_0:UpdateBreakLevel(arg_3_1.ship)

	return
end

function var_0_0.UpdateBreakLevel(arg_4_0, arg_4_1)
	arg_4_0.uiNewStart:make(function(arg_5_0, arg_5_1, arg_5_2)
		if arg_5_0 == UIItemList.EventUpdate then
			setActive(arg_5_2:Find("Image"), arg_5_1 < arg_4_1:GetBreakLevel())
		end

		return
	end)
	arg_4_0.uiNewStart:align((arg_4_1:GetBreakMaxLevel()))

	return
end

function var_0_0.OnDestroy(arg_6_0)
	return
end

return var_0_0

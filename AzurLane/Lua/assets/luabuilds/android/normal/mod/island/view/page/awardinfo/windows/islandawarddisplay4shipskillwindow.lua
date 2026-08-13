class = var_0_10000

local var_0_0 = "IslandAwardDisplay4ShipSkillWindow"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandAwardDisplayWindow"))

function var_0_1.getUIName(arg_1_0)
	return "IslandAwardDisplayForShipSkillUI"
end

function var_0_1.OnLoaded(arg_2_0)
	var_0_1.super.OnLoaded(arg_2_0)

	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "frame/bg/item/name")
	local var_2_2 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.nameTxt = var_2_2(var_2_1, var_3(var_1_10004))

	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_1.Find(var_2_3, "frame/bg/item/level")
	local var_2_5 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.levelTxt = var_2_5(var_2_4, var_3(var_1_10004))

	local var_2_6 = arg_2_0._tf
	local var_2_7 = var_1.Find(var_2_6, "frame/bg/item/desc")
	local var_2_8 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.descTxt = var_2_8(var_2_7, var_3(var_1_10004))

	local var_2_9 = arg_2_0._tf

	arg_2_0.iconTr = var_1.Find(var_2_9, "frame/bg/item/icon")
	UIItemList = var_1

	local var_2_10 = var_1.New
	local var_2_11 = arg_2_0._tf
	local var_2_12 = var_2.Find(var_2_11, "frame/bg/starts")
	local var_2_13 = arg_2_0._tf

	arg_2_0.uiNewStart = var_2_10(var_2_12, var_3.Find(var_2_13, "frame/bg/starts/tpl"))

	return
end

function var_0_1.Show(arg_3_0, arg_3_1)
	arg_3_1.awards = {}

	var_0_1.super.Show(arg_3_0, arg_3_1)

	local var_3_0 = arg_3_0.title

	i18n = var_3
	var_3_0.text = var_3("island_unlock_skill")

	local var_3_1 = arg_3_1.skill

	arg_3_0.nameTxt.text = var_3_1:GetName()
	arg_3_0.levelTxt.text = "[Lv." .. var_3_1:GetLevel() .. "]"

	local var_3_2 = arg_3_0.descTxt

	var_3_2.text = var_3_1:GetEffectDesc()
	GetImageSpriteFromAtlasAsync = var_3_2

	var_3_2("island/IslandSkillIcon/" .. var_3_1:GetIcon(), "", arg_3_0.iconTr)
	arg_3_0:UpdateBreakLevel(arg_3_1.ship)

	return
end

function var_0_1.UpdateBreakLevel(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:GetBreakMaxLevel()
	local var_4_1 = arg_4_0.uiNewStart

	var_3.make(var_4_1, function(arg_5_0, arg_5_1, arg_5_2)
		UIItemList = var_2_10003

		if arg_5_0 == var_2_10003.EventUpdate then
			setActive = var_3

			local var_5_0 = arg_5_2:Find("Image")
			local var_5_1 = arg_4_1

			var_3(var_5_0, arg_5_1 < var_5.GetBreakLevel(var_5_1))
		end

		return
	end)

	local var_4_2 = arg_4_0.uiNewStart

	var_3.align(var_4_2, var_4_0)

	return
end

function var_0_1.OnDestroy(arg_6_0)
	return
end

return var_0_1

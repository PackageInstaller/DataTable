class = var_0_10000

local var_0_0 = "IslandShipSkillMsgboxWindow"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandBaseMsgboxWindow"))

function var_0_1.getUIName(arg_1_0)
	return "IslandCommonMsgBoxForShipSkill"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_0, "close")

	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_1.Find(var_2_1, "name")
	local var_2_3 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.nameTxt = var_2_3(var_2_2, var_3(var_1_10004))

	local var_2_4 = arg_2_0._tf
	local var_2_5 = var_1.Find(var_2_4, "level")
	local var_2_6 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.levelTxt = var_2_6(var_2_5, var_3(var_1_10004))

	local var_2_7 = arg_2_0._tf
	local var_2_8 = var_1.Find(var_2_7, "content/Text")
	local var_2_9 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.descTxt = var_2_9(var_2_8, var_3(var_1_10004))

	local var_2_10 = arg_2_0._tf

	arg_2_0.iconTr = var_1.Find(var_2_10, "icon")
	setText = var_1

	local var_2_11 = arg_2_0._tf
	local var_2_12 = var_2.Find(var_2_11, "title")

	i18n = var_2_11

	var_1(var_2_12, var_2_11("island_skill_desc"))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.closeBtn

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	return
end

function var_0_1.OnShow(arg_5_0)
	local var_5_0 = arg_5_0.settings.skill

	assert = var_1_10002

	var_1_10002(var_5_0)

	arg_5_0.nameTxt.text = var_5_0:GetName()
	arg_5_0.descTxt.text = var_5_0:GetEffectDesc()

	local var_5_1 = arg_5_0.levelTxt

	var_5_1.text = "[Lv." .. var_5_0:GetLevel() .. "]"
	GetImageSpriteFromAtlasAsync = var_5_1

	var_5_1("island/IslandSkillIcon/" .. var_5_0:GetIcon(), "", arg_5_0.iconTr)

	return
end

function var_0_1.OnHide(arg_6_0)
	return
end

return var_0_1

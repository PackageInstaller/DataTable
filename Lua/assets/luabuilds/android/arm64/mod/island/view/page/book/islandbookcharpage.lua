local var_0_0 = class("IslandBookCharPage", import(".IslandBookItemPage"))

function var_0_0.getUIName(arg_1_0)
	return "IslandBookCharUI"
end

function var_0_0.GetIllustrationType(arg_2_0)
	return IslandIllustration.TYPES.CHAR
end

function var_0_0.GetHelpTip(arg_3_0)
	return i18n("island_guide_help")
end

function var_0_0.OnLoaded(arg_4_0)
	var_0_0.super.OnLoaded(arg_4_0)

	arg_4_0.starList = UIItemList.New(arg_4_0.rightTF:Find("stars"), arg_4_0.rightTF:Find("stars/tpl"))

	return
end

function var_0_0.FlushRightPanel(arg_5_0)
	var_0_0.super.FlushRightPanel(arg_5_0)

	local var_5_0, var_5_1, var_5_2, var_5_3

	if not arg_5_0.showIllustration then
		do return end

		var_5_0 = arg_5_0.showIllustration:GetLinkConfigID()
		var_5_1 = getProxy(IslandProxy):GetIsland():GetCharacterAgency():GetShipById(var_5_0)
		var_5_2 = setText
		var_5_3 = arg_5_0.rightTF:Find("level")
	end

	local var_5_4 = arg_5_0.showIllustration:GetStatus() == IslandIllustration.STATUS.UNLOCK and "Lv." .. var_5_1:GetLevel() or ""

	var_5_2(var_5_3, var_5_4)
	setScrollTextWithSize(arg_5_0.rightNameTF, arg_5_0.rightTF:Find("scroll_name/Text"), arg_5_0.showIllustration:GetName(), 11)

	local var_5_5 = var_5_1 and var_5_1:GetBreakLevel() or 0

	arg_5_0.starList:make(function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_0 == UIItemList.EventUpdate then
			setActive(arg_6_2:Find("Image"), arg_6_1 + 1 <= var_5_5)
		end

		return
	end)
	arg_5_0.starList:align(arg_5_0:GetShipBreakMaxLevel(var_5_0))

	return
end

function var_0_0.GetShipBreakMaxLevel(arg_7_0, arg_7_1)
	return pg.island_chara_template[arg_7_1].upgrade_level[2] + 1
end

return var_0_0

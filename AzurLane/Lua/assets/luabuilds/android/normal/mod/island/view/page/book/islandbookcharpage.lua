class = var_0_10000

local var_0_0 = "IslandBookCharPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandBookItemPage"))

function var_0_1.getUIName(arg_1_0)
	return "IslandBookCharUI"
end

function var_0_1.GetIllustrationType(arg_2_0)
	IslandIllustration = var_1_10001

	return var_1_10001.TYPES.CHAR
end

function var_0_1.GetHelpTip(arg_3_0)
	i18n = var_1_10001

	return var_1_10001("island_guide_help")
end

function var_0_1.OnLoaded(arg_4_0)
	var_0_1.super.OnLoaded(arg_4_0)

	UIItemList = var_1

	local var_4_0 = var_1.New
	local var_4_1 = arg_4_0.rightTF
	local var_4_2 = var_2.Find(var_4_1, "stars")
	local var_4_3 = arg_4_0.rightTF

	arg_4_0.starList = var_4_0(var_4_2, var_3.Find(var_4_3, "stars/tpl"))

	return
end

function var_0_1.FlushRightPanel(arg_5_0)
	var_0_1.super.FlushRightPanel(arg_5_0)

	if not arg_5_0.showIllustration then
		return
	end

	local var_5_0 = arg_5_0.showIllustration
	local var_5_1 = var_1.GetStatus(var_5_0)

	IslandIllustration = var_5_0

	local var_5_2 = var_5_1 == var_5_0.STATUS.UNLOCK
	local var_5_3 = arg_5_0.showIllustration
	local var_5_4 = var_2.GetLinkConfigID(var_5_3)

	getProxy = var_5_3
	IslandProxy = var_1_10004

	local var_5_5 = var_5_3(var_1_10004)
	local var_5_6 = var_3.GetIsland(var_5_5)
	local var_5_7 = var_3.GetCharacterAgency(var_5_6)
	local var_5_8 = var_3.GetShipById(var_5_7, var_5_4)

	setText = var_5_7

	local var_5_9 = arg_5_0.rightTF
	local var_5_10 = var_5.Find(var_5_9, "level")
	local var_5_11

	if not var_5_2 or not ("Lv." .. var_5_8:GetLevel()) then
		var_5_11 = ""
	end

	var_5_7(var_5_10, var_5_11)

	setScrollTextWithSize = var_5_7

	local var_5_12 = arg_5_0.rightNameTF
	local var_5_13 = arg_5_0.rightTF
	local var_5_14 = var_6.Find(var_5_13, "scroll_name/Text")
	local var_5_15 = arg_5_0.showIllustration

	var_5_7(var_5_12, var_5_14, var_7.GetName(var_5_15), 11)

	local var_5_16

	if not var_5_8 or not var_5_8:GetBreakLevel() then
		var_5_16 = 0
	end

	local var_5_17 = arg_5_0.starList

	var_5.make(var_5_17, function(arg_6_0, arg_6_1, arg_6_2)
		UIItemList = var_2_10003

		if arg_6_0 == var_2_10003.EventUpdate then
			local var_6_0 = arg_6_1 + 1

			setActive = var_2_10004

			var_2_10004(arg_6_2:Find("Image"), var_6_0 <= var_5_16)
		end

		return
	end)

	local var_5_18 = arg_5_0.starList

	var_5.align(var_5_18, arg_5_0:GetShipBreakMaxLevel(var_5_4))

	return
end

function var_0_1.GetShipBreakMaxLevel(arg_7_0, arg_7_1)
	pg = var_1_10002

	return var_1_10002.island_chara_template[arg_7_1].upgrade_level[2] + 1
end

return var_0_1

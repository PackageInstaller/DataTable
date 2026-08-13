class = var_0_10000

local var_0_0 = "IslandAwardDisplay4ShipBreakWindow"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "IslandAwardDisplay4ShipBreakUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "frame/Board/Top/text/text")

	arg_2_0.title = var_1.GetComponent(var_2_1, "Text")
	UIItemList = var_1

	local var_2_2 = var_1.New
	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_2.Find(var_2_3, "frame/bg/starts")
	local var_2_5 = arg_2_0._tf

	arg_2_0.uiNewStart = var_2_2(var_2_4, var_3.Find(var_2_5, "frame/bg/starts/tpl"))

	local var_2_6 = arg_2_0._tf
	local var_2_7 = var_1.Find(var_2_6, "frame/bg/item/level/Text_1")

	arg_2_0.oldLevelTxt = var_1.GetComponent(var_2_7, "Text")

	local var_2_8 = arg_2_0._tf
	local var_2_9 = var_1.Find(var_2_8, "frame/bg/item/level/Text_2")

	arg_2_0.newLevelTxt = var_1.GetComponent(var_2_9, "Text")

	local var_2_10 = arg_2_0._tf
	local var_2_11 = var_1.Find(var_2_10, "frame/bg/item/energy/Text_1")

	arg_2_0.oldEnergyTxt = var_1.GetComponent(var_2_11, "Text")

	local var_2_12 = arg_2_0._tf
	local var_2_13 = var_1.Find(var_2_12, "frame/bg/item/energy/Text_2")

	arg_2_0.newEnergyTxt = var_1.GetComponent(var_2_13, "Text")
	setText = var_1

	local var_2_14 = arg_2_0._tf
	local var_2_15 = var_2.Find(var_2_14, "frame/bg/item/energy/Text")

	i18n = var_2_14

	var_1(var_2_15, var_2_14("island_ship_level_limit"))

	setText = var_1

	local var_2_16 = arg_2_0._tf
	local var_2_17 = var_2.Find(var_2_16, "frame/bg/item/level/Text")

	i18n = var_2_16

	var_1(var_2_17, var_2_16("island_ship_energy_limit"))

	setText = var_1

	local var_2_18 = arg_2_0._tf
	local var_2_19 = var_2.Find(var_2_18, "frame/tip")

	i18n = var_2_18

	var_1(var_2_19, var_2_18("island_click_close"))

	local var_2_20 = arg_2_0._tf

	arg_2_0.frameTr = var_1.Find(var_2_20, "frame")

	local var_2_21 = arg_2_0.frameTr
	local var_2_22 = var_1.GetComponent

	typeof = var_3
	Animation = var_4
	arg_2_0.animator = var_2_22(var_2_21, var_3(var_4))

	local var_2_23 = arg_2_0.frameTr
	local var_2_24 = var_1.GetComponent

	typeof = var_3
	DftAniEvent = var_4
	arg_2_0.aniDft = var_2_24(var_2_23, var_3(var_4))

	return
end

function var_0_1.Show(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0.title

	i18n = var_1_10003
	var_3_0.text = var_1_10003("island_break_finish")

	local var_3_1 = arg_3_1.oldShip
	local var_3_2 = arg_3_1.newShip

	arg_3_0:UpdateBreakLevel(var_3_1, var_3_2)
	arg_3_0:UpdateLevel(var_3_1, var_3_2)
	arg_3_0:UpdateEnergy(var_3_1, var_3_2)

	return
end

function var_0_1.PlayExitAniamtion(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0.aniDft

	var_2.SetEndEvent(var_4_0, function()
		local var_5_0 = arg_4_0.aniDft

		var_0.SetEndEvent(var_5_0, nil)
		arg_4_1()

		return
	end)

	local var_4_1 = arg_4_0.animator

	var_2.Play(var_4_1, "anim_Island_commonget_single_out")

	return
end

function var_0_1.UpdateBreakLevel(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_2:GetBreakMaxLevel()
	local var_6_1 = arg_6_0.uiNewStart

	var_4.make(var_6_1, function(arg_7_0, arg_7_1, arg_7_2)
		UIItemList = var_2_10003

		if arg_7_0 == var_2_10003.EventUpdate then
			setActive = var_3

			local var_7_0 = arg_7_2:Find("Image")
			local var_7_1 = arg_6_2

			var_3(var_7_0, arg_7_1 < var_5.GetBreakLevel(var_7_1))
		end

		return
	end)

	local var_6_2 = arg_6_0.uiNewStart

	var_4.align(var_6_2, var_6_0)

	return
end

function var_0_1.UpdateLevel(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.oldLevelTxt.text = "Lv." .. arg_8_1:GetMaxLevel()
	arg_8_0.newLevelTxt.text = "Lv." .. arg_8_2:GetMaxLevel()

	return
end

function var_0_1.UpdateEnergy(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.oldEnergyTxt.text = arg_9_1:GetMaxEnergy()
	arg_9_0.newEnergyTxt.text = arg_9_2:GetMaxEnergy()

	return
end

function var_0_1.OnDestroy(arg_10_0)
	local var_10_0 = arg_10_0.aniDft

	var_1.SetEndEvent(var_10_0, nil)

	return
end

return var_0_1

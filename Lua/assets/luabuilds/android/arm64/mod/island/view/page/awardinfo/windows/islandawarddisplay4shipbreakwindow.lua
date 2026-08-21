local var_0_0 = class("IslandAwardDisplay4ShipBreakWindow", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "IslandAwardDisplay4ShipBreakUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.title = arg_2_0._tf:Find("frame/Board/Top/text/text"):GetComponent("Text")
	arg_2_0.uiNewStart = UIItemList.New(arg_2_0._tf:Find("frame/bg/starts"), arg_2_0._tf:Find("frame/bg/starts/tpl"))
	arg_2_0.oldLevelTxt = arg_2_0._tf:Find("frame/bg/item/level/Text_1"):GetComponent("Text")
	arg_2_0.newLevelTxt = arg_2_0._tf:Find("frame/bg/item/level/Text_2"):GetComponent("Text")
	arg_2_0.oldEnergyTxt = arg_2_0._tf:Find("frame/bg/item/energy/Text_1"):GetComponent("Text")
	arg_2_0.newEnergyTxt = arg_2_0._tf:Find("frame/bg/item/energy/Text_2"):GetComponent("Text")

	setText(arg_2_0._tf:Find("frame/bg/item/energy/Text"), i18n("island_ship_level_limit"))
	setText(arg_2_0._tf:Find("frame/bg/item/level/Text"), i18n("island_ship_energy_limit"))
	setText(arg_2_0._tf:Find("frame/tip"), i18n("island_click_close"))

	arg_2_0.frameTr = arg_2_0._tf:Find("frame")
	arg_2_0.animator = arg_2_0.frameTr:GetComponent(typeof(Animation))
	arg_2_0.aniDft = arg_2_0.frameTr:GetComponent(typeof(DftAniEvent))

	return
end

function var_0_0.Show(arg_3_0, arg_3_1)
	arg_3_0.title.text = i18n("island_break_finish")

	arg_3_0:UpdateBreakLevel(arg_3_1.oldShip, arg_3_1.newShip)
	arg_3_0:UpdateLevel(arg_3_1.oldShip, arg_3_1.newShip)
	arg_3_0:UpdateEnergy(arg_3_1.oldShip, arg_3_1.newShip)

	return
end

function var_0_0.PlayExitAniamtion(arg_4_0, arg_4_1)
	arg_4_0.aniDft:SetEndEvent(function()
		arg_4_0.aniDft:SetEndEvent(nil)
		arg_4_1()

		return
	end)
	arg_4_0.animator:Play("anim_Island_commonget_single_out")

	return
end

function var_0_0.UpdateBreakLevel(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.uiNewStart:make(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventUpdate then
			setActive(arg_7_2:Find("Image"), arg_7_1 < arg_6_2:GetBreakLevel())
		end

		return
	end)
	arg_6_0.uiNewStart:align((arg_6_2:GetBreakMaxLevel()))

	return
end

function var_0_0.UpdateLevel(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.oldLevelTxt.text = "Lv." .. arg_8_1:GetMaxLevel()
	arg_8_0.newLevelTxt.text = "Lv." .. arg_8_2:GetMaxLevel()

	return
end

function var_0_0.UpdateEnergy(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.oldEnergyTxt.text = arg_9_1:GetMaxEnergy()
	arg_9_0.newEnergyTxt.text = arg_9_2:GetMaxEnergy()

	return
end

function var_0_0.OnDestroy(arg_10_0)
	arg_10_0.aniDft:SetEndEvent(nil)

	return
end

return var_0_0

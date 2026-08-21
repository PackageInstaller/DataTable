local var_0_0 = class("IslandInventoryUpgradePage", import("...base.IslandBasePage"))

function var_0_0.getUIName(arg_1_0)
	return "IslandInventoryUpgradeUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.consumeList = UIItemList.New(arg_2_0._tf:Find("frame/bottom/consume/list"), arg_2_0._tf:Find("frame/bottom/consume/list/tpl"))
	arg_2_0.maxLevelTip = arg_2_0._tf:Find("frame/bottom/bg/max_level")
	arg_2_0.capacityTxt = arg_2_0._tf:Find("frame/bottom/capacity/Text"):GetComponent(typeof(Text))
	arg_2_0.confirmBtn = arg_2_0._tf:Find("frame/confirm")
	arg_2_0.levelTxt = arg_2_0._tf:Find("frame/top/level"):GetComponent(typeof(Text))
	arg_2_0.nextLevelTxt = arg_2_0._tf:Find("frame/top/level/next"):GetComponent(typeof(Text))
	arg_2_0.maxLevelTxt = arg_2_0._tf:Find("frame/top/max_level"):GetComponent(typeof(Text))
	arg_2_0.closeBtn = arg_2_0._tf:Find("frame/top/close")

	setText(arg_2_0._tf:Find("frame/top/title"), i18n("island_bag_upgrade_tip"))
	setText(arg_2_0._tf:Find("frame/bottom/Text"), i18n("island_bag_upgrade_req"))
	setText(arg_2_0._tf:Find("frame/bottom/bg/max_level"), i18n("island_bag_upgrade_max_level"))
	setText(arg_2_0._tf:Find("frame/bottom/capacity/label"), i18n("island_bag_upgrade_capacity"))

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0._tf, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.closeBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.confirmBtn, function()
		if not getProxy(IslandProxy):GetIsland():GetInventoryAgency():CanUpgrade() then
			return
		end

		arg_3_0:emit(IslandMediator.ON_UPGRADE_INVENTORY)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Show(arg_7_0)
	var_0_0.super.Show(arg_7_0)

	local var_7_0 = getProxy(IslandProxy):GetIsland()

	arg_7_0:UpdateConsume(var_7_0)
	arg_7_0:UpdateAddition(var_7_0)
	arg_7_0:UpdateStyle(var_7_0)

	return
end

function var_0_0.UpdateStyle(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1:GetInventoryAgency()
	local var_8_1 = var_8_0:IsMaxLevel()

	setActive(arg_8_0.confirmBtn, not var_8_1)
	setActive(arg_8_0.maxLevelTxt.gameObject, var_8_1)
	setActive(arg_8_0.levelTxt.gameObject, not var_8_1)

	if var_8_1 then
		arg_8_0.maxLevelTxt.text = "Lv." .. var_8_0:GetLevel()
	end

	setActive(arg_8_0.maxLevelTip, var_8_1)
	setGray(arg_8_0.confirmBtn, not var_8_0:CanUpgrade(), true)

	return
end

function var_0_0.UpdateAddition(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1:GetInventoryAgency()
	local var_9_1 = var_9_0:GetCapacity()
	local var_9_2 = var_9_0:GetLevel()

	arg_9_0.capacityTxt.text = "<color=#393a3c>" .. var_9_1 .. "</color><color=#39bfff> + " .. var_9_0:GetNextCapacity(var_9_2 + 1) - var_9_1 .. "</color>"
	arg_9_0.levelTxt.text = "Lv." .. var_9_2
	arg_9_0.nextLevelTxt.text = "Lv." .. var_9_2 + 1

	return
end

function var_0_0.UpdateConsume(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1:GetInventoryAgency():GetUpgradeConsume()

	arg_10_0.consumeList:make(function(arg_11_0, arg_11_1, arg_11_2)
		if arg_11_0 == UIItemList.EventUpdate then
			local var_11_0 = Drop.Create(var_10_0[arg_11_1 + 1])

			updateCustomDrop(arg_11_2, var_11_0)

			local var_11_1 = var_11_0:getOwnedCount()
			local var_11_3 = var_11_1

			if var_11_1 >= var_11_0.count then
				local var_11_4 = COLOR_GREEN or COLOR_RED

				setText(arg_11_2:Find("icon_bg/count_bg/count"), var_11_2(var_11_3, var_11_4) .. "/" .. var_11_0.count)

				return
			end
		end
	end)
	arg_10_0.consumeList:align(#arg_10_1:GetInventoryAgency():GetUpgradeConsume())

	return
end

function var_0_0.OnDestroy(arg_12_0)
	return
end

return var_0_0

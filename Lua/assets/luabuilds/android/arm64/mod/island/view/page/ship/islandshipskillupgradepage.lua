local var_0_0 = class("IslandShipSkillUpgradePage", import("...base.IslandBasePage"))

function var_0_0.getUIName(arg_1_0)
	return "IslandShipSkillUpgradeUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.upgradeBtn = arg_2_0._tf:Find("btn_confirm")
	arg_2_0.closeBtn = arg_2_0._tf:Find("frame_1/close")
	arg_2_0.titleTxt = arg_2_0._tf:Find("frame_1/title"):GetComponent(typeof(Text))
	arg_2_0.levelTxt = arg_2_0._tf:Find("frame_1/level"):GetComponent(typeof(Text))
	arg_2_0.nextLevelTxt = arg_2_0._tf:Find("frame_1/next_level"):GetComponent(typeof(Text))
	arg_2_0.descTxt = arg_2_0._tf:Find("frame_2/desc_bg/Text"):GetComponent(typeof(Text))
	arg_2_0.nextDescTxt = arg_2_0._tf:Find("frame_2/desc_bg_1/Text"):GetComponent(typeof(Text))
	arg_2_0.uiItemList = UIItemList.New(arg_2_0._tf:Find("frame_2/item_bg/items"), arg_2_0._tf:Find("frame_2/item_bg/items/tpl"))

	setText(arg_2_0._tf:Find("frame_2/sub_title/Text"), i18n("island_skill_consume_title"))
	setText(arg_2_0.upgradeBtn:Find("Text"), i18n("island_chara_up_button"))

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
	onButton(arg_3_0, arg_3_0.upgradeBtn, function()
		if not arg_3_0.ship:CanUpgradeSkill() then
			return
		end

		arg_3_0:emit(IslandMediator.SHIP_SKILL_UPGRADE, arg_3_0.ship.id)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddListener(GAME.ISLAND_SHIP_SKILL_UPGRADE_DONE, arg_7_0.OnSkillUpgrade)

	return
end

function var_0_0.RemoveListeners(arg_8_0)
	arg_8_0:RemoveListener(GAME.ISLAND_SHIP_SKILL_UPGRADE_DONE, arg_8_0.OnSkillUpgrade)

	return
end

function var_0_0.OnSkillUpgrade(arg_9_0)
	arg_9_0:Hide()

	return
end

function var_0_0.OnShow(arg_10_0, arg_10_1)
	arg_10_0.ship = arg_10_1

	local var_10_0 = arg_10_1:GetSkill()
	local var_10_1 = Clone(var_10_0)

	var_10_1:Upgrade()
	arg_10_0:UpdateMain(var_10_0, var_10_1)
	arg_10_0:BlurPanel(arg_10_0._tf)

	return
end

function var_0_0.UpdateMain(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0.titleTxt.text = arg_11_1:GetName()
	arg_11_0.levelTxt.text = "Lv." .. arg_11_1:GetLevel()
	arg_11_0.nextLevelTxt.text = "Lv." .. arg_11_2:GetLevel()
	arg_11_0.descTxt.text = arg_11_1:GetEffectDesc()
	arg_11_0.nextDescTxt.text = arg_11_2:GetEffectDesc()

	arg_11_0:UpdateConsume(arg_11_1)
	setGray(arg_11_0.upgradeBtn, not arg_11_0.ship:CanUpgradeSkill(), true)

	return
end

function var_0_0.UpdateConsume(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1:GetUpgradeMaterial()
	local var_12_1 = getProxy(IslandProxy):GetIsland():GetInventoryAgency()

	arg_12_0.uiItemList:make(function(arg_13_0, arg_13_1, arg_13_2)
		if arg_13_0 == UIItemList.EventUpdate then
			local var_13_0 = var_12_0[arg_13_1 + 1]

			updateCustomDrop(arg_13_2, var_12_0[arg_13_1 + 1])

			local var_13_1 = var_12_1:GetOwnCount(var_13_0.id)
			local var_13_3 = var_13_1

			if var_13_1 >= var_13_0.count then
				local var_13_4 = COLOR_GREEN or COLOR_RED

				setText(arg_13_2:Find("icon_bg/count_bg/count"), var_13_2(var_13_3, var_13_4) .. "/" .. var_13_0.count)

				return
			end
		end
	end)
	arg_12_0.uiItemList:align(#arg_12_1:GetUpgradeMaterial())

	return
end

function var_0_0.OnHide(arg_14_0)
	arg_14_0:UnBlurPanel()

	arg_14_0.selected = {}

	return
end

function var_0_0.OnDestroy(arg_15_0)
	arg_15_0:OnHide()

	return
end

return var_0_0

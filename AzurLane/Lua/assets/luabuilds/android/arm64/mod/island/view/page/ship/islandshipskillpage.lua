local var_0_0 = class("IslandShipSkillPage", import("...base.IslandBasePage"))

function var_0_0.getUIName(arg_1_0)
	return "IslandShipSkillUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.skillIcon = arg_2_0._tf:Find("adapt/attr_panel/skill/icon")
	arg_2_0.skillName = arg_2_0._tf:Find("adapt/attr_panel/skill/name"):GetComponent(typeof(Text))
	arg_2_0.skillLv = arg_2_0._tf:Find("adapt/attr_panel/skill/level"):GetComponent(typeof(Text))
	arg_2_0.descTxt = arg_2_0._tf:Find("adapt/attr_panel/desc/Text"):GetComponent(typeof(Text))
	arg_2_0.descList = UIItemList.New(arg_2_0._tf:Find("adapt/attr_panel/desc/list"), arg_2_0._tf:Find("adapt/attr_panel/desc/list/tpl"))
	arg_2_0.consumeList = UIItemList.New(arg_2_0._tf:Find("adapt/attr_panel/consume/list"), arg_2_0._tf:Find("adapt/attr_panel/consume/list/tpl"))
	arg_2_0.upgradeBtn = arg_2_0._tf:Find("adapt/attr_panel/consume/upgrade")
	arg_2_0.tipTxt = arg_2_0._tf:Find("adapt/attr_panel/consume/tip"):GetComponent(typeof(Text))
	arg_2_0.goldTr = arg_2_0._tf:Find("adapt/attr_panel/consume/label")
	arg_2_0.goldTxt = arg_2_0._tf:Find("adapt/attr_panel/consume/label/Text"):GetComponent(typeof(Text))
	arg_2_0.goldIco = arg_2_0._tf:Find("adapt/attr_panel/consume/label/icon")

	setText(arg_2_0._tf:Find("adapt/attr_panel/consume/label/label1"), i18n("island_ship_breakout_consume"))

	return
end

function var_0_0.OnInit(arg_3_0)
	return
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddListener(GAME.ISLAND_UPGRADE_SKILL_DONE, arg_4_0.OnSkillUpgrade)

	return
end

function var_0_0.RemoveListeners(arg_5_0)
	arg_5_0:RemoveListener(GAME.ISLAND_UPGRADE_SKILL_DONE, arg_5_0.OnSkillUpgrade)

	return
end

function var_0_0.OnSkillUpgrade(arg_6_0)
	arg_6_0:Flush()

	return
end

function var_0_0.OnShow(arg_7_0, arg_7_1)
	arg_7_0.selectedId = arg_7_1

	arg_7_0:Flush()

	return
end

function var_0_0.Flush(arg_8_0)
	local var_8_0 = getProxy(IslandProxy):GetIsland():GetCharacterAgency():GetShipById(arg_8_0.selectedId)

	if var_8_0 == nil then
		return
	end

	arg_8_0:UpdateMainView(var_8_0)

	return
end

function var_0_0.UpdateMainView(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1:GetMainSkill()
	local var_9_1 = arg_9_1:GetNextLevelMainSkillId()

	arg_9_0:FlushLevelAndIcon(arg_9_1, var_9_0, var_9_1)
	arg_9_0:FlushDesc(arg_9_1, var_9_0, var_9_1)
	arg_9_0:FlushConsume(arg_9_1, var_9_0, var_9_1)
	arg_9_0:FlushUpgradeBtn(arg_9_1, var_9_0, var_9_1)

	return
end

function var_0_0.FlushLevelAndIcon(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	GetImageSpriteFromAtlasAsync("island/IslandSkillIcon/" .. pg.island_chara_skill[arg_10_2].icon, "", arg_10_0.skillIcon)

	arg_10_0.skillName.text = pg.island_chara_skill[arg_10_2].name
	arg_10_0.skillLv.text = arg_10_3 and "<color=#393a3c>[ Lv." .. pg.island_chara_skill[arg_10_2].level .. " ]</color><color=#006cff>   >   [ Lv." .. pg.island_chara_skill[arg_10_2].level + 1 .. " ]</color>" or "<color=#393a3c>MAX</color>"

	return
end

function var_0_0.FlushDesc(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = arg_11_1:GetMainSkillUpgradeEffectDesc()

	arg_11_0.descList:make(function(arg_12_0, arg_12_1, arg_12_2)
		if arg_12_0 == UIItemList.EventUpdate then
			local var_12_0 = var_11_0[arg_12_1 + 1].level
			local var_12_1 = var_11_0[arg_12_1 + 1].desc
			local var_12_2 = pg.island_chara_skill[arg_11_2].level
			local var_12_3 = pg.island_chara_skill[arg_11_2].level + 1 == var_11_0[arg_12_1 + 1].level and "#006cff" or "#393a3c"

			setText(arg_12_2:Find("level"), "<color=" .. (pg.island_chara_skill[arg_11_2].level + 1 == var_11_0[arg_12_1 + 1].level and "#006cff" or "#393a3c") .. ">[ Lv." .. var_11_0[arg_12_1 + 1].level .. " ]</color>")
			setText(arg_12_2:Find("Text"), "<color=" .. var_12_3 .. ">" .. i18n("island_word_unlock") .. var_12_1 .. "</color>")

			GetOrAddComponent(arg_12_2, typeof(CanvasGroup)).alpha = var_12_0 <= var_12_2 + 1 and 1 or 0.4
		end

		return
	end)
	arg_11_0.descList:align(#arg_11_1:GetMainSkillUpgradeEffectDesc())

	arg_11_0.descTxt.text = arg_11_3 and pg.island_chara_skill[arg_11_3].desc or pg.island_chara_skill[arg_11_2].desc

	return
end

function var_0_0.FlushConsume(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = arg_13_1:GetUpgradeSkillConsume()
	local var_13_1 = getProxy(IslandProxy):GetIsland():GetInventoryAgency()

	arg_13_0.consumeList:make(function(arg_14_0, arg_14_1, arg_14_2)
		if arg_14_0 == UIItemList.EventUpdate then
			local var_14_0 = Drop.New({
				type = var_13_0[arg_14_1 + 2][1],
				id = var_13_0[arg_14_1 + 2][2],
				count = var_13_0[arg_14_1 + 2][3]
			})

			updateCustomDrop(arg_14_2, var_14_0)

			local var_14_1 = var_13_1:GetOwnCount(var_14_0.id)

			setText(arg_14_2:Find("icon_bg/count"), setColorStr(var_14_1, var_14_1 >= var_14_0.count and "#FFFFFF" or "#ff7e7e") .. "/" .. var_14_0.count)
			onButton(arg_13_0, arg_14_2, function()
				arg_13_0:ShowMsgBox({
					title = i18n("island_word_ship_buff_desc"),
					type = IslandMsgBox.TYPE_ITEM_DESC,
					itemId = var_14_0.id
				})

				return
			end, SFX_PANEL)
		end

		return
	end)
	arg_13_0.consumeList:align(math.max(0, #arg_13_1:GetUpgradeSkillConsume() - 1))

	return
end

function var_0_0.FlushUpgradeBtn(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = arg_16_1:GetUpgradeSkillConsume()
	local var_16_1 = arg_16_0.upgradeBtn:GetComponent(typeof(Image))

	var_16_1.color = arg_16_1:CanUpgradeMainSkill() and Color.New(0.2235294, 0.7490196, 1, 1) or Color.New(0.6117647, 0.6117647, 0.6117647, 1)

	local var_16_2 = true

	if arg_16_3 then
		local var_16_3 = pg.island_chara_skill[arg_16_3].upgrade_unlock

		var_16_2 = pg.island_chara_skill[arg_16_3].upgrade_unlock <= arg_16_1:GetLevel()
		arg_16_0.tipTxt.text = i18n("island_need_ship_level", var_16_3)
	end

	local var_16_4 = var_16_0[1]

	if var_16_0[1] then
		local var_16_5 = Drop.New({
			type = var_16_4[1],
			id = var_16_4[2],
			count = var_16_4[3]
		})

		GetImageSpriteFromAtlasAsync(var_16_5:getConfigTable().icon, "", arg_16_0.goldIco)

		arg_16_0.goldTxt.text = var_16_5.count
	end

	setActive(arg_16_0.tipTxt.gameObject, not var_16_2)
	setActive(arg_16_0.goldTr, var_16_2 and var_16_4)
	setActive(arg_16_0.upgradeBtn, not arg_16_1:IsMaxMainSkillLevel())
	onButton(arg_16_0, arg_16_0.upgradeBtn, function()
		if not var_0 then
			return
		end

		arg_16_0:emit(IslandMediator.UPGRADE_SKILL, arg_16_1.id)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnDestroy(arg_18_0)
	return
end

return var_0_0

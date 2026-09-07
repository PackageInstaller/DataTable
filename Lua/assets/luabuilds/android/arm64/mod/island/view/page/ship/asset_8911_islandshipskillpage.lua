local IslandShipSkillPage = class("IslandShipSkillPage", import("...base.IslandBasePage"))

function IslandShipSkillPage:getUIName()
	return "IslandShipSkillUI"
end

function IslandShipSkillPage:OnLoaded()
	self.skillIcon = self._tf:Find("adapt/attr_panel/skill/icon")
	self.skillName = self._tf:Find("adapt/attr_panel/skill/name"):GetComponent(typeof(Text))
	self.skillLv = self._tf:Find("adapt/attr_panel/skill/level"):GetComponent(typeof(Text))
	self.descTxt = self._tf:Find("adapt/attr_panel/desc/Text"):GetComponent(typeof(Text))
	self.descList = UIItemList.New(self._tf:Find("adapt/attr_panel/desc/list"), self._tf:Find("adapt/attr_panel/desc/list/tpl"))
	self.consumeList = UIItemList.New(self._tf:Find("adapt/attr_panel/consume/list"), self._tf:Find("adapt/attr_panel/consume/list/tpl"))
	self.upgradeBtn = self._tf:Find("adapt/attr_panel/consume/upgrade")
	self.tipTxt = self._tf:Find("adapt/attr_panel/consume/tip"):GetComponent(typeof(Text))
	self.goldTr = self._tf:Find("adapt/attr_panel/consume/label")
	self.goldTxt = self._tf:Find("adapt/attr_panel/consume/label/Text"):GetComponent(typeof(Text))
	self.goldIco = self._tf:Find("adapt/attr_panel/consume/label/icon")

	setText(self._tf:Find("adapt/attr_panel/consume/label/label1"), i18n("island_ship_breakout_consume"))

	return
end

function IslandShipSkillPage:OnInit()
	return
end

function IslandShipSkillPage:AddListeners()
	self:AddListener(GAME.ISLAND_UPGRADE_SKILL_DONE, self.OnSkillUpgrade)

	return
end

function IslandShipSkillPage:RemoveListeners()
	self:RemoveListener(GAME.ISLAND_UPGRADE_SKILL_DONE, self.OnSkillUpgrade)

	return
end

function IslandShipSkillPage:OnSkillUpgrade()
	self:Flush()

	return
end

function IslandShipSkillPage:OnShow(arg_7_1)
	self.selectedId = arg_7_1

	self:Flush()

	return
end

function IslandShipSkillPage:Flush()
	local var_8_0 = getProxy(IslandProxy):GetIsland():GetCharacterAgency():GetShipById(self.selectedId)

	if var_8_0 == nil then
		return
	end

	self:UpdateMainView(var_8_0)

	return
end

function IslandShipSkillPage:UpdateMainView(arg_9_1)
	local var_9_0 = arg_9_1:GetMainSkill()
	local var_9_1 = arg_9_1:GetNextLevelMainSkillId()

	self:FlushLevelAndIcon(arg_9_1, var_9_0, var_9_1)
	self:FlushDesc(arg_9_1, var_9_0, var_9_1)
	self:FlushConsume(arg_9_1, var_9_0, var_9_1)
	self:FlushUpgradeBtn(arg_9_1, var_9_0, var_9_1)

	return
end

function IslandShipSkillPage:FlushLevelAndIcon(arg_10_1, arg_10_2, arg_10_3)
	GetImageSpriteFromAtlasAsync("island/IslandSkillIcon/" .. pg.island_chara_skill[arg_10_2].icon, "", self.skillIcon)

	self.skillName.text = pg.island_chara_skill[arg_10_2].name
	self.skillLv.text = arg_10_3 and "<color=#393a3c>[ Lv." .. pg.island_chara_skill[arg_10_2].level .. " ]</color><color=#006cff>   >   [ Lv." .. pg.island_chara_skill[arg_10_2].level + 1 .. " ]</color>" or "<color=#393a3c>MAX</color>"

	return
end

function IslandShipSkillPage:FlushDesc(arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = arg_11_1:GetMainSkillUpgradeEffectDesc()

	self.descList:make(function(arg_12_0, arg_12_1, arg_12_2)
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
	self.descList:align(#var_11_0)

	self.descTxt.text = arg_11_3 and pg.island_chara_skill[arg_11_3].desc or pg.island_chara_skill[arg_11_2].desc

	return
end

function IslandShipSkillPage:FlushConsume(arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = arg_13_1:GetUpgradeSkillConsume()
	local var_13_1 = getProxy(IslandProxy):GetIsland():GetInventoryAgency()

	self.consumeList:make(function(arg_14_0, arg_14_1, arg_14_2)
		if arg_14_0 == UIItemList.EventUpdate then
			local var_14_0 = Drop.New({
				type = var_13_0[arg_14_1 + 2][1],
				id = var_13_0[arg_14_1 + 2][2],
				count = var_13_0[arg_14_1 + 2][3]
			})

			updateCustomDrop(arg_14_2, var_14_0)

			local var_14_1 = var_13_1:GetOwnCount(var_14_0.id)

			setText(arg_14_2:Find("icon_bg/count"), setColorStr(var_14_1, var_14_1 >= var_14_0.count and "#FFFFFF" or "#ff7e7e") .. "/" .. var_14_0.count)
			onButton(self, arg_14_2, function()
				self:ShowMsgBox({
					title = i18n("island_word_ship_buff_desc"),
					type = IslandMsgBox.TYPE_ITEM_DESC,
					itemId = var_14_0.id
				})

				return
			end, SFX_PANEL)
		end

		return
	end)
	self.consumeList:align(math.max(0, #var_13_0 - 1))

	return
end

function IslandShipSkillPage:FlushUpgradeBtn(arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = arg_16_1:GetUpgradeSkillConsume()
	local var_16_1 = arg_16_1:CanUpgradeMainSkill()

	self.upgradeBtn:GetComponent(typeof(Image)).color = var_16_1 and Color.New(0.2235294, 0.7490196, 1, 1) or Color.New(0.6117647, 0.6117647, 0.6117647, 1)

	local var_16_3 = true

	if arg_16_3 then
		local var_16_4 = pg.island_chara_skill[arg_16_3].upgrade_unlock

		var_16_3 = pg.island_chara_skill[arg_16_3].upgrade_unlock <= arg_16_1:GetLevel()
		self.tipTxt.text = i18n("island_need_ship_level", var_16_4)
	end

	local var_16_5 = var_16_0[1]

	if var_16_0[1] then
		local var_16_6 = Drop.New({
			type = var_16_5[1],
			id = var_16_5[2],
			count = var_16_5[3]
		})

		GetImageSpriteFromAtlasAsync(var_16_6:getConfigTable().icon, "", self.goldIco)

		self.goldTxt.text = var_16_6.count
	end

	setActive(self.tipTxt.gameObject, not var_16_3)
	setActive(self.goldTr, var_16_3 and var_16_5)
	setActive(self.upgradeBtn, not arg_16_1:IsMaxMainSkillLevel())
	onButton(self, self.upgradeBtn, function()
		if not var_16_1 then
			return
		end

		self:emit(IslandMediator.UPGRADE_SKILL, arg_16_1.id)

		return
	end, SFX_PANEL)

	return
end

function IslandShipSkillPage:OnDestroy()
	return
end

return IslandShipSkillPage

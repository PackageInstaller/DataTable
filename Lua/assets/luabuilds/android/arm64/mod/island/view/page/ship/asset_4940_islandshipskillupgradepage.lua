local IslandShipSkillUpgradePage = class("IslandShipSkillUpgradePage", import("...base.IslandBasePage"))

function IslandShipSkillUpgradePage:getUIName()
	return "IslandShipSkillUpgradeUI"
end

function IslandShipSkillUpgradePage:OnLoaded()
	self.upgradeBtn = self._tf:Find("btn_confirm")
	self.closeBtn = self._tf:Find("frame_1/close")
	self.titleTxt = self._tf:Find("frame_1/title"):GetComponent(typeof(Text))
	self.levelTxt = self._tf:Find("frame_1/level"):GetComponent(typeof(Text))
	self.nextLevelTxt = self._tf:Find("frame_1/next_level"):GetComponent(typeof(Text))
	self.descTxt = self._tf:Find("frame_2/desc_bg/Text"):GetComponent(typeof(Text))
	self.nextDescTxt = self._tf:Find("frame_2/desc_bg_1/Text"):GetComponent(typeof(Text))
	self.uiItemList = UIItemList.New(self._tf:Find("frame_2/item_bg/items"), self._tf:Find("frame_2/item_bg/items/tpl"))

	setText(self._tf:Find("frame_2/sub_title/Text"), i18n("island_skill_consume_title"))
	setText(self.upgradeBtn:Find("Text"), i18n("island_chara_up_button"))

	return
end

function IslandShipSkillUpgradePage:OnInit()
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.upgradeBtn, function()
		if not self.ship:CanUpgradeSkill() then
			return
		end

		self:emit(IslandMediator.SHIP_SKILL_UPGRADE, self.ship.id)

		return
	end, SFX_PANEL)

	return
end

function IslandShipSkillUpgradePage:AddListeners()
	self:AddListener(GAME.ISLAND_SHIP_SKILL_UPGRADE_DONE, self.OnSkillUpgrade)

	return
end

function IslandShipSkillUpgradePage:RemoveListeners()
	self:RemoveListener(GAME.ISLAND_SHIP_SKILL_UPGRADE_DONE, self.OnSkillUpgrade)

	return
end

function IslandShipSkillUpgradePage:OnSkillUpgrade()
	self:Hide()

	return
end

function IslandShipSkillUpgradePage:OnShow(arg_10_1)
	self.ship = arg_10_1

	local var_10_0 = arg_10_1:GetSkill()
	local var_10_1 = Clone(var_10_0)

	var_10_1:Upgrade()
	self:UpdateMain(var_10_0, var_10_1)
	self:BlurPanel(self._tf)

	return
end

function IslandShipSkillUpgradePage:UpdateMain(arg_11_1, arg_11_2)
	self.titleTxt.text = arg_11_1:GetName()
	self.levelTxt.text = "Lv." .. arg_11_1:GetLevel()
	self.nextLevelTxt.text = "Lv." .. arg_11_2:GetLevel()
	self.descTxt.text = arg_11_1:GetEffectDesc()
	self.nextDescTxt.text = arg_11_2:GetEffectDesc()

	self:UpdateConsume(arg_11_1)
	setGray(self.upgradeBtn, not self.ship:CanUpgradeSkill(), true)

	return
end

function IslandShipSkillUpgradePage:UpdateConsume(arg_12_1)
	local var_12_0 = arg_12_1:GetUpgradeMaterial()
	local var_12_1 = getProxy(IslandProxy):GetIsland():GetInventoryAgency()

	self.uiItemList:make(function(arg_13_0, arg_13_1, arg_13_2)
		if arg_13_0 == UIItemList.EventUpdate then
			local var_13_0 = var_12_0[arg_13_1 + 1]

			updateCustomDrop(arg_13_2, var_12_0[arg_13_1 + 1])

			local var_13_1 = var_12_1:GetOwnCount(var_13_0.id)

			setText(arg_13_2:Find("icon_bg/count_bg/count"), setColorStr(var_13_1, (var_13_1 >= var_13_0.count or nil) and (COLOR_GREEN or COLOR_RED)) .. "/" .. var_13_0.count)
		end

		return
	end)
	self.uiItemList:align(#var_12_0)

	return
end

function IslandShipSkillUpgradePage:OnHide()
	self:UnBlurPanel()

	self.selected = {}

	return
end

function IslandShipSkillUpgradePage:OnDestroy()
	self:OnHide()

	return
end

return IslandShipSkillUpgradePage

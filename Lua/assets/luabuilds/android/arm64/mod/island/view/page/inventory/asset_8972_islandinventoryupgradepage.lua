local IslandInventoryUpgradePage = class("IslandInventoryUpgradePage", import("...base.IslandBasePage"))

function IslandInventoryUpgradePage:getUIName()
	return "IslandInventoryUpgradeUI"
end

function IslandInventoryUpgradePage:OnLoaded()
	self.consumeList = UIItemList.New(self._tf:Find("frame/bottom/consume/list"), self._tf:Find("frame/bottom/consume/list/tpl"))
	self.maxLevelTip = self._tf:Find("frame/bottom/bg/max_level")
	self.capacityTxt = self._tf:Find("frame/bottom/capacity/Text"):GetComponent(typeof(Text))
	self.confirmBtn = self._tf:Find("frame/confirm")
	self.levelTxt = self._tf:Find("frame/top/level"):GetComponent(typeof(Text))
	self.nextLevelTxt = self._tf:Find("frame/top/level/next"):GetComponent(typeof(Text))
	self.maxLevelTxt = self._tf:Find("frame/top/max_level"):GetComponent(typeof(Text))
	self.closeBtn = self._tf:Find("frame/top/close")

	setText(self._tf:Find("frame/top/title"), i18n("island_bag_upgrade_tip"))
	setText(self._tf:Find("frame/bottom/Text"), i18n("island_bag_upgrade_req"))
	setText(self._tf:Find("frame/bottom/bg/max_level"), i18n("island_bag_upgrade_max_level"))
	setText(self._tf:Find("frame/bottom/capacity/label"), i18n("island_bag_upgrade_capacity"))

	return
end

function IslandInventoryUpgradePage:OnInit()
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.confirmBtn, function()
		if not getProxy(IslandProxy):GetIsland():GetInventoryAgency():CanUpgrade() then
			return
		end

		self:emit(IslandMediator.ON_UPGRADE_INVENTORY)

		return
	end, SFX_PANEL)

	return
end

function IslandInventoryUpgradePage:Show()
	IslandInventoryUpgradePage.super.Show(self)

	local var_7_0 = getProxy(IslandProxy):GetIsland()

	self:UpdateConsume(var_7_0)
	self:UpdateAddition(var_7_0)
	self:UpdateStyle(var_7_0)

	return
end

function IslandInventoryUpgradePage:UpdateStyle(arg_8_1)
	local var_8_0 = arg_8_1:GetInventoryAgency()
	local var_8_1 = var_8_0:IsMaxLevel()

	setActive(self.confirmBtn, not var_8_1)
	setActive(self.maxLevelTxt.gameObject, var_8_1)
	setActive(self.levelTxt.gameObject, not var_8_1)

	if var_8_1 then
		self.maxLevelTxt.text = "Lv." .. var_8_0:GetLevel()
	end

	setActive(self.maxLevelTip, var_8_1)
	setGray(self.confirmBtn, not var_8_0:CanUpgrade(), true)

	return
end

function IslandInventoryUpgradePage:UpdateAddition(arg_9_1)
	local var_9_0 = arg_9_1:GetInventoryAgency()
	local var_9_1 = var_9_0:GetCapacity()
	local var_9_2 = var_9_0:GetLevel()

	self.capacityTxt.text = "<color=#393a3c>" .. var_9_1 .. "</color><color=#39bfff> + " .. var_9_0:GetNextCapacity(var_9_2 + 1) - var_9_1 .. "</color>"
	self.levelTxt.text = "Lv." .. var_9_2
	self.nextLevelTxt.text = "Lv." .. var_9_2 + 1

	return
end

function IslandInventoryUpgradePage:UpdateConsume(arg_10_1)
	local var_10_0 = arg_10_1:GetInventoryAgency():GetUpgradeConsume()

	self.consumeList:make(function(arg_11_0, arg_11_1, arg_11_2)
		if arg_11_0 == UIItemList.EventUpdate then
			local var_11_0 = Drop.Create(var_10_0[arg_11_1 + 1])

			updateCustomDrop(arg_11_2, var_11_0)

			local var_11_1 = var_11_0:getOwnedCount()

			setText(arg_11_2:Find("icon_bg/count_bg/count"), setColorStr(var_11_1, (var_11_1 >= var_11_0.count or nil) and (COLOR_GREEN or COLOR_RED)) .. "/" .. var_11_0.count)
		end

		return
	end)
	self.consumeList:align(#var_10_0)

	return
end

function IslandInventoryUpgradePage:OnDestroy()
	return
end

return IslandInventoryUpgradePage

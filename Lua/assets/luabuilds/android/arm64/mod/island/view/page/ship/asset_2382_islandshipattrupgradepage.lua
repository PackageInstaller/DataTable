local IslandShipAttrUpgradePage = class("IslandShipAttrUpgradePage", import("...base.IslandBasePage"))
local var_0_1 = 1
local var_0_2 = 2

function IslandShipAttrUpgradePage:getUIName()
	return "IslandShipAttrUpgradeUI"
end

function IslandShipAttrUpgradePage:OnLoaded()
	self.upgradeBtn = self._tf:Find("frame/btn_confirm")
	self.closeBtn = self._tf:Find("frame/frame_1/close")
	self.contentTxt = self._tf:Find("frame/frame_1/Text"):GetComponent(typeof(Text))
	self.delBtn = self._tf:Find("frame/frame_2/del")
	self.maxBtn = self._tf:Find("frame/frame_2/max")
	self.toggles = {
		[var_0_1] = self._tf:Find("frame/toggles/upgrade"),
		[var_0_2] = self._tf:Find("frame/toggles/limit")
	}
	self.uiAttrList = UIItemList.New(self._tf:Find("frame/attr"), self._tf:Find("frame/attr/tpl"))
	self.uiUpgradeList = UIItemList.New(self._tf:Find("frame/frame_2/items"), self._tf:Find("frame/frame_2/items/tpl"))
	self.emptyTr = self._tf:Find("frame/frame_2/empty")
	self.uiLimitConsumrList = UIItemList.New(self._tf:Find("frame/frame_3/items"), self._tf:Find("frame/frame_3/items/tpl"))

	setText(self._tf:Find("frame/frame_1/title"), i18n("island_ship_title1"))
	setText(self._tf:Find("frame/toggles/upgrade/Text"), i18n("island_ship_title2"))
	setText(self._tf:Find("frame/toggles/limit/Text"), i18n("island_ship_title3"))
	setText(self._tf:Find("frame/toggles/upgrade/Text_1"), i18n("island_ship_title2"))
	setText(self._tf:Find("frame/toggles/limit/Text_1"), i18n("island_ship_title3"))
	setText(self._tf:Find("frame/frame_2/sub_title/Text"), i18n("island_ship_title4"))
	setText(self._tf:Find("frame/frame_3/sub_title/Text"), i18n("island_ship_title4"))
	setText(self.upgradeBtn:Find("Text"), i18n("island_confirm"))

	return
end

function IslandShipAttrUpgradePage:OnInit()
	onButton(self, self._tf:Find("frame/frame_1/title/help"), function()
		self:ShowMsgBox({
			type = IslandMsgBox.TYPE_WHITOUT_BTN,
			content = i18n("island_chara_attr_help")
		})

		return
	end, SFX_PANEL)
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.delBtn, function()
		self.selected = {}

		self:FlushAttrs(self.slectedAttrName)

		return
	end, SFX_PANEL)
	onButton(self, self.maxBtn, function()
		self:FillSelected()

		return
	end, SFX_PANEL)
	onButton(self, self.upgradeBtn, function()
		self:Confirm()

		return
	end, SFX_PANEL)

	for iter_3_0, iter_3_1 in ipairs(self.toggles) do
		onToggle(self, iter_3_1, function(arg_10_0)
			if arg_10_0 then
				self:SwitchPage(iter_3_0)
			end

			return
		end, SFX_PANEL)
	end

	return
end

function IslandShipAttrUpgradePage:AddListeners()
	self:AddListener(GAME.ISLNAD_SHIP_ATTR_UPGRADE_DONE, self.OnAttrUpgrade)
	self:AddListener(GAME.ISLNAD_SHIP_ATTR_LIMIT_UNLOCK_DONE, self.OnLimitUnlock)

	return
end

function IslandShipAttrUpgradePage:RemoveListeners()
	self:RemoveListener(GAME.ISLNAD_SHIP_ATTR_UPGRADE_DONE, self.OnAttrUpgrade)
	self:RemoveListener(GAME.ISLNAD_SHIP_ATTR_LIMIT_UNLOCK_DONE, self.OnLimitUnlock)

	return
end

function IslandShipAttrUpgradePage:OnAttrUpgrade()
	self.selected = {}

	self:SwitchAttr(self.slectedAttrName)

	return
end

function IslandShipAttrUpgradePage:OnLimitUnlock()
	self:SwitchPage(self.page)

	return
end

function IslandShipAttrUpgradePage:OnShow(arg_15_1)
	self.ship = arg_15_1
	self.selected = {}

	self:BlurPanel()
	triggerToggle(self.toggles[var_0_1], true)

	return
end

function IslandShipAttrUpgradePage:SwitchPage(arg_16_1)
	self.page = arg_16_1

	self:UpdateAttrPanel()
	self:UpdateContent()

	if self.page == var_0_2 then
		self:UpdateLimitUpgradeConsume()
	end

	return
end

function IslandShipAttrUpgradePage:UpdateAttrPanel()
	local var_17_0 = self.ship

	self.attrTrs = {}

	self.uiAttrList:make(function(arg_18_0, arg_18_1, arg_18_2)
		if arg_18_0 == UIItemList.EventUpdate then
			self.attrTrs[IslandShipAttr.ATTRS[arg_18_1 + 1]] = arg_18_2
			arg_18_2:Find("grade_bg"):GetComponent(typeof(Image)).sprite = GetSpriteFromAtlas("ui/IslandShipUI_atlas", IslandShipAttr.Grade2Img((var_17_0:GetAttrGrade(IslandShipAttr.ATTRS[arg_18_1 + 1])))[2])

			setText(arg_18_2:Find("name"), IslandShipAttr.ToChinese(IslandShipAttr.ATTRS[arg_18_1 + 1]))
			self:UpdateAtrrValue(var_17_0, IslandShipAttr.ATTRS[arg_18_1 + 1])
		end

		return
	end)
	self.uiAttrList:align(#IslandShipAttr.ATTRS)

	return
end

function IslandShipAttrUpgradePage:UpdateAtrrValue(arg_19_1, arg_19_2)
	if self.page == var_0_1 then
		setText(self.attrTrs[arg_19_2]:Find("value/value_1"), self.ship:GetAttr(arg_19_2))
		setText(self.attrTrs[arg_19_2]:Find("value/value_2"), "")
		setActive(self.attrTrs[arg_19_2]:Find("value/arr"), false)
		onToggle(self, self.attrTrs[arg_19_2], function(arg_20_0)
			if arg_20_0 then
				self:SwitchAttr(arg_19_2)
			end

			return
		end, SFX_PANEL)
		setToggleEnabled(self.attrTrs[arg_19_2], true)

		if self.slectedAttrName and arg_19_2 == self.slectedAttrName then
			triggerToggle(self.attrTrs[arg_19_2], true)
		elseif not self.slectedAttrName and arg_19_2 == IslandShipAttr.ATTRS[1] then
			triggerToggle(self.attrTrs[arg_19_2], true)
		end
	elseif self.page == var_0_2 then
		local var_19_0 = Clone(self.ship)

		var_19_0:SetUnlockExtraAttLimit()
		setActive(self.attrTrs[arg_19_2]:Find("value/arr"), true)
		setText(self.attrTrs[arg_19_2]:Find("value/value_1"), self.ship:GetExtraAttrLimit(arg_19_2))
		setText(self.attrTrs[arg_19_2]:Find("value/value_2"), var_19_0:GetExtraAttrLimit(arg_19_2))
		setToggleEnabled(self.attrTrs[arg_19_2], false)
		removeOnToggle(self.attrTrs[arg_19_2])

		for iter_19_0, iter_19_1 in pairs(self.attrTrs) do
			setActive(iter_19_1:Find("Image"), false)
		end
	end

	return
end

function IslandShipAttrUpgradePage:UpdateLimitUpgradeConsume()
	local var_21_0 = self.ship:IsUnlockExtraAttLimit()
	local var_21_1 = getProxy(IslandProxy):GetIsland():GetInventoryAgency()
	local var_21_2 = false

	if self.ship:IsUnlockExtraAttLimit() then
		self.uiLimitConsumrList:align(0)
	else
		local var_21_3 = self.ship:GetExtraAttrLimitUnlockConsume()

		self.uiLimitConsumrList:make(function(arg_22_0, arg_22_1, arg_22_2)
			if arg_22_0 == UIItemList.EventUpdate then
				local var_22_0 = var_21_3[arg_22_1 + 1]

				updateCustomDrop(arg_22_2, var_21_3[arg_22_1 + 1])

				local var_22_1 = var_21_1:GetOwnCount(var_22_0.id)

				setText(arg_22_2:Find("icon_bg/count_bg/count"), setColorStr(var_22_1, (var_22_1 >= var_22_0.count or nil) and (COLOR_GREEN or COLOR_RED)) .. "/" .. var_22_0.count)
			end

			return
		end)

		var_21_2 = _.all(var_21_3, function(arg_23_0)
			return var_21_1:GetOwnCount(arg_23_0.id) >= arg_23_0.count
		end)

		self.uiLimitConsumrList:align(#var_21_3)
	end

	setGray(self.upgradeBtn, var_21_0 or not var_21_2)

	return
end

function IslandShipAttrUpgradePage:SwitchAttr(arg_24_1)
	self.selected = {}

	self:ClearUpdateAttrValue(self.slectedAttrName)

	self.slectedAttrName = arg_24_1

	local var_24_1 = self:CanAddItemForAttrValue(arg_24_1)

	if var_24_1 then
		self:FlushAttrs(arg_24_1)
	else
		self.uiUpgradeList:align(0)
	end

	self:UpdateAttrValue()
	setActive(self.emptyTr, not var_24_1)
	setActive(self.delBtn, var_24_1)
	setActive(self.maxBtn, var_24_1)

	return
end

function IslandShipAttrUpgradePage:FlushAttrs(arg_25_1)
	local var_25_0 = self.ship:GetUpgradeExtraAttrConsume(arg_25_1)

	self.uiUpgradeList:make(function(arg_26_0, arg_26_1, arg_26_2)
		if arg_26_0 == UIItemList.EventUpdate then
			local var_26_0 = var_25_0[arg_26_1 + 1]

			updateCustomDrop(arg_26_2, var_25_0[arg_26_1 + 1])
			setText(arg_26_2:Find("icon_bg/count_bg/count"), "X" .. getProxy(IslandProxy):GetIsland():GetInventoryAgency():GetOwnCount(var_25_0[arg_26_1 + 1].id))
			onButton(self, arg_26_2, function()
				if not self:CanAddItemForAttrValue(arg_25_1, self.selected) then
					return
				end

				self:OpenAtrrCalcPanel(arg_26_2, var_26_0)

				return
			end, SFX_PANEL)
			onButton(self, arg_26_2:Find("calc/bg"), function()
				self.selected[var_26_0.id] = (self.selected[var_26_0.id] or 0) - 1

				self:UpdateAttrCalcPanel(arg_26_2, var_26_0)

				return
			end, SFX_PANEL)
			self:UpdateAttrCalcPanel(arg_26_2, var_25_0[arg_26_1 + 1])
		end

		return
	end)
	self.uiUpgradeList:align(#var_25_0)

	return
end

function IslandShipAttrUpgradePage:ClearUpdateAttrValue(arg_29_1)
	if not arg_29_1 or arg_29_1 == "" then
		return
	end

	setText(self.attrTrs[arg_29_1]:Find("value/value_1"), self.ship:GetAttr(arg_29_1))

	return
end

function IslandShipAttrUpgradePage:OpenAtrrCalcPanel(arg_30_1, arg_30_2)
	if getProxy(IslandProxy):GetIsland():GetInventoryAgency():GetOwnCount(arg_30_2.id) <= (self.selected[arg_30_2.id] or 0) then
		return
	end

	self.selected[arg_30_2.id] = (self.selected[arg_30_2.id] or 0) + 1

	self:UpdateAttrCalcPanel(arg_30_1, arg_30_2)

	return
end

function IslandShipAttrUpgradePage:UpdateAttrCalcPanel(arg_31_1, arg_31_2)
	local var_31_0 = self.selected[arg_31_2.id] or 0

	setText(arg_31_1:Find("calc/Text"), var_31_0)
	setActive(arg_31_1:Find("calc"), var_31_0 > 0)
	self:UpdateAttrValue()

	return
end

function IslandShipAttrUpgradePage:UpdateAttrValue()
	local var_32_0 = self.attrTrs[self.slectedAttrName]
	local var_32_1 = self.ship
	local var_32_2, var_32_3, var_32_4 = self:CanAddItemForAttrValue(self.slectedAttrName, self.selected)

	setText(var_32_0:Find("value/value_1"), var_32_1:GetAttr(self.slectedAttrName) .. (var_32_4 <= var_32_3 and "(MAX)" or string.format("(<color=#36a5fb>+%s</color>/%s)", var_32_3, var_32_4)))
	setGray(self.upgradeBtn, self:NothingSelected() and not var_32_2 or self:NothingSelected())

	return
end

function IslandShipAttrUpgradePage:CanAddItemForAttrValue(arg_33_1, arg_33_2)
	local var_33_0 = self.ship:GetExtraAttrValue(arg_33_1)

	for iter_33_0, iter_33_1 in pairs(arg_33_2 or {}) do
		var_33_0 = var_33_0 + tonumber(IslandItem.New({
			id = iter_33_0
		}):GetUseArg()) * iter_33_1
	end

	local var_33_1 = self.ship:GetExtraAttrLimit(arg_33_1)

	return var_33_0 < var_33_1, var_33_0, var_33_1
end

function IslandShipAttrUpgradePage:FillSelected()
	self.selected = {}

	local var_34_0 = getProxy(IslandProxy):GetIsland():GetInventoryAgency()
	local var_34_1 = _.map(self.ship:GetUpgradeExtraAttrConsume(self.slectedAttrName), function(arg_35_0)
		return var_34_0:GetItemById(arg_35_0.id) or IslandItem.New({
			number = 0,
			id = arg_35_0.id
		})
	end)

	table.sort(var_34_1, function(arg_36_0, arg_36_1)
		return arg_36_0:GetRarity() > arg_36_1:GetRarity()
	end)

	local var_34_2 = {}

	for iter_34_0, iter_34_1 in ipairs(var_34_1) do
		for iter_34_2 = 1, iter_34_1.count do
			if self:CanAddItemForAttrValue(self.slectedAttrName, var_34_2) then
				var_34_2[iter_34_1.id] = (var_34_2[iter_34_1.id] or 0) + 1
			else
				break
			end
		end
	end

	self.selected = var_34_2

	self:FlushAttrs(self.slectedAttrName)

	return
end

function IslandShipAttrUpgradePage:UpdateContent()
	if self.page == var_0_1 then
		self.contentTxt.text = i18n("island_ship_lock_attr_tip")
	elseif self.page == var_0_2 then
		self.contentTxt.text = i18n("island_ship_unlock_limit_tip")
	end

	return
end

function IslandShipAttrUpgradePage:Confirm()
	if self.page == var_0_1 then
		if not self.slectedAttrName or not self.ship then
			return
		end

		if self:NothingSelected() then
			return
		end

		if not self:CanAddItemForAttrValue(self.slectedAttrName) then
			return
		end

		local var_38_0 = table.indexof(IslandShipAttr.ATTRS, self.slectedAttrName)

		if var_38_0 <= 0 then
			return
		end

		self:emit(IslandMediator.SHIP_ATTR_UPGRADE, self.ship.id, var_38_0, self.selected)
	elseif self.page == var_0_2 then
		if self.ship:IsUnlockExtraAttLimit() then
			return
		end

		self:emit(IslandMediator.SHIP_ATTR_LIMIT_UNLOCK, self.ship.id)
	end

	return
end

function IslandShipAttrUpgradePage:NothingSelected()
	for iter_39_0, iter_39_1 in pairs(self.selected) do
		if iter_39_1 > 0 then
			return false
		end
	end

	return true
end

function IslandShipAttrUpgradePage:OnHide()
	self:UnBlurPanel()

	return
end

function IslandShipAttrUpgradePage:OnDestroy()
	self:OnHide()

	return
end

return IslandShipAttrUpgradePage

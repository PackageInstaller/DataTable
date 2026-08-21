local var_0_0 = class("IslandShipAttrUpgradePage", import("...base.IslandBasePage"))
local var_0_1 = 1
local var_0_2 = 2

function var_0_0.getUIName(arg_1_0)
	return "IslandShipAttrUpgradeUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.upgradeBtn = arg_2_0._tf:Find("frame/btn_confirm")
	arg_2_0.closeBtn = arg_2_0._tf:Find("frame/frame_1/close")
	arg_2_0.contentTxt = arg_2_0._tf:Find("frame/frame_1/Text"):GetComponent(typeof(Text))
	arg_2_0.delBtn = arg_2_0._tf:Find("frame/frame_2/del")
	arg_2_0.maxBtn = arg_2_0._tf:Find("frame/frame_2/max")
	arg_2_0.toggles = {
		[var_0_1] = arg_2_0._tf:Find("frame/toggles/upgrade"),
		[var_0_2] = arg_2_0._tf:Find("frame/toggles/limit")
	}
	arg_2_0.uiAttrList = UIItemList.New(arg_2_0._tf:Find("frame/attr"), arg_2_0._tf:Find("frame/attr/tpl"))
	arg_2_0.uiUpgradeList = UIItemList.New(arg_2_0._tf:Find("frame/frame_2/items"), arg_2_0._tf:Find("frame/frame_2/items/tpl"))
	arg_2_0.emptyTr = arg_2_0._tf:Find("frame/frame_2/empty")
	arg_2_0.uiLimitConsumrList = UIItemList.New(arg_2_0._tf:Find("frame/frame_3/items"), arg_2_0._tf:Find("frame/frame_3/items/tpl"))

	setText(arg_2_0._tf:Find("frame/frame_1/title"), i18n("island_ship_title1"))
	setText(arg_2_0._tf:Find("frame/toggles/upgrade/Text"), i18n("island_ship_title2"))
	setText(arg_2_0._tf:Find("frame/toggles/limit/Text"), i18n("island_ship_title3"))
	setText(arg_2_0._tf:Find("frame/toggles/upgrade/Text_1"), i18n("island_ship_title2"))
	setText(arg_2_0._tf:Find("frame/toggles/limit/Text_1"), i18n("island_ship_title3"))
	setText(arg_2_0._tf:Find("frame/frame_2/sub_title/Text"), i18n("island_ship_title4"))
	setText(arg_2_0._tf:Find("frame/frame_3/sub_title/Text"), i18n("island_ship_title4"))
	setText(arg_2_0.upgradeBtn:Find("Text"), i18n("island_confirm"))

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0._tf:Find("frame/frame_1/title/help"), function()
		arg_3_0:ShowMsgBox({
			type = IslandMsgBox.TYPE_WHITOUT_BTN,
			content = i18n("island_chara_attr_help")
		})

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0._tf, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.closeBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.delBtn, function()
		arg_3_0.selected = {}

		arg_3_0:FlushAttrs(arg_3_0.slectedAttrName)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.maxBtn, function()
		arg_3_0:FillSelected()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.upgradeBtn, function()
		arg_3_0:Confirm()

		return
	end, SFX_PANEL)

	for iter_3_0, iter_3_1 in ipairs(arg_3_0.toggles) do
		onToggle(arg_3_0, iter_3_1, function(arg_10_0)
			if arg_10_0 then
				arg_3_0:SwitchPage(iter_3_0)
			end

			return
		end, SFX_PANEL)
	end

	return
end

function var_0_0.AddListeners(arg_11_0)
	arg_11_0:AddListener(GAME.ISLNAD_SHIP_ATTR_UPGRADE_DONE, arg_11_0.OnAttrUpgrade)
	arg_11_0:AddListener(GAME.ISLNAD_SHIP_ATTR_LIMIT_UNLOCK_DONE, arg_11_0.OnLimitUnlock)

	return
end

function var_0_0.RemoveListeners(arg_12_0)
	arg_12_0:RemoveListener(GAME.ISLNAD_SHIP_ATTR_UPGRADE_DONE, arg_12_0.OnAttrUpgrade)
	arg_12_0:RemoveListener(GAME.ISLNAD_SHIP_ATTR_LIMIT_UNLOCK_DONE, arg_12_0.OnLimitUnlock)

	return
end

function var_0_0.OnAttrUpgrade(arg_13_0)
	arg_13_0.selected = {}

	arg_13_0:SwitchAttr(arg_13_0.slectedAttrName)

	return
end

function var_0_0.OnLimitUnlock(arg_14_0)
	arg_14_0:SwitchPage(arg_14_0.page)

	return
end

function var_0_0.OnShow(arg_15_0, arg_15_1)
	arg_15_0.ship = arg_15_1
	arg_15_0.selected = {}

	arg_15_0:BlurPanel()
	triggerToggle(arg_15_0.toggles[var_0_1], true)

	return
end

function var_0_0.SwitchPage(arg_16_0, arg_16_1)
	arg_16_0.page = arg_16_1

	arg_16_0:UpdateAttrPanel()
	arg_16_0:UpdateContent()

	if arg_16_0.page == var_0_2 then
		arg_16_0:UpdateLimitUpgradeConsume()
	end

	return
end

function var_0_0.UpdateAttrPanel(arg_17_0)
	local var_17_0 = arg_17_0.ship

	arg_17_0.attrTrs = {}

	arg_17_0.uiAttrList:make(function(arg_18_0, arg_18_1, arg_18_2)
		if arg_18_0 == UIItemList.EventUpdate then
			arg_17_0.attrTrs[IslandShipAttr.ATTRS[arg_18_1 + 1]] = arg_18_2
			arg_18_2:Find("grade_bg"):GetComponent(typeof(Image)).sprite = GetSpriteFromAtlas("ui/IslandShipUI_atlas", IslandShipAttr.Grade2Img((var_17_0:GetAttrGrade(IslandShipAttr.ATTRS[arg_18_1 + 1])))[2])

			setText(arg_18_2:Find("name"), IslandShipAttr.ToChinese(IslandShipAttr.ATTRS[arg_18_1 + 1]))
			arg_17_0:UpdateAtrrValue(var_17_0, IslandShipAttr.ATTRS[arg_18_1 + 1])
		end

		return
	end)
	arg_17_0.uiAttrList:align(#IslandShipAttr.ATTRS)

	return
end

function var_0_0.UpdateAtrrValue(arg_19_0, arg_19_1, arg_19_2)
	if arg_19_0.page == var_0_1 then
		setText(arg_19_0.attrTrs[arg_19_2]:Find("value/value_1"), arg_19_0.ship:GetAttr(arg_19_2))
		setText(arg_19_0.attrTrs[arg_19_2]:Find("value/value_2"), "")
		setActive(arg_19_0.attrTrs[arg_19_2]:Find("value/arr"), false)
		onToggle(arg_19_0, arg_19_0.attrTrs[arg_19_2], function(arg_20_0)
			if arg_20_0 then
				arg_19_0:SwitchAttr(arg_19_2)
			end

			return
		end, SFX_PANEL)
		setToggleEnabled(arg_19_0.attrTrs[arg_19_2], true)

		if arg_19_0.slectedAttrName and arg_19_2 == arg_19_0.slectedAttrName then
			triggerToggle(arg_19_0.attrTrs[arg_19_2], true)
		elseif not arg_19_0.slectedAttrName and arg_19_2 == IslandShipAttr.ATTRS[1] then
			triggerToggle(arg_19_0.attrTrs[arg_19_2], true)
		end
	elseif arg_19_0.page == var_0_2 then
		local var_19_0 = Clone(arg_19_0.ship)

		var_19_0:SetUnlockExtraAttLimit()
		setActive(arg_19_0.attrTrs[arg_19_2]:Find("value/arr"), true)
		setText(arg_19_0.attrTrs[arg_19_2]:Find("value/value_1"), arg_19_0.ship:GetExtraAttrLimit(arg_19_2))
		setText(arg_19_0.attrTrs[arg_19_2]:Find("value/value_2"), var_19_0:GetExtraAttrLimit(arg_19_2))
		setToggleEnabled(arg_19_0.attrTrs[arg_19_2], false)
		removeOnToggle(arg_19_0.attrTrs[arg_19_2])

		for iter_19_0, iter_19_1 in pairs(arg_19_0.attrTrs) do
			setActive(iter_19_1:Find("Image"), false)
		end
	end

	return
end

function var_0_0.UpdateLimitUpgradeConsume(arg_21_0)
	local var_21_0 = arg_21_0.ship:IsUnlockExtraAttLimit()
	local var_21_1 = getProxy(IslandProxy):GetIsland():GetInventoryAgency()
	local var_21_2 = false

	if arg_21_0.ship:IsUnlockExtraAttLimit() then
		arg_21_0.uiLimitConsumrList:align(0)
	else
		local var_21_3 = arg_21_0.ship:GetExtraAttrLimitUnlockConsume()

		arg_21_0.uiLimitConsumrList:make(function(arg_22_0, arg_22_1, arg_22_2)
			if arg_22_0 == UIItemList.EventUpdate then
				local var_22_0 = var_21_3[arg_22_1 + 1]

				updateCustomDrop(arg_22_2, var_21_3[arg_22_1 + 1])

				local var_22_1 = var_21_1:GetOwnCount(var_22_0.id)
				local var_22_3 = var_22_1

				if var_22_1 >= var_22_0.count then
					local var_22_4 = COLOR_GREEN or COLOR_RED

					setText(arg_22_2:Find("icon_bg/count_bg/count"), var_22_2(var_22_3, var_22_4) .. "/" .. var_22_0.count)

					return
				end
			end
		end)

		var_21_2 = _.all(var_21_3, function(arg_23_0)
			return var_21_1:GetOwnCount(arg_23_0.id) >= arg_23_0.count
		end)

		arg_21_0.uiLimitConsumrList:align(#var_21_3)
	end

	setGray(arg_21_0.upgradeBtn, var_21_0 or not var_21_2)

	return
end

function var_0_0.SwitchAttr(arg_24_0, arg_24_1)
	arg_24_0.selected = {}

	arg_24_0:ClearUpdateAttrValue(arg_24_0.slectedAttrName)

	arg_24_0.slectedAttrName = arg_24_1

	local var_24_1 = arg_24_0:CanAddItemForAttrValue(arg_24_1)

	if var_24_1 then
		arg_24_0:FlushAttrs(arg_24_1)
	else
		arg_24_0.uiUpgradeList:align(0)
	end

	arg_24_0:UpdateAttrValue()
	setActive(arg_24_0.emptyTr, not var_24_1)
	setActive(arg_24_0.delBtn, var_24_1)
	setActive(arg_24_0.maxBtn, var_24_1)

	return
end

function var_0_0.FlushAttrs(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0.ship:GetUpgradeExtraAttrConsume(arg_25_1)

	arg_25_0.uiUpgradeList:make(function(arg_26_0, arg_26_1, arg_26_2)
		if arg_26_0 == UIItemList.EventUpdate then
			local var_26_0 = var_25_0[arg_26_1 + 1]

			updateCustomDrop(arg_26_2, var_25_0[arg_26_1 + 1])
			setText(arg_26_2:Find("icon_bg/count_bg/count"), "X" .. getProxy(IslandProxy):GetIsland():GetInventoryAgency():GetOwnCount(var_25_0[arg_26_1 + 1].id))
			onButton(arg_25_0, arg_26_2, function()
				if not arg_25_0:CanAddItemForAttrValue(arg_25_1, arg_25_0.selected) then
					return
				end

				arg_25_0:OpenAtrrCalcPanel(arg_26_2, var_26_0)

				return
			end, SFX_PANEL)
			onButton(arg_25_0, arg_26_2:Find("calc/bg"), function()
				local var_28_0 = arg_25_0.selected[var_26_0.id] or 0

				arg_25_0.selected[var_26_0.id] = var_28_0 - 1

				arg_25_0:UpdateAttrCalcPanel(arg_26_2, var_26_0)

				return
			end, SFX_PANEL)
			arg_25_0:UpdateAttrCalcPanel(arg_26_2, var_25_0[arg_26_1 + 1])
		end

		return
	end)
	arg_25_0.uiUpgradeList:align(#arg_25_0.ship:GetUpgradeExtraAttrConsume(arg_25_1))

	return
end

function var_0_0.ClearUpdateAttrValue(arg_29_0, arg_29_1)
	if not arg_29_1 or arg_29_1 == "" then
		return
	end

	setText(arg_29_0.attrTrs[arg_29_1]:Find("value/value_1"), arg_29_0.ship:GetAttr(arg_29_1))

	return
end

function var_0_0.OpenAtrrCalcPanel(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = arg_30_0.selected[arg_30_2.id] or 0

	if getProxy(IslandProxy):GetIsland():GetInventoryAgency():GetOwnCount(arg_30_2.id) <= var_30_0 then
		return
	end

	local var_30_1 = arg_30_0.selected
	local var_30_2 = arg_30_0.selected[arg_30_2.id] or 0

	var_30_1[arg_30_2.id] = var_30_2 + 1

	arg_30_0:UpdateAttrCalcPanel(arg_30_1, arg_30_2)

	return
end

function var_0_0.UpdateAttrCalcPanel(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = arg_31_0.selected[arg_31_2.id] or 0

	setText(arg_31_1:Find("calc/Text"), var_31_0)
	setActive(arg_31_1:Find("calc"), var_31_0 > 0)
	arg_31_0:UpdateAttrValue()

	return
end

function var_0_0.UpdateAttrValue(arg_32_0)
	local var_32_2, var_32_3, var_32_4 = arg_32_0:CanAddItemForAttrValue(arg_32_0.slectedAttrName, arg_32_0.selected)

	setText(var_32_0:Find("value/value_1"), var_32_1:GetAttr(arg_32_0.slectedAttrName) .. (var_32_4 <= var_32_3 and "(MAX)" or string.format("(<color=#36a5fb>+%s</color>/%s)", var_32_3, var_32_4)))

	local var_32_5 = arg_32_0:NothingSelected() and not var_32_2

	setGray(arg_32_0.upgradeBtn, var_32_5 or arg_32_0:NothingSelected())

	return
end

function var_0_0.CanAddItemForAttrValue(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = arg_33_0.ship:GetExtraAttrValue(arg_33_1)

	for iter_33_0, iter_33_1 in pairs(arg_33_2 or {}) do
		local var_33_1 = IslandItem.New({
			id = iter_33_0
		})

		var_33_0 = var_33_0 + tonumber(var_33_1:GetUseArg()) * iter_33_1
	end

	local var_33_2 = arg_33_0.ship:GetExtraAttrLimit(arg_33_1)

	return var_33_0 < var_33_2, var_33_0, var_33_2
end

function var_0_0.FillSelected(arg_34_0)
	arg_34_0.selected = {}

	local var_34_0 = getProxy(IslandProxy):GetIsland():GetInventoryAgency()
	local var_34_1 = _.map(arg_34_0.ship:GetUpgradeExtraAttrConsume(arg_34_0.slectedAttrName), function(arg_35_0)
		return var_34_0:GetItemById(arg_35_0.id) or IslandItem.New({
			number = 0,
			id = arg_35_0.id
		})
	end)

	table.sort(var_34_1, function(arg_36_0, arg_36_1)
		return arg_36_0:GetRarity() > arg_36_1:GetRarity()
	end)

	for iter_34_0, iter_34_1 in ipairs(var_34_1) do
		for iter_34_2 = 1, iter_34_1.count do
			if arg_34_0:CanAddItemForAttrValue(arg_34_0.slectedAttrName, {}) then
				local var_34_2 = ({})[iter_34_1.id]

				if not ({})[iter_34_1.id] then
					var_34_2 = 0
				end

				;({})[iter_34_1.id] = var_34_2 + 1
			else
				break
			end
		end
	end

	arg_34_0.selected = {}

	arg_34_0:FlushAttrs(arg_34_0.slectedAttrName)

	return
end

function var_0_0.UpdateContent(arg_37_0)
	if arg_37_0.page == var_0_1 then
		arg_37_0.contentTxt.text = i18n("island_ship_lock_attr_tip")
	elseif arg_37_0.page == var_0_2 then
		arg_37_0.contentTxt.text = i18n("island_ship_unlock_limit_tip")
	end

	return
end

function var_0_0.Confirm(arg_38_0)
	if arg_38_0.page == var_0_1 then
		if not arg_38_0.slectedAttrName or not arg_38_0.ship then
			return
		end

		if arg_38_0:NothingSelected() then
			return
		end

		if not arg_38_0:CanAddItemForAttrValue(arg_38_0.slectedAttrName) then
			return
		end

		local var_38_0 = table.indexof(IslandShipAttr.ATTRS, arg_38_0.slectedAttrName)

		if var_38_0 <= 0 then
			return
		end

		arg_38_0:emit(IslandMediator.SHIP_ATTR_UPGRADE, arg_38_0.ship.id, var_38_0, arg_38_0.selected)
	elseif arg_38_0.page == var_0_2 then
		if arg_38_0.ship:IsUnlockExtraAttLimit() then
			return
		end

		arg_38_0:emit(IslandMediator.SHIP_ATTR_LIMIT_UNLOCK, arg_38_0.ship.id)
	end

	return
end

function var_0_0.NothingSelected(arg_39_0)
	for iter_39_0, iter_39_1 in pairs(arg_39_0.selected) do
		if iter_39_1 > 0 then
			return false
		end
	end

	return true
end

function var_0_0.OnHide(arg_40_0)
	arg_40_0:UnBlurPanel()

	return
end

function var_0_0.OnDestroy(arg_41_0)
	arg_41_0:OnHide()

	return
end

return var_0_0

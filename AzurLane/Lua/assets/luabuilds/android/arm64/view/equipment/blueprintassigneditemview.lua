local var_0_0 = class("BlueprintAssignedItemView", import(".AssignedItemView"))

function var_0_0.getUIName(arg_1_0)
	return "BlueprintItemAssignedView"
end

function var_0_0.OnInit(arg_2_0)
	var_0_0.super.OnInit(arg_2_0)

	arg_2_0.countOver = arg_2_0._tf:Find("operate/calc/value_bg/over_count")

	setText(arg_2_0.countOver, i18n("blueprint_select_overflow"))
	onButton(arg_2_0, arg_2_0.maxBtn, function()
		if not arg_2_0.itemVO or not arg_2_0.selectedIndex then
			return
		end

		local var_3_0 = arg_2_0.displayDrops[arg_2_0.selectedIndex]
		local var_3_1 = arg_2_0:GetBlueprintNeed(arg_2_0.displayDrops[arg_2_0.selectedIndex].id)

		if arg_2_0.count * arg_2_0.displayDrops[arg_2_0.selectedIndex].count < var_3_1 then
			arg_2_0.count = math.floor((var_3_1 + var_3_0.count - 1) / var_3_0.count)
			arg_2_0.count = math.min(arg_2_0.count, arg_2_0.itemVO.count)
		else
			arg_2_0.count = arg_2_0.itemVO.count
		end

		arg_2_0:updateValue()

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.confirmBtn, function()
		if not arg_2_0.selectedIndex or not arg_2_0.itemVO or arg_2_0.count <= 0 then
			return
		end

		local var_4_0 = arg_2_0.displayDrops[arg_2_0.selectedIndex]
		local var_4_1 = arg_2_0.count * arg_2_0.displayDrops[arg_2_0.selectedIndex].count
		local var_4_2 = arg_2_0:GetBlueprintNeed(arg_2_0.displayDrops[arg_2_0.selectedIndex].id)
		local var_4_3 = {}

		if arg_2_0.isSwitch and not arg_2_0:checkBlueprintIsFate(var_4_0.id) then
			if arg_2_0.count * arg_2_0.displayDrops[arg_2_0.selectedIndex].count <= var_4_2 then
				table.insert(var_4_3, function(arg_5_0)
					pg.MsgboxMgr.GetInstance():ShowMsgBox({
						content = i18n("blueprint_exchange_fate_unlock"),
						onYes = arg_5_0
					})

					return
				end)
			else
				table.insert(var_4_3, function(arg_6_0)
					pg.MsgboxMgr.GetInstance():ShowMsgBox({
						content = i18n("blueprint_exchange_fate_unlock_over", var_4_0:getConfig("name"), var_4_1 - var_4_2),
						onYes = arg_6_0
					})

					return
				end)
			end
		elseif not arg_2_0.isAllNeedZero and var_4_2 < arg_2_0.count * arg_2_0.displayDrops[arg_2_0.selectedIndex].count then
			table.insert(var_4_3, function(arg_7_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("blueprint_select_overflow_tip", var_4_0:getConfig("name"), var_4_1 - var_4_2),
					onYes = arg_7_0
				})

				return
			end)
		end

		seriesAsync(var_4_3, function()
			arg_2_0:emit(EquipmentMediator.ON_USE_ITEM, arg_2_0.itemVO.id, arg_2_0.count, arg_2_0.itemVO:getConfig("usage_arg")[arg_2_0.selectedIndex])
			arg_2_0:Hide()

			return
		end)

		return
	end, SFX_PANEL)

	arg_2_0.toggleSwitch = arg_2_0._tf:Find("operate/got/top/switch_btn")

	setText(arg_2_0.toggleSwitch:Find("Text_off"), i18n("show_fate_demand_count"))
	setText(arg_2_0.toggleSwitch:Find("Text_on"), i18n("show_design_demand_count"))
	onToggle(arg_2_0, arg_2_0.toggleSwitch, function(arg_9_0)
		arg_2_0.isSwitch = arg_9_0

		arg_2_0:updateValue()

		return
	end, SFX_PANEL)
	setText(arg_2_0._tf:Find("operate/got/top/info/Text"), i18n("fate_unlock_icon_desc"))

	return
end

function var_0_0.GetBlueprintNeed(arg_10_0, arg_10_1)
	arg_10_0.technologyProxy = arg_10_0.technologyProxy or getProxy(TechnologyProxy)

	local var_10_0 = arg_10_0.technologyProxy:getBluePrintById(arg_10_0.technologyProxy:GetBlueprint4Item(arg_10_1))

	arg_10_0.bagProxy = arg_10_0.bagProxy or getProxy(BagProxy)

	warning(arg_10_0.isSwitch)

	local var_10_1 = arg_10_0.isSwitch and var_10_0:getFateMaxLeftOver() or 0

	return math.max(var_10_0:getUseageMaxItem() + var_10_1 - arg_10_0.bagProxy:getItemCountById(var_10_0:getItemId()), 0)
end

function var_0_0.checkBlueprintIsUnlock(arg_11_0, arg_11_1)
	arg_11_0.technologyProxy = arg_11_0.technologyProxy or getProxy(TechnologyProxy)

	return arg_11_0.technologyProxy:getBluePrintById(arg_11_0.technologyProxy:GetBlueprint4Item(arg_11_1)):isUnlock()
end

function var_0_0.checkBlueprintIsFate(arg_12_0, arg_12_1)
	arg_12_0.technologyProxy = arg_12_0.technologyProxy or getProxy(TechnologyProxy)

	return arg_12_0.technologyProxy:getBluePrintById(arg_12_0.technologyProxy:GetBlueprint4Item(arg_12_1)):IsFate()
end

function var_0_0.updateValue(arg_13_0)
	arg_13_0.isAllNeedZero = underscore.all(arg_13_0.displayDrops, function(arg_14_0)
		return arg_13_0:GetBlueprintNeed(arg_14_0.id) == 0
	end)

	arg_13_0:updateCountText()
	arg_13_0.ulist:each(function(arg_15_0, arg_15_1)
		if not isActive(arg_15_1) then
			return
		end

		arg_15_0 = arg_15_0 + 1

		local var_15_0 = arg_13_0.count * arg_13_0.displayDrops[arg_15_0].count
		local var_15_1 = arg_13_0:GetBlueprintNeed(arg_13_0.displayDrops[arg_15_0].id)

		setText(arg_15_1:Find("item/icon_bg/count"), setColorStr(arg_13_0.count * arg_13_0.displayDrops[arg_15_0].count, not arg_13_0.isAllNeedZero and var_15_1 < var_15_0 and "#FF5A5A" or "#FFEC6E") .. "/" .. var_15_1)

		return
	end)

	return
end

function var_0_0.updateCountText(arg_16_0)
	local var_16_0 = arg_16_0.count * arg_16_0.displayDrops[arg_16_0.selectedIndex].count
	local var_16_1 = arg_16_0:GetBlueprintNeed(arg_16_0.displayDrops[arg_16_0.selectedIndex].id)
	local var_16_2 = not arg_16_0.isAllNeedZero and var_16_1 < var_16_0 and setColorStr(arg_16_0.count, "#FF5A5A") or arg_16_0.count

	setText(arg_16_0.valueText, var_16_2)
	setActive(arg_16_0.countOver, not arg_16_0.isAllNeedZero and var_16_1 < var_16_0)

	return
end

function var_0_0.update(arg_17_0, arg_17_1)
	arg_17_0.count = 1
	arg_17_0.selectedIndex = nil
	arg_17_0.selectedItem = nil
	arg_17_0.isSwitch = false
	arg_17_0.itemVO = arg_17_1
	arg_17_0.displayDrops = underscore.map(arg_17_1:getConfig("display_icon"), function(arg_18_0)
		return {
			type = arg_18_0[1],
			id = arg_18_0[2],
			count = arg_18_0[3]
		}
	end)

	arg_17_0.ulist:make(function(arg_19_0, arg_19_1, arg_19_2)
		arg_19_1 = arg_19_1 + 1

		if arg_19_0 == UIItemList.EventUpdate then
			updateDrop(arg_19_2:Find("item"), arg_17_0.displayDrops[arg_19_1])
			onToggle(arg_17_0, arg_19_2, function(arg_20_0)
				if arg_20_0 then
					arg_17_0.selectedIndex = arg_19_1
					arg_17_0.selectedItem = arg_19_2

					arg_17_0:updateCountText()
				end

				return
			end, SFX_PANEL)
			triggerToggle(arg_19_2, arg_19_1 == 1)
			setScrollText(arg_19_2:Find("name_bg/Text"), arg_17_0.displayDrops[arg_19_1]:getConfig("name"))

			arg_17_0.selectedItem = arg_17_0.selectedItem or arg_19_2

			setText(arg_19_2:Find("item/tip/Text"), i18n("tech_character_get"))
			setActive(arg_19_2:Find("item/tip"), arg_17_0:checkBlueprintIsUnlock(arg_17_0.displayDrops[arg_19_1].id))
			setActive(arg_19_2:Find("fateFlag"), arg_17_0:checkBlueprintIsFate(arg_17_0.displayDrops[arg_19_1].id))
		end

		return
	end)
	arg_17_0.ulist:align(#arg_17_0.displayDrops)
	triggerToggle(arg_17_0.selectedItem, true)
	triggerToggle(arg_17_0.toggleSwitch, false)

	local var_17_0 = Drop.New({
		type = DROP_TYPE_ITEM,
		id = arg_17_1.id,
		count = arg_17_1.count
	})

	updateDrop(arg_17_0.itemTF:Find("left/IconTpl"), setmetatable({
		count = 0
	}, {
		__index = var_17_0
	}))
	UpdateOwnDisplay(arg_17_0.itemTF:Find("left/own"), var_17_0)
	setText(arg_17_0.nameTF, arg_17_1:getConfig("name"))
	setText(arg_17_0.descTF, arg_17_1:getConfig("display"))

	return
end

return var_0_0

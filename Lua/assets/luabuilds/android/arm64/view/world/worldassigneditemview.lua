local var_0_0 = class("WorldAssignedItemView", import("..base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "StoreHouseItemAssignedView"
end

function var_0_0.OnInit(arg_2_0)
	local var_2_0 = arg_2_0._tf:Find("operate")

	arg_2_0.ulist = UIItemList.New(var_2_0:Find("got/bottom/list"), var_2_0:Find("got/bottom/list/tpl"))
	arg_2_0.confirmBtn = var_2_0:Find("actions/confirm")

	setText(arg_2_0.confirmBtn:Find("Image"), i18n("text_confirm"))

	arg_2_0.cancelBtn = var_2_0:Find("actions/cancel")

	setText(arg_2_0.cancelBtn:Find("Image"), i18n("text_cancel"))

	arg_2_0.rightArr = var_2_0:Find("calc/value_bg/add")
	arg_2_0.leftArr = var_2_0:Find("calc/value_bg/mius")
	arg_2_0.maxBtn = var_2_0:Find("calc/max")
	arg_2_0.valueText = var_2_0:Find("calc/value_bg/Text")
	arg_2_0.itemTF = var_2_0:Find("item")
	arg_2_0.nameTF = var_2_0:Find("item/display_panel/name_container/name/Text")
	arg_2_0.descTF = var_2_0:Find("item/display_panel/desc/Text")

	onButton(arg_2_0, arg_2_0._tf:Find("bg"), function()
		arg_2_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.cancelBtn, function()
		arg_2_0:Hide()

		return
	end, SFX_PANEL)
	pressPersistTrigger(arg_2_0.rightArr, 0.5, function(arg_5_0)
		if not arg_2_0.itemVO then
			arg_5_0()

			return
		end

		arg_2_0.count = math.min(arg_2_0.count + 1, arg_2_0.itemVO.count)

		arg_2_0:updateValue()

		return
	end, nil, true, true, 0.1, SFX_PANEL)
	pressPersistTrigger(arg_2_0.leftArr, 0.5, function(arg_6_0)
		if not arg_2_0.itemVO then
			arg_6_0()

			return
		end

		arg_2_0.count = math.max(arg_2_0.count - 1, 1)

		arg_2_0:updateValue()

		return
	end, nil, true, true, 0.1, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.maxBtn, function()
		if not arg_2_0.itemVO then
			return
		end

		arg_2_0.count = arg_2_0.itemVO.count

		arg_2_0:updateValue()

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.confirmBtn, function()
		if not arg_2_0.selectedIndex or not arg_2_0.itemVO or arg_2_0.count <= 0 then
			return
		end

		arg_2_0:emit(WorldInventoryMediator.OnUseItem, arg_2_0.itemVO.id, arg_2_0.count, arg_2_0.itemVO:getConfig("usage_arg")[arg_2_0.selectedIndex])
		arg_2_0:Hide()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Show(arg_9_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_9_0._tf)
	setActive(arg_9_0._tf, true)

	return
end

function var_0_0.Hide(arg_10_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_10_0._tf, arg_10_0._parentTf)
	setActive(arg_10_0._tf, false)

	return
end

function var_0_0.updateValue(arg_11_0)
	setText(arg_11_0.valueText, arg_11_0.count)
	arg_11_0.ulist:each(function(arg_12_0, arg_12_1)
		if not isActive(arg_12_1) then
			return
		end

		setText(arg_12_1:Find("item/icon_bg/count"), arg_11_0.count)

		return
	end)

	return
end

function var_0_0.update(arg_13_0, arg_13_1)
	arg_13_0.count = 1
	arg_13_0.selectedIndex = nil
	arg_13_0.selectedItem = nil
	arg_13_0.itemVO = arg_13_1
	arg_13_0.displayDrops = underscore.map(arg_13_1:getConfig("usage_arg"), function(arg_14_0)
		return {
			type = arg_14_0[1],
			id = arg_14_0[2],
			count = arg_14_0[3]
		}
	end)

	arg_13_0.ulist:make(function(arg_15_0, arg_15_1, arg_15_2)
		arg_15_1 = arg_15_1 + 1

		if arg_15_0 == UIItemList.EventUpdate then
			updateDrop(arg_15_2:Find("item"), arg_13_0.displayDrops[arg_15_1])

			local var_15_0 = arg_15_2:Find("item/icon_bg/count")

			onToggle(arg_13_0, arg_15_2, function(arg_16_0)
				if arg_16_0 then
					arg_13_0.selectedIndex = arg_15_1
					arg_13_0.selectedItem = arg_15_2
				elseif arg_13_0.selectedIndex == arg_15_1 then
					arg_13_0.selectedIndex = nil
					arg_13_0.selectedItem = nil
				end

				return
			end, SFX_PANEL)
			setScrollText(arg_15_2:Find("name_bg/Text"), arg_13_0.displayDrops[arg_15_1]:getConfig("name"))

			arg_13_0.selectedItem = arg_13_0.selectedItem or arg_15_2
		end

		return
	end)
	arg_13_0.ulist:align(#arg_13_0.displayDrops)
	triggerToggle(arg_13_0.selectedItem, true)
	arg_13_0:updateValue()

	local var_13_0 = Drop.New({
		type = arg_13_1.type,
		id = arg_13_1.id,
		count = arg_13_1.count
	})

	updateDrop(arg_13_0.itemTF:Find("left/IconTpl"), setmetatable({
		count = 0
	}, {
		__index = var_13_0
	}))
	UpdateOwnDisplay(arg_13_0.itemTF:Find("left/own"), var_13_0)
	setText(arg_13_0.nameTF, arg_13_1:getConfig("name"))
	setText(arg_13_0.descTF, arg_13_1:getConfig("display"))

	return
end

return var_0_0

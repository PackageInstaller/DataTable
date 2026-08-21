local var_0_0 = class("AssignedItemView", import("..base.BaseSubView"))

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
	arg_2_0.nameTF = arg_2_0.itemTF:Find("display_panel/name_container/name/Text")
	arg_2_0.descTF = arg_2_0.itemTF:Find("display_panel/desc/Text")

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

		local var_8_0 = {}

		if arg_2_0.itemVO:IsDoaSelectCharItem() then
			table.insert(var_8_0, function(arg_9_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("doa_character_select_confirm", (HXSet.hxLan(pg.ship_data_statistics[arg_2_0.displayDrops[arg_2_0.selectedIndex].id].name))),
					onYes = arg_9_0
				})

				return
			end)
		end

		local var_8_1 = arg_2_0.displayDrops[arg_2_0.selectedIndex].type == DROP_TYPE_ITEM and arg_2_0.displayDrops[arg_2_0.selectedIndex]:getSubClass()

		if var_8_1 and var_8_1:getConfig("type") == Item.SKIN_ASSIGNED_TYPE and var_8_1:IsAllSkinOwner() then
			table.insert(var_8_0, function(arg_10_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("blackfriday_pack_select_skinall"),
					onYes = arg_10_0
				})

				return
			end)
		end

		seriesAsync(var_8_0, function()
			arg_2_0:emit(EquipmentMediator.ON_USE_ITEM, arg_2_0.itemVO.id, arg_2_0.count, arg_2_0.itemVO:getConfig("usage_arg")[arg_2_0.selectedIndex])
			arg_2_0:Hide()

			return
		end)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Show(arg_12_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_12_0._tf)
	setActive(arg_12_0._tf, true)

	return
end

function var_0_0.Hide(arg_13_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_13_0._tf, arg_13_0._parentTf)
	setActive(arg_13_0._tf, false)

	return
end

function var_0_0.updateValue(arg_14_0)
	setText(arg_14_0.valueText, arg_14_0.count)
	arg_14_0.ulist:each(function(arg_15_0, arg_15_1)
		if not isActive(arg_15_1) then
			return
		end

		setText(arg_15_1:Find("item/icon_bg/count"), arg_14_0.count * arg_14_0.displayDrops[arg_15_0 + 1].count)

		local var_15_0 = arg_14_0:isOverLimit(arg_15_0 + 1, arg_14_0.count)

		setActive(arg_15_1:Find("block_mask"), var_15_0)

		if var_15_0 and arg_14_0.selectedIndex == arg_15_0 + 1 then
			triggerToggle(arg_15_1, false)
		end

		return
	end)

	return
end

function var_0_0.isOverLimit(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0.displayDrops[arg_16_1]
	local var_16_1 = underscore.detect(arg_16_0.itemVO:getConfig("limit"), function(arg_17_0)
		local var_17_0, var_17_1, var_17_2 = unpack(arg_17_0)

		return var_17_0 == var_16_0.type and var_17_1 == var_16_0.id
	end)
	local var_16_2

	var_16_2 = var_16_1 and var_16_1[3] or nil

	if not var_16_2 then
		return false
	else
		return var_16_2 < var_16_0:getOwnedCount() + var_16_0.count * arg_16_0.count
	end

	return
end

local function var_0_1(arg_18_0)
	local var_18_0 = getProxy(CollectionProxy)

	return var_18_0:getShipGroup(pg.ship_data_template[arg_18_0].group_type) ~= nil
end

function var_0_0.update(arg_19_0, arg_19_1)
	arg_19_0.count = 1
	arg_19_0.selectedIndex = nil
	arg_19_0.selectedItem = nil
	arg_19_0.itemVO = arg_19_1
	arg_19_0.displayDrops = underscore.map(arg_19_1:getConfig("display_icon"), function(arg_20_0)
		return Drop.Create(arg_20_0)
	end)

	local var_19_0 = arg_19_1:getConfig("time_limit") == 1

	arg_19_0.ulist:make(function(arg_21_0, arg_21_1, arg_21_2)
		arg_21_1 = arg_21_1 + 1

		if arg_21_0 == UIItemList.EventUpdate then
			local var_21_0 = arg_19_0.displayDrops[arg_21_1]

			updateDrop(arg_21_2:Find("item"), arg_19_0.displayDrops[arg_21_1])
			onToggle(arg_19_0, arg_21_2, function(arg_22_0)
				if arg_22_0 then
					arg_19_0.selectedIndex = arg_21_1
					arg_19_0.selectedItem = arg_21_2
				elseif arg_19_0.selectedIndex == arg_21_1 then
					arg_19_0.selectedIndex = nil
					arg_19_0.selectedItem = nil
				end

				return
			end, SFX_PANEL)
			triggerToggle(arg_21_2, false)
			setScrollText(arg_21_2:Find("name_bg/Text"), var_21_0:getConfig("name"))

			local var_21_1 = var_19_0 and var_21_0.type == DROP_TYPE_SHIP and var_0_1(var_21_0.id)

			if var_21_1 then
				setText(arg_21_2:Find("item/tip/Text"), i18n("tech_character_get"))
			end

			setActive(arg_21_2:Find("item/tip"), var_21_1)
			onButton(arg_19_0, arg_21_2:Find("block_mask"), function()
				pg.TipsMgr.GetInstance():ShowTips(i18n("item_assigned_type_limit_error"))

				return
			end, SFX_CANCEL)

			if not arg_19_0.selectedItem and not arg_19_0:isOverLimit(arg_21_1, arg_19_0.count) then
				arg_19_0.selectedItem = arg_21_2
			end
		end

		return
	end)
	arg_19_0.ulist:align(#arg_19_0.displayDrops)

	if arg_19_0.selectedItem then
		triggerToggle(arg_19_0.selectedItem, true)
	end

	arg_19_0:updateValue()

	local var_19_1 = Drop.New({
		type = DROP_TYPE_ITEM,
		id = arg_19_1.id,
		count = arg_19_1.count
	})

	updateDrop(arg_19_0.itemTF:Find("left/IconTpl"), setmetatable({
		count = 0
	}, {
		__index = var_19_1
	}))
	UpdateOwnDisplay(arg_19_0.itemTF:Find("left/own"), var_19_1)

	if underscore.any(arg_19_0.displayDrops, function(arg_24_0)
		return arg_24_0.type == DROP_TYPE_ITEM and arg_24_0:getConfig("type") == Item.SKIN_ASSIGNED_TYPE
	end) or var_19_1.type == DROP_TYPE_ITEM and var_19_1:getConfig("type") == Item.ASSIGNED_TYPE then
		RegisterDetailButton(arg_19_0, arg_19_0.itemTF:Find("left/detail"), var_19_1)
	else
		removeOnButton(arg_19_0.itemTF:Find("left/detail"))
	end

	setText(arg_19_0.nameTF, arg_19_1:getConfig("name"))
	setText(arg_19_0.descTF, arg_19_1:getConfig("display"))

	return
end

function var_0_0.OnDestroy(arg_25_0)
	if arg_25_0:isShowing() then
		arg_25_0:Hide()
	end

	return
end

return var_0_0

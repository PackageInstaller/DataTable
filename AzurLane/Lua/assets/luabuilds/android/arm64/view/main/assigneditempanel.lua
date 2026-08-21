local var_0_0 = class("AssignedItemPanel")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	pg.DelegateInfo.New(arg_1_0)

	arg_1_0._go = arg_1_1
	arg_1_0._tf = tf(arg_1_1)
	arg_1_0.isInited = false
	arg_1_0.selectedVO = nil
	arg_1_0.count = 1
	arg_1_0.view = arg_1_2

	return
end

function var_0_0.show(arg_2_0)
	setActive(arg_2_0._tf, true)
	pg.UIMgr.GetInstance():BlurPanel(arg_2_0._tf)

	return
end

function var_0_0.hide(arg_3_0)
	setActive(arg_3_0._tf, false)

	arg_3_0.selectedVO = nil
	arg_3_0.itemVO = nil
	arg_3_0.count = 1

	pg.UIMgr.GetInstance():UnOverlayPanel(arg_3_0._tf, arg_3_0.view._tf)

	if arg_3_0.selectedItem then
		triggerToggle(arg_3_0.selectedItem, false)
	end

	arg_3_0.selectedItem = nil

	return
end

function var_0_0.init(arg_4_0)
	arg_4_0.isInited = true
	arg_4_0.ulist = UIItemList.New(arg_4_0._tf:Find("got/bottom/scroll/list"), arg_4_0._tf:Find("got/bottom/scroll/list/tpl"))
	arg_4_0.confirmBtn = arg_4_0._tf:Find("calc/confirm")
	arg_4_0.rightArr = arg_4_0._tf:Find("calc/value_bg/add")
	arg_4_0.leftArr = arg_4_0._tf:Find("calc/value_bg/mius")
	arg_4_0.maxBtn = arg_4_0._tf:Find("calc/max")
	arg_4_0.valueText = arg_4_0._tf:Find("calc/value_bg/Text")
	arg_4_0.itemTF = arg_4_0._tf:Find("item/bottom/item")
	arg_4_0.nameTF = arg_4_0._tf:Find("item/bottom/name_bg/name")
	arg_4_0.descTF = arg_4_0._tf:Find("item/bottom/desc")

	onButton(arg_4_0, arg_4_0._tf, function()
		arg_4_0:hide()

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_0.rightArr, function()
		if not arg_4_0.itemVO then
			return
		end

		arg_4_0.count = math.min(arg_4_0.count + 1, arg_4_0.itemVO.count)

		arg_4_0:updateValue()

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_0.leftArr, function()
		if not arg_4_0.itemVO then
			return
		end

		arg_4_0.count = math.max(arg_4_0.count - 1, 1)

		arg_4_0:updateValue()

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_0.maxBtn, function()
		if not arg_4_0.itemVO then
			return
		end

		arg_4_0.count = arg_4_0.itemVO.count

		arg_4_0:updateValue()

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_0.confirmBtn, function()
		if not arg_4_0.selectedVO or not arg_4_0.itemVO or arg_4_0.count <= 0 then
			return
		end

		arg_4_0.view:emit(EquipmentMediator.ON_USE_ITEM, arg_4_0.itemVO.id, arg_4_0.count, arg_4_0.selectedVO)
		arg_4_0:hide()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.updateValue(arg_10_0)
	setText(arg_10_0.valueText, arg_10_0.count)
	arg_10_0.ulist:each(function(arg_11_0, arg_11_1)
		setText(arg_11_1:Find("item/bg/icon_bg/count"), arg_10_0.count)

		return
	end)

	return
end

function var_0_0.update(arg_12_0, arg_12_1)
	arg_12_0.itemVO = arg_12_1

	if not arg_12_0.isInited then
		arg_12_0:init()
	end

	local var_12_0 = arg_12_1:getConfig("display_icon")

	arg_12_0.selectedItem = nil

	arg_12_0.ulist:make(function(arg_13_0, arg_13_1, arg_13_2)
		if arg_13_0 == UIItemList.EventUpdate then
			updateDrop(arg_13_2:Find("item/bg"), {
				type = var_12_0[arg_13_1 + 1][1],
				id = var_12_0[arg_13_1 + 1][2],
				count = var_12_0[arg_13_1 + 1][3]
			})

			local var_13_0 = arg_13_2:Find("item/bg/icon_bg/count")

			onToggle(arg_12_0, arg_13_2, function(arg_14_0)
				if arg_14_0 then
					arg_12_0.selectedVO = arg_12_1:getConfig("usage_arg")[arg_13_1 + 1]

					setText(var_13_0, arg_12_0.count * var_0[3])

					arg_12_0.selectedItem = arg_13_2
				end

				return
			end, SFX_PANEL)
			setScrollText(arg_13_2:Find("name_bg/Text"), ({
				type = var_12_0[arg_13_1 + 1][1],
				id = var_12_0[arg_13_1 + 1][2],
				count = var_12_0[arg_13_1 + 1][3]
			}):getConfig("name"))
		end

		return
	end)
	arg_12_0.ulist:align(#var_12_0)
	arg_12_0:updateValue()
	updateDrop(arg_12_0.itemTF:Find("bg"), {
		type = DROP_TYPE_ITEM,
		id = arg_12_1.id,
		count = arg_12_1.count
	})
	setText(arg_12_0.nameTF, arg_12_1:getConfig("name"))
	setText(arg_12_0.descTF, arg_12_1:getConfig("display"))

	return
end

function var_0_0.dispose(arg_15_0)
	pg.DelegateInfo.Dispose(arg_15_0)

	return
end

return var_0_0

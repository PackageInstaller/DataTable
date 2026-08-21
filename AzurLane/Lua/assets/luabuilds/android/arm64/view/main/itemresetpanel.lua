local var_0_0 = class("ItemResetPanel")

var_0_0.SINGLE = 1
var_0_0.BATCH = 2
var_0_0.INFO = 3
var_0_0.SEE = 4

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	pg.DelegateInfo.New(arg_1_0)

	arg_1_0._parent = arg_1_2
	arg_1_0._go = arg_1_1
	arg_1_0._tf = tf(arg_1_1)

	onButton(arg_1_0, arg_1_0._tf:Find("bg"), function()
		arg_1_0:Close()

		return
	end, SFX_PANEL)
	setActive(arg_1_0._go, false)

	arg_1_0.backBtn = arg_1_0._tf:Find("window/top/btnBack")

	onButton(arg_1_0, arg_1_0.backBtn, function()
		arg_1_0:Close()

		return
	end, SFX_PANEL)

	arg_1_0.infoPanel = arg_1_0._tf:Find("window/panel/info")
	arg_1_0.fromListPanel = arg_1_0._tf:Find("window/panel/list")
	arg_1_0.fromItemList = UIItemList.New(arg_1_0.fromListPanel:Find("view/content"), arg_1_0.fromListPanel:Find("view/content/item"))

	arg_1_0.fromItemList:make(function(arg_4_0, arg_4_1, arg_4_2)
		arg_4_1 = arg_4_1 + 1

		if arg_4_0 == UIItemList.EventUpdate then
			setActive(arg_4_2:Find("from"), arg_1_0.infoList[arg_4_1])
			setActive(arg_4_2:Find("nothing"), not arg_1_0.infoList[arg_4_1])

			if arg_1_0.infoList[arg_4_1] then
				setText(arg_4_2:Find("from/Text"), pg.world_item_data_origin[arg_1_0.infoList[arg_4_1]].origin_text)
			end
		end

		return
	end)

	return
end

function var_0_0.Open(arg_5_0, arg_5_1)
	arg_5_0.itemVO = WorldItem.New(arg_5_1)

	arg_5_0:Update(arg_5_0.itemVO)
	setActive(arg_5_0._tf, true)
	pg.UIMgr.GetInstance():BlurPanel(arg_5_0._tf)

	return
end

function var_0_0.Close(arg_6_0)
	arg_6_0.itemVO = nil

	setActive(arg_6_0._tf, false)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_6_0._tf, arg_6_0._parent)

	return
end

function var_0_0.Update(arg_7_0, arg_7_1)
	local var_7_0 = Drop.New({
		type = arg_7_1.type,
		id = arg_7_1.id,
		count = arg_7_1.count
	})
	local var_7_1

	if arg_7_1:getConfig("item_transform_item_type") > 0 then
		var_7_0.count = arg_7_1:getConfig("item_transform_num")
		var_7_1 = Drop.New({
			type = arg_7_1:getConfig("item_transform_item_type"),
			id = arg_7_1:getConfig("item_transform_item_id"),
			count = arg_7_1:getConfig("item_transform_item_number")
		})
	end

	setText(arg_7_0.infoPanel:Find("top_text"), i18n("world_item_recycle_" .. (var_7_1 and 1 or 2)))
	setText(arg_7_0.infoPanel:Find("bottom_text"), i18n("world_item_origin"))
	updateDrop(arg_7_0.infoPanel:Find("before"), var_7_0)
	updateDrop(arg_7_0.infoPanel:Find("after"), defaultValue(var_7_1, var_7_0))
	setActive(arg_7_0.infoPanel:Find("after/destroy_mask"), not var_7_1)

	arg_7_0.infoList = arg_7_1:getConfig("item_origin")

	if #arg_7_0.infoList == 0 then
		table.insert(arg_7_0.infoList, 1)
	end

	arg_7_0.fromItemList:align(math.max(#arg_7_0.infoList, 3))

	return
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0:Close()
	pg.DelegateInfo.Dispose(arg_8_0)

	return
end

return var_0_0

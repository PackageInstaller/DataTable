class = var_0_10000

local var_0_0 = var_0_10000("ItemResetPanel")

var_0_0.SINGLE = 1
var_0_0.BATCH = 2
var_0_0.INFO = 3
var_0_0.SEE = 4

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	pg = var_1_10003

	var_1_10003.DelegateInfo.New(arg_1_0)

	arg_1_0._parent = arg_1_2
	arg_1_0._go = arg_1_1
	tf = var_3
	arg_1_0._tf = var_3(arg_1_1)
	onButton = var_3

	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0._tf
	local var_1_2 = var_5.Find(var_1_1, "bg")

	local function var_1_3()
		local var_2_0 = arg_1_0

		var_0.Close(var_2_0)

		return
	end

	SFX_PANEL = var_7

	var_3(var_1_0, var_1_2, var_1_3, var_7)

	setActive = var_3

	var_3(arg_1_0._go, false)

	local var_1_4 = arg_1_0._tf

	arg_1_0.backBtn = var_3.Find(var_1_4, "window/top/btnBack")
	onButton = var_3

	local var_1_5 = arg_1_0
	local var_1_6 = arg_1_0.backBtn

	local function var_1_7()
		local var_3_0 = arg_1_0

		var_0.Close(var_3_0)

		return
	end

	SFX_PANEL = var_7

	var_3(var_1_5, var_1_6, var_1_7, var_7)

	local var_1_8 = arg_1_0._tf

	arg_1_0.infoPanel = var_3.Find(var_1_8, "window/panel/info")

	local var_1_9 = arg_1_0._tf

	arg_1_0.fromListPanel = var_3.Find(var_1_9, "window/panel/list")
	UIItemList = var_3

	local var_1_10 = var_3.New
	local var_1_11 = arg_1_0.fromListPanel
	local var_1_12 = var_4.Find(var_1_11, "view/content")
	local var_1_13 = arg_1_0.fromListPanel

	arg_1_0.fromItemList = var_1_10(var_1_12, var_5.Find(var_1_13, "view/content/item"))

	local var_1_14 = arg_1_0.fromItemList

	var_3.make(var_1_14, function(arg_4_0, arg_4_1, arg_4_2)
		arg_4_1 = arg_4_1 + 1
		UIItemList = var_2_10003

		if arg_4_0 == var_2_10003.EventUpdate then
			local var_4_0 = arg_1_0.infoList[arg_4_1]

			setActive = var_2_10004

			var_2_10004(arg_4_2:Find("from"), var_4_0)

			setActive = var_2_10004

			var_2_10004(arg_4_2:Find("nothing"), not var_4_0)

			if var_4_0 then
				setText = var_2_10004

				local var_4_1 = arg_4_2
				local var_4_2 = arg_4_2.Find(var_4_1, "from/Text")

				pg = var_4_1

				var_2_10004(var_4_2, var_4_1.world_item_data_origin[var_4_0].origin_text)
			end
		end

		return
	end)

	return
end

function var_0_0.Open(arg_5_0, arg_5_1)
	WorldItem = var_1_10002
	arg_5_0.itemVO = var_1_10002.New(arg_5_1)

	arg_5_0:Update(arg_5_0.itemVO)

	setActive = var_2

	var_2(arg_5_0._tf, true)

	pg = var_2

	local var_5_0 = var_2.UIMgr.GetInstance()

	var_2.BlurPanel(var_5_0, arg_5_0._tf)

	return
end

function var_0_0.Close(arg_6_0)
	arg_6_0.itemVO = nil
	setActive = var_1

	var_1(arg_6_0._tf, false)

	pg = var_1

	local var_6_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_6_0, arg_6_0._tf, arg_6_0._parent)

	return
end

function var_0_0.Update(arg_7_0, arg_7_1)
	Drop = var_1_10002

	local var_7_0 = var_1_10002.New({
		type = arg_7_1.type,
		id = arg_7_1.id,
		count = arg_7_1.count
	})
	local var_7_1

	if arg_7_1:getConfig("item_transform_item_type") > 0 then
		var_7_0.count = arg_7_1:getConfig("item_transform_num")
		Drop = var_4
		var_7_1 = var_4.New({
			type = arg_7_1:getConfig("item_transform_item_type"),
			id = arg_7_1:getConfig("item_transform_item_id"),
			count = arg_7_1:getConfig("item_transform_item_number")
		})
	end

	setText = var_4

	local var_7_2 = arg_7_0.infoPanel
	local var_7_3 = var_5.Find(var_7_2, "top_text")

	i18n = var_7_2

	var_4(var_7_3, var_7_2("world_item_recycle_" .. (var_7_1 and 1 or 2)))

	setText = var_4

	local var_7_4 = arg_7_0.infoPanel
	local var_7_5 = var_5.Find(var_7_4, "bottom_text")

	i18n = var_7_4

	var_4(var_7_5, var_7_4("world_item_origin"))

	updateDrop = var_4

	local var_7_6 = arg_7_0.infoPanel

	var_4(var_5.Find(var_7_6, "before"), var_7_0)

	updateDrop = var_4

	local var_7_7 = arg_7_0.infoPanel
	local var_7_8 = var_5.Find(var_7_7, "after")

	defaultValue = var_7_7

	var_4(var_7_8, var_7_7(var_7_1, var_7_0))

	setActive = var_4

	local var_7_9 = arg_7_0.infoPanel

	var_4(var_5.Find(var_7_9, "after/destroy_mask"), not var_7_1)

	arg_7_0.infoList = arg_7_1:getConfig("item_origin")

	if #arg_7_0.infoList == 0 then
		table = var_4

		var_4.insert(arg_7_0.infoList, 1)
	end

	local var_7_10 = arg_7_0.fromItemList
	local var_7_11 = var_4.align

	math = var_6

	var_7_11(var_7_10, var_6.max(#arg_7_0.infoList, 3))

	return
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0:Close()

	pg = var_1

	var_1.DelegateInfo.Dispose(arg_8_0)

	return
end

return var_0_0

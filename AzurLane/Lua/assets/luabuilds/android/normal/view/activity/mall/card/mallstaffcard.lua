class = var_0_10000

local var_0_0 = var_0_10000("MallStaffCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform

	local var_1_0 = arg_1_0._tf

	arg_1_0.iconTF = var_2.Find(var_1_0, "icon")

	local var_1_1 = arg_1_0._tf
	local var_1_2 = var_2.Find(var_1_1, "name")
	local var_1_3 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.nameText = var_1_3(var_1_2, var_4(var_1_10005))

	local var_1_4 = arg_1_0._tf

	arg_1_0.selTF = var_2.Find(var_1_4, "sel")

	local var_1_5 = arg_1_0._tf

	arg_1_0.orderTF = var_2.Find(var_1_5, "mask/order")
	setText = var_2

	local var_1_6 = arg_1_0.orderTF
	local var_1_7 = var_3.Find(var_1_6, "Text")

	i18n = var_1_6

	var_2(var_1_7, var_1_6("mall_staff_in_order"))

	local var_1_8 = arg_1_0._tf

	arg_1_0.floorTF = var_2.Find(var_1_8, "mask/floor")

	local var_1_9 = {}
	local var_1_10 = arg_1_0._tf

	var_1_9[1] = var_3.Find(var_1_10, "attrs/1/Text")

	local var_1_11 = arg_1_0._tf

	var_1_9[2] = var_3.Find(var_1_11, "attrs/2/Text")

	local var_1_12 = arg_1_0._tf

	var_1_9[3] = var_3.Find(var_1_12, "attrs/3/Text")
	arg_1_0.attrTextTFs = var_1_9

	local var_1_13 = {}
	local var_1_14 = arg_1_0._tf

	var_1_13[1] = var_3.Find(var_1_14, "attrs/1")

	local var_1_15 = arg_1_0._tf

	var_1_13[2] = var_3.Find(var_1_15, "attrs/2")

	local var_1_16 = arg_1_0._tf

	var_1_13[3] = var_3.Find(var_1_16, "attrs/3")
	arg_1_0.attrBgTFs = var_1_13

	return
end

function var_0_0.Update(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	arg_2_0.staff = arg_2_1
	arg_2_0.id = arg_2_0.staff.id
	arg_2_0.tid = arg_2_0.staff.tid
	pg = var_5

	local var_2_0 = var_5.item_virtual_data_statistics[arg_2_0.tid].name

	arg_2_0.nameText.text = var_2_0

	var_0_0.StaticUpdateIcon(arg_2_0.iconTF, arg_2_0.tid)

	local var_2_1 = arg_2_0.staff

	arg_2_0.attrList = var_6.GetAttrList(var_2_1)

	local var_2_2

	var_2_2 = arg_2_4 or {}
	ipairs = var_2_1

	for iter_2_0, iter_2_1 in var_2_1(arg_2_0.attrList) do
		setText = var_1_10012

		var_1_10012(arg_2_0.attrTextTFs[iter_2_0], iter_2_1)

		table = var_1_10012

		if var_1_10012.contains(arg_2_4, iter_2_0) then
			GetImageSpriteFromAtlasAsync = var_1_10012

			var_1_10012("ui/mallstafftpl_atlas", "attr_bg2", arg_2_0.attrBgTFs[iter_2_0], true)
		else
			GetImageSpriteFromAtlasAsync = var_1_10012

			var_1_10012("ui/mallstafftpl_atlas", "attr_bg1", arg_2_0.attrBgTFs[iter_2_0], true)
		end
	end

	table = var_7

	local var_2_3 = var_7.indexof(arg_2_2, arg_2_0.id)

	setActive = var_8

	var_8(arg_2_0.selTF, var_2_3)

	local var_2_4

	if var_2_3 then
		setText = var_8
		var_2_4 = arg_2_0.selTF

		var_8(var_9.Find(var_2_4, "Text"), var_2_3)
	end

	local var_2_5 = arg_2_0.staff
	local var_2_6, var_2_7 = var_8.GetStatusInfos(var_2_5)

	setActive = var_2_4

	local var_2_8 = arg_2_0.orderTF

	MallStaff = var_1_10012

	var_2_4(var_2_8, var_2_6 == var_1_10012.STATUS.ORDER)

	setActive = var_2_4

	local var_2_9 = arg_2_0.floorTF

	MallStaff = var_12

	var_2_4(var_2_9, var_2_6 == var_12.STATUS.FLOOR and (arg_2_3 and not var_2_3 or not arg_2_3))

	MallStaff = var_2_4

	if var_2_6 == var_2_4.STATUS.FLOOR then
		setText = var_10

		local var_2_10 = arg_2_0.floorTF
		local var_2_11 = var_11.Find(var_2_10, "Text")

		i18n = var_2_10

		var_10(var_2_11, var_2_10("mall_staff_in_floor", var_2_7.floorId))
	end

	return
end

function var_0_0.Dispose(arg_3_0)
	return
end

function var_0_0.StaticUpdateIcon(arg_4_0, arg_4_1)
	pg = var_1_10002

	local var_4_0 = var_1_10002.activity_mall_staff_template[arg_4_1].icon_show

	GetImageSpriteFromAtlasAsync = var_1_10003

	var_1_10003("ui/mallstafftpl_atlas", var_4_0[1], arg_4_0:Find("body"))

	GetImageSpriteFromAtlasAsync = var_1_10003

	var_1_10003("ui/mallstafftpl_atlas", var_4_0[2], arg_4_0:Find("clothes"))

	GetImageSpriteFromAtlasAsync = var_1_10003

	var_1_10003("ui/mallstafftpl_atlas", var_4_0[3], arg_4_0:Find("face"))

	return
end

return var_0_0

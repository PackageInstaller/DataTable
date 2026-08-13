class = var_0_10000

local var_0_0 = var_0_10000("IslandItemCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform

	local var_1_0 = arg_1_0._tf
	local var_1_1 = var_2.Find(var_1_0, "name_bg/name")
	local var_1_2 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0.nameTxt = var_1_2(var_1_1, var_5(var_1_10007))

	local var_1_3 = arg_1_0._tf
	local var_1_4 = var_2.Find(var_1_3, "icon_bg/count_bg/count")
	local var_1_5 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0.cntTxt = var_1_5(var_1_4, var_5(var_1_10007))

	local var_1_6 = arg_1_0._tf

	arg_1_0.calcPanel = var_2.Find(var_1_6, "calc")

	local var_1_7 = arg_1_0._tf

	arg_1_0.reduceBtn = var_2.Find(var_1_7, "calc/btn")

	local var_1_8 = arg_1_0.calcPanel

	arg_1_0.valueInput = var_2.Find(var_1_8, "InputField")

	local var_1_9 = arg_1_0._tf

	arg_1_0.mask = var_2.Find(var_1_9, "mask")

	local var_1_10 = arg_1_0.mask
	local var_1_11 = var_2.Find(var_1_10, "Text")
	local var_1_12 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0.maskTxt = var_1_12(var_1_11, var_5(var_1_10007))

	return
end

function var_0_0.Update(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	arg_2_0.item = arg_2_1

	local var_2_0 = arg_2_0.nameTxt
	local var_2_1 = arg_2_0
	local var_2_2 = arg_2_0.ShortenString
	local var_2_3 = arg_2_1

	var_2_0.text = var_2_2(var_2_1, arg_2_1.GetName(var_2_3), 6)
	updateCustomDrop = var_2_0

	local var_2_4 = arg_2_0._tf

	Drop = var_2_1

	local var_2_5 = var_2_1.New
	local var_2_6 = {}

	DROP_TYPE_ISLAND_ITEM = var_2_3
	var_2_6.type = var_2_3
	var_2_6.id = arg_2_1.id
	var_2_6.count = arg_2_1:GetCount()

	var_2_0(var_2_4, var_2_5(var_2_6))

	IslandInventoryPage = var_2_0

	local var_2_7 = arg_2_2 == var_2_0.MODE_EDIT

	setActive = var_6

	var_6(arg_2_0.calcPanel, var_2_7)

	if var_2_7 then
		arg_2_0:UpdateValue(arg_2_3)
	end

	arg_2_0:UpdateTip(arg_2_1, arg_2_4)

	return
end

function var_0_0.UpdateTip(arg_3_0, arg_3_1, arg_3_2)
	IslandInventoryPage = var_1_10003

	if arg_3_2 ~= var_1_10003.INVENTORY_TYPE_OVERFLOW then
		setActive = var_3

		var_3(arg_3_0.mask, false)

		return
	end

	setActive = var_3

	var_3(arg_3_0.mask, true)

	getProxy = var_3
	IslandProxy = var_5

	local var_3_0 = var_3(var_5)
	local var_3_1 = var_3.GetIsland(var_3_0)
	local var_3_2 = var_3.GetInventoryAgency(var_3_1)
	local var_3_3 = arg_3_0.maskTxt

	if var_3_2:OwnItem() then
		i18n = var_3_4

		local var_3_4

		if not var_3_4("island_item_overflow", arg_3_1:GetCount()) then
			i18n = var_3_4
			var_3_4 = var_3_4("island_item_no_capacity")
		end

		var_3_3.text = var_3_4

		return
	end
end

function var_0_0.UpdateValue(arg_4_0, arg_4_1)
	setActive = var_1_10002

	var_1_10002(arg_4_0.calcPanel, arg_4_1 > 0)

	setInputText = var_1_10002

	var_1_10002(arg_4_0.valueInput, arg_4_1)

	return
end

function var_0_0.Dispose(arg_5_0)
	return
end

function var_0_0.ShortenString(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = 1
	local var_6_1 = 0
	local var_6_2 = 0
	local var_6_3 = #arg_6_1
	local var_6_4 = false

	while var_6_0 <= var_6_3 do
		string = var_1_10008
		var_1_10008 = var_1_10008.byte(arg_6_1, var_6_0)
		GetPerceptualSize = var_1_10009

		local var_6_5

		var_1_10009, var_6_5 = var_1_10009(var_1_10008)
		var_6_0 = var_6_0 + var_1_10009
		var_6_1 = var_6_1 + var_6_5
		math = var_11

		if var_11.ceil(var_6_1) == arg_6_2 - 1 then
			var_6_2 = var_6_0
		elseif arg_6_2 < var_11 then
			var_6_4 = true

			break
		end
	end

	if var_6_2 == 0 or var_6_3 < var_6_2 or not var_6_4 then
		return arg_6_1
	end

	string = var_1_10008

	return var_1_10008.sub(arg_6_1, 1, var_6_2 - 1) .. ".."
end

return var_0_0

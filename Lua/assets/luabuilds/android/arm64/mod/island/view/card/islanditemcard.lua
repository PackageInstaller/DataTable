local var_0_0 = class("IslandItemCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform
	arg_1_0.nameTxt = arg_1_0._tf:Find("name_bg/name"):GetComponent(typeof(Text))
	arg_1_0.cntTxt = arg_1_0._tf:Find("icon_bg/count_bg/count"):GetComponent(typeof(Text))
	arg_1_0.calcPanel = arg_1_0._tf:Find("calc")
	arg_1_0.reduceBtn = arg_1_0._tf:Find("calc/btn")
	arg_1_0.valueInput = arg_1_0.calcPanel:Find("InputField")
	arg_1_0.mask = arg_1_0._tf:Find("mask")
	arg_1_0.maskTxt = arg_1_0.mask:Find("Text"):GetComponent(typeof(Text))

	return
end

function var_0_0.Update(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	arg_2_0.item = arg_2_1
	arg_2_0.nameTxt.text = arg_2_0:ShortenString(arg_2_1:GetName(), 6)

	updateCustomDrop(arg_2_0._tf, Drop.New({
		type = DROP_TYPE_ISLAND_ITEM,
		id = arg_2_1.id,
		count = arg_2_1:GetCount()
	}))

	local var_2_0 = arg_2_2 == IslandInventoryPage.MODE_EDIT

	setActive(arg_2_0.calcPanel, arg_2_2 == IslandInventoryPage.MODE_EDIT)

	if var_2_0 then
		arg_2_0:UpdateValue(arg_2_3)
	end

	arg_2_0:UpdateTip(arg_2_1, arg_2_4)

	return
end

function var_0_0.UpdateTip(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_2 ~= IslandInventoryPage.INVENTORY_TYPE_OVERFLOW then
		setActive(arg_3_0.mask, false)

		return
	end

	setActive(arg_3_0.mask, true)

	local var_3_0 = arg_3_0.maskTxt

	var_3_0.text = getProxy(IslandProxy):GetIsland():GetInventoryAgency():OwnItem() and i18n("island_item_overflow", arg_3_1:GetCount()) or i18n("island_item_no_capacity")

	return
end

function var_0_0.UpdateValue(arg_4_0, arg_4_1)
	setActive(arg_4_0.calcPanel, arg_4_1 > 0)
	setInputText(arg_4_0.valueInput, arg_4_1)

	return
end

function var_0_0.Dispose(arg_5_0)
	return
end

function var_0_0.ShortenString(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = 1
	local var_6_1 = 0
	local var_6_2 = 0
	local var_6_3 = false

	while var_6_0 <= #arg_6_1 do
		local var_6_4, var_6_5 = GetPerceptualSize((string.byte(arg_6_1, var_6_0)))

		var_6_0 = var_6_0 + var_6_4
		var_6_1 = var_6_1 + var_6_5

		local var_6_6 = math.ceil(var_6_1)

		if var_6_6 == arg_6_2 - 1 then
			var_6_2 = var_6_0
		elseif arg_6_2 < var_6_6 then
			var_6_3 = true

			break
		end
	end

	if var_6_2 == 0 or #arg_6_1 < var_6_2 or not var_6_3 then
		return arg_6_1
	end

	return string.sub(arg_6_1, 1, var_6_2 - 1) .. ".."
end

return var_0_0

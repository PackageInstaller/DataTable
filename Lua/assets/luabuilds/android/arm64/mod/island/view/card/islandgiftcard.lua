local var_0_0 = class("IslandGiftCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._tf = arg_1_1.transform
	arg_1_0.itemTr = findTF(arg_1_0._tf, "IslandItemTpl")
	arg_1_0.countTr = arg_1_0.itemTr:Find("icon_bg/count_bg")
	arg_1_0.countTxt = arg_1_0.itemTr:Find("icon_bg/count_bg/count"):GetComponent(typeof(Text))
	arg_1_0.nameTF = findTF(arg_1_0._tf, "name/Text")
	arg_1_0.nameTxt = findTF(arg_1_0._tf, "name/Text"):GetComponent(typeof(Text))
	arg_1_0.selected = findTF(arg_1_0._tf, "selected")
	arg_1_0.heart = findTF(arg_1_0._tf, "heart")

	return
end

function var_0_0.Update(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.itemId = arg_2_2.id
	arg_2_0.item = arg_2_2

	updateCustomDrop(arg_2_0.itemTr, (Drop.New({
		type = DROP_TYPE_ISLAND_ITEM,
		id = arg_2_2.id,
		count = arg_2_2:GetCount()
	})))
	setActive(arg_2_0.countTr, true)
	setScrollText(arg_2_0.nameTF, arg_2_2:GetName())

	arg_2_0.countTxt.text = "X" .. arg_2_2:GetCount()

	arg_2_0:UpdateSelected(arg_2_3)
	setActive(arg_2_0.heart, table.contains(getProxy(IslandProxy):GetIsland():GetCharacterAgency():GetShipById(arg_2_1):GetFavoriteGift(), arg_2_0.itemId))

	return
end

function var_0_0.UpdateSelected(arg_3_0, arg_3_1)
	setActive(arg_3_0.selected, arg_3_1 == arg_3_0.itemId)

	return
end

function var_0_0.Dispose(arg_4_0)
	return
end

return var_0_0

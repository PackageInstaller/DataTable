class = var_0_10000

local var_0_0 = var_0_10000("IslandGiftCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._tf = arg_1_1.transform
	findTF = var_2
	arg_1_0.itemTr = var_2(arg_1_0._tf, "IslandItemTpl")

	local var_1_0 = arg_1_0.itemTr

	arg_1_0.countTr = var_2.Find(var_1_0, "icon_bg/count_bg")

	local var_1_1 = arg_1_0.itemTr
	local var_1_2 = var_2.Find(var_1_1, "icon_bg/count_bg/count")
	local var_1_3 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.countTxt = var_1_3(var_1_2, var_4(var_1_10005))
	findTF = var_2
	arg_1_0.nameTF = var_2(arg_1_0._tf, "name/Text")
	findTF = var_2

	local var_1_4 = var_2(arg_1_0._tf, "name/Text")
	local var_1_5 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.nameTxt = var_1_5(var_1_4, var_4(var_1_10005))
	findTF = var_2
	arg_1_0.selected = var_2(arg_1_0._tf, "selected")
	findTF = var_2
	arg_1_0.heart = var_2(arg_1_0._tf, "heart")

	return
end

function var_0_0.Update(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	getProxy = var_1_10004
	IslandProxy = var_1_10005

	local var_2_0 = var_1_10004(var_1_10005)
	local var_2_1 = var_4.GetIsland(var_2_0)
	local var_2_2 = var_4.GetCharacterAgency(var_2_1)
	local var_2_3 = var_4.GetShipById(var_2_2, arg_2_1)
	local var_2_4 = var_4.GetFavoriteGift(var_2_3)

	arg_2_0.itemId = arg_2_2.id
	arg_2_0.item = arg_2_2
	Drop = var_6

	local var_2_5 = var_6.New
	local var_2_6 = {}

	DROP_TYPE_ISLAND_ITEM = var_1_10008
	var_2_6.type = var_1_10008
	var_2_6.id = arg_2_2.id
	var_2_6.count = arg_2_2:GetCount()

	local var_2_7 = var_2_5(var_2_6)

	updateCustomDrop = var_2_6

	var_2_6(arg_2_0.itemTr, var_2_7)

	setActive = var_2_6

	var_2_6(arg_2_0.countTr, true)

	setScrollText = var_2_6

	var_2_6(arg_2_0.nameTF, arg_2_2:GetName())

	arg_2_0.countTxt.text = "X" .. arg_2_2:GetCount()

	arg_2_0:UpdateSelected(arg_2_3)

	setActive = var_7

	local var_2_8 = arg_2_0.heart

	table = var_9

	var_7(var_2_8, var_9.contains(var_2_4, arg_2_0.itemId))

	return
end

function var_0_0.UpdateSelected(arg_3_0, arg_3_1)
	setActive = var_1_10002

	var_1_10002(arg_3_0.selected, arg_3_1 == arg_3_0.itemId)

	return
end

function var_0_0.Dispose(arg_4_0)
	return
end

return var_0_0

local var_0_0 = class("AuctionGameMainEmojiListItem", import("view.base.BasePanel"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1.gameObject

	var_0_0.super.Ctor(arg_1_0, arg_1_0._go)

	arg_1_0._parentClass = arg_1_2

	arg_1_0:attach(arg_1_2)
	arg_1_0:Init()

	return
end

function var_0_0.Init(arg_2_0)
	arg_2_0.itemList = {}

	return
end

function var_0_0.didEnter(arg_3_0, arg_3_1)
	for iter_3_0 = 1, #arg_3_1 do
		arg_3_0.itemList[iter_3_0] = arg_3_0.itemList[iter_3_0] or AuctionGameMainEmojiItem.New(Instantiate(arg_3_0.uiEmojiItem, arg_3_0._tf), arg_3_0)

		arg_3_0.itemList[iter_3_0]:didEnter(arg_3_1[iter_3_0])
	end

	for iter_3_1 = #arg_3_1 + 1, #arg_3_0.itemList do
		arg_3_0.itemList[iter_3_1]:Show(false)
	end

	return
end

function var_0_0.willExit(arg_4_0)
	for iter_4_0, iter_4_1 in ipairs(arg_4_0.itemList) do
		iter_4_1:willExit()
	end

	arg_4_0.itemList = nil

	arg_4_0:detach()

	return
end

return var_0_0

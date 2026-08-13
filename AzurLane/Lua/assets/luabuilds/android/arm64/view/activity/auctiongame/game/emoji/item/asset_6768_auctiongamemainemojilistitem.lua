class = var_0_10000

local var_0_0 = "AuctionGameMainEmojiListItem"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BasePanel"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1.gameObject

	var_0_1.super.Ctor(arg_1_0, arg_1_0._go)

	arg_1_0._parentClass = arg_1_2

	arg_1_0:attach(arg_1_2)
	arg_1_0:Init()

	return
end

function var_0_1.Init(arg_2_0)
	arg_2_0.itemList = {}

	return
end

function var_0_1.didEnter(arg_3_0, arg_3_1)
	for iter_3_0 = 1, #arg_3_1 do
		local var_3_0 = arg_3_0.itemList
		local var_3_1

		if not arg_3_0.itemList[iter_3_0] then
			AuctionGameMainEmojiItem = var_3_1
			var_3_1 = var_3_1.New
			Instantiate = var_1_10009
			var_3_1 = var_3_1(var_1_10009(arg_3_0.uiEmojiItem, arg_3_0._tf), arg_3_0)
		end

		var_3_0[iter_3_0] = var_3_1

		local var_3_2 = arg_3_0.itemList[iter_3_0]

		var_6.didEnter(var_3_2, arg_3_1[iter_3_0])
	end

	for iter_3_1 = #arg_3_1 + 1, #arg_3_0.itemList do
		local var_3_3 = arg_3_0.itemList[iter_3_1]

		var_6.Show(var_3_3, false)
	end

	return
end

function var_0_1.willExit(arg_4_0)
	ipairs = var_1_10001

	for iter_4_0, iter_4_1 in var_1_10001(arg_4_0.itemList) do
		iter_4_1:willExit()
	end

	arg_4_0.itemList = nil

	arg_4_0:detach()

	return
end

return var_0_1

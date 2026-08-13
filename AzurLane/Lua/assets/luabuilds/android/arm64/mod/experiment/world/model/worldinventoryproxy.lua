class = var_0_10000

local var_0_0 = "WorldInventoryProxy"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...BaseEntity"))

var_0_1.Fields = {
	data = "table"
}
var_0_1.EventUpdateItem = "WorldInventoryProxy.EventUpdateItem"

function var_0_1.Build(arg_1_0)
	arg_1_0.data = {}

	return
end

function var_0_1.Setup(arg_2_0, arg_2_1)
	ipairs = var_1_10002

	for iter_2_0, iter_2_1 in var_1_10002(arg_2_1) do
		WorldItem = var_1_10007
		var_1_10007 = var_1_10007.New(iter_2_1)
		arg_2_0.data[var_1_10007.id] = var_1_10007

		arg_2_0:DispatchEvent(var_0_1.EventUpdateItem, var_1_10007:clone())
	end

	return
end

function var_0_1.GetItem(arg_3_0, arg_3_1)
	return arg_3_0.data[arg_3_1]
end

function var_0_1.GetItemCount(arg_4_0, arg_4_1)
	local var_4_0

	if not arg_4_0:GetItem(arg_4_1) or not var_2.count then
		var_4_0 = 0
	end

	return var_4_0
end

function var_0_1.AddItem(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0

	if arg_5_0:GetItem(arg_5_1) then
		var_5_0.count = var_5_0.count + arg_5_2
	else
		WorldItem = var_1_10004
		var_5_0 = var_1_10004.New({
			id = arg_5_1,
			count = arg_5_2
		})
		arg_5_0.data[arg_5_1] = var_5_0
	end

	arg_5_0:DispatchEvent(var_0_1.EventUpdateItem, var_5_0:clone())

	return
end

function var_0_1.RemoveItem(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_0:GetItem(arg_6_1) then
		arg_6_2 = arg_6_2 or var_3.count
		assert = var_1_10004

		var_1_10004(arg_6_2 <= var_3.count, "item count not enough: " .. var_3.id)

		var_3.count = var_3.count - arg_6_2

		if var_3.count == 0 then
			arg_6_0.data[arg_6_1] = nil
		end

		arg_6_0:DispatchEvent(var_0_1.EventUpdateItem, var_3:clone())
	end

	return
end

function var_0_1.UpdateItem(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_0:GetItem(arg_7_1) then
		var_3.count = arg_7_2

		arg_7_0:DispatchEvent(var_0_1.EventUpdateItem, var_3:clone())
	end

	return
end

function var_0_1.GetItemList(arg_8_0)
	_ = var_1_10001

	local var_8_0 = var_1_10001(arg_8_0.data)
	local var_8_1 = var_1.chain(var_8_0)
	local var_8_2 = var_1.values(var_8_1)
	local var_8_3 = var_1.filter(var_8_2, function(arg_9_0)
		return arg_9_0.count > 0
	end)

	return var_1.value(var_8_3)
end

function var_0_1.CalcResetExchangeResource(arg_10_0)
	local var_10_0 = {}

	pairs = var_1_10002

	for iter_10_0, iter_10_1 in var_1_10002(arg_10_0.data) do
		local var_10_1 = {
			type = iter_10_1:getConfig("item_transform_item_type"),
			id = iter_10_1:getConfig("item_transform_item_id")
		}
		local var_10_2 = iter_10_1

		var_10_1.count = iter_10_1.getConfig(var_10_2, "item_transform_item_number")

		if var_10_1.type > 0 then
			local var_10_3 = var_10_1.type
			local var_10_4

			if not var_10_0[var_10_1.type] then
				var_10_4 = {}
			end

			var_10_0[var_10_3] = var_10_4

			local var_10_5 = var_10_0[var_10_1.type]
			local var_10_6 = var_10_1.id

			defaultValue = var_10_2

			local var_10_7 = var_10_2(var_10_0[var_10_1.type][var_10_1.id], 0)

			math = var_11
			var_10_5[var_10_6] = var_10_7 + var_11.floor(iter_10_1.count / iter_10_1:getConfig("item_transform_num")) * var_10_1.count
		end
	end

	return var_10_0
end

function var_0_1.GetItemsByType(arg_11_0, arg_11_1)
	underscore = var_1_10002

	return var_1_10002.filter(arg_11_0:GetItemList(), function(arg_12_0)
		return arg_12_0:getWorldItemType() == arg_11_1
	end)
end

return var_0_1

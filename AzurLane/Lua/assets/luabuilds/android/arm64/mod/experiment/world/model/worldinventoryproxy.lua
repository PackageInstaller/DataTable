local var_0_0 = class("WorldInventoryProxy", import("...BaseEntity"))

var_0_0.Fields = {
	data = "table"
}
var_0_0.EventUpdateItem = "WorldInventoryProxy.EventUpdateItem"

function var_0_0.Build(arg_1_0)
	arg_1_0.data = {}

	return
end

function var_0_0.Setup(arg_2_0, arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		local var_2_0 = WorldItem.New(iter_2_1)

		arg_2_0.data[var_2_0.id] = var_2_0

		arg_2_0:DispatchEvent(var_0_0.EventUpdateItem, var_2_0:clone())
	end

	return
end

function var_0_0.GetItem(arg_3_0, arg_3_1)
	return arg_3_0.data[arg_3_1]
end

function var_0_0.GetItemCount(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0:GetItem(arg_4_1)

	if var_4_0 then
		return var_4_0.count or 0
	end
end

function var_0_0.AddItem(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0:GetItem(arg_5_1)

	if var_5_0 then
		var_5_0.count = var_5_0.count + arg_5_2
	else
		var_5_0 = WorldItem.New({
			id = arg_5_1,
			count = arg_5_2
		})
		arg_5_0.data[arg_5_1] = var_5_0
	end

	arg_5_0:DispatchEvent(var_0_0.EventUpdateItem, var_5_0:clone())

	return
end

function var_0_0.RemoveItem(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0:GetItem(arg_6_1)

	if var_6_0 then
		arg_6_2 = arg_6_2 or var_6_0.count

		assert(arg_6_2 <= var_6_0.count, "item count not enough: " .. var_6_0.id)

		var_6_0.count = var_6_0.count - arg_6_2

		if var_6_0.count == 0 then
			arg_6_0.data[arg_6_1] = nil
		end

		arg_6_0:DispatchEvent(var_0_0.EventUpdateItem, var_6_0:clone())
	end

	return
end

function var_0_0.UpdateItem(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0:GetItem(arg_7_1)

	if var_7_0 then
		var_7_0.count = arg_7_2

		arg_7_0:DispatchEvent(var_0_0.EventUpdateItem, var_7_0:clone())
	end

	return
end

function var_0_0.GetItemList(arg_8_0)
	return _(arg_8_0.data):chain():values():filter(function(arg_9_0)
		return arg_9_0.count > 0
	end):value()
end

function var_0_0.CalcResetExchangeResource(arg_10_0)
	for iter_10_0, iter_10_1 in pairs(arg_10_0.data) do
		local var_10_0 = {
			type = iter_10_1:getConfig("item_transform_item_type"),
			id = iter_10_1:getConfig("item_transform_item_id"),
			count = iter_10_1:getConfig("item_transform_item_number")
		}

		if var_10_0.type > 0 then
			local var_10_1 = ({})[var_10_0.type]

			if not ({})[var_10_0.type] then
				var_10_1 = {}
			end

			;({})[var_10_0.type] = var_10_1
			;({})[var_10_0.type][var_10_0.id] = defaultValue(({})[var_10_0.type][var_10_0.id], 0) + math.floor(iter_10_1.count / iter_10_1:getConfig("item_transform_num")) * var_10_0.count
		end
	end

	return {}
end

function var_0_0.GetItemsByType(arg_11_0, arg_11_1)
	return underscore.filter(arg_11_0:GetItemList(), function(arg_12_0)
		return arg_12_0:getWorldItemType() == arg_11_1
	end)
end

return var_0_0

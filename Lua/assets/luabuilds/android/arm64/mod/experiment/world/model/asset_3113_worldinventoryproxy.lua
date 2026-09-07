local WorldInventoryProxy = class("WorldInventoryProxy", import("...BaseEntity"))

WorldInventoryProxy.Fields = {
	data = "table"
}
WorldInventoryProxy.EventUpdateItem = "WorldInventoryProxy.EventUpdateItem"

function WorldInventoryProxy:Build()
	self.data = {}

	return
end

function WorldInventoryProxy:Setup(arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		local var_2_0 = WorldItem.New(iter_2_1)

		self.data[var_2_0.id] = var_2_0

		self:DispatchEvent(WorldInventoryProxy.EventUpdateItem, var_2_0:clone())
	end

	return
end

function WorldInventoryProxy:GetItem(arg_3_1)
	return self.data[arg_3_1]
end

function WorldInventoryProxy:GetItemCount(arg_4_1)
	local var_4_0 = self:GetItem(arg_4_1)

	return (var_4_0 or nil) and (var_4_0.count or 0)
end

function WorldInventoryProxy:AddItem(arg_5_1, arg_5_2)
	local var_5_0 = self:GetItem(arg_5_1)

	if var_5_0 then
		var_5_0.count = var_5_0.count + arg_5_2
	else
		var_5_0 = WorldItem.New({
			id = arg_5_1,
			count = arg_5_2
		})
		self.data[arg_5_1] = var_5_0
	end

	self:DispatchEvent(WorldInventoryProxy.EventUpdateItem, var_5_0:clone())

	return
end

function WorldInventoryProxy:RemoveItem(arg_6_1, arg_6_2)
	local var_6_0 = self:GetItem(arg_6_1)

	if var_6_0 then
		arg_6_2 = arg_6_2 or var_6_0.count

		assert(arg_6_2 <= var_6_0.count, "item count not enough: " .. var_6_0.id)

		var_6_0.count = var_6_0.count - arg_6_2

		if var_6_0.count == 0 then
			self.data[arg_6_1] = nil
		end

		self:DispatchEvent(WorldInventoryProxy.EventUpdateItem, var_6_0:clone())
	end

	return
end

function WorldInventoryProxy:UpdateItem(arg_7_1, arg_7_2)
	local var_7_0 = self:GetItem(arg_7_1)

	if var_7_0 then
		var_7_0.count = arg_7_2

		self:DispatchEvent(WorldInventoryProxy.EventUpdateItem, var_7_0:clone())
	end

	return
end

function WorldInventoryProxy:GetItemList()
	return _(self.data):chain():values():filter(function(arg_9_0)
		return arg_9_0.count > 0
	end):value()
end

function WorldInventoryProxy:CalcResetExchangeResource()
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in pairs(self.data) do
		local var_10_1 = {
			type = iter_10_1:getConfig("item_transform_item_type"),
			id = iter_10_1:getConfig("item_transform_item_id"),
			count = iter_10_1:getConfig("item_transform_item_number")
		}

		if var_10_1.type > 0 then
			var_10_0[var_10_1.type] = var_10_0[var_10_1.type] or {}
			var_10_0[var_10_1.type][var_10_1.id] = defaultValue(var_10_0[var_10_1.type][var_10_1.id], 0) + math.floor(iter_10_1.count / iter_10_1:getConfig("item_transform_num")) * var_10_1.count
		end
	end

	return var_10_0
end

function WorldInventoryProxy:GetItemsByType(arg_11_1)
	return underscore.filter(self:GetItemList(), function(arg_12_0)
		return arg_12_0:getWorldItemType() == arg_11_1
	end)
end

return WorldInventoryProxy

local IslandInventoryAgency = class("IslandInventoryAgency", import(".IslandBaseAgency"))

IslandInventoryAgency.ADD_ITEM = "IslandInventoryAgency.ADD_ITEM"
IslandInventoryAgency.REMOVE_ITEM = "IslandInventoryAgency.REMOVE_ITEM"

function IslandInventoryAgency:OnInit(arg_1_1)
	self.level = 1
	self.configId = self.level
	self.itemList = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.item_list or {}) do
		local var_1_0 = IslandItem.New(iter_1_1)

		self.itemList[var_1_0.id] = var_1_0
	end

	self.overflowItemList = {}

	for iter_1_2, iter_1_3 in ipairs(arg_1_1.item_list_cache or {}) do
		local var_1_1 = IslandItem.New(iter_1_3)

		self.overflowItemList[var_1_1.id] = var_1_1
	end

	return
end

function IslandInventoryAgency:InitPrivateData(arg_2_1)
	self.level = arg_2_1.storage_level

	return
end

function IslandInventoryAgency:GetOverflowItemList()
	return self.overflowItemList
end

function IslandInventoryAgency:RemoveOverflowItem(arg_4_1, arg_4_2)
	if not self.overflowItemList[arg_4_1] then
		return
	end

	local var_4_0 = math.max(0, self.overflowItemList[arg_4_1].count - arg_4_2)

	if var_4_0 <= 0 then
		self.overflowItemList[arg_4_1] = nil
	else
		self.overflowItemList[arg_4_1].count = var_4_0
	end

	return
end

function IslandInventoryAgency:AddOverFlowItem(arg_5_1)
	self.overflowItemList[arg_5_1.id] = arg_5_1

	return
end

function IslandInventoryAgency:GetItemList()
	return self.itemList
end

function IslandInventoryAgency:GetGroupedItemList()
	local var_7_0 = {}

	for iter_7_0, iter_7_1 in pairs(self.itemList) do
		local var_7_1 = iter_7_1:GetNumberOfSlotsOccupied()

		if var_7_1 <= 1 then
			table.insert(var_7_0, IslandItem.New({
				id = iter_7_0,
				num = iter_7_1:GetCount()
			}))
		else
			local var_7_2 = iter_7_1:getConfig("group_max")
			local var_7_3 = iter_7_1:GetCount() % var_7_2

			for iter_7_2 = 1, var_7_1 do
				table.insert(var_7_0, iter_7_2 == var_7_1 and var_7_3 > 0 and IslandItem.New({
					id = iter_7_0,
					num = var_7_3
				}) or IslandItem.New({
					id = iter_7_0,
					num = var_7_2
				}))
			end
		end
	end

	return var_7_0
end

function IslandInventoryAgency:TryAddItemFromOverflowList()
	local var_8_0, var_8_1 = self:SplitItemList4Add(self.overflowItemList)

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		self:AddItem(iter_8_1)
	end

	self.overflowItemList = {}

	for iter_8_2, iter_8_3 in ipairs(var_8_1) do
		self.overflowItemList[iter_8_3.id] = iter_8_3
	end

	return not self:ExistAnyOverFlowItem()
end

function IslandInventoryAgency:GetCanAddItemsFormOverFlowList()
	local var_9_0, var_9_1 = self:SplitItemList4Add(self.overflowItemList)

	return var_9_0
end

function IslandInventoryAgency:AddItem(arg_10_1)
	assert(isa(arg_10_1, IslandItem))

	local var_10_0 = arg_10_1:GetCount()

	if var_10_0 <= 0 then
		return
	end

	if self:OwnItem(arg_10_1.id) then
		self.itemList[arg_10_1.id]:IncreaseCount(var_10_0)
	else
		self.itemList[arg_10_1.id] = arg_10_1
	end

	self:DispatchEvent(IslandInventoryAgency.ADD_ITEM, arg_10_1.id)
	IslandTaskHelper.UpdateRuntimeTaskByTargetType(IslandTaskTargetType.RECYCLE)

	return
end

function IslandInventoryAgency:SplitItemList4Add(arg_11_1)
	local var_11_0 = {}
	local var_11_1 = {}

	table.sort(arg_11_1, CompareFuncs({
		function(arg_12_0)
			return arg_12_0:GetRarity() * -1
		end,
		function(arg_13_0)
			return arg_13_0.id
		end
	}))

	for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
		for iter_11_2 = 1, iter_11_1:GetCount() do
			if self:CanAddItem(iter_11_1.id, 1) then
				var_11_0[iter_11_1.id] = (var_11_0[iter_11_1.id] or 0) + 1
			else
				var_11_1[iter_11_1.id] = ((not var_11_1[iter_11_1.id] or nil) and 0) + 1
			end
		end
	end

	local var_11_4 = {}
	local var_11_5 = {}

	for iter_11_3, iter_11_4 in pairs(var_11_0) do
		table.insert(var_11_4, (IslandItem.New({
			id = iter_11_3,
			num = iter_11_4
		})))
	end

	for iter_11_5, iter_11_6 in pairs(var_11_1) do
		table.insert(var_11_5, (IslandItem.New({
			id = iter_11_5,
			num = iter_11_6
		})))
	end

	return var_11_4, var_11_5
end

function IslandInventoryAgency:TryAddItems(arg_14_1)
	if self:ExistAnyOverFlowItem() then
		return
	end

	local var_14_0, var_14_1 = self:SplitItemList4Add(arg_14_1)

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		self:AddItem(iter_14_1)
	end

	for iter_14_2, iter_14_3 in ipairs(var_14_1) do
		self.overflowItemList[iter_14_3.id] = iter_14_3
	end

	return not self:ExistAnyOverFlowItem()
end

function IslandInventoryAgency:ExistAnyOverFlowItem()
	return table.getCount(self.overflowItemList) > 0
end

function IslandInventoryAgency:CanAddItem(arg_16_1, arg_16_2)
	if self:ExistAnyOverFlowItem() then
		return false
	end

	local var_16_0 = self:GetLength()

	if self:OwnItem(arg_16_1) then
		local var_16_1 = self:GetItemById(arg_16_1)

		var_16_0 = var_16_0 + (IslandItem.New({
			id = arg_16_1,
			num = arg_16_2 + var_16_1:GetCount()
		}):GetNumberOfSlotsOccupied() - var_16_1:GetNumberOfSlotsOccupied())
	end

	local var_16_2 = self:GetCapacity()

	return var_16_0 < var_16_2, var_16_0 - var_16_2
end

function IslandInventoryAgency:RemoveItem(arg_17_1, arg_17_2)
	if not self:OwnItem(arg_17_1) then
		return
	end

	local var_17_0 = self.itemList[arg_17_1]

	if not self.itemList[arg_17_1]:CanRemove(arg_17_2) then
		return
	end

	var_17_0:ReduceCount(arg_17_2)

	if var_17_0:IsNotOwned() then
		self.itemList[arg_17_1] = nil
	end

	self:DispatchEvent(IslandInventoryAgency.REMOVE_ITEM, arg_17_1)
	IslandTaskHelper.UpdateRuntimeTaskByTargetType(IslandTaskTargetType.RECYCLE)

	return
end

function IslandInventoryAgency:GetItemById(arg_18_1)
	return self.itemList[arg_18_1]
end

function IslandInventoryAgency:OwnItem(arg_19_1)
	return self.itemList[arg_19_1] and not self.itemList[arg_19_1]:IsNotOwned()
end

function IslandInventoryAgency:GetOwnCount(arg_20_1)
	if not self.itemList[arg_20_1] then
		return 0
	else
		return self.itemList[arg_20_1]:GetCount()
	end

	return
end

function IslandInventoryAgency:GetCapacity()
	return self:getConfig("capacity") + self:GetHost():GetAblityAgency():GetInventoryMaxCntAddition()
end

function IslandInventoryAgency:GetNextCapacity(arg_22_1)
	if not pg.island_storage_level[arg_22_1] then
		return 0
	end

	return pg.island_storage_level[arg_22_1].capacity + self:GetHost():GetAblityAgency():GetInventoryMaxCntAddition()
end

function IslandInventoryAgency:StaticGetLength(arg_23_1)
	local var_23_0 = 0

	for iter_23_0, iter_23_1 in pairs(arg_23_1) do
		var_23_0 = var_23_0 + iter_23_1:GetNumberOfSlotsOccupied()
	end

	return var_23_0
end

function IslandInventoryAgency:GetLength()
	return self:StaticGetLength(self.itemList)
end

function IslandInventoryAgency:GetLevel()
	return self.level
end

function IslandInventoryAgency:getConfig(arg_26_1)
	return pg.island_storage_level[self.level][arg_26_1]
end

function IslandInventoryAgency:Upgrade()
	self.level = self.level + 1
	self.configId = self.level

	return
end

function IslandInventoryAgency:IsMaxLevel()
	return pg.island_storage_level.all[#pg.island_storage_level.all] <= self.level
end

function IslandInventoryAgency:CanUpgrade()
	return not self:IsMaxLevel()
end

function IslandInventoryAgency:GetUpgradeConsume()
	local var_30_0

	if self:IsMaxLevel() then
		do return {} end

		var_30_0 = {}
	end

	for iter_30_0, iter_30_1 in ipairs(pg.island_storage_level[self.level + 1].upgrade_material) do
		table.insert(var_30_0, iter_30_1)
	end

	return var_30_0
end

function IslandInventoryAgency:GetGifts()
	local var_31_0 = {}

	for iter_31_0, iter_31_1 in ipairs(pg.island_item_data_template.get_id_list_by_usage[IslandItemUsage.usage_ship_state]) do
		local var_31_1 = self:GetItemById(iter_31_1) or IslandItem.New({
			num = 0,
			id = iter_31_1
		})

		if var_31_1 then
			table.insert(var_31_0, var_31_1)
		end
	end

	return var_31_0
end

function IslandInventoryAgency:GetShipExpBooks()
	local var_32_0 = {}

	for iter_32_0, iter_32_1 in ipairs(pg.island_item_data_template.get_id_list_by_type[IslandItem.TYPE_SHIP_EXP_BOOK]) do
		local var_32_1 = self:GetItemById(iter_32_1) or IslandItem.New({
			num = 0,
			id = iter_32_1
		})

		if var_32_1 then
			table.insert(var_32_0, var_32_1)
		end
	end

	return var_32_0
end

function IslandInventoryAgency:GetFishingItems()
	local var_33_0 = {}

	for iter_33_0, iter_33_1 in pairs(self:GetItemList()) do
		if iter_33_1:IsFishingProp() then
			table.insert(var_33_0, iter_33_1)
		end
	end

	return var_33_0
end

function IslandInventoryAgency:OnSeasonReset()
	local var_34_0 = 0

	self.overflowItemList = {}

	for iter_34_0, iter_34_1 in pairs(self.itemList) do
		if iter_34_1:CanConvert() then
			var_34_0 = var_34_0 + iter_34_1:GetConvertPt() * iter_34_1:GetCount()
			self.itemList[iter_34_0] = nil
		end
	end

	return var_34_0
end

return IslandInventoryAgency

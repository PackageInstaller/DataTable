local var_0_0 = class("IslandInventoryAgency", import(".IslandBaseAgency"))

var_0_0.ADD_ITEM = "IslandInventoryAgency.ADD_ITEM"
var_0_0.REMOVE_ITEM = "IslandInventoryAgency.REMOVE_ITEM"

function var_0_0.OnInit(arg_1_0, arg_1_1)
	arg_1_0.level = 1
	arg_1_0.configId = arg_1_0.level
	arg_1_0.itemList = {}

	local var_1_0 = arg_1_1.item_list or {}

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		local var_1_1 = IslandItem.New(iter_1_1)

		arg_1_0.itemList[var_1_1.id] = var_1_1
	end

	arg_1_0.overflowItemList = {}

	local var_1_2 = arg_1_1.item_list_cache or {}

	for iter_1_2, iter_1_3 in ipairs(var_1_2) do
		local var_1_3 = IslandItem.New(iter_1_3)

		arg_1_0.overflowItemList[var_1_3.id] = var_1_3
	end

	return
end

function var_0_0.InitPrivateData(arg_2_0, arg_2_1)
	arg_2_0.level = arg_2_1.storage_level

	return
end

function var_0_0.GetOverflowItemList(arg_3_0)
	return arg_3_0.overflowItemList
end

function var_0_0.RemoveOverflowItem(arg_4_0, arg_4_1, arg_4_2)
	if not arg_4_0.overflowItemList[arg_4_1] then
		return
	end

	local var_4_0 = math.max(0, arg_4_0.overflowItemList[arg_4_1].count - arg_4_2)

	if var_4_0 <= 0 then
		arg_4_0.overflowItemList[arg_4_1] = nil
	else
		arg_4_0.overflowItemList[arg_4_1].count = var_4_0
	end

	return
end

function var_0_0.AddOverFlowItem(arg_5_0, arg_5_1)
	arg_5_0.overflowItemList[arg_5_1.id] = arg_5_1

	return
end

function var_0_0.GetItemList(arg_6_0)
	return arg_6_0.itemList
end

function var_0_0.GetGroupedItemList(arg_7_0)
	for iter_7_0, iter_7_1 in pairs(arg_7_0.itemList) do
		local var_7_0 = iter_7_1:GetNumberOfSlotsOccupied()

		if var_7_0 <= 1 then
			table.insert({}, IslandItem.New({
				id = iter_7_0,
				num = iter_7_1:GetCount()
			}))
		else
			local var_7_1 = iter_7_1:getConfig("group_max")
			local var_7_2 = iter_7_1:GetCount() % var_7_1

			for iter_7_2 = 1, var_7_0 do
				local var_7_3 = iter_7_2 == var_7_0 and var_7_2 > 0 and IslandItem.New({
					id = iter_7_0,
					num = var_7_2
				}) or IslandItem.New({
					id = iter_7_0,
					num = var_7_1
				})

				table.insert({}, var_7_3)
			end
		end
	end

	return {}
end

function var_0_0.TryAddItemFromOverflowList(arg_8_0)
	local var_8_0, var_8_1 = arg_8_0:SplitItemList4Add(arg_8_0.overflowItemList)

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		arg_8_0:AddItem(iter_8_1)
	end

	arg_8_0.overflowItemList = {}

	for iter_8_2, iter_8_3 in ipairs(var_8_1) do
		arg_8_0.overflowItemList[iter_8_3.id] = iter_8_3
	end

	return not arg_8_0:ExistAnyOverFlowItem()
end

function var_0_0.GetCanAddItemsFormOverFlowList(arg_9_0)
	local var_9_0, var_9_1 = arg_9_0:SplitItemList4Add(arg_9_0.overflowItemList)

	return var_9_0
end

function var_0_0.AddItem(arg_10_0, arg_10_1)
	assert(isa(arg_10_1, IslandItem))

	local var_10_0 = arg_10_1:GetCount()

	if var_10_0 <= 0 then
		return
	end

	if arg_10_0:OwnItem(arg_10_1.id) then
		arg_10_0.itemList[arg_10_1.id]:IncreaseCount(var_10_0)
	else
		arg_10_0.itemList[arg_10_1.id] = arg_10_1
	end

	arg_10_0:DispatchEvent(var_0_0.ADD_ITEM, arg_10_1.id)
	IslandTaskHelper.UpdateRuntimeTaskByTargetType(IslandTaskTargetType.RECYCLE)

	return
end

function var_0_0.SplitItemList4Add(arg_11_0, arg_11_1)
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
			if arg_11_0:CanAddItem(iter_11_1.id, 1) then
				local var_11_0 = ({})[iter_11_1.id]

				if not ({})[iter_11_1.id] then
					var_11_0 = 0
				end

				;({})[iter_11_1.id] = var_11_0 + 1
			else
				local var_11_1 = iter_11_1.id
				local var_11_2 = ({})[iter_11_1.id]

				if not ({})[iter_11_1.id] then
					var_11_2 = 0
				end

				;({})[var_11_1] = var_11_2 + 1
			end
		end
	end

	for iter_11_3, iter_11_4 in pairs({}) do
		table.insert({}, (IslandItem.New({
			id = iter_11_3,
			num = iter_11_4
		})))
	end

	for iter_11_5, iter_11_6 in pairs({}) do
		table.insert({}, (IslandItem.New({
			id = iter_11_5,
			num = iter_11_6
		})))
	end

	return {}, {}
end

function var_0_0.TryAddItems(arg_14_0, arg_14_1)
	if arg_14_0:ExistAnyOverFlowItem() then
		return
	end

	local var_14_0, var_14_1 = arg_14_0:SplitItemList4Add(arg_14_1)

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		arg_14_0:AddItem(iter_14_1)
	end

	for iter_14_2, iter_14_3 in ipairs(var_14_1) do
		arg_14_0.overflowItemList[iter_14_3.id] = iter_14_3
	end

	return not arg_14_0:ExistAnyOverFlowItem()
end

function var_0_0.ExistAnyOverFlowItem(arg_15_0)
	return table.getCount(arg_15_0.overflowItemList) > 0
end

function var_0_0.CanAddItem(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_0:ExistAnyOverFlowItem() then
		return false
	end

	local var_16_0 = arg_16_0:GetLength()

	if arg_16_0:OwnItem(arg_16_1) then
		local var_16_1 = arg_16_0:GetItemById(arg_16_1)

		var_16_0 = var_16_0 + (IslandItem.New({
			id = arg_16_1,
			num = arg_16_2 + var_16_1:GetCount()
		}):GetNumberOfSlotsOccupied() - var_16_1:GetNumberOfSlotsOccupied())
	end

	local var_16_2 = arg_16_0:GetCapacity()

	return var_16_0 < var_16_2, var_16_0 - var_16_2
end

function var_0_0.RemoveItem(arg_17_0, arg_17_1, arg_17_2)
	if not arg_17_0:OwnItem(arg_17_1) then
		return
	end

	local var_17_0 = arg_17_0.itemList[arg_17_1]

	if not arg_17_0.itemList[arg_17_1]:CanRemove(arg_17_2) then
		return
	end

	var_17_0:ReduceCount(arg_17_2)

	if var_17_0:IsNotOwned() then
		arg_17_0.itemList[arg_17_1] = nil
	end

	arg_17_0:DispatchEvent(var_0_0.REMOVE_ITEM, arg_17_1)
	IslandTaskHelper.UpdateRuntimeTaskByTargetType(IslandTaskTargetType.RECYCLE)

	return
end

function var_0_0.GetItemById(arg_18_0, arg_18_1)
	return arg_18_0.itemList[arg_18_1]
end

function var_0_0.OwnItem(arg_19_0, arg_19_1)
	return arg_19_0.itemList[arg_19_1] and not arg_19_0.itemList[arg_19_1]:IsNotOwned()
end

function var_0_0.GetOwnCount(arg_20_0, arg_20_1)
	if not arg_20_0.itemList[arg_20_1] then
		return 0
	else
		return arg_20_0.itemList[arg_20_1]:GetCount()
	end

	return
end

function var_0_0.GetCapacity(arg_21_0)
	return arg_21_0:getConfig("capacity") + arg_21_0:GetHost():GetAblityAgency():GetInventoryMaxCntAddition()
end

function var_0_0.GetNextCapacity(arg_22_0, arg_22_1)
	if not pg.island_storage_level[arg_22_1] then
		return 0
	end

	return pg.island_storage_level[arg_22_1].capacity + arg_22_0:GetHost():GetAblityAgency():GetInventoryMaxCntAddition()
end

function var_0_0.StaticGetLength(arg_23_0, arg_23_1)
	local var_23_0 = 0

	for iter_23_0, iter_23_1 in pairs(arg_23_1) do
		var_23_0 = var_23_0 + iter_23_1:GetNumberOfSlotsOccupied()
	end

	return var_23_0
end

function var_0_0.GetLength(arg_24_0)
	return arg_24_0:StaticGetLength(arg_24_0.itemList)
end

function var_0_0.GetLevel(arg_25_0)
	return arg_25_0.level
end

function var_0_0.getConfig(arg_26_0, arg_26_1)
	return pg.island_storage_level[arg_26_0.level][arg_26_1]
end

function var_0_0.Upgrade(arg_27_0)
	arg_27_0.level = arg_27_0.level + 1
	arg_27_0.configId = arg_27_0.level

	return
end

function var_0_0.IsMaxLevel(arg_28_0)
	return pg.island_storage_level.all[#pg.island_storage_level.all] <= arg_28_0.level
end

function var_0_0.CanUpgrade(arg_29_0)
	return not arg_29_0:IsMaxLevel()
end

function var_0_0.GetUpgradeConsume(arg_30_0)
	if arg_30_0:IsMaxLevel() then
		return {}
	end

	for iter_30_0, iter_30_1 in ipairs(pg.island_storage_level[arg_30_0.level + 1].upgrade_material) do
		table.insert({}, iter_30_1)
	end

	return {}
end

function var_0_0.GetGifts(arg_31_0)
	for iter_31_0, iter_31_1 in ipairs(pg.island_item_data_template.get_id_list_by_usage[IslandItemUsage.usage_ship_state]) do
		local var_31_0 = arg_31_0:GetItemById(iter_31_1) or IslandItem.New({
			num = 0,
			id = iter_31_1
		})

		if var_31_0 then
			table.insert({}, var_31_0)
		end
	end

	return {}
end

function var_0_0.GetShipExpBooks(arg_32_0)
	for iter_32_0, iter_32_1 in ipairs(pg.island_item_data_template.get_id_list_by_type[IslandItem.TYPE_SHIP_EXP_BOOK]) do
		local var_32_0 = arg_32_0:GetItemById(iter_32_1) or IslandItem.New({
			num = 0,
			id = iter_32_1
		})

		if var_32_0 then
			table.insert({}, var_32_0)
		end
	end

	return {}
end

function var_0_0.GetFishingItems(arg_33_0)
	for iter_33_0, iter_33_1 in pairs(arg_33_0:GetItemList()) do
		if iter_33_1:IsFishingProp() then
			table.insert({}, iter_33_1)
		end
	end

	return {}
end

function var_0_0.OnSeasonReset(arg_34_0)
	local var_34_0 = 0

	arg_34_0.overflowItemList = {}

	for iter_34_0, iter_34_1 in pairs(arg_34_0.itemList) do
		if iter_34_1:CanConvert() then
			var_34_0 = var_34_0 + iter_34_1:GetConvertPt() * iter_34_1:GetCount()
			arg_34_0.itemList[iter_34_0] = nil
		end
	end

	return var_34_0
end

return var_0_0

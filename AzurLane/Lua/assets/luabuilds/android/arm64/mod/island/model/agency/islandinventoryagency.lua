class = var_0_10000

local var_0_0 = "IslandInventoryAgency"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandBaseAgency"))

var_0_1.ADD_ITEM = "IslandInventoryAgency.ADD_ITEM"
var_0_1.REMOVE_ITEM = "IslandInventoryAgency.REMOVE_ITEM"

function var_0_1.OnInit(arg_1_0, arg_1_1)
	arg_1_0.level = 1
	arg_1_0.configId = arg_1_0.level
	arg_1_0.itemList = {}
	ipairs = var_2

	local var_1_0

	if not arg_1_1.item_list then
		var_1_0 = {}
	end

	for iter_1_0, iter_1_1 in var_2(var_1_0) do
		IslandItem = var_1_10007
		var_1_10007 = var_1_10007.New(iter_1_1)
		arg_1_0.itemList[var_1_10007.id] = var_1_10007
	end

	arg_1_0.overflowItemList = {}
	ipairs = var_2

	local var_1_1

	if not arg_1_1.item_list_cache then
		var_1_1 = {}
	end

	for iter_1_2, iter_1_3 in var_2(var_1_1) do
		IslandItem = var_1_10007
		var_1_10007 = var_1_10007.New(iter_1_3)
		arg_1_0.overflowItemList[var_1_10007.id] = var_1_10007
	end

	return
end

function var_0_1.InitPrivateData(arg_2_0, arg_2_1)
	arg_2_0.level = arg_2_1.storage_level

	return
end

function var_0_1.GetOverflowItemList(arg_3_0)
	return arg_3_0.overflowItemList
end

function var_0_1.RemoveOverflowItem(arg_4_0, arg_4_1, arg_4_2)
	if not arg_4_0.overflowItemList[arg_4_1] then
		return
	end

	math = var_3

	if var_3.max(0, arg_4_0.overflowItemList[arg_4_1].count - arg_4_2) <= 0 then
		arg_4_0.overflowItemList[arg_4_1] = nil
	else
		arg_4_0.overflowItemList[arg_4_1].count = var_3
	end

	return
end

function var_0_1.AddOverFlowItem(arg_5_0, arg_5_1)
	arg_5_0.overflowItemList[arg_5_1.id] = arg_5_1

	return
end

function var_0_1.GetItemList(arg_6_0)
	return arg_6_0.itemList
end

function var_0_1.GetGroupedItemList(arg_7_0)
	local var_7_0 = {}

	pairs = var_1_10002

	for iter_7_0, iter_7_1 in var_1_10002(arg_7_0.itemList) do
		if iter_7_1:GetNumberOfSlotsOccupied() <= 1 then
			table = var_8

			local var_7_1 = var_8.insert
			local var_7_2 = var_7_0

			IslandItem = var_1_10011

			var_7_1(var_7_2, var_1_10011.New({
				id = iter_7_0,
				num = iter_7_1:GetCount()
			}))
		else
			local var_7_3 = iter_7_1:getConfig("group_max")

			var_1_10011 = iter_7_1

			local var_7_4 = iter_7_1.GetCount(var_1_10011) % var_7_3

			for iter_7_2 = 1, var_7 do
				if iter_7_2 == var_7 and 0 < var_7_4 then
					IslandItem = var_1_10014

					if not var_1_10014.New({
						id = iter_7_0,
						num = var_7_4
					}) then
						IslandItem = var_1_10014
						var_1_10014 = var_1_10014.New({
							id = iter_7_0,
							num = var_7_3
						})
					end

					table = var_1_10015

					var_1_10015.insert(var_7_0, var_1_10014)
				end
			end
		end
	end

	return var_7_0
end

function var_0_1.TryAddItemFromOverflowList(arg_8_0)
	local var_8_0 = arg_8_0
	local var_8_1, var_8_2 = arg_8_0.SplitItemList4Add(var_8_0, arg_8_0.overflowItemList)

	ipairs = var_8_0

	for iter_8_0, iter_8_1 in var_8_0(var_8_1) do
		arg_8_0:AddItem(iter_8_1)
	end

	arg_8_0.overflowItemList = {}
	ipairs = var_3

	for iter_8_2, iter_8_3 in var_3(var_8_2) do
		arg_8_0.overflowItemList[iter_8_3.id] = iter_8_3
	end

	return not arg_8_0:ExistAnyOverFlowItem()
end

function var_0_1.GetCanAddItemsFormOverFlowList(arg_9_0)
	local var_9_0, var_9_1 = arg_9_0:SplitItemList4Add(arg_9_0.overflowItemList)

	return var_9_0
end

function var_0_1.AddItem(arg_10_0, arg_10_1)
	assert = var_1_10002
	isa = var_1_10004

	local var_10_0 = arg_10_1

	IslandItem = var_1_10007

	var_1_10002(var_1_10004(var_10_0, var_1_10007))

	if arg_10_1:GetCount() <= 0 then
		return
	end

	local var_10_1 = 0

	if arg_10_0:OwnItem(arg_10_1.id) then
		local var_10_2 = arg_10_0.itemList[arg_10_1.id].count
		local var_10_3 = arg_10_0.itemList[arg_10_1.id]

		var_4.IncreaseCount(var_10_3, var_2)
	else
		arg_10_0.itemList[arg_10_1.id] = arg_10_1
	end

	local var_10_4 = arg_10_0

	arg_10_0.DispatchEvent(var_10_4, var_0_1.ADD_ITEM, arg_10_1.id)

	IslandTaskHelper = var_4

	local var_10_5 = var_4.UpdateRuntimeTaskByTargetType

	IslandTaskTargetType = var_10_4

	var_10_5(var_10_4.RECYCLE)

	return
end

function var_0_1.SplitItemList4Add(arg_11_0, arg_11_1)
	local var_11_0 = {}
	local var_11_1 = {}

	table = var_1_10004

	local var_11_2 = var_1_10004.sort
	local var_11_3 = arg_11_1

	CompareFuncs = var_1_10007

	var_11_2(var_11_3, var_1_10007({
		function(arg_12_0)
			return arg_12_0:GetRarity() * -1
		end,
		function(arg_13_0)
			return arg_13_0.id
		end
	}))

	ipairs = var_11_2

	for iter_11_0, iter_11_1 in var_11_2(arg_11_1) do
		local var_11_4 = 1

		iter_11_2 = iter_11_1

		for iter_11_2 = var_11_4, iter_11_1.GetCount(iter_11_2) do
			if arg_11_0:CanAddItem(iter_11_1.id, 1) then
				local var_11_5 = iter_11_1.id
				local var_11_6

				if not var_11_0[iter_11_1.id] then
					var_11_6 = 0
				end

				var_11_0[var_11_5] = var_11_6 + 1
			else
				local var_11_7 = iter_11_1.id
				local var_11_8

				if not var_11_1[iter_11_1.id] then
					var_11_8 = 0
				end

				var_11_1[var_11_7] = var_11_8 + 1
			end
		end
	end

	local var_11_9 = {}
	local var_11_10 = {}

	pairs = var_6

	for iter_11_3, iter_11_4 in var_6(var_11_0) do
		IslandItem = var_1_10011
		var_1_10011 = var_1_10011.New({
			id = iter_11_3,
			num = iter_11_4
		})
		table = iter_11_2

		iter_11_2.insert(var_11_9, var_1_10011)
	end

	pairs = var_6

	for iter_11_5, iter_11_6 in var_6(var_11_1) do
		IslandItem = var_1_10011
		var_1_10011 = var_1_10011.New({
			id = iter_11_5,
			num = iter_11_6
		})
		table = iter_11_2

		iter_11_2.insert(var_11_10, var_1_10011)
	end

	return var_11_9, var_11_10
end

function var_0_1.TryAddItems(arg_14_0, arg_14_1)
	if arg_14_0:ExistAnyOverFlowItem() then
		return
	end

	local var_14_0 = arg_14_0
	local var_14_1, var_14_2 = arg_14_0.SplitItemList4Add(var_14_0, arg_14_1)

	ipairs = var_14_0

	for iter_14_0, iter_14_1 in var_14_0(var_14_1) do
		arg_14_0:AddItem(iter_14_1)
	end

	ipairs = var_4

	for iter_14_2, iter_14_3 in var_4(var_14_2) do
		arg_14_0.overflowItemList[iter_14_3.id] = iter_14_3
	end

	return not arg_14_0:ExistAnyOverFlowItem()
end

function var_0_1.ExistAnyOverFlowItem(arg_15_0)
	table = var_1_10001

	return var_1_10001.getCount(arg_15_0.overflowItemList) > 0
end

function var_0_1.CanAddItem(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_0:ExistAnyOverFlowItem() then
		return false
	end

	local var_16_0 = arg_16_0:GetLength()

	if arg_16_0:OwnItem(arg_16_1) then
		local var_16_1 = arg_16_0
		local var_16_2 = arg_16_0.GetItemById(var_16_1, arg_16_1)
		local var_16_3 = arg_16_2 + var_4.GetCount(var_16_2)

		IslandItem = var_16_1

		local var_16_4 = var_16_1.New({
			id = arg_16_1,
			num = var_16_3
		})

		var_16_0 = var_16_0 + (var_6.GetNumberOfSlotsOccupied(var_16_4) - var_4:GetNumberOfSlotsOccupied())
	end

	return var_16_0 < arg_16_0:GetCapacity(), var_16_0 - var_4
end

function var_0_1.RemoveItem(arg_17_0, arg_17_1, arg_17_2)
	if not arg_17_0:OwnItem(arg_17_1) then
		return
	end

	local var_17_0 = arg_17_0.itemList[arg_17_1]

	if not var_3.CanRemove(var_17_0, arg_17_2) then
		return
	end

	local var_17_1 = var_3.count

	var_3:ReduceCount(arg_17_2)

	if var_3:IsNotOwned() then
		arg_17_0.itemList[arg_17_1] = nil
	end

	local var_17_2 = arg_17_0

	arg_17_0.DispatchEvent(var_17_2, var_0_1.REMOVE_ITEM, arg_17_1)

	IslandTaskHelper = var_5

	local var_17_3 = var_5.UpdateRuntimeTaskByTargetType

	IslandTaskTargetType = var_17_2

	var_17_3(var_17_2.RECYCLE)

	return
end

function var_0_1.GetItemById(arg_18_0, arg_18_1)
	return arg_18_0.itemList[arg_18_1]
end

function var_0_1.OwnItem(arg_19_0, arg_19_1)
	return arg_19_0.itemList[arg_19_1] and not var_2:IsNotOwned()
end

function var_0_1.GetOwnCount(arg_20_0, arg_20_1)
	if not arg_20_0.itemList[arg_20_1] then
		return 0
	else
		return var_2:GetCount()
	end

	return
end

function var_0_1.GetCapacity(arg_21_0)
	local var_21_0 = arg_21_0:GetHost()
	local var_21_1 = var_1.GetAblityAgency(var_21_0)
	local var_21_2 = var_1.GetInventoryMaxCntAddition(var_21_1)

	return arg_21_0:getConfig("capacity") + var_21_2
end

function var_0_1.GetNextCapacity(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0:GetHost()
	local var_22_1 = var_2.GetAblityAgency(var_22_0)
	local var_22_2 = var_2.GetInventoryMaxCntAddition(var_22_1)

	pg = var_22_0

	if not var_22_0.island_storage_level[arg_22_1] then
		return 0
	end

	return var_4[arg_22_1].capacity + var_22_2
end

function var_0_1.StaticGetLength(arg_23_0, arg_23_1)
	local var_23_0 = 0

	pairs = var_1_10003

	for iter_23_0, iter_23_1 in var_1_10003(arg_23_1) do
		var_23_0 = var_23_0 + iter_23_1:GetNumberOfSlotsOccupied()
	end

	return var_23_0
end

function var_0_1.GetLength(arg_24_0)
	return arg_24_0:StaticGetLength(arg_24_0.itemList)
end

function var_0_1.GetLevel(arg_25_0)
	return arg_25_0.level
end

function var_0_1.getConfig(arg_26_0, arg_26_1)
	pg = var_1_10002

	return var_1_10002.island_storage_level[arg_26_0.level][arg_26_1]
end

function var_0_1.Upgrade(arg_27_0)
	arg_27_0.level = arg_27_0.level + 1
	arg_27_0.configId = arg_27_0.level

	return
end

function var_0_1.IsMaxLevel(arg_28_0)
	pg = var_1_10001

	return var_1_10001.island_storage_level.all[#var_1.all] <= arg_28_0.level
end

function var_0_1.CanUpgrade(arg_29_0)
	return not arg_29_0:IsMaxLevel()
end

function var_0_1.GetUpgradeConsume(arg_30_0)
	if arg_30_0:IsMaxLevel() then
		return {}
	end

	pg = var_1

	local var_30_0 = var_1.island_storage_level[arg_30_0.level + 1].upgrade_material
	local var_30_1 = {}

	ipairs = var_1_10004

	for iter_30_0, iter_30_1 in var_1_10004(var_30_0) do
		table = var_1_10009

		var_1_10009.insert(var_30_1, iter_30_1)
	end

	return var_30_1
end

function var_0_1.GetGifts(arg_31_0)
	local var_31_0 = {}

	pg = var_1_10002

	local var_31_1 = var_1_10002.island_item_data_template.get_id_list_by_usage

	IslandItemUsage = var_1_10003

	local var_31_2 = var_31_1[var_1_10003.usage_ship_state]

	ipairs = var_3

	for iter_31_0, iter_31_1 in var_3(var_31_2) do
		local var_31_3

		if not arg_31_0:GetItemById(iter_31_1) then
			IslandItem = var_1_10009
			var_31_3 = var_1_10009.New({
				num = 0,
				id = iter_31_1
			})
		end

		if var_31_3 then
			table = var_1_10009

			var_1_10009.insert(var_31_0, var_31_3)
		end
	end

	return var_31_0
end

function var_0_1.GetShipExpBooks(arg_32_0)
	local var_32_0 = {}

	pg = var_1_10002

	local var_32_1 = var_1_10002.island_item_data_template.get_id_list_by_type

	IslandItem = var_1_10003

	local var_32_2 = var_32_1[var_1_10003.TYPE_SHIP_EXP_BOOK]

	ipairs = var_3

	for iter_32_0, iter_32_1 in var_3(var_32_2) do
		local var_32_3

		if not arg_32_0:GetItemById(iter_32_1) then
			IslandItem = var_1_10009
			var_32_3 = var_1_10009.New({
				num = 0,
				id = iter_32_1
			})
		end

		if var_32_3 then
			table = var_1_10009

			var_1_10009.insert(var_32_0, var_32_3)
		end
	end

	return var_32_0
end

function var_0_1.GetFishingItems(arg_33_0)
	local var_33_0 = {}

	pairs = var_1_10002

	for iter_33_0, iter_33_1 in var_1_10002(arg_33_0:GetItemList()) do
		if iter_33_1:IsFishingProp() then
			table = var_7

			var_7.insert(var_33_0, iter_33_1)
		end
	end

	return var_33_0
end

function var_0_1.OnSeasonReset(arg_34_0)
	local var_34_0 = 0

	arg_34_0.overflowItemList = {}
	pairs = var_2

	for iter_34_0, iter_34_1 in var_2(arg_34_0.itemList) do
		if iter_34_1:CanConvert() then
			var_34_0 = var_34_0 + iter_34_1:GetConvertPt() * iter_34_1:GetCount()
			arg_34_0.itemList[iter_34_0] = nil
		end
	end

	return var_34_0
end

return var_0_1

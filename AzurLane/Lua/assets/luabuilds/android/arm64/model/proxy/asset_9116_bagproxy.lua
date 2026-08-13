class = var_0_10000

local var_0_0 = "BagProxy"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".NetProxy"))

var_0_1.ITEM_UPDATED = "item updated"

function var_0_1.register(arg_1_0)
	arg_1_0:on(15001, function(arg_2_0)
		arg_1_0.data = {}

		local var_2_0 = arg_1_0

		var_2_0.loveLetterRepairDic = {}
		ipairs = var_2_0

		for iter_2_0, iter_2_1 in var_2_0(arg_2_0.item_list) do
			Item = var_2_10006

			local var_2_1 = var_2_10006.New({
				id = iter_2_1.id,
				count = iter_2_1.count
			})

			var_2_10006.display(var_2_1, "loaded")

			arg_1_0.data[var_2_10006.id] = var_2_10006
		end

		local var_2_2 = arg_1_0

		var_2_2.limitList = {}
		ipairs = var_2_2

		for iter_2_2, iter_2_3 in var_2_2(arg_2_0.limit_list) do
			arg_1_0.limitList[iter_2_3.id] = iter_2_3.count
		end

		local var_2_3 = arg_1_0

		var_2_3.extraItemData = {}
		ipairs = var_2_3

		for iter_2_4, iter_2_5 in var_2_3(arg_2_0.item_misc_list) do
			local var_2_4 = arg_1_0.extraItemData
			local var_2_5 = iter_2_5.id
			local var_2_6

			if not arg_1_0.extraItemData[iter_2_5.id] then
				var_2_6 = {}
			end

			var_2_4[var_2_5] = var_2_6
			table = var_2_4

			var_2_4.insert(arg_1_0.extraItemData[iter_2_5.id], iter_2_5.data)
		end

		return
	end)

	return
end

function var_0_1.addExtraData(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_2 == nil then
		return
	end

	local var_3_0 = arg_3_0.extraItemData
	local var_3_1

	if not arg_3_0.extraItemData[arg_3_1] then
		var_3_1 = {}
	end

	var_3_0[arg_3_1] = var_3_1
	table = var_3_0

	var_3_0.insert(arg_3_0.extraItemData[arg_3_1], arg_3_2)

	return
end

function var_0_1.removeExtraData(arg_4_0, arg_4_1, arg_4_2)
	table = var_1_10003

	local var_4_0 = var_1_10003.removebyvalue
	local var_4_1

	if not arg_4_0.extraItemData[arg_4_1] then
		var_4_1 = {}
	end

	var_4_0(var_4_1, arg_4_2)

	return
end

function var_0_1.hasExtraData(arg_5_0, arg_5_1, arg_5_2)
	warning = var_1_10003
	PrintTable = var_1_10005

	local var_5_0

	if not arg_5_0.extraItemData[arg_5_1] then
		var_5_0 = {}
	end

	var_1_10003(var_1_10005(var_5_0))

	table = var_1_10003

	local var_5_1 = var_1_10003.contains
	local var_5_2

	if not arg_5_0.extraItemData[arg_5_1] then
		var_5_2 = {}
	end

	return var_5_1(var_5_2, arg_5_2)
end

function var_0_1.addItemById(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	assert = var_1_10004

	var_1_10004(arg_6_2 > 0, "count should greater than zero")

	ITEM_ID_CUBE = var_1_10004

	if arg_6_1 == var_1_10004 then
		pg = var_1_10004

		local var_6_0 = var_1_10004.TrackerMgr.GetInstance()
		local var_6_1 = var_4.Tracking

		TRACKING_CUBE_ADD = var_7

		var_6_1(var_6_0, var_7, arg_6_2)
	end

	for iter_6_0 = 1, arg_6_2 do
		arg_6_0:addExtraData(arg_6_1, arg_6_3)
	end

	arg_6_0:updateItem(arg_6_1, arg_6_2, arg_6_3)

	return
end

function var_0_1.removeItemById(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	assert = var_1_10004

	var_1_10004(arg_7_2 > 0, "count should greater than zero")

	ITEM_ID_CUBE = var_1_10004

	if arg_7_1 == var_1_10004 then
		pg = var_1_10004

		local var_7_0 = var_1_10004.TrackerMgr.GetInstance()
		local var_7_1 = var_4.Tracking

		TRACKING_CUBE_CONSUME = var_7

		var_7_1(var_7_0, var_7, arg_7_2)
	end

	for iter_7_0 = 1, arg_7_2 do
		arg_7_0:removeExtraData(arg_7_1, arg_7_3)
	end

	arg_7_0:updateItem(arg_7_1, -arg_7_2, arg_7_3)

	return
end

function var_0_1.getItemsByExclude(arg_8_0)
	local var_8_0 = {}

	pairs = var_1_10002

	for iter_8_0, iter_8_1 in var_1_10002(arg_8_0.data) do
		local var_8_1 = iter_8_1:getConfig("type")

		Item = var_1_10008

		if not var_1_10008.INVISIBLE_TYPE[var_8_1] then
			var_1_10008 = iter_8_1.count

			if 0 < var_1_10008 then
				if arg_8_0.extraItemData[iter_8_0] then
					var_1_10008 = iter_8_1.count
					ipairs = var_9

					for iter_8_2, iter_8_3 in var_9(arg_8_0.extraItemData[iter_8_0]) do
						table = var_1_10014
						var_1_10014 = var_1_10014.insert

						local var_8_2 = var_8_0

						Item = var_1_10017

						var_1_10014(var_8_2, var_1_10017.New({
							count = 1,
							id = iter_8_0,
							extra = iter_8_3
						}))

						var_1_10008 = var_1_10008 - 1
					end

					if 0 < var_1_10008 then
						table = var_9

						local var_8_3 = var_9.insert
						local var_8_4 = var_8_0

						Item = iter_8_2

						var_8_3(var_8_4, iter_8_2.New({
							id = iter_8_0,
							count = var_1_10008
						}))
					end
				else
					table = var_1_10008

					var_1_10008.insert(var_8_0, iter_8_1)
				end
			end
		end
	end

	return var_8_0
end

function var_0_1.getItemsByType(arg_9_0, arg_9_1)
	local var_9_0 = {}

	pairs = var_1_10003

	for iter_9_0, iter_9_1 in var_1_10003(arg_9_0.data) do
		if iter_9_1:getConfig("type") == arg_9_1 and iter_9_1.count ~= 0 then
			table = var_8

			var_8.insert(var_9_0, iter_9_1)
		end
	end

	Clone = var_3

	return var_3(var_9_0)
end

function var_0_1.ExitTypeItems(arg_10_0, arg_10_1)
	pairs = var_1_10002

	for iter_10_0, iter_10_1 in var_1_10002(arg_10_0.data) do
		if iter_10_1:getConfig("type") == arg_10_1 and iter_10_1.count > 0 then
			return true
		end
	end

	return false
end

function var_0_1.GetItemsByCondition(arg_11_0, arg_11_1)
	local var_11_0 = {}

	pairs = var_1_10003

	for iter_11_0, iter_11_1 in var_1_10003(arg_11_0.data) do
		local var_11_1 = true

		if arg_11_1 then
			pairs = var_1_10009

			for iter_11_2, iter_11_3 in var_1_10009(arg_11_1) do
				if iter_11_1:getConfig(iter_11_2) ~= iter_11_3 then
					var_11_1 = false

					break
				end
			end
		end

		if var_11_1 then
			table = var_1_10009

			var_1_10009.insert(var_11_0, iter_11_1)
		end
	end

	return var_11_0
end

function var_0_1.getItemById(arg_12_0, arg_12_1)
	if arg_12_0.data[arg_12_1] ~= nil then
		local var_12_0 = arg_12_0.data[arg_12_1]

		return var_2.clone(var_12_0)
	end

	return nil
end

function var_0_1.RawGetItemById(arg_13_0, arg_13_1)
	if arg_13_0.data[arg_13_1] ~= nil then
		return arg_13_0.data[arg_13_1]
	end

	return nil
end

function var_0_1.getItemCountById(arg_14_0, arg_14_1)
	local var_14_0

	if not arg_14_0.data[arg_14_1] or not arg_14_0.data[arg_14_1].count then
		var_14_0 = 0
	end

	if arg_14_0.extraItemData[arg_14_1] and #arg_14_0.extraItemData[arg_14_1] > 0 then
		math = var_3
		var_14_0 = var_3.max(var_14_0, 1)
	end

	return var_14_0
end

function var_0_1.getBoxCount(arg_15_0)
	local var_15_0 = arg_15_0
	local var_15_1 = arg_15_0.getItemsByType

	Item = var_1_10004

	local var_15_2 = var_15_1(var_15_0, var_1_10004.EQUIPMENT_BOX_TYPE_5)

	table = var_1_10002

	return var_1_10002.getCount(var_15_2)
end

function var_0_1.getCanComposeCount(arg_16_0)
	local var_16_0 = 0

	pg = var_1_10002

	local var_16_1 = var_1_10002.compose_data_template

	pairs = var_1_10003

	for iter_16_0, iter_16_1 in var_1_10003(var_16_1.all) do
		local var_16_2 = var_16_1[iter_16_1].material_id
		local var_16_3 = var_16_1[iter_16_1].material_num

		if arg_16_0:getItemById(var_16_2) and var_16_3 <= var_10.count then
			var_16_0 = var_16_0 + 1
		end
	end

	return var_16_0
end

function var_0_1.updateItem(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0

	if not arg_17_0.data[arg_17_1] then
		Item = var_17_0
		var_17_0 = var_17_0.New({
			count = 0,
			id = arg_17_1
		})
	end

	var_17_0.count = var_17_0.count + arg_17_2
	assert = var_5

	var_5(var_17_0.count >= 0, "item count error: " .. var_17_0.id)

	arg_17_0.data[var_17_0.id] = var_17_0

	local var_17_1 = arg_17_0.data[var_17_0.id]

	var_5.display(var_17_1, "updated")

	local var_17_2 = var_17_0:clone()

	var_17_2.extra = arg_17_3

	local var_17_3 = arg_17_0.facade

	var_6.sendNotification(var_17_3, var_0_1.ITEM_UPDATED, var_17_2)

	return
end

function var_0_1.canUpgradeFlagShipEquip(arg_18_0)
	getProxy = var_1_10001
	BayProxy = var_1_10003

	local var_18_0 = var_1_10001(var_1_10003)

	if var_1.getEquipment2ByflagShip(var_18_0) then
		pairs = var_1_10003

		for iter_18_0, iter_18_1 in var_1_10003(var_2:getConfig("trans_use_item")) do
			if not arg_18_0:getItemById(iter_18_1[1]) or var_8.count < iter_18_1[2] then
				return false
			end
		end

		return true
	end

	return
end

function var_0_1.AddLimitCnt(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_0.limitList
	local var_19_1

	if not arg_19_0.limitList[arg_19_1] then
		var_19_1 = 0
	end

	var_19_0[arg_19_1] = var_19_1 + arg_19_2

	return
end

function var_0_1.GetLimitCntById(arg_20_0, arg_20_1)
	local var_20_0

	if not arg_20_0.limitList[arg_20_1] then
		var_20_0 = 0
	end

	return var_20_0
end

function var_0_1.ClearLimitCnt(arg_21_0, arg_21_1)
	arg_21_0.limitList[arg_21_1] = 0

	return
end

function var_0_1.GetSkinShopDiscountItemList(arg_22_0)
	local var_22_0 = {}

	pairs = var_1_10002

	for iter_22_0, iter_22_1 in var_1_10002(arg_22_0.data) do
		if iter_22_1.count > 0 and iter_22_1:IsSkinShopDiscountType() then
			table = var_7

			var_7.insert(var_22_0, iter_22_1)
		end
	end

	return var_22_0
end

function var_0_1.GetExclusiveDiscountItem4Shop(arg_23_0, arg_23_1)
	local var_23_0 = {}

	pairs = var_1_10003

	for iter_23_0, iter_23_1 in var_1_10003(arg_23_0.data) do
		if iter_23_1.count > 0 and iter_23_1:IsExclusiveDiscountType() and iter_23_1:CanUseForShop(arg_23_1) then
			table = var_8

			var_8.insert(var_23_0, iter_23_1)
		end
	end

	return var_23_0
end

function var_0_1.SetLoveLetterRepairInfo(arg_24_0, arg_24_1, arg_24_2)
	arg_24_0.loveLetterRepairDic[arg_24_1] = arg_24_2

	return
end

function var_0_1.GetLoveLetterRepairInfo(arg_25_0, arg_25_1)
	return arg_25_0.loveLetterRepairDic[arg_25_1]
end

function var_0_1.GetSellingPrice(arg_26_0, arg_26_1)
	getProxy = var_1_10002
	BagProxy = var_1_10004

	local var_26_0 = var_1_10002(var_1_10004)
	local var_26_1 = {}

	pairs = var_1_10004

	for iter_26_0, iter_26_1 in var_1_10004(arg_26_1) do
		local var_26_2 = var_26_0:RawGetItemById(iter_26_1.id)
		local var_26_3

		if not var_9.GetPrice(var_26_2) then
			var_26_3 = {}
		end

		local var_26_4

		if not var_26_3[1] then
			var_26_4 = 0
		end

		local var_26_5

		if not var_26_3[2] then
			var_26_5 = 0
		end

		if not var_26_1[var_26_4] then
			var_26_1[var_26_4] = 0
		end

		var_26_1[var_26_4] = var_26_1[var_26_4] + var_26_5 * iter_26_1.count
	end

	local var_26_6 = {}

	pairs = var_5

	for iter_26_2, iter_26_3 in var_5(var_26_1) do
		if iter_26_2 > 0 and 0 < iter_26_3 then
			table = var_10

			local var_26_7 = var_10.insert
			local var_26_8 = var_26_6
			local var_26_9 = {}

			DROP_TYPE_RESOURCE = var_1_10014
			var_26_9[1] = var_1_10014
			var_26_9[2] = iter_26_2
			var_26_9[3] = iter_26_3

			var_26_7(var_26_8, var_26_9)
		end
	end

	return var_26_6
end

function var_0_1.GetSkinExperienceItems(arg_27_0)
	local var_27_0 = {}

	getProxy = var_1_10002
	BagProxy = var_1_10004

	local var_27_1 = var_1_10002(var_1_10004)
	local var_27_2 = var_2.getRawData(var_27_1)

	pairs = var_1_10004

	for iter_27_0, iter_27_1 in var_1_10004(var_27_2) do
		if iter_27_1.count > 0 and iter_27_1:IsSkinExperienceType() then
			table = var_9

			var_9.insert(var_27_0, iter_27_1)
		end
	end

	return var_27_0
end

function var_0_1.GetAllLoveLetterItem(arg_28_0)
	local var_28_0 = {}

	getProxy = var_1_10002
	LoveLetterProxy = var_1_10004

	local var_28_1 = var_1_10002(var_1_10004)
	local var_28_2 = var_2.GetLoveLetterItemDic(var_28_1)

	pairs = var_1_10003

	for iter_28_0, iter_28_1 in var_1_10003(arg_28_0.data) do
		assert = var_1_10008

		var_1_10008(not arg_28_0.extraItemData[iter_28_0] or iter_28_1.count == #arg_28_0.extraItemData[iter_28_0])

		for iter_28_2 = 1, iter_28_1.count do
			local var_28_3

			if not arg_28_0.extraItemData[iter_28_0] or not arg_28_0.extraItemData[iter_28_0][iter_28_2] then
				var_28_3 = nil
			end

			if not var_28_2[iter_28_0 .. "_" .. (var_28_3 or 0)] then
				break
			end

			table = var_13

			var_13.insert(var_28_0, {
				iter_28_0,
				var_28_3
			})
		end
	end

	return var_28_0
end

return var_0_1

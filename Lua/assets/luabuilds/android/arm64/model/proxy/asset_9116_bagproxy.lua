local BagProxy = class("BagProxy", import(".NetProxy"))

BagProxy.ITEM_UPDATED = "item updated"

function BagProxy:register()
	self:on(15001, function(arg_2_0)
		self.data = {}
		self.loveLetterRepairDic = {}

		for iter_2_0, iter_2_1 in ipairs(arg_2_0.item_list) do
			local var_2_0 = Item.New({
				id = iter_2_1.id,
				count = iter_2_1.count
			})

			var_2_0:display("loaded")

			self.data[var_2_0.id] = var_2_0
		end

		self.limitList = {}

		for iter_2_2, iter_2_3 in ipairs(arg_2_0.limit_list) do
			self.limitList[iter_2_3.id] = iter_2_3.count
		end

		self.extraItemData = {}

		for iter_2_4, iter_2_5 in ipairs(arg_2_0.item_misc_list) do
			self.extraItemData[iter_2_5.id] = self.extraItemData[iter_2_5.id] or {}

			table.insert(self.extraItemData[iter_2_5.id], iter_2_5.data)
		end

		return
	end)

	return
end

function BagProxy:addExtraData(arg_3_1, arg_3_2)
	if arg_3_2 == nil then
		return
	end

	self.extraItemData[arg_3_1] = self.extraItemData[arg_3_1] or {}

	table.insert(self.extraItemData[arg_3_1], arg_3_2)

	return
end

function BagProxy:removeExtraData(arg_4_1, arg_4_2)
	table.removebyvalue(self.extraItemData[arg_4_1] or {}, arg_4_2)

	return
end

function BagProxy:hasExtraData(arg_5_1, arg_5_2)
	warning(PrintTable(self.extraItemData[arg_5_1] or {}))

	return table.contains(self.extraItemData[arg_5_1] or {}, arg_5_2)
end

function BagProxy:addItemById(arg_6_1, arg_6_2, arg_6_3)
	assert(arg_6_2 > 0, "count should greater than zero")

	if arg_6_1 == ITEM_ID_CUBE then
		pg.TrackerMgr.GetInstance():Tracking(TRACKING_CUBE_ADD, arg_6_2)
	end

	for iter_6_0 = 1, arg_6_2 do
		self:addExtraData(arg_6_1, arg_6_3)
	end

	self:updateItem(arg_6_1, arg_6_2, arg_6_3)

	return
end

function BagProxy:removeItemById(arg_7_1, arg_7_2, arg_7_3)
	assert(arg_7_2 > 0, "count should greater than zero")

	if arg_7_1 == ITEM_ID_CUBE then
		pg.TrackerMgr.GetInstance():Tracking(TRACKING_CUBE_CONSUME, arg_7_2)
	end

	for iter_7_0 = 1, arg_7_2 do
		self:removeExtraData(arg_7_1, arg_7_3)
	end

	self:updateItem(arg_7_1, -arg_7_2, arg_7_3)

	return
end

function BagProxy:getItemsByExclude()
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in pairs(self.data) do
		if not Item.INVISIBLE_TYPE[iter_8_1:getConfig("type")] and iter_8_1.count > 0 then
			if self.extraItemData[iter_8_0] then
				local var_8_1 = iter_8_1.count

				for iter_8_2, iter_8_3 in ipairs(self.extraItemData[iter_8_0]) do
					table.insert(var_8_0, Item.New({
						count = 1,
						id = iter_8_0,
						extra = iter_8_3
					}))

					var_8_1 = var_8_1 - 1
				end

				if var_8_1 > 0 then
					table.insert(var_8_0, Item.New({
						id = iter_8_0,
						count = var_8_1
					}))
				end
			else
				table.insert(var_8_0, iter_8_1)
			end
		end
	end

	return var_8_0
end

function BagProxy:getItemsByType(arg_9_1)
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in pairs(self.data) do
		if iter_9_1:getConfig("type") == arg_9_1 and iter_9_1.count ~= 0 then
			table.insert(var_9_0, iter_9_1)
		end
	end

	return Clone(var_9_0)
end

function BagProxy:ExitTypeItems(arg_10_1)
	for iter_10_0, iter_10_1 in pairs(self.data) do
		if iter_10_1:getConfig("type") == arg_10_1 and iter_10_1.count > 0 then
			return true
		end
	end

	return false
end

function BagProxy:GetItemsByCondition(arg_11_1)
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in pairs(self.data) do
		local var_11_1 = true

		if arg_11_1 then
			for iter_11_2, iter_11_3 in pairs(arg_11_1) do
				if iter_11_1:getConfig(iter_11_2) ~= iter_11_3 then
					var_11_1 = false

					break
				end
			end
		end

		if var_11_1 then
			table.insert(var_11_0, iter_11_1)
		end
	end

	return var_11_0
end

function BagProxy:getItemById(arg_12_1)
	if self.data[arg_12_1] ~= nil then
		return self.data[arg_12_1]:clone()
	end

	return nil
end

function BagProxy:RawGetItemById(arg_13_1)
	if self.data[arg_13_1] ~= nil then
		return self.data[arg_13_1]
	end

	return nil
end

function BagProxy:getItemCountById(arg_14_1)
	local var_14_0

	if self.data[arg_14_1] then
		var_14_0 = self.data[arg_14_1].count or 0

		if self.extraItemData[arg_14_1] and #self.extraItemData[arg_14_1] > 0 then
			var_14_0 = math.max(var_14_0, 1)
		end
	end

	return var_14_0
end

function BagProxy:getBoxCount()
	return table.getCount((self:getItemsByType(Item.EQUIPMENT_BOX_TYPE_5)))
end

function BagProxy:getCanComposeCount()
	local var_16_0 = 0

	for iter_16_0, iter_16_1 in pairs(pg.compose_data_template.all) do
		local var_16_1 = self:getItemById(pg.compose_data_template[iter_16_1].material_id)

		if var_16_1 and pg.compose_data_template[iter_16_1].material_num <= var_16_1.count then
			var_16_0 = var_16_0 + 1
		end
	end

	return var_16_0
end

function BagProxy:updateItem(arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = self.data[arg_17_1] or Item.New({
		count = 0,
		id = arg_17_1
	})

	var_17_0.count = var_17_0.count + arg_17_2

	assert(var_17_0.count >= 0, "item count error: " .. var_17_0.id)

	self.data[var_17_0.id] = var_17_0

	self.data[var_17_0.id]:display("updated")

	local var_17_1 = var_17_0:clone()

	var_17_1.extra = arg_17_3

	self.facade:sendNotification(BagProxy.ITEM_UPDATED, var_17_1)

	return
end

function BagProxy:canUpgradeFlagShipEquip()
	local var_18_0 = getProxy(BayProxy):getEquipment2ByflagShip()

	if var_18_0 then
		for iter_18_0, iter_18_1 in pairs(var_18_0:getConfig("trans_use_item")) do
			local var_18_1 = self:getItemById(iter_18_1[1])

			if not var_18_1 or var_18_1.count < iter_18_1[2] then
				return false
			end
		end

		return true
	end

	return
end

function BagProxy:AddLimitCnt(arg_19_1, arg_19_2)
	self.limitList[arg_19_1] = (self.limitList[arg_19_1] or 0) + arg_19_2

	return
end

function BagProxy:GetLimitCntById(arg_20_1)
	return self.limitList[arg_20_1] or 0
end

function BagProxy:ClearLimitCnt(arg_21_1)
	self.limitList[arg_21_1] = 0

	return
end

function BagProxy:GetSkinShopDiscountItemList()
	local var_22_0 = {}

	for iter_22_0, iter_22_1 in pairs(self.data) do
		if iter_22_1.count > 0 and iter_22_1:IsSkinShopDiscountType() then
			table.insert(var_22_0, iter_22_1)
		end
	end

	return var_22_0
end

function BagProxy:GetExclusiveDiscountItem4Shop(arg_23_1)
	local var_23_0 = {}

	for iter_23_0, iter_23_1 in pairs(self.data) do
		if iter_23_1.count > 0 and iter_23_1:IsExclusiveDiscountType() and iter_23_1:CanUseForShop(arg_23_1) then
			table.insert(var_23_0, iter_23_1)
		end
	end

	return var_23_0
end

function BagProxy:SetLoveLetterRepairInfo(arg_24_1, arg_24_2)
	self.loveLetterRepairDic[arg_24_1] = arg_24_2

	return
end

function BagProxy:GetLoveLetterRepairInfo(arg_25_1)
	return self.loveLetterRepairDic[arg_25_1]
end

function BagProxy:GetSellingPrice(arg_26_1)
	local var_26_0 = getProxy(BagProxy)
	local var_26_1 = {}

	for iter_26_0, iter_26_1 in pairs(arg_26_1) do
		local var_26_2 = var_26_0:RawGetItemById(iter_26_1.id):GetPrice() or {}
		local var_26_3 = var_26_2[1] or 0

		var_26_1[var_26_3] = var_26_1[var_26_3] or 0
		var_26_1[var_26_3] = var_26_1[var_26_3] + (var_26_2[2] or 0) * iter_26_1.count
	end

	local var_26_4 = {}

	for iter_26_2, iter_26_3 in pairs(var_26_1) do
		if iter_26_2 > 0 and iter_26_3 > 0 then
			table.insert(var_26_4, {
				DROP_TYPE_RESOURCE,
				iter_26_2,
				iter_26_3
			})
		end
	end

	return var_26_4
end

function BagProxy:GetSkinExperienceItems()
	local var_27_0 = {}

	for iter_27_0, iter_27_1 in pairs((getProxy(BagProxy):getRawData())) do
		if iter_27_1.count > 0 and iter_27_1:IsSkinExperienceType() then
			table.insert(var_27_0, iter_27_1)
		end
	end

	return var_27_0
end

function BagProxy:GetAllLoveLetterItem()
	local var_28_0 = {}
	local var_28_1 = getProxy(LoveLetterProxy):GetLoveLetterItemDic()

	for iter_28_0, iter_28_1 in pairs(self.data) do
		assert(not self.extraItemData[iter_28_0] or iter_28_1.count == #self.extraItemData[iter_28_0])

		for iter_28_2 = 1, iter_28_1.count do
			local var_28_2

			if self.extraItemData[iter_28_0] then
				var_28_2 = self.extraItemData[iter_28_0][iter_28_2] or nil

				if not var_28_1[iter_28_0 .. "_" .. (var_28_2 or 0)] then
					break
				end
			end

			table.insert(var_28_0, {
				iter_28_0,
				var_28_2
			})
		end
	end

	return var_28_0
end

return BagProxy

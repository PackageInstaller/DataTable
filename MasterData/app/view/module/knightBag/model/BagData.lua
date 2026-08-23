local BagData = class("BagData")
local var_0_1 = g.core.const.ConstMgr.BAG_TYPE
local var_0_2 = g.core.config.parameter_info
local var_0_3 = g.core.const.ConstMgr.FurnitureConst
local var_0_4 = g.core.common.ServerTime

BagData.IGNORE_NEW_DATA = {
	[g.core.const.ConstMgr.BAG_TYPE.KNIGHT] = {
		[400070] = true,
		[400130] = true,
		[210000] = true,
		[400060] = true,
		[400050] = true,
		[200000] = true
	},
	[g.core.const.ConstMgr.BAG_TYPE.UNITE_TOKEN] = {
		[40020] = true,
		[40010] = true,
		[40030] = true
	}
}

function BagData:ctor()
	self:initData()
end

function BagData:initData()
	self._bagList = {}
	self._bagIndexList = {}
	self._difBagIndexList = {}
	self._flushFlag = false
	self._newData = {}
	self._allNew = {}
	self._newObtain = nil
	self._treasureIdMap = {}
	self._treasureList = {}
	self._equipIdMap = {}
	self._equipList = {}
	self._boxTypeList = {}
	self._sceneSkillitems = nil
	self._isSceneSKinGet = false
end

function BagData:reset()
	self._bagList = {}
	self._bagIndexList = {}
	self._boxTypeList = {}
	self._difBagIndexList = {}
	self._flushFlag = false
	self._newData = {}
	self._allNew = {}
	self._treasureIdMap = {}
	self._treasureList = {}
end

function BagData:initList(arg_4_1, arg_4_2)
	if not arg_4_2 then
		return
	end

	if self._bagList[arg_4_1] and #arg_4_2 < #self._bagList[arg_4_1] and arg_4_1 ~= var_0_1.TREASURE then
		self._bagList[arg_4_1] = {}
		self._bagIndexList[arg_4_1] = {}
		self._difBagIndexList[arg_4_1] = {}
	end

	self:addList(arg_4_1, arg_4_2, true)
end

function BagData:addList(arg_5_1, arg_5_2, arg_5_3)
	if not arg_5_2 then
		return
	end

	self:checkList(arg_5_1)

	if not arg_5_3 then
		self:setDifCount(arg_5_1, arg_5_2)
	end

	for iter_5_0 = 1, #arg_5_2 do
		self:addItem(arg_5_1, arg_5_2[iter_5_0], arg_5_3)
	end

	if not arg_5_3 then
		self._newData[tostring(arg_5_1)] = self._newData[tostring(arg_5_1)] or {}

		for iter_5_1, iter_5_2 in ipairs(arg_5_2) do
			if iter_5_2.id and self:checkValidNewData(arg_5_1, iter_5_2) then
				if arg_5_1 == var_0_1.ARTIFACT then
					self._newData[tostring(arg_5_1)][string.format("%d", iter_5_2.base_id)] = true
				else
					self._newData[tostring(arg_5_1)][string.format("%d", iter_5_2.id)] = true
				end
			end
		end
	end

	if arg_5_1 == var_0_1.TREASURE then
		self:addTreasureList(arg_5_2)
	end

	if arg_5_1 == var_0_1.EQUIPMENT then
		self:addEquipList(arg_5_2)
	end

	if arg_5_1 == var_0_1.FURNISHING then
		g.core.common.Storage:save("bag.json", self._newData)
	end
end

function BagData:addItem(arg_6_1, arg_6_2, arg_6_3)
	if self._bagIndexList[arg_6_1][arg_6_2.id] then
		self:updateItem(arg_6_1, arg_6_2)
	else
		self._bagIndexList[arg_6_1][arg_6_2.id] = arg_6_2

		table.insert(self._bagList[arg_6_1], #self._bagList[arg_6_1] + 1, arg_6_2)
		self:checkNewObtain(arg_6_1, arg_6_2.id, arg_6_2.num)
	end

	if not arg_6_3 then
		self:checkQuickBoxItem(arg_6_1, arg_6_2.id)
	end
end

function BagData:updateList(arg_7_1, arg_7_2)
	if not arg_7_2 then
		return
	end

	self:checkList(arg_7_1)
	self:setDifCount(arg_7_1, arg_7_2)

	for iter_7_0 = 1, #arg_7_2 do
		self:updateItem(arg_7_1, arg_7_2[iter_7_0])
	end

	if arg_7_1 == var_0_1.TREASURE then
		self:updateTreasureList(arg_7_2)
	end

	if arg_7_1 == var_0_1.EQUIPMENT then
		self:updateEquipList(arg_7_2)
	end
end

function BagData:updateItem(arg_8_1, arg_8_2)
	self:checkList(arg_8_1)

	if self._bagIndexList[arg_8_1][arg_8_2.id] then
		for iter_8_0, iter_8_1 in pairs(arg_8_2) do
			self._bagIndexList[arg_8_1][arg_8_2.id][iter_8_0] = iter_8_1
		end

		self:checkNewObtain(arg_8_1, arg_8_2.id, arg_8_2.num)
	else
		self:addItem(arg_8_1, arg_8_2)
	end
end

function BagData:removeList(arg_9_1, arg_9_2)
	if not arg_9_2 then
		return
	end

	for iter_9_0 = 1, #arg_9_2 do
		self:setDifCount(arg_9_1, {
			{
				num = 0,
				id = arg_9_2[iter_9_0]
			}
		})
		self:removeItem(arg_9_1, arg_9_2[iter_9_0])
	end

	if arg_9_1 == var_0_1.TREASURE then
		self:removeTreasureList(arg_9_2)
	end

	if arg_9_1 == var_0_1.EQUIPMENT then
		self:removeTreasureList(arg_9_2)
	end
end

function BagData:removeItem(arg_10_1, arg_10_2)
	if self._bagList[arg_10_1] then
		for iter_10_0, iter_10_1 in ipairs(self._bagList[arg_10_1]) do
			if arg_10_2 == iter_10_1.id then
				table.remove(self._bagList[arg_10_1], iter_10_0)

				break
			end
		end
	end

	self._bagIndexList[arg_10_1] = self._bagIndexList[arg_10_1] or {}
	self._bagIndexList[arg_10_1][arg_10_2] = nil

	self:checkNewObtain(arg_10_1, arg_10_2)
end

function BagData:getList(arg_11_1)
	self:checkList(arg_11_1)

	return self._bagList[arg_11_1]
end

function BagData:getDataByTypeAndSid(arg_12_1, arg_12_2)
	local var_12_0

	for iter_12_0, iter_12_1 in ipairs((self:getList(arg_12_1))) do
		if iter_12_1.id == arg_12_2 then
			var_12_0 = iter_12_1

			break
		end
	end

	return var_12_0
end

function BagData:getContainSpecificPropSelectBox(arg_13_1, arg_13_2)
	local var_13_0 = {}
	local var_13_1 = {}

	for iter_13_0, iter_13_1 in g.core.config.drop_info.ipairs() do
		for iter_13_2 = 1, iter_13_1.getKeyLength("reward_type_%d+") do
			if iter_13_1["reward_type_" .. iter_13_2] <= 0 then
				break
			elseif arg_13_1 == g.core.common.Goods.TYPE_FRAGMENT then
				local var_13_2 = g.core.config.fragment_info.get(arg_13_2)

				if iter_13_1["reward_type_" .. iter_13_2] == arg_13_1 and iter_13_1["reward_value_" .. iter_13_2] == arg_13_2 then
					var_13_1[iter_13_1.id] = {}

					break
				elseif iter_13_1["reward_type_" .. iter_13_2] == var_13_2.fragment_type and iter_13_1["reward_value_" .. iter_13_2] == var_13_2.fragment_value then
					var_13_1[iter_13_1.id] = {
						isWholeBox = true
					}

					break
				end
			elseif iter_13_1["reward_type_" .. iter_13_2] == arg_13_1 and iter_13_1["reward_value_" .. iter_13_2] == arg_13_2 then
				var_13_1[iter_13_1.id] = {}

				break
			end
		end
	end

	local var_13_3 = clone(self:getList(g.core.const.ConstMgr.BAG_TYPE.ITEM))

	for iter_13_3, iter_13_4 in ipairs(var_13_3) do
		local var_13_4 = g.core.config.item_info.get(iter_13_4.id)

		if var_13_4.item_type == 4 and var_13_4.if_show == 1 and var_13_1[var_13_4.item_value] then
			if var_13_1[var_13_4.item_value].isWholeBox then
				iter_13_4.isWholeBox = true
			else
				var_13_3.isWholeBox = false
			end

			table.insert(var_13_0, iter_13_4)
		end
	end

	table.sort(var_13_0, function(arg_14_0, arg_14_1)
		local var_14_0 = g.core.config.item_info.get(arg_14_0.id)
		local var_14_1 = g.core.config.item_info.get(arg_14_1.id)

		if arg_14_0.isWholeBox ~= arg_14_1.isWholeBox then
			return arg_14_1.isWholeBox
		end

		if var_14_0.quality ~= var_14_1.quality then
			return var_14_0.quality < var_14_1.quality
		end

		if arg_14_0.num ~= arg_14_1.num then
			return arg_14_0.num > arg_14_1.num
		end
	end)

	return var_13_0
end

function BagData:getIndexList(arg_15_1)
	self:checkList(arg_15_1)

	return self._bagIndexList[arg_15_1]
end

function BagData:getCount(arg_16_1)
	self:checkList(arg_16_1)

	return #self._bagList[arg_16_1]
end

function BagData:getCountById(arg_17_1, arg_17_2)
	if arg_17_1 == g.core.common.Goods.TYPE_EXPIRABLE_ITEM then
		return self:getOwnNum(arg_17_1, arg_17_2)
	end

	local var_17_0 = self:getIndexList(arg_17_1)

	if not var_17_0[arg_17_2] then
		return 0
	end

	local var_17_1 = var_17_0[arg_17_2].num

	if arg_17_1 == var_0_1.FURNISHING then
		var_17_1 = self:_defaultFurnitureSpecialCount(var_17_1, arg_17_2)
	end

	return var_17_1
end

function BagData:isItemExpired(arg_18_1, arg_18_2)
	local var_18_0 = self:getIndexList(arg_18_1)

	if not var_18_0[arg_18_2] then
		return false
	end

	if arg_18_1 ~= g.core.common.Goods.TYPE_ITEM then
		return false
	end

	local var_18_1 = g.core.config.item_info.fetch(arg_18_2)

	if not var_18_1 then
		return false
	end

	if var_18_1.limited_time > 0 or (var_18_0[arg_18_2].time or 0) > 0 then
		if var_0_4:getLeftSeconds((var_18_1.limited_time > 0 or nil) and var_18_1.limited_time) <= 0 then
			return true
		else
			return false
		end
	else
		return false
	end
end

function BagData:getItemTimeLimit(arg_19_1, arg_19_2)
	if not arg_19_1 or not arg_19_2 then
		return 0
	end

	if arg_19_1 == g.core.const.ConstMgr.BAG_TYPE.RESOURCE then
		return 0
	end

	local var_19_0 = 0
	local var_19_1 = self:getItem(arg_19_1, arg_19_2)

	if var_19_1 and var_19_1.time then
		var_19_0 = var_19_1.time
	end

	if arg_19_1 == g.core.const.ConstMgr.BAG_TYPE.ITEM then
		local var_19_2 = g.core.config.item_info.fetch(arg_19_2)

		if var_19_2 and var_19_2.limited_time > 0 then
			var_19_0 = var_19_2.limited_time
		end
	end

	return var_19_0
end

function BagData:getItem(arg_20_1, arg_20_2)
	self:checkList(arg_20_1)

	return self._bagIndexList[arg_20_1][arg_20_2]
end

function BagData:checkList(arg_21_1)
	if not self._bagList[arg_21_1] then
		self._bagList[arg_21_1] = {}
		self._bagIndexList[arg_21_1] = {}
		self._difBagIndexList[arg_21_1] = {}
	end
end

function BagData:isOwnItem(arg_22_1, arg_22_2)
	if not self._bagIndexList[arg_22_1] then
		return false
	end

	if self._bagIndexList[arg_22_1][arg_22_2] ~= nil and self._bagIndexList[arg_22_1][arg_22_2].num > 0 then
		return true
	else
		return false
	end
end

function BagData:getOwnNum(arg_23_1, arg_23_2)
	if arg_23_1 == 999 then
		if arg_23_2 == 0 then
			return g.core.model.User:getFreeGold()
		elseif arg_23_2 == 1 then
			return g.core.model.User:getGold()
		end
	end

	if arg_23_1 == g.core.common.Goods.TYPE_RESOURCE then
		if arg_23_2 == g.core.common.Goods.RESOURCE.TYPE_FREE_GOLD then
			return g.core.model.User:getFreeGold()
		elseif arg_23_2 == g.core.common.Goods.RESOURCE.TYPE_GOLD then
			return g.core.model.User:getGold()
		end
	end

	if arg_23_1 == var_0_1.TREASURE then
		return #(self._treasureList[arg_23_2] or {})
	end

	if arg_23_1 == var_0_1.EQUIPMENT then
		return #(self._equipList[arg_23_2] or {})
	end

	if arg_23_1 == var_0_1.EXPIRABLE_ITEM then
		local var_23_2 = 0
		local var_23_3 = self._bagIndexList[arg_23_1] or {}
		local var_23_4 = var_0_4:getTime()

		for iter_23_0, iter_23_1 in pairs(var_23_3) do
			if iter_23_1.base_id == arg_23_2 and var_23_4 < iter_23_1.expire_time then
				var_23_2 = var_23_2 + iter_23_1.num
			end
		end

		return var_23_2
	end

	if arg_23_1 == g.core.common.Goods.TYPE_ITEM and arg_23_2 == g.core.common.Goods.ITEM.TYPE_ANCIENTS_DICE then
		return g.core.model.User.ancientsData:getSelfDiceNum()
	end

	if not self._bagIndexList[arg_23_1] then
		return 0
	end

	local var_23_5 = self._bagIndexList[arg_23_1][arg_23_2]

	if not self._bagIndexList[arg_23_1][arg_23_2] then
		return 0
	end

	if var_23_5.num then
		if arg_23_1 == var_0_1.FURNISHING then
			return self:_defaultFurnitureSpecialCount(var_23_5.num, arg_23_2)
		end

		return var_23_5.num
	end

	return 1
end

function BagData:checkNewObtain(arg_24_1, arg_24_2, arg_24_3)
	if arg_24_1 ~= g.core.const.ConstMgr.BAG_TYPE.ITEM or self._newObtain == nil then
		return
	end

	local var_24_0 = tostring(arg_24_2)

	if arg_24_3 then
		if g.core.config.item_info.get(arg_24_2).if_new_obtain == 1 then
			local var_24_1 = false

			if self._newObtain[var_24_0] then
				if arg_24_3 > self._newObtain[var_24_0].size then
					var_24_1 = true
					self._newObtain[var_24_0] = {
						isNew = true,
						size = arg_24_3
					}
				else
					self._newObtain[var_24_0] = {
						isNew = false,
						size = arg_24_3
					}
				end
			else
				var_24_1 = true
				self._newObtain[var_24_0] = {
					isNew = true,
					size = arg_24_3
				}
			end

			if var_24_1 then
				local var_24_2 = {}

				for iter_24_0, iter_24_1 in pairs(self._newObtain) do
					if iter_24_1.isNew then
						var_24_2[iter_24_0] = true
					end
				end

				g.core.common.Storage:save("new_obtain_bag.json", var_24_2)
			end
		end
	else
		self._newObtain[var_24_0] = nil
	end
end

function BagData:loadNewObtain()
	self._newObtain = {}

	local var_25_0 = g.core.common.Storage:load("new_obtain_bag.json") or {}

	for iter_25_0, iter_25_1 in pairs((self:getList(g.core.const.ConstMgr.BAG_TYPE.ITEM))) do
		if g.core.config.item_info.get(iter_25_1.id).if_new_obtain == 1 then
			local var_25_1 = tostring(iter_25_1.id)
			local var_25_2 = {}

			var_25_2.isNew = var_25_0[var_25_1] or false
			var_25_2.size = iter_25_1.num
			self._newObtain[var_25_1] = var_25_2
		end
	end
end

function BagData:isNewObtainData(arg_26_1)
	if self._newObtain == nil then
		return false
	end

	local var_26_0 = self._newObtain[tostring(arg_26_1)]

	if var_26_0 then
		return var_26_0.isNew
	end

	return false
end

function BagData:clearNewObtain()
	if self._newObtain == nil then
		return
	end

	for iter_27_0, iter_27_1 in pairs(self._newObtain) do
		iter_27_1.isNew = false
	end

	g.core.common.Storage:save("new_obtain_bag.json", {})
end

function BagData:getNewData(arg_28_1, arg_28_2)
	local var_28_0 = self._newData[tostring(arg_28_1)]

	if not arg_28_2 then
		return var_28_0
	elseif var_28_0 then
		return var_28_0[string.format("%d", arg_28_2)]
	end
end

function BagData:allNewData(arg_29_1)
	return checkbool(self._allNew[tostring(arg_29_1)])
end

function BagData:clearNewData(arg_30_1, arg_30_2)
	local var_30_0 = self._newData[tostring(arg_30_1)]

	if var_30_0 and arg_30_2 then
		local var_30_1 = string.format("%d", arg_30_2)

		if arg_30_2 and var_30_0[var_30_1] then
			var_30_0[var_30_1] = nil
		end

		if not next(var_30_0) then
			self._newData[tostring(arg_30_1)] = nil
		end

		if arg_30_1 == 14 then
			self._newData[tostring(14)] = nil
		end

		g.core.common.Storage:save("bag.json", self._newData)
	end
end

function BagData:clearNewList(arg_31_1)
	if self._allNew[tostring(arg_31_1)] then
		self._allNew[tostring(arg_31_1)] = false

		g.core.common.Storage:save("all_bag.json", self._allNew)
	end
end

function BagData:checkValidNewData(arg_32_1, arg_32_2)
	if BagData.IGNORE_NEW_DATA[arg_32_1] then
		local var_32_0 = 0

		if arg_32_1 == var_0_1.KNIGHT then
			var_32_0 = g.core.config.knight_info.get(arg_32_2.base_id).advance_id
		elseif arg_32_1 == var_0_1.UNITE_TOKEN then
			var_32_0 = g.core.config.unite_token_info.get(arg_32_2.base_id).advance_id
		end

		if BagData.IGNORE_NEW_DATA[arg_32_1][var_32_0] then
			return false
		end
	end

	if arg_32_1 == var_0_1.KNIGHT and arg_32_2.position and arg_32_2.position > 0 then
		return false
	end

	return true
end

function BagData:checkNewList()
	local var_33_0 = g.core.common.Storage:load("all_bag.json")

	if not var_33_0 then
		for iter_33_0, iter_33_1 in pairs(self._bagList) do
			for iter_33_2, iter_33_3 in ipairs(iter_33_1) do
				if self:checkValidNewData(iter_33_0, iter_33_3) then
					self._allNew[tostring(iter_33_0)] = true

					break
				end
			end
		end
	else
		for iter_33_4, iter_33_5 in pairs(var_33_0) do
			self._allNew[iter_33_4] = iter_33_5
		end
	end
end

function BagData:checkNewData()
	local var_34_0 = g.core.common.Storage:load("bag.json")

	if var_34_0 then
		for iter_34_0, iter_34_1 in pairs(var_34_0) do
			self._newData[iter_34_0] = iter_34_1
		end
	end

	g.core.common.Storage:save("bag.json", self._newData)
end

function BagData:getDifCountById(arg_35_1, arg_35_2)
	if arg_35_1 == 999 then
		return g.core.model.User:getDifGold()
	end

	local var_35_0 = self._difBagIndexList[arg_35_1]

	if not self._difBagIndexList[arg_35_1] or var_35_0 and not var_35_0[arg_35_2] then
		return 0
	end

	return var_35_0[arg_35_2]
end

function BagData:cleanFlushFlag()
	self._flushFlag = false
end

function BagData:getFlushFlag()
	return self._flushFlag
end

function BagData:setFlushFlag()
	self._flushFlag = true
end

function BagData:setDifCount(arg_39_1, arg_39_2)
	for iter_39_0, iter_39_1 in ipairs(arg_39_2) do
		self._bagIndexList[arg_39_1] = self._bagIndexList[arg_39_1] or {}

		if iter_39_1.id and self._difBagIndexList[arg_39_1] then
			if not self._bagIndexList[arg_39_1][iter_39_1.id] then
				if iter_39_1.num then
					self._flushFlag = true
					self._difBagIndexList[arg_39_1][iter_39_1.id] = iter_39_1.num
				end
			else
				local var_39_0 = self._bagIndexList[arg_39_1][iter_39_1.id]

				if iter_39_1.num and var_39_0.num then
					self._flushFlag = true
					self._difBagIndexList[arg_39_1][iter_39_1.id] = iter_39_1.num - var_39_0.num
				end
			end
		end
	end
end

function BagData:addTreasureList(arg_40_1)
	if not arg_40_1 then
		return
	end

	for iter_40_0 = 1, #arg_40_1 do
		self._treasureIdMap[arg_40_1[iter_40_0].id] = arg_40_1[iter_40_0].base_id
		self._treasureList[arg_40_1[iter_40_0].base_id] = self._treasureList[arg_40_1[iter_40_0].base_id] or {}

		table.insert(self._treasureList[arg_40_1[iter_40_0].base_id], arg_40_1[iter_40_0])
	end
end

function BagData:addEquipList(arg_41_1)
	if not arg_41_1 then
		return
	end

	for iter_41_0 = 1, #arg_41_1 do
		self._equipIdMap[arg_41_1[iter_41_0].id] = arg_41_1[iter_41_0].base_id
		self._equipList[arg_41_1[iter_41_0].base_id] = self._equipList[arg_41_1[iter_41_0].base_id] or {}

		table.insert(self._equipList[arg_41_1[iter_41_0].base_id], arg_41_1[iter_41_0])
	end
end

function BagData:updateTreasureList(arg_42_1)
	if not arg_42_1 then
		return
	end

	for iter_42_0 = 1, #arg_42_1 do
		self._treasureIdMap[arg_42_1[iter_42_0].id] = arg_42_1[iter_42_0].base_id

		local var_42_0 = self._treasureList[arg_42_1[iter_42_0].base_id] or {}

		for iter_42_1 = 1, #var_42_0 do
			if var_42_0[iter_42_1].id == arg_42_1[iter_42_0].id then
				for iter_42_2, iter_42_3 in pairs(var_42_0[iter_42_1]) do
					var_42_0[iter_42_1][iter_42_2] = iter_42_3
				end
			end
		end
	end
end

function BagData:updateEquipList(arg_43_1)
	if not arg_43_1 then
		return
	end

	for iter_43_0 = 1, #arg_43_1 do
		self._equipIdMap[arg_43_1[iter_43_0].id] = arg_43_1[iter_43_0].base_id

		local var_43_0 = self._equipList[arg_43_1[iter_43_0].base_id] or {}

		for iter_43_1 = 1, #var_43_0 do
			if var_43_0[iter_43_1].id == arg_43_1[iter_43_0].id then
				for iter_43_2, iter_43_3 in pairs(var_43_0[iter_43_1]) do
					var_43_0[iter_43_1][iter_43_2] = iter_43_3
				end
			end
		end
	end
end

function BagData:removeTreasureList(arg_44_1)
	if not arg_44_1 then
		return
	end

	for iter_44_0 = 1, #arg_44_1 do
		if self._treasureIdMap[arg_44_1[iter_44_0]] then
			local var_44_0 = self._treasureList[self._treasureIdMap[arg_44_1[iter_44_0]]] or {}

			for iter_44_1 = 1, #var_44_0 do
				if var_44_0[iter_44_1].id == arg_44_1[iter_44_0] then
					table.remove(var_44_0, iter_44_1)

					break
				end
			end
		end
	end
end

function BagData:removeEquipList(arg_45_1)
	if not arg_45_1 then
		return
	end

	for iter_45_0 = 1, #arg_45_1 do
		if self._equipIdMap[arg_45_1[iter_45_0]] then
			local var_45_0 = self._equipList[self._equipIdMap[arg_45_1[iter_45_0]]] or {}

			for iter_45_1 = 1, #var_45_0 do
				if var_45_0[iter_45_1].id == arg_45_1[iter_45_0] then
					table.remove(var_45_0, iter_45_1)

					break
				end
			end
		end
	end
end

function BagData:updateWingData(arg_46_1)
	if not arg_46_1 then
		return
	end

	local var_46_0 = arg_46_1.id

	self._bagList[var_0_1.WING] = {
		{
			id = arg_46_1.id
		}
	}
	self._bagIndexList[var_0_1.WING] = {}
	self._bagIndexList[var_0_1.WING][var_46_0] = {
		num = 1,
		id = var_46_0
	}
end

function BagData:checkSceneskinItem(arg_47_1)
	if not self._sceneSkillitems then
		self._sceneSkillitems = {}

		for iter_47_0 = 1, g.core.config.maincity_scene_info.getLength() do
			local var_47_0 = g.core.config.maincity_scene_info.indexOf(iter_47_0)

			if var_47_0.forever_item_id ~= 0 then
				table.insert(self._sceneSkillitems, var_47_0.forever_item_id)
			end

			if var_47_0.limit_item_id ~= 0 then
				table.insert(self._sceneSkillitems, var_47_0.limit_item_id)
			end
		end
	end

	for iter_47_1, iter_47_2 in ipairs(self._sceneSkillitems) do
		if iter_47_2 == arg_47_1 then
			self:setSceneskinGet(true)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NEW_SCENE_SKIN_GO)
		end
	end
end

function BagData:isSceneskinGet()
	return self._isSceneSKinGet
end

function BagData:setSceneskinGet(arg_49_1)
	self._isSceneSKinGet = arg_49_1
end

function BagData:checkAndFixBagLeftNum(arg_50_1, arg_50_2)
	local var_50_0 = self:getCount(arg_50_1)
	local var_50_1, var_50_2 = self:checkAndFixNum(arg_50_1, var_50_0 + arg_50_2)

	if var_50_2 then
		arg_50_2 = var_50_1 - var_50_0
	end

	return arg_50_2, var_50_2
end

function BagData:checkAndFixNum(arg_51_1, arg_51_2)
	local var_51_0 = 0
	local var_51_1 = false
	local var_51_2 = g.core.config.role_info.get(g.core.model.User:getLevel())

	if g.core.common.Goods.TYPE_EQUIP == arg_51_1 then
		var_51_0 = var_51_2.equipment_bag_num_client
	elseif g.core.common.Goods.TYPE_TREASURE == arg_51_1 then
		var_51_0 = var_51_2.treasure_bag_num_client
	elseif g.core.common.Goods.TYPE_PET == arg_51_1 then
		var_51_0 = var_51_2.pet_bag_num_client
	elseif g.core.common.Goods.TYPE_PET_EQUIP == arg_51_1 then
		var_51_0 = var_51_2.pet_equipment_bag_num_client
	end

	if var_51_0 > 0 and var_51_0 < arg_51_2 then
		var_51_1 = true
		arg_51_2 = var_51_0
	end

	return arg_51_2, var_51_1
end

function BagData:checkIsRandOpenBox(arg_52_1)
	if not arg_52_1.type or not arg_52_1.value then
		return false
	end

	local var_52_0 = self:getItem(g.core.const.ConstMgr.BAG_TYPE.ITEM, arg_52_1.value)

	if not var_52_0 then
		return false
	end

	local var_52_1 = g.core.config.item_info.get(var_52_0.id)

	if var_52_1.item_type == 3 then
		if var_52_1.id == 1 then
			if g.core.model.User.bagData:getCountById(g.core.common.Goods.TYPE_RESOURCE, g.core.common.Goods.RESOURCE.TYPE_STAMINA) >= 100 then
				return false
			else
				return true
			end
		end

		return true
	end

	return false
end

function BagData:checkIsNewItem(arg_53_1)
	if not arg_53_1.type or not arg_53_1.value then
		return self:_checkExistNewItem()
	end

	if self:isNewObtainData(arg_53_1.value) then
		return true
	end

	return false
end

function BagData:_checkExistNewItem()
	if self._newObtain == nil then
		return false
	end

	for iter_54_0, iter_54_1 in pairs(self._newObtain) do
		if iter_54_1.isNew then
			return true
		end
	end

	return false
end

function BagData:checkIsTimeLimitItem(arg_55_1)
	local var_55_0 = arg_55_1.time or 0
	local var_55_1 = arg_55_1.onlyId or 0

	if not arg_55_1.type or not arg_55_1.value then
		return self:_checkExistTimeLimitItem()
	end

	if arg_55_1.type == g.core.const.ConstMgr.BAG_TYPE.EXPIRABLE_ITEM then
		if not self:getItem(g.core.const.ConstMgr.BAG_TYPE.EXPIRABLE_ITEM, var_55_1) then
			return false
		end

		if var_55_0 > 0 then
			local var_55_2 = var_0_4:getLeftSeconds(var_55_0)

			if var_55_2 < 0 then
				return false
			elseif var_55_2 <= 259200 then
				return true, "ui://base_new/pic_time_3"
			end
		end
	else
		local var_55_3 = self:getItem(g.core.const.ConstMgr.BAG_TYPE.ITEM, arg_55_1.value)

		if not var_55_3 then
			return false
		end

		local var_55_4 = g.core.config.item_info.get(var_55_3.id)

		if var_55_4.limited_time > 0 or var_55_0 > 0 then
			local var_55_6 = var_0_4:getLeftSeconds((var_55_4.limited_time > 0 or nil) and var_55_4.limited_time)

			if var_55_6 < 0 then
				return false
			elseif var_55_6 <= 259200 then
				return true, "ui://base_new/pic_time_3"
			end
		end
	end

	return false
end

function BagData:checkIsTimeFullItem(arg_56_1)
	local var_56_0 = arg_56_1.time or 0

	if not arg_56_1.type or not arg_56_1.value then
		return false
	end

	local var_56_1 = self:getItem(g.core.const.ConstMgr.BAG_TYPE.ITEM, arg_56_1.value)

	if not var_56_1 then
		return false
	end

	local var_56_2 = g.core.config.item_info.get(var_56_1.id)

	if var_56_2.limited_time > 0 or var_56_0 > 0 then
		if var_0_4:getLeftSeconds((var_56_2.limited_time > 0 or nil) and var_56_2.limited_time) > 259200 then
			return true, "ui://base_new/pic_time_2"
		end
	end

	return false
end

function BagData:_checkExistTimeLimitItem()
	for iter_57_0, iter_57_1 in pairs((self:getList(g.core.const.ConstMgr.BAG_TYPE.ITEM))) do
		local var_57_0 = g.core.config.item_info.get(iter_57_1.id)

		if var_57_0.limited_time > 0 or (iter_57_1.time or 0) > 0 then
			local var_57_3 = var_0_4:getLeftSeconds((var_57_0.limited_time > 0 or nil) and var_57_0.limited_time)

			if var_57_3 > 0 and var_57_3 <= 259200 then
				return true, "ui://base_new/pic_time_3"
			end
		end
	end

	for iter_57_2, iter_57_3 in pairs((self:getList(g.core.const.ConstMgr.BAG_TYPE.EXPIRABLE_ITEM))) do
		local var_57_5 = var_0_4:getLeftSeconds(iter_57_3.expire_time or 0)

		if var_57_5 > 0 and var_57_5 <= 259200 then
			return true, "ui://base_new/pic_time_3"
		end
	end

	return false
end

function BagData:checkQuickBoxItem(arg_58_1, arg_58_2)
	if arg_58_1 == g.core.const.ConstMgr.BAG_TYPE.ITEM then
		local var_58_0 = g.core.config.item_info.get(arg_58_2)

		if var_58_0 and var_58_0.item_type == g.core.common.Goods.TYPE_ITEM and var_58_0.use_type == 2 then
			local var_58_1 = table.indexof(self._boxTypeList, arg_58_2)

			if var_58_1 then
				self._boxTypeList[var_58_1] = arg_58_2
			else
				table.insert(self._boxTypeList, arg_58_2)
			end
		end
	end
end

function BagData:clearQuickBoxItem(arg_59_1)
	local var_59_0 = table.indexof(self._boxTypeList, arg_59_1)

	if var_59_0 then
		table.remove(self._boxTypeList, var_59_0)
	end
end

function BagData:resetAllQuickBoxItem()
	self._boxTypeList = {}
end

function BagData:getShowBoxId()
	local var_61_0 = 0

	if require("app.view.module.home.common.HomeModuleAutoPopup").isCurHavePopup() then
		return var_61_0
	end

	for iter_61_0 = 1, #self._boxTypeList do
		if self:getOwnNum(g.core.const.ConstMgr.BAG_TYPE.ITEM, self._boxTypeList[iter_61_0]) > 0 then
			var_61_0 = self._boxTypeList[iter_61_0]

			self:clearQuickBoxItem(self._boxTypeList[iter_61_0])

			break
		end
	end

	return var_61_0
end

function BagData:hasEquipCanCompose()
	for iter_62_0, iter_62_1 in ipairs((g.core.model.User.fragmentsData:getSpFragmentList(g.core.common.Goods.FRAGMENT.TYPE_EQUIP, {
		quality = 0,
		type = 0
	}))) do
		local var_62_0 = g.core.common.Goods:convert({
			type = g.core.common.Goods.TYPE_FRAGMENT,
			value = iter_62_1.id,
			size = iter_62_1.num
		})

		if var_62_0.size >= var_62_0.info.combine_num then
			return true
		end
	end

	return false
end

function BagData:hasTreasureCanCompose()
	for iter_63_0 = 1, g.core.config.treasure_info.getLength() do
		local var_63_0 = g.core.config.treasure_info.indexOf(iter_63_0)

		if var_63_0.seen_bag == 1 and g.core.model.User.bagData:getCountById(g.core.common.Goods.TYPE_FRAGMENT, var_63_0.fragment_1) >= g.core.config.fragment_info.get(var_63_0.fragment_1).combine_num then
			return true
		end
	end

	return false
end

function BagData:_defaultFurnitureSpecialCount(arg_64_1, arg_64_2)
	if arg_64_2 == var_0_2.get(var_0_3.DEFAULT_FURNITURE_ID_KEY_FLOOR).parameter then
		arg_64_1 = arg_64_1 - var_0_3.DEFAULT_SVR_FLOOR_NUM
	elseif arg_64_2 == var_0_2.get(var_0_3.DEFAULT_FURNITURE_ID_KEY_WALL).parameter then
		arg_64_1 = arg_64_1 - var_0_3.DEFAULT_SVR_FLOOR_NUM
	elseif arg_64_2 == var_0_2.get(var_0_3.DEFAULT_FURNITURE_ID_KEY_BG).parameter then
		arg_64_1 = arg_64_1 - var_0_3.DEFAULT_SVR_FLOOR_NUM
	end

	arg_64_1 = math.max(0, arg_64_1)

	return arg_64_1
end

return BagData

local var_0_0 = g.core.common.Goods
local var_0_1 = g.core.model.User.bagData
local var_0_2 = g.core.config.furniture_info
local var_0_3 = g.core.config.furniture_book_info
local var_0_4 = g.core.const.ConstMgr.FurnitureHandBookConst
local FurnitureHandBookData = class("FurnitureHandBookData", require("app.core.model.BaseData"))

function FurnitureHandBookData:ctor()
	self:initData()
end

function FurnitureHandBookData:initData()
	self._sumPerson = 0
	self._myRank = 0
	self._furnitureKit = {}

	self:_initFurnitureKitData()
end

function FurnitureHandBookData:_initFurnitureKitData()
	self._furnitureKit = {}

	for iter_3_0 = 1, var_0_3.getLength() do
		local var_3_0 = var_0_3.indexOf(iter_3_0).id

		self._furnitureKit[var_3_0] = {}

		for iter_3_1 = 1, var_0_2.getLength() do
			local var_3_1 = var_0_2.indexOf(iter_3_1)

			if var_3_0 == var_3_1.furniture_book then
				table.insert(self._furnitureKit[var_3_0], var_3_1.id)
			end
		end
	end
end

function FurnitureHandBookData:onS2CFurnishingNumRank(arg_4_1)
	if arg_4_1.sum_person then
		self._sumPerson = arg_4_1.sum_person
	end

	if arg_4_1.rank then
		self._myRank = arg_4_1.rank
	end
end

function FurnitureHandBookData:getBaseAttributeData()
	local var_5_0 = {}

	for iter_5_0 = 1, var_0_3.getLength() do
		local var_5_1 = var_0_3.indexOf(iter_5_0)

		if self:isActivateAttribute(var_5_1.id) then
			if var_5_0[var_5_1.attribute_type] then
				var_5_0[var_5_1.attribute_type].value = var_5_0[var_5_1.attribute_type].value + var_5_1.attribute_value
			else
				var_5_0[var_5_1.attribute_type] = {
					type = var_5_1.attribute_type,
					value = var_5_1.attribute_value
				}
			end
		end
	end

	local var_5_2 = {}

	if var_5_0 and next(var_5_0) then
		for iter_5_1, iter_5_2 in pairs(var_5_0) do
			table.insert(var_5_2, iter_5_2)
		end
	end

	return var_5_2
end

function FurnitureHandBookData:getEfficiencyData()
	local var_6_0 = 0
	local var_6_1 = 0

	for iter_6_0 = 1, var_0_3.getLength() do
		local var_6_2 = var_0_3.indexOf(iter_6_0)

		if self:isActivateEfficiency(var_6_2.id) then
			if var_6_2.efficiency_type == var_0_4.HOME_LAND_TYPE then
				var_6_0 = var_6_0 + var_6_2.efficiency_value / 1000
			elseif var_6_2.efficiency_type == var_0_4.FURNITURE_TYPE then
				var_6_1 = var_6_1 + var_6_2.efficiency_value / 1000
			end
		end
	end

	local var_6_3 = {}

	if var_6_0 > 0 then
		table.insert(var_6_3, {
			type = var_0_4.HOME_LAND_TYPE,
			value = var_6_0 * 100
		})
	end

	if var_6_1 > 0 then
		table.insert(var_6_3, {
			type = var_0_4.FURNITURE_TYPE,
			value = var_6_1 * 100
		})
	end

	return var_6_3
end

function FurnitureHandBookData:getOwnFurnituresCount()
	local var_7_0 = {}

	for iter_7_0 = 1, var_0_2.getLength() do
		local var_7_1 = var_0_2.indexOf(iter_7_0).id

		if var_0_1:isOwnItem(var_0_0.TYPE_FURNITURE, var_7_1) then
			table.insert(var_7_0, var_7_1)
		end
	end

	if next(var_7_0) then
		return table.nums(var_7_0)
	end

	return 0
end

function FurnitureHandBookData:getExceedPlayerRatio()
	if self._myRank > 0 and self._sumPerson > 0 then
		return math.floor((self._sumPerson - self._myRank) / self._sumPerson * 100)
	end

	return 0
end

function FurnitureHandBookData:getFurnituresByKitId(arg_9_1)
	local var_9_0 = self._furnitureKit[arg_9_1] or {}

	local function var_9_1(arg_10_0)
		return var_0_1:isOwnItem(var_0_0.TYPE_FURNITURE, arg_10_0) and 1 or 0
	end

	table.sort(var_9_0, function(arg_11_0, arg_11_1)
		local var_11_0 = var_9_1(arg_11_0)
		local var_11_1 = var_9_1(arg_11_1)

		if var_11_0 ~= var_11_1 then
			return var_11_1 < var_11_0
		end

		if arg_11_0 ~= arg_11_1 then
			return arg_11_1 < arg_11_0
		end

		return false
	end)

	local var_9_2 = {}

	for iter_9_0 = 1, #var_9_0 do
		if g.core.config.furniture_info.get(var_9_0[iter_9_0]).put == 1 then
			table.insert(var_9_2, var_9_0[iter_9_0])
		end
	end

	return var_9_2
end

function FurnitureHandBookData:getCollectKitCount(arg_12_1)
	local var_12_0 = 0
	local var_12_1 = self._furnitureKit[arg_12_1] or {}

	for iter_12_0 = 1, #var_12_1 do
		if var_0_1:isOwnItem(var_0_0.TYPE_FURNITURE, var_12_1[iter_12_0]) then
			var_12_0 = var_12_0 + 1
		end
	end

	return var_12_0
end

function FurnitureHandBookData:getKitFurnituresCollectRatio(arg_13_1)
	local var_13_0 = #self:getFurnituresByKitId(arg_13_1)

	if var_13_0 ~= 0 then
		return self:getCollectKitCount(arg_13_1) / var_13_0
	end

	return 0
end

function FurnitureHandBookData:getCurCollectProgress(arg_14_1)
	local var_14_0 = #self:getFurnituresByKitId(arg_14_1)

	return var_14_0 > 0 and math.ceil(self:getCollectKitCount(arg_14_1) / var_14_0 * 100) or 0
end

function FurnitureHandBookData:isActivateEfficiency(arg_15_1)
	local var_15_0 = var_0_3.get(arg_15_1)

	if var_15_0.efficiency_type > 0 and self:getCurCollectProgress(arg_15_1) >= math.ceil(var_15_0.efficiency_process / 1000 * 100) then
		return true
	end

	return false
end

function FurnitureHandBookData:isActivateAttribute(arg_16_1)
	if self:getCurCollectProgress(arg_16_1) >= math.ceil(var_0_3.get(arg_16_1).attribute_process / 1000 * 100) then
		return true
	end

	return false
end

function FurnitureHandBookData:getSortDataByCollect(arg_17_1)
	local var_17_0 = {}

	for iter_17_0 = 1, var_0_3.getLength() do
		local var_17_1 = var_0_3.indexOf(iter_17_0).id

		if #self:getFurnituresByKitId(var_17_1) > 0 then
			table.insert(var_17_0, var_17_1)
		end
	end

	if arg_17_1 then
		table.sort(var_17_0, function(arg_18_0, arg_18_1)
			local var_18_0 = var_0_3.get(arg_18_0)
			local var_18_1 = var_0_3.get(arg_18_1)

			if var_18_0 and var_18_1 then
				local var_18_2 = self:getCurCollectProgress(var_18_0.id)
				local var_18_3 = self:getCurCollectProgress(var_18_1.id)

				if var_18_2 ~= var_18_3 then
					return var_18_3 < var_18_2
				end

				if var_18_0.id ~= var_18_1.id then
					return var_18_0.id > var_18_1.id
				end
			end

			return false
		end)
	else
		table.sort(var_17_0, function(arg_19_0, arg_19_1)
			local var_19_0 = var_0_3.get(arg_19_0)
			local var_19_1 = var_0_3.get(arg_19_1)

			if var_19_0 and var_19_1 then
				local var_19_2 = self:getCurCollectProgress(var_19_0.id)
				local var_19_3 = self:getCurCollectProgress(var_19_1.id)

				if var_19_2 ~= var_19_3 then
					return var_19_2 < var_19_3
				end

				if var_19_0.id ~= var_19_1.id then
					return var_19_0.id > var_19_1.id
				end
			end

			return false
		end)
	end

	return var_17_0
end

function FurnitureHandBookData:getSortDataByQuality(arg_20_1)
	local var_20_0 = {}

	for iter_20_0 = 1, var_0_3.getLength() do
		local var_20_1 = var_0_3.indexOf(iter_20_0).id

		if #self:getFurnituresByKitId(var_20_1) > 0 then
			table.insert(var_20_0, var_20_1)
		end
	end

	if arg_20_1 then
		table.sort(var_20_0, function(arg_21_0, arg_21_1)
			local var_21_0 = var_0_3.get(arg_21_0)
			local var_21_1 = var_0_3.get(arg_21_1)

			if var_21_0.quality and var_21_1.quality then
				if var_21_0.quality ~= var_21_1.quality then
					return var_21_0.quality > var_21_1.quality
				end

				if var_21_0.id ~= var_21_1.id then
					return var_21_0.id > var_21_1.id
				end
			end

			return false
		end)
	else
		table.sort(var_20_0, function(arg_22_0, arg_22_1)
			local var_22_0 = var_0_3.get(arg_22_0)
			local var_22_1 = var_0_3.get(arg_22_1)

			if var_22_0.quality and var_22_1.quality then
				if var_22_0.quality ~= var_22_1.quality then
					return var_22_0.quality < var_22_1.quality
				end

				if var_22_0.id ~= var_22_1.id then
					return var_22_0.id > var_22_1.id
				end
			end

			return false
		end)
	end

	return var_20_0
end

function FurnitureHandBookData:checkIsHaveActivateHandBook(arg_23_1)
	if arg_23_1.id then
		if (self:isActivateEfficiency(arg_23_1.id) or self:isActivateAttribute(arg_23_1.id)) and not self:isCleanedNewInCache(arg_23_1.id) then
			return true
		end

		return false
	else
		return (self:checkAllHankBookIsHaveActivate())
	end
end

function FurnitureHandBookData:checkAllHankBookIsHaveActivate()
	for iter_24_0 = 1, var_0_3.getLength() do
		local var_24_0 = var_0_3.indexOf(iter_24_0).id

		if (self:isActivateAttribute(var_24_0) or self:isActivateEfficiency(var_24_0)) and not self:isCleanedNewInCache(var_24_0) then
			return true
		end
	end

	return false
end

function FurnitureHandBookData:isCleanedNewInCache(arg_25_1)
	local var_25_0 = g.core.common.Storage:load("furnitureHandBookNew.json")

	if var_25_0 then
		for iter_25_0, iter_25_1 in ipairs(var_25_0) do
			if iter_25_1 == arg_25_1 then
				return true
			end
		end
	end

	return false
end

function FurnitureHandBookData:cleanFurnitureHandBookNew(arg_26_1)
	if (self:isActivateEfficiency(arg_26_1) or self:isActivateAttribute(arg_26_1)) and not self:isCleanedNewInCache(arg_26_1) then
		local var_26_0 = g.core.common.Storage:load("furnitureHandBookNew.json") or {}

		table.insert(var_26_0, arg_26_1)
		g.core.common.Storage:save("furnitureHandBookNew.json", var_26_0)
	end

	return true
end

function FurnitureHandBookData:getFurnituresByKitIdWithoutOrder(arg_27_1)
	return self._furnitureKit[arg_27_1] or {}
end

return FurnitureHandBookData

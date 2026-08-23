local var_0_0 = g.core.config.precious_info
local var_0_1 = g.core.config.precious_upgrade_info
local var_0_2 = g.core.config.precious_suit_info
local PreciousStruct = require("app.view.module.precious.model.PreciousStruct")
local PreciousSuitStruct = require("app.view.module.precious.model.PreciousSuitStruct")
local PreciousData = class("PreciousData")

function PreciousData:ctor()
	self._siftQualityIdx = 0
	self._siftActivateIdx = 0
	self._pSuitGroupMap = {}
	self._pSuitGroupList = {}
	self._preciousAdvMap = {}
	self._preciousAdvArray = {}
	self._upgradeGroupMap = {}
	self._groupNameMap = {}
	self._groupNameList = {}

	self:initData()
end

function PreciousData:initData()
	self:_initPreciousCfg()
end

function PreciousData:_initPreciousCfg()
	for iter_3_0, iter_3_1 in var_0_2.ipairs() do
		if not self._pSuitGroupMap[iter_3_1.suit_group] and iter_3_1.put == 1 then
			local var_3_0 = PreciousSuitStruct.new()

			var_3_0:setCfg(iter_3_1)

			self._pSuitGroupMap[iter_3_1.suit_group] = var_3_0

			table.insert(self._pSuitGroupList, var_3_0)

			self._groupNameMap[iter_3_1.group] = self._groupNameMap[iter_3_1.group] or {
				group = iter_3_1.group,
				name = iter_3_1.group_name
			}
		end
	end

	for iter_3_2, iter_3_3 in pairs(self._pSuitGroupMap) do
		for iter_3_4, iter_3_5 in var_0_0.ipairs() do
			if iter_3_5.suit_group == iter_3_2 and not self._preciousAdvMap[iter_3_5.advance_id] then
				local var_3_1 = PreciousStruct.new()

				var_3_1:setCfg(iter_3_5)

				self._preciousAdvMap[iter_3_5.advance_id] = var_3_1

				table.insert(self._preciousAdvArray, var_3_1)
			end
		end
	end

	for iter_3_6, iter_3_7 in var_0_1.ipairs() do
		local var_3_2 = iter_3_7.upgrade_group

		self._upgradeGroupMap[iter_3_7.upgrade_group] = self._upgradeGroupMap[iter_3_7.upgrade_group] or var_0_1.match(function(arg_4_0)
			return arg_4_0.upgrade_group == var_3_2
		end)
	end

	self:_initGroupNameList()
end

function PreciousData:_initGroupNameList()
	for iter_5_0, iter_5_1 in pairs(self._groupNameMap) do
		if iter_5_0 ~= 0 then
			table.insert(self._groupNameList, iter_5_1)
		end
	end

	table.sort(self._groupNameList, function(arg_6_0, arg_6_1)
		return arg_6_0.group < arg_6_1.group
	end)

	if #self._groupNameList == 1 then
		self._groupNameList = {}
	end

	table.insert(self._groupNameList, 1, {
		group = 0,
		name = g.core.lang:get(421201)
	})
end

function PreciousData:getGroupNameList()
	return self._groupNameList
end

function PreciousData:getPreciousListByGroup(arg_8_1)
	local var_8_0 = {}

	if arg_8_1 == 0 then
		var_8_0 = self._preciousAdvArray
	else
		for iter_8_0, iter_8_1 in ipairs(self._preciousAdvArray) do
			if iter_8_1:getCfg().group == arg_8_1 then
				table.insert(var_8_0, iter_8_1)
			end
		end
	end

	return var_8_0
end

function PreciousData:getPreciousSuitList()
	return self._pSuitGroupList
end

function PreciousData:getActivateSuitList()
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in ipairs(self._pSuitGroupList) do
		if iter_10_1:getOwnPreciousNum() > 0 then
			table.insert(var_10_0, iter_10_1)
		end
	end

	return var_10_0
end

function PreciousData:getPreciousSuitListByFilter(arg_11_1)
	local var_11_0 = arg_11_1.group or 0
	local var_11_1 = arg_11_1.quality or 0
	local var_11_2 = arg_11_1.activate or 0
	local var_11_3 = {}

	for iter_11_0, iter_11_1 in ipairs(self._pSuitGroupList) do
		if var_11_0 ~= 0 then
			iter_11_1:isActivate()

			if iter_11_1:getGroup() == var_11_0 then
				table.insert(var_11_3, iter_11_1)
			end
		else
			table.insert(var_11_3, iter_11_1)
		end
	end

	local var_11_4 = {}

	for iter_11_2, iter_11_3 in ipairs(var_11_3) do
		if var_11_1 ~= 0 then
			if iter_11_3:getQuality() == var_11_1 then
				table.insert(var_11_4, iter_11_3)
			end
		else
			table.insert(var_11_4, iter_11_3)
		end
	end

	local var_11_5 = {}

	for iter_11_4, iter_11_5 in ipairs(var_11_4) do
		if var_11_2 ~= 0 then
			if iter_11_5:isActivate() and var_11_2 == 1 then
				table.insert(var_11_5, iter_11_5)
			elseif not iter_11_5:isActivate() and var_11_2 == 2 then
				table.insert(var_11_5, iter_11_5)
			end
		else
			table.insert(var_11_5, iter_11_5)
		end
	end

	self:sortPreciousSuitList(var_11_5)

	return var_11_5
end

function PreciousData:getPreciousList()
	return self._preciousAdvArray
end

function PreciousData:getPreciousSuitIndex(arg_13_1)
	for iter_13_0, iter_13_1 in ipairs((self:getActivateSuitList())) do
		if iter_13_1 == arg_13_1 then
			return iter_13_0
		end
	end
end

function PreciousData:getSiftMarkIdx()
	return self._siftQualityIdx, self._siftActivateIdx
end

function PreciousData:setSiftMarkIdx(arg_15_1, arg_15_2)
	self._siftQualityIdx = arg_15_1
	self._siftActivateIdx = arg_15_2
end

function PreciousData:getOwnPreciousList()
	local var_16_0 = {}

	for iter_16_0 = 1, #self._preciousAdvArray do
		if self._preciousAdvArray[iter_16_0] and self._preciousAdvArray[iter_16_0]:isOwn() then
			table.insert(var_16_0, self._preciousAdvArray[iter_16_0])
		end
	end

	return var_16_0
end

function PreciousData:getUpgradeInfoListByGroup(arg_17_1)
	return self._upgradeGroupMap[arg_17_1]
end

function PreciousData:getPreciousByAdvId(arg_18_1)
	return self._preciousAdvMap[arg_18_1]
end

function PreciousData:getPreciousSuitByGroup(arg_19_1)
	return self._pSuitGroupMap[arg_19_1]
end

function PreciousData:getPreciousSuitByAdvId(arg_20_1)
	if self._preciousAdvMap[arg_20_1] then
		local var_20_0 = self._preciousAdvMap[arg_20_1]:getSuitGroup()

		if self._pSuitGroupMap[var_20_0] then
			return self._pSuitGroupMap[var_20_0]
		end
	end

	return nil
end

function PreciousData:onS2CPreciousGetInfo(arg_21_1)
	if arg_21_1.suits then
		for iter_21_0, iter_21_1 in ipairs(arg_21_1.suits) do
			if self._pSuitGroupMap[iter_21_1.group] then
				self._pSuitGroupMap[iter_21_1.group]:setServerData(iter_21_1)
			end
		end
	end

	if arg_21_1.owns then
		for iter_21_2, iter_21_3 in ipairs(arg_21_1.owns) do
			if self._preciousAdvMap[iter_21_3.advance_id] then
				self._preciousAdvMap[iter_21_3.advance_id]:setServerData(iter_21_3)
			end
		end
	end
end

function PreciousData:updateOpPrecious(arg_22_1)
	if arg_22_1.insert then
		for iter_22_0, iter_22_1 in ipairs(arg_22_1.insert) do
			self:_updatePrecious(iter_22_1)
		end
	end

	if arg_22_1.update then
		for iter_22_2, iter_22_3 in ipairs(arg_22_1.update) do
			self:_updatePrecious(iter_22_3)
		end
	end
end

function PreciousData:_updatePrecious(arg_23_1)
	if not self._preciousAdvMap[arg_23_1.advance_id] then
		local var_23_0 = PreciousStruct.new({})

		var_23_0:setServerData(arg_23_1)

		self._preciousAdvMap[arg_23_1.advance_id] = var_23_0

		table.insert(self._preciousAdvArray, var_23_0)
	else
		self._preciousAdvMap[arg_23_1.advance_id]:setServerData(arg_23_1)
	end
end

function PreciousData:isPreciousCanComposeOrStarUp(arg_24_1)
	if arg_24_1.advId then
		local var_24_0 = self:getPreciousByAdvId(arg_24_1.advId)

		if var_24_0 then
			if var_24_0:isCanCompose() or var_24_0:isCanStarUp() then
				return true
			end
		end
	else
		for iter_24_0, iter_24_1 in ipairs(self._preciousAdvArray) do
			if iter_24_1:isCanCompose() or iter_24_1:isCanStarUp() then
				return true
			end
		end
	end

	return false
end

function PreciousData:isPreciousCanUpgradeStage(arg_25_1)
	if arg_25_1.advId then
		local var_25_0 = self:getPreciousByAdvId(arg_25_1.advId)

		if var_25_0 then
			local var_25_1, var_25_2 = var_25_0:getPreciousStageAndLevel()

			if var_25_1 ~= var_25_0:getMaxStage() and var_25_2 == var_25_0:getMaxNode() and var_25_0:isCanUpgradeUp() then
				return true
			end
		end
	else
		for iter_25_0, iter_25_1 in ipairs(self._preciousAdvArray) do
			local var_25_3, var_25_4 = iter_25_1:getPreciousStageAndLevel()

			if var_25_3 ~= iter_25_1:getMaxStage() and var_25_4 == iter_25_1:getMaxNode() and iter_25_1:isCanUpgradeUp() then
				return true
			end
		end
	end

	return false
end

function PreciousData:isPreciousSuitActivateOrStarUp(arg_26_1)
	if arg_26_1.group then
		local var_26_0 = self:getPreciousSuitByGroup(arg_26_1.group)

		if var_26_0 then
			if var_26_0:isCanActivate() or var_26_0:isCanStarUp() then
				return true
			end
		end
	else
		for iter_26_0, iter_26_1 in ipairs(self._pSuitGroupList) do
			if iter_26_1:isCanActivate() or iter_26_1:isCanStarUp() then
				return true
			end
		end
	end

	return false
end

function PreciousData:onS2CPreciousSuitActivate(arg_27_1)
	if arg_27_1.suit then
		if self._pSuitGroupMap[arg_27_1.suit.group] then
			self._pSuitGroupMap[arg_27_1.suit.group]:setServerData(arg_27_1.suit)
		end
	end
end

function PreciousData:onS2CPreciousSuitStarUp(arg_28_1)
	if arg_28_1.suit then
		if self._pSuitGroupMap[arg_28_1.suit.group] then
			self._pSuitGroupMap[arg_28_1.suit.group]:setServerData(arg_28_1.suit)
		end
	end
end

function PreciousData:getAllSuitList()
	local var_29_0 = {}

	for iter_29_0, iter_29_1 in pairs(self._pSuitGroupMap) do
		table.insert(var_29_0, iter_29_1)
	end

	table.sort(var_29_0, function(arg_30_0, arg_30_1)
		local var_30_0 = arg_30_0:isCanActivate() and 1 or 0
		local var_30_1 = arg_30_1:isCanActivate() and 1 or 0

		if var_30_0 ~= var_30_1 then
			return var_30_1 < var_30_0
		end

		local var_30_2 = arg_30_0:isCanStarUp() and 1 or 0
		local var_30_3 = arg_30_1:isCanStarUp() and 1 or 0

		if var_30_2 ~= var_30_3 then
			return var_30_3 < var_30_2
		end

		local var_30_4 = arg_30_0:isActivate() and 1 or 0
		local var_30_5 = arg_30_1:isActivate() and 1 or 0

		if var_30_4 ~= var_30_5 then
			return var_30_5 < var_30_4
		end

		local var_30_6 = arg_30_0:getQuality()
		local var_30_7 = arg_30_1:getQuality()

		if var_30_6 ~= var_30_7 then
			return var_30_7 < var_30_6
		end

		return arg_30_0:getId() > arg_30_1:getId()
	end)

	return var_29_0
end

function PreciousData:getAllActiveSuitList()
	local var_31_0 = {}

	for iter_31_0, iter_31_1 in pairs(self._pSuitGroupMap) do
		if iter_31_1:isActivate() and iter_31_1:getCfg().passive_skill_id > 0 then
			table.insert(var_31_0, iter_31_1)
		end
	end

	return var_31_0
end

function PreciousData:sortPreciousSuitList(arg_32_1)
	table.sort(arg_32_1, function(arg_33_0, arg_33_1)
		local var_33_0 = arg_33_0:isCanActivate() and 1 or 0
		local var_33_1 = arg_33_1:isCanActivate() and 1 or 0

		if var_33_0 ~= var_33_1 then
			return var_33_1 < var_33_0
		end

		local var_33_2 = arg_33_0:isCanStarUp() and 1 or 0
		local var_33_3 = arg_33_1:isCanStarUp() and 1 or 0

		if var_33_2 ~= var_33_3 then
			return var_33_3 < var_33_2
		end

		local var_33_4 = arg_33_0:isPreciousCanCompose() and 1 or 0
		local var_33_5 = arg_33_1:isPreciousCanCompose() and 1 or 0

		if var_33_4 ~= var_33_5 then
			return var_33_5 < var_33_4
		end

		local var_33_6 = arg_33_0:isPreciousCanStarUp() and 1 or 0
		local var_33_7 = arg_33_1:isPreciousCanStarUp() and 1 or 0

		if var_33_6 ~= var_33_7 then
			return var_33_7 < var_33_6
		end

		local var_33_8 = arg_33_0:getOwnPreciousNum() > 0 and 1 or 0
		local var_33_9 = arg_33_1:getOwnPreciousNum() > 0 and 1 or 0

		if var_33_8 ~= var_33_9 then
			return var_33_9 < var_33_8
		end

		if arg_33_0:getQuality() ~= arg_33_1:getQuality() then
			return arg_33_0:getQuality() > arg_33_1:getQuality()
		end

		if arg_33_0:getOwnPreciousNum() ~= arg_33_1:getOwnPreciousNum() then
			return arg_33_0:getOwnPreciousNum() > arg_33_1:getOwnPreciousNum()
		end

		if arg_33_0:getId() > arg_33_1:getId() then
			return true
		else
			return false
		end
	end)
end

function PreciousData:getSuitByGroupId(arg_34_1)
	return self._pSuitGroupMap[arg_34_1]
end

function PreciousData:getCanSellPreciousFragDataList()
	local var_35_0 = {}

	for iter_35_0, iter_35_1 in ipairs((g.core.model.User.fragmentsData:getFragmentListByType(g.core.common.Goods.TYPE_PRECIOUS))) do
		var_35_0[iter_35_1.id] = var_35_0[iter_35_1.id] or {
			num = 0,
			id = iter_35_1.id
		}
		var_35_0[iter_35_1.id].num = var_35_0[iter_35_1.id].num + iter_35_1.num
	end

	local var_35_1 = {}

	for iter_35_2, iter_35_3 in ipairs((self:getOwnPreciousList())) do
		if iter_35_3:isMaxStar() then
			local var_35_2 = var_35_0[iter_35_3:getCfg().fragment_id]

			if var_35_2 then
				local var_35_3 = g.core.config.fragment_info.get(var_35_2.id)

				table.insert(var_35_1, {
					type = g.core.common.Goods.TYPE_FRAGMENT,
					value = var_35_2.id,
					size = var_35_2.num,
					quality = var_35_3.quality,
					priceType = var_35_3.price_type,
					priceValue = var_35_3.price_value,
					priceSize = var_35_3.price_size
				})
			end
		end
	end

	table.sort(var_35_1, function(arg_36_0, arg_36_1)
		if arg_36_0.quality ~= arg_36_1.quality then
			return arg_36_0.quality > arg_36_1.quality
		end

		if arg_36_0.size ~= arg_36_1.size then
			return arg_36_0.size > arg_36_1.size
		end

		return arg_36_0.value > arg_36_1.value
	end)

	return var_35_1
end

return PreciousData

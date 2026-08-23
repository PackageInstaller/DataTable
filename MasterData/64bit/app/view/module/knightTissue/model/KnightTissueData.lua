local var_0_0 = g.core.config.knight_tissue_info
local var_0_1 = g.core.config.knight_tissue_level_info
local var_0_2 = g.core.config.knight_tissue_group_info
local var_0_3 = g.core.model.User.knightsData
local var_0_4 = g.core.const.ConstMgr.KnightTissueConst
local KnightTissueData = class("KnightTissueData")

function KnightTissueData:ctor()
	self:initData()
end

function KnightTissueData:initData()
	self._tipsFlag = false
	self._tissueData = {}
	self._tissueGroupData = {}
	self._collectCountCache = {}
	self._totalLevelCache = {}
	self._totalCollectAllCount = nil
	self._tissuePassiveCache = {}
	self._tissueMaxLevelCache = {}

	self:_initTissueGroupCfgData()
end

function KnightTissueData:invalidateCollectCache()
	self._collectCountCache = {}
	self._totalLevelCache = {}
end

function KnightTissueData:_getSortGroupTissueData()
	local var_4_0 = {}

	for iter_4_0 = 1, var_0_2.getLength() do
		table.insert(var_4_0, (var_0_2.indexOf(iter_4_0)))
	end

	table.sort(var_4_0, function(arg_5_0, arg_5_1)
		if arg_5_0.sort_weight ~= arg_5_1.sort_weight then
			return arg_5_0.sort_weight < arg_5_1.sort_weight
		end
	end)

	return var_4_0
end

function KnightTissueData:_initTissueGroupCfgData()
	self._tissueGroupData = {}

	local var_6_0 = self:_getSortGroupTissueData()

	for iter_6_0 = 1, #var_6_0 do
		for iter_6_1 = 1, var_0_0.getLength() do
			local var_6_1 = var_0_0.indexOf(iter_6_1)

			if var_6_0[iter_6_0].id == var_6_1.group then
				self._tissueGroupData[var_6_0[iter_6_0].id] = self._tissueGroupData[var_6_0[iter_6_0].id] or {}

				table.insert(self._tissueGroupData[var_6_0[iter_6_0].id], var_6_1.toObject())
			end
		end
	end
end

function KnightTissueData:getTissueGroupCfg()
	return self._tissueGroupData
end

function KnightTissueData:initKnightTissueLevelData(arg_8_1)
	if arg_8_1.tissues then
		self._tissueData = {}

		for iter_8_0 = 1, #arg_8_1.tissues do
			self._tissueData[arg_8_1.tissues[iter_8_0].id] = self._tissueData[arg_8_1.tissues[iter_8_0].id] or {}
			self._tissueData[arg_8_1.tissues[iter_8_0].id] = arg_8_1.tissues[iter_8_0].lv
		end
	end

	self:invalidateCollectCache()
end

function KnightTissueData:setKnightTissueLevel(arg_9_1)
	self._tissueData[arg_9_1.id] = self._tissueData[arg_9_1.id] or {}
	self._tissueData[arg_9_1.id] = arg_9_1.tissue.lv

	self:invalidateCollectCache()
end

function KnightTissueData:getKnightTissueLevel(arg_10_1)
	return (self._tissueData[arg_10_1] or nil) and self._tissueData[arg_10_1]
end

function KnightTissueData:isKnightTissueActive(arg_11_1)
	if self._tissueData[arg_11_1] then
		return true
	end

	return false
end

function KnightTissueData:getTissueCollectCountById(arg_12_1)
	if self._collectCountCache[arg_12_1] ~= nil then
		return self._collectCountCache[arg_12_1]
	end

	local var_12_0 = 0
	local var_12_1 = self:getTissueKnightById(arg_12_1)

	if next(var_12_1) then
		var_12_0 = #var_12_1
	end

	self._collectCountCache[arg_12_1] = var_12_0

	return var_12_0
end

function KnightTissueData:getKnightCollectionAllCount()
	if self._totalCollectAllCount then
		return self._totalCollectAllCount
	end

	local var_13_0 = 0

	for iter_13_0 = 1, var_0_0.getLength() do
		var_13_0 = var_13_0 + var_0_0.indexOf(iter_13_0).num
	end

	self._totalCollectAllCount = var_13_0

	return var_13_0
end

function KnightTissueData:getOwnCollectCount()
	local var_14_0 = 0

	for iter_14_0 = 1, var_0_0.getLength() do
		var_14_0 = var_14_0 + self:getTissueCollectCountById(var_0_0.indexOf(iter_14_0).id)
	end

	return var_14_0
end

function KnightTissueData:getTissueKnightById(arg_15_1)
	local var_15_0 = var_0_0.get(arg_15_1)
	local var_15_1 = {}

	for iter_15_0 = 1, var_0_4.TISSUE_KNIGHT_MAX do
		local var_15_2 = var_0_3:getKnight({
			advance_id = var_15_0["knight_" .. iter_15_0]
		})

		if var_15_2 and var_15_2:isOwn() then
			table.insert(var_15_1, var_15_2)
		end
	end

	return var_15_1
end

function KnightTissueData:getTotalLevelByKnightTissueId(arg_16_1)
	if self._totalLevelCache[arg_16_1] ~= nil then
		return self._totalLevelCache[arg_16_1]
	end

	local var_16_0 = self:getTissueKnightById(arg_16_1)
	local var_16_1 = 0

	for iter_16_0 = 1, #var_16_0 do
		var_16_1 = var_16_1 + var_16_0[iter_16_0]:getFavoLevel()
	end

	self._totalLevelCache[arg_16_1] = var_16_1

	return var_16_1
end

function KnightTissueData:getTissueKnightCfgById(arg_17_1)
	local var_17_0 = var_0_0.get(arg_17_1)
	local var_17_1 = {}

	for iter_17_0 = 1, var_0_4.TISSUE_KNIGHT_MAX do
		if var_17_0["knight_" .. iter_17_0] > 0 then
			table.insert(var_17_1, var_17_0["knight_" .. iter_17_0])
		end
	end

	return var_17_1
end

function KnightTissueData:getNextLevelSumValue(arg_18_1)
	local var_18_0 = self:getKnightTissueLevel(arg_18_1)
	local var_18_1 = var_0_1.match(function(arg_19_0)
		return arg_19_0.id == arg_18_1
	end)
	local var_18_2 = var_0_1.get(arg_18_1, var_18_0).favour_level

	if var_18_1 and next(var_18_1) then
		for iter_18_0 = 1, #var_18_1 do
			if var_18_1[iter_18_0].level == var_18_0 + 1 then
				var_18_2 = var_18_1[iter_18_0].favour_level
			end
		end
	end

	return var_18_2
end

function KnightTissueData:getTissueLevelPassive(arg_20_1)
	if self._tissuePassiveCache[arg_20_1] ~= nil then
		return self._tissuePassiveCache[arg_20_1]
	end

	local var_20_0 = {}
	local var_20_1 = var_0_1.match(function(arg_21_0)
		return arg_21_0.id == arg_20_1
	end)

	if #var_20_1 > 0 then
		for iter_20_0, iter_20_1 in pairs(var_20_1) do
			if not var_20_0[iter_20_1.skill_id] then
				var_20_0[#var_20_0 + 1] = iter_20_1
				var_20_0[iter_20_1.skill_id] = true
			end
		end
	end

	self._tissuePassiveCache[arg_20_1] = var_20_0

	return var_20_0
end

function KnightTissueData:isLevelUpHavePassiveActiveShow(arg_22_1, arg_22_2)
	for iter_22_0, iter_22_1 in ipairs((self:getTissueLevelPassive(arg_22_1))) do
		if iter_22_1.level == arg_22_2 then
			return true
		end
	end

	return false
end

function KnightTissueData:getTissueMaxLevel(arg_23_1)
	if self._tissueMaxLevelCache[arg_23_1] ~= nil then
		return self._tissueMaxLevelCache[arg_23_1]
	end

	local var_23_0 = 0
	local var_23_1 = var_0_1.match(function(arg_24_0)
		return arg_24_0.id == arg_23_1
	end)

	if var_23_1 and next(var_23_1) then
		var_23_0 = var_23_1[#var_23_1].level
	end

	self._tissueMaxLevelCache[arg_23_1] = var_23_0

	return var_23_0
end

function KnightTissueData:getTissueAttrCountById(arg_25_1, arg_25_2)
	local var_25_0 = 0
	local var_25_1 = var_0_1.get(arg_25_1, arg_25_2)

	if var_25_1 then
		for iter_25_0 = 1, 3 do
			if var_25_1["attr_type_" .. iter_25_0] > 0 then
				var_25_0 = var_25_0 + 1
			end
		end
	end

	return var_25_0
end

function KnightTissueData:getMatchTissueIdByKnight(arg_26_1)
	local var_26_0 = 0

	if not g.core.model.User.knightFavoData:isFavoEnable(arg_26_1) then
		return var_26_0
	end

	local var_26_1 = {}

	for iter_26_0 = 1, var_0_0.getLength() do
		local var_26_2 = var_0_0.indexOf(iter_26_0)

		for iter_26_1 = 1, var_0_4.TISSUE_KNIGHT_MAX do
			if var_26_2["knight_" .. iter_26_1] > 0 and var_26_2["knight_" .. iter_26_1] == arg_26_1 then
				table.insert(var_26_1, var_26_2.id)
			end
		end
	end

	if #var_26_1 == 1 then
		var_26_0 = var_26_1[1]
	elseif #var_26_1 > 1 then
		local var_26_3 = var_0_1.match(function(arg_27_0)
			return arg_27_0.skill_target == arg_26_1
		end)

		if var_26_3 and next(var_26_3) then
			var_26_0 = var_26_3[#var_26_3].id
		end
	end

	return var_26_0
end

function KnightTissueData:setTipsFlag(arg_28_1)
	self._tipsFlag = arg_28_1
end

function KnightTissueData:getTipsFlag()
	return self._tipsFlag
end

function KnightTissueData:isTissueCanActiveOrLevelUp(arg_30_1)
	if not arg_30_1.id then
		return (self:getAllTissueCanActiveOrLvUp())
	end

	local var_30_0 = arg_30_1.id
	local var_30_1 = self:getKnightTissueLevel(arg_30_1.id)

	if var_30_1 >= self:getTissueMaxLevel(arg_30_1.id) then
		return false
	end

	if var_30_1 <= 0 then
		if ((var_0_0.get(var_30_0).free_upgrade == 1 or nil) and 1) <= self:getTissueCollectCountById(var_30_0) then
			return true
		end
	elseif self:getNextLevelSumValue(var_30_0) <= self:getTotalLevelByKnightTissueId(var_30_0) then
		return true
	end

	return false
end

function KnightTissueData:getAllTissueCanActiveOrLvUp()
	local var_31_0 = false

	for iter_31_0 = 1, var_0_0.getLength() do
		if self:isTissueCanActiveOrLevelUp({
			id = var_0_0.indexOf(iter_31_0).id
		}) then
			var_31_0 = true

			break
		end
	end

	return var_31_0
end

function KnightTissueData:getKnightTissueListData(arg_32_1, arg_32_2)
	local var_32_0 = {}

	for iter_32_0, iter_32_1 in pairs(self._tissueGroupData) do
		table.insert(var_32_0, {
			isMain = true,
			isSelect = iter_32_0 == arg_32_1,
			info = var_0_2.get(iter_32_0).toObject()
		})

		if iter_32_0 == arg_32_1 then
			for iter_32_2, iter_32_3 in pairs(iter_32_1) do
				table.insert(var_32_0, {
					isMain = false,
					isSelect = iter_32_3.id == arg_32_2,
					info = clone(iter_32_3)
				})
			end
		end
	end

	return var_32_0
end

function KnightTissueData:updateRedPoint(arg_33_1)
	self:initKnightTissueLevelData({
		tissues = arg_33_1
	})
end

return KnightTissueData

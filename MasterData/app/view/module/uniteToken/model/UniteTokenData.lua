local UniteTokenData = class("UniteTokenData")
local UniteTokenStructData = import(".UniteTokenStructData")
local var_0_2 = g.core.const.ConstMgr.QUALITY_TYPE
local var_0_3 = g.core.config.passive_skill_info
local var_0_4 = g.core.const.ConstMgr.UniteTokenConst
local var_0_5 = g.core.config.unite_token_info
local var_0_6 = g.core.config.unite_token_rune_info
local var_0_7 = g.core.config.parameter_info

UniteTokenData.COLUMN = 5
UniteTokenData.MAX_UPGRADE_LEVEL = 100

function UniteTokenData:ctor()
	self:initData()
end

function UniteTokenData:initData()
	self._tokenList = {}
	self._tokenMap = {}
	self._tokenConditionList = {}
	self._ownTokenList = {}
	self._awakenTokenList = {}
	self._lineupTokenList = {}
	self._tokenTotalAttr = {}
	self._uniteTotalAttr = {}
	self._refreshedData = {}
	self._flushData = g.core.model.User.bagData:getList(g.core.const.ConstMgr.BAG_TYPE.UNITE_TOKEN)
	self._init = false

	self:_initTokenList()
end

function UniteTokenData:_initTokenList()
	for iter_3_0 = 1, var_0_5.getLength() do
		local var_3_0 = var_0_5.indexOf(iter_3_0)

		if var_3_0.put and var_3_0.put ~= 0 and var_3_0.star == 0 and var_3_0.type == 1 then
			local var_3_1 = UniteTokenStructData.new(var_3_0.id)

			self._tokenList[#self._tokenList + 1] = var_3_1
			self._tokenMap[var_3_0.advance_id] = var_3_1
		end
	end
end

function UniteTokenData:getTokenDataBy(arg_4_1)
	return self._tokenMap[arg_4_1]
end

function UniteTokenData:updateTokenData(arg_5_1)
	if not self._init and next(self._flushData) then
		for iter_5_0 = 1, table.nums(self._flushData) do
			local var_5_0 = var_0_5.get(self._flushData[iter_5_0].base_id)

			if var_5_0.type == 1 and self._tokenMap[var_5_0.advance_id] then
				local var_5_1 = self._tokenMap[var_5_0.advance_id]:getBaseId()

				self._tokenMap[var_5_0.advance_id]:setOwn(true)
				self._tokenMap[var_5_0.advance_id]:setBaseId(self._flushData[iter_5_0].base_id)
				self._tokenMap[var_5_0.advance_id]:setPreStarId(var_5_1)
				self._tokenMap[var_5_0.advance_id]:setNextStarId(var_5_0.next_star_id)
				self._tokenMap[var_5_0.advance_id]:setAwaken(self._flushData[iter_5_0].awaken)
				self._tokenMap[var_5_0.advance_id]:setFormationPos(self._flushData[iter_5_0].position)
				self._tokenMap[var_5_0.advance_id]:setLevel(self._flushData[iter_5_0].level)
				self._tokenMap[var_5_0.advance_id]:setStarLevel(var_5_0.star)
				self._tokenMap[var_5_0.advance_id]:setServerId(self._flushData[iter_5_0].id)
				self._tokenMap[var_5_0.advance_id]:setSkillId(var_5_0.skill_id)
				self._tokenMap[var_5_0.advance_id]:setRunes(self._flushData[iter_5_0].runes)

				self._init = true
			end
		end
	end

	self:refreshUniteTokenData(arg_5_1)
end

function UniteTokenData:updateTokenAttr(arg_6_1)
	self._tokenTotalAttr = {}

	local var_6_0 = clone(arg_6_1.addition_attribute) or {}

	for iter_6_0 = 1, #var_6_0 do
		if math.uint64_lt(0, var_6_0[iter_6_0].value) then
			table.insert(self._tokenTotalAttr, var_6_0[iter_6_0])
		end
	end

	table.sort(self._tokenTotalAttr, function(arg_7_0, arg_7_1)
		if arg_7_0.type == 2 ~= (arg_7_1.type == 2) then
			return arg_7_0.type == 2
		end

		if arg_7_0.type ~= arg_7_1.type then
			return arg_7_0.type < arg_7_1.type
		end
	end)

	self._uniteTotalAttr = clone(arg_6_1.combo_attribute) or {}
end

function UniteTokenData:hasTokenByAdvId(arg_8_1)
	return (self._tokenMap[arg_8_1]:isOwn())
end

function UniteTokenData:addToUniteTokenList(arg_9_1)
	for iter_9_0, iter_9_1 in pairs(arg_9_1) do
		local var_9_0 = UniteTokenStructData.new(iter_9_1.base_id)

		var_9_0:setOwn(true)
		var_9_0:setServerId(iter_9_1.id)
		var_9_0:setLevel(iter_9_1.level)
		self:_updateTokenList(iter_9_1.base_id, var_9_0)

		self._tokenMap[var_0_5.get(iter_9_1.base_id).advance_id] = var_9_0
	end

	self:refreshUniteTokenData()
end

function UniteTokenData:refreshUniteTokenData(arg_10_1)
	self:_setOwnTokenList()
	self:_setAwakenTokenList()
end

function UniteTokenData:_updateTokenList(arg_11_1, arg_11_2)
	local var_11_0 = var_0_5.get(arg_11_1)

	for iter_11_0 = 1, #self._tokenList do
		if self._tokenList[iter_11_0]:getAdvanceId() == var_11_0.advance_id then
			self._tokenList[iter_11_0] = arg_11_2
		end
	end
end

function UniteTokenData:_updateTokenListByCondition(arg_12_1)
	self._tokenConditionList = {}

	for iter_12_0, iter_12_1 in ipairs(self._tokenList) do
		if iter_12_1:isAvailable(arg_12_1) then
			table.insert(self._tokenConditionList, iter_12_1)
		end
	end
end

function UniteTokenData:opUpdateUniteToken(arg_13_1)
	if #arg_13_1 > 0 then
		local var_13_0 = var_0_5.get(arg_13_1[1].base_id)

		self._tokenMap[var_13_0.advance_id]:setOwn(true)
		self._tokenMap[var_13_0.advance_id]:setRunes(arg_13_1[1].runes)
		self._tokenMap[var_13_0.advance_id]:setBaseId(arg_13_1[1].base_id)
		self._tokenMap[var_13_0.advance_id]:setPreStarId((self._tokenMap[var_13_0.advance_id]:getBaseId()))
		self._tokenMap[var_13_0.advance_id]:setNextStarId(var_13_0.next_star_id)
		self._tokenMap[var_13_0.advance_id]:setAwaken(arg_13_1[1].awaken)
		self._tokenMap[var_13_0.advance_id]:setFormationPos(arg_13_1[1].position)
		self._tokenMap[var_13_0.advance_id]:setLevel(arg_13_1[1].level)
		self._tokenMap[var_13_0.advance_id]:setStarLevel(var_13_0.star)
		self._tokenMap[var_13_0.advance_id]:setServerId(arg_13_1[1].id)
		self._tokenMap[var_13_0.advance_id]:setSkillId(var_13_0.skill_id)
		self:_updateTokenList(arg_13_1[1].base_id, self._tokenMap[var_13_0.advance_id])
		self:refreshUniteTokenData()

		self._refreshedData = self._tokenMap[var_13_0.advance_id]
	end
end

function UniteTokenData:hasTokenToCompose()
	for iter_14_0, iter_14_1 in ipairs(self._tokenList) do
		if not iter_14_1:isOwn() and iter_14_1:canCompose() then
			return true
		end
	end

	return false
end

function UniteTokenData:_setOwnTokenList()
	self._ownTokenList = {}

	for iter_15_0, iter_15_1 in ipairs(self._tokenList) do
		if iter_15_1:isOwn() then
			table.insert(self._ownTokenList, iter_15_1)
		end
	end
end

function UniteTokenData:getFiveMaxTokenAvgLv()
	if #self._ownTokenList < 5 then
		local var_16_0 = 0

		for iter_16_0, iter_16_1 in ipairs(self._ownTokenList) do
			var_16_0 = var_16_0 + iter_16_1:getLevel()
		end

		return math.floor(var_16_0 / #self._ownTokenList / 10) * 10 - 20
	else
		local var_16_1 = clone(self._ownTokenList)

		table.sort(var_16_1, function(arg_17_0, arg_17_1)
			return arg_17_0:getLevel() > arg_17_1:getLevel()
		end)

		local var_16_2 = 0

		for iter_16_2 = 1, 5 do
			var_16_2 = var_16_2 + var_16_1[iter_16_2]:getLevel()
		end

		return math.floor(var_16_2 / 5 / 10) * 10 - 20
	end
end

function UniteTokenData:_setAwakenTokenList()
	self._awakenTokenList = {}

	for iter_18_0, iter_18_1 in ipairs(self._tokenList) do
		if iter_18_1:isAwaken() then
			table.insert(self._awakenTokenList, iter_18_1)
		end
	end
end

function UniteTokenData:getCanComposeCount()
	local var_19_0 = 0

	for iter_19_0, iter_19_1 in ipairs(self._tokenList) do
		if iter_19_1:canCompose() then
			var_19_0 = var_19_0 + 1
		end
	end

	return var_19_0
end

function UniteTokenData:_getTopShowConditionList()
	local var_20_0 = {}

	for iter_20_0, iter_20_1 in ipairs(self._tokenConditionList) do
		if iter_20_1:isTopShow() then
			table.insert(var_20_0, iter_20_1)
		end
	end

	return var_20_0
end

function UniteTokenData:getNonSynConditionTokenList()
	local var_21_0 = {}

	for iter_21_0, iter_21_1 in ipairs(self._tokenConditionList) do
		if not iter_21_1:isOwn() and not iter_21_1:canCompose() then
			table.insert(var_21_0, iter_21_1)
		end
	end

	return var_21_0
end

function UniteTokenData:updateTokenAwaken(arg_22_1)
	self._tokenMap[var_0_5.get(arg_22_1.id).advance_id]:setAwaken(true)
	self:refreshUniteTokenData()
end

function UniteTokenData:updateTokenFormation(arg_23_1)
	self._lineupTokenList = {}

	for iter_23_0, iter_23_1 in pairs(self._tokenMap) do
		iter_23_1:setFormationPos(0)
	end

	for iter_23_2, iter_23_3 in ipairs(arg_23_1) do
		if iter_23_3 > 0 then
			if self._tokenMap[iter_23_3] then
				self._tokenMap[iter_23_3]:setFormationPos(iter_23_2)

				self._lineupTokenList[iter_23_2] = self._tokenMap[iter_23_3]
			end
		else
			self._lineupTokenList[iter_23_2] = {}
		end
	end
end

function UniteTokenData:getAwakenTokenConditionList(arg_24_1)
	local var_24_0 = {}

	for iter_24_0, iter_24_1 in ipairs(self._awakenTokenList) do
		if iter_24_1:isAvailable(arg_24_1) then
			table.insert(var_24_0, iter_24_1)
		end
	end

	return var_24_0
end

function UniteTokenData:getIndexById(arg_25_1)
	self:getSortOwnTokenList()

	for iter_25_0, iter_25_1 in ipairs(self._ownTokenList) do
		if arg_25_1 == iter_25_1:getBaseId() then
			return iter_25_0
		end
	end

	return 1
end

function UniteTokenData:getNotLineupTokenList()
	local var_26_0 = {}

	for iter_26_0, iter_26_1 in ipairs(self._ownTokenList) do
		if not iter_26_1:isLineup() then
			table.insert(var_26_0, iter_26_1)
		end
	end

	return var_26_0
end

function UniteTokenData:getTokenListByQuality(arg_27_1)
	local var_27_0 = {}

	for iter_27_0, iter_27_1 in ipairs(self._ownTokenList) do
		if arg_27_1 == 0 or iter_27_1:getQuality() == arg_27_1 then
			table.insert(var_27_0, iter_27_1)
		end
	end

	table.sort(var_27_0, function(arg_28_0, arg_28_1)
		if arg_28_0:isLineup() ~= arg_28_1:isLineup() then
			return arg_28_0:isLineup()
		end

		if arg_28_0:getQuality() ~= arg_28_1:getQuality() then
			return arg_28_0:getQuality() > arg_28_1:getQuality()
		end

		if arg_28_0:getStarLevel() ~= arg_28_1:getStarLevel() then
			return arg_28_0:getStarLevel() > arg_28_1:getStarLevel()
		end

		if arg_28_0:getLevel() ~= arg_28_1:getLevel() then
			return arg_28_0:getLevel() > arg_28_1:getLevel()
		end

		return arg_28_0:getBaseId() > arg_28_1:getBaseId()
	end)

	return var_27_0
end

function UniteTokenData:getTotalBasicAttr()
	local var_29_0 = {}

	for iter_29_0, iter_29_1 in ipairs(self._ownTokenList) do
		for iter_29_2 = 1, 4 do
			local var_29_1 = var_0_5.get((iter_29_1:getBaseId()))

			var_29_0[var_29_1["basic_type_" .. iter_29_2]] = var_29_0[var_29_1["basic_type_" .. iter_29_2]] and var_29_0[var_29_1["basic_type_" .. iter_29_2]] + var_29_1["basic_value_" .. iter_29_2] or var_29_1["basic_value_" .. iter_29_2]
		end
	end

	return var_29_0
end

function UniteTokenData:getLineupTokenCount()
	local var_30_0 = 0

	for iter_30_0, iter_30_1 in ipairs(self._lineupTokenList) do
		if iter_30_1.getPos and iter_30_1:getPos() > 0 then
			var_30_0 = var_30_0 + 1
		end
	end

	return var_30_0
end

function UniteTokenData:hasLineupTokenByPos(arg_31_1)
	return checkbool((self:getLineupTokenByPos(arg_31_1)))
end

function UniteTokenData:getLineupTokenByPos(arg_32_1)
	for iter_32_0, iter_32_1 in ipairs(self._lineupTokenList) do
		if iter_32_1.getPos and iter_32_1:getPos() == arg_32_1 then
			return iter_32_1
		end
	end
end

function UniteTokenData:hasLineupTokenById(arg_33_1)
	for iter_33_0, iter_33_1 in ipairs(self._lineupTokenList) do
		if iter_33_1.getAdvanceId and iter_33_1:getAdvanceId() == arg_33_1 then
			return true
		end
	end

	return false
end

function UniteTokenData:getUniteValue()
	local var_34_0 = 0
	local var_34_1 = 0

	for iter_34_0, iter_34_1 in ipairs(self._uniteTotalAttr) do
		if iter_34_1.type == var_0_4.INIT_UNITE_VALUE_ID then
			var_34_0 = iter_34_1.value
		elseif iter_34_1.type == var_0_4.TOTAL_UNITE_VALUE_ID then
			var_34_1 = iter_34_1.value
		end
	end

	return var_34_0, var_34_1
end

function UniteTokenData:getStarUpFragmentNum(arg_35_1)
	local var_35_0 = var_0_5.get(arg_35_1).fragment_id

	return g.core.model.User.fragmentsData:getFragmentNumById(var_35_0), g.core.config.fragment_info.get(var_35_0).combine_num
end

function UniteTokenData:getMaxStarLevel(arg_36_1)
	local var_36_0 = 0
	local var_36_1 = {}

	for iter_36_0 = 1, var_0_5.getLength() do
		local var_36_2 = var_0_5.indexOf(iter_36_0)

		if var_36_2.advance_id == arg_36_1 then
			if var_36_2.next_star_id == 0 then
				var_36_0 = var_36_2.star
			elseif var_36_2.star == 0 then
				var_36_1[1] = var_36_2.skill_id
				var_36_1[2] = var_36_2.next_star_id
			else
				var_36_1[var_36_2.star + 2] = var_36_2.next_star_id
			end
		end
	end

	return var_36_0, var_36_1
end

function UniteTokenData:getTokenMaxLevel(arg_37_1)
	local var_37_0 = var_0_5.get(arg_37_1)

	for iter_37_0 = 1, g.core.config.unite_token_upgrade_info.getLength() do
		local var_37_1 = g.core.config.unite_token_upgrade_info.indexOf(iter_37_0)

		if var_37_1.id == var_37_0.upgrade_code and var_37_1.cost_type == 0 then
			return var_37_1.level
		end
	end

	return 0
end

function UniteTokenData:getTokenByServerId(arg_38_1)
	for iter_38_0, iter_38_1 in ipairs(self._tokenList) do
		if iter_38_1:getServerId() == arg_38_1 then
			return iter_38_1
		end
	end
end

function UniteTokenData:getTokenByRealServerId(arg_39_1)
	for iter_39_0, iter_39_1 in ipairs(self._tokenList) do
		if iter_39_1:getRealServerId() == arg_39_1 then
			return iter_39_1
		end
	end
end

function UniteTokenData:getSkillDesByAdvId(arg_40_1)
	return (self._tokenMap[arg_40_1]:getSkillDescription())
end

function UniteTokenData:getOwnTokenListRanked()
	local var_41_0 = {}

	for iter_41_0, iter_41_1 in ipairs((self:getOwnTokenList())) do
		var_41_0[1] = iter_41_1
	end

	table.sort(var_41_0, function(arg_42_0, arg_42_1)
		if arg_42_0:isLineup() ~= arg_42_1:isLineup() then
			return arg_42_0:isLineup()
		end

		if arg_42_0:getQuality() ~= arg_42_1:getQuality() then
			return arg_42_0:getQuality() > arg_42_1:getQuality()
		end

		if arg_42_0:getStarLevel() ~= arg_42_1:getStarLevel() then
			return arg_42_0:getStarLevel() > arg_42_1:getStarLevel()
		end

		return arg_42_0:getAdvanceId() > arg_42_1:getAdvanceId()
	end)

	return var_41_0
end

function UniteTokenData:getTokenListByLineupCheck(arg_43_1)
	local var_43_0 = {}
	local var_43_1 = 1

	if arg_43_1 then
		for iter_43_0, iter_43_1 in ipairs((self:getTokenList())) do
			if (iter_43_1:isOwn() or iter_43_1:canCompose()) and not iter_43_1:isLineup() then
				var_43_0[var_43_1] = iter_43_1
				var_43_1 = var_43_1 + 1
			end
		end
	else
		for iter_43_2, iter_43_3 in ipairs((self:getTokenList())) do
			if iter_43_3:isOwn() or iter_43_3:canCompose() then
				var_43_0[var_43_1] = iter_43_3
				var_43_1 = var_43_1 + 1
			end
		end
	end

	table.sort(var_43_0, function(arg_44_0, arg_44_1)
		if arg_44_0:canStarup() ~= arg_44_1:canStarup() then
			return arg_44_0:canStarup()
		end

		if arg_44_0:canCompose() ~= arg_44_1:canCompose() then
			return arg_44_0:canCompose()
		end

		if arg_44_0:canAwaken() ~= arg_44_1:canAwaken() then
			return arg_44_0:canAwaken()
		end

		if arg_44_0:isLineup() ~= arg_44_1:isLineup() then
			return arg_44_0:isLineup()
		end

		if arg_44_0:isAwaken() ~= arg_44_1:isAwaken() then
			return arg_44_0:isAwaken()
		end

		if arg_44_0:isOwn() ~= arg_44_1:isOwn() then
			return arg_44_0:isOwn()
		end

		if arg_44_0:getQuality() ~= arg_44_1:getQuality() then
			return arg_44_0:getQuality() > arg_44_1:getQuality()
		end

		if arg_44_0:getStarLevel() ~= arg_44_1:getStarLevel() then
			return arg_44_0:getStarLevel() > arg_44_1:getStarLevel()
		end

		if arg_44_0:getLevel() ~= arg_44_1:getLevel() then
			return arg_44_0:getLevel() > arg_44_1:getLevel()
		end

		if arg_44_0:getFragmentNum() ~= arg_44_1:getFragmentNum() then
			return arg_44_0:getFragmentNum() > arg_44_1:getFragmentNum()
		end

		return arg_44_0:getAdvanceId() > arg_44_1:getAdvanceId()
	end)

	return var_43_0
end

function UniteTokenData:getNewSortTokenList()
	local var_45_0 = {}
	local var_45_1 = {}

	for iter_45_0, iter_45_1 in ipairs((self:getTokenList())) do
		local var_45_2

		if iter_45_1:getPut() == 1 then
			if iter_45_1:isOwn() or iter_45_1:canCompose() then
				var_45_0[1] = iter_45_1
				var_45_2 = 1 + 1
			else
				table.insert(var_45_1, iter_45_1)
			end
		end
	end

	table.sort(var_45_0, function(arg_46_0, arg_46_1)
		if arg_46_0:isLineup() ~= arg_46_1:isLineup() then
			return arg_46_0:isLineup()
		end

		if arg_46_0:canCompose() ~= arg_46_1:canCompose() then
			return arg_46_0:canCompose()
		end

		if arg_46_0:canStarup() ~= arg_46_1:canStarup() then
			return arg_46_0:canStarup()
		end

		if arg_46_0:canUpgrade() ~= arg_46_1:canUpgrade() then
			return arg_46_0:canUpgrade()
		end

		if arg_46_0:getQuality() ~= arg_46_1:getQuality() then
			return arg_46_0:getQuality() > arg_46_1:getQuality()
		end

		if arg_46_0:getStarLevel() ~= arg_46_1:getStarLevel() then
			return arg_46_0:getStarLevel() > arg_46_1:getStarLevel()
		end

		if arg_46_0:getLevel() ~= arg_46_1:getLevel() then
			return arg_46_0:getLevel() > arg_46_1:getLevel()
		end

		return arg_46_0:getAdvanceId() > arg_46_1:getAdvanceId()
	end)
	table.sort(var_45_1, function(arg_47_0, arg_47_1)
		if arg_47_0:getQuality() ~= arg_47_1:getQuality() then
			return arg_47_0:getQuality() > arg_47_1:getQuality()
		end

		return arg_47_0:getAdvanceId() > arg_47_1:getAdvanceId()
	end)

	return var_45_0, var_45_1
end

function UniteTokenData:getNotOwnTokenList()
	local var_48_0 = {}

	for iter_48_0, iter_48_1 in ipairs((self:getTokenList())) do
		if iter_48_1:getPut() == 1 and not iter_48_1:isOwn() and not iter_48_1:canCompose() and iter_48_1:getFragmentNum() > 0 then
			var_48_0[#var_48_0 + 1] = iter_48_1
		end
	end

	table.sort(var_48_0, function(arg_49_0, arg_49_1)
		if arg_49_0:getFragmentNum() ~= arg_49_1:getFragmentNum() then
			return arg_49_0:getFragmentNum() > arg_49_1:getFragmentNum()
		end

		if arg_49_0:getQuality() ~= arg_49_1:getQuality() then
			return arg_49_0:getQuality() > arg_49_1:getQuality()
		end

		return arg_49_0:getAdvanceId() > arg_49_1:getAdvanceId()
	end)

	return var_48_0
end

function UniteTokenData:getTokenUIListByLineupCheck(arg_50_1)
	local var_50_0 = self:getTokenListByLineupCheck(arg_50_1)
	local var_50_1 = self:getNotOwnTokenList()

	if #var_50_1 > 0 then
		local var_50_2 = UniteTokenData.COLUMN - table.nums(var_50_0) % UniteTokenData.COLUMN

		if var_50_2 ~= UniteTokenData.COLUMN then
			for iter_50_0 = 1, var_50_2 do
				local var_50_3 = {}

				var_50_3.isEmptyItem = true
				var_50_0[#var_50_0 + 1] = var_50_3
			end
		end

		local var_50_4 = {}

		var_50_4.isLine = true
		var_50_0[#var_50_0 + 1] = var_50_4

		for iter_50_1 = 1, UniteTokenData.COLUMN - 1 do
			local var_50_5 = {}

			var_50_5.isEmptyLine = true
			var_50_0[#var_50_0 + 1] = var_50_5
		end

		for iter_50_2, iter_50_3 in ipairs(var_50_1) do
			var_50_0[#var_50_0 + 1] = iter_50_3
		end
	end

	return var_50_0
end

function UniteTokenData:getSkillDamages()
	local var_51_0 = g.core.model.User.knightsData:getLineUpList()
	local var_51_1 = g.core.config.battle_parameter_info.get(100 + #var_51_0)
	local var_51_2 = {}
	local var_51_3 = 0

	for iter_51_0, iter_51_1 in ipairs(var_51_0) do
		local var_51_4 = math.floor(iter_51_1:getAttrs().attack / (var_51_1.value / 1000))

		var_51_2[iter_51_0] = {
			damage = var_51_4,
			knight = iter_51_1
		}
		var_51_3 = var_51_3 + var_51_4
	end

	return var_51_2, var_51_3
end

function UniteTokenData:getInsetNum(arg_52_1, arg_52_2)
	local var_52_0 = 0

	for iter_52_0, iter_52_1 in ipairs((g.core.utils.Number.tenToTwoByteList(arg_52_1, arg_52_2))) do
		var_52_0 = var_52_0 + iter_52_1
	end

	return var_52_0
end

function UniteTokenData:getHoleInsetList(arg_53_1, arg_53_2)
	local var_53_0 = g.core.utils.Number.tenToTwoByteList(arg_53_1, arg_53_2)
	local var_53_1 = {}

	for iter_53_0 = #var_53_0, 1, -1 do
		table.insert(var_53_1, var_53_0[iter_53_0])
	end

	return var_53_1
end

function UniteTokenData:getInsetTalentList(arg_54_1)
	local var_54_0 = self:getTokenByAdvId(arg_54_1)
	local var_54_1 = var_0_6.get(arg_54_1)
	local var_54_2 = {}

	for iter_54_0 = 1, 3 do
		if var_54_1["talent_id_" .. iter_54_0] and var_54_1["talent_id_" .. iter_54_0] > 0 then
			local var_54_3 = g.core.config.talent_skill_info.get(var_54_1["talent_id_" .. iter_54_0])

			if var_54_3 then
				table.insert(var_54_2, {
					name = var_54_3.name,
					open_value = var_54_3.open_value,
					description = var_54_3.description
				})
			end
		end
	end

	return var_54_2
end

function UniteTokenData:getInsetTalentNum(arg_55_1, arg_55_2)
	local var_55_0 = self:getInsetNum(arg_55_2, var_0_6.get(arg_55_1).num)
	local var_55_1 = 0
	local var_55_2 = 0
	local var_55_3 = 0

	for iter_55_0, iter_55_1 in ipairs((self:getInsetTalentList(arg_55_1))) do
		if var_55_0 >= iter_55_1.open_value then
			var_55_1 = iter_55_1.open_value
			var_55_2 = iter_55_1.description
			var_55_3 = var_55_3 + 1
		end
	end

	return {
		talentNum = var_55_1,
		talentDesc = var_55_2,
		talentInsetCount = var_55_3
	}
end

function UniteTokenData:getTokenBaseInfo(arg_56_1)
	local var_56_0 = var_0_5.get(arg_56_1)
	local var_56_1 = {}

	for iter_56_0 = 1, var_0_4.BASE_ATTR_NUM do
		local var_56_2 = var_56_0["basic_type_" .. iter_56_0]
		local var_56_3 = var_56_0["awaken_type_" .. iter_56_0]

		if var_56_0["basic_type_" .. iter_56_0] > 0 or var_56_3 > 0 then
			local var_56_4 = var_56_2 > 0 and var_56_2 or var_56_3
			local var_56_5, var_56_6 = g.core.lang:getAttr(var_56_2 > 0 and var_56_2 or var_56_3, var_56_0["basic_value_" .. iter_56_0] + var_56_0["awaken_value_" .. iter_56_0], true)

			table.insert(var_56_1, {
				type = var_56_4,
				name = g.core.lang:get(202511) .. var_56_5,
				value = var_56_6
			})
		end
	end

	local var_56_7 = {
		skillId = var_56_0.skill_id,
		level = var_56_0.star + 1,
		desc = g.core.utils.String.formatSkillDesc(var_56_0.skill_id)
	}

	setmetatable(var_56_7, {
		__index = function(self, arg_57_1)
			if self.skillId and arg_57_1 == "cfg" then
				local var_57_0 = g.core.config.skill_info.get(self.skillId)

				self.cfg = var_57_0

				return var_57_0
			end
		end
	})

	return {
		attrList = var_56_1,
		skillInfo = var_56_7
	}
end

function UniteTokenData:getTokenAwakenInfo(arg_58_1)
	local var_58_0 = var_0_5.get(arg_58_1)
	local var_58_1 = {}

	for iter_58_0 = 1, var_0_4.AWAKEN_ATTR_NUM do
		if var_58_0["awaken_type_" .. iter_58_0] > 0 then
			local var_58_2, var_58_3 = g.core.lang:getAttr(var_58_0["awaken_type_" .. iter_58_0], var_58_0["awaken_value_" .. iter_58_0], true)

			table.insert(var_58_1, {
				type = var_58_0["awaken_type_" .. iter_58_0],
				name = g.core.lang:get(202511) .. var_58_2,
				value = var_58_3
			})
		end
	end

	return {
		attrList = var_58_1
	}
end

function UniteTokenData:getTokenUpgradeInfo(arg_59_1, arg_59_2, arg_59_3)
	local var_59_0 = g.core.config.unite_token_upgrade_info.get(arg_59_1, arg_59_2)
	local var_59_1 = {}

	for iter_59_0 = 1, var_0_4.LV_ATTR_NUM do
		local var_59_2 = iter_59_0
		local var_59_3 = 0

		if var_59_0["upgrade_type_" .. iter_59_0] > 0 then
			var_59_2 = var_59_0["upgrade_type_" .. iter_59_0]
			var_59_3 = var_59_0["upgrade_value_" .. iter_59_0]
		end

		local var_59_4, var_59_5 = g.core.lang:getAttr(var_59_2, var_59_3, true)

		var_59_1[iter_59_0] = {
			type = var_59_2,
			name = g.core.lang:get(202511) .. var_59_4,
			value = var_59_5
		}
	end

	local var_59_6 = {}

	if not arg_59_3 then
		local var_59_7
		local var_59_8 = false

		if arg_59_2 < UniteTokenData.MAX_UPGRADE_LEVEL then
			var_59_7 = g.core.config.unite_token_upgrade_info.get(arg_59_1, arg_59_2 + 1)
		else
			var_59_8 = true
		end

		for iter_59_1 = 1, var_0_4.LV_ATTR_NUM do
			var_59_6[iter_59_1] = var_59_8 and 0 or var_59_7["upgrade_value_" .. iter_59_1] - var_59_0["upgrade_value_" .. iter_59_1]
		end
	end

	local var_59_9
	local var_59_10 = {}
	local var_59_11 = 0
	local var_59_12 = var_0_7.get(19005).parameter

	for iter_59_2, iter_59_3 in g.core.config.unite_token_upgrade_info.ipairs() do
		if arg_59_1 == iter_59_3.id and iter_59_3.talent > 0 then
			local var_59_13 = {
				info = g.core.config.talent_skill_info.get(iter_59_3.talent),
				level = iter_59_3.level,
				isActive = arg_59_2 >= iter_59_3.level
			}

			if arg_59_2 < iter_59_3.level then
				var_59_9 = var_59_9 or clone(var_59_13)
			end

			if not var_59_13.isActive then
				var_59_11 = var_59_11 + 1
			end

			if var_59_11 <= var_59_12 then
				table.insert(var_59_10, var_59_13)
			end
		end
	end

	var_59_9 = var_59_9 or clone(var_59_10[#var_59_10])

	return {
		cfg = var_59_0,
		attrList = var_59_1,
		addAttrList = var_59_6,
		talentInfo = var_59_9,
		talentList = var_59_10
	}
end

function UniteTokenData:getTokenStarInfo(arg_60_1, arg_60_2, arg_60_3)
	if not arg_60_2 then
		return nil
	end

	local var_60_0 = arg_60_2.star

	if arg_60_3 then
		var_60_0 = var_60_0 + 1
	end

	local var_60_1 = {}

	for iter_60_0 = 1, var_0_4.STAR_ATTR_NUM do
		if arg_60_2["basic_type_" .. iter_60_0] > 0 then
			local var_60_2, var_60_3 = g.core.lang:getAttr(arg_60_2["basic_type_" .. iter_60_0], arg_60_2["basic_value_" .. iter_60_0], true)

			table.insert(var_60_1, {
				type = arg_60_2["basic_type_" .. iter_60_0],
				name = g.core.lang:get(202511) .. var_60_2,
				value = var_60_3
			})
		end
	end

	local var_60_4 = {}
	local var_60_5, var_60_6 = self:getMaxStarLevel(arg_60_1)
	local var_60_7 = {
		__index = function(self, arg_61_1)
			if self.skillId and arg_61_1 == "cfg" then
				local var_61_0 = g.core.config.skill_info.get(self.skillId)

				self.cfg = var_61_0

				return var_61_0
			end
		end
	}

	for iter_60_1 = 1, #var_60_6 do
		if var_60_0 == iter_60_1 - 1 then
			var_60_4 = {
				skillId = var_60_6[iter_60_1],
				level = iter_60_1,
				desc = g.core.utils.String.formatSkillDesc(var_60_6[iter_60_1])
			}

			setmetatable(var_60_4, var_60_7)

			break
		end
	end

	return {
		starNum = var_60_0,
		maxStarNum = var_60_5,
		attrList = var_60_1,
		skillInfo = var_60_4,
		isMax = var_60_5 <= var_60_0
	}
end

function UniteTokenData:getTokenPassiveInfo(arg_62_1, arg_62_2)
	local var_62_0 = {}

	for iter_62_0 = 1, var_0_5.getLength() do
		local var_62_1 = var_0_5.indexOf(iter_62_0)

		if var_62_1.advance_id == arg_62_1 and var_62_1.star == 0 then
			table.insert(var_62_0, var_62_1)

			while var_62_1.next_star_id > 0 do
				var_62_1 = var_0_5.get(var_62_1.next_star_id)

				table.insert(var_62_0, var_62_1)
			end

			break
		end
	end

	local var_62_2
	local var_62_3 = {}
	local var_62_4 = 1

	for iter_62_1, iter_62_2 in ipairs(var_62_0) do
		local var_62_5

		if iter_62_2.quality >= var_0_2.UR and iter_62_2.passive_skill_id > 0 and 0 ~= iter_62_2.passive_skill_id then
			var_62_5 = iter_62_2.passive_skill_id

			table.insert(var_62_3, {
				isPassive = true,
				skillId = iter_62_2.passive_skill_id,
				level = var_62_4,
				passiveCfg = var_0_3.get(iter_62_2.passive_skill_id),
				desc = g.core.utils.String.formatPassiveSkillDesc(iter_62_2.passive_skill_id)
			})

			var_62_4 = var_62_4 + 1
		end

		if iter_62_1 - 1 == arg_62_2 then
			var_62_2 = var_62_3[#var_62_3]
		end
	end

	return var_62_2, var_62_3
end

function UniteTokenData:getFullAttrList(arg_63_1, arg_63_2, arg_63_3)
	local var_63_0 = {}
	local var_63_1 = {}

	for iter_63_0 = 1, var_0_4.STAR_ATTR_NUM do
		if arg_63_3["basic_type_" .. iter_63_0] > 0 then
			local var_63_2, var_63_3 = g.core.lang:getAttr(arg_63_3["basic_type_" .. iter_63_0], arg_63_3["basic_value_" .. iter_63_0], true)

			if not var_63_1[arg_63_3["basic_type_" .. iter_63_0]] then
				table.insert(var_63_0, {
					type = arg_63_3["basic_type_" .. iter_63_0],
					name = g.core.lang:get(202511) .. var_63_2,
					value = var_63_3
				})

				var_63_1[arg_63_3["basic_type_" .. iter_63_0]] = #var_63_0
			else
				var_63_0[var_63_1[arg_63_3["basic_type_" .. iter_63_0]]].value = tonumber(var_63_0[var_63_1[arg_63_3["basic_type_" .. iter_63_0]]].value) + tonumber(var_63_3)
			end
		end
	end

	local var_63_4 = g.core.config.unite_token_upgrade_info.get(arg_63_1, arg_63_2)

	for iter_63_1 = 1, var_0_4.LV_ATTR_NUM do
		if var_63_4["upgrade_type_" .. iter_63_1] > 0 then
			local var_63_7, var_63_8 = g.core.lang:getAttr(var_63_4["upgrade_type_" .. iter_63_1], var_63_4["upgrade_value_" .. iter_63_1], true)

			if not var_63_1[var_63_4["upgrade_type_" .. iter_63_1]] then
				table.insert(var_63_0, {
					type = var_63_4["upgrade_type_" .. iter_63_1],
					name = g.core.lang:get(202511) .. var_63_7,
					value = var_63_8
				})

				var_63_1[var_63_4["upgrade_type_" .. iter_63_1]] = #var_63_0
			else
				var_63_0[var_63_1[var_63_4["upgrade_type_" .. iter_63_1]]].value = tonumber(var_63_0[var_63_1[var_63_4["upgrade_type_" .. iter_63_1]]].value) + tonumber(var_63_8)
			end
		end
	end

	return var_63_0
end

function UniteTokenData:getTokenSkillList(arg_64_1, arg_64_2)
	local var_64_0 = var_0_5.get(arg_64_1)
	local var_64_1 = {}

	for iter_64_0, iter_64_1 in g.core.config.unite_token_info.ipairs() do
		if iter_64_1.advance_id == var_64_0.advance_id then
			table.insert(var_64_1, iter_64_1)
		end
	end

	local var_64_2

	if arg_64_2 then
		var_64_2 = arg_64_2 - 1 or var_64_0.star
	end

	local var_64_3 = {}

	for iter_64_2, iter_64_3 in ipairs(var_64_1) do
		table.insert(var_64_3, {
			info = g.core.config.skill_info.get(iter_64_3.skill_id),
			level = iter_64_3.star + 1,
			star = iter_64_3.star,
			isActive = var_64_2 >= iter_64_3.star,
			desc = g.core.utils.String.formatSkillDesc(iter_64_3.skill_id)
		})
	end

	return var_64_3
end

function UniteTokenData:getTokenPassiveSkillList(arg_65_1, arg_65_2)
	local var_65_0 = {}

	for iter_65_0 = 1, var_0_5.getLength() do
		local var_65_1 = var_0_5.indexOf(iter_65_0)

		if var_65_1.advance_id == arg_65_1 and var_65_1.star == 0 then
			table.insert(var_65_0, var_65_1)

			while var_65_1.next_star_id > 0 do
				var_65_1 = var_0_5.get(var_65_1.next_star_id)

				table.insert(var_65_0, var_65_1)
			end

			break
		end
	end

	local var_65_2 = 0
	local var_65_3 = {}
	local var_65_4 = 1

	for iter_65_1, iter_65_2 in ipairs(var_65_0) do
		if iter_65_2.quality >= var_0_2.UR and iter_65_2.passive_skill_id > 0 and var_65_2 ~= iter_65_2.passive_skill_id then
			var_65_2 = iter_65_2.passive_skill_id

			table.insert(var_65_3, {
				info = g.core.config.skill_info.get(iter_65_2.passive_skill_id),
				level = var_65_4,
				star = iter_65_2.star,
				isActive = arg_65_2 >= iter_65_2.star,
				desc = g.core.utils.String.formatPassiveSkillDesc(iter_65_2.passive_skill_id)
			})

			var_65_4 = var_65_4 + 1
		end
	end

	return var_65_3
end

function UniteTokenData:getSortOwnTokenList()
	table.sort(self._ownTokenList, function(arg_67_0, arg_67_1)
		if arg_67_0:isLineup() ~= arg_67_1:isLineup() then
			return arg_67_0:isLineup()
		end

		if arg_67_0:getQuality() ~= arg_67_1:getQuality() then
			return arg_67_0:getQuality() > arg_67_1:getQuality()
		end

		if arg_67_0:getStarLevel() ~= arg_67_1:getStarLevel() then
			return arg_67_0:getStarLevel() > arg_67_1:getStarLevel()
		end

		if arg_67_0:getLevel() ~= arg_67_1:getLevel() then
			return arg_67_0:getLevel() > arg_67_1:getLevel()
		end

		return arg_67_0:getBaseId() > arg_67_1:getBaseId()
	end)

	return self._ownTokenList
end

function UniteTokenData:getCanSellUniteTokenFragDataArr()
	local var_68_0 = {}

	for iter_68_0, iter_68_1 in ipairs((self:getFullUniteTokenFragmentArr())) do
		local var_68_1 = g.core.config.fragment_info.get(iter_68_1.id)

		table.insert(var_68_0, {
			type = g.core.common.Goods.TYPE_FRAGMENT,
			value = iter_68_1.id,
			size = iter_68_1.num,
			quality = var_68_1.quality,
			priceType = var_68_1.price_type,
			priceValue = var_68_1.price_value,
			priceSize = var_68_1.price_size
		})
	end

	table.sort(var_68_0, function(arg_69_0, arg_69_1)
		if arg_69_0.quality ~= arg_69_1.quality then
			return arg_69_0.quality < arg_69_1.quality
		end

		return arg_69_0.value < arg_69_1.value
	end)

	return var_68_0
end

function UniteTokenData:getFullUniteTokenFragmentArr()
	local var_70_0 = g.core.model.User.fragmentsData:getPetFragmentListByType(g.core.common.Goods.TYPE_UNITETOKEN)
	local var_70_1 = {}

	for iter_70_0, iter_70_1 in ipairs(self._ownTokenList) do
		for iter_70_2, iter_70_3 in ipairs(var_70_0) do
			if iter_70_3.id == iter_70_1:getFragId() and iter_70_1:isMaxStarLevel() then
				table.insert(var_70_1, iter_70_3)
			end
		end
	end

	return var_70_1
end

function UniteTokenData:getFullUniteTokenArr(arg_71_1)
	if arg_71_1 < 1 then
		return {}
	end

	local var_71_0 = {}

	for iter_71_0, iter_71_1 in ipairs(self._ownTokenList) do
		if iter_71_1:isMaxStarLevel() and arg_71_1 <= iter_71_1:getQuality() then
			table.insert(var_71_0, iter_71_1)
		end
	end

	return var_71_0
end

function UniteTokenData:getOwnTokenList()
	return self._ownTokenList
end

function UniteTokenData:getAllAwakenTokenList()
	return self._awakenTokenList
end

function UniteTokenData:getTokenMap()
	return self._tokenMap
end

function UniteTokenData:getTokenList()
	return self._tokenList
end

function UniteTokenData:getLineupTokenList()
	return self._lineupTokenList
end

function UniteTokenData:getTokenByAdvId(arg_77_1)
	return self._tokenMap[arg_77_1]
end

function UniteTokenData:getTokenCount()
	return #self._tokenList
end

function UniteTokenData:getOwnTokenCount()
	return #self._ownTokenList
end

function UniteTokenData:getTokenTotalAttr()
	return self._tokenTotalAttr
end

function UniteTokenData:getUniteTotalAttr()
	return self._uniteTotalAttr
end

function UniteTokenData:getRefreshedUniteData()
	return self._refreshedData
end

function UniteTokenData:hasUniteTokenCanCompose()
	for iter_83_0, iter_83_1 in ipairs((self:getTokenList())) do
		if iter_83_1:canCompose() then
			return true
		end
	end

	return false
end

function UniteTokenData:isUniteTokenCanBreakUp(arg_84_1)
	if arg_84_1 and arg_84_1.advId then
		local var_84_0 = self:getTokenDataBy(arg_84_1.advId)

		if not var_84_0:isOwn() then
			return false
		end

		local var_84_1 = self:getTokenStarInfo(arg_84_1.advId, (var_0_5.get(var_84_0:getBaseId())))

		if var_84_1.starNum < var_84_1.maxStarNum then
			local var_84_2, var_84_3 = var_84_0:getStarUpFragmentNum()

			if var_84_3 <= var_84_2 then
				return true
			end
		end

		return false
	else
		local var_84_4, var_84_5 = self:getNewSortTokenList()

		for iter_84_0, iter_84_1 in ipairs(var_84_4) do
			local var_84_6 = self:getTokenStarInfo(iter_84_1:getAdvanceId(), (var_0_5.get(iter_84_1:getBaseId())))

			if var_84_6.starNum < var_84_6.maxStarNum then
				local var_84_7, var_84_8 = iter_84_1:getStarUpFragmentNum()

				if var_84_8 <= var_84_7 then
					return true
				end
			end
		end

		return false
	end
end

function UniteTokenData:isUniteTokenCanLvUp(arg_85_1)
	if arg_85_1 and arg_85_1.advId then
		local var_85_0 = self:getTokenDataBy(arg_85_1.advId)

		if not var_85_0:isOwn() then
			return false
		end

		if var_85_0:getLevel() >= var_85_0:getTokenMaxLevel() then
			return false
		end

		local var_85_1, var_85_2, var_85_3, var_85_4, var_85_5 = var_85_0:canUpgrade()

		return var_85_1
	else
		local var_85_6, var_85_7 = self:getNewSortTokenList()

		for iter_85_0, iter_85_1 in ipairs(var_85_6) do
			local var_85_8, var_85_9, var_85_10, var_85_11, var_85_12 = iter_85_1:canUpgrade()

			if iter_85_1:getLevel() < iter_85_1:getTokenMaxLevel() and var_85_8 then
				return true
			end
		end

		return false
	end
end

function UniteTokenData:isHasNewUniteToken(arg_86_1)
	if arg_86_1 and arg_86_1.advId then
		if g.core.model.User.bagData:getNewData(g.core.const.ConstMgr.BAG_TYPE.UNITE_TOKEN, arg_86_1.advId) then
			return true
		end
	else
		local var_86_0 = g.core.model.User.bagData:getNewData(g.core.const.ConstMgr.BAG_TYPE.UNITE_TOKEN)

		if var_86_0 and next(var_86_0) then
			return true
		end
	end

	return false
end

function UniteTokenData:hasNotLineUpToken()
	for iter_87_0, iter_87_1 in ipairs(self._ownTokenList) do
		if not iter_87_1:isLineup() then
			return true
		end
	end

	return false
end

return UniteTokenData

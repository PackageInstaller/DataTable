local var_0_0 = g.core.config.knight_info
local var_0_1 = g.core.config.knight_favorability_addition_info
local var_0_2 = g.core.const.ConstMgr.FUNCTION_TYPE
local KnightFavoStruct = import(".KnightFavoStruct")
local KnightFavoData = class("KnightFavoData")

function KnightFavoData:ctor()
	self:initData()
end

function KnightFavoData:initData()
	self._knightInfoList = {}
	self._knightByIdList = {}
	self._hasReqPlotData = false
	self._isInit = false
	self._maxLevel = 0
end

function KnightFavoData:refreshData()
	for iter_3_0, iter_3_1 in pairs((g.core.model.User.knightsData:getOwnerList())) do
		self:addKnight(iter_3_1)
	end

	self:_sortKnight()

	self._isInit = true
end

function KnightFavoData:addKnight(arg_4_1)
	local var_4_0 = arg_4_1:getAdvanceId()

	if not self._knightByIdList[var_4_0] then
		local var_4_1 = KnightFavoStruct.new()

		var_4_1:initData(arg_4_1)
		table.insert(self._knightInfoList, var_4_1)

		self._knightByIdList[var_4_0] = var_4_1
	end
end

function KnightFavoData:getReqPlotStatus()
	return self._hasReqPlotData
end

function KnightFavoData:setReqPlotStatus(arg_6_1)
	self._hasReqPlotData = arg_6_1
end

function KnightFavoData:onFavoPlotInfo(arg_7_1)
	self:setReqPlotStatus(true)

	if arg_7_1.status then
		for iter_7_0 = 1, #arg_7_1.status do
			self:getKnightFavoById(arg_7_1.status[iter_7_0].id):setPlotAwardIndex(arg_7_1.status[iter_7_0].num)
		end
	end
end

function KnightFavoData:getKnightFavoById(arg_8_1)
	if not self._isInit then
		self:refreshData()
	end

	return self._knightByIdList[arg_8_1]
end

function KnightFavoData:onFavoAward(arg_9_1)
	if arg_9_1.advance_id and arg_9_1.num then
		self:getKnightFavoById(arg_9_1.advance_id):setPlotAwardIndex(arg_9_1.num)
	end
end

function KnightFavoData:getOwnKnightList(arg_10_1)
	local var_10_0 = g.core.model.User.knightsData:getOwnerList()

	if #self._knightInfoList ~= #var_10_0 then
		for iter_10_0, iter_10_1 in pairs(var_10_0) do
			self:addKnight(iter_10_1)
		end
	end

	self:_sortKnight()

	if not arg_10_1 or arg_10_1 == 0 then
		return self._knightInfoList
	else
		local var_10_1 = {}

		for iter_10_2, iter_10_3 in pairs(self._knightInfoList) do
			if iter_10_3:getGroup() == arg_10_1 then
				table.insert(var_10_1, iter_10_3)
			end
		end

		return var_10_1
	end
end

function KnightFavoData:getOwnDisplayedKnightArr(arg_11_1)
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in ipairs((self:getOwnKnightList(arg_11_1))) do
		if iter_11_1:isFavoEnable() then
			table.insert(var_11_0, iter_11_1)
		end
	end

	return var_11_0
end

function KnightFavoData:_sortKnight()
	local var_12_0 = var_0_0:get_index_data()

	table.sort(self._knightInfoList, function(arg_13_0, arg_13_1)
		local var_13_0 = arg_13_0:getBaseKnightInfo():getFormationPos()
		local var_13_1 = arg_13_1:getBaseKnightInfo():getFormationPos()

		if var_13_0 ~= var_13_1 then
			if var_13_0 == 0 then
				return false
			elseif var_13_1 == 0 then
				return true
			end
		end

		local var_13_2 = arg_13_0:getBaseKnightInfo():getFavoLevel()
		local var_13_3 = arg_13_1:getBaseKnightInfo():getFavoLevel()

		if var_13_2 ~= var_13_3 then
			return var_13_3 < var_13_2
		end

		local var_13_4 = arg_13_0:getBaseKnightInfo():getQuality()
		local var_13_5 = arg_13_1:getBaseKnightInfo():getQuality()

		if var_13_4 ~= var_13_5 then
			return var_13_5 < var_13_4
		end

		local var_13_6 = arg_13_0:getBaseKnightInfo():getStarLv()
		local var_13_7 = arg_13_1:getBaseKnightInfo():getStarLv()

		if var_13_6 ~= var_13_7 then
			return var_13_7 < var_13_6
		end

		local var_13_8 = arg_13_0:getBaseKnightInfo():getAdvanceId()
		local var_13_9 = arg_13_1:getBaseKnightInfo():getAdvanceId()

		if var_12_0[var_13_8] ~= var_12_0[var_13_9] then
			return var_12_0[var_13_9] < var_12_0[var_13_8]
		end
	end)
end

function KnightFavoData:getTotalAttrsList()
	local var_14_0 = self:getOwnKnightList()
	local var_14_1 = {}
	local var_14_2 = 0
	local var_14_3 = 0
	local var_14_4 = 0
	local var_14_5 = 0

	for iter_14_0 = 1, #var_14_0 do
		if var_14_0[iter_14_0]:isFavoEnable() then
			var_14_2 = var_14_2 + var_14_0[iter_14_0]:getHp()
			var_14_3 = var_14_3 + var_14_0[iter_14_0]:getAttack()
			var_14_4 = var_14_4 + var_14_0[iter_14_0]:getPhyDefence()
			var_14_5 = var_14_5 + var_14_0[iter_14_0]:getMagDefence()
		end
	end

	table.insert(var_14_1, {
		type = 2,
		value = var_14_3,
		name = g.core.lang:get(112203)
	})
	table.insert(var_14_1, {
		type = 1,
		value = var_14_2,
		name = g.core.lang:get(112204)
	})
	table.insert(var_14_1, {
		type = 3,
		value = var_14_4,
		name = g.core.lang:get(112205)
	})
	table.insert(var_14_1, {
		type = 4,
		value = var_14_5,
		name = g.core.lang:get(112206)
	})

	return var_14_1
end

function KnightFavoData:getTotalFavoLevel()
	local var_15_0 = self:getOwnKnightList()
	local var_15_1 = 0

	for iter_15_0 = 1, #var_15_0 do
		if var_15_0[iter_15_0]:isFavoEnable() then
			var_15_1 = var_15_1 + var_15_0[iter_15_0]:getBaseKnightInfo():getFavoLevel()
		end
	end

	return math.min(var_15_1, self:getMaxTotalFavoLevel())
end

function KnightFavoData:getTotalAttrIndexData()
	local var_16_0 = {}

	for iter_16_0, iter_16_1 in pairs((var_0_1.get_index_data())) do
		var_16_0[tonumber(iter_16_1)] = iter_16_0
	end

	return var_16_0
end

function KnightFavoData:getTotalLevelDataByLevel(arg_17_1)
	return (var_0_1.get(arg_17_1))
end

function KnightFavoData:getTotalLevelAttrs()
	local var_18_0 = {}
	local var_18_1 = {}
	local var_18_2 = self:getTotalFavoLevel()
	local var_18_3 = self:getTotalAttrIndexData()

	for iter_18_0 = 1, #var_18_3 do
		if var_18_2 < var_18_3[iter_18_0] then
			break
		else
			local var_18_6 = self:getTotalLevelDataByLevel(var_18_3[iter_18_0])

			if var_18_6.affect_type_1 > 0 then
				var_18_0[var_18_6.affect_type_1] = var_18_0[var_18_6.affect_type_1] and var_18_0[var_18_6.affect_type_1] + var_18_6.affect_value_1 or var_18_6.affect_value_1
			end

			if var_18_6.affect_type_2 > 0 then
				var_18_0[var_18_6.affect_type_2] = var_18_0[var_18_6.affect_type_2] and var_18_0[var_18_6.affect_type_2] + var_18_6.affect_value_2 or var_18_6.affect_value_2
			end
		end
	end

	for iter_18_1, iter_18_2 in pairs(var_18_0) do
		local var_18_7, var_18_8 = g.core.lang:getAttr(iter_18_1, iter_18_2)

		table.insert(var_18_1, {
			withoutPlus1 = false,
			type = iter_18_1,
			value = iter_18_2,
			name = g.core.lang:get(1010) .. var_18_7
		})
	end

	table.sort(var_18_1, function(arg_19_0, arg_19_1)
		if arg_19_0.type < arg_19_1.type then
			return true
		end
	end)

	return var_18_1, var_18_0
end

function KnightFavoData:getMaxTotalFavoLevel()
	if not self._maxLevel or self._maxLevel == 0 then
		self._maxLevel = var_0_1.indexOf((var_0_1.getLength())).favorability_level
	end

	return self._maxLevel
end

function KnightFavoData:getKnightFavoStruct(arg_21_1)
	local var_21_0 = self:getOwnKnightList()

	for iter_21_0 = 1, #var_21_0 do
		if var_21_0[iter_21_0]:getBaseId() == arg_21_1.baseId then
			return var_21_0[iter_21_0]
		end
	end
end

function KnightFavoData:isNewDossier(arg_22_1)
	return arg_22_1.isNew
end

function KnightFavoData:isNewSound(arg_23_1)
	return arg_23_1.isNew
end

function KnightFavoData:isNewStory(arg_24_1)
	return arg_24_1.isNew
end

function KnightFavoData:isCanLevelUp(arg_25_1)
	if not self._isInit then
		self:refreshData()
	end

	if not g.core.common.ModuleUnlock:isModuleUnlock(var_0_2.HOME_LAND_FAVO_MAIN) then
		return false
	end

	if arg_25_1.advId then
		return self:getKnightFavoById(arg_25_1.advId):isCanLevelUp()
	else
		for iter_25_0, iter_25_1 in pairs(self._knightByIdList) do
			if iter_25_1:isCanLevelUp() then
				return true
			end
		end
	end

	return false
end

function KnightFavoData:isFavoEnable(arg_26_1)
	arg_26_1 = arg_26_1 or 0

	if arg_26_1 > 0 then
		local var_26_0 = g.core.config.knight_favorability_info.fetch(arg_26_1)

		if var_26_0 then
			return var_26_0.put == 1
		end
	else
		return false
	end
end

function KnightFavoData:setSelectedLikeItem(arg_27_1)
	self._selectedLikeItemCache = {
		isSelected = arg_27_1
	}

	g.core.common.Storage:save("fave_auto_selected_like.json", self._selectedLikeItemCache, true)
end

function KnightFavoData:isSelectedLikeItem()
	self._selectedLikeItemCache = self._selectedLikeItemCache or g.core.common.Storage:load("fave_auto_selected_like.json", true) or {
		isSelected = true
	}

	return self._selectedLikeItemCache.isSelected
end

return KnightFavoData

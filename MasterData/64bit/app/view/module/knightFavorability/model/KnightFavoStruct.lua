local var_0_0 = g.core.config.knight_favorability_info
local var_0_1 = g.core.config.knight_favorability_level_info
local var_0_2 = g.core.config.knight_base_info
local var_0_3 = g.core.config.knight_show_info
local var_0_4 = g.core.config.knight_favorability_story_info
local var_0_5 = g.core.config.knight_favorability_item_info
local var_0_6 = g.core.config.sound_title_info
local var_0_7 = g.core.config.parameter_info
local var_0_8 = g.core.const.ConstMgr.KnightFavoConst
local var_0_9 = 3
local var_0_10 = g.core.model.User
local var_0_11 = g.core.model.User.itemsData
local var_0_12 = g.core.common.Goods
local KnightFavoStruct = class("KnightFavoStruct")

function KnightFavoStruct:ctor()
	self._knight = nil
	self._favoId = 1
	self._likeItems = {}
	self._name = ""
	self._sex = nil
	self._age = ""
	self._groupName = ""
	self._birthday = ""
	self._height = ""
	self._weight = ""
	self._storyInfoList = {}
	self._plotList = {}
	self._allFavoItems = {}
	self._baseInfo = {}
	self._plotAwardIndex = nil
	self._cv = nil
	self._favoItemList = nil
	self._maxFavoLevel = 0
end

function KnightFavoStruct:initData(arg_2_1)
	if not arg_2_1 then
		return
	end

	self._knight = arg_2_1

	local var_2_0 = arg_2_1:getAdvanceId()
	local var_2_1 = var_0_0.get(var_2_0)

	self._favoId = var_2_1.favorability_id or 1
	self._name = var_2_1.name

	if var_2_1.sex == 1 then
		self._sex = g.core.lang:get(112002) or g.core.lang:get(112003)
	end

	self._age = var_2_1.age
	self._groupName = var_2_1.group > 0 and g.core.lang:get(var_2_1.group) or ""
	self._birthday = var_2_1.brithday_month > 0 and var_2_1.brithday_day > 0 and g.core.lang:get(112004, {
		month = var_2_1.brithday_month,
		day = var_2_1.brithday_day
	}) or ""
	self._height = var_2_1.height > 0 and var_2_1.height .. g.core.lang:get(112005) or ""
	self._weight = var_2_1.weight
	self._cv = var_0_2.get(var_2_0).cv

	local var_2_2 = (g.core.common.Storage:load("favo_story.json", false) or {})[tostring(var_2_0)] or {}

	for iter_2_0 = 1, var_0_9 do
		if var_2_1["story_" .. iter_2_0] and var_2_1["story_unlock_" .. iter_2_0] then
			table.insert(self._storyInfoList, {
				story = var_2_1["story_" .. iter_2_0],
				story_unlock = var_2_1["story_unlock_" .. iter_2_0],
				index = iter_2_0,
				isPlayed = var_2_2[tostring(iter_2_0)]
			})
		end
	end

	if var_2_1 then
		self._likeItems = {
			var_2_1.item_1,
			var_2_1.item_2
		}
	end

	self._plotList = self:_initPlotList()
	self._maxFavoLevel = 0

	for iter_2_1, iter_2_2 in var_0_1.ipairs() do
		if iter_2_2.id == self._favoId then
			self._maxFavoLevel = self._maxFavoLevel + 1
		end
	end
end

function KnightFavoStruct:getKnightLikeItems()
	return self._likeItems
end

function KnightFavoStruct:isLikeItem(arg_4_1)
	if not arg_4_1 then
		return false
	end

	local var_4_0 = self:getKnightLikeItems()

	for iter_4_0 = 1, #var_4_0 do
		if arg_4_1 == var_4_0[iter_4_0] then
			return true
		end
	end

	return false
end

function KnightFavoStruct:getBaseKnightInfo()
	return self._knight
end

function KnightFavoStruct:getFavoSortAttrs()
	local var_6_0 = {}
	local var_6_1 = self:getBaseKnightInfo():getFavoLevel()
	local var_6_2

	if var_6_1 < self._maxFavoLevel then
		var_6_2 = var_6_1 + 1 or self._maxFavoLevel
	end

	table.insert(var_6_0, {
		type = 1,
		isAll = true,
		value = self:getHp(),
		value2 = self:getHp(var_6_2)
	})
	table.insert(var_6_0, {
		type = 2,
		isAll = true,
		value = self:getAttack(),
		value2 = self:getAttack(var_6_2)
	})
	table.insert(var_6_0, {
		type = 3,
		isAll = true,
		value = self:getPhyDefence(),
		value2 = self:getPhyDefence(var_6_2)
	})
	table.insert(var_6_0, {
		type = 4,
		isAll = true,
		value = self:getMagDefence(),
		value2 = self:getMagDefence(var_6_2)
	})

	return var_6_0
end

function KnightFavoStruct:getFavoSortAttrsBuyLevel(arg_7_1)
	local var_7_0 = {}
	local var_7_1

	if arg_7_1 < self._maxFavoLevel then
		var_7_1 = arg_7_1 + 1 or self._maxFavoLevel
	end

	table.insert(var_7_0, {
		type = 1,
		isAll = true,
		value = self:getHp(arg_7_1),
		value2 = self:getHp(var_7_1)
	})
	table.insert(var_7_0, {
		type = 2,
		isAll = true,
		value = self:getAttack(arg_7_1),
		value2 = self:getAttack(var_7_1)
	})
	table.insert(var_7_0, {
		type = 3,
		isAll = true,
		value = self:getPhyDefence(arg_7_1),
		value2 = self:getPhyDefence(var_7_1)
	})
	table.insert(var_7_0, {
		type = 4,
		isAll = true,
		value = self:getMagDefence(arg_7_1),
		value2 = self:getMagDefence(var_7_1)
	})

	return var_7_0
end

function KnightFavoStruct:getLevelInfo(arg_8_1)
	if arg_8_1 == nil then
		arg_8_1 = self:getBaseKnightInfo():getFavoLevel()
	end

	return var_0_1.get(self._favoId, arg_8_1)
end

function KnightFavoStruct:getHp(arg_9_1)
	if arg_9_1 == nil then
		arg_9_1 = self:getBaseKnightInfo():getFavoLevel()
	end

	return var_0_1.get(self._favoId, arg_9_1).initial_hp
end

function KnightFavoStruct:getAttack(arg_10_1)
	if arg_10_1 == nil then
		arg_10_1 = self:getBaseKnightInfo():getFavoLevel()
	end

	return var_0_1.get(self._favoId, arg_10_1).attack
end

function KnightFavoStruct:getPhyDefence(arg_11_1)
	if arg_11_1 == nil then
		arg_11_1 = self:getBaseKnightInfo():getFavoLevel()
	end

	return var_0_1.get(self._favoId, arg_11_1).phy_defence
end

function KnightFavoStruct:getMagDefence(arg_12_1)
	if arg_12_1 == nil then
		arg_12_1 = self:getBaseKnightInfo():getFavoLevel()
	end

	return var_0_1.get(self._favoId, arg_12_1).mag_defence
end

function KnightFavoStruct:getUnlockStoryFlag()
	local var_13_0 = self:getPlotAwardIndex() or 0
	local var_13_1 = self:getPlotList()
	local var_13_2 = self:getBaseKnightInfo():getFavoLevel()

	for iter_13_0 = 1, #var_13_1 do
		if var_13_2 >= var_13_1[iter_13_0].avgUnlockLevel and var_13_0 < iter_13_0 then
			return true
		end
	end

	return false
end

function KnightFavoStruct:getProgressData()
	local var_14_0 = self._knight:getFavoLevel()
	local var_14_1 = self._knight:getFavoExp()
	local var_14_2 = {}
	local var_14_3 = var_0_1.get(self._favoId, var_14_0)

	var_14_2.curLevelExp = var_14_1

	if var_14_3 then
		var_14_2.toLevelExp = var_14_3.exp
	end

	if var_14_0 >= self._maxFavoLevel then
		var_14_2.knightLevelLimit = var_14_3.open_level
		var_14_2.maxFavoLevel = true
	else
		var_14_2.knightLevelLimit = var_14_1 >= var_14_3.exp and var_0_1.get(self._favoId, var_14_0 + 1).open_level or var_14_3.open_level
	end

	return var_14_2
end

function KnightFavoStruct:getFavoItemList()
	local var_15_0 = var_0_11:getFavoData()
	local var_15_1 = {}

	for iter_15_0, iter_15_1 in ipairs((var_0_5.get_index_data())) do
		local var_15_2 = self:getKnightLikeItems()
		local var_15_3 = false
		local var_15_4 = 0
		local var_15_5 = 0

		for iter_15_2 = 1, #var_15_2 do
			if var_15_2[iter_15_2] == iter_15_0 then
				var_15_3 = true
			end
		end

		for iter_15_3 = 1, #var_15_0 do
			if var_15_0[iter_15_3].id == iter_15_0 then
				var_15_4 = var_15_4 + 1
				var_15_5 = var_15_0[iter_15_3].num
			end
		end

		if var_15_3 then
			var_15_4 = var_15_4 + 2
		end

		local var_15_6 = var_0_12:convert({
			type = var_0_12.TYPE_KNIGHT_FAVORABILITY_ITEM,
			value = iter_15_0,
			size = var_15_5
		})
		local var_15_7 = var_0_5.get(iter_15_0)

		var_15_6.exp = var_15_7.exp
		var_15_6.expAdd = var_15_7.exp_add
		var_15_6.weight = var_15_4

		if var_15_4 == 1 or var_15_4 == 3 then
			var_15_6.hideNum = false
		end

		if var_15_5 <= 0 then
			var_15_6.isMask = true
		end

		table.insert(var_15_1, var_15_6)
	end

	table.sort(var_15_1, function(arg_16_0, arg_16_1)
		if arg_16_0.weight ~= arg_16_1.weight then
			return arg_16_0.weight > arg_16_1.weight
		end

		if arg_16_0.quality ~= arg_16_1.quality then
			return arg_16_0.quality > arg_16_1.quality
		end

		if arg_16_0.value ~= arg_16_1.value then
			return arg_16_0.value > arg_16_1.value
		end

		return false
	end)

	self._favoItemList = var_15_1

	return var_15_1
end

function KnightFavoStruct:getPreFavoItemList()
	if not self._favoItemList then
		return self:getFavoItemList()
	else
		local var_17_0 = var_0_11:getFavoData()
		local var_17_1 = false

		for iter_17_0 = 1, #self._favoItemList do
			if self._favoItemList[iter_17_0].weight == 1 or self._favoItemList[iter_17_0].weight == 3 then
				self._favoItemList[iter_17_0].size = 0

				for iter_17_1 = 1, #var_17_0 do
					if var_17_0[iter_17_1].id == self._favoItemList[iter_17_0].value then
						self._favoItemList[iter_17_0].size = var_17_0[iter_17_1].num
					end
				end

				if self._favoItemList[iter_17_0].size <= 0 then
					self._favoItemList[iter_17_0].weight = self._favoItemList[iter_17_0].weight - 1
					var_17_1 = true
				end
			end
		end

		if var_17_1 then
			table.sort(self._favoItemList, function(arg_18_0, arg_18_1)
				if arg_18_0.weight ~= arg_18_1.weight then
					return arg_18_0.weight > arg_18_1.weight
				end

				if arg_18_0.quality ~= arg_18_1.quality then
					return arg_18_0.quality > arg_18_1.quality
				end

				if arg_18_0.value ~= arg_18_1.value then
					return arg_18_0.value > arg_18_1.value
				end

				return false
			end)
		end

		return self._favoItemList
	end
end

function KnightFavoStruct:getName()
	return self._name
end

function KnightFavoStruct:getSex()
	return self._sex
end

function KnightFavoStruct:getAge()
	return self._age
end

function KnightFavoStruct:getBirthday()
	return self._birthday
end

function KnightFavoStruct:getHeight()
	return self._height
end

function KnightFavoStruct:getWeight()
	return self._weight
end

function KnightFavoStruct:getGroupName()
	return self._groupName
end

function KnightFavoStruct:getBaseInfoList()
	return {
		self._name,
		self._groupName,
		self._age,
		self._birthday,
		self._height,
		self._weight
	}
end

function KnightFavoStruct:getStoryList()
	return self._storyInfoList
end

function KnightFavoStruct:setStoryPlayedByIndex(arg_28_1)
	if not arg_28_1 then
		return
	end

	local var_28_0 = arg_28_1.index

	arg_28_1.isPlayed = true

	local var_28_1 = self._knight:getAdvanceId()
	local var_28_2 = g.core.common.Storage:load("favo_story.json", false) or {}

	var_28_2[tostring(var_28_1)] = var_28_2[tostring(var_28_1)] or {}

	local var_28_3 = var_28_2[tostring(var_28_1)]

	if var_28_3[tostring(var_28_0)] then
		return
	end

	var_28_3[tostring(var_28_0)] = true

	g.core.common.Storage:save("favo_story.json", var_28_2, false)
end

function KnightFavoStruct:setPlotPlayedByIndex(arg_29_1)
	if not arg_29_1 then
		return
	end

	local var_29_0 = arg_29_1.index

	arg_29_1.isPlayed = true

	local var_29_1 = self._knight:getAdvanceId()
	local var_29_2 = g.core.common.Storage:load("favo_plot.json", false) or {}

	var_29_2[tostring(var_29_1)] = var_29_2[tostring(var_29_1)] or {}

	local var_29_3 = var_29_2[tostring(var_29_1)]

	if var_29_3[tostring(var_29_0)] then
		return
	end

	var_29_3[tostring(var_29_0)] = true

	g.core.common.Storage:save("favo_plot.json", var_29_2, false)
end

function KnightFavoStruct:_initPlotList()
	local var_30_0 = self._knight:getAdvanceId()
	local var_30_1 = (g.core.common.Storage:load("favo_plot.json", false) or {})[tostring(var_30_0)] or {}
	local var_30_2 = var_0_0.get(var_30_0)
	local var_30_3 = {}

	for iter_30_0 = 1, g.core.const.ConstMgr.KnightFavoConst.cfg.FAVO_AVG_LENTH do
		local var_30_4 = {
			avg = var_30_2["avg_" .. iter_30_0]
		}

		if var_30_4.avg and var_30_4.avg > 0 then
			local var_30_5 = var_0_4.get(var_30_4.avg)

			var_30_4.avgUnlockLevel = var_30_5.avg_unlock
			var_30_4.avgAwardType = var_30_5.avg_award_type
			var_30_4.avgAwardValue = var_30_5.avg_award_value
			var_30_4.avgAwardSize = var_30_5.avg_award_size
			var_30_4.name = var_30_5.name
			var_30_4.res = var_30_5.res
			var_30_4.index = iter_30_0
			var_30_4.isPlayed = not not var_30_1[tostring(var_30_4.index)]

			table.insert(var_30_3, var_30_4)
		end
	end

	return var_30_3
end

function KnightFavoStruct:getPlotList()
	return self._plotList
end

function KnightFavoStruct:getPlotAwardIndex()
	return self._plotAwardIndex
end

function KnightFavoStruct:setPlotAwardIndex(arg_33_1)
	self._plotAwardIndex = arg_33_1
end

function KnightFavoStruct:getCV()
	return self._cv
end

function KnightFavoStruct:getMaxFavoLevel()
	return self._maxFavoLevel
end

function KnightFavoStruct:getUpLevelDataByExp(arg_36_1)
	local var_36_0 = self._knight:getLevel()
	local var_36_1 = self._knight:getFavoStage()
	local var_36_2 = {}

	var_36_2.level = self:getBaseKnightInfo():getFavoLevel()
	var_36_2.curExp = self:getBaseKnightInfo():getFavoExp()

	local var_36_3 = var_0_1.get(self._favoId, var_36_2.level)

	var_36_2.maxExp = var_36_3.exp
	var_36_2.limitLevel = var_36_3.open_level
	var_36_2.canLevelUp = var_36_2.level < self._maxFavoLevel
	var_36_2.curExp = var_36_2.curExp + arg_36_1
	var_36_2.isMaxLevel = false

	if var_36_2.level >= self._maxFavoLevel then
		var_36_2.isMaxLevel = true
		var_36_2.canLevelUp = false
		var_36_2.level = self._maxFavoLevel
		var_36_2.curExp = 0
	else
		for iter_36_0 = var_36_2.level, self._maxFavoLevel do
			if var_36_2.curExp >= var_36_2.maxExp then
				local var_36_4 = math.min(iter_36_0 + 1, self._maxFavoLevel)
				local var_36_5 = var_0_1.get(self._favoId, var_36_4)

				var_36_2.limitLevel = var_36_5.open_level

				if var_36_1 < var_36_5.stage and var_36_3.cost_type ~= 0 then
					var_36_2.isInAdvance = true
					var_36_2.canLevelUp = false

					break
				elseif var_36_0 < var_36_5.open_level then
					var_36_2.canLevelUp = false

					break
				elseif var_36_4 >= self._maxFavoLevel then
					var_36_2.isMaxLevel = true
					var_36_2.level = var_36_4
					var_36_2.canLevelUp = false
					var_36_2.curExp = 0

					break
				end

				var_36_2.level = var_36_4
				var_36_2.curExp = var_36_2.curExp - var_36_2.maxExp
				var_36_2.maxExp = var_36_5.exp
				var_36_3 = var_36_5
			else
				break
			end
		end
	end

	return var_36_2
end

function KnightFavoStruct:getUpgradeTargetLvNeedItem(arg_37_1, arg_37_2)
	local var_37_0 = self:getBaseKnightInfo():getFavoLevel()
	local var_37_1 = math.max(self:getTargetLevelExpValue(arg_37_1) - (self._knight:getFavoExp() + self:getTargetLevelExpValue(var_37_0)), 0)
	local var_37_2 = {}

	for iter_37_0 = 1, #self._likeItems do
		if var_37_1 > 0 then
			local var_37_3 = g.core.model.User.bagData:getOwnNum(var_0_12.TYPE_KNIGHT_FAVORABILITY_ITEM, self._likeItems[iter_37_0])

			if self._likeItems[iter_37_0] > 0 and var_37_3 > 0 then
				local var_37_4 = var_0_5.get(self._likeItems[iter_37_0]).exp_add
				local var_37_5 = math.ceil(var_37_1 / var_37_4)

				if var_37_3 < var_37_5 then
					table.insert(var_37_2, {
						isAdvance = 0,
						isLike = 1,
						type = var_0_12.TYPE_KNIGHT_FAVORABILITY_ITEM,
						value = self._likeItems[iter_37_0],
						size = var_37_3,
						addExp = var_37_4
					})

					var_37_1 = var_37_1 - var_37_3 * var_37_4
				else
					table.insert(var_37_2, {
						isAdvance = 0,
						isLike = 1,
						type = var_0_12.TYPE_KNIGHT_FAVORABILITY_ITEM,
						value = self._likeItems[iter_37_0],
						size = var_37_5,
						addExp = var_37_4
					})

					var_37_1 = 0
				end
			end
		end
	end

	for iter_37_1 = 1, #var_0_8.OPTIONAL_BOX do
		if var_37_1 > 0 then
			local var_37_6 = var_0_7.get(var_0_8.OPTIONAL_BOX[iter_37_1].id).parameter
			local var_37_7 = var_0_7.get(var_0_8.OPTIONAL_BOX[iter_37_1].addExp).parameter
			local var_37_8 = g.core.model.User.bagData:getOwnNum(var_0_12.TYPE_ITEM, var_37_6)

			if var_37_6 > 0 and var_37_8 > 0 then
				local var_37_9 = math.ceil(var_37_1 / var_37_7)

				if var_37_8 < var_37_9 then
					table.insert(var_37_2, {
						isAdvance = 0,
						type = var_0_12.TYPE_ITEM,
						value = var_37_6,
						size = var_37_8,
						addExp = var_37_7,
						isLike = var_0_8.OPTIONAL_BOX[iter_37_1].isLike and 1 or 0
					})

					var_37_1 = var_37_1 - var_37_8 * var_37_7
				else
					table.insert(var_37_2, {
						isAdvance = 0,
						type = var_0_12.TYPE_ITEM,
						value = var_37_6,
						size = var_37_9,
						addExp = var_37_7,
						isLike = var_0_8.OPTIONAL_BOX[iter_37_1].isLike and 1 or 0
					})

					var_37_1 = 0
				end
			end
		end
	end

	local var_37_10 = var_0_11:getFavoData()

	for iter_37_2 = 1, #var_37_10 do
		if var_37_1 > 0 then
			local var_37_11 = var_0_5.get(var_37_10[iter_37_2].id)
			local var_37_12 = not self:isLikeItem(var_37_10[iter_37_2].id)

			if var_37_10[iter_37_2].id ~= 100 and (arg_37_2 or nil) and var_37_11.quality < g.core.const.ConstMgr.QUALITY_TYPE.SSR then
				local var_37_13 = math.ceil(var_37_1 / var_37_11.exp)

				if var_37_10[iter_37_2].num < var_37_13 then
					table.insert(var_37_2, {
						isAdvance = 0,
						isLike = 0,
						type = var_0_12.TYPE_KNIGHT_FAVORABILITY_ITEM,
						value = var_37_10[iter_37_2].id,
						size = var_37_10[iter_37_2].num,
						addExp = var_37_11.exp
					})

					var_37_1 = var_37_1 - var_37_10[iter_37_2].num * var_37_11.exp
				else
					table.insert(var_37_2, {
						isAdvance = 0,
						isLike = 0,
						type = var_0_12.TYPE_KNIGHT_FAVORABILITY_ITEM,
						value = var_37_10[iter_37_2].id,
						size = var_37_13,
						addExp = var_37_11.exp
					})

					var_37_1 = 0
				end
			end
		end
	end

	if var_37_1 == 0 then
		local var_37_14 = g.core.model.User.bagData:getOwnNum(var_0_12.TYPE_KNIGHT_FAVORABILITY_ITEM, 100)
		local var_37_15 = 0

		for iter_37_3 = var_37_0, arg_37_1 - 1 do
			var_37_15 = var_37_15 + self:getLevelInfo(iter_37_3).cost_num
		end

		if var_37_14 > 0 and var_37_15 > 0 then
			table.insert(var_37_2, {
				isAdvance = 1,
				value = 100,
				isLike = 0,
				addExp = 0,
				type = var_0_12.TYPE_KNIGHT_FAVORABILITY_ITEM,
				size = var_37_15 <= var_37_14 and var_37_15 or var_37_14
			})
		end
	end

	table.sort(var_37_2, function(arg_38_0, arg_38_1)
		if arg_38_0.isAdvance ~= arg_38_1.isAdvance then
			return arg_38_0.isAdvance > arg_38_1.isAdvance
		end

		if arg_38_0.isLike ~= arg_38_1.isLike then
			return arg_38_0.isLike > arg_38_1.isLike
		end

		if arg_38_0.addExp ~= arg_38_1.addExp then
			return arg_38_0.addExp > arg_38_1.addExp
		end

		return false
	end)

	return var_37_2
end

function KnightFavoStruct:getCanUpTargetLvByUpgradeItem(arg_39_1, arg_39_2)
	local var_39_0 = self:getBaseKnightInfo():getFavoLevel()
	local var_39_1 = self:getTargetLevelExpValue(arg_39_1) - (self:getTargetLevelExpValue(var_39_0) + self._knight:getFavoExp())
	local var_39_2 = 0

	if arg_39_2 then
		for iter_39_0 = 1, #self._likeItems do
			if var_39_1 > 0 then
				local var_39_4 = g.core.model.User.bagData:getOwnNum(var_0_12.TYPE_KNIGHT_FAVORABILITY_ITEM, self._likeItems[iter_39_0])

				if self._likeItems[iter_39_0] > 0 and var_39_4 > 0 then
					var_39_2 = var_39_2 + var_0_5.get(self._likeItems[iter_39_0]).exp_add * var_39_4
				end
			end
		end

		for iter_39_1 = 1, #var_0_8.OPTIONAL_BOX do
			if var_39_1 > 0 then
				local var_39_5 = var_0_7.get(var_0_8.OPTIONAL_BOX[iter_39_1].id).parameter
				local var_39_6 = var_0_7.get(var_0_8.OPTIONAL_BOX[iter_39_1].addExp).parameter
				local var_39_7 = g.core.model.User.bagData:getOwnNum(var_0_12.TYPE_ITEM, var_39_5)

				if var_39_5 > 0 and var_39_7 > 0 then
					var_39_2 = var_39_2 + var_39_6 * var_39_7
				end
			end
		end

		local var_39_8 = var_0_11:getFavoData()

		for iter_39_2 = 1, #var_39_8 do
			if var_39_2 < var_39_1 then
				local var_39_9 = var_0_5.get(var_39_8[iter_39_2].id)
				local var_39_10 = g.core.model.User.bagData:getOwnNum(var_0_12.TYPE_KNIGHT_FAVORABILITY_ITEM, var_39_8[iter_39_2].id)

				if var_39_9.quality < g.core.const.ConstMgr.QUALITY_TYPE.SSR and var_39_10 > 0 then
					var_39_2 = var_39_2 + var_39_9.exp * var_39_10
				end
			else
				break
			end
		end
	else
		local var_39_11 = var_0_11:getFavoData()

		for iter_39_3 = 1, #var_39_11 do
			if var_39_2 < var_39_1 then
				local var_39_12 = var_39_11[iter_39_3].id
				local var_39_13 = var_0_5.get(var_39_11[iter_39_3].id)
				local var_39_14

				if self:isLikeItem(var_39_11[iter_39_3].id) then
					var_39_14 = var_39_13.exp_add or var_39_13.exp
				end

				local var_39_15 = g.core.model.User.bagData:getOwnNum(var_0_12.TYPE_KNIGHT_FAVORABILITY_ITEM, var_39_12)

				if var_39_15 > 0 then
					var_39_2 = var_39_2 + var_39_14 * var_39_15
				end
			else
				break
			end
		end

		if var_39_1 > var_39_2 then
			for iter_39_4 = 1, #var_0_8.OPTIONAL_BOX do
				if var_39_1 > 0 then
					local var_39_16 = var_0_7.get(var_0_8.OPTIONAL_BOX[iter_39_4].id).parameter
					local var_39_17 = var_0_7.get(var_0_8.OPTIONAL_BOX[iter_39_4].addExp).parameter
					local var_39_18 = g.core.model.User.bagData:getOwnNum(var_0_12.TYPE_ITEM, var_39_16)

					if var_39_16 > 0 and var_39_18 > 0 then
						var_39_2 = var_39_2 + var_39_17 * var_39_18
					end
				end
			end
		end
	end

	local var_39_19 = 0
	local var_39_20 = 0
	local var_39_21 = g.core.model.User.bagData:getOwnNum(var_0_12.TYPE_KNIGHT_FAVORABILITY_ITEM, 100)
	local var_39_22 = self._knight:getFavoExp() + self:getTargetLevelExpValue(var_39_0)

	for iter_39_5 = var_39_0, arg_39_1 do
		var_39_20 = var_39_20 + self:getLevelInfo(iter_39_5).cost_num

		if self:getTargetLevelExpValue(iter_39_5) - var_39_22 <= var_39_2 then
			var_39_19 = iter_39_5

			if var_39_21 < var_39_20 then
				break
			end
		end
	end

	return var_39_1 <= var_39_2, var_39_19
end

function KnightFavoStruct:getTargetLevelExpValue(arg_40_1)
	local var_40_0 = 0

	if arg_40_1 > 0 then
		for iter_40_0 = 1, arg_40_1 - 1 do
			var_40_0 = var_40_0 + self:getLevelInfo(iter_40_0).exp
		end
	end

	return var_40_0
end

function KnightFavoStruct:getGroup()
	if self._knight then
		return self._knight:getGroup()
	else
		return 0
	end
end

function KnightFavoStruct:isInAdvance()
	local var_42_0 = self:getLevelInfo()
	local var_42_1 = self:getBaseKnightInfo():getFavoStage()

	return var_42_1 == var_42_0.stage and var_42_0.cost_type ~= 0 and self:getBaseKnightInfo():getFavoExp() >= var_42_0.exp or var_42_1 < var_42_0.stage
end

function KnightFavoStruct:isCanLevelUp()
	if not self._knight:isLineup() then
		return false
	end

	local var_43_0 = self._knight:getLevel()
	local var_43_1 = self:getBaseKnightInfo():getFavoLevel()

	if var_43_1 >= self._maxFavoLevel then
		return false
	end

	if self:isInAdvance() then
		return false
	end

	if var_43_1 > self._maxFavoLevel or var_43_0 < var_0_1.get(self._favoId, math.min(var_43_1 + 1, self._maxFavoLevel)).open_level then
		return false
	end

	local var_43_2 = var_0_1.get(self._favoId, var_43_1)
	local var_43_3 = self:getFavoItemList()

	if var_43_3[1] == nil or var_43_3[1].weight ~= 3 then
		return false
	end

	local var_43_4 = var_43_2.exp
	local var_43_5 = self:getBaseKnightInfo():getFavoExp()

	for iter_43_0, iter_43_1 in pairs(var_43_3) do
		if iter_43_1.weight ~= 3 then
			return false
		end

		var_43_5 = var_43_5 + iter_43_1.expAdd * iter_43_1.size

		if var_43_4 <= var_43_5 then
			return true
		end
	end

	return false
end

function KnightFavoStruct:getSoundDataArr(arg_44_1)
	local var_44_0 = {}

	if not arg_44_1 or arg_44_1 < 1 then
		return var_44_0
	end

	local var_44_1 = (g.core.common.Storage:load("favo_sound.json", var_0_10:getId()) or {})[tostring(arg_44_1)] or {}
	local var_44_2 = var_0_0.get((self._knight:getAdvanceId()))
	local var_44_4 = var_0_3.get(arg_44_1)
	local var_44_5 = not var_0_10:isBoy()

	local function var_44_6(arg_46_0)
		local var_46_0 = string.match(arg_46_0, "^(.+)_sound$") .. "_lines"

		if var_44_5 then
			if var_0_3.hasKey(var_46_0 .. "_woman") then
				if string.len(var_44_4[var_46_0 .. "_woman"]) > 0 then
					return var_44_4[var_46_0 .. "_woman"]
				end
			end
		end

		if var_0_3.hasKey(var_46_0) then
			return var_44_4[var_46_0]
		end

		return ""
	end

	local var_44_7 = 1

	for iter_44_0, iter_44_1 in var_0_6.ipairs() do
		local var_44_8 = iter_44_1.lines

		if var_44_4[iter_44_1.lines] and var_44_4[iter_44_1.lines] ~= "" then
			if string.sub(iter_44_1.lines, 1, 3) ~= "day" then
				var_44_0[var_44_7] = {
					unlockLevel = 0,
					id = iter_44_0,
					title = iter_44_1.name,
					soundKey = var_44_8,
					soundName = var_44_4[var_44_8],
					tip = var_44_6(var_44_8),
					isPlayed = checkbool(var_44_1[var_44_8])
				}
			else
				local var_44_9 = g.core.model.User.userFestivalData
				local var_44_10 = tonumber((string.sub(string.split(var_44_8, "_")[1], 4)))
				local var_44_11 = false

				if var_44_10 ~= 11 and var_44_10 ~= 10 then
					var_44_11 = var_44_9:isIdUnlock(tonumber(var_44_10))
				elseif var_44_10 == 11 then
					var_44_11 = var_44_9:isIdUnlock(arg_44_1)
				elseif var_44_10 == 10 then
					var_44_11 = true
				end

				var_44_0[var_44_7] = {
					id = iter_44_0,
					title = iter_44_1.name,
					soundKey = var_44_8,
					soundName = var_44_4[var_44_8],
					unlockLevel = var_44_11 and 0 or 9999,
					tip = var_44_6(var_44_8),
					isPlayed = checkbool(var_44_1[var_44_8])
				}
			end

			var_44_7 = var_44_7 + 1
		end
	end

	local var_44_12 = g.core.model.User:getLevel()

	table.sort(var_44_0, function(arg_47_0, arg_47_1)
		if arg_47_0.unlockLevel <= var_44_12 ~= (arg_47_1.unlockLevel <= var_44_12) then
			return arg_47_0.unlockLevel <= var_44_12
		end

		return arg_47_0.id < arg_47_1.id
	end)

	return var_44_0
end

function KnightFavoStruct:setSoundsPlayed(arg_48_1, arg_48_2)
	if not arg_48_2 or #arg_48_2 == 0 then
		return
	elseif not arg_48_1 or arg_48_1 < 1 then
		return
	end

	local var_48_0 = tostring(arg_48_1)
	local var_48_1 = g.core.common.Storage:load("favo_sound.json", var_0_10:getId()) or {}
	local var_48_2 = var_48_1[var_48_0]

	if not var_48_1[var_48_0] then
		var_48_2 = {}
		var_48_1[var_48_0] = var_48_2
	end

	local var_48_3 = false

	for iter_48_0, iter_48_1 in ipairs(arg_48_2) do
		iter_48_1.isPlayed = true

		if not var_48_2[iter_48_1.soundKey] then
			var_48_3 = true
			var_48_2[iter_48_1.soundKey] = 1
		end
	end

	if var_48_3 then
		g.core.common.Storage:save("favo_sound.json", var_48_1, var_0_10:getId())
	end
end

function KnightFavoStruct:isFavoEnable()
	if not self._knight then
		return false
	end

	return g.core.model.User.knightFavoData:isFavoEnable((self._knight:getAdvanceId()))
end

return KnightFavoStruct

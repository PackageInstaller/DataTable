local HandBookData = class("HandBookData")
local var_0_1 = g.core.const.ConstMgr.CensorConst
local var_0_2 = g.core.config.knight_book_info
local var_0_3 = g.core.config.knight_book_award_info

function HandBookData:ctor()
	self:initData()
end

function HandBookData:initData()
	self._allActiveKnightData = {}
	self._activateScoreId = 0
	self._allKingBookInfo = {}

	for iter_2_0 = 1, var_0_2.getLength() do
		local var_2_0 = var_0_2.indexOf(iter_2_0)

		self._allKingBookInfo[var_2_0.advance_id] = self._allKingBookInfo[var_2_0.advance_id] or {}

		table.insert(self._allKingBookInfo[var_2_0.advance_id], var_2_0)
	end
end

function HandBookData:setAllActiveKnightData(arg_3_1)
	local var_3_1 = arg_3_1.level or {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.id or {}) do
		local var_3_2 = {
			id = iter_3_1
		}

		var_3_2.level = var_3_1[iter_3_0] and var_3_1[iter_3_0] or 1
		self._allActiveKnightData[iter_3_1] = var_3_2
	end

	self._activateScoreId = arg_3_1.award_id
end

function HandBookData:setKnightBookActivate(arg_4_1)
	self._activateScoreId = arg_4_1.target_id
end

function HandBookData:getAllActiveKnightData()
	return self._allActiveKnightData
end

function HandBookData:getActivateScoreId()
	return self._activateScoreId
end

function HandBookData:getUpNeedStar(arg_7_1)
	if self._allActiveKnightData[arg_7_1] then
		if self._allKingBookInfo[arg_7_1] then
			for iter_7_0, iter_7_1 in pairs(self._allKingBookInfo[arg_7_1]) do
				if iter_7_1.level == self._allActiveKnightData[arg_7_1].level + 1 then
					return iter_7_1.knight_star
				end
			end
		end
	end

	return 0
end

function HandBookData:isMaxLevel(arg_8_1)
	if self._allActiveKnightData[arg_8_1] then
		if self._allKingBookInfo[arg_8_1] then
			for iter_8_0, iter_8_1 in pairs(self._allKingBookInfo[arg_8_1]) do
				if iter_8_1.level == self._allActiveKnightData[arg_8_1].level + 1 then
					return false
				end
			end
		end
	end

	return true
end

function HandBookData:getKnightBookLevel(arg_9_1)
	return (self._allActiveKnightData[arg_9_1] or nil) and self._allActiveKnightData[arg_9_1].level
end

function HandBookData:setKnightBookLevel(arg_10_1)
	if arg_10_1 then
		if self._allActiveKnightData[arg_10_1.id] then
			self._allActiveKnightData[arg_10_1.id].level = self:getKnightBookLevel(arg_10_1.id) + 1
		else
			self._allActiveKnightData[arg_10_1.id] = {}
			self._allActiveKnightData[arg_10_1.id].id = arg_10_1.id
			self._allActiveKnightData[arg_10_1.id].level = 0
		end
	end
end

function HandBookData:onS2CKnightHandBookOneKeyUpgrade(arg_11_1)
	for iter_11_0, iter_11_1 in ipairs(arg_11_1.hb or {}) do
		if not self._allActiveKnightData[iter_11_1.id] then
			self._allActiveKnightData[iter_11_1.id] = {}
			self._allActiveKnightData[iter_11_1.id].id = iter_11_1.id
		end

		self._allActiveKnightData[iter_11_1.id].level = iter_11_1.level
	end
end

function HandBookData:getKnightBookAttr(arg_12_1, arg_12_2)
	local var_12_0 = {}

	if self._allKingBookInfo[arg_12_1] then
		for iter_12_0, iter_12_1 in pairs(self._allKingBookInfo[arg_12_1]) do
			if iter_12_1.level == arg_12_2 then
				var_12_0[1] = {
					isAll = true,
					attr = {
						g.core.lang:getAttr(iter_12_1.affect_type_1, iter_12_1.affect_value_1, true)
					},
					res = g.core.common.Path:getAttrIcon(iter_12_1.affect_type_1)
				}
				var_12_0[2] = {
					isAll = true,
					attr = {
						g.core.lang:getAttr(iter_12_1.affect_type_2, iter_12_1.affect_value_2, true)
					},
					res = g.core.common.Path:getAttrIcon(iter_12_1.affect_type_2)
				}
				var_12_0[3] = {
					isAll = true,
					attr = {
						g.core.lang:getAttr(iter_12_1.affect_type_3, iter_12_1.affect_value_3, true)
					},
					res = g.core.common.Path:getAttrIcon(iter_12_1.affect_type_3)
				}
				var_12_0[4] = {
					isAll = true,
					attr = {
						g.core.lang:getAttr(iter_12_1.affect_type_4, iter_12_1.affect_value_4, true)
					},
					res = g.core.common.Path:getAttrIcon(iter_12_1.affect_type_4)
				}
				var_12_0[5] = {
					res = "ui://base_new/icon_tujianzhi",
					attr = {
						g.core.lang:get(111506),
						iter_12_1.score
					}
				}
			end
		end
	end

	return var_12_0
end

function HandBookData:getBookInfoByIdAndLevel(arg_13_1, arg_13_2)
	if self._allKingBookInfo[arg_13_1] then
		for iter_13_0, iter_13_1 in pairs(self._allKingBookInfo[arg_13_1]) do
			if iter_13_1.level == arg_13_2 then
				return iter_13_1
			end
		end
	end
end

function HandBookData:getKnightBookScore(arg_14_1)
	if self._allActiveKnightData[arg_14_1] then
		if self._allKingBookInfo[arg_14_1] then
			for iter_14_0, iter_14_1 in pairs(self._allKingBookInfo[arg_14_1]) do
				if iter_14_1.level == self._allActiveKnightData[arg_14_1].level + 1 then
					return iter_14_1.score
				end
			end
		end
	end

	return 0
end

function HandBookData:getTotalKnightBookScore()
	local var_15_0 = 0

	for iter_15_0, iter_15_1 in pairs(self._allActiveKnightData) do
		if self._allKingBookInfo[iter_15_1.id] then
			for iter_15_2, iter_15_3 in pairs(self._allKingBookInfo[iter_15_1.id]) do
				if iter_15_3.level == iter_15_1.level then
					var_15_0 = var_15_0 + iter_15_3.score
				end
			end
		end
	end

	return var_15_0
end

function HandBookData:getTotalKnightBookAttr()
	local var_16_0 = {}

	for iter_16_0, iter_16_1 in pairs(self._allActiveKnightData) do
		if self._allKingBookInfo[iter_16_1.id] then
			for iter_16_2, iter_16_3 in pairs(self._allKingBookInfo[iter_16_1.id]) do
				if iter_16_3.level == iter_16_1.level then
					var_16_0[iter_16_3.affect_type_1] = var_16_0[iter_16_3.affect_type_1] or 0
					var_16_0[iter_16_3.affect_type_2] = var_16_0[iter_16_3.affect_type_2] or 0
					var_16_0[iter_16_3.affect_type_3] = var_16_0[iter_16_3.affect_type_3] or 0
					var_16_0[iter_16_3.affect_type_4] = var_16_0[iter_16_3.affect_type_4] or 0
					var_16_0[iter_16_3.affect_type_1] = var_16_0[iter_16_3.affect_type_1] + iter_16_3.affect_value_1
					var_16_0[iter_16_3.affect_type_2] = var_16_0[iter_16_3.affect_type_2] + iter_16_3.affect_value_2
					var_16_0[iter_16_3.affect_type_3] = var_16_0[iter_16_3.affect_type_3] + iter_16_3.affect_value_3
					var_16_0[iter_16_3.affect_type_4] = var_16_0[iter_16_3.affect_type_4] + iter_16_3.affect_value_4
				end
			end
		end
	end

	local var_16_1 = {}

	for iter_16_4, iter_16_5 in pairs(var_16_0) do
		table.insert(var_16_1, {
			attrId = iter_16_4,
			attrValue = iter_16_5
		})
	end

	table.sort(var_16_1, function(arg_17_0, arg_17_1)
		if arg_17_0.attrId == 2 ~= (arg_17_1.attrId == 2) then
			return arg_17_0.attrId == 2
		end

		if arg_17_0.attrId ~= arg_17_1.attrId then
			return arg_17_0.attrId < arg_17_1.attrId
		end
	end)

	return var_16_1
end

function HandBookData:getTotalBookActivateAttr()
	local var_18_0 = {}
	local var_18_1 = {}
	local var_18_2 = 0
	local var_18_3 = self:getTotalKnightBookScore()

	for iter_18_0 = 1, var_0_3.getLength() do
		local var_18_4 = var_0_3.indexOf(iter_18_0)

		if var_18_3 >= var_18_4.require_score then
			if var_18_1[var_18_4.affect_type_1] == nil then
				var_18_2 = var_18_2 + 1
				var_18_1[var_18_4.affect_type_1] = var_18_2
				var_18_0[var_18_2] = {
					attrId = var_18_4.affect_type_1,
					attrValue = var_18_4.affect_value_1
				}
			else
				var_18_0[var_18_1[var_18_4.affect_type_1]].attrValue = var_18_0[var_18_1[var_18_4.affect_type_1]].attrValue + var_18_4.affect_value_1
			end

			if var_18_1[var_18_4.affect_type_2] == nil then
				var_18_2 = var_18_2 + 1
				var_18_1[var_18_4.affect_type_2] = var_18_2
				var_18_0[var_18_2] = {
					attrId = var_18_4.affect_type_2,
					attrValue = var_18_4.affect_value_2
				}
			else
				var_18_0[var_18_1[var_18_4.affect_type_2]].attrValue = var_18_0[var_18_1[var_18_4.affect_type_2]].attrValue + var_18_4.affect_value_2
			end
		else
			break
		end
	end

	table.sort(var_18_0, function(arg_19_0, arg_19_1)
		if arg_19_0.attrId == 2 ~= (arg_19_1.attrId == 2) then
			return arg_19_0.attrId == 2
		end

		if arg_19_0.attrId ~= arg_19_1.attrId then
			return arg_19_0.attrId < arg_19_1.attrId
		end
	end)

	return var_18_0
end

function HandBookData:isKnightCanUp(arg_20_1)
	local var_20_0 = g.core.model.User.knightsData:getKnightInfoByAdvanceId(var_0_2.get(arg_20_1).knight_advance_id)

	if self:isMaxLevel(arg_20_1) then
		return false
	end

	if var_20_0 and g.core.model.User.handBookData:getUpNeedStar(arg_20_1) <= var_20_0.star then
		return true
	end

	return false
end

function HandBookData:getCurHandBookData()
	local var_21_0 = {}
	local var_21_1 = {}

	for iter_21_0, iter_21_1 in pairs(self._allKingBookInfo) do
		local var_21_2 = g.core.config.knight_info.get(iter_21_1[1].knight_advance_id)

		if var_21_2.put == 1 then
			local var_21_3 = {
				advId = iter_21_0,
				knightAdvId = iter_21_1[1].knight_advance_id,
				group = var_21_2.group,
				quality = var_21_2.quality,
				level = self:getKnightBookLevel(iter_21_0)
			}

			var_21_3.isActive = false
			var_21_3.curState = 0

			if self._allActiveKnightData[iter_21_0] then
				var_21_3.isActive = true
				var_21_3.curState = self:isKnightCanUp(iter_21_0) and 3 or 2
			elseif g.core.model.User.knightsData:hasKnightByAdvanceId(iter_21_1[1].knight_advance_id) then
				var_21_3.curState = 1
			end

			var_21_3.isResEnough = false

			local var_21_4 = self:getBookInfoByIdAndLevel(var_21_3.advId, var_21_3.level + 1)

			if var_21_4 then
				var_21_3.isResEnough = g.core.model.User.bagData:getOwnNum(var_21_4.cost_type, var_21_4.cost_value) >= var_21_4.cost_size
			end

			table.insert(var_21_0, var_21_3)
		end
	end

	for iter_21_2 = 1, #var_21_0 do
		var_21_1[var_21_0[iter_21_2].group] = var_21_1[var_21_0[iter_21_2].group] or {}

		table.insert(var_21_1[var_21_0[iter_21_2].group], var_21_0[iter_21_2])
	end

	local function var_21_5(arg_22_0, arg_22_1)
		if arg_22_0.curState == 0 then
			if arg_22_1.curState ~= 0 then
				return false
			end
		elseif arg_22_0.curState == 1 then
			if arg_22_1.curState ~= 1 then
				return true
			end
		elseif arg_22_0.curState == 2 then
			if arg_22_1.curState == 0 then
				return true
			end

			if arg_22_1.curState == 1 then
				return false
			end

			if arg_22_1.curState == 3 and arg_22_1.isResEnough then
				return false
			end
		elseif arg_22_0.curState == 3 then
			if arg_22_1.curState == 0 then
				return true
			end

			if arg_22_1.curState == 1 then
				return false
			end

			if arg_22_1.curState == 2 and arg_22_0.isResEnough then
				return true
			end

			if arg_22_1.curState == 3 and arg_22_0.isResEnough ~= arg_22_1.isResEnough then
				return arg_22_0.isResEnough
			end
		end

		if arg_22_0.quality ~= arg_22_1.quality then
			return arg_22_0.quality > arg_22_1.quality
		end

		if arg_22_0.knightAdvId ~= arg_22_1.knightAdvId then
			return arg_22_0.knightAdvId > arg_22_1.knightAdvId
		end
	end

	for iter_21_3, iter_21_4 in pairs(var_21_1) do
		table.sort(iter_21_4, var_21_5)
	end

	return var_21_1
end

function HandBookData:getHandBookNewestData(arg_23_1)
	local var_23_0 = g.core.config.knight_info.get(arg_23_1)
	local var_23_1 = {
		advId = arg_23_1,
		knightAdvId = arg_23_1,
		group = var_23_0.group,
		quality = var_23_0.quality,
		level = self:getKnightBookLevel(arg_23_1)
	}

	var_23_1.isActive = false
	var_23_1.curState = 0

	if self._allActiveKnightData[arg_23_1] then
		var_23_1.isActive = true
		var_23_1.curState = self:isKnightCanUp(arg_23_1) and 3 or 2
	elseif g.core.model.User.knightsData:hasKnightByAdvanceId(arg_23_1) then
		var_23_1.curState = 1
	end

	var_23_1.isResEnough = false

	local var_23_2 = self:getBookInfoByIdAndLevel(var_23_1.advId, var_23_1.level + 1)

	if var_23_2 then
		var_23_1.isResEnough = g.core.model.User.bagData:getOwnNum(var_23_2.cost_type, var_23_2.cost_value) >= var_23_2.cost_size
	end

	return var_23_1
end

function HandBookData:getCurHandBookDataByTag(arg_24_1)
	local var_24_0 = {}
	local var_24_1 = {}

	for iter_24_0, iter_24_1 in pairs(self._allKingBookInfo) do
		if g.core.config.knight_info.get(iter_24_1[1].knight_advance_id).put == 1 and not g.core.model.User.homeData:checkReverseCensorItem(var_0_1.CENSOR_TYPE.KNIGHT, iter_24_1[1].knight_advance_id) then
			table.insert(var_24_0, (self:getHandBookNewestData(iter_24_0)))
		end
	end

	local function var_24_2(arg_25_0, arg_25_1)
		if arg_25_0.curState == 0 then
			if arg_25_1.curState ~= 0 then
				return false
			end
		elseif arg_25_0.curState == 1 then
			if arg_25_1.curState ~= 1 then
				return true
			end
		elseif arg_25_0.curState == 2 then
			if arg_25_1.curState == 0 then
				return true
			end

			if arg_25_1.curState == 1 then
				return false
			end

			if arg_25_1.curState == 3 and arg_25_1.isResEnough then
				return false
			end
		elseif arg_25_0.curState == 3 then
			if arg_25_1.curState == 0 then
				return true
			end

			if arg_25_1.curState == 1 then
				return false
			end

			if arg_25_1.curState == 2 and arg_25_0.isResEnough then
				return true
			end

			if arg_25_1.curState == 3 and arg_25_0.isResEnough ~= arg_25_1.isResEnough then
				return arg_25_0.isResEnough
			end
		end

		if arg_25_0.quality ~= arg_25_1.quality then
			return arg_25_0.quality > arg_25_1.quality
		end

		if arg_25_0.knightAdvId ~= arg_25_1.knightAdvId then
			return arg_25_0.knightAdvId > arg_25_1.knightAdvId
		end
	end

	if arg_24_1 == 0 then
		table.sort(var_24_0, var_24_2)

		return var_24_0
	else
		for iter_24_2 = 1, #var_24_0 do
			var_24_1[var_24_0[iter_24_2].group] = var_24_1[var_24_0[iter_24_2].group] or {}

			table.insert(var_24_1[var_24_0[iter_24_2].group], var_24_0[iter_24_2])
		end

		table.sort(var_24_1[arg_24_1], var_24_2)

		return var_24_1[arg_24_1]
	end
end

function HandBookData:getNextScoreInfo(arg_26_1)
	local var_26_0 = arg_26_1 or self:getTotalKnightBookScore()
	local var_26_1 = var_0_3.getLength()

	for iter_26_0 = 1, var_26_1 do
		local var_26_2 = var_0_3.indexOf(iter_26_0)

		if var_26_0 < var_26_2.require_score then
			return var_26_2
		end
	end

	return var_0_3.indexOf(var_26_1)
end

function HandBookData:getCurScoreInfo(arg_27_1)
	local var_27_0 = arg_27_1 or self:getTotalKnightBookScore()
	local var_27_1 = var_0_3.getLength()

	for iter_27_0 = 1, var_27_1 do
		if var_27_0 < var_0_3.indexOf(iter_27_0).require_score then
			if iter_27_0 > 1 then
				return var_0_3.indexOf(iter_27_0 - 1)
			else
				return nil
			end
		end
	end

	return var_0_3.indexOf(var_27_1)
end

function HandBookData:getChangeAttrs(arg_28_1, arg_28_2)
	local var_28_0 = var_0_3.getLength()

	arg_28_2 = arg_28_2 < var_28_0 and arg_28_2 or var_28_0

	local var_28_1 = {}

	for iter_28_0 = arg_28_1 + 1, arg_28_2 do
		local var_28_2 = var_0_3.indexOf(iter_28_0)

		for iter_28_1 = 1, 2 do
			var_28_1[var_28_2["affect_type_" .. iter_28_1]] = not var_28_1[var_28_2["affect_type_" .. iter_28_1]] and var_28_2["affect_value_" .. iter_28_1] or var_28_1[var_28_2["affect_type_" .. iter_28_1]] + var_28_2["affect_value_" .. iter_28_1]
		end
	end

	return var_28_1
end

function HandBookData:getCurAndNextScoreInfo()
	local var_29_0 = self:getTotalKnightBookScore()
	local var_29_1 = var_0_3.getLength()

	for iter_29_0 = 1, var_29_1 do
		local var_29_2 = var_0_3.indexOf(iter_29_0)

		if var_29_0 < var_29_2.require_score then
			return {
				cur = (iter_29_0 > 1 and iter_29_0 ~= var_29_1 or nil) and var_0_3.indexOf(iter_29_0 - 1),
				next = var_29_2
			}
		end
	end

	return {
		cur = var_0_3.indexOf(var_29_1)
	}
end

function HandBookData:getCurActiveScoreInfo(arg_30_1)
	local var_30_0 = {}
	local var_30_1 = self:getTotalKnightBookScore()

	for iter_30_0 = 1, var_0_3.getLength() do
		local var_30_2 = var_0_3.indexOf(iter_30_0)

		if arg_30_1 < var_30_2.require_score and var_30_1 >= var_30_2.require_score then
			table.insert(var_30_0, var_30_2)
		end
	end

	return var_30_0
end

function HandBookData:getCurGroupActiveNum(arg_31_1)
	local var_31_0 = self:getCurHandBookData()[arg_31_1]
	local var_31_1 = 0

	for iter_31_0 = 1, #var_31_0 do
		if var_31_0[iter_31_0].isActive then
			var_31_1 = var_31_1 + 1
		end
	end

	return var_31_1
end

function HandBookData:getNewActiveAwardInfo(arg_32_1)
	local var_32_0 = self:getBookInfoByIdAndLevel(self._allActiveKnightData[arg_32_1].id, self._allActiveKnightData[arg_32_1].level)
	local var_32_1 = 0

	if var_32_0.level > 0 then
		var_32_1 = self:getBookInfoByIdAndLevel(var_32_0.advance_id, var_32_0.level - 1).score
	end

	local var_32_2 = self:getTotalKnightBookScore()
	local var_32_3 = var_32_2 - (var_32_0.score - var_32_1)

	return (var_0_3.match(function(arg_33_0)
		if var_32_3 < arg_33_0.require_score and var_32_2 >= arg_33_0.require_score then
			return true
		end
	end))
end

function HandBookData:getUpgradeList()
	local var_34_0 = 0
	local var_34_1 = 0
	local var_34_2 = 0
	local var_34_3 = {}

	for iter_34_0, iter_34_1 in pairs(self._allKingBookInfo) do
		local var_34_4 = iter_34_1[1].knight_advance_id
		local var_34_5 = g.core.model.User.knightsData:getKnight({
			advance_id = iter_34_1[1].knight_advance_id
		})
		local var_34_6 = var_34_5:getBaseInfo()

		if var_34_6.put == 1 then
			local var_34_7 = self._allActiveKnightData[var_34_4]

			if self._allActiveKnightData[var_34_4] and var_34_7.level < var_34_6.star or not var_34_7 and var_34_5:isOwn() then
				local var_34_8 = {
					advId = iter_34_0
				}

				if var_34_7 then
					var_34_8.level = var_34_7.level
					var_34_8.isActive = true
					var_34_8.isResEnough = false

					local var_34_9 = self:getBookInfoByIdAndLevel(var_34_4, var_34_8.level + 1)

					if var_34_9 then
						var_34_8.isResEnough = g.core.model.bag:getOwnNum(var_34_9.cost_type, var_34_9.cost_value) >= var_34_9.cost_size
						var_34_0 = var_34_0 + var_34_9.cost_size

						if var_34_8.isResEnough then
							var_34_2 = var_34_2 + 1
						end
					end
				else
					var_34_8.level = 0
					var_34_8.isActive = false
					var_34_8.isResEnough = true
					var_34_1 = var_34_1 + 1
				end

				var_34_8.knightInfo = var_34_6

				table.insert(var_34_3, var_34_8)
			end
		end
	end

	table.sort(var_34_3, function(arg_35_0, arg_35_1)
		if arg_35_0.isActive ~= arg_35_1.isActive then
			return arg_35_1.isActive
		elseif arg_35_0.isResEnough ~= arg_35_1.isResEnough then
			return arg_35_0.isResEnough
		end

		if arg_35_0.knightInfo.quality ~= arg_35_1.knightInfo.quality then
			return arg_35_0.knightInfo.quality > arg_35_1.knightInfo.quality
		end

		if arg_35_0.level ~= arg_35_1.level then
			return arg_35_0.level > arg_35_1.level
		end

		return arg_35_0.knightInfo.advance_id < arg_35_1.knightInfo.advance_id
	end)

	return var_34_3, {
		scrollNum = var_34_0,
		activeNum = var_34_1,
		upgradeNum = var_34_2
	}
end

function HandBookData:getAnimData(arg_36_1)
	local var_36_0 = {}
	local var_36_1 = self:getTotalKnightBookScore()
	local var_36_2 = self:getNextScoreInfo(arg_36_1)
	local var_36_3 = var_0_3.getLength()

	if var_36_2.id == 1 then
		table.insert(var_36_0, 0)
	else
		table.insert(var_36_0, var_0_3.indexOf(var_36_2.id - 1).require_score)
	end

	while var_36_1 > var_36_2.require_score do
		table.insert(var_36_0, var_36_2.require_score)

		if var_36_2.id == var_36_3 then
			var_36_0.full = true

			break
		end

		var_36_2 = var_0_3.indexOf(var_36_2.id + 1)
	end

	if not var_36_0.full then
		table.insert(var_36_0, var_36_2.require_score)

		if var_36_2.require_score == var_0_3.indexOf(var_36_3).require_score then
			var_36_0.full = true
		end
	end

	return var_36_0
end

function HandBookData:getCanActiveBookNum()
	local var_37_0 = 0

	for iter_37_0, iter_37_1 in ipairs((self:getCurHandBookDataByTag(0))) do
		if iter_37_1.curState and iter_37_1.curState == 1 then
			var_37_0 = var_37_0 + 1
		end
	end

	return var_37_0
end

function HandBookData:isHandBookCanUpgrade(arg_38_1)
	if arg_38_1 and arg_38_1.advId then
		local var_38_0 = self:getHandBookNewestData(arg_38_1.advId)

		if not var_38_0 then
			return false
		end

		if var_38_0.curState == 1 then
			return true
		elseif var_38_0.curState == 3 then
			if self:isMaxLevel(arg_38_1.advId) then
				return false
			end

			local var_38_1 = self:getBookInfoByIdAndLevel(arg_38_1.advId, self:getKnightBookLevel(arg_38_1.advId) + 1)

			if g.core.model.User.bagData:getOwnNum(var_38_1.cost_type, var_38_1.cost_value) >= var_38_1.cost_size then
				return true
			end
		end

		return false
	else
		for iter_38_0, iter_38_1 in pairs(self._allKingBookInfo) do
			if g.core.config.knight_info.get(iter_38_1[1].knight_advance_id).put == 1 then
				if self._allActiveKnightData[iter_38_0] then
					if self:isKnightCanUp(iter_38_0) then
						local var_38_2 = self:getBookInfoByIdAndLevel(iter_38_0, self:getKnightBookLevel(iter_38_0) + 1)

						if var_38_2 and g.core.model.User.bagData:getOwnNum(var_38_2.cost_type, var_38_2.cost_value) >= var_38_2.cost_size then
							return true
						end
					end
				elseif g.core.model.User.knightsData:hasKnightByAdvanceId(iter_38_1[1].knight_advance_id) then
					return true
				end
			end
		end

		return false
	end
end

function HandBookData:getAllCanActiveOrUpgradeHandBookList()
	local var_39_0 = {}
	local var_39_1 = {}
	local var_39_2 = {}

	for iter_39_0, iter_39_1 in pairs(self._allKingBookInfo) do
		if g.core.config.knight_info.get(iter_39_1[1].knight_advance_id).put == 1 then
			if self._allActiveKnightData[iter_39_0] then
				if self:isKnightCanUp(iter_39_0) then
					local var_39_3 = self:getBookInfoByIdAndLevel(iter_39_0, self:getKnightBookLevel(iter_39_0) + 1)

					if var_39_3 and g.core.model.User.bagData:getOwnNum(var_39_3.cost_type, var_39_3.cost_value) >= var_39_3.cost_size then
						table.insert(var_39_1, iter_39_0)
						table.insert(var_39_2, iter_39_0)
					end
				end
			elseif g.core.model.User.knightsData:hasKnightByAdvanceId(iter_39_1[1].knight_advance_id) then
				table.insert(var_39_0, iter_39_0)
				table.insert(var_39_2, iter_39_0)
			end
		end
	end

	return var_39_0, var_39_1, var_39_2
end

return HandBookData

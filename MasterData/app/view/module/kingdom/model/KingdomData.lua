local KingdomData = class("KingdomData")
local var_0_1 = g.core.config.scroll_main_growth_info
local var_0_2 = g.core.config.scroll_set_info

KingdomData.ATTRMAX = 10
KingdomData.MAIN = 1
KingdomData.BIO = 2

function KingdomData:ctor()
	self:initData()
end

function KingdomData:initData()
	self._allNodeInfo = {}
	self._allChapterInfo = {}
	self._allActiveNodeInfo = {}
	self._allStarInfo = {}
	self._allQualityInfo = {}
	self._allMainBigNode = {}
	self._isMainActive = false
	self._isBioActive = false

	self:initNodeInfo()
	self:initChapterInfo()
end

function KingdomData:initNodeInfo()
	for iter_3_0 = 1, var_0_1.getLength() do
		local var_3_0 = var_0_1.indexOf(iter_3_0)

		self._allNodeInfo[var_3_0.tab_type] = self._allNodeInfo[var_3_0.tab_type] or {}
		self._allNodeInfo[var_3_0.tab_type][var_3_0.set_id] = self._allNodeInfo[var_3_0.tab_type][var_3_0.set_id] or {}

		table.insert(self._allNodeInfo[var_3_0.tab_type][var_3_0.set_id], var_3_0)
	end
end

function KingdomData:initChapterInfo()
	local var_4_0 = {}

	for iter_4_0 = 1, var_0_2.getLength() do
		local var_4_1 = var_0_2.indexOf(iter_4_0)

		self._allChapterInfo[var_4_1.tab_type] = self._allChapterInfo[var_4_1.tab_type] or {}

		table.insert(self._allChapterInfo[var_4_1.tab_type], var_4_1)

		var_4_0[var_4_1.tab_type] = var_4_0[var_4_1.tab_type] or var_4_1.tab_type
	end

	for iter_4_1, iter_4_2 in pairs(var_4_0) do
		table.sort(self._allChapterInfo[iter_4_2], function(arg_5_0, arg_5_1)
			if arg_5_0.order ~= arg_5_1.order then
				return arg_5_0.order < arg_5_1.order
			end
		end)
	end
end

function KingdomData:updateInfo(arg_6_1)
	if arg_6_1.main_ids then
		for iter_6_0, iter_6_1 in ipairs(arg_6_1.main_ids) do
			self._allActiveNodeInfo[iter_6_1] = iter_6_1
		end
	end

	if arg_6_1.hero_ids then
		for iter_6_2, iter_6_3 in ipairs(arg_6_1.hero_ids) do
			self._allActiveNodeInfo[iter_6_3] = iter_6_3
		end
	end

	if arg_6_1.ids then
		for iter_6_4, iter_6_5 in ipairs(arg_6_1.ids) do
			self._allActiveNodeInfo[iter_6_5] = iter_6_5
		end
	end

	if arg_6_1.id and self:isKnightUp(arg_6_1.id) then
		g.core.model.User.formationData:freshMainAssctList()
	end

	self:checkMainActive()
	self:checkBioActive()
end

function KingdomData:getCurActChaptrId(arg_7_1)
	if self._allChapterInfo[arg_7_1] then
		for iter_7_0, iter_7_1 in ipairs(self._allChapterInfo[arg_7_1]) do
			for iter_7_2, iter_7_3 in ipairs((self:getCurNodeInfo(arg_7_1, iter_7_1.id))) do
				if not self._allActiveNodeInfo[iter_7_3.id] then
					return iter_7_1.id
				end
			end
		end
	end

	return self._allChapterInfo[arg_7_1][#self._allChapterInfo[arg_7_1]].id
end

function KingdomData:getCurActChaptrIndex(arg_8_1)
	if self._allChapterInfo[arg_8_1] then
		for iter_8_0, iter_8_1 in ipairs(self._allChapterInfo[arg_8_1]) do
			for iter_8_2, iter_8_3 in ipairs((self:getCurNodeInfo(arg_8_1, iter_8_1.id))) do
				if not self._allActiveNodeInfo[iter_8_3.id] then
					return iter_8_1.set_info_id
				end
			end
		end
	end

	return self._allChapterInfo[arg_8_1][#self._allChapterInfo[arg_8_1]].set_info_id
end

function KingdomData:getChapterInfoByType(arg_9_1)
	if self._allChapterInfo[arg_9_1] then
		return self._allChapterInfo[arg_9_1]
	end

	return {}
end

function KingdomData:getCurNodeInfo(arg_10_1, arg_10_2)
	if self._allNodeInfo[arg_10_1] and self._allNodeInfo[arg_10_1][arg_10_2] then
		return self._allNodeInfo[arg_10_1][arg_10_2]
	end

	return {}
end

function KingdomData:getCurChapterActNodeNum(arg_11_1, arg_11_2)
	local var_11_0 = 0

	if self._allNodeInfo[arg_11_1] and self._allNodeInfo[arg_11_1][arg_11_2] then
		for iter_11_0, iter_11_1 in ipairs(self._allNodeInfo[arg_11_1][arg_11_2]) do
			if self._allActiveNodeInfo[iter_11_1.id] then
				var_11_0 = var_11_0 + 1
			end
		end
	end

	return var_11_0
end

function KingdomData:isCurChapterAllActived(arg_12_1, arg_12_2)
	if self._allNodeInfo[arg_12_1] and self._allNodeInfo[arg_12_1][arg_12_2] then
		for iter_12_0, iter_12_1 in ipairs(self._allNodeInfo[arg_12_1][arg_12_2]) do
			if not self._allActiveNodeInfo[iter_12_1.id] then
				return false
			end
		end
	end

	return true
end

function KingdomData:getAllNodeInfo(arg_13_1)
	if self._allNodeInfo[arg_13_1] then
		return self._allNodeInfo[arg_13_1]
	end
end

function KingdomData:getNextActBigNode(arg_14_1)
	local var_14_0 = 0
	local var_14_1 = 0

	if self._allChapterInfo[arg_14_1] then
		for iter_14_0, iter_14_1 in ipairs(self._allChapterInfo[arg_14_1]) do
			for iter_14_2, iter_14_3 in ipairs((self:getCurNodeInfo(arg_14_1, iter_14_1.id))) do
				var_14_0 = var_14_0 + 1
				var_14_1 = var_14_1 + 1

				local var_14_2

				if not self._allActiveNodeInfo[iter_14_3.id] then
					if iter_14_3.stage_id ~= 0 then
						return 0, var_14_0, var_14_1, iter_14_3.stage_id
					end
				else
					if iter_14_3.stage_id ~= 0 then
						var_14_1 = 0
					end

					var_14_2 = 0 + 1
				end
			end
		end
	end

	return 0, 0, 0, 0
end

function KingdomData:getAllMainBigNode()
	if #self._allMainBigNode == 0 then
		local var_15_0 = 0
		local var_15_1 = 4

		for iter_15_0 = 1, var_0_1.getLength() do
			local var_15_2 = var_0_1.indexOf(iter_15_0)

			if var_15_2.stage_id ~= 0 and var_15_2.tab_type == 1 then
				local var_15_3 = g.core.config.scroll_stage_growth_info.get(var_15_2.stage_id).function_type
				local var_15_4 = {
					stageId = var_15_2.stage_id,
					setId = var_15_2.set_id
				}

				if var_15_3 == 2 then
					var_15_0 = var_15_0 + 1
					var_15_4.star = var_15_0
				elseif var_15_3 == 1 then
					var_15_1 = var_15_1 + 1
					var_15_4.quality = var_15_1
				end

				table.insert(self._allMainBigNode, var_15_4)
			end
		end
	end

	return self._allMainBigNode
end

function KingdomData:isCurNodeActive(arg_16_1)
	local var_16_0 = var_0_1.get(arg_16_1)
	local var_16_1 = g.core.common.Goods:convert({
		type = var_16_0.cost_type,
		value = var_16_0.cost_value,
		size = var_16_0.cost_size
	})

	var_16_1.curItemNum = g.core.model.User.bagData:getCountById(var_16_0.cost_type, var_16_0.cost_value)

	if not self._allActiveNodeInfo[arg_16_1] and (self._allActiveNodeInfo[var_16_0.prepose_id] or var_16_0.prepose_id == 0) then
		return true, var_16_1
	end

	return false, var_16_1
end

function KingdomData:isHasCurNode(arg_17_1)
	if self._allActiveNodeInfo[arg_17_1] then
		return true
	end

	return false
end

function KingdomData:getAllActAttrByTabType(arg_18_1)
	local var_18_0 = {}

	if self._allChapterInfo[arg_18_1] then
		for iter_18_0, iter_18_1 in ipairs(self._allChapterInfo[arg_18_1]) do
			for iter_18_2, iter_18_3 in ipairs((self:getCurNodeInfo(arg_18_1, iter_18_1.id))) do
				if self._allActiveNodeInfo[iter_18_3.id] then
					var_18_0[iter_18_3.attribute_type] = not var_18_0[iter_18_3.attribute_type] and iter_18_3.attribute_value or var_18_0[iter_18_3.attribute_type] + iter_18_3.attribute_value

					if iter_18_3.stage_id ~= 0 then
						local var_18_1 = g.core.config.scroll_stage_growth_info.get(iter_18_3.stage_id)

						for iter_18_4 = 1, KingdomData.ATTRMAX do
							if var_18_1["attribute_type_" .. iter_18_4] and var_18_1["attribute_type_" .. iter_18_4] ~= 0 then
								var_18_0[var_18_1["attribute_type_" .. iter_18_4]] = not var_18_0[var_18_1["attribute_type_" .. iter_18_4]] and var_18_1["attribute_value_" .. iter_18_4] or var_18_0[var_18_1["attribute_type_" .. iter_18_4]] + var_18_1["attribute_value_" .. iter_18_4]
							else
								break
							end
						end
					end
				else
					break
				end
			end
		end
	end

	local var_18_2 = {}

	for iter_18_5, iter_18_6 in pairs(var_18_0) do
		local var_18_3, var_18_4 = g.core.lang:getAttr(iter_18_5, iter_18_6)

		table.insert(var_18_2, {
			name = var_18_3,
			value = var_18_4,
			type = iter_18_5
		})
	end

	table.sort(var_18_2, function(arg_19_0, arg_19_1)
		if arg_19_0.type == 2 ~= (arg_19_1.type == 2) then
			return arg_19_0.type == 2
		end

		if arg_19_0.type ~= arg_19_1.type then
			return arg_19_0.type < arg_19_1.type
		end
	end)

	return var_18_2
end

function KingdomData:getAttrListByNodeId(arg_20_1)
	local var_20_0 = {}
	local var_20_1 = var_0_1.get(arg_20_1)

	var_20_0[var_20_1.attribute_type] = var_20_1.attribute_value

	local var_20_2 = {}

	for iter_20_0, iter_20_1 in pairs(var_20_0) do
		local var_20_3, var_20_4 = g.core.lang:getAttr(iter_20_0, iter_20_1)

		table.insert(var_20_2, {
			name = g.core.lang:get(1133) .. var_20_3,
			value = var_20_4
		})
	end

	return var_20_2
end

function KingdomData:getNodeAttrListByNodeId(arg_21_1)
	local var_21_0 = {}
	local var_21_1 = var_0_1.get(arg_21_1).stage_id

	if var_21_1 ~= 0 then
		local var_21_2 = g.core.config.scroll_stage_growth_info.get(var_21_1)

		for iter_21_0 = 1, KingdomData.ATTRMAX do
			if var_21_2["attribute_type_" .. iter_21_0] and var_21_2["attribute_type_" .. iter_21_0] ~= 0 then
				var_21_0[var_21_2["attribute_type_" .. iter_21_0]] = not var_21_0[var_21_2["attribute_type_" .. iter_21_0]] and var_21_2["attribute_value_" .. iter_21_0] or var_21_0[var_21_2["attribute_type_" .. iter_21_0]] + var_21_2["attribute_value_" .. iter_21_0]
			else
				break
			end
		end
	end

	local var_21_3 = {}

	for iter_21_1, iter_21_2 in pairs(var_21_0) do
		local var_21_4, var_21_5 = g.core.lang:getAttr(iter_21_1, iter_21_2)

		table.insert(var_21_3, {
			name = g.core.lang:get(1133) .. var_21_4,
			value = var_21_5
		})
	end

	return var_21_3
end

function KingdomData:getFunctionType(arg_22_1)
	local var_22_0 = g.core.config.scroll_main_growth_info.get(arg_22_1).stage_id

	if var_22_0 ~= 0 then
		return g.core.config.scroll_stage_growth_info.get(var_22_0).function_type
	end

	return 0
end

function KingdomData:isKnightUp(arg_23_1)
	if self:getFunctionType(arg_23_1) == 1 then
		return true
	end

	return false
end

function KingdomData:isKnightUpStar(arg_24_1)
	if self:getFunctionType(arg_24_1) == 2 then
		return true
	end

	return false
end

function KingdomData:isDropAward(arg_25_1)
	if self:getFunctionType(arg_25_1) == 3 then
		return true
	end

	return false
end

function KingdomData:isActiveAttr(arg_26_1)
	if self:getFunctionType(arg_26_1) == 4 then
		return true
	end

	return false
end

function KingdomData:getAwardList(arg_27_1)
	local var_27_0 = g.core.config.scroll_main_growth_info.get(arg_27_1).stage_id
	local var_27_1 = {}

	if var_27_0 ~= 0 then
		local var_27_2 = g.core.config.scroll_stage_growth_info.get(var_27_0).drop

		if var_27_2 ~= 0 then
			local var_27_3 = g.core.config.drop_info.get(var_27_2, 1)

			table.insert(var_27_1, {
				type = var_27_3.reward_type_1,
				value = var_27_3.reward_value_1,
				size = var_27_3.reward_min_1
			})
		end
	end

	return var_27_1
end

function KingdomData:getChapterInfoByFuncType(arg_28_1)
	local var_28_0 = 0
	local var_28_1 = 0

	if self._allChapterInfo[KingdomData.MAIN] then
		for iter_28_0, iter_28_1 in ipairs(self._allChapterInfo[KingdomData.MAIN]) do
			for iter_28_2, iter_28_3 in ipairs((self:getCurNodeInfo(KingdomData.MAIN, iter_28_1.id))) do
				var_28_0 = var_28_0 + 1
				var_28_1 = var_28_1 + 1

				local var_28_3 = 0

				if iter_28_3.stage_id ~= 0 then
					var_28_3 = g.core.config.scroll_stage_growth_info.get(iter_28_3.stage_id).function_type
				end

				local var_28_4

				if not self._allActiveNodeInfo[iter_28_3.id] then
					if iter_28_3.stage_id ~= 0 and var_28_3 == arg_28_1 then
						return var_28_0 - 0, var_28_1, g.core.config.dungeon_land_info.get(tonumber(iter_28_1.set_info_id))["chapter_" .. iter_28_2], tonumber(iter_28_1.set_info_id)
					end
				else
					if iter_28_3.stage_id ~= 0 and var_28_3 == arg_28_1 then
						var_28_1 = 0
					end

					var_28_4 = 0 + 1
				end
			end
		end
	end

	return 0, 0, 0, 0
end

function KingdomData:isHasActiviteNode()
	local function var_29_0(arg_30_0)
		local var_30_0 = var_0_1.get(arg_30_0)

		if var_30_0.cost_size <= g.core.model.User.bagData:getCountById(var_30_0.cost_type, var_30_0.cost_value) then
			return true
		end

		return false
	end

	for iter_29_0, iter_29_1 in pairs(self._allNodeInfo[KingdomData.MAIN]) do
		for iter_29_2, iter_29_3 in ipairs(iter_29_1) do
			if not self._allActiveNodeInfo[iter_29_3.id] and var_29_0(iter_29_3.id) then
				return true
			end
		end
	end

	for iter_29_4, iter_29_5 in pairs(self._allNodeInfo[KingdomData.BIO]) do
		for iter_29_6, iter_29_7 in ipairs(iter_29_5) do
			if not self._allActiveNodeInfo[iter_29_7.id] and var_29_0(iter_29_7.id) then
				return true
			end
		end
	end

	return false
end

function KingdomData:isHasMainActive()
	local function var_31_0(arg_32_0)
		local var_32_0 = var_0_1.get(arg_32_0)

		if var_32_0.cost_size <= g.core.model.User.bagData:getCountById(var_32_0.cost_type, var_32_0.cost_value) then
			return true
		end

		return false
	end

	for iter_31_0, iter_31_1 in pairs(self._allNodeInfo[KingdomData.MAIN]) do
		for iter_31_2, iter_31_3 in ipairs(iter_31_1) do
			if not self._allActiveNodeInfo[iter_31_3.id] and var_31_0(iter_31_3.id) then
				return true
			end
		end
	end

	return false
end

function KingdomData:checkMainActive()
	self._isMainActive = self:isHasMainActive()
end

function KingdomData:getMainActive()
	return self._isMainActive
end

function KingdomData:isHasBioActive()
	local function var_35_0(arg_36_0)
		local var_36_0 = var_0_1.get(arg_36_0)

		if var_36_0.cost_size <= g.core.model.User.bagData:getCountById(var_36_0.cost_type, var_36_0.cost_value) then
			return true
		end

		return false
	end

	for iter_35_0, iter_35_1 in pairs(self._allNodeInfo[KingdomData.BIO]) do
		for iter_35_2, iter_35_3 in ipairs(iter_35_1) do
			if not self._allActiveNodeInfo[iter_35_3.id] and var_35_0(iter_35_3.id) then
				return true
			end
		end
	end

	return false
end

function KingdomData:checkBioActive()
	self._isBioActive = self:isHasBioActive()
end

function KingdomData:getBioActive()
	return self._isBioActive
end

function KingdomData:isMaxStar(arg_39_1)
	if #self._allStarInfo == 0 then
		for iter_39_0 = 1, g.core.config.scroll_stage_growth_info.getLength() do
			local var_39_0 = g.core.config.scroll_stage_growth_info.indexOf(iter_39_0)

			if var_39_0.function_type == 2 then
				table.insert(self._allStarInfo, var_39_0)
			end
		end
	end

	if arg_39_1 == #self._allStarInfo then
		return true
	end

	return false
end

function KingdomData:isMaxQuality(arg_40_1)
	if #self._allQualityInfo == 0 then
		for iter_40_0 = 1, g.core.config.scroll_stage_growth_info.getLength() do
			local var_40_0 = g.core.config.scroll_stage_growth_info.indexOf(iter_40_0)

			if var_40_0.function_type == 1 then
				table.insert(self._allQualityInfo, var_40_0)
			end
		end
	end

	if arg_40_1 == #self._allQualityInfo + 4 then
		return true
	end

	return false
end

return KingdomData

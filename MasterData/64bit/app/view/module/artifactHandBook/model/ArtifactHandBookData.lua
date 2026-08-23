local var_0_0 = g.core.config.artifact_compose_score_info
local var_0_1 = g.core.config.artifact_compose_advanced_info
local ArtifactHandBookData = class("ArtifactHandBookData")

function ArtifactHandBookData:ctor()
	self:initData()
end

function ArtifactHandBookData:initData()
	self._activeHandBook = {}
	self._activeNum = 0
	self._activedArtifact = {}
	self._groupList = {}
	self._groupMap = {}
	self._singleList = {}
	self._AdvIdLvMap = {}
	self._activedURArtifact = {}
	self._URAdvIdLvMap = {}
	self._allItemMap = {}
	self._URHandBook = {}
	self._URHandBookScore = 0
	self._URHandBookLevel = 0

	self:_initGroupList()
end

function ArtifactHandBookData:_initGroupList()
	self._activeNum = 0
	self._groupList = {}

	for iter_3_0, iter_3_1 in g.core.config.artifact_compose_info.ipairs() do
		if not self._AdvIdLvMap[iter_3_1.advance_code] then
			self._AdvIdLvMap[iter_3_1.advance_code] = {}

			if iter_3_1.type == 2 then
				local var_3_0 = {}

				for iter_3_2 = 1, 5 do
					if iter_3_1["artifact_" .. iter_3_2] > 0 then
						local var_3_1 = g.core.config.artifact_compose_info.get(iter_3_1["artifact_" .. iter_3_2])

						if not self._allItemMap[iter_3_1["artifact_" .. iter_3_2]] then
							table.insert(var_3_0, {
								isActive = false,
								lv = 0,
								id = iter_3_1["artifact_" .. iter_3_2],
								info = var_3_1,
								advId = var_3_1.advance_code
							})

							self._allItemMap[iter_3_1["artifact_" .. iter_3_2]] = var_3_0[#var_3_0]
						else
							table.insert(var_3_0, self._allItemMap[iter_3_1["artifact_" .. iter_3_2]])
						end
					end
				end

				local var_3_2 = {
					isActive = false,
					lv = 0,
					info = iter_3_1,
					artifacts = var_3_0,
					advId = iter_3_1.advance_code
				}

				table.insert(self._groupList, var_3_2)

				self._groupMap[iter_3_1.group] = self._groupMap[iter_3_1.group] or {}

				table.insert(self._groupMap[iter_3_1.group], var_3_2)

				self._allItemMap[iter_3_1.id] = var_3_2
			elseif iter_3_1.type == 1 then
				self._singleList[iter_3_1.id] = iter_3_1
			end
		end

		self._AdvIdLvMap[iter_3_1.advance_code][iter_3_1.level] = iter_3_1
	end

	for iter_3_3, iter_3_4 in g.core.config.artifact_compose_advanced_info.ipairs() do
		if g.core.config.artifact_info.get(iter_3_4.advance_code).put ~= 0 then
			self._URAdvIdLvMap[iter_3_4.advance_code] = self._URAdvIdLvMap[iter_3_4.advance_code] or {}
			self._URHandBook[iter_3_4.id] = iter_3_4
			self._URAdvIdLvMap[iter_3_4.advance_code][iter_3_4.level] = iter_3_4
		end
	end
end

function ArtifactHandBookData:getTargetLvCfg(arg_4_1, arg_4_2)
	if self._AdvIdLvMap[arg_4_1] then
		return self._AdvIdLvMap[arg_4_1][arg_4_2]
	end

	return nil
end

function ArtifactHandBookData:getAllBaseAdditions()
	local var_5_0 = 0
	local var_5_1 = 0
	local var_5_2 = {}

	for iter_5_0, iter_5_1 in ipairs(self._groupList) do
		for iter_5_2, iter_5_3 in ipairs(iter_5_1.artifacts) do
			if g.core.config.artifact_info.get(iter_5_3.id).put ~= 0 then
				var_5_1 = var_5_1 + 1
			end

			if iter_5_3.isActive then
				var_5_0 = var_5_0 + 1

				local var_5_3 = self:getTargetLvCfg(iter_5_3.advId, iter_5_3.lv)

				for iter_5_4 = 1, 4 do
					if var_5_3["affect_type_" .. iter_5_4] ~= 0 then
						var_5_2[var_5_3["affect_type_" .. iter_5_4]] = not var_5_2[var_5_3["affect_type_" .. iter_5_4]] and var_5_3["affect_value_" .. iter_5_4] or var_5_2[var_5_3["affect_type_" .. iter_5_4]] + var_5_3["affect_value_" .. iter_5_4]
					end
				end
			end
		end
	end

	local var_5_4 = {}

	for iter_5_5, iter_5_6 in pairs(var_5_2) do
		table.insert(var_5_4, {
			isAll = true,
			type = iter_5_5,
			value = iter_5_6
		})
	end

	return var_5_4, var_5_0, var_5_1
end

function ArtifactHandBookData:getAllFettersAdditions()
	local var_6_0 = 0
	local var_6_1 = {}

	for iter_6_0, iter_6_1 in ipairs(self._groupList) do
		if iter_6_1.isActive then
			local var_6_2 = self:getTargetLvCfg(iter_6_1.advId, iter_6_1.lv)

			var_6_0 = var_6_0 + 1

			for iter_6_2 = 1, 4 do
				if var_6_2["affect_type_" .. iter_6_2] ~= 0 then
					var_6_1[var_6_2["affect_type_" .. iter_6_2]] = not var_6_1[var_6_2["affect_type_" .. iter_6_2]] and var_6_2["affect_value_" .. iter_6_2] or var_6_1[var_6_2["affect_type_" .. iter_6_2]] + var_6_2["affect_value_" .. iter_6_2]
				end
			end
		end
	end

	local var_6_3 = {}

	for iter_6_3, iter_6_4 in pairs(var_6_1) do
		table.insert(var_6_3, {
			isAll = true,
			type = iter_6_3,
			value = iter_6_4
		})
	end

	return var_6_3, var_6_0, #self._groupList
end

function ArtifactHandBookData:getHandBookByGroup(arg_7_1, arg_7_2)
	if not arg_7_2 or arg_7_2 == 0 then
		return self._groupMap[arg_7_1]
	else
		local var_7_0 = g.core.config.artifact_info
		local var_7_1 = {}

		for iter_7_0, iter_7_1 in ipairs(self._groupMap[arg_7_1]) do
			local var_7_2 = {}

			for iter_7_2, iter_7_3 in ipairs(iter_7_1.artifacts) do
				if arg_7_2 == var_7_0.get(g.core.config.artifact_compose_info.get(iter_7_3.id).artifact_1).quality then
					table.insert(var_7_2, iter_7_3)
				end
			end

			if #var_7_2 > 0 then
				table.insert(var_7_1, {
					info = iter_7_1.info,
					artifacts = var_7_2,
					isActive = iter_7_1.isActive,
					level = iter_7_1.lv,
					lv = iter_7_1.lv
				})
			end
		end

		return var_7_1
	end
end

function ArtifactHandBookData:activeHandBook(arg_8_1)
	local var_8_0 = self:getMemoryId(arg_8_1.id)

	self._allItemMap[var_8_0].isActive = true
	self._allItemMap[var_8_0].lv = 1

	self:updateAllHandBookData()
end

function ArtifactHandBookData:lvUpHandBook(arg_9_1)
	self._allItemMap[self:getMemoryId(arg_9_1.id)].lv = arg_9_1.level

	self:updateAllHandBookData()
end

function ArtifactHandBookData:activeHandBook(arg_10_1)
	local var_10_0 = self:getMemoryId(arg_10_1.id)

	self._allItemMap[var_10_0].isActive = true
	self._allItemMap[var_10_0].lv = 1

	self:updateAllHandBookData()
end

function ArtifactHandBookData:lvUpHandBook(arg_11_1)
	self._allItemMap[self:getMemoryId(arg_11_1.id)].lv = arg_11_1.level

	self:updateAllHandBookData()
end

function ArtifactHandBookData:getMemoryId(arg_12_1)
	return self:getTargetLvCfg(g.core.config.artifact_compose_info.get(arg_12_1).advance_code, 1).id
end

function ArtifactHandBookData:updateAllHandBookData()
	for iter_13_0, iter_13_1 in ipairs(self._groupList) do
		local var_13_0 = true
		local var_13_1 = 0

		for iter_13_2, iter_13_3 in ipairs(iter_13_1.artifacts) do
			if not iter_13_3.isActive then
				var_13_0 = false
			end

			var_13_1 = var_13_1 + iter_13_3.lv

			local var_13_2, var_13_3 = g.core.model.User.artifactData:hasArtifactByAdvanceId(iter_13_3.id)

			iter_13_3.star = var_13_3:getStar()
			iter_13_3.maxStar = var_13_3:getMaxStar()
			iter_13_3.struct = var_13_3

			if iter_13_3.isActive then
				local var_13_4 = self:getTargetLvCfg(iter_13_3.advId, iter_13_3.lv)

				if var_13_4.next_id and var_13_4.next_id ~= 0 then
					iter_13_3.canLvUp = iter_13_3.star >= var_13_4.need
				else
					iter_13_3.canLvUp = false
					iter_13_3.isMax = true
				end
			end
		end

		iter_13_1.canActive = not not var_13_0
		iter_13_1.childLv = var_13_1

		local var_13_5 = self:getTargetLvCfg(iter_13_1.advId, iter_13_1.lv)

		if var_13_5 then
			if var_13_5.next_id and var_13_5.next_id ~= 0 then
				iter_13_1.canLvUp = iter_13_1.lv >= var_13_5.need
			else
				iter_13_1.canLvUp = false
				iter_13_1.isMax = true
			end
		end
	end
end

function ArtifactHandBookData:updateHandBook(arg_14_1)
	self._activeNum = 0
	self._activedArtifact = {}
	self._activeHandBook = {}

	local var_14_0 = arg_14_1.hb or {}

	self._activeHandBook = var_14_0

	local var_14_1 = {}

	for iter_14_0, iter_14_1 in pairs(self._activeHandBook) do
		var_14_1[iter_14_1.id] = iter_14_1.level
	end

	self._activedArtifact = var_14_1

	for iter_14_2, iter_14_3 in ipairs(self._groupList) do
		local var_14_2 = true

		for iter_14_4, iter_14_5 in ipairs(iter_14_3.artifacts) do
			if var_14_1[iter_14_5.id] then
				iter_14_5.isActive = true
				iter_14_5.lv = var_14_1[iter_14_5.id] or 0
			else
				var_14_2 = false
				iter_14_5.isActive = false
			end
		end

		if var_14_1[iter_14_3.info.id] then
			iter_14_3.isActive = true
			iter_14_3.lv = var_14_1[iter_14_3.info.id] or 0
		end

		iter_14_3.canActive = not not var_14_2
	end

	self._activeNum = #var_14_0

	self:updateAllHandBookData()
end

function ArtifactHandBookData:getGroupList()
	return self._groupList
end

function ArtifactHandBookData:getActiveNum()
	return self._activeNum
end

function ArtifactHandBookData:getHandBookAttr()
	local var_17_0 = {}

	for iter_17_0, iter_17_1 in ipairs(self._activeHandBook) do
		local var_17_1 = g.core.config.artifact_compose_info.get(iter_17_1.id)

		for iter_17_2 = 1, 4 do
			if var_17_1["affect_type_" .. iter_17_2] > 0 then
				var_17_0[var_17_1["affect_type_" .. iter_17_2]] = var_17_0[var_17_1["affect_type_" .. iter_17_2]] or 0
				var_17_0[var_17_1["affect_type_" .. iter_17_2]] = var_17_0[var_17_1["affect_type_" .. iter_17_2]] + var_17_1["affect_value_" .. iter_17_2]
			end
		end
	end

	local var_17_2 = {}

	for iter_17_3, iter_17_4 in pairs(var_17_0) do
		table.insert(var_17_2, {
			type = iter_17_3,
			value = iter_17_4
		})
	end

	return var_17_2
end

function ArtifactHandBookData:groupHasItemCanActive(arg_18_1)
	if arg_18_1 and arg_18_1.group then
		for iter_18_0, iter_18_1 in ipairs(self._groupMap[arg_18_1.group]) do
			if not iter_18_1.isActive and iter_18_1.canActive then
				return true
			end

			if iter_18_1.lv and iter_18_1.lv > 0 and self:getTargetLvCfg(iter_18_1.advId, iter_18_1.lv).next_id ~= 0 then
				local var_18_0 = self:getTargetLvCfg(iter_18_1.advId, iter_18_1.lv + 1)

				if iter_18_1.childLv >= var_18_0.need then
					if var_18_0.num == 0 then
						return true
					end

					if g.core.model.User.bagData:getCountById(var_18_0.cost_type, var_18_0.cost_value) >= var_18_0.num then
						return true
					end
				end
			end

			for iter_18_2, iter_18_3 in ipairs(iter_18_1.artifacts) do
				local var_18_1, var_18_2 = g.core.model.User.artifactData:hasArtifactByAdvanceId(iter_18_3.id)

				if not iter_18_3.isActive and var_18_1 and g.core.config.artifact_info.get(iter_18_3.id).put ~= 0 then
					return true
				end

				if iter_18_3.lv and iter_18_3.lv > 0 and self:getTargetLvCfg(iter_18_3.advId, iter_18_3.lv).next_id ~= 0 then
					local var_18_3 = self:getTargetLvCfg(iter_18_3.advId, iter_18_3.lv + 1)

					if var_18_3 and var_18_2:getStar() >= var_18_3.need then
						if var_18_3.num == 0 then
							return true
						end

						if g.core.model.User.bagData:getCountById(var_18_3.cost_type, var_18_3.cost_value) >= var_18_3.num then
							return true
						end
					end
				end
			end
		end
	else
		for iter_18_4, iter_18_5 in pairs(self._groupMap) do
			for iter_18_6, iter_18_7 in ipairs(iter_18_5) do
				if not iter_18_7.isActive and iter_18_7.canActive then
					return true
				end

				if iter_18_7.lv and iter_18_7.lv > 0 and self:getTargetLvCfg(iter_18_7.advId, iter_18_7.lv).next_id ~= 0 then
					local var_18_4 = self:getTargetLvCfg(iter_18_7.advId, iter_18_7.lv + 1)

					if iter_18_7.childLv >= var_18_4.need then
						if var_18_4.num == 0 then
							return true
						end

						if g.core.model.User.bagData:getCountById(var_18_4.cost_type, var_18_4.cost_value) >= var_18_4.num then
							return true
						end
					end
				end

				for iter_18_8, iter_18_9 in ipairs(iter_18_7.artifacts) do
					local var_18_5, var_18_6 = g.core.model.User.artifactData:hasArtifactByAdvanceId(iter_18_9.id)

					if not iter_18_9.isActive and var_18_5 and g.core.config.artifact_info.get(iter_18_9.id).put ~= 0 then
						return true
					end

					if iter_18_9.lv and iter_18_9.lv > 0 and self:getTargetLvCfg(iter_18_9.advId, iter_18_9.lv).next_id ~= 0 then
						local var_18_7 = self:getTargetLvCfg(iter_18_9.advId, iter_18_9.lv + 1)

						if var_18_7 and var_18_6:getStar() >= var_18_7.need then
							if var_18_7.num == 0 then
								return true
							end

							if g.core.model.User.bagData:getCountById(var_18_7.cost_type, var_18_7.cost_value) >= var_18_7.num then
								return true
							end
						end
					end
				end
			end
		end
	end

	return false
end

function ArtifactHandBookData:getAllCanActiveOrUpgradeHandBookList(arg_19_1)
	local var_19_0 = {}
	local var_19_1 = {}
	local var_19_2 = {}

	if arg_19_1 then
		for iter_19_0, iter_19_1 in pairs(self._URAdvIdLvMap) do
			local var_19_3 = self._activedURArtifact[iter_19_0] or 1
			local var_19_4 = self:isURArtifactActived(iter_19_0)
			local var_19_5 = g.core.model.User.artifactData:getArtifactByAdvacnceId(iter_19_0)
			local var_19_6 = self:getTargetURLvCfg(iter_19_0, var_19_3 + 1)
			local var_19_7 = self:getTargetURLvCfg(iter_19_0, var_19_4 and var_19_3 or 1).id
			local var_19_8 = false

			if not var_19_4 and var_19_5:isOwn() then
				table.insert(var_19_0, var_19_7)
				table.insert(var_19_2, var_19_7)

				var_19_8 = true
			end

			if checkbool(var_19_6) and not var_19_8 and var_19_5:getStar() >= var_19_6.need then
				table.insert(var_19_1, var_19_7)
				table.insert(var_19_2, var_19_7)
			end
		end
	else
		for iter_19_2, iter_19_3 in pairs(self._groupMap) do
			for iter_19_4, iter_19_5 in ipairs(iter_19_3) do
				local var_19_9 = false

				for iter_19_6, iter_19_7 in ipairs(iter_19_5.artifacts) do
					local var_19_10, var_19_11 = g.core.model.User.artifactData:hasArtifactByAdvanceId(iter_19_7.id)

					if not iter_19_7.isActive and var_19_10 and g.core.config.artifact_info.get(iter_19_7.id).put ~= 0 then
						table.insert(var_19_0, iter_19_7.id)
						table.insert(var_19_2, iter_19_7.id)
					end

					if iter_19_7.lv and iter_19_7.lv > 0 then
						local var_19_12 = self:getTargetLvCfg(iter_19_7.advId, iter_19_7.lv)

						if var_19_12.next_id ~= 0 then
							local var_19_13 = self:getTargetLvCfg(iter_19_7.advId, iter_19_7.lv + 1)

							if var_19_13 and var_19_11:getStar() >= var_19_13.need then
								table.insert(var_19_1, var_19_12.id)
								table.insert(var_19_2, var_19_12.id)

								var_19_9 = true
							end
						end
					end
				end

				if not iter_19_5.isActive then
					local var_19_14 = true

					for iter_19_8, iter_19_9 in ipairs(iter_19_5.artifacts) do
						local var_19_15, var_19_16 = g.core.model.User.artifactData:hasArtifactByAdvanceId(iter_19_9.id)

						if iter_19_9.isActive or not iter_19_9.isActive and var_19_15 and g.core.config.artifact_info.get(iter_19_9.id).put ~= 0 then
							-- block empty
						else
							var_19_14 = false
						end
					end

					if var_19_14 then
						table.insert(var_19_0, iter_19_5.info.id)
						table.insert(var_19_2, iter_19_5.info.id)
					end
				end

				if iter_19_5.lv and iter_19_5.lv > 0 then
					local var_19_17 = self:getTargetLvCfg(iter_19_5.advId, iter_19_5.lv)

					if var_19_17.next_id ~= 0 and (iter_19_5.childLv >= self:getTargetLvCfg(iter_19_5.advId, iter_19_5.lv + 1).need or var_19_9) then
						table.insert(var_19_1, var_19_17.id)
						table.insert(var_19_2, var_19_17.id)
					end
				end
			end
		end
	end

	return var_19_0, var_19_1, var_19_2
end

function ArtifactHandBookData:getAllCanActiveOrUpgradeHandBookCostData()
	local var_20_0 = {
		size = 0,
		type = g.core.common.Goods.TYPE_RESOURCE,
		value = g.core.common.Goods.RESOURCE.TYPE_COIN
	}

	local function var_20_2(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4)
		arg_21_3 = arg_21_3 or 0

		if self:getTargetLvCfg(arg_21_0, arg_21_1).next_id ~= 0 then
			local var_21_0 = self:getTargetLvCfg(arg_21_0, arg_21_1 + 1)

			if arg_21_2 >= var_21_0.need then
				arg_21_4 = not arg_21_4 and var_21_0.num or math.min(arg_21_4, var_21_0.num)
				arg_21_3, arg_21_4 = var_20_2(arg_21_0, arg_21_1 + 1, arg_21_2, arg_21_3 + var_21_0.num, arg_21_4)
			end
		end

		return arg_21_3, arg_21_4
	end

	for iter_20_0, iter_20_1 in pairs(self._groupMap) do
		for iter_20_2, iter_20_3 in ipairs(iter_20_1) do
			if not iter_20_3.isActive and iter_20_3.canActive then
				var_20_0.minSize = 0
				var_20_0.size, var_20_0.minSize = var_20_2(iter_20_3.advId, 1, iter_20_3.childLv, var_20_0.size, var_20_0.minSize)
			end

			if iter_20_3.lv and iter_20_3.lv > 0 then
				var_20_0.size, var_20_0.minSize = var_20_2(iter_20_3.advId, iter_20_3.lv, iter_20_3.childLv, var_20_0.size, var_20_0.minSize)
			end

			for iter_20_4, iter_20_5 in ipairs(iter_20_3.artifacts) do
				local var_20_5, var_20_6 = g.core.model.User.artifactData:hasArtifactByAdvanceId(iter_20_5.id)
				local var_20_7 = g.core.config.artifact_info.get(iter_20_5.id)
				local var_20_8 = var_20_6:getStar()

				if not iter_20_5.isActive and var_20_5 and var_20_7.put ~= 0 then
					var_20_0.minSize = 0
					var_20_0.size, var_20_0.minSize = var_20_2(iter_20_5.advId, 1, var_20_8, var_20_0.size, var_20_0.minSize)
				end

				if iter_20_5.lv and iter_20_5.lv > 0 then
					var_20_0.size, var_20_0.minSize = var_20_2(iter_20_5.advId, iter_20_5.lv, var_20_8, var_20_0.size, var_20_0.minSize)
				end
			end
		end
	end

	return var_20_0
end

function ArtifactHandBookData:updateURHandBook(arg_22_1)
	self._activedURArtifact = {}

	for iter_22_0, iter_22_1 in ipairs(arg_22_1.hb or {}) do
		self._activedURArtifact[var_0_1.get(iter_22_1.id).advance_code] = iter_22_1.level
	end

	self:updateURHandBookScoreAndLevel()
end

function ArtifactHandBookData:activeURHandBook(arg_23_1)
	local var_23_0 = var_0_1.get(arg_23_1.id)

	self._activedURArtifact[var_23_0.advance_code] = var_23_0.level

	self:updateURHandBookScoreAndLevel()
end

function ArtifactHandBookData:lvUpURHandBook(arg_24_1)
	local var_24_0 = var_0_1.get(arg_24_1.new_id)

	self._activedURArtifact[var_24_0.advance_code] = var_24_0.level

	self:updateURHandBookScoreAndLevel()
end

function ArtifactHandBookData:updateURHandBookScoreAndLevel()
	self._URHandBookScore = self:getTotalActiveURHandBookScore()
	self._URHandBookLevel = 0

	for iter_25_0 = 1, var_0_0.getLength() do
		if self._URHandBookScore >= var_0_0.get(iter_25_0).score then
			self._URHandBookLevel = iter_25_0
		end
	end
end

function ArtifactHandBookData:getURHandBook()
	local var_26_0 = {}

	for iter_26_0, iter_26_1 in pairs(self._URAdvIdLvMap) do
		local var_26_1 = self._activedURArtifact[iter_26_0] or 1
		local var_26_2 = self:isURArtifactActived(iter_26_0)
		local var_26_3 = g.core.model.User.artifactData:getArtifactByAdvacnceId(iter_26_0)
		local var_26_4 = self:getTargetURLvCfg(iter_26_0, var_26_1 + 1)
		local var_26_5 = not checkbool(var_26_4)

		if var_26_3:isPut() then
			local var_26_8 = var_26_0
			local var_26_9 = {}

			var_26_9.info = var_26_2 and self:getTargetURLvCfg(iter_26_0, var_26_1) or self:getTargetURLvCfg(iter_26_0, 1)
			var_26_9.advId = iter_26_0
			var_26_9.isMax = var_26_5
			var_26_9.isActive = var_26_2
			var_26_9.canActive = not var_26_2 and var_26_3:isOwn()
			var_26_9.quality = var_26_3:getQuality()
			var_26_9.canLvUp = (not var_26_5 or false) and var_26_3:getStar() >= var_26_4.need and g.core.model.User.bagData:getCountById(var_26_4.cost_type, var_26_4.cost_value) >= var_26_4.num
			var_26_9.level = self._activedURArtifact[iter_26_0] or 0
			var_26_9.struct = var_26_3

			table.insert(var_26_8, var_26_9)
		end
	end

	table.sort(var_26_0, function(arg_27_0, arg_27_1)
		if arg_27_0.canActive ~= arg_27_1.canActive then
			return arg_27_0.canActive
		end

		if arg_27_0.isActive ~= arg_27_1.isActive then
			return arg_27_0.isActive
		end

		if arg_27_0.canLvUp ~= arg_27_1.canLvUp then
			return arg_27_0.canLvUp
		end

		if arg_27_0.quality ~= arg_27_1.quality then
			return arg_27_0.quality > arg_27_1.quality
		end

		if arg_27_0.info.sort ~= arg_27_1.info.sort then
			return arg_27_0.info.sort > arg_27_1.info.sort
		end

		return arg_27_0.advId < arg_27_1.advId
	end)

	return var_26_0
end

function ArtifactHandBookData:getTargetURHandBookLvAttr(arg_28_1, arg_28_2)
	local var_28_0 = self._activedURArtifact[arg_28_1] or 0
	local var_28_1 = {}
	local var_28_2 = 0

	for iter_28_0, iter_28_1 in pairs(self._URAdvIdLvMap[arg_28_1]) do
		if var_28_0 >= iter_28_1.level then
			var_28_2 = var_28_2 + iter_28_1.score

			for iter_28_2 = 1, 4 do
				if iter_28_1["affect_type_" .. iter_28_2] > 0 then
					var_28_1[iter_28_1["affect_type_" .. iter_28_2]] = var_28_1[iter_28_1["affect_type_" .. iter_28_2]] or 0
					var_28_1[iter_28_1["affect_type_" .. iter_28_2]] = var_28_1[iter_28_1["affect_type_" .. iter_28_2]] + iter_28_1["affect_value_" .. iter_28_2]
				end
			end
		end
	end

	local var_28_4 = 0
	local var_28_5 = {}

	if arg_28_2 then
		local var_28_6 = self:getTargetURLvCfg(arg_28_1, var_28_0 + 1)

		var_28_4 = var_28_6 and var_28_6.score or 0

		if var_28_6 then
			for iter_28_3 = 1, 4 do
				if var_28_6["affect_type_" .. iter_28_3] > 0 then
					var_28_5[var_28_6["affect_type_" .. iter_28_3]] = var_28_5[var_28_6["affect_type_" .. iter_28_3]] or 0
					var_28_1[var_28_6["affect_type_" .. iter_28_3]] = var_28_1[var_28_6["affect_type_" .. iter_28_3]] or 0
					var_28_5[var_28_6["affect_type_" .. iter_28_3]] = var_28_5[var_28_6["affect_type_" .. iter_28_3]] + var_28_6["affect_value_" .. iter_28_3]
				end
			end
		end
	end

	local var_28_7 = {}

	for iter_28_4, iter_28_5 in pairs(var_28_1) do
		local var_28_8, var_28_9 = g.core.lang:getAttr(iter_28_4, iter_28_5, true)
		local var_28_11, var_28_12 = g.core.lang:getAttr(iter_28_4, iter_28_5 + (var_28_5[iter_28_4] or 0), true)

		table.insert(var_28_7, {
			isAll = true,
			name = var_28_8,
			value1 = var_28_9,
			value2 = var_28_12,
			icon = g.core.common.Path:getAttrIcon(iter_28_4)
		})
	end

	table.insert(var_28_7, {
		iconScale = 1,
		icon = "ui://base_new/icon_tujianzhi",
		name = g.core.lang:get(205561),
		value1 = var_28_2,
		value2 = var_28_2 + var_28_4
	})

	return var_28_7
end

function ArtifactHandBookData:getURHandBookLevelAllScore(arg_29_1, arg_29_2)
	local var_29_0 = 0

	for iter_29_0 = 1, arg_29_2 do
		local var_29_1 = self:getTargetURLvCfg(arg_29_1, iter_29_0)

		if var_29_1 then
			var_29_0 = var_29_0 + var_29_1.score
		end
	end

	return var_29_0
end

function ArtifactHandBookData:getURHandBookLevelAllAttr(arg_30_1, arg_30_2)
	local var_30_0 = {}

	for iter_30_0 = 1, arg_30_2 do
		local var_30_1 = self:getTargetURLvCfg(arg_30_1, iter_30_0)

		if var_30_1 then
			var_30_0[var_30_1.affect_type_1] = (var_30_0[var_30_1.affect_type_1] or 0) + var_30_1.affect_value_1
			var_30_0[var_30_1.affect_type_2] = (var_30_0[var_30_1.affect_type_2] or 0) + var_30_1.affect_value_2
			var_30_0[var_30_1.affect_type_3] = (var_30_0[var_30_1.affect_type_3] or 0) + var_30_1.affect_value_3
			var_30_0[var_30_1.affect_type_4] = (var_30_0[var_30_1.affect_type_4] or 0) + var_30_1.affect_value_4
		end
	end

	return var_30_0
end

function ArtifactHandBookData:isURHandBookCanLvUp(arg_31_1)
	local var_31_0 = self._activedURArtifact[arg_31_1] or 0
	local var_31_1 = g.core.model.User.artifactData:getArtifactByAdvacnceId(arg_31_1)

	if not var_31_1 then
		return false
	end

	if not var_31_1:isOwn() then
		return false
	end

	local var_31_2 = self:getTargetURLvCfg(arg_31_1, var_31_0 + 1)

	if var_31_2 then
		if var_31_2.need >= var_31_1:getStar() then
			return false
		end

		if var_31_2.num == 0 then
			return true
		end

		if g.core.model.User.bagData:getCountById(var_31_2.cost_type, var_31_2.cost_value) >= var_31_2.num then
			return true
		end
	end

	return false
end

function ArtifactHandBookData:getAllURBookLvAttrAddition()
	local var_32_0 = {}

	for iter_32_0 = 1, math.min(var_0_0.getLength(), self._URHandBookLevel) do
		local var_32_1 = var_0_0.get(iter_32_0)

		for iter_32_1 = 1, 4 do
			if var_32_1["affect_type_" .. iter_32_1] ~= 0 then
				var_32_0[var_32_1["affect_type_" .. iter_32_1]] = not var_32_0[var_32_1["affect_type_" .. iter_32_1]] and var_32_1["affect_value_" .. iter_32_1] or var_32_0[var_32_1["affect_type_" .. iter_32_1]] + var_32_1["affect_value_" .. iter_32_1]
			end
		end
	end

	local var_32_2 = {}

	for iter_32_2, iter_32_3 in pairs(var_32_0) do
		table.insert(var_32_2, {
			isAll = true,
			type = iter_32_2,
			value = iter_32_3
		})
	end

	return var_32_2
end

function ArtifactHandBookData:getURBookAttrAddition(arg_33_1)
	local var_33_0 = var_0_0.get(arg_33_1)
	local var_33_1 = {}

	for iter_33_0 = 1, 4 do
		if var_33_0["affect_type_" .. iter_33_0] ~= 0 then
			table.insert(var_33_1, {
				isAll = true,
				type = var_33_0["affect_type_" .. iter_33_0],
				value = var_33_0["affect_value_" .. iter_33_0]
			})
		end
	end

	return var_33_1
end

function ArtifactHandBookData:getURBookChangeAddition(arg_34_1, arg_34_2)
	if arg_34_2 <= arg_34_1 then
		return {}
	end

	local var_34_0 = {}

	for iter_34_0 = arg_34_1 + 1, arg_34_2 do
		local var_34_1 = var_0_0.get(iter_34_0)

		for iter_34_1 = 1, 4 do
			if var_34_1["affect_type_" .. iter_34_1] ~= 0 then
				var_34_0[var_34_1["affect_type_" .. iter_34_1]] = not var_34_0[var_34_1["affect_type_" .. iter_34_1]] and var_34_1["affect_value_" .. iter_34_1] or var_34_0[var_34_1["affect_type_" .. iter_34_1]] + var_34_1["affect_value_" .. iter_34_1]
			end
		end
	end

	local var_34_2 = {}

	for iter_34_2, iter_34_3 in pairs(var_34_0) do
		table.insert(var_34_2, {
			isAll = true,
			type = iter_34_2,
			value = iter_34_3
		})
	end

	return var_34_2
end

function ArtifactHandBookData:getURArtifactActiveLv(arg_35_1)
	return self._activedURArtifact[arg_35_1] or 0
end

function ArtifactHandBookData:isURArtifactActived(arg_36_1)
	return checkbool(self._activedURArtifact[arg_36_1])
end

function ArtifactHandBookData:getArtifactCurScoreInfo(arg_37_1)
	local var_37_0 = arg_37_1 or self:getURHandBookScore()
	local var_37_1 = var_0_0.getLength()

	for iter_37_0 = 1, var_37_1 do
		if var_37_0 < var_0_0.indexOf(iter_37_0).score then
			if iter_37_0 > 1 then
				return var_0_0.indexOf(iter_37_0 - 1)
			else
				return nil
			end
		end
	end

	return var_0_0.indexOf(var_37_1)
end

function ArtifactHandBookData:getArtifactChangeAttrs(arg_38_1, arg_38_2)
	local var_38_0 = var_0_0.getLength()

	arg_38_2 = arg_38_2 < var_38_0 and arg_38_2 or var_38_0

	local var_38_1 = {}

	for iter_38_0 = arg_38_1 + 1, arg_38_2 do
		local var_38_2 = var_0_0.indexOf(iter_38_0)

		for iter_38_1 = 1, 2 do
			var_38_1[var_38_2["affect_type_" .. iter_38_1]] = not var_38_1[var_38_2["affect_type_" .. iter_38_1]] and var_38_2["affect_value_" .. iter_38_1] or var_38_1[var_38_2["affect_type_" .. iter_38_1]] + var_38_2["affect_value_" .. iter_38_1]
		end
	end

	return var_38_1
end

function ArtifactHandBookData:getTotalURHandBookAttr()
	local var_39_0 = {}

	for iter_39_0, iter_39_1 in pairs(self._URHandBook) do
		if self._activedURArtifact[iter_39_1.advance_code] and self._activedURArtifact[iter_39_1.advance_code] >= iter_39_1.level then
			for iter_39_2 = 1, 4 do
				if iter_39_1["affect_type_" .. iter_39_2] > 0 then
					var_39_0[iter_39_1["affect_type_" .. iter_39_2]] = var_39_0[iter_39_1["affect_type_" .. iter_39_2]] or 0
					var_39_0[iter_39_1["affect_type_" .. iter_39_2]] = var_39_0[iter_39_1["affect_type_" .. iter_39_2]] + iter_39_1["affect_value_" .. iter_39_2]
				end
			end
		end
	end

	local var_39_1 = {}

	for iter_39_3, iter_39_4 in pairs(var_39_0) do
		table.insert(var_39_1, {
			type = iter_39_3,
			value = iter_39_4
		})
	end

	return var_39_1
end

function ArtifactHandBookData:getNextLvHandBookCfg()
	return var_0_0.fetch(self._URHandBookLevel + 1)
end

function ArtifactHandBookData:getTotalActiveURHandBookScore()
	local var_41_0 = 0

	for iter_41_0, iter_41_1 in pairs(self._URHandBook) do
		if self._activedURArtifact[iter_41_1.advance_code] and self._activedURArtifact[iter_41_1.advance_code] >= iter_41_1.level then
			var_41_0 = var_41_0 + iter_41_1.score
		end
	end

	return var_41_0
end

function ArtifactHandBookData:getCurAndNextScoreInfo()
	local var_42_0 = self:getURHandBookScore()
	local var_42_1 = var_0_0.getLength()

	for iter_42_0 = 1, var_42_1 do
		local var_42_2 = var_0_0.indexOf(iter_42_0)

		if var_42_0 < var_42_2.score then
			return {
				cur = (iter_42_0 > 1 and iter_42_0 ~= var_42_1 or nil) and var_0_0.indexOf(iter_42_0 - 1),
				next = var_42_2
			}
		end
	end

	return {
		cur = var_0_0.indexOf(var_42_1)
	}
end

function ArtifactHandBookData:getTotalURArtifactBookAttr()
	local var_43_0 = {}

	for iter_43_0, iter_43_1 in pairs(self._URHandBook) do
		if self._activedURArtifact[iter_43_1.advance_code] and self._activedURArtifact[iter_43_1.advance_code] > 0 and self._activedURArtifact[iter_43_1.advance_code] >= iter_43_1.level then
			var_43_0[iter_43_1.affect_type_1] = var_43_0[iter_43_1.affect_type_1] or 0
			var_43_0[iter_43_1.affect_type_2] = var_43_0[iter_43_1.affect_type_2] or 0
			var_43_0[iter_43_1.affect_type_3] = var_43_0[iter_43_1.affect_type_3] or 0
			var_43_0[iter_43_1.affect_type_4] = var_43_0[iter_43_1.affect_type_4] or 0
			var_43_0[iter_43_1.affect_type_1] = var_43_0[iter_43_1.affect_type_1] + iter_43_1.affect_value_1
			var_43_0[iter_43_1.affect_type_2] = var_43_0[iter_43_1.affect_type_2] + iter_43_1.affect_value_2
			var_43_0[iter_43_1.affect_type_3] = var_43_0[iter_43_1.affect_type_3] + iter_43_1.affect_value_3
			var_43_0[iter_43_1.affect_type_4] = var_43_0[iter_43_1.affect_type_4] + iter_43_1.affect_value_4
		end
	end

	local var_43_1 = {}

	for iter_43_2, iter_43_3 in pairs(var_43_0) do
		table.insert(var_43_1, {
			attrId = iter_43_2,
			attrValue = iter_43_3
		})
	end

	table.sort(var_43_1, function(arg_44_0, arg_44_1)
		if arg_44_0.attrId == 2 ~= (arg_44_1.attrId == 2) then
			return arg_44_0.attrId == 2
		end

		if arg_44_0.attrId ~= arg_44_1.attrId then
			return arg_44_0.attrId < arg_44_1.attrId
		end
	end)

	return var_43_1
end

function ArtifactHandBookData:getTotalBookActivateAttr()
	local var_45_0 = {}
	local var_45_1 = {}
	local var_45_2 = 0
	local var_45_3 = self:getURHandBookScore()

	for iter_45_0 = 1, var_0_0.getLength() do
		local var_45_4 = var_0_0.indexOf(iter_45_0)

		if var_45_3 >= var_45_4.score then
			for iter_45_1 = 1, 4 do
				if var_45_4["affect_type_" .. iter_45_1] > 0 then
					if var_45_1[var_45_4["affect_type_" .. iter_45_1]] == nil then
						var_45_2 = var_45_2 + 1
						var_45_1[var_45_4["affect_type_" .. iter_45_1]] = var_45_2
						var_45_0[var_45_2] = {
							attrId = var_45_4["affect_type_" .. iter_45_1],
							attrValue = var_45_4["affect_value_" .. iter_45_1]
						}
					else
						var_45_0[var_45_1[var_45_4["affect_type_" .. iter_45_1]]].attrValue = var_45_0[var_45_1[var_45_4["affect_type_" .. iter_45_1]]].attrValue + var_45_4["affect_value_" .. iter_45_1]
					end
				end
			end
		else
			break
		end
	end

	table.sort(var_45_0, function(arg_46_0, arg_46_1)
		if arg_46_0.attrId == 2 ~= (arg_46_1.attrId == 2) then
			return arg_46_0.attrId == 2
		end

		if arg_46_0.attrId ~= arg_46_1.attrId then
			return arg_46_0.attrId < arg_46_1.attrId
		end
	end)

	return var_45_0
end

function ArtifactHandBookData:getTargetURLvCfg(arg_47_1, arg_47_2)
	if self._URAdvIdLvMap[arg_47_1] then
		return self._URAdvIdLvMap[arg_47_1][arg_47_2]
	end

	return nil
end

function ArtifactHandBookData:getURHandBookLv()
	return self._URHandBookLevel
end

function ArtifactHandBookData:getURHandBookScore()
	return self._URHandBookScore
end

function ArtifactHandBookData:isHasHandBookCanLvUp()
	for iter_50_0, iter_50_1 in pairs(self._URAdvIdLvMap) do
		local var_50_0, var_50_1, var_50_2, var_50_3, var_50_4

		if not self._activedURArtifact[iter_50_0] then
			var_50_0 = 1
			var_50_1 = g.core.model.User.artifactData:getArtifactByAdvacnceId(iter_50_0)
			var_50_2 = self:getTargetURLvCfg(iter_50_0, self._activedURArtifact[iter_50_0] + 1)
			var_50_3 = false
			var_50_4 = (not not checkbool(var_50_2) or false) and var_50_1:getStar() >= var_50_2.need and g.core.model.User.bagData:getCountById(var_50_2.cost_type, var_50_2.cost_value) >= var_50_2.num
		end

		if not self:isURArtifactActived(iter_50_0) and var_50_1:isOwn() then
			return true
		end

		if var_50_4 then
			return var_50_4
		end
	end

	return false
end

function ArtifactHandBookData:hasURArtifactPut()
	local var_51_0 = g.core.const.ConstMgr.QUALITY_TYPE

	return #g.core.model.User.artifactData:getSpList(function(arg_52_0)
		return arg_52_0:getQuality() >= var_51_0.UR and arg_52_0:isPut()
	end, false, true) > 0
end

return ArtifactHandBookData

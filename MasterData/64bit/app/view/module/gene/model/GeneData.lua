local var_0_0 = g.core.config.gene_info
local var_0_1 = g.core.config.gene_segment_info
local var_0_2 = g.core.config.gene_segment_cost_info
local var_0_3 = g.core.config.gene_segment_attribute_info
local var_0_4 = g.core.config.talent_skill_info
local var_0_5 = g.core.model.User.bagData
local GeneData = class("GeneData")

function GeneData:ctor()
	self:initData()
end

function GeneData:initData()
	self._srvGeneInfoMap = {}
	self._geneFragsArr = {}
	self._fragCntMap = {}
	self._swapInfo = nil
	self._preGeneAttrMap = nil
	self._changeErrCnt = 0
	self._totalAttrInfo = {}

	self:_initGeneInfo()
end

function GeneData:_initGeneInfo()
	for iter_3_0, iter_3_1 in var_0_1.ipairs() do
		if not self._geneFragsArr[iter_3_1.gene_id] then
			self._geneFragsArr[iter_3_1.gene_id] = {}

			local var_3_0 = self:getGeneLen(iter_3_1.gene_id)

			for iter_3_2 = 1, var_3_0 do
				self._geneFragsArr[iter_3_1.gene_id][iter_3_2] = {}

				for iter_3_3 = 1, var_3_0 do
					self._geneFragsArr[iter_3_1.gene_id][iter_3_2][iter_3_3] = {}
				end
			end
		end

		self._geneFragsArr[iter_3_1.gene_id][iter_3_1.location_x][iter_3_1.location_y] = {
			activated = false,
			id = iter_3_1.id
		}
		self._fragCntMap[iter_3_1.gene_id] = self._fragCntMap[iter_3_1.gene_id] or 0
		self._fragCntMap[iter_3_1.gene_id] = self._fragCntMap[iter_3_1.gene_id] + 1
	end

	for iter_3_4, iter_3_5 in var_0_0.ipairs() do
		self._srvGeneInfoMap[iter_3_5.id] = {
			is_activate = false,
			base_id = iter_3_5.id,
			segments = {}
		}
	end
end

function GeneData:onS2CGeneGetInfo(arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(arg_4_1.genes or {}) do
		for iter_4_2, iter_4_3 in ipairs(iter_4_1.segments) do
			self._geneFragsArr[iter_4_1.base_id][iter_4_3.x][iter_4_3.y] = {
				activated = true,
				id = iter_4_3.base_id
			}
		end

		self._srvGeneInfoMap[iter_4_1.base_id] = iter_4_1
	end
end

function GeneData:onS2CFlushRedPoint(arg_5_1)
	if arg_5_1 then
		for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
			for iter_5_2, iter_5_3 in ipairs(iter_5_1.segments) do
				self._geneFragsArr[iter_5_1.base_id][iter_5_3.x][iter_5_3.y] = {
					activated = true,
					id = iter_5_3.base_id
				}
			end

			self._srvGeneInfoMap[iter_5_1.base_id] = iter_5_1
		end
	end
end

function GeneData:onS2CGeneActivateSegment(arg_6_1)
	local var_6_0 = var_0_1.get(arg_6_1.base_id)

	if not var_6_0 then
		return
	end

	local var_6_1 = var_6_0.gene_id
	local var_6_2 = self:getGeneLen(var_6_0.gene_id)
	local var_6_3

	for iter_6_0 = 1, var_6_2 do
		for iter_6_1 = 1, var_6_2 do
			if self._geneFragsArr[var_6_0.gene_id][iter_6_0][iter_6_1] and self._geneFragsArr[var_6_0.gene_id][iter_6_0][iter_6_1].id == arg_6_1.base_id then
				self._geneFragsArr[var_6_0.gene_id][iter_6_0][iter_6_1].activated = true
				var_6_3 = {
					base_id = arg_6_1.base_id,
					x = iter_6_0,
					y = iter_6_1
				}

				break
			end
		end

		if var_6_3 ~= nil then
			break
		end
	end

	table.insert(self._srvGeneInfoMap[var_6_1].segments, var_6_3)
end

function GeneData:onS2CGeneActivateMap(arg_7_1)
	if self._srvGeneInfoMap[arg_7_1.base_id] then
		self._srvGeneInfoMap[arg_7_1.base_id].is_activate = true
	end
end

function GeneData:onS2CGeneChangePosition(arg_8_1)
	local var_8_0 = var_0_1.get(arg_8_1.base_id1)
	local var_8_1 = var_0_1.get(arg_8_1.base_id2)

	if not var_8_0 or not var_8_1 then
		return
	end

	local var_8_2 = var_8_0.gene_id

	if self._srvGeneInfoMap[var_8_0.gene_id] then
		for iter_8_0, iter_8_1 in ipairs(self._srvGeneInfoMap[var_8_0.gene_id].segments) do
			if iter_8_1.base_id == arg_8_1.base_id1 then
				iter_8_1.base_id = arg_8_1.base_id2

				if self._geneFragsArr[var_8_0.gene_id] then
					self._geneFragsArr[var_8_0.gene_id][iter_8_1.x][iter_8_1.y].id = arg_8_1.base_id2
				end

				break
			end
		end
	end

	if var_8_2 ~= var_8_1.gene_id then
		if self._srvGeneInfoMap[var_8_1.gene_id] then
			for iter_8_2, iter_8_3 in ipairs(self._srvGeneInfoMap[var_8_1.gene_id].segments) do
				if iter_8_3.base_id == arg_8_1.base_id2 then
					iter_8_3.base_id = arg_8_1.base_id1

					if self._geneFragsArr[var_8_1.gene_id] then
						self._geneFragsArr[var_8_1.gene_id][iter_8_3.x][iter_8_3.y].id = arg_8_1.base_id1
					end

					break
				end
			end
		end
	elseif self._srvGeneInfoMap[var_8_0.gene_id] then
		for iter_8_4, iter_8_5 in ipairs(self._srvGeneInfoMap[var_8_0.gene_id].segments) do
			if iter_8_5.base_id == arg_8_1.base_id2 then
				iter_8_5.base_id = arg_8_1.base_id1

				if self._geneFragsArr[var_8_0.gene_id] then
					self._geneFragsArr[var_8_0.gene_id][iter_8_5.x][iter_8_5.y].id = arg_8_1.base_id1
				end

				break
			end
		end
	end
end

function GeneData:getGeneLen(arg_9_1)
	return var_0_0.get(arg_9_1).gene_len
end

function GeneData:getNextGene(arg_10_1)
	return var_0_0.get(arg_10_1).next_id
end

function GeneData:getPreGene(arg_11_1)
	local var_11_0

	for iter_11_0, iter_11_1 in var_0_0.ipairs() do
		if iter_11_1.next_id == arg_11_1 then
			var_11_0 = iter_11_1.id
		end
	end

	return var_11_0
end

function GeneData:getGeneState(arg_12_1)
	if self._srvGeneInfoMap[arg_12_1].is_activate then
		return 2
	end

	local var_12_0 = self:getPreGene(arg_12_1)

	if var_12_0 == nil then
		return 1
	end

	if self._srvGeneInfoMap[var_12_0].is_activate then
		return 1
	end

	return 0
end

function GeneData:addChangeErrCnt()
	self._changeErrCnt = self._changeErrCnt + 1
end

function GeneData:getChangeErrCnt()
	return self._changeErrCnt
end

function GeneData:setSwapInfo(arg_15_1)
	self._swapInfo = arg_15_1
end

function GeneData:getSwapInfo()
	return self._swapInfo
end

function GeneData:setPreGeneAttr(arg_17_1)
	self._preGeneAttrMap = arg_17_1
end

function GeneData:getPreGeneAttr()
	return self._preGeneAttrMap
end

function GeneData:getGeneAttrChange(arg_19_1)
	if not self._preGeneAttrMap then
		return {}
	end

	local var_19_0 = self:getGeneAttr(arg_19_1)

	for iter_19_0, iter_19_1 in pairs(self._preGeneAttrMap) do
		var_19_0[iter_19_0] = var_19_0[iter_19_0] or 0
		var_19_0[iter_19_0] = var_19_0[iter_19_0] - (self._preGeneAttrMap[iter_19_0] or 0)
	end

	local var_19_1 = {}

	for iter_19_2, iter_19_3 in pairs(var_19_0) do
		if iter_19_3 ~= 0 then
			var_19_1[iter_19_2] = iter_19_3
		end
	end

	return var_19_1
end

function GeneData:getGeneSrvInfoById(arg_20_1)
	return self._srvGeneInfoMap[arg_20_1]
end

function GeneData:getGeneFragmentById(arg_21_1)
	return self._geneFragsArr[arg_21_1]
end

function GeneData:getGeneFragsCntById(arg_22_1)
	return self._fragCntMap[arg_22_1]
end

function GeneData:getActivatedFragsCnt(arg_23_1)
	return (self._srvGeneInfoMap[arg_23_1].segments or nil) and (#self._srvGeneInfoMap[arg_23_1].segments or 0)
end

function GeneData:getFragPos(arg_24_1, arg_24_2)
	for iter_24_0, iter_24_1 in ipairs(self._srvGeneInfoMap[arg_24_1].segments) do
		if iter_24_1.base_id == arg_24_2 then
			return {
				x = iter_24_1.x,
				y = iter_24_1.y
			}
		end
	end

	return nil
end

function GeneData:resetGeneFragsInfo(arg_25_1, arg_25_2, arg_25_3, arg_25_4)
	self._geneFragsArr[arg_25_1][arg_25_2][arg_25_3].id = arg_25_4
end

function GeneData:getFragActivatedState(arg_26_1, arg_26_2, arg_26_3)
	local var_26_0 = self._geneFragsArr[arg_26_1]

	if not self._geneFragsArr[arg_26_1][arg_26_2][arg_26_3].activated then
		return 0
	end

	local var_26_1 = self:getGeneLen(arg_26_1)
	local var_26_2 = 1

	local function var_26_3(arg_27_0, arg_27_1)
		if arg_27_0 < 1 or arg_27_0 > var_26_1 then
			return false
		end

		if arg_27_1 < 1 or arg_27_1 > var_26_1 then
			return false
		end

		if var_26_0[arg_27_0][arg_27_1] == nil then
			return false
		end

		if not var_26_0[arg_27_0][arg_27_1].activated then
			return false
		end

		return true
	end

	for iter_26_0 = 0, 2 do
		if var_26_3(arg_26_2 + iter_26_0, arg_26_3) and var_26_3(arg_26_2 + iter_26_0 - 1, arg_26_3) and var_26_3(arg_26_2 + iter_26_0 - 2, arg_26_3) then
			local var_26_4 = var_0_1.get(self._geneFragsArr[arg_26_1][arg_26_2 + iter_26_0][arg_26_3].id).type

			if var_26_4 == var_0_1.get(self._geneFragsArr[arg_26_1][arg_26_2 + iter_26_0 - 1][arg_26_3].id).type and var_26_4 == var_0_1.get(self._geneFragsArr[arg_26_1][arg_26_2 + iter_26_0 - 2][arg_26_3].id).type then
				var_26_2 = var_26_2 + 1

				break
			end
		end
	end

	for iter_26_1 = 0, 2 do
		if var_26_3(arg_26_2, arg_26_3 + iter_26_1) and var_26_3(arg_26_2, arg_26_3 + iter_26_1 - 1) and var_26_3(arg_26_2, arg_26_3 + iter_26_1 - 2) then
			local var_26_5 = var_0_1.get(self._geneFragsArr[arg_26_1][arg_26_2][arg_26_3 + iter_26_1].id).type

			if var_26_5 == var_0_1.get(self._geneFragsArr[arg_26_1][arg_26_2][arg_26_3 + iter_26_1 - 1].id).type and var_26_5 == var_0_1.get(self._geneFragsArr[arg_26_1][arg_26_2][arg_26_3 + iter_26_1 - 2].id).type then
				var_26_2 = var_26_2 + 1

				break
			end
		end
	end

	return var_26_2
end

function GeneData:getLinkedFrags(arg_28_1, arg_28_2)
	local var_28_0 = {}
	local var_28_1 = self:getFragPos(arg_28_1, arg_28_2)

	if not var_28_1 then
		return var_28_0
	end

	local var_28_2 = var_28_1.x

	if self:getFragActivatedState(arg_28_1, var_28_1.x, var_28_1.y) < 2 then
		return var_28_0
	end

	local var_28_3 = self._geneFragsArr[arg_28_1]
	local var_28_4 = var_0_1.get(arg_28_2).type
	local var_28_5 = self:getGeneLen(arg_28_1)

	for iter_28_0 = var_28_2, var_28_5 do
		if not var_28_3[iter_28_0][var_28_1.y].id then
			break
		end

		if not var_28_3[iter_28_0][var_28_1.y].activated then
			break
		end

		if var_28_4 == var_0_1.get(var_28_3[iter_28_0][var_28_1.y].id).type then
			var_28_0["frag" .. iter_28_0 .. "_" .. var_28_1.y] = {
				x = iter_28_0,
				y = var_28_1.y
			}
		else
			break
		end
	end

	for iter_28_1 = var_28_2, 1, -1 do
		if not var_28_3[iter_28_1][var_28_1.y].id then
			break
		end

		if not var_28_3[iter_28_1][var_28_1.y].activated then
			break
		end

		if var_28_4 == var_0_1.get(var_28_3[iter_28_1][var_28_1.y].id).type then
			var_28_0["frag" .. iter_28_1 .. "_" .. var_28_1.y] = {
				x = iter_28_1,
				y = var_28_1.y
			}
		else
			break
		end
	end

	for iter_28_2 = var_28_1.y, var_28_5 do
		if not var_28_3[var_28_2][iter_28_2].id then
			break
		end

		if not var_28_3[var_28_2][iter_28_2].activated then
			break
		end

		if var_28_4 == var_0_1.get(var_28_3[var_28_2][iter_28_2].id).type then
			var_28_0["frag" .. var_28_2 .. "_" .. iter_28_2] = {
				x = var_28_2,
				y = iter_28_2
			}
		else
			break
		end
	end

	for iter_28_3 = var_28_1.y, 1, -1 do
		if not var_28_3[var_28_2][iter_28_3].id then
			break
		end

		if not var_28_3[var_28_2][iter_28_3].activated then
			break
		end

		if var_28_4 == var_0_1.get(var_28_3[var_28_2][iter_28_3].id).type then
			var_28_0["frag" .. var_28_2 .. "_" .. iter_28_3] = {
				x = var_28_2,
				y = iter_28_3
			}
		else
			break
		end
	end

	return var_28_0
end

function GeneData:getFragAttr(arg_29_1, arg_29_2)
	for iter_29_0, iter_29_1 in var_0_3.ipairs() do
		if iter_29_1.gene_id == arg_29_1 and iter_29_1.type == arg_29_2 then
			return iter_29_1
		end
	end

	return nil
end

function GeneData:getActivateFragCostCfg(arg_30_1)
	local var_30_0 = self:getActivatedFragsCnt(arg_30_1)

	for iter_30_0, iter_30_1 in var_0_2.ipairs() do
		if iter_30_1.gene_id == arg_30_1 and iter_30_1.num == var_30_0 + 1 then
			return iter_30_1
		end
	end

	return nil
end

function GeneData:getGeneAttr(arg_31_1)
	local var_31_0 = {}
	local var_31_1 = self:getGeneLen(arg_31_1)

	for iter_31_0 = 1, var_31_1 do
		for iter_31_1 = 1, var_31_1 do
			if self._geneFragsArr[arg_31_1][iter_31_0][iter_31_1].id and self._geneFragsArr[arg_31_1][iter_31_0][iter_31_1].id > 0 then
				local var_31_2 = self:getFragActivatedState(arg_31_1, iter_31_0, iter_31_1)

				if var_31_2 > 0 then
					local var_31_3 = self:getFragAttr(arg_31_1, var_0_1.get(self._geneFragsArr[arg_31_1][iter_31_0][iter_31_1].id).type)

					var_31_0[var_31_3.attribute_type] = var_31_0[var_31_3.attribute_type] or 0
					var_31_0[var_31_3.attribute_type] = var_31_0[var_31_3.attribute_type] + var_31_3.attribute_value

					if var_31_2 >= 2 then
						var_31_0[var_31_3.attribute_1_type] = var_31_0[var_31_3.attribute_1_type] or 0
						var_31_0[var_31_3.attribute_1_type] = var_31_0[var_31_3.attribute_1_type] + var_31_3.attribute_1_value
					end

					if var_31_2 == 3 then
						var_31_0[var_31_3.attribute_2_type] = var_31_0[var_31_3.attribute_2_type] or 0
						var_31_0[var_31_3.attribute_2_type] = var_31_0[var_31_3.attribute_2_type] + var_31_3.attribute_2_value
					end
				end
			end
		end
	end

	return var_31_0
end

function GeneData:getGeneTalent(arg_32_1)
	if self:getGeneState(arg_32_1) ~= 2 then
		return {}
	end

	local var_32_0 = {}
	local var_32_1 = var_0_4.get(var_0_0.get(arg_32_1).gene_talent)

	if var_32_1.affect_type_1 > 0 then
		var_32_0[var_32_1.affect_type_1] = var_32_1.affect_value_1
	end

	if var_32_1.affect_type_2 > 0 then
		var_32_0[var_32_1.affect_type_2] = var_32_1.affect_value_2
	end

	if var_32_1.affect_type_3 > 0 then
		var_32_0[var_32_1.affect_type_3] = var_32_1.affect_value_3
	end

	return var_32_0
end

function GeneData:getGeneScore(arg_33_1)
	local var_33_0 = 0
	local var_33_1 = self:getGeneLen(arg_33_1)

	for iter_33_0 = 1, var_33_1 do
		for iter_33_1 = 1, var_33_1 do
			local var_33_2 = self:getFragActivatedState(arg_33_1, iter_33_0, iter_33_1)

			if var_33_2 >= 1 then
				var_33_0 = var_33_0 + 1
			end

			if var_33_2 >= 2 then
				var_33_0 = var_33_0 + 3
			end

			if var_33_2 >= 3 then
				var_33_0 = var_33_0 + 12
			end
		end
	end

	return var_33_0
end

function GeneData:getGuideCond()
	return #self._srvGeneInfoMap[var_0_0.indexOf(1).id].segments == 0
end

function GeneData:canActivateFragById(arg_35_1)
	if self:getGeneState(arg_35_1) == 1 then
		local var_35_0 = self:getActivateFragCostCfg(arg_35_1)

		if var_35_0 and var_0_5:getOwnNum(var_35_0.material_1_type, var_35_0.material_1_value) >= var_35_0.material_1_size then
			return true
		end
	end

	return false
end

function GeneData:getTotalAttrInfo()
	self._totalAttrInfo = {}

	local var_36_0 = {}

	for iter_36_0, iter_36_1 in var_0_0.ipairs() do
		for iter_36_2, iter_36_3 in pairs((self:getGeneAttr(iter_36_1.id))) do
			var_36_0[iter_36_2] = var_36_0[iter_36_2] or 0
			var_36_0[iter_36_2] = var_36_0[iter_36_2] + iter_36_3
		end

		for iter_36_4, iter_36_5 in pairs((self:getGeneTalent(iter_36_1.id))) do
			var_36_0[iter_36_4] = var_36_0[iter_36_4] or 0
			var_36_0[iter_36_4] = var_36_0[iter_36_4] + iter_36_5
		end
	end

	for iter_36_6, iter_36_7 in pairs(var_36_0) do
		local var_36_1, var_36_2 = g.core.lang:getAttr(iter_36_6, iter_36_7, true)

		table.insert(self._totalAttrInfo, {
			name = var_36_1,
			value = var_36_2
		})
	end

	return self._totalAttrInfo
end

function GeneData:getCurGeneIndex()
	local var_37_0 = 1

	for iter_37_0, iter_37_1 in var_0_0.ipairs() do
		if self:getGeneState(iter_37_1.id) == 1 then
			var_37_0 = iter_37_0

			break
		end
	end

	return var_37_0
end

function GeneData:isFirstGeneSeqActivate(arg_38_1, arg_38_2)
	if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.GENE) and self:getFragActivatedState(1, arg_38_1, arg_38_2) == 0 then
		return true
	end

	return false
end

function GeneData:isFirstGeneActivate()
	if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.GENE) and self:getActivatedFragsCnt(1) == 0 then
		return true
	end

	return false
end

function GeneData:canActivateGeneById(arg_40_1)
	if self:getGeneState(arg_40_1) == 1 then
		local var_40_0 = var_0_0.get(arg_40_1)

		if self:getGeneFragsCntById(arg_40_1) == self:getActivatedFragsCnt(arg_40_1) and not self:getGeneSrvInfoById(arg_40_1).is_activate and var_0_5:getOwnNum(var_40_0.material_type, var_40_0.material_value) >= var_40_0.material_size then
			return true
		end
	end

	return false
end

function GeneData:canActivateFrag(arg_41_1)
	if arg_41_1 and arg_41_1.geneId then
		if self:canActivateFragById(arg_41_1 and arg_41_1.geneId) then
			return true
		end
	else
		for iter_41_0, iter_41_1 in var_0_0.ipairs() do
			if self:canActivateFragById(iter_41_1.id) then
				return true
			end
		end
	end

	return false
end

function GeneData:canActivateGene(arg_42_1)
	if arg_42_1 and arg_42_1.geneId then
		if self:canActivateGeneById(arg_42_1 and arg_42_1.geneId) then
			return true
		end
	else
		for iter_42_0, iter_42_1 in var_0_0.ipairs() do
			if self:canActivateGeneById(iter_42_1.id) then
				return true
			end
		end
	end

	return false
end

return GeneData

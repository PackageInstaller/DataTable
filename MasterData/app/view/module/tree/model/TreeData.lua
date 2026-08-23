local var_0_0 = g.core.const.ConstMgr.TreeConst
local TreeNodeStruct = require("app.view.module.tree.model.TreeNodeStruct")
local var_0_2 = g.core.config.tree_node_info
local var_0_3 = g.core.config.tree_level_info
local AstrolabeData = class("AstrolabeData")

function AstrolabeData:ctor()
	self:initData()
end

function AstrolabeData:initData()
	self._allNodeDict = {}
	self._moduleNodeDict = {}
	self._hasServerRedPoint = false

	self:_initCfg()
end

function AstrolabeData:_initCfg()
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in var_0_3.ipairs() do
		var_3_0[iter_3_1.group] = var_3_0[iter_3_1.group] or {}
		var_3_0[iter_3_1.group][iter_3_1.level] = iter_3_1
	end

	for iter_3_2, iter_3_3 in var_0_2.ipairs() do
		local var_3_1 = self:getNodeByAdvanceId(iter_3_3.advance_id, true)

		var_3_1:addInfo(iter_3_3)

		if iter_3_3.level_group > 0 then
			var_3_1:setLevelGroup(iter_3_3.node_stage, var_3_0[iter_3_3.level_group])
		end

		for iter_3_4 = 1, 3 do
			if iter_3_3["father_node_" .. iter_3_4] > 0 then
				local var_3_2 = self:getNodeByAdvanceId(iter_3_3["father_node_" .. iter_3_4], true)

				var_3_1:addParent(var_3_2)
				var_3_2:addChild(var_3_1)
			end
		end

		self._moduleNodeDict[iter_3_3.orientation] = self._moduleNodeDict[iter_3_3.orientation] or {}
		self._moduleNodeDict[iter_3_3.orientation][iter_3_3.advance_id] = var_3_1
	end
end

function AstrolabeData:getAllNode()
	return self._allNodeDict
end

function AstrolabeData:getNodeByAdvanceId(arg_5_1, arg_5_2)
	if arg_5_2 and not self._allNodeDict[arg_5_1] then
		self._allNodeDict[arg_5_1] = TreeNodeStruct.new(arg_5_1)
	end

	return self._allNodeDict[arg_5_1]
end

function AstrolabeData:getModuleNodeDict(arg_6_1)
	return self._moduleNodeDict[arg_6_1]
end

function AstrolabeData:onS2CGetInfo(arg_7_1)
	self._hasServerRedPoint = false

	for iter_7_0, iter_7_1 in ipairs(arg_7_1.tree_nodes or {}) do
		self:getNodeByAdvanceId(iter_7_1.advance_id):setNodeServerData(iter_7_1)
	end
end

function AstrolabeData:onS2CUpgradeStage(arg_8_1)
	self:getNodeByAdvanceId(arg_8_1.advance_id):setNodeServerData(arg_8_1.tree_node)
end

function AstrolabeData:onS2CUpgradeLevel(arg_9_1)
	self:getNodeByAdvanceId(arg_9_1.advance_id):setLevel(arg_9_1.target_level)
end

function AstrolabeData:getAllCenterAndBigNodeAttr(arg_10_1)
	local var_10_1 = {}

	for iter_10_0, iter_10_1 in pairs(arg_10_1 and (self:getModuleNodeDict(arg_10_1) or {}) or self._allNodeDict) do
		local var_10_2 = {}

		if iter_10_1:isLight() then
			if iter_10_1:getNodeType() == var_0_0.NODE_TYPE.CENTER then
				local var_10_3 = iter_10_1:getBonusInfo()

				if var_10_3 then
					var_10_2.struct = iter_10_1
					var_10_2.name = var_10_3.name
					var_10_2.type = iter_10_1:getNodeType()
					var_10_2.nodeName = iter_10_1:getInfo().node_name
					var_10_2.oricent = iter_10_1:getInfo().orientation
					var_10_2.baseAttr = var_10_3.basic_des
					var_10_2.extraAttr = var_10_3.extra_des
					var_10_2.isExtraCondition = iter_10_1:isFinishCondition()
					var_10_2.condDesc = g.core.lang:get(426518, {
						desc = var_10_3.extra_condition_des
					})

					table.insert(var_10_1, var_10_2)
				end
			elseif iter_10_1:getNodeType() == var_0_0.NODE_TYPE.BIG then
				local var_10_4 = iter_10_1:getInfo()

				var_10_2.struct = iter_10_1
				var_10_2.name = var_10_4.talent_name
				var_10_2.type = iter_10_1:getNodeType()
				var_10_2.nodeName = var_10_4.node_name
				var_10_2.oricent = var_10_4.orientation
				var_10_2.baseAttr = iter_10_1:getBigTalentAttrStr(var_10_4, false)
				var_10_2.extraAttr = iter_10_1:getBigTalentAttrStr(var_10_4, true)
				var_10_2.isExtraCondition = iter_10_1:isFinishCondition()
				var_10_2.condDesc = g.core.lang:get(426518, {
					desc = iter_10_1:getInfo().condition_des
				})

				table.insert(var_10_1, var_10_2)
			end
		end
	end

	if var_10_1 and next(var_10_1) then
		table.sort(var_10_1, function(arg_11_0, arg_11_1)
			if arg_11_0.type ~= arg_11_1.type then
				return arg_11_0.type > arg_11_1.type
			else
				return arg_11_0.struct:getAdvanceId() < arg_11_1.struct:getAdvanceId()
			end
		end)
	end

	return var_10_1
end

function AstrolabeData:getAllSmallNodeBaseAttr()
	local var_12_0 = {}

	for iter_12_0, iter_12_1 in pairs(self._allNodeDict) do
		if iter_12_1:getNodeType() == var_0_0.NODE_TYPE.SMALL then
			for iter_12_2, iter_12_3 in pairs((iter_12_1:getLevelAttrDict())) do
				var_12_0[iter_12_2] = var_12_0[iter_12_2] or 0
				var_12_0[iter_12_2] = var_12_0[iter_12_2] + iter_12_3
			end
		end
	end

	return var_12_0
end

function AstrolabeData:getSmallNodeBaseAttrByOrientation(arg_13_1)
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in pairs(self._allNodeDict) do
		if iter_13_1:getNodeType() == var_0_0.NODE_TYPE.SMALL and iter_13_1:getInfo().orientation == arg_13_1 then
			for iter_13_2, iter_13_3 in pairs((iter_13_1:getLevelAttrDict())) do
				var_13_0[iter_13_2] = var_13_0[iter_13_2] or 0
				var_13_0[iter_13_2] = var_13_0[iter_13_2] + iter_13_3
			end
		end
	end

	local var_13_1 = {}

	for iter_13_4, iter_13_5 in pairs(var_13_0) do
		table.insert(var_13_1, {
			type = iter_13_4,
			value = iter_13_5
		})
	end

	return var_13_1
end

function AstrolabeData:getCenterAndBigNodeAttrByType(arg_14_1)
	return (self:getAllCenterAndBigNodeAttr(arg_14_1))
end

function AstrolabeData:getAllSmallNodeNumAttr()
	local var_15_0 = {}

	for iter_15_0, iter_15_1 in pairs((self:getAllSmallNodeBaseAttr())) do
		local var_15_1 = g.core.config.attribute_info.get(iter_15_0)

		if var_15_1.value_format == 1 then
			table.insert(var_15_0, {
				id = var_15_1.id,
				type = iter_15_0,
				value = iter_15_1
			})
		end
	end

	if var_15_0 and next(var_15_0) then
		table.sort(var_15_0, function(arg_16_0, arg_16_1)
			return arg_16_0.id < arg_16_1.id
		end)
	end

	return var_15_0
end

function AstrolabeData:getAllSmallNodePercentAttr()
	local var_17_0 = {}

	for iter_17_0, iter_17_1 in pairs((self:getAllSmallNodeBaseAttr())) do
		local var_17_1 = g.core.config.attribute_info.get(iter_17_0)

		if var_17_1.value_format == 2 then
			table.insert(var_17_0, {
				id = var_17_1.id,
				type = iter_17_0,
				value = iter_17_1
			})
		end
	end

	if var_17_0 and next(var_17_0) then
		table.sort(var_17_0, function(arg_18_0, arg_18_1)
			return arg_18_0.id < arg_18_1.id
		end)
	end

	return var_17_0
end

function AstrolabeData:hasNodeCanUpgrade(arg_19_1)
	if self._hasServerRedPoint then
		return true
	end

	local var_19_0 = arg_19_1.advId or 0

	if var_19_0 > 0 then
		local var_19_1 = self:getNodeByAdvanceId(var_19_0)

		return var_19_1:isCanUpgradeStage() or var_19_1:isCanUpgradeLevel()
	else
		for iter_19_0, iter_19_1 in pairs(self._allNodeDict) do
			if iter_19_1:isCanUpgradeStage() or iter_19_1:isCanUpgradeLevel() then
				return true
			end
		end
	end

	return false
end

function AstrolabeData:setRedPoint(arg_20_1)
	self._hasServerRedPoint = arg_20_1
end

return AstrolabeData

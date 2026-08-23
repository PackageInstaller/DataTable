local var_0_0 = g.core.config.tree_bonus_info
local var_0_1 = g.core.config.tree_node_info
local var_0_2 = g.core.const.ConstMgr.TreeConst
local TreeNodeConditionActiveComp = class("TreeNodeConditionActiveComp", require("app.fairyGUI.tree.UI_TreeNodeConditionActiveComp"))

function TreeNodeConditionActiveComp:ctor()
	self._nodeStruct = nil
	self._extraAttrList = {}

	self:initView()
end

function TreeNodeConditionActiveComp:initView()
	self.m_extraAttrList:setVirtual()
	self.m_extraAttrList:setItemRenderer(handler(self, self._onRenderExtraAttrList))
end

function TreeNodeConditionActiveComp:_onRenderExtraAttrList(arg_3_1, arg_3_2)
	arg_3_2:updateCell(self._extraAttrList[arg_3_1 + 1], self._nodeStruct:getNodeType() == var_0_2.NODE_TYPE.CENTER)
end

function TreeNodeConditionActiveComp:update(arg_4_1)
	local var_4_0 = arg_4_1.data or {}

	self._nodeStruct = arg_4_1.nodeStruct

	if not self._nodeStruct then
		return
	end

	self.m_nodeComp:updateNode(self._nodeStruct)
	self.m_extraName:setText(self._nodeStruct:getInfo().talent_name)

	if self._nodeStruct:getNodeType() == var_0_2.NODE_TYPE.BIG then
		self.m_isCenterController:setSelectedIndex(0)

		local var_4_1 = var_0_1.get(var_4_0.info_id)

		self._extraAttrList = {}

		local var_4_2 = {}

		self._nodeStruct:getExtraAttrDictByInfo(var_4_1, var_4_2, 0)

		local var_4_3 = {}

		self._nodeStruct:getExtraAttrDictByInfo(self._nodeStruct:getInfo(var_4_1.node_stage - 1), var_4_3, 0)

		for iter_4_0, iter_4_1 in pairs(var_4_2) do
			local var_4_4, var_4_5 = g.core.lang:getAttr(iter_4_0, iter_4_1, true)
			local var_4_7, var_4_8 = g.core.lang:getAttr(iter_4_0, var_4_3[iter_4_0] or 0, true)

			table.insert(self._extraAttrList, {
				desc = var_4_4,
				beforeValue = var_4_8,
				afterValue = var_4_5,
				hasNew = var_4_3[iter_4_0] == nil
			})
		end

		self.m_extraAttrList:setNumItems(#self._extraAttrList)
		self.m_extraAttrList:resizeToFit(#self._extraAttrList)
		self.m_extraTip:setText(g.core.lang:get(426519, {
			desc = var_4_1.condition_des
		}))
	else
		self.m_isCenterController:setSelectedIndex(1)

		local var_4_9 = var_4_0.cur_times or 1
		local var_4_10 = var_0_0.get(var_4_0.info_id)

		self._extraAttrList = {}

		local var_4_11 = {}

		self._nodeStruct:getExtraAttrDictByInfo(var_4_10, var_4_11, var_4_9)

		local var_4_12 = {}

		self._nodeStruct:getExtraAttrDictByInfo(var_4_10, var_4_12, var_4_9 - 1)

		for iter_4_2, iter_4_3 in pairs(var_4_11) do
			local var_4_13, var_4_14 = g.core.lang:getAttr(iter_4_2, iter_4_3, true)
			local var_4_16, var_4_17 = g.core.lang:getAttr(iter_4_2, var_4_12[iter_4_2] or 0, true)

			table.insert(self._extraAttrList, {
				desc = var_4_13,
				beforeValue = var_4_17,
				afterValue = var_4_14,
				hasNew = var_4_12[iter_4_2] == nil
			})
		end

		self.m_extraAttrList:setNumItems(#self._extraAttrList)
		self.m_extraAttrList:resizeToFit(#self._extraAttrList)
		self.m_curCount:setText(var_4_9)
		self.m_maxCount:setText(g.core.lang:get(201028, {
			num = var_4_10.extra_num_max
		}))
		self.m_extraTip:setText(g.core.lang:get(426519, {
			desc = var_4_10.extra_condition_des
		}))
	end

	self.m_enterTransition:play()
end

return TreeNodeConditionActiveComp

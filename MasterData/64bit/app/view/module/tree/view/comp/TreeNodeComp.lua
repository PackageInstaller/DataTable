local var_0_0 = g.core.model.User.treeData
local var_0_1 = g.core.const.ConstMgr.TreeConst
local TreeTalentComp = class("TreeTalentComp", require("app.fairyGUI.tree.UI_TreeNodeComp"))

function TreeTalentComp:ctor()
	self._nodeType = 0
	self._topQualityCtrl = self.m_qualityTop:getController("quality")
end

function TreeTalentComp:updateNode(arg_2_1, arg_2_2)
	arg_2_2 = arg_2_2 or arg_2_1:getNodeType()
	self._nodeType = arg_2_2

	local var_2_0 = arg_2_1:getQuality()

	self:setQuality(var_2_0)

	if arg_2_2 == var_0_1.NODE_TYPE.SMALL then
		self.m_nodeTypeController:setSelectedIndex(0)
		self.m_node1:updateByValue(var_2_0, true, 0, 0, false, arg_2_1:getIcon())
	elseif arg_2_2 == var_0_1.NODE_TYPE.BIG then
		self.m_nodeTypeController:setSelectedIndex(1)
		self.m_node2:updateByValue(var_2_0, true, arg_2_1:getStage(), arg_2_1:getIcon(), arg_2_1)
	elseif arg_2_2 == var_0_1.NODE_TYPE.CENTER then
		self.m_nodeTypeController:setSelectedIndex(2)
		self.m_node3:updateByValue(var_2_0, true, arg_2_1:getIcon())
	end

	self.m_nodeName:setText(arg_2_1:getInfo().node_name)
end

function TreeTalentComp:updateAfterNodeByValue(arg_3_1)
	self.m_nodeTypeController:setSelectedIndex(arg_3_1.node_type - 1)

	local var_3_0 = g.core.common.Path:getTreeIcon(arg_3_1.node_type, arg_3_1.node_icon)

	if arg_3_1.node_type == var_0_1.NODE_TYPE.SMALL then
		self.m_node1:updateByValue(arg_3_1.node_quality, true, 0, 0, false, var_3_0)
	elseif arg_3_1.node_type == var_0_1.NODE_TYPE.BIG then
		self.m_node2:updateByValue(arg_3_1.node_quality, true, arg_3_1.node_stage, var_3_0, var_0_0:getNodeByAdvanceId(arg_3_1.advance_id))
	elseif arg_3_1.node_type == var_0_1.NODE_TYPE.CENTER then
		self.m_node3:updateByValue(arg_3_1.node_quality, true, var_3_0)
	end

	self:setQuality(arg_3_1.node_quality)
	self.m_nodeName:setText(arg_3_1.node_name)
end

function TreeTalentComp:setQuality(arg_4_1)
	self._topQualityCtrl:setSelectedIndex(arg_4_1)
end

return TreeTalentComp

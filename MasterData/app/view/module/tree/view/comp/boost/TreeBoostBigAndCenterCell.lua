local TreeBoostBigAndCenterCell = class("TreeBoostBigAndCenterCell", require("app.fairyGUI.tree.UI_TreeBoostBigAndCenterCell"))

function TreeBoostBigAndCenterCell:ctor()
	self._nodeStruct = nil

	self.m_gotoBtn:addClickListener(handler(self, self._onClickGoToBtn))
end

function TreeBoostBigAndCenterCell:updateCenterCell(arg_2_1)
	self._nodeStruct = arg_2_1.struct

	self.m_effNameTxt:setText(arg_2_1.name)
	self.m_nodeNameTxt:setText(g.core.lang:get(426520, {
		nodeName = arg_2_1.nodeName
	}))
	self.m_baseAttrTxt:setText(arg_2_1.baseAttr)
	self.m_extraAttrTxt:setText(arg_2_1.extraAttr)

	local var_2_0

	if arg_2_1.isExtraCondition then
		var_2_0 = g.core.common.Color.A1 or g.core.common.Color.A2
	end

	self.m_extraAttrTxt:setColor(var_2_0)
	self.m_condDescTxt:setText(arg_2_1.condDesc)
	self.m_condDescTxt:setColor(var_2_0)
end

function TreeBoostBigAndCenterCell:_onClickGoToBtn()
	self:dispatchCompEvent("CLICK_GO_NODE", {
		nodeStruct = self._nodeStruct
	})
end

return TreeBoostBigAndCenterCell

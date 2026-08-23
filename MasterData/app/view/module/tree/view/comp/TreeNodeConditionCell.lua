local var_0_0 = g.core.const.ConstMgr.TreeConst
local TreeTalentComp = class("TreeTalentComp", require("app.fairyGUI.tree.UI_TreeNodeConditionCell"))

function TreeTalentComp:ctor()
	self._nodeStruct = nil

	self:initView()
end

function TreeTalentComp:initView()
	self.m_gotoBtn:addClickListener(handler(self, self._onClickGoto))
end

function TreeTalentComp:_onClickGoto()
	if not self._nodeStruct then
		return
	end

	self:dispatchCompEvent(var_0_0.EVENT.NODE_GOTO, {
		nodeStruct = self._nodeStruct
	})
end

function TreeTalentComp:updateData(arg_4_1)
	self.m_desc:setText(arg_4_1.str)

	self._nodeStruct = arg_4_1.parentStruct

	self.m_stateController:setSelectedIndex(arg_4_1.isCondition and 1 or 0)
end

return TreeTalentComp

local TreeBoostOverViewPop = class("TreeBoostOverViewPop", require("app.fairyGUI.tree.UI_TreeBoostOverViewPop"), function()
	return fgui.GComponent:create({
		resName = "TreeBoostOverViewPop",
		pkgPath = "ui/tree/tree",
		pkgName = "tree"
	}, ...)
end)

function TreeBoostOverViewPop:ctor(arg_2_1)
	self:showAtCenter()

	self._orient = arg_2_1 and arg_2_1.orient

	self:_updateMainView()
end

function TreeBoostOverViewPop:_updateMainView()
	self.m_nodeComp:updateNodeComp()

	if self._orient then
		self.m_tabController:setSelectedIndex(1)
		self.m_moduleComp:updateModuleComp(self._orient)
	else
		self.m_tabController:setSelectedIndex(0)
		self.m_moduleComp:updateModuleComp()
	end
end

function TreeBoostOverViewPop:receiveCompEvent(arg_4_1, arg_4_2)
	if arg_4_1 == "CLICK_GO_NODE" then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.TREE_GOTO_NODE, false, {
			nodeStruct = arg_4_2.nodeStruct
		})
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	end
end

return TreeBoostOverViewPop

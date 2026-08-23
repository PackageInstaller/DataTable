local var_0_0 = g.core.model.User.treeData
local TreeBoostModuleComp = class("TreeBoostModuleComp", require("app.fairyGUI.tree.UI_TreeBoostModuleComp"))

function TreeBoostModuleComp:ctor()
	self._oricent = 1

	self.m_tabController:setSelectedIndex(self._oricent - 1)
	self.m_tabController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onClickTabChanged))
end

function TreeBoostModuleComp:_onClickTabChanged()
	self._oricent = self.m_tabController:getSelectedIndex() + 1

	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_JiaChengClick)
	self:updateModuleComp()
end

function TreeBoostModuleComp:updateModuleComp(arg_3_1)
	if arg_3_1 then
		self._oricent = arg_3_1

		self.m_tabController:setSelectedIndex(self._oricent - 1)
	end

	self.m_moduleComp:updateScrollComp(var_0_0:getSmallNodeBaseAttrByOrientation(self._oricent), (var_0_0:getCenterAndBigNodeAttrByType(self._oricent)))
end

return TreeBoostModuleComp

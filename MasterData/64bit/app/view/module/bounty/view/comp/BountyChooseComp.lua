local BountyChooseComp = class("BountyChooseComp", require("app.fairyGUI.bounty.UI_BountyChooseComp"))

function BountyChooseComp:ctor()
	self:_initBtn()
end

function BountyChooseComp:_initBtn()
	self.m_starController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onTabChanged))
end

function BountyChooseComp:_onTabChanged()
	self._curSelStar = self.m_starController:getSelectedIndex()

	self:_onSaveClick()
end

function BountyChooseComp:_onSaveClick()
	self:dispatchCompEvent("filter_event", {
		star = self.m_starController:getSelectedIndex()
	})
end

function BountyChooseComp:setSelectedStar(arg_5_1)
	self.m_starController:setSelectedIndex(arg_5_1)
end

return BountyChooseComp

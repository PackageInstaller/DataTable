local ActivityMainTabCell = class("ActivityMainTabCell", require("app.fairyGUI.activity.UI_ActivityMainTabCell"))

function ActivityMainTabCell:ctor()
	self._selectedBefore = false
	self._activityData = nil
	self.m_buttonController = self:getController("button")

	self.m_buttonController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onSelectedStateChanged))
end

function ActivityMainTabCell:_onSelectedStateChanged()
	self:_updateIcons()
	self:_playSwitchAni()

	self._selectedBefore = self:isSelected()
end

function ActivityMainTabCell:updateCell(arg_3_1)
	self._activityData = arg_3_1

	self.m_titleTxt:setText((arg_3_1:getActivityName()))
	self:_updateIcons()
	self:refreshRedPoint()
end

function ActivityMainTabCell:_updateIcons()
	if not self._activityData then
		return
	end

	local var_4_0 = self._activityData:getTabIconConfig()

	if self:isSelected() then
		self:setIcon(var_4_0.selectedIcon)
	else
		self:setIcon(var_4_0.icon)
	end

	self.m_iconShadow:setURL(var_4_0.shadowIcon)
end

function ActivityMainTabCell:updateCD()
	return
end

function ActivityMainTabCell:refreshRedPoint()
	if not self._activityData then
		return
	end

	self.m_redPointComp:setId(self._activityData:getTabRedPointId())
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp
	})
end

function ActivityMainTabCell:_playSwitchAni()
	local var_7_0 = self:isSelected()

	if self._selectedBefore and not var_7_0 then
		self.m_reSwichTransition:play()
	elseif not self._selectedBefore and var_7_0 then
		self.m_swichTransition:play()
	end
end

return ActivityMainTabCell

local ArtifactHandBookTabComp = class("ArtifactHandBookTabComp", require("app.fairyGUI.artifactHandbook.UI_ArtifactHandBookTabComp"))

function ArtifactHandBookTabComp:ctor()
	self.m_buttonController = self:getController("button")

	self.m_buttonController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onSelectedTagChanged))
end

function ArtifactHandBookTabComp:onLoad()
	self._group = self.m_groupController:getSelectedIndex() + 1

	if self._group then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_redPointComp,
			customData = {
				group = self._group
			}
		})
	end
end

function ArtifactHandBookTabComp:_onSelectedTagChanged()
	if self.m_buttonController:getSelectedIndex() == 1 then
		self.m_clickTransition:play()
	else
		self.m_clickTransition:stop()
	end
end

function ArtifactHandBookTabComp:playEnterAnim()
	self["m_enter" .. self.m_buttonController:getSelectedIndex() .. "Transition"]:play()
end

return ArtifactHandBookTabComp

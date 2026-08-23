local EchoLabCollectTabCell = class("EchoLabCollectTabCell", require("app.fairyGUI.echoLab.UI_EchoLabCollectTabCell"))

function EchoLabCollectTabCell:ctor()
	return
end

function EchoLabCollectTabCell:updateView(arg_2_1)
	self:setTitle(arg_2_1:getBuildName())
	self.m_levelTipText:setText(g.core.lang:get(200017, {
		level = arg_2_1:getLevel()
	}))
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {
			buildType = arg_2_1:getBuildType()
		}
	})
end

return EchoLabCollectTabCell

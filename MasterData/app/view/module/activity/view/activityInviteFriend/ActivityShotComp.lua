local ActivityShotComp = class("ActivityShotComp", require("app.fairyGUI.activity.UI_ActivityShotComp"))

function ActivityShotComp:ctor()
	self.m_logo:setURL(g.core.common.Path:getShareLogoByRegionId(config.PUBLISH_REGION))
end

return ActivityShotComp

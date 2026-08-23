local var_0_0 = g.core.model.User.abvertPageAwardData
local ActivityAbvertPageComp = class("ActivityAbvertPageComp", require("app.fairyGUI.activity.UI_ActivityAbvertPageComp"))

function ActivityAbvertPageComp:updateComp()
	local var_1_0 = var_0_0:getOpenScreenTemplate((var_0_0:getCurActId()))

	self.m_bgLoader:setURL("bg/abvertPageAward/bg_abvertPageAward_" .. var_1_0 .. ".jpg")

	if not self._awardComp then
		self._awardComp = fgui.UIPackage:createObject("activity", "ActivityAbvertPageAwardComp_" .. var_1_0)

		self.m_placeComp:addChild(self._awardComp)
	end

	self._awardComp:updateComp()
end

return ActivityAbvertPageComp

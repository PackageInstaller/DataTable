local ActivityPermanentRechargeBuildingComp = class("ActivityPermanentRechargeBuildingComp", require("app.fairyGUI.activity.UI_ActivityPermanentRechargeBuildNameCell"))

function ActivityPermanentRechargeBuildingComp:ctor()
	self._name = nil
end

function ActivityPermanentRechargeBuildingComp:updateNameCell(arg_2_1)
	self._name = arg_2_1.buildInfo.name

	self.m_title:setText(self._name)
end

return ActivityPermanentRechargeBuildingComp

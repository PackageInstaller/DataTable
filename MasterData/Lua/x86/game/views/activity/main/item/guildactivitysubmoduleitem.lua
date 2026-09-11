ActivitySubmoduleItem = import("game.views.activity.Main.item.ActivitySubmoduleItem")

local GuildActivitySubmoduleItem = class("GuildActivitySubmoduleItem", ActivitySubmoduleItem)

function GuildActivitySubmoduleItem:OnEnter()
	self.activiteData_ = ActivityData:GetActivityData(self.activityId_)
	self.startTime_ = self.activiteData_.startTime
	self.stopTime_ = self.activiteData_.stopTime

	manager.redPoint:bindUIandKey(self.transform_, string.format("%s_%s", RedPointConst.GUILD_ACTIVITY, ActivityConst.GUILD_ACTIVITY_START))
	manager.notify:RegistListener(ACTIVITY_UPDATE, self.updateHandler_)
	self:RefreshLock()
end

function GuildActivitySubmoduleItem:OnExit()
	manager.redPoint:unbindUIandKey(self.transform_, string.format("%s_%s", RedPointConst.GUILD_ACTIVITY, ActivityConst.GUILD_ACTIVITY_START))
	manager.notify:RemoveListener(ACTIVITY_UPDATE, self.updateHandler_)
	self:StopTimer()
end

return GuildActivitySubmoduleItem

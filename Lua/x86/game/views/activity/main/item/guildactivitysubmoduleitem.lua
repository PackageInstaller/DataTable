ActivitySubmoduleItem = import("game.views.activity.Main.item.ActivitySubmoduleItem")

local var_0_0 = class("GuildActivitySubmoduleItem", ActivitySubmoduleItem)

function var_0_0.OnEnter(arg_1_0)
	arg_1_0.activiteData_ = ActivityData:GetActivityData(arg_1_0.activityId_)
	arg_1_0.startTime_ = arg_1_0.activiteData_.startTime
	arg_1_0.stopTime_ = arg_1_0.activiteData_.stopTime

	manager.redPoint:bindUIandKey(arg_1_0.transform_, string.format("%s_%s", RedPointConst.GUILD_ACTIVITY, ActivityConst.GUILD_ACTIVITY_START))
	manager.notify:RegistListener(ACTIVITY_UPDATE, arg_1_0.updateHandler_)
	arg_1_0:RefreshLock()
end

function var_0_0.OnExit(arg_2_0)
	manager.redPoint:unbindUIandKey(arg_2_0.transform_, string.format("%s_%s", RedPointConst.GUILD_ACTIVITY, ActivityConst.GUILD_ACTIVITY_START))
	manager.notify:RemoveListener(ACTIVITY_UPDATE, arg_2_0.updateHandler_)
	arg_2_0:StopTimer()
end

return var_0_0

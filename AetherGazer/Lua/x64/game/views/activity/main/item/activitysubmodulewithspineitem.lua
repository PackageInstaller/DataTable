ActivitySubmoduleItem = import("game.views.activity.Main.item.ActivitySubmoduleItem")

local var_0_0 = class("ActivitySubmoduleWithSpineItem", ActivitySubmoduleItem)

function var_0_0.InitUI(arg_1_0)
	var_0_0.super.InitUI(arg_1_0)

	arg_1_0.spine_ = arg_1_0.spineGo_.transform:GetComponent(typeof(Spine.Unity.SkeletonGraphic))
end

function var_0_0.RefreshLock(arg_2_0)
	var_0_0.super.RefreshLock(arg_2_0)

	local var_2_0 = manager.time:GetServerTime() < arg_2_0.startTime_

	if manager.time:GetServerTime() >= arg_2_0.stopTime_ or var_2_0 then
		arg_2_0.spine_.color = Color(0.7058823529411765, 0.6823529411764706, 0.6823529411764706)
	else
		arg_2_0.spine_.color = Color(1, 1, 1)
	end
end

return var_0_0

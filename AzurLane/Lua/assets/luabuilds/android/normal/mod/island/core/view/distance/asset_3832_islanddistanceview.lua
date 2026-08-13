class = var_0_10000

local var_0_0 = "IslandDistanceView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..IslandBaseOpView"))

function var_0_1.GetUIName(arg_1_0)
	return "IslandDistanceUI"
end

function var_0_1.GetUIParent(arg_2_0, arg_2_1)
	return arg_2_0:GetView().interactionContainer
end

function var_0_1.OnInit(arg_3_0, arg_3_1)
	IslandTargetTracker = var_1_10002

	local var_3_0 = var_1_10002.New
	local var_3_1 = arg_3_0._tf

	arg_3_0.targetTracker = var_3_0(var_3.Find(var_3_1, "distance"))

	local var_3_2 = arg_3_0._tf
	local var_3_3 = var_2.Find(var_3_2, "distance/Image")
	local var_3_4 = var_2.GetComponent

	typeof = var_4
	Image = var_5
	arg_3_0.iconImg = var_3_4(var_3_3, var_4(var_5))

	local var_3_5 = arg_3_0._tf
	local var_3_6 = var_2.Find(var_3_5, "distance/arr/arr")
	local var_3_7 = var_2.GetComponent

	typeof = var_4
	Image = var_5
	arg_3_0.arrImg = var_3_7(var_3_6, var_4(var_5))
	IslandTargetTracker = var_2

	local var_3_8 = var_2.New
	local var_3_9 = arg_3_0._tf

	arg_3_0.mainTargetTracker = var_3_8(var_3.Find(var_3_9, "main_distance"))

	return
end

function var_0_1.OnUpdate(arg_4_0)
	local var_4_0 = arg_4_0.mainTargetTracker

	var_1.Update(var_4_0)

	local var_4_1 = arg_4_0.targetTracker
	local var_4_2 = var_1.Update
	local var_4_3 = arg_4_0.mainTargetTracker

	var_4_2(var_4_1, var_3.GetShowTargetPosition(var_4_3))

	return
end

function var_0_1.SetTrackingTarget(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5)
	IslandTaskTrackCard = var_1_10006

	if arg_5_5 == var_1_10006.TYPES.MAIN then
		local var_5_0 = arg_5_0.mainTargetTracker

		var_6.Tracking(var_5_0, arg_5_1._go, arg_5_2._go, arg_5_3)
	else
		IslandTaskTrackCard = var_6

		if arg_5_5 == var_6.TYPES.OTHER then
			arg_5_0:UpdateTrackerStyle(arg_5_4)

			local var_5_1 = arg_5_0.targetTracker

			var_6.Tracking(var_5_1, arg_5_1._go, arg_5_2._go, arg_5_3)
		end
	end

	return
end

function var_0_1.UpdateTrackerStyle(arg_6_0, arg_6_1)
	IslandTaskType = var_1_10002

	local var_6_0 = var_1_10002.GetTrackingIconName

	if not arg_6_1 then
		::label_6_0::

		IslandTaskType = var_1_10003
		var_1_10003 = var_1_10003.MAIN
	end

	local var_6_1 = var_6_0(var_1_10003)

	GetSpriteFromAtlas = var_1_10003

	local var_6_2 = var_1_10003("ui/IslandUI_atlas", var_6_1)

	arg_6_0.iconImg.sprite = var_6_2

	local var_6_3 = arg_6_0.iconImg

	var_4.SetNativeSize(var_6_3)

	GetSpriteFromAtlas = var_4

	local var_6_4 = var_4("ui/IslandUI_atlas", var_6_1 .. "_1")

	arg_6_0.arrImg.sprite = var_6_4

	local var_6_5 = arg_6_0.arrImg

	var_5.SetNativeSize(var_6_5)

	return
end

function var_0_1.CancelTracking(arg_7_0, arg_7_1)
	IslandTaskTrackCard = var_1_10002

	if arg_7_1 == var_1_10002.TYPES.MAIN then
		local var_7_0 = arg_7_0.mainTargetTracker

		var_2.UnTracking(var_7_0)
	else
		IslandTaskTrackCard = var_2

		if arg_7_1 == var_2.TYPES.OTHER then
			local var_7_1 = arg_7_0.targetTracker

			var_2.UnTracking(var_7_1)
		end
	end

	return
end

function var_0_1.ShowHud(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.mainTargetTracker

	var_2.OnShowHud(var_8_0, arg_8_1)

	local var_8_1 = arg_8_0.targetTracker

	var_2.OnShowHud(var_8_1, arg_8_1)

	return
end

function var_0_1.HideHud(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0.mainTargetTracker

	var_2.OnHideHud(var_9_0, arg_9_1)

	local var_9_1 = arg_9_0.targetTracker

	var_2.OnHideHud(var_9_1, arg_9_1)

	return
end

function var_0_1.OnDestroy(arg_10_0)
	if arg_10_0.targetTracker then
		local var_10_0 = arg_10_0.targetTracker

		var_1.Dispose(var_10_0)

		arg_10_0.targetTracker = nil
	end

	if arg_10_0.mainTargetTracker then
		local var_10_1 = arg_10_0.mainTargetTracker

		var_1.Dispose(var_10_1)

		arg_10_0.mainTargetTracker = nil
	end

	return
end

return var_0_1

local var_0_0 = class("IslandDistanceView", import("..IslandBaseOpView"))

function var_0_0.GetUIName(arg_1_0)
	return "IslandDistanceUI"
end

function var_0_0.GetUIParent(arg_2_0, arg_2_1)
	return arg_2_0:GetView().interactionContainer
end

function var_0_0.OnInit(arg_3_0, arg_3_1)
	arg_3_0.targetTracker = IslandTargetTracker.New(arg_3_0._tf:Find("distance"))
	arg_3_0.iconImg = arg_3_0._tf:Find("distance/Image"):GetComponent(typeof(Image))
	arg_3_0.arrImg = arg_3_0._tf:Find("distance/arr/arr"):GetComponent(typeof(Image))
	arg_3_0.mainTargetTracker = IslandTargetTracker.New(arg_3_0._tf:Find("main_distance"))

	return
end

function var_0_0.OnUpdate(arg_4_0)
	arg_4_0.mainTargetTracker:Update()
	arg_4_0.targetTracker:Update(arg_4_0.mainTargetTracker:GetShowTargetPosition())

	return
end

function var_0_0.SetTrackingTarget(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5)
	if arg_5_5 == IslandTaskTrackCard.TYPES.MAIN then
		arg_5_0.mainTargetTracker:Tracking(arg_5_1._go, arg_5_2._go, arg_5_3)
	elseif arg_5_5 == IslandTaskTrackCard.TYPES.OTHER then
		arg_5_0:UpdateTrackerStyle(arg_5_4)
		arg_5_0.targetTracker:Tracking(arg_5_1._go, arg_5_2._go, arg_5_3)
	end

	return
end

function var_0_0.UpdateTrackerStyle(arg_6_0, arg_6_1)
	local var_6_0 = IslandTaskType.GetTrackingIconName(arg_6_1 or IslandTaskType.MAIN)

	arg_6_0.iconImg.sprite = GetSpriteFromAtlas("ui/IslandUI_atlas", var_6_0)

	arg_6_0.iconImg:SetNativeSize()

	arg_6_0.arrImg.sprite = GetSpriteFromAtlas("ui/IslandUI_atlas", var_6_0 .. "_1")

	arg_6_0.arrImg:SetNativeSize()

	return
end

function var_0_0.CancelTracking(arg_7_0, arg_7_1)
	if arg_7_1 == IslandTaskTrackCard.TYPES.MAIN then
		arg_7_0.mainTargetTracker:UnTracking()
	elseif arg_7_1 == IslandTaskTrackCard.TYPES.OTHER then
		arg_7_0.targetTracker:UnTracking()
	end

	return
end

function var_0_0.ShowHud(arg_8_0, arg_8_1)
	arg_8_0.mainTargetTracker:OnShowHud(arg_8_1)
	arg_8_0.targetTracker:OnShowHud(arg_8_1)

	return
end

function var_0_0.HideHud(arg_9_0, arg_9_1)
	arg_9_0.mainTargetTracker:OnHideHud(arg_9_1)
	arg_9_0.targetTracker:OnHideHud(arg_9_1)

	return
end

function var_0_0.OnDestroy(arg_10_0)
	if arg_10_0.targetTracker then
		arg_10_0.targetTracker:Dispose()

		arg_10_0.targetTracker = nil
	end

	if arg_10_0.mainTargetTracker then
		arg_10_0.mainTargetTracker:Dispose()

		arg_10_0.mainTargetTracker = nil
	end

	return
end

return var_0_0

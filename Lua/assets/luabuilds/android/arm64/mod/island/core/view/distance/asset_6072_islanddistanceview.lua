local IslandDistanceView = class("IslandDistanceView", import("..IslandBaseOpView"))

function IslandDistanceView:GetUIName()
	return "IslandDistanceUI"
end

function IslandDistanceView:GetUIParent(arg_2_1)
	return self:GetView().interactionContainer
end

function IslandDistanceView:OnInit(arg_3_1)
	self.targetTracker = IslandTargetTracker.New(self._tf:Find("distance"))
	self.iconImg = self._tf:Find("distance/Image"):GetComponent(typeof(Image))
	self.arrImg = self._tf:Find("distance/arr/arr"):GetComponent(typeof(Image))
	self.mainTargetTracker = IslandTargetTracker.New(self._tf:Find("main_distance"))

	return
end

function IslandDistanceView:OnUpdate()
	self.mainTargetTracker:Update()
	self.targetTracker:Update(self.mainTargetTracker:GetShowTargetPosition())

	return
end

function IslandDistanceView:SetTrackingTarget(arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5)
	if arg_5_5 == IslandTaskTrackCard.TYPES.MAIN then
		self.mainTargetTracker:Tracking(arg_5_1._go, arg_5_2._go, arg_5_3)
	elseif arg_5_5 == IslandTaskTrackCard.TYPES.OTHER then
		self:UpdateTrackerStyle(arg_5_4)
		self.targetTracker:Tracking(arg_5_1._go, arg_5_2._go, arg_5_3)
	end

	return
end

function IslandDistanceView:UpdateTrackerStyle(arg_6_1)
	local var_6_0 = IslandTaskType.GetTrackingIconName(arg_6_1 or IslandTaskType.MAIN)

	self.iconImg.sprite = GetSpriteFromAtlas("ui/IslandUI_atlas", var_6_0)

	self.iconImg:SetNativeSize()

	self.arrImg.sprite = GetSpriteFromAtlas("ui/IslandUI_atlas", var_6_0 .. "_1")

	self.arrImg:SetNativeSize()

	return
end

function IslandDistanceView:CancelTracking(arg_7_1)
	if arg_7_1 == IslandTaskTrackCard.TYPES.MAIN then
		self.mainTargetTracker:UnTracking()
	elseif arg_7_1 == IslandTaskTrackCard.TYPES.OTHER then
		self.targetTracker:UnTracking()
	end

	return
end

function IslandDistanceView:ShowHud(arg_8_1)
	self.mainTargetTracker:OnShowHud(arg_8_1)
	self.targetTracker:OnShowHud(arg_8_1)

	return
end

function IslandDistanceView:HideHud(arg_9_1)
	self.mainTargetTracker:OnHideHud(arg_9_1)
	self.targetTracker:OnHideHud(arg_9_1)

	return
end

function IslandDistanceView:OnDestroy()
	if self.targetTracker then
		self.targetTracker:Dispose()

		self.targetTracker = nil
	end

	if self.mainTargetTracker then
		self.mainTargetTracker:Dispose()

		self.mainTargetTracker = nil
	end

	return
end

return IslandDistanceView

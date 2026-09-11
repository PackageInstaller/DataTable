local VolumeSkinTrialActivityView = class("VolumeSkinTrialActivityView", SkinTrialActivityView)

function VolumeSkinTrialActivityView:UIName()
	if ActivityTools.GetActivityTheme(self.params_.activityID) == ActivityConst.THEME.VOLUME_DOWN then
		if self.params_.activityID == ActivityConst.TYR_SKIN_TRIAL then
			return "UI/VolumeIIIDownUI/SkinTrial/VolumeIIIDownSkinTrialMainUI_1"
		else
			return "UI/VolumeIIIDownUI/SkinTrial/VolumeIIIDownSkinTrialMainUI_2"
		end
	else
		return "UI/VolumeIIIUI/VolumeSkinTrialMainUI"
	end
end

function VolumeSkinTrialActivityView:RefreshSkinItem()
	for iter_2_0, iter_2_1 in ipairs(self.skinTrialIDList_) do
		if self.skinItemList_[iter_2_0] then
			self.skinItemList_[iter_2_0]:SetSkinTrialID(iter_2_1)
		else
			local var_2_1 = self:GetItemClass().New

			self.skinItemList_[iter_2_0] = self:GetItemClass().New(self.skinItemPanel_:GetChild(iter_2_0 - 1).gameObject, iter_2_1)
		end
	end

	for iter_2_2 = #self.skinItemList_, #self.skinTrialIDList_ + 1, -1 do
		self.skinItemList_[iter_2_2]:Dispose()

		self.skinItemList_[iter_2_2] = nil
	end
end

function VolumeSkinTrialActivityView:GetItemClass()
	return VolumeSkinTrialActivityItem
end

return VolumeSkinTrialActivityView

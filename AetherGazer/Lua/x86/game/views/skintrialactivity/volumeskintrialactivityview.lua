local var_0_0 = class("VolumeSkinTrialActivityView", SkinTrialActivityView)

function var_0_0.UIName(arg_1_0)
	if ActivityTools.GetActivityTheme(arg_1_0.params_.activityID) == ActivityConst.THEME.VOLUME_DOWN then
		if arg_1_0.params_.activityID == ActivityConst.TYR_SKIN_TRIAL then
			return "UI/VolumeIIIDownUI/SkinTrial/VolumeIIIDownSkinTrialMainUI_1"
		else
			return "UI/VolumeIIIDownUI/SkinTrial/VolumeIIIDownSkinTrialMainUI_2"
		end
	else
		return "UI/VolumeIIIUI/VolumeSkinTrialMainUI"
	end
end

function var_0_0.RefreshSkinItem(arg_2_0)
	local var_2_0

	for iter_2_0, iter_2_1 in ipairs(arg_2_0.skinTrialIDList_) do
		if arg_2_0.skinItemList_[iter_2_0] then
			arg_2_0.skinItemList_[iter_2_0]:SetSkinTrialID(iter_2_1)
		else
			local var_2_1 = arg_2_0.skinItemPanel_:GetChild(iter_2_0 - 1).gameObject

			arg_2_0.skinItemList_[iter_2_0] = arg_2_0:GetItemClass().New(var_2_1, iter_2_1)
		end
	end

	for iter_2_2 = #arg_2_0.skinItemList_, #arg_2_0.skinTrialIDList_ + 1, -1 do
		arg_2_0.skinItemList_[iter_2_2]:Dispose()

		arg_2_0.skinItemList_[iter_2_2] = nil
	end
end

function var_0_0.GetItemClass(arg_3_0)
	return VolumeSkinTrialActivityItem
end

return var_0_0

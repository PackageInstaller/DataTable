ResidentMusicHomeView = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local ResidentMusicHomeView = class("ResidentMusicHomeView", ActivityMainBasePanel)

function ResidentMusicHomeView:GetUIName()
	return "Widget/System/Activity_Resident/Acitvity_MusicUI/Acitvity_MusicHomeUI"
end

function ResidentMusicHomeView:AddListeners()
	self:AddBtnListener(self.goBtn_, nil, function()
		if not manager.assetPend:CheckAssetPend("assetpend_consistent_activity_m") then
			manager.assetPend:ShowAssetPendMessageBox("assetpend_consistent_activity_m")

			return
		end

		JumpTools.OpenPageByJump("/residentMusicGameMainView", {
			activity_id = self.activityID_
		})
	end)
	self:AddBtnListener(self.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("residentMusicRewardView", {
			activity_id = MusicData:GetActivityTaskID(self.activityID_)
		})
	end)
	self:AddBtnListener(self.infoBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelpPro", {
			isPrefab = true,
			pages = (GameSetting.v210_music_describe or nil) and (GameSetting.v210_music_describe.value or {})
		})
	end)
end

function ResidentMusicHomeView:OnEnter()
	MusicData:SetPageActivityId(self.activityID_)
	ResidentMusicHomeView.super.OnEnter(self)
	manager.redPoint:bindUIandKey(self.rewardBtn_.transform, string.format("%s_%s", RedPointConst.MUSIC_REWARD, self.activityID_))
	manager.redPoint:bindUIandKey(self.goBtn_.transform, string.format("%s_%s", RedPointConst.MUSIC_OPEN, self.activityID_))

	self.descText_.text = GetTips("ACTIVITY_MUSIC_2_10_CONTENT")
end

function ResidentMusicHomeView:OnExit()
	ResidentMusicHomeView.super.OnExit(self)
	manager.redPoint:unbindUIandKey(self.rewardBtn_.transform, string.format("%s_%s", RedPointConst.MUSIC_REWARD, self.activityID_))
	manager.redPoint:unbindUIandKey(self.goBtn_.transform, string.format("%s_%s", RedPointConst.MUSIC_OPEN, self.activityID_))
end

return ResidentMusicHomeView

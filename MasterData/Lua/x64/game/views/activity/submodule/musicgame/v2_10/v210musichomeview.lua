ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local V210MusicHomeView = class("V210MusicHomeView", ActivityMainBasePanel)

function V210MusicHomeView:GetUIName()
	return "UI/VersionUI/JapanRegionUI_2_10/JapanRegionMusicUI/MusicHomeUI"
end

function V210MusicHomeView:AddListeners()
	self:AddBtnListener(self.m_enterBtn, nil, function()
		JumpTools.OpenPageByJump("/V210MusicMain", {
			activity_id = self.activityID_
		})
	end)
	self:AddBtnListener(self.m_rewardBtn, nil, function()
		JumpTools.OpenPageByJump("V210MusicReward", {
			activity_id = self.activityID_
		})
	end)
	self:AddBtnListener(self.descbtnBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelpPro", {
			isPrefab = true,
			pages = (GameSetting.v210_music_describe or nil) and (GameSetting.v210_music_describe.value or {})
		})
	end)
end

function V210MusicHomeView:OnEnter()
	MusicData:SetPageActivityId(self.activityID_)
	V210MusicHomeView.super.OnEnter(self)
	manager.redPoint:bindUIandKey(self.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.MUSIC_REWARD, self.activityID_))
	manager.redPoint:bindUIandKey(self.m_enterBtn.transform, string.format("%s_%s", RedPointConst.MUSIC_OPEN, self.activityID_))

	self.textcontentText_.text = GetTips("ACTIVITY_MUSIC_2_10_CONTENT")
end

function V210MusicHomeView:OnExit()
	V210MusicHomeView.super.OnExit(self)
	manager.redPoint:unbindUIandKey(self.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.MUSIC_REWARD, self.activityID_))
	manager.redPoint:unbindUIandKey(self.m_enterBtn.transform, string.format("%s_%s", RedPointConst.MUSIC_OPEN, self.activityID_))
end

return V210MusicHomeView

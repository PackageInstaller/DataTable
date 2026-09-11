ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local XH1stMusicHomeView = class("XH1stMusicHomeView", ActivityMainBasePanel)

function XH1stMusicHomeView:GetUIName()
	return "UI/VersionUI/XuHeng1stUI/Music/XH1stMusicHomeUI"
end

function XH1stMusicHomeView:AddListeners()
	self:AddBtnListener(self.m_enterBtn, nil, function()
		JumpTools.OpenPageByJump("/enternalMusicMain", {
			activity_id = self.activityID_
		})
	end)
	self:AddBtnListener(self.m_rewardBtn, nil, function()
		JumpTools.OpenPageByJump("enternalMusicReward", {
			activity_id = self.activityID_
		})
	end)
end

function XH1stMusicHomeView:OnEnter()
	XH1stMusicHomeView.super.OnEnter(self)
	manager.redPoint:bindUIandKey(self.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.MUSIC_REWARD, self.activityID_))
	manager.redPoint:bindUIandKey(self.m_enterBtn.transform, string.format("%s_%s", RedPointConst.MUSIC_OPEN, self.activityID_))
end

function XH1stMusicHomeView:OnExit()
	XH1stMusicHomeView.super.OnExit(self)
	manager.redPoint:unbindUIandKey(self.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.MUSIC_REWARD, self.activityID_))
	manager.redPoint:unbindUIandKey(self.m_enterBtn.transform, string.format("%s_%s", RedPointConst.MUSIC_OPEN, self.activityID_))
end

return XH1stMusicHomeView

local SixInvitePage = class("SixInvitePage", import(".FifthInvitePage"))

function SixInvitePage:OnDataSetting()
	self.ultimate = LaunchBallActivityMgr.GotInvitationFlag(self.activity.id) and 1 or 0
	self.usedtime = LaunchBallActivityMgr.GetRoundCount(self.activity.id)
	self.maxtime = LaunchBallActivityMgr.GetRoundCountMax(self.activity.id)

	return
end

function SixInvitePage:OnFirstFlush()
	onButton(self, self.goBtn, function()
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.SIXTH_ANNIVERSARY_JP_DARK)

		return
	end, SFX_PANEL)
	setActive(self.helpBtn, false)

	return
end

function SixInvitePage:CheckGet()
	if self.ultimate == 0 then
		if self.maxtime > self.usedtime then
			return
		end

		LaunchBallActivityMgr.GetInvitation(self.activity.id)
	end

	return
end

return SixInvitePage

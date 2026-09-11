local VolumeMusicStopView = class("VolumeMusicStopView", ReduxView)

function VolumeMusicStopView:UIName()
	return "UI/VolumeIIIDownUI/AthenaMusicGame/VolumeIIIDownMusicPauseUI"
end

function VolumeMusicStopView:UIParent()
	return manager.ui.uiMain.transform
end

function VolumeMusicStopView:Init()
	self:InitUI()
	self:AddUIListener()
end

function VolumeMusicStopView:InitUI()
	self:BindCfgUI()
end

function VolumeMusicStopView:AddUIListener()
	self:AddBtnListener(self.m_goBtn, nil, function()
		self:Back()
		MusicLuaBridge.ResumeMusicGame()

		local var_6_0 = GameObject.Find("movie")

		if var_6_0 then
			var_6_0:GetComponent("CriManaMovieMaterial"):Pause(false)
		end
	end)
	self:AddBtnListener(self.m_endBtn, nil, function()
		self:Back()
		MusicLuaBridge.EndMusicGame()
	end)
	self:AddBtnListener(self.m_reBtn, nil, function()
		self:Back()

		local var_8_0 = ActivityMusicCfg[MusicData:GetGameId()]

		if var_8_0 then
			SDKTools.SendMessageToSDK("activity_music_start", {
				is_restart = true,
				activity_id = var_8_0.activity_id,
				difficulty_id = var_8_0.difficult
			})
		end

		MusicLuaBridge.ReStartMusicGame()
	end)
end

function VolumeMusicStopView:OnTop()
	manager.windowBar:SwitchBar({})
end

function VolumeMusicStopView:OnEnter()
	return
end

function VolumeMusicStopView:OnExit()
	manager.windowBar:HideBar()
end

function VolumeMusicStopView:Dispose()
	VolumeMusicStopView.super.Dispose(self)
end

return VolumeMusicStopView

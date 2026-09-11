local EnternalMusicStopView = class("EnternalMusicStopView", ReduxView)

function EnternalMusicStopView:UIName()
	return "UI/VersionUI/XuHeng1stUI/Music/XH1stMusicPromptUI"
end

function EnternalMusicStopView:UIParent()
	return manager.ui.uiMain.transform
end

function EnternalMusicStopView:Init()
	self:InitUI()
	self:AddUIListener()
end

function EnternalMusicStopView:InitUI()
	self:BindCfgUI()
end

function EnternalMusicStopView:AddUIListener()
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

function EnternalMusicStopView:OnTop()
	manager.windowBar:SwitchBar({})
end

function EnternalMusicStopView:OnExit()
	manager.windowBar:HideBar()
end

return EnternalMusicStopView

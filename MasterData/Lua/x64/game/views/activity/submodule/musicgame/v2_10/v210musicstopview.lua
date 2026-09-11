local EnternalMusicStopView = class("EnternalMusicStopView", ReduxView)

function EnternalMusicStopView:UIName()
	local var_1_0 = MusicData:GetNowMusicUINameList()

	if var_1_0 and var_1_0.stopView then
		return var_1_0.stopView
	else
		return "UI/VersionUI/JapanRegionUI_2_10/JapanRegionMusicUI/MusicPromptUI"
	end
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
			local var_6_1 = var_6_0:GetComponent("CriManaMovieMaterial")

			if var_6_1 then
				var_6_1:Pause(false)
			end
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
				difficulty_id = var_8_0.difficult,
				other_data = MusicData:GetSpectralAndVercialSDKKey()
			})
		end

		MusicLuaBridge.ReStartMusicGame()
	end)
end

function EnternalMusicStopView:OnTop()
	manager.windowBar:HideBar()
end

function EnternalMusicStopView:OnExit()
	manager.windowBar:HideBar()
end

return EnternalMusicStopView

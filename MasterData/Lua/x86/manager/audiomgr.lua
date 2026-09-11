local AudioMgr = class("AudioMgr")
local var_0_1 = {
	"music",
	"effect",
	"voice"
}

function AudioMgr:Ctor()
	self:OnCtor()
end

function AudioMgr:OnCtor()
	self.recordedTalkPlayback = nil
end

function AudioMgr:InitListener()
	print("Initialize Audio Mgr")
	AudioManager.Instance:SetListener(manager.ui.mainCamera)
	AudioManager.Instance:CreateCriAtom()

	self.recordedTalkPlayback = {}
end

function AudioMgr:SetLocalizationFlag(arg_4_1)
	AudioManager.Instance:SetLocalizationFlag(arg_4_1)
end

function AudioMgr:GetLocalizationFlag()
	return AudioManager.Instance:GetLocalizationFlag()
end

function AudioMgr:SetAudioMasterMute(arg_6_1)
	AudioManager.Instance:SetAudioMasterMute(arg_6_1)
end

function AudioMgr:ClearBGMFlag()
	local var_7_0 = AudioManager.Instance:GetPlayer(var_0_1[1])

	if var_7_0 ~= nil then
		var_7_0.cueName = ""
	end
end

function AudioMgr:PlayBGM(arg_8_1, arg_8_2, arg_8_3)
	return AudioManager.Instance:Play(var_0_1[1], arg_8_1, arg_8_2, arg_8_3 ~= "" and arg_8_3 ~= nil)
end

function AudioMgr:StopBGM(arg_9_1, arg_9_2, arg_9_3)
	return AudioManager.Instance:Stop(var_0_1[1])
end

function AudioMgr:AddCue(arg_10_1, arg_10_2, arg_10_3)
	AudioManager.Instance:AddCue(arg_10_1, arg_10_2, arg_10_3)
end

function AudioMgr:PlayEffect(arg_11_1, arg_11_2, arg_11_3)
	return AudioManager.Instance:Play(var_0_1[2], arg_11_1, arg_11_2, arg_11_3 ~= "" and arg_11_3 ~= nil)
end

function AudioMgr:StopEffect()
	AudioManager.Instance:Stop(var_0_1[2])
end

function AudioMgr:PlayVoice(arg_13_1, arg_13_2, arg_13_3)
	return AudioManager.Instance:Play(var_0_1[3], arg_13_1, arg_13_2, arg_13_3 ~= "" and arg_13_3 ~= nil)
end

function AudioMgr:StopVoice()
	self.recordedTalkPlayback = {}

	AudioManager.Instance:Stop(var_0_1[3])
end

function AudioMgr:StopVoiceImmediate()
	AudioManager.Instance:StopImmediate(var_0_1[3])
end

function AudioMgr:PauseVoice(arg_16_1)
	AudioManager.Instance:Pause(var_0_1[3], arg_16_1)
end

function AudioMgr:IsStoppedOfVoice()
	return AudioManager.Instance:IsStopped(var_0_1[3])
end

function AudioMgr:GetVoiceLength(arg_18_1, arg_18_2, arg_18_3)
	return AudioManager.Instance:GetCueInfoLength(var_0_1[3], arg_18_1, arg_18_2, arg_18_3 ~= "")
end

function AudioMgr:StopBgmImmediate()
	AudioManager.Instance:StopImmediate(var_0_1[1])
end

function AudioMgr:Play(arg_20_1, arg_20_2, arg_20_3, arg_20_4)
	return AudioManager.Instance:Play(arg_20_1, arg_20_2, arg_20_3, arg_20_4 ~= "" and arg_20_4 ~= nil)
end

function AudioMgr:Pause(arg_21_1, arg_21_2)
	AudioManager.Instance:Pause(arg_21_1, arg_21_2)
end

function AudioMgr:PauseAll(arg_22_1)
	AudioManager.Instance:PauseAll(arg_22_1)
end

function AudioMgr:Stop(arg_23_1)
	if arg_23_1 == var_0_1[3] then
		self.recordedTalkPlayback = {}
	end

	AudioManager.Instance:Stop(arg_23_1)
end

function AudioMgr:StopAll()
	self.recordedTalkPlayback = {}

	AudioManager.Instance:StopAll()
end

function AudioMgr:RemoveCue(arg_25_1)
	AudioManager.Instance:RemoveCue(arg_25_1)
end

function AudioMgr:HasCueSheet(arg_26_1)
	return LuaForUtil.HasCueSheet(arg_26_1)
end

function AudioMgr:SetVolume(arg_27_1, arg_27_2)
	AudioManager.Instance:SetVolume(arg_27_1, arg_27_2)
end

function AudioMgr:GetVolume(arg_28_1)
	return AudioManager.Instance:GetVolume(arg_28_1)
end

function AudioMgr:GetMusicVolume()
	return AudioManager.Instance:GetVolume(var_0_1[1])
end

function AudioMgr:GetEffectVolume()
	return AudioManager.Instance:GetVolume(var_0_1[2])
end

function AudioMgr:GetVoiceVolume()
	return AudioManager.Instance:GetVolume(var_0_1[3])
end

function AudioMgr:PlayUIAudio(arg_32_1)
	AudioManager.Instance:PlayUIAudio(arg_32_1)
end

function AudioMgr:GetAudioName(arg_33_1, arg_33_2)
	for iter_33_0, iter_33_1 in ipairs(MusicRecordCfg.all) do
		if MusicRecordCfg[iter_33_1].cuesheet == arg_33_1 and MusicRecordCfg[iter_33_1].cueName == arg_33_2 then
			return GetI18NText(MusicRecordCfg[iter_33_1].musicName)
		end
	end

	if arg_33_1 ~= "ui_battle" then
		print(string.format("没有对应的bmg,cueSheet = %s cueName = %s", arg_33_1, arg_33_2))
	end

	return ""
end

function AudioMgr:PlayUIAudioByVoice(arg_34_1)
	local var_34_0 = -1

	if arg_34_1 == "open_battel" then
		var_34_0 = 14
	elseif arg_34_1 == "expup" then
		var_34_0 = 17
	elseif arg_34_1 == "pro1" then
		var_34_0 = 18
	elseif arg_34_1 == "pro2" then
		var_34_0 = 18
	elseif arg_34_1 == "pro3" then
		var_34_0 = 19
	elseif arg_34_1 == "sign_in" then
		var_34_0 = 20
	elseif arg_34_1 == "stage_slide" then
		var_34_0 = 21
	elseif arg_34_1 == "equip" then
		var_34_0 = 22
	elseif arg_34_1 == "hero_change" then
		var_34_0 = 25
	end

	if var_34_0 ~= -1 then
		manager.audio:PlayUIAudio(var_34_0)
	end
end

function AudioMgr:SetEffectSelectorLabel(arg_35_1, arg_35_2)
	AudioManager.Instance:SetSelectorLabel(var_0_1[2], arg_35_1, arg_35_2)
end

function AudioMgr:SetObtainGoldSelectorLabel()
	AudioManager.Instance:SetSelectorLabel(var_0_1[2], "search", "gold")
end

function AudioMgr:SetObtainPurpleSelectorLabel()
	AudioManager.Instance:SetSelectorLabel(var_0_1[2], "search", "purple")
end

function AudioMgr:SetObtainBlueSelectorLabel()
	AudioManager.Instance:SetSelectorLabel(var_0_1[2], "search", "blue")
end

function AudioMgr:Dispose()
	if self.recordedTalkPlayback then
		for iter_39_0, iter_39_1 in pairs(self.recordedTalkPlayback) do
			iter_39_1:Stop()
		end
	end

	self.recordedTalkPlayback = nil
end

function AudioMgr:DestoryCriAtom()
	AudioManager.Instance:DestoryCriAtom()
end

function AudioMgr:GetBgmPlayer()
	return AudioManager.Instance:GetPlayer(var_0_1[1])
end

function AudioMgr:SetBgmAisacControl(arg_42_1, arg_42_2)
	return AudioManager.Instance:SetAisacControl(var_0_1[1], arg_42_1, arg_42_2)
end

function AudioMgr:ResetParametersBgm()
	AudioManager.Instance:ResetParameters(var_0_1[1])
end

function AudioMgr:SetEffectAisacControl(arg_44_1, arg_44_2)
	return AudioManager.Instance:SetAisacControl(var_0_1[2], arg_44_1, arg_44_2)
end

function AudioMgr:SetStartTime(arg_45_1)
	AudioManager.Instance:SetStartTime(var_0_1[1], arg_45_1)
end

function AudioMgr:RemoveRecorededHeroTalkPlayback(arg_46_1)
	if self.recordedTalkPlayback then
		self.recordedTalkPlayback[arg_46_1] = nil

		return self.recordedTalkPlayback[arg_46_1]
	end
end

function AudioMgr:RecordHeroTalkPlayback(arg_47_1, arg_47_2)
	if self.recordedTalkPlayback then
		self.recordedTalkPlayback[arg_47_1] = arg_47_2
	end
end

function AudioMgr:CleanCriAtom()
	AudioManager.Instance:CleanCriAtom()
end

return AudioMgr

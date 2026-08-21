local var_0_0 = class("AudioMgr")
local var_0_1 = {
	"music",
	"effect",
	"voice"
}

function var_0_0.Ctor(arg_1_0)
	arg_1_0:OnCtor()
end

function var_0_0.OnCtor(arg_2_0)
	arg_2_0.recordedTalkPlayback = nil
end

function var_0_0.InitListener(arg_3_0)
	print("Initialize Audio Mgr")
	AudioManager.Instance:SetListener(manager.ui.mainCamera)
	AudioManager.Instance:CreateCriAtom()

	arg_3_0.recordedTalkPlayback = {}
end

function var_0_0.SetLocalizationFlag(arg_4_0, arg_4_1)
	AudioManager.Instance:SetLocalizationFlag(arg_4_1)
end

function var_0_0.GetLocalizationFlag(arg_5_0)
	return AudioManager.Instance:GetLocalizationFlag()
end

function var_0_0.SetAudioMasterMute(arg_6_0, arg_6_1)
	AudioManager.Instance:SetAudioMasterMute(arg_6_1)
end

function var_0_0.ClearBGMFlag(arg_7_0)
	local var_7_0 = AudioManager.Instance:GetPlayer(var_0_1[1])

	if var_7_0 ~= nil then
		var_7_0.cueName = ""
	end
end

function var_0_0.PlayBGM(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	return AudioManager.Instance:Play(var_0_1[1], arg_8_1, arg_8_2, arg_8_3 ~= "" and arg_8_3 ~= nil)
end

function var_0_0.StopBGM(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	return AudioManager.Instance:Stop(var_0_1[1])
end

function var_0_0.AddCue(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	AudioManager.Instance:AddCue(arg_10_1, arg_10_2, arg_10_3)
end

function var_0_0.PlayEffect(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	return AudioManager.Instance:Play(var_0_1[2], arg_11_1, arg_11_2, arg_11_3 ~= "" and arg_11_3 ~= nil)
end

function var_0_0.StopEffect(arg_12_0)
	AudioManager.Instance:Stop(var_0_1[2])
end

function var_0_0.PlayVoice(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	return AudioManager.Instance:Play(var_0_1[3], arg_13_1, arg_13_2, arg_13_3 ~= "" and arg_13_3 ~= nil)
end

function var_0_0.StopVoice(arg_14_0)
	arg_14_0.recordedTalkPlayback = {}

	AudioManager.Instance:Stop(var_0_1[3])
end

function var_0_0.StopVoiceImmediate(arg_15_0)
	AudioManager.Instance:StopImmediate(var_0_1[3])
end

function var_0_0.PauseVoice(arg_16_0, arg_16_1)
	AudioManager.Instance:Pause(var_0_1[3], arg_16_1)
end

function var_0_0.IsStoppedOfVoice(arg_17_0)
	return AudioManager.Instance:IsStopped(var_0_1[3])
end

function var_0_0.GetVoiceLength(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	return AudioManager.Instance:GetCueInfoLength(var_0_1[3], arg_18_1, arg_18_2, arg_18_3 ~= "")
end

function var_0_0.StopBgmImmediate(arg_19_0)
	AudioManager.Instance:StopImmediate(var_0_1[1])
end

function var_0_0.Play(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4)
	return AudioManager.Instance:Play(arg_20_1, arg_20_2, arg_20_3, arg_20_4 ~= "" and arg_20_4 ~= nil)
end

function var_0_0.Pause(arg_21_0, arg_21_1, arg_21_2)
	AudioManager.Instance:Pause(arg_21_1, arg_21_2)
end

function var_0_0.PauseAll(arg_22_0, arg_22_1)
	AudioManager.Instance:PauseAll(arg_22_1)
end

function var_0_0.Stop(arg_23_0, arg_23_1)
	if arg_23_1 == var_0_1[3] then
		arg_23_0.recordedTalkPlayback = {}
	end

	AudioManager.Instance:Stop(arg_23_1)
end

function var_0_0.StopAll(arg_24_0)
	arg_24_0.recordedTalkPlayback = {}

	AudioManager.Instance:StopAll()
end

function var_0_0.RemoveCue(arg_25_0, arg_25_1)
	AudioManager.Instance:RemoveCue(arg_25_1)
end

function var_0_0.HasCueSheet(arg_26_0, arg_26_1)
	return LuaForUtil.HasCueSheet(arg_26_1)
end

function var_0_0.SetVolume(arg_27_0, arg_27_1, arg_27_2)
	AudioManager.Instance:SetVolume(arg_27_1, arg_27_2)
end

function var_0_0.GetVolume(arg_28_0, arg_28_1)
	return AudioManager.Instance:GetVolume(arg_28_1)
end

function var_0_0.GetMusicVolume(arg_29_0)
	return AudioManager.Instance:GetVolume(var_0_1[1])
end

function var_0_0.GetEffectVolume(arg_30_0)
	return AudioManager.Instance:GetVolume(var_0_1[2])
end

function var_0_0.GetVoiceVolume(arg_31_0)
	return AudioManager.Instance:GetVolume(var_0_1[3])
end

function var_0_0.PlayUIAudio(arg_32_0, arg_32_1)
	AudioManager.Instance:PlayUIAudio(arg_32_1)
end

function var_0_0.GetAudioName(arg_33_0, arg_33_1, arg_33_2)
	for iter_33_0, iter_33_1 in ipairs(MusicRecordCfg.all) do
		local var_33_0 = MusicRecordCfg[iter_33_1]

		if var_33_0.cuesheet == arg_33_1 and var_33_0.cueName == arg_33_2 then
			return GetI18NText(var_33_0.musicName)
		end
	end

	if arg_33_1 ~= "ui_battle" then
		print(string.format("没有对应的bmg,cueSheet = %s cueName = %s", arg_33_1, arg_33_2))
	end

	return ""
end

function var_0_0.PlayUIAudioByVoice(arg_34_0, arg_34_1)
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

function var_0_0.SetEffectSelectorLabel(arg_35_0, arg_35_1, arg_35_2)
	AudioManager.Instance:SetSelectorLabel(var_0_1[2], arg_35_1, arg_35_2)
end

function var_0_0.SetObtainGoldSelectorLabel(arg_36_0)
	AudioManager.Instance:SetSelectorLabel(var_0_1[2], "search", "gold")
end

function var_0_0.SetObtainPurpleSelectorLabel(arg_37_0)
	AudioManager.Instance:SetSelectorLabel(var_0_1[2], "search", "purple")
end

function var_0_0.SetObtainBlueSelectorLabel(arg_38_0)
	AudioManager.Instance:SetSelectorLabel(var_0_1[2], "search", "blue")
end

function var_0_0.Dispose(arg_39_0)
	if arg_39_0.recordedTalkPlayback then
		for iter_39_0, iter_39_1 in pairs(arg_39_0.recordedTalkPlayback) do
			iter_39_1:Stop()
		end
	end

	arg_39_0.recordedTalkPlayback = nil
end

function var_0_0.DestoryCriAtom(arg_40_0)
	AudioManager.Instance:DestoryCriAtom()
end

function var_0_0.GetBgmPlayer(arg_41_0)
	return AudioManager.Instance:GetPlayer(var_0_1[1])
end

function var_0_0.SetBgmAisacControl(arg_42_0, arg_42_1, arg_42_2)
	return AudioManager.Instance:SetAisacControl(var_0_1[1], arg_42_1, arg_42_2)
end

function var_0_0.ResetParametersBgm(arg_43_0)
	AudioManager.Instance:ResetParameters(var_0_1[1])
end

function var_0_0.SetEffectAisacControl(arg_44_0, arg_44_1, arg_44_2)
	return AudioManager.Instance:SetAisacControl(var_0_1[2], arg_44_1, arg_44_2)
end

function var_0_0.SetStartTime(arg_45_0, arg_45_1)
	AudioManager.Instance:SetStartTime(var_0_1[1], arg_45_1)
end

function var_0_0.RemoveRecorededHeroTalkPlayback(arg_46_0, arg_46_1)
	if arg_46_0.recordedTalkPlayback then
		local var_46_0
		local var_46_1 = arg_46_0.recordedTalkPlayback
		local var_46_2 = arg_46_0.recordedTalkPlayback[arg_46_1]

		var_46_1[arg_46_1] = nil

		return var_46_2
	end
end

function var_0_0.RecordHeroTalkPlayback(arg_47_0, arg_47_1, arg_47_2)
	if arg_47_0.recordedTalkPlayback then
		arg_47_0.recordedTalkPlayback[arg_47_1] = arg_47_2
	end
end

function var_0_0.CleanCriAtom(arg_48_0)
	AudioManager.Instance:CleanCriAtom()
end

return var_0_0

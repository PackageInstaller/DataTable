pg = pg or {}

local var_0_0 = pg

pg.CriMgr = singletonClass("CriMgr")

local var_0_1 = pg.CriMgr

pg.CriMgr.Category_CV = "Category_CV"
pg.CriMgr.Category_BGM = "Category_BGM"
pg.CriMgr.Category_SE = "Category_SE"
pg.CriMgr.Category_Mute_Other_CV = "Mute_Other_CV"
pg.CriMgr.C_BGM = "C_BGM"
pg.CriMgr.C_VOICE = "cv"
pg.CriMgr.C_SE = "C_SE"
pg.CriMgr.C_BATTLE_SE = "C_BATTLE_SE"
pg.CriMgr.C_GALLERY_MUSIC = "C_GALLERY_MUSIC"
pg.CriMgr.C_BATTLE_CV_EXTRA = "C_BATTLE_CV_EXTRA"
pg.CriMgr.C_TIMELINE = "C_TIMELINE"
pg.CriMgr.C_SE_LOOP = "C_SE_LOOP"
pg.CriMgr.NEXT_VER = 40

function pg.CriMgr.Init(arg_1_0, arg_1_1)
	print("initializing cri manager...")
	seriesAsync({
		function(arg_2_0)
			arg_1_0:InitCri(arg_2_0)

			return
		end,
		function(arg_3_0)
			local var_3_0 = CueData.GetCueData()

			var_3_0.cueSheetName = "se-ui"
			var_3_0.channelName = var_0_1.C_SE

			arg_1_0.criInst:LoadCueSheet(var_3_0, function(arg_4_0)
				arg_3_0()

				return
			end, true)

			return
		end,
		function(arg_5_0)
			local var_5_0 = CueData.GetCueData()

			var_5_0.cueSheetName = "se-battle"
			var_5_0.channelName = var_0_1.C_BATTLE_SE

			arg_1_0.criInst:LoadCueSheet(var_5_0, function(arg_6_0)
				arg_5_0()

				return
			end, true)

			return
		end,
		function(arg_7_0)
			arg_1_0:InitBgmCfg(arg_7_0)

			return
		end
	}, arg_1_1)

	return
end

function pg.CriMgr.InitCri(arg_8_0, arg_8_1)
	local var_8_0 = GameObject.Find("CRIWARE")

	var_8_0:AddComponent(typeof(CriWareMgr))

	arg_8_0.criInitializer = var_8_0:GetComponent(typeof(CriWare.CriWareInitializer))
	arg_8_0.criInitializer.fileSystemConfig.numberOfLoaders = 128
	arg_8_0.criInitializer.manaConfig.numberOfDecoders = 128
	arg_8_0.criInitializer.atomConfig.useRandomSeedWithTime = true
	arg_8_0.criInitializer.DecrypterConfig.key = "621561580448882"

	arg_8_0.criInitializer:Initialize()

	arg_8_0.criInst = CriWareMgr.Inst

	arg_8_0.criInst:Init(function()
		arg_8_0:ResetAllVolume()

		local var_9_0 = arg_8_0.criInst:GetChannelData(var_0_1.C_VOICE)

		arg_8_0.criInst:CreateChannel(var_0_1.C_GALLERY_MUSIC, CriWareMgr.CRI_CHANNEL_TYPE.SINGLE)

		arg_8_0.criInst:GetChannelData(var_0_1.C_BGM).channelPlayer.loop = true

		arg_8_0.criInst:CreateChannel(var_0_1.C_BATTLE_CV_EXTRA, CriWareMgr.CRI_CHANNEL_TYPE.SINGLE)

		arg_8_0.criInst:GetChannelData(var_0_1.C_BATTLE_CV_EXTRA).channelPlayer.volume = 0.6

		arg_8_0.criInst:CreateChannel(var_0_1.C_SE_LOOP, CriWareMgr.CRI_CHANNEL_TYPE.MULTI_NOT_REPEAT)

		arg_8_0.criInst:GetChannelData(var_0_1.C_SE_LOOP).channelPlayer.loop = true
		arg_8_0.bgmWaveAnalyzer = GetOrAddComponent(GameObject.Find("CRIWARE/C_BGM"), typeof(CriAtomWaveAnalyzer))

		arg_8_0.bgmWaveAnalyzer:Init()
		arg_8_1()

		return
	end)

	return
end

function pg.CriMgr.PlayBGM(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_0.bgmName == "bgm-" .. arg_10_1 then
		return
	end

	arg_10_0.bgmName = "bgm-" .. arg_10_1

	arg_10_0.criInst:PlayBGM("bgm-" .. arg_10_1, CriWareMgr.CRI_FADE_TYPE.FADE_INOUT, function(arg_11_0)
		if arg_11_0 == nil then
			local var_11_0 = arg_10_1 or "NIL"

			warning("Missing BGM :" .. var_11_0)
		end

		return
	end)

	return
end

function pg.CriMgr.StopBGM(arg_12_0)
	arg_12_0.criInst:StopBGM(CriWareMgr.CRI_FADE_TYPE.FADE_INOUT)

	arg_12_0.bgmName = nil

	return
end

function pg.CriMgr.StopPlaybackInfoForce(arg_13_0, arg_13_1)
	arg_13_1.playback:Stop(true)

	return
end

function pg.CriMgr.playCueSheetVoice(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	assert(arg_14_1, "cueSheetName can not be nil.")
	assert(arg_14_2, "cueName can not be nil.")

	if arg_14_3 then
		arg_14_0.criInst:PlaySE(arg_14_2, arg_14_1, function(arg_15_0)
			if arg_14_4 ~= nil then
				arg_14_4(arg_15_0)
			end

			return
		end)
	else
		arg_14_0.criInst:PlayVoice(arg_14_2, CriWareMgr.CRI_FADE_TYPE.NONE, arg_14_1, function(arg_16_0)
			if arg_14_4 ~= nil then
				arg_14_4(arg_16_0)
			end

			return
		end)
	end

	return
end

function pg.CriMgr.PlayPaintingBgm(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4, arg_17_5)
	arg_17_0._paintingBgmSheets = arg_17_0._paintingBgmSheets or {}
	arg_17_0._paintingBgmSheetInfo = arg_17_0._paintingBgmSheetInfo or {}
	arg_17_0._paintingBgmSheetVolume = arg_17_0._paintingBgmSheetVolume or {}

	if not table.contains(arg_17_0._paintingBgmSheets, arg_17_1) then
		table.insert(arg_17_0._paintingBgmSheets, arg_17_1)
	end

	if arg_17_3 and arg_17_0._paintingBgmSheetInfo[arg_17_2] then
		return
	end

	arg_17_0._paintingBgmVolumeRate = arg_17_5 or 1

	if arg_17_0._paintingBgmSheetInfo[arg_17_2] and arg_17_0._paintingBgmSheetInfo[arg_17_2].channelPlayer then
		arg_17_0._paintingBgmSheetInfo[arg_17_2].channelPlayer.volume = arg_17_4 * arg_17_5

		print("设置 painting bgm = " .. arg_17_2 .. " 音量 = " .. arg_17_4 .. " 当前音量 = " .. arg_17_0._paintingBgmSheetInfo[arg_17_2].channelPlayer.volume)
	else
		var_0_0.CriMgr.GetInstance():PlaySE_Loop(arg_17_1, arg_17_2, function(arg_18_0)
			if arg_18_0 then
				arg_18_0.channelPlayer.volume = arg_17_4 * arg_17_5

				print("播放 painting bgm = " .. arg_17_2 .. " volume = " .. arg_18_0.channelPlayer.volume)

				arg_17_0._paintingBgmSheetInfo[arg_17_2] = arg_18_0
				arg_17_0._paintingBgmSheetVolume[arg_17_2] = arg_17_4
			end

			return
		end)
	end

	return
end

function pg.CriMgr.ChangePaintingBgmVolume(arg_19_0, arg_19_1)
	if arg_19_0._paintingBgmVolumeRate and arg_19_0._paintingBgmVolumeRate == arg_19_1 then
		return
	end

	arg_19_0._paintingBgmVolumeRate = arg_19_1 or 1

	if arg_19_0._paintingBgmSheetInfo then
		for iter_19_0, iter_19_1 in pairs(arg_19_0._paintingBgmSheetInfo) do
			if iter_19_1 and iter_19_1.channelPlayer then
				iter_19_1.channelPlayer.volume = arg_19_0._paintingBgmSheetVolume[iter_19_0] * arg_19_1

				print("设置 painting bgm = " .. iter_19_0 .. " 音量 = " .. arg_19_1 .. " 当前音量 = " .. iter_19_1.channelPlayer.volume)
			end
		end
	end

	return
end

function pg.CriMgr.StopPaintingBgm(arg_20_0, arg_20_1)
	if arg_20_0._paintingBgmSheetInfo and arg_20_0._paintingBgmSheetInfo[arg_20_1] then
		arg_20_0.criInst:StopSound(arg_20_0._paintingBgmSheetInfo[arg_20_1], CriWareMgr.CRI_FADE_TYPE.FADE_INOUT)

		arg_20_0._paintingBgmSheetInfo[arg_20_1] = nil
	end

	return
end

function pg.CriMgr.DisposePaintingBgm(arg_21_0)
	arg_21_0._paintingBgmSheetInfo = {}
	arg_21_0._paintingBgmSheetVolume = {}

	if arg_21_0._paintingBgmSheets then
		for iter_21_0, iter_21_1 in ipairs(arg_21_0._paintingBgmSheets) do
			var_0_0.CriMgr.GetInstance():UnloadCueSheet(iter_21_1)
		end

		arg_21_0._paintingBgmSheets = nil
	end

	return
end

function pg.CriMgr.LoadCV(arg_22_0, arg_22_1, arg_22_2)
	arg_22_0:LoadCueSheet(var_0_1.GetCVBankName(arg_22_1), arg_22_2)

	return
end

function pg.CriMgr.LoadBattleCV(arg_23_0, arg_23_1, arg_23_2)
	arg_23_0:LoadCueSheet(var_0_1.GetBattleCVBankName(arg_23_1), arg_23_2)

	return
end

function pg.CriMgr.UnloadCVBank(arg_24_0)
	var_0_1.GetInstance():UnloadCueSheet(arg_24_0)

	return
end

function pg.CriMgr.GetCVBankName(arg_25_0)
	return "cv-" .. arg_25_0
end

function pg.CriMgr.GetBattleCVBankName(arg_26_0)
	return "cv-" .. arg_26_0 .. "-battle"
end

function pg.CriMgr.CheckFModeEvent(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	if not arg_27_1 then
		return
	end

	local var_27_0
	local var_27_1

	string.gsub(arg_27_1, "event:/cv/(.+)/(.+)", function(arg_28_0, arg_28_1)
		var_27_0 = "cv-" .. arg_28_0 .. (tobool(ShipWordHelper.CVBattleKey[string.gsub(arg_28_1, "_%w+", "")]) and "-battle" or "") .. (tobool(ShipWordHelper.CVGiftKey[arg_28_1]) and "-gift" or "")
		var_27_1 = arg_28_1

		return
	end)
	string.gsub(arg_27_1, "event:/tb/(.+)/(.+)", function(arg_29_0, arg_29_1)
		var_27_0 = "tb-" .. arg_29_0
		var_27_1 = arg_29_1

		return
	end)
	string.gsub(arg_27_1, "event:/educate/(.+)/(.+)", function(arg_30_0, arg_30_1)
		var_27_0 = "educate-" .. arg_30_0
		var_27_1 = arg_30_1

		return
	end)
	string.gsub(arg_27_1, "event:/dorm/(.+)/(.+)", function(arg_31_0, arg_31_1)
		var_27_0 = arg_31_0
		var_27_1 = arg_31_1

		return
	end)

	if string.find(arg_27_1, "event:/educate%-cv/") then
		local var_27_2 = string.split(arg_27_1, "/")

		var_27_1 = var_27_2[#var_27_2]
		var_27_0 = var_27_2[#var_27_2 - 1]
	end

	if var_27_0 and var_27_1 then
		arg_27_2(var_27_0, var_27_1)
	else
		var_27_1 = arg_27_1
		var_27_1 = string.gsub(arg_27_1, "event:/(battle)/(.+)", "%1-%2")
		var_27_1 = string.gsub(arg_27_1, "event:/(ui)/(.+)", "%1-%2")

		arg_27_3(arg_27_1)
	end

	return var_27_0
end

function pg.CriMgr.CheckHasCue(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = CriWare.CriAtom.GetCueSheet(arg_32_1)

	return var_32_0 ~= nil and var_32_0.acb:Exists(arg_32_2)
end

function pg.CriMgr.PlaySoundEffect_V3(arg_33_0, arg_33_1, arg_33_2)
	arg_33_0:CheckFModeEvent(arg_33_1, function(arg_34_0, arg_34_1)
		arg_33_0:PlayCV_V3(arg_34_0, arg_34_1, arg_33_2)

		return
	end, function(arg_35_0)
		arg_33_0:PlaySE_V3(arg_35_0, arg_33_2)

		return
	end)

	return
end

function pg.CriMgr.PlayMultipleSound_V3(arg_36_0, arg_36_1, arg_36_2)
	arg_36_0:CheckFModeEvent(arg_36_1, function(arg_37_0, arg_37_1)
		arg_36_0:CreateCvMultipleHandler(arg_37_0, arg_37_1, arg_36_2)

		return
	end, function(arg_38_0)
		arg_36_0:PlaySE_V3(arg_38_0, arg_36_2)

		return
	end)

	return
end

function pg.CriMgr.StopSoundEffect_V3(arg_39_0, arg_39_1)
	arg_39_0:CheckFModeEvent(arg_39_1, function(arg_40_0, arg_40_1)
		arg_39_0:StopCV_V3()

		return
	end, function(arg_41_0)
		arg_39_0:StopSE_V3()

		return
	end)

	return
end

function pg.CriMgr.UnloadSoundEffect_V3(arg_42_0, arg_42_1)
	arg_42_0:CheckFModeEvent(arg_42_1, function(arg_43_0, arg_43_1)
		arg_42_0:UnloadCueSheet(arg_43_0)

		return
	end, function(arg_44_0)
		arg_42_0:StopSE_V3()

		return
	end)

	return
end

function pg.CriMgr.PlayCV_V3(arg_45_0, arg_45_1, arg_45_2, arg_45_3)
	assert(arg_45_1, "cueSheetName can not be nil.")
	assert(arg_45_2, "cueName can not be nil.")
	arg_45_0.criInst:PlayVoice(arg_45_2, CriWareMgr.CRI_FADE_TYPE.NONE, arg_45_1, function(arg_46_0)
		if arg_45_3 ~= nil then
			arg_45_3(arg_46_0)
		end

		return
	end)

	return
end

function pg.CriMgr.CreateCvMultipleHandler(arg_47_0, arg_47_1, arg_47_2, arg_47_3)
	if not arg_47_0.luHandle then
		arg_47_0.luHandle = LateUpdateBeat:CreateListener(arg_47_0.LateCvHandler, arg_47_0)

		LateUpdateBeat:AddListener(arg_47_0.luHandle)
	end

	arg_47_0.cvCacheDataList = arg_47_0.cvCacheDataList or {}

	local var_47_0 = true

	for iter_47_0, iter_47_1 in ipairs(arg_47_0.cvCacheDataList) do
		if iter_47_1[1] == arg_47_1 and iter_47_1[2] == arg_47_2 then
			var_47_0 = false

			break
		end
	end

	if var_47_0 then
		arg_47_0.cvCacheDataList[#arg_47_0.cvCacheDataList + 1] = {
			arg_47_1,
			arg_47_2,
			arg_47_3
		}
	end

	return
end

function pg.CriMgr.LateCvHandler(arg_48_0)
	for iter_48_0, iter_48_1 in ipairs(arg_48_0.cvCacheDataList) do
		local var_48_0 = iter_48_1[3]

		if iter_48_0 == 1 then
			arg_48_0.criInst:PlayVoice(iter_48_1[2], CriWareMgr.CRI_FADE_TYPE.NONE, iter_48_1[1], function(arg_49_0)
				if var_48_0 ~= nil then
					var_48_0(arg_49_0)
				end

				return
			end)
		else
			local var_48_1 = CueData.GetCueData()

			var_48_1.cueSheetName = iter_48_1[1]
			var_48_1.channelName = var_0_1.C_BATTLE_CV_EXTRA
			var_48_1.cueName = iter_48_1[2]

			onDelayTick(function()
				arg_48_0.criInst:PlaySound(var_48_1, CriWareMgr.CRI_FADE_TYPE.FADE_CROSS, function(arg_51_0)
					if var_48_0 ~= nil then
						var_48_0(arg_51_0)
					end

					return
				end)

				return
			end, iter_48_0 * 0.4)
		end
	end

	arg_48_0.cvCacheDataList = nil

	if arg_48_0.luHandle then
		LateUpdateBeat:RemoveListener(arg_48_0.luHandle)

		arg_48_0.luHandle = nil
	end

	return
end

function pg.CriMgr.StopCV_V3(arg_52_0)
	arg_52_0.criInst:GetChannelData(var_0_1.C_VOICE).channelPlayer:Stop()

	return
end

function pg.CriMgr.PlaySE_V3(arg_53_0, arg_53_1, arg_53_2)
	assert(arg_53_1, "cueName can not be nil.")
	arg_53_0.criInst:PlayAnySE(arg_53_1, nil, function(arg_54_0)
		if arg_53_2 ~= nil then
			arg_53_2(arg_54_0)
		end

		return
	end)

	return
end

function pg.CriMgr.StopSE_V3(arg_55_0)
	arg_55_0.criInst:GetChannelData(var_0_1.C_SE).channelPlayer:Stop()
	arg_55_0.criInst:GetChannelData(var_0_1.C_BATTLE_SE).channelPlayer:Stop()

	return
end

function pg.CriMgr.StopSEBattle_V3(arg_56_0)
	arg_56_0.criInst:GetChannelData(var_0_1.C_BATTLE_SE).channelPlayer:Stop()

	return
end

function pg.CriMgr.PlaySE_Loop(arg_57_0, arg_57_1, arg_57_2, arg_57_3)
	arg_57_0.criInst:PlaySound(CueData.GetCueDataAndInit(var_0_1.C_SE_LOOP, arg_57_1, arg_57_2), CriWareMgr.CRI_FADE_TYPE.FADE_INOUT, function(arg_58_0)
		if arg_57_3 ~= nil then
			arg_57_3(arg_58_0)
		end

		return
	end)

	return
end

function pg.CriMgr.StopSE_Loop(arg_59_0, arg_59_1, arg_59_2)
	arg_59_0.criInst:StopSound(CueData.GetCueDataAndInit(var_0_1.C_SE_LOOP, arg_59_1, arg_59_2), CriWareMgr.CRI_FADE_TYPE.FADE_INOUT)

	return
end

function pg.CriMgr.LoadCueSheet(arg_60_0, arg_60_1, arg_60_2)
	local var_60_0 = CueData.GetCueData()

	var_60_0.cueSheetName = arg_60_1

	arg_60_0.criInst:LoadCueSheet(var_60_0, function(arg_61_0)
		existCall(arg_60_2, arg_61_0)

		return
	end, true)

	return
end

function pg.CriMgr.UnloadCueSheet(arg_62_0, arg_62_1)
	arg_62_0.criInst:UnloadCueSheet(arg_62_1)

	return
end

function pg.CriMgr.getCVVolume(arg_63_0)
	return PlayerPrefs.GetFloat("cv_vol", DEFAULT_CVVOLUME)
end

function pg.CriMgr.setCVVolume(arg_64_0, arg_64_1)
	PlayerPrefs.SetFloat("cv_vol", arg_64_1)
	CriWare.CriAtom.SetCategoryVolume(var_0_1.Category_CV, arg_64_1)
	CriWare.CriAtom.SetCategoryVolume(var_0_1.Category_Mute_Other_CV, arg_64_1)

	return
end

function pg.CriMgr.getBGMVolume(arg_65_0)
	return PlayerPrefs.GetFloat("bgm_vol", DEFAULT_BGMVOLUME)
end

function pg.CriMgr.setBGMVolume(arg_66_0, arg_66_1)
	PlayerPrefs.SetFloat("bgm_vol", arg_66_1)
	CriWare.CriAtom.SetCategoryVolume(var_0_1.Category_BGM, arg_66_1)

	return
end

function pg.CriMgr.changeBGMVolume(arg_67_0, arg_67_1)
	CriWare.CriAtom.SetCategoryVolume(var_0_1.Category_BGM, arg_67_1)

	return
end

function pg.CriMgr.getSEVolume(arg_68_0)
	return PlayerPrefs.GetFloat("se_vol", DEFAULT_SEVOLUME)
end

function pg.CriMgr.setSEVolume(arg_69_0, arg_69_1)
	PlayerPrefs.SetFloat("se_vol", arg_69_1)
	CriWare.CriAtom.SetCategoryVolume(var_0_1.Category_SE, arg_69_1)

	return
end

function pg.CriMgr.MuteAllVolume(arg_70_0)
	CriWare.CriAtom.SetCategoryVolume(var_0_1.Category_CV, 0)
	CriWare.CriAtom.SetCategoryVolume(var_0_1.Category_Mute_Other_CV, 0)
	CriWare.CriAtom.SetCategoryVolume(var_0_1.Category_BGM, 0)
	CriWare.CriAtom.SetCategoryVolume(var_0_1.Category_SE, 0)

	return
end

function pg.CriMgr.ResetAllVolume(arg_71_0)
	CriWare.CriAtom.SetCategoryVolume(var_0_1.Category_CV, arg_71_0:getCVVolume())
	CriWare.CriAtom.SetCategoryVolume(var_0_1.Category_Mute_Other_CV, arg_71_0:getCVVolume())
	CriWare.CriAtom.SetCategoryVolume(var_0_1.Category_BGM, arg_71_0:getBGMVolume())
	CriWare.CriAtom.SetCategoryVolume(var_0_1.Category_SE, arg_71_0:getSEVolume())

	return
end

function pg.CriMgr.InitBgmCfg(arg_72_0, arg_72_1)
	arg_72_0.isDefaultBGM = false

	if OPEN_SPECIAL_IP_BGM and PLATFORM_CODE == PLATFORM_US then
		if Application.isEditor then
			if arg_72_1 then
				arg_72_1()
			end

			return
		end

		local var_72_0 = {
			"Malaysia",
			"Indonesia"
		}

		local function var_72_2(arg_73_0)
			local var_73_0, var_73_1 = string.find(arg_73_0, "\"country\":\"")

			if var_73_1 then
				arg_73_0 = string.sub(arg_73_0, var_73_1 + 1)
			end

			local var_73_2 = string.find(arg_73_0, "\",")

			if var_73_2 then
				arg_73_0 = string.sub(arg_73_0, 1, var_73_2 - 1)
			end

			return arg_73_0
		end

		local function var_72_3(arg_74_0)
			local var_74_0 = false

			for iter_74_0, iter_74_1 in ipairs(var_72_0) do
				if iter_74_1 == arg_74_0 then
					var_74_0 = true
				end
			end

			return var_74_0
		end

		VersionMgr.Inst:WebRequest("https://pro.ip-api.com/json/?key=TShzQlq7O9KuthI", function(arg_75_0, arg_75_1)
			local var_75_0 = var_72_2(arg_75_1)

			originalPrint("content: " .. arg_75_1)
			originalPrint("country is: " .. var_75_0)

			arg_72_0.isDefaultBGM = var_72_3(var_75_0)

			originalPrint("IP limit: " .. tostring(arg_72_0.isDefaultBGM))

			if arg_72_1 then
				arg_72_1()
			end

			return
		end)
	elseif arg_72_1 then
		arg_72_1()
	end

	return
end

function pg.CriMgr.IsDefaultBGM(arg_76_0)
	return arg_76_0.isDefaultBGM
end

function pg.CriMgr.getAtomSource(arg_77_0, arg_77_1)
	return GetComponent(GameObject.Find("CRIWARE/" .. arg_77_1), "CriAtomSource")
end

function pg.CriMgr.GetCueInfo(arg_78_0, arg_78_1, arg_78_2, arg_78_3, arg_78_4)
	arg_78_0:LoadCueSheet(arg_78_1, function(arg_79_0)
		if not arg_79_0 then
			warning("加载CueSheet失败")

			return
		end

		arg_78_3((arg_78_0.criInst:GetCueInfo(arg_78_1, arg_78_2)))

		if not arg_78_4 then
			arg_78_0:UnloadCueSheet(arg_78_1)
		end

		return
	end)

	return
end

function pg.CriMgr.SetBgmWaveAnalyzerOnCapture(arg_80_0, arg_80_1, arg_80_2)
	arg_80_0.bgmWaveAnalyzer.OnCaptureL = arg_80_1
	arg_80_0.bgmWaveAnalyzer.OnCaptureR = arg_80_2

	return
end

return

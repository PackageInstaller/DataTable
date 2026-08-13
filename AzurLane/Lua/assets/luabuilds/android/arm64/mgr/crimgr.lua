pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
singletonClass = var_0_10001
var_0.CriMgr = var_0_10001("CriMgr")

local var_0_1 = var_0.CriMgr

var_0_1.Category_CV = "Category_CV"
var_0_1.Category_BGM = "Category_BGM"
var_0_1.Category_SE = "Category_SE"
var_0_1.Category_Mute_Other_CV = "Mute_Other_CV"
var_0_1.C_BGM = "C_BGM"
var_0_1.C_VOICE = "cv"
var_0_1.C_SE = "C_SE"
var_0_1.C_BATTLE_SE = "C_BATTLE_SE"
var_0_1.C_GALLERY_MUSIC = "C_GALLERY_MUSIC"
var_0_1.C_BATTLE_CV_EXTRA = "C_BATTLE_CV_EXTRA"
var_0_1.C_TIMELINE = "C_TIMELINE"
var_0_1.C_SE_LOOP = "C_SE_LOOP"
var_0_1.NEXT_VER = 40

function var_0_1.Init(arg_1_0, arg_1_1)
	print = var_1_10002

	var_1_10002("initializing cri manager...")

	seriesAsync = var_1_10002

	var_1_10002({
		function(arg_2_0)
			local var_2_0 = arg_1_0

			var_1.InitCri(var_2_0, arg_2_0)

			return
		end,
		function(arg_3_0)
			CueData = var_2_10001

			local var_3_0 = var_2_10001.GetCueData()

			var_3_0.cueSheetName = "se-ui"
			var_3_0.channelName = var_0_1.C_SE

			local var_3_1 = arg_1_0.criInst

			var_2.LoadCueSheet(var_3_1, var_3_0, function(arg_4_0)
				arg_3_0()

				return
			end, true)

			return
		end,
		function(arg_5_0)
			CueData = var_2_10001

			local var_5_0 = var_2_10001.GetCueData()

			var_5_0.cueSheetName = "se-battle"
			var_5_0.channelName = var_0_1.C_BATTLE_SE

			local var_5_1 = arg_1_0.criInst

			var_2.LoadCueSheet(var_5_1, var_5_0, function(arg_6_0)
				arg_5_0()

				return
			end, true)

			return
		end,
		function(arg_7_0)
			local var_7_0 = arg_1_0

			var_1.InitBgmCfg(var_7_0, arg_7_0)

			return
		end
	}, arg_1_1)

	return
end

function var_0_1.InitCri(arg_8_0, arg_8_1)
	GameObject = var_1_10002

	local var_8_0 = var_1_10002.Find("CRIWARE")
	local var_8_1 = var_2.AddComponent

	typeof = var_1_10006
	CriWareMgr = var_1_10008

	var_8_1(var_8_0, var_1_10006(var_1_10008))

	local var_8_2 = var_2
	local var_8_3 = var_2.GetComponent

	typeof = var_6
	CriWare = var_1_10008
	arg_8_0.criInitializer = var_8_3(var_8_2, var_6(var_1_10008.CriWareInitializer))
	arg_8_0.criInitializer.fileSystemConfig.numberOfLoaders = 128
	arg_8_0.criInitializer.manaConfig.numberOfDecoders = 128
	arg_8_0.criInitializer.atomConfig.useRandomSeedWithTime = true
	arg_8_0.criInitializer.DecrypterConfig.key = "621561580448882"

	local var_8_4 = arg_8_0.criInitializer

	var_3.Initialize(var_8_4)

	CriWareMgr = var_3
	arg_8_0.criInst = var_3.Inst

	local var_8_5 = arg_8_0.criInst

	var_3.Init(var_8_5, function()
		local var_9_0 = arg_8_0

		var_0.ResetAllVolume(var_9_0)

		local var_9_1 = arg_8_0.criInst
		local var_9_2 = var_0.GetChannelData(var_9_1, var_0_1.C_VOICE)
		local var_9_3 = arg_8_0.criInst
		local var_9_4 = var_1.CreateChannel
		local var_9_5 = var_0_1.C_GALLERY_MUSIC

		CriWareMgr = var_2_10005

		var_9_4(var_9_3, var_9_5, var_2_10005.CRI_CHANNEL_TYPE.SINGLE)

		local var_9_6 = arg_8_0.criInst

		var_1.GetChannelData(var_9_6, var_0_1.C_BGM).channelPlayer.loop = true

		local var_9_7 = arg_8_0.criInst
		local var_9_8 = var_1.CreateChannel
		local var_9_9 = var_0_1.C_BATTLE_CV_EXTRA

		CriWareMgr = var_5

		var_9_8(var_9_7, var_9_9, var_5.CRI_CHANNEL_TYPE.SINGLE)

		local var_9_10 = arg_8_0.criInst

		var_1.GetChannelData(var_9_10, var_0_1.C_BATTLE_CV_EXTRA).channelPlayer.volume = 0.6

		local var_9_11 = arg_8_0.criInst
		local var_9_12 = var_1.CreateChannel
		local var_9_13 = var_0_1.C_SE_LOOP

		CriWareMgr = var_5

		var_9_12(var_9_11, var_9_13, var_5.CRI_CHANNEL_TYPE.MULTI_NOT_REPEAT)

		local var_9_14 = arg_8_0.criInst
		local var_9_15 = var_1.GetChannelData(var_9_14, var_0_1.C_SE_LOOP).channelPlayer

		var_9_15.loop = true
		GameObject = var_9_15

		local var_9_16 = var_9_15.Find("CRIWARE/C_BGM")
		local var_9_17 = arg_8_0

		GetOrAddComponent = var_3

		local var_9_18 = var_9_16

		typeof = var_2_10006
		CriAtomWaveAnalyzer = var_2_10008
		var_9_17.bgmWaveAnalyzer = var_3(var_9_18, var_2_10006(var_2_10008))

		local var_9_19 = arg_8_0.bgmWaveAnalyzer

		var_2.Init(var_9_19)
		arg_8_1()

		return
	end)

	return
end

function var_0_1.PlayBGM(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = "bgm-" .. arg_10_1

	if arg_10_0.bgmName == var_10_0 then
		return
	end

	arg_10_0.bgmName = var_10_0

	local var_10_1 = arg_10_0.criInst
	local var_10_2 = var_4.PlayBGM
	local var_10_3 = var_10_0

	CriWareMgr = var_1_10008

	var_10_2(var_10_1, var_10_3, var_1_10008.CRI_FADE_TYPE.FADE_INOUT, function(arg_11_0)
		if arg_11_0 == nil then
			warning = var_2_10001

			local var_11_0 = "Missing BGM :"
			local var_11_1

			if not arg_10_1 then
				var_11_1 = "NIL"
			end

			var_2_10001(var_11_0 .. var_11_1)
		end

		return
	end)

	return
end

function var_0_1.StopBGM(arg_12_0)
	local var_12_0 = arg_12_0.criInst
	local var_12_1 = var_1.StopBGM

	CriWareMgr = var_1_10004

	var_12_1(var_12_0, var_1_10004.CRI_FADE_TYPE.FADE_INOUT)

	arg_12_0.bgmName = nil

	return
end

function var_0_1.StopPlaybackInfoForce(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1.playback

	var_2.Stop(var_13_0, true)

	return
end

function var_0_1.playCueSheetVoice(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	assert = var_1_10005

	var_1_10005(arg_14_1, "cueSheetName can not be nil.")

	assert = var_1_10005

	var_1_10005(arg_14_2, "cueName can not be nil.")

	if arg_14_3 then
		local var_14_0 = arg_14_0.criInst

		var_5.PlaySE(var_14_0, arg_14_2, arg_14_1, function(arg_15_0)
			if arg_14_4 ~= nil then
				arg_14_4(arg_15_0)
			end

			return
		end)
	else
		local var_14_1 = arg_14_0.criInst
		local var_14_2 = var_5.PlayVoice
		local var_14_3 = arg_14_2

		CriWareMgr = var_1_10009

		var_14_2(var_14_1, var_14_3, var_1_10009.CRI_FADE_TYPE.NONE, arg_14_1, function(arg_16_0)
			if arg_14_4 ~= nil then
				arg_14_4(arg_16_0)
			end

			return
		end)
	end

	return
end

function var_0_1.PlayPaintingBgm(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4, arg_17_5)
	if not arg_17_0._paintingBgmSheets then
		arg_17_0._paintingBgmSheets = {}
	end

	if not arg_17_0._paintingBgmSheetInfo then
		arg_17_0._paintingBgmSheetInfo = {}
	end

	if not arg_17_0._paintingBgmSheetVolume then
		arg_17_0._paintingBgmSheetVolume = {}
	end

	table = var_6

	if not var_6.contains(arg_17_0._paintingBgmSheets, arg_17_1) then
		table = var_6

		var_6.insert(arg_17_0._paintingBgmSheets, arg_17_1)
	end

	if arg_17_3 and arg_17_0._paintingBgmSheetInfo[arg_17_2] then
		return
	end

	arg_17_0._paintingBgmVolumeRate = arg_17_5 or 1

	if arg_17_0._paintingBgmSheetInfo[arg_17_2] and arg_17_0._paintingBgmSheetInfo[arg_17_2].channelPlayer then
		local var_17_0 = arg_17_0._paintingBgmSheetInfo[arg_17_2].channelPlayer

		var_17_0.volume = arg_17_4 * arg_17_5
		print = var_17_0

		var_17_0("设置 painting bgm = " .. arg_17_2 .. " 音量 = " .. arg_17_4 .. " 当前音量 = " .. arg_17_0._paintingBgmSheetInfo[arg_17_2].channelPlayer.volume)
	else
		local var_17_1 = var_0.CriMgr.GetInstance()

		var_6.PlaySE_Loop(var_17_1, arg_17_1, arg_17_2, function(arg_18_0)
			if arg_18_0 then
				local var_18_0 = arg_18_0.channelPlayer

				var_18_0.volume = arg_17_4 * arg_17_5
				print = var_18_0

				var_18_0("播放 painting bgm = " .. arg_17_2 .. " volume = " .. arg_18_0.channelPlayer.volume)

				arg_17_0._paintingBgmSheetInfo[arg_17_2] = arg_18_0
				arg_17_0._paintingBgmSheetVolume[arg_17_2] = arg_17_4
			end

			return
		end)
	end

	return
end

function var_0_1.ChangePaintingBgmVolume(arg_19_0, arg_19_1)
	if arg_19_0._paintingBgmVolumeRate and arg_19_0._paintingBgmVolumeRate == arg_19_1 then
		return
	end

	arg_19_0._paintingBgmVolumeRate = arg_19_1 or 1

	if arg_19_0._paintingBgmSheetInfo then
		pairs = var_2

		for iter_19_0, iter_19_1 in var_2(arg_19_0._paintingBgmSheetInfo) do
			if iter_19_1 and iter_19_1.channelPlayer then
				local var_19_0 = iter_19_1.channelPlayer

				var_19_0.volume = arg_19_0._paintingBgmSheetVolume[iter_19_0] * arg_19_1
				print = var_19_0

				var_19_0("设置 painting bgm = " .. iter_19_0 .. " 音量 = " .. arg_19_1 .. " 当前音量 = " .. iter_19_1.channelPlayer.volume)
			end
		end
	end

	return
end

function var_0_1.StopPaintingBgm(arg_20_0, arg_20_1)
	if arg_20_0._paintingBgmSheetInfo and arg_20_0._paintingBgmSheetInfo[arg_20_1] then
		local var_20_0 = arg_20_0.criInst
		local var_20_1 = var_2.StopSound
		local var_20_2 = arg_20_0._paintingBgmSheetInfo[arg_20_1]

		CriWareMgr = var_1_10006

		var_20_1(var_20_0, var_20_2, var_1_10006.CRI_FADE_TYPE.FADE_INOUT)

		arg_20_0._paintingBgmSheetInfo[arg_20_1] = nil
	end

	return
end

function var_0_1.DisposePaintingBgm(arg_21_0)
	arg_21_0._paintingBgmSheetInfo = {}
	arg_21_0._paintingBgmSheetVolume = {}

	if arg_21_0._paintingBgmSheets then
		ipairs = var_1

		for iter_21_0, iter_21_1 in var_1(arg_21_0._paintingBgmSheets) do
			local var_21_0 = var_0.CriMgr.GetInstance()

			var_6.UnloadCueSheet(var_21_0, iter_21_1)
		end

		arg_21_0._paintingBgmSheets = nil
	end

	return
end

function var_0_1.LoadCV(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = var_0_1.GetCVBankName(arg_22_1)

	arg_22_0:LoadCueSheet(var_22_0, arg_22_2)

	return
end

function var_0_1.LoadBattleCV(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = var_0_1.GetBattleCVBankName(arg_23_1)

	arg_23_0:LoadCueSheet(var_23_0, arg_23_2)

	return
end

function var_0_1.UnloadCVBank(arg_24_0)
	local var_24_0 = var_0_1.GetInstance()

	var_1.UnloadCueSheet(var_24_0, arg_24_0)

	return
end

function var_0_1.GetCVBankName(arg_25_0)
	return "cv-" .. arg_25_0
end

function var_0_1.GetBattleCVBankName(arg_26_0)
	return "cv-" .. arg_26_0 .. "-battle"
end

function var_0_1.CheckFModeEvent(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	if not arg_27_1 then
		return
	end

	local var_27_0
	local var_27_1

	string = var_1_10006

	var_1_10006.gsub(arg_27_1, "event:/cv/(.+)/(.+)", function(arg_28_0, arg_28_1)
		string = var_2_10002

		local var_28_0 = var_2_10002.gsub(arg_28_1, "_%w+", "")

		tobool = var_2_10003
		ShipWordHelper = var_5

		local var_28_1 = var_2_10003(var_5.CVBattleKey[var_28_0])

		tobool = var_4
		ShipWordHelper = var_6

		local var_28_2 = var_4(var_6.CVGiftKey[arg_28_1])

		var_27_0 = "cv-" .. arg_28_0 .. (var_28_1 and "-battle" or "") .. (var_28_2 and "-gift" or "")
		var_27_1 = arg_28_1

		return
	end)

	string = var_6

	var_6.gsub(arg_27_1, "event:/tb/(.+)/(.+)", function(arg_29_0, arg_29_1)
		var_27_0 = "tb-" .. arg_29_0
		var_27_1 = arg_29_1

		return
	end)

	string = var_6

	var_6.gsub(arg_27_1, "event:/educate/(.+)/(.+)", function(arg_30_0, arg_30_1)
		var_27_0 = "educate-" .. arg_30_0
		var_27_1 = arg_30_1

		return
	end)

	string = var_6

	var_6.gsub(arg_27_1, "event:/dorm/(.+)/(.+)", function(arg_31_0, arg_31_1)
		var_27_0 = arg_31_0
		var_27_1 = arg_31_1

		return
	end)

	string = var_6

	if var_6.find(arg_27_1, "event:/educate%-cv/") then
		string = var_6
		var_27_1 = var_6[#var_6.split(arg_27_1, "/")]
		var_27_0 = var_6[#var_6 - 1]
	end

	if var_27_0 and var_27_1 then
		arg_27_2(var_27_0, var_27_1)
	else
		var_27_1 = arg_27_1
		string = var_6
		var_27_1 = var_6.gsub(var_27_1, "event:/(battle)/(.+)", "%1-%2")
		string = var_6
		var_27_1 = var_6.gsub(var_27_1, "event:/(ui)/(.+)", "%1-%2")

		arg_27_3(var_27_1)
	end

	return var_27_0
end

function var_0_1.CheckHasCue(arg_32_0, arg_32_1, arg_32_2)
	CriWare = var_1_10003

	local var_32_1

	if var_1_10003.CriAtom.GetCueSheet(arg_32_1) ~= nil then
		local var_32_0 = var_3.acb

		var_32_1 = var_4.Exists(var_32_0, arg_32_2)
	else
		var_32_1 = false
	end

	if false then
		var_32_1 = true
	end

	return var_32_1
end

function var_0_1.PlaySoundEffect_V3(arg_33_0, arg_33_1, arg_33_2)
	arg_33_0:CheckFModeEvent(arg_33_1, function(arg_34_0, arg_34_1)
		local var_34_0 = arg_33_0

		var_2.PlayCV_V3(var_34_0, arg_34_0, arg_34_1, arg_33_2)

		return
	end, function(arg_35_0)
		local var_35_0 = arg_33_0

		var_1.PlaySE_V3(var_35_0, arg_35_0, arg_33_2)

		return
	end)

	return
end

function var_0_1.PlayMultipleSound_V3(arg_36_0, arg_36_1, arg_36_2)
	arg_36_0:CheckFModeEvent(arg_36_1, function(arg_37_0, arg_37_1)
		local var_37_0 = arg_36_0

		var_2.CreateCvMultipleHandler(var_37_0, arg_37_0, arg_37_1, arg_36_2)

		return
	end, function(arg_38_0)
		local var_38_0 = arg_36_0

		var_1.PlaySE_V3(var_38_0, arg_38_0, arg_36_2)

		return
	end)

	return
end

function var_0_1.StopSoundEffect_V3(arg_39_0, arg_39_1)
	arg_39_0:CheckFModeEvent(arg_39_1, function(arg_40_0, arg_40_1)
		local var_40_0 = arg_39_0

		var_2.StopCV_V3(var_40_0)

		return
	end, function(arg_41_0)
		local var_41_0 = arg_39_0

		var_1.StopSE_V3(var_41_0)

		return
	end)

	return
end

function var_0_1.UnloadSoundEffect_V3(arg_42_0, arg_42_1)
	arg_42_0:CheckFModeEvent(arg_42_1, function(arg_43_0, arg_43_1)
		local var_43_0 = arg_42_0

		var_2.UnloadCueSheet(var_43_0, arg_43_0)

		return
	end, function(arg_44_0)
		local var_44_0 = arg_42_0

		var_1.StopSE_V3(var_44_0)

		return
	end)

	return
end

function var_0_1.PlayCV_V3(arg_45_0, arg_45_1, arg_45_2, arg_45_3)
	assert = var_1_10004

	var_1_10004(arg_45_1, "cueSheetName can not be nil.")

	assert = var_1_10004

	var_1_10004(arg_45_2, "cueName can not be nil.")

	local var_45_0 = arg_45_0.criInst
	local var_45_1 = var_4.PlayVoice
	local var_45_2 = arg_45_2

	CriWareMgr = var_1_10008

	var_45_1(var_45_0, var_45_2, var_1_10008.CRI_FADE_TYPE.NONE, arg_45_1, function(arg_46_0)
		if arg_45_3 ~= nil then
			arg_45_3(arg_46_0)
		end

		return
	end)

	return
end

function var_0_1.CreateCvMultipleHandler(arg_47_0, arg_47_1, arg_47_2, arg_47_3)
	if not arg_47_0.luHandle then
		LateUpdateBeat = var_4
		arg_47_0.luHandle = var_4:CreateListener(arg_47_0.LateCvHandler, arg_47_0)
		LateUpdateBeat = var_4

		var_4:AddListener(arg_47_0.luHandle)
	end

	local var_47_0

	if not arg_47_0.cvCacheDataList then
		var_47_0 = {}
	end

	arg_47_0.cvCacheDataList = var_47_0

	local var_47_1 = true

	ipairs = var_1_10005

	for iter_47_0, iter_47_1 in var_1_10005(arg_47_0.cvCacheDataList) do
		if iter_47_1[1] == arg_47_1 and iter_47_1[2] == arg_47_2 then
			var_47_1 = false

			break
		end
	end

	if var_47_1 then
		arg_47_0.cvCacheDataList[#arg_47_0.cvCacheDataList + 1] = {
			arg_47_1,
			arg_47_2,
			arg_47_3
		}
	end

	return
end

function var_0_1.LateCvHandler(arg_48_0)
	ipairs = var_1_10001

	for iter_48_0, iter_48_1 in var_1_10001(arg_48_0.cvCacheDataList) do
		local var_48_0 = iter_48_1[1]
		local var_48_1 = iter_48_1[2]
		local var_48_2 = iter_48_1[3]

		if iter_48_0 == 1 then
			local var_48_3 = arg_48_0.criInst

			var_1_10009 = var_1_10009.PlayVoice

			local var_48_4 = var_48_1

			CriWareMgr = var_1_10013

			var_1_10009(var_48_3, var_48_4, var_1_10013.CRI_FADE_TYPE.NONE, var_48_0, function(arg_49_0)
				if var_48_2 ~= nil then
					var_48_2(arg_49_0)
				end

				return
			end)
		else
			CueData = var_1_10009
			var_1_10009 = var_1_10009.GetCueData()
			var_1_10009.cueSheetName = var_48_0
			var_1_10009.channelName = var_0_1.C_BATTLE_CV_EXTRA
			var_1_10009.cueName = var_48_1
			onDelayTick = var_10

			var_10(function()
				local var_50_0 = arg_48_0.criInst
				local var_50_1 = var_0.PlaySound
				local var_50_2 = var_1_10009

				CriWareMgr = var_2_10004

				var_50_1(var_50_0, var_50_2, var_2_10004.CRI_FADE_TYPE.FADE_CROSS, function(arg_51_0)
					if var_48_2 ~= nil then
						var_48_2(arg_51_0)
					end

					return
				end)

				return
			end, iter_48_0 * 0.4)
		end
	end

	arg_48_0.cvCacheDataList = nil

	if arg_48_0.luHandle then
		LateUpdateBeat = var_1

		var_1:RemoveListener(arg_48_0.luHandle)

		arg_48_0.luHandle = nil
	end

	return
end

function var_0_1.StopCV_V3(arg_52_0)
	local var_52_0 = arg_52_0.criInst
	local var_52_1 = var_1.GetChannelData(var_52_0, var_0_1.C_VOICE).channelPlayer

	var_1.Stop(var_52_1)

	return
end

function var_0_1.PlaySE_V3(arg_53_0, arg_53_1, arg_53_2)
	assert = var_1_10003

	var_1_10003(arg_53_1, "cueName can not be nil.")

	local var_53_0 = arg_53_0.criInst

	var_3.PlayAnySE(var_53_0, arg_53_1, nil, function(arg_54_0)
		if arg_53_2 ~= nil then
			arg_53_2(arg_54_0)
		end

		return
	end)

	return
end

function var_0_1.StopSE_V3(arg_55_0)
	local var_55_0 = arg_55_0.criInst
	local var_55_1 = var_1.GetChannelData(var_55_0, var_0_1.C_SE).channelPlayer

	var_1.Stop(var_55_1)

	local var_55_2 = arg_55_0.criInst
	local var_55_3 = var_1.GetChannelData(var_55_2, var_0_1.C_BATTLE_SE).channelPlayer

	var_1.Stop(var_55_3)

	return
end

function var_0_1.StopSEBattle_V3(arg_56_0)
	local var_56_0 = arg_56_0.criInst
	local var_56_1 = var_1.GetChannelData(var_56_0, var_0_1.C_BATTLE_SE).channelPlayer

	var_1.Stop(var_56_1)

	return
end

function var_0_1.PlaySE_Loop(arg_57_0, arg_57_1, arg_57_2, arg_57_3)
	CueData = var_1_10004

	local var_57_0 = var_1_10004.GetCueDataAndInit(var_0_1.C_SE_LOOP, arg_57_1, arg_57_2)
	local var_57_1 = arg_57_0.criInst
	local var_57_2 = var_5.PlaySound
	local var_57_3 = var_57_0

	CriWareMgr = var_1_10009

	var_57_2(var_57_1, var_57_3, var_1_10009.CRI_FADE_TYPE.FADE_INOUT, function(arg_58_0)
		if arg_57_3 ~= nil then
			arg_57_3(arg_58_0)
		end

		return
	end)

	return
end

function var_0_1.StopSE_Loop(arg_59_0, arg_59_1, arg_59_2)
	CueData = var_1_10003

	local var_59_0 = var_1_10003.GetCueDataAndInit(var_0_1.C_SE_LOOP, arg_59_1, arg_59_2)
	local var_59_1 = arg_59_0.criInst
	local var_59_2 = var_4.StopSound
	local var_59_3 = var_59_0

	CriWareMgr = var_1_10008

	var_59_2(var_59_1, var_59_3, var_1_10008.CRI_FADE_TYPE.FADE_INOUT)

	return
end

function var_0_1.LoadCueSheet(arg_60_0, arg_60_1, arg_60_2)
	CueData = var_1_10003

	local var_60_0 = var_1_10003.GetCueData()

	var_60_0.cueSheetName = arg_60_1

	local var_60_1 = arg_60_0.criInst

	var_4.LoadCueSheet(var_60_1, var_60_0, function(arg_61_0)
		existCall = var_2_10001

		var_2_10001(arg_60_2, arg_61_0)

		return
	end, true)

	return
end

function var_0_1.UnloadCueSheet(arg_62_0, arg_62_1)
	local var_62_0 = arg_62_0.criInst

	var_2.UnloadCueSheet(var_62_0, arg_62_1)

	return
end

function var_0_1.getCVVolume(arg_63_0)
	PlayerPrefs = var_1_10001

	local var_63_0 = var_1_10001.GetFloat
	local var_63_1 = "cv_vol"

	DEFAULT_CVVOLUME = var_1_10004

	return var_63_0(var_63_1, var_1_10004)
end

function var_0_1.setCVVolume(arg_64_0, arg_64_1)
	PlayerPrefs = var_1_10002

	var_1_10002.SetFloat("cv_vol", arg_64_1)

	CriWare = var_2

	var_2.CriAtom.SetCategoryVolume(var_0_1.Category_CV, arg_64_1)

	CriWare = var_2

	var_2.CriAtom.SetCategoryVolume(var_0_1.Category_Mute_Other_CV, arg_64_1)

	return
end

function var_0_1.getBGMVolume(arg_65_0)
	PlayerPrefs = var_1_10001

	local var_65_0 = var_1_10001.GetFloat
	local var_65_1 = "bgm_vol"

	DEFAULT_BGMVOLUME = var_1_10004

	return var_65_0(var_65_1, var_1_10004)
end

function var_0_1.setBGMVolume(arg_66_0, arg_66_1)
	PlayerPrefs = var_1_10002

	var_1_10002.SetFloat("bgm_vol", arg_66_1)

	CriWare = var_2

	var_2.CriAtom.SetCategoryVolume(var_0_1.Category_BGM, arg_66_1)

	return
end

function var_0_1.changeBGMVolume(arg_67_0, arg_67_1)
	CriWare = var_1_10002

	var_1_10002.CriAtom.SetCategoryVolume(var_0_1.Category_BGM, arg_67_1)

	return
end

function var_0_1.getSEVolume(arg_68_0)
	PlayerPrefs = var_1_10001

	local var_68_0 = var_1_10001.GetFloat
	local var_68_1 = "se_vol"

	DEFAULT_SEVOLUME = var_1_10004

	return var_68_0(var_68_1, var_1_10004)
end

function var_0_1.setSEVolume(arg_69_0, arg_69_1)
	PlayerPrefs = var_1_10002

	var_1_10002.SetFloat("se_vol", arg_69_1)

	CriWare = var_2

	var_2.CriAtom.SetCategoryVolume(var_0_1.Category_SE, arg_69_1)

	return
end

function var_0_1.MuteAllVolume(arg_70_0)
	CriWare = var_1_10001

	var_1_10001.CriAtom.SetCategoryVolume(var_0_1.Category_CV, 0)

	CriWare = var_1

	var_1.CriAtom.SetCategoryVolume(var_0_1.Category_Mute_Other_CV, 0)

	CriWare = var_1

	var_1.CriAtom.SetCategoryVolume(var_0_1.Category_BGM, 0)

	CriWare = var_1

	var_1.CriAtom.SetCategoryVolume(var_0_1.Category_SE, 0)

	return
end

function var_0_1.ResetAllVolume(arg_71_0)
	CriWare = var_1_10001

	var_1_10001.CriAtom.SetCategoryVolume(var_0_1.Category_CV, arg_71_0:getCVVolume())

	CriWare = var_1

	var_1.CriAtom.SetCategoryVolume(var_0_1.Category_Mute_Other_CV, arg_71_0:getCVVolume())

	CriWare = var_1

	var_1.CriAtom.SetCategoryVolume(var_0_1.Category_BGM, arg_71_0:getBGMVolume())

	CriWare = var_1

	var_1.CriAtom.SetCategoryVolume(var_0_1.Category_SE, arg_71_0:getSEVolume())

	return
end

function var_0_1.InitBgmCfg(arg_72_0, arg_72_1)
	arg_72_0.isDefaultBGM = false
	OPEN_SPECIAL_IP_BGM = var_2

	if var_2 then
		PLATFORM_CODE = var_2
		PLATFORM_US = var_1_10003

		if var_2 == var_1_10003 then
			Application = var_2

			if var_2.isEditor then
				if arg_72_1 then
					arg_72_1()
				end

				return
			end

			local var_72_0 = {
				"Malaysia",
				"Indonesia"
			}
			local var_72_1 = "https://pro.ip-api.com/json/?key=TShzQlq7O9KuthI"
			local var_72_2 = ""

			local function var_72_3(arg_73_0)
				local var_73_0 = "\"country\":\""
				local var_73_1 = "\","

				string = var_2_10003

				local var_73_2, var_73_3 = var_2_10003.find(arg_73_0, var_73_0)

				if var_73_3 then
					string = var_5
					arg_73_0 = var_5.sub(arg_73_0, var_73_3 + 1)
				end

				string = var_5

				if var_5.find(arg_73_0, var_73_1) then
					string = var_6
					arg_73_0 = var_6.sub(arg_73_0, 1, var_5 - 1)
				end

				return arg_73_0
			end

			local function var_72_4(arg_74_0)
				local var_74_0 = false

				ipairs = var_2_10002

				for iter_74_0, iter_74_1 in var_2_10002(var_72_0) do
					if iter_74_1 == arg_74_0 then
						var_74_0 = true
					end
				end

				return var_74_0
			end

			VersionMgr = var_1_10007

			local var_72_5 = var_1_10007.Inst

			var_7.WebRequest(var_72_5, var_72_1, function(arg_75_0, arg_75_1)
				local var_75_0 = var_72_3(arg_75_1)

				originalPrint = var_2_10003

				var_2_10003("content: " .. arg_75_1)

				originalPrint = var_2_10003

				var_2_10003("country is: " .. var_75_0)

				local var_75_1 = arg_72_0

				var_75_1.isDefaultBGM = var_72_4(var_75_0)
				originalPrint = var_75_1

				local var_75_2 = "IP limit: "

				tostring = var_6

				var_75_1(var_75_2 .. var_6(arg_72_0.isDefaultBGM))

				if arg_72_1 then
					arg_72_1()
				end

				return
			end)

			goto label_72_0
		end
	end

	if arg_72_1 then
		arg_72_1()
	end

	::label_72_0::

	return
end

function var_0_1.IsDefaultBGM(arg_76_0)
	return arg_76_0.isDefaultBGM
end

function var_0_1.getAtomSource(arg_77_0, arg_77_1)
	GetComponent = var_1_10002
	GameObject = var_1_10004

	return var_1_10002(var_1_10004.Find("CRIWARE/" .. arg_77_1), "CriAtomSource")
end

function var_0_1.GetCueInfo(arg_78_0, arg_78_1, arg_78_2, arg_78_3, arg_78_4)
	arg_78_0:LoadCueSheet(arg_78_1, function(arg_79_0)
		if not arg_79_0 then
			warning = var_2_10001

			var_2_10001("加载CueSheet失败")

			return
		end

		local var_79_0 = arg_78_0.criInst
		local var_79_1 = var_1.GetCueInfo(var_79_0, arg_78_1, arg_78_2)

		arg_78_3(var_79_1)

		if not arg_78_4 then
			local var_79_2 = arg_78_0

			var_2.UnloadCueSheet(var_79_2, arg_78_1)
		end

		return
	end)

	return
end

function var_0_1.SetBgmWaveAnalyzerOnCapture(arg_80_0, arg_80_1, arg_80_2)
	arg_80_0.bgmWaveAnalyzer.OnCaptureL = arg_80_1
	arg_80_0.bgmWaveAnalyzer.OnCaptureR = arg_80_2

	return
end

return

local var_0_0 = singletonClass("MusicData")
local var_0_1 = {}
local var_0_2 = 0
local var_0_3 = 0
local var_0_4 = {}
local var_0_5 = 0
local var_0_6 = 0
local var_0_7
local var_0_8
local var_0_9
local var_0_10
local var_0_11
local var_0_12
local var_0_13 = false
local var_0_14
local var_0_15
local var_0_16
local var_0_17 = {}
local var_0_18 = {}
local var_0_19 = {}
local var_0_20 = {}
local var_0_21 = {}
local var_0_22 = {}
local var_0_23 = false
local var_0_24 = 0
local var_0_25 = false
local var_0_26 = {}
local var_0_27
local var_0_28
local var_0_29

function var_0_0.Init(arg_1_0)
	var_0_29 = nil
	var_0_1 = {}
	var_0_2 = 0
	var_0_3 = 0
	var_0_4 = {}
	var_0_5 = 0
	var_0_6 = 0
	var_0_14 = nil
	var_0_7 = nil
	var_0_15 = nil
	var_0_8 = nil
	var_0_9 = nil
	var_0_10 = nil
	var_0_16 = nil
	var_0_17 = {}
	var_0_18 = {}
	var_0_19 = {}
	var_0_20 = {}
	var_0_21 = {}
	var_0_24 = 0
	var_0_25 = false
	var_0_27 = nil
	var_0_28 = nil
	var_0_22 = arg_1_0:GetMusicActThemeList()
	var_0_26 = {}

	arg_1_0:InitFilterList()
end

function var_0_0.InitMusicData(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.activity_id
	local var_2_1 = arg_2_1.challenge_info

	for iter_2_0, iter_2_1 in ipairs(var_2_1) do
		local var_2_2 = iter_2_1.id

		var_0_1[var_2_2] = {
			score = iter_2_1.score,
			finishState = iter_2_1.sign
		}
	end
end

function var_0_0.IsInitMusicData(arg_3_0)
	return next(var_0_1) ~= nil
end

function var_0_0.GetTagImagePath(arg_4_0, arg_4_1)
	local var_4_0 = ActivityMusicCfg[arg_4_1].tagname

	if var_4_0 and var_4_0 ~= "" then
		return "TextureConfig/Music/Music_CollabLogo/" .. var_4_0
	else
		return nil
	end
end

function var_0_0.GetScore(arg_5_0, arg_5_1)
	if var_0_1[arg_5_1] then
		return var_0_1[arg_5_1].score
	end

	return 0
end

function var_0_0.GetIsComplete(arg_6_0, arg_6_1)
	if var_0_1[arg_6_1] then
		return var_0_1[arg_6_1].finishState
	end

	return MusicConst.MusicFinishState.Unfinished
end

function var_0_0.SetScore(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if not var_0_1[arg_7_1] then
		var_0_1[arg_7_1] = {
			score = arg_7_2,
			finishState = arg_7_3
		}
	else
		var_0_1[arg_7_1].score = arg_7_2
		var_0_1[arg_7_1].finishState = arg_7_3
	end
end

function var_0_0.GetRewardState(arg_8_0, arg_8_1)
	return
end

function var_0_0.GetTargetAccuracy(arg_9_0, arg_9_1)
	return GameSetting.attach_music_grade.value[arg_9_1] or 0
end

function var_0_0.GetTargetAccuracyDes(arg_10_0, arg_10_1)
	return ({
		"S+",
		"S",
		"A",
		"B",
		"C",
		"F"
	})[arg_10_1] or ""
end

function var_0_0.ResetGameData(arg_11_0)
	var_0_3 = 0
	var_0_4 = {}
	var_0_5 = 0
	var_0_6 = 0
end

function var_0_0.ModifGameData(arg_12_0, arg_12_1)
	if MusicConst.MusicNodeHitRating.PerfectPlus == arg_12_1 then
		var_0_3 = var_0_3 + 101
		var_0_6 = var_0_6 + 1
	elseif MusicConst.MusicNodeHitRating.Perfect == arg_12_1 then
		var_0_3 = var_0_3 + 100
		var_0_6 = var_0_6 + 1
	elseif MusicConst.MusicNodeHitRating.Good == arg_12_1 then
		var_0_3 = var_0_3 + 70
		var_0_6 = var_0_6 + 1
	else
		var_0_6 = 0
	end

	if var_0_6 > var_0_5 then
		var_0_5 = var_0_6
	end

	var_0_4[arg_12_1] = var_0_4[arg_12_1] and var_0_4[arg_12_1] + 1 or 1
end

function var_0_0.GetGameScore(arg_13_0)
	return var_0_3
end

function var_0_0.SetLookBackState(arg_14_0, arg_14_1)
	var_0_23 = arg_14_1
end

function var_0_0.GetLookBackState(arg_15_0)
	return var_0_23
end

function var_0_0.SetGameId(arg_16_0, arg_16_1)
	var_0_2 = arg_16_1
end

function var_0_0.GetGameId(arg_17_0)
	return var_0_2
end

function var_0_0.GetGameRecord(arg_18_0, arg_18_1)
	return var_0_4[arg_18_1] or 0
end

function var_0_0.GetComboHit(arg_19_0)
	return var_0_6
end

function var_0_0.GetMaxComboHit(arg_20_0)
	return var_0_5
end

function var_0_0.SetPageActivityId(arg_21_0, arg_21_1)
	var_0_24 = arg_21_1
end

function var_0_0.GetPageActivityID(arg_22_0)
	return var_0_24
end

function var_0_0.SetSelectedData(arg_23_0, arg_23_1, arg_23_2)
	var_0_27 = arg_23_1
	var_0_28 = arg_23_2
end

function var_0_0.GetSelectData(arg_24_0)
	return var_0_27, var_0_28
end

function var_0_0.SetCacheMusicTreePos(arg_25_0, arg_25_1)
	var_0_29 = arg_25_1
end

function var_0_0.GetCacheMusicTreePos(arg_26_0)
	return var_0_29
end

function var_0_0.GetSpeedValue(arg_27_0, arg_27_1)
	if not var_0_7 then
		var_0_7 = {}
	end

	if not var_0_7[arg_27_1] then
		var_0_7[arg_27_1] = getData("Music", "TrackSpeed" .. tostring(arg_27_1))
	end

	if type(var_0_7[arg_27_1]) ~= "number" then
		var_0_7[arg_27_1] = 3
	else
		var_0_7[arg_27_1] = math.max(var_0_7[arg_27_1], 1)
		var_0_7[arg_27_1] = math.min(var_0_7[arg_27_1], 5)
	end

	return var_0_7[arg_27_1]
end

function var_0_0.SetSpeedValue(arg_28_0, arg_28_1, arg_28_2)
	if not var_0_7 then
		var_0_7 = {}
	end

	var_0_7[arg_28_2] = arg_28_1

	saveData("Music", "TrackSpeed" .. tostring(arg_28_2), arg_28_1)
end

function var_0_0.GetSpeedData(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0:GetSpeedValue(arg_29_1)

	return 45.833333333333336 * var_29_0 * var_29_0 - 562.5 * var_29_0 + 2016.6666666666667
end

function var_0_0.GetConstantSpeed(arg_30_0)
	return (arg_30_0:GetSpeedValue(MusicConst.MusicTrackType.Constant_Slope))
end

function var_0_0.GetJudgeValue(arg_31_0)
	if not var_0_8 then
		var_0_8 = getData("Music", "Judge")
	end

	if type(var_0_8) ~= "number" then
		var_0_8 = 0
	else
		var_0_8 = math.max(var_0_8, -50)
		var_0_8 = math.min(var_0_8, 50)
	end

	return var_0_8
end

function var_0_0.SetJudgeValue(arg_32_0, arg_32_1)
	var_0_8 = arg_32_1

	saveData("Music", "Judge", arg_32_1)
end

function var_0_0.GetJudgeData(arg_33_0)
	local var_33_0 = arg_33_0:GetJudgeValue()
	local var_33_1 = math.abs(var_33_0) / 50 * 300

	if var_33_0 < 0 then
		return -1 * var_33_1
	end

	return var_33_1
end

function var_0_0.GetScreanValue(arg_34_0)
	if not var_0_9 then
		var_0_9 = getData("Music", "Screan")
	end

	if type(var_0_9) ~= "number" then
		var_0_9 = 0
	else
		var_0_9 = math.max(var_0_9, -50)
		var_0_9 = math.min(var_0_9, 50)
	end

	return var_0_9
end

function var_0_0.SetScreanValue(arg_35_0, arg_35_1)
	var_0_9 = arg_35_1

	saveData("Music", "Screan", var_0_9)
end

function var_0_0.GetScreanData(arg_36_0)
	local var_36_0 = arg_36_0:GetScreanValue()
	local var_36_1 = math.abs(var_36_0) / 50 * 300

	if var_36_0 < 0 then
		return -1 * var_36_1
	end

	return var_36_1
end

function var_0_0.GetVolumeValue(arg_37_0)
	if not var_0_10 then
		var_0_10 = getData("Music", "Volume")
	end

	if type(var_0_10) ~= "number" then
		var_0_10 = 50
	else
		var_0_10 = math.max(var_0_10, 0)
		var_0_10 = math.min(var_0_10, 100)
	end

	return var_0_10
end

function var_0_0.SetVolumeValue(arg_38_0, arg_38_1)
	var_0_10 = arg_38_1

	saveData("Music", "Volume", var_0_10)
end

function var_0_0.GetVolumeData(arg_39_0)
	local var_39_0 = arg_39_0:GetVolumeValue()

	return math.abs(var_39_0) / 100
end

function var_0_0.GetShowMovie(arg_40_0)
	if not var_0_11 then
		var_0_11 = getData("Music", "ShowMovie")
	end

	if type(var_0_11) ~= "number" then
		var_0_11 = 1
	end

	return var_0_11 ~= 0
end

function var_0_0.SetShoMovie(arg_41_0, arg_41_1)
	var_0_11 = arg_41_1 and 1 or 0

	saveData("Music", "ShowMovie", var_0_11)
end

function var_0_0.GetVerical(arg_42_0)
	if not var_0_13 then
		var_0_13 = getData("Music", "isVertical")
	end

	if type(var_0_13) ~= "number" then
		var_0_13 = 0
	end

	return var_0_13 ~= 0
end

function var_0_0.SetVerical(arg_43_0, arg_43_1)
	var_0_13 = arg_43_1 and 1 or 0

	saveData("Music", "isVertical", var_0_13)
end

function var_0_0.GetTrackPathType(arg_44_0)
	if not var_0_14 then
		var_0_14 = getData("Music", "useTrackPathType")
	end

	if type(var_0_14) ~= "number" then
		var_0_14 = MusicConst.MusicTrackType.Slope
	end

	return var_0_14
end

function var_0_0.SetTrackPathType(arg_45_0, arg_45_1)
	var_0_14 = arg_45_1

	saveData("Music", "useTrackPathType", var_0_14)
end

function var_0_0.GetSpectralType(arg_46_0)
	if not var_0_15 then
		var_0_15 = getData("Music", "SpectralType")
	end

	if type(var_0_15) ~= "number" then
		var_0_15 = 0
	end

	return var_0_15
end

function var_0_0.SetSpectralType(arg_47_0, arg_47_1)
	var_0_15 = arg_47_1

	saveData("Music", "SpectralType", var_0_15)
end

function var_0_0.GetSpectralAndVercialSDKKey(arg_48_0)
	local var_48_0 = "[" .. arg_48_0:GetSpectralType() + 1 .. ","

	if arg_48_0:GetVerical() then
		var_48_0 = var_48_0 .. 1
	else
		var_48_0 = var_48_0 .. 2
	end

	return var_48_0 .. "]"
end

function var_0_0.GetSpectralSendData(arg_49_0)
	local var_49_0 = {}

	table.insert(var_49_0, arg_49_0:GetSpectralType() + 1)

	if arg_49_0:GetVerical() then
		table.insert(var_49_0, 1)
	else
		table.insert(var_49_0, 2)
	end

	return var_49_0
end

function var_0_0.GetMixValue(arg_50_0)
	if not var_0_16 then
		var_0_16 = getData("Music", "MixRangeValue")
	end

	if type(var_0_16) ~= "number" then
		var_0_16 = 0.5
	end

	return var_0_16
end

function var_0_0.SetMixValue(arg_51_0, arg_51_1)
	var_0_16 = arg_51_1

	saveData("Music", "MixRangeValue", var_0_16)
end

function var_0_0.GetPlayKeyEffectSound(arg_52_0)
	if not var_0_12 then
		var_0_12 = getData("Music", "PlayKeyEffectSound")
	end

	if type(var_0_12) ~= "number" then
		var_0_12 = 1
	end

	return var_0_12 ~= 0
end

function var_0_0.SetPlayKeyEffectSound(arg_53_0, arg_53_1)
	var_0_12 = arg_53_1 and 1 or 0

	saveData("Music", "PlayKeyEffectSound", var_0_12)
end

function var_0_0.GetDifficultyIndex(arg_54_0, arg_54_1)
	if var_0_17 == nil then
		var_0_17 = {}
	end

	if not var_0_17[arg_54_1] then
		var_0_17[arg_54_1] = getData("Music", "SelectDiffcult" .. tostring(arg_54_1))
	end

	if type(var_0_17[arg_54_1]) ~= "number" then
		var_0_17[arg_54_1] = 1
	end

	return var_0_17[arg_54_1]
end

function var_0_0.SetDifficultIndex(arg_55_0, arg_55_1, arg_55_2)
	var_0_17[arg_55_1] = arg_55_2

	saveData("Music", "SelectDiffcult" .. tostring(arg_55_1), arg_55_2)
end

function var_0_0.GetTrackCount(arg_56_0, arg_56_1)
	if var_0_18 == nil then
		var_0_18 = {}
	end

	if not var_0_18[arg_56_1] then
		var_0_18[arg_56_1] = getData("Music", "SelectTrackCount" .. tostring(arg_56_1))
	end

	if type(var_0_18[arg_56_1]) ~= "number" then
		var_0_18[arg_56_1] = 4
	end

	return var_0_18[arg_56_1]
end

function var_0_0.SetTrackCount(arg_57_0, arg_57_1, arg_57_2)
	var_0_18[arg_57_1] = arg_57_2

	saveData("Music", "SelectTrackCount" .. tostring(arg_57_1), arg_57_2)
end

function var_0_0.GetRead(arg_58_0, arg_58_1)
	return table.indexof(var_0_19, arg_58_1)
end

function var_0_0.SetRead(arg_59_0, arg_59_1)
	if not table.indexof(var_0_19, arg_59_1) then
		table.insert(var_0_19, arg_59_1)
	end
end

function var_0_0.SetSelectIndex(arg_60_0, arg_60_1)
	var_0_20[arg_60_0] = arg_60_1

	saveData("MusicSelect", tostring(arg_60_0), arg_60_1)
end

function var_0_0.GetSelectIndex(arg_61_0)
	if not var_0_20[arg_61_0] then
		var_0_20[arg_61_0] = getData("MusicSelect", tostring(arg_61_0))
	end

	if type(var_0_20[arg_61_0]) ~= "number" then
		var_0_20[arg_61_0] = 1
	end

	return var_0_20[arg_61_0]
end

function var_0_0.GetAisacSet(arg_62_0, arg_62_1)
	local var_62_0 = {}
	local var_62_1 = MusicRecordCfg[arg_62_1]

	if var_62_1 and var_62_1.initAISAC ~= "" then
		for iter_62_0, iter_62_1 in ipairs(var_62_1.initAISAC) do
			var_62_0[iter_62_1[1]] = iter_62_1[2]
		end
	end

	return var_62_0
end

function var_0_0.GetNowMusicUINameList(arg_63_0)
	return arg_63_0:GetMusicUINameList(var_0_24)
end

function var_0_0.GetMusicUINameList(arg_64_0, arg_64_1)
	local var_64_0 = arg_64_0:GetMusicViewType(arg_64_1)

	return MusicConst.MusicViewUIName[var_64_0]
end

function var_0_0.GetMusicViewPathList(arg_65_0, arg_65_1, arg_65_2)
	local var_65_0 = arg_65_0:GetMusicViewType(arg_65_1, arg_65_2)

	return MusicConst.MusicViewRoutesName[var_65_0]
end

function var_0_0.GetMusicViewType(arg_66_0, arg_66_1, arg_66_2)
	local var_66_0 = ActivityTools.GetActivityTheme(var_0_24)

	return arg_66_0:GetMusicTypeByTheme(var_66_0)
end

function var_0_0.GetMusicTypeByTheme(arg_67_0, arg_67_1)
	if arg_67_1 == ActivityConst.THEME.ACTIVITY_2_0 then
		return MusicConst.MusicViewType.Enternal
	elseif arg_67_1 == ActivityConst.THEME.VOLUME_DOWN then
		return MusicConst.MusicViewType.Volume
	elseif arg_67_1 == ActivityConst.THEME.ACTIVITY_2_10 then
		return MusicConst.MusicViewType.V210
	elseif arg_67_1 == ActivityConst.THEME.ACTIVITY_3_11 then
		return MusicConst.MusicViewType.QWorld
	elseif arg_67_1 == ActivityConst.THEME.ACTIVITY_4_6 then
		return MusicConst.MusicViewType.V46Resident
	elseif arg_67_1 == ActivityConst.THEME.ACTIVITY_5_1 then
		return MusicConst.MusicViewType.V51Resident
	else
		return MusicConst.MusicViewType.V46Resident
	end
end

function var_0_0.GetMusicdifficultLab(arg_68_0, arg_68_1)
	if arg_68_1 == 1 then
		return GetTips("ACTIVITY_MUSIC_LEVEL_1")
	elseif arg_68_1 == 2 then
		return GetTips("ACTIVITY_MUSIC_LEVEL_2")
	elseif arg_68_1 == 9 then
		return GetTips("ACTIVITY_MUSIC_LEVEL_3")
	else
		return GetTips("ACTIVITY_MUSIC_LEVEL_4")
	end
end

function var_0_0.SetSpecialEffectState(arg_69_0, arg_69_1)
	var_0_25 = arg_69_1
end

function var_0_0.GetSpecialEffectState(arg_70_0)
	return var_0_25
end

function var_0_0.GetMusicActThemeList(arg_71_0)
	local var_71_0 = {}
	local var_71_1 = {}

	for iter_71_0, iter_71_1 in pairs(ActivityMusicCfg.get_id_list_by_activity_id) do
		local var_71_2 = ActivityMusicCfg[iter_71_0]
		local var_71_3 = ActivityTools.GetActivityTheme(iter_71_0)

		if var_71_1[var_71_3] == nil then
			var_71_1[var_71_3] = true

			table.insert(var_71_0, var_71_3)
		end
	end

	table.sort(var_71_0, function(arg_72_0, arg_72_1)
		return arg_72_1 < arg_72_0
	end)

	return var_71_0
end

function var_0_0.GetActThemeList(arg_73_0)
	return var_0_22
end

function var_0_0.UpdateFilterList(arg_74_0, arg_74_1)
	var_0_21 = arg_74_1
end

function var_0_0.GetFilterList(arg_75_0)
	return var_0_21
end

function var_0_0.InitFilterList(arg_76_0)
	var_0_21 = {}
	var_0_21[MusicConst.MusicFilterType.verFilterKey] = {}
	var_0_21[MusicConst.MusicFilterType.tagFilterKey] = {}

	for iter_76_0, iter_76_1 in pairs(var_0_22) do
		var_0_21[MusicConst.MusicFilterType.verFilterKey][iter_76_0] = false
	end

	for iter_76_2, iter_76_3 in pairs(MusicConst.MusicTag) do
		var_0_21[MusicConst.MusicFilterType.tagFilterKey][iter_76_3] = false
	end
end

function var_0_0.GetTrackKeySetData(arg_77_0, arg_77_1)
	if not var_0_26[arg_77_1] then
		local var_77_0 = getData("Music", "Key_Set" .. arg_77_1)

		if var_77_0 then
			var_0_26[arg_77_1] = var_77_0
		else
			var_0_26[arg_77_1] = arg_77_0:GetDefaultKeyData(arg_77_1)
		end
	end

	return var_0_26[arg_77_1]
end

function var_0_0.GetDefaultKeyData(arg_78_0, arg_78_1)
	local var_78_0 = {}

	for iter_78_0, iter_78_1 in ipairs(MusicConst.MusicTrackSetDefaultKey[arg_78_1]) do
		table.insert(var_78_0, iter_78_1)
	end

	return var_78_0
end

function var_0_0.SaveTrackKeySetData(arg_79_0, arg_79_1, arg_79_2)
	saveData("Music", "Key_Set" .. arg_79_1, arg_79_2)

	var_0_26[arg_79_1] = arg_79_2
end

function var_0_0.GetActivityTaskID(arg_80_0, arg_80_1)
	local var_80_0
	local var_80_1 = ActivityCfg[arg_80_1]

	for iter_80_0, iter_80_1 in pairs(var_80_1.sub_activity_list) do
		local var_80_2 = ActivityCfg[iter_80_1]

		if var_80_2 and var_80_2.activity_template == ActivityTemplateConst.TASK then
			var_80_0 = iter_80_1

			break
		end
	end

	return var_80_0
end

return var_0_0

class = var_0_10000

local var_0_0 = "SettingsProxy"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.Proxy)

function var_0_1.onRegister(arg_1_0)
	PlayerPrefs = var_1_10001
	arg_1_0._isBgmEnble = var_1_10001.GetInt("ShipSkinBGM", 1) > 0
	PlayerPrefs = var_1
	arg_1_0._ShowBg = var_1.GetInt("disableBG", 1) > 0
	PlayerPrefs = var_1
	arg_1_0._ShowLive2d = var_1.GetInt("disableLive2d", 1) > 0
	PlayerPrefs = var_1
	arg_1_0._selectedShipId = var_1.GetInt("playerShipId")
	PlayerPrefs = var_1
	arg_1_0._backyardFoodRemind = var_1.GetString("backyardRemind")
	PlayerPrefs = var_1
	arg_1_0._userAgreement = var_1.GetInt("userAgreement", 0)
	PlayerPrefs = var_1
	arg_1_0._showMaxLevelHelp = var_1.GetInt("maxLevelHelp", 0) > 0
	PlayerPrefs = var_1
	arg_1_0._nextTipAutoBattleTime = var_1.GetInt("AutoBattleTip", 0)
	PlayerPrefs = var_1
	arg_1_0._setFlagShip = var_1.GetInt("setFlagShip", 0) > 0
	PlayerPrefs = var_1
	arg_1_0._setFlagShipForSkinAtlas = var_1.GetInt("setFlagShipforskinatlas", 0) > 0
	PlayerPrefs = var_1
	arg_1_0._setFlagRandom = var_1.GetInt("setFlagRandom", 0) > 0
	PlayerPrefs = var_1

	local var_1_0 = var_1.GetFloat
	local var_1_1 = "SetScreenRatio"

	ADAPT_TARGET = var_4
	arg_1_0._screenRatio = var_1_0(var_1_1, var_4)
	PlayerPrefs = var_1
	arg_1_0.storyAutoPlayCode = var_1.GetInt("story_autoplay_flag", 0)
	NotchAdapt = var_1
	var_1.CheckNotchRatio = arg_1_0._screenRatio
	PlayerPrefs = var_1
	arg_1_0._nextTipActBossTime = var_1.GetInt("ActBossTipLastTime", 0)
	GetZeroTime = var_1

	if var_1() <= arg_1_0._nextTipActBossTime then
		PlayerPrefs = var_2
		arg_1_0.nextTipActBossExchangeTicket = var_2.GetInt("ActBossTip", 0)
	end

	arg_1_0:resetEquipSceneIndex()

	PlayerPrefs = var_2
	arg_1_0._isShowCollectionHelp = var_2.GetInt("collection_Help", 0) > 0
	PlayerPrefs = var_2
	arg_1_0.showMainSceneWordTip = var_2.GetInt("main_scene_word_toggle", 1) > 0
	arg_1_0.lastRequestVersionTime = nil
	arg_1_0.worldBossFlag = {}
	arg_1_0.worldFlag = {}

	return
end

function var_0_1.SetWorldBossFlag(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_0.worldBossFlag[arg_2_1] ~= arg_2_2 then
		local var_2_0 = arg_2_0.worldBossFlag

		var_2_0[arg_2_1] = arg_2_2
		PlayerPrefs = var_2_0

		var_2_0.SetInt("worldBossFlag" .. arg_2_1, arg_2_2 and 1 or 0)

		PlayerPrefs = var_3

		var_3.Save()
	end

	return
end

function var_0_1.GetWorldBossFlag(arg_3_0, arg_3_1)
	if not arg_3_0.worldBossFlag[arg_3_1] then
		local var_3_0 = arg_3_0.worldBossFlag

		PlayerPrefs = var_1_10003
		var_3_0[arg_3_1] = var_1_10003.GetInt("worldBossFlag" .. arg_3_1, 1) > 0
	end

	return arg_3_0.worldBossFlag[arg_3_1]
end

function var_0_1.SetWorldFlag(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_0.worldFlag[arg_4_1] ~= arg_4_2 then
		local var_4_0 = arg_4_0.worldFlag

		var_4_0[arg_4_1] = arg_4_2
		PlayerPrefs = var_4_0

		var_4_0.SetInt("world_flag_" .. arg_4_1, arg_4_2 and 1 or 0)

		PlayerPrefs = var_3

		var_3.Save()
	end

	return
end

function var_0_1.GetWorldFlag(arg_5_0, arg_5_1)
	if not arg_5_0.worldFlag[arg_5_1] then
		local var_5_0 = arg_5_0.worldFlag

		PlayerPrefs = var_1_10003
		var_5_0[arg_5_1] = var_1_10003.GetInt("world_flag_" .. arg_5_1, 0) > 0
	end

	return arg_5_0.worldFlag[arg_5_1]
end

function var_0_1.GetDockYardLockBtnFlag(arg_6_0)
	if not arg_6_0.dockYardLockFlag then
		getProxy = var_1
		PlayerProxy = var_1_10003

		local var_6_0 = var_1(var_1_10003)
		local var_6_1 = var_1.getRawData(var_6_0).id

		PlayerPrefs = var_1_10002
		arg_6_0.dockYardLockFlag = var_1_10002.GetInt("DockYardLockFlag" .. var_6_1, 0) > 0
	end

	return arg_6_0.dockYardLockFlag
end

function var_0_1.SetDockYardLockBtnFlag(arg_7_0, arg_7_1)
	if arg_7_0.dockYardLockFlag ~= arg_7_1 then
		getProxy = var_2
		PlayerProxy = var_1_10004

		local var_7_0 = var_2(var_1_10004)
		local var_7_1 = var_2.getRawData(var_7_0).id

		PlayerPrefs = var_1_10003

		var_1_10003.SetInt("DockYardLockFlag" .. var_7_1, arg_7_1 and 1 or 0)

		PlayerPrefs = var_3

		var_3.Save()

		arg_7_0.dockYardLockFlag = arg_7_1
	end

	return
end

function var_0_1.GetDockYardLevelBtnFlag(arg_8_0)
	if not arg_8_0.dockYardLevelFlag then
		getProxy = var_1
		PlayerProxy = var_1_10003

		local var_8_0 = var_1(var_1_10003)
		local var_8_1 = var_1.getRawData(var_8_0).id

		PlayerPrefs = var_1_10002
		arg_8_0.dockYardLevelFlag = var_1_10002.GetInt("DockYardLevelFlag" .. var_8_1, 0) > 0
	end

	return arg_8_0.dockYardLevelFlag
end

function var_0_1.SetDockYardLevelBtnFlag(arg_9_0, arg_9_1)
	if arg_9_0.dockYardLevelFlag ~= arg_9_1 then
		getProxy = var_2
		PlayerProxy = var_1_10004

		local var_9_0 = var_2(var_1_10004)
		local var_9_1 = var_2.getRawData(var_9_0).id

		PlayerPrefs = var_1_10003

		var_1_10003.SetInt("DockYardLevelFlag" .. var_9_1, arg_9_1 and 1 or 0)

		PlayerPrefs = var_3

		var_3.Save()

		arg_9_0.dockYardLevelFlag = arg_9_1
	end

	return
end

function var_0_1.IsShowCollectionHelp(arg_10_0)
	return arg_10_0._isShowCollectionHelp
end

function var_0_1.SetCollectionHelpFlag(arg_11_0, arg_11_1)
	if arg_11_0._isShowCollectionHelp ~= arg_11_1 then
		arg_11_0._isShowCollectionHelp = arg_11_1
		PlayerPrefs = var_2

		var_2.SetInt("collection_Help", arg_11_1 and 1 or 0)

		PlayerPrefs = var_2

		var_2.Save()
	end

	return
end

function var_0_1.IsBGMEnable(arg_12_0)
	return arg_12_0._isBgmEnble
end

function var_0_1.SetBgmFlag(arg_13_0, arg_13_1)
	if arg_13_0._isBgmEnble ~= arg_13_1 then
		arg_13_0._isBgmEnble = arg_13_1
		PlayerPrefs = var_2

		var_2.SetInt("ShipSkinBGM", arg_13_1 and 1 or 0)

		PlayerPrefs = var_2

		var_2.Save()
	end

	return
end

function var_0_1.IsEnableMainMusicPlayer(arg_14_0)
	return true
end

function var_0_1.getSkinPosSetting(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1
	local var_15_1 = arg_15_1.GetRecordPosKey(var_15_0)
	local var_15_2 = arg_15_0
	local var_15_3 = arg_15_0.GetCurrMainUIStyleKeyForSkinShop(var_15_2)

	PlayerPrefs = var_15_0

	local var_15_4 = var_15_0.HasKey
	local var_15_5 = var_15_3

	tostring = var_1_10007

	if var_15_4(var_15_5 .. var_1_10007(var_15_1) .. "_scale") then
		PlayerPrefs = var_4

		local var_15_6 = var_4.GetFloat
		local var_15_7 = var_15_3

		tostring = var_7

		local var_15_8 = var_15_6(var_15_7 .. var_7(var_15_1) .. "_x", 0)

		PlayerPrefs = var_15_2

		local var_15_9 = var_15_2.GetFloat
		local var_15_10 = var_15_3

		tostring = var_8

		local var_15_11 = var_15_9(var_15_10 .. var_8(var_15_1) .. "_y", 0)

		PlayerPrefs = var_6

		local var_15_12 = var_6.GetFloat
		local var_15_13 = var_15_3

		tostring = var_9

		local var_15_14 = var_15_12(var_15_13 .. var_9(var_15_1) .. "_scale", 1)

		return var_15_8, var_15_11, var_15_14
	else
		return nil
	end

	return
end

function var_0_1.setSkinPosSetting(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	local var_16_0 = arg_16_1
	local var_16_1 = arg_16_1.GetRecordPosKey(var_16_0)
	local var_16_2 = arg_16_0:GetCurrMainUIStyleKeyForSkinShop()

	PlayerPrefs = var_16_0

	local var_16_3 = var_16_0.SetFloat
	local var_16_4 = var_16_2

	tostring = var_1_10010

	var_16_3(var_16_4 .. var_1_10010(var_16_1) .. "_x", arg_16_2)

	PlayerPrefs = var_16_3

	local var_16_5 = var_16_3.SetFloat
	local var_16_6 = var_16_2

	tostring = var_10

	var_16_5(var_16_6 .. var_10(var_16_1) .. "_y", arg_16_3)

	PlayerPrefs = var_16_5

	local var_16_7 = var_16_5.SetFloat
	local var_16_8 = var_16_2

	tostring = var_10

	var_16_7(var_16_8 .. var_10(var_16_1) .. "_scale", arg_16_4)

	PlayerPrefs = var_16_7

	var_16_7.Save()

	return
end

function var_0_1.setSkinScaleSetting(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	local var_17_0 = arg_17_1:GetRecordPosKey()

	tostring = var_1_10006

	local var_17_1 = var_1_10006(var_17_0) .. arg_17_2 .. "_" .. arg_17_3 .. "_part_scale"

	PlayerPrefs = var_7

	local var_17_2 = var_7.SetFloat

	tostring = var_9

	var_17_2(var_9(var_17_0) .. arg_17_2 .. "_" .. arg_17_3 .. "_part_scale", arg_17_4)

	return
end

function var_0_1.getSkinScaleSetting(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0
	local var_18_1 = arg_18_1:GetRecordPosKey()

	tostring = var_1_10006

	local var_18_2 = var_1_10006(var_18_1) .. arg_18_2 .. "_" .. arg_18_3 .. "_part_scale"

	PlayerPrefs = var_7

	if var_7.HasKey(var_18_2) then
		PlayerPrefs = var_7
		var_18_0 = var_7.GetFloat(var_18_2, 1)
	else
		return 1
	end

	return var_18_0
end

function var_0_1.GetCurrMainUIStyleKeyForSkinShop(arg_19_0)
	local var_19_0 = arg_19_0:GetMainSceneThemeStyle()

	NewMainScene = var_1_10002

	if var_19_0 == var_1_10002.THEME_CLASSIC then
		return ""
	else
		return var_19_0
	end

	return
end

function var_0_1.resetSkinPosSetting(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_1:GetRecordPosKey()

	PlayerPrefs = var_1_10003

	local var_20_1 = var_1_10003.DeleteKey

	tostring = var_1_10005

	var_20_1(var_1_10005(var_20_0) .. "_x")

	PlayerPrefs = var_20_1

	local var_20_2 = var_20_1.DeleteKey

	tostring = var_5

	var_20_2(var_5(var_20_0) .. "_y")

	PlayerPrefs = var_20_2

	local var_20_3 = var_20_2.DeleteKey

	tostring = var_5

	var_20_3(var_5(var_20_0) .. "_scale")

	PlayerPrefs = var_20_3

	var_20_3.Save()

	return
end

function var_0_1.getCharacterSetting(arg_21_0, arg_21_1, arg_21_2)
	PlayerPrefs = var_1_10003

	local var_21_0 = var_1_10003.GetInt

	tostring = var_1_10005

	return var_21_0(var_1_10005(arg_21_1) .. "_" .. arg_21_2, 1) > 0
end

function var_0_1.setCharacterSetting(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	PlayerPrefs = var_1_10004

	local var_22_0 = var_1_10004.SetInt

	tostring = var_1_10006

	var_22_0(var_1_10006(arg_22_1) .. "_" .. arg_22_2, arg_22_3 and 1 or 0)

	PlayerPrefs = var_22_0

	var_22_0.Save()

	return
end

function var_0_1.getCurrentSecretaryIndex(arg_23_0)
	PlayerPrefs = var_1_10001

	local var_23_0 = var_1_10001.GetInt("currentSecretaryIndex", 1)

	PlayerVitaeShipsPage = var_1_10002

	if var_23_0 > var_1_10002.GetAllUnlockSlotCnt() then
		arg_23_0:setCurrentSecretaryIndex(1)

		return 1
	else
		PlayerVitaeShipsPage = var_3

		return var_3.GetSlotIndexList()[var_23_0]
	end

	return
end

function var_0_1.rotateCurrentSecretaryIndex(arg_24_0)
	local function var_24_0()
		getProxy = var_2_10000
		PlayerProxy = var_2_10002

		local var_25_0 = var_2_10000(var_2_10002)
		local var_25_1 = var_0.getRawData(var_25_0)
		local var_25_3

		if var_0.ExistEducateChar(var_25_1) then
			getProxy = var_25_3
			SettingsProxy = var_25_1

			local var_25_2 = var_25_3(var_25_1)

			var_25_3 = var_25_3.GetFlagShipDisplayMode(var_25_2)
			FlAG_SHIP_DISPLAY_ONLY_SHIP = var_2_10001
			var_25_3 = var_25_3 ~= var_2_10001
		end

		return var_25_3
	end

	PlayerPrefs = var_1_10002

	local var_24_1 = var_1_10002.GetInt("currentSecretaryIndex", 1)

	PlayerVitaeShipsPage = var_1_10003

	if not (var_1_10003.GetAllUnlockSlotCnt() < var_24_1 + 1) then
		PlayerVitaeShipsPage = var_4

		local var_24_2

		if var_24_2 == var_4.EDUCATE_CHAR_SLOT_ID and not var_24_0() then
			var_24_2 = 1
		end

		arg_24_0:setCurrentSecretaryIndex(var_24_2)

		pg = var_4

		local var_24_3 = var_4.m02
		local var_24_4 = var_4.sendNotification

		GAME = var_7

		var_24_4(var_24_3, var_7.ROTATE_PAINTING_INDEX)

		return
	end
end

function var_0_1.setCurrentSecretaryIndex(arg_26_0, arg_26_1)
	PlayerPrefs = var_1_10002

	var_1_10002.SetInt("currentSecretaryIndex", arg_26_1)

	PlayerPrefs = var_2

	var_2.Save()

	return
end

function var_0_1.SetFlagShip(arg_27_0, arg_27_1)
	if arg_27_0._setFlagShip ~= arg_27_1 then
		arg_27_0._setFlagShip = arg_27_1
		PlayerPrefs = var_2

		var_2.SetInt("setFlagShip", arg_27_1 and 1 or 0)

		PlayerPrefs = var_2

		var_2.Save()
	end

	return
end

function var_0_1.GetSetFlagShip(arg_28_0)
	return arg_28_0._setFlagShip
end

function var_0_1.SetFlagShipForSkinAtlas(arg_29_0, arg_29_1)
	if arg_29_0._setFlagShipForSkinAtlas ~= arg_29_1 then
		arg_29_0._setFlagShipForSkinAtlas = arg_29_1
		PlayerPrefs = var_2

		var_2.SetInt("setFlagShipforskinatlas", arg_29_1 and 1 or 0)

		PlayerPrefs = var_2

		var_2.Save()
	end

	return
end

function var_0_1.GetSetFlagShipForSkinAtlas(arg_30_0)
	return arg_30_0._setFlagShipForSkinAtlas
end

function var_0_1.SetFlagRandom(arg_31_0, arg_31_1)
	if arg_31_0._setFlagRandom ~= arg_31_1 then
		arg_31_0._setFlagRandom = arg_31_1
		PlayerPrefs = var_2

		var_2.SetInt("setFlagRandom", arg_31_1 and 1 or 0)

		PlayerPrefs = var_2

		var_2.Save()
	end

	return
end

function var_0_1.GetFlagRandom(arg_32_0)
	return arg_32_0._setFlagRandom
end

function var_0_1.CheckNeedUserAgreement(arg_33_0)
	PLATFORM_CODE = var_1_10001
	PLATFORM_KR = var_1_10002

	if var_1_10001 == var_1_10002 then
		return false
	else
		PLATFORM_CODE = var_1_10001
		PLATFORM_CH = var_1_10002

		if var_1_10001 == var_1_10002 then
			return false
		else
			PLATFORM_CODE = var_1_10001
			PLATFORM_JP = var_1_10002

			if var_1_10001 == var_1_10002 then
				return false
			else
				return arg_33_0:GetUserAgreementFlag() > arg_33_0._userAgreement
			end
		end
	end

	return
end

function var_0_1.GetUserAgreementFlag(arg_34_0)
	USER_AGREEMENT_FLAG_DEFAULT = var_1_10001
	PLATFORM_CODE = var_1_10002
	PLATFORM_CHT = var_1_10003

	if var_1_10002 == var_1_10003 then
		USER_AGREEMENT_FLAG_TW = var_1_10001
	end

	return var_1_10001
end

function var_0_1.SetUserAgreement(arg_35_0)
	if arg_35_0:CheckNeedUserAgreement() then
		local var_35_0 = arg_35_0:GetUserAgreementFlag()

		PlayerPrefs = var_1_10002

		var_1_10002.SetInt("userAgreement", var_35_0)

		PlayerPrefs = var_2

		var_2.Save()

		arg_35_0._userAgreement = var_35_0
	end

	return
end

function var_0_1.IsLive2dEnable(arg_36_0)
	return arg_36_0._ShowLive2d
end

function var_0_1.IsBGEnable(arg_37_0)
	return arg_37_0._ShowBg
end

function var_0_1.SetSelectedShipId(arg_38_0, arg_38_1)
	if arg_38_0._selectedShipId ~= arg_38_1 then
		arg_38_0._selectedShipId = arg_38_1
		PlayerPrefs = var_2

		var_2.SetInt("playerShipId", arg_38_1)

		PlayerPrefs = var_2

		var_2.Save()
	end

	return
end

function var_0_1.GetSelectedShipId(arg_39_0)
	return arg_39_0._selectedShipId
end

function var_0_1.setEquipSceneIndex(arg_40_0, arg_40_1)
	arg_40_0._equipSceneIndex = arg_40_1

	return
end

function var_0_1.getEquipSceneIndex(arg_41_0)
	return arg_41_0._equipSceneIndex
end

function var_0_1.resetEquipSceneIndex(arg_42_0)
	StoreHouseConst = var_1_10001
	arg_42_0._equipSceneIndex = var_1_10001.WARP_TO_MATERIAL

	return
end

function var_0_1.setActivityLayerIndex(arg_43_0, arg_43_1)
	arg_43_0._activityLayerIndex = arg_43_1

	return
end

function var_0_1.getActivityLayerIndex(arg_44_0)
	return arg_44_0._activityLayerIndex
end

function var_0_1.resetActivityLayerIndex(arg_45_0)
	arg_45_0._activityLayerIndex = 1

	return
end

function var_0_1.setBackyardRemind(arg_46_0)
	GetZeroTime = var_1_10001

	local var_46_0 = var_1_10001()
	local var_46_1 = arg_46_0._backyardFoodRemind

	tostring = var_1_10003

	if var_46_1 ~= var_1_10003(var_46_0) then
		PlayerPrefs = var_46_1

		var_46_1.SetString("backyardRemind", var_46_0)

		PlayerPrefs = var_2

		var_2.Save()

		arg_46_0._backyardFoodRemind = var_46_0
	end

	return
end

function var_0_1.getBackyardRemind(arg_47_0)
	if not arg_47_0._backyardFoodRemind or arg_47_0._backyardFoodRemind == "" then
		return 0
	else
		tonumber = var_1

		return var_1(arg_47_0._backyardFoodRemind)
	end

	return
end

function var_0_1.getMaxLevelHelp(arg_48_0)
	return arg_48_0._showMaxLevelHelp
end

function var_0_1.setMaxLevelHelp(arg_49_0, arg_49_1)
	if arg_49_0._showMaxLevelHelp ~= arg_49_1 then
		arg_49_0._showMaxLevelHelp = arg_49_1
		PlayerPrefs = var_2

		var_2.SetInt("maxLevelHelp", arg_49_1 and 1 or 0)

		PlayerPrefs = var_2

		var_2.Save()
	end

	return
end

function var_0_1.setStopBuildSpeedupRemind(arg_50_0)
	arg_50_0.isStopBuildSpeedupReamind = true

	return
end

function var_0_1.getStopBuildSpeedupRemind(arg_51_0)
	return arg_51_0.isStopBuildSpeedupReamind
end

function var_0_1.checkReadHelp(arg_52_0, arg_52_1)
	getProxy = var_1_10002
	PlayerProxy = var_1_10004

	local var_52_0 = var_1_10002(var_1_10004)

	if not var_2.getData(var_52_0) then
		return true
	end

	if arg_52_1 == "help_backyard" then
		return true
	else
		pg = var_1_10004

		local var_52_1 = var_1_10004.SeriesGuideMgr.GetInstance()

		if var_4.isEnd(var_52_1) then
			PlayerPrefs = var_4

			local var_52_2 = var_4.GetInt(arg_52_1, 0)

			PlayerPrefs = var_52_0

			return var_52_0.GetInt(arg_52_1, 0) > 0
		end
	end

	return true
end

function var_0_1.recordReadHelp(arg_53_0, arg_53_1)
	PlayerPrefs = var_1_10002

	var_1_10002.SetInt(arg_53_1, 1)

	PlayerPrefs = var_2

	var_2.Save()

	return
end

function var_0_1.clearAllReadHelp(arg_54_0)
	PlayerPrefs = var_1_10001

	var_1_10001.DeleteKey("tactics_lesson_system_introduce")

	PlayerPrefs = var_1

	var_1.DeleteKey("help_shipinfo_equip")

	PlayerPrefs = var_1

	var_1.DeleteKey("help_shipinfo_detail")

	PlayerPrefs = var_1

	var_1.DeleteKey("help_shipinfo_intensify")

	PlayerPrefs = var_1

	var_1.DeleteKey("help_shipinfo_upgrate")

	PlayerPrefs = var_1

	var_1.DeleteKey("help_backyard")

	PlayerPrefs = var_1

	var_1.DeleteKey("has_entered_class")

	PlayerPrefs = var_1

	var_1.DeleteKey("help_commander_info")

	PlayerPrefs = var_1

	var_1.DeleteKey("help_commander_play")

	PlayerPrefs = var_1

	var_1.DeleteKey("help_commander_ability")

	PlayerPrefs = var_1

	var_1.DeleteKey("loveactivity_help_tips")

	return
end

function var_0_1.setAutoBattleTip(arg_55_0)
	GetZeroTime = var_1_10001
	arg_55_0._nextTipAutoBattleTime = var_1_10001()
	PlayerPrefs = var_1_10002

	var_1_10002.SetInt("AutoBattleTip", var_1)

	PlayerPrefs = var_2

	var_2.Save()

	return
end

function var_0_1.isTipAutoBattle(arg_56_0)
	pg = var_1_10001

	local var_56_0 = var_1_10001.TimeMgr.GetInstance()

	return var_1.GetServerTime(var_56_0) > arg_56_0._nextTipAutoBattleTime
end

function var_0_1.setActBossExchangeTicketTip(arg_57_0, arg_57_1)
	if arg_57_0.nextTipActBossExchangeTicket == arg_57_1 then
		return
	end

	arg_57_0.nextTipActBossExchangeTicket = arg_57_1
	GetZeroTime = var_2

	local var_57_0 = var_2()

	if arg_57_0._nextTipActBossTime < var_57_0 then
		arg_57_0._nextTipActBossTime = var_57_0
		PlayerPrefs = var_3

		var_3.SetInt("ActBossTipLastTime", var_57_0)
	end

	PlayerPrefs = var_3

	var_3.SetInt("ActBossTip", arg_57_1)

	PlayerPrefs = var_3

	var_3.Save()

	return
end

function var_0_1.isTipActBossExchangeTicket(arg_58_0)
	pg = var_1_10001

	local var_58_0 = var_1_10001.TimeMgr.GetInstance()

	if var_1.GetServerTime(var_58_0) > arg_58_0._nextTipActBossTime then
		return nil
	end

	return arg_58_0.nextTipActBossExchangeTicket
end

function var_0_1.SetScreenRatio(arg_59_0, arg_59_1)
	if arg_59_0._screenRatio ~= arg_59_1 then
		arg_59_0._screenRatio = arg_59_1
		PlayerPrefs = var_2

		var_2.SetFloat("SetScreenRatio", arg_59_1)

		PlayerPrefs = var_2

		var_2.Save()
	end

	return
end

function var_0_1.GetScreenRatio(arg_60_0)
	return arg_60_0._screenRatio
end

function var_0_1.CheckLargeScreen(arg_61_0)
	Screen = var_1_10001

	local var_61_0 = var_1_10001.width

	Screen = var_1_10002

	return var_61_0 / var_1_10002.height > 2
end

function var_0_1.IsShowBeatMonseterNianCurtain(arg_62_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_62_0 = var_1_10001(var_1_10003)
	local var_62_1 = var_1.getRawData(var_62_0)

	pg = var_1_10002

	local var_62_2 = var_1_10002.TimeMgr.GetInstance()
	local var_62_3 = var_2.GetServerTime(var_62_2)

	tonumber = var_62_0
	PlayerPrefs = var_1_10005

	return var_62_3 > var_62_0(var_1_10005.GetString("HitMonsterNianLayer2020" .. var_62_1.id, "0"))
end

function var_0_1.SetBeatMonseterNianFlag(arg_63_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_63_0 = var_1_10001(var_1_10003)
	local var_63_1 = var_1.getRawData(var_63_0)

	PlayerPrefs = var_1_10002

	local var_63_2 = var_1_10002.SetString
	local var_63_3 = "HitMonsterNianLayer2020" .. var_63_1.id

	GetZeroTime = var_5

	var_63_2(var_63_3, var_5())

	PlayerPrefs = var_63_2

	var_63_2.Save()

	return
end

function var_0_1.ShouldShowEventActHelp(arg_64_0)
	if not arg_64_0.actEventFlag then
		getProxy = var_1
		PlayerProxy = var_1_10003

		local var_64_0 = var_1(var_1_10003)
		local var_64_1 = var_1.getRawData(var_64_0).id

		PlayerPrefs = var_1_10002
		arg_64_0.actEventFlag = var_1_10002.GetInt("event_act_help1" .. var_64_1, 0) > 0
	end

	return not arg_64_0.actEventFlag
end

function var_0_1.MarkEventActHelpFlag(arg_65_0)
	if not arg_65_0.actEventFlag then
		arg_65_0.actEventFlag = true
		getProxy = var_1
		PlayerProxy = var_1_10003

		local var_65_0 = var_1(var_1_10003)
		local var_65_1 = var_1.getRawData(var_65_0).id

		PlayerPrefs = var_1_10002

		var_1_10002.SetInt("event_act_help1" .. var_65_1, 1)

		PlayerPrefs = var_2

		var_2.Save()
	end

	return
end

function var_0_1.SetStorySpeed(arg_66_0, arg_66_1)
	arg_66_0.storySpeed = arg_66_1

	local var_66_0

	getProxy = var_1_10003
	PlayerProxy = var_1_10005

	if var_1_10003(var_1_10005) then
		getProxy = var_3
		PlayerProxy = var_1_10005

		local var_66_1 = var_3(var_1_10005)

		var_66_0 = var_3.getRawData(var_66_1).id
	else
		var_66_0 = 1
	end

	PlayerPrefs = var_3

	var_3.SetInt("story_speed_flag" .. var_66_0, arg_66_1)

	PlayerPrefs = var_3

	var_3.Save()

	return
end

function var_0_1.GetStorySpeed(arg_67_0)
	if not arg_67_0.storySpeed then
		local var_67_0

		getProxy = var_1_10002
		PlayerProxy = var_1_10004

		if var_1_10002(var_1_10004) then
			getProxy = var_2
			PlayerProxy = var_1_10004

			local var_67_1 = var_2(var_1_10004)

			var_67_0 = var_2.getRawData(var_67_1).id
		else
			var_67_0 = 1
		end

		PlayerPrefs = var_2
		arg_67_0.storySpeed = var_2.GetInt("story_speed_flag" .. var_67_0, 0)
	end

	return arg_67_0.storySpeed
end

function var_0_1.GetStoryAutoPlayFlag(arg_68_0)
	return arg_68_0.storyAutoPlayCode > 0
end

function var_0_1.SetStoryAutoPlayFlag(arg_69_0, arg_69_1)
	if arg_69_0.storyAutoPlayCode ~= arg_69_1 then
		PlayerPrefs = var_2

		var_2.SetInt("story_autoplay_flag", arg_69_1)

		PlayerPrefs = var_2

		var_2.Save()

		arg_69_0.storyAutoPlayCode = arg_69_1
	end

	return
end

function var_0_1.GetPaintingDownloadPrefs(arg_70_0)
	PlayerPrefs = var_1_10001

	return var_1_10001.GetInt("Painting_Download_Prefs", 0)
end

function var_0_1.SetPaintingDownloadPrefs(arg_71_0, arg_71_1)
	PlayerPrefs = var_1_10002

	var_1_10002.SetInt("Painting_Download_Prefs", arg_71_1)

	return
end

function var_0_1.ShouldShipMainSceneWord(arg_72_0)
	return arg_72_0.showMainSceneWordTip
end

function var_0_1.SaveMainSceneWordFlag(arg_73_0, arg_73_1)
	if arg_73_0.showMainSceneWordTip ~= arg_73_1 then
		arg_73_0.showMainSceneWordTip = arg_73_1
		PlayerPrefs = var_2

		var_2.SetInt("main_scene_word_toggle", arg_73_1 and 1 or 0)

		PlayerPrefs = var_2

		var_2.Save()
	end

	return
end

function var_0_1.RecordFrameRate(arg_74_0)
	if not arg_74_0.originalFrameRate then
		Application = var_1
		arg_74_0.originalFrameRate = var_1.targetFrameRate
	end

	return
end

function var_0_1.RestoreFrameRate(arg_75_0)
	if arg_75_0.originalFrameRate then
		Application = var_1
		var_1.targetFrameRate = arg_75_0.originalFrameRate
		arg_75_0.originalFrameRate = nil
	end

	return
end

function var_0_1.ResetTimeLimitSkinShopTip(arg_76_0)
	PlayerPrefs = var_1_10001

	local var_76_0 = var_1_10001.GetInt("tipLimitSkinShopTime_", 0)

	pg = var_1_10002

	local var_76_1 = var_1_10002.TimeMgr.GetInstance()

	arg_76_0.isTipLimitSkinShop = var_76_0 <= var_2.GetServerTime(var_76_1)

	if arg_76_0.isTipLimitSkinShop then
		GetZeroTime = var_2
		arg_76_0.nextTipLimitSkinShopTime = var_2()
	end

	return
end

function var_0_1.ShouldTipTimeLimitSkinShop(arg_77_0)
	return arg_77_0.isTipLimitSkinShop
end

function var_0_1.SetNextTipTimeLimitSkinShop(arg_78_0)
	if arg_78_0.isTipLimitSkinShop and arg_78_0.nextTipLimitSkinShopTime then
		PlayerPrefs = var_1

		var_1.SetInt("tipLimitSkinShopTime_", arg_78_0.nextTipLimitSkinShopTime)

		PlayerPrefs = var_1

		var_1.Save()

		arg_78_0.nextTipLimitSkinShopTime = nil
		arg_78_0.isTipLimitSkinShop = false
	end

	return
end

function var_0_1.WorldBossProgressTipFlag(arg_79_0, arg_79_1)
	if arg_79_0.WorldBossProgressTipValue ~= arg_79_1 then
		arg_79_0.WorldBossProgressTipValue = arg_79_1
		PlayerPrefs = var_2

		var_2.SetString("_WorldBossProgressTipFlag_", arg_79_1)

		PlayerPrefs = var_2

		var_2.Save()
	end

	return
end

function var_0_1.GetWorldBossProgressTipFlag(arg_80_0)
	if not arg_80_0.WorldBossProgressTipValue then
		pg = var_1

		local var_80_0 = var_1.gameset.joint_boss_ticket.description[1] + var_1[2]
		local var_80_1 = var_1[1] .. "&" .. var_80_0

		PlayerPrefs = var_4
		arg_80_0.WorldBossProgressTipValue = var_4.GetString("_WorldBossProgressTipFlag_", var_80_1)

		return var_4
	else
		return arg_80_0.WorldBossProgressTipValue
	end

	return
end

function var_0_1.GetWorldBossProgressTipTable(arg_81_0)
	if not arg_81_0:GetWorldBossProgressTipFlag() or var_1 == "" then
		return {}
	end

	string = var_1_10002

	return var_1_10002.split(var_1, "&")
end

function var_0_1.GetChatFlag(arg_82_0)
	if not arg_82_0.chatFlag then
		local var_82_0 = {}

		ChatConst = var_1_10002
		var_82_0[1] = var_1_10002.ChannelWorld
		ChatConst = var_2
		var_82_0[2] = var_2.ChannelPublic
		ChatConst = var_2
		var_82_0[3] = var_2.ChannelFriend
		getProxy = var_2
		GuildProxy = var_1_10004

		local var_82_1 = var_2(var_1_10004)
		local var_82_2

		if var_2.getRawData(var_82_1) then
			table = var_82_2
			var_82_2 = var_82_2.insert

			local var_82_3 = var_82_0

			ChatConst = var_1_10005

			var_82_2(var_82_3, var_1_10005.ChannelGuild)
		end

		PlayerPrefs = var_82_2

		local var_82_4 = var_82_2.GetInt
		local var_82_5 = "chat__setting"

		IndexConst = var_1_10005
		arg_82_0.chatFlag = var_82_4(var_82_5, var_1_10005.Flags2Bits(var_82_0))
	end

	return arg_82_0.chatFlag
end

function var_0_1.SetChatFlag(arg_83_0, arg_83_1)
	if arg_83_0.chatFlag ~= arg_83_1 then
		arg_83_0.chatFlag = arg_83_1
		PlayerPrefs = var_2

		var_2.SetInt("chat__setting", arg_83_1)

		PlayerPrefs = var_2

		var_2.Save()
	end

	return
end

function var_0_1.IsShowActivityMapSPTip()
	getProxy = var_1_10000
	PlayerProxy = var_1_10002

	local var_84_0 = var_1_10000(var_1_10002)
	local var_84_1 = var_0.getRawData(var_84_0)

	pg = var_1_10001

	local var_84_2 = var_1_10001.TimeMgr.GetInstance()
	local var_84_3 = var_1.GetServerTime(var_84_2)

	PlayerPrefs = var_84_0

	return var_84_3 > var_84_0.GetInt("ActivityMapSPTip" .. var_84_1.id, 0)
end

function var_0_1.SetActivityMapSPTip()
	getProxy = var_1_10000
	PlayerProxy = var_1_10002

	local var_85_0 = var_1_10000(var_1_10002)
	local var_85_1 = var_0.getRawData(var_85_0)

	PlayerPrefs = var_1_10001

	local var_85_2 = var_1_10001.SetInt
	local var_85_3 = "ActivityMapSPTip" .. var_85_1.id

	GetZeroTime = var_4

	var_85_2(var_85_3, var_4())

	PlayerPrefs = var_85_2

	var_85_2.Save()

	return
end

function var_0_1.IsTipNewTheme(arg_86_0)
	pg = var_1_10001

	local var_86_0 = var_1[var_1_10001.backyard_theme_template.all[#var_1.all]].ids[1]

	pg = var_1_10004

	local var_86_1 = var_1_10004.furniture_shop_template[var_86_0]

	getProxy = var_1_10005
	PlayerProxy = var_1_10007

	local var_86_2 = var_1_10005(var_1_10007)
	local var_86_3 = var_5.getRawData(var_86_2).id

	PlayerPrefs = var_1_10006

	local var_86_4 = var_1_10006.GetInt(var_86_3 .. "IsTipNewTheme" .. var_2, 0) == 0

	if var_86_1 then
		::label_86_0::

		if var_86_1.new == 1 then
			pg = var_86_2

			local var_86_5 = var_86_2.TimeMgr.GetInstance()

			if var_86_2.inTime(var_86_5, var_86_1.time) then
				var_86_2 = var_86_4
			end
		else
			var_86_2 = false
		end

		if false then
			var_86_2 = true
		end
	end

	if var_86_2 then
		arg_86_0.lastThemeId = var_2
	else
		arg_86_0.lastThemeId = nil
	end

	return arg_86_0.lastThemeId ~= nil
end

function var_0_1.UpdateNewThemeValue(arg_87_0)
	if arg_87_0.lastThemeId then
		local var_87_0 = arg_87_0.lastThemeId

		getProxy = var_1_10002
		PlayerProxy = var_1_10004

		local var_87_1 = var_1_10002(var_1_10004)
		local var_87_2 = var_2.getRawData(var_87_1).id

		PlayerPrefs = var_1_10003

		var_1_10003.SetInt(var_87_2 .. "IsTipNewTheme" .. var_87_0, 1)

		PlayerPrefs = var_3

		var_3.Save()
	end

	return
end

function var_0_1.GetNewGemFurnitureLocalCache(arg_88_0)
	if not arg_88_0.cacheGemFuruitures then
		arg_88_0.cacheGemFuruitures = {}
		getProxy = var_1
		PlayerProxy = var_1_10003

		local var_88_0 = var_1(var_1_10003)
		local var_88_1 = var_1.getRawData(var_88_0).id

		PlayerPrefs = var_1_10002

		if var_1_10002.GetString(var_88_1 .. "IsTipNewGenFurniture") ~= "" then
			string = var_88_0

			local var_88_2 = var_88_0.split(var_2, "#")

			ipairs = var_4

			for iter_88_0, iter_88_1 in var_4(var_88_2) do
				local var_88_3 = arg_88_0.cacheGemFuruitures

				tonumber = var_1_10010
				var_88_3[var_1_10010(iter_88_1)] = true
			end
		end
	end

	return arg_88_0.cacheGemFuruitures
end

function var_0_1.IsTipNewGemFurniture(arg_89_0)
	local var_89_0 = arg_89_0
	local var_89_1 = arg_89_0.GetNewGemFurnitureLocalCache(var_89_0)

	getProxy = var_1_10002
	DormProxy = var_1_10004

	local var_89_2 = var_1_10002(var_1_10004)
	local var_89_3 = var_2.GetTag7Furnitures(var_89_2)

	_ = var_89_0

	if var_89_0.any(var_89_3, function(arg_90_0)
		pg = var_2_10001

		return var_2_10001.furniture_shop_template[arg_90_0].new == 1 and not var_89_1[arg_90_0]
	end) then
		arg_89_0.newGemFurniture = var_89_3
	else
		arg_89_0.newGemFurniture = nil
	end

	return arg_89_0.newGemFurniture ~= nil
end

function var_0_1.UpdateNewGemFurnitureValue(arg_91_0)
	if arg_91_0.newGemFurniture then
		pairs = var_1

		for iter_91_0, iter_91_1 in var_1(arg_91_0.newGemFurniture) do
			arg_91_0.cacheGemFuruitures[iter_91_1] = true
		end

		table = var_1

		local var_91_0 = var_1.concat(arg_91_0.newGemFurniture, "#")

		getProxy = var_2
		PlayerProxy = var_4

		local var_91_1 = var_2(var_4)
		local var_91_2 = var_2.getRawData(var_91_1).id

		PlayerPrefs = var_3

		var_3.SetString(var_91_2 .. "IsTipNewGenFurniture", var_91_0)

		PlayerPrefs = var_3

		var_3.Save()
	end

	return
end

function var_0_1.GetRandomFlagShipList(arg_92_0)
	if arg_92_0.randomFlagShipList then
		return arg_92_0.randomFlagShipList
	end

	getProxy = var_1
	PlayerProxy = var_1_10003

	local var_92_0 = var_1(var_1_10003)
	local var_92_1 = var_1.getRawData(var_92_0).id

	PlayerPrefs = var_1_10002

	if var_1_10002.GetString("RandomFlagShipList" .. var_92_1, "") == "" then
		arg_92_0.randomFlagShipList = {}
	else
		string = var_92_0
		arg_92_0.randomFlagShipList = var_92_0.split(var_2, "#")
	end

	return arg_92_0.randomFlagShipList
end

function var_0_1.IsRandomFlagShip(arg_93_0, arg_93_1)
	if not arg_93_0.randomFlagShipMap then
		arg_93_0.randomFlagShipMap = {}
		ipairs = var_2

		for iter_93_0, iter_93_1 in var_2(arg_93_0:GetRandomFlagShipList()) do
			arg_93_0.randomFlagShipMap[iter_93_1] = true
		end
	end

	return arg_93_0.randomFlagShipMap[arg_93_1] == true
end

function var_0_1.IsOpenRandomFlagShip(arg_94_0)
	local var_94_0 = arg_94_0:GetRandomFlagShipList()

	getProxy = var_1_10002
	BayProxy = var_1_10004

	local var_94_1 = var_1_10002(var_1_10004)
	local var_94_2

	if #var_94_0 > 0 then
		_ = var_3
		var_94_2 = var_3.any(var_94_0, function(arg_95_0)
			ShipPhantom = var_2_10001

			local var_95_0, var_95_1 = var_2_10001.UnpackMark(arg_95_0)
			local var_95_2 = var_94_1

			return var_3.RawGetShipById(var_95_2, var_95_0) ~= nil
		end)
	else
		var_94_2 = false
	end

	if false then
		var_94_2 = true
	end

	return var_94_2
end

function var_0_1.UpdateRandomFlagShipList(arg_96_0, arg_96_1)
	arg_96_0.randomFlagShipMap = nil
	arg_96_0.randomFlagShipList = arg_96_1
	ipairs = var_2

	for iter_96_0, iter_96_1 in var_2(arg_96_1) do
		getProxy = var_1_10007
		BayProxy = var_1_10009
		var_1_10009 = var_1_10007(var_1_10009)

		if var_1_10007.GetShipPhantom(var_1_10009, iter_96_1) then
			local var_96_0 = var_1_10007.phantomId

			if 0 < var_96_0 then
				pg = var_96_0

				local var_96_1 = var_96_0.GameTrackerMgr.GetInstance()
				local var_96_2 = var_8.Record

				GameTrackerBuilder = var_1_10011

				var_96_2(var_96_1, var_1_10011.BuildPhantom(var_1_10007:getSkinId()))
			end
		end
	end

	table = var_2

	local var_96_3 = var_2.concat(arg_96_1, "#")

	getProxy = var_3
	PlayerProxy = var_5

	local var_96_4 = var_3(var_5)
	local var_96_5 = var_3.getRawData(var_96_4).id

	PlayerPrefs = var_4

	var_4.SetString("RandomFlagShipList" .. var_96_5, var_96_3)

	PlayerPrefs = var_4

	var_4.Save()

	return
end

function var_0_1.GetPrevRandomFlagShipTime(arg_97_0)
	if arg_97_0.prevRandomFlagShipTime then
		return arg_97_0.prevRandomFlagShipTime
	end

	getProxy = var_1
	PlayerProxy = var_1_10003

	local var_97_0 = var_1(var_1_10003)
	local var_97_1 = var_1.getRawData(var_97_0).id

	PlayerPrefs = var_1_10002
	arg_97_0.prevRandomFlagShipTime = var_1_10002.GetInt("RandomFlagShipTime" .. var_97_1, 0)

	return arg_97_0.prevRandomFlagShipTime
end

function var_0_1.SetPrevRandomFlagShipTime(arg_98_0, arg_98_1)
	if arg_98_0.prevRandomFlagShipTime == arg_98_1 then
		return
	end

	arg_98_0.prevRandomFlagShipTime = arg_98_1
	getProxy = var_2
	PlayerProxy = var_1_10004

	local var_98_0 = var_2(var_1_10004)
	local var_98_1 = var_2.getRawData(var_98_0).id

	PlayerPrefs = var_1_10003

	var_1_10003.SetInt("RandomFlagShipTime" .. var_98_1, arg_98_1)

	PlayerPrefs = var_3

	var_3.Save()

	return
end

function var_0_1.GetFlagShipDisplayMode(arg_99_0)
	if not arg_99_0.flagShipDisplayMode then
		getProxy = var_1
		PlayerProxy = var_1_10003

		local var_99_0 = var_1(var_1_10003)
		local var_99_1 = var_1.getRawData(var_99_0).id

		PlayerPrefs = var_1_10002

		local var_99_2 = var_1_10002.GetInt
		local var_99_3 = "flag-ship-display-mode" .. var_99_1

		FlAG_SHIP_DISPLAY_ALL = var_5
		arg_99_0.flagShipDisplayMode = var_99_2(var_99_3, var_5)
	end

	return arg_99_0.flagShipDisplayMode
end

function var_0_1.SetFlagShipDisplayMode(arg_100_0, arg_100_1)
	if arg_100_0.flagShipDisplayMode ~= arg_100_1 then
		arg_100_0.flagShipDisplayMode = arg_100_1
		getProxy = var_2
		PlayerProxy = var_1_10004

		local var_100_0 = var_2(var_1_10004)
		local var_100_1 = var_2.getRawData(var_100_0).id

		PlayerPrefs = var_1_10003

		var_1_10003.SetInt("flag-ship-display-mode" .. var_100_1, arg_100_1)

		PlayerPrefs = var_3

		var_3.Save()
	end

	return
end

function var_0_1.RecordContinuousOperationAutoSubStatus(arg_101_0, arg_101_1)
	if arg_101_1 then
		return
	end

	getProxy = var_1_10002
	PlayerProxy = var_1_10004

	local var_101_0 = var_1_10002(var_1_10004)
	local var_101_1 = var_2.getRawData(var_101_0).id

	PlayerPrefs = var_1_10003

	var_1_10003.SetInt("AutoBotCOFlag" .. var_101_1, 1)

	PlayerPrefs = var_3

	var_3.Save()

	return
end

function var_0_1.ResetContinuousOperationAutoSub(arg_102_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_102_0 = var_1_10001(var_1_10003)
	local var_102_1 = var_1.getRawData(var_102_0).id

	PlayerPrefs = var_1_10002

	if var_1_10002.GetInt("AutoBotCOFlag" .. var_102_1, 0) == 0 then
		return
	end

	pg = var_102_0

	local var_102_2 = var_102_0.m02
	local var_102_3 = var_3.sendNotification

	GAME = var_1_10006

	local var_102_4 = var_1_10006.AUTO_SUB
	local var_102_5 = {
		isActiveSub = true
	}

	SYSTEM_ACT_BOSS = var_1_10008
	var_102_5.system = var_1_10008

	var_102_3(var_102_2, var_102_4, var_102_5)

	PlayerPrefs = var_102_3

	var_102_3.SetInt("AutoBotCOFlag" .. var_102_1, 0)

	PlayerPrefs = var_3

	var_3.Save()

	return
end

function var_0_1.SetWorkbenchDailyTip(arg_103_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_103_0 = var_1_10001(var_1_10003)
	local var_103_1 = var_1.getRawData(var_103_0).id

	GetZeroTime = var_1_10002

	local var_103_2 = var_1_10002()

	PlayerPrefs = var_103_0

	var_103_0.SetInt("WorkbenchDailyTip" .. var_103_1, var_103_2)

	PlayerPrefs = var_3

	var_3.Save()

	return
end

function var_0_1.IsTipWorkbenchDaily(arg_104_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_104_0 = var_1_10001(var_1_10003)
	local var_104_1 = var_1.getRawData(var_104_0).id

	pg = var_1_10002

	local var_104_2 = var_1_10002.TimeMgr.GetInstance()
	local var_104_3 = var_2.GetServerTime(var_104_2)

	PlayerPrefs = var_104_0

	return var_104_3 > var_104_0.GetInt("WorkbenchDailyTip" .. var_104_1, 0)
end

function var_0_1.IsDisplayResultPainting(arg_105_0)
	PlayerPrefs = var_1_10001

	local var_105_0 = var_1_10001.HasKey

	BATTLERESULT_SKIP_DISPAY_PAINTING = var_1_10003

	local var_105_1 = var_105_0(var_1_10003)
	local var_105_2 = false

	if var_105_1 then
		PlayerPrefs = var_1_10003
		var_1_10003 = var_1_10003.GetInt
		BATTLERESULT_SKIP_DISPAY_PAINTING = var_1_10005
		var_105_2 = var_1_10003(var_1_10005) <= 0
		PlayerPrefs = var_1_10003
		var_1_10003 = var_1_10003.DeleteKey
		BATTLERESULT_SKIP_DISPAY_PAINTING = var_1_10005

		var_1_10003(var_1_10005)

		PlayerPrefs = var_1_10003
		var_1_10003 = var_1_10003.SetInt
		BATTLERESULT_DISPAY_PAINTING = var_1_10005

		var_1_10003(var_1_10005, var_105_2 and 1 or 0)

		PlayerPrefs = var_1_10003

		var_1_10003.Save()
	else
		PlayerPrefs = var_1_10003

		local var_105_3 = var_1_10003.GetInt

		BATTLERESULT_DISPAY_PAINTING = var_1_10005
		var_105_2 = var_105_3(var_1_10005, 0) >= 1
	end

	return var_105_2
end

function var_0_1.IsDisplayCommanderCatCustomName(arg_106_0)
	if not arg_106_0.customFlag then
		getProxy = var_1
		PlayerProxy = var_1_10003

		local var_106_0 = var_1(var_1_10003)
		local var_106_1 = var_1.getRawData(var_106_0).id

		PlayerPrefs = var_1_10002
		arg_106_0.customFlag = var_1_10002.GetInt("DisplayCommanderCatCustomName" .. var_106_1, 0) == 0
	end

	return arg_106_0.customFlag
end

function var_0_1.SetDisplayCommanderCatCustomName(arg_107_0, arg_107_1)
	if arg_107_1 == arg_107_0.customFlag then
		return
	end

	arg_107_0.customFlag = arg_107_1

	local var_107_0 = arg_107_0.customFlag and 0 or 1

	getProxy = var_1_10003
	PlayerProxy = var_1_10005

	local var_107_1 = var_1_10003(var_1_10005)
	local var_107_2 = var_3.getRawData(var_107_1).id

	PlayerPrefs = var_1_10004

	var_1_10004.SetInt("DisplayCommanderCatCustomName" .. var_107_2, var_107_0)

	PlayerPrefs = var_4

	var_4.Save()

	return
end

function var_0_1.GetCommanderQuicklyToolRarityConfig(arg_108_0)
	if not arg_108_0.quicklyToolRarityConfig then
		getProxy = var_1
		PlayerProxy = var_1_10003

		local var_108_0 = var_1(var_1_10003)
		local var_108_1 = var_1.getRawData(var_108_0).id

		PlayerPrefs = var_1_10002

		local var_108_2 = var_1_10002.GetString("CommanderQuicklyToolRarityConfig" .. var_108_1, "1#1#1")

		string = var_108_0

		local var_108_3 = var_108_0.split(var_108_2, "#")

		_ = var_4
		arg_108_0.quicklyToolRarityConfig = var_4.map(var_108_3, function(arg_109_0)
			tonumber = var_2_10001

			return var_2_10001(arg_109_0) == 1
		end)
	end

	return arg_108_0.quicklyToolRarityConfig
end

function var_0_1.SaveCommanderQuicklyToolRarityConfig(arg_110_0, arg_110_1)
	local var_110_0 = false

	ipairs = var_1_10003

	for iter_110_0, iter_110_1 in var_1_10003(arg_110_0.quicklyToolRarityConfig) do
		if arg_110_1[iter_110_0] ~= iter_110_1 then
			var_110_0 = true

			break
		end
	end

	if var_110_0 then
		arg_110_0.quicklyToolRarityConfig = arg_110_1
		_ = var_3

		local var_110_1 = var_3.map(arg_110_0.quicklyToolRarityConfig, function(arg_111_0)
			return arg_111_0 and "1" or "0"
		end)

		table = var_4

		local var_110_2 = var_4.concat(var_110_1, "#")

		getProxy = var_5
		PlayerProxy = var_7

		local var_110_3 = var_5(var_7)
		local var_110_4 = var_5.getRawData(var_110_3).id

		PlayerPrefs = var_6

		var_6.SetString("CommanderQuicklyToolRarityConfig" .. var_110_4, var_110_2)

		PlayerPrefs = var_6

		var_6.Save()
	end

	return
end

function var_0_1.GetCommanderLockFlagRarityConfig(arg_112_0)
	if not arg_112_0.lockFlagRarityConfig then
		getProxy = var_1
		PlayerProxy = var_1_10003

		local var_112_0 = var_1(var_1_10003)
		local var_112_1 = var_1.getRawData(var_112_0).id

		PlayerPrefs = var_1_10002

		local var_112_2 = var_1_10002.GetString("CommanderLockFlagRarityConfig_" .. var_112_1, "1#0#0")

		string = var_112_0

		local var_112_3 = var_112_0.split(var_112_2, "#")

		_ = var_4
		arg_112_0.lockFlagRarityConfig = var_4.map(var_112_3, function(arg_113_0)
			tonumber = var_2_10001

			return var_2_10001(arg_113_0) == 1
		end)
	end

	return arg_112_0.lockFlagRarityConfig
end

function var_0_1.SaveCommanderLockFlagRarityConfig(arg_114_0, arg_114_1)
	local var_114_0 = false

	ipairs = var_1_10003

	for iter_114_0, iter_114_1 in var_1_10003(arg_114_0.lockFlagRarityConfig) do
		if arg_114_1[iter_114_0] ~= iter_114_1 then
			var_114_0 = true

			break
		end
	end

	if var_114_0 then
		arg_114_0.lockFlagRarityConfig = arg_114_1
		_ = var_3

		local var_114_1 = var_3.map(arg_114_0.lockFlagRarityConfig, function(arg_115_0)
			return arg_115_0 and "1" or "0"
		end)

		table = var_4

		local var_114_2 = var_4.concat(var_114_1, "#")

		getProxy = var_5
		PlayerProxy = var_7

		local var_114_3 = var_5(var_7)
		local var_114_4 = var_5.getRawData(var_114_3).id

		PlayerPrefs = var_6

		var_6.SetString("CommanderLockFlagRarityConfig_" .. var_114_4, var_114_2)

		PlayerPrefs = var_6

		var_6.Save()
	end

	return
end

function var_0_1.GetCommanderLockFlagTalentConfig(arg_116_0)
	if not arg_116_0.lockFlagTalentConfig then
		getProxy = var_1
		PlayerProxy = var_1_10003

		local var_116_0 = var_1(var_1_10003)
		local var_116_1 = var_1.getRawData(var_116_0).id

		PlayerPrefs = var_1_10002

		local var_116_2 = var_1_10002.GetString("CommanderLockFlagTalentConfig" .. var_116_1, "")
		local var_116_3 = {}

		if var_116_2 == "" then
			ipairs = var_4
			CommanderCatUtil = var_1_10006

			for iter_116_0, iter_116_1 in var_4(var_1_10006.GetAllTalentNames()) do
				var_116_3[iter_116_1.id] = true
			end
		else
			ipairs = var_4
			string = var_1_10006

			for iter_116_2, iter_116_3 in var_4(var_1_10006.split(var_116_2, "#")) do
				string = var_9

				if #var_9.split(iter_116_3, "*") == 2 then
					tonumber = var_10

					local var_116_4 = var_10(var_9[1])

					tonumber = var_11
					var_116_3[var_116_4] = var_11(var_9[2]) == 1
				end
			end
		end

		arg_116_0.lockFlagTalentConfig = var_116_3
	end

	return arg_116_0.lockFlagTalentConfig
end

function var_0_1.SaveCommanderLockFlagTalentConfig(arg_117_0, arg_117_1)
	arg_117_0.lockFlagTalentConfig = arg_117_1

	local var_117_0 = {}

	pairs = var_1_10003

	for iter_117_0, iter_117_1 in var_1_10003(arg_117_1) do
		table = var_1_10008

		var_1_10008.insert(var_117_0, iter_117_0 .. "*" .. (iter_117_1 and "1" or "0"))
	end

	table = var_3

	local var_117_1 = var_3.concat(var_117_0, "#")

	getProxy = var_4
	PlayerProxy = var_6

	local var_117_2 = var_4(var_6)
	local var_117_3 = var_4.getRawData(var_117_2).id

	PlayerPrefs = var_5

	var_5.SetString("CommanderLockFlagTalentConfig" .. var_117_3, var_117_1)

	PlayerPrefs = var_5

	var_5.Save()

	return
end

function var_0_1.GetMainPaintingVariantFlag(arg_118_0, arg_118_1)
	if not arg_118_0.mainPaintingVariantFlag then
		arg_118_0.mainPaintingVariantFlag = {}
	end

	if not arg_118_0.mainPaintingVariantFlag[arg_118_1] then
		getProxy = var_2
		PlayerProxy = var_1_10004

		local var_118_0 = var_2(var_1_10004)
		local var_118_1 = var_2.getRawData(var_118_0).id

		PlayerPrefs = var_1_10003

		local var_118_2 = var_1_10003.GetInt(arg_118_1 .. "_mainMeshImagePainting_ex_" .. var_118_1, 0)

		arg_118_0.mainPaintingVariantFlag[arg_118_1] = var_118_2
	end

	return arg_118_0.mainPaintingVariantFlag[arg_118_1]
end

function var_0_1.SwitchMainPaintingVariantFlag(arg_119_0, arg_119_1)
	local var_119_0 = 1 - arg_119_0:GetMainPaintingVariantFlag(arg_119_1)
	local var_119_1 = arg_119_0.mainPaintingVariantFlag

	var_119_1[arg_119_1] = var_119_0
	getProxy = var_119_1
	PlayerProxy = var_1_10006

	local var_119_2 = var_119_1(var_1_10006)
	local var_119_3 = var_4.getRawData(var_119_2).id

	PlayerPrefs = var_5

	var_5.SetInt(arg_119_1 .. "_mainMeshImagePainting_ex_" .. var_119_3, var_119_0)

	PlayerPrefs = var_5

	var_5.Save()

	return
end

function var_0_1.IsTipDay(arg_120_0, arg_120_1, arg_120_2, arg_120_3)
	getProxy = var_1_10004
	PlayerProxy = var_1_10006

	local var_120_0 = var_1_10004(var_1_10006)
	local var_120_1 = var_4.getRawData(var_120_0).id

	PlayerPrefs = var_1_10005

	return var_1_10005.GetInt(var_120_1 .. "educate_char_" .. arg_120_1 .. arg_120_2 .. arg_120_3, 0) == 1
end

function var_0_1.RecordTipDay(arg_121_0, arg_121_1, arg_121_2, arg_121_3)
	getProxy = var_1_10004
	PlayerProxy = var_1_10006

	local var_121_0 = var_1_10004(var_1_10006)
	local var_121_1 = var_4.getRawData(var_121_0).id

	PlayerPrefs = var_1_10005

	var_1_10005.SetInt(var_121_1 .. "educate_char_" .. arg_121_1 .. arg_121_2 .. arg_121_3, 1)

	PlayerPrefs = var_5

	var_5.Save()

	return
end

function var_0_1.UpdateEducateCharTip(arg_122_0, arg_122_1)
	getProxy = var_1_10002
	PlayerProxy = var_1_10004

	local var_122_0 = var_1_10002(var_1_10004)
	local var_122_1 = var_2.getRawData(var_122_0).id

	NewEducateHelper = var_1_10003

	local var_122_2 = var_1_10003.GetAllUnlockSecretaryIds()
	local var_122_3 = {}

	ipairs = var_1_10005

	for iter_122_0, iter_122_1 in var_1_10005(arg_122_1 or {}) do
		var_122_3[iter_122_1] = true
	end

	ipairs = var_5

	for iter_122_2, iter_122_3 in var_5(var_122_2 or {}) do
		local var_122_4 = var_122_1 .. "educate_char_tip" .. iter_122_3

		if var_122_3[iter_122_3] ~= true then
			PlayerPrefs = var_11

			var_11.SetInt(var_122_4, 1)

			PlayerPrefs = var_11

			var_11.Save()
		end
	end

	arg_122_0:RefillEducateCharTipList()

	return
end

function var_0_1.RefillEducateCharTipList(arg_123_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_123_0 = var_1_10001(var_1_10003)
	local var_123_1 = var_1.getRawData(var_123_0).id

	arg_123_0.educateCharTipList = {}
	LOCK_EDUCATE_SYSTEM = var_2

	if var_2 then
		return
	end

	NewEducateHelper = var_2

	local var_123_2 = var_2.GetAllUnlockSecretaryIds()

	ipairs = var_123_0

	for iter_123_0, iter_123_1 in var_123_0(var_123_2 or {}) do
		PlayerPrefs = var_1_10008

		if var_1_10008.GetInt(var_123_1 .. "educate_char_tip" .. iter_123_1, 0) == 1 then
			table = var_1_10009

			var_1_10009.insert(arg_123_0.educateCharTipList, iter_123_1)
		end
	end

	return
end

function var_0_1.ShouldEducateCharTip(arg_124_0)
	NewEducateHelper = var_1_10001

	if var_1_10001.GetEducateCharSlotMaxCnt() == 0 then
		return false
	end

	if not arg_124_0.educateCharTipList or #arg_124_0.educateCharTipList == 0 then
		arg_124_0:RefillEducateCharTipList()
	end

	_ = var_1

	return var_1.any(arg_124_0.educateCharTipList, function(arg_125_0)
		NewEducateHelper = var_2_10001

		return var_2_10001.IsUnlockDefaultShip(arg_125_0)
	end)
end

function var_0_1._ShouldEducateCharTip(arg_126_0, arg_126_1)
	if not arg_126_0.educateCharTipList or #arg_126_0.educateCharTipList == 0 then
		arg_126_0:RefillEducateCharTipList()
	end

	table = var_2

	if var_2.contains(arg_126_0.educateCharTipList, arg_126_1) then
		NewEducateHelper = var_2

		if var_2.IsUnlockDefaultShip(arg_126_1) then
			return true
		end
	end

	return false
end

function var_0_1.ClearEducateCharTip(arg_127_0, arg_127_1)
	if not arg_127_0:_ShouldEducateCharTip(arg_127_1) then
		return false
	end

	table = var_2

	var_2.removebyvalue(arg_127_0.educateCharTipList, arg_127_1)

	getProxy = var_2
	PlayerProxy = var_4

	local var_127_0 = var_2(var_4)
	local var_127_1 = var_2.getRawData(var_127_0).id .. "educate_char_tip" .. arg_127_1

	PlayerPrefs = var_4

	if var_4.HasKey(var_127_1) then
		PlayerPrefs = var_4

		var_4.DeleteKey(var_127_1)

		PlayerPrefs = var_4

		var_4.Save()
	end

	pg = var_4

	local var_127_2 = var_4.m02
	local var_127_3 = var_4.sendNotification

	GAME = var_1_10007

	var_127_3(var_127_2, var_1_10007.CLEAR_EDUCATE_TIP, {
		id = arg_127_1
	})

	return true
end

function var_0_1.GetMainSceneThemeStyle(arg_128_0)
	PlayerPrefs = var_1_10001

	local var_128_0 = var_1_10001.GetInt

	USAGE_NEW_MAINUI = var_1_10003

	if var_128_0(var_1_10003, 1) == 1 then
		NewMainScene = var_1_10002

		return var_1_10002.THEME_MELLOW
	else
		NewMainScene = var_1_10002

		return var_1_10002.THEME_CLASSIC
	end

	return
end

function var_0_1.IsMellowStyle(arg_129_0)
	local var_129_0 = arg_129_0:GetMainSceneThemeStyle()

	NewMainScene = var_1_10002

	return var_1_10002.THEME_MELLOW == var_129_0
end

function var_0_1.GetMainSceneScreenSleepTime(arg_130_0)
	pg = var_1_10001

	local var_130_0 = var_1_10001.NewGuideMgr.GetInstance()

	if var_1.IsBusy(var_130_0) then
		SleepTimeout = var_1

		return var_1.SystemSetting
	end

	pg = var_1

	local var_130_1 = var_1.settings_other_template[20]

	PlayerPrefs = var_1_10002

	local var_130_2 = var_1_10002.GetInt

	_G = var_1_10004

	if var_130_2(var_1_10004[var_130_1.name], var_130_1.default) == 1 then
		SleepTimeout = var_130_0

		return var_130_0.NeverSleep
	else
		SleepTimeout = var_130_0

		return var_130_0.SystemSetting
	end

	return
end

function var_0_1.ShowL2dResetInMainScene(arg_131_0)
	pg = var_1_10001

	local var_131_0 = var_1_10001.settings_other_template[21]

	PlayerPrefs = var_1_10002

	local var_131_1 = var_1_10002.GetInt

	_G = var_1_10004

	return var_131_1(var_1_10004[var_131_0.name], var_131_0.default) == 1
end

function var_0_1.GetRecommendLowEnerySkipEnable(arg_132_0)
	pg = var_1_10001

	local var_132_0 = var_1_10001.settings_other_template[25]

	PlayerPrefs = var_1_10002

	local var_132_1 = var_1_10002.GetInt

	_G = var_1_10004

	return var_132_1(var_1_10004[var_132_0.name], var_132_0.default) == 1
end

local var_0_2 = "ISLAND_REST_EVENT"

function var_0_1.ShouldTipIslandRestEvet(arg_133_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_133_0 = var_1_10001(var_1_10003)
	local var_133_1 = var_1.getRawData(var_133_0).id

	PlayerPrefs = var_1_10002

	local var_133_2 = var_1_10002.GetInt(var_0_2 .. var_133_1, 0)

	pg = var_133_0

	local var_133_3 = var_133_0.TimeMgr.GetInstance()

	return var_133_2 < var_3.GetServerTime(var_133_3)
end

function var_0_1.RecordIslandRestEvet(arg_134_0)
	GetZeroTime = var_1_10001

	local var_134_0 = var_1_10001()

	getProxy = var_1_10002
	PlayerProxy = var_1_10004

	local var_134_1 = var_1_10002(var_1_10004)
	local var_134_2 = var_2.getRawData(var_134_1).id

	PlayerPrefs = var_1_10003

	var_1_10003.SetInt(var_0_2 .. var_134_2, var_134_0)

	PlayerPrefs = var_3

	var_3.Save()

	return
end

function var_0_1.Reset(arg_135_0)
	arg_135_0:resetEquipSceneIndex()
	arg_135_0:resetActivityLayerIndex()

	arg_135_0.isStopBuildSpeedupReamind = false

	arg_135_0:RestoreFrameRate()

	arg_135_0.randomFlagShipList = nil
	arg_135_0.prevRandomFlagShipTime = nil
	arg_135_0.randomFlagShipMap = nil
	arg_135_0.educateCharTipList = {}

	return
end

function var_0_1.IsExchangeCodeActive()
	getGameset = var_1_10000

	return var_1_10000("exchangecode_ios_on")[1] == 1
end

return var_0_1

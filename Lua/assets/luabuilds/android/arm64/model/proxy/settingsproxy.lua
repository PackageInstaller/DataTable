local var_0_0 = class("SettingsProxy", pm.Proxy)

function var_0_0.onRegister(arg_1_0)
	arg_1_0._isBgmEnble = PlayerPrefs.GetInt("ShipSkinBGM", 1) > 0
	arg_1_0._ShowBg = PlayerPrefs.GetInt("disableBG", 1) > 0
	arg_1_0._ShowLive2d = PlayerPrefs.GetInt("disableLive2d", 1) > 0
	arg_1_0._selectedShipId = PlayerPrefs.GetInt("playerShipId")
	arg_1_0._backyardFoodRemind = PlayerPrefs.GetString("backyardRemind")
	arg_1_0._userAgreement = PlayerPrefs.GetInt("userAgreement", 0)
	arg_1_0._showMaxLevelHelp = PlayerPrefs.GetInt("maxLevelHelp", 0) > 0
	arg_1_0._nextTipAutoBattleTime = PlayerPrefs.GetInt("AutoBattleTip", 0)
	arg_1_0._setFlagShip = PlayerPrefs.GetInt("setFlagShip", 0) > 0
	arg_1_0._setFlagShipForSkinAtlas = PlayerPrefs.GetInt("setFlagShipforskinatlas", 0) > 0
	arg_1_0._setFlagRandom = PlayerPrefs.GetInt("setFlagRandom", 0) > 0
	arg_1_0._screenRatio = PlayerPrefs.GetFloat("SetScreenRatio", ADAPT_TARGET)
	arg_1_0.storyAutoPlayCode = PlayerPrefs.GetInt("story_autoplay_flag", 0)
	NotchAdapt.CheckNotchRatio = arg_1_0._screenRatio
	arg_1_0._nextTipActBossTime = PlayerPrefs.GetInt("ActBossTipLastTime", 0)

	if GetZeroTime() <= arg_1_0._nextTipActBossTime then
		arg_1_0.nextTipActBossExchangeTicket = PlayerPrefs.GetInt("ActBossTip", 0)
	end

	arg_1_0:resetEquipSceneIndex()

	arg_1_0._isShowCollectionHelp = PlayerPrefs.GetInt("collection_Help", 0) > 0
	arg_1_0.showMainSceneWordTip = PlayerPrefs.GetInt("main_scene_word_toggle", 1) > 0
	arg_1_0.lastRequestVersionTime = nil
	arg_1_0.worldBossFlag = {}
	arg_1_0.worldFlag = {}

	return
end

function var_0_0.SetWorldBossFlag(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_0.worldBossFlag[arg_2_1] ~= arg_2_2 then
		arg_2_0.worldBossFlag[arg_2_1] = arg_2_2

		PlayerPrefs.SetInt("worldBossFlag" .. arg_2_1, arg_2_2 and 1 or 0)
		PlayerPrefs.Save()
	end

	return
end

function var_0_0.GetWorldBossFlag(arg_3_0, arg_3_1)
	arg_3_0.worldBossFlag[arg_3_1] = arg_3_0.worldBossFlag[arg_3_1] or PlayerPrefs.GetInt("worldBossFlag" .. arg_3_1, 1) > 0

	return arg_3_0.worldBossFlag[arg_3_1]
end

function var_0_0.SetWorldFlag(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_0.worldFlag[arg_4_1] ~= arg_4_2 then
		arg_4_0.worldFlag[arg_4_1] = arg_4_2

		PlayerPrefs.SetInt("world_flag_" .. arg_4_1, arg_4_2 and 1 or 0)
		PlayerPrefs.Save()
	end

	return
end

function var_0_0.GetWorldFlag(arg_5_0, arg_5_1)
	arg_5_0.worldFlag[arg_5_1] = arg_5_0.worldFlag[arg_5_1] or PlayerPrefs.GetInt("world_flag_" .. arg_5_1, 0) > 0

	return arg_5_0.worldFlag[arg_5_1]
end

function var_0_0.GetDockYardLockBtnFlag(arg_6_0)
	if not arg_6_0.dockYardLockFlag then
		local var_6_0 = PlayerPrefs.GetInt("DockYardLockFlag" .. getProxy(PlayerProxy):getRawData().id, 0)

		arg_6_0.dockYardLockFlag = var_6_0 > 0
	end

	return arg_6_0.dockYardLockFlag
end

function var_0_0.SetDockYardLockBtnFlag(arg_7_0, arg_7_1)
	if arg_7_0.dockYardLockFlag ~= arg_7_1 then
		local var_7_0 = getProxy(PlayerProxy)

		PlayerPrefs.SetInt("DockYardLockFlag" .. var_7_0:getRawData().id, arg_7_1 and 1 or 0)
		PlayerPrefs.Save()

		arg_7_0.dockYardLockFlag = arg_7_1
	end

	return
end

function var_0_0.GetDockYardLevelBtnFlag(arg_8_0)
	if not arg_8_0.dockYardLevelFlag then
		local var_8_0 = PlayerPrefs.GetInt("DockYardLevelFlag" .. getProxy(PlayerProxy):getRawData().id, 0)

		arg_8_0.dockYardLevelFlag = var_8_0 > 0
	end

	return arg_8_0.dockYardLevelFlag
end

function var_0_0.SetDockYardLevelBtnFlag(arg_9_0, arg_9_1)
	if arg_9_0.dockYardLevelFlag ~= arg_9_1 then
		local var_9_0 = getProxy(PlayerProxy)

		PlayerPrefs.SetInt("DockYardLevelFlag" .. var_9_0:getRawData().id, arg_9_1 and 1 or 0)
		PlayerPrefs.Save()

		arg_9_0.dockYardLevelFlag = arg_9_1
	end

	return
end

function var_0_0.IsShowCollectionHelp(arg_10_0)
	return arg_10_0._isShowCollectionHelp
end

function var_0_0.SetCollectionHelpFlag(arg_11_0, arg_11_1)
	if arg_11_0._isShowCollectionHelp ~= arg_11_1 then
		arg_11_0._isShowCollectionHelp = arg_11_1

		PlayerPrefs.SetInt("collection_Help", arg_11_1 and 1 or 0)
		PlayerPrefs.Save()
	end

	return
end

function var_0_0.IsBGMEnable(arg_12_0)
	return arg_12_0._isBgmEnble
end

function var_0_0.SetBgmFlag(arg_13_0, arg_13_1)
	if arg_13_0._isBgmEnble ~= arg_13_1 then
		arg_13_0._isBgmEnble = arg_13_1

		PlayerPrefs.SetInt("ShipSkinBGM", arg_13_1 and 1 or 0)
		PlayerPrefs.Save()
	end

	return
end

function var_0_0.IsEnableMainMusicPlayer(arg_14_0)
	return true
end

function var_0_0.getSkinPosSetting(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1:GetRecordPosKey()
	local var_15_1 = arg_15_0:GetCurrMainUIStyleKeyForSkinShop()

	if PlayerPrefs.HasKey(var_15_1 .. tostring(var_15_0) .. "_scale") then
		return PlayerPrefs.GetFloat(var_15_1 .. tostring(var_15_0) .. "_x", 0), PlayerPrefs.GetFloat(var_15_1 .. tostring(var_15_0) .. "_y", 0), (PlayerPrefs.GetFloat(var_15_1 .. tostring(var_15_0) .. "_scale", 1))
	else
		return nil
	end

	return
end

function var_0_0.setSkinPosSetting(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	local var_16_0 = arg_16_1:GetRecordPosKey()
	local var_16_1 = arg_16_0:GetCurrMainUIStyleKeyForSkinShop()

	PlayerPrefs.SetFloat(var_16_1 .. tostring(var_16_0) .. "_x", arg_16_2)
	PlayerPrefs.SetFloat(var_16_1 .. tostring(var_16_0) .. "_y", arg_16_3)
	PlayerPrefs.SetFloat(var_16_1 .. tostring(var_16_0) .. "_scale", arg_16_4)
	PlayerPrefs.Save()

	return
end

function var_0_0.setSkinScaleSetting(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	local var_17_0 = arg_17_1:GetRecordPosKey()
	local var_17_1 = tostring(var_17_0) .. arg_17_2 .. "_" .. arg_17_3 .. "_part_scale"

	PlayerPrefs.SetFloat(tostring(var_17_0) .. arg_17_2 .. "_" .. arg_17_3 .. "_part_scale", arg_17_4)

	return
end

function var_0_0.getSkinScaleSetting(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0
	local var_18_1 = tostring((arg_18_1:GetRecordPosKey())) .. arg_18_2 .. "_" .. arg_18_3 .. "_part_scale"

	if PlayerPrefs.HasKey(var_18_1) then
		var_18_0 = PlayerPrefs.GetFloat(var_18_1, 1)
	else
		return 1
	end

	return var_18_0
end

function var_0_0.GetCurrMainUIStyleKeyForSkinShop(arg_19_0)
	local var_19_0 = arg_19_0:GetMainSceneThemeStyle()

	if var_19_0 == NewMainScene.THEME_CLASSIC then
		return ""
	else
		return var_19_0
	end

	return
end

function var_0_0.resetSkinPosSetting(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_1:GetRecordPosKey()

	PlayerPrefs.DeleteKey(tostring(var_20_0) .. "_x")
	PlayerPrefs.DeleteKey(tostring(var_20_0) .. "_y")
	PlayerPrefs.DeleteKey(tostring(var_20_0) .. "_scale")
	PlayerPrefs.Save()

	return
end

function var_0_0.getCharacterSetting(arg_21_0, arg_21_1, arg_21_2)
	return PlayerPrefs.GetInt(tostring(arg_21_1) .. "_" .. arg_21_2, 1) > 0
end

function var_0_0.setCharacterSetting(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	PlayerPrefs.SetInt(tostring(arg_22_1) .. "_" .. arg_22_2, arg_22_3 and 1 or 0)
	PlayerPrefs.Save()

	return
end

function var_0_0.getCurrentSecretaryIndex(arg_23_0)
	local var_23_0 = PlayerPrefs.GetInt("currentSecretaryIndex", 1)

	if var_23_0 > PlayerVitaeShipsPage.GetAllUnlockSlotCnt() then
		arg_23_0:setCurrentSecretaryIndex(1)

		return 1
	else
		return PlayerVitaeShipsPage.GetSlotIndexList()[var_23_0]
	end

	return
end

function var_0_0.rotateCurrentSecretaryIndex(arg_24_0)
	local var_24_0 = PlayerPrefs.GetInt("currentSecretaryIndex", 1) + 1

	if PlayerVitaeShipsPage.GetAllUnlockSlotCnt() < var_24_0 or var_24_0 == PlayerVitaeShipsPage.EDUCATE_CHAR_SLOT_ID and not (function()
		local var_25_0 = getProxy(PlayerProxy):getRawData():ExistEducateChar()

		if var_25_0 then
			var_25_0 = getProxy(SettingsProxy):GetFlagShipDisplayMode() ~= FlAG_SHIP_DISPLAY_ONLY_SHIP
		end

		return var_25_0
	end)() then
		var_24_0 = 1
	end

	arg_24_0:setCurrentSecretaryIndex(var_24_0)
	pg.m02:sendNotification(GAME.ROTATE_PAINTING_INDEX)

	return
end

function var_0_0.setCurrentSecretaryIndex(arg_26_0, arg_26_1)
	PlayerPrefs.SetInt("currentSecretaryIndex", arg_26_1)
	PlayerPrefs.Save()

	return
end

function var_0_0.SetFlagShip(arg_27_0, arg_27_1)
	if arg_27_0._setFlagShip ~= arg_27_1 then
		arg_27_0._setFlagShip = arg_27_1

		PlayerPrefs.SetInt("setFlagShip", arg_27_1 and 1 or 0)
		PlayerPrefs.Save()
	end

	return
end

function var_0_0.GetSetFlagShip(arg_28_0)
	return arg_28_0._setFlagShip
end

function var_0_0.SetFlagShipForSkinAtlas(arg_29_0, arg_29_1)
	if arg_29_0._setFlagShipForSkinAtlas ~= arg_29_1 then
		arg_29_0._setFlagShipForSkinAtlas = arg_29_1

		PlayerPrefs.SetInt("setFlagShipforskinatlas", arg_29_1 and 1 or 0)
		PlayerPrefs.Save()
	end

	return
end

function var_0_0.GetSetFlagShipForSkinAtlas(arg_30_0)
	return arg_30_0._setFlagShipForSkinAtlas
end

function var_0_0.SetFlagRandom(arg_31_0, arg_31_1)
	if arg_31_0._setFlagRandom ~= arg_31_1 then
		arg_31_0._setFlagRandom = arg_31_1

		PlayerPrefs.SetInt("setFlagRandom", arg_31_1 and 1 or 0)
		PlayerPrefs.Save()
	end

	return
end

function var_0_0.GetFlagRandom(arg_32_0)
	return arg_32_0._setFlagRandom
end

function var_0_0.CheckNeedUserAgreement(arg_33_0)
	if PLATFORM_CODE == PLATFORM_KR then
		return false
	elseif PLATFORM_CODE == PLATFORM_CH then
		return false
	elseif PLATFORM_CODE == PLATFORM_JP then
		return false
	else
		return arg_33_0:GetUserAgreementFlag() > arg_33_0._userAgreement
	end

	return
end

function var_0_0.GetUserAgreementFlag(arg_34_0)
	local var_34_0 = USER_AGREEMENT_FLAG_DEFAULT

	if PLATFORM_CODE == PLATFORM_CHT then
		var_34_0 = USER_AGREEMENT_FLAG_TW
	end

	return var_34_0
end

function var_0_0.SetUserAgreement(arg_35_0)
	if arg_35_0:CheckNeedUserAgreement() then
		local var_35_0 = arg_35_0:GetUserAgreementFlag()

		PlayerPrefs.SetInt("userAgreement", var_35_0)
		PlayerPrefs.Save()

		arg_35_0._userAgreement = var_35_0
	end

	return
end

function var_0_0.IsLive2dEnable(arg_36_0)
	return arg_36_0._ShowLive2d
end

function var_0_0.IsBGEnable(arg_37_0)
	return arg_37_0._ShowBg
end

function var_0_0.SetSelectedShipId(arg_38_0, arg_38_1)
	if arg_38_0._selectedShipId ~= arg_38_1 then
		arg_38_0._selectedShipId = arg_38_1

		PlayerPrefs.SetInt("playerShipId", arg_38_1)
		PlayerPrefs.Save()
	end

	return
end

function var_0_0.GetSelectedShipId(arg_39_0)
	return arg_39_0._selectedShipId
end

function var_0_0.setEquipSceneIndex(arg_40_0, arg_40_1)
	arg_40_0._equipSceneIndex = arg_40_1

	return
end

function var_0_0.getEquipSceneIndex(arg_41_0)
	return arg_41_0._equipSceneIndex
end

function var_0_0.resetEquipSceneIndex(arg_42_0)
	arg_42_0._equipSceneIndex = StoreHouseConst.WARP_TO_MATERIAL

	return
end

function var_0_0.setActivityLayerIndex(arg_43_0, arg_43_1)
	arg_43_0._activityLayerIndex = arg_43_1

	return
end

function var_0_0.getActivityLayerIndex(arg_44_0)
	return arg_44_0._activityLayerIndex
end

function var_0_0.resetActivityLayerIndex(arg_45_0)
	arg_45_0._activityLayerIndex = 1

	return
end

function var_0_0.setBackyardRemind(arg_46_0)
	local var_46_0 = GetZeroTime()

	if arg_46_0._backyardFoodRemind ~= tostring(var_46_0) then
		PlayerPrefs.SetString("backyardRemind", var_46_0)
		PlayerPrefs.Save()

		arg_46_0._backyardFoodRemind = var_46_0
	end

	return
end

function var_0_0.getBackyardRemind(arg_47_0)
	if not arg_47_0._backyardFoodRemind or arg_47_0._backyardFoodRemind == "" then
		return 0
	else
		return tonumber(arg_47_0._backyardFoodRemind)
	end

	return
end

function var_0_0.getMaxLevelHelp(arg_48_0)
	return arg_48_0._showMaxLevelHelp
end

function var_0_0.setMaxLevelHelp(arg_49_0, arg_49_1)
	if arg_49_0._showMaxLevelHelp ~= arg_49_1 then
		arg_49_0._showMaxLevelHelp = arg_49_1

		PlayerPrefs.SetInt("maxLevelHelp", arg_49_1 and 1 or 0)
		PlayerPrefs.Save()
	end

	return
end

function var_0_0.setStopBuildSpeedupRemind(arg_50_0)
	arg_50_0.isStopBuildSpeedupReamind = true

	return
end

function var_0_0.getStopBuildSpeedupRemind(arg_51_0)
	return arg_51_0.isStopBuildSpeedupReamind
end

function var_0_0.checkReadHelp(arg_52_0, arg_52_1)
	if not getProxy(PlayerProxy):getData() then
		return true
	end

	if arg_52_1 == "help_backyard" then
		return true
	else
		local var_52_0 = pg.SeriesGuideMgr.GetInstance()

		if var_52_0:isEnd() then
			local var_52_1 = PlayerPrefs.GetInt(arg_52_1, 0)

			return PlayerPrefs.GetInt(arg_52_1, 0) > 0
		end
	end

	return true
end

function var_0_0.recordReadHelp(arg_53_0, arg_53_1)
	PlayerPrefs.SetInt(arg_53_1, 1)
	PlayerPrefs.Save()

	return
end

function var_0_0.clearAllReadHelp(arg_54_0)
	PlayerPrefs.DeleteKey("tactics_lesson_system_introduce")
	PlayerPrefs.DeleteKey("help_shipinfo_equip")
	PlayerPrefs.DeleteKey("help_shipinfo_detail")
	PlayerPrefs.DeleteKey("help_shipinfo_intensify")
	PlayerPrefs.DeleteKey("help_shipinfo_upgrate")
	PlayerPrefs.DeleteKey("help_backyard")
	PlayerPrefs.DeleteKey("has_entered_class")
	PlayerPrefs.DeleteKey("help_commander_info")
	PlayerPrefs.DeleteKey("help_commander_play")
	PlayerPrefs.DeleteKey("help_commander_ability")
	PlayerPrefs.DeleteKey("loveactivity_help_tips")

	return
end

function var_0_0.setAutoBattleTip(arg_55_0)
	local var_55_0 = GetZeroTime()

	arg_55_0._nextTipAutoBattleTime = var_55_0

	PlayerPrefs.SetInt("AutoBattleTip", var_55_0)
	PlayerPrefs.Save()

	return
end

function var_0_0.isTipAutoBattle(arg_56_0)
	local var_56_0 = pg.TimeMgr.GetInstance()

	return var_56_0:GetServerTime() > arg_56_0._nextTipAutoBattleTime
end

function var_0_0.setActBossExchangeTicketTip(arg_57_0, arg_57_1)
	if arg_57_0.nextTipActBossExchangeTicket == arg_57_1 then
		return
	end

	arg_57_0.nextTipActBossExchangeTicket = arg_57_1

	local var_57_0 = GetZeroTime()

	if var_57_0 > arg_57_0._nextTipActBossTime then
		arg_57_0._nextTipActBossTime = var_57_0

		PlayerPrefs.SetInt("ActBossTipLastTime", var_57_0)
	end

	PlayerPrefs.SetInt("ActBossTip", arg_57_1)
	PlayerPrefs.Save()

	return
end

function var_0_0.isTipActBossExchangeTicket(arg_58_0)
	if pg.TimeMgr.GetInstance():GetServerTime() > arg_58_0._nextTipActBossTime then
		return nil
	end

	return arg_58_0.nextTipActBossExchangeTicket
end

function var_0_0.SetScreenRatio(arg_59_0, arg_59_1)
	if arg_59_0._screenRatio ~= arg_59_1 then
		arg_59_0._screenRatio = arg_59_1

		PlayerPrefs.SetFloat("SetScreenRatio", arg_59_1)
		PlayerPrefs.Save()
	end

	return
end

function var_0_0.GetScreenRatio(arg_60_0)
	return arg_60_0._screenRatio
end

function var_0_0.CheckLargeScreen(arg_61_0)
	return Screen.width / Screen.height > 2
end

function var_0_0.IsShowBeatMonseterNianCurtain(arg_62_0)
	local var_62_0 = pg.TimeMgr.GetInstance()
	local var_62_1 = PlayerPrefs.GetString("HitMonsterNianLayer2020" .. getProxy(PlayerProxy):getRawData().id, "0")

	return var_62_0:GetServerTime() > tonumber(var_62_1)
end

function var_0_0.SetBeatMonseterNianFlag(arg_63_0)
	PlayerPrefs.SetString("HitMonsterNianLayer2020" .. getProxy(PlayerProxy):getRawData().id, GetZeroTime())
	PlayerPrefs.Save()

	return
end

function var_0_0.ShouldShowEventActHelp(arg_64_0)
	if not arg_64_0.actEventFlag then
		local var_64_0 = PlayerPrefs.GetInt("event_act_help1" .. getProxy(PlayerProxy):getRawData().id, 0)

		arg_64_0.actEventFlag = var_64_0 > 0
	end

	return not arg_64_0.actEventFlag
end

function var_0_0.MarkEventActHelpFlag(arg_65_0)
	if not arg_65_0.actEventFlag then
		arg_65_0.actEventFlag = true

		PlayerPrefs.SetInt("event_act_help1" .. getProxy(PlayerProxy):getRawData().id, 1)
		PlayerPrefs.Save()
	end

	return
end

function var_0_0.SetStorySpeed(arg_66_0, arg_66_1)
	arg_66_0.storySpeed = arg_66_1

	local var_66_0 = getProxy(PlayerProxy) and getProxy(PlayerProxy):getRawData().id or 1

	PlayerPrefs.SetInt("story_speed_flag" .. var_66_0, arg_66_1)
	PlayerPrefs.Save()

	return
end

function var_0_0.GetStorySpeed(arg_67_0)
	if not arg_67_0.storySpeed then
		local var_67_0 = getProxy(PlayerProxy) and getProxy(PlayerProxy):getRawData().id or 1

		arg_67_0.storySpeed = PlayerPrefs.GetInt("story_speed_flag" .. var_67_0, 0)
	end

	return arg_67_0.storySpeed
end

function var_0_0.GetStoryAutoPlayFlag(arg_68_0)
	return arg_68_0.storyAutoPlayCode > 0
end

function var_0_0.SetStoryAutoPlayFlag(arg_69_0, arg_69_1)
	if arg_69_0.storyAutoPlayCode ~= arg_69_1 then
		PlayerPrefs.SetInt("story_autoplay_flag", arg_69_1)
		PlayerPrefs.Save()

		arg_69_0.storyAutoPlayCode = arg_69_1
	end

	return
end

function var_0_0.GetPaintingDownloadPrefs(arg_70_0)
	return PlayerPrefs.GetInt("Painting_Download_Prefs", 0)
end

function var_0_0.SetPaintingDownloadPrefs(arg_71_0, arg_71_1)
	PlayerPrefs.SetInt("Painting_Download_Prefs", arg_71_1)

	return
end

function var_0_0.ShouldShipMainSceneWord(arg_72_0)
	return arg_72_0.showMainSceneWordTip
end

function var_0_0.SaveMainSceneWordFlag(arg_73_0, arg_73_1)
	if arg_73_0.showMainSceneWordTip ~= arg_73_1 then
		arg_73_0.showMainSceneWordTip = arg_73_1

		PlayerPrefs.SetInt("main_scene_word_toggle", arg_73_1 and 1 or 0)
		PlayerPrefs.Save()
	end

	return
end

function var_0_0.RecordFrameRate(arg_74_0)
	arg_74_0.originalFrameRate = arg_74_0.originalFrameRate or Application.targetFrameRate

	return
end

function var_0_0.RestoreFrameRate(arg_75_0)
	if arg_75_0.originalFrameRate then
		Application.targetFrameRate = arg_75_0.originalFrameRate
		arg_75_0.originalFrameRate = nil
	end

	return
end

function var_0_0.ResetTimeLimitSkinShopTip(arg_76_0)
	local var_76_0 = pg.TimeMgr.GetInstance()

	arg_76_0.isTipLimitSkinShop = PlayerPrefs.GetInt("tipLimitSkinShopTime_", 0) <= var_76_0:GetServerTime()

	if arg_76_0.isTipLimitSkinShop then
		arg_76_0.nextTipLimitSkinShopTime = GetZeroTime()
	end

	return
end

function var_0_0.ShouldTipTimeLimitSkinShop(arg_77_0)
	return arg_77_0.isTipLimitSkinShop
end

function var_0_0.SetNextTipTimeLimitSkinShop(arg_78_0)
	if arg_78_0.isTipLimitSkinShop and arg_78_0.nextTipLimitSkinShopTime then
		PlayerPrefs.SetInt("tipLimitSkinShopTime_", arg_78_0.nextTipLimitSkinShopTime)
		PlayerPrefs.Save()

		arg_78_0.nextTipLimitSkinShopTime = nil
		arg_78_0.isTipLimitSkinShop = false
	end

	return
end

function var_0_0.WorldBossProgressTipFlag(arg_79_0, arg_79_1)
	if arg_79_0.WorldBossProgressTipValue ~= arg_79_1 then
		arg_79_0.WorldBossProgressTipValue = arg_79_1

		PlayerPrefs.SetString("_WorldBossProgressTipFlag_", arg_79_1)
		PlayerPrefs.Save()
	end

	return
end

function var_0_0.GetWorldBossProgressTipFlag(arg_80_0)
	if not arg_80_0.WorldBossProgressTipValue then
		local var_80_0 = PlayerPrefs.GetString("_WorldBossProgressTipFlag_", pg.gameset.joint_boss_ticket.description[1] .. "&" .. pg.gameset.joint_boss_ticket.description[1] + pg.gameset.joint_boss_ticket.description[2])

		arg_80_0.WorldBossProgressTipValue = var_80_0

		return var_80_0
	else
		return arg_80_0.WorldBossProgressTipValue
	end

	return
end

function var_0_0.GetWorldBossProgressTipTable(arg_81_0)
	local var_81_0 = arg_81_0:GetWorldBossProgressTipFlag()

	if not var_81_0 or var_81_0 == "" then
		return {}
	end

	return string.split(var_81_0, "&")
end

function var_0_0.GetChatFlag(arg_82_0)
	if not arg_82_0.chatFlag then
		if getProxy(GuildProxy):getRawData() then
			table.insert({
				ChatConst.ChannelWorld,
				ChatConst.ChannelPublic,
				ChatConst.ChannelFriend
			}, ChatConst.ChannelGuild)
		end

		arg_82_0.chatFlag = PlayerPrefs.GetInt("chat__setting", IndexConst.Flags2Bits({
			ChatConst.ChannelWorld,
			ChatConst.ChannelPublic,
			ChatConst.ChannelFriend
		}))
	end

	return arg_82_0.chatFlag
end

function var_0_0.SetChatFlag(arg_83_0, arg_83_1)
	if arg_83_0.chatFlag ~= arg_83_1 then
		arg_83_0.chatFlag = arg_83_1

		PlayerPrefs.SetInt("chat__setting", arg_83_1)
		PlayerPrefs.Save()
	end

	return
end

function var_0_0.IsShowActivityMapSPTip()
	local var_84_0 = pg.TimeMgr.GetInstance()
	local var_84_1 = "ActivityMapSPTip" .. getProxy(PlayerProxy):getRawData().id

	return var_84_0:GetServerTime() > PlayerPrefs.GetInt(var_84_1, 0)
end

function var_0_0.SetActivityMapSPTip()
	PlayerPrefs.SetInt("ActivityMapSPTip" .. getProxy(PlayerProxy):getRawData().id, GetZeroTime())
	PlayerPrefs.Save()

	return
end

function var_0_0.IsTipNewTheme(arg_86_0)
	local var_86_0 = pg.backyard_theme_template.all[#pg.backyard_theme_template.all]
	local var_86_1 = pg.furniture_shop_template[pg.backyard_theme_template[pg.backyard_theme_template.all[#pg.backyard_theme_template.all]].ids[1]]
	local var_86_2 = PlayerPrefs.GetInt(getProxy(PlayerProxy):getRawData().id .. "IsTipNewTheme" .. pg.backyard_theme_template.all[#pg.backyard_theme_template.all], 0) == 0
	local var_86_3

	if pg.furniture_shop_template[pg.backyard_theme_template[pg.backyard_theme_template.all[#pg.backyard_theme_template.all]].ids[1]] then
		::label_86_0::

		if var_86_1.new == 1 then
			var_86_3 = pg.TimeMgr.GetInstance():inTime(var_86_1.time)

			if var_86_3 then
				var_86_3 = var_86_2
			end
		else
			var_86_3 = false
		end

		if false then
			var_86_3 = true
		end
	end

	arg_86_0.lastThemeId = var_86_3 and var_86_0 or nil

	return arg_86_0.lastThemeId ~= nil
end

function var_0_0.UpdateNewThemeValue(arg_87_0)
	if arg_87_0.lastThemeId then
		PlayerPrefs.SetInt(getProxy(PlayerProxy):getRawData().id .. "IsTipNewTheme" .. arg_87_0.lastThemeId, 1)
		PlayerPrefs.Save()
	end

	return
end

function var_0_0.GetNewGemFurnitureLocalCache(arg_88_0)
	if not arg_88_0.cacheGemFuruitures then
		arg_88_0.cacheGemFuruitures = {}

		local var_88_0 = PlayerPrefs.GetString(getProxy(PlayerProxy):getRawData().id .. "IsTipNewGenFurniture")

		if var_88_0 ~= "" then
			for iter_88_0, iter_88_1 in ipairs((string.split(var_88_0, "#"))) do
				arg_88_0.cacheGemFuruitures[tonumber(iter_88_1)] = true
			end
		end
	end

	return arg_88_0.cacheGemFuruitures
end

function var_0_0.IsTipNewGemFurniture(arg_89_0)
	local var_89_0 = arg_89_0:GetNewGemFurnitureLocalCache()
	local var_89_1 = getProxy(DormProxy):GetTag7Furnitures()

	arg_89_0.newGemFurniture = _.any(var_89_1, function(arg_90_0)
		return pg.furniture_shop_template[arg_90_0].new == 1 and not var_89_0[arg_90_0]
	end) and var_89_1 or nil

	return arg_89_0.newGemFurniture ~= nil
end

function var_0_0.UpdateNewGemFurnitureValue(arg_91_0)
	if arg_91_0.newGemFurniture then
		for iter_91_0, iter_91_1 in pairs(arg_91_0.newGemFurniture) do
			arg_91_0.cacheGemFuruitures[iter_91_1] = true
		end

		PlayerPrefs.SetString(getProxy(PlayerProxy):getRawData().id .. "IsTipNewGenFurniture", (table.concat(arg_91_0.newGemFurniture, "#")))
		PlayerPrefs.Save()
	end

	return
end

function var_0_0.GetRandomFlagShipList(arg_92_0)
	if arg_92_0.randomFlagShipList then
		return arg_92_0.randomFlagShipList
	end

	local var_92_0 = getProxy(PlayerProxy)
	local var_92_1 = PlayerPrefs.GetString("RandomFlagShipList" .. var_92_0:getRawData().id, "")

	arg_92_0.randomFlagShipList = var_92_1 == "" and {} or string.split(var_92_1, "#")

	return arg_92_0.randomFlagShipList
end

function var_0_0.IsRandomFlagShip(arg_93_0, arg_93_1)
	if not arg_93_0.randomFlagShipMap then
		arg_93_0.randomFlagShipMap = {}

		for iter_93_0, iter_93_1 in ipairs(arg_93_0:GetRandomFlagShipList()) do
			arg_93_0.randomFlagShipMap[iter_93_1] = true
		end
	end

	return arg_93_0.randomFlagShipMap[arg_93_1] == true
end

function var_0_0.IsOpenRandomFlagShip(arg_94_0)
	local var_94_0 = arg_94_0:GetRandomFlagShipList()
	local var_94_1 = getProxy(BayProxy)

	return #var_94_0 > 0 and _.any(var_94_0, function(arg_95_0)
		local var_95_0, var_95_1 = ShipPhantom.UnpackMark(arg_95_0)

		return var_94_1:RawGetShipById(var_95_0) ~= nil
	end)
end

function var_0_0.UpdateRandomFlagShipList(arg_96_0, arg_96_1)
	arg_96_0.randomFlagShipMap = nil
	arg_96_0.randomFlagShipList = arg_96_1

	for iter_96_0, iter_96_1 in ipairs(arg_96_1) do
		local var_96_0 = getProxy(BayProxy):GetShipPhantom(iter_96_1)

		if var_96_0 and var_96_0.phantomId > 0 then
			pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildPhantom(var_96_0:getSkinId()))
		end
	end

	PlayerPrefs.SetString("RandomFlagShipList" .. getProxy(PlayerProxy):getRawData().id, (table.concat(arg_96_1, "#")))
	PlayerPrefs.Save()

	return
end

function var_0_0.GetPrevRandomFlagShipTime(arg_97_0)
	if arg_97_0.prevRandomFlagShipTime then
		return arg_97_0.prevRandomFlagShipTime
	end

	local var_97_0 = getProxy(PlayerProxy)

	arg_97_0.prevRandomFlagShipTime = PlayerPrefs.GetInt("RandomFlagShipTime" .. var_97_0:getRawData().id, 0)

	return arg_97_0.prevRandomFlagShipTime
end

function var_0_0.SetPrevRandomFlagShipTime(arg_98_0, arg_98_1)
	if arg_98_0.prevRandomFlagShipTime == arg_98_1 then
		return
	end

	arg_98_0.prevRandomFlagShipTime = arg_98_1

	PlayerPrefs.SetInt("RandomFlagShipTime" .. getProxy(PlayerProxy):getRawData().id, arg_98_1)
	PlayerPrefs.Save()

	return
end

function var_0_0.GetFlagShipDisplayMode(arg_99_0)
	arg_99_0.flagShipDisplayMode = arg_99_0.flagShipDisplayMode or PlayerPrefs.GetInt("flag-ship-display-mode" .. getProxy(PlayerProxy):getRawData().id, FlAG_SHIP_DISPLAY_ALL)

	return arg_99_0.flagShipDisplayMode
end

function var_0_0.SetFlagShipDisplayMode(arg_100_0, arg_100_1)
	if arg_100_0.flagShipDisplayMode ~= arg_100_1 then
		arg_100_0.flagShipDisplayMode = arg_100_1

		PlayerPrefs.SetInt("flag-ship-display-mode" .. getProxy(PlayerProxy):getRawData().id, arg_100_1)
		PlayerPrefs.Save()
	end

	return
end

function var_0_0.RecordContinuousOperationAutoSubStatus(arg_101_0, arg_101_1)
	if arg_101_1 then
		return
	end

	local var_101_0 = getProxy(PlayerProxy)

	PlayerPrefs.SetInt("AutoBotCOFlag" .. var_101_0:getRawData().id, 1)
	PlayerPrefs.Save()

	return
end

function var_0_0.ResetContinuousOperationAutoSub(arg_102_0)
	local var_102_0 = getProxy(PlayerProxy):getRawData().id

	if PlayerPrefs.GetInt("AutoBotCOFlag" .. var_102_0, 0) == 0 then
		return
	end

	pg.m02:sendNotification(GAME.AUTO_SUB, {
		isActiveSub = true,
		system = SYSTEM_ACT_BOSS
	})
	PlayerPrefs.SetInt("AutoBotCOFlag" .. var_102_0, 0)
	PlayerPrefs.Save()

	return
end

function var_0_0.SetWorkbenchDailyTip(arg_103_0)
	PlayerPrefs.SetInt("WorkbenchDailyTip" .. getProxy(PlayerProxy):getRawData().id, (GetZeroTime()))
	PlayerPrefs.Save()

	return
end

function var_0_0.IsTipWorkbenchDaily(arg_104_0)
	local var_104_0 = pg.TimeMgr.GetInstance()
	local var_104_1 = "WorkbenchDailyTip" .. getProxy(PlayerProxy):getRawData().id

	return var_104_0:GetServerTime() > PlayerPrefs.GetInt(var_104_1, 0)
end

function var_0_0.IsDisplayResultPainting(arg_105_0)
	local var_105_0 = false

	if PlayerPrefs.HasKey(BATTLERESULT_SKIP_DISPAY_PAINTING) then
		var_105_0 = PlayerPrefs.GetInt(BATTLERESULT_SKIP_DISPAY_PAINTING) <= 0

		PlayerPrefs.DeleteKey(BATTLERESULT_SKIP_DISPAY_PAINTING)
		PlayerPrefs.SetInt(BATTLERESULT_DISPAY_PAINTING, var_105_0 and 1 or 0)
		PlayerPrefs.Save()
	else
		var_105_0 = PlayerPrefs.GetInt(BATTLERESULT_DISPAY_PAINTING, 0) >= 1
	end

	return var_105_0
end

function var_0_0.IsDisplayCommanderCatCustomName(arg_106_0)
	if not arg_106_0.customFlag then
		local var_106_0 = getProxy(PlayerProxy)

		arg_106_0.customFlag = PlayerPrefs.GetInt("DisplayCommanderCatCustomName" .. var_106_0:getRawData().id, 0) == 0
	end

	return arg_106_0.customFlag
end

function var_0_0.SetDisplayCommanderCatCustomName(arg_107_0, arg_107_1)
	if arg_107_1 == arg_107_0.customFlag then
		return
	end

	arg_107_0.customFlag = arg_107_1

	local var_107_0 = getProxy(PlayerProxy)

	PlayerPrefs.SetInt("DisplayCommanderCatCustomName" .. var_107_0:getRawData().id, arg_107_0.customFlag and 0 or 1)
	PlayerPrefs.Save()

	return
end

function var_0_0.GetCommanderQuicklyToolRarityConfig(arg_108_0)
	arg_108_0.quicklyToolRarityConfig = arg_108_0.quicklyToolRarityConfig or _.map(string.split(PlayerPrefs.GetString("CommanderQuicklyToolRarityConfig" .. getProxy(PlayerProxy):getRawData().id, "1#1#1"), "#"), function(arg_109_0)
		return tonumber(arg_109_0) == 1
	end)

	return arg_108_0.quicklyToolRarityConfig
end

function var_0_0.SaveCommanderQuicklyToolRarityConfig(arg_110_0, arg_110_1)
	local var_110_0 = false

	for iter_110_0, iter_110_1 in ipairs(arg_110_0.quicklyToolRarityConfig) do
		if arg_110_1[iter_110_0] ~= iter_110_1 then
			var_110_0 = true

			break
		end
	end

	if var_110_0 then
		arg_110_0.quicklyToolRarityConfig = arg_110_1

		PlayerPrefs.SetString("CommanderQuicklyToolRarityConfig" .. getProxy(PlayerProxy):getRawData().id, (table.concat(_.map(arg_110_0.quicklyToolRarityConfig, function(arg_111_0)
			return arg_111_0 and "1" or "0"
		end), "#")))
		PlayerPrefs.Save()
	end

	return
end

function var_0_0.GetCommanderLockFlagRarityConfig(arg_112_0)
	arg_112_0.lockFlagRarityConfig = arg_112_0.lockFlagRarityConfig or _.map(string.split(PlayerPrefs.GetString("CommanderLockFlagRarityConfig_" .. getProxy(PlayerProxy):getRawData().id, "1#0#0"), "#"), function(arg_113_0)
		return tonumber(arg_113_0) == 1
	end)

	return arg_112_0.lockFlagRarityConfig
end

function var_0_0.SaveCommanderLockFlagRarityConfig(arg_114_0, arg_114_1)
	local var_114_0 = false

	for iter_114_0, iter_114_1 in ipairs(arg_114_0.lockFlagRarityConfig) do
		if arg_114_1[iter_114_0] ~= iter_114_1 then
			var_114_0 = true

			break
		end
	end

	if var_114_0 then
		arg_114_0.lockFlagRarityConfig = arg_114_1

		PlayerPrefs.SetString("CommanderLockFlagRarityConfig_" .. getProxy(PlayerProxy):getRawData().id, (table.concat(_.map(arg_114_0.lockFlagRarityConfig, function(arg_115_0)
			return arg_115_0 and "1" or "0"
		end), "#")))
		PlayerPrefs.Save()
	end

	return
end

function var_0_0.GetCommanderLockFlagTalentConfig(arg_116_0)
	if not arg_116_0.lockFlagTalentConfig then
		local var_116_0 = PlayerPrefs.GetString("CommanderLockFlagTalentConfig" .. getProxy(PlayerProxy):getRawData().id, "")
		local var_116_1 = {}

		if var_116_0 == "" then
			for iter_116_0, iter_116_1 in ipairs(CommanderCatUtil.GetAllTalentNames()) do
				var_116_1[iter_116_1.id] = true
			end
		else
			for iter_116_2, iter_116_3 in ipairs(string.split(var_116_0, "#")) do
				local var_116_2 = string.split(iter_116_3, "*")

				if #var_116_2 == 2 then
					var_116_1[tonumber(var_116_2[1])] = tonumber(var_116_2[2]) == 1
				end
			end
		end

		arg_116_0.lockFlagTalentConfig = var_116_1
	end

	return arg_116_0.lockFlagTalentConfig
end

function var_0_0.SaveCommanderLockFlagTalentConfig(arg_117_0, arg_117_1)
	arg_117_0.lockFlagTalentConfig = arg_117_1

	local var_117_0 = {}

	for iter_117_0, iter_117_1 in pairs(arg_117_1) do
		table.insert(var_117_0, iter_117_0 .. "*" .. (iter_117_1 and "1" or "0"))
	end

	PlayerPrefs.SetString("CommanderLockFlagTalentConfig" .. getProxy(PlayerProxy):getRawData().id, (table.concat(var_117_0, "#")))
	PlayerPrefs.Save()

	return
end

function var_0_0.GetMainPaintingVariantFlag(arg_118_0, arg_118_1)
	arg_118_0.mainPaintingVariantFlag = arg_118_0.mainPaintingVariantFlag or {}
	arg_118_0.mainPaintingVariantFlag[arg_118_1] = arg_118_0.mainPaintingVariantFlag[arg_118_1] or PlayerPrefs.GetInt(arg_118_1 .. "_mainMeshImagePainting_ex_" .. getProxy(PlayerProxy):getRawData().id, 0)

	return arg_118_0.mainPaintingVariantFlag[arg_118_1]
end

function var_0_0.SwitchMainPaintingVariantFlag(arg_119_0, arg_119_1)
	local var_119_0 = 1 - arg_119_0:GetMainPaintingVariantFlag(arg_119_1)

	arg_119_0.mainPaintingVariantFlag[arg_119_1] = var_119_0

	PlayerPrefs.SetInt(arg_119_1 .. "_mainMeshImagePainting_ex_" .. getProxy(PlayerProxy):getRawData().id, var_119_0)
	PlayerPrefs.Save()

	return
end

function var_0_0.IsTipDay(arg_120_0, arg_120_1, arg_120_2, arg_120_3)
	local var_120_0 = getProxy(PlayerProxy)

	return PlayerPrefs.GetInt(var_120_0:getRawData().id .. "educate_char_" .. arg_120_1 .. arg_120_2 .. arg_120_3, 0) == 1
end

function var_0_0.RecordTipDay(arg_121_0, arg_121_1, arg_121_2, arg_121_3)
	PlayerPrefs.SetInt(getProxy(PlayerProxy):getRawData().id .. "educate_char_" .. arg_121_1 .. arg_121_2 .. arg_121_3, 1)
	PlayerPrefs.Save()

	return
end

function var_0_0.UpdateEducateCharTip(arg_122_0, arg_122_1)
	local var_122_0 = getProxy(PlayerProxy):getRawData().id

	for iter_122_0, iter_122_1 in ipairs(arg_122_1 or {}) do
		({})[iter_122_1] = true
	end

	for iter_122_2, iter_122_3 in ipairs(NewEducateHelper.GetAllUnlockSecretaryIds() or {}) do
		if ({})[iter_122_3] ~= true then
			PlayerPrefs.SetInt(var_122_0 .. "educate_char_tip" .. iter_122_3, 1)
			PlayerPrefs.Save()
		end
	end

	arg_122_0:RefillEducateCharTipList()

	return
end

function var_0_0.RefillEducateCharTipList(arg_123_0)
	local var_123_0 = getProxy(PlayerProxy):getRawData().id

	arg_123_0.educateCharTipList = {}

	if LOCK_EDUCATE_SYSTEM then
		return
	end

	for iter_123_0, iter_123_1 in ipairs(NewEducateHelper.GetAllUnlockSecretaryIds() or {}) do
		if PlayerPrefs.GetInt(var_123_0 .. "educate_char_tip" .. iter_123_1, 0) == 1 then
			table.insert(arg_123_0.educateCharTipList, iter_123_1)
		end
	end

	return
end

function var_0_0.ShouldEducateCharTip(arg_124_0)
	if NewEducateHelper.GetEducateCharSlotMaxCnt() == 0 then
		return false
	end

	if not arg_124_0.educateCharTipList or #arg_124_0.educateCharTipList == 0 then
		arg_124_0:RefillEducateCharTipList()
	end

	return _.any(arg_124_0.educateCharTipList, function(arg_125_0)
		return NewEducateHelper.IsUnlockDefaultShip(arg_125_0)
	end)
end

function var_0_0._ShouldEducateCharTip(arg_126_0, arg_126_1)
	if not arg_126_0.educateCharTipList or #arg_126_0.educateCharTipList == 0 then
		arg_126_0:RefillEducateCharTipList()
	end

	if table.contains(arg_126_0.educateCharTipList, arg_126_1) and NewEducateHelper.IsUnlockDefaultShip(arg_126_1) then
		return true
	end

	return false
end

function var_0_0.ClearEducateCharTip(arg_127_0, arg_127_1)
	if not arg_127_0:_ShouldEducateCharTip(arg_127_1) then
		return false
	end

	table.removebyvalue(arg_127_0.educateCharTipList, arg_127_1)

	local var_127_0 = getProxy(PlayerProxy):getRawData().id

	if PlayerPrefs.HasKey(var_127_0 .. "educate_char_tip" .. arg_127_1) then
		PlayerPrefs.DeleteKey(var_127_0 .. "educate_char_tip" .. arg_127_1)
		PlayerPrefs.Save()
	end

	pg.m02:sendNotification(GAME.CLEAR_EDUCATE_TIP, {
		id = arg_127_1
	})

	return true
end

function var_0_0.GetMainSceneThemeStyle(arg_128_0)
	if PlayerPrefs.GetInt(USAGE_NEW_MAINUI, 1) == 1 then
		return NewMainScene.THEME_MELLOW
	else
		return NewMainScene.THEME_CLASSIC
	end

	return
end

function var_0_0.IsMellowStyle(arg_129_0)
	return NewMainScene.THEME_MELLOW == arg_129_0:GetMainSceneThemeStyle()
end

function var_0_0.GetMainSceneScreenSleepTime(arg_130_0)
	if pg.NewGuideMgr.GetInstance():IsBusy() then
		return SleepTimeout.SystemSetting
	end

	if PlayerPrefs.GetInt(_G[pg.settings_other_template[20].name], pg.settings_other_template[20].default) == 1 then
		return SleepTimeout.NeverSleep
	else
		return SleepTimeout.SystemSetting
	end

	return
end

function var_0_0.ShowL2dResetInMainScene(arg_131_0)
	return PlayerPrefs.GetInt(_G[pg.settings_other_template[21].name], pg.settings_other_template[21].default) == 1
end

function var_0_0.GetRecommendLowEnerySkipEnable(arg_132_0)
	return PlayerPrefs.GetInt(_G[pg.settings_other_template[25].name], pg.settings_other_template[25].default) == 1
end

local var_0_1 = "ISLAND_REST_EVENT"

function var_0_0.ShouldTipIslandRestEvet(arg_133_0)
	local var_133_9000
	local var_133_0 = getProxy(PlayerProxy)
	local var_133_1 = PlayerPrefs.GetInt(var_0_1 .. var_133_0.getRawData(var_133_9000).id, 0)

	return var_133_1 < pg.TimeMgr.GetInstance().GetServerTime(var_133_0)
end

function var_0_0.RecordIslandRestEvet(arg_134_0)
	PlayerPrefs.SetInt(var_0_1 .. getProxy(PlayerProxy):getRawData().id, (GetZeroTime()))
	PlayerPrefs.Save()

	return
end

function var_0_0.Reset(arg_135_0)
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

function var_0_0.IsExchangeCodeActive()
	return getGameset("exchangecode_ios_on")[1] == 1
end

return var_0_0

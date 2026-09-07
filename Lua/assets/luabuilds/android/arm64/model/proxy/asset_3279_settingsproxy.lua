local SettingsProxy = class("SettingsProxy", pm.Proxy)

function SettingsProxy:onRegister()
	self._isBgmEnble = PlayerPrefs.GetInt("ShipSkinBGM", 1) > 0
	self._ShowBg = PlayerPrefs.GetInt("disableBG", 1) > 0
	self._ShowLive2d = PlayerPrefs.GetInt("disableLive2d", 1) > 0
	self._selectedShipId = PlayerPrefs.GetInt("playerShipId")
	self._backyardFoodRemind = PlayerPrefs.GetString("backyardRemind")
	self._userAgreement = PlayerPrefs.GetInt("userAgreement", 0)
	self._showMaxLevelHelp = PlayerPrefs.GetInt("maxLevelHelp", 0) > 0
	self._nextTipAutoBattleTime = PlayerPrefs.GetInt("AutoBattleTip", 0)
	self._setFlagShip = PlayerPrefs.GetInt("setFlagShip", 0) > 0
	self._setFlagShipForSkinAtlas = PlayerPrefs.GetInt("setFlagShipforskinatlas", 0) > 0
	self._setFlagRandom = PlayerPrefs.GetInt("setFlagRandom", 0) > 0
	self._screenRatio = PlayerPrefs.GetFloat("SetScreenRatio", ADAPT_TARGET)
	self.storyAutoPlayCode = PlayerPrefs.GetInt("story_autoplay_flag", 0)
	NotchAdapt.CheckNotchRatio = self._screenRatio
	self._nextTipActBossTime = PlayerPrefs.GetInt("ActBossTipLastTime", 0)

	if GetZeroTime() <= self._nextTipActBossTime then
		self.nextTipActBossExchangeTicket = PlayerPrefs.GetInt("ActBossTip", 0)
	end

	self:resetEquipSceneIndex()

	self._isShowCollectionHelp = PlayerPrefs.GetInt("collection_Help", 0) > 0
	self.showMainSceneWordTip = PlayerPrefs.GetInt("main_scene_word_toggle", 1) > 0
	self.lastRequestVersionTime = nil
	self.worldBossFlag = {}
	self.worldFlag = {}

	return
end

function SettingsProxy:SetWorldBossFlag(arg_2_1, arg_2_2)
	if self.worldBossFlag[arg_2_1] ~= arg_2_2 then
		self.worldBossFlag[arg_2_1] = arg_2_2

		PlayerPrefs.SetInt("worldBossFlag" .. arg_2_1, arg_2_2 and 1 or 0)
		PlayerPrefs.Save()
	end

	return
end

function SettingsProxy:GetWorldBossFlag(arg_3_1)
	self.worldBossFlag[arg_3_1] = self.worldBossFlag[arg_3_1] or PlayerPrefs.GetInt("worldBossFlag" .. arg_3_1, 1) > 0

	return self.worldBossFlag[arg_3_1]
end

function SettingsProxy:SetWorldFlag(arg_4_1, arg_4_2)
	if self.worldFlag[arg_4_1] ~= arg_4_2 then
		self.worldFlag[arg_4_1] = arg_4_2

		PlayerPrefs.SetInt("world_flag_" .. arg_4_1, arg_4_2 and 1 or 0)
		PlayerPrefs.Save()
	end

	return
end

function SettingsProxy:GetWorldFlag(arg_5_1)
	self.worldFlag[arg_5_1] = self.worldFlag[arg_5_1] or PlayerPrefs.GetInt("world_flag_" .. arg_5_1, 0) > 0

	return self.worldFlag[arg_5_1]
end

function SettingsProxy:GetDockYardLockBtnFlag()
	self.dockYardLockFlag = self.dockYardLockFlag or PlayerPrefs.GetInt("DockYardLockFlag" .. getProxy(PlayerProxy):getRawData().id, 0) > 0

	return self.dockYardLockFlag
end

function SettingsProxy:SetDockYardLockBtnFlag(arg_7_1)
	if self.dockYardLockFlag ~= arg_7_1 then
		PlayerPrefs.SetInt("DockYardLockFlag" .. getProxy(PlayerProxy):getRawData().id, arg_7_1 and 1 or 0)
		PlayerPrefs.Save()

		self.dockYardLockFlag = arg_7_1
	end

	return
end

function SettingsProxy:GetDockYardLevelBtnFlag()
	self.dockYardLevelFlag = self.dockYardLevelFlag or PlayerPrefs.GetInt("DockYardLevelFlag" .. getProxy(PlayerProxy):getRawData().id, 0) > 0

	return self.dockYardLevelFlag
end

function SettingsProxy:SetDockYardLevelBtnFlag(arg_9_1)
	if self.dockYardLevelFlag ~= arg_9_1 then
		PlayerPrefs.SetInt("DockYardLevelFlag" .. getProxy(PlayerProxy):getRawData().id, arg_9_1 and 1 or 0)
		PlayerPrefs.Save()

		self.dockYardLevelFlag = arg_9_1
	end

	return
end

function SettingsProxy:IsShowCollectionHelp()
	return self._isShowCollectionHelp
end

function SettingsProxy:SetCollectionHelpFlag(arg_11_1)
	if self._isShowCollectionHelp ~= arg_11_1 then
		self._isShowCollectionHelp = arg_11_1

		PlayerPrefs.SetInt("collection_Help", arg_11_1 and 1 or 0)
		PlayerPrefs.Save()
	end

	return
end

function SettingsProxy:IsBGMEnable()
	return self._isBgmEnble
end

function SettingsProxy:SetBgmFlag(arg_13_1)
	if self._isBgmEnble ~= arg_13_1 then
		self._isBgmEnble = arg_13_1

		PlayerPrefs.SetInt("ShipSkinBGM", arg_13_1 and 1 or 0)
		PlayerPrefs.Save()
	end

	return
end

function SettingsProxy:IsEnableMainMusicPlayer()
	return true
end

function SettingsProxy:getSkinPosSetting(arg_15_1)
	local var_15_0 = arg_15_1:GetRecordPosKey()
	local var_15_1 = self:GetCurrMainUIStyleKeyForSkinShop()

	if PlayerPrefs.HasKey(var_15_1 .. tostring(var_15_0) .. "_scale") then
		return PlayerPrefs.GetFloat(var_15_1 .. tostring(var_15_0) .. "_x", 0), PlayerPrefs.GetFloat(var_15_1 .. tostring(var_15_0) .. "_y", 0), (PlayerPrefs.GetFloat(var_15_1 .. tostring(var_15_0) .. "_scale", 1))
	else
		return nil
	end

	return
end

function SettingsProxy:setSkinPosSetting(arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	local var_16_0 = arg_16_1:GetRecordPosKey()
	local var_16_1 = self:GetCurrMainUIStyleKeyForSkinShop()

	PlayerPrefs.SetFloat(var_16_1 .. tostring(var_16_0) .. "_x", arg_16_2)
	PlayerPrefs.SetFloat(var_16_1 .. tostring(var_16_0) .. "_y", arg_16_3)
	PlayerPrefs.SetFloat(var_16_1 .. tostring(var_16_0) .. "_scale", arg_16_4)
	PlayerPrefs.Save()

	return
end

function SettingsProxy:setSkinScaleSetting(arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	local var_17_0 = arg_17_1:GetRecordPosKey()
	local var_17_1 = tostring(var_17_0) .. arg_17_2 .. "_" .. arg_17_3 .. "_part_scale"

	PlayerPrefs.SetFloat(tostring(var_17_0) .. arg_17_2 .. "_" .. arg_17_3 .. "_part_scale", arg_17_4)

	return
end

function SettingsProxy:getSkinScaleSetting(arg_18_1, arg_18_2, arg_18_3)
	local var_18_0
	local var_18_1 = tostring((arg_18_1:GetRecordPosKey())) .. arg_18_2 .. "_" .. arg_18_3 .. "_part_scale"

	if PlayerPrefs.HasKey(var_18_1) then
		var_18_0 = PlayerPrefs.GetFloat(var_18_1, 1)
	else
		return 1
	end

	return var_18_0
end

function SettingsProxy:GetCurrMainUIStyleKeyForSkinShop()
	local var_19_0 = self:GetMainSceneThemeStyle()

	if var_19_0 == NewMainScene.THEME_CLASSIC then
		return ""
	else
		return var_19_0
	end

	return
end

function SettingsProxy:resetSkinPosSetting(arg_20_1)
	local var_20_0 = arg_20_1:GetRecordPosKey()

	PlayerPrefs.DeleteKey(tostring(var_20_0) .. "_x")
	PlayerPrefs.DeleteKey(tostring(var_20_0) .. "_y")
	PlayerPrefs.DeleteKey(tostring(var_20_0) .. "_scale")
	PlayerPrefs.Save()

	return
end

function SettingsProxy:getCharacterSetting(arg_21_1, arg_21_2)
	return PlayerPrefs.GetInt(tostring(arg_21_1) .. "_" .. arg_21_2, 1) > 0
end

function SettingsProxy:setCharacterSetting(arg_22_1, arg_22_2, arg_22_3)
	PlayerPrefs.SetInt(tostring(arg_22_1) .. "_" .. arg_22_2, arg_22_3 and 1 or 0)
	PlayerPrefs.Save()

	return
end

function SettingsProxy:getCurrentSecretaryIndex()
	local var_23_0 = PlayerPrefs.GetInt("currentSecretaryIndex", 1)

	if var_23_0 > PlayerVitaeShipsPage.GetAllUnlockSlotCnt() then
		self:setCurrentSecretaryIndex(1)

		return 1
	else
		return PlayerVitaeShipsPage.GetSlotIndexList()[var_23_0]
	end

	return
end

function SettingsProxy:rotateCurrentSecretaryIndex()
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

	self:setCurrentSecretaryIndex(var_24_0)
	pg.m02:sendNotification(GAME.ROTATE_PAINTING_INDEX)

	return
end

function SettingsProxy:setCurrentSecretaryIndex(arg_26_1)
	PlayerPrefs.SetInt("currentSecretaryIndex", arg_26_1)
	PlayerPrefs.Save()

	return
end

function SettingsProxy:SetFlagShip(arg_27_1)
	if self._setFlagShip ~= arg_27_1 then
		self._setFlagShip = arg_27_1

		PlayerPrefs.SetInt("setFlagShip", arg_27_1 and 1 or 0)
		PlayerPrefs.Save()
	end

	return
end

function SettingsProxy:GetSetFlagShip()
	return self._setFlagShip
end

function SettingsProxy:SetFlagShipForSkinAtlas(arg_29_1)
	if self._setFlagShipForSkinAtlas ~= arg_29_1 then
		self._setFlagShipForSkinAtlas = arg_29_1

		PlayerPrefs.SetInt("setFlagShipforskinatlas", arg_29_1 and 1 or 0)
		PlayerPrefs.Save()
	end

	return
end

function SettingsProxy:GetSetFlagShipForSkinAtlas()
	return self._setFlagShipForSkinAtlas
end

function SettingsProxy:SetFlagRandom(arg_31_1)
	if self._setFlagRandom ~= arg_31_1 then
		self._setFlagRandom = arg_31_1

		PlayerPrefs.SetInt("setFlagRandom", arg_31_1 and 1 or 0)
		PlayerPrefs.Save()
	end

	return
end

function SettingsProxy:GetFlagRandom()
	return self._setFlagRandom
end

function SettingsProxy:CheckNeedUserAgreement()
	if PLATFORM_CODE == PLATFORM_KR then
		return false
	elseif PLATFORM_CODE == PLATFORM_CH then
		return false
	elseif PLATFORM_CODE == PLATFORM_JP then
		return false
	else
		return self:GetUserAgreementFlag() > self._userAgreement
	end

	return
end

function SettingsProxy:GetUserAgreementFlag()
	return (PLATFORM_CODE == PLATFORM_CHT or nil) and USER_AGREEMENT_FLAG_TW
end

function SettingsProxy:SetUserAgreement()
	if self:CheckNeedUserAgreement() then
		local var_35_0 = self:GetUserAgreementFlag()

		PlayerPrefs.SetInt("userAgreement", var_35_0)
		PlayerPrefs.Save()

		self._userAgreement = var_35_0
	end

	return
end

function SettingsProxy:IsLive2dEnable()
	return self._ShowLive2d
end

function SettingsProxy:IsBGEnable()
	return self._ShowBg
end

function SettingsProxy:SetSelectedShipId(arg_38_1)
	if self._selectedShipId ~= arg_38_1 then
		self._selectedShipId = arg_38_1

		PlayerPrefs.SetInt("playerShipId", arg_38_1)
		PlayerPrefs.Save()
	end

	return
end

function SettingsProxy:GetSelectedShipId()
	return self._selectedShipId
end

function SettingsProxy:setEquipSceneIndex(arg_40_1)
	self._equipSceneIndex = arg_40_1

	return
end

function SettingsProxy:getEquipSceneIndex()
	return self._equipSceneIndex
end

function SettingsProxy:resetEquipSceneIndex()
	self._equipSceneIndex = StoreHouseConst.WARP_TO_MATERIAL

	return
end

function SettingsProxy:setActivityLayerIndex(arg_43_1)
	self._activityLayerIndex = arg_43_1

	return
end

function SettingsProxy:getActivityLayerIndex()
	return self._activityLayerIndex
end

function SettingsProxy:resetActivityLayerIndex()
	self._activityLayerIndex = 1

	return
end

function SettingsProxy:setBackyardRemind()
	local var_46_0 = GetZeroTime()

	if self._backyardFoodRemind ~= tostring(var_46_0) then
		PlayerPrefs.SetString("backyardRemind", var_46_0)
		PlayerPrefs.Save()

		self._backyardFoodRemind = var_46_0
	end

	return
end

function SettingsProxy:getBackyardRemind()
	if not self._backyardFoodRemind or self._backyardFoodRemind == "" then
		return 0
	else
		return tonumber(self._backyardFoodRemind)
	end

	return
end

function SettingsProxy:getMaxLevelHelp()
	return self._showMaxLevelHelp
end

function SettingsProxy:setMaxLevelHelp(arg_49_1)
	if self._showMaxLevelHelp ~= arg_49_1 then
		self._showMaxLevelHelp = arg_49_1

		PlayerPrefs.SetInt("maxLevelHelp", arg_49_1 and 1 or 0)
		PlayerPrefs.Save()
	end

	return
end

function SettingsProxy:setStopBuildSpeedupRemind()
	self.isStopBuildSpeedupReamind = true

	return
end

function SettingsProxy:getStopBuildSpeedupRemind()
	return self.isStopBuildSpeedupReamind
end

function SettingsProxy:checkReadHelp(arg_52_1)
	if not getProxy(PlayerProxy):getData() then
		return true
	end

	if arg_52_1 == "help_backyard" then
		return true
	elseif pg.SeriesGuideMgr.GetInstance():isEnd() then
		local var_52_0 = PlayerPrefs.GetInt(arg_52_1, 0)

		return PlayerPrefs.GetInt(arg_52_1, 0) > 0
	end

	return true
end

function SettingsProxy:recordReadHelp(arg_53_1)
	PlayerPrefs.SetInt(arg_53_1, 1)
	PlayerPrefs.Save()

	return
end

function SettingsProxy:clearAllReadHelp()
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

function SettingsProxy:setAutoBattleTip()
	local var_55_0 = GetZeroTime()

	self._nextTipAutoBattleTime = var_55_0

	PlayerPrefs.SetInt("AutoBattleTip", var_55_0)
	PlayerPrefs.Save()

	return
end

function SettingsProxy:isTipAutoBattle()
	return pg.TimeMgr.GetInstance():GetServerTime() > self._nextTipAutoBattleTime
end

function SettingsProxy:setActBossExchangeTicketTip(arg_57_1)
	if self.nextTipActBossExchangeTicket == arg_57_1 then
		return
	end

	self.nextTipActBossExchangeTicket = arg_57_1

	local var_57_0 = GetZeroTime()

	if var_57_0 > self._nextTipActBossTime then
		self._nextTipActBossTime = var_57_0

		PlayerPrefs.SetInt("ActBossTipLastTime", var_57_0)
	end

	PlayerPrefs.SetInt("ActBossTip", arg_57_1)
	PlayerPrefs.Save()

	return
end

function SettingsProxy:isTipActBossExchangeTicket()
	if pg.TimeMgr.GetInstance():GetServerTime() > self._nextTipActBossTime then
		return nil
	end

	return self.nextTipActBossExchangeTicket
end

function SettingsProxy:SetScreenRatio(arg_59_1)
	if self._screenRatio ~= arg_59_1 then
		self._screenRatio = arg_59_1

		PlayerPrefs.SetFloat("SetScreenRatio", arg_59_1)
		PlayerPrefs.Save()
	end

	return
end

function SettingsProxy:GetScreenRatio()
	return self._screenRatio
end

function SettingsProxy:CheckLargeScreen()
	return Screen.width / Screen.height > 2
end

function SettingsProxy:IsShowBeatMonseterNianCurtain()
	return pg.TimeMgr.GetInstance():GetServerTime() > tonumber(PlayerPrefs.GetString("HitMonsterNianLayer2020" .. getProxy(PlayerProxy):getRawData().id, "0"))
end

function SettingsProxy:SetBeatMonseterNianFlag()
	PlayerPrefs.SetString("HitMonsterNianLayer2020" .. getProxy(PlayerProxy):getRawData().id, GetZeroTime())
	PlayerPrefs.Save()

	return
end

function SettingsProxy:ShouldShowEventActHelp()
	self.actEventFlag = self.actEventFlag or PlayerPrefs.GetInt("event_act_help1" .. getProxy(PlayerProxy):getRawData().id, 0) > 0

	return not self.actEventFlag
end

function SettingsProxy:MarkEventActHelpFlag()
	if not self.actEventFlag then
		self.actEventFlag = true

		PlayerPrefs.SetInt("event_act_help1" .. getProxy(PlayerProxy):getRawData().id, 1)
		PlayerPrefs.Save()
	end

	return
end

function SettingsProxy:SetStorySpeed(arg_66_1)
	self.storySpeed = arg_66_1

	PlayerPrefs.SetInt("story_speed_flag" .. (getProxy(PlayerProxy) and getProxy(PlayerProxy):getRawData().id or 1), arg_66_1)
	PlayerPrefs.Save()

	return
end

function SettingsProxy:GetStorySpeed()
	self.storySpeed = self.storySpeed or PlayerPrefs.GetInt("story_speed_flag" .. (getProxy(PlayerProxy) and getProxy(PlayerProxy):getRawData().id or 1), 0)

	return self.storySpeed
end

function SettingsProxy:GetStoryAutoPlayFlag()
	return self.storyAutoPlayCode > 0
end

function SettingsProxy:SetStoryAutoPlayFlag(arg_69_1)
	if self.storyAutoPlayCode ~= arg_69_1 then
		PlayerPrefs.SetInt("story_autoplay_flag", arg_69_1)
		PlayerPrefs.Save()

		self.storyAutoPlayCode = arg_69_1
	end

	return
end

function SettingsProxy:GetPaintingDownloadPrefs()
	return PlayerPrefs.GetInt("Painting_Download_Prefs", 0)
end

function SettingsProxy:SetPaintingDownloadPrefs(arg_71_1)
	PlayerPrefs.SetInt("Painting_Download_Prefs", arg_71_1)

	return
end

function SettingsProxy:ShouldShipMainSceneWord()
	return self.showMainSceneWordTip
end

function SettingsProxy:SaveMainSceneWordFlag(arg_73_1)
	if self.showMainSceneWordTip ~= arg_73_1 then
		self.showMainSceneWordTip = arg_73_1

		PlayerPrefs.SetInt("main_scene_word_toggle", arg_73_1 and 1 or 0)
		PlayerPrefs.Save()
	end

	return
end

function SettingsProxy:RecordFrameRate()
	self.originalFrameRate = self.originalFrameRate or Application.targetFrameRate

	return
end

function SettingsProxy:RestoreFrameRate()
	if self.originalFrameRate then
		Application.targetFrameRate = self.originalFrameRate
		self.originalFrameRate = nil
	end

	return
end

function SettingsProxy:ResetTimeLimitSkinShopTip()
	self.isTipLimitSkinShop = PlayerPrefs.GetInt("tipLimitSkinShopTime_", 0) <= pg.TimeMgr.GetInstance():GetServerTime()

	if self.isTipLimitSkinShop then
		self.nextTipLimitSkinShopTime = GetZeroTime()
	end

	return
end

function SettingsProxy:ShouldTipTimeLimitSkinShop()
	return self.isTipLimitSkinShop
end

function SettingsProxy:SetNextTipTimeLimitSkinShop()
	if self.isTipLimitSkinShop and self.nextTipLimitSkinShopTime then
		PlayerPrefs.SetInt("tipLimitSkinShopTime_", self.nextTipLimitSkinShopTime)
		PlayerPrefs.Save()

		self.nextTipLimitSkinShopTime = nil
		self.isTipLimitSkinShop = false
	end

	return
end

function SettingsProxy:WorldBossProgressTipFlag(arg_79_1)
	if self.WorldBossProgressTipValue ~= arg_79_1 then
		self.WorldBossProgressTipValue = arg_79_1

		PlayerPrefs.SetString("_WorldBossProgressTipFlag_", arg_79_1)
		PlayerPrefs.Save()
	end

	return
end

function SettingsProxy:GetWorldBossProgressTipFlag()
	if not self.WorldBossProgressTipValue then
		local var_80_0 = PlayerPrefs.GetString("_WorldBossProgressTipFlag_", pg.gameset.joint_boss_ticket.description[1] .. "&" .. pg.gameset.joint_boss_ticket.description[1] + pg.gameset.joint_boss_ticket.description[2])

		self.WorldBossProgressTipValue = var_80_0

		return var_80_0
	else
		return self.WorldBossProgressTipValue
	end

	return
end

function SettingsProxy:GetWorldBossProgressTipTable()
	local var_81_0 = self:GetWorldBossProgressTipFlag()

	if not var_81_0 or var_81_0 == "" then
		return {}
	end

	return string.split(var_81_0, "&")
end

function SettingsProxy:GetChatFlag()
	if not self.chatFlag then
		local var_82_0 = {
			ChatConst.ChannelWorld,
			ChatConst.ChannelPublic,
			ChatConst.ChannelFriend
		}

		if getProxy(GuildProxy):getRawData() then
			table.insert(var_82_0, ChatConst.ChannelGuild)
		end

		self.chatFlag = PlayerPrefs.GetInt("chat__setting", IndexConst.Flags2Bits(var_82_0))
	end

	return self.chatFlag
end

function SettingsProxy:SetChatFlag(arg_83_1)
	if self.chatFlag ~= arg_83_1 then
		self.chatFlag = arg_83_1

		PlayerPrefs.SetInt("chat__setting", arg_83_1)
		PlayerPrefs.Save()
	end

	return
end

function SettingsProxy.IsShowActivityMapSPTip()
	return pg.TimeMgr.GetInstance():GetServerTime() > PlayerPrefs.GetInt("ActivityMapSPTip" .. getProxy(PlayerProxy):getRawData().id, 0)
end

function SettingsProxy.SetActivityMapSPTip()
	PlayerPrefs.SetInt("ActivityMapSPTip" .. getProxy(PlayerProxy):getRawData().id, GetZeroTime())
	PlayerPrefs.Save()

	return
end

function SettingsProxy:IsTipNewTheme()
	local var_86_0 = pg.backyard_theme_template.all[#pg.backyard_theme_template.all]
	local var_86_1 = pg.furniture_shop_template[pg.backyard_theme_template[var_86_0].ids[1]]
	local var_86_2

	if pg.furniture_shop_template[pg.backyard_theme_template[var_86_0].ids[1]] then
		::label_86_0::

		if var_86_1.new == 1 then
			var_86_2 = pg.TimeMgr.GetInstance():inTime(var_86_1.time)

			if var_86_2 then
				var_86_2 = PlayerPrefs.GetInt(getProxy(PlayerProxy):getRawData().id .. "IsTipNewTheme" .. var_86_0, 0) == 0
			end
		else
			var_86_2 = false
		end
	else
		var_86_2 = true
	end

	self.lastThemeId = var_86_2 and var_86_0 or nil

	return self.lastThemeId ~= nil
end

function SettingsProxy:UpdateNewThemeValue()
	if self.lastThemeId then
		PlayerPrefs.SetInt(getProxy(PlayerProxy):getRawData().id .. "IsTipNewTheme" .. self.lastThemeId, 1)
		PlayerPrefs.Save()
	end

	return
end

function SettingsProxy:GetNewGemFurnitureLocalCache()
	if not self.cacheGemFuruitures then
		self.cacheGemFuruitures = {}

		local var_88_0 = PlayerPrefs.GetString(getProxy(PlayerProxy):getRawData().id .. "IsTipNewGenFurniture")

		if var_88_0 ~= "" then
			for iter_88_0, iter_88_1 in ipairs((string.split(var_88_0, "#"))) do
				self.cacheGemFuruitures[tonumber(iter_88_1)] = true
			end
		end
	end

	return self.cacheGemFuruitures
end

function SettingsProxy:IsTipNewGemFurniture()
	local var_89_0 = self:GetNewGemFurnitureLocalCache()
	local var_89_1 = getProxy(DormProxy):GetTag7Furnitures()

	self.newGemFurniture = _.any(var_89_1, function(arg_90_0)
		return pg.furniture_shop_template[arg_90_0].new == 1 and not var_89_0[arg_90_0]
	end) and var_89_1 or nil

	return self.newGemFurniture ~= nil
end

function SettingsProxy:UpdateNewGemFurnitureValue()
	if self.newGemFurniture then
		for iter_91_0, iter_91_1 in pairs(self.newGemFurniture) do
			self.cacheGemFuruitures[iter_91_1] = true
		end

		PlayerPrefs.SetString(getProxy(PlayerProxy):getRawData().id .. "IsTipNewGenFurniture", (table.concat(self.newGemFurniture, "#")))
		PlayerPrefs.Save()
	end

	return
end

function SettingsProxy:GetRandomFlagShipList()
	if self.randomFlagShipList then
		return self.randomFlagShipList
	end

	local var_92_0 = PlayerPrefs.GetString("RandomFlagShipList" .. getProxy(PlayerProxy):getRawData().id, "")

	self.randomFlagShipList = var_92_0 == "" and {} or string.split(var_92_0, "#")

	return self.randomFlagShipList
end

function SettingsProxy:IsRandomFlagShip(arg_93_1)
	if not self.randomFlagShipMap then
		self.randomFlagShipMap = {}

		for iter_93_0, iter_93_1 in ipairs(self:GetRandomFlagShipList()) do
			self.randomFlagShipMap[iter_93_1] = true
		end
	end

	return self.randomFlagShipMap[arg_93_1] == true
end

function SettingsProxy:IsOpenRandomFlagShip()
	local var_94_0 = self:GetRandomFlagShipList()
	local var_94_1 = getProxy(BayProxy)

	return #var_94_0 > 0 and _.any(var_94_0, function(arg_95_0)
		local var_95_0, var_95_1 = ShipPhantom.UnpackMark(arg_95_0)

		return var_94_1:RawGetShipById(var_95_0) ~= nil
	end)
end

function SettingsProxy:UpdateRandomFlagShipList(arg_96_1)
	self.randomFlagShipMap = nil
	self.randomFlagShipList = arg_96_1

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

function SettingsProxy:GetPrevRandomFlagShipTime()
	if self.prevRandomFlagShipTime then
		return self.prevRandomFlagShipTime
	end

	self.prevRandomFlagShipTime = PlayerPrefs.GetInt("RandomFlagShipTime" .. getProxy(PlayerProxy):getRawData().id, 0)

	return self.prevRandomFlagShipTime
end

function SettingsProxy:SetPrevRandomFlagShipTime(arg_98_1)
	if self.prevRandomFlagShipTime == arg_98_1 then
		return
	end

	self.prevRandomFlagShipTime = arg_98_1

	PlayerPrefs.SetInt("RandomFlagShipTime" .. getProxy(PlayerProxy):getRawData().id, arg_98_1)
	PlayerPrefs.Save()

	return
end

function SettingsProxy:GetFlagShipDisplayMode()
	self.flagShipDisplayMode = self.flagShipDisplayMode or PlayerPrefs.GetInt("flag-ship-display-mode" .. getProxy(PlayerProxy):getRawData().id, FlAG_SHIP_DISPLAY_ALL)

	return self.flagShipDisplayMode
end

function SettingsProxy:SetFlagShipDisplayMode(arg_100_1)
	if self.flagShipDisplayMode ~= arg_100_1 then
		self.flagShipDisplayMode = arg_100_1

		PlayerPrefs.SetInt("flag-ship-display-mode" .. getProxy(PlayerProxy):getRawData().id, arg_100_1)
		PlayerPrefs.Save()
	end

	return
end

function SettingsProxy:RecordContinuousOperationAutoSubStatus(arg_101_1)
	if arg_101_1 then
		return
	end

	PlayerPrefs.SetInt("AutoBotCOFlag" .. getProxy(PlayerProxy):getRawData().id, 1)
	PlayerPrefs.Save()

	return
end

function SettingsProxy:ResetContinuousOperationAutoSub()
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

function SettingsProxy:SetWorkbenchDailyTip()
	PlayerPrefs.SetInt("WorkbenchDailyTip" .. getProxy(PlayerProxy):getRawData().id, (GetZeroTime()))
	PlayerPrefs.Save()

	return
end

function SettingsProxy:IsTipWorkbenchDaily()
	return pg.TimeMgr.GetInstance():GetServerTime() > PlayerPrefs.GetInt("WorkbenchDailyTip" .. getProxy(PlayerProxy):getRawData().id, 0)
end

function SettingsProxy:IsDisplayResultPainting()
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

function SettingsProxy:IsDisplayCommanderCatCustomName()
	self.customFlag = self.customFlag or PlayerPrefs.GetInt("DisplayCommanderCatCustomName" .. getProxy(PlayerProxy):getRawData().id, 0) == 0

	return self.customFlag
end

function SettingsProxy:SetDisplayCommanderCatCustomName(arg_107_1)
	if arg_107_1 == self.customFlag then
		return
	end

	self.customFlag = arg_107_1

	PlayerPrefs.SetInt("DisplayCommanderCatCustomName" .. getProxy(PlayerProxy):getRawData().id, self.customFlag and 0 or 1)
	PlayerPrefs.Save()

	return
end

function SettingsProxy:GetCommanderQuicklyToolRarityConfig()
	self.quicklyToolRarityConfig = self.quicklyToolRarityConfig or _.map(string.split(PlayerPrefs.GetString("CommanderQuicklyToolRarityConfig" .. getProxy(PlayerProxy):getRawData().id, "1#1#1"), "#"), function(arg_109_0)
		return tonumber(arg_109_0) == 1
	end)

	return self.quicklyToolRarityConfig
end

function SettingsProxy:SaveCommanderQuicklyToolRarityConfig(arg_110_1)
	local var_110_0 = false

	for iter_110_0, iter_110_1 in ipairs(self.quicklyToolRarityConfig) do
		if arg_110_1[iter_110_0] ~= iter_110_1 then
			var_110_0 = true

			break
		end
	end

	if var_110_0 then
		self.quicklyToolRarityConfig = arg_110_1

		PlayerPrefs.SetString("CommanderQuicklyToolRarityConfig" .. getProxy(PlayerProxy):getRawData().id, (table.concat(_.map(self.quicklyToolRarityConfig, function(arg_111_0)
			return arg_111_0 and "1" or "0"
		end), "#")))
		PlayerPrefs.Save()
	end

	return
end

function SettingsProxy:GetCommanderLockFlagRarityConfig()
	self.lockFlagRarityConfig = self.lockFlagRarityConfig or _.map(string.split(PlayerPrefs.GetString("CommanderLockFlagRarityConfig_" .. getProxy(PlayerProxy):getRawData().id, "1#0#0"), "#"), function(arg_113_0)
		return tonumber(arg_113_0) == 1
	end)

	return self.lockFlagRarityConfig
end

function SettingsProxy:SaveCommanderLockFlagRarityConfig(arg_114_1)
	local var_114_0 = false

	for iter_114_0, iter_114_1 in ipairs(self.lockFlagRarityConfig) do
		if arg_114_1[iter_114_0] ~= iter_114_1 then
			var_114_0 = true

			break
		end
	end

	if var_114_0 then
		self.lockFlagRarityConfig = arg_114_1

		PlayerPrefs.SetString("CommanderLockFlagRarityConfig_" .. getProxy(PlayerProxy):getRawData().id, (table.concat(_.map(self.lockFlagRarityConfig, function(arg_115_0)
			return arg_115_0 and "1" or "0"
		end), "#")))
		PlayerPrefs.Save()
	end

	return
end

function SettingsProxy:GetCommanderLockFlagTalentConfig()
	if not self.lockFlagTalentConfig then
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

		self.lockFlagTalentConfig = var_116_1
	end

	return self.lockFlagTalentConfig
end

function SettingsProxy:SaveCommanderLockFlagTalentConfig(arg_117_1)
	self.lockFlagTalentConfig = arg_117_1

	local var_117_0 = {}

	for iter_117_0, iter_117_1 in pairs(arg_117_1) do
		table.insert(var_117_0, iter_117_0 .. "*" .. (iter_117_1 and "1" or "0"))
	end

	PlayerPrefs.SetString("CommanderLockFlagTalentConfig" .. getProxy(PlayerProxy):getRawData().id, (table.concat(var_117_0, "#")))
	PlayerPrefs.Save()

	return
end

function SettingsProxy:GetMainPaintingVariantFlag(arg_118_1)
	self.mainPaintingVariantFlag = self.mainPaintingVariantFlag or {}
	self.mainPaintingVariantFlag[arg_118_1] = self.mainPaintingVariantFlag[arg_118_1] or PlayerPrefs.GetInt(arg_118_1 .. "_mainMeshImagePainting_ex_" .. getProxy(PlayerProxy):getRawData().id, 0)

	return self.mainPaintingVariantFlag[arg_118_1]
end

function SettingsProxy:SwitchMainPaintingVariantFlag(arg_119_1)
	local var_119_0 = 1 - self:GetMainPaintingVariantFlag(arg_119_1)

	self.mainPaintingVariantFlag[arg_119_1] = var_119_0

	PlayerPrefs.SetInt(arg_119_1 .. "_mainMeshImagePainting_ex_" .. getProxy(PlayerProxy):getRawData().id, var_119_0)
	PlayerPrefs.Save()

	return
end

function SettingsProxy:IsTipDay(arg_120_1, arg_120_2, arg_120_3)
	return PlayerPrefs.GetInt(getProxy(PlayerProxy):getRawData().id .. "educate_char_" .. arg_120_1 .. arg_120_2 .. arg_120_3, 0) == 1
end

function SettingsProxy:RecordTipDay(arg_121_1, arg_121_2, arg_121_3)
	PlayerPrefs.SetInt(getProxy(PlayerProxy):getRawData().id .. "educate_char_" .. arg_121_1 .. arg_121_2 .. arg_121_3, 1)
	PlayerPrefs.Save()

	return
end

function SettingsProxy:UpdateEducateCharTip(arg_122_1)
	local var_122_0 = getProxy(PlayerProxy):getRawData().id
	local var_122_1 = {}

	for iter_122_0, iter_122_1 in ipairs(arg_122_1 or {}) do
		var_122_1[iter_122_1] = true
	end

	for iter_122_2, iter_122_3 in ipairs(NewEducateHelper.GetAllUnlockSecretaryIds() or {}) do
		if var_122_1[iter_122_3] ~= true then
			PlayerPrefs.SetInt(var_122_0 .. "educate_char_tip" .. iter_122_3, 1)
			PlayerPrefs.Save()
		end
	end

	self:RefillEducateCharTipList()

	return
end

function SettingsProxy:RefillEducateCharTipList()
	local var_123_0 = getProxy(PlayerProxy):getRawData().id

	self.educateCharTipList = {}

	if LOCK_EDUCATE_SYSTEM then
		return
	end

	for iter_123_0, iter_123_1 in ipairs(NewEducateHelper.GetAllUnlockSecretaryIds() or {}) do
		if PlayerPrefs.GetInt(var_123_0 .. "educate_char_tip" .. iter_123_1, 0) == 1 then
			table.insert(self.educateCharTipList, iter_123_1)
		end
	end

	return
end

function SettingsProxy:ShouldEducateCharTip()
	if NewEducateHelper.GetEducateCharSlotMaxCnt() == 0 then
		return false
	end

	if not self.educateCharTipList or #self.educateCharTipList == 0 then
		self:RefillEducateCharTipList()
	end

	return _.any(self.educateCharTipList, function(arg_125_0)
		return NewEducateHelper.IsUnlockDefaultShip(arg_125_0)
	end)
end

function SettingsProxy:_ShouldEducateCharTip(arg_126_1)
	if not self.educateCharTipList or #self.educateCharTipList == 0 then
		self:RefillEducateCharTipList()
	end

	if table.contains(self.educateCharTipList, arg_126_1) and NewEducateHelper.IsUnlockDefaultShip(arg_126_1) then
		return true
	end

	return false
end

function SettingsProxy:ClearEducateCharTip(arg_127_1)
	if not self:_ShouldEducateCharTip(arg_127_1) then
		return false
	end

	table.removebyvalue(self.educateCharTipList, arg_127_1)

	if PlayerPrefs.HasKey(getProxy(PlayerProxy):getRawData().id .. "educate_char_tip" .. arg_127_1) then
		PlayerPrefs.DeleteKey(getProxy(PlayerProxy):getRawData().id .. "educate_char_tip" .. arg_127_1)
		PlayerPrefs.Save()
	end

	pg.m02:sendNotification(GAME.CLEAR_EDUCATE_TIP, {
		id = arg_127_1
	})

	return true
end

function SettingsProxy:GetMainSceneThemeStyle()
	if PlayerPrefs.GetInt(USAGE_NEW_MAINUI, 1) == 1 then
		return NewMainScene.THEME_MELLOW
	else
		return NewMainScene.THEME_CLASSIC
	end

	return
end

function SettingsProxy:IsMellowStyle()
	return NewMainScene.THEME_MELLOW == self:GetMainSceneThemeStyle()
end

function SettingsProxy:GetMainSceneScreenSleepTime()
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

function SettingsProxy:ShowL2dResetInMainScene()
	return PlayerPrefs.GetInt(_G[pg.settings_other_template[21].name], pg.settings_other_template[21].default) == 1
end

function SettingsProxy:GetRecommendLowEnerySkipEnable()
	return PlayerPrefs.GetInt(_G[pg.settings_other_template[25].name], pg.settings_other_template[25].default) == 1
end

local var_0_1 = "ISLAND_REST_EVENT"

function SettingsProxy:ShouldTipIslandRestEvet()
	local var_133_0 = getProxy(PlayerProxy)

	return PlayerPrefs.GetInt(var_0_1 .. var_133_0:getRawData().id, 0) < pg.TimeMgr.GetInstance().GetServerTime(var_133_0)
end

function SettingsProxy:RecordIslandRestEvet()
	PlayerPrefs.SetInt(var_0_1 .. getProxy(PlayerProxy):getRawData().id, (GetZeroTime()))
	PlayerPrefs.Save()

	return
end

function SettingsProxy:Reset()
	self:resetEquipSceneIndex()
	self:resetActivityLayerIndex()

	self.isStopBuildSpeedupReamind = false

	self:RestoreFrameRate()

	self.randomFlagShipList = nil
	self.prevRandomFlagShipTime = nil
	self.randomFlagShipMap = nil
	self.educateCharTipList = {}

	return
end

function SettingsProxy.IsExchangeCodeActive()
	return getGameset("exchangecode_ios_on")[1] == 1
end

return SettingsProxy

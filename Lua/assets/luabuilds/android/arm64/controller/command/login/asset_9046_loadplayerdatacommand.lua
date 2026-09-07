local LoadPlayerDataCommand = class("LoadPlayerDataCommand", pm.SimpleCommand)

function LoadPlayerDataCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.isNewPlayer

	originalPrint("loading player data: " .. var_1_0.id)

	pg.proxyRegister = ProxyRegister.New()

	pg.proxyRegister:RgisterProxy(self.facade, {
		{
			PlayerProxy,
			true
		},
		{
			BayProxy,
			true,
			{}
		},
		{
			FleetProxy,
			true,
			{}
		},
		{
			EquipmentProxy,
			true,
			{}
		},
		{
			ChapterProxy,
			true,
			{}
		},
		{
			ChapterAutoProxy,
			true,
			{}
		},
		{
			WorldProxy,
			true,
			{}
		},
		{
			BagProxy,
			true,
			{}
		},
		{
			TaskProxy,
			true,
			{}
		},
		{
			MailProxy,
			true,
			{}
		},
		{
			CompensateProxy,
			true,
			{}
		},
		{
			NavalAcademyProxy,
			true,
			{}
		},
		{
			DormProxy,
			true,
			{}
		},
		{
			ChatProxy,
			true,
			{}
		},
		{
			FriendProxy,
			true,
			{}
		},
		{
			NotificationProxy,
			true,
			{}
		},
		{
			BuildShipProxy,
			true,
			{}
		},
		{
			CollectionProxy,
			true,
			{}
		},
		{
			EventProxy,
			true,
			{}
		},
		{
			ActivityProxy,
			true,
			{}
		},
		{
			ActivityPermanentProxy,
			true,
			{}
		},
		{
			MilitaryExerciseProxy,
			true
		},
		{
			ServerNoticeProxy,
			true
		},
		{
			DailyLevelProxy,
			true
		},
		{
			ShopsProxy,
			true
		},
		{
			GuildProxy,
			true
		},
		{
			VoteProxy,
			true
		},
		{
			ChallengeProxy,
			true
		},
		{
			CommanderProxy,
			true
		},
		{
			ColoringProxy,
			true
		},
		{
			AnswerProxy,
			true
		},
		{
			TechnologyProxy,
			true
		},
		{
			BillboardProxy,
			true
		},
		{
			MetaCharacterProxy,
			true
		},
		{
			TechnologyNationProxy,
			true
		},
		{
			AttireProxy,
			true
		},
		{
			ShipSkinProxy,
			true
		},
		{
			SecondaryPWDProxy,
			true,
			{}
		},
		{
			SkirmishProxy,
			true
		},
		{
			PrayProxy,
			true
		},
		{
			EmojiProxy,
			true
		},
		{
			MiniGameProxy,
			true
		},
		{
			InstagramProxy,
			true
		},
		{
			InstagramChatProxy,
			true
		},
		{
			CryptolaliaProxy,
			true
		},
		{
			AppreciateProxy,
			true
		},
		{
			AvatarFrameProxy,
			true
		},
		{
			ActivityTaskProxy,
			true
		},
		{
			TotalTaskProxy,
			true
		},
		{
			RefluxProxy,
			true
		},
		{
			SixthAnniversaryIslandProxy,
			true
		},
		{
			LimitChallengeProxy,
			true
		},
		{
			GameRoomProxy,
			true
		},
		{
			FeastProxy,
			true
		},
		{
			EducateProxy,
			not LOCK_EDUCATE_SYSTEM
		},
		{
			NewEducateProxy,
			true
		},
		{
			ApartmentProxy,
			true
		},
		{
			LivingAreaCoverProxy,
			true
		},
		{
			Dorm3dChatProxy,
			true
		},
		{
			Dorm3dInsProxy,
			true
		},
		{
			GMTProxy,
			true
		},
		{
			IslandProxy,
			true
		},
		{
			SystemTipProxy,
			true
		},
		{
			CommanderManualProxy,
			true
		},
		{
			CityRebuildProxy,
			true
		},
		{
			LoveLetterProxy,
			true
		},
		{
			PlayRoomProxy,
			true
		},
		{
			LoadingPicProxy,
			true
		},
		{
			AuctionGameBaseProxy,
			true
		},
		{
			AuctionGameProxy,
			true
		}
	})
	pg.ConnectionMgr.GetInstance():setPacketIdx(1)
	pg.ConnectionMgr.GetInstance():Send(11001, {
		timestamp = 0
	}, 11002, function(arg_2_0)
		originalPrint("player loaded: " .. arg_2_0.timestamp)
		pg.TimeMgr.GetInstance():SetServerTime(arg_2_0.timestamp, arg_2_0.monday_0oclock_timestamp)
		pg.proxyRegister:Start()

		local var_2_0 = getProxy(PlayerProxy):getRawData()
		local var_2_1, var_2_2 = getProxy(ActivityProxy):isSurveyOpen()

		if var_2_1 then
			self:sendNotification(GAME.GET_SURVEY_STATE, {
				surveyID = var_2_2
			})
		end

		self:sendNotification(GAME.AUCTION_GAME_INIT, {})

		if var_1_1 then
			pg.PushNotificationMgr.GetInstance():Reset()
			pg.SdkMgr.GetInstance():CreateRole(var_2_0.id, var_2_0.name, var_2_0.level, var_2_0.registerTime, var_2_0:getTotalGem())
		end

		pg.SeriesGuideMgr.GetInstance():Init(var_1_1, var_2_0)
		WorldGuider.GetInstance():Init()

		local var_2_3 = getProxy(UserProxy):getData()
		local var_2_4 = getProxy(ServerProxy)
		local var_2_5 = var_2_4:getLastServer(var_2_3.uid)

		pg.SdkMgr.GetInstance():EnterServer(tostring(var_2_5.id), var_2_5.name, var_2_0.id, var_2_0.name, var_2_0.registerTime, var_2_0.level, var_2_0:getTotalGem())
		var_2_4:recordLoginedServer(var_2_3.uid, var_2_5.id)
		getProxy(MetaCharacterProxy):requestMetaTacticsInfo(nil, true)
		self:sendNotification(GAME.REQUEST_META_PT_DATA, {
			isAll = true
		})
		self:sendNotification(GAME.GET_SEASON_INFO)
		self:sendNotification(GAME.GET_GUILD_INFO)
		self:sendNotification(GAME.GET_PUBLIC_GUILD_USER_DATA, {})
		self:sendNotification(GAME.REQUEST_MINI_GAME, {
			type = MiniGameRequestCommand.REQUEST_HUB_DATA
		})
		self:sendNotification(GAME.REQUEST_EMOJI_INFO_FROM_SERVER)
		LimitChallengeConst.RequestInfo()

		if not LOCK_EDUCATE_SYSTEM then
			self:sendNotification(GAME.EDUCATE_REQUEST)
		end

		if not LOCK_NEW_EDUCATE_SYSTEM then
			getProxy(NewEducateProxy):ReqDataCheck()
		end

		self:sendNotification(GAME.ACT_INSTAGRAM_CHAT, {
			operation = ActivityConst.INSTAGRAM_CHAT_GET_DATA
		})
		pg.SdkMgr.GetInstance():BindCPU()
		pg.SecondaryPWDMgr.GetInstance():FetchData()
		MonthCardOutDateTipPanel.SetMonthCardEndDateLocal()
		pg.NewStoryMgr.GetInstance():Fix()
		getProxy(SettingsProxy):ResetTimeLimitSkinShopTip()
		getProxy(SettingsProxy):ResetContinuousOperationAutoSub()
		getProxy(PlayerProxy):setInited(true)

		if MainCheckShipNumSequence.New():Check(arg_2_0.ship_count) then
			self:sendNotification(GAME.LOAD_PLAYER_DATA_DONE)
		end

		pg.GameTrackerMgr.GetInstance():FetchCache()

		if Dorm3dRoomTemplateScene.FirstDefaultSetting then
			self:sendNotification(GAME.APARTMENT_TRACK, Dorm3dTrackCommand.BuildDataGraphics(Dorm3dRoomTemplateScene.FirstDefaultSetting))

			Dorm3dRoomTemplateScene.FirstDefaultSetting = nil
		end

		pg.SdkMgr.GetInstance():QueryPendingTransaction()

		if ISLAND_PLAYER_TESTING then
			pg.WatermarkingMgr.GetInstance():Init(var_2_0)
		end

		return
	end, nil, 60)

	return
end

return LoadPlayerDataCommand

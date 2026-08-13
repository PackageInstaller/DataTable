class = var_0_10000

local var_0_0 = "LoadPlayerDataCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().isNewPlayer
	local var_1_1 = var_2.id

	originalPrint = var_1_10005

	var_1_10005("loading player data: " .. var_1_1)

	pg = var_1_10005
	ProxyRegister = var_1_10006
	var_1_10005.proxyRegister = var_1_10006.New()
	pg = var_1_10005

	local var_1_2 = var_1_10005.proxyRegister
	local var_1_3 = var_5.RgisterProxy
	local var_1_4 = arg_1_0.facade
	local var_1_5 = {}
	local var_1_6 = {
		nil,
		true
	}

	PlayerProxy = var_1_10011
	var_1_6[1] = var_1_10011
	var_1_5[1] = var_1_6

	local var_1_7 = {
		nil,
		true
	}

	BayProxy = var_1_10011
	var_1_7[1] = var_1_10011
	var_1_7[3] = {}
	var_1_5[2] = var_1_7

	local var_1_8 = {
		nil,
		true
	}

	FleetProxy = var_11
	var_1_8[1] = var_11
	var_1_8[3] = {}
	var_1_5[3] = var_1_8

	local var_1_9 = {
		nil,
		true
	}

	EquipmentProxy = var_11
	var_1_9[1] = var_11
	var_1_9[3] = {}
	var_1_5[4] = var_1_9

	local var_1_10 = {
		nil,
		true
	}

	ChapterProxy = var_11
	var_1_10[1] = var_11
	var_1_10[3] = {}
	var_1_5[5] = var_1_10

	local var_1_11 = {
		nil,
		true
	}

	WorldProxy = var_11
	var_1_11[1] = var_11
	var_1_11[3] = {}
	var_1_5[6] = var_1_11

	local var_1_12 = {
		nil,
		true
	}

	BagProxy = var_11
	var_1_12[1] = var_11
	var_1_12[3] = {}
	var_1_5[7] = var_1_12

	local var_1_13 = {
		nil,
		true
	}

	TaskProxy = var_11
	var_1_13[1] = var_11
	var_1_13[3] = {}
	var_1_5[8] = var_1_13

	local var_1_14 = {
		nil,
		true
	}

	MailProxy = var_11
	var_1_14[1] = var_11
	var_1_14[3] = {}
	var_1_5[9] = var_1_14

	local var_1_15 = {
		nil,
		true
	}

	CompensateProxy = var_11
	var_1_15[1] = var_11
	var_1_15[3] = {}
	var_1_5[10] = var_1_15

	local var_1_16 = {
		nil,
		true
	}

	NavalAcademyProxy = var_11
	var_1_16[1] = var_11
	var_1_16[3] = {}
	var_1_5[11] = var_1_16

	local var_1_17 = {
		nil,
		true
	}

	DormProxy = var_11
	var_1_17[1] = var_11
	var_1_17[3] = {}
	var_1_5[12] = var_1_17

	local var_1_18 = {
		nil,
		true
	}

	ChatProxy = var_11
	var_1_18[1] = var_11
	var_1_18[3] = {}
	var_1_5[13] = var_1_18

	local var_1_19 = {
		nil,
		true
	}

	FriendProxy = var_11
	var_1_19[1] = var_11
	var_1_19[3] = {}
	var_1_5[14] = var_1_19

	local var_1_20 = {
		nil,
		true
	}

	NotificationProxy = var_11
	var_1_20[1] = var_11
	var_1_20[3] = {}
	var_1_5[15] = var_1_20

	local var_1_21 = {
		nil,
		true
	}

	BuildShipProxy = var_11
	var_1_21[1] = var_11
	var_1_21[3] = {}
	var_1_5[16] = var_1_21

	local var_1_22 = {
		nil,
		true
	}

	CollectionProxy = var_11
	var_1_22[1] = var_11
	var_1_22[3] = {}
	var_1_5[17] = var_1_22

	local var_1_23 = {
		nil,
		true
	}

	EventProxy = var_11
	var_1_23[1] = var_11
	var_1_23[3] = {}
	var_1_5[18] = var_1_23

	local var_1_24 = {
		nil,
		true
	}

	ActivityProxy = var_11
	var_1_24[1] = var_11
	var_1_24[3] = {}
	var_1_5[19] = var_1_24

	local var_1_25 = {
		nil,
		true
	}

	ActivityPermanentProxy = var_11
	var_1_25[1] = var_11
	var_1_25[3] = {}
	var_1_5[20] = var_1_25

	local var_1_26 = {
		nil,
		true
	}

	MilitaryExerciseProxy = var_11
	var_1_26[1] = var_11
	var_1_5[21] = var_1_26

	local var_1_27 = {
		nil,
		true
	}

	ServerNoticeProxy = var_11
	var_1_27[1] = var_11
	var_1_5[22] = var_1_27

	local var_1_28 = {
		nil,
		true
	}

	DailyLevelProxy = var_11
	var_1_28[1] = var_11
	var_1_5[23] = var_1_28

	local var_1_29 = {
		nil,
		true
	}

	ShopsProxy = var_11
	var_1_29[1] = var_11
	var_1_5[24] = var_1_29

	local var_1_30 = {
		nil,
		true
	}

	GuildProxy = var_11
	var_1_30[1] = var_11
	var_1_5[25] = var_1_30

	local var_1_31 = {
		nil,
		true
	}

	VoteProxy = var_11
	var_1_31[1] = var_11
	var_1_5[26] = var_1_31

	local var_1_32 = {
		nil,
		true
	}

	ChallengeProxy = var_11
	var_1_32[1] = var_11
	var_1_5[27] = var_1_32

	local var_1_33 = {
		nil,
		true
	}

	CommanderProxy = var_11
	var_1_33[1] = var_11
	var_1_5[28] = var_1_33

	local var_1_34 = {
		nil,
		true
	}

	ColoringProxy = var_11
	var_1_34[1] = var_11
	var_1_5[29] = var_1_34

	local var_1_35 = {
		nil,
		true
	}

	AnswerProxy = var_11
	var_1_35[1] = var_11
	var_1_5[30] = var_1_35

	local var_1_36 = {
		nil,
		true
	}

	TechnologyProxy = var_11
	var_1_36[1] = var_11
	var_1_5[31] = var_1_36

	local var_1_37 = {
		nil,
		true
	}

	BillboardProxy = var_11
	var_1_37[1] = var_11
	var_1_5[32] = var_1_37

	local var_1_38 = {
		nil,
		true
	}

	MetaCharacterProxy = var_11
	var_1_38[1] = var_11
	var_1_5[33] = var_1_38

	local var_1_39 = {
		nil,
		true
	}

	TechnologyNationProxy = var_11
	var_1_39[1] = var_11
	var_1_5[34] = var_1_39

	local var_1_40 = {
		nil,
		true
	}

	AttireProxy = var_11
	var_1_40[1] = var_11
	var_1_5[35] = var_1_40

	local var_1_41 = {
		nil,
		true
	}

	ShipSkinProxy = var_11
	var_1_41[1] = var_11
	var_1_5[36] = var_1_41

	local var_1_42 = {
		nil,
		true
	}

	SecondaryPWDProxy = var_11
	var_1_42[1] = var_11
	var_1_42[3] = {}
	var_1_5[37] = var_1_42

	local var_1_43 = {
		nil,
		true
	}

	SkirmishProxy = var_11
	var_1_43[1] = var_11
	var_1_5[38] = var_1_43

	local var_1_44 = {
		nil,
		true
	}

	PrayProxy = var_11
	var_1_44[1] = var_11
	var_1_5[39] = var_1_44

	local var_1_45 = {
		nil,
		true
	}

	EmojiProxy = var_11
	var_1_45[1] = var_11
	var_1_5[40] = var_1_45

	local var_1_46 = {
		nil,
		true
	}

	MiniGameProxy = var_11
	var_1_46[1] = var_11
	var_1_5[41] = var_1_46

	local var_1_47 = {
		nil,
		true
	}

	InstagramProxy = var_11
	var_1_47[1] = var_11
	var_1_5[42] = var_1_47

	local var_1_48 = {
		nil,
		true
	}

	InstagramChatProxy = var_11
	var_1_48[1] = var_11
	var_1_5[43] = var_1_48

	local var_1_49 = {
		nil,
		true
	}

	CryptolaliaProxy = var_11
	var_1_49[1] = var_11
	var_1_5[44] = var_1_49

	local var_1_50 = {
		nil,
		true
	}

	AppreciateProxy = var_11
	var_1_50[1] = var_11
	var_1_5[45] = var_1_50

	local var_1_51 = {
		nil,
		true
	}

	AvatarFrameProxy = var_11
	var_1_51[1] = var_11
	var_1_5[46] = var_1_51

	local var_1_52 = {
		nil,
		true
	}

	ActivityTaskProxy = var_11
	var_1_52[1] = var_11
	var_1_5[47] = var_1_52

	local var_1_53 = {
		nil,
		true
	}

	TotalTaskProxy = var_11
	var_1_53[1] = var_11
	var_1_5[48] = var_1_53

	local var_1_54 = {
		nil,
		true
	}

	RefluxProxy = var_11
	var_1_54[1] = var_11
	var_1_5[49] = var_1_54

	local var_1_55 = {
		nil,
		true
	}

	SixthAnniversaryIslandProxy = var_11
	var_1_55[1] = var_11
	var_1_5[50] = var_1_55

	local var_1_56 = {
		nil,
		true
	}

	LimitChallengeProxy = var_11
	var_1_56[1] = var_11
	var_1_5[51] = var_1_56

	local var_1_57 = {
		nil,
		true
	}

	GameRoomProxy = var_11
	var_1_57[1] = var_11
	var_1_5[52] = var_1_57

	local var_1_58 = {
		nil,
		true
	}

	FeastProxy = var_11
	var_1_58[1] = var_11
	var_1_5[53] = var_1_58

	local var_1_59 = {}

	EducateProxy = var_11
	var_1_59[1] = var_11
	LOCK_EDUCATE_SYSTEM = var_11
	var_1_59[2] = not var_11
	var_1_5[54] = var_1_59

	local var_1_60 = {
		nil,
		true
	}

	NewEducateProxy = var_11
	var_1_60[1] = var_11
	var_1_5[55] = var_1_60

	local var_1_61 = {
		nil,
		true
	}

	ApartmentProxy = var_11
	var_1_61[1] = var_11
	var_1_5[56] = var_1_61

	local var_1_62 = {
		nil,
		true
	}

	LivingAreaCoverProxy = var_11
	var_1_62[1] = var_11
	var_1_5[57] = var_1_62

	local var_1_63 = {
		nil,
		true
	}

	Dorm3dChatProxy = var_11
	var_1_63[1] = var_11
	var_1_5[58] = var_1_63

	local var_1_64 = {
		nil,
		true
	}

	Dorm3dInsProxy = var_11
	var_1_64[1] = var_11
	var_1_5[59] = var_1_64

	local var_1_65 = {
		nil,
		true
	}

	GMTProxy = var_11
	var_1_65[1] = var_11
	var_1_5[60] = var_1_65

	local var_1_66 = {
		nil,
		true
	}

	IslandProxy = var_11
	var_1_66[1] = var_11
	var_1_5[61] = var_1_66

	local var_1_67 = {
		nil,
		true
	}

	SystemTipProxy = var_11
	var_1_67[1] = var_11
	var_1_5[62] = var_1_67

	local var_1_68 = {
		nil,
		true
	}

	CommanderManualProxy = var_11
	var_1_68[1] = var_11
	var_1_5[63] = var_1_68

	local var_1_69 = {
		nil,
		true
	}

	CityRebuildProxy = var_11
	var_1_69[1] = var_11
	var_1_5[64] = var_1_69

	local var_1_70 = {
		nil,
		true
	}

	LoveLetterProxy = var_11
	var_1_70[1] = var_11
	var_1_5[65] = var_1_70

	local var_1_71 = {
		nil,
		true
	}

	PlayRoomProxy = var_11
	var_1_71[1] = var_11
	var_1_5[66] = var_1_71

	local var_1_72 = {
		nil,
		true
	}

	LoadingPicProxy = var_11
	var_1_72[1] = var_11
	var_1_5[67] = var_1_72

	local var_1_73 = {
		nil,
		true
	}

	AuctionGameBaseProxy = var_11
	var_1_73[1] = var_11
	var_1_5[68] = var_1_73

	local var_1_74 = {
		nil,
		true
	}

	AuctionGameProxy = var_11
	var_1_74[1] = var_11
	var_1_5[69] = var_1_74

	var_1_3(var_1_2, var_1_4, var_1_5)

	pg = var_1_3

	local var_1_75 = var_1_3.ConnectionMgr.GetInstance()

	var_5.setPacketIdx(var_1_75, 1)

	pg = var_5

	local var_1_76 = var_5.ConnectionMgr.GetInstance()

	var_5.Send(var_1_76, 11001, {
		timestamp = 0
	}, 11002, function(arg_2_0)
		originalPrint = var_2_10001

		var_2_10001("player loaded: " .. arg_2_0.timestamp)

		pg = var_2_10001

		local var_2_0 = var_2_10001.TimeMgr.GetInstance()

		var_1.SetServerTime(var_2_0, arg_2_0.timestamp, arg_2_0.monday_0oclock_timestamp)

		pg = var_1

		local var_2_1 = var_1.proxyRegister

		var_1.Start(var_2_1)

		getProxy = var_1
		PlayerProxy = var_2_1

		local var_2_2 = var_1(var_2_1)
		local var_2_3 = var_1.getRawData(var_2_2)

		getProxy = var_2_1
		ActivityProxy = var_5

		local var_2_4 = var_2_1(var_5)
		local var_2_5, var_2_6 = var_3.isSurveyOpen(var_2_4)

		if var_2_5 then
			local var_2_7 = arg_1_0
			local var_2_8 = var_5.sendNotification

			GAME = var_2_10008

			var_2_8(var_2_7, var_2_10008.GET_SURVEY_STATE, {
				surveyID = var_2_6
			})
		end

		local var_2_9 = arg_1_0
		local var_2_10 = var_5.sendNotification

		GAME = var_2_10008

		var_2_10(var_2_9, var_2_10008.AUCTION_GAME_INIT, {})

		if var_1_0 then
			pg = var_5

			local var_2_11 = var_5.PushNotificationMgr.GetInstance()

			var_5.Reset(var_2_11)

			pg = var_5

			local var_2_12 = var_5.SdkMgr.GetInstance()

			var_5.CreateRole(var_2_12, var_2_3.id, var_2_3.name, var_2_3.level, var_2_3.registerTime, var_2_3:getTotalGem())
		end

		pg = var_5

		local var_2_13 = var_5.SeriesGuideMgr.GetInstance()

		var_5.Init(var_2_13, var_1_0, var_2_3)

		WorldGuider = var_5

		local var_2_14 = var_5.GetInstance()

		var_5.Init(var_2_14)

		getProxy = var_5
		UserProxy = var_2_14

		local var_2_15 = var_5(var_2_14)
		local var_2_16 = var_5.getData(var_2_15)

		getProxy = var_2_14
		ServerProxy = var_9

		local var_2_17 = var_2_14(var_9)
		local var_2_18 = var_7.getLastServer(var_2_17, var_2_16.uid)

		pg = var_9

		local var_2_19 = var_9.SdkMgr.GetInstance()
		local var_2_20 = var_9.EnterServer

		tostring = var_2_10012

		var_2_20(var_2_19, var_2_10012(var_2_18.id), var_2_18.name, var_2_3.id, var_2_3.name, var_2_3.registerTime, var_2_3.level, var_2_3:getTotalGem())

		local var_2_21 = var_7

		var_7.recordLoginedServer(var_2_21, var_2_16.uid, var_2_18.id)

		getProxy = var_9
		MetaCharacterProxy = var_2_21

		local var_2_22 = var_9(var_2_21)

		var_9.requestMetaTacticsInfo(var_2_22, nil, true)

		local var_2_23 = arg_1_0
		local var_2_24 = var_9.sendNotification

		GAME = var_12

		var_2_24(var_2_23, var_12.REQUEST_META_PT_DATA, {
			isAll = true
		})

		local var_2_25 = arg_1_0
		local var_2_26 = var_9.sendNotification

		GAME = var_12

		var_2_26(var_2_25, var_12.GET_SEASON_INFO)

		local var_2_27 = arg_1_0
		local var_2_28 = var_9.sendNotification

		GAME = var_12

		var_2_28(var_2_27, var_12.GET_GUILD_INFO)

		local var_2_29 = arg_1_0
		local var_2_30 = var_9.sendNotification

		GAME = var_12

		var_2_30(var_2_29, var_12.GET_PUBLIC_GUILD_USER_DATA, {})

		local var_2_31 = arg_1_0
		local var_2_32 = var_9.sendNotification

		GAME = var_12

		local var_2_33 = var_12.REQUEST_MINI_GAME
		local var_2_34 = {}

		MiniGameRequestCommand = var_14
		var_2_34.type = var_14.REQUEST_HUB_DATA

		var_2_32(var_2_31, var_2_33, var_2_34)

		local var_2_35 = arg_1_0
		local var_2_36 = var_9.sendNotification

		GAME = var_2_33

		var_2_36(var_2_35, var_2_33.REQUEST_EMOJI_INFO_FROM_SERVER)

		LimitChallengeConst = var_2_36

		var_2_36.RequestInfo()

		LOCK_EDUCATE_SYSTEM = var_2_37

		local var_2_37

		if not var_2_37 then
			var_2_35 = arg_1_0
			var_2_37 = var_2_37.sendNotification
			GAME = var_12

			var_2_37(var_2_35, var_12.EDUCATE_REQUEST)
		end

		LOCK_NEW_EDUCATE_SYSTEM = var_2_37

		if not var_2_37 then
			getProxy = var_2_37
			NewEducateProxy = var_2_35

			local var_2_38 = var_2_37(var_2_35)

			var_9.ReqDataCheck(var_2_38)
		end

		local var_2_39 = arg_1_0
		local var_2_40 = var_9.sendNotification

		GAME = var_12

		local var_2_41 = var_12.ACT_INSTAGRAM_CHAT
		local var_2_42 = {}

		ActivityConst = var_14
		var_2_42.operation = var_14.INSTAGRAM_CHAT_GET_DATA

		var_2_40(var_2_39, var_2_41, var_2_42)

		pg = var_2_40

		local var_2_43 = var_2_40.SdkMgr.GetInstance()

		var_9.BindCPU(var_2_43)

		pg = var_9

		local var_2_44 = var_9.SecondaryPWDMgr.GetInstance()

		var_9.FetchData(var_2_44)

		MonthCardOutDateTipPanel = var_9

		var_9.SetMonthCardEndDateLocal()

		pg = var_9

		local var_2_45 = var_9.NewStoryMgr.GetInstance()

		var_9.Fix(var_2_45)

		getProxy = var_9
		SettingsProxy = var_2_45

		local var_2_46 = var_9(var_2_45)

		var_9.ResetTimeLimitSkinShopTip(var_2_46)

		getProxy = var_9
		SettingsProxy = var_2_46

		local var_2_47 = var_9(var_2_46)

		var_9.ResetContinuousOperationAutoSub(var_2_47)

		getProxy = var_9
		PlayerProxy = var_2_47

		local var_2_48 = var_9(var_2_47)

		var_9.setInited(var_2_48, true)

		MainCheckShipNumSequence = var_10

		local var_2_49 = var_10.New()
		local var_2_51

		if var_10.Check(var_2_49, arg_2_0.ship_count) then
			local var_2_50 = arg_1_0

			var_2_51 = var_2_51.sendNotification
			GAME = var_13

			var_2_51(var_2_50, var_13.LOAD_PLAYER_DATA_DONE)
		end

		pg = var_2_51

		local var_2_52 = var_2_51.GameTrackerMgr.GetInstance()

		var_10.FetchCache(var_2_52)

		Dorm3dRoomTemplateScene = var_10

		local var_2_54

		if var_10.FirstDefaultSetting then
			local var_2_53 = arg_1_0

			var_2_54 = var_2_54.sendNotification
			GAME = var_13

			local var_2_55 = var_13.APARTMENT_TRACK

			Dorm3dTrackCommand = var_14

			local var_2_56 = var_14.BuildDataGraphics

			Dorm3dRoomTemplateScene = var_16

			var_2_54(var_2_53, var_2_55, var_2_56(var_16.FirstDefaultSetting))

			Dorm3dRoomTemplateScene = var_2_54
			var_2_54.FirstDefaultSetting = nil
		end

		pg = var_2_54

		local var_2_57 = var_2_54.SdkMgr.GetInstance()

		var_10.QueryPendingTransaction(var_2_57)

		ISLAND_PLAYER_TESTING = var_10

		if var_10 then
			pg = var_10

			local var_2_58 = var_10.WatermarkingMgr.GetInstance()

			var_10.Init(var_2_58, var_2_3)
		end

		return
	end, nil, 60)

	return
end

return var_0_1

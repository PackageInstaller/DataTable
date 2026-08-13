class = var_0_10000

local var_0_0 = "IslandCheaterTavernMainPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.IslandBasePage"))

function var_0_1.getUIName(arg_1_0)
	return "IslandCheaterTavernMainUI"
end

function var_0_1.NeedCache(arg_2_0)
	return false
end

function var_0_1.CreateViews(arg_3_0)
	arg_3_0.views = {
		arg_3_0:CreateCheaterTavernStartGameView(),
		arg_3_0:CreateCheaterTavernInGamingView()
	}

	return
end

function var_0_1.GetSubView(arg_4_0, arg_4_1)
	ipairs = var_1_10002

	for iter_4_0, iter_4_1 in var_1_10002(arg_4_0.views) do
		isa = var_1_10007

		if var_1_10007(iter_4_1, arg_4_1) then
			return iter_4_1
		end
	end

	return nil
end

function var_0_1.ExecuteAction(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0:Load(arg_5_2)
	arg_5_0:ActionInvoke(arg_5_1, arg_5_2)

	arg_5_0.initShow = true

	return
end

function var_0_1.CreateCheaterTavernStartGameView(arg_6_0)
	IslandCheaterTavernStartGameView = var_1_10001

	local var_6_0 = var_1_10001.New(arg_6_0.uiStartGamePanel)

	var_1.attach(var_6_0, arg_6_0)

	return var_1
end

function var_0_1.CreateCheaterTavernInGamingView(arg_7_0)
	IslandCheaterTavernInGamingView = var_1_10001

	local var_7_0 = var_1_10001.New(arg_7_0.uiInGamingPanel, arg_7_0)

	var_1.attach(var_7_0, arg_7_0)

	return var_1
end

function var_0_1.OnLoaded(arg_8_0)
	return
end

function var_0_1.Preload(arg_9_0, arg_9_1)
	arg_9_0.numDicCache = {}

	local var_9_0 = 0

	for iter_9_0 = 1, 10 do
		local var_9_1 = iter_9_0 % 10

		GetSpriteFromAtlasAsync = var_1_10008

		var_1_10008("Island/IslandCheaterTavernIcon/" .. var_9_1, "", function(arg_10_0)
			arg_9_0.numDicCache[var_9_1] = arg_10_0
			var_9_0 = var_9_0 + 1

			if var_9_0 == 1 then
				arg_9_1()
			end

			return
		end)
	end

	return
end

function var_0_1.GetNumSpriteByIndex(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1 % 10

	return arg_11_0.numDicCache[var_11_0]
end

function var_0_1.AddListeners(arg_12_0)
	local var_12_0 = arg_12_0
	local var_12_1 = arg_12_0.AddListener

	GAME = var_1_10004

	var_12_1(var_12_0, var_1_10004.ISLAND_CHEATER_FIRSTROND_START, arg_12_0.OnCheaterEveryRoundStart)

	IslandCheaterTavernConst = var_12_1

	if not var_12_1.putCardTest then
		local var_12_2 = arg_12_0
		local var_12_3 = arg_12_0.AddListener

		GAME = var_4

		var_12_3(var_12_2, var_4.ISLAND_PLAYER_CHEATER_OPERATE_DONE, arg_12_0.OnCheaterOperateDone)

		local var_12_4 = arg_12_0
		local var_12_5 = arg_12_0.AddListener

		GAME = var_4

		var_12_5(var_12_4, var_4.ISLAND_CHEATER_OPERATE_DONE_NOTIFY, arg_12_0.OnCheaterOperateDoneNotify)

		local var_12_6 = arg_12_0
		local var_12_7 = arg_12_0.AddListener

		GAME = var_4

		var_12_7(var_12_6, var_4.ISLAND_CHEATER_END_SCORE_NOTIFY, arg_12_0.OnCheaterEndScoreNotify)

		local var_12_8 = arg_12_0
		local var_12_9 = arg_12_0.AddListener

		GAME = var_4

		var_12_9(var_12_8, var_4.ISLAND_CHEATER_REAL_END_NOTIFY, arg_12_0.OnGameEndNotify)

		local var_12_10 = arg_12_0
		local var_12_11 = arg_12_0.AddListener

		CheaterTavernEvent = var_4

		var_12_11(var_12_10, var_4.FINSH_PAGE_QUIT, arg_12_0.OnCheaterFinishQuit)

		local var_12_12 = arg_12_0
		local var_12_13 = arg_12_0.AddListener

		GAME = var_4

		var_12_13(var_12_12, var_4.ISLAND_CHEATER_DELEGATE_NOTIFY, arg_12_0.OnCheaterDelegateNotify)

		local var_12_14 = arg_12_0
		local var_12_15 = arg_12_0.AddListener

		GAME = var_4

		var_12_15(var_12_14, var_4.ISLAND_CHEATER_RECONNECT, arg_12_0.OnCheaterReconected)
	end

	local var_12_16 = arg_12_0
	local var_12_17 = arg_12_0.AddListener

	ChatProxy = var_4

	var_12_17(var_12_16, var_4.NEW_MSG, arg_12_0.RefreshMessage)

	local var_12_18 = arg_12_0
	local var_12_19 = arg_12_0.AddListener

	FriendProxy = var_4

	var_12_19(var_12_18, var_4.FRIEND_NEW_MSG, arg_12_0.RefreshMessage)

	local var_12_20 = arg_12_0
	local var_12_21 = arg_12_0.AddListener

	GuildProxy = var_4

	var_12_21(var_12_20, var_4.NEW_MSG_ADDED, arg_12_0.RefreshMessage)

	local var_12_22 = arg_12_0
	local var_12_23 = arg_12_0.AddListener

	PlayRoomProxy = var_4

	var_12_23(var_12_22, var_4.CHAT_MSG_UPDATE, arg_12_0.RefreshMessage)

	local var_12_24 = arg_12_0
	local var_12_25 = arg_12_0.AddListener

	GAME = var_4

	var_12_25(var_12_24, var_4.CHANGE_CHAT_ROOM_DONE, arg_12_0.RefreshMessage)

	local var_12_26 = arg_12_0
	local var_12_27 = arg_12_0.AddListener

	IslandProxy = var_4

	var_12_27(var_12_26, var_4.PRESS_BACK, arg_12_0.OnPressBack)

	return
end

function var_0_1.RemoveListeners(arg_13_0)
	local var_13_0 = arg_13_0
	local var_13_1 = arg_13_0.RemoveListener

	GAME = var_1_10004

	var_13_1(var_13_0, var_1_10004.ISLAND_CHEATER_FIRSTROND_START, arg_13_0.OnCheaterEveryRoundStart)

	IslandCheaterTavernConst = var_13_1

	if not var_13_1.putCardTest then
		local var_13_2 = arg_13_0
		local var_13_3 = arg_13_0.RemoveListener

		GAME = var_4

		var_13_3(var_13_2, var_4.ISLAND_PLAYER_CHEATER_OPERATE_DONE, arg_13_0.OnCheaterOperateDone)

		local var_13_4 = arg_13_0
		local var_13_5 = arg_13_0.RemoveListener

		GAME = var_4

		var_13_5(var_13_4, var_4.ISLAND_CHEATER_OPERATE_DONE_NOTIFY, arg_13_0.OnCheaterOperateDoneNotify)

		local var_13_6 = arg_13_0
		local var_13_7 = arg_13_0.RemoveListener

		GAME = var_4

		var_13_7(var_13_6, var_4.ISLAND_CHEATER_END_SCORE_NOTIFY, arg_13_0.OnCheaterEndScoreNotify)

		local var_13_8 = arg_13_0
		local var_13_9 = arg_13_0.RemoveListener

		GAME = var_4

		var_13_9(var_13_8, var_4.ISLAND_CHEATER_REAL_END_NOTIFY, arg_13_0.OnGameEndNotify)

		local var_13_10 = arg_13_0
		local var_13_11 = arg_13_0.RemoveListener

		CheaterTavernEvent = var_4

		var_13_11(var_13_10, var_4.FINSH_PAGE_QUIT, arg_13_0.OnCheaterFinishQuit)

		local var_13_12 = arg_13_0
		local var_13_13 = arg_13_0.RemoveListener

		GAME = var_4

		var_13_13(var_13_12, var_4.ISLAND_CHEATER_DELEGATE_NOTIFY, arg_13_0.OnCheaterDelegateNotify)

		local var_13_14 = arg_13_0
		local var_13_15 = arg_13_0.RemoveListener

		GAME = var_4

		var_13_15(var_13_14, var_4.ISLAND_CHEATER_RECONNECT, arg_13_0.OnCheaterReconected)
	end

	local var_13_16 = arg_13_0
	local var_13_17 = arg_13_0.RemoveListener

	ChatProxy = var_4

	var_13_17(var_13_16, var_4.NEW_MSG, arg_13_0.RefreshMessage)

	local var_13_18 = arg_13_0
	local var_13_19 = arg_13_0.RemoveListener

	FriendProxy = var_4

	var_13_19(var_13_18, var_4.FRIEND_NEW_MSG, arg_13_0.RefreshMessage)

	local var_13_20 = arg_13_0
	local var_13_21 = arg_13_0.RemoveListener

	GuildProxy = var_4

	var_13_21(var_13_20, var_4.NEW_MSG_ADDED, arg_13_0.RefreshMessage)

	local var_13_22 = arg_13_0
	local var_13_23 = arg_13_0.RemoveListener

	PlayRoomProxy = var_4

	var_13_23(var_13_22, var_4.CHAT_MSG_UPDATE, arg_13_0.RefreshMessage)

	local var_13_24 = arg_13_0
	local var_13_25 = arg_13_0.RemoveListener

	GAME = var_4

	var_13_25(var_13_24, var_4.CHANGE_CHAT_ROOM_DONE, arg_13_0.RefreshMessage)

	local var_13_26 = arg_13_0
	local var_13_27 = arg_13_0.RemoveListener

	IslandProxy = var_4

	var_13_27(var_13_26, var_4.PRESS_BACK, arg_13_0.OnPressBack)

	return
end

function var_0_1.OnCheaterFinishQuit(arg_14_0)
	arg_14_0:Hide()

	local var_14_0 = arg_14_0
	local var_14_1 = arg_14_0.emit

	IslandMediator = var_1_10004

	var_14_1(var_14_0, var_1_10004.PLAY_ROOM_MATCH_STOP)

	getProxy = var_14_1
	PlayRoomProxy = var_14_0

	local var_14_2 = var_14_1(var_14_0)

	var_1.SetPlayingGameState(var_14_2, false)

	IslandCheaterTavernRecordTools = var_1

	local var_14_3 = var_1.RecordResult

	IslandCheaterTavernRecordTools = var_14_2

	var_14_3(var_14_2.LEAVE)

	return
end

function var_0_1.OnCheaterEndScoreNotify(arg_15_0)
	local var_15_0 = arg_15_0
	local var_15_1 = arg_15_0.GetSubView

	IslandCheaterTavernInGamingView = var_1_10004

	local var_15_2 = var_15_1(var_15_0, var_1_10004)

	var_1.DestroyMainCard(var_15_2)

	arg_15_0.isFinish = true

	local var_15_3 = arg_15_0
	local var_15_4 = arg_15_0.emit

	IslandMediator = var_1_10004

	local var_15_5 = var_1_10004.OPEN_PAGE
	local var_15_6 = "IslandCheaterTavernFinishPage"
	local var_15_7 = {}

	IslandCheaterTavernConst = var_1_10007
	var_15_7[1] = var_1_10007.SettlementType.ByScore

	var_15_4(var_15_3, var_15_5, var_15_6, var_15_7)

	return
end

function var_0_1.OnGameEndNotify(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0:GetIsland()
	local var_16_1 = var_2.GetCheaterTavernAgency(var_16_0)
	local var_16_2 = arg_16_1.win_user

	getProxy = var_16_0
	PlayerProxy = var_1_10006

	local var_16_3 = var_16_0(var_1_10006)
	local var_16_4 = var_16_2 == var_4.getRawData(var_16_3).id
	local var_16_5 = var_16_1:GetPlayerData(var_16_2)
	local var_16_6 = arg_16_0
	local var_16_7 = arg_16_0.emitCore

	CheaterTavernEvent = var_1_10009

	var_16_7(var_16_6, var_1_10009.PLAY_WIN_ANIMATION, var_16_2, var_16_4, var_16_5.seat)

	if var_16_4 then
		return
	end

	local var_16_8 = arg_16_0
	local var_16_9 = arg_16_0.GetPage

	IslandCheaterTavernFinishPage = var_9

	if var_16_9(var_16_8, var_9) then
		return
	end

	local var_16_10 = arg_16_0
	local var_16_11 = arg_16_0.emit

	IslandMediator = var_9

	local var_16_12 = var_9.OPEN_PAGE
	local var_16_13 = "IslandCheaterTavernFinishPage"
	local var_16_14 = {}

	IslandCheaterTavernConst = var_12
	var_16_14[1] = var_12.SettlementType.ByFinal

	var_16_11(var_16_10, var_16_12, var_16_13, var_16_14)

	return
end

function var_0_1.OnCheaterDelegateNotify(arg_17_0)
	local var_17_0 = arg_17_0
	local var_17_1 = arg_17_0.GetSubView

	IslandCheaterTavernInGamingView = var_1_10004

	local var_17_2 = var_17_1(var_17_0, var_1_10004)

	var_1.UpdateDelegateState(var_17_2)

	return
end

function var_0_1.OnCheaterOperateDoneNotify(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0
	local var_18_1 = arg_18_0.GetSubView

	IslandCheaterTavernInGamingView = var_1_10005

	local var_18_2 = var_18_1(var_18_0, var_1_10005)

	var_2.OnCheaterOperateDoneNotify(var_18_2, arg_18_1)

	return
end

function var_0_1.OnCheaterOperateDone(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0
	local var_19_1 = arg_19_0.GetSubView

	IslandCheaterTavernInGamingView = var_1_10005

	local var_19_2 = var_19_1(var_19_0, var_1_10005)

	var_2.OnCheaterOperateDone(var_19_2, arg_19_1)

	return
end

function var_0_1.OnCheaterReconected(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0
	local var_20_1 = arg_20_0.GetSubView

	IslandCheaterTavernInGamingView = var_1_10005

	local var_20_2 = var_20_1(var_20_0, var_1_10005)

	var_2.OnCheaterReconected(var_20_2, arg_20_1.operation)

	return
end

function var_0_1.OnCheaterEveryRoundStart(arg_21_0, arg_21_1)
	ipairs = var_1_10002

	for iter_21_0, iter_21_1 in var_1_10002(arg_21_0.views) do
		iter_21_1:OnCheaterEveryRoundStart()
	end

	local var_21_0 = arg_21_0.animation

	var_2.Play(var_21_0, "Anim_IslandCheaterTavernMainUI_in")
	arg_21_0:RemoveEveryRondStartTimer()

	pg = var_2

	local var_21_1 = var_2.gameset.bar_showcard_time.key_value

	Timer = var_3
	arg_21_0.everyRondStartTimer = var_3.New(function()
		ipairs = var_2_10000

		for iter_22_0, iter_22_1 in var_2_10000(arg_21_0.views) do
			iter_22_1:OnCheaterEveryRoundStartDone(arg_21_1.operation)
		end

		return
	end, var_21_1, 1)

	local var_21_2 = arg_21_0.everyRondStartTimer

	var_3.Start(var_21_2)

	return
end

function var_0_1.RemoveEveryRondStartTimer(arg_23_0)
	if arg_23_0.everyRondStartTimer then
		local var_23_0 = arg_23_0.everyRondStartTimer

		var_1.Stop(var_23_0)
	end

	return
end

function var_0_1.OnInit(arg_24_0)
	onButton = var_1_10001

	local var_24_0 = arg_24_0
	local var_24_1 = arg_24_0.uicloseBtn

	local function var_24_2()
		local var_25_0 = arg_24_0

		var_0.OnClickCloseBtn(var_25_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_24_0, var_24_1, var_24_2, var_1_10006)

	onButton = var_1_10001

	local var_24_3 = arg_24_0
	local var_24_4 = arg_24_0.uiSenderPanel

	local function var_24_5()
		local var_26_0 = arg_24_0
		local var_26_1 = var_0.emit

		BaseUI = var_2_10003

		local var_26_2 = var_2_10003.ON_ADD_SUBLAYER

		Context = var_2_10004

		local var_26_3 = var_2_10004.New
		local var_26_4 = {}

		PlayRoomNotificationLayer = var_2_10007
		var_26_4.viewComponent = var_2_10007
		PlayRoomNotificationMediator = var_2_10007
		var_26_4.mediator = var_2_10007
		var_26_4.data = {
			inRoom = true
		}

		var_26_1(var_26_0, var_26_2, var_26_3(var_26_4))

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_24_3, var_24_4, var_24_5, var_1_10006)

	onButton = var_1_10001

	local var_24_6 = arg_24_0
	local var_24_7 = arg_24_0.uiHelpBtn

	local function var_24_8()
		pg = var_2_10000

		local var_27_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_27_1 = var_0.ShowMsgBox
		local var_27_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_27_2.type = var_2_10004
		pg = var_2_10004
		var_27_2.helps = var_2_10004.gametip.island_help_bar.tip

		var_27_1(var_27_0, var_27_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_24_6, var_24_7, var_24_8, var_1_10006)

	local var_24_9 = arg_24_0.uiAdapt
	local var_24_10 = var_1.GetComponent

	typeof = var_24_7
	Animation = var_1_10006
	arg_24_0.animation = var_24_10(var_24_9, var_24_7(var_1_10006))

	return
end

function var_0_1.OnShow(arg_28_0, arg_28_1, arg_28_2)
	arg_28_0.isFinish = false

	arg_28_0:CreateViews()

	local var_28_0 = arg_28_0
	local var_28_1 = arg_28_0.GetSubView

	IslandCheaterTavernInGamingView = var_1_10006

	local var_28_2 = var_28_1(var_28_0, var_1_10006)

	var_3.SetActiveState(var_28_2, false)

	local var_28_3 = arg_28_0
	local var_28_4 = arg_28_0.GetSubView

	IslandCheaterTavernStartGameView = var_6

	local var_28_5 = var_28_4(var_28_3, var_6)

	var_3.SetActiveState(var_28_5, false)
	arg_28_0:Flush()
	arg_28_0:RefreshMessage()

	ipairs = var_3

	for iter_28_0, iter_28_1 in var_3(arg_28_0.views) do
		iter_28_1:Init()
	end

	return
end

function var_0_1.Flush(arg_29_0)
	return
end

function var_0_1.OnDestroy(arg_30_0)
	arg_30_0:OnHide()
	var_0_1.super.OnDestroy(arg_30_0)

	return
end

function var_0_1.OnHide(arg_31_0)
	local var_31_0 = arg_31_0:GetIsland()
	local var_31_1 = var_1.GetCheaterTavernAgency(var_31_0)

	var_1.SetUILoadOver(var_31_1, false)
	arg_31_0:RemoveEveryRondStartTimer()

	ipairs = var_1

	for iter_31_0, iter_31_1 in var_1(arg_31_0.views) do
		iter_31_1:Hide()
	end

	return
end

function var_0_1.RefreshMessage(arg_32_0)
	arg_32_0:GetMessages()

	local var_32_0 = arg_32_0.displays

	setActive = var_1_10002

	var_1_10002(arg_32_0.uiChatItemGo, #var_32_0 > 0)

	if #var_32_0 <= 0 then
		return
	end

	local var_32_1 = var_32_0[#var_32_0]
	local var_32_2 = arg_32_0.uiChannelImage

	GetSpriteFromAtlas = var_4

	local var_32_3 = "channel"

	ChatConst = var_1_10007
	var_32_2.sprite = var_4(var_32_3, var_1_10007.GetChannelSprite(var_32_1.type) .. "_mel")

	local var_32_4 = arg_32_0.uiChatText
	local var_32_5 = var_3.GetComponent(var_32_4, "RichText")
	local var_32_6 = var_32_1.type

	ChatConst = var_32_4

	if var_32_6 == var_32_4.ChannelPublic then
		var_32_5.supportRichText = true
		ChatProxy = var_4

		var_4.InjectPublic(var_32_5, var_32_1, true)
	else
		local var_32_7 = var_32_1

		if var_32_1.IsWorldBossNotify(var_32_7) then
			var_32_5.supportRichText = true

			local var_32_8 = var_32_1.args.playerName
			local var_32_9 = var_32_1.args.bossName

			GetPerceptualSize = var_32_7

			local var_32_10 = var_32_7(var_32_8 .. var_32_9) - 18
			local var_32_11

			if 0 < var_32_10 then
				GetPerceptualSize = var_32_11
				var_32_11 = var_32_11(var_32_9) - var_32_10
				shortenString = var_9
				var_32_9 = var_9(var_32_9, var_32_11)
			end

			i18n = var_32_11
			var_32_5.text = var_32_11("ad_4", var_32_1.args.supportType, var_32_8, var_32_9, var_32_1.args.level)
		else
			var_32_5.supportRichText = var_32_1.emojiId ~= nil
			var_32_5.text = arg_32_0:MatchEmoji(var_32_5, var_32_1)
		end
	end

	return
end

function var_0_1.MatchEmoji(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = false
	local var_33_1 = arg_33_2.player.name .. ": " .. arg_33_2.content
	local var_33_2 = false

	string = var_6

	local var_33_3 = var_6.gmatch
	local var_33_4 = var_33_1

	ChatConst = var_1_10009

	for iter_33_0 in var_33_3(var_33_4, var_1_10009.EmojiIconCodeMatch) do
		table = var_1_10011
		var_1_10011 = var_1_10011.contains
		pg = var_1_10013
		var_1_10013 = var_1_10013.emoji_small_template.all
		tonumber = var_1_10014

		if var_1_10011(var_1_10013, var_1_10014(iter_33_0)) then
			var_33_2 = true
			pg = var_1_10011
			var_1_10011 = var_1_10011.emoji_small_template
			tonumber = var_1_10012
			var_1_10011 = var_1_10011[var_1_10012(iter_33_0)]
			LoadSprite = var_1_10012
			var_1_10012 = var_1_10012("emoji/" .. var_1_10011.pic .. "_small", nil)

			arg_33_1:AddSprite(iter_33_0, var_1_10012)
		end
	end

	if not arg_33_2.emojiId then
		if var_33_2 then
			shortenString = var_7

			if not var_7(var_33_1, 16) then
				::label_33_0::

				shortenString = var_7
				var_33_1 = var_7(var_33_1, 20)
			end

			string = var_7

			local var_33_5 = var_7.gsub
			local var_33_6 = var_33_1

			ChatConst = iter_33_0

			return (var_33_5(var_33_6, iter_33_0.EmojiIconCodeMatch, function(arg_34_0)
				table = var_2_10001

				local var_34_0 = var_2_10001.contains

				pg = var_2_10003

				local var_34_1 = var_2_10003.emoji_small_template.all

				tonumber = var_2_10004

				if var_34_0(var_34_1, var_2_10004(arg_34_0)) then
					string = var_1

					return var_1.format("<icon name=%s w=0.7 h=0.7/>", arg_34_0)
				end

				return
			end))
		end
	end
end

function var_0_1.GetMessages(arg_35_0)
	arg_35_0.displays = {}
	getProxy = var_1
	ChatProxy = var_1_10003

	local var_35_0 = var_1(var_1_10003)

	_ = var_1_10002

	var_1_10002.each(var_35_0:getRawData(), function(arg_36_0)
		local var_36_0 = arg_35_0

		var_1.InsertMsg(var_36_0, arg_35_0.displays, arg_36_0)

		return
	end)

	getProxy = var_2
	GuildProxy = var_4

	local var_35_1 = var_2(var_4)

	if var_2.getRawData(var_35_1) then
		_ = var_3

		var_3.each(var_2:getChatMsgs(), function(arg_37_0)
			local var_37_0 = arg_35_0

			var_1.InsertMsg(var_37_0, arg_35_0.displays, arg_37_0)

			return
		end)
	end

	getProxy = var_3
	FriendProxy = var_35_1

	local var_35_2 = var_3(var_35_1)

	_ = var_4

	local var_35_3 = var_4.each
	local var_35_4 = var_35_2

	var_35_3(var_35_2.getCacheMsgList(var_35_4), function(arg_38_0)
		local var_38_0 = arg_35_0

		var_1.InsertMsg(var_38_0, arg_35_0.displays, arg_38_0)

		return
	end)

	_ = var_35_3

	local var_35_5 = var_35_3.each

	getProxy = var_6
	PlayRoomProxy = var_35_4

	local var_35_6 = var_6(var_35_4)

	var_35_5(var_6.GetChatMsgs(var_35_6), function(arg_39_0)
		local var_39_0 = arg_35_0

		var_1.InsertMsg(var_39_0, arg_35_0.displays, arg_39_0)

		return
	end)

	table = var_35_5

	var_35_5.sort(arg_35_0.displays, function(arg_40_0, arg_40_1)
		return arg_40_0.timestamp < arg_40_1.timestamp
	end)

	return
end

function var_0_1.InsertMsg(arg_41_0, arg_41_1, arg_41_2)
	getProxy = var_1_10003
	FriendProxy = var_1_10005

	local var_41_0 = var_1_10003(var_1_10005)

	if var_3.isInBlackList(var_41_0, arg_41_2.playerId) then
		return
	end

	if arg_41_2.player and arg_41_2.content then
		table = var_3

		var_3.insert(arg_41_1, arg_41_2)
	end

	return
end

function var_0_1.OnClickCloseBtn(arg_42_0)
	local var_42_0 = {}

	getProxy = var_1_10002
	PlayRoomProxy = var_1_10004

	local var_42_1 = var_1_10002(var_1_10004)
	local var_42_2 = var_2.GetRoomData(var_42_1)
	local var_42_3

	if not arg_42_0.isFinish then
		var_42_3 = var_42_2.roomType
		PlayRoomConst = var_42_1

		if var_42_3 == var_42_1.PLAY_ROOM_TYPE.MATCH then
			table = var_42_3

			var_42_3.insert(var_42_0, function(arg_43_0)
				pg = var_2_10001

				local var_43_0 = var_2_10001.MsgboxMgr.GetInstance()
				local var_43_1 = var_1.ShowMsgBox
				local var_43_2 = {}

				i18n = var_2_10005
				var_43_2.content = var_2_10005("bar_tips_game6")
				var_43_2.onYes = arg_43_0

				var_43_1(var_43_0, var_43_2)

				return
			end)
		else
			table = var_42_3

			var_42_3.insert(var_42_0, function(arg_44_0)
				pg = var_2_10001

				local var_44_0 = var_2_10001.MsgboxMgr.GetInstance()
				local var_44_1 = var_1.ShowMsgBox
				local var_44_2 = {}

				i18n = var_2_10005
				var_44_2.content = var_2_10005("bar_tips_game7")
				var_44_2.onYes = arg_44_0

				var_44_1(var_44_0, var_44_2)

				return
			end)
		end
	end

	seriesAsync = var_42_3

	var_42_3(var_42_0, function()
		local var_45_0 = arg_42_0

		var_0.Hide(var_45_0)

		local var_45_1 = arg_42_0
		local var_45_2 = var_0.emit

		IslandMediator = var_2_10003

		var_45_2(var_45_1, var_2_10003.PLAY_ROOM_MATCH_STOP)

		getProxy = var_45_2
		PlayRoomProxy = var_45_1

		local var_45_3 = var_45_2(var_45_1)

		var_0.SetPlayingGameState(var_45_3, false)

		IslandCheaterTavernRecordTools = var_0

		local var_45_4 = var_0.RecordResult

		IslandCheaterTavernRecordTools = var_45_3

		var_45_4(var_45_3.LEAVE)

		return
	end)

	return
end

function var_0_1.OnPressBack(arg_46_0)
	arg_46_0:OnClickCloseBtn()

	return
end

return var_0_1

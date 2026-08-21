local var_0_0 = class("IslandCheaterTavernMainPage", import("...base.IslandBasePage"))

function var_0_0.getUIName(arg_1_0)
	return "IslandCheaterTavernMainUI"
end

function var_0_0.NeedCache(arg_2_0)
	return false
end

function var_0_0.CreateViews(arg_3_0)
	arg_3_0.views = {
		arg_3_0:CreateCheaterTavernStartGameView(),
		arg_3_0:CreateCheaterTavernInGamingView()
	}

	return
end

function var_0_0.GetSubView(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(arg_4_0.views) do
		if isa(iter_4_1, arg_4_1) then
			return iter_4_1
		end
	end

	return nil
end

function var_0_0.ExecuteAction(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0:Load(arg_5_2)
	arg_5_0:ActionInvoke(arg_5_1, arg_5_2)

	arg_5_0.initShow = true

	return
end

function var_0_0.CreateCheaterTavernStartGameView(arg_6_0)
	local var_6_0 = IslandCheaterTavernStartGameView.New(arg_6_0.uiStartGamePanel)

	var_6_0:attach(arg_6_0)

	return var_6_0
end

function var_0_0.CreateCheaterTavernInGamingView(arg_7_0)
	local var_7_0 = IslandCheaterTavernInGamingView.New(arg_7_0.uiInGamingPanel, arg_7_0)

	var_7_0:attach(arg_7_0)

	return var_7_0
end

function var_0_0.OnLoaded(arg_8_0)
	return
end

function var_0_0.Preload(arg_9_0, arg_9_1)
	arg_9_0.numDicCache = {}

	local var_9_0 = 0

	for iter_9_0 = 1, 10 do
		GetSpriteFromAtlasAsync("Island/IslandCheaterTavernIcon/" .. iter_9_0 % 10, "", function(arg_10_0)
			arg_9_0.numDicCache[var_0] = arg_10_0
			var_9_0 = var_9_0 + 1

			if var_9_0 == 1 then
				arg_9_1()
			end

			return
		end)
	end

	return
end

function var_0_0.GetNumSpriteByIndex(arg_11_0, arg_11_1)
	return arg_11_0.numDicCache[arg_11_1 % 10]
end

function var_0_0.AddListeners(arg_12_0)
	arg_12_0:AddListener(GAME.ISLAND_CHEATER_FIRSTROND_START, arg_12_0.OnCheaterEveryRoundStart)

	if not IslandCheaterTavernConst.putCardTest then
		arg_12_0:AddListener(GAME.ISLAND_PLAYER_CHEATER_OPERATE_DONE, arg_12_0.OnCheaterOperateDone)
		arg_12_0:AddListener(GAME.ISLAND_CHEATER_OPERATE_DONE_NOTIFY, arg_12_0.OnCheaterOperateDoneNotify)
		arg_12_0:AddListener(GAME.ISLAND_CHEATER_END_SCORE_NOTIFY, arg_12_0.OnCheaterEndScoreNotify)
		arg_12_0:AddListener(GAME.ISLAND_CHEATER_REAL_END_NOTIFY, arg_12_0.OnGameEndNotify)
		arg_12_0:AddListener(CheaterTavernEvent.FINSH_PAGE_QUIT, arg_12_0.OnCheaterFinishQuit)
		arg_12_0:AddListener(GAME.ISLAND_CHEATER_DELEGATE_NOTIFY, arg_12_0.OnCheaterDelegateNotify)
		arg_12_0:AddListener(GAME.ISLAND_CHEATER_RECONNECT, arg_12_0.OnCheaterReconected)
	end

	arg_12_0:AddListener(ChatProxy.NEW_MSG, arg_12_0.RefreshMessage)
	arg_12_0:AddListener(FriendProxy.FRIEND_NEW_MSG, arg_12_0.RefreshMessage)
	arg_12_0:AddListener(GuildProxy.NEW_MSG_ADDED, arg_12_0.RefreshMessage)
	arg_12_0:AddListener(PlayRoomProxy.CHAT_MSG_UPDATE, arg_12_0.RefreshMessage)
	arg_12_0:AddListener(GAME.CHANGE_CHAT_ROOM_DONE, arg_12_0.RefreshMessage)
	arg_12_0:AddListener(IslandProxy.PRESS_BACK, arg_12_0.OnPressBack)

	return
end

function var_0_0.RemoveListeners(arg_13_0)
	arg_13_0:RemoveListener(GAME.ISLAND_CHEATER_FIRSTROND_START, arg_13_0.OnCheaterEveryRoundStart)

	if not IslandCheaterTavernConst.putCardTest then
		arg_13_0:RemoveListener(GAME.ISLAND_PLAYER_CHEATER_OPERATE_DONE, arg_13_0.OnCheaterOperateDone)
		arg_13_0:RemoveListener(GAME.ISLAND_CHEATER_OPERATE_DONE_NOTIFY, arg_13_0.OnCheaterOperateDoneNotify)
		arg_13_0:RemoveListener(GAME.ISLAND_CHEATER_END_SCORE_NOTIFY, arg_13_0.OnCheaterEndScoreNotify)
		arg_13_0:RemoveListener(GAME.ISLAND_CHEATER_REAL_END_NOTIFY, arg_13_0.OnGameEndNotify)
		arg_13_0:RemoveListener(CheaterTavernEvent.FINSH_PAGE_QUIT, arg_13_0.OnCheaterFinishQuit)
		arg_13_0:RemoveListener(GAME.ISLAND_CHEATER_DELEGATE_NOTIFY, arg_13_0.OnCheaterDelegateNotify)
		arg_13_0:RemoveListener(GAME.ISLAND_CHEATER_RECONNECT, arg_13_0.OnCheaterReconected)
	end

	arg_13_0:RemoveListener(ChatProxy.NEW_MSG, arg_13_0.RefreshMessage)
	arg_13_0:RemoveListener(FriendProxy.FRIEND_NEW_MSG, arg_13_0.RefreshMessage)
	arg_13_0:RemoveListener(GuildProxy.NEW_MSG_ADDED, arg_13_0.RefreshMessage)
	arg_13_0:RemoveListener(PlayRoomProxy.CHAT_MSG_UPDATE, arg_13_0.RefreshMessage)
	arg_13_0:RemoveListener(GAME.CHANGE_CHAT_ROOM_DONE, arg_13_0.RefreshMessage)
	arg_13_0:RemoveListener(IslandProxy.PRESS_BACK, arg_13_0.OnPressBack)

	return
end

function var_0_0.OnCheaterFinishQuit(arg_14_0)
	arg_14_0:Hide()
	arg_14_0:emit(IslandMediator.PLAY_ROOM_MATCH_STOP)
	getProxy(PlayRoomProxy):SetPlayingGameState(false)
	IslandCheaterTavernRecordTools.RecordResult(IslandCheaterTavernRecordTools.LEAVE)

	return
end

function var_0_0.OnCheaterEndScoreNotify(arg_15_0)
	arg_15_0:GetSubView(IslandCheaterTavernInGamingView):DestroyMainCard()

	arg_15_0.isFinish = true

	arg_15_0:emit(IslandMediator.OPEN_PAGE, "IslandCheaterTavernFinishPage", {
		IslandCheaterTavernConst.SettlementType.ByScore
	})

	return
end

function var_0_0.OnGameEndNotify(arg_16_0, arg_16_1)
	local var_16_9000
	local var_16_0 = arg_16_0:GetIsland()
	local var_16_1 = var_16_0.GetCheaterTavernAgency(var_16_9000)
	local var_16_2 = arg_16_1.win_user == getProxy(PlayerProxy).getRawData(var_16_0).id

	arg_16_0:emitCore(CheaterTavernEvent.PLAY_WIN_ANIMATION, arg_16_1.win_user, var_16_2, var_16_1:GetPlayerData(arg_16_1.win_user).seat)

	if var_16_2 then
		return
	end

	if arg_16_0:GetPage(IslandCheaterTavernFinishPage) then
		return
	end

	arg_16_0:emit(IslandMediator.OPEN_PAGE, "IslandCheaterTavernFinishPage", {
		IslandCheaterTavernConst.SettlementType.ByFinal
	})

	return
end

function var_0_0.OnCheaterDelegateNotify(arg_17_0)
	arg_17_0:GetSubView(IslandCheaterTavernInGamingView):UpdateDelegateState()

	return
end

function var_0_0.OnCheaterOperateDoneNotify(arg_18_0, arg_18_1)
	arg_18_0:GetSubView(IslandCheaterTavernInGamingView):OnCheaterOperateDoneNotify(arg_18_1)

	return
end

function var_0_0.OnCheaterOperateDone(arg_19_0, arg_19_1)
	arg_19_0:GetSubView(IslandCheaterTavernInGamingView):OnCheaterOperateDone(arg_19_1)

	return
end

function var_0_0.OnCheaterReconected(arg_20_0, arg_20_1)
	arg_20_0:GetSubView(IslandCheaterTavernInGamingView):OnCheaterReconected(arg_20_1.operation)

	return
end

function var_0_0.OnCheaterEveryRoundStart(arg_21_0, arg_21_1)
	for iter_21_0, iter_21_1 in ipairs(arg_21_0.views) do
		iter_21_1:OnCheaterEveryRoundStart()
	end

	arg_21_0.animation:Play("Anim_IslandCheaterTavernMainUI_in")
	arg_21_0:RemoveEveryRondStartTimer()

	arg_21_0.everyRondStartTimer = Timer.New(function()
		for iter_22_0, iter_22_1 in ipairs(arg_21_0.views) do
			iter_22_1:OnCheaterEveryRoundStartDone(arg_21_1.operation)
		end

		return
	end, pg.gameset.bar_showcard_time.key_value, 1)

	arg_21_0.everyRondStartTimer:Start()

	return
end

function var_0_0.RemoveEveryRondStartTimer(arg_23_0)
	if arg_23_0.everyRondStartTimer then
		arg_23_0.everyRondStartTimer:Stop()
	end

	return
end

function var_0_0.OnInit(arg_24_0)
	onButton(arg_24_0, arg_24_0.uicloseBtn, function()
		arg_24_0:OnClickCloseBtn()

		return
	end, SFX_PANEL)
	onButton(arg_24_0, arg_24_0.uiSenderPanel, function()
		arg_24_0:emit(BaseUI.ON_ADD_SUBLAYER, Context.New({
			viewComponent = PlayRoomNotificationLayer,
			mediator = PlayRoomNotificationMediator,
			data = {
				inRoom = true
			}
		}))

		return
	end, SFX_PANEL)
	onButton(arg_24_0, arg_24_0.uiHelpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.island_help_bar.tip
		})

		return
	end, SFX_PANEL)

	arg_24_0.animation = arg_24_0.uiAdapt:GetComponent(typeof(Animation))

	return
end

function var_0_0.OnShow(arg_28_0, arg_28_1, arg_28_2)
	arg_28_0.isFinish = false

	arg_28_0:CreateViews()
	arg_28_0:GetSubView(IslandCheaterTavernInGamingView):SetActiveState(false)
	arg_28_0:GetSubView(IslandCheaterTavernStartGameView):SetActiveState(false)
	arg_28_0:Flush()
	arg_28_0:RefreshMessage()

	for iter_28_0, iter_28_1 in ipairs(arg_28_0.views) do
		iter_28_1:Init()
	end

	return
end

function var_0_0.Flush(arg_29_0)
	return
end

function var_0_0.OnDestroy(arg_30_0)
	arg_30_0:OnHide()
	var_0_0.super.OnDestroy(arg_30_0)

	return
end

function var_0_0.OnHide(arg_31_0)
	arg_31_0:GetIsland():GetCheaterTavernAgency():SetUILoadOver(false)
	arg_31_0:RemoveEveryRondStartTimer()

	for iter_31_0, iter_31_1 in ipairs(arg_31_0.views) do
		iter_31_1:Hide()
	end

	return
end

function var_0_0.RefreshMessage(arg_32_0)
	arg_32_0:GetMessages()

	local var_32_0 = arg_32_0.displays

	setActive(arg_32_0.uiChatItemGo, #arg_32_0.displays > 0)

	if #var_32_0 <= 0 then
		return
	end

	local var_32_1 = var_32_0[#var_32_0]

	arg_32_0.uiChannelImage.sprite = GetSpriteFromAtlas("channel", ChatConst.GetChannelSprite(var_32_0[#var_32_0].type) .. "_mel")

	local var_32_2 = arg_32_0.uiChatText:GetComponent("RichText")

	if var_32_1.type == ChatConst.ChannelPublic then
		var_32_2.supportRichText = true

		ChatProxy.InjectPublic(var_32_2, var_32_1, true)
	elseif var_32_1:IsWorldBossNotify() then
		var_32_2.supportRichText = true

		local var_32_3 = var_32_1.args.bossName
		local var_32_4 = GetPerceptualSize(var_32_1.args.playerName .. var_32_1.args.bossName) - 18

		if var_32_4 > 0 then
			var_32_3 = shortenString(var_32_3, GetPerceptualSize(var_32_3) - var_32_4)
		end

		var_32_2.text = i18n("ad_4", var_32_1.args.supportType, var_32_1.args.playerName, var_32_3, var_32_1.args.level)
	else
		var_32_2.supportRichText = var_32_1.emojiId ~= nil
		var_32_2.text = arg_32_0:MatchEmoji(var_32_2, var_32_1)
	end

	return
end

function var_0_0.MatchEmoji(arg_33_0, arg_33_1, arg_33_2)
	local var_33_1 = arg_33_2.player.name .. ": " .. arg_33_2.content
	local var_33_2 = false

	for iter_33_0 in string.gmatch(arg_33_2.player.name .. ": " .. arg_33_2.content, ChatConst.EmojiIconCodeMatch) do
		if table.contains(pg.emoji_small_template.all, tonumber(iter_33_0)) then
			var_33_2 = true

			arg_33_1:AddSprite(iter_33_0, (LoadSprite("emoji/" .. pg.emoji_small_template[tonumber(iter_33_0)].pic .. "_small", nil)))
		end
	end

	if not arg_33_2.emojiId then
		var_33_1 = var_33_2 and shortenString(var_33_1, 16) or shortenString(var_33_1, 20)
	end

	return (string.gsub(var_33_1, ChatConst.EmojiIconCodeMatch, function(arg_34_0)
		if table.contains(pg.emoji_small_template.all, tonumber(arg_34_0)) then
			return string.format("<icon name=%s w=0.7 h=0.7/>", arg_34_0)
		end

		return
	end))
end

function var_0_0.GetMessages(arg_35_0)
	arg_35_0.displays = {}

	_.each(getProxy(ChatProxy):getRawData(), function(arg_36_0)
		arg_35_0:InsertMsg(arg_35_0.displays, arg_36_0)

		return
	end)

	local var_35_0 = getProxy(GuildProxy)

	if var_35_0:getRawData() then
		_.each(var_35_0:getChatMsgs(), function(arg_37_0)
			arg_35_0:InsertMsg(arg_35_0.displays, arg_37_0)

			return
		end)
	end

	local var_35_1 = getProxy(FriendProxy)

	_.each(var_35_1:getCacheMsgList(), function(arg_38_0)
		arg_35_0:InsertMsg(arg_35_0.displays, arg_38_0)

		return
	end)
	_.each(getProxy(PlayRoomProxy):GetChatMsgs(), function(arg_39_0)
		arg_35_0:InsertMsg(arg_35_0.displays, arg_39_0)

		return
	end)
	table.sort(arg_35_0.displays, function(arg_40_0, arg_40_1)
		return arg_40_0.timestamp < arg_40_1.timestamp
	end)

	return
end

function var_0_0.InsertMsg(arg_41_0, arg_41_1, arg_41_2)
	if getProxy(FriendProxy):isInBlackList(arg_41_2.playerId) then
		return
	end

	if arg_41_2.player and arg_41_2.content then
		table.insert(arg_41_1, arg_41_2)
	end

	return
end

function var_0_0.OnClickCloseBtn(arg_42_0)
	if not arg_42_0.isFinish then
		if getProxy(PlayRoomProxy):GetRoomData().roomType == PlayRoomConst.PLAY_ROOM_TYPE.MATCH then
			table.insert({}, function(arg_43_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("bar_tips_game6"),
					onYes = arg_43_0
				})

				return
			end)
		else
			table.insert({}, function(arg_44_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("bar_tips_game7"),
					onYes = arg_44_0
				})

				return
			end)
		end
	end

	seriesAsync({}, function()
		arg_42_0:Hide()
		arg_42_0:emit(IslandMediator.PLAY_ROOM_MATCH_STOP)
		getProxy(PlayRoomProxy):SetPlayingGameState(false)
		IslandCheaterTavernRecordTools.RecordResult(IslandCheaterTavernRecordTools.LEAVE)

		return
	end)

	return
end

function var_0_0.OnPressBack(arg_46_0)
	arg_46_0:OnClickCloseBtn()

	return
end

return var_0_0

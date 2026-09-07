local IslandCheaterTavernMainPage = class("IslandCheaterTavernMainPage", import("...base.IslandBasePage"))

function IslandCheaterTavernMainPage:getUIName()
	return "IslandCheaterTavernMainUI"
end

function IslandCheaterTavernMainPage:NeedCache()
	return false
end

function IslandCheaterTavernMainPage:CreateViews()
	self.views = {
		self:CreateCheaterTavernStartGameView(),
		self:CreateCheaterTavernInGamingView()
	}

	return
end

function IslandCheaterTavernMainPage:GetSubView(arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(self.views) do
		if isa(iter_4_1, arg_4_1) then
			return iter_4_1
		end
	end

	return nil
end

function IslandCheaterTavernMainPage:ExecuteAction(arg_5_1, arg_5_2)
	self:Load(arg_5_2)
	self:ActionInvoke(arg_5_1, arg_5_2)

	self.initShow = true

	return
end

function IslandCheaterTavernMainPage:CreateCheaterTavernStartGameView()
	local var_6_0 = IslandCheaterTavernStartGameView.New(self.uiStartGamePanel)

	var_6_0:attach(self)

	return var_6_0
end

function IslandCheaterTavernMainPage:CreateCheaterTavernInGamingView()
	local var_7_0 = IslandCheaterTavernInGamingView.New(self.uiInGamingPanel, self)

	var_7_0:attach(self)

	return var_7_0
end

function IslandCheaterTavernMainPage:OnLoaded()
	return
end

function IslandCheaterTavernMainPage:Preload(arg_9_1)
	self.numDicCache = {}

	local var_9_0 = 0

	for iter_9_0 = 1, 10 do
		local var_9_1 = iter_9_0 % 10

		GetSpriteFromAtlasAsync("Island/IslandCheaterTavernIcon/" .. iter_9_0 % 10, "", function(arg_10_0)
			self.numDicCache[var_9_1] = arg_10_0
			var_9_0 = var_9_0 + 1

			if var_9_0 == 1 then
				arg_9_1()
			end

			return
		end)
	end

	return
end

function IslandCheaterTavernMainPage:GetNumSpriteByIndex(arg_11_1)
	return self.numDicCache[arg_11_1 % 10]
end

function IslandCheaterTavernMainPage:AddListeners()
	self:AddListener(GAME.ISLAND_CHEATER_FIRSTROND_START, self.OnCheaterEveryRoundStart)

	if not IslandCheaterTavernConst.putCardTest then
		self:AddListener(GAME.ISLAND_PLAYER_CHEATER_OPERATE_DONE, self.OnCheaterOperateDone)
		self:AddListener(GAME.ISLAND_CHEATER_OPERATE_DONE_NOTIFY, self.OnCheaterOperateDoneNotify)
		self:AddListener(GAME.ISLAND_CHEATER_END_SCORE_NOTIFY, self.OnCheaterEndScoreNotify)
		self:AddListener(GAME.ISLAND_CHEATER_REAL_END_NOTIFY, self.OnGameEndNotify)
		self:AddListener(CheaterTavernEvent.FINSH_PAGE_QUIT, self.OnCheaterFinishQuit)
		self:AddListener(GAME.ISLAND_CHEATER_DELEGATE_NOTIFY, self.OnCheaterDelegateNotify)
		self:AddListener(GAME.ISLAND_CHEATER_RECONNECT, self.OnCheaterReconected)
	end

	self:AddListener(ChatProxy.NEW_MSG, self.RefreshMessage)
	self:AddListener(FriendProxy.FRIEND_NEW_MSG, self.RefreshMessage)
	self:AddListener(GuildProxy.NEW_MSG_ADDED, self.RefreshMessage)
	self:AddListener(PlayRoomProxy.CHAT_MSG_UPDATE, self.RefreshMessage)
	self:AddListener(GAME.CHANGE_CHAT_ROOM_DONE, self.RefreshMessage)
	self:AddListener(IslandProxy.PRESS_BACK, self.OnPressBack)

	return
end

function IslandCheaterTavernMainPage:RemoveListeners()
	self:RemoveListener(GAME.ISLAND_CHEATER_FIRSTROND_START, self.OnCheaterEveryRoundStart)

	if not IslandCheaterTavernConst.putCardTest then
		self:RemoveListener(GAME.ISLAND_PLAYER_CHEATER_OPERATE_DONE, self.OnCheaterOperateDone)
		self:RemoveListener(GAME.ISLAND_CHEATER_OPERATE_DONE_NOTIFY, self.OnCheaterOperateDoneNotify)
		self:RemoveListener(GAME.ISLAND_CHEATER_END_SCORE_NOTIFY, self.OnCheaterEndScoreNotify)
		self:RemoveListener(GAME.ISLAND_CHEATER_REAL_END_NOTIFY, self.OnGameEndNotify)
		self:RemoveListener(CheaterTavernEvent.FINSH_PAGE_QUIT, self.OnCheaterFinishQuit)
		self:RemoveListener(GAME.ISLAND_CHEATER_DELEGATE_NOTIFY, self.OnCheaterDelegateNotify)
		self:RemoveListener(GAME.ISLAND_CHEATER_RECONNECT, self.OnCheaterReconected)
	end

	self:RemoveListener(ChatProxy.NEW_MSG, self.RefreshMessage)
	self:RemoveListener(FriendProxy.FRIEND_NEW_MSG, self.RefreshMessage)
	self:RemoveListener(GuildProxy.NEW_MSG_ADDED, self.RefreshMessage)
	self:RemoveListener(PlayRoomProxy.CHAT_MSG_UPDATE, self.RefreshMessage)
	self:RemoveListener(GAME.CHANGE_CHAT_ROOM_DONE, self.RefreshMessage)
	self:RemoveListener(IslandProxy.PRESS_BACK, self.OnPressBack)

	return
end

function IslandCheaterTavernMainPage:OnCheaterFinishQuit()
	self:Hide()
	self:emit(IslandMediator.PLAY_ROOM_MATCH_STOP)
	getProxy(PlayRoomProxy):SetPlayingGameState(false)
	IslandCheaterTavernRecordTools.RecordResult(IslandCheaterTavernRecordTools.LEAVE)

	return
end

function IslandCheaterTavernMainPage:OnCheaterEndScoreNotify()
	self:GetSubView(IslandCheaterTavernInGamingView):DestroyMainCard()

	self.isFinish = true

	self:emit(IslandMediator.OPEN_PAGE, "IslandCheaterTavernFinishPage", {
		IslandCheaterTavernConst.SettlementType.ByScore
	})

	return
end

function IslandCheaterTavernMainPage:OnGameEndNotify(arg_16_1)
	local var_16_0 = self:GetIsland()
	local var_16_1 = var_16_0:GetCheaterTavernAgency()
	local var_16_2 = arg_16_1.win_user == getProxy(PlayerProxy).getRawData(var_16_0).id

	self:emitCore(CheaterTavernEvent.PLAY_WIN_ANIMATION, arg_16_1.win_user, var_16_2, var_16_1:GetPlayerData(arg_16_1.win_user).seat)

	if var_16_2 then
		return
	end

	if self:GetPage(IslandCheaterTavernFinishPage) then
		return
	end

	self:emit(IslandMediator.OPEN_PAGE, "IslandCheaterTavernFinishPage", {
		IslandCheaterTavernConst.SettlementType.ByFinal
	})

	return
end

function IslandCheaterTavernMainPage:OnCheaterDelegateNotify()
	self:GetSubView(IslandCheaterTavernInGamingView):UpdateDelegateState()

	return
end

function IslandCheaterTavernMainPage:OnCheaterOperateDoneNotify(arg_18_1)
	self:GetSubView(IslandCheaterTavernInGamingView):OnCheaterOperateDoneNotify(arg_18_1)

	return
end

function IslandCheaterTavernMainPage:OnCheaterOperateDone(arg_19_1)
	self:GetSubView(IslandCheaterTavernInGamingView):OnCheaterOperateDone(arg_19_1)

	return
end

function IslandCheaterTavernMainPage:OnCheaterReconected(arg_20_1)
	self:GetSubView(IslandCheaterTavernInGamingView):OnCheaterReconected(arg_20_1.operation)

	return
end

function IslandCheaterTavernMainPage:OnCheaterEveryRoundStart(arg_21_1)
	for iter_21_0, iter_21_1 in ipairs(self.views) do
		iter_21_1:OnCheaterEveryRoundStart()
	end

	self.animation:Play("Anim_IslandCheaterTavernMainUI_in")
	self:RemoveEveryRondStartTimer()

	self.everyRondStartTimer = Timer.New(function()
		for iter_22_0, iter_22_1 in ipairs(self.views) do
			iter_22_1:OnCheaterEveryRoundStartDone(arg_21_1.operation)
		end

		return
	end, pg.gameset.bar_showcard_time.key_value, 1)

	self.everyRondStartTimer:Start()

	return
end

function IslandCheaterTavernMainPage:RemoveEveryRondStartTimer()
	if self.everyRondStartTimer then
		self.everyRondStartTimer:Stop()
	end

	return
end

function IslandCheaterTavernMainPage:OnInit()
	onButton(self, self.uicloseBtn, function()
		self:OnClickCloseBtn()

		return
	end, SFX_PANEL)
	onButton(self, self.uiSenderPanel, function()
		self:emit(BaseUI.ON_ADD_SUBLAYER, Context.New({
			viewComponent = PlayRoomNotificationLayer,
			mediator = PlayRoomNotificationMediator,
			data = {
				inRoom = true
			}
		}))

		return
	end, SFX_PANEL)
	onButton(self, self.uiHelpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.island_help_bar.tip
		})

		return
	end, SFX_PANEL)

	self.animation = self.uiAdapt:GetComponent(typeof(Animation))

	return
end

function IslandCheaterTavernMainPage:OnShow(arg_28_1, arg_28_2)
	self.isFinish = false

	self:CreateViews()
	self:GetSubView(IslandCheaterTavernInGamingView):SetActiveState(false)
	self:GetSubView(IslandCheaterTavernStartGameView):SetActiveState(false)
	self:Flush()
	self:RefreshMessage()

	for iter_28_0, iter_28_1 in ipairs(self.views) do
		iter_28_1:Init()
	end

	return
end

function IslandCheaterTavernMainPage:Flush()
	return
end

function IslandCheaterTavernMainPage:OnDestroy()
	self:OnHide()
	IslandCheaterTavernMainPage.super.OnDestroy(self)

	return
end

function IslandCheaterTavernMainPage:OnHide()
	self:GetIsland():GetCheaterTavernAgency():SetUILoadOver(false)
	self:RemoveEveryRondStartTimer()

	for iter_31_0, iter_31_1 in ipairs(self.views) do
		iter_31_1:Hide()
	end

	return
end

function IslandCheaterTavernMainPage:RefreshMessage()
	self:GetMessages()

	local var_32_0 = self.displays

	setActive(self.uiChatItemGo, #self.displays > 0)

	if #var_32_0 <= 0 then
		return
	end

	local var_32_1 = var_32_0[#var_32_0]

	self.uiChannelImage.sprite = GetSpriteFromAtlas("channel", ChatConst.GetChannelSprite(var_32_0[#var_32_0].type) .. "_mel")

	local var_32_2 = self.uiChatText:GetComponent("RichText")

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
		var_32_2.text = self:MatchEmoji(var_32_2, var_32_1)
	end

	return
end

function IslandCheaterTavernMainPage:MatchEmoji(arg_33_1, arg_33_2)
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

function IslandCheaterTavernMainPage:GetMessages()
	self.displays = {}

	_.each(getProxy(ChatProxy):getRawData(), function(arg_36_0)
		self:InsertMsg(self.displays, arg_36_0)

		return
	end)

	local var_35_0 = getProxy(GuildProxy)

	if var_35_0:getRawData() then
		_.each(var_35_0:getChatMsgs(), function(arg_37_0)
			self:InsertMsg(self.displays, arg_37_0)

			return
		end)
	end

	_.each(getProxy(FriendProxy):getCacheMsgList(), function(arg_38_0)
		self:InsertMsg(self.displays, arg_38_0)

		return
	end)
	_.each(getProxy(PlayRoomProxy):GetChatMsgs(), function(arg_39_0)
		self:InsertMsg(self.displays, arg_39_0)

		return
	end)
	table.sort(self.displays, function(arg_40_0, arg_40_1)
		return arg_40_0.timestamp < arg_40_1.timestamp
	end)

	return
end

function IslandCheaterTavernMainPage:InsertMsg(arg_41_1, arg_41_2)
	if getProxy(FriendProxy):isInBlackList(arg_41_2.playerId) then
		return
	end

	if arg_41_2.player and arg_41_2.content then
		table.insert(arg_41_1, arg_41_2)
	end

	return
end

function IslandCheaterTavernMainPage:OnClickCloseBtn()
	local var_42_0 = {}

	if not self.isFinish then
		if getProxy(PlayRoomProxy):GetRoomData().roomType == PlayRoomConst.PLAY_ROOM_TYPE.MATCH then
			table.insert(var_42_0, function(arg_43_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("bar_tips_game6"),
					onYes = arg_43_0
				})

				return
			end)
		else
			table.insert(var_42_0, function(arg_44_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("bar_tips_game7"),
					onYes = arg_44_0
				})

				return
			end)
		end
	end

	seriesAsync(var_42_0, function()
		self:Hide()
		self:emit(IslandMediator.PLAY_ROOM_MATCH_STOP)
		getProxy(PlayRoomProxy):SetPlayingGameState(false)
		IslandCheaterTavernRecordTools.RecordResult(IslandCheaterTavernRecordTools.LEAVE)

		return
	end)

	return
end

function IslandCheaterTavernMainPage:OnPressBack()
	self:OnClickCloseBtn()

	return
end

return IslandCheaterTavernMainPage

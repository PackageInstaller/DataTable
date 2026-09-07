local PlayRoomInfoScene = class("PlayRoomInfoScene", import("view.base.BaseUI"))

function PlayRoomInfoScene:getUIName()
	return "IslandPlayRoomInfoUI"
end

function PlayRoomInfoScene:init()
	self:InitData()
	onButton(self, self.uiCloseBtn, function()
		self:OnClickCloseBtn()

		return
	end, SFX_PANEL)
	onButton(self, self.uiViewerBtn, function()
		self:emit(PlayRoomInfoMediator.ON_CLICK_VIEWER)

		return
	end, SFX_PANEL)
	onButton(self, self.uiReadyBtn, function()
		self:emit(PlayRoomInfoMediator.ON_CLICK_READY, {
			arg = 1
		})

		return
	end, SFX_PANEL)
	onButton(self, self.uiCancelReadyBtn, function()
		self:emit(PlayRoomInfoMediator.ON_CLICK_READY, {
			arg = 0
		})

		return
	end, SFX_PANEL)
	onButton(self, self.uiStartBtn, function()
		if not PlayRoomTools.CanStartGame() then
			return
		end

		local var_7_0 = {}

		if not PlayRoomTools.IsPlayerFull() then
			table.insert(var_7_0, function(arg_8_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("island_bar_quick_addbot"),
					onYes = arg_8_0
				})

				return
			end)
		end

		seriesAsync(var_7_0, function()
			self:emit(PlayRoomInfoMediator.ON_CLICK_START_GAME)

			return
		end)

		return
	end, SFX_PANEL)
	onButton(self, self.uiRoomSwitchBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("play_room_switch_tip"),
			onYes = function()
				self:emit(PlayRoomInfoMediator.ON_SWITCH_ROOM_TYPE)

				return
			end
		})

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
	onButton(self, self.uiAcceptBtn, function()
		self:emit(PlayRoomInfoMediator.ON_MATCH_CLICK_READY, {
			arg = 1
		})

		return
	end, SFX_PANEL)
	onButton(self, self.uiCopyBtn, function()
		UniPasteBoard.SetClipBoardString(self.playRoomProxy:GetRoomData().teamList[1])
		pg.TipsMgr.GetInstance():ShowTips(i18n("friend_id_copy_ok"))

		return
	end, SFX_PANEL)

	self.playerItemList = {}

	local var_2_0 = getProxy(PlayRoomProxy):GetRoomData()

	if var_2_0 then
		for iter_2_0 = 1, PlayRoomTools.GetMaxTeamCnt(var_2_0.gameType) do
			self.playerItemList[iter_2_0] = PlayRoomInfoPlayerItem.New(Object.Instantiate(self.uiPlayerItem, self.uiPlayerPanel), self)
		end
	end

	setText(self.uiReadyText, i18n("match_ui_room_ready1"))
	setText(self.uiCancelReadyText, i18n("match_ui_room_ready2"))
	setText(self.uiStartText, i18n("match_ui_room_startgame"))
	setText(self.uiAcceptText, i18n("match_ui_accept"))
	setText(self.uiMatchText, i18n("match_ui_matching"))
	setText(self.uiLoadText, i18n("match_ui_matching_loading"))

	return
end

function PlayRoomInfoScene:InitData()
	self.sceneRoomType = self.contextData.sceneRoomType

	return
end

function PlayRoomInfoScene:didEnter()
	self.playRoomProxy = getProxy(PlayRoomProxy)

	if self.playRoomProxy:GetRoomData() == nil then
		self.uiCloseBtn.onClick:Invoke()

		return
	end

	self:InitUIDisplay()

	if self.sceneRoomType == IslandCheaterTavernConst.SceneRoomType.CustomRoom then
		self:RefreshUI()
	elseif self.sceneRoomType == IslandCheaterTavernConst.SceneRoomType.MatchInfoRoom then
		self:RefreshMatchInfoUI()
	else
		self:RefreshLoadInfoUI()
	end

	self:RefreshMessage()

	return
end

function PlayRoomInfoScene:InitUIDisplay()
	local var_17_0 = self.sceneRoomType == IslandCheaterTavernConst.SceneRoomType.CustomRoom

	setActive(self.uiImage_2, self.sceneRoomType == IslandCheaterTavernConst.SceneRoomType.CustomRoom)
	setActive(self.uiAcceptPanel, not var_17_0)
	setActive(self.uiSenderPanel, var_17_0)
	setActive(self.uiBtnList, var_17_0)
	setActive(self.uiViewerBtn, false)
	setActive(self.uiloadPanel, false)

	self.isLoading = false

	if self.sceneRoomType == IslandCheaterTavernConst.SceneRoomType.CustomRoom then
		-- block empty
	elseif self.sceneRoomType == IslandCheaterTavernConst.SceneRoomType.MatchInfoRoom then
		setText(self.uiTitleText, i18n("match_ui_point_match"))
	end

	return
end

function PlayRoomInfoScene:willExit()
	for iter_18_0, iter_18_1 in ipairs(self.playerItemList) do
		iter_18_1:willExit()
	end

	self.playerItemList = nil

	self:StopLeanTween()
	self:StopLoadLeanTween()

	return
end

function PlayRoomInfoScene:RefreshUI()
	local var_19_0 = self.playRoomProxy:GetRoomData()
	local var_19_3 = PlayRoomTools.GetHostID()

	if var_19_0.roomType == PlayRoomConst.PLAY_ROOM_TYPE.PERSON then
		setText(self.uiTitleText, i18n("match_ui_room_filter6"))
	else
		setText(self.uiTitleText, i18n("match_ui_room_filter5"))
	end

	setText(self.uiIdText, var_19_3)
	setText(self.uiViewerText, i18n("play_room_viewer_tip", #var_19_0.viewerList, PlayRoomTools.GetMaxViewerCnt(var_19_0.gameType)))

	local var_19_4 = getProxy(PlayerProxy):getPlayerId()
	local var_19_5 = var_19_3 == var_19_4

	setActive(self.uiStartBtn, var_19_3 == var_19_4)
	setActive(self.uiRoomSwitchBtn, var_19_5)

	local var_19_6 = PlayRoomTools.IsViewer()

	setActive(self.uiBtnList, not var_19_6)

	if not var_19_6 then
		local var_19_7 = table.contains(var_19_0.readyList, var_19_4)

		setActive(self.uiReadyBtn, not var_19_7 and not var_19_5)
		setActive(self.uiCancelReadyBtn, var_19_7 and not var_19_5)
	end

	self:RefreshPlayerList()
	setGray(self.uiStartBtn, not PlayRoomTools.CanStartGame(), true)

	return
end

function PlayRoomInfoScene:RefreshPlayerList()
	local var_20_0 = self.playRoomProxy:GetRoomData()
	local var_20_1 = getProxy(PlayerProxy):getPlayerId()

	for iter_20_0, iter_20_1 in ipairs(self.playerItemList) do
		if var_20_0.teamPosList[iter_20_0] then
			iter_20_1:didEnter(var_20_0.playerDataList[var_20_0.teamPosList[iter_20_0][1]], PlayRoomTools.GetHostID(), self.sceneRoomType, (table.contains(var_20_0.readyList, var_20_1)))
		end
	end

	return
end

function PlayRoomInfoScene:OnClickCloseBtn()
	if self.isLoading then
		return
	end

	if self.sceneRoomType == IslandCheaterTavernConst.SceneRoomType.MatchInfoRoom then
		self:emit(PlayRoomInfoMediator.ON_MATCH_CLICK_READY, {
			arg = 0
		})
	end

	self:emit(PlayRoomInfoMediator.ON_CLICK_CLOSE, {
		sceneRoomType = self.sceneRoomType
	})

	return
end

function PlayRoomInfoScene:closeView()
	self.contextData.onClose()

	return
end

function PlayRoomInfoScene:RefreshMatchInfoUI()
	self:RefreshMatchInfoPlayerList()

	local var_23_0 = self.playRoomProxy:GetMatchRoomData()

	if not var_23_0 then
		return
	end

	if table.contains(var_23_0.readyList, (getProxy(PlayerProxy):getPlayerId())) then
		self:StopLeanTween()
		self:ShowTimePanel(false)
	else
		self:ShowTimePanel(true)
		self:StartLeanTween(pg.TimeMgr.GetInstance():GetServerTime(), self.playRoomProxy:GetMatchRoomData().endTimestamp)
	end

	setActive(self.uiRoomSwitchBtn, false)

	return
end

function PlayRoomInfoScene:RefreshMatchInfoPlayerList()
	local var_24_0 = self.playRoomProxy:GetMatchRoomData()

	if not var_24_0 then
		return
	end

	local var_24_1 = var_24_0.teamPosList
	local var_24_2 = getProxy(PlayerProxy):getPlayerId()

	for iter_24_0, iter_24_1 in ipairs(self.playerItemList) do
		iter_24_1:didEnter(var_24_0.playerDataList[var_24_1[iter_24_0][1]], nil, self.sceneRoomType, (table.contains(var_24_0.readyList, var_24_2)))
	end

	return
end

function PlayRoomInfoScene:StartLeanTween(arg_25_1, arg_25_2)
	self:StopLeanTween()

	if arg_25_2 <= arg_25_1 then
		return
	end

	LeanTween.value(self._go, (arg_25_2 - arg_25_1) / pg.gameset.match_refuseCD.key_value, 0, arg_25_2 - arg_25_1):setOnUpdate(System.Action_float(function(arg_26_0)
		self.uiSlider.value = arg_26_0

		local var_26_0 = arg_25_2 - pg.TimeMgr.GetInstance():GetServerTime()

		setText(self.uiTimeText, string.format("%02d:%02d", math.floor(var_26_0 / 60), var_26_0 % 60))

		return
	end)):setOnComplete(System.Action(function()
		self:OnClickCloseBtn()
		self:StopLeanTween()

		return
	end))

	return
end

function PlayRoomInfoScene:StopLeanTween()
	LeanTween.cancel(self._go)

	return
end

function PlayRoomInfoScene:StartLoadLeanTween(arg_29_1)
	self:StopLoadLeanTween()
	LeanTween.value(self._go, 0, 1, arg_29_1):setOnUpdate(System.Action_float(function(arg_30_0)
		self.uiLoadSlider.value = arg_30_0

		for iter_30_0, iter_30_1 in ipairs(self.playerItemList) do
			iter_30_1:RefreshSelfLoad(arg_30_0 * 100)
		end

		return
	end)):setOnComplete(System.Action(function()
		self:StopLoadLeanTween()

		return
	end))

	return
end

function PlayRoomInfoScene:StopLoadLeanTween()
	LeanTween.cancel(self._go)

	return
end

function PlayRoomInfoScene:ShowTimePanel(arg_33_1)
	setActive(self.uiAcceptPanel, arg_33_1)

	return
end

function PlayRoomInfoScene:RefreshLoadInfoUI()
	local var_34_0 = self.playRoomProxy:GetGameLoadData()

	if not var_34_0 then
		return
	end

	local var_34_1 = var_34_0.teamPosList
	local var_34_2 = table.contains(var_34_0.readyList, (getProxy(PlayerProxy):getPlayerId()))

	for iter_34_0, iter_34_1 in ipairs(self.playerItemList) do
		iter_34_1:didEnter(var_34_0.playerDataList[var_34_1[iter_34_0][1]], nil, self.sceneRoomType, var_34_2, var_34_0.loadList[var_34_1[iter_34_0][1]])
	end

	setActive(self.uiSenderPanel, false)
	setActive(self.uiBtnList, false)
	self:StartLoadLeanTween(2)

	return
end

function PlayRoomInfoScene:EnterLoadInfoUI()
	self.uiLoadSlider.value = 0

	setActive(self.uiloadPanel, true)

	self.isLoading = true

	self:RefreshLoadInfoUI()

	return
end

function PlayRoomInfoScene:RefreshMessage()
	self:GetMessages()

	local var_36_0 = self.displays

	setActive(self.uiChatItemGo, #self.displays > 0)

	if #var_36_0 <= 0 then
		return
	end

	local var_36_1 = var_36_0[#var_36_0]

	self.uiChannelImage.sprite = GetSpriteFromAtlas("channel", ChatConst.GetChannelSprite(var_36_0[#var_36_0].type) .. "_mel")

	local var_36_2 = self.uiChatText:GetComponent("RichText")

	if var_36_1.type == ChatConst.ChannelPublic then
		var_36_2.supportRichText = true

		ChatProxy.InjectPublic(var_36_2, var_36_1, true)
	elseif var_36_1:IsWorldBossNotify() then
		var_36_2.supportRichText = true

		local var_36_3 = var_36_1.args.bossName
		local var_36_4 = GetPerceptualSize(var_36_1.args.playerName .. var_36_1.args.bossName) - 18

		if var_36_4 > 0 then
			var_36_3 = shortenString(var_36_3, GetPerceptualSize(var_36_3) - var_36_4)
		end

		var_36_2.text = i18n("ad_4", var_36_1.args.supportType, var_36_1.args.playerName, var_36_3, var_36_1.args.level)
	else
		var_36_2.supportRichText = var_36_1.emojiId ~= nil
		var_36_2.text = self:MatchEmoji(var_36_2, var_36_1)
	end

	return
end

function PlayRoomInfoScene:MatchEmoji(arg_37_1, arg_37_2)
	local var_37_1 = arg_37_2.player.name .. ": " .. arg_37_2.content
	local var_37_2 = false

	for iter_37_0 in string.gmatch(arg_37_2.player.name .. ": " .. arg_37_2.content, ChatConst.EmojiIconCodeMatch) do
		if table.contains(pg.emoji_small_template.all, tonumber(iter_37_0)) then
			var_37_2 = true

			arg_37_1:AddSprite(iter_37_0, (LoadSprite("emoji/" .. pg.emoji_small_template[tonumber(iter_37_0)].pic .. "_small", nil)))
		end
	end

	if not arg_37_2.emojiId then
		var_37_1 = var_37_2 and shortenString(var_37_1, 16) or shortenString(var_37_1, 20)
	end

	return (string.gsub(var_37_1, ChatConst.EmojiIconCodeMatch, function(arg_38_0)
		if table.contains(pg.emoji_small_template.all, tonumber(arg_38_0)) then
			return string.format("<icon name=%s w=0.7 h=0.7/>", arg_38_0)
		end

		return
	end))
end

function PlayRoomInfoScene:GetMessages()
	self.displays = {}

	_.each(getProxy(ChatProxy):getRawData(), function(arg_40_0)
		self:InsertMsg(self.displays, arg_40_0)

		return
	end)

	local var_39_0 = getProxy(GuildProxy)

	if var_39_0:getRawData() then
		_.each(var_39_0:getChatMsgs(), function(arg_41_0)
			self:InsertMsg(self.displays, arg_41_0)

			return
		end)
	end

	_.each(getProxy(FriendProxy):getCacheMsgList(), function(arg_42_0)
		self:InsertMsg(self.displays, arg_42_0)

		return
	end)
	_.each(getProxy(PlayRoomProxy):GetChatMsgs(), function(arg_43_0)
		self:InsertMsg(self.displays, arg_43_0)

		return
	end)
	table.sort(self.displays, function(arg_44_0, arg_44_1)
		return arg_44_0.timestamp < arg_44_1.timestamp
	end)

	return
end

function PlayRoomInfoScene:InsertMsg(arg_45_1, arg_45_2)
	if getProxy(FriendProxy):isInBlackList(arg_45_2.playerId) then
		return
	end

	if arg_45_2.player and arg_45_2.content then
		table.insert(arg_45_1, arg_45_2)
	end

	return
end

function PlayRoomInfoScene:onBackPressed()
	self:OnClickCloseBtn()

	return
end

return PlayRoomInfoScene

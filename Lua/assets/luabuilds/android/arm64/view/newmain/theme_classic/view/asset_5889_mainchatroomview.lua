local MainChatRoomView = class("MainChatRoomView", import("...base.MainBaseView"))

function MainChatRoomView:Ctor(arg_1_1, arg_1_2)
	MainChatRoomView.super.Ctor(self, arg_1_1, arg_1_2)

	local var_1_0 = arg_1_1:Find("item")

	self.items = {
		var_1_0
	}
	self.tplInitPosY = var_1_0.anchoredPosition.y
	self.MAX_COUNT = 4
	self.enableBtn = arg_1_1:Find("enable")
	self.disableBtn = arg_1_1:Find("disable")
	self.btn = arg_1_1:GetComponent(typeof(Button))
	self.empty = arg_1_1:Find("empty"):GetComponent(typeof(Text))

	self:RegisterEvent(arg_1_2)

	return
end

function MainChatRoomView:RegisterEvent(arg_2_1)
	self:bind(GAME.REMOVE_LAYERS, function(arg_3_0, arg_3_1)
		self:OnRemoveLayer(arg_3_1.context)

		return
	end)
	self:bind(GAME.ANY_CHAT_MSG_UPDATE, function(arg_4_0)
		self:OnUpdateChatMsg()

		return
	end)

	self.hideChatFlag = PlayerPrefs.GetInt(HIDE_CHAT_FLAG)

	onButton(self, self._tf, function()
		if not self.hideChatFlag or self.hideChatFlag ~= 1 then
			self:GoChatView()
		end

		return
	end, SFX_MAIN)
	onButton(self, self.enableBtn, function()
		self:SwitchState()

		return
	end, SFX_MAIN)
	onButton(self, self.disableBtn, function()
		self:SwitchState()

		return
	end, SFX_MAIN)
	self:UpdateBtnState()

	return
end

function MainChatRoomView:GoChatView()
	self:emit(NewMainMediator.OPEN_CHATVIEW)

	return
end

function MainChatRoomView:SwitchState()
	local var_9_0 = self.hideChatFlag

	if self.hideChatFlag then
		if self.hideChatFlag ~= 1 then
			var_9_0 = false
		end

		local var_9_1
		local var_9_2

		do
			var_9_0 = true
			var_9_1 = pg.MsgboxMgr.GetInstance()
			var_9_2 = {}
		end
	end

	var_9_2.content = i18n(var_9_0 and "show_chat_warning" or "hide_chat_warning")

	function var_9_2.onYes()
		PlayerPrefs.SetInt(HIDE_CHAT_FLAG, var_9_0 and 0 or 1)

		self.hideChatFlag = PlayerPrefs.GetInt(HIDE_CHAT_FLAG)

		self:UpdateBtnState()

		return
	end

	var_9_1:ShowMsgBox(var_9_2)

	return
end

function MainChatRoomView:UpdateBtnState()
	local var_11_0 = self.hideChatFlag and self.hideChatFlag == 1

	setActive(self.enableBtn, var_11_0)
	setActive(self.disableBtn, not var_11_0)

	if var_11_0 then
		self:Clear()
	end

	self.btn.enabled = not var_11_0

	return
end

function MainChatRoomView:OnRemoveLayer(arg_12_1)
	if arg_12_1.mediator == NotificationMediator then
		self:Update()
	end

	return
end

function MainChatRoomView:OnUpdateChatMsg()
	self:Update()

	return
end

function MainChatRoomView:Init()
	self:Update()

	return
end

function MainChatRoomView:Refresh()
	self:Update()

	return
end

function MainChatRoomView:Update()
	if self.hideChatFlag and self.hideChatFlag == 1 then
		return
	end

	self:UpdateMessages((getProxy(ChatProxy):GetAllTypeChatMessages(self.MAX_COUNT)))

	return
end

function MainChatRoomView:InstantiateMsgTpl(arg_17_1)
	for iter_17_0 = #self.items + 1, arg_17_1 do
		table.insert(self.items, (Object.Instantiate(self.items[1], self.items[1].parent)))
	end

	for iter_17_1 = #self.items, arg_17_1 + 1, -1 do
		setActive(self.items[iter_17_1], false)
	end

	return
end

function MainChatRoomView:UpdateMessages(arg_18_1)
	self:InstantiateMsgTpl(#arg_18_1)

	for iter_18_0 = 1, #arg_18_1 do
		self.items[iter_18_0].anchoredPosition = Vector2(self.items[iter_18_0].anchoredPosition.x, self.tplInitPosY - (iter_18_0 - 1) * (self.items[iter_18_0].sizeDelta.y + 14))

		self:UpdateMessage(self.items[iter_18_0], arg_18_1[iter_18_0])
	end

	self.empty.text = PLATFORM_CODE == PLATFORM_JP and #arg_18_1 <= 0 and "ログはありません" or ""

	return
end

function MainChatRoomView:UpdateMessage(arg_19_1, arg_19_2)
	setActive(arg_19_1, true)

	findTF(arg_19_1, "channel"):GetComponent("Image").sprite = GetSpriteFromAtlas("channel", ChatConst.GetChannelSprite(arg_19_2.type) .. "_1920")

	local var_19_0 = findTF(arg_19_1, "text"):GetComponent("RichText")

	if arg_19_2.type == ChatConst.ChannelPublic then
		var_19_0.supportRichText = true

		ChatProxy.InjectPublic(var_19_0, arg_19_2, true)
	elseif arg_19_2:IsWorldBossNotify() then
		var_19_0.supportRichText = true

		local var_19_1 = arg_19_2.args.bossName
		local var_19_2 = GetPerceptualSize(arg_19_2.args.playerName .. arg_19_2.args.bossName) - 18

		if var_19_2 > 0 then
			var_19_1 = shortenString(var_19_1, GetPerceptualSize(var_19_1) - var_19_2)
		end

		var_19_0.text = i18n("ad_4", arg_19_2.args.supportType, arg_19_2.args.playerName, var_19_1, arg_19_2.args.level)
	else
		var_19_0.supportRichText = arg_19_2.emojiId ~= nil
		var_19_0.text = self:MatchEmoji(var_19_0, arg_19_2)
	end

	return
end

function MainChatRoomView:MatchEmoji(arg_20_1, arg_20_2)
	local var_20_1 = arg_20_2.player.name .. ": " .. arg_20_2.content
	local var_20_2 = false

	for iter_20_0 in string.gmatch(arg_20_2.player.name .. ": " .. arg_20_2.content, ChatConst.EmojiIconCodeMatch) do
		if table.contains(pg.emoji_small_template.all, tonumber(iter_20_0)) then
			var_20_2 = true

			arg_20_1:AddSprite(iter_20_0, (LoadSprite("emoji/" .. pg.emoji_small_template[tonumber(iter_20_0)].pic .. "_small", nil)))
		end
	end

	if not arg_20_2.emojiId then
		var_20_1 = var_20_2 and shortenString(var_20_1, 16) or shortenString(var_20_1, 20)
	end

	return (string.gsub(var_20_1, ChatConst.EmojiIconCodeMatch, function(arg_21_0)
		if table.contains(pg.emoji_small_template.all, tonumber(arg_21_0)) then
			return string.format("<icon name=%s w=0.7 h=0.7/>", arg_21_0)
		end

		return
	end))
end

function MainChatRoomView:Clear()
	for iter_22_0, iter_22_1 in ipairs(self.items) do
		setActive(iter_22_1, false)
	end

	return
end

function MainChatRoomView:GetDirection()
	return Vector2(1, 0)
end

return MainChatRoomView

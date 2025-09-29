-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/PlayerInfoLeaveMsgView.lua

module("logic.extensions.playerinfo.view.PlayerInfoLeaveMsgView", package.seeall)

local M = class("PlayerInfoLeaveMsgView", ViewComponent)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._btnReturn1 = self:getBtn("title_view_-878360263")
	self._imgPlayerMask = self:getImage("0&player_info_tips_copy_-1800821240")
	self._imgPlayerCard = self:getImage("0&player_info_tips_copy_-595620040")
	self._imgPlayerFrame = self:getImage("0&player_info_tips_copy_-832178768")
	self._txtPlayerName = self:getUIComponent("0&player_info_tips_-1766141246", UIComponentType.Text)
	self._txtUID = self:getUIComponent("0&player_info_tips_-381786658", UIComponentType.Text)
	self._txtPlayerLv = self:getUIComponent("0&player_info_tips_copy_328444276", UIComponentType.Text)
	self._txtPlayerBirthday = self:getUIComponent("0&player_info_tips_-1161882955", UIComponentType.Text)
	self._txtContent = self:getUIComponent("0&player_info_tips_-1718004023", UIComponentType.TextMeshProUGUI)
	self._goVoiceMark = self:getGo("0&player_info_tips_copy_-1809176887")
	self._btnPlayVoice = self:getBtn("0&player_info_tips_copy_-2025662989")
	self._goEmojiRoot = self:getGo("0&player_info_tips_copy_262193796")
	self._imgEmoji = self:getImage("0&4&chat_emoji_item1_-98144409")

	local goLeaveMsg = goutil.findChild(self.mainGO, "right/message_panel").gameObject

	self._msgView = Astral.SimpleLuaComponentContainer.Add(goLeaveMsg, LeaveMsgPanel)

	self._msgView:setClickSaveFunction(self._onClickSave, self)
	self._msgView:setClickResetFunction(self._onClickReset, self)
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnReturn1:AddClickListener(self._onClickBack, self)
	self._btnPlayVoice:AddClickListener(self._onClickVoice, self)
end

function M:unbindEvents()
	self._btnReturn1:RemoveClickListener()
	self._btnPlayVoice:RemoveClickListener()
end

function M:onEnter()
	self:setEvent(true)

	local info = self:getFirstParam() or {}

	if not info.playerCardInfo then
		printError("没有playerCardInfo")
		self:close()

		return
	end

	if info.playerCardInfo.userId ~= PlayerModel.instance:getId() then
		printError(string.format("userId[%s] 不等于玩家userId[%s]", info.playerCardInfo.userId, PlayerModel.instance:getId()))
		self:close()

		return
	end

	self._playerCardInfo = info.playerCardInfo

	self:refreshPlayerInfo()

	self._messageMO = LeaveMsgMO.New(self._playerCardInfo.sign)

	self._msgView:setContext(self._messageMO)
	self:refreshView()
end

function M:onExit()
	CriwareAudioPlayer.instance:stopAllVoiceSound()
	self:setEvent(false)
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(LeaveMsgEventType.ON_EDIT_ALL_PREVIEW, self._handleEditAllPreview, self)
		GlobalDispatcher:addEventListener(EventType.CHANGE_PLAYER_SIGN_SUC, self._handleChangePlayerSignSuc, self)
	else
		GlobalDispatcher:removeEventListener(LeaveMsgEventType.ON_EDIT_ALL_PREVIEW, self._handleEditAllPreview, self)
		GlobalDispatcher:removeEventListener(EventType.CHANGE_PLAYER_SIGN_SUC, self._handleChangePlayerSignSuc, self)
	end
end

function M:_handleEditAllPreview(e, isAllFinish, previewStr, emoji)
	self:refreshView()
end

function M:_handleChangePlayerSignSuc()
	self:_onClickBack()
end

function M:_onClickBack()
	ViewMgr.instance:close(ViewName.PlayerInfoLeaveMsgView, true, WindowType.WindowCloseReasonType.QuickCloseType, false)
end

function M:_onClickSave(leaveMsgMO)
	local emoji = leaveMsgMO:getEmoji()

	if emoji > 0 and not leaveMsgMO:getAllParagraphFinish(false) then
		local content = lang("tip_leave_msg_only_use_emoji")
		local dialog = Dialog.showMessage(lang("tip_title"), content)

		dialog:setConfirmListener(function()
			PlayerAgent.instance:sendChangeSignRequest(leaveMsgMO)
			dialog:forceClose()
		end, self)

		return
	end

	if leaveMsgMO:getAllParagraphFinish() then
		local content = lang("tip_player_leave_msg_confirm")
		local dialog = Dialog.showMessage(lang("tip_title"), content)

		dialog:setConfirmListener(function()
			PlayerAgent.instance:sendChangeSignRequest(leaveMsgMO)
			dialog:forceClose()
		end, self)

		return
	else
		local content = lang("tip_leave_msg_keep_empty_confirm")
		local dialog = Dialog.showMessage(lang("tip_title"), content)

		dialog:setConfirmListener(function()
			PlayerAgent.instance:sendChangeSignRequest(nil)
			dialog:forceClose()
		end, self)

		return
	end
end

function M:_onClickReset()
	local content = lang("tip_leave_msg_reset_confirm")
	local dialog = Dialog.showMessage(lang("tip_title"), content)

	dialog:setConfirmListener(function()
		local data

		self._messageMO = LeaveMsgMO.New(data)

		self._msgView:setContext(self._messageMO)
		self:refreshView()
	end, self)
end

function M:_onClickVoice()
	self._msgView:playVoice()
end

function M:refreshView()
	local contentStr
	local isVoice = self._msgView:getPageType() == LeaveMsgEnum.MsgType.Voice

	if isVoice then
		contentStr = "<line-indent=9%>" .. self._messageMO:getPreviewMsg()
	else
		contentStr = self._messageMO:getPreviewMsg(false, "#000000")
	end

	goutil.setActive(self._goVoiceMark, isVoice)

	self._txtContent.text = contentStr

	self:_updateEmoji(self._messageMO:getEmoji())
end

function M:_updateEmoji(emoji)
	if emoji and emoji > 0 then
		local cfg = ChatConfig.instance:getConfigByKey(ConfigName.ChatEmoji, emoji)

		if cfg then
			goutil.setActive(self._goEmojiRoot.gameObject, true)
			IconLoader.setSprite(self._imgEmoji, IconType.ChatEmoji, cfg.icon)
		else
			goutil.setActive(self._goEmojiRoot.gameObject, false)
		end
	else
		goutil.setActive(self._goEmojiRoot.gameObject, false)
	end
end

function M:refreshPlayerInfo()
	local playerInfo = self._playerCardInfo

	self._txtPlayerName.text = playerInfo.nickname
	self._txtUID.text = playerInfo.userId
	self._txtPlayerLv.text = self:_formatLevel(playerInfo.lv)
	self._txtPlayerBirthday.text = self:_formatBirthday(playerInfo.birthday)

	local itemCO = BackpackConfig.instance:getItemInfoByItemId(playerInfo.portrait)

	if itemCO then
		IconLoader.setSprite(self._imgPlayerMask, IconType.PlayerInfoMask, itemCO.icon)
	end

	for i, v in ipairs(playerInfo.displayCard or {}) do
		self:_setCardOrFrame(v)
	end
end

function M:_formatLevel(level)
	local a = math.floor(level / 10)
	local b = level % 10

	return string.format("%s-%s", a, b)
end

function M:_formatBirthday(timeStamp)
	local str

	timeStamp = tonumber(timeStamp)

	if timeStamp > 0 then
		local birthdayTb = TimeUtil.instance:formatUnixTime2Date(timeStamp / 1000)

		if birthdayTb then
			tempStr = string.format("%02d月%02d日", birthdayTb.month, birthdayTb.day)
		end
	else
		str = string.format("%s月%s日", "--", "--")
	end

	return str
end

function M:_setCardOrFrame(itemId)
	local itemCO = BackpackConfig.instance:getItemInfoByItemId(itemId)

	if itemCO then
		local iconType = self:_getIconType(itemId)

		if iconType == 1 then
			IconLoader.setSprite(self._imgPlayerCard, IconType.PlayerInfoCard, itemCO.icon2)
		else
			IconLoader.setSprite(self._imgPlayerFrame, IconType.PlayerInfoFrame, itemCO.icon2)
		end
	end
end

function M:_getIconType(itemId)
	local allCfgMap = BackpackConfig.instance:getItemsInfoByType(GameEnum.ItemTypeEnum.DisplayCard)

	for _, v in pairs(allCfgMap) do
		if v.id == itemId then
			return v.subType
		end
	end
end

return M

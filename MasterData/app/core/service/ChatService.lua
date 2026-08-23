local ChatService = class("ChatService")

function ChatService:ctor()
	self._bubbleSize = cc.size(0, 0)
	self._chatBtn = nil
	self._voiceChatList = {}
	self._isChatOpen = true
	self._sateRect = nil

	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FLUSH, self._onFlush, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_MODULE_ENTER, self._onModuleEnter, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_MODULE_EXIT, self._onModuleExit, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_CHAT_BROADCAST, self._recvBroadcast, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NOTICE, self._recvSysNotice, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NOTIFY_USER_VIEW_DETAIL, self._recvSysNotice, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MAIL_INFO, self._recvChatInfoPrivate, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CHAT_SHOW_START, self._recvChatShowStart, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CHAT_SHOW_END, self._recvChatShowEnd, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_STORY_END, self._onPlayStoryEnd, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_VOICE_SEND_SUCCESS, self._onVoiceChatAck, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_VOICE_RECEIVEMESSAGE, self._onVoiceChatReceive, self)
end

function ChatService:_onFlush()
	self:_createChatBubble()
end

function ChatService:_createChatBubble()
	if not self._chatBtn then
		self._sateRect = self._sateRect or cc.Director:getInstance():getSafeAreaRect()

		local var_3_0 = g.core.layer.LayerManager:getSysTipLayer()
		local var_3_1 = fgui.UIPackage:createObject("base_new", "BaseLoaderBtn")

		var_3_1:setProperties("icon", {
			icon = "ui://icon/btn_icon_liaotian"
		})
		var_3_1:getChild("icon"):setPivot(0.5, 0.5, true)
		var_3_0:addChild(var_3_1)

		self._chatBtn = var_3_1

		local var_3_2 = var_3_1:getSize()

		self._bubbleSize = var_3_2

		var_3_1:getChild("icon"):setPosition(var_3_2.width / 2, var_3_2.height / 2)
		var_3_1:setPivot(0.5, 0.5, true)
		var_3_1:setPosition(self._sateRect.x + var_3_2.width / 2, display.height - 250 + self._sateRect.y)
		var_3_1:setDraggable(true)
		var_3_1:setVisible(false)
		var_3_1:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
		var_3_1:addEventListener(fgui.UIEventType.TouchMove, handler(self, self._onTouchMove))
		var_3_1:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onTouchEnd))
		var_3_1:addClickListener(handler(self, self._onClickChat))
		self:_setChatRedPoint()
	end
end

function ChatService:_recvBroadcast()
	self:_setChatRedPoint()
end

function ChatService:_recvSysNotice()
	self:_setChatRedPoint()
end

function ChatService:_recvChatInfoPrivate()
	self:_setChatRedPoint()
end

function ChatService:_recvChatShowStart()
	self._isChatOpen = true

	self:_updateVisible()
end

function ChatService:_recvChatShowEnd()
	self._isChatOpen = false

	self:_updateVisible()
end

function ChatService:_setChatRedPoint()
	if self._chatBtn then
		-- block empty
	end
end

function ChatService:_onTouchBegin(arg_10_1)
	self:_onTouchMove(arg_10_1)
end

function ChatService:_onTouchMove(arg_11_1)
	local var_11_0 = arg_11_1:getInput():getTouch()

	if not var_11_0 then
		return
	end

	local var_11_1 = var_11_0:getLocation()

	self._sateRect = self._sateRect or cc.Director:getInstance():getSafeAreaRect()

	if var_11_1.x <= self._sateRect.x then
		var_11_1.x = self._sateRect.x
	end

	if var_11_1.x >= self._sateRect.x + self._sateRect.width then
		var_11_1.x = self._sateRect.x + self._sateRect.width
	end

	if var_11_1.y <= self._sateRect.y then
		var_11_1.y = self._sateRect.y
	end

	if var_11_1.y >= self._sateRect.y + self._sateRect.height then
		var_11_1.y = self._sateRect.y + self._sateRect.height
	end

	arg_11_1:getSender():setPosition(var_11_1.x, display.height - var_11_1.y)
end

function ChatService:_onTouchEnd(arg_12_1)
	local var_12_0 = arg_12_1:getInput():getTouch()

	if not var_12_0 then
		return
	end

	local var_12_1 = var_12_0:getLocation()

	self._sateRect = self._sateRect or cc.Director:getInstance():getSafeAreaRect()

	if var_12_1.y <= self._bubbleSize.height / 2 + self._sateRect.y then
		var_12_1.y = self._bubbleSize.height / 2 + self._sateRect.y
	elseif var_12_1.y >= self._sateRect.y + self._sateRect.height - self._bubbleSize.height / 2 then
		var_12_1.y = self._sateRect.y + self._sateRect.height - self._bubbleSize.height / 2
	end

	arg_12_1:getSender():runFGAction(fgui.FMoveTo:create(0.3, cc.p(self._sateRect.x + self._bubbleSize.width / 2, display.height - var_12_1.y)))
end

function ChatService:_onClickChat()
	if not g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.CHAT) then
		return
	end

	g.core.module.ModuleManager:pushModule(g.view.entrance.CHAT)
end

function ChatService:_onModuleEnter()
	self:_updateVisible()
end

function ChatService:_onModuleExit()
	self:_updateVisible()
end

function ChatService:_onPlayStoryEnd()
	if not self._chatBtn then
		return
	end

	self._chatBtn:runFGAction(fgui.FSequence:create(fgui.FDelayTime:create(0.3), fgui.FCallFunc:create(function()
		self:_updateVisible()
	end)))
end

function ChatService:_updateVisible()
	self:_setChatRedPoint()

	local var_18_0 = g.core.module.ModuleManager:getCurModule()

	if not var_18_0 then
		return
	end

	local var_18_1 = var_18_0.module

	if not var_18_0.module then
		return
	end

	if not self._chatBtn then
		return
	end

	if self._isChatOpen then
		if var_18_1.modType == g.view.entrance.POPUP or var_18_1 == g.view.entrance.BATTLE and g.core.model.User.chatData:getChatSetInfo()[6] == 1 or var_18_1 == g.view.entrance.STORY_ANIMATION or var_18_1 == g.view.entrance.STORY_DIALOG or var_18_1 == g.view.entrance.CAMPAIGN or var_18_1 == g.view.entrance.HOME or var_18_1 == g.view.entrance.GUILD or var_18_1 == g.view.entrance.DUNGEON or var_18_1 == g.view.entrance.LOGIN or var_18_1 == g.view.entrance.BIO_MAIN or var_18_1 == g.view.entrance.BIO_TEAM or var_18_1 == g.view.entrance.POWER_SAVE or var_18_1 == g.view.entrance.GUILDBOSS_BATTLE or var_18_1 == g.view.entrance.MYSTERYBOSS or var_18_1 == g.view.entrance.TEAMPVP_BATTLE then
			self._chatBtn:setVisible(false)
		else
			self._chatBtn:setVisible(g.core.common.ModuleUnlock:isModuleShow(g.core.const.ConstMgr.FUNCTION_TYPE.CHAT_FLOAT_QIPAO) and g.core.model.User.chatData:getChatSetInfo()[5] == 0)
		end
	else
		self._chatBtn:setVisible(false)
	end
end

function ChatService:_onVoiceChatAck(arg_19_1, arg_19_2)
	if arg_19_2.result and arg_19_2.result.data then
		local var_19_0, var_19_1, var_19_2 = g.core.model.User.chatData:getVoiceChatInfo(arg_19_2.receiveid)

		g.core.model.User.chatData:setVoicePath(tostring(arg_19_2.result.data.message_id), arg_19_2.result.data.path)

		if var_19_1 == g.core.const.ConstMgr.ChatConst.SINGLE then
			g.core.network.GameNetProxy:send_C2S_Mail_Send({
				content = arg_19_2.result.data.message_content,
				uid = arg_19_2.receiveid,
				name = var_19_2,
				sub_type = g.core.const.ConstMgr.MailConst.SUB_TYPE.VOICE,
				voice_path = arg_19_2.result.data.path,
				voice_time = arg_19_2.result.data.audio_time,
				voice_param = tostring(arg_19_2.result.data.message_id)
			})
		else
			if var_19_1 == g.core.const.ChatConst.ALL then
				var_19_1 = g.core.const.ChatConst.WORLD
			end

			local var_19_3 = 0

			if var_19_1 == g.core.const.ChatConst.TROOPS then
				var_19_3 = g.core.model.User.bioData:getTeamInfo().id
			end

			g.core.network.GameNetProxy:send_C2S_Chat({
				sub_type = 2,
				invite_id = 0,
				channel = var_19_1,
				content = arg_19_2.result.data.message_content,
				name = g.core.model.User:getName(),
				unique_id = (var_19_1 == g.core.const.ChatConst.ARMY and g.core.model.User.guildData:hasGuild() or nil) and g.core.model.User.guildData:getGuildId(),
				voice_path = arg_19_2.result.data.path,
				voice_time = arg_19_2.result.data.audio_time,
				voice_param = tostring(arg_19_2.result.data.message_id)
			})
		end
	end
end

function ChatService:_onVoiceChatReceive(arg_20_1, arg_20_2)
	if arg_20_2.result and arg_20_2.result.data then
		g.core.model.User.chatData:setVoicePath(tostring(arg_20_2.result.data.message_id), arg_20_2.result.data.path)
	end
end

return ChatService

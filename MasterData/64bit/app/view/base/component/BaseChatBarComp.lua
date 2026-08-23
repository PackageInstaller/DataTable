local var_0_0 = g.core.model.User.chatData
local var_0_1 = g.core.const.ConstMgr.ChatConst
local ChatCommon = require("app.view.module.chat.common.ChatCommon")
local var_0_3 = g.core.model.User.worldRedPacketData
local BaseChatBarComp = class("BaseChatBarComp", require("app.fairyGUI.base_new.UI_BaseChatBarComp"))

function BaseChatBarComp:ctor()
	self._isFirstEnter = true
	self._chatList = {}
	self._scheduler = nil
	self._chatRed = self.m_chatBtn:getChild("redPointComp")
	self._curChannel = var_0_1.WORLD

	if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.CROSS_FRIEND) then
		self._curChannel = var_0_1.AREA
	end

	self._clickCallBack = nil
	self._packetEffect = nil

	self:_init()
	self:_addListeners()
end

function BaseChatBarComp:_init()
	self._chatList = var_0_0:getChatFloatInfo()
end

function BaseChatBarComp:_addListeners()
	self.m_chatBtn:addClickListener(handler(self, self._onChatBtnClick))
	self:addClickListener(handler(self, self._onChatBtnClick))
end

function BaseChatBarComp:_onChatBtnClick()
	if g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.CHAT) then
		if self._clickCallBack then
			self._clickCallBack()

			self._clickCallBack = nil
		else
			g.core.module.ModuleManager:pushModule(g.view.entrance.CHAT, {
				type = self._curChannel
			})
		end
	end
end

function BaseChatBarComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_CHAT_BROADCAST, handler(self, self._recvBroadcast), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NOTICE, handler(self, self._recvSysNotice), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NOTIFY_USER_VIEW_DETAIL, handler(self, self._recvSysNotice2), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MAIL_INFO, handler(self, self._recvChatInfoPrivate), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_REQJOIN, handler(self, self._onRcvJoinGuild), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_BIOGRAPHY_JOINTEAM, handler(self, self._onRcvBioJoinTeam), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CLEAR_SOMEONE_CHAT, handler(self, self._recvBroadcast), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_MODULE_EXIT, handler(self, self._onModuleExit), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_WORLD_RED_PACKET_AWARD, handler(self, self._delayRefreshListView), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_WORLD_RED_PACKET_NOTIFY, handler(self, self._delayRefreshListView), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FRIEND_ADDBLACKLIST, handler(self, self._delayRefreshListView), self)
	self:_delayRefreshListView()
	self:updateRedPacket()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self._chatRed
	})
end

function BaseChatBarComp:_recvBroadcast(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	self:_delayRefreshListView()
end

function BaseChatBarComp:_recvSysNotice(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	if #var_0_0:getSingleSysNoticeData(arg_7_4) > 0 and self._chatList then
		self:_delayRefreshListView()
	end
end

function BaseChatBarComp:_recvSysNotice2(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	if self._chatList then
		self:_delayRefreshListView()
	end
end

function BaseChatBarComp:_recvChatInfoPrivate(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	if arg_9_4 and arg_9_4.mail_type == 3 then
		if not var_0_0:getFirstEnterFlag() then
			var_0_0:setChatFloatInfo((var_0_0:getSingleMailInfoContent(arg_9_4)))
			self:_delayRefreshListView()
		end

		var_0_0:setFirstEnterFlag()
	end
end

function BaseChatBarComp:_delayRefreshListView()
	self._scheduler = self._scheduler or self:newScheduleOnce(function()
		self._chatList = var_0_0:getChatFloatInfo()

		local var_11_0 = self._chatList[#self._chatList]

		if self._chatList[#self._chatList] and true then
			local var_11_1 = true

			self.m_channelText:setText((g.core.lang:get(109046, {
				channel = ChatCommon:getChannelTitle(var_11_0.channel)
			})))

			local var_11_2 = ""

			if var_11_0.special_id and var_11_0.special_id > 0 then
				var_11_2 = ChatCommon:getSpecialContent(var_11_0)
			elseif var_11_0.viewUser then
				var_11_1 = false
				var_11_2 = g.core.lang:get(109068, {
					name = var_11_0.viewUser.name
				})
			elseif var_11_0.user then
				local var_11_3 = ""
				local var_11_4 = var_11_0.look and tonumber(var_11_0.look)

				var_11_3 = var_11_4 and var_11_4 > 0 and g.core.lang:get(109049, {
					imgName = g.core.config.talk_show_info.get(var_11_4).name
				}) or var_11_0.content
				var_11_2 = g.core.lang:get(109047, {
					name = var_11_0.user.name,
					content = var_11_3
				})
			elseif var_11_0.look then
				local var_11_6 = var_11_0.look and tonumber(var_11_0.look)

				var_11_2 = var_11_6 and var_11_6 > 0 and g.core.lang:get(109049, {
					imgName = g.core.config.talk_show_info.get(var_11_6).name
				}) or var_11_0.content
			else
				var_11_2 = var_11_0.worldRedPacketId and var_0_3:getPacketSendText(var_11_0.worldRedPacketId) or var_11_0.content or ""
			end

			local var_11_7 = g.core.utils.String.splitString((g.core.utils.Black:filterBlack(var_11_2)))

			if var_11_0.special_id and var_11_0.special_id > 0 then
				var_11_7 = ChatCommon:getSpecialContent(var_11_0)
			end

			self.m_chatText:enableRich()
			self.m_chatText:setText(var_11_7, var_11_1, true)

			self._scheduler = nil
		end

		self:updateRedPacket()
	end, 0.2)
end

function BaseChatBarComp:updateRedPacket()
	if var_0_3:hasCanGetPacket() then
		self.m_hasRedPacketController:setSelectedIndex(1)

		if self._packetEffect == nil then
			self._packetEffect = self.m_effectNode:addEffectSpine({
				isLoop = true,
				remove = false,
				name = "eff_ui_worldRedPacket_icon",
				anim = "play"
			})
		end
	else
		self.m_hasRedPacketController:setSelectedIndex(0)
		self.m_effectNode:removeAllEffect()

		self._packetEffect = nil
	end
end

function BaseChatBarComp:_onRcvJoinGuild()
	local var_13_0 = g.core.module.ModuleManager:getCurModule()

	if not var_13_0 then
		return
	end

	if var_13_0.module ~= g.view.entrance.BIO_TEAM then
		g.core.module.ModuleManager:pushModule(g.view.entrance.BIO_TEAM)
	end
end

function BaseChatBarComp:_onRcvBioJoinTeam()
	if g.core.model.User.bioData:getTeamInfo().id > 0 then
		local var_14_0 = g.core.module.ModuleManager:getCurModule()

		if not var_14_0 then
			return
		end

		local var_14_1 = var_14_0.module

		if not var_14_0.module then
			return
		end

		if var_14_1 == g.view.entrance.BATTLE or var_14_1 == g.view.entrance.STORY_ANIMATION or var_14_1 == g.view.entrance.STORY_DIALOG or var_14_1 == g.view.entrance.CAMPAIGN or var_14_1 == g.view.entrance.HOME or var_14_1 == g.view.entrance.GUILD or var_14_1 == g.view.entrance.DUNGEON or var_14_1 == g.view.entrance.LOGIN then
			g.core.module.ModuleManager:pushModule(g.view.entrance.BIO_TEAM)
		end
	end
end

function BaseChatBarComp:_onModuleExit(arg_15_1, arg_15_2, arg_15_3)
	if arg_15_2 == g.core.event.enum.EVENT_MODULE_EXIT and arg_15_3 and arg_15_3.routeType == 1013 then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self._chatRed
		})
	end
end

function BaseChatBarComp:setCurChannel(arg_16_1)
	self._curChannel = arg_16_1
end

function BaseChatBarComp:setTouchCallBack(arg_17_1)
	self._curChannel = arg_17_1
end

function BaseChatBarComp:setOverClick(arg_18_1)
	self._clickCallBack = arg_18_1
end

return BaseChatBarComp

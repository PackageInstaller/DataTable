local var_0_0 = g.core.config.parameter_info
local var_0_1 = g.core.const.ConstMgr.PARAMETER_CONST
local var_0_2 = g.core.const.ConstMgr.ChatConst
local var_0_3 = g.core.model.User.chatData
local var_0_4 = g.core.common.Path
local var_0_5 = g.core.common.Goods
local ChatBottomComp = class("ChatBottomComp", require("app.fairyGUI.chat.UI_ChatBottomComp"))

function ChatBottomComp:ctor()
	self._emojiGroup = 0
	self._beginTouchPos = nil
	self._isCancelSend = false
	self._curChannel = var_0_2.WORLD
	self._content = ""
	self._user = nil
	self._forbidscheduleHandler = nil
	self._propNum = g.core.model.User.itemsData:getItemNumById(var_0_5.ITEM.TYPE_CHAT_HAOJIAO)
	self._imgRed = self.m_imgBtn:getChild("redPointComp")

	self:_initComp()
	self:_addListener()
end

function ChatBottomComp:onLoad()
	self:_addNetWorkListener()
	self:_recvChatCast()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self._imgRed
	})
end

function ChatBottomComp:_initComp()
	self:_initData()
	self:_initUI()
end

function ChatBottomComp:updateComp(arg_4_1)
	if arg_4_1 == nil then
		self._user = nil
	else
		self._user = (arg_4_1.id or arg_4_1.receiver) and arg_4_1 or arg_4_1.user
	end
end

function ChatBottomComp:setFaceVisible()
	self.m_showFaceController:setSelectedIndex(0)
	self:_setAllFaceGroupRecord()
end

function ChatBottomComp:setInput(arg_6_1)
	local var_6_0 = self.m_inputComp:getInputStr()

	if tonumber(var_0_3:isCrossServerChat(self._curChannel) and var_0_0.get(var_0_1.MINE_BARRAGE_WORLD_LIMIT).parameter or var_0_0.get(var_0_1.CHAT_WORD_LIMIT).parameter) < string.utf8len(var_6_0 .. arg_6_1) then
		return
	end

	self.m_inputComp:setInputStr(var_6_0 .. arg_6_1)
end

function ChatBottomComp:setChannel(arg_7_1)
	self._curChannel = arg_7_1

	if var_0_3:isCrossServerChat(self._curChannel) then
		local var_7_0 = tonumber(var_0_0.get(var_0_1.MINE_BARRAGE_WORLD_LIMIT).parameter)

		self.m_inputComp:setMaxLength(var_7_0)
		self.m_inputComp:setPrompt(g.core.lang:get(109023, {
			number = var_7_0
		}))
	else
		local var_7_1 = tonumber(var_0_0.get(var_0_1.CHAT_WORD_LIMIT).parameter)

		self.m_inputComp:setMaxLength(var_7_1)
		self.m_inputComp:setPrompt(g.core.lang:get(109023, {
			number = var_7_1
		}))
	end

	self:_recvChatCast()
end

function ChatBottomComp:onScheduleUpdate(arg_8_1, arg_8_2)
	local var_8_0 = tonumber(g.core.common.ServerTime:getTime())
	local var_8_1 = var_0_3:getLastSendConnectTime(self._curChannel)
	local var_8_2 = var_0_0.get(var_0_1.CHAT_CD_TIME).parameter

	if self._curChannel == var_0_2.WORLD or self._curChannel == var_0_2.AREA then
		var_8_2 = var_0_0.get(var_0_1.CHAT_WORLD_CD_TIME).parameter
	elseif self._curChannel == var_0_2.GUILD_WAR then
		var_8_2 = var_0_0.get(var_0_1.CHAT_GUILD_WAR_CD_LIMIT).parameter
	elseif self._curChannel == var_0_2.GVE then
		var_8_2 = g.core.config.parameter_info.get(var_0_1.CHAT_GVE_CD_LIMIT).parameter
	end

	local var_8_3 = self._curChannel == var_0_2.WRESTAREA or self._curChannel == var_0_2.WRESTALL

	var_8_2 = (self._curChannel == var_0_2.STORM or var_8_3) and 0

	if var_8_0 - var_8_1 >= tonumber((self._curChannel == var_0_2.STORM or var_8_3) and 0) then
		self.m_sendBtn:setState(1)
	else
		self.m_sendBtn:setState(0, var_8_1 + var_8_2 - var_8_0, var_8_2)
	end
end

function ChatBottomComp:onForbidScheduleUpdate(arg_9_1, arg_9_2)
	local var_9_0, var_9_1, var_9_2, var_9_3 = g.core.common.ServerTime:getLeftTimeParts((var_0_3:getForbidTime(self._curChannel)))
	local var_9_4 = ""

	var_9_4 = var_9_0 > 0 and string.format("%02d:%02d:%02d", var_9_0, var_9_1, var_9_2) or string.format("%02d:%02d:%02d", var_9_1, var_9_2, var_9_3)

	self.m_inputComp:setInputStr(string.format(g.core.lang:get(109024, {
		time = var_9_4
	})))

	if not var_0_3:isDuringForbid(self._curChannel) then
		self:_recvChatCast()
	end
end

function ChatBottomComp:receiveCompEvent(arg_10_1)
	local var_10_0 = {
		...
	}

	if arg_10_1 == "ChatFaceCell_click" then
		self:setFaceVisible()

		if var_0_3:isChatFaceGroupTimeExpire(var_10_0[1].groupId) then
			g.core.module.ModuleManager:tip(g.core.lang:get(109053))

			return
		end

		self._faceId = var_10_0[1].faceId
		self._emojiGroup = var_10_0[1].groupId

		self:_onClickSend()
	end
end

function ChatBottomComp:_initData()
	return
end

function ChatBottomComp:_initUI()
	self:addListen(self.m_faceComp)
	g.core.utils.Black:filterBlackOnInput(self.m_inputComp.m_inputText)
	g.core.utils.Tools.setInputTextFont(self.m_inputComp.m_inputText)

	if self.scheduleHandler then
		self:cancelSchedule(self.scheduleHandler)

		self.scheduleHandler = nil
	end

	self.scheduleHandler = self.scheduleHandler or self:newSchedule(function()
		self:onScheduleUpdate()
	end, 0.05)
end

function ChatBottomComp:_addListener()
	self.m_sendBtn:addClickListener(handler(self, self._onClickSend))
	self.m_imgBtn:addClickListener(handler(self, self._onClickFace))
	self.m_hideFace:addClickListener(handler(self, self.setFaceVisible))

	if config.SHOW_VOICE_CHAT_FUNCTION then
		self.m_inputComp:setClickCbk(handler(self, self._onInput))
	end
end

function ChatBottomComp:_addNetWorkListener()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CHAT_FORBID_NTF, handler(self, self._recvChatCast), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_CHAT_BROADCAST, handler(self, self._recvBroadcast), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MAIL_SEND, self._recvChatPrivate, self)
end

function ChatBottomComp:_isCanChat()
	if var_0_3:isDuringForbid(self._curChannel) then
		g.core.module.ModuleManager:tip(g.core.lang:get(109025))

		return false
	end

	if self._curChannel == var_0_2.WORLD or self._curChannel == var_0_2.SINGLE then
		if not g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.CHAT_WORLD) then
			return false
		end

		if var_0_3:getWorldLeftTimes() <= 0 then
			g.core.module.ModuleManager:tip(g.core.lang:get(109026))

			return false
		end
	end

	if self._curChannel == var_0_2.ARMY and not g.core.model.User.guildData:hasGuild() then
		g.core.module.ModuleManager:tip(g.core.lang:get(109027))

		return false
	end

	if self._curChannel == var_0_2.TROOPS and g.core.model.User.bioData:getTeamInfo().id == 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(109028))

		return false
	end

	if not self:_isCanConnect() then
		g.core.module.ModuleManager:tip(g.core.lang:get(109029))

		return false
	end

	if self._curChannel == var_0_2.SINGLE then
		if not g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.CHAT) then
			return false
		end

		if not self._user then
			g.core.module.ModuleManager:tip(g.core.lang:get(109030))

			return false
		end

		local var_16_0 = tonumber(self._user.receiver or self._user.id)

		if var_0_3:isInBlackList(var_16_0) then
			g.core.module.ModuleManager:tip(g.core.lang:get(109031))

			return false
		end

		local var_16_1 = var_0_3:getChatSetInfo()

		if #var_16_1 > 1 then
			if var_16_1[1] == 1 and not g.core.model.User.friendData:getFriendInfoById(var_16_0) then
				g.core.module.ModuleManager:tip(g.core.lang:get(109032))

				return false
			end
		end
	end

	return true
end

function ChatBottomComp:_onInput()
	self.m_inputComp:setInputStr("")
end

function ChatBottomComp:_isCanConnect()
	local var_18_0 = tonumber(g.core.common.ServerTime:getTime())
	local var_18_1 = var_0_3:getLastSendConnectTime(self._curChannel)
	local var_18_2 = var_0_0.get(var_0_1.CHAT_CD_TIME).parameter

	if self._curChannel == var_0_2.WORLD or self._curChannel == var_0_2.AREA then
		var_18_2 = var_0_0.get(var_0_1.CHAT_WORLD_CD_TIME).parameter
	elseif self._curChannel == var_0_2.ALLIANCE then
		var_18_2 = var_0_0.get(var_0_1.ALLIANCE_CHAT_CD).parameter
	end

	if var_18_0 - var_18_1 >= tonumber(var_18_2) then
		return true
	end

	return false
end

function ChatBottomComp:_updateInputUnlock(arg_19_1)
	self.m_inputComp:setTouchable(arg_19_1)
end

function ChatBottomComp:_onClickSend()
	local var_20_0 = g.core.lang:getNormalText((self.m_inputComp:getInputStr()))

	if var_0_3:isCrossServerChat(self._curChannel) then
		if var_0_3:isChatCostHorn() and self._propNum < 1 then
			self:_onNoProp()

			self._emojiGroup = 0
			self._faceId = 0

			return
		end

		if var_20_0 == "" and self._emojiGroup == 0 then
			g.core.module.ModuleManager:tip(g.core.lang:get(109033))

			return
		end

		if string.find(var_20_0, "|") or g.core.utils.Black:isMatchText(var_20_0) then
			g.core.module.ModuleManager:tip(g.core.lang:get(109034))

			return
		end

		if self:_isCanChat() then
			local var_20_1 = var_0_3:toSvrChatType(self._curChannel)

			if var_0_3:isChatCostHorn() and not var_0_3:getRecommand() then
				self:addPopup((require("app.view.base.pop.BaseConfirmPop").new({
					title = g.core.lang:get(109035),
					desc = g.core.lang:get(109036, {
						num = 1,
						resIcon = var_0_4:getIconByTypeValue(var_0_5.TYPE_ITEM, var_0_5.ITEM.TYPE_CHAT_HAOJIAO, true)
					}),
					onConfirm = handler(self, function()
						g.core.network.GameNetProxy:send_C2S_BulletScreenSend({
							type = var_20_1,
							content = self._emojiGroup > 0 and "" or var_20_0,
							look = self._faceId
						})

						self._faceId = 0
						self._emojiGroup = 0
					end),
					tip = {
						isChecked = false,
						txt = g.core.lang:get(1000)
					},
					onCheck = handler(self, function(arg_22_0, arg_22_1)
						var_0_3:setRecommand(arg_22_1)
					end)
				})))
			else
				g.core.network.GameNetProxy:send_C2S_BulletScreenSend({
					invite_id = 0,
					type = var_20_1,
					content = self._emojiGroup > 0 and "" or var_20_0,
					look = self._faceId,
					unique_id = (self._curChannel == var_0_2.TROOPS or nil) and g.core.model.User.bioData:getTeamInfo().id
				})

				self._faceId = 0
				self._emojiGroup = 0
			end
		end
	elseif self:_isCanChat() then
		var_20_0 = string.gsub(var_20_0, "\n", "")
		var_20_0 = string.gsub(var_20_0, "\r", "")

		if var_20_0 == "" and self._emojiGroup == 0 then
			g.core.module.ModuleManager:tip(g.core.lang:get(109033))

			return
		end

		if string.find(var_20_0, "|") then
			g.core.module.ModuleManager:tip(g.core.lang:get(109034))

			return
		end

		if string.len(var_20_0) > var_0_0.get(6004).parameter * 3 then
			g.core.module.ModuleManager:tip(g.core.lang:get(109037))

			return
		end

		if (function(arg_23_0)
			local var_23_0 = 0
			local var_23_1 = 0

			while true do
				var_23_0 = string.find(arg_23_0, "\n", var_23_0 + 1)

				if not var_23_0 then
					break
				end

				var_23_1 = var_23_1 + 1
			end

			return var_23_1
		end)(var_20_0) > 5 then
			g.core.module.ModuleManager:tip(g.core.lang:get(109038))

			return
		end

		if self._curChannel == var_0_2.SINGLE then
			local var_20_3 = self._user.receiver or self._user.id
			local var_20_4 = self._user.name

			if var_20_3 == 0 or var_20_4 == nil or var_20_4 == "" then
				return
			end

			g.core.network.GameNetProxy:send_C2S_Mail_Send({
				content = self._emojiGroup > 0 and "" or var_20_0,
				uid = var_20_3,
				name = var_20_4,
				look = self._faceId
			})

			self._faceId = 0
			self._emojiGroup = 0

			return
		end

		local var_20_5 = self._curChannel

		if self._curChannel == var_0_2.ALL then
			var_20_5 = var_0_2.WORLD
		end

		if var_20_0 and #var_20_0 > 0 and var_20_5 == var_0_2.WORLD then
			g.core.network.GameNetProxy:send_C2S_Action_Finish({
				id = 1104
			})
		end

		local var_20_6 = 0

		if var_20_5 == var_0_2.TROOPS then
			var_20_6 = g.core.model.User.bioData:getTeamInfo().id
		elseif var_20_5 == var_0_2.ARMY and g.core.model.User.guildData:hasGuild() then
			var_20_6 = g.core.model.User.guildData:getGuildId()
		end

		g.core.network.GameNetProxy:send_C2S_Chat({
			invite_id = 0,
			channel = var_20_5,
			content = self._emojiGroup > 0 and "" or var_20_0,
			name = g.core.model.User:getName(),
			unique_id = var_20_6,
			look = self._faceId
		})

		self._faceId = 0
		self._emojiGroup = 0
	else
		self._faceId = 0
		self._emojiGroup = 0
	end
end

function ChatBottomComp:_onClickFace()
	if var_0_3:isDuringForbid(self._curChannel) then
		g.core.module.ModuleManager:tip(g.core.lang:get(109025))

		return
	end

	self:_setAllFaceGroupRecord()

	if self.m_showFaceController:getSelectedIndex() == 1 then
		self.m_showFaceController:setSelectedIndex(0)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self._imgRed
		})
	else
		self.m_showFaceController:setSelectedIndex(1)
		self:updateFaceComp()
	end
end

function ChatBottomComp:_onNoProp()
	g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
		type = var_0_5.TYPE_ITEM,
		value = var_0_5.ITEM.TYPE_CHAT_HAOJIAO,
		size = self._propNum
	})
end

function ChatBottomComp:_onClickCancelFace()
	return
end

function ChatBottomComp:_recvBroadcast(arg_27_1, arg_27_2, arg_27_3, arg_27_4)
	if arg_27_4.user and arg_27_4.user.id == g.core.model.User:getId() then
		self.m_inputComp:setInputStr("")
	end

	if arg_27_4.user and math.uint64_equal(arg_27_4.user.id, g.core.model.User:getId()) then
		var_0_3:setLastSendConnectTime(self._curChannel)
	end
end

function ChatBottomComp:_recvChatCast(arg_28_1, arg_28_2, arg_28_3, arg_28_4)
	self.m_inputComp:setInputStr("")

	if var_0_3:isDuringForbid(self._curChannel) then
		self:_updateInputUnlock(false)
		self:onForbidScheduleUpdate()

		self._forbidscheduleHandler = self._forbidscheduleHandler or self:newSchedule(function()
			self:onForbidScheduleUpdate()
		end, 0.5)
	else
		if self._forbidscheduleHandler then
			self:cancelSchedule(self._forbidscheduleHandler)

			self._forbidscheduleHandler = nil
		end

		self:_updateInputUnlock(true)
	end
end

function ChatBottomComp:_recvChatPrivate()
	self.m_inputComp:setInputStr("")
end

function ChatBottomComp:updateFaceComp()
	self.m_faceComp:updateComp()
end

function ChatBottomComp:_setAllFaceGroupRecord()
	self.m_faceComp:setFaceGroupListRecord()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self._imgRed
	})
end

return ChatBottomComp

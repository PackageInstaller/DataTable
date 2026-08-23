local var_0_0 = g.core.model.User.worldRedPacketData
local var_0_1 = g.core.config.redpacket_info
local ChatMainPopCfg = require("app.view.module.chat.common.ChatMainPopCfg")
local WorldRedPacketOpenPop = require("app.view.module.worldRedPacket.view.WorldRedPacketOpenPop")
local WorldRedPacketShowPop = require("app.view.module.worldRedPacket.view.WorldRedPacketShowPop")
local var_0_5 = g.core.const.ConstMgr.ChatConst
local var_0_6 = g.core.model.User.chatData
local var_0_7 = g.core.event.EventManager
local var_0_8 = g.core.model.User.guildData
local var_0_9 = {
	COMMON = 0,
	SINGLE = 1
}
local var_0_10 = {
	NONE = 1,
	HAVE = 0,
	NO_GUILD = 2
}
local ChatMainPop = class("ChatMainPop", require("app.fairyGUI.chat.UI_ChatMainPop"), function()
	return fgui.GComponent:create({
		isFullScreen = true,
		pkgPath = "ui/chat/chat",
		resName = "ChatMainPop",
		pkgName = "chat"
	})
end)

function ChatMainPop:ctor(arg_2_1)
	self._channelList = nil
	self._chatList = nil

	if arg_2_1 then
		self._curChannel = arg_2_1.type or var_0_5.WORLD
	end

	self._userInfo = arg_2_1 and arg_2_1.user
	self._isHideSetBtn = arg_2_1 and arg_2_1.hideSet
	self._packetDetailData = nil
	self._topPosY = 0
	self._bottomPosY = 0

	self:_initComp()

	if arg_2_1 and arg_2_1.inputstr then
		self.m_bottomComp:setInput(arg_2_1.inputstr)
	end
end

function ChatMainPop:onLoad()
	self._topPosY = self.m_chatList:localToGlobal(cc.p(0, 0)).y
	self._bottomPosY = self._topPosY + self.m_chatList:getHeight()

	self:_addNetWorkListener()
	self:_requestLeftTimes()
	self:_updatePop()
	g.core.common.GlobalFunc.checkAvatarId()
	g.core.common.GlobalFunc.checkFrameId()
	self.m_enterTransition:play(handler(self, self._scrollChat))
end

function ChatMainPop:_initComp()
	self:_initData()
	self:_initUI()
end

function ChatMainPop:receiveCompEvent(arg_5_1)
	local var_5_0 = {
		...
	}

	if arg_5_1 == "ChatFriendCell_chat" and var_5_0[1] then
		self.m_showBottomController:setSelectedIndex(1)
		self.m_bottomComp:updateComp(var_5_0[1])
		self.m_tabList:getChildAt((self.m_tabList:itemIndexToChildIndex((self.m_tabList:getSelectedIndex())))):refreshRed()
	elseif arg_5_1 == "ChatPrivateComp_ChangeToFriend" then
		var_0_6:setPrivatePlayer(nil)
		self.m_showBottomController:setSelectedIndex(0)
		self.m_bottomComp:updateComp()
	elseif arg_5_1 == "ChatPrivateComp_DelChat" then
		self.m_tabList:getChildAt((self.m_tabList:itemIndexToChildIndex((self.m_tabList:getSelectedIndex())))):refreshRed()
	elseif arg_5_1 == "ChatCell_Goto_TeamBattleTeam" then
		self:_gotoTeamBattleTeamLayer()
	else
		return false
	end
end

function ChatMainPop:_scrollChat()
	self.m_chatList:getScrollPane():scrollBottom(true)
end

function ChatMainPop:_initData()
	self._channelList = {}

	local var_7_0, var_7_1 = var_0_6:getChatSetInfo()

	if not var_7_1 then
		g.core.network.GameNetProxy:send_C2S_GetUserConfig({})
	end

	for iter_7_0, iter_7_1 in pairs(ChatMainPopCfg.btnCfg) do
		if iter_7_1.isShow() then
			table.insert(self._channelList, iter_7_1)
		end
	end

	g.core.network.GameNetProxy:send_C2S_TalkShow_Get({})
end

function ChatMainPop:_initUI()
	self:addListen(self.m_privateComp)
	self:addListen(self.m_chatList)
	self.m_tabList:setIniter()
	self.m_tabList:setItemRenderer(handler(self, self._onTabRenderer))
	self.m_tabList:setNumItems(#self._channelList)
	self.m_chatList:setVirtual()
	self.m_chatList:doFairyBatching(false)
	self.m_chatList:setItemProvider(handler(self, self._onItemProvider))
	self.m_chatList:setItemRenderer(handler(self, self._onItemRenderer))
	self.m_setBtn:setVisible(not self._isHideSetBtn)
	self.m_jumpBtn:addClickListener(handler(self, self._onClickJumpPacketBtn))
	self.m_jumpBtn:setVisible(false)
	self.m_tabList:addClickListener(handler(self, self._onChangeChannel))
	self.m_closeBtn:addClickListener(handler(self, self._onClickClose))
	self.m_setBtn:addClickListener(handler(self, self._onClickSet))
	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onClose))
	self.m_chatList:addEventListener(fgui.UIEventType.ScrollEnd, handler(self, self.updatePacketBtn))
end

function ChatMainPop:_addNetWorkListener()
	var_0_7:addEventListener(g.core.event.enum.EVENT_NET_S2C_CHAT_BROADCAST, self._recvBroadcast, self)
	var_0_7:addEventListener(g.core.event.enum.EVENT_NET_S2C_NOTICE, self._recvSysNotice, self)
	var_0_7:addEventListener(g.core.event.enum.EVENT_NET_S2C_NOTIFY_USER_VIEW_DETAIL, self._recvSysNotice, self)
	var_0_7:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_REQJOIN, self._onRcvJoinGuild, self)
	var_0_7:addEventListener(g.core.event.enum.EVENT_NET_S2C_BIOGRAPHY_JOINTEAM, self._onRcvJoinBio, self)
	var_0_7:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_CHAT_SHARE, self._onGetChatShare, self)
	var_0_7:addEventListener(g.core.event.enum.EVENT_NET_S2C_GROUP_BATTLE_JOINROOM, self._onRcvJoinTeamPvp, self)
	var_0_7:addEventListener(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_JOINTEAM, self._onRcvJoinTeamBattle, self)
	var_0_7:addEventListener(g.core.event.enum.EVENT_MODULE_ENTER, handler(self, self._onModuleEnter), self)
	var_0_7:addEventListener(g.core.event.enum.EVENT_CLEAR_SOMEONE_CHAT, self._updateClearSomeChat, self)
	var_0_7:addEventListener(g.core.event.enum.EVENT_TRANSLATE_FINISH_NOTIFY, self._onTranslateFinish, self)
	var_0_7:addEventListener(g.core.event.enum.EVENT_NET_S2C_TALK_SHOW_GET, handler(self, self._onRecChatFaceInfo), self)
	var_0_7:addEventListener(g.core.event.enum.EVENT_NET_S2C_WORLD_RED_PACKET_DETAIL, handler(self, self._onGetPacketDetail), self)
	var_0_7:addEventListener(g.core.event.enum.EVENT_NET_S2C_WORLD_RED_PACKET_AWARD, handler(self, self._onGetPacketAward), self)
	var_0_7:addEventListener(g.core.event.enum.EVENT_NET_S2C_WORLD_RED_PACKET_NOTIFY, handler(self, self._onRecRedPacket), self)
	var_0_7:addEventListener(g.core.event.enum.EVENT_NET_S2C_WORLD_RED_PACKET_ADD, handler(self, self._onRecRedPacket), self)
	var_0_7:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, handler(self, self._onCrossDay), self)
	var_0_7:addEventListener(g.core.event.enum.EVENT_NET_S2C_BOUNTY_GETMONSTERINFO, handler(self, self._onBountyMonsterInfo), self)
	var_0_7:addEventListener(g.core.event.enum.EVENT_NET_S2C_ANNIVERSARY_GETSHAREJIGSAW, handler(self, self._onGetShareJigsaw), self)
end

function ChatMainPop:_updateClearSomeChat()
	self:_initData()
	self.m_tabList:setNumItems(#self._channelList)
	self:_updatePop()
end

function ChatMainPop:_onTranslateFinish()
	if self._chatList then
		self.m_chatList:setNumItems(#self._chatList)

		if self.m_chatList:getScrollPane():getPercY() > 0.9 then
			self.m_chatList:getScrollPane():scrollTop(true)
			self.m_chatList:getScrollPane():scrollBottom(true)
		end
	end
end

function ChatMainPop:_updatePop()
	local var_12_0 = 1

	for iter_12_0, iter_12_1 in pairs(self._channelList) do
		if iter_12_1.channel == self._curChannel then
			var_12_0 = iter_12_0

			break
		end
	end

	self.m_tabList:setSelectedIndex(var_12_0 - 1)
	self.m_tabList:scrollToView(var_12_0 - 1)
	self:_onChangeChannel()
end

function ChatMainPop:_onTabRenderer(arg_13_1, arg_13_2)
	if not self._channelList[arg_13_1 + 1] then
		return
	end

	arg_13_2:setTitle(g.core.lang:get(self._channelList[arg_13_1 + 1].title))
	arg_13_2:setRedId(self._channelList[arg_13_1 + 1].redId)
end

function ChatMainPop:_onItemRenderer(arg_14_1, arg_14_2)
	arg_14_2:updateCell({
		data = self._chatList[arg_14_1 + 1],
		isShowChannelType = self._curChannel == var_0_5.WORLD or self._curChannel == var_0_5.STORM,
		channel = self._curChannel
	})
end

function ChatMainPop:_onItemProvider(arg_15_1)
	if self._curChannel == var_0_5.SYSTEM then
		return "ui://chat/ChatMainCell"
	else
		if not self._chatList[arg_15_1 + 1] then
			return
		end

		if self._chatList[arg_15_1 + 1].showTime then
			return "ui://chat/ChatTimeCell"
		elseif self._chatList[arg_15_1 + 1].worldRedPacketId then
			if self._chatList[arg_15_1 + 1].isSelf then
				return "ui://chat/ChatRedPacketRightCell"
			else
				return "ui://chat/ChatRedPacketLeftCell"
			end
		elseif not self._chatList[arg_15_1 + 1].user then
			return "ui://chat/ChatMainCell"
		elseif self._chatList[arg_15_1 + 1].user.id == g.core.model.User:getId() then
			return "ui://chat/ChatRightCell"
		else
			return "ui://chat/ChatLeftCell"
		end
	end
end

function ChatMainPop:_changeSingleList()
	self.m_stateController:setSelectedIndex(var_0_9.SINGLE)

	local var_16_0 = self.m_privateComp:getChattingUid()

	if var_16_0 ~= nil then
		var_0_6:setPrivateRedPointPlayerList(var_16_0)
	end

	if self._userInfo then
		local var_16_1 = self._userInfo.receiver or self._userInfo.id

		var_0_6:savePrivate(var_16_1, var_0_6:getPrivateContent(var_16_1) or {})
		var_0_6:setPrivateRedPointPlayerList(var_16_1)
		self.m_privateComp:changeToChat(self._userInfo)
		self.m_bottomComp:setChannel(self._curChannel)
		self.m_bottomComp:updateComp(self._userInfo)

		self._userInfo = nil
	end

	self.m_privateComp:scrollToBottomWithOutAni()
	self.m_showBottomController:setSelectedIndex((self.m_privateComp.m_stateController:getSelectedIndex()))
end

function ChatMainPop:_changeChatList()
	self.m_stateController:setSelectedIndex(var_0_9.COMMON)

	if self._curChannel == var_0_5.SYSTEM then
		self.m_showBottomController:setSelectedIndex(0)

		self._chatList = var_0_6:getSysNoticeData() or {}

		if #self._chatList == 0 then
			self._chatList = {
				{
					content = g.core.lang:get(109021),
					channel = var_0_5.SYSTEM
				}
			}

			self.m_emptyTypeController:setSelectedIndex(var_0_10.NONE)
		else
			self.m_emptyTypeController:setSelectedIndex(var_0_10.HAVE)
		end

		self.m_chatList:setNumItems(#self._chatList)
		self.m_chatList:scrollToView(#self._chatList - 1, false)
	elseif self._curChannel == var_0_5.ARMY and not var_0_8:hasGuild() then
		self.m_showBottomController:setSelectedIndex(0)
		self.m_emptyTypeController:setSelectedIndex(var_0_10.NO_GUILD)
	else
		self.m_showBottomController:setSelectedIndex(1)

		self._chatList = var_0_6:getChatInfoByType(self._curChannel) or {}

		self.m_chatList:setNumItems(#self._chatList)

		local var_17_0

		if #self._chatList > 7 then
			self.m_chatList:scrollToView(#self._chatList - 8, false)

			if #self._chatList == 0 then
				var_17_0 = var_0_10.NONE or var_0_10.HAVE
			end
		end

		self.m_emptyTypeController:setSelectedIndex(var_17_0)
	end

	if self._curChannel == var_0_5.WORLD then
		self:newScheduleOnce(handler(self, self.updatePacketBtn), 0.2)
	else
		self:updatePacketBtn()
	end
end

function ChatMainPop:_checkModule()
	local var_18_0 = g.core.module.ModuleManager:getFirstFullModule()

	if not var_18_0 then
		return
	end

	local var_18_1 = var_18_0.module

	if not var_18_0.module then
		return
	end

	if var_18_1 ~= g.view.entrance.BATTLE and var_18_1 ~= g.view.entrance.STORY_ANIMATION and var_18_1 ~= g.view.entrance.STORY_DIALOG and var_18_1 ~= g.view.entrance.CAMPAIGN and var_18_1 ~= g.view.entrance.BIO_MAIN and var_18_1 ~= g.view.entrance.BIO_STAGE and var_18_1 ~= g.view.entrance.BIO_TEAM and var_18_1 ~= g.view.entrance.TEAM_PVP_TEAM_LAYER and var_18_1 ~= g.view.entrance.TEAM_BATTLE_TEAM_UP_LAYER then
		return true
	end

	return false
end

function ChatMainPop:_requestLeftTimes()
	if var_0_6:getWorldLeftTimes() == 0 then
		g.core.network.GameNetProxy:send_C2S_Chat_LeftTimes({})
	end
end

function ChatMainPop:_onChangeChannel()
	local var_20_0 = self.m_tabList:getSelectedIndex()
	local var_20_1 = self.m_tabList:getChildAt((self.m_tabList:itemIndexToChildIndex(var_20_0)))

	var_20_1:showEffect()

	self._curChannel = self._channelList[var_20_0 + 1].channel

	self.m_bottomComp:setChannel(self._curChannel)
	var_0_6:setChannelType(self._curChannel)
	var_0_6:setChannelFlag(self._curChannel, false)

	if self._curChannel == var_0_5.SINGLE then
		self:_changeSingleList()
		var_20_1:refreshRed()
	else
		var_0_6:setPrivatePlayer(nil)
		self:_changeChatList()
		self.m_chatList:getScrollPane():scrollBottom(true)
		var_0_6:setNoChannelChat(self._curChannel)
		var_20_1:refreshRed()
	end
end

function ChatMainPop:_onClickClose()
	if self._inClose then
		return
	end

	self._inClose = true

	self.m_backTransition:play(handler(self, self.onCloseAnimPlayEnd))
end

function ChatMainPop:onCloseAnimPlayEnd()
	local var_22_0 = self.m_privateComp:getChattingUid()

	if var_22_0 then
		local var_22_1 = tonumber(var_22_0)

		if var_22_1 > 0 then
			var_0_6:savePrivate(var_22_1, (var_0_6:getPrivateContent(var_22_1)))
			var_0_6:setPrivateRedPointPlayerList(var_22_1)
		end
	end

	var_0_6:setChannelType(0)
	var_0_6:setPrivatePlayer(nil)

	if g.core.battle.BattleProxy:isInBattle() then
		self:removeSelf()
	else
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	end

	var_0_7:dispatchEvent(g.core.event.enum.EVENT_MODULE_EXIT, false, g.view.entrance.CHAT)
end

function ChatMainPop:_onClickSet()
	self:addPopup(require("app.view.module.chat.view.ChatSettingPop").new())
end

function ChatMainPop:_onClose(arg_24_1)
	local var_24_0 = arg_24_1:getInput():getTouch()

	if var_24_0 then
		local var_24_1 = var_24_0:getLocation()

		if not self.m_chatBg:containPoint(var_24_1) and not self.m_closeBtn:containPoint(var_24_1) then
			self:_onClickClose()
		end
	end
end

function ChatMainPop:_recvBroadcast(arg_25_1, arg_25_2, arg_25_3)
	local var_25_0 = true

	self._chatList = var_0_6:getChatInfoByType(self._curChannel) or {}

	if self._curChannel == var_0_5.SYSTEM then
		self._chatList = var_0_6:getSysNoticeData()
	end

	local var_25_1 = #self._chatList

	self.m_chatList:setNumItems(#self._chatList)
	self.m_emptyTypeController:setSelectedIndex((var_25_1 == 0 or nil) and (var_0_10.NONE or var_0_10.HAVE))

	if arg_25_3.user and math.uint64_equal(arg_25_3.user.id, g.core.model.User:getId()) then
		self.m_chatList:getScrollPane():scrollBottom(true)

		if arg_25_3.channel == var_0_5.WORLD then
			var_0_6:addWorldLeftTimes(-1)
		end
	elseif var_25_0 then
		self.m_chatList:getScrollPane():scrollBottom(true)
	else
		var_0_6:setUnreadInfo(arg_25_3.channel)
	end
end

function ChatMainPop:_recvSysNotice()
	if self._curChannel == var_0_5.SYSTEM then
		self._chatList = var_0_6:getSysNoticeData()

		self.m_chatList:setNumItems(#self._chatList)
		self.m_emptyTypeController:setSelectedIndex((#self._chatList == 0 or nil) and (var_0_10.NONE or var_0_10.HAVE))
		self.m_chatList:getScrollPane():scrollBottom(true)
	end
end

function ChatMainPop:_onRcvJoinGuild()
	g.core.module.ModuleManager:tip(g.core.lang:get(109022))
	self:_initData()
	self.m_tabList:setNumItems(#self._channelList)
end

function ChatMainPop:_onRcvJoinBio()
	if g.core.model.User.bioData:getTeamInfo().id > 0 and self:_checkModule() then
		g.core.module.ModuleManager:pushModule(g.view.entrance.BIO_TEAM)
	end
end

function ChatMainPop:_onGetChatShare(arg_29_1, arg_29_2, arg_29_3)
	if arg_29_3.share_info then
		if arg_29_3.share_info.share_type == g.core.network.proto.CST_PRESET_FORMATION then
			if arg_29_3.share_info.preset_formation_info then
				g.core.module.ModuleManager:pushModule(g.view.entrance.FORMATION_OTHER, {
					title = "",
					preFormationParam = arg_29_3.share_info.preset_formation_info
				})
			end
		else
			arg_29_3.share_info.assist = true

			g.core.module.ModuleManager:pushModule(g.view.entrance.BATTLE_SUMMARY, arg_29_3.share_info)
		end
	end
end

function ChatMainPop:_onRcvJoinTeamPvp()
	if g.core.model.User.teamPvpData:getTeamInfo().id > 0 and self:_checkModule() then
		g.core.module.ModuleManager:pushModule(g.view.entrance.TEAM_PVP_TEAM_LAYER)
	end
end

function ChatMainPop:_onRcvJoinTeamBattle()
	if g.core.model.User.teamBattleData:getTeamUpData():getMyTeamId() > 0 and self:_checkModule() then
		g.core.module.ModuleManager:pushModule(g.view.entrance.TEAM_BATTLE_TEAM_UP_LAYER)
	end
end

function ChatMainPop:_gotoTeamBattleTeamLayer()
	if self:_checkModule() then
		g.core.module.ModuleManager:pushModule(g.view.entrance.TEAM_BATTLE_TEAM_UP_LAYER)
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(427101))
	end
end

function ChatMainPop:_onModuleEnter(arg_33_1, arg_33_2, arg_33_3)
	local var_33_0 = arg_33_3 and arg_33_3.params

	if not (arg_33_3 and arg_33_3.params) then
		return
	end

	if var_33_0 and var_33_0.tag and (var_33_0 and var_33_0.tag) == g.core.const.ConstMgr.ShowConst.BUFF_CHOOSE then
		local var_33_1 = self.m_privateComp:getChattingUid()

		if var_33_1 and var_33_1 > 0 then
			var_0_6:savePrivate(var_33_1, (var_0_6:getPrivateContent(var_33_1)))
			var_0_6:setPrivateRedPointPlayerList(var_33_1)
		end

		var_0_6:setChannelType(0)
		var_0_6:setPrivatePlayer(nil)
		self:removeFromParent()
	end
end

function ChatMainPop:_onRecChatFaceInfo()
	if self.m_bottomComp.updateFaceComp then
		self.m_bottomComp:updateFaceComp()
	end
end

function ChatMainPop:_onCrossDay()
	if self._chatList then
		self.m_chatList:setNumItems(#self._chatList)
		self:updatePacketBtn()
	end
end

function ChatMainPop:_onRecRedPacket(arg_36_1, arg_36_2, arg_36_3, arg_36_4)
	if not arg_36_4.errorText and self._curChannel == var_0_5.WORLD then
		local var_36_0 = self.m_chatList:getScrollPane():isBottomMost()

		self._chatList = var_0_6:getChatInfoByType(self._curChannel) or {}

		self.m_chatList:setNumItems(#self._chatList)
		self.m_emptyTypeController:setSelectedIndex((#self._chatList == 0 or nil) and (var_0_10.NONE or var_0_10.HAVE))

		if var_36_0 then
			self.m_chatList:getScrollPane():scrollBottom(true)
		else
			var_0_6:setUnreadInfo(arg_36_4.channel)
		end

		self:updatePacketBtn()
	end
end

function ChatMainPop:_onGetPacketAward(arg_37_1, arg_37_2, arg_37_3, arg_37_4)
	if arg_37_4.errorAward then
		if self._packetDetailData ~= nil then
			g.core.module.ModuleManager:pushPopup(WorldRedPacketShowPop.new(self._packetDetailData), {
				touchDisappear = true
			})
		end
	else
		g.core.module.ModuleManager:pushPopup(WorldRedPacketOpenPop.new(arg_37_4.data))
	end

	if self._curChannel == var_0_5.WORLD then
		self.m_chatList:setNumItems(#self._chatList)
	end

	self:updatePacketBtn()
end

function ChatMainPop:_onGetPacketDetail(arg_38_1, arg_38_2, arg_38_3, arg_38_4)
	self._packetDetailData = arg_38_4.world_red_packet_detail

	local var_38_0 = false

	if not (self._packetDetailData.world_red_packet.self_pick_point and self._packetDetailData.world_red_packet.self_pick_point > 0) then
		local var_38_1 = var_0_1.get(self._packetDetailData.world_red_packet.base_id)

		if self._packetDetailData.world_red_packet.pick_num < var_38_1.limit_people and (g.core.model.User:isSelfById(self._packetDetailData.world_red_packet.from_user.id) or var_0_0:getLeftCount(var_38_1.get_limit) > 0) then
			var_38_0 = true
		end
	end

	if var_38_0 then
		g.core.network.GameNetProxy:send_C2S_WorldRedPacket_Award({
			id = self._packetDetailData.world_red_packet.id
		})
	else
		if self._curChannel == var_0_5.WORLD then
			self.m_chatList:setNumItems(#self._chatList)
		end

		g.core.module.ModuleManager:pushPopup(WorldRedPacketShowPop.new(self._packetDetailData), {
			touchDisappear = true
		})
	end
end

function ChatMainPop:_onBountyMonsterInfo(arg_39_1, arg_39_2, arg_39_3, arg_39_4)
	if arg_39_4 and arg_39_4.id then
		g.core.module.ModuleManager:pushModule(g.view.entrance.BOUNTY_SHARE, {
			shareType = arg_39_4.share_type,
			monsterId = arg_39_4.id,
			star = arg_39_4.monster.star
		})
	end
end

function ChatMainPop:_onGetShareJigsaw(arg_40_1, arg_40_2, arg_40_3, arg_40_4)
	if arg_40_4.awards then
		g.core.module.ModuleManager:awardSummary(arg_40_4.awards, true)
	end

	if self._chatList then
		self.m_chatList:setNumItems(#self._chatList)
		self:updatePacketBtn()
	end
end

function ChatMainPop:_onClickJumpPacketBtn()
	if not self._chatList then
		return
	end

	for iter_41_0, iter_41_1 in ipairs(self._chatList) do
		if iter_41_1.worldRedPacketId and var_0_0:canGetPacket(iter_41_1.worldRedPacketId) then
			self.m_chatList:scrollToView(iter_41_0 - 1, true)

			break
		end
	end

	self:updatePacketBtn()
end

function ChatMainPop:updatePacketBtn()
	if self._curChannel ~= var_0_5.WORLD then
		self.m_jumpBtn:setVisible(false)

		return
	end

	for iter_42_0, iter_42_1 in ipairs((self.m_chatList:getChildren())) do
		if iter_42_1.getPacketId and self:_isInListView(iter_42_1) and var_0_0:canGetPacket((iter_42_1:getPacketId())) then
			self.m_jumpBtn:setVisible(false)

			return
		end
	end

	local var_42_0 = 0

	for iter_42_2, iter_42_3 in ipairs(self._chatList) do
		if iter_42_3.worldRedPacketId and var_0_0:canGetPacket(iter_42_3.worldRedPacketId) then
			var_42_0 = iter_42_2
		end
	end

	self.m_jumpBtn:setVisible(var_42_0 ~= 0)
end

function ChatMainPop:_isInListView(arg_43_1)
	local var_43_0 = arg_43_1:localToGlobal(cc.p(0, 0)).y

	if var_43_0 < self._topPosY or var_43_0 + arg_43_1:getHeight() > self._bottomPosY then
		return false
	else
		return true
	end
end

return ChatMainPop

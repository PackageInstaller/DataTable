local AncientsTeamInvitePop = class("AncientsTeamInvitePop", require("app.fairyGUI.ancients.UI_AncientsTeamInvitePop"), function()
	return fgui.GComponent:create({
		pkgName = "ancients",
		resName = "AncientsTeamInvitePop",
		pkgPath = "ui/ancients/ancients"
	}, ...)
end)

function var_0_0:ctor()
	self:getView():center(true)
	self.m_List_user:setVirtual(self)
	self.m_List_user:setItemRenderer(handler(self, self._onRenderListUserCell))
	self.m_oneKeyCallBtn:addClickListener(handler(self, self._onClickOneKeyCall))
	self.m_tabController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onTabChange))

	self._tabIndex = 0
	self._friendArray = nil
	self._guildArray = nil
	self._allianceArray = nil
	self._finalUsers = {}
	self._isSendFriend = false
	self._isSendGuild = false
	self._isSendAlliance = false

	if g.core.model.User.ancientsData:isFinalState() then
		self.m_tab1:setTitle(g.core.lang:get(433379))
		self.m_tab2:setVisible(false)
		self.m_tab3:setVisible(false)
		self.m_tabController:setSelectedIndex(0)
	end
end

function var_0_0:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ANCIENT_INVITE, handler(self, self._onRcvInvite), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ANCIENT_GETUSERLIST, handler(self, self._onRcvGetUserList), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FRIEND_FRIENDLIST, handler(self, self._onRcvFriendList), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SNAPSHOT_ONLINEUSERS, handler(self, self._onRcvGetRightUsers), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ANCIENT_GETFINALUSERLIST, handler(self, self._onRcvGetFinalUserList), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, handler(self, self._onGetCommonSimpleUserSnapshot), self)
	self:_updateView()
end

function var_0_0:_onGetCommonSimpleUserSnapshot(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	self.m_List_user:setNumItems(#self._finalUsers)
end

function var_0_0:_onRcvGetFinalUserList(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	self._finalUsers = arg_5_4.users or {}

	if #self._finalUsers == 0 then
		self.m_is_emptyController:setSelectedIndex(1)
		self.m_Comp_empty:setTitle(g.core.lang:get(433394))

		return
	end

	self.m_is_emptyController:setSelectedIndex(0)

	local var_5_0 = {}

	for iter_5_0, iter_5_1 in ipairs(self._finalUsers) do
		table.insert(var_5_0, iter_5_1.user_id)
	end

	if g.core.utils.Tools.ancientsFunc.sendSimpleUserSnapshot(var_5_0) then
		self.m_List_user:setNumItems(#self._finalUsers)
	end
end

function var_0_0:_onRenderListUserCell(arg_6_1, arg_6_2)
	local var_6_0 = self.m_tabController:getSelectedIndex()

	if g.core.model.User.ancientsData:isFinalState() then
		if var_6_0 == 0 then
			arg_6_2:updateCell({
				snapshot = g.core.utils.Tools.ancientsFunc.getSnapshot(self._finalUsers[arg_6_1 + 1].user_id),
				simpleUser = self._finalUsers[arg_6_1 + 1] or {}
			})
		end
	else
		local var_6_1

		if var_6_0 == 0 then
			var_6_1 = self._friendArray[arg_6_1 + 1]
		elseif var_6_0 == 1 then
			var_6_1 = self._guildArray[arg_6_1 + 1]
		elseif var_6_0 == 2 then
			var_6_1 = self._allianceArray[arg_6_1 + 1]
		end

		if var_6_1 then
			arg_6_2:updateCell({
				snapshot = var_6_1,
				simpleUser = g.core.model.User.ancientsData:getSimpleUser(var_6_1.id) or {}
			})
		end
	end
end

function var_0_0:_updateView()
	if self._tabIndex == 0 then
		if g.core.model.User.ancientsData:isFinalState() then
			g.core.network.GameNetProxy:send_C2S_Ancient_GetFinalUserList({})
		elseif self._friendArray == nil then
			g.core.network.GameNetProxy:send_C2S_Friend_FriendList({})
		elseif #self._friendArray > 0 then
			if not self._isSendFriend then
				self:_sendGetUserList(self._tabIndex)

				self._isSendFriend = true
			else
				self.m_is_emptyController:setSelectedIndex(0)

				for iter_7_0, iter_7_1 in ipairs(self._friendArray) do
					if not g.core.model.User.ancientsData:getSimpleUser(iter_7_1.id) then
						table.removebyvalue(self._friendArray, iter_7_1)
					end
				end

				self.m_List_user:setNumItems(#self._friendArray)
			end
		else
			self.m_is_emptyController:setSelectedIndex(1)
			self.m_Comp_empty:setTitle(g.core.lang:get(433394))
		end
	elseif self._tabIndex == 1 then
		if self._guildArray == nil then
			g.core.network.GameNetProxy:send_C2S_Snapshot_OnlineUsers({
				tp = 2
			})
		elseif #self._guildArray > 0 then
			if not self._isSendGuild then
				self:_sendGetUserList(self._tabIndex)

				self._isSendGuild = true
			else
				self.m_is_emptyController:setSelectedIndex(0)

				for iter_7_2, iter_7_3 in ipairs(self._guildArray) do
					if not g.core.model.User.ancientsData:getSimpleUser(iter_7_3.id) then
						table.removebyvalue(self._guildArray, iter_7_3)
					end
				end

				self.m_List_user:setNumItems(#self._guildArray)
			end
		else
			self.m_is_emptyController:setSelectedIndex(1)
			self.m_Comp_empty:setTitle(g.core.lang:get(433394))
		end
	elseif self._tabIndex == 2 then
		if self._allianceArray == nil then
			g.core.network.GameNetProxy:send_C2S_Snapshot_OnlineUsers({
				tp = 1
			})
		elseif #self._allianceArray > 0 then
			if not self._isSendAlliance then
				self:_sendGetUserList(self._tabIndex)

				self._isSendAlliance = true
			else
				self.m_is_emptyController:setSelectedIndex(0)

				for iter_7_4, iter_7_5 in ipairs(self._allianceArray) do
					if not g.core.model.User.ancientsData:getSimpleUser(iter_7_5.id) then
						table.removebyvalue(self._allianceArray, iter_7_5)
					end
				end

				self.m_List_user:setNumItems(#self._allianceArray)
			end
		else
			self.m_is_emptyController:setSelectedIndex(1)
			self.m_Comp_empty:setTitle(g.core.lang:get(433394))
		end
	end
end

function var_0_0:_onTabChange()
	local var_8_0 = self.m_tabController:getSelectedIndex()

	if var_8_0 == self._tabIndex then
		return
	end

	self._tabIndex = var_8_0

	self:_updateView()
end

function var_0_0:_onRcvInvite(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	self:_updateView()
end

function var_0_0:_onRcvGetUserList(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	self:_updateView()
end

function var_0_0:_onRcvFriendList(arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	self._friendArray = {}

	local var_11_0 = arg_11_4.friend or {}

	for iter_11_0 = 1, #var_11_0 do
		if var_11_0[iter_11_0].user.offline_time <= 0 then
			table.insert(self._friendArray, var_11_0[iter_11_0].user)
		end
	end

	self:_updateView()
end

function var_0_0:_onRcvGetRightUsers(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	if arg_12_4.tp == 2 then
		self._guildArray = {}

		local var_12_0 = arg_12_4.snapshots or {}

		for iter_12_0 = 1, #var_12_0 do
			if var_12_0[iter_12_0].id ~= g.core.model.User:getId() and var_12_0[iter_12_0].offline_time <= 0 then
				table.insert(self._guildArray, var_12_0[iter_12_0])
			end
		end

		self:_updateView()
	elseif arg_12_4.tp == 1 then
		self._allianceArray = {}

		local var_12_1 = arg_12_4.snapshots or {}

		for iter_12_1 = 1, #var_12_1 do
			if var_12_1[iter_12_1].id ~= g.core.model.User:getId() and var_12_1[iter_12_1].offline_time <= 0 then
				table.insert(self._allianceArray, var_12_1[iter_12_1])
			end
		end

		self:_updateView()
	end
end

function var_0_0:_sendGetUserList(arg_13_1)
	local var_13_0 = {}

	if arg_13_1 == 0 then
		var_13_0 = self._friendArray or {}
	elseif arg_13_1 == 1 then
		var_13_0 = self._guildArray or {}
	elseif arg_13_1 == 2 then
		var_13_0 = self._allianceArray or {}
	end

	local var_13_1 = {}

	for iter_13_0, iter_13_1 in ipairs(var_13_0) do
		table.insert(var_13_1, iter_13_1.id)
	end

	g.core.network.GameNetProxy:send_C2S_Ancient_GetUserList({
		user_ids = var_13_1
	})
end

function var_0_0._onClickOneKeyCall(arg_14_0)
	g.core.module.ModuleManager:pushPopup((require("app.view.base.infoPop.BaseChatCallPop").new({
		desc = g.core.lang:get(429020),
		funcId = g.core.const.ConstMgr.FUNCTION_TYPE.ANCIENTS,
		teamId = g.core.model.User.ancientsData:getTeam(g.core.const.ConstMgr.AncientsConst.GET_TEAM_TYPE.CURRENT_TEAM).team_id
	})))
end

return var_0_0

local var_0_0 = g.core.module.ModuleManager
local var_0_1 = g.core.model.User.friendData
local var_0_2 = g.core.model.User.playerInfoData
local var_0_3 = g.core.model.User
local PlayerInfoUserComp = class("PlayerInfoUserComp", require("app.fairyGUI.playerInfo.UI_PlayerInfoUserComp"))

function PlayerInfoUserComp:ctor()
	self._uid = 0
	self._playerInfo = nil

	self:initView()
end

function PlayerInfoUserComp:initView()
	self.m_lookRoomBtn:addClickListener(handler(self, self._onClickLookRoomBtn))
	self.m_battleBtn:addClickListener(handler(self, self._onClickBattleBtn))
	self.m_blackBtn:addClickListener(handler(self, self._onClickBlackBtn))
	self.m_friendBtn:addClickListener(handler(self, self._onClickFriendBtn))
	self.m_chatBtn:addClickListener(handler(self, self._onClickChatBtn))
end

function PlayerInfoUserComp:setDisableJump(arg_3_1)
	self._isDisableJump = arg_3_1

	if arg_3_1 == nil then
		self._isDisableJump = true
	end
end

function PlayerInfoUserComp:_onClickBattleBtn()
	if g.core.battle.BattleProxy:isInBattle() then
		var_0_0:tip(g.core.lang:get(1043))

		return
	end

	g.core.network.GameNetProxy:send_C2S_Friend_Duel({
		id = self._uid
	})
end

function PlayerInfoUserComp:_onClickBlackBtn()
	local var_5_0 = self._playerInfo.user

	if not self._playerInfo.user then
		return
	end

	local var_5_1 = var_0_1:getBlackList()

	if table.nums(var_5_1) == g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.FRIEND_BLACK_LIMIT).parameter then
		var_0_0:tip(g.core.lang:get(102515))

		return
	end

	for iter_5_0, iter_5_1 in pairs(var_5_1) do
		if iter_5_1:getFriendId() == self._playerInfo.user.id then
			var_0_0:tip(g.core.lang:get(102519))

			return
		end
	end

	var_0_0:pushPopup((require("app.view.base.pop.BaseConfirmPop").new({
		title = g.core.lang:get(107050),
		desc = g.core.lang:get(102516, {
			name = self._playerInfo.user.name
		}),
		confirmText = g.core.lang:get(1160),
		cancelText = g.core.lang:get(1037),
		onConfirm = function()
			g.core.network.GameNetProxy:send_C2S_Friend_AddBlackList({
				id = var_5_0.id
			})
		end
	})))
end

function PlayerInfoUserComp:_onClickFriendBtn()
	local var_7_0 = self._playerInfo.user

	if not self._playerInfo.user then
		return
	end

	if not var_0_1:isInFriendList(self._playerInfo.user.id) then
		if self._playerInfo.user.isBlack then
			var_0_1:onDelBlackSuc({
				id = self._playerInfo.user.id
			})
		end

		if var_0_1:isInAddFriendList(self._playerInfo.user.id) then
			var_0_0:tip(g.core.lang:get(102517))

			return
		end

		var_0_1:notifyAddFriendBySelf(self._playerInfo.user)
		g.core.network.GameNetProxy:send_C2S_Friend_AddFriend({
			user_id = self._playerInfo.user.id
		})
	else
		local var_7_1 = require("app.view.base.pop.BaseConfirmPop").new

		var_0_0:pushPopup((require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(107050),
			desc = g.core.lang:get(102514, {
				name = self._playerInfo.user.name
			}),
			confirmText = g.core.lang:get(1160),
			cancelText = g.core.lang:get(1037),
			onConfirm = function()
				g.core.network.GameNetProxy:send_C2S_Friend_DelFriend({
					id = var_7_0.id
				})
			end
		})))
	end
end

function PlayerInfoUserComp:_onClickChatBtn()
	if not g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.CHAT) then
		return
	end

	local var_9_0 = self._playerInfo.user

	if g.core.model.User.chatData:isInBlackList(self._uid) then
		g.core.module.ModuleManager:tip(g.core.lang:get(1042))

		return
	end

	if g.core.model.User:getId() == self._uid then
		g.core.module.ModuleManager:tip(g.core.lang:get(1044))

		return
	end

	g.core.model.User.chatData:setPrivateChatPInfo(var_9_0)
	g.core.module.ModuleManager:popAllPopupAndPush(g.view.entrance.CHAT, {
		type = g.core.const.ConstMgr.ChatConst.SINGLE,
		user = var_9_0
	})
end

function PlayerInfoUserComp:_onClickLookRoomBtn()
	if self._isDisableJump then
		var_0_0:tip(g.core.lang:get(2087))

		return
	end

	local var_10_0 = tonumber(g.core.common.ServerTime:getTime())

	if var_10_0 - var_0_1:getFriendRoomConnectTime() >= 3 then
		g.core.network.GameNetProxy:send_C2S_FurnitureRoom_FriendGetInfo({
			friend_id = self._uid
		})
		var_0_1:setFriendRoomConnectTime(var_10_0)
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(309184))
	end
end

function PlayerInfoUserComp:updateBtn(arg_11_1)
	self.m_friendBtn:getController("btnType"):setSelectedIndex(var_0_1:isInFriendList(self._uid) and 4 or 3)
end

function PlayerInfoUserComp:updatePlayerContent(arg_12_1, arg_12_2, arg_12_3)
	self._uid = arg_12_2
	self._playerInfo = arg_12_3

	if arg_12_1 then
		self.m_isSelfController:setSelectedIndex(1)
		self.m_userName:setText(var_0_3:getName(), false, true)
		self.m_levelText:setText(var_0_3:getLevel())
		self.m_userIcon:updateAsSelf()
		self.m_powerText:setText(var_0_3:getFightValue())

		local var_12_0 = var_0_3:getGuildName()

		if not var_12_0 or var_12_0 == "" then
			var_12_0 = g.core.lang:get(1012)
		end

		self.m_guildName:setText(var_12_0)
	else
		self.m_isSelfController:setSelectedIndex(0)

		local var_12_1 = var_0_2:getPlayerSnapShot()

		self.m_userName:setText(var_12_1.name or "", false, true)
		self.m_levelText:setText(var_12_1.level or 0)

		if var_12_1.id and var_12_1.id > 0 then
			self.m_userIcon:updateAsUser(var_12_1)
		end

		self.m_powerText:setText(var_12_1.fight_value)

		local var_12_2 = var_12_1.guild_name

		if not var_12_1.guild_name or var_12_2 == "" then
			var_12_2 = g.core.lang:get(1012)
		end

		self.m_guildName:setText(var_12_2)
		self.m_isCrossServerController:setSelectedIndex(0)

		if g.core.platform.ServerListProxy:isOtherServerUser(var_12_1.sid) then
			self.m_isCrossServerController:setSelectedIndex(1)
			self:_updateCrossServerView(var_12_1.server_name or "")
		end
	end
end

function PlayerInfoUserComp:_updateCrossServerView(arg_13_1)
	self.m_serverName:initRaceTextParams({
		pauseTime = 0.5,
		scrollDirection = 1,
		playMode = 2,
		moveType = 1,
		duration = 3,
		title = arg_13_1 or ""
	})

	local var_13_0 = self.m_serverName:getContainerSize()
	local var_13_1 = self.m_serverName:getTextSize()

	self.m_serverName:setTitleAlign("left")

	if var_13_1.width > var_13_0.width then
		self.m_serverName:setMoveDistance(var_13_1.width - var_13_0.width)
		self.m_serverName:setStartPos(cc.p(0, self.m_serverName:getTextPosition().y))
	end

	self.m_serverName:play()
end

return PlayerInfoUserComp

local var_0_0 = g.core.module.ModuleManager
local var_0_1 = g.core.model.User.friendData
local NewSlgTeamPlayerInfoUserComp = class("NewSlgTeamPlayerInfoUserComp", require("app.fairyGUI.newSlg.UI_NewSlgTeamPlayerInfoUserComp"))

function NewSlgTeamPlayerInfoUserComp:ctor()
	self._uid = 0
	self._playerInfo = nil

	self:initView()
end

function NewSlgTeamPlayerInfoUserComp:initView()
	self.m_blackBtn:addClickListener(handler(self, self._onClickBlackBtn))
	self.m_friendBtn:addClickListener(handler(self, self._onClickFriendBtn))
	self.m_chatBtn:addClickListener(handler(self, self._onClickChatBtn))
end

function NewSlgTeamPlayerInfoUserComp:updateAuthority(arg_3_1)
	self.m_powerText:setText(arg_3_1)
end

function NewSlgTeamPlayerInfoUserComp:_onClickBlackBtn()
	local var_4_0 = self._playerInfo

	if not self._playerInfo then
		return
	end

	local var_4_1 = var_0_1:getBlackList()

	if table.nums(var_4_1) == g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.FRIEND_BLACK_LIMIT).parameter then
		var_0_0:tip(g.core.lang:get(102515))

		return
	end

	for iter_4_0, iter_4_1 in pairs(var_4_1) do
		if iter_4_1:getFriendId() == self._playerInfo.id then
			var_0_0:tip(g.core.lang:get(102519))

			return
		end
	end

	var_0_0:pushPopup((require("app.view.base.pop.BaseConfirmPop").new({
		title = g.core.lang:get(107050),
		desc = g.core.lang:get(102516, {
			name = self._playerInfo.name
		}),
		confirmText = g.core.lang:get(1160),
		cancelText = g.core.lang:get(1037),
		onConfirm = function()
			g.core.network.GameNetProxy:send_C2S_Friend_AddBlackList({
				id = var_4_0.id
			})
		end
	})))
end

function NewSlgTeamPlayerInfoUserComp:_onClickFriendBtn()
	local var_6_0 = self._playerInfo

	if not self._playerInfo then
		return
	end

	if not var_0_1:isInFriendList(self._playerInfo.id) then
		if self._playerInfo.isBlack then
			var_0_1:onDelBlackSuc({
				id = self._playerInfo.id
			})
		end

		if var_0_1:isInAddFriendList(self._playerInfo.id) then
			var_0_0:tip(g.core.lang:get(102517))

			return
		end

		var_0_1:notifyAddFriendBySelf(self._playerInfo)
		g.core.network.GameNetProxy:send_C2S_Friend_AddFriend({
			user_id = self._playerInfo.id
		})
	else
		local var_6_1 = require("app.view.base.pop.BaseConfirmPop").new

		var_0_0:pushPopup((require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(107050),
			desc = g.core.lang:get(102514, {
				name = self._playerInfo.name
			}),
			confirmText = g.core.lang:get(1160),
			cancelText = g.core.lang:get(1037),
			onConfirm = function()
				g.core.network.GameNetProxy:send_C2S_Friend_DelFriend({
					id = var_6_0.id
				})
			end
		})))
	end
end

function NewSlgTeamPlayerInfoUserComp:_onClickChatBtn()
	if not g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.CHAT) then
		return
	end

	local var_8_0 = self._playerInfo

	if g.core.model.User.chatData:isInBlackList(self._uid) then
		g.core.module.ModuleManager:tip(g.core.lang:get(1042))

		return
	end

	if g.core.model.User:getId() == self._uid then
		g.core.module.ModuleManager:tip(g.core.lang:get(1044))

		return
	end

	g.core.model.User.chatData:setPrivateChatPInfo(var_8_0)
	g.core.module.ModuleManager:popAllPopupAndPush(g.view.entrance.CHAT, {
		type = g.core.const.ConstMgr.ChatConst.SINGLE,
		user = var_8_0
	})
end

function NewSlgTeamPlayerInfoUserComp:updateBtn()
	self.m_friendBtn:getController("btnType"):setSelectedIndex(var_0_1:isInFriendList(self._uid) and 4 or 3)
end

function NewSlgTeamPlayerInfoUserComp:updatePlayerContent(arg_10_1)
	self._uid = arg_10_1.id
	self._playerInfo = arg_10_1

	self.m_userName:setText(arg_10_1.name or "", false, true)
	self.m_levelText:setText(arg_10_1.level or 0)

	if arg_10_1.id and arg_10_1.id > 0 then
		self.m_userIcon:updateAsUser(arg_10_1)
	end

	local var_10_0 = arg_10_1.alliance_name

	if not arg_10_1.alliance_name or var_10_0 == "" then
		var_10_0 = g.core.lang:get(429536)
	end

	self.m_allianceName:setText(var_10_0)
	self:_updateCrossServerView(arg_10_1.server_name or "")
end

function NewSlgTeamPlayerInfoUserComp:_updateCrossServerView(arg_11_1)
	self.m_serverName:initRaceTextParams({
		scrollDirection = 1,
		moveType = 1,
		playMode = 2,
		pauseTime = 0.5,
		duration = 3,
		title = arg_11_1 or ""
	})

	local var_11_0 = self.m_serverName:getContainerSize()
	local var_11_1 = self.m_serverName:getTextSize()

	self.m_serverName:setTitleAlign("left")

	if var_11_1.width > var_11_0.width then
		self.m_serverName:setMoveDistance(var_11_1.width - var_11_0.width)
		self.m_serverName:setStartPos(cc.p(0, self.m_serverName:getTextPosition().y))
	end

	self.m_serverName:play()
end

return NewSlgTeamPlayerInfoUserComp

local var_0_0 = g.core.const.ConstMgr.FUNCTION_TYPE
local FriendControllerConst = require("app.view.module.friend.const.FriendControllerConst")
local var_0_2 = g.core.common.ModuleUnlock
local PressComp = require("app.view.module.recruit.view.comp.PressComp")
local var_0_4 = g.core.model.User.friendData
local FriendMainItem = class("FriendMainItem", require("app.fairyGUI.friend.UI_FriendMainItem"))
local var_0_6 = {
	[FriendControllerConst.TabType.FRIEND_LIST] = {
		funcName = "_updateFriendListContent",
		controlIdx = FriendControllerConst.ItemType.FRIEND_LIST,
		giftType = FriendControllerConst.GiftType.GIVE
	},
	[FriendControllerConst.TabType.TIP_LIST] = {
		funcName = "_updateFriendListContent",
		controlIdx = FriendControllerConst.ItemType.TIP_LIST,
		giftType = FriendControllerConst.GiftType.RECV
	},
	[FriendControllerConst.TabType.REQUEST_LIST] = {
		funcName = "_updateRequestListContent",
		controlIdx = FriendControllerConst.ItemType.REQUEST_LIST,
		giftType = FriendControllerConst.GiftType.RECV
	},
	[FriendControllerConst.TabType.BLACK_LIST] = {
		funcName = "_updateBlackListContent",
		controlIdx = FriendControllerConst.ItemType.BLACK_LIST,
		giftType = FriendControllerConst.GiftType.RECV
	}
}

function FriendMainItem:ctor()
	self._dataList = {}
	self._tabSelectIdx = -1

	self:_initUIListeners()
	self.getSharedTrans(self, "listCardAUiScaleIn", "CombineBagList", self)
end

function FriendMainItem:_initUIListeners()
	self.m_iconLoader:addClickListener(handler(self, self._onClickUserIcon))
	self.m_agreeBtn:addClickListener(handler(self, self._onConfirmRequest))
	self.m_refuseBtn:addClickListener(handler(self, self._onRefuseRequest))
	self.m_blackDelBtn:addClickListener(handler(self, self._onRemoveFromBlackList))
	self.m_giftLoader:addClickListener(handler(self, self._onGiftBtnClicked))
	self.m_addTipBtn:addClickListener(handler(self, self._onRequestAddFriend))
	self.m_homeBtn:addClickListener(handler(self, self._onFriendHomeBtn))
	self.m_chatBtn:addClickListener(handler(self, self._onChatBtn))
	self.m_infoPopBtn:addClickListener(handler(self, self._onShowClick))
end

function FriendMainItem:_onGiftBtnClicked()
	if self.m_forbiddenOprateController:getSelectedIndex() == 1 then
		g.core.module.ModuleManager:tip(g.core.lang:get(102532))

		return
	end

	if self._data:isCanReceived() then
		self:_onRecvGift()
	elseif not self._data:isGifted() then
		self:_onGiveGift()
	end
end

function FriendMainItem:_onGiveGift()
	self:dispatchCompEvent("FriendGiftBtnClick", {
		id = self._friendId,
		name = self._giftName
	})
end

function FriendMainItem:_onRecvGift()
	self:dispatchCompEvent("FriendReceiveBtnClick", {
		id = self._friendId
	})
end

function FriendMainItem:_onRequestAddFriend()
	self:dispatchCompEvent("ApplyAddFriend", {
		data = self._data,
		idx = self._idx
	})
end

function FriendMainItem:_onConfirmRequest()
	self:dispatchCompEvent("FriendConfirmBtnClick", {
		value = true,
		id = self._friendId
	})
end

function FriendMainItem:_onRefuseRequest()
	self:dispatchCompEvent("FriendConfirmBtnClick", {
		value = false,
		id = self._friendId
	})
end

function FriendMainItem:_onRemoveFromBlackList()
	self:dispatchCompEvent("BlackDelBtnClick", {
		id = self._friendId,
		name = self._friendName
	})
end

function FriendMainItem:_onShowClick()
	local var_10_0 = self.m_infoPopBtn:displayObject():convertToWorldSpace(cc.p(0, 0))

	self:dispatchCompEvent("ShowPlayerInfoView", {
		data = self._data:getBasicInfo(),
		pos = cc.p(var_10_0.x - 340, display.height - var_10_0.y - 110)
	})
end

function FriendMainItem:_onFriendHomeBtn()
	self:dispatchCompEvent("FriendHomeBtnClick", {
		id = self._friendId,
		name = self._friendName
	})
end

function FriendMainItem:_onChatBtn()
	self:dispatchCompEvent("FriendChatBtnClick", {
		id = self._friendId,
		user = self._data:getBasicInfo()
	})
end

function FriendMainItem:updateCell(arg_13_1, arg_13_2, arg_13_3)
	if arg_13_2 < 0 then
		arg_13_2 = FriendControllerConst.TabType.FRIEND_LIST
	end

	self._idx = arg_13_3
	self._data = arg_13_1
	self._friendId = arg_13_1:getFriendId()
	self._friendName = arg_13_1:getFriendName()

	local var_13_0 = var_0_6[arg_13_2]

	self.m_itemTypeController:setSelectedIndex(var_0_6[arg_13_2].controlIdx)

	local var_13_1 = FriendControllerConst.ItemType.TIP_LIST ~= var_13_0.controlIdx

	self.m_offlineStateTxt:setVisible(FriendControllerConst.ItemType.TIP_LIST ~= var_13_0.controlIdx)
	self.m_onlineStateTxt:setVisible(var_13_1)
	self:_updateBaseInfoUI(arg_13_1)
	self:_updateServerView(arg_13_1)
	self[var_13_0.funcName](self, arg_13_1)
end

function FriendMainItem:_updateServerView(arg_14_1)
	self._serverId = arg_14_1:getServerId()

	local var_14_0 = var_0_4:isCrossServerFriend(self._serverId)

	self.m_isCrossServerController:setSelectedIndex(var_14_0 and 1 or 0)

	if var_14_0 then
		self:_updateCrossServerView(arg_14_1:getServerName())
	end
end

function FriendMainItem:_updateCrossServerView(arg_15_1)
	self.m_serverNameTxt:initRaceTextParams({
		scrollDirection = 1,
		moveType = 1,
		playMode = 2,
		pauseTime = 0.5,
		duration = 3,
		title = arg_15_1 or ""
	})

	local var_15_0 = self.m_serverNameTxt:getContainerSize()
	local var_15_1 = self.m_serverNameTxt:getTextSize()

	self.m_serverNameTxt:setTitleAlign("left")

	if var_15_1.width > var_15_0.width then
		self.m_serverNameTxt:setMoveDistance(var_15_1.width - var_15_0.width)
		self.m_serverNameTxt:setStartPos(cc.p(0, self.m_serverNameTxt:getTextPosition().y))
	end

	self.m_serverNameTxt:play()
end

function FriendMainItem:_updateUserIcon(arg_16_1)
	local var_16_0 = g.core.config.knight_info.get(arg_16_1.base_id)
	local var_16_1 = g.core.config.knight_base_info.get(var_16_0.res_id).icon_id
	local var_16_2 = 0

	if arg_16_1.dress_id and arg_16_1.dress_id ~= 0 then
		var_16_2 = var_16_0.sex
		var_16_1 = g.core.config.knight_base_info.get(var_16_0.sex == 0 and g.core.config.dress_info.get(arg_16_1.dress_id).woman_res_id or g.core.config.dress_info.get(arg_16_1.dress_id).man_res_id).icon_id
	end

	if arg_16_1.avata_id and arg_16_1.avata_id > 0 then
		local var_16_4 = g.core.config.avata_info.get(arg_16_1.avata_id)
		local var_16_5 = string.split(var_16_4.res, ",")

		if #var_16_5 > 1 then
			local var_16_6 = {}

			for iter_16_0, iter_16_1 in ipairs(var_16_5) do
				local var_16_7 = string.split(iter_16_1, "_")

				var_16_6[var_16_7[1]] = var_16_7[2]
			end

			self.m_iconLoader:setURL(g.core.common.Path:getRoleHeadIcon(var_16_6[tostring(var_16_2)]))
		else
			self.m_iconLoader:setURL(g.core.common.Path:getRoleHeadIcon(var_16_4.res))
		end
	else
		self.m_iconLoader:setURL(g.core.common.Path:getKnightIconById(var_16_1))
	end
end

function FriendMainItem:_updateBaseInfoUI(arg_17_1)
	local var_17_0 = arg_17_1:getBasicInfo()

	self:_updateUserIcon(var_17_0)
	self.m_levelTxt:setText(g.core.lang:get(109619, {
		level = var_17_0.level
	}))
	self.m_nameTxt:setText(var_17_0.name, false, true)

	local var_17_1 = arg_17_1:getOfflineTime()
	local var_17_2 = FriendControllerConst.OnlineState.ONLINE

	if var_17_1 > 0 then
		var_17_2 = FriendControllerConst.OnlineState.OFFLINE

		local var_17_3 = g.core.common.ServerTime:getTimerBeforeDHM(var_17_1)

		var_17_3 = g.core.common.ServerTime:getTime() - var_17_1 < 60 and g.core.lang:get(102006) or g.core.lang:get(102501, {
			time = var_17_3
		})

		self.m_offlineStateTxt:setText(var_17_3)
	end

	self.m_onlineStateController:setSelectedIndex(var_17_2)
	self.m_powerTxt:setText(g.core.utils.Number.transFightValue(var_17_0.fight_value))

	local var_17_4 = var_17_0.guild_name

	if not var_17_0.guild_name or string.len(var_17_4) == 0 then
		var_17_4 = g.core.lang:get(300011)
	end

	self.m_guildTxt:setText(var_17_4)

	if not var_0_2:isModuleUnlock(var_0_0.HOME_LAND_FURNITURE) then
		self.m_homeBtn:setVisible(false)
	else
		local var_17_5 = "isCanClean"
		local var_17_6 = {}

		var_17_6.index = g.core.model.User.furnitureData:isCanCleanFurnitureByUserId(self._friendId) and 1 or 0

		self.m_homeBtn:setCtrlState(var_17_5, var_17_6)
	end
end

function FriendMainItem:_updateFriendListContent(arg_18_1)
	local var_18_0, var_18_1 = var_0_4:getFriendIntimate(arg_18_1:getIntimate())

	if var_18_0 then
		if var_18_1 then
			-- block empty
		end

		self._giftName = var_18_0.gift_name
	end

	if arg_18_1:isCanReceived() then
		self.m_giftTypeController:setSelectedIndex(0)
		self.m_forbiddenOprateController:setSelectedIndex(0)
	else
		self.m_giftTypeController:setSelectedIndex(1)
		self.m_forbiddenOprateController:setSelectedIndex(arg_18_1:isGifted() and 1 or 0)
	end
end

function FriendMainItem:_updateRequestListContent(arg_19_1)
	return
end

function FriendMainItem:_updateBlackListContent(arg_20_1)
	return
end

function FriendMainItem:_onClickUserIcon()
	if not g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.PLAYER_INFO) then
		return
	end

	g.core.module.ModuleManager:pushModule(g.view.entrance.PLAYER_INFO, {
		isUpdate = true,
		uid = self._friendId
	})
end

function FriendMainItem:_checkAndGetPopInfo(arg_22_1)
	local var_22_0 = {}
	local var_22_1 = {
		user = clone(arg_22_1)
	}

	if var_22_1.user.guild_id and var_22_1.user.guild_id == 0 then
		var_22_1.user.guild_id = -1
	end

	var_22_0.playerInfo = var_22_1

	return var_22_0
end

return FriendMainItem

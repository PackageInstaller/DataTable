local var_0_0 = g.core.const.ConstMgr.FUNCTION_TYPE
local var_0_1 = g.core.model.User.friendData
local FriendControllerConst = require("app.view.module.friend.const.FriendControllerConst")
local var_0_4 = g.core.model.User.furnitureData
local UserConst = require("app.view.module.user.const.UserConst")
local var_0_6 = {
	SHOW_FRIEND_LIST_ACTION = 1,
	SHOW_SEARCH_LIST_ACTION = 99999,
	SHOW_TIP_LIST_ACTION = 99999
}
local var_0_7 = {
	[FriendControllerConst.TabType.FRIEND_LIST] = 0,
	[FriendControllerConst.TabType.REQUEST_LIST] = 2,
	[FriendControllerConst.TabType.BLACK_LIST] = 1
}
local FriendMainLayer = class("FriendMainLayer", require("app.fairyGUI.friend.UI_FriendMainLayer"), function()
	return fgui.GComponent:create({
		resName = "FriendMainLayer",
		pkgPath = "ui/friend/friend",
		isFullScreen = true,
		pkgName = "friend"
	}, ...)
end)

function FriendMainLayer:ctor()
	self._dataList = nil
	self._tabSelectIdx = -1

	self:_reset()
	self:_initUIListeners()
end

function FriendMainLayer:_initUIListeners()
	self.m_tabList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onTabChange))
	self.m_tabList:setNumItems(4)
	self.m_tabList:resizeToFit(4)
	self:_refreshTabRedPoints()
	self.m_list:setVirtual(self)
	self.m_list:setItemRenderer(handler(self, self._onListItemRender))
	self.m_list:doFairyBatching(false)
	self.m_setBtn:addClickListener(handler(self, self._showFriendLimitPop))
	self.m_recommendBtn:addClickListener(handler(self, self._showRecommendFriendPop))
	self.m_searchBtn:addClickListener(handler(self, self._searchFriend))
	self.m_esayGiftBtn:addClickListener(handler(self, self._onEsayGiftBtnClicked))
	self.m_allConfirmBtn:addClickListener(handler(self, self._allConfirm))
	self.m_allRefuseBtn:addClickListener(handler(self, self._allRefuse))
	self.m_refreshBtn:setClickFunc(handler(self, self._onSynchronizeRecommendList))
	self.m_refreshBtn:setTimeInterval(tonumber(g.core.config.parameter_info.get(102).parameter))
	self.m_refreshBtn:setLimitTip(102530)
	self.m_allConfirmTipBtn:addClickListener(handler(self, self._allConfirmTipOrSearchFriends))

	if not g.core.model.User.guideData:getServerDataById(g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.CROSS_FRIEND_1) and g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.CROSS_FRIEND) then
		g.core.model.User.guideData:setSaveServerData(g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.CROSS_FRIEND_1)
	end
end

function FriendMainLayer:_resetUI()
	self.m_nameInput:setPrompt(g.core.lang:get(102520))
	self:addBg("bg/common/pic_bb_beijing.jpg")

	local var_4_0 = self.m_listRightNode:getPosition()
	local var_4_1 = var_4_0.x - self.m_list:getPosition().x - 1120

	if var_4_1 > 0 then
		local var_4_2 = self.m_tabList:getPosition().x + self.m_tabList:getSize().width
		local var_4_3 = self.m_contentGroup:getPosition()
		local var_4_4 = var_4_3.x

		var_4_3.x = var_4_2 + var_4_1 / 3

		self.m_contentGroup:setPosition(var_4_3)
		self.m_list:setColumnGap(var_4_1 / 3)

		local var_4_5 = self.m_list:getPosition()

		var_4_5.x = var_4_2 + var_4_1 / 3 + (var_4_5.x - var_4_4)

		self.m_list:setPosition(var_4_5)

		var_4_0.x = var_4_0.x - var_4_1 / 3 * 2 - (display.width - var_4_0.x)

		self.m_contentRightNode:setPosition(var_4_0)

		local var_4_6 = self.m_bottomBg:getSize()

		var_4_6.width = var_4_6.width + var_4_1 / 3

		self.m_bottomBg:setSize(var_4_6)
	end
end

function FriendMainLayer:_resetOther()
	self._animationTimes = {}

	for iter_5_0, iter_5_1 in pairs(var_0_6) do
		self._animationTimes[iter_5_0] = iter_5_1
	end

	self._sortCache = {}
	self._lastFriendNum = -1
	self._tabSelectIdx = -1
	self._remainGift = 0
	self._showViews = {}
	self._canRecv = false
	self._recommendList = nil
	self._searchList = nil
end

function FriendMainLayer:_reset()
	self:_resetUI()
	self:_resetOther()
end

function FriendMainLayer:_addCustomListeners()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FRIEND_FRIENDLIST, handler(self, self._onSynchronizeInfoEnd), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FRIEND_NOTIFYGIFT, handler(self, self._onSynchronizeInfoEnd), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FRIEND_REQUESTLIST, handler(self, self._onSynchronizeInfoEnd), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FRIEND_CONFIRMFRIEND, handler(self, self._onFriendOperationBack), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FRIEND_BLACKLIST, handler(self, self._onSynchronizeInfoEnd), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_DETAIL_INFO, handler(self, self._getUserDetailInfoBack), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FRIEND_GETRECOMMENDLIST, handler(self, self._onRefreshRecommendList), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FRIEND_GETSNAPSHOT, handler(self, self._onSynchronizeSearchList), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FRIEND_NOTIFYDELFRIEND, handler(self, self._onSynchronizeInfoEnd), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FRIEND_NOTIFYADDFRIENDREQUEST, handler(self, self._onNotifyEnd), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FRIEND_NOTIFYADDFRIEND, handler(self, self._onSynchronizeFriendInfo), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FRIEND_RECEIVEGIFT, handler(self, self._onRecvGiftBack), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FRIEND_SENDGIFT, handler(self, self._onGiveGiftBack), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FRIEND_DELBLACKLIST, handler(self, self._onSynchronizeInfoEnd), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FRIEND_DELFRIEND, handler(self, self._onSynchronizeInfoEnd), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FRIEND_ADDFRIEND, handler(self, self._onRequestFriendAddBack), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FRIEND_NOTIFYTASK, handler(self, self._onSynchronizeFriendTask), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FRIEND_INFO, handler(self, self._onSynchronizeInfoEnd), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, handler(self, self._onSynchronizeFriendInfo), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FRIEND_REQUESTCONDLIST, self._updateLimitUI, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FRIEND_SETREQUESTCOND, self._updateLimitUI, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FURNITURE_ROOM_GETINFO, self._onFurnitureGetInfo, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FURNITURE_ROOM_FRIENDGETINFO, self._onRecGetFriendFurnitureInfo, self)
end

function FriendMainLayer:onLoad()
	self.m_topBar:setResInfoById(18)
	self:_addCustomListeners()
	self:_onSynchronizeFriendInfo()

	if g.core.common.ModuleUnlock:isModuleShow(var_0_0.FRIEND_APPLY_COND) then
		self:_onSynchronizeLimitInfo()
	end

	self:newScheduleOnce(handler(self, self.checkSpeWeakGuide), 1)
end

function FriendMainLayer:onUnload()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH)
end

function FriendMainLayer:_onTabChange(arg_10_1)
	local var_10_0 = self.m_tabList:getSelectedIndex()

	if var_10_0 == self._tabSelectIdx then
		return
	end

	self._tabSelectIdx = var_10_0

	self.m_tabTypeController:setSelectedIndex(var_10_0)

	if var_10_0 == 1 and not g.core.model.User.guideData:getServerDataById(g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.CROSS_FRIEND_2) and g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.CROSS_FRIEND) then
		g.core.model.User.guideData:setSaveServerData(g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.CROSS_FRIEND_2)
	end

	self:_clearSearchInput()

	self._giftId = nil
	self._lastFriendNum = -1

	if var_10_0 == FriendControllerConst.TabType.FRIEND_LIST then
		self:_onSynchronizeFriendListInfo()
	elseif var_10_0 == FriendControllerConst.TabType.REQUEST_LIST then
		self:_onSynchronizeFriendRequestList()

		return
	elseif var_10_0 == FriendControllerConst.TabType.BLACK_LIST then
		self:_onSynchronizeBlackListInfo()

		return
	end

	self:_updateView()
end

function FriendMainLayer:_onListItemRender(arg_11_1, arg_11_2)
	arg_11_2:updateCell(self._dataList[arg_11_1 + 1], self._tabSelectIdx, arg_11_1)
	self:_onCheckSearchList(arg_11_1 + 1)
end

function FriendMainLayer:_onCheckSearchList(arg_12_1)
	if self._tabSelectIdx == FriendControllerConst.TabType.TIP_LIST and self._searchList then
		local var_12_0 = math.ceil(#self._searchList / 50)

		if arg_12_1 >= var_12_0 * 50 then
			self:_requestSearch(var_12_0 + 1)
		end
	end
end

function FriendMainLayer:_updateView()
	if FriendControllerConst.TabType.TIP_LIST ~= self._tabSelectIdx then
		self._dataList = var_0_1:getCurTabList(var_0_7[self._tabSelectIdx])
	end

	self.m_isEmptyController:setSelectedIndex(FriendControllerConst.IsEmpty.Has)

	if self._tabSelectIdx == FriendControllerConst.TabType.FRIEND_LIST then
		self:_showFriendListView()
	elseif self._tabSelectIdx == FriendControllerConst.TabType.TIP_LIST then
		self:_showTipListView()
	elseif self._tabSelectIdx == FriendControllerConst.TabType.GIFT_LIST then
		self:_showGiftListView()
	elseif self._tabSelectIdx == FriendControllerConst.TabType.REQUEST_LIST then
		local var_13_0 = {}

		for iter_13_0, iter_13_1 in ipairs(self._dataList) do
			if iter_13_1:getBasicInfo() and next(iter_13_1:getBasicInfo()) then
				var_13_0[#var_13_0 + 1] = iter_13_1
			end
		end

		self._dataList = var_13_0

		self:_showRequestListView()
	else
		self:_showBlackListView()
	end
end

function FriendMainLayer:_normalCompare(arg_14_1, arg_14_2)
	if arg_14_1:isGifted() ~= arg_14_2:isGifted() then
		return not arg_14_1:isGifted()
	end

	local var_14_0 = arg_14_1:getBasicInfo()
	local var_14_1 = arg_14_2:getBasicInfo()

	if var_14_0.offline_time ~= var_14_1.offline_time then
		if var_14_0.offline_time == 0 then
			return true
		end

		if var_14_1.offline_time == 0 then
			return false
		end

		if var_14_0.offline_time ~= nil and var_14_1.offline_time ~= nil then
			return var_14_0.offline_time > var_14_1.offline_time
		end
	end

	if var_14_0.level ~= var_14_1.level then
		if type(var_14_0.level) ~= "number" then
			return true
		end

		if type(var_14_1.level) ~= "number" then
			return false
		end

		return var_14_0.level > var_14_1.level
	end

	return false
end

function FriendMainLayer:_sortFriendDataAndCache(arg_15_1)
	table.sort(arg_15_1, handler(self, self._normalCompare))

	self._sortCache = {}

	for iter_15_0, iter_15_1 in ipairs(arg_15_1) do
		self._sortCache[iter_15_1:getFriendId()] = iter_15_0
	end
end

function FriendMainLayer:_cacheCompare(arg_16_1, arg_16_2)
	local var_16_0 = self._sortCache[arg_16_1:getFriendId()]
	local var_16_1 = self._sortCache[arg_16_2:getFriendId()]

	if var_16_1 == var_16_0 then
		return false
	end

	if not var_16_0 then
		return true
	elseif not var_16_1 then
		return false
	end

	return var_16_0 < var_16_1
end

function FriendMainLayer:_checkSortCache()
	local var_17_0 = true

	for iter_17_0, iter_17_1 in ipairs(self._dataList) do
		if self._sortCache[iter_17_1:getFriendId()] == nil then
			var_17_0 = false

			break
		end
	end

	return var_17_0
end

function FriendMainLayer:_recoverSortByCache(arg_18_1)
	table.sort(arg_18_1, handler(self, self._cacheCompare))
end

function FriendMainLayer:_showFriendListView()
	local var_19_0 = table.nums(self._dataList)

	if self._giftId or self._lastFriendNum == var_19_0 and self:_checkSortCache() then
		self:_recoverSortByCache(self._dataList)
	else
		self:_sortFriendDataAndCache(self._dataList)
	end

	self.m_list:setNumItems(var_19_0)

	self._lastFriendNum = var_19_0

	self:_checkAndPlayAnimation("SHOW_FRIEND_LIST_ACTION", self.m_list, nil, "listCardAUiScaleIn")

	if var_19_0 == 0 then
		self.m_isEmptyController:setSelectedIndex(FriendControllerConst.IsEmpty.EMPTY)
	else
		self.m_isEmptyController:setSelectedIndex(FriendControllerConst.IsEmpty.Has)
	end

	self:_updateNumTxt(var_19_0, g.core.config.role_info.get((g.core.model.User:getLevel())).friend_limit)

	local var_19_1 = g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.FRIEND_GIFT_LIMIT).parameter

	self._remainGift = math.max(0, var_19_1 - var_0_1:getGiftedNum())

	self.m_timeText:setText(g.core.lang:get(102512, {
		num = self._remainGift,
		max = var_19_1
	}))

	local var_19_2, var_19_3

	if self._remainGift < 1 then
		self.m_isLackController:setSelectedIndex(1)
	else
		self.m_isLackController:setSelectedIndex(0)

		var_19_2 = var_0_4:getCurSweepTime()
		var_19_3 = {
			num = var_19_2
		}
	end

	var_19_3.maxNum = var_0_4:getSweepDailyMaxTime()

	self.m_sweepTimeText:setText(g.core.lang:get(107056, var_19_3))

	if var_19_2 < 1 then
		self.m_isSweepLackController:setSelectedIndex(1)
	else
		self.m_isSweepLackController:setSelectedIndex(0)
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_pointBtn
	})
end

function FriendMainLayer:_showTipListView()
	if not self._recommendList then
		self:_onSynchronizeRecommendList()

		return
	end

	if self._searchList then
		self._dataList = self._searchList

		self.m_isHideBottomController:setSelectedIndex(1)
		self.m_searchBtn:setTitle(g.core.lang:get(102522))
	else
		self.m_searchBtn:setTitle(g.core.lang:get(102521))

		self._dataList = self._recommendList
	end

	self.m_list:setNumItems(table.nums(self._dataList))

	if not self._requestAddIdx then
		self:_checkAndPlayAnimation("SHOW_TIP_LIST_ACTION", self.m_list, nil, "listCardAUiScaleIn")
	end

	if #self._dataList == 0 then
		self.m_isEmptyController:setSelectedIndex(FriendControllerConst.IsEmpty.EMPTY)
	end

	self:_updateNumTxt(table.nums((var_0_1:getCurTabList(var_0_7[FriendControllerConst.TabType.FRIEND_LIST]))), g.core.config.role_info.get((g.core.model.User:getLevel())).friend_limit)
end

function FriendMainLayer:_showRequestListView()
	self.m_list:setNumItems(#self._dataList)
	self:_updateNumTxt(table.nums((var_0_1:getCurTabList(var_0_7[FriendControllerConst.TabType.FRIEND_LIST]))), g.core.config.role_info.get((g.core.model.User:getLevel())).friend_limit)

	local var_21_0 = g.core.common.ModuleUnlock:isModuleShow(var_0_0.FRIEND_APPLY_COND)

	self.m_limitTitleTxt:setVisible(var_21_0)
	self.m_limitLvTxt:setVisible(var_21_0)
	self.m_setBtn:setVisible(var_21_0)

	if #self._dataList > 0 then
		self.m_isEmptyController:setSelectedIndex(FriendControllerConst.IsEmpty.Has)
	else
		self.m_isEmptyController:setSelectedIndex(FriendControllerConst.IsEmpty.EMPTY)
	end
end

function FriendMainLayer:_showBlackListView()
	local var_22_0 = #self._dataList

	self.m_list:setNumItems(#self._dataList)

	if var_22_0 == 0 then
		self.m_isEmptyController:setSelectedIndex(FriendControllerConst.IsEmpty.EMPTY)
	else
		self.m_isEmptyController:setSelectedIndex(FriendControllerConst.IsEmpty.Has)
	end

	self:_updateNumTxt(var_22_0, g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.FRIEND_BLACK_LIMIT).parameter)
end

function FriendMainLayer:_updateNumTxt(arg_23_1, arg_23_2)
	self.m_numTxt:setText(g.core.lang:get(102512, {
		num = arg_23_1,
		max = arg_23_2
	}))
end

function FriendMainLayer:_updateLimitUI()
	local var_24_0 = var_0_1:getApplyCondList()[1]
	local var_24_1 = g.core.lang:get(102511)

	self.m_limitLvTxt:setText((var_24_0.condType == 1 or nil) and g.core.lang:get(102502, {
		level = var_24_0.value
	}))
end

function FriendMainLayer:receiveCompEvent(arg_25_1)
	local var_25_0 = {
		...
	}

	if arg_25_1 == "FriendGiftBtnClick" then
		self._giftName = var_25_0[1].name

		self:_onGiveGift(var_25_0[1].id)
	elseif arg_25_1 == "ApplyAddFriend" then
		if var_0_1:isInFriendList(var_25_0[1].data:getFriendId()) then
			g.core.module.ModuleManager:tip(g.core.lang:get(102529))

			return
		end

		var_0_1:notifyAddFriendBySelf(var_25_0[1].data:getBasicInfo())
		g.core.network.GameNetProxy:send_C2S_Friend_AddFriend({
			user_id = var_25_0[1].data:getFriendId()
		})

		self._requestAddIdx = var_25_0[1].idx
	elseif arg_25_1 == "FriendConfirmBtnClick" then
		local var_25_1 = var_0_1:getCurTabList(var_0_7[FriendControllerConst.TabType.FRIEND_LIST])

		if var_25_0[1].value then
			if var_25_1 and var_0_1:getFriendNumMax() > #var_25_1 then
				self:_onProcessingFriendOperation(var_25_0[1].id, var_25_0[1].value)
			else
				g.core.module.ModuleManager:tip(g.core.lang:get(102506))
			end
		else
			self:_onProcessingFriendOperation(var_25_0[1].id, var_25_0[1].value)
		end
	elseif arg_25_1 == "BlackDelBtnClick" then
		self:addPopup((require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(107050),
			desc = g.core.lang:get(102507, {
				name = var_25_0[1].name
			}),
			confirmText = g.core.lang:get(1160),
			cancelText = g.core.lang:get(1037),
			onConfirm = function()
				self:_onRemoveFromBlackList(var_25_0[1].id)
			end
		})))
	elseif arg_25_1 == "FriendReceiveBtnClick" then
		self:_onRecvGift({
			var_25_0[1].id
		})
	elseif arg_25_1 == "FriendHomeBtnClick" then
		self:_onSendGotoFriendHome(var_25_0[1].id)
	elseif arg_25_1 == "ShowPlayerInfoView" then
		local var_25_2 = clone(var_25_0[1].data)
		local var_25_3

		if var_25_2.guild_id and var_25_2.guild_id == 0 then
			var_25_2.guild_id = -1
			var_25_3 = require("app.view.base.infoPop.InfoUserMenuPop").new
		end

		self:addPopup(require("app.view.base.infoPop.InfoUserMenuPop").new({
			isRightPos = true,
			showPersonInfo = false,
			playerInfo = {
				user = var_25_2
			},
			showPos = var_25_0[1].pos
		}), {
			isUpdateBlack = false,
			hideContinue = true
		})
	elseif arg_25_1 == "FriendChatBtnClick" then
		self:_openChatPop(var_25_0[1].id, var_25_0[1].user)
	end
end

function FriendMainLayer:_checkAndPlayAnimation(arg_27_1, arg_27_2, arg_27_3, arg_27_4, arg_27_5, arg_27_6)
	local var_27_0 = self._animationTimes[arg_27_1]

	if not self._animationTimes[arg_27_1] or var_27_0 < 1 then
		return
	end

	if arg_27_3 then
		local var_27_1 = self:getView():getSharedTrans(arg_27_4, arg_27_3, arg_27_2)

		if var_27_1 then
			var_27_1:play(function()
				if arg_27_6 then
					arg_27_6()
				end
			end)
		end
	elseif arg_27_5 then
		arg_27_2:transitionShowCells(arg_27_4, arg_27_5[1], arg_27_5[2])
	else
		arg_27_2:transitionShowCells(arg_27_4)
	end

	self._animationTimes[arg_27_1] = var_27_0 - 1
end

function FriendMainLayer:_onGiveGift(arg_29_1)
	self._giftId = arg_29_1

	g.core.network.GameNetProxy:send_C2S_Friend_SendGift({
		id = arg_29_1
	})
end

function FriendMainLayer:_onSendGotoFriendHome(arg_30_1)
	local var_30_0 = tonumber(g.core.common.ServerTime:getTime())

	if var_30_0 - var_0_1:getFriendRoomConnectTime() >= 3 then
		g.core.network.GameNetProxy:send_C2S_FurnitureRoom_FriendGetInfo({
			friend_id = arg_30_1
		})
		var_0_1:setFriendRoomConnectTime(var_30_0)
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(309184))
	end
end

function FriendMainLayer:_onGiveGiftBack()
	g.core.module.ModuleManager:tip(self._giftId == 0 and g.core.lang:get(102503) or g.core.lang:get(102505))
	self:_onSynchronizeInfoEnd()
end

function FriendMainLayer:_onSynchronizeFriendInfo()
	g.core.network.GameNetProxy:send_C2S_Friend_Info({})

	if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.HOME_LAND_FURNITURE) then
		g.core.network.GameNetProxy:send_C2S_FurnitureRoom_GetInfo({})
	end
end

function FriendMainLayer:_onSynchronizeFriendListInfo()
	local var_33_0 = tonumber(g.core.common.ServerTime:getTime())

	if var_33_0 - var_0_1:getFriendListConnectTime() >= 10 then
		g.core.network.GameNetProxy:send_C2S_Friend_FriendList({})
		var_0_1:setFriendListConnectTime(var_33_0)
	else
		self:_onSynchronizeInfoEnd()
	end
end

function FriendMainLayer:_onFurnitureGetInfo()
	local var_34_0 = var_0_4:getCurSweepTime()

	self.m_sweepTimeText:setText(g.core.lang:get(107056, {
		num = var_34_0,
		maxNum = var_0_4:getSweepDailyMaxTime()
	}))

	if var_34_0 < 1 then
		self.m_isSweepLackController:setSelectedIndex(1)
	else
		self.m_isSweepLackController:setSelectedIndex(0)
	end
end

function FriendMainLayer:_onRecGetFriendFurnitureInfo(arg_35_1, arg_35_2)
	local var_35_0 = g.core.module.ModuleManager:getCurModule()

	if var_35_0 and var_35_0.module ~= g.view.entrance.FRIEND_FURNITURE and arg_35_2 and arg_35_2.friend_id then
		g.core.module.ModuleManager:pushModule(g.view.entrance.FRIEND_FURNITURE, {
			friendId = arg_35_2.friend_id
		})
	end
end

function FriendMainLayer:_onNotifyEnd()
	self._requestAddIdx = -1

	self:_updateView()

	self._requestAddIdx = nil
end

function FriendMainLayer:_onSynchronizeInfoEnd()
	local var_37_0 = self.m_tabList:getSelectedIndex()

	if var_37_0 < 0 then
		self.m_tabList:setSelectedIndex(FriendControllerConst.TabType.FRIEND_LIST)
		self:_onTabChange()

		return
	end

	if FriendControllerConst.TabType.TIP_LIST == var_37_0 and not self._recommendList then
		self:_onRefreshRecommendList()
	else
		self:_updateView()
	end

	self:_refreshTabRedPoints()
end

function FriendMainLayer:_onRequestFriendAddBack(arg_38_1, arg_38_2, arg_38_3, arg_38_4)
	g.core.module.ModuleManager:tip(g.core.lang:get(1011))

	if FriendControllerConst.TabType.TIP_LIST == self.m_tabList:getSelectedIndex() and self._requestAddIdx then
		if self._requestAddIdx == 999 then
			if self._searchList then
				self._searchList = {}
			else
				self._recommendList = {}
			end

			self._requestAddIdx = nil

			self:_onSynchronizeRecommendList()

			return
		end

		local var_38_0 = arg_38_4.user_id

		for iter_38_0, iter_38_1 in ipairs(self._dataList) do
			if iter_38_1:getFriendId() == var_38_0 then
				table.remove(self._dataList, iter_38_0)

				break
			end
		end
	end

	self:_onSynchronizeInfoEnd()

	self._requestAddIdx = nil
end

function FriendMainLayer:_onSynchronizeSearchList(arg_39_1, arg_39_2, arg_39_3, arg_39_4)
	self._searchList = arg_39_4

	self:_updateView()
end

function FriendMainLayer:_onProcessingFriendOperation(arg_40_1, arg_40_2)
	g.core.network.GameNetProxy:send_C2S_Friend_ConfirmFriend({
		id = arg_40_1,
		accept = arg_40_2
	})
end

function FriendMainLayer:_onFriendOperationBack(arg_41_1, arg_41_2, arg_41_3, arg_41_4)
	local var_41_0

	if not arg_41_4.ids then
		for iter_41_0, iter_41_1 in ipairs(self._dataList) do
			if iter_41_1:getFriendId() == arg_41_4.id then
				var_41_0 = iter_41_1:getBasicInfo().name

				break
			end
		end
	end

	local var_41_1 = arg_41_4.accept and (var_41_0 and g.core.lang:get(102526, {
		name = var_41_0
	}) or g.core.lang:get(102528)) or var_41_0 and g.core.lang:get(102525, {
		name = var_41_0
	}) or g.core.lang:get(102527)

	g.core.module.ModuleManager:tip((arg_41_4.ret == g.core.network.proto.RET_TARGET_FRIEND_FULL or nil) and g.core.lang:get(102537))
	self:_onSynchronizeInfoEnd()
end

function FriendMainLayer:_onSynchronizeFriendRequestList()
	local var_42_0 = tonumber(g.core.common.ServerTime:getTime())

	if var_42_0 - var_0_1:getFriendRequestListConnectTime() >= 10 then
		g.core.network.GameNetProxy:send_C2S_Friend_RequestList({})
		var_0_1:setFriendRequestListConnectTime(var_42_0)
	else
		self:_onSynchronizeInfoEnd()
	end
end

function FriendMainLayer:_onSynchronizeRecommendList()
	local var_43_0 = not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.CROSS_FRIEND)
	local var_43_1 = tonumber(g.core.common.ServerTime:getTime())

	if var_43_1 - var_0_1:getFriendRecommendConnectTime() >= 10 then
		g.core.network.GameNetProxy:send_C2S_Friend_GetRecommendList({
			is_local = var_43_0
		})
		var_0_1:setFriendRecommendConnectTime(var_43_1)
	else
		self:_onRefreshRecommendList()
	end
end

function FriendMainLayer:_onRefreshRecommendList()
	self._recommendList = var_0_1:getRecommendList()

	if #self._recommendList == 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(102531))
	end

	self:_updateView()
end

function FriendMainLayer:_onSynchronizeBlackListInfo()
	g.core.network.GameNetProxy:send_C2S_Friend_BlackList({})
end

function FriendMainLayer:_onRemoveFromBlackList(arg_46_1)
	g.core.network.GameNetProxy:send_C2S_Friend_DelBlackList({
		id = arg_46_1
	})
end

function FriendMainLayer:_onBlackListRemoveBack()
	self:_onSynchronizeInfoEnd()
end

function FriendMainLayer:_onSynchronizeFriendTask()
	self:_onSynchronizeFriendListInfo()
	self:_onSynchronizeFriendRequestList()
	self:_onSynchronizeBlackListInfo()
end

function FriendMainLayer:_onNameInputChanged()
	return
end

function FriendMainLayer:_onSynchronizeLimitInfo()
	g.core.network.GameNetProxy:send_C2S_Friend_RequestCondList({})
end

function FriendMainLayer:_onRecvGift(arg_51_1)
	if self._remainGift > 0 then
		g.core.network.GameNetProxy:send_C2S_Friend_ReceiveGift({
			id = arg_51_1
		})
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(102508))
	end
end

function FriendMainLayer:_openChatPop(arg_52_1, arg_52_2)
	if not g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.CHAT) then
		return
	end

	local var_52_0 = arg_52_2

	if g.core.model.User.chatData:isInBlackList(arg_52_1) then
		g.core.module.ModuleManager:tip(g.core.lang:get(1042))

		return
	end

	if g.core.model.User:getId() == arg_52_1 then
		g.core.module.ModuleManager:tip(g.core.lang:get(1044))

		return
	end

	g.core.model.User.chatData:setPrivateChatPInfo(var_52_0)
	g.core.module.ModuleManager:popAllPopupAndPush(g.view.entrance.CHAT, {
		type = g.core.const.ConstMgr.ChatConst.SINGLE,
		user = var_52_0
	})
end

function FriendMainLayer:_onRecvGiftBack(arg_53_1, arg_53_2, arg_53_3, arg_53_4)
	if arg_53_4.id == nil and var_0_1:getLeftGiftNum() > 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(102535))
	end

	g.core.module.ModuleManager:awardSummary(arg_53_4.awards or {})
	self:_onSynchronizeInfoEnd()
end

function FriendMainLayer:_showFriendLimitPop(arg_54_1)
	self:addPopup(require("app.view.module.friend.view.pop.FriendConditionPop").new(), {
		touchDisappear = true,
		hideContinue = true
	})
end

function FriendMainLayer:_showRecommendFriendPop()
	self.m_tabList:setSelectedIndex(FriendControllerConst.TabType.TIP_LIST)
	self:_onTabChange()
end

function FriendMainLayer:_onEsayGiftBtnClicked()
	self:_esayGive()
	self:_esayRecv()
end

function FriendMainLayer:_esayGive()
	local var_57_0 = true
	local var_57_1 = var_0_1:getCurTabList(var_0_7[FriendControllerConst.TabType.FRIEND_LIST])

	if table.nums(var_57_1) == 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(102509))

		return
	else
		for iter_57_0, iter_57_1 in pairs(var_57_1) do
			if not iter_57_1:isGifted() then
				var_57_0 = false

				break
			end
		end
	end

	if var_57_0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(102510))
	else
		self:_onGiveGift(0)
	end
end

function FriendMainLayer:_esayRecv()
	local var_58_0 = var_0_1:getGiftList()

	if not var_58_0 or #var_58_0 < 1 then
		return
	end

	local var_58_1 = {}

	for iter_58_0, iter_58_1 in pairs(var_58_0) do
		if not iter_58_1:isReceived() then
			table.insert(var_58_1, iter_58_1:getFriendId())
		end
	end

	self:_onRecvGift(var_58_1)
end

function FriendMainLayer:_allConfirm()
	local var_59_0 = var_0_1:getCurTabList(var_0_7[FriendControllerConst.TabType.FRIEND_LIST])

	if var_59_0 and var_0_1:getFriendNumMax() > #var_59_0 then
		self:_onProcessingFriendOperation(0, true)
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(102506))
	end
end

function FriendMainLayer:_allConfirmTipOrSearchFriends()
	local var_60_0 = var_0_1:getCurTabList(var_0_7[FriendControllerConst.TabType.FRIEND_LIST])

	if var_60_0 and var_0_1:getFriendNumMax() > #var_60_0 then
		for iter_60_0, iter_60_1 in ipairs(self._searchList or self._recommendList) do
			var_0_1:notifyAddFriendBySelf(iter_60_1:getBasicInfo())
			g.core.network.GameNetProxy:send_C2S_Friend_AddFriend({
				user_id = iter_60_1:getFriendId()
			})
		end

		self._requestAddIdx = 999
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(102506))
	end
end

function FriendMainLayer:_allRefuse()
	self:_onProcessingFriendOperation(0, false)
end

function FriendMainLayer:_getUserDetailInfoBack()
	return
end

function FriendMainLayer:_searchFriend()
	local var_63_0 = self.m_nameInput:getInputStr()

	if not var_63_0 or #var_63_0 < 1 then
		return
	end

	if self._searchList then
		self:_clearSearchInput()
		self:_updateView()
	else
		self:_requestSearch(0, var_63_0)
	end
end

function FriendMainLayer:_clearSearchInput()
	self.m_nameInput:setInputStr("")

	self._searchList = nil

	self.m_isHideBottomController:setSelectedIndex(0)
end

function FriendMainLayer:_requestSearch(arg_65_1, arg_65_2)
	local var_65_0 = tonumber(g.core.common.ServerTime:getTime())

	if var_65_0 - g.core.model.User.friendData:getFriendSearchConnectTime() >= 5 then
		g.core.network.GameNetProxy:send_C2S_Friend_GetSnapshot({
			name = self.m_nameInput:getInputStr()
		})
		g.core.model.User.friendData:setFriendSearchConnectTime(var_65_0)
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(309184))
	end
end

function FriendMainLayer:_refreshTabRedPoints()
	for iter_66_0 = 0, self.m_tabList:numChildren() - 1 do
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_tabList:getChildAt(iter_66_0)
		})
	end
end

function FriendMainLayer:checkSpeWeakGuide()
	if not g.core.model.User.guideData:getServerDataById(g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.CROSS_FRIEND_2) and g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.CROSS_FRIEND) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_TICK, false, {
			key = "CROSS_FRIEND_STEP_2",
			targetBtn = self.m_tabList:getChildAt(1)
		})
	end
end

return FriendMainLayer

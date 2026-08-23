local FurnitureCharmRankLayer = class("FurnitureCharmRankLayer", require("app.fairyGUI.furniture.UI_FurnitureCharmRankLayer"), function()
	return fgui.GComponent:create({
		resName = "FurnitureCharmRankLayer",
		pkgPath = "ui/furniture/furniture",
		isFullScreen = true,
		pkgName = "furniture"
	}, ...)
end)

function FurnitureCharmRankLayer:ctor(arg_2_1)
	self:addBg("bg/common/pic_bb_beijing.jpg")

	if arg_2_1 then
		self._isFriend = arg_2_1.isFriend or false
	end

	self._serverRankList = {}
	self._friendRankList = {}
	self._charmAllRankList = {}
	self._selfSvrRank = 0
	self._selfFriendRank = 0
	self._selfAllRank = 0

	self.m_allServerRankList:setVirtual()
	self.m_allServerRankList:setItemRenderer(handler(self, self._onServerRankRenderer))
	self.m_allServerRankList:doFairyBatching(false)
	self.m_moodsRankList:setVirtual()
	self.m_moodsRankList:setItemRenderer(handler(self, self._onCharmAllRankRenderer))
	self.m_moodsRankList:doFairyBatching(false)
	self.m_friendRankList:setVirtual()
	self.m_friendRankList:setItemRenderer(handler(self, self._onFriendRankRenderer))
	self.m_friendRankList:doFairyBatching(false)
	self.m_topBarComp:setHelpId(g.core.const.ConstMgr.HelpConst.HELP_TYPE.FURNITURE_CHARM_RANK)
	self.m_typeController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onCtrlChanged))
	self.m_myRankGroup:setVisible(not self._isFriend)
	self.m_charmNunTxt:setText(tonumber((g.core.model.User.furnitureData:getCharmValue())))
end

function FurnitureCharmRankLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_COMMON_RANK_LIST, self._onRcvGetRank, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FURNITURE_ROOM_GETPRAISEUSER, self._onRcvGetPaiseUser, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, self._updateRankList, self)
	g.core.network.GameNetProxy:send_C2S_GetCommonRankList({
		size = 100,
		id = g.core.network.proto.FURNITURE_CHARM_LOCAL
	})
	g.core.network.GameNetProxy:send_C2S_GetCommonRankList({
		size = 100,
		id = g.core.network.proto.FURNITURE_SUM_CHARM_LOCAL
	})

	local var_3_0 = tonumber(g.core.common.ServerTime:getTime())

	if var_3_0 - g.core.model.User.friendData:getFriendListConnectTime() >= 10 then
		g.core.network.GameNetProxy:send_C2S_Friend_FriendList({})
		g.core.model.User.friendData:setFriendListConnectTime(var_3_0)
	end
end

function FurnitureCharmRankLayer:_onRcvGetRank(arg_4_1, arg_4_2, arg_4_3)
	if arg_4_3.id == g.core.network.proto.FURNITURE_CHARM_LOCAL then
		self._selfSvrRank = arg_4_3.self_rank or 0
		self._serverRankList = arg_4_3.rank_units or {}

		self.m_allServerRankList:setNumItems(#self._serverRankList)
	elseif arg_4_3.id == g.core.network.proto.FURNITURE_SUM_CHARM_LOCAL then
		self._selfAllRank = arg_4_3.self_rank or 0
		self._charmAllRankList = arg_4_3.rank_units or {}

		g.core.network.GameNetProxy:send_C2S_FurnitureRoom_GetPraiseUser({})
	end

	self:updateMySelfRank()
end

function FurnitureCharmRankLayer:updateMySelfRank()
	local var_5_0 = self.m_typeController:getSelectedIndex()

	if var_5_0 == 0 then
		if self._selfSvrRank == 0 then
			self.m_serverRankNum:setText(g.core.lang:get(112550))
		else
			self.m_serverRankNum:setText(self._selfSvrRank)
		end

		self.m_charmNunTxt:setText(tonumber((g.core.model.User.furnitureData:getCharmValue())))
	elseif var_5_0 == 1 then
		self.m_serverRankNum:setText(self._selfFriendRank)
		self.m_charmNunTxt:setText(tonumber((g.core.model.User.furnitureData:getSumCharmValue())))
	else
		if self._selfAllRank == 0 then
			self.m_serverRankNum:setText(g.core.lang:get(112550))
		else
			self.m_serverRankNum:setText(self._selfAllRank)
		end

		self.m_charmNunTxt:setText(tonumber((g.core.model.User.furnitureData:getSumCharmValue())))
	end
end

function FurnitureCharmRankLayer:_onRcvGetPaiseUser()
	if #self._charmAllRankList ~= 0 then
		self.m_moodsRankList:setNumItems(#self._charmAllRankList)
	end
end

function FurnitureCharmRankLayer:_onCtrlChanged()
	local var_7_0 = self.m_typeController:getSelectedIndex()

	if var_7_0 == 1 then
		self:updateFriendRank()
	elseif var_7_0 == 0 then
		g.core.network.GameNetProxy:send_C2S_GetCommonRankList({
			size = 100,
			id = g.core.network.proto.FURNITURE_CHARM_LOCAL
		})
	elseif var_7_0 == 2 then
		g.core.network.GameNetProxy:send_C2S_GetCommonRankList({
			size = 100,
			id = g.core.network.proto.FURNITURE_SUM_CHARM_LOCAL
		})
	end

	self:updateMySelfRank()
end

function FurnitureCharmRankLayer:_updateRankList()
	local var_8_0 = self.m_typeController:getSelectedIndex()

	if var_8_0 == 1 then
		self:updateFriendRank()
	elseif var_8_0 == 0 then
		self.m_allServerRankList:setNumItems(#self._serverRankList)
	elseif var_8_0 == 2 then
		self.m_moodsRankList:setNumItems(#self._charmAllRankList)
	end
end

function FurnitureCharmRankLayer:updateFriendRank()
	if self._inited then
		return
	end

	self._inited = true
	self._friendRankList = {}

	for iter_9_0, iter_9_1 in ipairs((g.core.model.User.friendData:getFriendList())) do
		if iter_9_1:getCharmValue() > 0 then
			table.insert(self._friendRankList, iter_9_1)
		end
	end

	table.insert(self._friendRankList, {
		isSelf = true,
		getCharmValue = function()
			return g.core.model.User.furnitureData:getSumCharmValue()
		end,
		getCharmSvrRank = function()
			return self._selfAllRank
		end,
		getBasicInfo = function()
			return g.core.model.User:getUserData()
		end
	})
	table.sort(self._friendRankList, function(arg_13_0, arg_13_1)
		if arg_13_0:getCharmValue() ~= arg_13_1:getCharmValue() then
			return arg_13_0:getCharmValue() > arg_13_1:getCharmValue()
		end

		return arg_13_0:getBasicInfo().id < arg_13_1:getBasicInfo().id
	end)

	for iter_9_2, iter_9_3 in ipairs(self._friendRankList) do
		if iter_9_3.isSelf then
			self._selfFriendRank = iter_9_2
		end
	end

	self.m_friendRankList:setNumItems(#self._friendRankList)
end

function FurnitureCharmRankLayer:_onServerRankRenderer(arg_14_1, arg_14_2)
	arg_14_2:updateCellData(self._serverRankList[arg_14_1 + 1], arg_14_1 + 1)
end

function FurnitureCharmRankLayer:_onCharmAllRankRenderer(arg_15_1, arg_15_2)
	arg_15_2:updateCellData(self._charmAllRankList[arg_15_1 + 1], arg_15_1 + 1)
end

function FurnitureCharmRankLayer:_onFriendRankRenderer(arg_16_1, arg_16_2)
	arg_16_2:updateCellData(self._friendRankList[arg_16_1 + 1], arg_16_1 + 1)
end

return FurnitureCharmRankLayer

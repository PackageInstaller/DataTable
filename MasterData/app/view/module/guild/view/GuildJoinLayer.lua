local var_0_2 = g.core.model.User.guildData
local var_0_3 = g.core.const.ConstMgr.GuildCommonConst
local GuildJoinLayer = class("GuildJoinLayer", require("app.fairyGUI.guild.UI_GuildJoinLayer"), function()
	return fgui.GComponent:create({
		resName = "GuildJoinLayer",
		pkgPath = "ui/guild/guild",
		isFullScreen = true,
		pkgName = "guild"
	}, ...)
end)

function GuildJoinLayer:ctor(arg_2_1)
	self._constRecommendNum = 80
	self._recomNum = 0
	self._recommendData = {}
	self._fightData = {}
	self._commendListType = var_0_3.commendType.CAN_JOIN
	self._seekData = {}
	self._recomIndex = 1
	self._createVipLimit = 0
	self._isFirstEnter = true
	self._isCanUpdateOnlyShowList = false
	self._listType = var_0_3.joinListType.RECOMMEND_GUILD
	self._guildDict = {}
	self._rankList = {}
	self._showList = {}

	self:_initView()
end

function GuildJoinLayer:_initView()
	self.m_fastJoinBtn:addClickListener(handler(self, self._onClickQuickJoin))
	self.m_myApplyGuildBtn:addClickListener(handler(self, self._onClickMyApply))
	self.m_createGuildBtn:addClickListener(handler(self, self._onClickCreate))
	self.m_seekGuildBtn:addClickListener(handler(self, self._onClickSeek))
	self.m_checkStateController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onSelectedGuild))
	self.m_recommendList:setVirtual()
	self.m_recommendList:setItemRenderer(handler(self, self._onGuildListRenderer))
	self.m_recommendList:addEventListener(fgui.UIEventType.PullUpRelease, handler(self, self._onPullUpRelease))
	self.m_seekList:setVirtual()
	self.m_seekList:setItemRenderer(handler(self, self._onGuildListRenderer))
	self.m_joinCheckBtn:addClickListener(handler(self, self._onClickOnlyShow))
	self.m_topBar:setHelpId(g.core.const.ConstMgr.HelpConst.HELP_TYPE.GUILD_JOIN)
	self.m_topBar:setResInfoById(9)
	self:addBg("bg/guild/bg_jt_juantuanrenwu.jpg", false)
	self.m_checkStateController:setSelectedIndex(self._commendListType)
end

function GuildJoinLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_RECOMMEND, handler(self, self._onRcvRecommendGuild), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_SEARCH, handler(self, self._onRcvSearchGuild), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_GUILD_SNAP_SHOT, handler(self, self._onRcvGuildSnapShot), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_FASTJOIN, handler(self, self._onRcvFastJoin), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_COMMON_RANK_LIST, handler(self, self._onRcvRank), self)

	if self._isFirstEnter then
		self._isFirstEnter = false

		g.core.network.GameNetProxy:send_C2S_Guild_GetApplyHistory({})
		g.core.network.GameNetProxy:send_C2S_Guild_Recommend({
			index = 1
		})
	else
		self:_updateTime()
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_WEAK_GUIDE_READY)
end

function GuildJoinLayer:_updateRecommendList()
	self._listType = var_0_3.joinListType.RECOMMEND_GUILD

	self.m_listTypeController:setSelectedIndex(self._listType)

	if not self._recommendData or #self._recommendData < 1 then
		self._recommendData = var_0_2:getRecommendList(self._commendListType, self._fightData)
	end

	self._recomNum = math.min(self._constRecommendNum, #self._recommendData)

	local var_5_0 = self._recomNum <= 0

	if self._recomNum > 0 then
		self.m_recommendList:setNumItems(self._recomNum)
		self.m_recommendList:transitionShowCells("listCardAUiScaleIn", 0.06)
	end

	self.m_isEmptyController:setSelectedIndex(var_5_0 and 1 or 0)
end

function GuildJoinLayer:_updateSeekList()
	self.m_listTypeController:setSelectedIndex(self._listType)

	local var_6_0 = #self._seekData <= 0

	if #self._seekData > 0 then
		self.m_seekList:setNumItems(#self._seekData)
	end

	self.m_isEmptyController:setSelectedIndex(var_6_0 and 2 or 0)
	self.m_seekList:transitionShowCells("listCardAUiScaleIn", 0.06)
end

function GuildJoinLayer:_onRcvRecommendGuild(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	self._listType = var_0_3.joinListType.RECOMMEND_GUILD
	self._recomIndex = arg_7_4.index

	g.core.network.GameNetProxy:send_C2S_GetCommonRankList({
		size = 30,
		id = g.core.network.proto.GUILD_LEVEL
	})
end

function GuildJoinLayer:_onRcvGuildSnapShot(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	for iter_8_0, iter_8_1 in ipairs(arg_8_4.snapshots or {}) do
		self._guildDict[iter_8_1.id] = iter_8_1
	end

	for iter_8_2, iter_8_3 in ipairs(self._rankList) do
		if self._guildDict[iter_8_3.id] and not self._fightData[iter_8_2] then
			self._fightData[iter_8_2] = self._guildDict[iter_8_3.id]
		end
	end

	self:_onRcvRankGuildData()
end

function GuildJoinLayer:_onRcvRank(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	self._rankList = arg_9_4.rank_units or {}

	local var_9_0 = {}

	for iter_9_0, iter_9_1 in ipairs(self._rankList) do
		if not self._guildDict[iter_9_1.id] then
			var_9_0[#var_9_0 + 1] = iter_9_1.id
		else
			self._fightData[iter_9_0] = self._guildDict[iter_9_1.id]
		end
	end

	if #var_9_0 > 0 then
		g.core.network.GameNetProxy:send_C2S_GetGuildSnapShot({
			guild_ids = var_9_0
		})
	else
		self:_onRcvRankGuildData()
	end
end

function GuildJoinLayer:_onRcvRankGuildData()
	var_0_2:updateGuildApplyState(self._fightData)

	self._recommendData = var_0_2:getRecommendList(self._commendListType, self._fightData)

	if self._recomIndex > 1 then
		local var_10_0 = math.min(#self._recommendData, self._recomNum + self._constRecommendNum)

		self._recomNum = var_10_0

		self.m_recommendList:setNumItems(var_10_0)
		self.m_recommendList:scrollToView(math.max(self.m_recommendList:getNumItems() - 2, 0), true)
	end

	self:_updateRecommendList()
	self:_updateTime()
end

function GuildJoinLayer:_onRcvFastJoin(arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	g.core.module.ModuleManager:tip(g.core.lang:get(109513, {
		name = arg_11_4.guild.name
	}))
	g.core.module.ModuleManager:replaceModule(g.view.entrance.GUILD_MAIN)
end

function GuildJoinLayer:_onRcvSearchGuild()
	self._listType = var_0_3.joinListType.SEEK_GUILD

	self.m_seekGuildBtn:setTitle(g.core.lang:get(109557))

	self._seekData = var_0_2:getSearchList()

	self:_updateSeekList()
end

function GuildJoinLayer:_updateTime()
	local var_13_0 = g.core.model.User:getUserData().join_guild_limit or 0
	local var_13_1 = g.core.common.ServerTime:getTime()
	local var_13_2 = true

	if not math.uint64_lt(var_13_0, var_13_1, true) then
		self.m_timeText:resetCooldownTs(var_13_0 - var_13_1, handler(self, self._timeUnlock))

		var_13_2 = false
	end

	self.m_timeShowController:setSelectedIndex(var_13_2 and 0 or 1)
end

function GuildJoinLayer:_onGuildListRenderer(arg_14_1, arg_14_2)
	local var_14_0 = {}

	if self._listType == var_0_3.joinListType.RECOMMEND_GUILD then
		var_14_0 = self._recommendData[arg_14_1 + 1]
	elseif self._listType == var_0_3.joinListType.SEEK_GUILD then
		var_14_0 = self._seekData[arg_14_1 + 1]
	end

	arg_14_2:updateInfo({
		data = var_14_0
	})
end

function GuildJoinLayer:_timeUnlock()
	self.m_timeShowController:setSelectedIndex(0)
end

function GuildJoinLayer:_onClickQuickJoin()
	local var_16_0 = g.core.model.User:getUserData().join_guild_limit or 0

	if not math.uint64_lt(var_16_0, g.core.common.ServerTime:getTime(), true) then
		g.core.module.ModuleManager:tip(g.core.lang:get(109512, {
			time = g.core.common.ServerTime:getLeftDHMSFormat(var_16_0)
		}))
	else
		g.core.network.GameNetProxy:send_C2S_Guild_FastJoin({})
	end
end

function GuildJoinLayer:_onClickMyApply()
	local GuildMyApplyPop = require("app.view.module.guild.view.GuildMyApplyPop")

	if var_17_0 then
		g.core.module.ModuleManager:pushPopup(var_17_0.new(), {
			touchDisappear = false
		})
	end
end

function GuildJoinLayer:_onClickCreate()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.guild.view.GuildCreatePop").new(), {
		touchDisappear = false
	})
end

function GuildJoinLayer:_onClickSeek()
	if self._listType == var_0_3.joinListType.SEEK_GUILD then
		self.m_seekGuildBtn:setTitle(g.core.lang:get(109558))
		self.m_inputComp:setInputStr("")
		self:_updateRecommendList()
	elseif self.m_inputComp:judgeLegal() then
		g.core.network.GameNetProxy:send_C2S_Guild_Search({
			key = self.m_inputComp:getInputStr()
		})
	end
end

function GuildJoinLayer:_onSelectedGuild()
	if self._isCanUpdateOnlyShowList then
		self._commendListType = self.m_checkStateController:getSelectedIndex()
		self._recommendData = var_0_2:getRecommendList(self._commendListType, self._fightData)

		self:_updateRecommendList()
	else
		self._isCanUpdateOnlyShowList = true
	end
end

function GuildJoinLayer:_onPullUpRelease()
	local var_21_0 = math.min(#self._recommendData, self._recomNum + self._constRecommendNum)

	if self.m_recommendList:getScrollPane():getFooter():getHeight() > 100 then
		if self._recomNum == var_21_0 then
			g.core.network.GameNetProxy:send_C2S_Guild_Recommend({
				index = self._recomIndex + 1
			})
		else
			local var_21_1 = self.m_recommendList:getNumItems() - 9

			self._recomNum = var_21_0

			self.m_recommendList:setNumItems(var_21_0)
			self.m_recommendList:scrollToView(math.max(var_21_1, 0), true)
		end
	end
end

function GuildJoinLayer:_onClickOnlyShow()
	self.m_checkStateController:setSelectedIndex(not self.m_checkBtn:isSelected() and 1 or 0)
	self:_onSelectedGuild()
end

return GuildJoinLayer

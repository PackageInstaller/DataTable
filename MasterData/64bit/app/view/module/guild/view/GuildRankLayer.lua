local GuildRankLayer = class("GuildRankLayer", require("app.fairyGUI.guild.UI_GuildRankLayer"), function()
	return fgui.GComponent:create({
		resName = "GuildRankLayer",
		pkgName = "guild",
		isFullScreen = true,
		pkgPath = "ui/guild/guild"
	}, ...)
end)

function GuildRankLayer:ctor()
	self._hasBtn = g.core.model.User.guildData:isShowMerge()

	self.m_rankList:setVirtual()
	self.m_rankList:setItemRendererAsync1(handler(self, self._onRankListRenderer), 0.05)
	self:addBg("bg/guild/bg_jt_juantuanrenwu.jpg")
	self.m_topBar:setResInfoById(13)
end

function GuildRankLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_COMMON_RANK_LIST, self._onRcvRank, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_GUILD_SNAP_SHOT, self._justUpdateView, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_MERGE_REQUEST, self.updateView, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_MERGE_CANCEL, self.updateView, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.GUILD_MERGE_REQUEST_ERROR, self._mergeRequestError, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_NOTIFYLEAVE, self._onRcvNotifyLeave, self)
	g.core.network.GameNetProxy:send_C2S_GetCommonRankList({
		size = 30,
		id = g.core.network.proto.GUILD_LEVEL
	})
end

function GuildRankLayer:_mergeRequestError()
	g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)
end

function GuildRankLayer:_onRcvNotifyLeave(arg_5_1, arg_5_2, arg_5_3)
	if arg_5_3.type == g.core.const.ConstMgr.GuildCommonConst.LeaveType.MERGE then
		g.core.module.ModuleManager:tip(g.core.lang:get(430013))
		g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)
	end
end

function GuildRankLayer:_onRcvRank(arg_6_1, arg_6_2, arg_6_3)
	if arg_6_3.id == g.core.network.proto.GUILD_LEVEL then
		self._levelData = arg_6_3.rank_units or {}
		self._levelRank = arg_6_3.self_rank or 0
	end

	self:updateView()
end

function GuildRankLayer:updateView()
	if self._levelRank == 0 then
		self.m_myRankTxt:setText(g.core.lang:get(109556))
	else
		self.m_myRankTxt:setText(self._levelRank)
	end

	self.m_rankList:setNumItems(#self._levelData)
	self.m_rankList:transitionShowCells("enter_up", 0.03, 1)
	self.m_isShowBtnController:setSelectedIndex(self._hasBtn and 1 or 0)
end

function GuildRankLayer:_justUpdateView()
	if self._levelRank == 0 then
		self.m_myRankTxt:setText(g.core.lang:get(109556))
	else
		self.m_myRankTxt:setText(self._levelRank)
	end

	self.m_rankList:setNumItems(#self._levelData)
	self.m_isShowBtnController:setSelectedIndex(self._hasBtn and 1 or 0)
end

function GuildRankLayer:_onRankListRenderer(arg_9_1, arg_9_2)
	arg_9_2:setData(arg_9_1, self._levelData[arg_9_1 + 1], self._hasBtn)
end

return GuildRankLayer

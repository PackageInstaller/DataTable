local var_0_0 = g.core.event
local var_0_2 = g.core.const.ConstMgr.GuildBossConst
local var_0_3 = g.core.model.User.guildBossData
local var_0_4 = g.core.const.ConstMgr.RankAwardConst
local RankAward = require("app.core.common.RankAward")
local var_0_6 = 0
local var_0_8 = 0
local var_0_9 = 1
local GuildBossRankAwardPop = class("GuildBossRankAwardPop", require("app.fairyGUI.guildBoss.UI_GuildBossRankAwardPop"), function()
	return fgui.GComponent:create({
		resName = "GuildBossRankAwardPop",
		pkgPath = "ui/guildBoss/guildBoss",
		isFullScreen = true,
		pkgName = "guildBoss"
	})
end)

function GuildBossRankAwardPop:ctor(arg_2_1)
	self._bossInfo = arg_2_1.bossInfo or var_0_3:getTodayBossInfo()
	self._personRank = nil
	self._personAward = nil
	self._guildRank = nil
	self._guildAward = nil
	self._selfRankPersonDamage = 0
	self._selfRankGuildDamage = 0
	self._selfPersonAward = {}
	self._selfGuildAward = {}

	self:initDamageRank()
end

function GuildBossRankAwardPop:onLoad()
	self:_initRegisterUI()
	self:_sendRankMsg()
	self:_changeSubTabUI()
	self:_refreshListView()
end

function GuildBossRankAwardPop:initDamageRank()
	self:_initDamageRankData()
	self:_initDamageRankUI()
end

function GuildBossRankAwardPop:_initDamageRankData()
	if not self._bossInfo then
		-- block empty
	elseif self._bossInfo.type == var_0_2.TYPE_LOCAL_SERVER then
		self._personAward = RankAward:getRankAwardArray(var_0_4.GUILD_BOSS_LOCAL_PERSON)
		self._guildAward = RankAward:getRankAwardArray(var_0_4.GUILD_BOSS_LOCAL_GUILD)
	elseif self._bossInfo.type == var_0_2.TYPE_CROSS_SERVER then
		self._personAward = RankAward:getRankAwardArray(var_0_4.GUILD_BOSS_CROSS_PERSON)
		self._guildAward = RankAward:getRankAwardArray(var_0_4.GUILD_BOSS_CROSS_GUILD)
	end
end

function GuildBossRankAwardPop:_initDamageRankUI()
	self:addBg("bg/common/pic_bb_beijing.jpg")
	self.m_topBarComp:setResInfoById(78)
	self.m_mainTabController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onMainTabRankChange))
	self.m_subTabController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onSubTabRankChange))
	self.m_rankList:setVirtual()
	self.m_rankList:setItemProvider(handler(self, self._onRankItemTempl))
	self.m_rankList:setItemRenderer(handler(self, self._onRenderRankList))
end

function GuildBossRankAwardPop:_initRegisterUI()
	var_0_0.EventManager:addEventListener(var_0_0.enum.EVENT_NET_S2C_GET_COMMON_RANK_LIST, self._onNetGetRankList, self)
	var_0_0.EventManager:addEventListener(var_0_0.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, self._refreshListView, self)
	var_0_0.EventManager:addEventListener(var_0_0.enum.EVENT_NET_S2C_GET_GUILD_SNAP_SHOT, self._refreshListView, self)
end

function GuildBossRankAwardPop:_sendRankMsg()
	if not self._bossInfo then
		-- block empty
	elseif self._bossInfo.type == var_0_2.TYPE_LOCAL_SERVER then
		g.core.network.GameNetProxy:send_C2S_GetCommonRankList({
			size = 50,
			id = g.core.network.proto.GUILD_BOSS_USER_LOCAL
		})
		g.core.network.GameNetProxy:send_C2S_GetCommonRankList({
			size = 30,
			id = g.core.network.proto.GUILD_BOSS_GUILD_LOCAL
		})
	elseif self._bossInfo.type == var_0_2.TYPE_CROSS_SERVER then
		g.core.network.GameNetProxy:send_C2S_GetCommonRankList({
			size = 50,
			id = g.core.network.proto.GUILD_BOSS_USER_CROSS
		})
		g.core.network.GameNetProxy:send_C2S_GetCommonRankList({
			size = 30,
			id = g.core.network.proto.GUILD_BOSS_GUILD_CROSS
		})
	end
end

function GuildBossRankAwardPop:_onRankItemTempl(arg_9_1)
	if self.m_mainTabController:getSelectedIndex() == var_0_6 then
		if self.m_subTabController:getSelectedIndex() == var_0_8 then
			return "ui://guildBoss/GuildBossGuildRankCell"
		else
			return "ui://guildBoss/GuildBossPersonRankCell"
		end
	else
		return "ui://guildBoss/GuildBossAwardCell"
	end
end

function GuildBossRankAwardPop:_onRenderRankList(arg_10_1, arg_10_2)
	local var_10_0 = self.m_subTabController:getSelectedIndex()
	local var_10_1 = self.m_mainTabController:getSelectedIndex() == var_0_6 and (var_10_0 == var_0_8 and self._guildRank or self._personRank) or var_10_0 == var_0_8 and self._guildAward or self._personAward

	if var_10_1 then
		arg_10_2:updateCell(var_10_1[arg_10_1 + 1], arg_10_1 + 1)
	end
end

function GuildBossRankAwardPop:_refreshListView()
	local var_11_0 = self.m_subTabController:getSelectedIndex()
	local var_11_1 = 0

	var_11_1 = self.m_mainTabController:getSelectedIndex() == var_0_6 and (var_11_0 == var_0_8 and (self._guildRank ~= nil and #self._guildRank or 0) or self._personRank ~= nil and #self._personRank or 0) or var_11_0 == var_0_8 and #self._guildAward or #self._personAward

	if var_11_1 > 0 then
		self.m_isEmptyController:setSelectedIndex(0)
		self.m_rankList:setNumItems(var_11_1)
	else
		self.m_isEmptyController:setSelectedIndex(1)
	end
end

function GuildBossRankAwardPop:_changeSubTabUI()
	if self.m_subTabController:getSelectedIndex() == var_0_8 then
		if self._selfRankGuildDamage > 0 then
			self.m_numTxt:setText(self._selfRankGuildDamage)
		else
			self.m_numTxt:setText(g.core.lang:get(306501))
		end
	elseif self._selfRankPersonDamage > 0 then
		self.m_numTxt:setText(self._selfRankPersonDamage)
	else
		self.m_numTxt:setText(g.core.lang:get(306501))
	end
end

function GuildBossRankAwardPop:_refreshAward(arg_13_1)
	if next(arg_13_1) then
		for iter_13_0 = 1, 3 do
			if arg_13_1[iter_13_0] then
				self["m_res" .. iter_13_0]:setVisible(true)
				self["m_res" .. iter_13_0]:updateByTVS(arg_13_1[iter_13_0])
			else
				self["m_res" .. iter_13_0]:setVisible(false)
			end
		end
	end
end

function GuildBossRankAwardPop:_onMainTabRankChange(arg_14_1)
	self:_refreshListView()
end

function GuildBossRankAwardPop:_onSubTabRankChange(arg_15_1)
	self:_changeSubTabUI()
	self:_refreshListView()
end

function GuildBossRankAwardPop:_onNetGetRankList(arg_16_1, arg_16_2, arg_16_3)
	if not arg_16_3.rank_units then
		return
	end

	local var_16_0 = self.m_mainTabController:getSelectedIndex()
	local var_16_1 = self.m_subTabController:getSelectedIndex()

	if arg_16_3.id == g.core.network.proto.GUILD_BOSS_USER_LOCAL or arg_16_3.id == g.core.network.proto.GUILD_BOSS_USER_CROSS then
		self._personRank = arg_16_3.rank_units
		self._selfRankPersonDamage = arg_16_3.self_rank

		table.sort(self._personRank, function(arg_17_0, arg_17_1)
			return arg_17_0.rank < arg_17_1.rank
		end)

		self._selfPersonAward = self:_getSelfAward(self._selfRankPersonDamage, var_0_9)

		self:_changeSubTabUI()

		if var_16_0 == var_0_6 and var_16_1 == var_0_9 then
			self:_refreshListView()
		end
	elseif arg_16_3.id == g.core.network.proto.GUILD_BOSS_GUILD_LOCAL or arg_16_3.id == g.core.network.proto.GUILD_BOSS_GUILD_CROSS then
		self._guildRank = arg_16_3.rank_units
		self._selfRankGuildDamage = arg_16_3.self_rank

		table.sort(self._guildRank, function(arg_18_0, arg_18_1)
			return arg_18_0.rank < arg_18_1.rank
		end)

		self._selfGuildAward = self:_getSelfAward(self._selfRankGuildDamage, var_0_8)

		self:_changeSubTabUI()

		if var_16_0 == var_0_6 and var_16_1 == var_0_8 then
			self:_refreshListView()
		end
	end
end

function GuildBossRankAwardPop:_getSelfAward(arg_19_1, arg_19_2)
	if arg_19_2 == var_0_8 then
		for iter_19_0, iter_19_1 in pairs(self._guildAward) do
			if arg_19_1 >= iter_19_1.minRank and arg_19_1 <= iter_19_1.maxRank then
				return iter_19_1.data or {}
			end
		end
	else
		for iter_19_2, iter_19_3 in pairs(self._personAward) do
			if arg_19_1 >= iter_19_3.minRank and arg_19_1 <= iter_19_3.maxRank then
				return iter_19_3.data or {}
			end
		end
	end

	return {}
end

return GuildBossRankAwardPop

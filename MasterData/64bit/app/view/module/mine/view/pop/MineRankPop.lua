local RankAward = require("app.core.common.RankAward")
local MineRankPop = class("MineRankPop", require("app.fairyGUI.mine.UI_MineRankPop"), function()
	return fgui.GComponent:create({
		resName = "MineRankPop",
		pkgName = "mine",
		isFullScreen = true,
		pkgPath = "ui/mine/mine"
	})
end)

function MineRankPop:ctor()
	self:addBg("bg/common/pic_bb_beijing.jpg")

	self._selfRank = 0
	self._selfRankList = {}
	self._rankAwardInfo = {}
	self._selfGuildRank = 0
	self._topInit = {
		false,
		false
	}
	self._leftInit = {
		true,
		false
	}

	self.m_rankList:setVirtual()
	self.m_rankList:setItemRenderer(handler(self, self._onRankListRenderer))
	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onAwardListRenderer))
	self.m_guildRankList:setVirtual()
	self.m_guildRankList:setItemRenderer(handler(self, self._onGuildRankRenderer))
	self.m_guildRankList:doFairyBatching(false)
	self.m_awardList:doFairyBatching(false)
	self.m_topTypeController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onTopTypeClick))
	self.m_leftTypeController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onLeftTypeClick))
end

function MineRankPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_COMMON_RANK_LIST, self._rcvRankList, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, self.updateRankList, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_GUILD_SNAP_SHOT, self.updateRankList, self)
	self:reqSelfRank()
end

function MineRankPop:_onTopTypeClick()
	if self.m_topTypeController:getSelectedIndex() == 1 then
		if self._topInit[2] then
			self:checkEmptyState(#self._rankAwardInfo)

			return
		end

		self._topInit[2] = true
		self._rankAwardInfo = RankAward:getRankAwardArray(g.core.const.ConstMgr.RankAwardConst.MINE_PERSON_RANK)

		self.m_awardList:setNumItems(#self._rankAwardInfo)
		self:checkEmptyState(#self._rankAwardInfo)
	else
		self:checkEmptyState(#self._selfRankList)
	end
end

function MineRankPop:_onLeftTypeClick()
	local var_5_0 = self.m_leftTypeController:getSelectedIndex()

	if self._leftInit[var_5_0 + 1] then
		self:updateTabView()
	else
		self._leftInit[var_5_0 + 1] = true
		self._cityList = g.core.model.User.mineData:getNotCapitalCityList(true)

		local var_5_1 = 0
		local var_5_2
		local var_5_3 = g.core.model.User:getUserData()

		for iter_5_0, iter_5_1 in ipairs(self._cityList) do
			local var_5_4 = iter_5_1:getGuildData()

			if var_5_4 and var_5_4.id == var_5_3.guild_id then
				var_5_2 = iter_5_1
				var_5_1 = iter_5_0

				self.m_cityNameTxt:setText(iter_5_1:getCfg().name)

				break
			end
		end

		if var_5_2 then
			self._selfGuildRank = var_5_1
		end

		self:updateTabView()
	end

	if var_5_0 == 1 then
		self.m_guildRankList:setNumItems(#self._cityList)
		self:checkEmptyState(#self._cityList)
		self.m_guildRankList:transitionShowCells("enter_left", 0.03, 1)
	elseif self.m_topTypeController:getSelectedIndex() == 0 then
		self.m_rankList:setNumItems(#self._selfRankList)
		self:checkEmptyState(#self._selfRankList)
		self.m_rankList:transitionShowCells("enter_left", 0.03, 1)
	else
		self.m_awardList:setNumItems(#self._rankAwardInfo)
		self:checkEmptyState(#self._rankAwardInfo)
		self.m_awardList:transitionShowCells("enter_left", 0.03, 1)
	end
end

function MineRankPop:checkEmptyState(arg_6_1)
	if arg_6_1 == 0 then
		self.m_emptyController:setSelectedIndex(1)
	else
		self.m_emptyController:setSelectedIndex(0)
	end
end

function MineRankPop:_onGuildRankRenderer(arg_7_1, arg_7_2)
	arg_7_2:updateCell(self._cityList[arg_7_1 + 1], arg_7_1 + 1)
end

function MineRankPop:updateTabView()
	if self.m_leftTypeController:getSelectedIndex() == 1 then
		if self._selfGuildRank ~= 0 then
			self.m_rankTxt:setText(self._selfGuildRank)
			self.m_hasRankController:setSelectedIndex(0)
		else
			self.m_hasRankController:setSelectedIndex(1)
		end
	elseif self._selfRank ~= 0 then
		self.m_rankTxt:setText(self._selfRank)
		self.m_hasRankController:setSelectedIndex(0)
	else
		self.m_hasRankController:setSelectedIndex(1)
	end
end

function MineRankPop:_onAwardListRenderer(arg_9_1, arg_9_2)
	arg_9_2:updateCell(self._rankAwardInfo[arg_9_1 + 1], arg_9_1 + 1)
end

function MineRankPop:reqSelfRank()
	if self._topInit[1] then
		return
	end

	self._topInit[1] = true

	local var_10_0 = {
		g.core.network.proto.MINE_GOLD_CROSS,
		g.core.network.proto.MINE_GOLD_LOCAL
	}

	if (g.core.model.User.mineData:getActivtyType() or g.core.const.ConstMgr.MineConst.ACTIVITY_TYPE.CROSS_SERVER) == g.core.const.ConstMgr.MineConst.ACTIVITY_TYPE.CROSS_SERVER then
		g.core.network.GameNetProxy:send_C2S_GetCommonRankList({
			size = 100,
			id = var_10_0[1]
		})
	elseif var_10_0[2] then
		g.core.network.GameNetProxy:send_C2S_GetCommonRankList({
			size = 100,
			id = var_10_0[2]
		})
	end
end

function MineRankPop:_onRankListRenderer(arg_11_1, arg_11_2)
	if self._selfRankList[arg_11_1 + 1] then
		arg_11_2:updateCell({
			rankUnit = self._selfRankList[arg_11_1 + 1],
			selfRank = self._selfRank
		}, arg_11_1 + 1)
	end
end

function MineRankPop:_rcvRankList(arg_12_1, arg_12_2, arg_12_3)
	local var_12_1 = arg_12_3.rank_units or {}

	self._selfRank = arg_12_3.self_rank or 0
	self._selfRankList = var_12_1 or {}

	self.m_rankList:setNumItems(#var_12_1)
	self:checkEmptyState(#var_12_1)
	self.m_rankList:transitionShowCells("enter_left", 0.03, 1)
	self:updateTabView()
end

function MineRankPop:updateRankList()
	self.m_rankList:setNumItems(#self._selfRankList)
end

return MineRankPop

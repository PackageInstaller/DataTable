local AncientsCoopTeamRankPop = class("AncientsCoopTeamRankPop", require("app.fairyGUI.ancients.UI_AncientsCoopTeamRankPop"), function()
	return fgui.GComponent:create({
		resName = "AncientsCoopTeamRankPop",
		pkgPath = "ui/ancients/ancients",
		isFullScreen = true,
		pkgName = "ancients"
	}, ...)
end)

function var_0_0:ctor()
	self:addBg("bg/common/pic_bb_beijing.jpg")
	self.m_List_rank:setVirtual(self)
	self.m_List_rank:setItemRenderer(handler(self, self._onRenderListRankCell))
	self.m_List_reward:setVirtual(self)
	self.m_List_reward:setItemRenderer(handler(self, self._onRenderListRewardCell))
	self.m_tabController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onTabChange))
	self.m_topBarComp:setResInfoById(g.core.const.ConstMgr.AncientsConst.TopBarId)

	self._selfRank = 0
	self._rankArr = {}

	local var_2_0 = g.core.model.User.ancientsData:getAncientsInfo()

	self._rewardArr = g.core.common.RankAward:getRankAwardArray(g.core.const.ConstMgr.RankAwardConst.ANCIENTS, var_2_0.rank_group)
	self._finalRewardArr = g.core.common.RankAward:getRankAwardArray(g.core.const.ConstMgr.RankAwardConst.ANCIENTS_FINAL, var_2_0.knockout_rank)
end

function var_0_0:onLoad()
	g.core.network.GameNetProxy:send_C2S_Ancient_GetRankList({
		limit = g.core.config.ancients_parameter_info.get(27).parameter
	})
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ANCIENT_GETRANKLIST, handler(self, self._onRevGetRankList), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, handler(self, self._updateView), self)
end

function var_0_0:_onRevGetRankList(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	self._selfRank = arg_4_4.self_rank or 0
	self._rankArr = arg_4_4.rank_units or {}

	self:_updateView()
end

function var_0_0:_updateView()
	self.m_rankTxt:setText(self._selfRank == 0 and g.core.lang:get(1157) or self._selfRank)
	self.m_teamScoreTxt:setText(g.core.model.User.ancientsData:getTeamScore())
	self.m_selfScoreTxt:setText(g.core.model.User.ancientsData:getSelfScore())
	self.m_List_rank:setNumItems(#self._rankArr)
	self.m_is_emptyController:setSelectedIndex(#self._rankArr > 0 and 0 or 1)
end

function var_0_0:_onRenderListRankCell(arg_6_1, arg_6_2)
	arg_6_2:updateCell(self._rankArr[arg_6_1 + 1], arg_6_1)
end

function var_0_0:_onRenderListRewardCell(arg_7_1, arg_7_2)
	local var_7_0 = self.m_tabController:getSelectedIndex()

	if var_7_0 == 1 then
		arg_7_2:updateCell({
			award = self._rewardArr[arg_7_1 + 1],
			selfRank = self._selfRank,
			index = arg_7_1,
			tabIndex = var_7_0
		})
	elseif var_7_0 == 2 then
		arg_7_2:updateCell({
			award = self._finalRewardArr[arg_7_1 + 1],
			index = arg_7_1,
			tabIndex = var_7_0
		})
	end
end

function var_0_0:_onTabChange()
	local var_8_0 = self.m_tabController:getSelectedIndex()

	if var_8_0 == 1 then
		self.m_List_reward:setNumItems(#self._rewardArr)
	elseif var_8_0 == 2 then
		self.m_List_reward:setNumItems(#self._finalRewardArr)
	end
end

return var_0_0

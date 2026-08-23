local var_0_0 = g.core.event.enum
local var_0_1 = g.core.event.EventManager
local var_0_2 = g.core.network.GameNetProxy
local var_0_3 = g.core.model.User.explorationData
local var_0_4 = g.core.const.ConstMgr.ExplorationConst
local var_0_5 = g.core.network.proto
local ExplorationRankLayer = class("ExplorationRankLayer", require("app.fairyGUI.exploration.UI_ExplorationRankLayer"), function()
	return fgui.GComponent:create({
		isFullScreen = true,
		pkgPath = "ui/exploration/exploration",
		resName = "ExplorationRankLayer",
		pkgName = "exploration"
	}, ...)
end)

function ExplorationRankLayer:ctor()
	self._rankType = 0
	self._showType = 0
	self._clearRankList = {}
	self._damageRankList = {}
	self._guildRankList = {}
	self._myClearRank = 0
	self._myDamageRank = 0
	self._myGuildRank = 0
	self._showRewardList = {}

	self.m_rankTypeController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onRankTypeChanged))
	self.m_showTypeController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onShowTypeChanged))
	self.m_clearRankList:setVirtual()
	self.m_clearRankList:setItemRenderer(handler(self, self._onRenderClearRank))
	self.m_damageRankList:setVirtual()
	self.m_damageRankList:setItemRenderer(handler(self, self._onRenderDamageRank))
	self.m_guildRankList:setVirtual()
	self.m_guildRankList:setItemRenderer(handler(self, self._onRenderGuildRank))
	self.m_rewardList:setVirtual()
	self.m_rewardList:doFairyBatching(false)
	self.m_rewardList:setItemRenderer(handler(self, self._onRenderRewardList))
	self:addBg("bg/common/pic_bb_beijing.jpg")
	self.m_stageController:setSelectedIndex(0)
end

function ExplorationRankLayer:_onRankTypeChanged()
	self._rankType = self.m_rankTypeController:getSelectedIndex()

	self:_updateView()
end

function ExplorationRankLayer:_onShowTypeChanged()
	self._showType = self.m_showTypeController:getSelectedIndex()

	self:_updateView()
end

function ExplorationRankLayer:_updateView()
	if self._showType == 0 then
		self:_updateRankList()
	else
		self._showRewardList = var_0_3:getRewardListByType(self._rankType)

		self.m_rewardList:setNumItems(#self._showRewardList)
	end

	self:_updateMyRank()
end

function ExplorationRankLayer:_updateMyRank()
	if self._rankType == var_0_4.RANK_TYPE.CLEAR then
		if self._myClearRank > 0 then
			self.m_rankTxt:setText(g.core.lang:get(420661, {
				rank = self._myClearRank
			}))
		else
			self.m_rankTxt:setText(g.core.lang:get(420660))
		end
	elseif self._rankType == var_0_4.RANK_TYPE.DAMAGE then
		if self._myDamageRank > 0 then
			self.m_rankTxt:setText(g.core.lang:get(420661, {
				rank = self._myDamageRank
			}))
		else
			self.m_rankTxt:setText(g.core.lang:get(420660))
		end
	elseif self._rankType == var_0_4.RANK_TYPE.GUILD then
		if self._myGuildRank > 0 then
			self.m_rankTxt:setText(g.core.lang:get(420662, {
				rank = self._myGuildRank
			}))
		else
			self.m_rankTxt:setText(g.core.lang:get(420660))
		end
	end
end

function ExplorationRankLayer:_onRenderClearRank(arg_7_1, arg_7_2)
	arg_7_2:updateCell(arg_7_1 + 1, (self._clearRankList[arg_7_1 + 1] or nil) and {
		user = self._clearRankList[arg_7_1 + 1].user,
		score = self._clearRankList[arg_7_1 + 1].score,
		id = self._clearRankList[arg_7_1 + 1].id
	})
end

function ExplorationRankLayer:_onRenderDamageRank(arg_8_1, arg_8_2)
	arg_8_2:updateCell(arg_8_1 + 1, (self._damageRankList[arg_8_1 + 1] or nil) and {
		user = self._damageRankList[arg_8_1 + 1].user,
		score = self._damageRankList[arg_8_1 + 1].score,
		id = self._damageRankList[arg_8_1 + 1].id
	})
end

function ExplorationRankLayer:_onRenderGuildRank(arg_9_1, arg_9_2)
	arg_9_2:updateCell(arg_9_1 + 1, (self._guildRankList[arg_9_1 + 1] or nil) and {
		guild = self._guildRankList[arg_9_1 + 1].guild,
		score = self._guildRankList[arg_9_1 + 1].score,
		id = self._guildRankList[arg_9_1 + 1].id
	})
end

function ExplorationRankLayer:_onRenderRewardList(arg_10_1, arg_10_2)
	arg_10_2:updateCell(arg_10_1, self._showRewardList[arg_10_1 + 1].minRank, self._showRewardList[arg_10_1 + 1].maxRank, self._showRewardList[arg_10_1 + 1].data)
end

function ExplorationRankLayer:_updateRankList()
	if self._rankType == var_0_4.RANK_TYPE.CLEAR then
		self.m_clearRankList:setNumItems(var_0_4.SHOW_RANK_SIZE)
	elseif self._rankType == var_0_4.RANK_TYPE.DAMAGE then
		self.m_damageRankList:setNumItems(var_0_4.SHOW_RANK_SIZE)
	elseif self._rankType == var_0_4.RANK_TYPE.GUILD then
		self.m_guildRankList:setNumItems(var_0_4.SHOW_RANK_SIZE)
	end
end

function ExplorationRankLayer:_updateRankData(arg_12_1, arg_12_2, arg_12_3)
	if arg_12_3.id == var_0_5.EXPLORATION_PASS_CROSS then
		self._clearRankList, self._myClearRank = var_0_3:getRankList(var_0_4.RANK_TYPE.CLEAR)
	elseif arg_12_3.id == var_0_5.EXPLORATION_BOSS_USER_CROSS then
		self._damageRankList, self._myDamageRank = var_0_3:getRankList(var_0_4.RANK_TYPE.DAMAGE)
	elseif arg_12_3.id == var_0_5.EXPLORATION_BOSS_GUILD_CROSS then
		self._guildRankList, self._myGuildRank = var_0_3:getRankList(var_0_4.RANK_TYPE.GUILD)
	end

	self:_updateView()

	local var_12_0 = var_0_3:getCurStage()

	if var_12_0 == var_0_4.OPEN_STATE.NORMAL then
		self.m_stageController:setSelectedIndex(var_0_3:getGameStage() - 1)
	elseif var_12_0 == var_0_4.OPEN_STATE.FINISH then
		self.m_stageController:setSelectedIndex(1)
	end
end

function ExplorationRankLayer:onLoad()
	var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_GET_COMMON_RANK_LIST, self._updateRankData, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, self._updateView, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_GUILD_SNAP_SHOT, self._updateView, self)
	var_0_2:send_C2S_GetCommonRankList({
		size = 50,
		id = var_0_5.EXPLORATION_PASS_CROSS
	})
	var_0_2:send_C2S_GetCommonRankList({
		size = 50,
		id = var_0_5.EXPLORATION_BOSS_USER_CROSS
	})
	var_0_2:send_C2S_GetCommonRankList({
		size = 50,
		id = var_0_5.EXPLORATION_BOSS_GUILD_CROSS
	})
end

return ExplorationRankLayer

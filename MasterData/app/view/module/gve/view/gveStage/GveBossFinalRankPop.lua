local var_0_0 = g.core.model.User.gveDataMgr
local RankAward = require("app.core.common.RankAward")
local var_0_2 = g.core.const.ConstMgr.GveConst
local GveBossFinalRankPop = class("GveBossFinalRankPop", require("app.fairyGUI.gve.UI_GveBossFinalRankPop"), function()
	return fgui.GComponent:create({
		resName = "GveBossFinalRankPop",
		pkgPath = "ui/gve/gve",
		isFullScreen = true,
		pkgName = "gve"
	}, ...)
end)

function GveBossFinalRankPop:ctor()
	self:addBg("bg/common/pic_bb_beijing.jpg")

	self._awardList = {}
	self._personRankData = {}
	self._guildDamageRank = {}

	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self.onAwardRenderer))
	self.m_rankList:setVirtual()
	self.m_rankList:setItemRenderer(handler(self, self._onRankRenderer))
	self.m_guildRankList:setVirtual()
	self.m_guildRankList:setItemRenderer(handler(self, self._onGuildRankRenderer))
	self.m_mainTabController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onMainTabControlChangedEvent))
	self.m_subTabController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onSubTabControlChangedEvent))
end

function GveBossFinalRankPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, self._updateRankView, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_GETSNAPSHOT, self._updateRankView, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_SEARCHLIST, self._updateRankView, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_G_VE_GETBOSSRANK, self._onRcvRank, self)
	g.core.network.GameNetProxy:send_C2S_GVE_GetBossRank({
		page = 1,
		boss_id = 0,
		rank_type = var_0_2.GVE_RANK_TYPE.BOSS9_USER_TOTAL_DAMAGE
	})
	g.core.network.GameNetProxy:send_C2S_GVE_GetBossRank({
		page = 1,
		boss_id = 0,
		rank_type = var_0_2.GVE_RANK_TYPE.BOSS9_ALLIANCE_TOTAL_DAMAGE
	})
end

function GveBossFinalRankPop:_onMainTabControlChangedEvent()
	self:_updateRankView(true)
end

function GveBossFinalRankPop:_onSubTabControlChangedEvent()
	self:_updateRankView(true)
end

function GveBossFinalRankPop:_updateRankView(arg_6_1)
	if self.m_mainTabController:getSelectedIndex() == 0 then
		if self.m_subTabController:getSelectedIndex() == 0 then
			self:updateGuildDamageRank()
		else
			self:updatePersonDamageRank()
		end
	elseif self.m_subTabController:getSelectedIndex() == 0 then
		self:updateRankReward(var_0_2.FINAL_BOSS_GUILD_RANK_TYPE)
	else
		self:updateRankReward(var_0_2.FINAL_BOSS_PERSON_RANK_TYPE)
	end

	if self.m_subTabController:getSelectedIndex() == 0 then
		local var_6_0 = var_0_0:getLastBossDamageGuildRank()

		if var_6_0 > 0 then
			self.m_numTxt:setText(var_6_0)
			self.m_hasRankController:setSelectedIndex(1)
		else
			self.m_hasRankController:setSelectedIndex(0)
		end
	else
		local var_6_1 = self._personRankData.self_rank or 0

		if var_6_1 > 0 then
			self.m_numTxt:setText(var_6_1)
			self.m_hasRankController:setSelectedIndex(1)
		else
			self.m_hasRankController:setSelectedIndex(0)
		end
	end
end

function GveBossFinalRankPop:updateGuildDamageRank()
	self._guildDamageRank = var_0_0:getLastBossDamageDataList()

	self.m_guildRankList:setNumItems(#self._guildDamageRank)
end

function GveBossFinalRankPop:updatePersonDamageRank()
	self.m_rankList:setNumItems((self._personRankData.rank_units or nil) and (#self._personRankData.rank_units or 0))
end

function GveBossFinalRankPop:_onRcvRank(arg_9_1, arg_9_2, arg_9_3)
	if arg_9_3.rank_type == var_0_2.GVE_RANK_TYPE.BOSS9_USER_TOTAL_DAMAGE then
		self:onGetPersonRank(arg_9_1, arg_9_2, arg_9_3)
	elseif arg_9_3.rank_type == var_0_2.GVE_RANK_TYPE.BOSS9_ALLIANCE_TOTAL_DAMAGE then
		self:onGetGuildRank(arg_9_1, arg_9_2, arg_9_3)
	end
end

function GveBossFinalRankPop:onGetGuildRank()
	self:_updateRankView()
end

function GveBossFinalRankPop:onGetPersonRank(arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = {
		rank_units = arg_11_3.data
	}

	if arg_11_3.self_data then
		var_11_0.self_rank = arg_11_3.self_data.rank or 0
	end

	self._personRankData = var_11_0

	self:_updateRankView()
end

function GveBossFinalRankPop:_onGuildRankRenderer(arg_12_1, arg_12_2)
	arg_12_2:updateBossGuildRank(self._guildDamageRank[arg_12_1 + 1], arg_12_1 + 1)
	arg_12_2:setCtrlState("bg", {
		index = arg_12_1 % 2 ~= 0 and 1 or 0
	})
end

function GveBossFinalRankPop:_onRankRenderer(arg_13_1, arg_13_2)
	arg_13_2:updateCell(self._personRankData.rank_units[arg_13_1 + 1], arg_13_1 + 1)
	arg_13_2:setCtrlState("showBg", {
		index = arg_13_1 % 2 ~= 0 and 1 or 0
	})
end

function GveBossFinalRankPop:onAwardRenderer(arg_14_1, arg_14_2)
	arg_14_2:updateCell((self._awardList[self._rankType] or {})[arg_14_1 + 1])
	arg_14_2:setCtrlState("showBg", {
		index = arg_14_1 % 2 ~= 0 and 1 or 0
	})
end

function GveBossFinalRankPop:updateRankReward(arg_15_1)
	self._rankType = arg_15_1
	self._awardList[arg_15_1] = self._awardList[arg_15_1] or RankAward:getRankAwardArray(arg_15_1, var_0_0:getGveBaseId())

	self.m_awardList:setNumItems(#self._awardList[arg_15_1])
end

return GveBossFinalRankPop

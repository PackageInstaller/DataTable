local var_0_0 = g.core.model.User.gveDataMgr
local RankAward = require("app.core.common.RankAward")
local var_0_2 = {
	TOTAL = 2,
	ONCE = 1
}
local GveBossRankPop = class("GveBossRankPop", require("app.fairyGUI.gve.UI_GveBossRankPop"), function()
	return fgui.GComponent:create({
		resName = "GveBossRankPop",
		pkgPath = "ui/gve/gve",
		isFullScreen = true,
		pkgName = "gve"
	}, ...)
end)

function GveBossRankPop:ctor(arg_2_1)
	self._bossData = arg_2_1
	self._rankIndex = {
		[var_0_2.ONCE] = 1,
		[var_0_2.TOTAL] = 1
	}
	self._rankMaxIndex = {}
	self._rankType = var_0_2.TOTAL
	self._rankList = {}
	self._rankMap = {}
	self._myRankList = {}
	self._awardList = {}

	self:initView()
end

function GveBossRankPop:initView()
	self.m_topBarComp:setResInfoById(g.core.const.ConstMgr.HelpConst.HELP_TYPE.GVE_RANK_POP)
	self:addBg("bg/common/pic_bb_beijing.jpg")

	local var_3_0 = cc.Director:getInstance():getSafeAreaRect()
	local var_3_1 = self.m_rankList:getWidth() * (display.width / CC_DESIGN_RESOLUTION.width)

	if var_3_0.x > 0 then
		var_3_1 = var_3_1 - var_3_0.x
	end

	self.m_rankList:setWidth(var_3_1)
	self.m_awardList:setWidth(var_3_1)
	self.m_rankList:setVirtual()
	self.m_rankList:setItemRenderer(handler(self, self._onRankRenderer))
	self.m_rankList:addEventListener(fgui.UIEventType.PullUpRelease, handler(self, self._onPullUpRelease))
	self.m_rankList:doFairyBatching(false)
	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onAwardRenderer))
	self.m_subTabController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onSubTabRankChange))
	self.m_mainTabController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onMainTabRankChange))

	if self._bossData:getInfo().rank_award_2 > 0 then
		self.m_tabCountController:setSelectedIndex(1)
	else
		self.m_tabCountController:setSelectedIndex(0)
	end
end

function GveBossRankPop:_onMainTabRankChange()
	self:updateView()
end

function GveBossRankPop:_onSubTabRankChange()
	self._rankType = self.m_subTabController:getSelectedIndex() == 0 and var_0_2.TOTAL or var_0_2.ONCE

	self:updateView()
end

function GveBossRankPop:_onPullUpRelease()
	if self.m_rankList:getScrollPane():getFooter():getHeight() > 100 then
		if self._rankIndex[self._rankType] + 1 <= (self._rankMaxIndex[self._rankType] or 1) then
			g.core.network.GameNetProxy:send_C2S_GVE_GetBossRank({
				rank_type = self._rankType,
				boss_id = self._bossData:getInfo().id,
				page = self._rankIndex[self._rankType] + 1
			})
		else
			g.core.module.ModuleManager:tip(g.core.lang:get(309021))
		end
	end
end

function GveBossRankPop:_onRankRenderer(arg_7_1, arg_7_2)
	arg_7_2:updateCell((self._rankList[self._rankType] or {})[arg_7_1 + 1], arg_7_1 + 1)
	arg_7_2:setCtrlState("showBg", {
		index = arg_7_1 % 2 ~= 0 and 1 or 0
	})
end

function GveBossRankPop:_onAwardRenderer(arg_8_1, arg_8_2)
	arg_8_2:updateCell((self._awardList[self._rankType] or {})[arg_8_1 + 1])
	arg_8_2:setCtrlState("showBg", {
		index = arg_8_1 % 2 ~= 0 and 1 or 0
	})
end

function GveBossRankPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_G_VE_GETBOSSRANK, self._onRcvRank, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, self.updateView, self)
	g.core.network.GameNetProxy:send_C2S_GVE_GetBossRank({
		rank_type = self._rankType,
		boss_id = self._bossData:getInfo().id,
		page = self._rankIndex[self._rankType]
	})
end

function GveBossRankPop:updateView()
	if self.m_mainTabController:getSelectedIndex() == 0 then
		if not self._rankList[self._rankType] then
			g.core.network.GameNetProxy:send_C2S_GVE_GetBossRank({
				rank_type = self._rankType,
				boss_id = self._bossData:getInfo().id,
				page = self._rankIndex[self._rankType]
			})
		else
			local var_10_0 = #self._rankList[self._rankType]

			self.m_rankList:setNumItems(#self._rankList[self._rankType])
			self.m_emptyController:setSelectedIndex(var_10_0 == 0 and 1 or 0)
		end
	else
		self._awardList[self._rankType] = self._awardList[self._rankType] or RankAward:getRankAwardArray((self._rankType == var_0_2.TOTAL or nil) and (self._bossData:getInfo().rank_award_1 or self._bossData:getInfo().rank_award_2), var_0_0:getGveBaseId())

		self.m_awardList:setNumItems(#self._awardList[self._rankType])
		self.m_emptyController:setSelectedIndex(0)
	end

	self.m_rankTip:setText(g.core.lang:get(self._rankType == var_0_2.TOTAL and 309004 or 309005, {
		name = self._bossData:getInfo().name
	}))

	local var_10_2 = (self._myRankList[self._rankType] or {}).rank or 0

	if var_10_2 == 0 then
		self.m_hasRankController:setSelectedIndex(0)
	else
		self.m_hasRankController:setSelectedIndex(1)
		self.m_numTxt:setText(var_10_2)
	end
end

function GveBossRankPop:_onRcvRank(arg_11_1, arg_11_2, arg_11_3)
	if arg_11_3.boss_id ~= self._bossData:getInfo().id then
		return
	end

	local var_11_0 = arg_11_3.rank_type

	self._rankIndex[var_11_0] = arg_11_3.page or 1
	self._rankMaxIndex[var_11_0] = arg_11_3.total_page or 1
	self._myRankList[var_11_0] = arg_11_3.self_data or {}

	local var_11_1 = {}
	local var_11_2 = self._rankList[var_11_0] or {}

	for iter_11_0, iter_11_1 in pairs(var_11_2) do
		var_11_1[iter_11_1.id] = iter_11_0
	end

	for iter_11_2, iter_11_3 in pairs(arg_11_3.data or {}) do
		if iter_11_3.id then
			if var_11_1[iter_11_3.id] then
				var_11_2[var_11_1[iter_11_3.id]] = iter_11_3
			else
				table.insert(var_11_2, iter_11_3)
			end
		end
	end

	table.sort(var_11_2, function(arg_12_0, arg_12_1)
		local var_12_0 = arg_12_0.first or 0
		local var_12_1 = arg_12_1.first or 0

		if var_12_0 ~= var_12_1 then
			return var_12_1 < var_12_0
		end

		local var_12_2 = arg_12_0.second or 0
		local var_12_3 = arg_12_1.second or 0

		if var_12_2 ~= var_12_3 then
			return var_12_2 < var_12_3
		end

		return arg_12_0.rank < arg_12_1.rank
	end)

	self._rankList[var_11_0] = var_11_2

	if self._rankType == var_11_0 then
		self:updateView()
	end
end

return GveBossRankPop

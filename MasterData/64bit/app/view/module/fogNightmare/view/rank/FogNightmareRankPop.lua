local var_0_0 = g.core.model.User.fogNightmareData
local var_0_1 = g.core.const.ConstMgr.FogNightmareConst
local var_0_2 = g.core.const.ConstMgr.RankAwardConst
local RankAward = require("app.core.common.RankAward")
local var_0_4 = {
	REWARD = 1,
	RANK = 0
}
local FogNightmareRankPop = class("FogNightmareRankPop", require("app.fairyGUI.fogNightmare.UI_FogNightmareRankPop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/fogNightmare/fogNightmare",
		resName = "FogNightmareRankPop",
		pkgName = "fogNightmare",
		isFullScreen = true
	}, ...)
end)

function FogNightmareRankPop:ctor()
	self._rankList = nil
	self._rewardList = nil
	self._curTabIndex = var_0_4.RANK
	self._myRank = 0

	self:_initView()
end

function FogNightmareRankPop:_initView()
	self:addBg("bg/common/pic_bb_beijing.jpg")
	self.m_topBarComp:setResInfoById(g.core.const.ConstMgr.HelpConst.HELP_TYPE.FOG_NIGHTMARE)

	local var_3_0 = cc.Director:getInstance():getSafeAreaRect()
	local var_3_1 = self.m_rankList:getWidth() * (display.width / CC_DESIGN_RESOLUTION.width)

	if var_3_0.x > 0 then
		var_3_1 = var_3_1 - var_3_0.x * 2
	end

	self.m_rankList:setWidth(var_3_1)
	self.m_rewardList:setWidth(var_3_1)
	self.m_topBg1:setWidth(var_3_1)
	self.m_topBg2:setWidth(var_3_1)
	self.m_downBg:setWidth(var_3_1)
	self.m_rankList:setVirtual()
	self.m_rankList:setItemRenderer(handler(self, self._onRendererRankList))
	self.m_rewardList:setVirtual()
	self.m_rewardList:doFairyBatching(false)
	self.m_rewardList:setItemRenderer(handler(self, self._onRendererRewardList))
	self.m_showListController:setSelectedIndex(self._curTabIndex)
	self.m_showListController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onShowListChanged))
end

function FogNightmareRankPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_COMMON_RANK_LIST, self._onS2CRanklist, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, self.updateView, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FORMATION_GETOTHER, self._onS2CFormationGetOther, self)
	self:updateView()
end

function FogNightmareRankPop:_onShowListChanged()
	local var_5_0 = self.m_showListController:getSelectedIndex()

	if var_5_0 == self._curTabIndex then
		return
	end

	self._curTabIndex = var_5_0

	self:updateView()
end

function FogNightmareRankPop:_onS2CRanklist(arg_6_1, arg_6_2, arg_6_3)
	if arg_6_3 and arg_6_3.id == g.core.network.proto.FOG_CROSS_AREA then
		self._rankList = arg_6_3.rank_units or {}
		self._myRank = arg_6_3.self_rank or 0

		if self._curTabIndex == var_0_4.RANK then
			self:updateView()
		end
	end
end

function FogNightmareRankPop:updateView()
	if self._curTabIndex == var_0_4.RANK then
		if self._rankList == nil then
			g.core.network.GameNetProxy:send_C2S_GetCommonRankList({
				size = 100,
				id = g.core.network.proto.FOG_CROSS_AREA
			})
		else
			self.m_rankList:setNumItems(#self._rankList)
			self.m_rankList:transitionShowCells("enter_left", 0.03)
			self.m_hasRankListController:setSelectedIndex(#self._rankList > 0 and 1 or 0)
		end
	elseif self._curTabIndex == var_0_4.REWARD then
		if self._rewardList == nil then
			self._rewardList = RankAward:getRankAwardArray(var_0_2.FOG_NIGHTMARE, var_0_0:getActivitySubId())
		end

		self.m_rewardList:setNumItems(#self._rewardList)
		self.m_rewardList:transitionShowCells("enter_left", 0.03)
		self.m_hasRankListController:setSelectedIndex(#self._rewardList > 0 and 1 or 0)
	end

	if self._myRank <= 0 then
		if var_0_0:getTowerData():getHistoryMaxFloorNum() <= 0 then
			if var_0_0:getTowerData():getCurrentMaxFloorNum() > 0 then
				self.m_isMyRankController:setSelectedIndex(1)
				self.m_rankValueText:setText(var_0_1.SHOW_RANK_COUNT .. "+")

				goto label_7_0
			end
		end

		self.m_isMyRankController:setSelectedIndex(0)
	else
		self.m_isMyRankController:setSelectedIndex(1)
		self.m_rankValueText:setText(self._myRank)
	end

	::label_7_0::
end

function FogNightmareRankPop:_onS2CFormationGetOther(arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = g.core.model.User.fogNightmareData:getFormationData():getOtherFormationData()

	if #var_8_0 == 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(500228))

		return
	end

	local var_8_1

	for iter_8_0, iter_8_1 in ipairs(self._rankList) do
		if iter_8_1.id == arg_8_3.target_id then
			var_8_1 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, iter_8_1.id)

			if not var_8_1 then
				return
			end

			break
		end
	end

	local var_8_2 = require("app.view.module.fogNightmare.view.explore.pop.FogNightmareExploreOtherFormationPop").new

	g.core.module.ModuleManager:pushPopup((require("app.view.module.fogNightmare.view.explore.pop.FogNightmareExploreOtherFormationPop").new({
		formations = var_8_0,
		user = var_8_1
	})))
end

function FogNightmareRankPop:_onRendererRankList(arg_9_1, arg_9_2)
	arg_9_2:updateCell(self._rankList[arg_9_1 + 1])
	arg_9_2:setCtrlState("isShowBg", {
		index = arg_9_1 % 2 == 0 and 1 or 0
	})
end

function FogNightmareRankPop:_onRendererRewardList(arg_10_1, arg_10_2)
	arg_10_2:updateCell(self._rewardList[arg_10_1 + 1])
	arg_10_2:setCtrlState("isShowBg", {
		index = arg_10_1 % 2 == 0 and 1 or 0
	})
end

return FogNightmareRankPop

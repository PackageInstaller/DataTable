local var_0_0 = g.core.const.ConstMgr.PubgConst
local var_0_1 = g.core.model.User.pubgData
local PubgRankLayer = class("PubgRankLayer", require("app.fairyGUI.pubg.UI_PubgRankLayer"), function()
	return fgui.GComponent:create({
		pkgName = "pubg",
		isFullScreen = true,
		pkgPath = "ui/pubg/pubg",
		resName = "PubgRankLayer"
	}, ...)
end)

function PubgRankLayer:ctor(arg_2_1)
	self._rankList = {}
	self._rewardList = {}

	self:_initView()
	self:_initListView()
end

function PubgRankLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_COMMON_RANK_LIST, self._updateRankList, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, self._updateRankList, self)
	g.core.network.GameNetProxy:send_C2S_GetCommonRankList({
		id = var_0_0.RANK_TYPE,
		size = var_0_0.RANK_SHOW_SIZE
	})
end

function PubgRankLayer:_initListView()
	self.m_rankList:setVirtual()
	self.m_rankList:setItemRenderer(handler(self, self._onRenderRankList))
	self.m_rankList:doFairyBatching(false)
	self.m_rewardList:setVirtual()
	self.m_rewardList:setItemRenderer(handler(self, self._onRenderRewardList))
	self:_updateRankList()
end

function PubgRankLayer:_onRenderRankList(arg_5_1, arg_5_2)
	arg_5_2:updateCell(self._rankList[arg_5_1 + 1], arg_5_1)
end

function PubgRankLayer:_onRenderRewardList(arg_6_1, arg_6_2)
	arg_6_2:updateCell(self._rewardList[arg_6_1 + 1], arg_6_1)
end

function PubgRankLayer:_initView(arg_7_1)
	self:addBg("bg/common/pic_bb_beijing.jpg")

	local var_7_0, var_7_1 = var_0_1:getMyTotalRankAndScore()

	if var_7_0 > 0 then
		self.m_rankTxt:setText(g.core.lang:get(421100, {
			rank = var_7_0
		}))
	else
		self.m_rankTxt:setText(g.core.lang:get(421099))
	end

	self.m_topSelController:setSelectedIndex(0)
end

function PubgRankLayer:_updateRankList()
	self._rankList = var_0_1:getRankPlayerListByRankType(var_0_0.RANK_TYPE)
	self._rewardList = var_0_1:getRankRewardList()

	self.m_rankList:setNumItems(#self._rankList)
	self.m_rewardList:setNumItems(#self._rewardList)
	self.m_noPlayerComp:setVisible(#self._rankList == 0)
end

return PubgRankLayer

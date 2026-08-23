local var_0_0 = g.core.model.User.wushTowerData
local WushTowerRankPop = class("WushTowerRankPop", require("app.fairyGUI.wushTower.UI_WushTowerRankPop"), function()
	return fgui.GComponent:create({
		resName = "WushTowerRankPop",
		pkgName = "wushTower",
		isFullScreen = true,
		pkgPath = "ui/wushTower/wushTower"
	}, ...)
end)

function WushTowerRankPop:ctor()
	self.m_recordList:setVirtual()
	self.m_recordList:setItemRenderer(handler(self, self._onRecordListRenderer))
	self.m_topBarComp:setResInfoById(g.core.const.ConstMgr.WushTowerConst.WUSHTOWER_MAIN_TOPBAR)
	self:addBg("bg/common/pic_bb_beijing.jpg")
end

function WushTowerRankPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_COMMON_RANK_LIST, self._updateView, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, self._updateView, self)
	g.core.network.GameNetProxy:send_C2S_GetCommonRankList({
		size = 100,
		id = g.core.network.proto.DEAD_TOWER_LOCAL
	})
end

function WushTowerRankPop:_onRecordListRenderer(arg_4_1, arg_4_2)
	arg_4_2:updateCell(self:_isShowItemBg(arg_4_1), var_0_0:getRankArr()[arg_4_1 + 1])
end

function WushTowerRankPop:_updateView()
	local var_5_0 = var_0_0:getMyRanking()

	if var_5_0 > 0 then
		self.m_rankTxt:setText(var_5_0)
	else
		self.m_rankTxt:setText(g.core.lang:get(113014))
	end

	self.m_recordList:setNumItems(#var_0_0:getRankArr())
	self.m_recordList:transitionShowCells("enter_left", 0.03)
end

function WushTowerRankPop:_isShowItemBg(arg_6_1)
	return arg_6_1 % 2 ~= 0
end

return WushTowerRankPop

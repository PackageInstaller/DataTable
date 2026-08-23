local var_0_0 = g.core.event.EventManager
local var_0_1 = g.core.event.enum
local var_0_2 = g.core.network.GameNetProxy
local var_0_3 = g.core.model.User.redCliffData
local var_0_4 = g.core.const.ConstMgr.RedCliffConst
local RedCliffGrandUpgradePop = class("RedCliffGrandUpgradePop", require("app.fairyGUI.redCliff.UI_RedCliffGrandUpgradePop"), function()
	return fgui.GComponent:create({
		resName = "RedCliffGrandUpgradePop",
		pkgPath = "ui/redCliff/redCliff",
		pkgName = "redCliff"
	})
end)

function RedCliffGrandUpgradePop:ctor()
	self:showAtCenter()
	self.m_touchBg:addClickListener(handler(self, self._onClickTouchBg))

	self._playerList = {}

	self.m_playerList:setVirtual()
	self.m_playerList:setItemRenderer(handler(self, self._onRenderPlayerList))
end

function RedCliffGrandUpgradePop:_onClickTouchBg()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function RedCliffGrandUpgradePop:_onRenderPlayerList(arg_4_1, arg_4_2)
	arg_4_2:updateGrandCell(self._playerList[arg_4_1 + 1], arg_4_1)
end

function RedCliffGrandUpgradePop:_onRcvPromotionList(arg_5_1, arg_5_2, arg_5_3)
	self._playerList = var_0_3:getRankListByRankType(g.core.network.proto.CHIBI_ACHIEVEMENT_ALL_SERVER)

	self.m_playerList:setNumItems(#self._playerList)
end

function RedCliffGrandUpgradePop:onLoad()
	var_0_0:addEventListener(var_0_1.EVENT_NET_S2C_GET_COMMON_RANK_LIST, self._onRcvPromotionList, self)
	var_0_0:addEventListener(var_0_1.EVENT_NET_S2C_GET_USER_SNAP_SHOT, self._onRcvPromotionList, self)
	var_0_2:send_C2S_GetCommonRankList({
		id = g.core.network.proto.CHIBI_ACHIEVEMENT_ALL_SERVER,
		size = var_0_4.RANK_SHOW_SIZE.ALL_SERVER
	})
	self.m_enterTransition:play()
end

function RedCliffGrandUpgradePop:onUnload()
	self.m_backTransition:play()
end

return RedCliffGrandUpgradePop

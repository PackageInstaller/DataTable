local var_0_0 = g.core.model.User.knightSoulData
local var_0_1 = g.core.const.ConstMgr.KnightSoulConst
local KnightSoulRankLayer = class("KnightSoulRankLayer", require("app.fairyGUI.knightSoul.UI_KnightSoulRankLayer"), function()
	return fgui.GComponent:create({
		resName = "KnightSoulRankLayer",
		pkgPath = "ui/knightSoul/knightSoul",
		isFullScreen = true,
		pkgName = "knightSoul"
	}, ...)
end)

function KnightSoulRankLayer:ctor()
	self:_initRegisterUI()
end

function KnightSoulRankLayer:_initRegisterUI()
	self:addBg("bg/common/pic_bb_beijing.jpg")

	self._tabIndex = 0
	self._rankList = {}

	self.m_rankList:setVirtual()
	self.m_rankList:setItemRenderer(handler(self, self._onRankItemRender))
	self.m_typeController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onTypeCtrlChanged))
	self.m_bookNumTxt:setText(var_0_0:getCurActivateBookNum())
	self.m_honorNumTxt:setText(var_0_0:getCurHonorNum())
end

function KnightSoulRankLayer:_updateRankList()
	self._rankList = var_0_0:getRankListByType(self._tabIndex)

	self.m_rankList:setNumItems(var_0_1.SHOW_RANK_NUM)
	self.m_rankList:transitionShowCells("enter_left", 0.03)

	local var_4_0 = var_0_0:getRankByType(self._tabIndex)

	if var_4_0 > 0 then
		self.m_rankTxt:setText(var_4_0)
	else
		self.m_rankTxt:setText(g.core.lang:get(410623))
	end
end

function KnightSoulRankLayer:_onRankOrRewardChanged()
	self:_updateRankList()
end

function KnightSoulRankLayer:_onTypeCtrlChanged()
	self._tabIndex = self.m_typeController:getSelectedIndex()

	self:_updateRankList()
end

function KnightSoulRankLayer:_onRankItemRender(arg_7_1, arg_7_2)
	arg_7_2:updateRankCell((self._rankList[arg_7_1 + 1] or nil) and self._rankList[arg_7_1 + 1], self._tabIndex, arg_7_1 + 1)
end

function KnightSoulRankLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_COMMON_RANK_LIST, self._onRcvRankInfo, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, self._onRcvUserInfo, self)
	g.core.network.GameNetProxy:send_C2S_GetCommonRankList({
		size = 100,
		id = g.core.network.proto.KSOUL_HONOR_LOCAL
	})
	g.core.network.GameNetProxy:send_C2S_GetCommonRankList({
		size = 100,
		id = g.core.network.proto.KSOUL_HONOR_CROSS
	})
end

function KnightSoulRankLayer:_onRcvRankInfo()
	self:_updateRankList()
end

function KnightSoulRankLayer:_onRcvUserInfo()
	self.m_rankList:setNumItems(var_0_1.SHOW_RANK_NUM)
end

return KnightSoulRankLayer

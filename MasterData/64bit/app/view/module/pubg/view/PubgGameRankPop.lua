local var_0_0 = g.core.model.User.pubgData
local PubgGameRankPop = class("PubgGameRankPop", require("app.fairyGUI.pubg.UI_PubgGameRankPop"), function()
	return fgui.GComponent:create({
		pkgName = "pubg",
		resName = "PubgGameRankPop"
	}, ...)
end)

function PubgGameRankPop:ctor(arg_2_1)
	self._playerList = {}

	self:_initBtn()
	self:_initListView()
	self:showAtCenter()
end

function PubgGameRankPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, self._updateRankList, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PUBG_SERVERINFOS, self._updateRankList, self)
	self.m_enterTransition:play()
end

function PubgGameRankPop:_initBtn()
	self.m_playerList:setNumItems(#self._playerList)
	self.m_touchBg:addClickListener(handler(self, self._onClickClose))
end

function PubgGameRankPop:_initListView()
	self.m_playerList:setVirtual()
	self.m_playerList:setItemRenderer(handler(self, self._onRenderPlayerList))
	self.m_playerList:doFairyBatching(false)
	self:_updateRankList()
end

function PubgGameRankPop:_onRenderPlayerList(arg_6_1, arg_6_2)
	arg_6_2:updateCell(self._playerList[arg_6_1 + 1], arg_6_1)
end

function PubgGameRankPop:_updateRankList()
	self._playerList = var_0_0:getGamePlayerList()

	self.m_playerList:setNumItems(#self._playerList)
end

function PubgGameRankPop:_onClickClose()
	if self._isClose then
		return
	end

	self._isClose = true

	self.m_backTransition:play(handler(self, self.switchModule))
end

function PubgGameRankPop:switchModule()
	g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.PUBG_MAIN_LAYER)
end

return PubgGameRankPop

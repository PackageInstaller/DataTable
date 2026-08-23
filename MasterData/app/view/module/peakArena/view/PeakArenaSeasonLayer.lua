local var_0_0 = g.core.const.ConstMgr.PeakArenaConst
local var_0_1 = g.core.model.User.peakArenaData
local var_0_2 = g.core.event.EventManager
local var_0_3 = g.core.event.enum
local PeakArenaSeasonLayer = class("PeakArenaSeasonLayer", require("app.fairyGUI.peakArena.UI_PeakArenaSeasonLayer"), function()
	return fgui.GComponent:create({
		resName = "PeakArenaSeasonLayer",
		pkgPath = "ui/peakArena/peakArena",
		isFullScreen = true,
		pkgName = "peakArena"
	}, ...)
end)

function PeakArenaSeasonLayer:ctor()
	self._showList = {}

	self:showAtCenter()
	self:addBg("bg/peakArena/bg_wzjj.jpg")
	self.m_topBarComp:setResInfoById(var_0_0.TOP_BAR_ID)
	self.m_seasonList:setVirtual()
	self.m_seasonList:setItemRenderer(handler(self, self._onRendererSeasonList))
end

function PeakArenaSeasonLayer:_onRendererSeasonList(arg_3_1, arg_3_2)
	arg_3_2:update(self._showList[arg_3_1 + 1])
end

function PeakArenaSeasonLayer:onLoad()
	var_0_2:addEventListener(var_0_3.EVENT_NET_S2C_PEAK_ARENA_GETHISTORYS, self._updateView, self)
	var_0_2:addEventListener(var_0_3.EVENT_NET_S2C_GET_USER_SNAP_SHOT, handler(self, self._onS2CUserSnapshot), self)
	g.core.network.GameNetProxy:send_C2S_PeakArena_GetHistorys({})
end

function PeakArenaSeasonLayer:_onS2CUserSnapshot()
	self.m_seasonList:setNumItems(#self._showList)
end

function PeakArenaSeasonLayer:_updateView()
	self._showList = var_0_1:getPeakArenaHistory()

	self.m_seasonList:setNumItems(#self._showList)
end

return PeakArenaSeasonLayer

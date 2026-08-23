local var_0_0 = g.core.event.enum
local var_0_1 = g.core.const.ConstMgr.PeakArenaConst
local var_0_2 = g.core.const.ConstMgr.PeakArenaConst.MatchRecordType
local var_0_3 = g.core.event.EventManager
local var_0_4 = g.core.model.User.peakArenaData
local PeakArenaMatchRecordLayer = class("PeakArenaMatchRecordLayer", require("app.fairyGUI.peakArena.UI_PeakArenaMatchRecordLayer"), function()
	return fgui.GComponent:create({
		resName = "PeakArenaMatchRecordLayer",
		pkgPath = "ui/peakArena/peakArena",
		isFullScreen = true,
		pkgName = "peakArena"
	}, ...)
end)

function PeakArenaMatchRecordLayer:ctor()
	self._recordArr = {}
	self._curTab = 1

	self.m_tabSelController:setSelectedIndex(0)
	self:addBg("bg/arena/bg_jjc_zhujiemian.jpg")
	self.m_topBarComp:setResInfoById(var_0_1.TOP_BAR_ID)
	self.m_recordList:setVirtual()
	self.m_recordList:setItemRenderer(handler(self, self._onRenderRecordList))
	self.m_tabSelController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onTabSelChanged))
	self:_onTabSelChanged()
end

function PeakArenaMatchRecordLayer:onLoad()
	var_0_4:resetRecordList()
	var_0_3:addEventListener(var_0_0.EVENT_NET_S2C_PEAK_ARENA_GETRECORDS, self._onS2CGetRecords, self)
	var_0_3:addEventListener(var_0_0.EVENT_NET_S2C_GET_USER_SNAP_SHOT, handler(self, self._onS2CUserSnapshot), self)
	self:_reqRecordInfo(self._curTab)
end

function PeakArenaMatchRecordLayer:_onRenderRecordList(arg_4_1, arg_4_2)
	arg_4_2:updateCell(self._recordArr[arg_4_1 + 1], self._curTab)
end

function PeakArenaMatchRecordLayer:_onTabSelChanged()
	self._curTab = self.m_tabSelController:getSelectedIndex() + 1

	local var_5_0 = var_0_4:getRecordArrWithType(self._curTab)

	if not var_5_0 then
		self.m_emptyController:setSelectedIndex(1)
		self:_reqRecordInfo(self._curTab)
	else
		self._recordArr = var_5_0

		local var_5_1 = #var_5_0

		self.m_emptyController:setSelectedIndex(#var_5_0 <= 0 and 1 or 0)
		self.m_recordList:setNumItems(var_5_1)

		if var_5_1 > 0 then
			self.m_recordList:scrollToView(0, false)
			self:_transShowListCells()
		end
	end
end

function PeakArenaMatchRecordLayer:onUnload()
	return
end

function PeakArenaMatchRecordLayer:_onS2CGetRecords(arg_7_1, arg_7_2, arg_7_3)
	if self._curTab == var_0_2.PERSONAL then
		local var_7_0 = var_0_4:getRecordArrWithType(var_0_2.PERSONAL) or {}

		self._recordArr = var_7_0

		local var_7_1 = #var_7_0

		self.m_emptyController:setSelectedIndex(#var_7_0 <= 0 and 1 or 0)
		self.m_recordList:setNumItems(var_7_1)

		if var_7_1 > 0 then
			self.m_recordList:scrollToView(0, false)
			self:_transShowListCells()
		end
	end
end

function PeakArenaMatchRecordLayer:_onS2CUserSnapshot()
	self.m_recordList:setNumItems(#self._recordArr)
end

function PeakArenaMatchRecordLayer:_reqRecordInfo(arg_9_1)
	if arg_9_1 == var_0_2.PERSONAL then
		g.core.network.GameNetProxy:send_C2S_PeakArena_GetRecords({})
	elseif arg_9_1 == var_0_2.TOP_BATTLE then
		-- block empty
	end
end

function PeakArenaMatchRecordLayer:_transShowListCells()
	self.m_recordList:transitionShowCells("enter_left", 0.03)
end

return PeakArenaMatchRecordLayer

local var_0_0 = g.core.event.EventManager
local var_0_1 = g.core.event.enum
local var_0_2 = g.core.network.GameNetProxy
local var_0_3 = g.core.model.User.redCliffData
local var_0_4 = g.core.const.ConstMgr.RedCliffConst
local RedCliffSemiFinalPop = class("RedCliffSemiFinalPop", require("app.fairyGUI.redCliff.UI_RedCliffSemiFinalPop"), function()
	return fgui.GComponent:create({
		resName = "RedCliffSemiFinalPop",
		pkgPath = "ui/redCliff/redCliff",
		pkgName = "redCliff"
	}, ...)
end)

function RedCliffSemiFinalPop:ctor()
	self:showAtCenter()

	self._showPlayerList = {}
	self._curRoomSel = 0

	self.m_playerList:setVirtual()
	self.m_playerList:setItemRenderer(handler(self, self._onRenderPlayerList))
	self.m_roomIdController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onSelChanged))
	self.m_roomIdController:setSelectedIndex(self._curRoomSel)
end

function RedCliffSemiFinalPop:onLoad()
	var_0_0:addEventListener(var_0_1.EVENT_NET_S2C_CHI_BI_GETFINALROOM, self._updateView, self)
	var_0_2:send_C2S_ChiBi_GetFinalRoom({
		room_id = var_0_4.ROOM_ID[1]
	})
	var_0_2:send_C2S_ChiBi_GetFinalRoom({
		room_id = var_0_4.ROOM_ID[2]
	})
	var_0_2:send_C2S_ChiBi_GetFinalRoom({
		room_id = var_0_4.ROOM_ID[3]
	})
	var_0_2:send_C2S_ChiBi_GetFinalRoom({
		room_id = var_0_4.ROOM_ID[4]
	})
	self:_updateView()
end

function RedCliffSemiFinalPop:_updateView()
	self._showPlayerList = var_0_3:getFinalRoomListByRoomId(var_0_4.ROOM_ID[self._curRoomSel + 1])

	local var_4_0 = #self._showPlayerList

	self.m_isEmptyController:setSelectedIndex(#self._showPlayerList > 0 and 0 or 1)
	self.m_playerList:setNumItems(var_4_0)
end

function RedCliffSemiFinalPop:_onRenderPlayerList(arg_5_1, arg_5_2)
	arg_5_2:updateSemiCell(self._showPlayerList[arg_5_1 + 1], arg_5_1)
end

function RedCliffSemiFinalPop:_onSelChanged()
	self._curRoomSel = self.m_roomIdController:getSelectedIndex()

	self:_updateView()
end

return RedCliffSemiFinalPop

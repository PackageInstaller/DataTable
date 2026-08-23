local var_0_0 = g.core.model.User.redCliffData
local var_0_1 = g.core.const.ConstMgr.RedCliffConst
local RedCliffGrandFinalPop = class("RedCliffGrandFinalPop", require("app.fairyGUI.redCliff.UI_RedCliffGrandFinalPop"), function()
	return fgui.GComponent:create({
		resName = "RedCliffGrandFinalPop",
		pkgPath = "ui/redCliff/redCliff",
		pkgName = "redCliff"
	})
end)

function RedCliffGrandFinalPop:ctor()
	self:showAtCenter()

	self._playerList = {}

	self.m_playerList:setVirtual()
	self.m_playerList:setItemRenderer(handler(self, self._onRenderPlayerList))
end

function RedCliffGrandFinalPop:_onRenderPlayerList(arg_3_1, arg_3_2)
	arg_3_2:updateMatchUserCell((self._playerList[arg_3_1 + 1] or nil) and (self._playerList[arg_3_1 + 1].user or nil), arg_3_1)
end

function RedCliffGrandFinalPop:_updateView()
	self._playerList = var_0_0:getFinalRoomListByRoomId(var_0_1.ROOM_ID[5])

	local var_4_0 = #self._playerList

	self.m_isEmptyController:setSelectedIndex(#self._playerList > 0 and 0 or 1)
	self.m_playerList:setNumItems(var_4_0)
end

function RedCliffGrandFinalPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_CHI_BI_GETFINALROOM, self._updateView, self)
	g.core.network.GameNetProxy:send_C2S_ChiBi_GetFinalRoom({
		room_id = var_0_1.ROOM_ID[5]
	})
end

return RedCliffGrandFinalPop

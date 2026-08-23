local var_0_0 = g.core.model.User.redCliffData
local RedCliffStageMatchUserPop = class("RedCliffStageMatchUserPop", require("app.fairyGUI.redCliff.UI_RedCliffStageMatchUserPop"), function()
	return fgui.GComponent:create({
		pkgName = "redCliff",
		resName = "RedCliffStageMatchUserPop",
		pkgPath = "ui/redCliff/redCliff"
	})
end)

function RedCliffStageMatchUserPop:ctor()
	self:showAtCenter()
	self.m_playerList:setVirtual()
	self.m_playerList:setItemRenderer(handler(self, self._onRenderPlayerList))
end

function RedCliffStageMatchUserPop:_onRenderPlayerList(arg_3_1, arg_3_2)
	arg_3_2:updateMatchUserCell(self._playerList[arg_3_1 + 1], arg_3_1)
end

function RedCliffStageMatchUserPop:_onRcvRoomUser()
	self._playerList = var_0_0:getRoomUserList()

	self.m_playerList:setNumItems(#self._playerList)
end

function RedCliffStageMatchUserPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_CHI_BI_GETROOMUSER, self._onRcvRoomUser, self)
	g.core.network.GameNetProxy:send_C2S_ChiBi_GetRoomUser({})
end

return RedCliffStageMatchUserPop

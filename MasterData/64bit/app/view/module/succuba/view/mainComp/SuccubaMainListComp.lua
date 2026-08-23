local SuccubaMainListComp = class("SuccubaMainListComp", require("app.fairyGUI.succuba.UI_SuccubaMainListComp"))

function SuccubaMainListComp:ctor()
	self.m_list:doFairyBatching(false)
	self.m_list:setVirtual(self)
	self.m_list:setItemRenderer(handler(self, self._onRenderRoomItem))
	self.m_list:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickRoomItem))
end

function SuccubaMainListComp:updateListComp()
	self._roomInfoList = g.core.model.User.succubaData:getRoomListByCheckInit()

	self.m_list:setNumItems(g.core.const.ConstMgr.SuccubaConst.ROOM_MAX_NUM)
end

function SuccubaMainListComp:setSelectedRoom(arg_3_1)
	self.m_list:setSelectedIndex(arg_3_1 - 1)
	self:_onClickRoomItem()
end

function SuccubaMainListComp:_onRenderRoomItem(arg_4_1, arg_4_2)
	arg_4_2:updateIconItem(self._roomInfoList[arg_4_1 + 1], arg_4_1 + 1)
end

function SuccubaMainListComp:_onClickRoomItem()
	self:dispatchCompEvent("clickRoomIcon", {
		room = self.m_list:getSelectedIndex() + 1
	})
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Click_Large_02)
end

return SuccubaMainListComp

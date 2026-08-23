local var_0_0 = g.core.model.User.anniversaryData
local AnniversaryShareFriendPop = class("AnniversaryShareFriendPop", require("app.fairyGUI.anniversary.UI_AnniversaryShareFriendPop"), function()
	return fgui.GComponent:create({
		resName = "AnniversaryShareFriendPop",
		pkgPath = "ui/anniversary/anniversary",
		pkgName = "anniversary"
	}, ...)
end)

function AnniversaryShareFriendPop:ctor(arg_2_1)
	self:showAtCenter()

	self._jigsawId = arg_2_1.jigsawId

	self.m_memberList:setVirtual()
	self.m_memberList:setItemRenderer(handler(self, self._onListRender))
	self.m_memberList:doFairyBatching(false)
end

function AnniversaryShareFriendPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MAIL_SEND, self._onInvitePlayer, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, self._updateList, self)
	self:_updateList()
end

function AnniversaryShareFriendPop:_updateList()
	self.m_emptyTypeController:setSelectedIndex(0)

	self._listData = var_0_0:getLocalServerFriends()

	if #self._listData > 0 then
		self.m_memberList:setNumItems(#self._listData)
	else
		self.m_emptyTypeController:setSelectedIndex(1)
	end
end

function AnniversaryShareFriendPop:_onListRender(arg_5_1, arg_5_2)
	arg_5_2:updateInviteCell(self._listData[arg_5_1 + 1], self._jigsawId)
end

function AnniversaryShareFriendPop:_onInvitePlayer(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	g.core.module.ModuleManager:tip(g.core.lang:get(431654))
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return AnniversaryShareFriendPop

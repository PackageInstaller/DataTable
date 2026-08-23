local MarkItem = class("MarkItem", require("app.fairyGUI.mask.UI_MarkItem"))

function MarkItem:ctor()
	local socket = require("socket")
	local var_1_1 = g.core.platform.ServerListProxy:getSelectedServer()
	local var_1_2 = var_1_1.name or "no name"

	self.m_txt_user:setText(g.core.model.User:getName() .. "|" .. tostring(g.core.model.User:getShowId()))
	self.m_txt_server:setText(var_1_2 .. "|" .. tostring(var_1_1.sid))
	self.m_txt_game:setText(tostring(g.core.platform.PlatformProxy:getOpGameId()) .. "|" .. tostring(g.core.platform.PlatformProxy:getOpId()))
	self.m_txt_ip:setText((tostring(socket.dns.toip((socket.dns.gethostname())))))
	self:_setAlpha()
end

function MarkItem:_setAlpha()
	return
end

return MarkItem

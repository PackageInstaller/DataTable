local GveHalidomCell = class("GveHalidomCell", require("app.fairyGUI.gve.UI_GveHalidomCell"))

function GveHalidomCell:ctor(arg_1_1)
	return
end

function GveHalidomCell:onLoad()
	return
end

function GveHalidomCell:receiveCompEvent(arg_3_1, arg_3_2)
	arg_3_2 = arg_3_2 or {}
end

function GveHalidomCell:updateView()
	self.m_icon:updateView(...)
end

function GveHalidomCell:onUnload()
	return
end

return GveHalidomCell

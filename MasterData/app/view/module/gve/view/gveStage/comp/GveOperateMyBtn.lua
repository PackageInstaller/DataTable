local GveConst = require("app.view.module.gve.const.GveConst")
local GveOperateBtn = class("GveOperateBtn", require("app.fairyGUI.gve.UI_GveOperateMyBtn"))

function GveOperateBtn:setSpeIconPic(arg_1_1)
	if arg_1_1 then
		self.m_secIconController:setSelectedIndex(1)
		self.m_secLoader:setURL(arg_1_1)
	else
		self.m_secIconController:setSelectedIndex(0)
	end
end

return GveOperateBtn

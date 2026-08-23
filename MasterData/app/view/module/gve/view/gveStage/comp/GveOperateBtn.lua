local GveConst = require("app.view.module.gve.const.GveConst")
local GveOperateBtn = class("GveOperateBtn", require("app.fairyGUI.gve.UI_GveOperateBtn"))

function GveOperateBtn:getOperateType()
	return self._operateType
end

function GveOperateBtn:setSpeIconPic(arg_2_1)
	self.m_loaderIcon:setURL(arg_2_1)
end

return GveOperateBtn

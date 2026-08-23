local var_0_0 = g.core.const.ConstMgr.ServerPassActivityConst
local ServerPassTipPop = class("ServerPassTipPop", require("app.fairyGUI.serverPassActivity.UI_ServerPassTipPop"), function()
	return fgui.GComponent:create({
		resName = "ServerPassTipPop",
		pkgPath = "ui/serverPassActivity/serverPassActivity",
		pkgName = "serverPassActivity"
	}, ...)
end)

function ServerPassTipPop:ctor(arg_2_1)
	self:showAtCenter()
	self:_updateView(arg_2_1)
end

function ServerPassTipPop:_updateView(arg_3_1)
	self.m_title:setText(g.core.lang:get(433202, {
		ratio = arg_3_1.value / 10,
		level = g.core.config.parameter_info.get(var_0_0.PARAMETER_ID.PRIVILEGE_LIMIT_LEVEL_ID).parameter
	}))
end

return ServerPassTipPop

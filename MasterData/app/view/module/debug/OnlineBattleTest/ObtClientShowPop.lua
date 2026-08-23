local ObtDebugConst = require("app.view.module.debug.OnlineBattleTest.ObtDebugConst")
local ObtClientShowPop = class("ObtClientShowPop", require("app.fairyGUI.debug.UI_ObtClientShowPop"), function()
	return fgui.GComponent:create({
		resName = "ObtClientShowPop",
		pkgPath = "ui/debug/debug",
		pkgName = "debug"
	}, ...)
end)

function ObtClientShowPop:ctor(arg_2_1)
	self:showAtCenter()
	self:initView()
end

function ObtClientShowPop:initView()
	self.m_lookBtn:addClickListener(handler(self, self._onClickLookBtn))
	self.m_exportBtn:addClickListener(handler(self, self._onClickExportBtn))
end

function ObtClientShowPop:_onClickLookBtn()
	g.core.module.ModuleManager:tip("待加")
end

function ObtClientShowPop:_onClickExportBtn()
	g.core.module.ModuleManager:tip("待加")
end

function ObtClientShowPop:onRemoved()
	self:dispatchCompEvent("ObtClientShowPop_Clear_Pop")
end

function ObtClientShowPop:receive(arg_7_1, arg_7_2)
	if arg_7_1 == ObtDebugConst.get_battle_report then
		-- block empty
	end
end

return ObtClientShowPop

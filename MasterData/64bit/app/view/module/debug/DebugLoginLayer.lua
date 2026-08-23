local DebugLoginLayer = class("DebugLoginLayer", require("app.fairyGUI.debug.UI_DebugLoginLayer"), function()
	return fgui.GComponent:create({
		isFullScreen = true,
		pkgPath = "ui/debug/debug",
		resName = "DebugLoginLayer",
		pkgName = "debug"
	})
end)

function DebugLoginLayer:ctor(arg_2_1)
	self:initDebugLogin()
end

function DebugLoginLayer:onLoad()
	self:_initRegisterUI()
	self:startTestSample()
end

function DebugLoginLayer:onUnload()
	return
end

function DebugLoginLayer:receiveCompEvent(arg_5_1, arg_5_2)
	if arg_5_1 == "UI_REBEL_" then
		-- block empty
	end
end

function DebugLoginLayer:initDebugLogin()
	self:_initDebugLoginData()
	self:_initDebugLoginUI()
end

function DebugLoginLayer:startTestSample()
	self:_showSample("SpineAnimationTestPop")
end

function DebugLoginLayer:_initDebugLoginData()
	return
end

function DebugLoginLayer:_initDebugLoginUI()
	self.m_closeBtn:addClickListener(handler(self, self._onCloseSelfClick))
end

function DebugLoginLayer:_initRegisterUI()
	return
end

function DebugLoginLayer:_showSample(arg_11_1)
	self.m_holdComp:addChild((require("app.view.module.debug.test." .. arg_11_1).new()))
end

function DebugLoginLayer:_onCloseSelfClick()
	g.core.module.ModuleManager:popModule()
end

return DebugLoginLayer

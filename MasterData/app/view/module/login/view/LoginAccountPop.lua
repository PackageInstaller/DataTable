local LoginAccountPop = class("LoginAccountPop", require("app.fairyGUI.login.UI_LoginAccountPop"), function()
	return fgui.GComponent:create({
		resName = "LoginAccountPop",
		pkgPath = "ui/login/login",
		pkgName = "login"
	})
end)

function LoginAccountPop:ctor()
	self:showAtCenter()
	self.m_confirmBtn:addClickListener(handler(self, self._onConfirm))
end

function LoginAccountPop:_onCancel()
	self:_onClose()
end

function LoginAccountPop:_onConfirm()
	local var_4_0 = self.m_inputNameTxt:getText()

	if not g.core.platform.PlatformProxy:isLoginTokenCode(var_4_0) and #var_4_0 == 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(100025))

		return
	end

	self:dispatchCompEvent("login_account", var_4_0)
	self:_onClose()
end

function LoginAccountPop:_onClose()
	g.core.module.ModuleManager:popComponent()
end

function LoginAccountPop:receiveCompEvent(arg_6_1)
	return
end

function LoginAccountPop:onLoad()
	if device.isWindows() or config.SHOW_DEBUG_BTN then
		self:addDebugBtn()
	end
end

function LoginAccountPop:addDebugBtn()
	local var_8_0 = fgui.UIPackage:createObject("base_new", "BaseLoaderBtn")
	local var_8_1 = self:getSize()

	var_8_0:setPosition(var_8_1.width / 2 + 250, var_8_1.height / 2 - 23)
	fgui.UIPackage:addPackage("ui/create/create")
	var_8_0:setIcon("ui://create/icon_dl_suijiname")
	self:addChild(var_8_0)
	var_8_0:addClickListener(function()
		local var_9_0 = ""

		for iter_9_0 = 1, 13 do
			local var_9_1 = math.random(1, 3)
			local var_9_2 = 0
			local var_9_3

			if var_9_1 == 1 then
				var_9_2 = math.random(48, 57)
			elseif var_9_1 == 2 then
				var_9_2 = math.random(97, 122)
			else
				var_9_2 = math.random(65, 90)
				var_9_3 = var_9_0
			end

			var_9_0 = var_9_0 .. string.char(var_9_2)
		end

		self.m_inputNameTxt:setText(var_9_0)
		self:dispatchCompEvent("login_account", var_9_0)
	end)
end

function LoginAccountPop:onUnload()
	return
end

return LoginAccountPop

local NewAccountConfirmPop = class("NewAccountConfirmPop", require("app.fairyGUI.infoPop.UI_NewAccountConfirmPop"), function()
	return fgui.GComponent:create({
		resName = "NewAccountConfirmPop",
		pkgPath = "ui/infoPop/infoPop",
		pkgName = "infoPop"
	})
end)

function NewAccountConfirmPop:ctor(arg_2_1, arg_2_2)
	self._accountData = arg_2_1

	self.m_accountText:setText(arg_2_1.username)
	self.m_codeText:setText(arg_2_1.password)
	self.m_copyAccountBtn:addClickListener(handler(self, self._onCopyAccountClick))
	self.m_copyCodeBtn:addClickListener(handler(self, self._onCopyCodeClick))
	self.m_confirmBtn:addClickListener(handler(self, self._onConfirmBtnClicked))

	self._callBack = arg_2_2

	self:showAtCenter()
end

function NewAccountConfirmPop:_onCopyAccountClick()
	g.core.platform.PlatformProxy:copyToClipboard(self._accountData.username)
	g.core.module.ModuleManager:tip(g.core.lang:get(2060))
end

function NewAccountConfirmPop:_onCopyCodeClick()
	g.core.platform.PlatformProxy:copyToClipboard(self._accountData.password)
	g.core.module.ModuleManager:tip(g.core.lang:get(2060))
end

function NewAccountConfirmPop:_onConfirmBtnClicked()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function NewAccountConfirmPop:onUnload()
	if self._callBack then
		self._callBack()
	end
end

return NewAccountConfirmPop

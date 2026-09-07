local DebugPanel = class("DebugPanel", import("..base.BaseUI"))

function DebugPanel:Ctor()
	DebugPanel.super.Ctor(self)
	self:onUILoaded(DebugMgr.Inst.DebugPanel)
	setActive(self._tf, false)

	self.ctrls = self._tf:Find("ctrls")
	self._customBtnTpl = self:getTpl("ctrls/custom_button")

	return
end

function DebugPanel:addCustomBtn(arg_2_1, arg_2_2)
	local var_2_0 = cloneTplTo(self._customBtnTpl, self.ctrls)

	arg_2_1 = string.gsub(arg_2_1, "(.)", "%1\n")

	setButtonText(var_2_0, arg_2_1)
	onButton(self, var_2_0, arg_2_2)

	return
end

function DebugPanel:hidePanel()
	triggerButton(self.ctrls:Find("hide_button"))

	return
end

return DebugPanel

local BaseAssistPopComp = class("BaseAssistPopComp", require("app.fairyGUI.base.UI_BaseAssistPopComp"), function()
	return fgui.GComponent:create({
		resName = "BaseAssistPopComp",
		pkgName = "base"
	})
end)

function BaseAssistPopComp:ctor(arg_2_1)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_TOUCH_START)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)

	self._touchStart = true

	self:setPosition(display.width / 2, display.height / 2)

	arg_2_1 = arg_2_1 or {}
	self._params = arg_2_1 or {}

	if arg_2_1.title then
		self.m_popPanel:setTitle(arg_2_1.title)
	else
		self.m_popPanel:setTitle(g.core.lang:get(1257))
	end

	if arg_2_1.text then
		self.m_desTxt:setText(arg_2_1.text)
	else
		self.m_desTxt:setText("")
	end

	if arg_2_1.text_ok then
		self.m_confirmBtn:setText(arg_2_1.text_ok)
	end

	if arg_2_1.text_cancel then
		self.m_cancelBtn:setText(arg_2_1.text_cancel)
	end

	if arg_2_1.type then
		self.m_typeController:setSelectedIndex(arg_2_1.type)
	end

	if arg_2_1.show_check then
		self.m_showCheckController:setSelectedIndex(1)
	end

	if arg_2_1.check_text then
		self.m_checkBtn:setTitle(arg_2_1.check_text)
	end

	self.m_confirmBtn:addClickListener(function()
		self:dispatchCompEvent("txt_pop_ok", arg_2_1.info)

		if not g.core.module.ModuleManager:isHasPreviousModule() then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_MODULE_EVENT, true, "txt_pop_ok", arg_2_1.info)
		end

		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)

		if arg_2_1.handler_ok then
			arg_2_1.handler_ok()
		end
	end)
	self.m_cancelBtn:addClickListener(handler(self, self._onBtnCancel))
	self.m_checkBtn:addClickListener(function()
		local var_4_0 = self.m_checkBtn:isSelected()

		self:dispatchCompEvent("assist_pop_check", var_4_0 and 1 or 0)

		if arg_2_1.handler_check then
			arg_2_1.handler_check(var_4_0)
		end
	end)
	g.core.service.ServiceManager:getServiceByName("GuideService"):setSystemTipsState(true)
end

function BaseAssistPopComp:onCancelCallback()
	if self._params.ignoreAndroidBack then
		return
	end

	self:_onBtnCancel()
end

function BaseAssistPopComp:_onBtnCancel()
	self:dispatchCompEvent("txt_pop_cancel", self._params.info)
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)

	if self._params.handler_cancel then
		self._params.handler_cancel()
	end
end

function BaseAssistPopComp:onUnload()
	g.core.service.ServiceManager:getServiceByName("GuideService"):setSystemTipsState(false)

	if self._touchStart then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_TOUCH_END)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)

		self._touchStart = false
	end
end

return BaseAssistPopComp

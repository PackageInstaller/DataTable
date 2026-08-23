local AssistantChangePositionComp = class("AssistantChangePositionComp", require("app.fairyGUI.assistant.UI_AssistantChangePositionComp"), function()
	return fgui.GComponent:create({
		resName = "AssistantChangePositionComp",
		pkgPath = "ui/assistant/assistant",
		isFullScreen = true,
		pkgName = "assistant"
	})
end)
local AssistantCommon = require("app.view.module.assistant.common.AssistantCommon")

function AssistantChangePositionComp:ctor(arg_2_1)
	self._minScale = 0.5
	self._changeInterval = 1
	self._SLIDER_RATE = 100
	self._sliderClickHeight = self.m_sliderBg:getHeight()
	self._sliderPosY = self.m_sliderBg:getPosition().y
	self._starPos = nil
	self._canMove = nil
	self._advanceId = arg_2_1 and arg_2_1.advanceId
	self.m_inTransition = self:getView():getTransition("in")
	self.m_outTransition = self:getView():getTransition("out")

	self:_initComp()
	self:_addListener()
end

function AssistantChangePositionComp:onLoad()
	self.m_inTransition:play()
end

function AssistantChangePositionComp:onUnload()
	self:dispatchCompEvent("AssistantChangePosition_Quit")
end

function AssistantChangePositionComp:_initComp()
	self:_resetUI(true)
end

function AssistantChangePositionComp:_resetUI(arg_6_1)
	local var_6_0 = AssistantCommon.getAssistantData()

	self.m_slider:setValue((((self._advanceId or nil) and g.core.model.User:getNominateInfo(self._advanceId).scale) - self._minScale) * self._SLIDER_RATE)
end

function AssistantChangePositionComp:_addListener()
	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self:addEventListener(fgui.UIEventType.TouchMove, handler(self, self._onTouchMove))
	self:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onTouchEnd))
	self.m_bg:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onBgTouchBegin))
	self.m_slider:addEventListener(fgui.UIEventType.Changed, handler(self, self._onSliderChange))
	self.m_slider:addClickListener(handler(self, self._onSliderClick))
	self.m_sliderBg:addClickListener(handler(self, self._onSliderClick))
	self.m_sliderBg:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onBgTouchBegin))
	self.m_resetBtn:addClickListener(handler(self, self._onClickReset))
	self.m_resetBtn:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onBgTouchBegin))
	self.m_confirmBtn:addClickListener(handler(self, self._onClickConfirm))
	self.m_confirmBtn:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onBgTouchBegin))
	self.m_returnBtn:addClickListener(handler(self, self._onClickReturn))
	self.m_returnBtn:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onBgTouchBegin))
end

function AssistantChangePositionComp:_onBgTouchBegin(arg_8_1)
	arg_8_1:stopPropagation()
end

function AssistantChangePositionComp:_onTouchBegin(arg_9_1)
	local var_9_0 = arg_9_1:getInput():getPosition()

	if self.m_slider:containPoint(var_9_0) then
		return
	else
		self._starPos = var_9_0
		self._canMove = true

		arg_9_1:captureTouch()
		self:dispatchCompEvent("AssistantChangePosition_MoveBegin")
	end
end

function AssistantChangePositionComp:_onTouchMove(arg_10_1)
	if not self._starPos or not self._canMove then
		return
	end

	local var_10_0 = arg_10_1:getInput():getPosition()
	local var_10_1 = cc.p(0, 0)

	var_10_1.x = var_10_0.x - self._starPos.x
	var_10_1.y = var_10_0.y - self._starPos.y

	self:dispatchCompEvent("AssistantChangePosition_Move", {
		changPos = var_10_1
	})
end

function AssistantChangePositionComp:_onTouchEnd()
	self._starPos = nil
	self._canMove = false
end

function AssistantChangePositionComp:_onSliderChange()
	self:dispatchCompEvent("AssistantChangePosition_ChangeScale", {
		scale = self.m_slider:getValue() / self._SLIDER_RATE * self._changeInterval + self._minScale
	})
end

function AssistantChangePositionComp:_onSliderClick(arg_13_1)
	self.m_slider:setValue((g.core.utils.Number.formatNumberByLimit((1 - (arg_13_1:getInput():getPosition().y - self._sliderPosY) / self._sliderClickHeight) * 100, 0, 100)))
	self:_onSliderChange()
end

function AssistantChangePositionComp:_onClickReset()
	self:dispatchCompEvent("AssistantChangePosition_Reset")
	self:newScheduleOnce(handler(self, self._resetUI), 0.04)
end

function AssistantChangePositionComp:_onClickConfirm()
	self.m_outTransition:play(handler(self, function()
		self:dispatchCompEvent("AssistantChangePosition_Confirm")

		if self._advanceId then
			if g.core.model.User:isInNominateList(self._advanceId) == 0 then
				g.core.module.ModuleManager:tip(g.core.lang:get(100545))
			else
				g.core.module.ModuleManager:tip(g.core.lang:get(100529))
			end

			g.core.module.ModuleManager:onlyPopSelfByDisplay(self)

			return
		end

		g.core.module.ModuleManager:tip(g.core.lang:get(100529))
		g.core.module.ModuleManager:popModule()
	end))
end

function AssistantChangePositionComp:_onClickReturn()
	self.m_outTransition:play(handler(self, function()
		g.core.module.ModuleManager:popModule()

		if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.ASSISTANT_ADV) then
			g.core.module.ModuleManager:pushModule(g.view.entrance.ASSISTANT_ADV)
		else
			g.core.module.ModuleManager:pushModule(g.view.entrance.ASSISTANT)
		end
	end))
end

return AssistantChangePositionComp

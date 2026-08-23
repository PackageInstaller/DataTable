local HomeChangeAssistantComp = class("HomeChangeAssistantComp", require("app.fairyGUI.home.UI_HomeChangeAssistantComp"))

function HomeChangeAssistantComp:ctor()
	self.m_h5SpList:setVirtual()
	self.m_h5SpList:setItemRenderer(handler(self, self._onH5SpRenderer))
	self:_initBtn()
end

function HomeChangeAssistantComp:_initBtn()
	self.m_changeAssistBtn:addClickListener(handler(self, self._onChangeAssistBtnClick))
	self.m_showAssistBtn:addClickListener(handler(self, self._onShowAssistBtnClick))
	self.m_nextAssistBtn:addClickListener(handler(self, self._onNextAssistBtnClick))
end

function HomeChangeAssistantComp:onLoad()
	self:updateRedPoint()
	self.m_nextAssistBtn:setVisible((g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.ASSISTANT_ADV)))
	self:updateSpH5List()
end

function HomeChangeAssistantComp:updateSpH5List()
	self._spH5Data = g.core.model.User.h5ActivityData:getSpH5ActivityInfo()

	if #self._spH5Data == 0 then
		self.m_h5SpList:setVisible(false)
	else
		self.m_h5SpList:setVisible(true)
		self.m_h5SpList:setNumItems(#self._spH5Data)
		self.m_h5SpList:resizeToFit(#self._spH5Data)
	end
end

function HomeChangeAssistantComp:_onH5SpRenderer(arg_5_1, arg_5_2)
	arg_5_2:updateH5Btn(self._spH5Data[arg_5_1 + 1])
end

function HomeChangeAssistantComp:updateRedPoint()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_changeRedPointComp
	})
end

function HomeChangeAssistantComp:_onChangeAssistBtnClick()
	if g.core.guide.GuideProxy:isGuideRunning() then
		return
	elseif g.core.utils.Tools.checkSilentFull() ~= 0 then
		require("upgrade.UpgradeSilent").showUpgradeTip()

		return
	end

	if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.ASSISTANT_ADV) then
		g.core.module.ModuleManager:pushModule(g.view.entrance.ASSISTANT_ADV)
	else
		g.core.module.ModuleManager:pushModule(g.view.entrance.ASSISTANT)
	end
end

function HomeChangeAssistantComp:_onShowAssistBtnClick()
	self:dispatchCompEvent("EVENT_HOME_HIDE_UI")
end

function HomeChangeAssistantComp:_onNextAssistBtnClick()
	self:dispatchCompEvent("AssistantChange_Adv_Next")
end

return HomeChangeAssistantComp

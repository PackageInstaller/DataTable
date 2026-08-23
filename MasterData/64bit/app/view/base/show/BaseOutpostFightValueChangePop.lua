local BaseOtherFightValueChangePop = class("BaseOtherFightValueChangePop", require("app.fairyGUI.base_new.UI_BaseOutpostFightValueChangePop"), function()
	return fgui.GComponent:create({
		resName = "BaseOutpostFightValueChangePop",
		pkgName = "base_new",
		pkgPath = "ui/base_new/base_new"
	})
end)

function BaseOtherFightValueChangePop:ctor(arg_2_1)
	self:getView():setPosition(display.width / 2, display.height * 0.9)

	if arg_2_1 then
		self._changeValue = arg_2_1.changeValue or 0
	end

	self.m_fightValueTxt:setText(g.core.model.User.outpostData:getFightValue() - self._changeValue)

	if self._changeValue > 0 then
		self.m_stateController:setSelectedIndex(0)
	else
		self.m_stateController:setSelectedIndex(1)
	end

	self.m_inTransition:setHook("roll", handler(self, self._onRollNum))
	self.m_inTransition:setHook("eff", handler(self, self._onShowEff))
end

function BaseOtherFightValueChangePop:_onShowEff()
	self._spineEffect = self.m_placeHolderComp:addEffectSpine({
		name = "eff_ui_common_fightvalue",
		anim = "play",
		isLoop = false
	})
end

function BaseOtherFightValueChangePop:_onRollNum()
	self.m_valueTxt:runChangeAni(0, self._changeValue, false, "+")
end

function BaseOtherFightValueChangePop:onLoad()
	self.m_inTransition:play()
	self:newScheduleOnce(handler(self, self._onPlayOutTrans), 1.2)
end

function BaseOtherFightValueChangePop:_onPlayOutTrans()
	self.m_outTransition:play(handler(self, self.onShowFinish))
end

function BaseOtherFightValueChangePop:onShowFinish()
	self:dispatchCompEvent("Event_close_pop_layer")
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_EXIT_SIMPLE_TIP_SHOW)
end

function BaseOtherFightValueChangePop:onUnload()
	self:cancelAllSchedule()
end

return BaseOtherFightValueChangePop

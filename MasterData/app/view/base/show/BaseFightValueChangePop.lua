local BaseFightValueChangePop = class("BaseFightValueChangePop", require("app.fairyGUI.base_new.UI_BaseFightValueChangePop"), function()
	return fgui.GComponent:create({
		resName = "BaseFightValueChangePop",
		pkgPath = "ui/base_new/base_new",
		pkgName = "base_new"
	})
end)

function BaseFightValueChangePop:ctor(arg_2_1)
	self:getView():setPosition(display.width / 2, display.height * 0.9)

	if arg_2_1 then
		self._changeValue = arg_2_1.changeValue or 0
	end

	local var_2_0 = g.core.model.User:getFightValue()

	self.m_fightValueTxt:setText(((arg_2_1 and arg_2_1.type and arg_2_1.type == 1 or nil) and g.core.model.User.newSlgDevelopData:getTotalAuthority()) - self._changeValue)

	if self._changeValue > 0 then
		self.m_stateController:setSelectedIndex(0)
	else
		self.m_stateController:setSelectedIndex(1)
	end

	self.m_inTransition:setHook("roll", handler(self, self._onRollNum))
	self.m_inTransition:setHook("eff", handler(self, self._onShowEff))
end

function BaseFightValueChangePop:_onShowEff()
	self._spineEffect = self.m_placeHolderComp:addEffectSpine({
		anim = "play",
		name = "eff_ui_common_fightvalue",
		remove = true,
		isLoop = false
	})
end

function BaseFightValueChangePop:_onRollNum()
	self.m_valueTxt:runChangeAni(0, self._changeValue, false, "+")
end

function BaseFightValueChangePop:onLoad()
	self.m_inTransition:play()
	self:newScheduleOnce(handler(self, self._onPlayOutTrans), 1.2)
end

function BaseFightValueChangePop:_onPlayOutTrans()
	self.m_outTransition:play(handler(self, self.onShowFinish))
end

function BaseFightValueChangePop:onShowFinish()
	self:dispatchCompEvent("Event_close_pop_layer")
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_EXIT_SIMPLE_TIP_SHOW)
end

function BaseFightValueChangePop:onUnload()
	self:cancelAllSchedule()
end

return BaseFightValueChangePop

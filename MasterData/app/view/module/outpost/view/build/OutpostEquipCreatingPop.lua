local OutpostEquipCreatingPop = class("OutpostEquipCreatingPop", require("app.fairyGUI.outpost.UI_OutpostEquipCreatingPop"), function()
	return fgui.GComponent:create({
		resName = "OutpostEquipCreatingPop",
		pkgPath = "ui/outpost/outpost",
		isFullScreen = false,
		pkgName = "outpost"
	}, ...)
end)

function OutpostEquipCreatingPop:ctor(arg_2_1)
	self:showAtCenter()

	self.curValue = 0
	self._max = 115
	self._param = arg_2_1

	self.m_bar:setMax(self._max)
	self.m_bar:setValue(self.curValue)

	self.t = 0

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
end

function OutpostEquipCreatingPop:onLoad()
	self.m_effHolder:addEffectSpine({
		anim = "play",
		name = "eff_ui_outpost_equipmaking",
		remove = true,
		isLoop = false
	})
	self:newSchedule(handler(self, self._updateTick), 0.01)
end

function OutpostEquipCreatingPop:_updateTick(arg_4_1, arg_4_2)
	self.t = self.t + arg_4_2 * 100

	if self.t > self._max then
		self:cancelAllSchedule()
		self:onClose()

		return
	end

	self.m_bar:setValue(self.t)
end

function OutpostEquipCreatingPop:onClose()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	g.core.module.ModuleManager:pushPopup(require("app.view.base.show.BaseFeedBackPopNew").new({
		autoDisappear = true,
		equipCfg = self._param.equipCfg,
		title = g.core.lang:get(432630),
		showComp = fgui.UIPackage:createObject("outpost", "OutpostEquipSuccComp")
	}), {
		touchDisappear = true,
		hideContinue = false
	})
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return OutpostEquipCreatingPop

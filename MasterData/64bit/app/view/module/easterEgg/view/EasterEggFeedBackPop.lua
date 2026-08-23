local EasterEggFeedBackPop = class("EasterEggFeedBackPop", require("app.fairyGUI.easterEgg.UI_EasterEggFeedBackPop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/easterEgg/easterEgg",
		resName = "EasterEggFeedBackPop",
		pkgName = "easterEgg"
	})
end)

function EasterEggFeedBackPop:ctor(arg_2_1)
	self._showElem = nil
	self._waitingList = arg_2_1
	self._schedulerRunnerId = nil
	self._lastExitTimer = nil
end

function EasterEggFeedBackPop:onLoad()
	self:getView():setPosition(display.width, display.height * 0.2)
	self:_onShowSpine()

	if #self._waitingList > 0 then
		self._schedulerRunnerId = g.core.common.Scheduler:newSchedule(handler(self, self._onShowSpine), 0.4)
	end
end

function EasterEggFeedBackPop:_addNewSpine(arg_4_1, arg_4_2)
	if self._showElem then
		self._showElem:playExit()

		self._showElem = nil
	end

	if arg_4_2 then
		self._lastExitTimer = g.core.common.Scheduler:newScheduleOnce(handler(self, self._onShowFinish), 1)
	end

	local var_4_0 = fgui.UIPackage:createObject("easterEgg", "EasterEggFeedBackComp")

	var_4_0:setElemView(g.core.lang:get(300037))
	self.m_placeHolderComp:addChild(var_4_0)

	self._showElem = var_4_0
end

function EasterEggFeedBackPop:_onShowFinish()
	self._showElem:playExit(handler(self, self._onExit))

	self._lastExitTimer = nil
end

function EasterEggFeedBackPop:_onExit()
	self:dispatchCompEvent("Event_close_pop_layer")
end

function EasterEggFeedBackPop:_onShowSpine()
	self:_addNewSpine(table.remove(self._waitingList, 1), #self._waitingList == 0)

	if #self._waitingList == 0 and self._schedulerRunnerId then
		g.core.common.Scheduler:cancelSchedule(self._schedulerRunnerId)

		self._schedulerRunnerId = nil
	end
end

function EasterEggFeedBackPop:onUnload()
	if self._schedulerRunnerId then
		g.core.common.Scheduler:cancelSchedule(self._schedulerRunnerId)

		self._schedulerRunnerId = nil
	end

	if self._lastExitTimer then
		g.core.common.Scheduler:cancelSchedule(self._lastExitTimer)

		self._lastExitTimer = nil
	end
end

return EasterEggFeedBackPop

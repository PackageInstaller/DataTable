local var_0_0 = require("app.view.module.storm.const.StormConst").CITY_TYPE
local var_0_1 = g.core.config.storm_info
local StormMainLandComp = class("StormMainLandComp", require("app.fairyGUI.storm.UI_StormMainLandComp1"))

function StormMainLandComp:ctor()
	self._delayUnlockComp = nil
	self._landData = nil
end

function StormMainLandComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GUIDE_FINISH, handler(self, self._onForceGuideEnd), self)
end

function StormMainLandComp:updateView(arg_3_1, arg_3_2)
	self._landData = arg_3_1

	local var_3_0

	if arg_3_2 then
		var_3_0 = g.core.model.User.stormData:getFinishId()
	end

	local var_3_1 = false

	self.m_lineStateController:setSelectedIndex(g.core.model.User.stormData:getMapCurOpenIndex(arg_3_1) - 1)

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.small) do
		local var_3_2 = var_0_1.get(iter_3_1)

		self["m_mapComp" .. iter_3_0]:updateShow(var_3_2, var_0_0.SMALL_CITY)

		if var_3_1 then
			var_3_1 = false
			self._delayUnlockComp = self["m_mapComp" .. iter_3_0]

			self["m_mapComp" .. iter_3_0]:setDelayUnlock()
		end

		if var_3_2.id == var_3_0 then
			var_3_1 = true

			self["m_mapComp" .. iter_3_0]:playFinishAnim(handler(self, self._onFinishAnimPlayEnd))
		end
	end

	self.m_mapComp6:updateShow(var_0_1.get(arg_3_1.middle), var_0_0.MIDDLE_CITY)
	self.m_mapComp7:updateShow(var_0_1.get(arg_3_1.big), var_0_0.BIG_CITY)
	self:_checkSpeWeakGuide()
end

function StormMainLandComp:_onForceGuideEnd()
	self:_checkSpeWeakGuide()
end

function StormMainLandComp:_checkSpeWeakGuide()
	if self._landData.chapterId == 1 and g.core.model.User.stormData:getCityPercent(self._landData.small[1]) == 0 then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_TICK, false, {
			key = "STORM_WEAK_FINGER",
			targetBtn = self.m_mapComp1
		})
	end
end

function StormMainLandComp:_onFinishAnimPlayEnd()
	if self._delayUnlockComp then
		self._delayUnlockComp:playUnlock()

		self._delayUnlockComp = nil
	end
end

function StormMainLandComp:playEnterAnim()
	if self._playing then
		return
	end

	self._playing = true

	self.m_enterTransition:play(handler(self, self._onPlayAnimEnd))
end

function StormMainLandComp:playSwitchAnim()
	self.m_switchTransition:play(handler(self, self._onPlayAnimEnd))
end

function StormMainLandComp:_onPlayAnimEnd()
	self._playing = false
end

function StormMainLandComp:onUnload()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH)
end

return StormMainLandComp

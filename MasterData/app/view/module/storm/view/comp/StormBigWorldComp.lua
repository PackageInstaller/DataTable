local var_0_0 = {
	LOCKED = 0,
	FINISH = 2,
	FIGHTING = 1
}
local var_0_1 = 3
local var_0_2 = g.core.model.User.stormData
local StormBigWorldComp = class("StormBigWorldComp", require("app.fairyGUI.storm.UI_StormBigWorldComp"))

function StormBigWorldComp:ctor()
	self.m_bg:setURL("bg/storm/bg_xyjf_map_big.jpg")
	self:updateMapShow()

	for iter_1_0 = 1, 4 do
		self["m_touch0" .. iter_1_0]:addClickListener(handler(self, self["_onTouchLand" .. iter_1_0]))

		for iter_1_1 = (iter_1_0 - 1) * 5 + 1, (iter_1_0 - 1) * 5 + 5 do
			self["m_smallComp" .. iter_1_1]:setDefaultClickEvent(handler(self, self["_onTouchLand" .. iter_1_0]))
		end
	end
end

function StormBigWorldComp:onLoad()
	self:setTouchable(false)
	self.m_enterTransition:play(handler(self, self._onAnimPlayFinish))
	self:updatePositionState()
end

function StormBigWorldComp:updateMapShow()
	self._curOpenNum = var_0_2:getCurFightingPage()

	if self._curOpenNum == 0 then
		self._curOpenNum = 1
	end

	self.m_unlockStateController:setSelectedIndex(self._curOpenNum - 1)

	local var_3_0 = g.core.model.User.stormCityData:getOwnCityId()

	self.m_fightController:setSelectedIndex(self._curOpenNum)

	for iter_3_0 = 1, 4 do
		local var_3_1

		if iter_3_0 <= var_0_1 then
			var_3_1 = {
				isOpen = iter_3_0 <= self._curOpenNum,
				index = iter_3_0,
				landInfo = var_0_2:getLandDataByIndex(iter_3_0),
				isCurLand = self._curOpenNum == iter_3_0
			}

			if var_3_1.landInfo.big == var_3_0 then
				var_3_1.isSelected = true
			end
		else
			var_3_1 = {
				isOpen = false,
				index = iter_3_0
			}
		end

		self["m_iconComp" .. iter_3_0]:updateState(var_3_1)
		self["m_titleComp" .. iter_3_0]:updateState(var_3_1)
	end
end

function StormBigWorldComp:updatePositionState()
	self:updateMapShow()

	for iter_4_0 = 1, 20 do
		local var_4_0 = g.core.model.User.stormData:getSmallCityData(iter_4_0)

		if var_4_0 then
			self["m_smallComp" .. iter_4_0]:updateCompShow(var_4_0)
		end
	end

	local var_4_1 = g.core.model.User.stormData:getCurSmallCityPage()

	for iter_4_1 = 1, 19 do
		self["m_line" .. iter_4_1]:setVisible(iter_4_1 < var_4_1)
	end

	local var_4_2 = var_0_2:getCurFightingPage()

	for iter_4_2 = 1, 4 do
		local var_4_3 = var_0_2:getLandDataByIndex(iter_4_2)

		self["m_middleComp" .. iter_4_2]:updateCompShow(var_4_3, iter_4_2)
		self["m_stationComp" .. iter_4_2]:updateCompShow(var_4_3, iter_4_2)
		self["m_middleComp" .. iter_4_2]:setVisible(iter_4_2 <= var_4_2)
		self["m_stationComp" .. iter_4_2]:setVisible(iter_4_2 <= var_4_2)

		if var_4_3 then
			if var_0_2:getCityState(g.core.config.storm_info.get(var_4_3.middle).preset_id) ~= var_0_0.FINISH then
				self["m_lineTag" .. iter_4_2]:setVisible(false)
			else
				self["m_lineTag" .. iter_4_2]:setVisible(true)
			end
		else
			self["m_lineTag" .. iter_4_2]:setVisible(false)
		end
	end
end

function StormBigWorldComp:_onAnimPlayFinish()
	self:setTouchable(true)
end

function StormBigWorldComp:getIconComp(arg_6_1)
	return self["m_iconComp" .. arg_6_1]
end

function StormBigWorldComp:getCurLandPosCompDir()
	if self["m_iconComp" .. self._curOpenNum] then
		local var_7_0 = self["m_iconComp" .. self._curOpenNum]:getPosition()
		local var_7_1 = self:getSize()

		return var_7_1.width / 2 - var_7_0.x, var_7_1.height / 2 - var_7_0.y
	end

	return 0, 0
end

function StormBigWorldComp:_onTouchLand1()
	if self._curOpenNum >= 1 then
		var_0_2:setMapLandSelIndex(1)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_MODULE_ENTER_PLAY_TRANSITION, false, {
			isSpine = true,
			forceCallFunc = true,
			callback = function()
				g.core.module.ModuleManager:pushModule(g.view.entrance.STORM_MAIN, {
					landIndex = 1
				})
			end
		})
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(304537))
	end
end

function StormBigWorldComp:_onTouchLand2()
	if self._curOpenNum >= 2 then
		var_0_2:setMapLandSelIndex(2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_MODULE_ENTER_PLAY_TRANSITION, false, {
			isSpine = true,
			forceCallFunc = true,
			callback = function()
				g.core.module.ModuleManager:pushModule(g.view.entrance.STORM_MAIN, {
					landIndex = 2
				})
			end
		})
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(304537))
	end
end

function StormBigWorldComp:_onTouchLand3()
	if self._curOpenNum >= 3 then
		var_0_2:setMapLandSelIndex(3)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_MODULE_ENTER_PLAY_TRANSITION, false, {
			isSpine = true,
			forceCallFunc = true,
			callback = function()
				g.core.module.ModuleManager:pushModule(g.view.entrance.STORM_MAIN, {
					landIndex = 3
				})
			end
		})
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(304537))
	end
end

function StormBigWorldComp:_onTouchLand4()
	if self._curOpenNum >= 4 then
		var_0_2:setMapLandSelIndex(4)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_MODULE_ENTER_PLAY_TRANSITION, false, {
			isSpine = true,
			forceCallFunc = true,
			callback = function()
				g.core.module.ModuleManager:pushModule(g.view.entrance.STORM_MAIN, {
					landIndex = 4
				})
			end
		})
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(304537))
	end
end

return StormBigWorldComp

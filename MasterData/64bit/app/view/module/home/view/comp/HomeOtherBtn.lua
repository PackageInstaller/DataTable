local var_0_0 = g.core.model.User.commanderWorldData
local var_0_1 = g.core.const.ConstMgr.FUNCTION_TYPE
local var_0_2 = g.core.common.ModuleUnlock
local var_0_3 = g.core.common.ServerTime
local var_0_4 = require("app.view.module.home.const.HomeConst").OTHER_BTN
local HomeOtherBtn = class("HomeOtherBtn", require("app.fairyGUI.home.UI_HomeOtherBtn"))

function HomeOtherBtn:ctor()
	self._commanderWorldSchedule = nil

	self:addClickListener(handler(self, self._onOtherBtnClick))
end

function HomeOtherBtn:updateCell(arg_2_1, arg_2_2)
	self._type = arg_2_1
	self._data = arg_2_2

	if self._type == var_0_4.TYPE_CULTIVATE or self._type == var_0_4.TYPE_WITCH then
		self:setIcon("pic/homeOther/" .. arg_2_2:getLocationIcon() .. ".png")
		self.m_redPointComp:setId(arg_2_2:getRedPointId())
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_redPointComp,
			customData = {
				actValue = arg_2_2:getActId()
			}
		})
	end
end

function HomeOtherBtn:updateCD(arg_3_1)
	self.m_cdTxt:setText(arg_3_1)
end

function HomeOtherBtn:_onOtherBtnClick()
	if not self._type then
		return
	end

	if self._type == var_0_4.TYPE_COMMANDER_WORLD then
		self:_onClickCommanderWorld()
	elseif self._type == var_0_4.TYPE_DOUBLE_ELEVEN then
		self:_onClickDoubleEleven()
	elseif self._type == var_0_4.TYPE_CULTIVATE or self._type == var_0_4.TYPE_WITCH then
		self:_onClickCultivate()
	end
end

function HomeOtherBtn:_onClickCommanderWorld()
	if var_0_2:isModuleUnlock(var_0_1.COMMANDER_WORLD) then
		if var_0_0:getActivityStageAndRemainTime() ~= 0 then
			g.core.module.ModuleManager:pushModule(g.view.entrance.COMMANDER_WORLD)
		else
			self:setVisible(false)
			g.core.module.ModuleManager:tip(g.core.lang:get(410322))
		end
	end
end

function HomeOtherBtn:_onClickDoubleEleven()
	if var_0_2:isModuleUnlock(var_0_1.DOUBLE_ELEVEN) then
		if var_0_2:isModuleUnlock(var_0_1.DOUBLE_ELEVEN) then
			g.core.module.ModuleManager:pushModule(g.view.entrance.DOUBLE_ELEVEN)
		else
			self:setVisible(false)
			g.core.module.ModuleManager:tip(g.core.lang:get(410324))
		end
	end
end

function HomeOtherBtn:updateOtherBtnTime()
	if self._type == var_0_4.TYPE_CULTIVATE or self._type == var_0_4.TYPE_WITCH then
		local var_7_0 = self._data
		local var_7_1, var_7_2 = self._data:getHomeIconTimeDesc()

		if var_7_0:isInNormalOpenTime() then
			self.m_stateController:setSelectedIndex(0)
		else
			self.m_stateController:setSelectedIndex(1)
		end

		if var_7_1 > var_0_3:getTime() then
			if var_7_2 then
				self:updateCD(var_7_2)
			else
				local var_7_3, var_7_4, var_7_5, var_7_6 = var_0_3:getLeftTimeParts(var_7_1)

				self:updateCD(g.core.lang:get(1051, {
					day = var_7_3,
					hour = var_7_4
				}))
			end
		elseif not var_7_2 then
			self:setVisible(false)
		end
	end
end

function HomeOtherBtn:_onClickCultivate()
	if self._data then
		g.core.module.ModuleManager:pushModule(g.view.entrance.CULTIVATE_MAIN, {
			route1 = self._data:getActId()
		})
	end
end

return HomeOtherBtn

local var_0_0 = 3
local var_0_1 = g.core.model.User.furnitureData
local var_0_2 = g.core.common.Scheduler
local FurnitureComfortLvComp = class("FurnitureComfortLvComp", require("app.fairyGUI.furniture.UI_FurnitureComfortLvComp"))

function FurnitureComfortLvComp:ctor()
	self._dormId = nil
	self._comfort = 0
	self._timer = nil

	self:addClickListener(handler(self, self._onClick))
end

function FurnitureComfortLvComp:onUnload()
	self:_cancelTimer()
end

function FurnitureComfortLvComp:_onClick()
	if not self._dormId then
		return
	end

	g.core.module.ModuleManager:pushPopup(require("app.view.module.furniture.view.pop.FurnitureRoomLevelUpPop").new(self._dormId), {
		touchDisappear = false
	})
end

function FurnitureComfortLvComp:updateComp(arg_4_1)
	self._dormId = arg_4_1

	local var_4_0 = var_0_1:getRoomInfo(arg_4_1)

	self._comfort = var_4_0:getComfort()

	if arg_4_1 == self._dormId and self._comfort < self._comfort then
		self:playAddComfortEff()
	end

	self.m_roomLvTxt:setText(var_4_0:getLevel())
	self.m_comfortLvTxt:setText(self._comfort)
	self.m_levelUpImg:setVisible(var_4_0:isCanLevelUp() and var_4_0:isEnoughItemLevelUpNeed())
end

function FurnitureComfortLvComp:playAddComfortEff()
	self.m_effDadComp:addEffectSpine({
		remove = true,
		name = "eff_ui_furniture_comfort",
		isLoop = false
	})
end

function FurnitureComfortLvComp:checkAndShowPromptUpgrade(arg_6_1)
	local var_6_0 = var_0_1:getRoomInfo(arg_6_1)

	if var_6_0:isCanLevelUp() and var_6_0:isEnoughItemLevelUpNeed() and not var_0_1:isDormPromptedUpgrade(arg_6_1) then
		self.m_showBubbleController:setSelectedIndex(1)
		self:_startTimer()
		var_0_1:savePromptedUpgradeDorm(arg_6_1)
	end
end

function FurnitureComfortLvComp:_onCDEnd()
	self:_cancelTimer()
	self.m_showBubbleController:setSelectedIndex(0)
end

function FurnitureComfortLvComp:_startTimer()
	self:_cancelTimer()

	self._timer = var_0_2:newScheduleOnce(handler(self, self._onCDEnd), var_0_0)
end

function FurnitureComfortLvComp:_cancelTimer()
	if self._timer then
		var_0_2:cancelSchedule(self._timer)

		self._timer = nil
	end
end

return FurnitureComfortLvComp

local var_0_0 = g.core.common.ServerTime
local FurnitureBathCrockCDComp = class("FurnitureBathCrockCDComp", require("app.fairyGUI.furniture.UI_FurnitureBathCrockCDComp"))

function FurnitureBathCrockCDComp:ctor()
	self._totalTime = 0
	self._endTime = -1
	self._scheduler = nil

	self:addClickListener(handler(self, self.onClickBathCDIcon))
end

function FurnitureBathCrockCDComp:onUnload()
	self:_cancelScheduler()
end

function FurnitureBathCrockCDComp:startCD(arg_3_1, arg_3_2)
	if self._totalTime == arg_3_1 and self._endTime == arg_3_2 then
		return
	end

	self._endTime = arg_3_2
	self._totalTime = arg_3_1

	if not arg_3_1 or not arg_3_2 then
		self.m_cdController:setSelectedIndex(0)
		self:_cancelScheduler()
	elseif arg_3_1 <= 0 or arg_3_2 <= var_0_0:getTime() then
		self.m_cdController:setSelectedIndex(0)
		self:_cancelScheduler()
	else
		self._scheduler = self._scheduler or g.core.common.Scheduler:newSchedule(handler(self, self._onCD), 1)

		self.m_cdBar:setMax(arg_3_1)
		self.m_cdTimeText:setText(g.core.lang:get(112547, {
			time = g.core.common.ServerTime:getLeftSecondsString(self._endTime)
		}))
		self.m_cdController:setSelectedIndex(1)
	end
end

function FurnitureBathCrockCDComp:_onCD()
	local var_4_0 = self._endTime - var_0_0:getTime()

	if var_4_0 <= 0 then
		self.m_cdController:setSelectedIndex(0)
		self:dispatchCompEvent("BATH_CROCK_CD_OVER")
		self:_cancelScheduler()
	else
		self.m_cdBar:setValue(self._totalTime - var_4_0)
		self.m_cdTimeText:setText(g.core.lang:get(112547, {
			time = g.core.common.ServerTime:getLeftSecondsString(self._endTime)
		}))
	end
end

function FurnitureBathCrockCDComp:_cancelScheduler()
	if self._scheduler then
		g.core.common.Scheduler:cancelSchedule(self._scheduler)

		self._scheduler = nil
	end
end

function FurnitureBathCrockCDComp:onClickBathCDIcon()
	if self.m_cdController:getSelectedIndex() == 1 then
		self.m_cdTimeText:runFGAction(fgui.FSequence:create({
			fgui.FFadeTo:create(0.5, 255),
			fgui.FDelayTime:create(3),
			fgui.FFadeTo:create(0.5, 0)
		}))
		self.m_cdTimeText:setVisible(true)
		self.m_cdTimeBg:runFGAction(fgui.FSequence:create({
			fgui.FFadeTo:create(0.5, 255),
			fgui.FDelayTime:create(3),
			fgui.FFadeTo:create(0.5, 0)
		}))
		self.m_cdTimeBg:setVisible(true)
	end
end

return FurnitureBathCrockCDComp

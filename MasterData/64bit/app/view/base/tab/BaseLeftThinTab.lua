local BaseLeftThinTab = class("BaseLeftThinTab", require("app.fairyGUI.base_new.UI_BaseLeftThinTab"))

function BaseLeftThinTab:ctor()
	self._titleEffect = nil
	self._unLockCheckFunc = nil
	self.m_buttonController = self:getController("button")

	self.m_buttonController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onTabCompChanged))
end

function BaseLeftThinTab:onLoad()
	self._style = self.m_styleController:getSelectedIndex()

	if self._style == 0 then
		self.m_up_enterTransition:play()
	else
		self.m_up_enter1Transition:play()
	end

	if self.m_redPointComp:getId() > 0 then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_redPointComp,
			customData = self.m_redPointComp:getCustomData()
		})
	end
end

function BaseLeftThinTab:updateRedPoint()
	if self.m_redPointComp:getId() > 0 then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_redPointComp,
			customData = self.m_redPointComp:getCustomData()
		})
	end
end

function BaseLeftThinTab:setRedPointId(arg_4_1, arg_4_2)
	self.m_redPointComp:setId(arg_4_1)

	if arg_4_1 and arg_4_1 > 0 then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_redPointComp,
			customData = arg_4_2
		})
	end
end

function BaseLeftThinTab:setUnlockCheck(arg_5_1)
	self._unLockCheckFunc = arg_5_1
end

function BaseLeftThinTab:setShowData(arg_6_1)
	if not arg_6_1 then
		return
	end

	self._showData = arg_6_1

	if arg_6_1.shading then
		self:getChild("iconDown"):setURL(arg_6_1.shading)
	end

	local var_6_0 = self.m_buttonController:getSelectedIndex()

	if arg_6_1[var_6_0] then
		self:setIcon(arg_6_1[var_6_0])
	end
end

function BaseLeftThinTab:_onTabCompChanged()
	if not self._unLockCheckFunc or self._unLockCheckFunc and self._unLockCheckFunc() then
		local var_7_0 = self.m_buttonController:getSelectedIndex()

		if self._showData and self._showData[var_7_0] then
			self:setIcon(self._showData[var_7_0])
		end

		if var_7_0 == 1 then
			if not self._titleEffect then
				self._titleEffect = require("app.view.common.SpineBase").new({
					resId = "",
					anim = "play",
					isLoop = false,
					path = g.core.common.Path:getEffSpine("eff_ui_common_lefttab")
				})

				self.m_effectComp:addNode(self._titleEffect)
				self.m_loader:setOpacity(0)
			else
				self._titleEffect:setAnimation(0, "play")
			end
		end

		if self._playDelayAnimId then
			g.core.common.Scheduler:cancelSchedule(self._playDelayAnimId)

			self._playDelayAnimId = nil
		end

		self._playDelayAnimId = g.core.common.Scheduler:newScheduleOnce(handler(self, self._onPlayDelayAnim), 0.04)
	end
end

function BaseLeftThinTab:_onPlayDelayAnim()
	self._playDelayAnimId = nil

	if self.m_buttonController:getSelectedIndex() == 0 then
		-- block empty
	elseif self._style == 0 then
		self.m_down_enterTransition:play()
	else
		self.m_down_enter1Transition:play()
	end
end

function BaseLeftThinTab:onUnload()
	if self._playDelayAnimId then
		g.core.common.Scheduler:cancelSchedule(self._playDelayAnimId)

		self._playDelayAnimId = nil
	end
end

function BaseLeftThinTab:setStyleByIndex(arg_10_1)
	if arg_10_1 == 0 or arg_10_1 == 1 then
		self._style = arg_10_1

		self.m_styleController:setSelectedIndex(arg_10_1)
	end
end

return BaseLeftThinTab

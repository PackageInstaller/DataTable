local var_0_0 = g.core.model.User.anniversaryData
local var_0_1 = g.core.const.ConstMgr.AnniversaryConst
local AnniversaryMainAwardComp = class("AnniversaryMainAwardComp", require("app.fairyGUI.anniversary.UI_AnniversaryMainAwardComp"))

function AnniversaryMainAwardComp:ctor()
	self._clickNum = 0
	self._index = 1
	self._timeSchedule = nil

	self.m_bgLoader:setURL(var_0_0:getActivityResource("ui_cocos", "pic_xmhy_zhanbandi.png"))
	self.m_nameText:setColor(var_0_1.hexToRgb(var_0_0:getAnniversaryInfo().main_color))
	self:setVisible(false)
end

function AnniversaryMainAwardComp:updateItem(arg_2_1, arg_2_2)
	if not arg_2_1 then
		return
	end

	if self._clickNum == 0 then
		self:newScheduleOnce(handler(self, self._playEnterAnim), 0.1 * (arg_2_2 - 1))
	end

	if self._timeSchedule then
		self:cancelSchedule(self._timeSchedule)
	end

	self._timeSchedule = self:newScheduleOnce(handler(self, self._playShowEnd), var_0_1.FIRE_AWARD_STILL_TIME)
	self._index = arg_2_2
	self._clickNum = self._clickNum + 1

	self.m_nameText:setText(g.core.lang:get(431612) .. arg_2_1.name)
	self.m_iconLoader:setURL(arg_2_1.icon_mini)
	self.m_numText:setText("X" .. arg_2_1.size * self._clickNum)
end

function AnniversaryMainAwardComp:_playEnterAnim()
	self:setVisible(true)
	self.m_enterTransition:play()
end

function AnniversaryMainAwardComp:_playShowEnd()
	self._clickNum = 0
	self._timeSchedule = nil

	self.m_backTransition:play()

	if self._index == 1 then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ANNIVERSARY_TOPBAR_RESCOMP_REFRESH)
	end
end

return AnniversaryMainAwardComp

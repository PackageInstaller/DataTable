local var_0_0 = g.core.common.ServerTime
local var_0_1 = g.core.model.User.activityInviteFriendData
local ActivityInviteFriendComp = class("ActivityInviteFriendComp", require("app.fairyGUI.activity.UI_ActivityInviteFriendComp"))

function ActivityInviteFriendComp:ctor()
	self._isNewUser = false
	self.m_myInviteCodeComp = nil
	self.m_inputInviteCodeComp = nil
	self.m_buttonController = self.m_buttonComp:getController("select")

	self:_initView()
end

function ActivityInviteFriendComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FRIEND_RECOMMEND_GETINFO, handler(self, self._onRcvFriendRecommendInfo), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FRIEND_RECOMMEND_SYNCINFO, handler(self, self._onRcvRecommendInfo), self)
	g.core.network.GameNetProxy:send_C2S_FriendRecommend_GetInfo({})
end

function ActivityInviteFriendComp:updateComp()
	self.m_enterTransition:play()

	if self.m_InputInviteCodeComp and self.m_InputInviteCodeComp:isVisible() then
		self.m_InputInviteCodeComp:playEnterAnimation()
	end

	if self.m_myInviteCodeComp and self.m_myInviteCodeComp:isVisible() then
		self.m_myInviteCodeComp:playEnterAnimation()
	end
end

function ActivityInviteFriendComp:_initView()
	self.m_buttonController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onCheckboxChange))
	self.m_shareBtn:addClickListener(handler(self, self._onClickShareBtn))

	local var_4_0 = self:addBg("bg/activity/bg_hd_haoyou.jpg", false)

	var_4_0:setSize(1638, 998)

	if display.width > 1638 or display.height > 998 then
		var_4_0:setScale((math.max(display.width / 1638, display.height / 998)))
	end

	self.m_buttonComp:setVisible(false)
end

function ActivityInviteFriendComp:_onCheckboxChange()
	local var_5_0 = self.m_buttonController:getSelectedIndex() == 0

	self:_showInputInviteCodeComp(var_5_0)
	self:_showMyInviteCodeComp(not var_5_0)
end

function ActivityInviteFriendComp:_showInputInviteCodeComp(arg_6_1)
	if not arg_6_1 then
		if not self.m_InputInviteCodeComp then
			-- block empty
		else
			self.m_InputInviteCodeComp:setVisible(arg_6_1)
		end

		return
	end

	if not self.m_InputInviteCodeComp then
		self.m_InputInviteCodeComp = fgui.UIPackage:createObject("activity", "ActivityInputInviteCodeComp")

		self.m_placeHolder:addChild(self.m_InputInviteCodeComp)
		self.m_InputInviteCodeComp:playEnterAnimation()
	else
		self.m_InputInviteCodeComp:setVisible(arg_6_1)
		self.m_InputInviteCodeComp:playCutAnimation()
	end

	if arg_6_1 then
		self.m_InputInviteCodeComp:updateView()
	end
end

function ActivityInviteFriendComp:_showMyInviteCodeComp(arg_7_1)
	if not arg_7_1 then
		if not self.m_myInviteCodeComp then
			-- block empty
		else
			self.m_myInviteCodeComp:setVisible(arg_7_1)
		end

		return
	end

	if not self.m_myInviteCodeComp then
		self.m_myInviteCodeComp = fgui.UIPackage:createObject("activity", "ActivityMyInviteCodeComp")

		self.m_placeHolder:addChild(self.m_myInviteCodeComp)
		self.m_myInviteCodeComp:playEnterAnimation()
	else
		self.m_myInviteCodeComp:setVisible(arg_7_1)
		self.m_myInviteCodeComp:playCutAnimation()
	end

	if arg_7_1 then
		self.m_myInviteCodeComp:updateView()
	end
end

function ActivityInviteFriendComp:_onRcvFriendRecommendInfo(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	if var_0_1:getIsNewUser() then
		self.m_buttonComp:setVisible(true)
		self:_showInputInviteCodeComp(true)
		self:_showMyInviteCodeComp(false)
	else
		self.m_buttonComp:setVisible(false)
		self:_showMyInviteCodeComp(true)
		self:_showInputInviteCodeComp(false)
	end

	self:_updateActivityView()
end

function ActivityInviteFriendComp:_onRcvRecommendInfo(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	self:_updateActivityView()
end

function ActivityInviteFriendComp:_updateActivityView()
	local var_10_0 = var_0_1:getOpenServerDayTime()
	local var_10_1
	local var_10_2

	if var_0_0:getOpenDays() <= var_10_0 then
		var_10_1 = var_0_0:getDateObject(var_0_0:getTimeByOpenDay(1))
		var_10_2 = var_0_0:getDateObject(var_0_0:getTimeByOpenDay(var_10_0))
	else
		local var_10_3 = var_0_1:getActivityInfo()

		var_10_1 = var_0_0:getDateObject(var_10_3.begin_time)
		var_10_2 = var_0_0:getDateObject(var_10_3.end_time)
	end

	self.m_startMonthText:setText(var_10_1.month)
	self.m_startDayText:setText(var_10_1.day)
	self.m_endMonthText:setText(var_10_2.month)
	self.m_endDayText:setText(var_10_2.day)
end

function ActivityInviteFriendComp:_onRewardFlush()
	return
end

function ActivityInviteFriendComp:_onClickShareBtn()
	g.core.module.ModuleManager:pushModule(g.view.entrance.INVITE_FRIEND_SHARE, {
		bg = "bg/share/bg_fx_haoyouyaoqing1.jpg",
		code = var_0_1:getMyInviteCode()
	})
end

return ActivityInviteFriendComp

local var_0_0 = g.core.model.User.userBackData
local UserBackConst = require("app.view.module.userBack.const.UserBackConst")
local UserBackLayer = class("UserBackLayer", require("app.fairyGUI.userBack.UI_UserBackLayer"), function()
	return fgui.GComponent:create({
		resName = "UserBackLayer",
		pkgPath = "ui/userBack/userBack",
		pkgName = "userBack"
	})
end)

function UserBackLayer:ctor(arg_2_1)
	self:showAtCenter()
	self.m_userBackBgComp:setSize(display.width, display.height)
	self.m_messageBgComp:setSize(display.width, display.height)

	if arg_2_1 and arg_2_1.endcall then
		self._closeCallBack = arg_2_1.endcall
	end

	self._paramSelIndex = arg_2_1 and arg_2_1.selIndex
	self._userBackType = nil
	self._signView = nil
	self._giftView = nil
	self._messageEnterFinished = false
	self._messageOpenFinished = false

	var_0_0:initCfgData()
	self:_initView()
	var_0_0:saveUserBackTodayShow()
end

function UserBackLayer:onLoad()
	self._userBackType = var_0_0:getUserBackType() or UserBackConst.SIGN

	if self._userBackType == UserBackConst.SIGN then
		self.m_buttonStatusController:setSelectedIndex(0)
	else
		self.m_buttonStatusController:setSelectedIndex(1)
	end

	if self._paramSelIndex then
		self.m_buttonStatusController:setSelectedIndex(self._paramSelIndex)

		self._paramSelIndex = nil
	end

	self:_onPlayShow()
	self:addSpineEffect()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, handler(self, self._onPlayShow), self)
end

function UserBackLayer:_onPlayShow()
	self:_onCheckboxChange()
	self:playUserBackAnimation()
end

function UserBackLayer:_initView()
	self.m_userBackBgComp:addBg("bg/activity/bg_hd_lwjhg_1.png", nil, nil, 1)
	self.m_messageBgComp:addBg("bg/activity/bg_lwjhg.jpg", nil, nil, 1)
	self.m_bg:addClickListener(handler(self, self._onCloseView))
	self.m_buttonStatusController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onCheckboxChange))
	self.m_messageBgComp:addClickListener(handler(self, self._onClickMessage))

	if self._closeCallBack then
		if var_0_0:canBeatFace() then
			self:showMessageView()
		else
			self:showUserBackView()
		end
	else
		self:showUserBackView()
	end
end

function UserBackLayer:_onClickMessage()
	if self._messageOpenFinished == true and self._messageEnterFinished == true then
		self:_closeMessageAnimation()

		return
	end

	if self._messageEnterFinished == true and not self._messageAnimationPlayed then
		self:_openMessageAnimation()

		self._messageAnimationPlayed = true

		return
	end
end

function UserBackLayer:showMessageView()
	self.m_showController:setSelectedIndex(0)
	var_0_0:setBeatFace()
	self.m_enter_letterTransition:setHook("over", function()
		self._messageEnterFinished = true
	end)
	self.m_enter_letterTransition:play(function()
		return
	end)
end

function UserBackLayer:_openMessageAnimation()
	self.m_open_letterTransition:play(function()
		self._messageOpenFinished = true
	end)
end

function UserBackLayer:_closeMessageAnimation()
	self.m_close_letterTransition:play(function()
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
		var_0_0:setIsFromOpenMessage(true)
		g.core.module.ModuleManager:pushModule(g.view.entrance.ACTIVITY, {
			activityValue = 0,
			activityType = g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.USER_BACK
		})
	end)
end

function UserBackLayer:showUserBackView()
	self.m_showController:setSelectedIndex(1)
	self:clearTimer()

	self._updateSchedule = self:newSchedule(handler(self, function()
		self:_updateCountDown()
	end), 1)

	self:_updateCountDown()
end

function UserBackLayer:_updateCountDown()
	local var_16_0 = (var_0_0:getEndTime() or 0) - g.core.common.ServerTime:getTime()
	local var_16_1

	if var_16_0 <= 0 then
		var_16_0 = 0

		self:_onCloseView()

		do return end

		var_16_1 = {}
	end

	var_16_1.timeTip = g.core.common.ServerTime:secondToDHMString(var_16_0)

	self.m_timeText:setText((g.core.lang:get(107059, var_16_1)))
end

function UserBackLayer:_onCheckboxChange()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_XxGift)

	local var_17_0 = self.m_buttonStatusController:getSelectedIndex() == 0

	self:_showSignComp(var_17_0)
	self:_showGiftComp(not var_17_0)
end

function UserBackLayer:_showSignComp(arg_18_1)
	if not arg_18_1 then
		if not self._signView then
			-- block empty
		else
			self._signView:setVisible(false)
		end

		return
	end

	if not self._signView then
		self._signView = fgui.UIPackage:createObject("userBack", "UserBackSignComp")

		self.m_placeHolder:addChild(self._signView)
	elseif self._signView then
		self._signView:setVisible(arg_18_1)
	end

	self._signView:updateView()
	self.m_signBtn:playAnimation()
	self._signView:playEnterAnimation()
end

function UserBackLayer:_showGiftComp(arg_19_1)
	if not arg_19_1 then
		if not self._giftView then
			-- block empty
		else
			self._giftView:setVisible(false)
		end

		return
	end

	if not self._giftView then
		self._giftView = fgui.UIPackage:createObject("userBack", "UserBackGiftComp")

		self.m_placeHolder:addChild(self._giftView)
	elseif self._giftView then
		self._giftView:setVisible(arg_19_1)
	end

	self._giftView:updateView()
	self.m_giftBtn:playAnimation()
end

function UserBackLayer:_onCloseView()
	self:clearTimer()
	self.m_back_signTransition:play(function()
		self:homeLayerAutoPopup()
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	end)
end

function UserBackLayer:clearTimer()
	if self._updateSchedule then
		self:cancelSchedule(self._updateSchedule)

		self._updateSchedule = nil
	end
end

function UserBackLayer:playMessageAnimation()
	return
end

function UserBackLayer:playUserBackAnimation()
	self.m_enter_signTransition:play()
end

function UserBackLayer:addSpineEffect()
	self._effStar = self.m_effStar:addEffectSpine({
		isLoop = true,
		name = "eff_ui_userBack_star",
		anim = "play"
	})

	self.m_effTitle:addEffectSpine({
		isLoop = false,
		name = "eff_ui_userBack_title",
		anim = "play",
		remove = true
	})
end

function UserBackLayer:homeLayerAutoPopup()
	if self._closeCallBack then
		self._closeCallBack()

		self._closeCallBack = nil
	end

	self:dispatchCompEvent("PopView_Close")
end

function UserBackLayer:onUnLoad()
	if self._effStar then
		self._effStar:removeFromParent()

		self._effStar = nil
	end
end

return UserBackLayer

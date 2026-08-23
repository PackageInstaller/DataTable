local var_0_0 = g.core.model.User.userBackData
local ActivityUserBackComp = class("ActivityUserBackComp", require("app.fairyGUI.activity.UI_ActivityUserBackComp"))

function ActivityUserBackComp:ctor()
	var_0_0:initCfgData()
	self:_initBtn()
	self:_initEffect()
end

function ActivityUserBackComp:onLoad()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_recruitBtn
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_artifactBtn
	})
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_MODULE_EXIT, self._initEffect, self)
end

function ActivityUserBackComp:onUnload()
	self:clearTimer()
end

function ActivityUserBackComp:_initBtn()
	self.m_signUpBtn:addClickListener(handler(self, self._onSignUpBtnClick))
	self.m_giftBagBtn:addClickListener(handler(self, self._onGiftBagBtnClick))
	self.m_recruitBtn:addClickListener(handler(self, self._onRecruitBtnClick))
	self.m_resourceBtn:addClickListener(handler(self, self._onResourceBtnClick))
	self.m_artifactBtn:addClickListener(handler(self, self._onArtifactBtnClick))
end

function ActivityUserBackComp:_initEffect()
	self.m_signEffect = self.m_signEffect or self.m_signUpBtn:getChild("eff"):addEffectSpine({
		name = "eff_ui_activityUserBack_btn",
		anim = "play",
		isLoop = true
	})

	self.m_signEffect:setVisible((var_0_0:hasSignAwardGet()))

	self.m_giftEffect = self.m_giftEffect or self.m_giftBagBtn:getChild("eff"):addEffectSpine({
		name = "eff_ui_activityUserBack_btn",
		anim = "play",
		isLoop = true
	})

	self.m_giftEffect:setVisible((var_0_0:hasFreeGiftGet()))

	self.m_resourceEffect = self.m_resourceEffect or self.m_resourceBtn:getChild("eff"):addEffectSpine({
		name = "eff_ui_activityUserBack_btn",
		anim = "play",
		isLoop = true
	})

	self.m_resourceEffect:setVisible((var_0_0:hasCanGetResourceAward()))
end

function ActivityUserBackComp:updateComp(arg_6_1, arg_6_2)
	self.m_enterTransition:play()
	self:_initTimer()

	if var_0_0:getIsFromOpenMessage() then
		self:_onSignUpBtnClick()
		var_0_0:setIsFromOpenMessage(false)
	end
end

function ActivityUserBackComp:_initTimer()
	self:clearTimer()

	self._updateSchedule = self:newSchedule(handler(self, function()
		self:_updateCountDown()
	end), 1)

	self:_updateCountDown()
end

function ActivityUserBackComp:_updateCountDown()
	local var_9_0 = var_0_0:getEndTime() or 0

	self.m_timeText:setText(g.core.lang:get(407806, {
		timestr = g.core.common.ServerTime:getLeftDHFormat(var_9_0)
	}))
end

function ActivityUserBackComp:clearTimer()
	if self._updateSchedule then
		self:cancelSchedule(self._updateSchedule)

		self._updateSchedule = nil
	end
end

function ActivityUserBackComp:_onSignUpBtnClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.USER_BACK, {
		selIndex = 0
	})
end

function ActivityUserBackComp:_onGiftBagBtnClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.USER_BACK, {
		selIndex = 1
	})
end

function ActivityUserBackComp:_onRecruitBtnClick()
	local var_13_0 = var_0_0:getCurBackTurnCfg()

	if g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.RETURN_RECRUIT) and var_13_0 then
		g.view.entrance.ModuleGotoProxy:gotoModule(var_13_0.source_route_1)
	end
end

function ActivityUserBackComp:_onResourceBtnClick()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.activity.view.activityUserBack.ActivityUserBackResourcePop").new()))
end

function ActivityUserBackComp:_onArtifactBtnClick()
	local var_15_0 = var_0_0:getCurBackTurnCfg()

	if g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.RETURN_RECRUIT_ARTIFACT) and var_15_0 then
		g.view.entrance.ModuleGotoProxy:gotoModule(var_15_0.source_route_2)
	end
end

return ActivityUserBackComp

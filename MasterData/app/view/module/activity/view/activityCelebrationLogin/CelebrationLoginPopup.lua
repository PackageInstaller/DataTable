local var_0_0 = g.core.model.User.activityCelebrationLoginData
local CelebrationLoginPopup = class("CelebrationLoginPopup", require("app.fairyGUI.activity.UI_CelebrationLoginPopup"), function()
	return fgui.GComponent:create({
		resName = "CelebrationLoginPopup",
		pkgPath = "ui/activity/activity",
		pkgName = "activity"
	}, ...)
end)

function CelebrationLoginPopup:ctor(arg_2_1)
	if arg_2_1 and arg_2_1.endcall then
		self._endcall = arg_2_1.endcall
	end

	self._functionId = arg_2_1.param.function_id
	self._isOnClose = false

	self:showAtCenter()

	self._subId = var_0_0:getActivityIdByFunction(self._functionId)

	self.m_bgLoader:addClickListener(handler(self, self._onClickClose))
	g.core.model.User.dayNotifyTool:saveTodayRecord("CelebrationLogin_" .. self._subId, true, true)
end

function CelebrationLoginPopup:homeLayerAutoPopup()
	if self._endcall then
		self._endcall()
	end
end

function CelebrationLoginPopup:onLoad()
	self:updateView()
end

function CelebrationLoginPopup:updateView()
	self.m_enterTransition:play()
	self.m_celebrationLoginComp:updateComp(self._subId, nil, nil, true)
end

function CelebrationLoginPopup:_onClickClose()
	if self._isOnClose then
		return
	end

	self._isOnClose = true

	self.m_eff:addEffectSpine({
		anim = "play",
		name = "eff_ui_activity_celeBg",
		remove = true,
		isLoop = false
	})
	self.m_backTransition:setHook("start", handler(self, self._onPopMoveStart))
	self.m_backTransition:play()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_CELEBRATION_LOGIN_BACK, false)
end

function CelebrationLoginPopup:_onPopMoveStart()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return CelebrationLoginPopup

local var_0_0 = g.core.model.User.wushData
local var_0_1 = {
	USER_STOP = 2,
	BATTLE_FAILED = 1,
	ALL_FINISH = 3
}
local var_0_2 = g.core.const.ConstMgr.InfoConst.AUTO_TYPE
local var_0_3 = {
	[var_0_1.BATTLE_FAILED] = 303044,
	[var_0_1.USER_STOP] = 303045,
	[var_0_1.ALL_FINISH] = 303046
}
local WushAutoRunComp = class("WushAutoRunComp", require("app.fairyGUI.wush.UI_WushAutoRunComp"))

function WushAutoRunComp:ctor()
	self._lastRunTime = 0
	self._pauseMainLayer = false

	self.m_autoBg:updateAutoState({
		clickStopFunc = handler(self, self._onStopClick)
	})
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ANTI_ADDICTION_NOTIFY, handler(self, self._onRepeatLogin), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_SERVER_BROKEN, handler(self, self._onRepeatLogin), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_EXPIRED, handler(self, self._onRepeatLogin), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_TIMEOUT, handler(self, self._onRepeatLogin), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_DISCONNECTED, handler(self, self._onRepeatLogin), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_CONNECT_BROKEN, handler(self, self._onRepeatLogin), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_CONNECT_FAIL, handler(self, self._onRepeatLogin), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_LOGIN_OFFINE, handler(self, self._onRepeatLogin), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_LOGIN_REPEAT, handler(self, self._onRepeatLogin), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_G2C_OFFLINE_NEW, handler(self, self._onRepeatLogin), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_G2C_OFFLINE, handler(self, self._onRepeatLogin), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CLICK_TO_LOGIN_REPEAT, handler(self, self._onRepeatLogin), self)
end

function WushAutoRunComp:onLoad()
	self:newSchedule(handler(self, self.checkAutoAction), 3)
	self:checkAutoAction()
end

function WushAutoRunComp:_onRepeatLogin()
	self:cancelAllSchedule()
	self:removeFromParent()
end

function WushAutoRunComp:onGuideExitAuto()
	self:cancelAllSchedule()
	g.core.event.EventManager:removeListenerWithTarget(self)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
	g.core.common.Scheduler:newScheduleOnce(function()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	end, 0.2)
	self:removeFromParent()
end

function WushAutoRunComp:checkAutoAction()
	if g.core.guide.GuideProxy:isGuideRunning() then
		self:onGuideExitAuto()

		return
	end

	local var_6_0 = g.core.common.ServerTime:getTime()

	if var_6_0 - self._lastRunTime < 1 then
		return
	end

	self._lastRunTime = var_6_0

	local var_6_1 = g.core.module.ModuleManager:getCurModule()
	local var_6_2 = var_6_1.display:getName()

	if var_0_0:isPassFinish() then
		self:doFinishAutoAction(var_0_1.ALL_FINISH)

		return
	end

	if var_6_2 == "WushMainLayer" and not self._pauseMainLayer then
		if var_6_1.display:doAutoAction() then
			self._pauseMainLayer = true
		end
	elseif var_6_2 == "BattleScene" then
		local var_6_3 = g.core.battle.BattleProxy:getBattleLayer()

		if var_6_3 and var_6_3.doAutoAction then
			var_6_3:doAutoAction()
		end

		self._pauseMainLayer = false
	elseif var_6_2 == "BattleResultLayer" then
		if not var_6_1.display:doAutoAction() then
			self:doFinishAutoAction(var_0_1.BATTLE_FAILED)

			return
		end

		self._pauseMainLayer = false
	elseif var_6_2 == "WushBuffChoosePop" then
		var_6_1.display:doAutoAction()
	end

	self.m_autoBg:updateAutoState({
		aType = var_0_2.WUSH
	})
end

function WushAutoRunComp:doFinishAutoAction(arg_7_1)
	fgui.UIPackage:addPackage("ui/infoPop/infoPop")

	local var_7_0 = fgui.UIPackage:createObject("infoPop", "LazyAutoFinishPop")

	var_7_0:setPosition(display.width / 2 + display.cx, display.height / 2 + display.cy)

	local var_7_1 = var_0_0:getCurFloorId() or 1

	var_7_0:updateAutoReason({
		levelTxt = g.core.lang:get(303043, {
			floor = var_7_1
		}),
		desc = g.core.lang:get(var_0_3[arg_7_1])
	})
	g.core.layer.LayerManager:getGuideTopLayer():addChild(var_7_0)
	self:cancelAllSchedule()
	g.core.event.EventManager:removeListenerWithTarget(self)
	self:removeFromParent()
end

function WushAutoRunComp:_onStopClick()
	self:doFinishAutoAction(var_0_1.USER_STOP)
end

return WushAutoRunComp

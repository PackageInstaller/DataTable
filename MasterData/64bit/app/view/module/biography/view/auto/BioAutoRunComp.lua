local var_0_0 = {
	FINISH = 2,
	RES_LACK = 1,
	PLAYER_ACTION = 0,
	BATTLE_FAILED = 3
}
local var_0_1 = g.core.const.ConstMgr.InfoConst.AUTO_TYPE
local BioAutoRunComp = class("BioAutoRunComp", require("app.fairyGUI.biography.UI_BioAutoRunComp"))

function BioAutoRunComp:ctor()
	self._lastRunTime = 0
	self._taskType = -1
	self._attack_time = 0
	self._actionComp = nil

	self.m_autoBg:updateAutoState({
		clickStopFunc = handler(self, self._onStopClick)
	})
	self.m_autoBg:updateAutoState({
		aType = var_0_1.BIO
	})

	self._timeScale = cc.Director:getInstance():getScheduler():getTimeScale()

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

function BioAutoRunComp:_onRepeatLogin()
	self:cancelAllSchedule()
	self:removeFromParent()
end

function BioAutoRunComp:setTaskType(arg_3_1)
	self._taskType = arg_3_1
end

function BioAutoRunComp:setActionComp(arg_4_1)
	self._actionComp = arg_4_1
end

function BioAutoRunComp:onLoad()
	cc.Director:getInstance():getScheduler():setTimeScale(2)
	self:newSchedule(handler(self, self.checkAutoAction), 2)
	self:checkAutoAction()
end

function BioAutoRunComp:onGuideExitAuto()
	self:cancelAllSchedule()
	g.core.event.EventManager:removeListenerWithTarget(self)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
	g.core.common.Scheduler:newScheduleOnce(function()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	end, 0.2)
	self:removeFromParent()
end

function BioAutoRunComp:checkAutoAction()
	if g.core.guide.GuideProxy:isGuideRunning() then
		self:onGuideExitAuto()

		return
	end

	local var_8_0 = g.core.common.ServerTime:getTime()

	if var_8_0 - self._lastRunTime < 1 then
		return
	end

	self._lastRunTime = var_8_0

	local var_8_1 = g.core.module.ModuleManager:getCurModule()
	local var_8_2 = var_8_1.display:getName()

	if var_8_2 == "BioGameStage" then
		cc.Director:getInstance():getScheduler():setTimeScale(2)

		local var_8_3 = g.core.common.ServerTime:getTime()

		if var_8_3 - self._attack_time < 0.5 then
			return
		end

		self._attack_time = var_8_3

		if var_8_1.display:doAutoAction(self._taskType) then
			self:doFinishAutoAction(var_0_0.FINISH)
		end
	elseif var_8_2 == "StoryDarkCurtainLayer" or var_8_2 == "TouchGameLayer" or var_8_2 == "BioGameQTELayer" or var_8_2 == "BioGameTreeLayer" or var_8_2 == "BioGameClickLayer" or var_8_2 == "PuzzleGameMainLayer" or var_8_2 == "StoryDialogLayer" or var_8_2 == "BaseFeedBackPop" or var_8_2 == "BioChapterEndPop" or var_8_2 == "StoryIllustrationLayer" then
		if var_8_1.display and var_8_1.display.doAutoAction then
			var_8_1.display:doAutoAction()
		end
	elseif var_8_2 == "BattleResultLayer" then
		if var_8_1.display and var_8_1.display.doAutoAction and not var_8_1.display:doAutoAction() then
			self:doFinishAutoAction(var_0_0.BATTLE_FAILED)
		end
	elseif var_8_2 == "BioTriggerBattlePop" then
		local var_8_4 = g.core.common.ServerTime:getTime()

		if var_8_4 - self._attack_time < 0.5 then
			return
		end

		self._attack_time = var_8_4

		if var_8_1.display and var_8_1.display.doAutoAction and var_8_1.display:doAutoAction() then
			self:doFinishAutoAction(var_0_0.RES_LACK)
		end
	elseif var_8_2 == "BattleScene" then
		local var_8_5 = g.core.battle.BattleProxy:getBattleLayer()

		if var_8_5 then
			var_8_5:doAutoAction()
		end
	end
end

function BioAutoRunComp:doFinishAutoAction(arg_9_1)
	self:cancelAllSchedule()
	g.core.event.EventManager:removeListenerWithTarget(self)
	self:removeFromParent()
end

function BioAutoRunComp:onUnload()
	cc.Director:getInstance():getScheduler():setTimeScale(self._timeScale)
end

function BioAutoRunComp:_onStopClick()
	self:doFinishAutoAction(var_0_0.PLAYER_ACTION)
end

return BioAutoRunComp

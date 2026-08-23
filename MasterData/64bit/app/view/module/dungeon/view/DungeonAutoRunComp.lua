local var_0_0 = {
	CHALLENGE_FINISH = 2,
	PLAYER_STOP = 1,
	BATTLE_FIELD = 0,
	RES_LACK = 3
}
local var_0_1 = {
	[var_0_0.BATTLE_FIELD] = g.core.lang:get(2802),
	[var_0_0.PLAYER_STOP] = g.core.lang:get(2803),
	[var_0_0.CHALLENGE_FINISH] = g.core.lang:get(2804),
	[var_0_0.RES_LACK] = g.core.lang:get(2805)
}
local var_0_2 = g.core.const.ConstMgr.InfoConst.AUTO_TYPE
local var_0_3 = g.core.model.User.dungeonData
local DungeonAutoRunComp = class("DungeonAutoRunComp", require("app.fairyGUI.dungeon.UI_DungeonAutoRunComp"))

function DungeonAutoRunComp:ctor()
	self._lastRunTime = 0
	self._attack_time = 0

	self.m_autoBg:updateAutoState({
		clickStopFunc = handler(self, self._onStopClick)
	})

	self._nextStep = nil

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

function DungeonAutoRunComp:_onRepeatLogin(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	self:cancelAllSchedule()
	self:removeFromParent()
end

function DungeonAutoRunComp:onLoad()
	var_0_3:setNormalSkipFight(true)
	var_0_3:setAutoChallenge(true)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_DUNGEON_CHALLENGESTAGEFINISH, self._onRcvBattleFinish, self)
	self:newSchedule(handler(self, self.checkAutoAction), 3)
	self:checkAutoAction()
	self.m_autoBg:updateAutoState({
		aType = var_0_2.DUNGEON
	})
end

function DungeonAutoRunComp:onGuideExitAuto()
	self:cancelAllSchedule()
	g.core.event.EventManager:removeListenerWithTarget(self)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
	g.core.common.Scheduler:newScheduleOnce(function()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	end, 0.2)
	self:removeFromParent()
end

function DungeonAutoRunComp:checkAutoAction()
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
	local var_6_2 = var_6_1.display
	local var_6_3 = var_6_1.display:getName()

	if var_6_3 == "DungeonStageLayer" and (not self._nextStep or self._nextStep == "DungeonStageLayer") then
		if g.core.common.ServerTime:getTime() - self._attack_time < 0.5 then
			return
		end

		if var_0_3:isAllPassed() then
			self:doFinishAutoAction(var_0_0.CHALLENGE_FINISH)

			return
		end

		if self:isFullBattleRes() then
			self._attack_time = g.core.common.ServerTime:getTime()
			self._nextStep = var_6_2:doAutoAction() and "DungeonMainLayer" or "BaseFeedBackPop"
		else
			self:doFinishAutoAction(var_0_0.RES_LACK)

			return
		end
	elseif var_6_3 == "DungeonMainLayer" then
		if self._nextStep then
			if self._nextStep == "DungeonMainLayer" then
				if g.core.model.User.dungeonData:isChapterPassed((g.core.model.User.dungeonData:getLastUnlockChapter())) then
					self:doFinishAutoAction(var_0_0.CHALLENGE_FINISH)

					return
				end

				var_6_2:doAutoAction()

				self._nextStep = nil

				goto label_6_0
			end

			if var_6_3 == "DungeonEffectPop" and (not self._nextStep or self._nextStep == "DungeonEffectPop") then
				var_6_2:doAutoAction()

				self._nextStep = nil
			elseif var_6_3 == "BaseFeedBackPop" and (not self._nextStep or self._nextStep == "BaseFeedBackPop") then
				var_6_2:doAutoAction()

				self._nextStep = nil
			elseif var_6_3 == "BattleResultLayer" and (not self._nextStep or self._nextStep == "BattleResultLayer") then
				var_6_2:doAutoAction()

				self._nextStep = nil
			elseif var_6_3 == "BaseConfirmPop" and (not self._nextStep or self._nextStep == "BaseConfirmPop") and var_6_2.doAutoAction then
				var_6_2:doAutoAction()
			end
		end
	end

	::label_6_0::
end

function DungeonAutoRunComp:isFullBattleRes()
	if g.core.model.User.resourceData:getVit() < g.core.config.dungeon_stage_info.get((var_0_3:getLastUnlockStageId())).cost then
		return false
	end

	return true
end

function DungeonAutoRunComp:_onRcvBattleFinish(arg_8_1, arg_8_2, arg_8_3)
	if not arg_8_3.is_win then
		self:doFinishAutoAction(var_0_0.BATTLE_FIELD)
	end
end

function DungeonAutoRunComp:doFinishAutoAction(arg_9_1)
	fgui.UIPackage:addPackage("ui/infoPop/infoPop")

	local var_9_0 = fgui.UIPackage:createObject("infoPop", "LazyAutoFinishPop")

	var_9_0:setPosition(display.width / 2 + display.cx, display.height / 2 + display.cy)

	local var_9_1 = g.core.config.dungeon_chapter_info.get((g.core.model.User.dungeonData:getLastUnlockChapter()))

	var_9_0:updateAutoReason({
		levelTxt = g.core.lang:get(2808, {
			num1 = var_9_1.land_id,
			num2 = var_9_1.id
		}),
		desc = g.core.lang:get(var_0_1[arg_9_1])
	})
	g.core.layer.LayerManager:getGuideTopLayer():addChild(var_9_0)
	self:cancelAllSchedule()
	g.core.event.EventManager:removeListenerWithTarget(self)
	self:removeFromParent()
end

function DungeonAutoRunComp:_onStopClick()
	self:doFinishAutoAction(var_0_0.PLAYER_STOP)
end

function DungeonAutoRunComp:onUnload()
	var_0_3:setAutoChallenge(false)
end

return DungeonAutoRunComp

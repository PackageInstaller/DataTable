local var_0_0 = 1
local var_0_1 = 3
local var_0_2 = g.core.const.ConstMgr
local var_0_3 = g.core.common.ServerTime
local var_0_4 = g.core.module.ModuleManager
local var_0_5 = g.core.model.User.peakArenaData
local var_0_6 = g.core.network.GameNetProxy
local PeakArenaMatchSuccessPop = require("app.view.module.peakArena.view.PeakArenaMatchSuccessPop")
local PeakArenaMatchingPop = class("PeakArenaMatchingPop", require("app.fairyGUI.peakArena.UI_PeakArenaMatchingPop"), function()
	return fgui.GComponent:create({
		resName = "PeakArenaMatchingPop",
		pkgName = "peakArena",
		isFullScreen = true,
		pkgPath = "ui/peakArena/peakArena"
	}, ...)
end)

function PeakArenaMatchingPop:ctor()
	self._timer = nil
	self._startTime = 0
	self._exeTimerLastTime = 0
	self._maxMatchingDuration = var_0_5:getMaxMatchingDuration()

	self.m_cancelBtn:addClickListener(handler(self, self._onClickCancelBtn))
end

function PeakArenaMatchingPop:onLoad()
	var_0_5:clearMatchedOpponentInfo()
	var_0_5:clearBattleId()
	var_0_6:send_C2S_PeakArena_Match({})
	self.m_cancelBtn:setTouchable(true)
	self:_startScheduler()
	self:_playEnterAni()
	g.core.sound.SoundManager:playSound(var_0_2.SoundConst.Sound.PEAK_ARENA_MATCHING_IN)
	g.core.sound.SoundManager:playSound(var_0_2.SoundConst.Sound.PEAK_ARENA_MATCHING)
end

function PeakArenaMatchingPop:onUnload()
	self:_cancelScheduler()
	g.core.sound.SoundManager:playSound(var_0_2.SoundConst.Sound.PEAK_ARENA_MATCHING_STOP)
end

function PeakArenaMatchingPop:_onClickCancelBtn()
	self.m_cancelBtn:setTouchable(false)
	self:_cancelMatching()
end

function PeakArenaMatchingPop:_onCD()
	local var_6_0 = var_0_3:getTime()

	if var_6_0 - self._exeTimerLastTime < var_0_0 then
		return
	end

	self._exeTimerLastTime = var_6_0

	local var_6_1 = var_6_0 - self._startTime

	self.m_cdTxt:setText((var_0_3:secondToMSString(var_6_0 - self._startTime)))

	local var_6_2 = var_0_5:getMatchedOpponentInfo()

	if var_6_2 then
		if (var_6_2.isRobot and g.core.model.User.snapShotCacheData:getDataSnapShotTemplate(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, var_6_2.targetId) or g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, var_6_2.targetId)) and var_6_1 >= var_0_1 then
			self:_gotoMatchSuccessPop()
		end
	elseif var_6_1 >= self._maxMatchingDuration then
		self:_cancelMatching(true)
	end
end

function PeakArenaMatchingPop:_gotoMatchSuccessPop()
	self.m_cancelBtn:setTouchable(false)
	self:_cancelScheduler()
	var_0_4:popModule()
	var_0_4:pushPopup(PeakArenaMatchSuccessPop.new(), {
		touchDisappear = false,
		ignoreTouch = true
	})
end

function PeakArenaMatchingPop:_startScheduler()
	self._startTime = var_0_3:getTime()

	self:_onCD()

	self._timer = self._timer or g.core.common.Scheduler:newSchedule(handler(self, self._onCD), var_0_0)
end

function PeakArenaMatchingPop:_cancelScheduler()
	if self._timer then
		g.core.common.Scheduler:cancelSchedule(self._timer)

		self._timer = nil
	end
end

function PeakArenaMatchingPop:_cancelMatching(arg_10_1)
	self.m_cancelBtn:setTouchable(false)
	self:_cancelScheduler()
	var_0_6:send_C2S_PeakArena_ChallengeBegin({
		is_battle = false
	})
	var_0_4:popModule()

	if arg_10_1 then
		var_0_4:tip(g.core.lang:get(307009))
	else
		var_0_5:cancelMatching()
	end
end

function PeakArenaMatchingPop:_playEnterAni(arg_11_1)
	self.m_enterTransition:setHook("enter", function()
		self.m_matchingDiskComp:playEnterAni()
	end)
	self.m_enterTransition:setHook("loop", function()
		self.m_matchingDiskComp:playTurnAroundAni()
	end)
	self.m_enterTransition:play()
	self.m_effDi:addEffectSpine({
		remove = false,
		name = "eff_ui_peakArena_di",
		isLoop = true
	})
end

return PeakArenaMatchingPop

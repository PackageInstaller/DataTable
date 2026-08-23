local var_0_0 = g.core.common.ServerTime
local var_0_1 = g.core.const.ConstMgr.PubgConst
local var_0_2 = g.core.const.ConstMgr
local PubgMatchingPop = class("PubgMatchingPop", require("app.fairyGUI.pubg.UI_PubgMatchingPop"), function()
	return fgui.GComponent:create({
		resName = "PubgMatchingPop",
		pkgPath = "ui/pubg/pubg",
		isFullScreen = true,
		pkgName = "pubg"
	}, ...)
end)

function PubgMatchingPop:ctor(arg_2_1)
	self._timer = nil
	self._startTime = 0

	self:_initView()
	self:_initBtn()
	self:showAtCenter()
end

function PubgMatchingPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PUBG_GAMEBEGIN, handler(self, self._onRecvGameBegin), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PUBG_CANCELMATCH, handler(self, self._onRecvCancelMatch), self)
	self.m_enterTransition:play()
	self:_playEnterAni()
	g.core.sound.SoundManager:playSound(var_0_2.SoundConst.Sound.PEAK_ARENA_MATCHING_IN)
end

function PubgMatchingPop:onUnload()
	self:_cancelScheduler()
end

function PubgMatchingPop:_initBtn()
	self.m_cancelBtn:addClickListener(handler(self, self._onCancelBtnClick))
end

function PubgMatchingPop:_initView(arg_6_1)
	self.m_stateController:setSelectedIndex(0)
	self:_startScheduler()
end

function PubgMatchingPop:_startScheduler()
	self._startTime = var_0_0:getTime()

	self:_onCD()

	self._timer = self._timer or g.core.common.Scheduler:newSchedule(handler(self, self._onCD), 1)
end

function PubgMatchingPop:_onCD()
	local var_8_0 = var_0_0:getTime() - self._startTime

	self.m_cdText:setText((var_0_0:secondToMSString(var_8_0)))
	self.m_tipsText:setVisible(var_8_0 >= var_0_1.MATCHING_TIME_LONG)

	if self._matchTime and var_8_0 >= self._matchTime then
		self:_cancelScheduler()
		self.m_stateController:setSelectedIndex(1)
		self:newScheduleOnce(handler(self, self._enterMapLayer), 2)
	elseif var_8_0 >= var_0_1.MATCHING_TIME_OUT then
		self:_cancelScheduler()
		g.core.module.ModuleManager:tip(g.core.lang:get(307009))
		g.core.network.GameNetProxy:send_C2S_Pubg_CancelMatch({})
	end
end

function PubgMatchingPop:_cancelScheduler()
	if self._timer then
		g.core.common.Scheduler:cancelSchedule(self._timer)

		self._timer = nil
	end
end

function PubgMatchingPop:_onRecvGameBegin(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	self._matchTime = var_0_0:getTime() - self._startTime

	self:_onCD()
end

function PubgMatchingPop:_onRecvCancelMatch(arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	self:_cancelScheduler()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function PubgMatchingPop:_playEnterAni()
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

function PubgMatchingPop:_enterMapLayer()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	g.core.module.ModuleManager:pushModule(g.view.entrance.PUBG_MAP_LAYER)
end

function PubgMatchingPop:_onCancelBtnClick()
	g.core.network.GameNetProxy:send_C2S_Pubg_CancelMatch({})
end

return PubgMatchingPop

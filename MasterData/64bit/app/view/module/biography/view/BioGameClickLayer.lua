local var_0_0 = g.core.model.User.bioData
local BattleConst = require("app.view.battle.const.BattleConst")
local var_0_2 = BattleConst.SPINE_ACTION_TYPE
local var_0_3 = g.core.event
local BioGameClickLayer = class("BioGameClickLayer", require("app.fairyGUI.biography.UI_BioGameClickLayer"), function()
	return fgui.GComponent:create({
		isFullScreen = true,
		pkgPath = "ui/biography/biography",
		resName = "BioGameClickLayer",
		pkgName = "biography"
	}, ...)
end)

function BioGameClickLayer:ctor(arg_2_1)
	self._missionId = arg_2_1
	self._spine = nil
	self._isDone = false
	self._lastTouchTime = 0
	self._isHasSendNet = false
	self._isProgressFull = false

	self:_initView()
	self:_initBtn()
end

function BioGameClickLayer:onLoad()
	var_0_3.EventManager:dispatchEvent(var_0_3.enum.EVENT_BIO_SET_HUDUI_SHOW, false, false)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_TICK, false, {
		key = "BIO_CLICK_GAME_STAGE_1",
		targetBtn = self.m_clickBtn
	})
end

function BioGameClickLayer:onUnload()
	var_0_3.EventManager:dispatchEvent(var_0_3.enum.EVENT_BIO_SET_HUDUI_SHOW, false, true)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH)
end

function BioGameClickLayer:_initView()
	local var_5_0 = g.core.config.biography_event_info.get(var_0_0:getMission(self._missionId).sub_id)

	self.m_infoComp:updateEventInfo(var_5_0)

	self._spine = self.m_iconHolderComp:addEffectSpine({
		isLoop = false,
		name = var_5_0.pic,
		anim = var_0_2.IDLE,
		eventHandler = handler(self, self._onSpineEvent)
	})
end

function BioGameClickLayer:_initBtn()
	self.m_clickBtn:addClickListener(handler(self, self._onGameClick))
end

function BioGameClickLayer:_onGameClick()
	if self._isProgressFull then
		return
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH, false, {
		finish = true
	})

	if self._guideSchedulerId then
		self:cancelSchedule(self._guideSchedulerId)

		self._guideSchedulerId = nil
	end

	self.m_iconHolderComp:stopAllFGActions()
	self.m_iconHolderComp:setScale(1)
	self.m_infoComp:onClickOnce()
	self:_showHitAnimation()

	self._lastTouchTime = os.time()
	self._guideSchedulerId = self:newSchedule(handler(self, self._onCheckGuideScheduler), 1)
end

function BioGameClickLayer:_onCheckGuideScheduler()
	if os.time() - self._lastTouchTime >= 4 then
		if self._guideSchedulerId then
			self:cancelSchedule(self._guideSchedulerId)

			self._guideSchedulerId = nil
		end

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_TICK, false, {
			key = "BIO_CLICK_GAME_STAGE_2",
			targetBtn = self.m_clickBtn
		})
	end
end

function BioGameClickLayer:_onSpineEvent(arg_9_1)
	if arg_9_1.type == BattleConst.SPINE_EVENT.COMPLETE then
		if arg_9_1.animation == var_0_2.IDLE or arg_9_1.animation == var_0_2.HIT then
			self._spine:setAnimation(0, var_0_2.IDLE, true)
		elseif arg_9_1.animation == var_0_2.OUT then
			self:_onFinishClickTask()
		end
	elseif arg_9_1.type == "end" and self._isProgressFull then
		self:_onFinishClickTask()
	end
end

function BioGameClickLayer:_onFinishClickTask()
	if not self._isHasSendNet then
		self._isHasSendNet = true

		g.core.network.GameNetProxy:send_C2S_Biography_ExecuteMission({
			id = self._missionId
		})
		g.core.module.ModuleManager:popComponent()
	end
end

function BioGameClickLayer:receiveCompEvent(arg_11_1)
	if arg_11_1 == "progressChanging" then
		self:_showHitAnimation()
	elseif arg_11_1 == "progress_bar_is_over" then
		self._isProgressFull = true

		local var_11_0 = false

		for iter_11_0, iter_11_1 in ipairs(self._spine:getAnimationNames() or {}) do
			if iter_11_1 and iter_11_1 == var_0_2.OUT then
				var_11_0 = true

				self._spine:setAnimation(0, var_0_2.OUT, false)
			end
		end

		if not var_11_0 then
			self:_onFinishClickTask()
		end
	end
end

function BioGameClickLayer:_showHitAnimation()
	self._preTime = self._curTime or 0

	local var_12_0 = self.m_infoComp:getCurPercent() * ((self._spine:getAnimationDuration(var_0_2.HIT) or 0) / self.m_infoComp:getMaxPercent())

	self._curTime = var_12_0

	self._spine:setAnimation(0, var_0_2.HIT, false)

	if var_12_0 > self._preTime then
		self._spine:play(self._preTime, self._curTime)
	else
		self._spine:play(var_12_0, self._preTime)
	end
end

function BioGameClickLayer:doAutoAction()
	for iter_13_0 = 1, 6 do
		if self.m_infoComp:onClickOnce() then
			self:_onFinishClickTask()

			return
		end
	end
end

return BioGameClickLayer

local var_0_0 = g.core.model.User.richmanData
local var_0_1 = g.core.config.richman_event_info
local var_0_2 = g.core.config.richman_game_info
local var_0_3 = require("app.view.module.goldSaving.const.GoldSavingConst").TURN_GAME_CONST
local RichmanWishTreeLayer = class("RichmanWishTreeLayer", require("app.fairyGUI.richman.UI_RichmanWishTreeLayer"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/richman/richman",
		resName = "RichmanWishTreeLayer",
		pkgName = "richman",
		isFullScreen = true
	}, ...)
end)

function RichmanWishTreeLayer:ctor(arg_2_1)
	self._event = arg_2_1
	self._params = arg_2_1.params
	self._eventCfg = var_0_1.get(arg_2_1.id)
	self._gameId = self._eventCfg.event_value1

	self:onUpdateRewardShow()
	self.m_bgDi:setURL("bg/richman/bg_dfw_game1.jpg")

	self._curTimes = 0

	self.m_topBarComp:setTitle(var_0_2.get(self._gameId).event_name)

	self._perPos = nil

	self:_initBtn()
	self:_initView()
end

function RichmanWishTreeLayer:_initBtn()
	self.m_startBtn:addClickListener(handler(self, self._onBeginClick))
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_SmallGame_ShuJu)
end

function RichmanWishTreeLayer:_initView()
	self.m_rotateEffect = self.m_eff:addEffectSpine({
		name = "eff_ui_richman_rotate",
		anim = "loop",
		isLoop = true
	})

	self.m_rotateEffect:setTimeScale(0.5)
end

function RichmanWishTreeLayer:onLoad()
	self.m_enterTransition:play()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RICH_MAN_EVENTPROCESS, self._onWishProcess, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_RICHMAN_EVENTPROCESS_FAILED, self.onGameStageFinish, self)
	self:updateView()
end

function RichmanWishTreeLayer:onGameStageFinish()
	g.core.module.ModuleManager:tip(g.core.lang:get(426006))
	g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)
end

function RichmanWishTreeLayer:onUpdateRewardShow()
	local var_7_0, var_7_1 = var_0_0:getGameData():getWishTreeGameData(self._event)

	self._awardList = var_7_0
	self._specialReward = var_7_1

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		if self["m_rewardItem" .. iter_7_0] then
			self["m_rewardItem" .. iter_7_0]:updateRewardItem(iter_7_1)
		end
	end
end

function RichmanWishTreeLayer:_onWishProcess(arg_8_1, arg_8_2, arg_8_3)
	self._finalAwards = arg_8_3 and arg_8_3.awards

	if self._params then
		local var_8_0 = 0
		local var_8_1 = g.core.common.Goods:convertAwards(self._finalAwards)

		for iter_8_0, iter_8_1 in ipairs(self._awardList) do
			for iter_8_2, iter_8_3 in ipairs(var_8_1) do
				if iter_8_1.type == iter_8_3.type and iter_8_1.value == iter_8_3.value and iter_8_1.size == iter_8_3.size then
					var_8_0 = iter_8_0

					break
				end
			end

			if var_8_0 > 0 then
				break
			end
		end

		self._rewardPos = var_8_0 > 0 and var_8_0 or self._params[1]
	else
		self._rewardPos = arg_8_3.event.params
	end

	self._curTimes = 0
	self._rewardPos = self._rewardPos - var_0_3.PER_NUM

	if self._rewardPos <= 0 then
		self._rewardPos = self._rewardPos + var_0_3.ALL_NUM
	end

	self.m_startBtn:setVisible(false)
	self:startRun()
end

function RichmanWishTreeLayer:updateView()
	self.m_startBtn:setVisible(true)
end

function RichmanWishTreeLayer:onUnload()
	self:showReward()

	if self._rotateSchedule then
		g.core.common.Scheduler:cancelSchedule(self._rotateSchedule)

		self._rotateSchedule = nil
	end
end

function RichmanWishTreeLayer:getNextNumber(arg_11_1, arg_11_2)
	local var_11_0 = arg_11_1

	if arg_11_2 then
		var_11_0 = var_11_0 + 1

		if var_11_0 > var_0_3.ALL_NUM then
			var_11_0 = var_11_0 - var_0_3.ALL_NUM
		end
	else
		var_11_0 = var_11_0 - 1

		if var_11_0 < 1 then
			var_11_0 = var_0_3.ALL_NUM
		end
	end

	return var_11_0
end

function RichmanWishTreeLayer:_onBeginClick()
	g.core.network.GameNetProxy:send_C2S_RichMan_EventProcess({
		unique_id = self._event.unique_id,
		params = {}
	})
	self.m_startBtn:setVisible(false)
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_SmallGame_Kaishi)
end

function RichmanWishTreeLayer:_playRotateEffect()
	if self._rotateSchedule or not self.m_rotateEffect then
		return
	end

	self._timeScale = 3

	self.m_rotateEffect:setTimeScale(self._timeScale)

	self._rotateSchedule = g.core.common.Scheduler:newSchedule(handler(self, self.addRotateSpeed), 1)
end

function RichmanWishTreeLayer:addRotateSpeed()
	if not self.m_rotateEffect then
		return
	end

	self._timeScale = self._timeScale + 3

	self.m_rotateEffect:setTimeScale(self._timeScale)

	if self._timeScale > 10 then
		self.m_rotateEffect:dispose()

		self.m_rotateEffect = nil

		self:onRunEffFinish()

		if self._rotateSchedule then
			g.core.common.Scheduler:cancelSchedule(self._rotateSchedule)

			self._rotateSchedule = nil
		end
	end
end

function RichmanWishTreeLayer:finalRunLight()
	self._curTimes = self._curTimes + 1

	if not self._perPos then
		self["m_rewardItem" .. self._rewardPos]:lightStateChange(true)

		self._perPos = {
			self._rewardPos
		}
	else
		self["m_rewardItem" .. self._perPos[1]]:lightStateChange(false)
		self["m_rewardItem" .. self._rewardPos]:lightStateChange(true)

		self._perPos = {
			self._rewardPos
		}
	end

	self._rewardPos = self:getNextNumber(self._rewardPos, true)

	if self._curTimes <= var_0_3.PER_NUM then
		self:newScheduleOnce(handler(self, self.finalRunLight), var_0_3.BASE_TIME * math.pow(1.5, self._curTimes - 1))
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_SmallGame_Chouka)
	else
		self["m_rewardItem" .. self._perPos[1]]:playFinish()
		self:newScheduleOnce(handler(self, self.showReward), var_0_3.SHOW_AWARD_DELAY)
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_SmallGame_Jiesuan)
	end
end

function RichmanWishTreeLayer:showReward()
	if self._finalAwards then
		g.core.module.ModuleManager:awardSummary(self._finalAwards, nil, nil, g.core.lang:get(300001), handler(self, self._onClose))

		self._finalAwards = nil
	end
end

function RichmanWishTreeLayer:_onClose()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function RichmanWishTreeLayer:startRun()
	self:_playRotateEffect()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_SmallGame_ChoukaVideo)
end

function RichmanWishTreeLayer:onRunEffFinish()
	self:finalRunLight()
end

function RichmanWishTreeLayer:onUnload()
	if self._finalAwards then
		local var_20_0 = self._finalAwards

		g.core.common.Scheduler:newScheduleOnce(function()
			g.core.module.ModuleManager:awardSummary(var_20_0)
		end, 0)

		self._finalAwards = nil
	end
end

return RichmanWishTreeLayer

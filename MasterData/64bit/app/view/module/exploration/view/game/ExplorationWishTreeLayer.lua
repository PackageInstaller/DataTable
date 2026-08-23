local var_0_0 = 20
local var_0_1 = 12
local var_0_2 = g.core.config.exploration_game_info
local var_0_3 = g.core.model.User.explorationData
local ExplorationWishTreeLayer = class("ExplorationWishTreeLayer", require("app.fairyGUI.exploration.UI_ExplorationWishTreeLayer"), function()
	return fgui.GComponent:create({
		resName = "ExplorationWishTreeLayer",
		pkgName = "exploration",
		isFullScreen = true,
		pkgPath = "ui/exploration/exploration"
	}, ...)
end)

function ExplorationWishTreeLayer:ctor(arg_2_1)
	self._event = arg_2_1
	self._params = arg_2_1.params

	self:addBg("bg/exploration/bg_slmj_xuyuanshu.jpg")
	self.m_startBtn:addClickListener(handler(self, self.onStartClick))

	self._rewardPos = -1
	self._nextLightNum = 0

	self.m_topBarComp:setTitle(var_0_2.get(arg_2_1.id).event_name)
	self.m_enterTransition:play()
	self:onUpdateRewardShow()
end

function ExplorationWishTreeLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_EXPLORATION_EVENTPROCESS, self._onWishProcess, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_EXPLORATION_EVENTPROCESS_FAILED, self.onGameStageFinish, self)
end

function ExplorationWishTreeLayer:onGameStageFinish()
	g.core.module.ModuleManager:tip(g.core.lang:get(420691))
	g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)
end

function ExplorationWishTreeLayer:onUpdateRewardShow()
	local var_5_0, var_5_1 = var_0_3:getGameData():getWishTreeGameData(self._event)

	self._awardList = var_5_0
	self._specialReward = var_5_1

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		if self["m_rewardItem" .. iter_5_0] then
			self["m_rewardItem" .. iter_5_0]:updateRewardItem(iter_5_1)
		end
	end
end

function ExplorationWishTreeLayer:onStartClick()
	g.core.network.GameNetProxy:send_C2S_Exploration_EventProcess({
		unique_id = self._event.unique_id,
		params = {}
	})
end

function ExplorationWishTreeLayer:_onWishProcess(arg_7_1, arg_7_2, arg_7_3)
	self._finalAwards = arg_7_3 and arg_7_3.awards

	if self._params then
		local var_7_0 = 0
		local var_7_1 = g.core.common.Goods:convertAwards(self._finalAwards)

		for iter_7_0, iter_7_1 in ipairs(self._awardList) do
			for iter_7_2, iter_7_3 in ipairs(var_7_1) do
				if iter_7_1.type == iter_7_3.type and iter_7_1.value == iter_7_3.value and iter_7_1.size == iter_7_3.size then
					var_7_0 = iter_7_0

					break
				end
			end

			if var_7_0 > 0 then
				break
			end
		end

		self._rewardPos = var_7_0 > 0 and var_7_0 or self._params[1]
	else
		self._rewardPos = arg_7_3.event.params
	end

	self:playMoveAnim()
	self.m_startGroup:setVisible(false)
end

function ExplorationWishTreeLayer:playMoveAnim()
	self._runIndex = {}

	for iter_8_0 = 1, var_0_0 - 1 do
		table.insert(self._runIndex, math.random(1, var_0_1))
	end

	table.insert(self._runIndex, self._rewardPos)
	self:newSchedule(handler(self, self.runWishAction), 0)
end

function ExplorationWishTreeLayer:runWishAction()
	if self._runIndex then
		if #self._runIndex == 1 then
			self:cancelAllSchedule()
			g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_Tree_Receive_Award)
			self:playFinalAward()
		elseif self._nextLightNum == 0 then
			self:resetNextLightNum()
			g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_Triggering)
			self["m_rewardItem" .. table.remove(self._runIndex, 1)]:playRun()
		else
			self._nextLightNum = self._nextLightNum - 1
		end
	end
end

function ExplorationWishTreeLayer:resetNextLightNum()
	self._nextLightNum = math.abs(var_0_0 / 2 - #self._runIndex) * 2
end

function ExplorationWishTreeLayer:playFinalAward()
	self["m_rewardItem" .. self._rewardPos]:playAward(handler(self, self.onShowAward))
end

function ExplorationWishTreeLayer:onShowAward()
	if self._finalAwards then
		g.core.module.ModuleManager:awardSummary(self._finalAwards, nil, nil, g.core.lang:get(300001), handler(self, self._onClose))

		self._finalAwards = nil
	end
end

function ExplorationWishTreeLayer:_onClose()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function ExplorationWishTreeLayer:onUnload()
	if self._finalAwards then
		local var_14_0 = self._finalAwards

		g.core.common.Scheduler:newScheduleOnce(function()
			g.core.module.ModuleManager:awardSummary(var_14_0)
		end, 0)

		self._finalAwards = nil
	end
end

return ExplorationWishTreeLayer

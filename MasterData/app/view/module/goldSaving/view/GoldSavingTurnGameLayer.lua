local GoldSavingConst = require("app.view.module.goldSaving.const.GoldSavingConst")
local var_0_1 = GoldSavingConst.TURN_GAME_CONST
local GoldSavingTurnGameLayer = class("GoldSavingTurnGameLayer", require("app.fairyGUI.goldSaving.UI_GoldSavingTurnGameLayer"), function()
	return fgui.GComponent:create({
		resName = "GoldSavingTurnGameLayer",
		pkgPath = "ui/goldSaving/goldSaving",
		isFullScreen = true,
		pkgName = "goldSaving"
	}, ...)
end)

function GoldSavingTurnGameLayer:ctor(arg_2_1)
	self._cfg = arg_2_1.cfg
	self._gameId = arg_2_1.cfg.id
	self._awardList, self._specialAward = g.core.model.User.goldSavingData:getTurnGameAwardList(self._gameId)
	self._curActId = arg_2_1.actId
	self._curTimes = 0

	self.m_topBarComp:setTitle(arg_2_1.cfg.event_name)
	self.m_topBarComp:setResInfoById(310)
	self.m_topBarComp:setTopIconGroupVisible(false)

	self._perPos = nil
	self._params = arg_2_1.content and arg_2_1.content.params or nil
	self._endPos = {}

	self:_initBtn()
	self:_initView()
end

function GoldSavingTurnGameLayer:onLoad()
	self.m_enterTransition:play()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GOLD_SAVING_GAMEOVER, self._onTurnGameAward, self)
	self:updateView()
end

function GoldSavingTurnGameLayer:updateView()
	self.m_beginBtn:setVisible(true)

	if self._cfg.type == GoldSavingConst.GAME_TYPE.DAILY_BOX_TURN_TABLE then
		self.m_showStateController:setSelectedIndex(2)
		self.m_costComp:updateByTVS({
			size = 1,
			showHave = true,
			type = g.core.common.Goods.TYPE_ITEM,
			value = g.core.model.User.itemsData:getDailyBoxGameItemInfo().id
		})
	elseif self._specialAward then
		self.m_showStateController:setSelectedIndex(1)
		self.m_tipsText:setText(g.core.lang:get(407920, {
			num = self._specialAward.size,
			name = self._specialAward.name
		}))
	else
		self.m_showStateController:setSelectedIndex(0)
	end
end

function GoldSavingTurnGameLayer:onUnload()
	self:showReward()

	if self._rotateSchedule then
		g.core.common.Scheduler:cancelSchedule(self._rotateSchedule)

		self._rotateSchedule = nil
	end
end

function GoldSavingTurnGameLayer:getNextNumber(arg_6_1, arg_6_2)
	local var_6_0 = arg_6_1

	if arg_6_2 then
		var_6_0 = var_6_0 + 1

		if var_6_0 > var_0_1.ALL_NUM then
			var_6_0 = var_6_0 - var_0_1.ALL_NUM
		end
	else
		var_6_0 = var_6_0 - 1

		if var_6_0 < 1 then
			var_6_0 = var_0_1.ALL_NUM
		end
	end

	return var_6_0
end

function GoldSavingTurnGameLayer:_initBtn()
	self.m_beginBtn:addClickListener(handler(self, self._onBeginClick))
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_SmallGame_ShuJu)
end

function GoldSavingTurnGameLayer:_initView()
	self:addBg("bg/goldSaving/bg_sj_game1.jpg")

	for iter_8_0 = 1, #self._awardList do
		local var_8_0 = self._awardList[iter_8_0]
		local var_8_1 = self["m_awardIcon" .. iter_8_0]

		if self["m_awardIcon" .. iter_8_0] then
			local var_8_2 = g.core.common.Goods:convert(var_8_0)

			var_8_1:setIcon(var_8_2.icon)
			var_8_1:setTitle(var_8_0.size)
			var_8_1:setClickData(var_8_0)

			if self._cfg.type == GoldSavingConst.GAME_TYPE.DAILY_BOX_TURN_TABLE then
				var_8_1:getController("bigAward"):setSelectedIndex((GoldSavingConst.DAILY_BOX_BIG_AWARD[var_8_2.type] and GoldSavingConst.DAILY_BOX_BIG_AWARD[var_8_2.type][var_8_2.value] or nil) and GoldSavingConst.DAILY_BOX_BIG_AWARD[var_8_2.type][var_8_2.value] <= var_8_2.size and 1 or 0)
			else
				var_8_1:getController("bigAward"):setSelectedIndex(var_8_0.size >= var_0_1.BIG_AWARD_NUM and 1 or 0)
			end
		end
	end

	self.m_rotateEffect = self.m_eff:addEffectSpine({
		anim = "loop",
		name = "eff_ui_goldSaving_rotate",
		isLoop = true
	})

	self.m_rotateEffect:setTimeScale(0.5)
end

function GoldSavingTurnGameLayer:_onBeginClick()
	if self._cfg.type == GoldSavingConst.GAME_TYPE.DAILY_BOX_TURN_TABLE then
		local var_9_0 = g.core.model.User.itemsData:getDailyBoxGameItemInfo()

		if g.core.model.User.bagData:getOwnNum(g.core.common.Goods.TYPE_ITEM, var_9_0.id) > 0 then
			g.core.network.GameNetProxy:send_C2S_Item_Use({
				num = 1,
				id = var_9_0.id
			})
		else
			g.core.module.ModuleManager:tip(g.core.lang:get(404025))

			return
		end
	else
		g.core.network.GameNetProxy:send_C2S_GoldSaving_GameOver({
			game_id = self._gameId
		})
		self:newScheduleOnce(handler(self, self._checkActId), 0)
	end

	self.m_beginBtn:setVisible(false)
	self.m_showStateController:setSelectedIndex(0)
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_SmallGame_Kaishi)
end

function GoldSavingTurnGameLayer:_playRotateEffect()
	if self._rotateSchedule or not self.m_rotateEffect then
		return
	end

	self._timeScale = 3

	self.m_rotateEffect:setTimeScale(self._timeScale)

	self._rotateSchedule = g.core.common.Scheduler:newSchedule(handler(self, self.addRotateSpeed), 1)
end

function GoldSavingTurnGameLayer:addRotateSpeed()
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

function GoldSavingTurnGameLayer:finalRunLight()
	self._curTimes = self._curTimes + 1

	if not self._perPos then
		self["m_awardIcon" .. self._endPos[1]]:lightStateChange(true)

		self._perPos = {
			self._endPos[1]
		}
	else
		self["m_awardIcon" .. self._perPos[1]]:lightStateChange(false)
		self["m_awardIcon" .. self._endPos[1]]:lightStateChange(true)

		self._perPos = {
			self._endPos[1]
		}
	end

	self._endPos[1] = self:getNextNumber(self._endPos[1], true)

	if self._curTimes <= var_0_1.PER_NUM then
		self:newScheduleOnce(handler(self, self.finalRunLight), var_0_1.BASE_TIME * math.pow(1.5, self._curTimes - 1))
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_SmallGame_Chouka)
	else
		self["m_awardIcon" .. self._perPos[1]]:playFinish()
		self:newScheduleOnce(handler(self, self.showReward), var_0_1.SHOW_AWARD_DELAY)
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_SmallGame_Jiesuan)
	end
end

function GoldSavingTurnGameLayer:showReward()
	if self._cfg.type == GoldSavingConst.GAME_TYPE.DAILY_BOX_TURN_TABLE and g.core.model.User.bagData:getOwnNum(g.core.common.Goods.TYPE_ITEM, g.core.model.User.itemsData:getDailyBoxGameItemInfo().id) > 0 and self._finalAwards then
		local var_13_0 = self._finalAwards

		g.core.common.Scheduler:newScheduleOnce(function()
			g.core.module.ModuleManager:awardSummary(var_13_0)
		end, 0)

		self._finalAwards = nil

		if self._perPos then
			self["m_awardIcon" .. self._perPos[1]]:lightStateChange(false)

			self._perPos = nil
		end

		self._curTimes = 0

		self:updateView()

		if not self.m_rotateEffect then
			self.m_rotateEffect = self.m_eff:addEffectSpine({
				anim = "loop",
				name = "eff_ui_goldSaving_rotate",
				isLoop = true
			})

			self.m_rotateEffect:setTimeScale(0.5)
		end

		return
	end

	if self._finalAwards then
		local var_13_1 = self._finalAwards
		local var_13_2 = handler(self, function(arg_15_0)
			if arg_15_0 and not tolua.isnull(arg_15_0) then
				g.core.module.ModuleManager:popAllPopup()
				g.core.module.ModuleManager:onlyPopSelfByDisplay(arg_15_0)
			end
		end)

		g.core.module.ModuleManager:popAllPopup()
		g.core.common.Scheduler:newScheduleOnce(function()
			g.core.module.ModuleManager:awardSummary(var_13_1, nil, nil, nil, var_13_2)
		end, var_0_1.SHOW_AWARD_DELAY)
	end

	self._finalAwards = nil
end

function GoldSavingTurnGameLayer:_onTurnGameAward(arg_17_1, arg_17_2, arg_17_3)
	self._finalAwards = arg_17_3 and arg_17_3.awards

	if self._params then
		local var_17_0 = 0
		local var_17_1 = g.core.common.Goods:convertAwards(self._finalAwards)

		for iter_17_0, iter_17_1 in ipairs(self._awardList) do
			for iter_17_2, iter_17_3 in ipairs(var_17_1) do
				if iter_17_1.type == iter_17_3.type and iter_17_1.value == iter_17_3.value and iter_17_1.size == iter_17_3.size then
					var_17_0 = iter_17_0

					break
				end
			end

			if var_17_0 > 0 then
				break
			end
		end

		if var_17_0 > 0 then
			self._endPos[1] = var_17_0
		else
			self._endPos = self._params
		end
	else
		self._endPos = arg_17_3.params
	end

	for iter_17_4, iter_17_5 in ipairs(self._endPos) do
		self._endPos[iter_17_4] = self._endPos[iter_17_4] - var_0_1.PER_NUM

		if self._endPos[iter_17_4] <= 0 then
			self._endPos[iter_17_4] = self._endPos[iter_17_4] + var_0_1.ALL_NUM
		end
	end

	self:startRun()
end

function GoldSavingTurnGameLayer:startRun()
	self:_playRotateEffect()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_SmallGame_ChoukaVideo)
end

function GoldSavingTurnGameLayer:onRunEffFinish()
	self:finalRunLight()
end

function GoldSavingTurnGameLayer:_checkActId()
	if self._curActId ~= nil and g.core.model.User.goldSavingData:getCurActId() ~= self._curActId then
		g.core.module.ModuleManager:tip(g.core.lang:get(307029))
		g.core.module.ModuleManager:popAllPopup()
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	end
end

return GoldSavingTurnGameLayer

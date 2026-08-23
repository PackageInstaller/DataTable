local var_0_0 = g.core.model.User.domainData
local var_0_1 = g.core.const.ConstMgr.DomainConst.TURN_GAME_CONST
local DomainTurnGamePop = class("DomainTurnGamePop", require("app.fairyGUI.domainDungeon.UI_DomainTurnGamePop"), function()
	return fgui.GComponent:create({
		resName = "DomainTurnGamePop",
		pkgPath = "ui/domainDungeon/domainDungeon",
		pkgName = "domainDungeon"
	}, ...)
end)

function DomainTurnGamePop:ctor(arg_2_1)
	self.m_touchArea:setSize(display.width, display.height)
	self:showAtCenter()

	self._dungeonData = arg_2_1.dungeon
	self._stageId = arg_2_1.stageId
	self._curTimes = 0
	self._perPos = nil

	self:_initRewardShow()
	self.m_closeBtn:addClickListener(handler(self, self._onClose))
end

function DomainTurnGamePop:_initRewardShow()
	local var_3_0 = self._dungeonData:getStage(self._stageId):getTurnTableReward()

	self._awardList = var_3_0

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		if self["m_awardIcon" .. iter_3_0] then
			self["m_awardIcon" .. iter_3_0]:updateRewardItem(self._dungeonData:getId(), iter_3_1)
		end
	end

	self.m_rotateEffect = self.m_eff:addEffectSpine({
		anim = "loop",
		isLoop = true,
		name = "eff_ui_domainDungeon_rotatecube_" .. self._dungeonData:getId()
	})

	self.m_rotateEffect:setTimeScale(0.5)
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_SmallGame_ShuJu)
	self.m_bg1:setURL(var_0_0:getDungeonResource(self._dungeonData:getId(), "pic_mnly_zhuanpan01.png"))
	self.m_bg2:setURL(var_0_0:getDungeonResource(self._dungeonData:getId(), "pic_mnly_zhuanpan02.png"))
end

function DomainTurnGamePop:onLoad()
	self.m_bgEff:addEffectSpine({
		anim = "loop_1",
		isLoop = true,
		name = "eff_ui_domainDungeon_gamebg_" .. self._dungeonData:getId()
	})
	self.m_enterTransition:play(handler(self, self.playEndAnim))
end

function DomainTurnGamePop:playEndAnim()
	self._finalAwards = var_0_0:getSurprise().awards

	local var_5_0 = 0
	local var_5_1 = g.core.common.Goods:convertAwards(self._finalAwards)

	for iter_5_0, iter_5_1 in ipairs(self._awardList) do
		for iter_5_2, iter_5_3 in ipairs(var_5_1) do
			if iter_5_1.type == iter_5_3.type and iter_5_1.value == iter_5_3.value and iter_5_1.size == iter_5_3.size then
				var_5_0 = iter_5_0

				break
			end
		end

		if var_5_0 > 0 then
			break
		end
	end

	self._rewardPos = var_5_0 > 0 and var_5_0 or 1
	self._curTimes = 0
	self._rewardPos = self._rewardPos - var_0_1.PER_NUM

	if self._rewardPos <= 0 then
		self._rewardPos = self._rewardPos + var_0_1.ALL_NUM
	end

	self:startRun()
end

function DomainTurnGamePop:getNextNumber(arg_6_1, arg_6_2)
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

function DomainTurnGamePop:_playRotateEffect()
	if self._rotateSchedule or not self.m_rotateEffect then
		return
	end

	self._timeScale = 3

	self.m_rotateEffect:setTimeScale(self._timeScale)

	self._rotateSchedule = g.core.common.Scheduler:newSchedule(handler(self, self.addRotateSpeed), 1)
end

function DomainTurnGamePop:addRotateSpeed()
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

function DomainTurnGamePop:finalRunLight()
	self._curTimes = self._curTimes + 1

	if not self._perPos then
		self["m_awardIcon" .. self._rewardPos]:lightStateChange(true)

		self._perPos = {
			self._rewardPos
		}
	else
		self["m_awardIcon" .. self._perPos[1]]:lightStateChange(false)
		self["m_awardIcon" .. self._rewardPos]:lightStateChange(true)

		self._perPos = {
			self._rewardPos
		}
	end

	self._rewardPos = self:getNextNumber(self._rewardPos, true)

	if self._curTimes <= var_0_1.PER_NUM then
		self:newScheduleOnce(handler(self, self.finalRunLight), var_0_1.BASE_TIME * math.pow(1.5, self._curTimes - 1))
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_SmallGame_Chouka)
	else
		self["m_awardIcon" .. self._perPos[1]]:playFinish(self._dungeonData:getId())
		self:newScheduleOnce(handler(self, self.showReward), var_0_1.SHOW_AWARD_DELAY)
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_SmallGame_Jiesuan)
	end
end

function DomainTurnGamePop:_onClose()
	var_0_0:resetSurprise()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function DomainTurnGamePop:startRun()
	self:_playRotateEffect()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_SmallGame_ChoukaVideo)
end

function DomainTurnGamePop:onRunEffFinish()
	self:finalRunLight()
end

function DomainTurnGamePop:showReward()
	if self._finalAwards then
		var_0_0:awardSummary({
			isAuto = false,
			award = self._finalAwards,
			dungeonId = self._dungeonData:getId(),
			callBack = handler(self, self._onClose)
		})

		self._finalAwards = nil
	end
end

function DomainTurnGamePop:onUnload()
	self:showReward()

	if self._rotateSchedule then
		g.core.common.Scheduler:cancelSchedule(self._rotateSchedule)

		self._rotateSchedule = nil
	end
end

return DomainTurnGamePop

local var_0_0 = g.core.const.ConstMgr.WeeklyCompetitionConst
local WeeklyCompetitionTaskProgressComp = class("WeeklyCompetitionTaskProgressComp", (require("app.fairyGUI.weeklyCompetition.UI_WeeklyCompetitionTaskProgressComp")))

function WeeklyCompetitionTaskProgressComp:ctor()
	self._rewardInfoList = nil
	self._score = 0
	self._tempScore = 0
	self._groupScoreList = {}

	self.m_progressBar:setMax(var_0_0.SCORE_PROGRESS_MAX)
	self.m_checkBtn:addClickListener(handler(self, self._onCheckBtnClick))
end

function WeeklyCompetitionTaskProgressComp:initViewComp(arg_2_1)
	self:getChild("n1"):setText(g.core.lang:get(420107, {
		name = arg_2_1:getScoreIconName()
	}))
	self.m_icon:setURL(arg_2_1:getScoreIconUrl())
end

function WeeklyCompetitionTaskProgressComp:updateProgressComp(arg_3_1, arg_3_2, arg_3_3)
	self._rewardInfoList = arg_3_1
	self._score = arg_3_3:getResourceNum()
	self._tempScore = arg_3_2

	self.m_progressValue:setText(self._score, false, true)
	self:_updateBoxComp(arg_3_2)
	self:_updateProValue()
end

function WeeklyCompetitionTaskProgressComp:_updateBoxComp(arg_4_1)
	self._groupScoreList = {}

	local var_4_0

	for iter_4_0, iter_4_1 in ipairs(self._rewardInfoList) do
		self["m_boxComp" .. iter_4_0]:updateBox(iter_4_1, (arg_4_1 and self._tempScore < iter_4_1.cfg.score or nil) and var_0_0.REWARD_STATE.NONE)

		self._groupScoreList[#self._groupScoreList + 1] = iter_4_1.scoreInfo
		var_4_0 = iter_4_1
	end

	self.m_nodeText:setText(var_4_0.cfg.node_name)
	self.m_bubbleComp:updateBubble(var_4_0.awards)
end

function WeeklyCompetitionTaskProgressComp:_calcProValue(arg_5_1)
	local var_5_0 = 0

	for iter_5_0, iter_5_1 in ipairs(self._groupScoreList) do
		var_5_0 = var_5_0 + (arg_5_1 >= iter_5_1.score and var_0_0.SCORE_PROGRESS_MAX / #self._groupScoreList or math.max(arg_5_1 - iter_5_1.startScore, 0) / (iter_5_1.score - iter_5_1.startScore) * (var_0_0.SCORE_PROGRESS_MAX / #self._groupScoreList))
	end

	return var_5_0
end

function WeeklyCompetitionTaskProgressComp:_updateProValue()
	self.m_progressBar:setValue((self:_calcProValue(self._tempScore or self._score)))
end

function WeeklyCompetitionTaskProgressComp:_onCheckBtnClick()
	self:dispatchCompEvent("onRewardPreviewShow")
end

function WeeklyCompetitionTaskProgressComp:playLevelUpEffect()
	if self._animInfo.spineIdx > 0 then
		self["m_iconIdle" .. self._animInfo.spineIdx]:removeAllEffect()
		self["m_iconEnter" .. self._animInfo.spineIdx]:removeAllEffect()
	end

	if self._info.state == 0 then
		self._animInfo.spineIdx = 0

		return
	end

	self._animInfo.spineIdx = math.random(1, 3)

	self.m_levelUpEffect:addEffectSpine({
		anim = "play",
		name = "eff_ui_lottery_enter",
		isLoop = false,
		remove = true,
		eventHandler = handler(self, self._onEnterSpineEvent)
	})
end

function WeeklyCompetitionTaskProgressComp:_playScoreProBarEffect(arg_9_1, arg_9_2)
	self.m_progressBar:setValue((self:_calcProValue(arg_9_1)))
	self.m_progressBar:tweenValue(self:_calcProValue(arg_9_2), 0.4)
end

function WeeklyCompetitionTaskProgressComp:playProUpEffect(arg_10_1, arg_10_2)
	self.m_levelUpEffect:addEffectSpine({
		anim = "play",
		name = "eff_ui_weeklyCompetition_levelUp",
		remove = true,
		isLoop = false
	})

	local var_10_0 = self.m_progressBar:getSize()

	var_10_0.width = var_10_0.width * (self:_calcProValue(arg_10_2) / var_0_0.SCORE_PROGRESS_MAX)

	self.m_expEffectComp:setSize(var_10_0)
	self:_playScoreProBarEffect(arg_10_1, arg_10_2)

	local var_10_1 = {}

	for iter_10_0, iter_10_1 in ipairs(self._rewardInfoList) do
		if arg_10_1 <= iter_10_1.scoreInfo.score and arg_10_2 >= iter_10_1.scoreInfo.score then
			var_10_1[iter_10_1.id] = true
		end
	end

	self.m_expEffectComp:getChild("effectNode"):addEffectSpine({
		anim = "play",
		name = "eff_ui_weeklyCompetition_level",
		isLoop = false,
		remove = true,
		eventHandler = handler(self, function(arg_11_0, arg_11_1, arg_11_2)
			if require("app.view.battle.const.BattleConst").SPINE_EVENT.COMPLETE == arg_11_1.type then
				arg_11_0:_onProUpEffectPlayEnd(var_10_1)
			end
		end)
	})
end

function WeeklyCompetitionTaskProgressComp:_onProUpEffectPlayEnd(arg_12_1)
	if next(arg_12_1) then
		self:playBoxRenew(arg_12_1, true)
	else
		self:dispatchCompEvent("onProUpEffectEnd")
	end
end

function WeeklyCompetitionTaskProgressComp:playBoxRenew(arg_13_1, arg_13_2)
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in ipairs(self._rewardInfoList) do
		if arg_13_1[iter_13_1.id] then
			var_13_0[#var_13_0 + 1] = self["m_boxComp" .. iter_13_0]
		end
	end

	local var_13_1 = #self._rewardInfoList == #var_13_0

	for iter_13_2, iter_13_3 in ipairs(var_13_0) do
		iter_13_3:playRenewEffect(arg_13_2, var_13_1)
	end

	self.m_timeLineRenewEffect:addEffectSpine({
		anim = "renew",
		name = "eff_ui_weeklyCompetition_timeLine",
		remove = true,
		isLoop = false
	})
end

function WeeklyCompetitionTaskProgressComp:playOpenBox(arg_14_1, arg_14_2)
	for iter_14_0, iter_14_1 in ipairs(self._rewardInfoList) do
		if iter_14_1.id == arg_14_1 then
			self["m_boxComp" .. iter_14_0]:playOpenEffect(arg_14_2)

			break
		end
	end
end

function WeeklyCompetitionTaskProgressComp:clearAllEffect()
	for iter_15_0 = 1, 3 do
		self["m_boxComp" .. iter_15_0]:clearAllEffect()
	end

	self.m_timeLineRenewEffect:removeAllEffect()
	self.m_levelUpEffect:removeAllEffect()
	self.m_expEffectComp:getChild("effectNode"):removeAllEffect()
end

return WeeklyCompetitionTaskProgressComp

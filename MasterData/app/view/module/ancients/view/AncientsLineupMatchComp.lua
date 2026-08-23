local AncientsLineupMatchComp = class("AncientsLineupMatchComp", require("app.fairyGUI.ancients.UI_AncientsLineupMatchComp"))

function var_0_1.ctor(arg_1_0)
	arg_1_0._enterTime = 0
	arg_1_0._scheduleExit = nil
	arg_1_0._matchTime = 0
	arg_1_0._matchDuration = 0
	arg_1_0._scheduleMatch = nil
end

function var_0_1:updateView()
	self.m_Comp_pet_equip:updateIcon((g.core.common.Goods:convert({
		type = g.core.common.Goods.TYPE_PET,
		value = g.core.config.ancients_pet_info.get(g.core.model.User.ancientsData:getTeamPetId()).advance_id
	})))
	self.m_Txt_pet_level:setText(g.core.model.User.ancientsData:getTeamPetLevel())
	self.m_Txt_score:setText(g.core.model.User.ancientsData:getTeamScore())
	self.m_Btn_match:updateView({
		onClick = handler(self, self._onClickBtnMatch)
	})

	if self._enterTime == 0 then
		local var_2_0 = g.core.model.User.ancientsData:getLineupMatchCd()

		self._enterTime = g.core.common.ServerTime:getTime()

		self:cancelScheduleExit()

		self._scheduleExit = self:newSchedule(handler(self, self._updateExitCd), 1)

		self:_updateExitCd()
	end
end

function var_0_1:_onClickBtnMatch()
	if self._scheduleMatch ~= nil then
		return
	end

	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_JuXiang_Match)

	if g.core.model.User.ancientsData:getLeftFightTimes() <= 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(433307))

		return
	end

	self._matchTime = g.core.common.ServerTime:getTime()

	self:cancelScheduleExit()
	self:cancelScheduleMatch()
	self.m_is_matchingController:setSelectedIndex(1)

	self._matchDuration = math.random(g.core.const.ConstMgr.AncientsConst.FAKE_MATCH_DURATION[1], g.core.const.ConstMgr.AncientsConst.FAKE_MATCH_DURATION[2])
	self._scheduleMatch = self:newSchedule(handler(self, self._updateMatchCd), 1)

	self:_updateMatchCd()
end

function var_0_1:_updateExitCd()
	local var_4_0 = math.max(0, g.core.model.User.ancientsData:getLineupMatchCd() - (g.core.common.ServerTime:getTime() - self._enterTime))

	self.m_Txt_cd:setText(g.core.lang:get(433303, {
		time = var_4_0
	}))
	self.m_Txt_cd2:setText(g.core.lang:get(433303, {
		time = var_4_0
	}))

	if var_4_0 <= 0 then
		self:cancelScheduleExit()
		self:dispatchCompEvent("ANCIENTS_LINEUP_MATCH_EXIT")
	end
end

function var_0_1:_updateMatchCd()
	local var_5_0 = g.core.common.ServerTime:getTime() - self._matchTime

	self.m_Btn_match:updateMatchCd(var_5_0)

	if var_5_0 >= self._matchDuration then
		self:cancelScheduleExit()
		self:cancelScheduleMatch()
		self:dispatchCompEvent("ANCIENTS_LINEUP_CLICK_MATCH")
	end
end

function var_0_1:cancelScheduleExit()
	if self._scheduleExit ~= nil then
		self:cancelSchedule(self._scheduleExit)

		self._scheduleExit = nil
	end
end

function var_0_1:cancelScheduleMatch()
	if self._scheduleMatch ~= nil then
		self:cancelSchedule(self._scheduleMatch)

		self._scheduleMatch = nil
	end
end

return var_0_1

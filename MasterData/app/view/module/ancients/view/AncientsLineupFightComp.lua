local AncientsLineupFightComp = class("AncientsLineupFightComp", require("app.fairyGUI.ancients.UI_AncientsLineupFightComp"))
local var_0_2 = g.core.const.ConstMgr.AncientsConst
local var_0_3 = {
	433412,
	433328,
	433329,
	433330
}

function var_0_0:ctor()
	self._enemyTeamUsers = {}
	self._enterTime = 0
	self._scheduleFight = nil
	self._scheduleRound = nil

	self.m_stateController:setSelectedIndex(g.core.model.User.ancientsData:isFinalState() and 1 or 0)
end

function var_0_0:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, handler(self, self._onGetCommonSimpleUserSnapshot), self)
end

function var_0_0:updateView()
	local var_3_0 = g.core.model.User.ancientsData

	if not g.core.model.User.ancientsData:getTeam(var_0_2.GET_TEAM_TYPE.ENEMY_TEAM) then
		self.m_is_emptyController:setSelectedIndex(1)
	else
		self.m_is_emptyController:setSelectedIndex(0)
		self.m_Comp_pet_equip:updateIcon((g.core.common.Goods:convert({
			type = g.core.common.Goods.TYPE_PET,
			value = g.core.config.ancients_pet_info.get(var_3_0:getTeamPetId(var_0_2.GET_TEAM_TYPE.ENEMY_TEAM)).advance_id
		})))
		self.m_Txt_pet_level:setText(var_3_0:getTeamPetLevel(var_0_2.GET_TEAM_TYPE.ENEMY_TEAM))
		self.m_Txt_score:setText(var_3_0:getTeamScore(var_0_2.GET_TEAM_TYPE.ENEMY_TEAM))
	end

	if g.core.utils.Tools.ancientsFunc.sendSimpleUserSnapshot((var_3_0:getTeamUserIds(var_0_2.GET_TEAM_TYPE.ENEMY_TEAM))) then
		self:_updateUsersInfo()
	end

	self:cancelScheduleRound()

	if var_3_0:isFinalState() then
		self.m_stateController:setSelectedIndex(1)
		self:cancelScheduleFight()

		self._scheduleRound = self:newSchedule(handler(self, self._updateRoundCd), 1)

		self:_updateRoundCd()
	end
end

function var_0_0._updateUsersInfo(arg_4_0)
	local var_4_0 = g.core.model.User.ancientsData:getTeam(var_0_2.GET_TEAM_TYPE.ENEMY_TEAM)

	if var_4_0 then
		local var_4_1 = g.core.utils.Tools.ancientsFunc.getSnapshot(var_4_0.captain)
	end

	arg_4_0._enemyTeamUsers = g.core.model.User.ancientsData:getTeamUsers(var_0_2.GET_TEAM_TYPE.ENEMY_TEAM)
end

function var_0_0:_onClickBtnFight()
	self:dispatchCompEvent("ANCIENTS_LINEUP_CLICK_FIGHT")
end

function var_0_0:_onGetCommonSimpleUserSnapshot(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	self:_updateUsersInfo()
end

function var_0_0:_updateFightCd()
	local var_7_0 = math.max(0, g.core.model.User.ancientsData:getLineupFightCd() - (g.core.common.ServerTime:getTime() - self._enterTime))

	self.m_Txt_cd:setText(g.core.lang:get(433304, {
		time = var_7_0
	}))
	self.m_Txt_cd2:setText(g.core.lang:get(433304, {
		time = var_7_0
	}))

	if var_7_0 <= 0 then
		self:dispatchCompEvent("ANCIENTS_LINEUP_CLICK_FIGHT")
	end
end

function var_0_0:cancelScheduleFight()
	if self._scheduleFight ~= nil then
		self:cancelSchedule(self._scheduleFight)

		self._scheduleFight = nil
	end
end

function var_0_0:_updateRoundCd()
	local var_9_0, var_9_1 = g.core.model.User.ancientsData:getFinalNextRoundTypeAndCd()

	if var_9_0 == var_0_2.ROUND_TYPE.NONE then
		self.m_Txt_round_name:setText("")
		self.m_Txt_round_cd:setText("")
	else
		self.m_Txt_round_name:setText(g.core.lang:get(var_0_3[var_9_0]))
		self.m_Txt_round_cd:setText(g.core.lang:get(433331, {
			time = g.core.common.ServerTime:secondToHMSString(var_9_1)
		}))
	end
end

function var_0_0:cancelScheduleRound()
	if self._scheduleRound ~= nil then
		self:cancelSchedule(self._scheduleRound)

		self._scheduleRound = nil
	end
end

return var_0_0

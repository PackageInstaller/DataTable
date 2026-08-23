local var_0_0 = g.core.config.ancients_active_info
local var_0_3 = g.core.config.ancients_parameter_info
local var_0_4 = g.core.config.ancients_pet_info
local var_0_5 = g.core.config.ancients_pet_level_info
local var_0_7 = g.core.config.ancients_task_info
local AncientsData = class("AncientsData", require("app.core.model.BaseData"))
local BaseData = require("app.core.model.BaseData")
local var_0_11 = g.core.const.ConstMgr.AncientsConst

function AncientsData:ctor()
	BaseData.ctor(self)

	self._info = nil
	self._activityId = 0
	self._firstOpenTime = 0
	self._coopEndTime = 0
	self._scoreEndTime = 0
	self._finalCoopEndTime = 0
	self._finalEndTime = 0
	self._endTime = 0
	self._finalStageTimeList = {
		0,
		0,
		0,
		0
	}
	self._team = nil
	self._finalTeam = nil
	self._enemyTeam = nil
	self._applyTeams = {}
	self._simpleUserMap = {}
	self._selfScore = 0
	self._joinTeamCd = 0
	self._awardExp = 0
	self._oldAwardExp = 0
	self._taskSerData = {}
	self._activeCount = 0
	self._selfDiceNum = 0
	self._echoQualityMap = {}
	self._activeAwardedIds = {}
	self._roundTeamsMap = {}
	self._finalTeamMap = {}
	self._guessMap = {}
	self._dailyDiceRewardData = nil
	self._invitationList = {}
	self._chainTurnId = 0
	self._chainFree = false
end

function AncientsData:getAncientsInfo()
	return self._info
end

function AncientsData:getTeamId()
	if not self._team then
		return 0
	end

	return self._team.team_id or 0
end

function AncientsData:getTeam(arg_4_1, arg_4_2)
	arg_4_1 = arg_4_1 or var_0_11.GET_TEAM_TYPE.TEAM

	if arg_4_1 == var_0_11.GET_TEAM_TYPE.TEAM then
		return self._team
	elseif arg_4_1 == var_0_11.GET_TEAM_TYPE.FINAL_TEAM then
		return self._finalTeam
	elseif arg_4_1 == var_0_11.GET_TEAM_TYPE.CURRENT_TEAM then
		if self:getAncientsState() <= g.core.const.ConstMgr.AncientsConst.ANCIENT_STATUS.FIGHT then
			return self._team
		else
			return self._finalTeam
		end
	elseif arg_4_1 == var_0_11.GET_TEAM_TYPE.ENEMY_TEAM then
		return self._enemyTeam
	elseif arg_4_1 == var_0_11.GET_TEAM_TYPE.CUSTOM_TEAM then
		return arg_4_2
	end

	return nil
end

function AncientsData:getTeamLeaderName(arg_5_1)
	local var_5_0 = self:getTeam(arg_5_1)

	if not var_5_0 then
		return ""
	end

	return var_5_0.name or ""
end

function AncientsData:getTeamScore(arg_6_1)
	local var_6_0 = self:getTeam(arg_6_1)

	if not var_6_0 then
		return 0
	end

	return var_6_0.score or 0
end

function AncientsData:getTeamJoinCdTime(arg_7_1, arg_7_2)
	local var_7_0 = self:getTeam(arg_7_1, arg_7_2)

	if not var_7_0 then
		return 0
	end

	return var_7_0.join_user_cd_time or 0
end

function AncientsData:getSelfScore()
	return self._selfScore
end

function AncientsData:getSelfDiceNum()
	return self._selfDiceNum
end

function AncientsData:getEchoQualityByIndex(arg_10_1)
	return self._echoQualityMap[arg_10_1]
end

function AncientsData:setEchoQualityByIndex(arg_11_1, arg_11_2)
	self._echoQualityMap[arg_11_1] = arg_11_2
end

function AncientsData:setSelfDiceNum(arg_12_1)
	self._selfDiceNum = arg_12_1 or 0
end

function AncientsData:getTeamPetId(arg_13_1, arg_13_2)
	local var_13_0 = self:getTeam(arg_13_1, arg_13_2)

	if not var_13_0 or not var_13_0.pet then
		return 0
	end

	return var_13_0.pet.base_id or 0
end

function AncientsData:getTeamPetLevel(arg_14_1, arg_14_2)
	local var_14_0 = self:getTeam(arg_14_1, arg_14_2)

	if not var_14_0 or not var_14_0.pet then
		return 0
	end

	return var_14_0.pet.level or 0
end

function AncientsData:getTeamPetFightValue(arg_15_1, arg_15_2)
	local var_15_0 = self:getTeam(arg_15_1, arg_15_2)

	if not var_15_0 then
		return 0
	end

	return var_15_0.pet_fight_value or 0
end

function AncientsData:getTeamUsers(arg_16_1, arg_16_2)
	local var_16_0 = self:getTeam(arg_16_1, arg_16_2)

	if not var_16_0 or not var_16_0.users then
		return {}
	end

	return var_16_0.users
end

function AncientsData:getTeamUserByUserId(arg_17_1, arg_17_2, arg_17_3)
	for iter_17_0, iter_17_1 in ipairs((self:getTeamUsers(arg_17_2, arg_17_3))) do
		if iter_17_1.user_id == arg_17_1 then
			return iter_17_1
		end
	end
end

function AncientsData:getTeamUserByPos(arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = self:getTeam(arg_18_2, arg_18_3)

	if not var_18_0 or not var_18_0.users then
		return nil
	end

	for iter_18_0, iter_18_1 in ipairs(var_18_0.users) do
		if iter_18_1.pos == arg_18_1 then
			return iter_18_1
		end
	end

	return nil
end

function AncientsData:getTeamUserIds(arg_19_1, arg_19_2)
	local var_19_0 = self:getTeam(arg_19_1, arg_19_2)

	if not var_19_0 or not var_19_0.users then
		return {}
	end

	local var_19_1 = {}

	for iter_19_0, iter_19_1 in ipairs(var_19_0.users) do
		table.insert(var_19_1, iter_19_1.user_id)
	end

	return var_19_1
end

function AncientsData:isTeamUserLeader(arg_20_1, arg_20_2, arg_20_3)
	local var_20_0 = self:getTeam(arg_20_2, arg_20_3)

	if not var_20_0 then
		return false
	end

	return var_20_0.captain == arg_20_1
end

function AncientsData:isUserInTeam(arg_21_1, arg_21_2, arg_21_3)
	local var_21_0 = self:getTeam(arg_21_2, arg_21_3)

	if not var_21_0 or not var_21_0.users then
		return false
	end

	for iter_21_0, iter_21_1 in ipairs(var_21_0.users) do
		if iter_21_1.user_id == arg_21_1 then
			return true
		end
	end

	return false
end

function AncientsData:isUserBanFight(arg_22_1, arg_22_2, arg_22_3)
	local var_22_0 = self:getTeam(arg_22_2, arg_22_3)

	if not var_22_0 or not var_22_0.users then
		return false
	end

	for iter_22_0, iter_22_1 in ipairs(var_22_0.users) do
		if iter_22_1.user_id == arg_22_1 then
			return iter_22_1.ban_fight
		end
	end

	return false
end

function AncientsData:getTeamOperateState(arg_23_1)
	local var_23_0 = self:getTeam(arg_23_1)

	if not var_23_0 or not var_23_0.operate then
		return var_0_11.ANCIENT_OPERATE_STATUS.NONE
	end

	return var_23_0.operate.status
end

function AncientsData:getSimpleUser(arg_24_1)
	return self._simpleUserMap[arg_24_1]
end

function AncientsData:getUserFormationPos(arg_25_1, arg_25_2, arg_25_3)
	local var_25_0 = self:getTeam(arg_25_2, arg_25_3)

	if not var_25_0 or not var_25_0.formation_positions then
		return 0
	end

	for iter_25_0, iter_25_1 in ipairs(var_25_0.formation_positions) do
		if iter_25_1.uid == arg_25_1 then
			return iter_25_1.pos
		end
	end

	return 0
end

function AncientsData:getLineupMatchCd()
	return var_0_3.get(14).parameter - 10
end

function AncientsData:getLineupFightCd()
	return var_0_3.get(15).parameter - 10
end

function AncientsData:getParamById(arg_28_1)
	return var_0_3.get(arg_28_1).parameter
end

function AncientsData:getLeftFightTimes()
	if not self._team then
		return 0
	end

	return self._team.rest_fight_times or 0
end

function AncientsData:getCanBuyFightTimes()
	if not self._team then
		return 0
	end

	return self._team.buy_fight_left_count or 0
end

function AncientsData:hasNewTeamApply()
	local var_31_0 = self:getTeam(var_0_11.GET_TEAM_TYPE.CURRENT_TEAM)

	if not var_31_0 then
		return false
	end

	if var_31_0.users and #var_31_0.users >= var_0_11.TEAM_USER_MAX_NUM then
		return false
	end

	if not self:isTeamUserLeader(g.core.model.User:getId(), var_0_11.GET_TEAM_TYPE.CURRENT_TEAM) then
		return false
	end

	return var_31_0.has_apply
end

function AncientsData:hasNewMessage(arg_32_1)
	local var_32_0 = self:getTeam(arg_32_1)

	if not var_32_0 then
		return false
	end

	return ((g.core.common.Storage:load("ancients_message_cache.json") or {}).msg_id or 0) < (var_32_0.max_message_id or 0)
end

function AncientsData:setMaxMessageId(arg_33_1)
	local var_33_0 = g.core.common.Storage:load("ancients_message_cache.json") or {}

	if (var_33_0.msg_id or 0) < arg_33_1 then
		var_33_0.msg_id = arg_33_1

		g.core.common.Storage:save("ancients_message_cache.json", var_33_0)
	end
end

function AncientsData:getBattleWinScore()
	return var_0_3.get(8).parameter
end

function AncientsData:getBattleLoseScore()
	return var_0_3.get(49).parameter
end

function AncientsData:getPetEquipmentIconTypeAndPathByPetId(arg_36_1)
	local var_36_0 = g.core.config.ancients_pet_info.fetch(arg_36_1)

	if var_36_0 == nil then
		return 1, ""
	end

	local var_36_1 = g.core.config.pet_equipment_info.fetch(var_36_0.up_equipment)

	if var_36_1 == nil then
		return 1, ""
	end

	return var_36_1.type, g.core.common.Path:getPetEquipmentIconById(var_36_1.res_id)
end

function AncientsData:getPetEquipmentNameByPetId(arg_37_1)
	local var_37_0 = g.core.config.ancients_pet_info.fetch(arg_37_1)

	if var_37_0 == nil then
		return ""
	end

	local var_37_1 = g.core.config.pet_equipment_info.fetch(var_37_0.up_equipment)

	if var_37_1 == nil then
		return ""
	end

	return var_37_1.name
end

function AncientsData:isApplyedByTeamId(arg_38_1)
	for iter_38_0, iter_38_1 in ipairs(self._applyTeams) do
		if iter_38_1.team_id == arg_38_1 then
			return true
		end
	end

	return false
end

function AncientsData:setApplyTeams(arg_39_1)
	self._applyTeams = arg_39_1.teams or {}
end

function AncientsData:getBoxGoodsArray(arg_40_1)
	local var_40_0 = {}

	for iter_40_0 = 1, g.core.config.ancients_award_box_info.getLength() do
		local var_40_1 = g.core.config.ancients_award_box_info.indexOf(iter_40_0)

		if var_40_1.box == arg_40_1 then
			table.insert(var_40_0, var_40_1)
		end
	end

	table.sort(var_40_0, function(arg_41_0, arg_41_1)
		return arg_41_0.sort < arg_41_1.sort
	end)

	return var_40_0
end

function AncientsData:getAncientsState()
	if not self:isTimeToOpen() then
		return g.core.const.ConstMgr.AncientsConst.ANCIENT_STATUS.NONE
	end

	if g.core.common.ServerTime:getLeftSeconds(self._coopEndTime) > 0 then
		return g.core.const.ConstMgr.AncientsConst.ANCIENT_STATUS.COOP
	elseif g.core.common.ServerTime:getLeftSeconds(self._scoreEndTime) > 0 then
		return g.core.const.ConstMgr.AncientsConst.ANCIENT_STATUS.FIGHT
	elseif g.core.common.ServerTime:getLeftSeconds(self._finalCoopEndTime) > 0 then
		return g.core.const.ConstMgr.AncientsConst.ANCIENT_STATUS.FINAL_COOP
	elseif g.core.common.ServerTime:getLeftSeconds(self._finalEndTime) > 0 then
		return g.core.const.ConstMgr.AncientsConst.ANCIENT_STATUS.FINAL
	end

	return g.core.const.ConstMgr.AncientsConst.ANCIENT_STATUS.REVIEW
end

function AncientsData:isFinalState()
	return self:getAncientsState() >= var_0_11.ANCIENT_STATUS.FINAL_COOP
end

function AncientsData:getFinalNextRoundTypeAndCd()
	local var_44_0 = g.core.model.User.ancientsData:getFinalStageTimeList()
	local var_44_1 = g.core.common.ServerTime:getTime()
	local var_44_2 = var_0_11.ROUND_TYPE.NONE
	local var_44_3 = 0

	if var_44_1 < var_44_0[1] then
		var_44_2 = var_0_11.ROUND_TYPE.ROUND_TYPE1
		var_44_3 = var_44_0[1] - var_44_1
	elseif var_44_1 < var_44_0[2] then
		var_44_2 = var_0_11.ROUND_TYPE.ROUND_TYPE2
		var_44_3 = var_44_0[2] - var_44_1
	elseif var_44_1 < var_44_0[3] then
		var_44_2 = var_0_11.ROUND_TYPE.ROUND_TYPE3
		var_44_3 = var_44_0[3] - var_44_1
	else
		var_44_2 = var_0_11.ROUND_TYPE.ROUND_TYPE4
		var_44_3 = var_44_0[4] - var_44_1
	end

	return var_44_2, var_44_3
end

function AncientsData:isForbiddenJoinTeam()
	return g.core.common.ServerTime:getTime() <= self._joinTeamCd
end

function AncientsData:teamForbiddenJoin(arg_46_1)
	return arg_46_1 >= g.core.common.ServerTime:getTime()
end

function AncientsData:getForbiddenJoinTeamCDStr()
	return g.core.common.ServerTime:getShowTimeBySecond(self._joinTeamCd - g.core.common.ServerTime:getTime())
end

function AncientsData:getCDStr(arg_48_1)
	return g.core.common.ServerTime:getShowTimeBySecond(arg_48_1 - g.core.common.ServerTime:getTime())
end

function AncientsData:getAwardExp()
	return self._awardExp or 0
end

function AncientsData:getOldAwardExp()
	return self._oldAwardExp or 0
end

function AncientsData:setOldAwardExp()
	self._oldAwardExp = self._awardExp
end

function AncientsData:getAwardProg(arg_52_1)
	local var_52_0 = {
		max = 0,
		now = 0,
		isMax = false
	}
	local var_52_1 = g.core.model.User.ancientsData:getTeamPetId()

	if not var_52_1 or var_52_1 == 0 then
		return var_52_0
	end

	local var_52_2 = g.core.config.ancients_pet_info.fetch(var_52_1).award_group
	local var_52_3 = {}

	for iter_52_0 = 1, g.core.config.ancients_award_info.getLength() do
		local var_52_4 = g.core.config.ancients_award_info.indexOf(iter_52_0)

		if var_52_4.award_group == var_52_2 then
			table.insert(var_52_3, var_52_4)
		end
	end

	table.sort(var_52_3, function(arg_53_0, arg_53_1)
		return arg_53_0.exp < arg_53_1.exp
	end)

	local var_52_5 = var_52_3[1]
	local var_52_6

	for iter_52_1 = #var_52_3, 1, -1 do
		if arg_52_1 >= var_52_3[iter_52_1].exp then
			var_52_5 = var_52_3[iter_52_1]
			var_52_6 = var_52_3[iter_52_1 + 1]

			break
		end
	end

	var_52_0.cfg = var_52_5
	var_52_0.nexCfg = var_52_6

	if not var_52_6 then
		var_52_0.isMax = true
	else
		var_52_0.now = arg_52_1 - var_52_5.exp
		var_52_0.max = var_52_6.exp - var_52_5.exp
	end

	return var_52_0
end

function AncientsData:isShowEntrance()
	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.ANCIENTS) then
		return false
	end

	return self:isTimeToOpen()
end

function AncientsData:isTimeToOpen()
	if g.core.common.ServerTime:getTime() >= self._firstOpenTime and g.core.common.ServerTime:getTime() < self._endTime then
		return true
	end

	return false
end

function AncientsData:isActivityOpen(arg_56_1)
	if self._activityId ~= arg_56_1 then
		return false
	end

	return self:isTimeToOpen()
end

function AncientsData:getActivityShowTime()
	return self._endTime
end

function AncientsData:isShowDiceReward()
	local var_58_1 = (g.core.common.Storage:load("ancients_daily_dice_reward_cache.json") or {}).time or 0
	local var_58_2 = self:getDailyDiceReward()

	return not g.core.common.ServerTime:isToday(var_58_1) and var_58_2 and #var_58_2 > 0 and self:getAncientsState() < g.core.const.ConstMgr.AncientsConst.ANCIENT_STATUS.FINAL_COOP
end

function AncientsData:getChainTurnId()
	return self._chainTurnId
end

function AncientsData:hasFreeChain()
	return self._chainFree
end

function AncientsData:onRecvEnter(arg_61_1)
	self._selfScore = arg_61_1.score
	self._team = arg_61_1.team
	self._finalTeam = arg_61_1.my_final_team
	self._awardExp = arg_61_1.loot_exp or 0
	self._taskSerData = {}

	self:updateTaskData(arg_61_1.tasks or {})
	self:updateTaskData(arg_61_1.team_tasks or {})
	self:updateActiveCount(arg_61_1.active_value)
	self:updateActiveAwardedIds(arg_61_1.active_awarded_ids or {}, true)

	self._dailyDiceRewardData = arg_61_1.contributions
	self._scoreStageRank = arg_61_1.score_stage_rank
	self._roundTeamsMap = {}

	for iter_61_0, iter_61_1 in ipairs(arg_61_1.round_teams or {}) do
		self._roundTeamsMap[iter_61_1.round] = iter_61_1.team_ids
	end

	self._finalTeamMap = {}

	for iter_61_2, iter_61_3 in ipairs(arg_61_1.final_teams or {}) do
		self._finalTeamMap[iter_61_3.team_id] = iter_61_3
	end

	self._hasFinalInvite = arg_61_1.has_invitation
end

function AncientsData:onRecvInvite(arg_62_1)
	if self._simpleUserMap[arg_62_1.user_id] then
		self._simpleUserMap[arg_62_1.user_id].is_invited = true
	end
end

function AncientsData:onRcvInvitationList(arg_63_1)
	self._invitationList = arg_63_1.teams or {}
end

function AncientsData:onRcvApplyList(arg_64_1)
	self._applyList = arg_64_1.users or {}

	local var_64_0 = self:getTeam(var_0_11.GET_TEAM_TYPE.CURRENT_TEAM)

	if #self._applyList <= 0 then
		if var_64_0 then
			var_64_0.has_apply = false
		end
	elseif var_64_0 then
		var_64_0.has_apply = true
	end
end

function AncientsData:onRcvConfirmApply(arg_65_1)
	for iter_65_0, iter_65_1 in ipairs(self._applyList) do
		if iter_65_1.user_id == arg_65_1.user_id then
			table.remove(self._applyList, iter_65_0)
		end
	end

	local var_65_0 = self:getTeam(var_0_11.GET_TEAM_TYPE.CURRENT_TEAM)

	if #self._applyList <= 0 then
		if var_65_0 then
			var_65_0.has_apply = false
		end
	elseif var_65_0 then
		var_65_0.has_apply = true
	end
end

function AncientsData:onRecvQuitTeam(arg_66_1)
	if self._team and self._team.team_id == arg_66_1.team_id then
		self._team = nil
	elseif self._finalTeam and self._finalTeam.team_id == arg_66_1.team_id then
		self._finalTeam = nil
	end

	self._joinTeamCd = arg_66_1.join_team_cd_time
end

function AncientsData:onRecvNotifyTeamChange(arg_67_1)
	if arg_67_1.team.promote_rank and arg_67_1.team.promote_rank > 0 then
		self._finalTeam = arg_67_1.team
	else
		self._team = arg_67_1.team
	end
end

function AncientsData:onRecvBeKick(arg_68_1)
	if self._team and self._team.team_id == arg_68_1.team_id then
		self._team = nil
	elseif self._finalTeam and self._finalTeam.team_id == arg_68_1.team_id then
		self._finalTeam = nil
	end
end

function AncientsData:onRecvGetUserList(arg_69_1)
	for iter_69_0, iter_69_1 in ipairs(arg_69_1.users) do
		self._simpleUserMap[iter_69_1.user_id] = iter_69_1
	end
end

function AncientsData:onRecvOperateNotify(arg_70_1)
	if not self._team then
		return
	end

	self._team.operate = arg_70_1.operate
end

function AncientsData:onRecvFormationNotify(arg_71_1)
	if not self._team then
		return
	end

	self._team.formation_positions = arg_71_1.formation_positions or {}
end

function AncientsData:onRecvMatch(arg_72_1)
	self._enemyTeam = arg_72_1.opponent_team
end

function AncientsData:onRecvBattleSpectate(arg_73_1)
	self._enemyTeam = arg_73_1.opponent_team
end

function AncientsData:onRecvFightTimesNtf(arg_74_1)
	if not self._team then
		return
	end

	self._team.rest_fight_times = arg_74_1.times or 0
	self._team.buy_fight_left_count = arg_74_1.left_count or 0
end

function AncientsData:onRecvFinalMatch(arg_75_1)
	self._enemyTeam = arg_75_1.opponent_team
end

function AncientsData:onRecvFinalFormationNotify(arg_76_1)
	if not self._finalTeam then
		return
	end

	self._finalTeam.formation_positions = arg_76_1.formation_positions or {}
end

function AncientsData:onRecvNotifyMaxMessageId(arg_77_1)
	local var_77_0 = self:getTeam(var_0_11.GET_TEAM_TYPE.CURRENT_TEAM)

	if not var_77_0 or var_77_0.team_id ~= arg_77_1.team_id then
		return
	end

	var_77_0.max_message_id = arg_77_1.max_message_id or 0
end

function AncientsData:updateCrossRedPoint(arg_78_1)
	self._team = arg_78_1.team
	self._finalTeam = arg_78_1.my_final_team
	self._joinTeamCd = arg_78_1.join_team_cd_time
	self._selfDiceNum = arg_78_1.dice_num or 0
	self._promoteRank = arg_78_1.promote_rank or 0
	self._guessMap = {}

	for iter_78_0, iter_78_1 in ipairs(arg_78_1.guesses or {}) do
		if self._guessMap[iter_78_1.round] then
			table.sort(self._guessMap[iter_78_1.round], function(arg_79_0, arg_79_1)
				return arg_79_0.num < arg_79_1.num
			end)
			table.insert(self._guessMap[iter_78_1.round], iter_78_1)

			self._guessMap[iter_78_1.round] = self._guessMap[iter_78_1.round]
		else
			self._guessMap[iter_78_1.round] = {
				iter_78_1
			}
		end
	end
end

function AncientsData:updateRedPointData(arg_80_1)
	self._activityData = arg_80_1.activity

	if arg_80_1.activity.sub_id and arg_80_1.activity.sub_id ~= 0 then
		self._info = g.core.config.ancients_info.get(arg_80_1.activity.sub_id)
	end

	self._activityId = arg_80_1.activity.sub_id or 0
	self._firstOpenTime = arg_80_1.activity.start_time or 0
	self._coopEndTime = arg_80_1.activity.score_start_time or 0
	self._scoreEndTime = arg_80_1.activity.score_end_time or 0
	self._finalCoopEndTime = arg_80_1.activity.final_start_time or 0
	self._finalEndTime = arg_80_1.activity.final_end_time or 0
	self._endTime = arg_80_1.activity.end_time or 0
	self._finalStageTimeList = arg_80_1.activity.final_round_time_list or {
		0,
		0,
		0,
		0
	}
	self._chainTurnId = 0
	self._chainFree = 0
end

function AncientsData:getActivityData()
	return self._activityData
end

function AncientsData:getFinalStageTimeList()
	return self._finalStageTimeList
end

function AncientsData:initGuessData(arg_83_1)
	self._guessMap = {}

	for iter_83_0, iter_83_1 in ipairs(arg_83_1.guesses or {}) do
		if self._guessMap[iter_83_1.round] then
			table.sort(self._guessMap[iter_83_1.round], function(arg_84_0, arg_84_1)
				return arg_84_0.num < arg_84_1.num
			end)
			table.insert(self._guessMap[iter_83_1.round], iter_83_1)

			self._guessMap[iter_83_1.round] = self._guessMap[iter_83_1.round]
		else
			self._guessMap[iter_83_1.round] = {
				iter_83_1
			}
		end
	end
end

function AncientsData:updateGuessData(arg_85_1)
	if self._guessMap[arg_85_1.round] then
		for iter_85_0, iter_85_1 in ipairs(self._guessMap[arg_85_1.round]) do
			if iter_85_1.num == arg_85_1.num then
				self._guessMap[arg_85_1.round][iter_85_0] = arg_85_1
			end
		end
	else
		self._guessMap[arg_85_1.round] = {
			arg_85_1
		}
	end
end

function AncientsData:addGuessData(arg_86_1)
	for iter_86_0, iter_86_1 in ipairs(arg_86_1.guesses or {}) do
		self._guessMap[iter_86_1.round] = self._guessMap[iter_86_1.round] and table.insert(self._guessMap[iter_86_1.round], iter_86_1) or {
			iter_86_1
		}
	end
end

function AncientsData:InitRoundTeamsData(arg_87_1)
	self._roundTeamsMap = {}

	for iter_87_0, iter_87_1 in ipairs(arg_87_1.round_teams or {}) do
		self._roundTeamsMap[iter_87_1.round] = iter_87_1.team_ids
	end
end

function AncientsData:updatePetData(arg_88_1)
	if not self._team then
		return
	end

	if not arg_88_1 then
		return
	end

	self._team.pet = arg_88_1
end

function AncientsData:getPetData(arg_89_1)
	local var_89_0 = self:getTeam(arg_89_1)

	if var_89_0 then
		return var_89_0.pet
	end
end

function AncientsData:getPetBaseId(arg_90_1)
	local var_90_0 = self:getPetData(arg_90_1)

	if var_90_0 then
		return var_90_0.base_id
	end

	return 0
end

function AncientsData:getPetLevel(arg_91_1)
	local var_91_0 = self:getPetData(arg_91_1)

	if var_91_0 then
		return var_91_0.level
	end

	return 1
end

function AncientsData:getPetChangeTimes(arg_92_1)
	local var_92_0 = self:getTeam(arg_92_1)

	if var_92_0 then
		return var_92_0.daily_pet_change_times or 0
	end

	return 0
end

function AncientsData:getPetExp(arg_93_1)
	local var_93_0 = self:getPetData(arg_93_1)

	if var_93_0 then
		return var_93_0.exp or 0
	end

	return 0
end

function AncientsData:updateTaskData(arg_94_1)
	arg_94_1 = arg_94_1 or {}

	for iter_94_0, iter_94_1 in ipairs(arg_94_1) do
		self._taskSerData[iter_94_1.id] = iter_94_1
	end
end

function AncientsData:reqGetTaskAwards(arg_95_1)
	if not arg_95_1 then
		return
	end

	for iter_95_0, iter_95_1 in ipairs(arg_95_1.ids or {}) do
		if self._taskSerData[iter_95_1] then
			self._taskSerData[iter_95_1].awarded = true
		end
	end
end

function AncientsData:reqGetActiveAwards(arg_96_1)
	if not arg_96_1 then
		return
	end

	self:updateActiveAwardedIds(arg_96_1.ids or {})
end

function AncientsData:reqTaskNtf(arg_97_1)
	if not arg_97_1 then
		return
	end

	self:updateTaskData(arg_97_1.tasks or {})
end

function AncientsData:updateActiveCount(arg_98_1)
	if not arg_98_1 then
		return
	end

	self._activeCount = arg_98_1
end

function AncientsData:updateActiveAwardedIds(arg_99_1, arg_99_2)
	if arg_99_2 then
		self._activeAwardedIds = {}
	end

	arg_99_1 = arg_99_1 or {}

	for iter_99_0, iter_99_1 in ipairs(arg_99_1) do
		self._activeAwardedIds[iter_99_1] = true
	end
end

function AncientsData:getDailyDiceReward()
	return self._dailyDiceRewardData
end

function AncientsData:getTaskInfoById(arg_101_1)
	return var_0_7.get(arg_101_1)
end

function AncientsData:getTaskInfoArr(arg_102_1)
	if not self:getAncientsInfo() then
		return {}
	end

	if not self._taskInfoArr then
		self._taskInfoArr = {}

		for iter_102_0, iter_102_1 in var_0_7.ipairs() do
			if iter_102_1.task_group == self:getAncientsInfo().task_group then
				self._taskInfoArr[iter_102_1.task_sort] = self._taskInfoArr[iter_102_1.task_sort] or {}

				table.insert(self._taskInfoArr[iter_102_1.task_sort], iter_102_1)
			end
		end
	end

	return self._taskInfoArr[arg_102_1] or {}
end

function AncientsData:getActiveInfoArr()
	if not self._activeInfoArr then
		self._activeInfoArr = {}

		for iter_103_0, iter_103_1 in var_0_0.ipairs() do
			table.insert(self._activeInfoArr, iter_103_1)
		end
	end

	return self._activeInfoArr
end

function AncientsData:getAdvIdByUnit(arg_104_1)
	local var_104_0 = g.core.config.knight_info.fetch(arg_104_1.base_id)

	return (var_104_0 or nil) and (var_104_0.advance_id or 0)
end

function AncientsData:shouldFixAdvIdByUnits(arg_105_1, arg_105_2)
	local var_105_0 = true

	for iter_105_0, iter_105_1 in ipairs(arg_105_1) do
		local var_105_1 = g.core.config.knight_info.fetch(iter_105_1.base_id)

		if var_105_1 and var_105_1.advance_id == arg_105_2 then
			var_105_0 = false
		end
	end

	return var_105_0
end

function AncientsData:getTaskState(arg_106_1)
	local var_106_0 = g.core.model.User.ancientsData:getTaskSerData(arg_106_1.id)
	local var_106_1 = 1

	if var_106_0.awarded then
		var_106_1 = 2
	elseif var_106_0.value >= arg_106_1.goal then
		var_106_1 = 0
	end

	return var_106_1
end

function AncientsData:getActiveCount()
	return self._activeCount
end

function AncientsData:isActiveAwarded(arg_108_1)
	return self._activeAwardedIds[arg_108_1]
end

function AncientsData:getTaskSerData(arg_109_1)
	return self._taskSerData[arg_109_1] or {
		value = 0,
		awarded = false,
		id = arg_109_1
	}
end

function AncientsData:isEchoUnlock(arg_110_1)
	arg_110_1 = arg_110_1 or 1

	local var_110_0 = self:getCurPetLevelInfo()

	if not var_110_0 then
		return false
	end

	return var_110_0.echo_num > arg_110_1 - 1, var_110_0.echo_num
end

function AncientsData:isSkillUnlock(arg_111_1)
	arg_111_1 = arg_111_1 or 1

	local var_111_0 = self:getCurPetLevelInfo()

	if not var_111_0 then
		return false
	end

	return var_111_0["skill" .. arg_111_1] > 0
end

function AncientsData:getCurPetLevelInfo(arg_112_1)
	return (self:getPetLevelInfo(self:getPetBaseId(arg_112_1), (self:getPetLevel(arg_112_1))))
end

function AncientsData:getPetInfoById(arg_113_1)
	return var_0_4.get(arg_113_1)
end

function AncientsData:getPetInfoArr()
	if not self:getAncientsInfo() then
		return {}
	end

	if not self._petInfoArr then
		self._petInfoArr = {}

		for iter_114_0, iter_114_1 in var_0_4.ipairs() do
			self._petInfoArr[iter_114_1.ancients_pet_group] = self._petInfoArr[iter_114_1.ancients_pet_group] or {}

			table.insert(self._petInfoArr[iter_114_1.ancients_pet_group], iter_114_1)
		end
	end

	return self._petInfoArr[self:getAncientsInfo().ancients_pet_group] or {}
end

function AncientsData:getPetLevelInfo(arg_115_1, arg_115_2)
	return var_0_5.fetch(arg_115_1, arg_115_2)
end

function AncientsData:getPetSkillsInfo(arg_116_1)
	local var_116_0 = self:getPetBaseId(arg_116_1)

	if var_116_0 == 0 then
		return {}
	end

	local var_116_1 = self:getPetInfoById(var_116_0)
	local var_116_2 = {
		{
			level = 0,
			index = 1,
			skillId = var_116_1.skill1
		},
		{
			level = 0,
			index = 2,
			skillId = var_116_1.skill2
		}
	}
	local var_116_3 = self:getCurPetLevelInfo(arg_116_1)

	for iter_116_0, iter_116_1 in ipairs(var_116_2) do
		iter_116_1.level = iter_116_1.isEcho and var_116_3.echo_num + var_116_3.echo_extra_effect or var_116_3["skill" .. iter_116_0] == 0 and 0 or var_116_3["skill" .. iter_116_0] - iter_116_1.skillId
	end

	return var_116_2
end

function AncientsData:getPetEchoData(arg_117_1, arg_117_2)
	local var_117_0 = self:getPetData(arg_117_2)

	if var_117_0 then
		return (var_117_0.skills or {})[arg_117_1] or {}
	end

	return {}
end

function AncientsData:hasFinalFightQualification()
	return self._promoteRank > 0
end

function AncientsData:isRankLevelAward()
	return self._scoreStageRank <= 32 and self._scoreStageRank > 0
end

function AncientsData:isGuessByTeamId(arg_120_1, arg_120_2)
	for iter_120_0, iter_120_1 in ipairs(self._guessMap[arg_120_1] or {}) do
		if iter_120_1.support_team_id == arg_120_2 then
			return true
		end
	end

	return false
end

function AncientsData:isPromoteByTeamId(arg_121_1, arg_121_2)
	local var_121_0 = self._roundTeamsMap[arg_121_1] or {}

	if #var_121_0 < 1 then
		return true
	end

	for iter_121_0, iter_121_1 in ipairs(var_121_0) do
		if iter_121_1 == arg_121_2 and arg_121_2 ~= 0 then
			return true
		end
	end

	return false
end

function AncientsData:getPromoteLineStateByTeamId(arg_122_1, arg_122_2)
	local var_122_0 = self._roundTeamsMap[arg_122_1] or {}

	if self:isInStageShowTime(arg_122_1) or #var_122_0 < 1 then
		return 2, arg_122_2 > 0
	end

	for iter_122_0, iter_122_1 in ipairs(var_122_0) do
		if iter_122_1 == arg_122_2 and arg_122_2 ~= 0 then
			return 1
		end
	end

	return 0
end

function AncientsData:getRoundTeamsMap()
	return self._roundTeamsMap
end

function AncientsData:getGuessMap()
	return self._guessMap
end

function AncientsData:getFinalTeamMap()
	return self._finalTeamMap
end

function AncientsData:hasFinalInvite()
	return self._hasFinalInvite
end

function AncientsData:resetFinalInvite()
	self._hasFinalInvite = false
end

function AncientsData:isInStageShowTime(arg_128_1)
	if arg_128_1 == 0 then
		return false
	end

	if g.core.model.User.ancientsData:getAncientsState() == g.core.const.ConstMgr.AncientsConst.ANCIENT_STATUS.FINAL then
		local var_128_0 = g.core.common.ServerTime:getLeftSeconds(({
			self._finalStageTimeList[1],
			self._finalStageTimeList[2],
			self._finalStageTimeList[3],
			self._finalStageTimeList[4]
		})[arg_128_1])

		if var_128_0 - 600 <= 0 and var_128_0 + g.core.config.ancients_parameter_info.get(48).parameter * 60 > 0 then
			return true
		end
	end

	return false
end

function AncientsData:isInStageEffShowTime(arg_129_1)
	if arg_129_1 == 0 then
		return false
	end

	if g.core.model.User.ancientsData:getAncientsState() == g.core.const.ConstMgr.AncientsConst.ANCIENT_STATUS.FINAL then
		local var_129_0 = g.core.common.ServerTime:getLeftSeconds(({
			self._finalStageTimeList[1],
			self._finalStageTimeList[2],
			self._finalStageTimeList[3],
			self._finalStageTimeList[4]
		})[arg_129_1])

		if var_129_0 <= 0 and var_129_0 + g.core.config.ancients_parameter_info.get(48).parameter * 60 > 0 then
			return true
		end
	end

	return false
end

function AncientsData:isShowBattleVideo(arg_130_1)
	if arg_130_1 == 0 then
		return false
	end

	if g.core.model.User.ancientsData:getAncientsState() == g.core.const.ConstMgr.AncientsConst.ANCIENT_STATUS.FINAL and g.core.common.ServerTime:getLeftSeconds(({
		self._finalStageTimeList[1],
		self._finalStageTimeList[2],
		self._finalStageTimeList[3],
		self._finalStageTimeList[4]
	})[arg_130_1]) <= 0 then
		return true
	end

	if g.core.model.User.ancientsData:getAncientsState() > g.core.const.ConstMgr.AncientsConst.ANCIENT_STATUS.FINAL then
		return true
	end

	return false
end

function AncientsData:isInStageShowTimeAndCd()
	for iter_131_0 = 1, 4 do
		if g.core.model.User.ancientsData:getAncientsState() == g.core.const.ConstMgr.AncientsConst.ANCIENT_STATUS.FINAL then
			local var_131_0 = g.core.common.ServerTime:getLeftSeconds(({
				self._finalStageTimeList[1],
				self._finalStageTimeList[2],
				self._finalStageTimeList[3],
				self._finalStageTimeList[4]
			})[iter_131_0])

			if var_131_0 <= 0 and var_131_0 + g.core.config.ancients_parameter_info.get(48).parameter * 60 > 0 then
				return true, 3 + var_131_0 + g.core.config.ancients_parameter_info.get(48).parameter * 60
			end
		end
	end

	return false, 0
end

function AncientsData:getCampaignStr()
	local var_132_0 = {
		433344,
		433345,
		433346,
		433347,
		433348
	}
	local var_132_1 = g.core.model.User.ancientsData:getActivityData()
	local var_132_2 = ""

	if g.core.common.ServerTime:getLeftSeconds(var_132_1.score_start_time) > 0 then
		var_132_2 = g.core.lang:get(var_132_0[1])
	elseif g.core.common.ServerTime:getLeftSeconds(var_132_1.score_end_time) > 0 then
		var_132_2 = g.core.lang:get(var_132_0[2])
	elseif g.core.common.ServerTime:getLeftSeconds(var_132_1.final_start_time) > 0 then
		var_132_2 = g.core.lang:get(var_132_0[3])
	elseif g.core.common.ServerTime:getLeftSeconds(var_132_1.final_end_time) > 0 then
		var_132_2 = g.core.lang:get(var_132_0[4])
	elseif g.core.common.ServerTime:getLeftSeconds(var_132_1.end_time) > 0 then
		var_132_2 = g.core.lang:get(var_132_0[5])
	end

	return var_132_2
end

function AncientsData:getCurStageFinishTime()
	local var_133_0 = g.core.model.User.ancientsData:getActivityData()
	local var_133_1 = 0

	if g.core.common.ServerTime:getLeftSeconds(var_133_0.score_start_time) > 0 then
		var_133_1 = var_133_0.score_start_time
	elseif g.core.common.ServerTime:getLeftSeconds(var_133_0.score_end_time) > 0 then
		var_133_1 = var_133_0.score_end_time
	elseif g.core.common.ServerTime:getLeftSeconds(var_133_0.final_start_time) > 0 then
		var_133_1 = var_133_0.final_start_time
	elseif g.core.common.ServerTime:getLeftSeconds(var_133_0.final_end_time) > 0 then
		var_133_1 = var_133_0.final_end_time
	elseif g.core.common.ServerTime:getLeftSeconds(var_133_0.end_time) > 0 then
		var_133_1 = var_133_0.end_time
	end

	return var_133_1
end

function AncientsData:checkAncientsHasFightTimes()
	if g.core.model.User.ancientsData:getAncientsState() ~= var_0_11.ANCIENT_STATUS.FIGHT then
		return false
	end

	return g.core.model.User.ancientsData:getLeftFightTimes() > 0
end

function AncientsData:checkAncientsTaskAward(arg_135_1)
	for iter_135_0, iter_135_1 in ipairs((g.core.model.User.ancientsData:getTaskInfoArr(arg_135_1))) do
		if g.core.model.User.ancientsData:getTaskState(iter_135_1) == 0 then
			return true
		end
	end

	return false
end

function AncientsData:checkAncientsHasSpoils()
	return g.core.model.User.ancientsData:getSelfDiceNum() > 0
end

function AncientsData:checkAncientsFinalCanGuess()
	for iter_137_0, iter_137_1 in ipairs((g.core.model.User.ancientsData:getGuessMap())) do
		for iter_137_2, iter_137_3 in ipairs(iter_137_1) do
			if iter_137_3.support_team_id == 0 and g.core.model.User.ancientsData:getRoundTeamsMap()[iter_137_3.round] == nil and not g.core.model.User.ancientsData:isInStageShowTime(iter_137_3.round - 1) then
				return true
			end
		end
	end
end

function AncientsData:checkAncientsFinalCanGuess()
	for iter_138_0, iter_138_1 in ipairs((g.core.model.User.ancientsData:getGuessMap())) do
		for iter_138_2, iter_138_3 in ipairs(iter_138_1) do
			if iter_138_3.support_team_id == 0 and g.core.model.User.ancientsData:getRoundTeamsMap()[iter_138_3.round] == nil and not g.core.model.User.ancientsData:isInStageShowTime(iter_138_3.round - 1) then
				return true
			end
		end
	end
end

function AncientsData:checkAncientsFinalSubCanGuess(arg_139_1)
	if arg_139_1 == nil or not arg_139_1.round then
		return self:checkAncientsFinalCanGuess()
	end

	for iter_139_0, iter_139_1 in ipairs(g.core.model.User.ancientsData:getGuessMap()[arg_139_1.round] or {}) do
		if iter_139_1.support_team_id == 0 and g.core.model.User.ancientsData:getRoundTeamsMap()[iter_139_1.round] == nil and not g.core.model.User.ancientsData:isInStageShowTime(iter_139_1.round - 1) then
			return true
		end
	end
end

function AncientsData:checkAncientsFinalHasGuessAward()
	for iter_140_0, iter_140_1 in ipairs((g.core.model.User.ancientsData:getGuessMap())) do
		for iter_140_2, iter_140_3 in ipairs(iter_140_1) do
			if iter_140_3.support_team_id ~= 0 and g.core.model.User.ancientsData:getRoundTeamsMap()[iter_140_3.round] ~= nil and not iter_140_3.is_awarded and not g.core.model.User.ancientsData:isInStageShowTime(iter_140_3.round) then
				return true
			end
		end
	end
end

function AncientsData:checkAncientsFinalHasSubGuessAward(arg_141_1)
	if arg_141_1 == nil or not arg_141_1.round then
		return self:checkAncientsFinalHasGuessAward()
	end

	for iter_141_0, iter_141_1 in ipairs(g.core.model.User.ancientsData:getGuessMap()[arg_141_1.round] or {}) do
		if iter_141_1.support_team_id ~= 0 and g.core.model.User.ancientsData:getRoundTeamsMap()[iter_141_1.round] ~= nil and not iter_141_1.is_awarded and not g.core.model.User.ancientsData:isInStageShowTime(iter_141_1.round) then
			return true
		end
	end
end

function AncientsData:checkAncientsInvited()
	if self:getAncientsState() == var_0_11.ANCIENT_STATUS.COOP then
		return #self._invitationList > 0
	elseif self:getAncientsState() == var_0_11.ANCIENT_STATUS.FINAL_COOP and self:hasFinalFightQualification() then
		return #self._invitationList > 0
	else
		return false
	end
end

return AncientsData

local var_0_0 = g.core.config.domain_stage_info
local var_0_1 = g.core.model.User.domainData
local var_0_2 = g.core.common.Drops
local var_0_3 = g.core.const.ConstMgr.DomainConst
local DomainStageStruct = class("DomainStageStruct")

function DomainStageStruct:ctor(arg_1_1)
	self._stageInfo = arg_1_1
	self._curStageId = 1
	self._maxStageId = 0
	self._curGrade = 0
	self._stageInfoMap = {}
	self._stageInfoArray = {}
end

function DomainStageStruct:getStageInfo()
	return self._stageInfo
end

function DomainStageStruct:getStageGradeInfo()
	local var_3_0 = {}
	local var_3_1 = 1

	while var_0_0.hasKey("grade_value_" .. var_3_1) do
		local var_3_2 = self._stageInfo["grade_value_" .. var_3_1]
		local var_3_3 = self._stageInfo["grade_reward_" .. var_3_1]
		local var_3_4 = ""

		var_3_4 = self._stageInfo.grade_type == var_0_3.GRADE_TYPE.HP and g.core.lang:get(433151, {
			value = self._stageInfo["grade_size_" .. var_3_1]
		}) or g.core.lang:get(433152, {
			value = self._stageInfo["grade_size_" .. var_3_1]
		})

		table.insert(var_3_0, {
			grade = var_3_2,
			desc = (var_3_2 == var_0_3.GRADE.C or nil) and g.core.lang:get(433153),
			award = var_0_2:getGoodsArray(var_3_3)
		})

		var_3_1 = var_3_1 + 1
	end

	return var_3_0
end

function DomainStageStruct:isUnlockStage()
	return (checkbool(self._stageInfo.action_value <= g.core.model.User.domainData:getActionsValue(self._stageInfo.action_key, self._stageInfo.action_type)))
end

function DomainStageStruct:getStageState()
	local var_5_0 = self:isUnlockStage()
	local var_5_1 = var_0_1:getDungeon(self._stageInfo.dungeon_id):getCurStageAndGrade()

	if var_5_1 < self._stageInfo.stage or not var_5_0 then
		return var_0_3.STAGE_STATE.LOCK
	elseif self._stageInfo.stage == var_5_1 and var_5_0 then
		return var_0_3.STAGE_STATE.OPEN
	else
		return var_0_3.STAGE_STATE.SWEEP
	end
end

function DomainStageStruct:getFirstReward()
	return (var_0_2:getGoodsArray(self._stageInfo.first_reward))
end

function DomainStageStruct:getTurnTableReward()
	return (var_0_2:getGoodsArray(self._stageInfo.turntable_reward, false, true))
end

function DomainStageStruct:getEnemyList()
	local var_8_0 = g.core.config.massive_monster_team_info.get(self._stageInfo.monster_team, 1)
	local var_8_1 = {}

	if var_8_0 then
		for iter_8_0 = 1, 6 do
			if var_8_0["knight_id_" .. iter_8_0] > 0 then
				local var_8_2 = g.core.config.knight_info.get(var_8_0["knight_id_" .. iter_8_0])

				table.insert(var_8_1, {
					resId = var_8_2.res_id,
					info = var_8_2,
					star = var_8_2.star
				})
			end
		end
	end

	return var_8_1
end

function DomainStageStruct:getShowKnightInfo()
	local var_9_0 = g.core.config.massive_monster_team_info.get(self._stageInfo.monster_team, 1)

	if var_9_0 then
		return (g.core.config.knight_info.get(var_9_0.knight_id_1))
	end

	return {}
end

return DomainStageStruct

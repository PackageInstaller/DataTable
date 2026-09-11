local BattlePushSnowBallTeamSurvivalStageTemplate = class("BattlePushSnowBallTeamSurvivalStageTemplate", BattleBaseCooperationTemplate)

function BattlePushSnowBallTeamSurvivalStageTemplate:Ctor(arg_1_1, arg_1_2)
	self.id = arg_1_1
	self.dest = arg_1_2.dest
	self.activityID_ = arg_1_2.activityID
	self.cfg = BattlePushSnowBallTeamSurvivalStageCfg[self.id]
	self.heroList = {
		0,
		0,
		0
	}
	self.heroTrialList = {
		PushSnowBallData:GetSelectedBattleModelID(),
		0,
		0
	}
end

function BattlePushSnowBallTeamSurvivalStageTemplate:GetActivityID()
	return self.activityID_
end

function BattlePushSnowBallTeamSurvivalStageTemplate:GetDest()
	return self.dest
end

function BattlePushSnowBallTeamSurvivalStageTemplate:GetRoleDatas()
	return self.roleDataInLua
end

function BattlePushSnowBallTeamSurvivalStageTemplate:GetEnemyLevel()
	return self.cfg.monster_level
end

function BattlePushSnowBallTeamSurvivalStageTemplate:GetAILevel()
	return self.cfg.ai_level
end

function BattlePushSnowBallTeamSurvivalStageTemplate:GetStageId()
	return self.id
end

function BattlePushSnowBallTeamSurvivalStageTemplate:GetMap()
	return self.cfg.map, false
end

function BattlePushSnowBallTeamSurvivalStageTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.PUSH_SNOWBALL_TEAM_SURVIVAL
end

function BattlePushSnowBallTeamSurvivalStageTemplate:GetHeroTeam()
	return self.heroList, self.heroTrialList
end

function BattlePushSnowBallTeamSurvivalStageTemplate:UpdateRoleDatas()
	self.roleDataInLua = {}
	self.heroList = {}
	self.heroTrialList = {}
	self.heroInfoList = {}
	self.playerList = PushSnowBallData:GetPlayerList()

	for iter_11_0, iter_11_1 in ipairs(self.playerList) do
		local var_11_0 = RoleDataForExchange.New()

		var_11_0.UID = iter_11_1.uid
		var_11_0.ID = HeroStandardSystemCfg[iter_11_1.heroID].skin_id
		var_11_0.attributeID = {
			1,
			2,
			3
		}
		var_11_0.attributeValue = {
			1000,
			1000,
			1000
		}
		var_11_0.skillLevel = {
			1,
			1,
			1,
			1,
			1,
			1
		}

		table.insert(self.roleDataInLua, var_11_0)
		table.insert(self.heroTrialList, var_11_0.ID)
	end
end

function BattlePushSnowBallTeamSurvivalStageTemplate:GetMaxRaceData()
	return 0, 0
end

function BattlePushSnowBallTeamSurvivalStageTemplate:GetSystemHeroTeam()
	return self.heroTrialList
end

function BattlePushSnowBallTeamSurvivalStageTemplate:GetHeroDataByPos(arg_14_1)
	return nil
end

function BattlePushSnowBallTeamSurvivalStageTemplate:GetIsCooperation()
	return true, self.playerList
end

function BattlePushSnowBallTeamSurvivalStageTemplate:GetChipList()
	return {}
end

function BattlePushSnowBallTeamSurvivalStageTemplate:GetComboSkillID()
	return 0
end

function BattlePushSnowBallTeamSurvivalStageTemplate:GetComboSkillLevel()
	return 0
end

function BattlePushSnowBallTeamSurvivalStageTemplate:GetResurrectImmediately()
	return true
end

function BattlePushSnowBallTeamSurvivalStageTemplate:GetName()
	return self.cfg.name
end

return BattlePushSnowBallTeamSurvivalStageTemplate

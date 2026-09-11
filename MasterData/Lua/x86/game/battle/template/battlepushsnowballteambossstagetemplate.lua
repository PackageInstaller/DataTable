local BattlePushSnowBallTeamBossStageTemplate = class("BattlePushSnowBallTeamBossStageTemplate", BattleBaseCooperationTemplate)

function BattlePushSnowBallTeamBossStageTemplate:Ctor(arg_1_1, arg_1_2)
	self.id = arg_1_1
	self.dest = arg_1_2.dest
	self.activityID_ = arg_1_2.activityID
	self.cfg = BattlePushSnowBallTeamBossStageCfg[self.id]
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

function BattlePushSnowBallTeamBossStageTemplate:GetActivityID()
	return self.activityID_
end

function BattlePushSnowBallTeamBossStageTemplate:GetDest()
	return self.dest
end

function BattlePushSnowBallTeamBossStageTemplate:GetRoleDatas()
	return self.roleDataInLua
end

function BattlePushSnowBallTeamBossStageTemplate:GetEnemyLevel()
	return self.cfg.monster_level
end

function BattlePushSnowBallTeamBossStageTemplate:GetAILevel()
	return self.cfg.ai_level
end

function BattlePushSnowBallTeamBossStageTemplate:GetStageId()
	return self.id
end

function BattlePushSnowBallTeamBossStageTemplate:GetMap()
	return self.cfg.map, false
end

function BattlePushSnowBallTeamBossStageTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.PUSH_SNOWBALL_TEAM_BOSS
end

function BattlePushSnowBallTeamBossStageTemplate:GetHeroTeam()
	return self.heroList, self.heroTrialList
end

function BattlePushSnowBallTeamBossStageTemplate:UpdateRoleDatas()
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

function BattlePushSnowBallTeamBossStageTemplate:GetSystemHeroTeam()
	return self.heroTrialList
end

function BattlePushSnowBallTeamBossStageTemplate:GetMaxRaceData()
	return 0, 0
end

function BattlePushSnowBallTeamBossStageTemplate:GetHeroDataByPos(arg_14_1)
	return nil
end

function BattlePushSnowBallTeamBossStageTemplate:GetIsCooperation()
	return true, self.playerList
end

function BattlePushSnowBallTeamBossStageTemplate:GetChipList()
	return {}
end

function BattlePushSnowBallTeamBossStageTemplate:GetComboSkillID()
	return 0
end

function BattlePushSnowBallTeamBossStageTemplate:GetComboSkillLevel()
	return 0
end

function BattlePushSnowBallTeamBossStageTemplate:GetResurrectImmediately()
	return true
end

function BattlePushSnowBallTeamBossStageTemplate:GetName()
	return self.cfg.name
end

return BattlePushSnowBallTeamBossStageTemplate

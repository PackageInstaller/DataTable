local BattlePushSnowBallSingleStageTemplate = class("BattlePushSnowBallSingleStageTemplate", BattleBaseStageTemplate)

function BattlePushSnowBallSingleStageTemplate:Ctor(arg_1_1, arg_1_2)
	BattlePushSnowBallSingleStageTemplate.super.Ctor(self, arg_1_1)

	self.id = arg_1_1
	self.activityID = arg_1_2.activityID
	self.activityCfg = PushSnowBallCfg[PushSnowBallCfg.get_id_list_by_activityId[self.activityID][1]]
	self.cfg = BattlePushSnowBallSingleStageCfg[self.id]
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

function BattlePushSnowBallSingleStageTemplate:GetActivityID()
	return self.activityID
end

function BattlePushSnowBallSingleStageTemplate:GetDest()
	return self.cfg.id
end

function BattlePushSnowBallSingleStageTemplate:GetRoleDatas()
	return self.roleDataInLua
end

function BattlePushSnowBallSingleStageTemplate:UpdateRoleDatas(arg_5_1)
	self.roleDataInLua = {}

	local var_5_0 = RoleDataForExchange.New()

	var_5_0.UID = arg_5_1.playerID
	var_5_0.playerLevel = arg_5_1.level
	var_5_0.ID = HeroStandardSystemCfg[PushSnowBallData:GetSelectedBattleModelID()].skin_id
	var_5_0.attributeID = {
		1,
		2,
		3
	}
	var_5_0.attributeValue = {
		1000,
		1000,
		1000
	}
	var_5_0.skillLevel = {
		1,
		1,
		1,
		1,
		1,
		1
	}

	table.insert(self.roleDataInLua, var_5_0)
end

function BattlePushSnowBallSingleStageTemplate:GetEnemyLevel()
	return self.cfg.monster_level
end

function BattlePushSnowBallSingleStageTemplate:GetAILevel()
	return self.cfg.ai_level
end

function BattlePushSnowBallSingleStageTemplate:GetStageId()
	return self.id
end

function BattlePushSnowBallSingleStageTemplate:GetMap()
	return self.cfg.map, false
end

function BattlePushSnowBallSingleStageTemplate:GetName()
	return self.cfg.name
end

function BattlePushSnowBallSingleStageTemplate:GetSystemHeroTeam()
	return self.heroTrialList
end

function BattlePushSnowBallSingleStageTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.PUSH_SNOWBALL_SINGLE
end

function BattlePushSnowBallSingleStageTemplate:GetHeroTeam()
	return self.heroList, self.heroTrialList
end

function BattlePushSnowBallSingleStageTemplate:GetStageAffix()
	local var_14_0 = PushSnowBallDeviceCfg[PushSnowBallData:GetSelectedDeviceID()]
	local var_14_1 = {}
	local var_14_2 = {}
	local var_14_3 = {}

	if var_14_0 then
		for iter_14_0, iter_14_1 in pairs((type(var_14_0.affixs) == "table" or nil) and (var_14_0.affixs or {}) or {}) do
			table.insert(var_14_1, iter_14_1[1])
			table.insert(var_14_2, iter_14_1[2])
			table.insert(var_14_3, iter_14_1[3])
		end
	end

	return var_14_1, var_14_2, var_14_3
end

return BattlePushSnowBallSingleStageTemplate

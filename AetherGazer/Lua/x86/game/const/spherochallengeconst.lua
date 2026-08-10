local var_0_0 = {
	accelerateID = 54057,
	entrustMaxLevel = 4,
	EntrustState = {
		pool = 3,
		execute = 1,
		waite = 2
	},
	EntrustPosState = {
		empty = "empty",
		start = "start",
		fin = "finish",
		lock = "lock"
	},
	ScheduleID = {
		Barbecue = 2428407,
		Decode = 2428406,
		Decode_hero = 202803,
		Deter = 2428403,
		Explode = 2428404,
		Awake_hero = 202801,
		Barbecue_hero = 202802,
		Endurance = 2428402,
		Boss = 2428405,
		Entrust = 2428408,
		Awake = 2428401
	},
	ScheduleTypeName = {
		MiniGame = "ACTIVITY_HERO_CHALLENGE_GAME_TYPE",
		Entrust = "ACTIVITY_HERO_CHALLENGE_ENTRUST_TYPE",
		Battle = "ACTIVITY_HERO_CHALLENGE_BATTLE_TYPE"
	},
	ScheduleType = {
		MiniGame = 2,
		Entrust = 3,
		Battle = 1
	},
	ScheduleSubType = {
		boss = 5,
		train1 = 2,
		barbuce = 7,
		train2 = 3,
		decode = 6,
		train3 = 4,
		entrust = 8,
		story = 1
	},
	BattleSubType = {
		boss = 5,
		train1 = 2,
		train2 = 3,
		train3 = 4,
		story = 1
	},
	ChapterType = {
		train = 2,
		boss = 3,
		story = 1
	}
}

var_0_0.trainIndex = {
	[var_0_0.BattleSubType.train1] = 1,
	[var_0_0.BattleSubType.train2] = 2,
	[var_0_0.BattleSubType.train3] = 3
}
var_0_0.chapterID = {
	[var_0_0.BattleSubType.story] = 701,
	[var_0_0.BattleSubType.train1] = 702,
	[var_0_0.BattleSubType.train2] = 702,
	[var_0_0.BattleSubType.train3] = 702,
	[var_0_0.BattleSubType.boss] = 703
}
var_0_0.scheduleIndex = {
	[var_0_0.ScheduleSubType.story] = var_0_0.ScheduleID.Awake,
	[var_0_0.ScheduleSubType.train1] = var_0_0.ScheduleID.Endurance,
	[var_0_0.ScheduleSubType.train2] = var_0_0.ScheduleID.Deter,
	[var_0_0.ScheduleSubType.train3] = var_0_0.ScheduleID.Explode,
	[var_0_0.ScheduleSubType.boss] = var_0_0.ScheduleID.Boss,
	[var_0_0.ScheduleSubType.decode] = var_0_0.ScheduleID.Decode,
	[var_0_0.ScheduleSubType.barbuce] = var_0_0.ScheduleID.Barbecue,
	[var_0_0.ScheduleSubType.entrust] = var_0_0.ScheduleID.Entrust
}
var_0_0.PriorityType = {
	var_0_0.ScheduleType.Battle,
	var_0_0.ScheduleType.MiniGame,
	var_0_0.ScheduleType.Entrust
}
var_0_0.scheduleNum = GameSetting.activity_hero_challenge_schedule_limit.value[1]
var_0_0.scheduleTask = {
	[var_0_0.ScheduleSubType.train1] = var_0_0.ScheduleID.Awake_hero,
	[var_0_0.ScheduleSubType.train2] = var_0_0.ScheduleID.Awake_hero,
	[var_0_0.ScheduleSubType.train3] = var_0_0.ScheduleID.Awake_hero,
	[var_0_0.ScheduleSubType.decode] = var_0_0.ScheduleID.Decode_hero,
	[var_0_0.ScheduleSubType.barbuce] = var_0_0.ScheduleID.Barbecue_hero
}

return var_0_0

local var_0_0 = {
	EVENT = {
		SETTLEMENT_UPDATED = "SUMMERRACE_SETTLEMENT_UPDATED",
		RUNTIME_UPDATED = "SUMMERRACE_RUNTIME_UPDATED",
		PLAYER_LABEL_POSE_UPDATED = "SUMMERRACE_PLAYER_LABEL_POSE_UPDATED",
		OUTGAME_UPDATED = "SUMMERRACE_OUTGAME_UPDATED",
		STAGE_ITEM_UNLOCK_ANIM = "SUMMERRACE_STAGE_ITEM_UNLOCK_ANIM",
		DAMAGE_TEXT = "SUMMERRACE_DAMAGE_TEXT",
		STAGE_RESOLVED = "SUMMERRACE_STAGE_RESOLVED"
	},
	MODE = {
		ONE_VS_TWO_PRACTICE = "one_vs_two_practice",
		CHAMPIONSHIP = "championship",
		SURVIVAL_PRACTICE = "survival_practice",
		CHALLENGE = "challenge",
		PLOT = "plot"
	},
	TOURNAMENT_TAB = {
		DUEL = "duel",
		NORMAL = "normal",
		SURVIVAL = "survival"
	},
	FILTER = {
		ALL = "all",
		BODY = "body",
		EQUIP = "equip",
		WEAPON = "weapon"
	},
	REWARD_PAGE = {
		LIMITED = "limited",
		RESIDENT = "resident"
	},
	REWARD_SUBTYPE = {
		STAGE = "stage",
		ACHIEVEMENT = "achievement",
		DAILY = "daily"
	},
	SOURCE_TYPE = {
		MODIFY = "modify",
		REWARD = "reward",
		CHALLENGE = "challenge"
	},
	ACTIVITY_ID = {
		RESIDENT = ActivityConst.ACTIVITY_SUMMER_RACE_MAIN,
		MAIN = ActivityConst.ACTIVITY_SUMMER_RACE_MAIN,
		RANK = ActivityConst.ACTIVITY_SUMMER_RACE_RANK,
		TASK = ActivityConst.ACTIVITY_SUMMER_RACE_TASK
	},
	ACTIVITY_TEMPLATE = {
		TASK = ActivityTemplateConst.TASK,
		RANK = ActivityTemplateConst.SUMMER_RACE_RANK
	},
	BUILD = {
		BUDGET_COST = 18
	},
	DISPLAY = {
		CANVAS_SCALE = 180
	},
	PROPERTY_MAX = {
		ROF = 7,
		Skill = 4,
		HP = 10,
		ATK = 5,
		Cost = 18
	},
	BATTLE = {
		OVERLOAD_BUBBLE_TIPS = {
			"ACTIVITY_TANK_OVERLOAD_TIP_1",
			"ACTIVITY_TANK_OVERLOAD_TIP_2",
			"ACTIVITY_TANK_OVERLOAD_TIP_3"
		},
		EQUIP_BUBBLE_TIPS = {
			"ACTIVITY_TANK_EQUIP_TIP_1",
			"ACTIVITY_TANK_EQUIP_TIP_2",
			"ACTIVITY_TANK_EQUIP_TIP_3"
		}
	},
	BRIDGE_EVENT = {
		ENEMY_DEFEAT_BEFORE_FX = "SummerRace.EnemyDefeatBeforeFx"
	},
	GUIDE_TRIGGER = {
		STAGE_COMPLETED = "summerRaceStageCompleted",
		ENERGY_REACHED = "summerRaceEnergyReached",
		CONTEXT_ENEMY_DEFEAT_BEFORE_FX = "enemyDefeatBeforeFx",
		WAVE_START = "summerRaceWaveStart",
		ENEMY_DEFEAT_BEFORE_FX = "summerRaceEnemyDefeatBeforeFx"
	},
	GUIDE = {
		PAUSE_POLL_INTERVAL = 0.05
	},
	MOUNT_SLOT_TYPE = {
		EQUIP = 1,
		WEAPON = 0
	}
}

var_0_0.MODE_VALUE_TO_KEY = {
	var_0_0.MODE.CHAMPIONSHIP,
	var_0_0.MODE.SURVIVAL_PRACTICE,
	var_0_0.MODE.ONE_VS_TWO_PRACTICE,
	var_0_0.MODE.CHALLENGE,
	var_0_0.MODE.PLOT
}
var_0_0.VALID_MODE = {
	[var_0_0.MODE.CHAMPIONSHIP] = true,
	[var_0_0.MODE.SURVIVAL_PRACTICE] = true,
	[var_0_0.MODE.ONE_VS_TWO_PRACTICE] = true,
	[var_0_0.MODE.CHALLENGE] = true,
	[var_0_0.MODE.PLOT] = true
}
var_0_0.VALID_TOURNAMENT_TAB = {
	[var_0_0.TOURNAMENT_TAB.NORMAL] = true,
	[var_0_0.TOURNAMENT_TAB.SURVIVAL] = true,
	[var_0_0.TOURNAMENT_TAB.DUEL] = true
}
var_0_0.VALID_MODIFY_FILTER = {
	[var_0_0.FILTER.ALL] = true,
	[var_0_0.FILTER.WEAPON] = true,
	[var_0_0.FILTER.EQUIP] = true
}
var_0_0.VALID_ILLUSTRATED_FILTER = {
	[var_0_0.FILTER.BODY] = true,
	[var_0_0.FILTER.WEAPON] = true,
	[var_0_0.FILTER.EQUIP] = true
}
var_0_0.VALID_REWARD_PAGE = {
	[var_0_0.REWARD_PAGE.LIMITED] = true,
	[var_0_0.REWARD_PAGE.RESIDENT] = true
}
var_0_0.VALID_REWARD_SUBTYPE = {
	[var_0_0.REWARD_SUBTYPE.DAILY] = true,
	[var_0_0.REWARD_SUBTYPE.STAGE] = true,
	[var_0_0.REWARD_SUBTYPE.ACHIEVEMENT] = true
}
var_0_0.VALID_SOURCE_TYPE = {
	[var_0_0.SOURCE_TYPE.MODIFY] = true,
	[var_0_0.SOURCE_TYPE.REWARD] = true,
	[var_0_0.SOURCE_TYPE.CHALLENGE] = true
}
var_0_0.STAGE_MODE_TO_TAB = {
	var_0_0.TOURNAMENT_TAB.NORMAL,
	var_0_0.TOURNAMENT_TAB.SURVIVAL,
	var_0_0.TOURNAMENT_TAB.DUEL,
	[5] = var_0_0.TOURNAMENT_TAB.NORMAL
}
var_0_0.MODE_TYPE_TO_MODE_KEY = {
	var_0_0.MODE.CHAMPIONSHIP,
	var_0_0.MODE.SURVIVAL_PRACTICE,
	var_0_0.MODE.ONE_VS_TWO_PRACTICE,
	var_0_0.MODE.CHALLENGE,
	var_0_0.MODE.PLOT
}
var_0_0.MODE_KEY_TO_MODE_TYPE = {
	[var_0_0.MODE.CHAMPIONSHIP] = 1,
	[var_0_0.MODE.SURVIVAL_PRACTICE] = 2,
	[var_0_0.MODE.ONE_VS_TWO_PRACTICE] = 3,
	[var_0_0.MODE.CHALLENGE] = 4,
	[var_0_0.MODE.PLOT] = 5
}
var_0_0.OPTION_ITEM_TYPE_TO_FILTER = {
	var_0_0.FILTER.WEAPON,
	var_0_0.FILTER.EQUIP
}
var_0_0.ENABLE_STATIC_REWARD_PREVIEW_FALLBACK = false
var_0_0.CHALLENGE_SCORE_SETTING_KEYS = {
	"tank_challenge_wave_point",
	"summer_race_challenge_wave_score"
}
var_0_0.CHALLENGE_HEAL_RATIO_SETTING_KEYS = {
	"tank_challenge_wave_heal_ratio",
	"summer_race_challenge_wave_heal_ratio"
}
var_0_0.DAMAGE_TO_ENERGY_RATIO_SETTING_KEY = "summer_race_damage_to_energy_ratio"
var_0_0.ENERGY_REGEN_PER_SECOND_SETTING_KEY = "summer_race_energy_regen_per_second"
var_0_0.MAX_ENERGY_SETTING_KEY = "summer_race_max_energy"
var_0_0.DEFAULT_CHALLENGE_WAVE_SCORE_TABLE = {
	1000,
	2000,
	3000,
	4000,
	6000,
	8000,
	10000,
	13000,
	16000,
	19000,
	22000,
	25000,
	28000,
	31000,
	34000,
	37000,
	40000,
	43000,
	46000,
	49000
}
var_0_0.BODY_SPINE_SKIN_NAMES = {
	"default",
	"car/che_2"
}
var_0_0.CHAMPIONSHIP_CLICK_NAMESPACE = "SummerRaceChampionship"
var_0_0.CHAMPIONSHIP_ENTRY_CLICK_KEY = "entry_click_time"
var_0_0.REWARD_DEFS = {
	limited = {
		daily = {
			{
				rewardCount = 80,
				state = "canReceive",
				rewardId = "limited_daily_1",
				progressText = "1/1",
				rewardName = "Daily Token"
			},
			{
				rewardCount = 2,
				state = "locked",
				rewardId = "limited_daily_2",
				progressText = "0/1",
				rewardName = "Repair Kit"
			}
		},
		stage = {
			{
				rewardCount = 60,
				state = "received",
				rewardId = "limited_stage_1",
				progressText = "1/1",
				rewardName = "Stage Medal"
			},
			{
				rewardCount = 100,
				state = "locked",
				rewardId = "limited_stage_2",
				progressText = "0/1",
				rewardName = "Arena Voucher"
			},
			{
				rewardCount = 140,
				state = "locked",
				rewardId = "limited_stage_3",
				progressText = "0/1",
				rewardName = "Elite Voucher"
			}
		},
		achievement = {
			{
				rewardCount = 1,
				state = "locked",
				rewardId = "limited_achievement_1",
				progressText = "0/1",
				rewardName = "Duel Badge"
			}
		}
	},
	resident = {
		daily = {
			{
				rewardCount = 1,
				state = "canReceive",
				rewardId = "resident_daily_1",
				progressText = "1/1",
				rewardName = "Gear Coupon"
			},
			{
				rewardCount = 1,
				state = "locked",
				rewardId = "resident_daily_2",
				progressText = "0/1",
				rewardName = "Energy Pack"
			}
		},
		stage = {
			{
				rewardCount = 1,
				state = "locked",
				rewardId = "resident_stage_1",
				progressText = "0/1",
				rewardName = "Workshop Ticket"
			},
			{
				rewardCount = 15,
				state = "locked",
				rewardId = "resident_stage_2",
				progressText = "0/1",
				rewardName = "Blueprint Chip"
			}
		},
		achievement = {
			{
				rewardCount = 1,
				state = "locked",
				rewardId = "resident_achievement_1",
				progressText = "0/1",
				rewardName = "Arena Title"
			}
		}
	}
}
var_0_0.REWARD_ENTRY_PRIORITY = {
	{
		var_0_0.REWARD_PAGE.LIMITED,
		var_0_0.REWARD_SUBTYPE.DAILY
	},
	{
		var_0_0.REWARD_PAGE.LIMITED,
		var_0_0.REWARD_SUBTYPE.STAGE
	},
	{
		var_0_0.REWARD_PAGE.LIMITED,
		var_0_0.REWARD_SUBTYPE.ACHIEVEMENT
	},
	{
		var_0_0.REWARD_PAGE.RESIDENT,
		var_0_0.REWARD_SUBTYPE.DAILY
	}
}
var_0_0.LIMITED_ENTRY_SUBTYPE_PRIORITY = {
	var_0_0.REWARD_SUBTYPE.DAILY,
	var_0_0.REWARD_SUBTYPE.STAGE,
	var_0_0.REWARD_SUBTYPE.ACHIEVEMENT
}

return var_0_0

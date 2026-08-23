local var_0_0 = {
	MiniGridX = 3,
	MAP_ALIVE_CHECK_TIME = 2,
	MAP_DRAG_RADIO = 1,
	EQUIP_NUM = 3,
	KNIGHT_COIN_ID = 1,
	MAP_ALIVE_COUNT = 20,
	MAP_DRAG_ACCELERATE = 0,
	ShowVitDeltaTime = 5,
	MAP_MOUNTAIN_POOL_NUM = 80,
	BossHpJson = "OutpostBossHp.json",
	AsyncUpdateCount = 3,
	MAP_BUILD_POOL_NUM = 40,
	INIT_OBS_POOL_SIZE = 100,
	MAP_TILE_HEIGHT = 70,
	MAP_BIG_CELL_NUM = 1,
	MAP_DRAG_INERTIA_CLOSE = true,
	MAP_COLOR_POOL_NUM = 20,
	MAP_TILE_WIDTH = 140,
	MAP_MOVE_SPEED = 500,
	BOSS_SUMMON_PLAY_NUM_ID = 104,
	MAP_DRAG_SENSITIVE = 1,
	ROLE_HEIGHT = 80,
	MAP_DRAG_CHECK_NUM = 1,
	MAP_DEBUG_GRID = false,
	MAP_BORDER_NUM = 2,
	MiniGridY = 3,
	EXCHANGE_ITEM_TYPE = 38,
	MAP_DEBUG_COLORF = cc.c4f(0.15, 0.9, 0.9, 1),
	MAP_DEBUG_COLORB = cc.c4b(30, 230, 230, 255),
	UPDATE_RENDER_PIX = display.height * 0.3,
	POOL_OBJ_TYPE = {
		ENTITY = 2,
		BUILD = 1,
		OBS = 3
	},
	STATE_ENUM = {
		KNIGHT_FATIGUE = 4,
		KNIGHT_MOOD = 5,
		KNIGHT_DEMONIC = 2,
		KNIGHT_HP = 1,
		KNIGHT_HUNGER = 3
	},
	TIPS_ENUM = {
		TAVERN_LACK = 4,
		HOTEL_LACK = 3,
		RESTAURANT_LACK = 2,
		HOSPITAL_LACK = 1,
		ARMOR_READY = 5,
		BOSS_BOX = 7,
		WEAPON_READY = 6
	},
	TIPS_TYPE = {
		KNIGHT = 2,
		BUILD = 1,
		BOSS_BOX = 3
	},
	UNLOCK_TYPE = {
		GUIDE_TASK = 1,
		MAIN_CITY_LEVEL = 3
	},
	WorldParam = {
		OneKeyGetDrop = 35,
		SecondTickTime = 0.9,
		DamageAddMin = 2015,
		BulletStartHeight = 50,
		BulletSpeed = 100,
		AtkEffectCdRate = 0.8,
		FINISH_FORCE_QUEST_ID = 33,
		HasBossMoodCheck = 42,
		LowerMoodSubAtk = 13,
		AttackChangeMinCd = 0.5,
		AttackSpeedId = 2,
		MinAtkRangeId = 4,
		HitMin = 2003,
		CritRateMax = 2006,
		HasBossHungerCheck = 40,
		HasBossFatigueCheck = 41,
		ItemToKnightSpeed = 800,
		AttackSpeedMax = 2018,
		MoveSpeedId = 1,
		BlockRateMax = 2010,
		KnightBagItemMaxNum = 16,
		DamageAddMax = 2016,
		HitMax = 2004,
		AttackSpeedMin = 2017,
		TickSubDemonicEnergy = 9,
		KnightBagMaxNum = 15,
		BlockDamageMax = 2012,
		CritDamageMin = 2007,
		MonsterAttrBindBuild = 37,
		AtkBulletCdRate = 0.5,
		BlockDamageMin = 2011,
		CritDamageMax = 2008,
		TickDelayCount = 3,
		SkillUseHunger = 11,
		HurtSubMood = 26,
		VitMax = 22,
		VitSubDemonicEnergy = 17,
		BossAttackTime = 24,
		AttackUseHunger = 10,
		SpeedOnMainCityLevel = 43,
		FindMonsterRange = 32,
		BlockRateMin = 2009,
		BossSleepTime = 25,
		LowerHpRecover = 8,
		TickSubFatigue = 12,
		CritRateMin = 2005,
		DemonicEnergyMax = 23,
		HasBossHpCheck = 39,
		BulletBoomDist2 = 900
	},
	Profession = {
		Hunter = 2,
		Warrior = 1,
		Mage = 3
	},
	TrajectoryType = {
		Bullet = 1,
		None = 0
	},
	EntityType = {
		Bullet = 32,
		Door = 256,
		Knight = 4,
		Drop = 64,
		Barrier = 128,
		Mask = 512,
		Build = 2,
		Boss = 16,
		BossBox = 1024,
		Monster = 8,
		None = 0
	},
	ShowType = {
		ItemToKnight = 999,
		KnightTalk = 998,
		THROW = 996,
		DropRes = 997
	},
	MonsterType = {
		Elite = 2,
		BigBoss = 4,
		SmallBoss = 3,
		Normal = 1
	}
}

var_0_0.EnemyMask = {
	[bit.bor(var_0_0.EntityType.Knight, var_0_0.EntityType.Monster)] = true,
	[bit.bor(var_0_0.EntityType.Knight, var_0_0.EntityType.Boss)] = true
}
var_0_0.FriendlyMask = {
	[bit.bor(var_0_0.EntityType.Boss, var_0_0.EntityType.Monster)] = true
}
var_0_0.BuildType = {
	ArmorShop = 7,
	Tavern = 6,
	Hotel = 5,
	Hospital = 3,
	Exchange = 2,
	WeaponShop = 8,
	Boss = 9,
	AirWall = 10,
	Main = 1,
	Restaurant = 4,
	None = 0
}
var_0_0.BuildJumpId = {
	OUTPOST_MAIN_LAYER = 376,
	[var_0_0.BuildType.Main] = 377,
	[var_0_0.BuildType.Exchange] = 378,
	[var_0_0.BuildType.Hospital] = 379,
	[var_0_0.BuildType.Restaurant] = 380,
	[var_0_0.BuildType.Hotel] = 381,
	[var_0_0.BuildType.Tavern] = 382,
	[var_0_0.BuildType.ArmorShop] = 383,
	[var_0_0.BuildType.WeaponShop] = 384,
	[var_0_0.BuildType.Boss] = 385
}
var_0_0.BuildUnlockType = {
	BUILD_LEVEL = 500,
	USER_LEVEL = 1,
	KILL_BOSS = 504,
	MAIN_TASK = 506
}
var_0_0.SP_TASK_TYPE = 31
var_0_0.REJECT_IN_BUILD_REASON = {
	IS_IN_BUILDING = 2,
	KNIGHT_LIMIT = 3,
	ITEM_LIMIT = 4,
	NOT_COIN = 5,
	UNLOCK_BUILD = 1,
	NONE = 0
}
var_0_0.EquipType = {
	LOWER_BODY_ARMOR = 3,
	UPPER_BODY_ARMOR = 2,
	ARMS = 1,
	NONE = 0
}
var_0_0.ParameterID = {
	MAX_DONATE_NUM = 36,
	LIMIT_TASK_DROP = 19,
	CONSUMPTION_BASE_TIME = 2,
	LIMIT_TASK_TIME = 18
}
var_0_0.BOSS_OP_TYPE = {
	CANCEL_BOSS = 3,
	SWEEP_BOSS = 2,
	CALL_BOSS = 1
}
var_0_0.BUILD_SP_KNIGHT_TIME = {
	FOREVER = -1,
	WAIT_TO_DO = 2
}
var_0_0.EXCHANGE_TYPE = {
	SELL = 3,
	PRODUCE = 1,
	PUBLISH = 2
}
var_0_0.BONUS_TYPE = {
	TIME_TYPE = 2,
	COIN_TYPE = 1,
	KNIGHT_NUM = 3
}
var_0_0.TASK_TYPE = {
	LIMIT = 2,
	MAIN = 1
}
var_0_0.FsmTran = {
	Finish = 0
}
var_0_0.FsmState = {
	NormalSkill = 5,
	Root_DispatchRecover = 202,
	ReadyingAtk = 7,
	Sleep = 101,
	NORMAL_IDLE = 24,
	FindBoss = 103,
	Root_AtkBoss = 204,
	NORMAL_RECOVER = 22,
	MoveToPos = 3,
	Root_NoDispatch = 203,
	Idle = 2,
	Root_NoVit = 206,
	CMD_MOVE_TO = 1001,
	ActiveSkill = 6,
	Dead = 1,
	NORMAL_MOVE_TO = 23,
	Cmd = 205,
	AtkRecover = 8,
	MoveToTarget = 4,
	Root_DispatchAtk = 201,
	HasBossIdle = 10,
	SubmitItem = 9,
	ReadyingBoss = 102,
	WALK = 21,
	CMD_IDLE = 1000
}
var_0_0.EffectTween = {
	Shield = "outpostbattletxt_shield",
	Dodge = "outpostbattletxt_dodge",
	Damage = "outpostbattletxt_damage",
	Crit = "outpostbattletxt_critical",
	Recover = "outpostbattletxt_cure"
}
var_0_0.TweenType = {
	IconNumberLine = 3,
	Word = 2,
	IconNumberNoLine = 4,
	Number = 1
}
var_0_0.SkillType = {
	ActiveSkill = 2,
	Normal = 1
}
var_0_0.TalkType = {
	Talk7 = 7,
	Talk1 = 1,
	Talk14 = 14,
	Talk16 = 16,
	Talk5 = 5,
	Talk1002 = 1002,
	Talk1001 = 1001,
	Talk3 = 3
}
var_0_0.BuildToState = {
	[var_0_0.BuildType.Tavern] = var_0_0.STATE_ENUM.KNIGHT_MOOD,
	[var_0_0.BuildType.Restaurant] = var_0_0.STATE_ENUM.KNIGHT_HUNGER,
	[var_0_0.BuildType.Hotel] = var_0_0.STATE_ENUM.KNIGHT_FATIGUE,
	[var_0_0.BuildType.Hospital] = var_0_0.STATE_ENUM.KNIGHT_HP
}

return var_0_0

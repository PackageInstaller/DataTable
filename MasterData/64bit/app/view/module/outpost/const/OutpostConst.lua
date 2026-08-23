local var_0_0 = {
	MAP_DRAG_CHECK_NUM = 1,
	MAP_BORDER_NUM = 2,
	MAP_BUILD_POOL_NUM = 40,
	MAP_COLOR_POOL_NUM = 20,
	MAP_MOUNTAIN_POOL_NUM = 80,
	INIT_OBS_POOL_SIZE = 100,
	MAP_MOVE_SPEED = 500,
	MAP_DRAG_ACCELERATE = 0,
	MAP_DRAG_SENSITIVE = 1,
	MAP_DRAG_RADIO = 1,
	MAP_DRAG_INERTIA_CLOSE = true,
	MAP_TILE_HEIGHT = 70,
	MAP_TILE_WIDTH = 140,
	MAP_BIG_CELL_NUM = 1,
	MAP_DEBUG_GRID = false,
	BossHpJson = "OutpostBossHp.json",
	ShowVitDeltaTime = 5,
	AsyncUpdateCount = 3,
	MiniGridY = 3,
	MiniGridX = 3,
	EXCHANGE_ITEM_TYPE = 38,
	BOSS_SUMMON_PLAY_NUM_ID = 104,
	EQUIP_NUM = 3,
	ROLE_HEIGHT = 80,
	KNIGHT_COIN_ID = 1,
	MAP_ALIVE_CHECK_TIME = 2,
	MAP_ALIVE_COUNT = 20,
	MAP_DEBUG_COLORF = cc.c4f(0.15, 0.9, 0.9, 1),
	MAP_DEBUG_COLORB = cc.c4b(30, 230, 230, 255),
	UPDATE_RENDER_PIX = display.height * 0.3,
	POOL_OBJ_TYPE = {
		OBS = 3,
		ENTITY = 2,
		BUILD = 1
	},
	STATE_ENUM = {
		KNIGHT_HUNGER = 3,
		KNIGHT_DEMONIC = 2,
		KNIGHT_HP = 1,
		KNIGHT_MOOD = 5,
		KNIGHT_FATIGUE = 4
	},
	TIPS_ENUM = {
		ARMOR_READY = 5,
		TAVERN_LACK = 4,
		HOTEL_LACK = 3,
		RESTAURANT_LACK = 2,
		HOSPITAL_LACK = 1,
		BOSS_BOX = 7,
		WEAPON_READY = 6
	},
	TIPS_TYPE = {
		KNIGHT = 2,
		BOSS_BOX = 3,
		BUILD = 1
	},
	UNLOCK_TYPE = {
		GUIDE_TASK = 1,
		MAIN_CITY_LEVEL = 3
	},
	WorldParam = {
		FindMonsterRange = 32,
		HurtSubMood = 26,
		BossSleepTime = 25,
		BossAttackTime = 24,
		DemonicEnergyMax = 23,
		VitMax = 22,
		VitSubDemonicEnergy = 17,
		KnightBagItemMaxNum = 16,
		KnightBagMaxNum = 15,
		LowerMoodSubAtk = 13,
		TickSubFatigue = 12,
		SkillUseHunger = 11,
		AttackUseHunger = 10,
		TickSubDemonicEnergy = 9,
		LowerHpRecover = 8,
		SecondTickTime = 0.9,
		AttackChangeMinCd = 0.5,
		ItemToKnightSpeed = 800,
		TickDelayCount = 3,
		AtkBulletCdRate = 0.5,
		AtkEffectCdRate = 0.8,
		BulletBoomDist2 = 900,
		BulletStartHeight = 50,
		BulletSpeed = 100,
		AttackSpeedMax = 2018,
		AttackSpeedMin = 2017,
		DamageAddMax = 2016,
		DamageAddMin = 2015,
		BlockDamageMax = 2012,
		BlockDamageMin = 2011,
		BlockRateMax = 2010,
		BlockRateMin = 2009,
		CritDamageMax = 2008,
		CritDamageMin = 2007,
		CritRateMax = 2006,
		CritRateMin = 2005,
		HitMax = 2004,
		HitMin = 2003,
		MinAtkRangeId = 4,
		AttackSpeedId = 2,
		MoveSpeedId = 1,
		SpeedOnMainCityLevel = 43,
		HasBossMoodCheck = 42,
		HasBossFatigueCheck = 41,
		HasBossHungerCheck = 40,
		HasBossHpCheck = 39,
		MonsterAttrBindBuild = 37,
		OneKeyGetDrop = 35,
		FINISH_FORCE_QUEST_ID = 33
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
		None = 0,
		BossBox = 1024,
		Mask = 512,
		Door = 256,
		Barrier = 128,
		Drop = 64,
		Boss = 16,
		Monster = 8,
		Knight = 4,
		Build = 2
	},
	ShowType = {
		ItemToKnight = 999,
		THROW = 996,
		DropRes = 997,
		KnightTalk = 998
	},
	MonsterType = {
		BigBoss = 4,
		SmallBoss = 3,
		Elite = 2,
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
	AirWall = 10,
	None = 0,
	ArmorShop = 7,
	Tavern = 6,
	Hotel = 5,
	Restaurant = 4,
	Hospital = 3,
	Exchange = 2,
	Main = 1,
	WeaponShop = 8,
	Boss = 9
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
	USER_LEVEL = 1,
	MAIN_TASK = 506,
	KILL_BOSS = 504,
	BUILD_LEVEL = 500
}
var_0_0.SP_TASK_TYPE = 31
var_0_0.REJECT_IN_BUILD_REASON = {
	NOT_COIN = 5,
	ITEM_LIMIT = 4,
	KNIGHT_LIMIT = 3,
	IS_IN_BUILDING = 2,
	UNLOCK_BUILD = 1,
	NONE = 0
}
var_0_0.EquipType = {
	UPPER_BODY_ARMOR = 2,
	LOWER_BODY_ARMOR = 3,
	NONE = 0,
	ARMS = 1
}
var_0_0.ParameterID = {
	MAX_DONATE_NUM = 36,
	LIMIT_TASK_DROP = 19,
	LIMIT_TASK_TIME = 18,
	CONSUMPTION_BASE_TIME = 2
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
	PUBLISH = 2,
	PRODUCE = 1
}
var_0_0.BONUS_TYPE = {
	KNIGHT_NUM = 3,
	TIME_TYPE = 2,
	COIN_TYPE = 1
}
var_0_0.TASK_TYPE = {
	LIMIT = 2,
	MAIN = 1
}
var_0_0.FsmTran = {
	Finish = 0
}
var_0_0.FsmState = {
	Root_DispatchRecover = 202,
	Root_DispatchAtk = 201,
	FindBoss = 103,
	ReadyingBoss = 102,
	Sleep = 101,
	NORMAL_IDLE = 24,
	NORMAL_MOVE_TO = 23,
	NORMAL_RECOVER = 22,
	WALK = 21,
	HasBossIdle = 10,
	SubmitItem = 9,
	AtkRecover = 8,
	ReadyingAtk = 7,
	ActiveSkill = 6,
	NormalSkill = 5,
	MoveToTarget = 4,
	MoveToPos = 3,
	Idle = 2,
	Dead = 1,
	CMD_MOVE_TO = 1001,
	CMD_IDLE = 1000,
	Root_NoVit = 206,
	Cmd = 205,
	Root_AtkBoss = 204,
	Root_NoDispatch = 203
}
var_0_0.EffectTween = {
	Damage = "outpostbattletxt_damage",
	Dodge = "outpostbattletxt_dodge",
	Crit = "outpostbattletxt_critical",
	Shield = "outpostbattletxt_shield",
	Recover = "outpostbattletxt_cure"
}
var_0_0.TweenType = {
	Word = 2,
	Number = 1,
	IconNumberNoLine = 4,
	IconNumberLine = 3
}
var_0_0.SkillType = {
	ActiveSkill = 2,
	Normal = 1
}
var_0_0.TalkType = {
	Talk7 = 7,
	Talk5 = 5,
	Talk3 = 3,
	Talk1 = 1,
	Talk1002 = 1002,
	Talk1001 = 1001,
	Talk16 = 16,
	Talk14 = 14
}
var_0_0.BuildToState = {
	[var_0_0.BuildType.Tavern] = var_0_0.STATE_ENUM.KNIGHT_MOOD,
	[var_0_0.BuildType.Restaurant] = var_0_0.STATE_ENUM.KNIGHT_HUNGER,
	[var_0_0.BuildType.Hotel] = var_0_0.STATE_ENUM.KNIGHT_FATIGUE,
	[var_0_0.BuildType.Hospital] = var_0_0.STATE_ENUM.KNIGHT_HP
}

return var_0_0

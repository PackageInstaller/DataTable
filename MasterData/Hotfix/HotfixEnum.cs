using UnityEngine;

public static class HotfixEnum
{
	public enum monsterEpicType
	{
		[InspectorName("普通")]
		NORMAL = 5,
		[InspectorName("精英")]
		ELITE = 4,
		[InspectorName("小Boss")]
		LEADER = 3,
		[InspectorName("Boss")]
		LORD = 2,
		[InspectorName("全体")]
		ALL = 1,
		[InspectorName("陷阱")]
		TRAP = 6,
		[InspectorName("BossRush")]
		BOSSRUSH = 7,
		[InspectorName("JointDrillBoss")]
		JOINTDRILLBOSS = 8
	}

	public enum subBossType
	{
		[InspectorName("普通")]
		NORMAL = 5,
		[InspectorName("HuntBoss")]
		HUNTBOSS = 4
	}

	public enum actorMovType
	{
		[InspectorName("静止")]
		STATIC = 1,
		[InspectorName("行走")]
		WALK,
		[InspectorName("漂浮")]
		FLY
	}

	public enum skillType
	{
		[InspectorName("普攻")]
		NORMAL = 1,
		[InspectorName("技能")]
		OTHER_SKILL,
		[InspectorName("主控技能")]
		SKILL,
		[InspectorName("援护技能")]
		SUPPORT,
		[InspectorName("绝招")]
		ULTIMATE,
		[InspectorName("闪避")]
		DODGE,
		[InspectorName("疾跑")]
		RUSH
	}

	public enum skinType
	{
		[InspectorName("初始皮肤")]
		BASIC = 1,
		[InspectorName("进阶皮肤")]
		ADVANCE,
		[InspectorName("其它皮肤")]
		OTHER
	}

	public enum skinExtraTag
	{
		[InspectorName("模型")]
		MODEL = 1,
		[InspectorName("背景图")]
		IMAGE,
		[InspectorName("音乐")]
		MUSIC,
		[InspectorName("立绘")]
		TWOD
	}

	public enum skinSourceType
	{
		[InspectorName("活动获得")]
		ACTIVITY = 1,
		[InspectorName("限时出售")]
		TIMELIMIT,
		[InspectorName("成就获得")]
		ACHIEVEMENT,
		[InspectorName("主线任务")]
		MAINTASK,
		[InspectorName("地宫获得")]
		ROGUELIKE,
		[InspectorName("升阶获得")]
		ADVANCE,
		[InspectorName("创业基金")]
		BATTLEPASS
	}

	public enum handbookType
	{
		[InspectorName("角色皮肤")]
		SKIN = 1,
		[InspectorName("星盘大图")]
		OUTFIT,
		[InspectorName("剧情大图")]
		PLOT,
		[InspectorName("好感度CG")]
		CG,
		[InspectorName("故事集")]
		StorySet,
		[InspectorName("后宅角色皮肤")]
		DormSkin,
		[InspectorName("后宅家具")]
		DormFurniture,
		[InspectorName("活动剧情回顾")]
		StoryReview
	}

	public enum roguelikeLevelStyle
	{
		[InspectorName("麦田")]
		CountrySide = 1,
		[InspectorName("城镇白天")]
		City_Main_2 = 2,
		[InspectorName("城镇傍晚")]
		City_Main_1 = 3,
		[InspectorName("密涅瓦")]
		Boss_miniewa = 4,
		[InspectorName("水道桥")]
		City_Main_3 = 5,
		[InspectorName("水道桥_高达")]
		Boss_Gaoda = 6,
		[InspectorName("森林")]
		Forest = 7,
		[InspectorName("新森林")]
		Forest_New = 8,
		[InspectorName("野猪王")]
		Boss_Yezhuwang = 9,
		[InspectorName("半身树")]
		Boss_Banshenshu = 10,
		[InspectorName("温室")]
		Company_Main_5_1 = 11,
		[InspectorName("蜂鸟")]
		Boss_Fengniao = 12,
		[InspectorName("花房")]
		Company_Main_6_1 = 13,
		[InspectorName("风草")]
		Boss_Fengcao = 14,
		[InspectorName("海兔")]
		Boss_Haitu = 15,
		[InspectorName("城市突围")]
		City_Main_1_2 = 16,
		[InspectorName("污染森林")]
		Forest_Main_2_5 = 17,
		[InspectorName("Main5_1")]
		Main_5_1 = 18,
		[InspectorName("Main6_2")]
		Main_6_2 = 19,
		[InspectorName("Main7_1")]
		Main_7_1 = 20,
		[InspectorName("Main7_2")]
		Main_7_2 = 21,
		[InspectorName("Main8")]
		Main_8_1 = 22,
		[InspectorName("Main8_2")]
		Main_8_2 = 23,
		[InspectorName("Main8_3")]
		Main_8_3 = 24,
		[InspectorName("Main9_1")]
		Main_9_1 = 25,
		[InspectorName("Main9_2")]
		Main_9_2 = 26,
		[InspectorName("Main9_3")]
		Main_9_3 = 27,
		[InspectorName("Main9_4")]
		Main_9_4 = 28,
		[InspectorName("Main9_5")]
		Main_9_5 = 29,
		[InspectorName("Main10_1")]
		Main_10_1 = 30,
		[InspectorName("Main10_2")]
		Main_10_2 = 31,
		[InspectorName("Main10_3")]
		Main_10_3 = 32,
		[InspectorName("无属性塔")]
		Roguelike_non = 101,
		[InspectorName("miniboss")]
		Roguelike_miniboss = 102,
		[InspectorName("史莱姆")]
		Roguelike_shilaimu = 103,
		[InspectorName("跳舞机")]
		Roguelike_tiaowuji = 104,
		[InspectorName("鲨鱼")]
		Roguelike_shasha = 105,
		[InspectorName("大罐子")]
		Roguelike_daguanzi = 106,
		[InspectorName("厨子")]
		Roguelike_chuzi = 107,
		[InspectorName("塔楼")]
		Roguelike_talou = 108,
		[InspectorName("风扇姬")]
		Roguelike_fengshanji = 109,
		[InspectorName("多臂台灯")]
		Roguelike_duobitaideng = 110,
		[InspectorName("禁断丽容")]
		Roguelike_jinduanlirong = 111,
		[InspectorName("通用")]
		Roguelike_CommonBoss = 112,
		[InspectorName("方miniboss")]
		Roguelike_Fangminiboss = 113,
		[InspectorName("圆boss通用")]
		Roguelike_Commonminiboss_BOSS = 114,
		[InspectorName("射击卡带")]
		DailyInstance_01 = 115,
		[InspectorName("节奏卡带")]
		DailyInstance_02 = 116,
		[InspectorName("格斗卡带")]
		DailyInstance_03 = 117,
		[InspectorName("Boss_TR")]
		Boss_TuRen = 118,
		[InspectorName("Boss_PX")]
		Boss_PX = 119,
		[InspectorName("Boss_FL")]
		Boss_FL = 120,
		[InspectorName("TR01")]
		TravelBoss_Maoyan = 201,
		[InspectorName("TR02")]
		TravelBoss_Huayuan = 202,
		[InspectorName("TR03")]
		TravelBoss_Huochui = 203,
		[InspectorName("TR04")]
		TravelBoss_WuYu = 204,
		[InspectorName("剧院魅影")]
		JointDrill_01_JYMY = 251,
		[InspectorName("JD02")]
		JointDrill_02_SZ = 252,
		[InspectorName("JD02_1")]
		JointDrill_02_SZ_Red = 253,
		[InspectorName("JD02_2")]
		JointDrill_02_SZ_Blue = 254,
		[InspectorName("JD03")]
		JointDrill_03_MSS = 255,
		[InspectorName("吸血鬼1号")]
		VampireSurvivor_01 = 301,
		[InspectorName("吸血鬼2号")]
		VampireSurvivor_02 = 302,
		[InspectorName("吸血鬼3号")]
		VampireSurvivor_03 = 303,
		[InspectorName("吸血鬼4号")]
		VampireSurvivor_04 = 304,
		[InspectorName("ACT01")]
		StoryActivity_1 = 401,
		[InspectorName("ACT02")]
		StoryActivity_2 = 406,
		[InspectorName("ACT03")]
		StoryActivity_3 = 411,
		[InspectorName("ACT04")]
		StoryActivity_4 = 416,
		[InspectorName("ACT04_1")]
		StoryActivity_4_BOSS01 = 417,
		[InspectorName("ACT04_2")]
		StoryActivity_4_BOSS02 = 418,
		[InspectorName("ACT05")]
		StoryActivity_5 = 421,
		[InspectorName("ACT06")]
		StoryActivity_6 = 426,
		[InspectorName("ACT06_1")]
		StoryActivity_6_night = 427,
		[InspectorName("ACT06_2")]
		StoryActivity_6_BOSS01 = 428,
		[InspectorName("ACT07")]
		StoryActivity_7 = 431,
		[InspectorName("ACT07_1")]
		StoryActivity_7_Tow = 432,
		[InspectorName("ACT08")]
		StoryActivity_8 = 436,
		[InspectorName("ACT09")]
		StoryActivity_9 = 441,
		[InspectorName("ACT10")]
		StoryActivity_10 = 446,
		[InspectorName("ACT11")]
		StoryActivity_11 = 451,
		[InspectorName("ACT12")]
		StoryActivity_12 = 456,
		[InspectorName("ACT12_1")]
		StoryActivity_12_Boss01 = 457,
		[InspectorName("ACT13")]
		StoryActivity_13 = 461,
		[InspectorName("ACT14")]
		StoryActivity_14 = 466,
		[InspectorName("ACT15")]
		StoryActivity_15 = 471,
		[InspectorName("ACT15_1")]
		StoryActivity_15_01 = 472,
		[InspectorName("ACT16")]
		StoryActivity_16 = 476,
		[InspectorName("ACT16_1")]
		StoryActivity_16_01 = 477,
		[InspectorName("ACT17")]
		StoryActivity_17 = 481,
		[InspectorName("ACT17_1")]
		StoryActivity_17_Boss01 = 482,
		[InspectorName("ACT18")]
		StoryActivity_18 = 486,
		[InspectorName("ACT19")]
		StoryActivity_19 = 491,
		[InspectorName("ACT19_1")]
		StoryActivity_19_01 = 492,
		[InspectorName("ACT20")]
		StoryActivity_20 = 496,
		[InspectorName("ACT20_1")]
		StoryActivity_20_01 = 497,
		[InspectorName("ACT21")]
		StoryActivity_21 = 501,
		[InspectorName("ACT22")]
		StoryActivity_22 = 506,
		[InspectorName("ACT22_1")]
		StoryActivity_22_01 = 507,
		[InspectorName("ACT23")]
		StoryActivity_23 = 511,
		[InspectorName("ACT24")]
		StoryActivity_24 = 516,
		[InspectorName("ACT25")]
		StoryActivity_25 = 521,
		[InspectorName("ACT25_1")]
		StoryActivity_25_01 = 522,
		[InspectorName("训练关")]
		Training = 901
	}

	public enum roguelikeFloorFunction
	{
		[InspectorName("跑图")]
		THROUGH = 1,
		[InspectorName("事件")]
		MAPEVENT,
		[InspectorName("Boss战")]
		BOSSFIGHT
	}

	public enum effectiveGoals
	{
		[InspectorName("无")]
		NONE,
		[InspectorName("自己")]
		ONESELF,
		[InspectorName("敌人")]
		ENEMY,
		[InspectorName("所有角色")]
		FULL_TEAM,
		[InspectorName("除自己外的友方角色")]
		TEAMMATE,
		[InspectorName("除陷阱外的全部角色或怪物")]
		FULL_ENEMY,
		[InspectorName("主控角色")]
		MAINCONTROL_PLAYER,
		[InspectorName("援护角色")]
		ASSISTANT_PLAYER,
		[InspectorName("自己阵营的仆从")]
		TEAM_SUMMONED,
		[InspectorName("所有角色和仆从")]
		FULL_TEAM_AND_SUMMONED,
		[InspectorName("自己及仆从")]
		ONESELF_AND_SUMMONED,
		[InspectorName("友方阵营")]
		FRIEND_FACTION,
		[InspectorName("敌我阵营")]
		FRIEND_AND_ENEMY_FACTION,
		[InspectorName("施放来源的仆从")]
		FROM_ACTOR_SUMMONED,
		[InspectorName("除自己外角色的仆从")]
		TEAMMATE_SUMMONED,
		[InspectorName("敌方阵营的仆从")]
		ENEMY_SUMMONED,
		[InspectorName("双方阵营的仆从")]
		FRIEND_AND_ENEMY_SUMMONED,
		[InspectorName("除自己之外的友方角色和仆从")]
		TEAMMATE_AND_SUMMONED
	}

	public enum screen
	{
		[InspectorName("无")]
		NONE,
		[InspectorName("无筛选")]
		NOTHING,
		[InspectorName("被锁定的")]
		LOCKED
	}

	public enum timeSuperposition
	{
		[InspectorName("不叠加")]
		DONOTSTACK = 1,
		[InspectorName("重置")]
		RESET,
		[InspectorName("叠加")]
		SUPERPOSITION
	}

	public enum packMark
	{
		[InspectorName("素材")]
		Material = 1,
		[InspectorName("消耗品")]
		Consumables = 4,
		[InspectorName("装备")]
		Equipment = 5,
		[InspectorName("基础物品")]
		BasicItem = 6
	}

	public enum timing
	{
		[InspectorName("独立计算")]
		INDEPENDENT = 1,
		[InspectorName("先来后到")]
		SEQUENCE
	}

	public enum logicType
	{
		[InspectorName("与")]
		AND = 1,
		[InspectorName("或")]
		OR
	}

	public enum distance
	{
		[InspectorName("近战")]
		CLOSERANGE = 1,
		[InspectorName("远程")]
		REMOTE
	}

	public enum damageSource
	{
		[InspectorName("玩家")]
		PLAYER = 1,
		[InspectorName("怪物")]
		MONSTER,
		[InspectorName("陷阱")]
		TRAP,
		[InspectorName("信条")]
		PERK,
		[InspectorName("命运卡")]
		FATECARD
	}

	public enum damageType
	{
		[InspectorName("无")]
		NONE,
		[InspectorName("普攻")]
		NORMAL,
		[InspectorName("技能")]
		SKILL,
		[InspectorName("绝招")]
		ULTIMATE,
		[InspectorName("其他")]
		OTHER,
		[InspectorName("印记")]
		MARK,
		[InspectorName("衍生物")]
		PROJECTILE,
		[InspectorName("仆从")]
		SUMMON
	}

	public enum damageEffect
	{
		[InspectorName("物理")]
		PHYSICS = 1,
		[InspectorName("法术")]
		MAGIC = 2,
		[InspectorName("真实")]
		REAL = 4,
		[InspectorName("无伤害")]
		NO_DAMAGE = 5,
		[InspectorName("无伤害应用攻击特性无受击动画")]
		NO_DAMAGE_APPLY_FEATHER_NO_ANI = 6,
		[InspectorName("无伤害应用攻击特性有受击动画")]
		NO_DAMAGE_APPLY_FEATHER = 7,
		[InspectorName("无")]
		NONE = 8
	}

	public enum skillSlotType
	{
		[InspectorName("无")]
		NONE,
		[InspectorName("闪避")]
		A,
		[InspectorName("技能1")]
		B,
		[InspectorName("技能2")]
		C,
		[InspectorName("绝招")]
		D,
		[InspectorName("普攻")]
		NORMAL
	}

	public enum otherSources
	{
		[InspectorName("自身")]
		ONESELF = 1,
		[InspectorName("敌人")]
		ENEMY
	}

	public enum diffculty
	{
		[InspectorName("难度1")]
		Diffculty_1 = 1,
		[InspectorName("难度2")]
		Diffculty_2,
		[InspectorName("难度3")]
		Diffculty_3,
		[InspectorName("难度4")]
		Diffculty_4,
		[InspectorName("难度5")]
		Diffculty_5,
		[InspectorName("难度6")]
		Diffculty_6,
		[InspectorName("难度7")]
		Diffculty_7,
		[InspectorName("难度8")]
		Diffculty_8,
		[InspectorName("难度9")]
		Diffculty_9,
		[InspectorName("难度10")]
		Diffculty_10
	}

	public enum monsterBloodType
	{
		[InspectorName("不显示")]
		NONE,
		[InspectorName("简易")]
		SIMPLE,
		[InspectorName("高级")]
		ADVANCE,
		[InspectorName("Boss")]
		BOSS,
		[InspectorName("友方召唤物")]
		PLAYERSUMMON,
		[InspectorName("简易常驻")]
		SIMPLE2,
		[InspectorName("小Boss")]
		MINIBOSS,
		[InspectorName("BossRush")]
		BOSSRUSH,
		[InspectorName("JointDrillBoss")]
		JOINTDRILLBOSS
	}

	public enum travelerDuelBossType
	{
		[InspectorName("普通")]
		NORMAL = 1,
		[InspectorName("挑战")]
		CHALLENGE
	}

	public enum worldLevelType
	{
		[InspectorName("主线")]
		Mainline = 1,
		[InspectorName("支线")]
		Branchline = 3,
		[InspectorName("地区boss")]
		RegionBoss = 4,
		[InspectorName("序章")]
		Prologue = 6,
		[InspectorName("序章战斗")]
		PrologueBattleLevel = 7,
		[InspectorName("旅人决斗")]
		TravelerDuel = 8,
		[InspectorName("日常副本")]
		DailyInstance = 9,
		[InspectorName("无尽塔")]
		InfinityTower = 10,
		[InspectorName("通用")]
		All = 11,
		[InspectorName("装备副本")]
		EquipmentInstance = 12,
		[InspectorName("星塔")]
		StarTower = 13,
		[InspectorName("吸血鬼")]
		VampireInstance = 14,
		[InspectorName("Boss积分挑战")]
		ScoreBoss = 15,
		[InspectorName("技能素材本")]
		SkillInstance = 16,
		[InspectorName("周本")]
		WeeklyCopies = 17,
		[InspectorName("动态关卡")]
		Dynamic = 18,
		[InspectorName("自动战斗平衡测试")]
		AutoBalance = 19,
		[InspectorName("中型活动挑战")]
		ActivityLevels = 20,
		[InspectorName("打砖块")]
		BrickBreaker = 21,
		[InspectorName("塔防玩法")]
		TowerDefense = 22,
		[InspectorName("教学关")]
		Tutorial = 23,
		[InspectorName("活动剧情战斗关卡")]
		ActivityStory = 24,
		[InspectorName("猎影合围")]
		TraceHunt = 25
	}

	public enum dynamicLevelType
	{
		[InspectorName("总力战")]
		JointDrill = 1,
		[InspectorName("塔防")]
		TowerDefense,
		[InspectorName("试玩关")]
		Trial,
		[InspectorName("教学关")]
		Tutorial,
		[InspectorName("总力战二型")]
		JointDrill_2,
		[InspectorName("内部测试工具")]
		BattlePresetTeamEditor,
		[InspectorName("自走棋")]
		SoldierChess,
		[InspectorName("猎影合围")]
		TraceHunt
	}

	public enum mainLineType
	{
		[InspectorName("主线")]
		Mainline = 1,
		[InspectorName("支线")]
		Branchline
	}

	public enum hurtFlashTintType
	{
		[InspectorName("无")]
		NONE,
		[InspectorName("边缘")]
		EDGE,
		[InspectorName("全身")]
		WHOLE
	}

	public enum referencetarget
	{
		[InspectorName("释放者")]
		Self = 1,
		[InspectorName("受益者")]
		Target
	}

	public enum referenceattrib
	{
		[InspectorName("最大生命")]
		Hp = 1,
		[InspectorName("总攻击力")]
		Atk,
		[InspectorName("基础攻击力")]
		BaseAtk,
		[InspectorName("基础最大生命")]
		BaseHp,
		[InspectorName("最大防御力")]
		DEF,
		[InspectorName("基础防御力")]
		BaseDEF,
		[InspectorName("暴击")]
		CRITRATE,
		[InspectorName("暴击伤害")]
		CRITPOWER_P,
		[InspectorName("防御穿透")]
		PENETRATE,
		[InspectorName("水系伤害")]
		WEE,
		[InspectorName("火系伤害")]
		FEE,
		[InspectorName("地系伤害")]
		SEE,
		[InspectorName("风系伤害")]
		AEE,
		[InspectorName("光系伤害")]
		LEE,
		[InspectorName("暗系伤害")]
		DEE,
		[InspectorName("水系穿透")]
		WEP,
		[InspectorName("火系穿透")]
		FEP,
		[InspectorName("地系穿透")]
		SEP,
		[InspectorName("风系穿透")]
		AEP,
		[InspectorName("光系穿透")]
		LEP,
		[InspectorName("暗系穿透")]
		DEP,
		[InspectorName("当前生命")]
		CurrentHp
	}

	public enum subMapName
	{
		[InspectorName("雷霆崖")]
		ThunderBluff = 1,
		[InspectorName("奥格瑞玛")]
		Orgrimmar,
		[InspectorName("贫瘠之地")]
		Barrens,
		[InspectorName("东瘟疫之地")]
		EasternPlaguelands
	}

	public enum monsterAIBranchActiveConditionType
	{
		[InspectorName("无")]
		NONE,
		[InspectorName("血量百分比大于等于")]
		HP_PER_MORE_OR_EQUAL,
		[InspectorName("血量百分比小于")]
		HP_PER_LESS,
		[InspectorName("目标距离大于等于")]
		TARGET_DISTANCE_GREATER_OR_EQU,
		[InspectorName("目标距离小于")]
		TARGET_DISTANCE_LESS,
		[InspectorName("坐标距离大于等于")]
		POSITION_DISTANCE_GREATER_OR_EQU,
		[InspectorName("坐标距离小于")]
		POSITION_DISTANCE_LESS,
		[InspectorName("特定怪物基础状态")]
		TARGET_MONSTER_BASIC_STATE,
		[InspectorName("指定buffId")]
		TARGET_MONSTER_BUFFID,
		[InspectorName("指定buffGroupId")]
		TARGET_MONSTER_BUFFGROUPID,
		[InspectorName("指定BranchID释放次数")]
		TARGET_MONSTER_CASTSKILLTIME,
		[InspectorName("指定Branch组ID释放次数")]
		TARGET_MONSTER_GROUP_CASTSKILLTIME,
		[InspectorName("目标韧性状态")]
		TARGET_TOUGHNESS_STATE,
		[InspectorName("目标韧性状态变化")]
		TARGET_TOUGHNESS_STATECHANGE
	}

	public enum jumpType
	{
		[InspectorName("关卡")]
		Mainline = 1,
		[InspectorName("遗迹")]
		Rogue,
		[InspectorName("遗迹组")]
		RogueGroup,
		[InspectorName("遗迹主界面")]
		RoguePanel,
		[InspectorName("区域BOSS")]
		RegionBoss,
		[InspectorName("区域BOSS组")]
		RegionBossGroup,
		[InspectorName("区域BOSS主界面")]
		RegionBossPanel,
		[InspectorName("文本")]
		Text,
		[InspectorName("世界地图")]
		Map,
		[InspectorName("商店")]
		Shop,
		[InspectorName("商城")]
		Mall,
		[InspectorName("抽卡")]
		Gacha,
		[InspectorName("每日副本")]
		DailyInstanceLevel,
		[InspectorName("旅人对决")]
		TravelerDuelLevel,
		[InspectorName("背包")]
		Depot,
		[InspectorName("角色列表")]
		CharacterList,
		[InspectorName("材料合成")]
		Crafting,
		[InspectorName("星塔")]
		StarTower,
		[InspectorName("星塔组")]
		StarTowerGroup,
		[InspectorName("星塔主界面")]
		StarTowerPanel,
		[InspectorName("星盘列表")]
		Disc,
		[InspectorName("纹章本主界面")]
		EquipmentPanel,
		[InspectorName("纹章本组")]
		EquipmentGroup,
		[InspectorName("主线故事")]
		MainlineStory,
		[InspectorName("无尽塔主界面")]
		InfinityTower,
		[InspectorName("无尽塔种类")]
		InfinityTowerGroup,
		[InspectorName("委托")]
		Agent,
		[InspectorName("手机")]
		Phone,
		[InspectorName("吸血鬼")]
		Vampire,
		[InspectorName("排行榜星塔")]
		StarTowerRank,
		[InspectorName("自选包")]
		ComCYO,
		[InspectorName("技能本主界面")]
		SkillInstancePanel,
		[InspectorName("技能本组")]
		SkillInstanceGroup,
		[InspectorName("王权")]
		Quest,
		[InspectorName("积分boss")]
		ScoreBoss,
		[InspectorName("周本")]
		WeeklyCopies,
		[InspectorName("故事集")]
		StorySet,
		[InspectorName("星塔养成")]
		StarTowerGrowth,
		[InspectorName("中型活动任务")]
		ActivityTask,
		[InspectorName("主线故事章节")]
		MainLineStoryChapter,
		[InspectorName("见习任务")]
		QuestNewbie,
		[InspectorName("角色详情界面")]
		CharInfo,
		[InspectorName("猎影合围")]
		TraceHunt,
		[InspectorName("活动剧情")]
		ActivityStory,
		[InspectorName("活动关卡")]
		ActivityLevel,
		[InspectorName("活动小游戏1")]
		ActivityGame1,
		[InspectorName("活动小游戏2")]
		ActivityGame2,
		[InspectorName("尖兵陷阵")]
		Soldier,
		[InspectorName("魔王之塔")]
		Dorm
	}

	public enum characterSearchTargetType
	{
		[InspectorName("近战")]
		MELEE = 1,
		[InspectorName("远程")]
		RANGED
	}

	public enum characterSearchTargetTypeTowerDefense
	{
		[InspectorName("常规")]
		NORMAL = 1
	}

	public enum gachaStorageType
	{
		[InspectorName("角色UP卡池")]
		CharacterUpCardPool = 1,
		[InspectorName("角色常驻卡池")]
		CharacterCardPool,
		[InspectorName("秘纹UP卡池")]
		DiscUpCardPool,
		[InspectorName("秘纹常驻卡池")]
		DiscCardPool,
		[InspectorName("新手卡池")]
		BeginnerCardPool,
		[InspectorName("角色常驻卡池累抽赠奖")]
		CharacterCardRewardPool
	}

	public enum guidetype
	{
		[InspectorName("强制点击型")]
		ForcedClick = 1,
		[InspectorName("介绍型")]
		Introductory,
		[InspectorName("弹出图片型")]
		PopPicture,
		[InspectorName("通用对话")]
		PlayAvg
	}

	public enum dailyType
	{
		[InspectorName("经验本")]
		ExpDungeon = 1,
		[InspectorName("金币本")]
		MoneyDungeon,
		[InspectorName("神器经验本")]
		PresentsExpDungeon,
		[InspectorName("星盘经验本")]
		OutfitExpDungeon,
		[InspectorName("通用素材关")]
		Common
	}

	public enum DailyRewardType
	{
		[InspectorName("角色经验")]
		CharExp = 1,
		[InspectorName("金币")]
		Money,
		[InspectorName("纹章经验")]
		EquipmentExp,
		[InspectorName("星盘经验")]
		DiscExp
	}

	public enum guideDetectionType
	{
		[InspectorName("主动检测")]
		InitiativeCheck = 1,
		[InspectorName("被动检测")]
		PassiveCheck
	}

	public enum guideprepose
	{
		[InspectorName("完成指引")]
		PreGuide = 1,
		[InspectorName("世界等级")]
		WorldClass,
		[InspectorName("完成关卡")]
		FinishDungeon,
		[InspectorName("系统解锁")]
		UnlockFunction,
		[InspectorName("持有道具")]
		HoldItem,
		[InspectorName("完成星塔任务")]
		FinishStarTowerQuest,
		[InspectorName("未观看角色指定剧情")]
		UnFinishCharacterPlot,
		[InspectorName("完成后宅任务")]
		FinishDormQuest,
		[InspectorName("完成后宅任务组")]
		FinishDormQuestGroup
	}

	public enum guidepost
	{
		[InspectorName("未完成指引")]
		UnDoneGuide = 1
	}

	public enum guidetrigger
	{
		[InspectorName("完成指引")]
		PreGuide = 1,
		[InspectorName("世界等级")]
		WorldClass,
		[InspectorName("打开界面")]
		OpenInterface,
		[InspectorName("完成上一步")]
		FinishLastStep,
		[InspectorName("完成关卡")]
		FinishDungeon,
		[InspectorName("系统解锁")]
		UnlockFunction
	}

	public enum endtype
	{
		[InspectorName("强制引导")]
		ForceGuide = 1,
		[InspectorName("非强制引导")]
		UnforceGuide
	}

	public enum fixedRoguelikeFunc0
	{
		[InspectorName("战斗")]
		Battle = 1,
		[InspectorName("Boss战")]
		Boss
	}

	public enum fixedRoguelikeFunc1
	{
		[InspectorName("普通挑战")]
		CommonChallenge = 31,
		[InspectorName("生存挑战")]
		LiveChallenge = 32,
		[InspectorName("MiniBoss挑战")]
		MiniBossChallenge = 33,
		[InspectorName("无主的财富_怪物型")]
		Monster = 101,
		[InspectorName("无主的财富_宝箱型")]
		Treasure = 102
	}

	public enum fixedRoguelikeGameplayType
	{
		[InspectorName("无补充")]
		UnReplenish = 1,
		[InspectorName("连续补充")]
		Replenish,
		[InspectorName("全远程")]
		Remote,
		[InspectorName("包围")]
		Surround,
		[InspectorName("单挑")]
		One2One,
		[InspectorName("深入")]
		Thorough,
		[InspectorName("混乱")]
		Chaos
	}

	public enum infinityTowerGameplayType
	{
		[InspectorName("常规")]
		Normal = 1,
		[InspectorName("包围")]
		Surround,
		[InspectorName("单挑")]
		One2One,
		[InspectorName("混乱")]
		Chaos,
		[InspectorName("精英战")]
		Elite,
		[InspectorName("全远程包围")]
		RemoteSur,
		[InspectorName("全近战")]
		Melee,
		[InspectorName("特殊怪")]
		Special,
		[InspectorName("全远程并排")]
		RemoteSBS
	}

	public enum vampireWaveType
	{
		[InspectorName("常规")]
		Normal = 1,
		[InspectorName("集群")]
		gather,
		[InspectorName("分散")]
		Loose
	}

	public enum fixedRoguelikePortDir
	{
		[InspectorName("左")]
		Left = 1,
		[InspectorName("右")]
		Right
	}

	public enum levelState
	{
		[InspectorName("失败")]
		Failed = 1,
		[InspectorName("完成")]
		Success,
		[InspectorName("下一个房间")]
		Teleporter
	}

	public enum specificCombatType
	{
		[InspectorName("限时挑战")]
		Timelimited = 1,
		[InspectorName("盗宝哥布林")]
		RobberGoblin,
		[InspectorName("免受伤害")]
		EscapeInjury,
		[InspectorName("连续击杀")]
		ContinuousKilling,
		[InspectorName("击杀指定怪物")]
		KillMonster,
		[InspectorName("召唤干扰怪物")]
		DisturbMonster
	}

	public enum combatActivePointType
	{
		[InspectorName("关卡开始时")]
		LevelStart = 1,
		[InspectorName("首个波次刷新时")]
		FirstWaveRefresh,
		[InspectorName("首个波次完成时")]
		FirstWaveClear,
		[InspectorName("每个波次刷新时")]
		EveryWaveRefresh,
		[InspectorName("每个波次完成时")]
		EveryWaveClear,
		[InspectorName("最后波次刷新时")]
		FinalWaveRefresh,
		[InspectorName("最后波次完成时")]
		FinalWaveClear
	}

	public enum combatActiveType
	{
		[InspectorName("自动")]
		Automatic = 1,
		[InspectorName("交互")]
		Interactive
	}

	public enum npcType
	{
		[InspectorName("天赋")]
		Talent = 1,
		[InspectorName("福利房")]
		RewardRoom,
		[InspectorName("商店")]
		shop,
		[InspectorName("资源轮换")]
		Gamble,
		[InspectorName("强化")]
		Upgrade,
		[InspectorName("任务")]
		Quest,
		[InspectorName("恢复")]
		Resque,
		[InspectorName("信条选择（序章专用）")]
		PrologueReward,
		[InspectorName("叙事")]
		Narrate
	}

	public enum npcNewType
	{
		[InspectorName("商店")]
		Shop = 1,
		[InspectorName("强化")]
		Upgrade,
		[InspectorName("恢复")]
		Resque,
		[InspectorName("叙事")]
		Narrate,
		[InspectorName("事件")]
		Event,
		[InspectorName("危险房")]
		Danger,
		[InspectorName("高危房")]
		Horror
	}

	public enum areaEffectType
	{
		[InspectorName("通用区域效果")]
		TriggerAreaObj = 1,
		[InspectorName("风墙")]
		TriggerWindWall,
		[InspectorName("扩散型区域效果")]
		DiffuseArea,
		[InspectorName("持续牵引型区域效果")]
		PullArea,
		[InspectorName("单次攻击区域效果")]
		HitArea,
		[InspectorName("触发型区域效果")]
		TriggerArea
	}

	public enum characterGrade
	{
		[InspectorName("SSR")]
		SSR = 1,
		[InspectorName("SR")]
		SR,
		[InspectorName("R")]
		R
	}

	public enum characterJobClass
	{
		[InspectorName("先锋")]
		Vanguard = 1,
		[InspectorName("均衡")]
		Balance,
		[InspectorName("支援")]
		Support
	}

	public enum characterAttackType
	{
		[InspectorName("近战")]
		MELEE = 1,
		[InspectorName("远程")]
		RANGED
	}

	public enum shopRefreshTimeType
	{
		[InspectorName("日")]
		DAY = 1,
		[InspectorName("周")]
		WEEK,
		[InspectorName("月")]
		MONTH
	}

	public enum itemType
	{
		[InspectorName("资源")]
		Res = 1,
		[InspectorName("道具")]
		Item = 2,
		[InspectorName("角色")]
		Char = 3,
		[InspectorName("体力")]
		Energy = 4,
		[InspectorName("世界等级经验")]
		WorldRankExp = 5,
		[InspectorName("遗迹道具")]
		RogueItem = 6,
		[InspectorName("星盘")]
		Disc = 7,
		[InspectorName("装备")]
		Equipment = 9,
		[InspectorName("角色皮肤")]
		CharacterSkin = 10,
		[InspectorName("月卡")]
		MonthlyCard = 11,
		[InspectorName("头衔")]
		Title = 12,
		[InspectorName("称号")]
		Honor = 13,
		[InspectorName("头像")]
		HeadItem = 14,
		[InspectorName("等级称号")]
		LevelHonor = 15,
		[InspectorName("追踪委托书")]
		TraceRequest = 16,
		[InspectorName("围猎许可证")]
		HuntPermit = 17,
		[InspectorName("自走棋道具")]
		SoldierItem = 18,
		[InspectorName("后宅道具")]
		DormFurniture = 19,
		[InspectorName("后宅称号")]
		DormHonor = 20
	}

	public enum expireType
	{
		[InspectorName("固定时间")]
		ExpireMin = 1,
		[InspectorName("指定天数")]
		ExpireDay,
		[InspectorName("指定周数")]
		ExpireWeek,
		[InspectorName("指定日期")]
		ExpireDate
	}

	public enum useMode
	{
		[InspectorName("手动使用")]
		UseModeManual = 1,
		[InspectorName("自动使用")]
		UseModeAuto,
		[InspectorName("不可使用")]
		UseModeNot
	}

	public enum useAction
	{
		[InspectorName("掉落")]
		Drop = 1,
		[InspectorName("获得物品")]
		Item,
		[InspectorName("自选")]
		Pick,
		[InspectorName("不可使用")]
		No
	}

	public enum questType
	{
		[InspectorName("主线")]
		Mainline,
		[InspectorName("新手")]
		New,
		[InspectorName("日常")]
		Daily,
		[InspectorName("周常")]
		Weekly,
		[InspectorName("月常")]
		Monthly,
		[InspectorName("天赋")]
		Talent,
		[InspectorName("成就")]
		Achieve
	}

	public enum fateCardActiveAction
	{
		[InspectorName("房间退出")]
		RoomExit,
		[InspectorName("战斗结束")]
		BattleEnd
	}

	public enum instanceType
	{
		[InspectorName("无")]
		None,
		[InspectorName("主线")]
		Story,
		[InspectorName("星塔")]
		StarTower,
		[InspectorName("吸血鬼")]
		VampireSurvivor,
		[InspectorName("区域BOSS")]
		RegionBoss,
		[InspectorName("日常副本")]
		DailyInstance,
		[InspectorName("周常副本")]
		WeekBoss,
		[InspectorName("技能副本")]
		SkillInstance,
		[InspectorName("角色纹章")]
		CharGemInstance,
		[InspectorName("旅人对决")]
		TravelerDue
	}

	public enum activityDoubleRewardType
	{
		[InspectorName("无")]
		None,
		[InspectorName("双倍奖励")]
		Double,
		[InspectorName("三倍奖励")]
		Triple
	}

	public enum achievementCond
	{
		[InspectorName("[历史]达成成就X")]
		AchievementSpecific = 1,
		[InspectorName("[历史]达成X个成就")]
		AchievementTotal = 2,
		[InspectorName("战斗X次")]
		BattleTotal = 3,
		[InspectorName("拥有角色X")]
		CharacterAcquire = 5,
		[InspectorName("拥有X个品阶Y稀有度Z的角色")]
		CharacterAcquireQuantityRarityAndAdvancement = 6,
		[InspectorName("角色进阶X次")]
		CharacterAdvanceTotal = 7,
		[InspectorName("角色技能提升X次")]
		CharacterSkillUpTotal = 8,
		[InspectorName("角色X升级技能Y次")]
		CharacterSkillWithSpecificUpTotal = 9,
		[InspectorName("[历史]拥有角色X")]
		CharacterSpecific = 10,
		[InspectorName("[历史]角色升级到X级")]
		CharacterUpLevel = 11,
		[InspectorName("角色升级X次")]
		CharacterUpTotal = 12,
		[InspectorName("[历史]角色X突破到Y阶")]
		CharacterWithSpecificAdvance = 13,
		[InspectorName("[历史]角色X达到Y好感度")]
		CharacterWithSpecificAffinity = 14,
		[InspectorName("[历史]角色X升到Y级")]
		CharacterWithSpecificUpLevel = 15,
		[InspectorName("[历史]拥有X数量Y等级的角色")]
		CharactersWithSpecificLevelAndQuantity = 16,
		[InspectorName("[历史]拥有X数量Y等级Z属性的角色")]
		CharactersWithSpecificNumberLevelAndAttributes = 17,
		[InspectorName("[历史]角色X剧情")]
		CharactersWithSpecificPlot = 18,
		[InspectorName("[历史]拥有X数量Y进阶次数Z属性的角色")]
		CharactersWithSpecificQuantityAdvancementCountAndAttribute = 19,
		[InspectorName("[历史]拥有X数量Y稀有度的角色")]
		CharactersWithSpecificQuantityAndRarity = 20,
		[InspectorName("[历史]拥有X数量Y进阶次数Z稀有度的角色")]
		CharactersWithSpecificQuantityRarityAndAdvancement = 21,
		[InspectorName("[历史]拥有X数量Y等级Z稀有度的角色")]
		CharactersWithSpecificQuantityRarityAndLevel = 22,
		[InspectorName("[历史]聊天X次")]
		ChatTotal = 23,
		[InspectorName("通关X次难度Y的Z日常副本")]
		DailyInstanceClearSpecificDifficultyAndTotal = 24,
		[InspectorName("通关X次Y类型日常副本")]
		DailyInstanceClearSpecificTypeAndTotal = 25,
		[InspectorName("通关日常副本X次")]
		DailyInstanceClearTotal = 26,
		[InspectorName("[历史]特定日期")]
		DateSpecific = 27,
		[InspectorName("拥有星盘X")]
		DiscAcquire = 28,
		[InspectorName("拥有X个稀有度Y的星盘")]
		DiscAcquireSpecificQuantityAndRarity = 29,
		[InspectorName("拥有X个等级Y稀有度Z的星盘")]
		DiscAcquireQuantityLevelAndRarity = 30,
		[InspectorName("拥有X个品阶Y稀有度Z的星盘")]
		DiscAcquireQuantityPhaseAndRarity = 31,
		[InspectorName("拥有X个星级Y稀有度Z的星盘")]
		DiscAcquireQuantityStarAndRarity = 32,
		[InspectorName("星盘突破X次")]
		DiscLimitBreakTotal = 33,
		[InspectorName("星盘升阶X次")]
		DiscPromoteTotal = 34,
		[InspectorName("星盘强化X次")]
		DiscStrengthenTotal = 35,
		[InspectorName("[历史]拥有X个等级Y稀有度Z的星盘")]
		DiscWithSpecificQuantityLevelAndRarity = 36,
		[InspectorName("[历史]拥有X个品阶Y稀有度Z的星盘")]
		DiscWithSpecificQuantityPhaseAndRarity = 37,
		[InspectorName("[历史]拥有X个星级Y稀有度Z的星盘")]
		DiscWithSpecificQuantityStarAndRarity = 38,
		[InspectorName("抽卡X次没有获得SSR角色")]
		GachaCharacterNotSSRTotal = 40,
		[InspectorName("单次十连获得X个SSR角色")]
		GachaCharacterTenModeSSRTotal = 41,
		[InspectorName("抽取X次角色")]
		GachaCharacterTotal = 42,
		[InspectorName("单次十连获得X个Y稀有度的物品")]
		GachaTenModeAcquireQuantityAndRarityItems = 43,
		[InspectorName("抽卡X次")]
		GachaTotal = 44,
		[InspectorName("赠礼X次")]
		GiftGiveTotal = 45,
		[InspectorName("[历史]通关X层Y类型的无尽塔")]
		InfinityTowerClearSpecificFloor = 46,
		[InspectorName("通关无尽塔X次")]
		InfinityTowerClearTotal = 47,
		[InspectorName("新增X道具Y个")]
		ItemsAdd = 48,
		[InspectorName("消耗X道具Y个")]
		ItemsDeplete = 49,
		[InspectorName("合成X次")]
		ItemsProductTotal = 50,
		[InspectorName("登录X次")]
		LoginTotal = 51,
		[InspectorName("完成巅峰揭幕赛季X次")]
		QuestTravelerDuelChallengeTotal = 52,
		[InspectorName("[历史]达成手册任务X")]
		QuestTourGuideSpecific = 53,
		[InspectorName("达成X次Y类型任务")]
		QuestWithSpecificType = 55,
		[InspectorName("[历史]三星通关X种Y难度的区域")]
		RegionBossClearSpecificFullStarWithBossIdAndDifficulty = 56,
		[InspectorName("通关X次难度Y的Z地区")]
		RegionBossClearSpecificLevelWithDifficultyAndTotal = 57,
		[InspectorName("通关X次Y地区")]
		RegionBossClearSpecificTotal = 58,
		[InspectorName("通关地区X次")]
		RegionBossClearTotal = 59,
		[InspectorName("[历史]拥有X个等级Y的技能")]
		SkillsWithSpecificQuantityAndLevel = 60,
		[InspectorName("拥有角色皮肤X")]
		SkinAcquire = 61,
		[InspectorName("[历史]通关X类型Y关卡获得Z星数")]
		StageClearSpecificStars = 62,
		[InspectorName("[历史]通关旅行故事X")]
		StoryClear = 63,
		[InspectorName("[历史]达到X世界等级")]
		WorldClassSpecific = 71,
		[InspectorName("通关X次Y类型的区域")]
		RegionBossClearSpecificTypeWithTotal = 72,
		[InspectorName("[历史]完成X次Y角色的邀约")]
		CharactersWithSpecificDatingCount = 73,
		[InspectorName("完成X次角色邀约")]
		CharactersDatingTotal = 74,
		[InspectorName("吸血鬼赛季累计达到X分")]
		VampireSurvivorScoreTotal = 75,
		[InspectorName("指定吸血鬼关卡达到指定分数")]
		VampireSurvivorSpecificLevelWithSpecificScore = 76,
		[InspectorName("通关指定吸血鬼关卡X")]
		VampireSurvivorPassedSpecificLevel = 77,
		[InspectorName("角色X参与Y次星塔")]
		CharacterParticipateTowerNumber = 78,
		[InspectorName("角色X所有技能均达到Y级")]
		CharacterAllSkillReachSpecificLevel = 79,
		[InspectorName("通关吸血鬼X次")]
		VampireClearTotal = 81,
		[InspectorName("[历史]通关吸血鬼X次")]
		VampireWithSpecificClearTotal = 82,
		[InspectorName("完成委托X次")]
		AgentFinishTotal = 83,
		[InspectorName("[历史]完成委托X次")]
		AgentWithSpecificFinishTotal = 84,
		[InspectorName("在挖格子活动X中抵达Y层")]
		ActivityMiningEnterLayer = 86,
		[InspectorName("在挖格子活动X中破坏Y个Z类型的格子")]
		ActivityMiningDestroyGrid = 87,
		[InspectorName("当期BOSSRUSH累计星数达到X")]
		BossRushTotalStars = 88,
		[InspectorName("[历史]通关X个Y层的无尽塔")]
		InfinityTowerClearSpecificDifficultyAndTotal = 89,
		[InspectorName("通关技能副本X次")]
		SkillInstanceClearTotal = 90,
		[InspectorName("[历史]通关指定吸血鬼关卡X")]
		VampireSurvivorSpecificPassedLevel = 91,
		[InspectorName("[历史]通关X个Y难度的周常副本")]
		WeekBoosClearSpecificDifficultyAndTotal = 92,
		[InspectorName("NpcX达到Y好感度")]
		NpcAffinityWithSpecificLevel = 93,
		[InspectorName("[历史]角色X通关Y次星塔")]
		CharacterPassedWithSpecificTowerAndCount = 94,
		[InspectorName("总力战赛季累计达到X分")]
		JointDrillScoreTotal = 95,
		[InspectorName("通关纹章副本X次")]
		CharGemInstanceClearTotal = 104,
		[InspectorName("领取商店奖励X次")]
		DailyShopReceiveShopTotal = 105,
		[InspectorName("申请委托X次")]
		AgentApplyTotal = 106,
		[InspectorName("[历史]拥有星盘X")]
		DiscSpecific = 114,
		[InspectorName("[历史]通关故事集X")]
		StorySetClearSpecific = 116,
		[InspectorName("[历史]角色X提升Y技能到Z等级")]
		CharacterWithSpecificSkillAndLevel = 118,
		[InspectorName("[历史]拥有X个Y等级Z属性的星盘")]
		DiscWithSpecificQuantityLevelAndAttr = 119,
		[InspectorName("[历史]通关教学关卡X")]
		TutorialLevelClearSpecific = 120,
		[InspectorName("[历史]累计通关教学关卡X次")]
		TutorialLevelSpecificClearTotal = 121,
		[InspectorName("[历史]拥有X个Y品阶Z属性的星盘")]
		DiscWithSpecificQuantityPhaseAndAttr = 122,
		[InspectorName("通关X次Y难度的周常副本")]
		WeekBossClearTotal = 123,
		[InspectorName("[历史]猎影合围累计追捕X次")]
		TraceHuntTraceComplete = 159,
		[InspectorName("[历史]猎影合围累计协助讨伐X次")]
		TraceHuntAssistHunt = 160,
		[InspectorName("拥有后宅家具X")]
		DormFurnitureAcquire = 161,
		[InspectorName("[历史]收取后宅奖励X次")]
		DormRewardReceive = 162,
		[InspectorName("[历史]解锁后宅房间X")]
		DormUnlockRoom = 163,
		[InspectorName("放置后宅家具X")]
		DormPlaceFurniture = 164,
		[InspectorName("[历史]获得摸头奖励X次")]
		DormRoleInteractionReward = 165,
		[InspectorName("[历史]收集后宅X种家具")]
		DormFurnitureCollect = 166,
		[InspectorName("领取后宅X次奖励")]
		DormDailyReceiveReward = 171,
		[InspectorName("[历史]后宅给旅人赠礼X次")]
		DormSendGift = 172,
		[InspectorName("通关活动故事X")]
		ActivityStoryPass = 173,
		[InspectorName("[历史]尖兵陷阵对局X次")]
		SoldierClearTotal = 174,
		[InspectorName("[历史]尖兵陷阵X赛季对局Y次")]
		SoldierClearTotalWithSeason = 175,
		[InspectorName("[历史]尖兵陷阵X赛季到达Y段位")]
		SoldierSpecificRankWithSeason = 176,
		[InspectorName("保存X房间一次")]
		DormSaveRoom = 177,
		[InspectorName("客户端事件(Client)")]
		ClientReport = 200,
		[InspectorName("星塔战斗胜利X次Y类型房间")]
		TowerBattleTimes = 501,
		[InspectorName("星塔BOSS挑战最高奖励X次")]
		TowerBossChallengeSpecificHighRewardWithTotal = 502,
		[InspectorName("星塔Build特定角色X")]
		TowerBuildSpecificCharacter = 503,
		[InspectorName("星塔角色达到X次Y评分")]
		TowerBuildSpecificScoreWithTotal = 504,
		[InspectorName("通关X次全部角色类型Y的星塔")]
		TowerClearSpecificCharacterTypeWithTotal = 505,
		[InspectorName("通过任意X种Y难度的星塔")]
		TowerClearSpecificGroupIdAndDifficulty = 506,
		[InspectorName("通关X次难度Y的Z星塔组")]
		TowerClearSpecificLevelWithDifficultyAndTotal = 507,
		[InspectorName("星塔通关X次")]
		TowerClearTotal = 508,
		[InspectorName("[历史]进入X次Y类型星塔房间")]
		TowerEnterRoom = 509,
		[InspectorName("星塔房触发X次事件")]
		TowerEventTimes = 511,
		[InspectorName("星塔房获得X次命运卡")]
		TowerFateTimes = 512,
		[InspectorName("星塔获得X道具Y个")]
		TowerItemsGet = 513,
		[InspectorName("[历史]星塔X难度商店购买X次")]
		TowerSpecificDifficultyShopBuyTimes = 514,
		[InspectorName("完成星塔养成特定节点X解锁")]
		TowerGrowthSpecificNote = 515,
		[InspectorName("[历史]通关X次难度Y的Z星塔组")]
		TowerClearSpecificLevelWithDifficultyAndTotalHistory = 516,
		[InspectorName("[历史]星塔事典累计收集事件图鉴数量")]
		TowerBookWithSpecificEvent = 517,
		[InspectorName("[历史]星塔事典累计收集卡片图鉴数量")]
		TowerBookWithSpecificFateCard = 518,
		[InspectorName("[历史]星塔事典累计收集潜能图鉴数量")]
		TowerBookWithSpecificPotential = 520,
		[InspectorName("星塔获得X次难度Y以上评分Z的构筑")]
		TowerBuildSpecificDifficultyAndScoreWithTotal = 521,
		[InspectorName("[历史]星塔X难度使用强化器X次")]
		TowerSpecificDifficultyStrengthenMachineTotal = 522,
		[InspectorName("[历史]星塔X难度击杀boss总数X")]
		TowerSpecificDifficultyKillBossTotal = 524,
		[InspectorName("[历史]星塔事典累计收集角色X的潜能达到Y个")]
		TowerBookSpecificCharWithPotentialTotal = 525,
		[InspectorName("星塔角色X获得Y次Z评分构筑")]
		TowerBuildSpecificCharSpecificScoreWithTotal = 526,
		[InspectorName("[历史]完成星塔养成特定节点X解锁")]
		TowerGrowthWithSpecificNote = 527,
		[InspectorName("[历史]星塔命运卡重随X次")]
		TowerSpecificFateCardReRollTotal = 528,
		[InspectorName("[历史]星塔潜能重随X次")]
		TowerSpecificPotentialReRollTotal = 529,
		[InspectorName("[历史]星塔商店重随X次")]
		TowerSpecificShopReRollTotal = 530,
		[InspectorName("[历史]星塔音符激活X次")]
		TowerSpecificNoteActivateTotal = 531,
		[InspectorName("[历史]星塔累计获得X级音符等级")]
		TowerSpecificNoteLevelTotal = 532,
		[InspectorName("[历史]星塔新潜能加成X次")]
		TowerSpecificPotentialBonusTotal = 533,
		[InspectorName("[历史]星塔潜能幸运强化X次")]
		TowerSpecificPotentialLuckyTotal = 534,
		[InspectorName("[历史]星塔X难度商店折扣物品购买Y次")]
		TowerSpecificShopBuyDiscountTotal = 535,
		[InspectorName("[历史]星塔X难度协奏技能激活Y次")]
		TowerSpecificSecondarySkillActivateTotal = 536,
		[InspectorName("[历史]星塔X难度音符额外等级效果触发Y次")]
		TowerSpecificGetExtraNoteLvTotal = 537,
		[InspectorName("星塔扫荡X次")]
		TowerSweepTimes = 539,
		[InspectorName("[历史]星塔扫荡X次")]
		TowerSweepTotal = 540,
		[InspectorName("星塔参与X次Y成员")]
		TowerBattleWithPartner = 541
	}

	public enum activityAcceptCond
	{
		[InspectorName("[历史]达到X世界等级")]
		WorldClassSpecific = 71
	}

	public enum activityBreakoutCharUnlockCond
	{
		[InspectorName("在打砖块活动X中通关Y关卡")]
		ActivityBreakoutWinSpecificLevel = 117
	}

	public enum activityQuestCompleteCond
	{
		[InspectorName("体力消耗X点")]
		EnergyDeplete = 39,
		[InspectorName("新增X道具Y个")]
		ItemsAdd = 48,
		[InspectorName("消耗X道具Y个")]
		ItemsDeplete = 49,
		[InspectorName("登录X次")]
		LoginTotal = 51,
		[InspectorName("[历史]通关旅行故事X")]
		StoryClear = 63,
		[InspectorName("[历史]达到X世界等级")]
		WorldClassSpecific = 71,
		[InspectorName("在曲奇工坊活动X中的Y关卡中累计打包Z盒")]
		ActivityCookieLevelAccPackage = 96,
		[InspectorName("在曲奇工坊活动X中的关卡Y达到Z分")]
		ActivityCookieLevelScore = 97,
		[InspectorName("在曲奇工坊活动X中的Y模块中累计完成Z盒")]
		ActivityCookieTypeAccPackage = 98,
		[InspectorName("在曲奇工坊活动X中的Y模块中累计包装Z个饼干")]
		ActivityCookieTypeAccPackCookie = 99,
		[InspectorName("在曲奇工坊活动X中的Y模块中累计收集Z类型评价N次")]
		ActivityCookieTypeAccRhythm = 100,
		[InspectorName("在曲奇工坊活动X中的Y模块中累计挑战Z次")]
		ActivityCookieTypeChallenge = 101,
		[InspectorName("在活动X中累计达到Y分")]
		ActivityScore = 107,
		[InspectorName("活动类型AVG阅读X活动剧情第Y关")]
		ActivityTypeAvgReadWithSpecificIdAndLevelId = 108,
		[InspectorName("活动类型关卡通关X活动战斗关卡Y关")]
		ActivityTypeLevelPassedWithSpecificIdAndLevelId = 109,
		[InspectorName("活动类型关卡3星通关X活动战斗关卡Y关")]
		ActivityTypeLevel3StarPassedWithSpecificIdAndLevelId = 110,
		[InspectorName("活动类型关卡收集X活动战斗关卡Y类型关卡Z星")]
		ActivityTypeLevelStarWithSpecificIdAndLevelTypeTotal = 111,
		[InspectorName("活动类型关卡通关X活动战斗关卡Y关时A位置出场Z属性角色")]
		ActivityTypeLevelPassedWithSpecificIdAndLevelIdAndSpecificPositionAndCharElem = 112,
		[InspectorName("活动类型关卡挑战X活动战斗关卡Y次")]
		ActivityTypeLevelPassedSpecificIdTotal = 113,
		[InspectorName("剧情活动X中阅读Y剧情")]
		ActivityStoryReadStory = 124,
		[InspectorName("在打砖块活动X中的Y关卡Z秒内通关")]
		ActivityBreakoutWinWithinSeconds = 125,
		[InspectorName("在打砖块活动X中[单次]通关Y关卡剩余Z格血量")]
		ActivityBreakoutWinRemainHP = 126,
		[InspectorName("在打砖块活动X中[累计]击败Y个怪物")]
		ActivityBreakoutAccDefeatMonster = 127,
		[InspectorName("在打砖块活动X中[累计]击碎Y个砖块")]
		ActivityBreakoutAccBreakout = 128,
		[InspectorName("在打砖块活动X中[累计]收集Y个掉落物")]
		ActivityBreakoutAccDropCollect = 129,
		[InspectorName("在打砖块活动X中[累计]收集Y个Z类型的掉落物")]
		ActivityBreakoutAccSpecificDropCollect = 130,
		[InspectorName("在打砖块活动X中Y角色[累计]出战Z次")]
		ActivityBreakoutAccCharBattleTimes = 131,
		[InspectorName("在打砖块活动X中通关Y类型的所有关卡")]
		ActivityBreakoutWinAllSpecificTypeLevels = 132,
		[InspectorName("企鹅牌活动通关达到X分")]
		ActivityPenguinCardLevelPassedScore = 133,
		[InspectorName("企鹅牌活动通关X关卡Y星数")]
		ActivityPenguinCardLevelPassedWithStar = 134,
		[InspectorName("在豪礼抛物线X活动中累计投中Y个礼物")]
		ActivityThrowGiftAccHitGift = 135,
		[InspectorName("在豪礼抛物线X活动中累计达到Y分数")]
		ActivityThrowGiftAccScore = 136,
		[InspectorName("在豪礼抛物线X活动中累计投出Y个礼物")]
		ActivityThrowGiftAccThrowGift = 137,
		[InspectorName("在豪礼抛物线X活动中累计使用Y个道具")]
		ActivityThrowGiftAccUseItem = 138,
		[InspectorName("在豪礼抛物线X活动Y关卡中投中Z个礼物")]
		ActivityThrowGiftLevelHitGift = 139,
		[InspectorName("在豪礼抛物线X活动Y关卡中达到Z分数")]
		ActivityThrowGiftLevelScore = 140,
		[InspectorName("在豪礼抛物线X活动Y关卡中投出Z个礼物")]
		ActivityThrowGiftLevelThrowGift = 141,
		[InspectorName("在黄金矿工活动X中累计抓取Y次Z道具")]
		ActivityGoldenSpyAccPickItem = 142,
		[InspectorName("在黄金矿工活动X中累计最高得分达到Y分")]
		ActivityGoldenSpyAccMaxScore = 143,
		[InspectorName("在黄金矿工活动X中在Y关卡中通过Z层")]
		ActivityGoldenSpyPassFloorInSpecifiedLevel = 144,
		[InspectorName("在黄金矿工活动X中在Y分组累计最佳特工积分达到Z分")]
		ActivityGoldenSpyAccGroupMaxScore = 145,
		[InspectorName("在黄金矿工活动X中Y关卡达到Y分")]
		ActivityGoldenSpyGetScoreInSpecifiedLevel = 146,
		[InspectorName("在黄金矿工活动X中累计完成Y条局内任务")]
		ActivityGoldenSpyAccCompleteTask = 147,
		[InspectorName("在黄金矿工活动X中累计使用Y技能Z次")]
		ActivityGoldenSpyAccUseSkill = 148,
		[InspectorName("在企鹅牌活动X中通关达到Y分")]
		ActivityPenguinCardClearScore = 149,
		[InspectorName("在企鹅牌活动X中通关Y关卡达到Z星数")]
		ActivityPenguinCardClearStar = 150,
		[InspectorName("在企鹅牌活动X中累计达到Y分数")]
		ActivityPenguinCardTotalScore = 151,
		[InspectorName("冰激凌活动中累计完成X个订单")]
		ActivityIceCreamCumulativeOrder = 152,
		[InspectorName("冰激凌活动中单局达成完成X个订单")]
		ActivityIceCreamSingleOrder = 153,
		[InspectorName("冰激凌活动中累计达成分数X")]
		ActivityIceCreamCumulativeScore = 154,
		[InspectorName("冰激凌活动中完成关卡X")]
		ActivityIceCreamLevelPassed = 155,
		[InspectorName("冰激凌活动中累计使用道具X个")]
		ActivityIceCreamCumulativeUseItem = 156,
		[InspectorName("冰激凌活动中累计进入FEVER模式X次")]
		ActivityIceCreamCumulativeCombo = 157,
		[InspectorName("在自走棋活动X中累计达到Y分")]
		ActivitySoldierScore = 158,
		[InspectorName("算术跑酷活动中累计使用道具X个")]
		ActivityMathParkourCumulativeUseItem = 167,
		[InspectorName("算术跑酷活动中累计达成分数X")]
		ActivityMathParkourCumulativeScore = 168,
		[InspectorName("算术跑酷活动中完成关卡X")]
		ActivityMathParkourLevelPassed = 169,
		[InspectorName("在企鹅牌活动X中通关Y关卡Z难度")]
		ActivityPenguinCardClearDifficulty = 170,
		[InspectorName("通关活动故事X")]
		ActivityStoryPass = 173
	}

	public enum chatCond
	{
		[InspectorName("拥有角色X")]
		CharacterAcquire = 5,
		[InspectorName("[历史]拥有角色X")]
		CharacterSpecific = 10,
		[InspectorName("[历史]角色升级到X级")]
		CharacterUpLevel = 11,
		[InspectorName("[历史]角色X突破到Y阶")]
		CharacterWithSpecificAdvance = 13,
		[InspectorName("[历史]角色X达到Y好感度")]
		CharacterWithSpecificAffinity = 14,
		[InspectorName("[历史]聊天X次")]
		ChatTotal = 23,
		[InspectorName("[历史]特定日期")]
		DateSpecific = 27,
		[InspectorName("拥有星盘X")]
		DiscAcquire = 28,
		[InspectorName("赠礼X次")]
		GiftGiveTotal = 45,
		[InspectorName("登录X次")]
		LoginTotal = 51,
		[InspectorName("[历史]通关X类型Y关卡获得Z星数")]
		StageClearSpecificStars = 62,
		[InspectorName("[历史]达到X世界等级")]
		WorldClassSpecific = 71,
		[InspectorName("当期BOSSRUSH累计星数达到X")]
		BossRushTotalStars = 88,
		[InspectorName("[历史]拥有星盘X")]
		DiscSpecific = 114,
		[InspectorName("[历史]角色X提升Y技能到Z等级")]
		CharacterWithSpecificSkillAndLevel = 118
	}

	public enum handBookCond
	{
		[InspectorName("拥有角色X")]
		CharacterAcquire = 5,
		[InspectorName("[历史]拥有角色X")]
		CharacterSpecific = 10,
		[InspectorName("[历史]角色X突破到Y阶")]
		CharacterWithSpecificAdvance = 13,
		[InspectorName("新增X道具Y个")]
		ItemsAdd = 48,
		[InspectorName("拥有角色皮肤X")]
		SkinAcquire = 61,
		[InspectorName("[历史]通关旅行故事X")]
		StoryClear = 63,
		[InspectorName("[历史]通关故事集X")]
		StorySetClearSpecific = 116,
		[InspectorName("[历史]角色X提升Y技能到Z等级")]
		CharacterWithSpecificSkillAndLevel = 118,
		[InspectorName("拥有后宅家具X")]
		DormFurnitureAcquire = 161,
		[InspectorName("通关活动故事X")]
		ActivityStoryPass = 173
	}

	public enum jointDrillCond
	{
		[InspectorName("总力战赛季累计达到X分")]
		JointDrillScoreTotal = 95
	}

	public enum questAcceptCond
	{
		[InspectorName("[历史]达成手册任务X")]
		QuestTourGuideSpecific = 53,
		[InspectorName("[历史]达到X世界等级")]
		WorldClassSpecific = 71,
		[InspectorName("[历史]完成X次Y角色的邀约")]
		CharactersWithSpecificDatingCount = 73,
		[InspectorName("NpcX达到Y好感度")]
		NpcAffinityWithSpecificLevel = 93,
		[InspectorName("[历史]角色X通关Y次星塔")]
		CharacterPassedWithSpecificTowerAndCount = 94,
		[InspectorName("[历史]通关故事集X")]
		StorySetClearSpecific = 116,
		[InspectorName("[历史]通关教学关卡X")]
		TutorialLevelClearSpecific = 120,
		[InspectorName("[历史]累计通关教学关卡X次")]
		TutorialLevelSpecificClearTotal = 121,
		[InspectorName("[历史]星塔X难度商店购买X次")]
		TowerSpecificDifficultyShopBuyTimes = 514,
		[InspectorName("完成星塔养成特定节点X解锁")]
		TowerGrowthSpecificNote = 515,
		[InspectorName("[历史]星塔事典累计收集事件图鉴数量")]
		TowerBookWithSpecificEvent = 517,
		[InspectorName("[历史]星塔事典累计收集卡片图鉴数量")]
		TowerBookWithSpecificFateCard = 518,
		[InspectorName("[历史]星塔事典累计收集潜能图鉴数量")]
		TowerBookWithSpecificPotential = 520,
		[InspectorName("[历史]星塔X难度使用强化器X次")]
		TowerSpecificDifficultyStrengthenMachineTotal = 522,
		[InspectorName("[历史]星塔X难度击杀boss总数X")]
		TowerSpecificDifficultyKillBossTotal = 524,
		[InspectorName("[历史]星塔事典累计收集角色X的潜能达到Y个")]
		TowerBookSpecificCharWithPotentialTotal = 525,
		[InspectorName("[历史]完成星塔养成特定节点X解锁")]
		TowerGrowthWithSpecificNote = 527,
		[InspectorName("[历史]星塔命运卡重随X次")]
		TowerSpecificFateCardReRollTotal = 528,
		[InspectorName("[历史]星塔潜能重随X次")]
		TowerSpecificPotentialReRollTotal = 529,
		[InspectorName("[历史]星塔商店重随X次")]
		TowerSpecificShopReRollTotal = 530,
		[InspectorName("[历史]星塔音符激活X次")]
		TowerSpecificNoteActivateTotal = 531,
		[InspectorName("[历史]星塔累计获得X级音符等级")]
		TowerSpecificNoteLevelTotal = 532,
		[InspectorName("[历史]星塔新潜能加成X次")]
		TowerSpecificPotentialBonusTotal = 533,
		[InspectorName("[历史]星塔潜能幸运强化X次")]
		TowerSpecificPotentialLuckyTotal = 534,
		[InspectorName("[历史]星塔X难度商店折扣物品购买Y次")]
		TowerSpecificShopBuyDiscountTotal = 535,
		[InspectorName("[历史]星塔X难度协奏技能激活Y次")]
		TowerSpecificSecondarySkillActivateTotal = 536,
		[InspectorName("[历史]星塔X难度音符额外等级效果触发Y次")]
		TowerSpecificGetExtraNoteLvTotal = 537,
		[InspectorName("星塔参与X次Y成员")]
		TowerBattleWithPartner = 541
	}

	public enum questCompleteCond
	{
		[InspectorName("战斗X次")]
		BattleTotal = 3,
		[InspectorName("战斗X次Y成员")]
		BattlesTotalWithPartner = 4,
		[InspectorName("拥有X个品阶Y稀有度Z的角色")]
		CharacterAcquireQuantityRarityAndAdvancement = 6,
		[InspectorName("角色进阶X次")]
		CharacterAdvanceTotal = 7,
		[InspectorName("角色技能提升X次")]
		CharacterSkillUpTotal = 8,
		[InspectorName("角色X升级技能Y次")]
		CharacterSkillWithSpecificUpTotal = 9,
		[InspectorName("角色升级X次")]
		CharacterUpTotal = 12,
		[InspectorName("[历史]角色X突破到Y阶")]
		CharacterWithSpecificAdvance = 13,
		[InspectorName("[历史]角色X升到Y级")]
		CharacterWithSpecificUpLevel = 15,
		[InspectorName("[历史]拥有X数量Y等级Z属性的角色")]
		CharactersWithSpecificNumberLevelAndAttributes = 17,
		[InspectorName("[历史]拥有X数量Y进阶次数Z属性的角色")]
		CharactersWithSpecificQuantityAdvancementCountAndAttribute = 19,
		[InspectorName("[历史]拥有X数量Y等级Z稀有度的角色")]
		CharactersWithSpecificQuantityRarityAndLevel = 22,
		[InspectorName("[历史]聊天X次")]
		ChatTotal = 23,
		[InspectorName("通关X次难度Y的Z日常副本")]
		DailyInstanceClearSpecificDifficultyAndTotal = 24,
		[InspectorName("通关X次Y类型日常副本")]
		DailyInstanceClearSpecificTypeAndTotal = 25,
		[InspectorName("通关日常副本X次")]
		DailyInstanceClearTotal = 26,
		[InspectorName("拥有X个等级Y稀有度Z的星盘")]
		DiscAcquireQuantityLevelAndRarity = 30,
		[InspectorName("拥有X个品阶Y稀有度Z的星盘")]
		DiscAcquireQuantityPhaseAndRarity = 31,
		[InspectorName("拥有X个星级Y稀有度Z的星盘")]
		DiscAcquireQuantityStarAndRarity = 32,
		[InspectorName("星盘突破X次")]
		DiscLimitBreakTotal = 33,
		[InspectorName("星盘升阶X次")]
		DiscPromoteTotal = 34,
		[InspectorName("星盘强化X次")]
		DiscStrengthenTotal = 35,
		[InspectorName("[历史]拥有X个等级Y稀有度Z的星盘")]
		DiscWithSpecificQuantityLevelAndRarity = 36,
		[InspectorName("[历史]拥有X个品阶Y稀有度Z的星盘")]
		DiscWithSpecificQuantityPhaseAndRarity = 37,
		[InspectorName("[历史]拥有X个星级Y稀有度Z的星盘")]
		DiscWithSpecificQuantityStarAndRarity = 38,
		[InspectorName("体力消耗X点")]
		EnergyDeplete = 39,
		[InspectorName("抽卡X次")]
		GachaTotal = 44,
		[InspectorName("赠礼X次")]
		GiftGiveTotal = 45,
		[InspectorName("[历史]通关X层Y类型的无尽塔")]
		InfinityTowerClearSpecificFloor = 46,
		[InspectorName("通关无尽塔X次")]
		InfinityTowerClearTotal = 47,
		[InspectorName("新增X道具Y个")]
		ItemsAdd = 48,
		[InspectorName("消耗X道具Y个")]
		ItemsDeplete = 49,
		[InspectorName("合成X次")]
		ItemsProductTotal = 50,
		[InspectorName("登录X次")]
		LoginTotal = 51,
		[InspectorName("完成巅峰揭幕赛季X次")]
		QuestTravelerDuelChallengeTotal = 52,
		[InspectorName("[历史]达成手册任务X")]
		QuestTourGuideSpecific = 53,
		[InspectorName("达成X次Y类型任务")]
		QuestWithSpecificType = 55,
		[InspectorName("[历史]三星通关X种Y难度的区域")]
		RegionBossClearSpecificFullStarWithBossIdAndDifficulty = 56,
		[InspectorName("通关X次难度Y的Z地区")]
		RegionBossClearSpecificLevelWithDifficultyAndTotal = 57,
		[InspectorName("通关X次Y地区")]
		RegionBossClearSpecificTotal = 58,
		[InspectorName("通关地区X次")]
		RegionBossClearTotal = 59,
		[InspectorName("[历史]拥有X个等级Y的技能")]
		SkillsWithSpecificQuantityAndLevel = 60,
		[InspectorName("[历史]通关X类型Y关卡获得Z星数")]
		StageClearSpecificStars = 62,
		[InspectorName("[历史]通关旅行故事X")]
		StoryClear = 63,
		[InspectorName("通关X次巅峰秀场Y")]
		TrekkerVersusClearCount = 64,
		[InspectorName("通关巅峰秀场X指定Y词条")]
		TrekkerVersusClearWithSpecificAffix = 65,
		[InspectorName("通关X次难度Y的巅峰秀场Z")]
		TrekkerVersusClearWithSpecificDifficultyAndTotal = 66,
		[InspectorName("巅峰秀场X粉丝等级达到Y")]
		TrekkerVersusFansWithSpecificLevel = 67,
		[InspectorName("[历史]达到X世界等级")]
		WorldClassSpecific = 71,
		[InspectorName("通关X次Y类型的区域")]
		RegionBossClearSpecificTypeWithTotal = 72,
		[InspectorName("[历史]完成X次Y角色的邀约")]
		CharactersWithSpecificDatingCount = 73,
		[InspectorName("完成X次角色邀约")]
		CharactersDatingTotal = 74,
		[InspectorName("通关指定吸血鬼关卡X")]
		VampireSurvivorPassedSpecificLevel = 77,
		[InspectorName("角色X参与Y次星塔")]
		CharacterParticipateTowerNumber = 78,
		[InspectorName("角色X所有技能均达到Y级")]
		CharacterAllSkillReachSpecificLevel = 79,
		[InspectorName("通关吸血鬼X次")]
		VampireClearTotal = 81,
		[InspectorName("[历史]通关吸血鬼X次")]
		VampireWithSpecificClearTotal = 82,
		[InspectorName("完成委托X次")]
		AgentFinishTotal = 83,
		[InspectorName("[历史]完成委托X次")]
		AgentWithSpecificFinishTotal = 84,
		[InspectorName("在挖格子活动X中抵达Y层")]
		ActivityMiningEnterLayer = 86,
		[InspectorName("在挖格子活动X中破坏Y个Z类型的格子")]
		ActivityMiningDestroyGrid = 87,
		[InspectorName("当期BOSSRUSH累计星数达到X")]
		BossRushTotalStars = 88,
		[InspectorName("[历史]通关X个Y层的无尽塔")]
		InfinityTowerClearSpecificDifficultyAndTotal = 89,
		[InspectorName("通关技能副本X次")]
		SkillInstanceClearTotal = 90,
		[InspectorName("[历史]通关指定吸血鬼关卡X")]
		VampireSurvivorSpecificPassedLevel = 91,
		[InspectorName("[历史]通关X个Y难度的周常副本")]
		WeekBoosClearSpecificDifficultyAndTotal = 92,
		[InspectorName("NpcX达到Y好感度")]
		NpcAffinityWithSpecificLevel = 93,
		[InspectorName("[历史]角色X通关Y次星塔")]
		CharacterPassedWithSpecificTowerAndCount = 94,
		[InspectorName("在曲奇工坊活动X中的Y关卡中累计打包Z盒")]
		ActivityCookieLevelAccPackage = 96,
		[InspectorName("在曲奇工坊活动X中的关卡Y达到Z分")]
		ActivityCookieLevelScore = 97,
		[InspectorName("在曲奇工坊活动X中的Y模块中累计完成Z盒")]
		ActivityCookieTypeAccPackage = 98,
		[InspectorName("在曲奇工坊活动X中的Y模块中累计包装Z个饼干")]
		ActivityCookieTypeAccPackCookie = 99,
		[InspectorName("在曲奇工坊活动X中的Y模块中累计收集Z类型评价N次")]
		ActivityCookieTypeAccRhythm = 100,
		[InspectorName("在曲奇工坊活动X中的Y模块中累计挑战Z次")]
		ActivityCookieTypeChallenge = 101,
		[InspectorName("通关纹章副本X次")]
		CharGemInstanceClearTotal = 104,
		[InspectorName("领取商店奖励X次")]
		DailyShopReceiveShopTotal = 105,
		[InspectorName("申请委托X次")]
		AgentApplyTotal = 106,
		[InspectorName("在活动X中累计达到Y分")]
		ActivityScore = 107,
		[InspectorName("活动类型AVG阅读X活动剧情第Y关")]
		ActivityTypeAvgReadWithSpecificIdAndLevelId = 108,
		[InspectorName("活动类型关卡通关X活动战斗关卡Y关")]
		ActivityTypeLevelPassedWithSpecificIdAndLevelId = 109,
		[InspectorName("活动类型关卡3星通关X活动战斗关卡Y关")]
		ActivityTypeLevel3StarPassedWithSpecificIdAndLevelId = 110,
		[InspectorName("活动类型关卡收集X活动战斗关卡Y类型关卡Z星")]
		ActivityTypeLevelStarWithSpecificIdAndLevelTypeTotal = 111,
		[InspectorName("活动类型关卡通关X活动战斗关卡Y关时A位置出场Z属性角色")]
		ActivityTypeLevelPassedWithSpecificIdAndLevelIdAndSpecificPositionAndCharElem = 112,
		[InspectorName("活动类型关卡挑战X活动战斗关卡Y次")]
		ActivityTypeLevelPassedSpecificIdTotal = 113,
		[InspectorName("[历史]通关故事集X")]
		StorySetClearSpecific = 116,
		[InspectorName("[历史]角色X提升Y技能到Z等级")]
		CharacterWithSpecificSkillAndLevel = 118,
		[InspectorName("[历史]拥有X个Y等级Z属性的星盘")]
		DiscWithSpecificQuantityLevelAndAttr = 119,
		[InspectorName("[历史]通关教学关卡X")]
		TutorialLevelClearSpecific = 120,
		[InspectorName("[历史]累计通关教学关卡X次")]
		TutorialLevelSpecificClearTotal = 121,
		[InspectorName("[历史]拥有X个Y品阶Z属性的星盘")]
		DiscWithSpecificQuantityPhaseAndAttr = 122,
		[InspectorName("通关X次Y难度的周常副本")]
		WeekBossClearTotal = 123,
		[InspectorName("剧情活动X中阅读Y剧情")]
		ActivityStoryReadStory = 124,
		[InspectorName("在自走棋活动X中累计达到Y分")]
		ActivitySoldierScore = 158,
		[InspectorName("[历史]收取后宅奖励X次")]
		DormRewardReceive = 162,
		[InspectorName("[历史]解锁后宅房间X")]
		DormUnlockRoom = 163,
		[InspectorName("放置后宅家具X")]
		DormPlaceFurniture = 164,
		[InspectorName("[历史]获得摸头奖励X次")]
		DormRoleInteractionReward = 165,
		[InspectorName("[历史]收集后宅X种家具")]
		DormFurnitureCollect = 166,
		[InspectorName("领取后宅X次奖励")]
		DormDailyReceiveReward = 171,
		[InspectorName("[历史]后宅给旅人赠礼X次")]
		DormSendGift = 172,
		[InspectorName("通关活动故事X")]
		ActivityStoryPass = 173,
		[InspectorName("[历史]尖兵陷阵对局X次")]
		SoldierClearTotal = 174,
		[InspectorName("[历史]尖兵陷阵X赛季对局Y次")]
		SoldierClearTotalWithSeason = 175,
		[InspectorName("[历史]尖兵陷阵X赛季到达Y段位")]
		SoldierSpecificRankWithSeason = 176,
		[InspectorName("保存X房间一次")]
		DormSaveRoom = 177,
		[InspectorName("客户端事件(Client)")]
		ClientReport = 200,
		[InspectorName("星塔战斗胜利X次Y类型房间")]
		TowerBattleTimes = 501,
		[InspectorName("星塔BOSS挑战最高奖励X次")]
		TowerBossChallengeSpecificHighRewardWithTotal = 502,
		[InspectorName("星塔Build特定角色X")]
		TowerBuildSpecificCharacter = 503,
		[InspectorName("星塔角色达到X次Y评分")]
		TowerBuildSpecificScoreWithTotal = 504,
		[InspectorName("通关X次全部角色类型Y的星塔")]
		TowerClearSpecificCharacterTypeWithTotal = 505,
		[InspectorName("通过任意X种Y难度的星塔")]
		TowerClearSpecificGroupIdAndDifficulty = 506,
		[InspectorName("通关X次难度Y的Z星塔组")]
		TowerClearSpecificLevelWithDifficultyAndTotal = 507,
		[InspectorName("星塔通关X次")]
		TowerClearTotal = 508,
		[InspectorName("[历史]进入X次Y类型星塔房间")]
		TowerEnterRoom = 509,
		[InspectorName("进入星塔X次")]
		TowerEnterTotal = 510,
		[InspectorName("星塔房触发X次事件")]
		TowerEventTimes = 511,
		[InspectorName("星塔房获得X次命运卡")]
		TowerFateTimes = 512,
		[InspectorName("星塔获得X道具Y个")]
		TowerItemsGet = 513,
		[InspectorName("[历史]星塔X难度商店购买X次")]
		TowerSpecificDifficultyShopBuyTimes = 514,
		[InspectorName("完成星塔养成特定节点X解锁")]
		TowerGrowthSpecificNote = 515,
		[InspectorName("[历史]通关X次难度Y的Z星塔组")]
		TowerClearSpecificLevelWithDifficultyAndTotalHistory = 516,
		[InspectorName("[历史]星塔事典累计收集事件图鉴数量")]
		TowerBookWithSpecificEvent = 517,
		[InspectorName("[历史]星塔事典累计收集卡片图鉴数量")]
		TowerBookWithSpecificFateCard = 518,
		[InspectorName("[历史]星塔事典累计收集潜能图鉴数量")]
		TowerBookWithSpecificPotential = 520,
		[InspectorName("星塔获得X次难度Y以上评分Z的构筑")]
		TowerBuildSpecificDifficultyAndScoreWithTotal = 521,
		[InspectorName("[历史]星塔X难度使用强化器X次")]
		TowerSpecificDifficultyStrengthenMachineTotal = 522,
		[InspectorName("[历史]星塔X难度击杀boss总数X")]
		TowerSpecificDifficultyKillBossTotal = 524,
		[InspectorName("[历史]星塔事典累计收集角色X的潜能达到Y个")]
		TowerBookSpecificCharWithPotentialTotal = 525,
		[InspectorName("星塔角色X获得Y次Z评分构筑")]
		TowerBuildSpecificCharSpecificScoreWithTotal = 526,
		[InspectorName("[历史]完成星塔养成特定节点X解锁")]
		TowerGrowthWithSpecificNote = 527,
		[InspectorName("[历史]星塔命运卡重随X次")]
		TowerSpecificFateCardReRollTotal = 528,
		[InspectorName("[历史]星塔潜能重随X次")]
		TowerSpecificPotentialReRollTotal = 529,
		[InspectorName("[历史]星塔商店重随X次")]
		TowerSpecificShopReRollTotal = 530,
		[InspectorName("[历史]星塔音符激活X次")]
		TowerSpecificNoteActivateTotal = 531,
		[InspectorName("[历史]星塔累计获得X级音符等级")]
		TowerSpecificNoteLevelTotal = 532,
		[InspectorName("[历史]星塔新潜能加成X次")]
		TowerSpecificPotentialBonusTotal = 533,
		[InspectorName("[历史]星塔潜能幸运强化X次")]
		TowerSpecificPotentialLuckyTotal = 534,
		[InspectorName("[历史]星塔X难度商店折扣物品购买Y次")]
		TowerSpecificShopBuyDiscountTotal = 535,
		[InspectorName("[历史]星塔X难度协奏技能激活Y次")]
		TowerSpecificSecondarySkillActivateTotal = 536,
		[InspectorName("[历史]星塔X难度音符额外等级效果触发Y次")]
		TowerSpecificGetExtraNoteLvTotal = 537,
		[InspectorName("进入星塔X层")]
		TowerEnterFloor = 538,
		[InspectorName("星塔扫荡X次")]
		TowerSweepTimes = 539,
		[InspectorName("[历史]星塔扫荡X次")]
		TowerSweepTotal = 540,
		[InspectorName("星塔参与X次Y成员")]
		TowerBattleWithPartner = 541
	}

	public enum shopCond
	{
		[InspectorName("[历史]通关X类型Y关卡获得Z星数")]
		StageClearSpecificStars = 62,
		[InspectorName("[历史]达到X世界等级")]
		WorldClassSpecific = 71,
		[InspectorName("商店X前置商品Y售罄")]
		ShopPreGoodsSellOut = 85,
		[InspectorName("X活动Y商店Z物品售罄")]
		ActivityShopPreGoodsSellOut = 115
	}

	public enum towerCond
	{
		[InspectorName("[历史]通关故事集X")]
		StorySetClearSpecific = 116,
		[InspectorName("客户端事件(Client)")]
		ClientReport = 200,
		[InspectorName("星塔战斗胜利X次Y类型房间")]
		TowerBattleTimes = 501,
		[InspectorName("星塔BOSS挑战最高奖励X次")]
		TowerBossChallengeSpecificHighRewardWithTotal = 502,
		[InspectorName("星塔Build特定角色X")]
		TowerBuildSpecificCharacter = 503,
		[InspectorName("星塔角色达到X次Y评分")]
		TowerBuildSpecificScoreWithTotal = 504,
		[InspectorName("通关X次全部角色类型Y的星塔")]
		TowerClearSpecificCharacterTypeWithTotal = 505,
		[InspectorName("通过任意X种Y难度的星塔")]
		TowerClearSpecificGroupIdAndDifficulty = 506,
		[InspectorName("通关X次难度Y的Z星塔组")]
		TowerClearSpecificLevelWithDifficultyAndTotal = 507,
		[InspectorName("星塔通关X次")]
		TowerClearTotal = 508,
		[InspectorName("[历史]进入X次Y类型星塔房间")]
		TowerEnterRoom = 509,
		[InspectorName("进入星塔X次")]
		TowerEnterTotal = 510,
		[InspectorName("星塔房触发X次事件")]
		TowerEventTimes = 511,
		[InspectorName("星塔房获得X次命运卡")]
		TowerFateTimes = 512,
		[InspectorName("星塔获得X道具Y个")]
		TowerItemsGet = 513,
		[InspectorName("[历史]星塔X难度商店购买X次")]
		TowerSpecificDifficultyShopBuyTimes = 514,
		[InspectorName("完成星塔养成特定节点X解锁")]
		TowerGrowthSpecificNote = 515,
		[InspectorName("[历史]通关X次难度Y的Z星塔组")]
		TowerClearSpecificLevelWithDifficultyAndTotalHistory = 516,
		[InspectorName("[历史]星塔事典累计收集事件图鉴数量")]
		TowerBookWithSpecificEvent = 517,
		[InspectorName("[历史]星塔事典累计收集卡片图鉴数量")]
		TowerBookWithSpecificFateCard = 518,
		[InspectorName("[历史]星塔事典累计收集潜能图鉴数量")]
		TowerBookWithSpecificPotential = 520,
		[InspectorName("星塔获得X次难度Y以上评分Z的构筑")]
		TowerBuildSpecificDifficultyAndScoreWithTotal = 521,
		[InspectorName("[历史]星塔X难度使用强化器X次")]
		TowerSpecificDifficultyStrengthenMachineTotal = 522,
		[InspectorName("[历史]星塔X难度击杀boss总数X")]
		TowerSpecificDifficultyKillBossTotal = 524,
		[InspectorName("[历史]星塔事典累计收集角色X的潜能达到Y个")]
		TowerBookSpecificCharWithPotentialTotal = 525,
		[InspectorName("星塔角色X获得Y次Z评分构筑")]
		TowerBuildSpecificCharSpecificScoreWithTotal = 526,
		[InspectorName("[历史]完成星塔养成特定节点X解锁")]
		TowerGrowthWithSpecificNote = 527,
		[InspectorName("[历史]星塔命运卡重随X次")]
		TowerSpecificFateCardReRollTotal = 528,
		[InspectorName("[历史]星塔潜能重随X次")]
		TowerSpecificPotentialReRollTotal = 529,
		[InspectorName("[历史]星塔商店重随X次")]
		TowerSpecificShopReRollTotal = 530,
		[InspectorName("[历史]星塔音符激活X次")]
		TowerSpecificNoteActivateTotal = 531,
		[InspectorName("[历史]星塔累计获得X级音符等级")]
		TowerSpecificNoteLevelTotal = 532,
		[InspectorName("[历史]星塔新潜能加成X次")]
		TowerSpecificPotentialBonusTotal = 533,
		[InspectorName("[历史]星塔潜能幸运强化X次")]
		TowerSpecificPotentialLuckyTotal = 534,
		[InspectorName("[历史]星塔X难度商店折扣物品购买Y次")]
		TowerSpecificShopBuyDiscountTotal = 535,
		[InspectorName("[历史]星塔X难度协奏技能激活Y次")]
		TowerSpecificSecondarySkillActivateTotal = 536,
		[InspectorName("[历史]星塔X难度音符额外等级效果触发Y次")]
		TowerSpecificGetExtraNoteLvTotal = 537,
		[InspectorName("进入星塔X层")]
		TowerEnterFloor = 538,
		[InspectorName("星塔扫荡X次")]
		TowerSweepTimes = 539,
		[InspectorName("[历史]星塔扫荡X次")]
		TowerSweepTotal = 540,
		[InspectorName("星塔参与X次Y成员")]
		TowerBattleWithPartner = 541
	}

	public enum towerDefenseCond
	{
		[InspectorName("[历史]通关塔防关卡X")]
		TowerDefenseClear = 102,
		[InspectorName("[历史]塔防关卡X星级达到Y")]
		TowerDefenseClearSpecificStar
	}

	public enum vampireSurvivorCond
	{
		[InspectorName("吸血鬼赛季累计达到X分")]
		VampireSurvivorScoreTotal = 75,
		[InspectorName("指定吸血鬼关卡达到指定分数")]
		VampireSurvivorSpecificLevelWithSpecificScore = 76,
		[InspectorName("通关指定吸血鬼关卡X")]
		VampireSurvivorPassedSpecificLevel = 77,
		[InspectorName("[历史]通关指定吸血鬼关卡X")]
		VampireSurvivorSpecificPassedLevel = 91
	}

	public enum honorType
	{
		[InspectorName("普通")]
		Normal = 1,
		[InspectorName("默契")]
		Character,
		[InspectorName("组")]
		Group,
		[InspectorName("等级")]
		Levels,
		[InspectorName("后宅")]
		Dorm
	}

	public enum headType
	{
		[InspectorName("主角头像女")]
		HeroineAvatar = 1,
		[InspectorName("主角头像男")]
		HeroAvatar,
		[InspectorName("角色头像")]
		CharacterAvatar,
		[InspectorName("道具头像")]
		PropAvatar
	}

	public enum towerBookFateCardFinishType
	{
		[InspectorName("命运卡图鉴数量")]
		FateCardCount = 1,
		[InspectorName("收集特定命运卡")]
		FateCardCollect,
		[InspectorName("解锁特定命运卡")]
		FateCardUnlock
	}

	public enum towerBookPotentialCond
	{
		[InspectorName("星塔图鉴X角色解锁Y个潜能图鉴")]
		TowerBookCharPotentialQuantity = 401
	}

	public enum towerGrowthEffect
	{
		[InspectorName("客户端效果")]
		ClientEffect,
		[InspectorName("潜能重随")]
		ReRollPotential,
		[InspectorName("卡片重随")]
		ReRollFateCard,
		[InspectorName("命运之间解锁")]
		UnlockHighRiskRoom,
		[InspectorName("星塔扫荡解锁")]
		UnlockTowerSweep,
		[InspectorName("商店重随")]
		ReRollShopGoods,
		[InspectorName("获得新潜能等级加成")]
		GetNewPotentialLvUp,
		[InspectorName("强化机解锁")]
		UnlockStrengthenMachine,
		[InspectorName("强化机幸运强化")]
		LuckyStrengthenMachine,
		[InspectorName("强化机首次免费")]
		StrengthenMachineFirstFree,
		[InspectorName("强化机打折")]
		StrengthenMachineDiscount,
		[InspectorName("初始额外星塔币")]
		EnterTowerGetCoins,
		[InspectorName("额外掉落星塔币")]
		DropExtraGetCoins,
		[InspectorName("商店货物增加")]
		ShopGoodsIncrease,
		[InspectorName("商店打折货物增加")]
		ShopDiscountGoodsIncrease,
		[InspectorName("星塔额外产出")]
		TowerExtraReward,
		[InspectorName("初始额外卡片")]
		EnterTowerGetFateCard,
		[InspectorName("卡片掉落概率提高")]
		FateCardDropPropUp,
		[InspectorName("额外获得同系卡片")]
		DropExtraGetFateCard,
		[InspectorName("获得卡片权重提升")]
		GetFateCardWeightUp,
		[InspectorName("星塔产生票根提升")]
		TowerTicketProductionUp,
		[InspectorName("票根周获取上限提升")]
		TowerTicketLimitUp,
		[InspectorName("命运之间额外掉落")]
		HighRiskRoomExtraDrop,
		[InspectorName("增加复活次数")]
		AddResurrectionCount,
		[InspectorName("解锁命运卡")]
		UnlockFateCard,
		[InspectorName("BOSS房额外掉落音符")]
		BOSSExtraGetRunes,
		[InspectorName("额外SUB星盘槽位")]
		DiscExtraSubSlot,
		[InspectorName("星塔额外获得的音符数")]
		DropExtraGetRunes,
		[InspectorName("进入星塔获得音符")]
		EnterTowerGetRunes,
		[InspectorName("获得额外音符等级")]
		GetExtraRuneLevel,
		[InspectorName("潜能等级提升")]
		PotentialMaxLvUp,
		[InspectorName("随机额外事件")]
		RandomExtraEvent,
		[InspectorName("移除援护音符")]
		RemoveDropAssistantRunes,
		[InspectorName("潜能等级加成获得额外等级")]
		ExtraGetPotentialLvUp,
		[InspectorName("潜能等级加成选取次数扣除")]
		StrengthenPotentialLvUp,
		[InspectorName("强化强化机")]
		StrengthStrengthMachine
	}

	public enum vampireTalentEffect
	{
		[InspectorName("客户端效果")]
		ClientEffect,
		[InspectorName("命运卡选项提升")]
		FateCardSelectUp,
		[InspectorName("战斗获取命运卡")]
		BattleGetFateCard,
		[InspectorName("命运卡重随")]
		ReRollFateCard,
		[InspectorName("解锁特殊命运卡")]
		UnlockspecialFateCard,
		[InspectorName("战斗随机事件概率提升")]
		BattleRdmEventUp,
		[InspectorName("经验提升")]
		VampireExpUp,
		[InspectorName("激活掉落物")]
		ActiveDrop,
		[InspectorName("提升掉落物概率")]
		DropItemPropUp
	}

	public enum towerGrowthNodeType
	{
		[InspectorName("普通")]
		Normal = 1,
		[InspectorName("核心")]
		Core
	}

	public enum towerEventResType
	{
		[InspectorName("通用资源")]
		Common,
		[InspectorName("命运卡")]
		FateCard,
		[InspectorName("属性音符技能")]
		SubNoteSkill,
		[InspectorName("潜能")]
		Potential
	}

	public enum eventTypes
	{
		[InspectorName("未定义")]
		eUnKnown = 1,
		[InspectorName("通配符")]
		eWildCard = 2,
		[InspectorName("登录")]
		eLogin = 3,
		[InspectorName("完成任务")]
		eQuest = 4,
		[InspectorName("每日首次登录")]
		eDailyLogin = 5,
		[InspectorName("战斗相关事件")]
		eBattle = 6,
		[InspectorName("战斗星级相关事件")]
		eBattleStar = 7,
		[InspectorName("日常副本通关事件")]
		eDailyInstance = 8,
		[InspectorName("世界等级升级事件")]
		eWorldClassUpgrade = 9,
		[InspectorName("道具消耗")]
		eItemsDeplete = 10,
		[InspectorName("道具补充")]
		eItemsAdd = 11,
		[InspectorName("抽卡事件")]
		eGacha = 12,
		[InspectorName("角色经验变化")]
		eCharacterExpUp = 13,
		[InspectorName("地区boss关卡")]
		eRegionBoss = 14,
		[InspectorName("体力消耗")]
		eEnergyConsume = 15,
		[InspectorName("星盘获得事件")]
		eDiscAdd = 16,
		[InspectorName("星盘强化事件")]
		eDiscStrengthen = 17,
		[InspectorName("星盘升阶事件")]
		eDiscPromote = 18,
		[InspectorName("星盘突破事件")]
		eDiscLimitBreak = 19,
		[InspectorName("角色进阶事件")]
		eCharacterAdvance = 20,
		[InspectorName("角色技能升级事件")]
		eCharacterSkillUpgrade = 21,
		[InspectorName("获取新角色事件")]
		eCharacterAdd = 22,
		[InspectorName("角色升级事件")]
		eCharacterUpgrade = 23,
		[InspectorName("角色皮肤变更事件")]
		eCharacterSkinAdd = 24,
		[InspectorName("角色好感度事件")]
		eCharacterAffinity = 25,
		[InspectorName("角色完成剧情事件")]
		ePlot = 26,
		[InspectorName("达成成就")]
		eAchievement = 27,
		[InspectorName("旅人对决关卡")]
		eTravelerDuel = 28,
		[InspectorName("旅人对决等级升级")]
		eTravelerDuelLevelUp = 29,
		[InspectorName("进入副本")]
		eEnterInstance = 30,
		[InspectorName("溢出事件")]
		eOverflow = 31,
		[InspectorName("客户端事件(CLIENT)")]
		eClient = 200,
		[InspectorName("客户端事件[星塔复活]")]
		eTowerResurrection = 201
	}

	public enum elementType
	{
		[InspectorName("继承属性")]
		INHERIT,
		[InspectorName("水")]
		WE,
		[InspectorName("火")]
		FE,
		[InspectorName("地")]
		SE,
		[InspectorName("风")]
		AE,
		[InspectorName("光")]
		LE,
		[InspectorName("暗")]
		DE,
		[InspectorName("无")]
		NONE
	}

	public enum itemRarity
	{
		[InspectorName("史诗（彩）")]
		SSR = 1,
		[InspectorName("精英（橙）")]
		SR,
		[InspectorName("稀有（蓝）")]
		R,
		[InspectorName("优秀（绿）")]
		M,
		[InspectorName("普通（白）")]
		N
	}

	public enum monsterAIBranchFollowEventType
	{
		[InspectorName("无")]
		NONE,
		[InspectorName("沉睡指定id的AI")]
		DEACTIVE_CERTAIN_ID_AI,
		[InspectorName("激活指定id的AI")]
		ACTIVE_CERTAIN_ID_AI,
		[InspectorName("沉睡指定组id的AI")]
		DEACTIVE_CERTAIN_GROUPID_AI,
		[InspectorName("激活指定组id的AI")]
		ACTIVE_CERTAIN_GROUPID_AI,
		[InspectorName("执行指定id的AI")]
		EXECUTE_CERTAIN_ID_AI,
		[InspectorName("关闭指定id的AI")]
		CLOSE_CERTAIN_ID_AI,
		[InspectorName("开启指定id的AI")]
		OPEN_CERTAIN_ID_AI,
		[InspectorName("关闭指定组id的AI")]
		CLOSE_CERTAIN_GROUPID_AI,
		[InspectorName("开启指定组id的AI")]
		OPEN_CERTAIN_GROUPID_AI,
		[InspectorName("无视限制条件执行指定BranchID")]
		FORCE_EXECUTE_CERTAIN_ID_AI,
		[InspectorName("指定id的AI进入CD")]
		CERTAIN_ID_AI_BEGIN_CD,
		[InspectorName("指定BranchID释放次数清零")]
		CERTAIN_ID_AI_CLEAR_CASTSKILLTIME,
		[InspectorName("指定BranchID组释放次数清零")]
		CERTAIN_ID_GROUP_CLEAR_CASTSKILLTIME
	}

	public enum effectAttributeType
	{
		[InspectorName("无")]
		NONE = 0,
		[InspectorName("攻击力")]
		ATK = 1,
		[InspectorName("防御力")]
		DEF = 2,
		[InspectorName("生命上限")]
		MAXHP = 3,
		[InspectorName("命中")]
		HITRATE = 4,
		[InspectorName("回避")]
		EVD = 5,
		[InspectorName("暴击")]
		CRITRATE = 6,
		[InspectorName("暴击抵抗")]
		CRITRESIST = 7,
		[InspectorName("暴击伤害")]
		CRITPOWER_P = 8,
		[InspectorName("防御穿透")]
		PENETRATE = 9,
		[InspectorName("无视防御")]
		DEF_IGNORE = 10,
		[InspectorName("水系抗性")]
		WER = 11,
		[InspectorName("火系抗性")]
		FER = 12,
		[InspectorName("地系抗性")]
		SER = 13,
		[InspectorName("风系抗性")]
		AER = 14,
		[InspectorName("光系抗性")]
		LER = 15,
		[InspectorName("暗系抗性")]
		DER = 16,
		[InspectorName("水系伤害")]
		WEE = 17,
		[InspectorName("火系伤害")]
		FEE = 18,
		[InspectorName("地系伤害")]
		SEE = 19,
		[InspectorName("风系伤害")]
		AEE = 20,
		[InspectorName("光系伤害")]
		LEE = 21,
		[InspectorName("暗系伤害")]
		DEE = 22,
		[InspectorName("水系穿透")]
		WEP = 23,
		[InspectorName("火系穿透")]
		FEP = 24,
		[InspectorName("地系穿透")]
		SEP = 25,
		[InspectorName("风系穿透")]
		AEP = 26,
		[InspectorName("光系穿透")]
		LEP = 27,
		[InspectorName("暗系穿透")]
		DEP = 28,
		[InspectorName("无视水系伤害")]
		WEI = 29,
		[InspectorName("无视火系伤害")]
		FEI = 30,
		[InspectorName("无视地系伤害")]
		SEI = 31,
		[InspectorName("无视风系伤害")]
		AEI = 32,
		[InspectorName("无视光系伤害")]
		LEI = 33,
		[InspectorName("无视暗系伤害")]
		DEI = 34,
		[InspectorName("受到水系伤害")]
		WEERCD = 35,
		[InspectorName("受到火系伤害")]
		FEERCD = 36,
		[InspectorName("受到地系伤害")]
		SEERCD = 37,
		[InspectorName("受到风系伤害")]
		AEERCD = 38,
		[InspectorName("受到光系伤害")]
		LEERCD = 39,
		[InspectorName("受到暗系伤害")]
		DEERCD = 40,
		[InspectorName("重量")]
		WEIGHT = 41,
		[InspectorName("最大韧性")]
		TOUGHNESS_MAX = 42,
		[InspectorName("破韧效率")]
		TOUGHNESS_DAMAGE_ADJUST = 43,
		[InspectorName("护盾上限")]
		SHIELD_MAX = 44,
		[InspectorName("移动速度")]
		MOVESPEED = 46,
		[InspectorName("攻击速度")]
		ATKSPD_P = 47,
		[InspectorName("强度")]
		INTENSITY = 48,
		[InspectorName("造成伤害")]
		GENDMG = 49,
		[InspectorName("伤害值")]
		DMGPLUS = 50,
		[InspectorName("最终伤害")]
		FINALDMG = 51,
		[InspectorName("最终伤害值")]
		FINALDMGPLUS = 52,
		[InspectorName("受到所有伤害")]
		GENDMGRCD = 53,
		[InspectorName("受到伤害")]
		DMGPLUSRCD = 54,
		[InspectorName("弱点压制")]
		SUPPRESS = 55,
		[InspectorName("普攻伤害")]
		NORMALDMG = 56,
		[InspectorName("技能伤害")]
		SKILLDMG = 57,
		[InspectorName("绝招伤害")]
		ULTRADMG = 58,
		[InspectorName("其他伤害")]
		OTHERDMG = 59,
		[InspectorName("受到普攻伤害")]
		RCDNORMALDMG = 60,
		[InspectorName("受到技能伤害")]
		RCDSKILLDMG = 61,
		[InspectorName("受到绝招伤害")]
		RCDULTRADMG = 62,
		[InspectorName("受到其他伤害")]
		RCDOTHERDMG = 63,
		[InspectorName("印记伤害")]
		MARKDMG = 64,
		[InspectorName("受到印记伤害")]
		RCDMARKDMG = 65,
		[InspectorName("仆从伤害")]
		SUMMONDMG = 66,
		[InspectorName("受到仆从伤害")]
		RCDSUMMONDMG = 67,
		[InspectorName("衍生物伤害")]
		PROJECTILEDMG = 68,
		[InspectorName("受到衍生物伤害")]
		RCDPROJECTILEDMG = 69,
		[InspectorName("普攻暴击")]
		NORMALCRITRATE = 70,
		[InspectorName("技能暴击")]
		SKILLCRITRATE = 71,
		[InspectorName("绝招暴击")]
		ULTRACRITRATE = 72,
		[InspectorName("印记暴击")]
		MARKCRITRATE = 73,
		[InspectorName("仆从暴击")]
		SUMMONCRITRATE = 74,
		[InspectorName("衍生物暴击")]
		PROJECTILECRITRATE = 75,
		[InspectorName("其他暴击")]
		OTHERCRITRATE = 76,
		[InspectorName("普攻暴击伤害")]
		NORMALCRITPOWER = 77,
		[InspectorName("技能暴击伤害")]
		SKILLCRITPOWER = 78,
		[InspectorName("绝招暴击伤害")]
		ULTRACRITPOWER = 79,
		[InspectorName("印记暴击伤害")]
		MARKCRITPOWER = 80,
		[InspectorName("仆从暴击伤害")]
		SUMMONCRITPOWER = 81,
		[InspectorName("衍生物暴击伤害")]
		PROJECTILECRITPOWER = 82,
		[InspectorName("其他暴击伤害")]
		OTHERCRITPOWER = 83,
		[InspectorName("能量上限")]
		ENERGY_MAX = 84,
		[InspectorName("伤害倍率")]
		SKILL_INTENSITY = 85,
		[InspectorName("破韧专属易伤")]
		TOUGHNESS_BROKEN_DMG = 86,
		[InspectorName("护盾强效")]
		ADD_SHIELD_STRENGTHEN = 87,
		[InspectorName("受护盾效率")]
		BE_ADD_SHIELD_STRENGTHEN = 88,
		[InspectorName("普攻弱点压制")]
		NORMAL_SUPPRESS = 89,
		[InspectorName("技能弱点压制")]
		SKILL_SUPPRESS = 90,
		[InspectorName("绝招弱点压制")]
		ULTRA_SUPPRESS = 91,
		[InspectorName("印记弱点压制")]
		MARK_SUPPRESS = 92,
		[InspectorName("仆从弱点压制")]
		SUMMON_SUPPRESS = 93,
		[InspectorName("衍生物弱点压制")]
		PROJECTILE_SUPPRESS = 94,
		[InspectorName("其他弱点压制")]
		OTHER_SUPPRESS = 95,
		[InspectorName("环境修正")]
		ENV_AMEND = 96,
		[InspectorName("最大效果数量")]
		MAX = 97
	}

	public enum attributeFinialLimitType
	{
		[InspectorName("最终元素槽位伤害")]
		FINAL_ELEMENTTYPE_DAMAGETYPE_DMG = 1,
		[InspectorName("最终受到元素槽位伤害")]
		FINAL_ELEMENTTYPE_DAMAGETYPE_RCDDMG,
		[InspectorName("最终元素槽位暴击")]
		FINAL_ELEMENTTYPE_DAMAGETYPE_CRITRATE,
		[InspectorName("最终元素槽位暴击伤害")]
		FINAL_ELEMENTTYPE_DAMAGETYPE_CRITPOWER,
		[InspectorName("最终元素槽位弱点压制")]
		FINAL_ELEMENTTYPE_DAMAGETYPE_SUPPRESS,
		[InspectorName("最终元素槽位穿透")]
		FINAL_ELEMENTTYPE_DAMAGETYPE_EP,
		[InspectorName("最大数量")]
		MAX
	}

	public enum trigger
	{
		[InspectorName("无")]
		NONE = 0,
		[InspectorName("无条件")]
		NOTHING = 1,
		[InspectorName("击中时")]
		HITTING = 2,
		[InspectorName("被击中时")]
		BEHIT = 3,
		[InspectorName("击杀敌人时")]
		KILLENEMY = 4,
		[InspectorName("造成暴击时")]
		CRIT = 5,
		[InspectorName("释放技能时")]
		CASTSKILL = 6,
		[InspectorName("获得特定buff时")]
		GETBUFF = 7,
		[InspectorName("特定buff消失时")]
		REMOVEBUFF = 8,
		[InspectorName("入场时")]
		ENTERBATTLE = 9,
		[InspectorName("离场时")]
		LEAVEBATTLE = 10,
		[InspectorName("被暴击时")]
		BECRIT = 11,
		[InspectorName("开始换弹时")]
		BEGIN_RELOAD = 12,
		[InspectorName("换弹完成时")]
		FINISH_RELOAD = 13,
		[InspectorName("效果执行时")]
		EFFECT_EXECUTE = 18,
		[InspectorName("指定间隔触发")]
		CERTAIN_TIME_INTERVAL = 19,
		[InspectorName("技能释放完成时触发")]
		CASTSKILLEND = 20,
		[InspectorName("血量变化时")]
		HP_CHANGE = 21,
		[InspectorName("免疫死亡时触发")]
		ON_IMMUNE_DEAD = 22,
		[InspectorName("伤害会导致死亡时触发")]
		DAMAGE_CAUSE_DEAD = 23,
		[InspectorName("极限闪避时")]
		PERFECT_DODGE = 24,
		[InspectorName("战斗胜利时")]
		BATTLE_WIN = 25,
		[InspectorName("手动切换上场")]
		SWICH_PLAYER = 26,
		[InspectorName("击破所有护盾时")]
		TO_BREAK_ALLSHIELD = 27,
		[InspectorName("所有护盾被击破时")]
		BE_BREAK_ALLSHIELD = 28,
		[InspectorName("指定护盾被击破时")]
		BE_BREAK_CERTAINSHIELD = 29,
		[InspectorName("指定护盾正常消失时")]
		BE_FINISH_CERTAINSHIELD = 30,
		[InspectorName("破韧时")]
		BREAK_TOUGHNESS = 31,
		[InspectorName("触发印记时")]
		TRIGGER_MARK = 32,
		[InspectorName("大招能量变化时")]
		ULTIMATE_ENERGY_CHANGE = 33,
		[InspectorName("攻击时")]
		ATTACKING = 34,
		[InspectorName("被攻击时")]
		BEATTACK = 35,
		[InspectorName("仆从死亡时")]
		SUMMONED_DIED = 36,
		[InspectorName("召唤仆从时")]
		SUMMON = 37,
		[InspectorName("施加护盾时")]
		ADD_SHIELD = 38,
		[InspectorName("获得护盾时")]
		GET_SHIELD = 39,
		[InspectorName("进入战斗状态时")]
		IN_BATTLE_STATE = 40,
		[InspectorName("己方触发印记时")]
		ANY_ACTOR_TRIGGER_MARK = 41
	}

	public enum takeEffect
	{
		[InspectorName("无")]
		NONE,
		[InspectorName("默认")]
		DEFAULT,
		[InspectorName("生命高于")]
		HEALTHUP,
		[InspectorName("生命低于")]
		HEALTHDOWN,
		[InspectorName("携带IDBuff")]
		CARRYBUFFID,
		[InspectorName("携带组Buff")]
		CARRYBUFFGROUP,
		[InspectorName("携带标识Buff")]
		CARRYBUFFIDENTIFYING,
		[InspectorName("指定技能槽位")]
		SKILLSLOTTYPE,
		[InspectorName("指定伤害元素类型")]
		HITELEMENTTYPE,
		[InspectorName("指定攻击类型")]
		DISTANCETYPE,
		[InspectorName("指定角色元素类型")]
		ACTORELEMENTTYPE,
		[InspectorName("指定BUFFID")]
		CERTAINBUFFID,
		[InspectorName("指定BUFF组ID")]
		CERTAINBUFFGROUPID,
		[InspectorName("指定BUFF标识")]
		CERTAINBUFFTAG,
		[InspectorName("指定护盾ID")]
		CERTAINSHIELDID,
		[InspectorName("附近人数多于")]
		NEARBY_ACTOR_LARGE_OR_EQUAL,
		[InspectorName("附近人数少于")]
		NEARBY_ACTOR_LESS_OR_EQUAL,
		[InspectorName("指定技能ID")]
		CERTAIN_SKILL_ID,
		[InspectorName("有护盾")]
		HAVE_SHIELD,
		[InspectorName("无护盾")]
		NO_SHIELD,
		[InspectorName("不在场上")]
		LEAVE_STAGE,
		[InspectorName("同时命中敌人多于")]
		HIT_TARGET_MOREOREQUAL_THAN,
		[InspectorName("同时命中敌人少于")]
		HIT_TARGET_LESSOREQUAL_THAN,
		[InspectorName("BUFF叠加层数")]
		BUFF_NUM,
		[InspectorName("概率高于 ")]
		PROBOBILITY_UP,
		[InspectorName("指定关卡类型")]
		CERTAIN_LEVEL_TYPE,
		[InspectorName("指定效果ID")]
		CERTAIN_EFFECT_ID,
		[InspectorName("指定效果TAG")]
		CERTAIN_EFFECT_TAG,
		[InspectorName("指定怪物阶层")]
		CERTAIN_MONSTER_EPICTYPE,
		[InspectorName("间隔时间")]
		TIME_INTERVAL,
		[InspectorName("指定职业")]
		CHARACTER_JOBCLASS,
		[InspectorName("指定关卡主题")]
		ROGUELIKE_LEVELSTYLE,
		[InspectorName("指定怪物标签")]
		CERTAIN_MONSTER_TAG,
		[InspectorName("目标包含指定标签")]
		TARGET_CONTAIN_TAG,
		[InspectorName("伤害包含指定标签")]
		DAMAGE_CONTAIN_TAG,
		[InspectorName("与目标距离小于")]
		DISTANCE_LESSOREQUAL_THAN,
		[InspectorName("与目标距离大于")]
		DISTANCE_MOREOREQUAL_THAN,
		[InspectorName("指定阵营类型")]
		CERTAIN_FACTION_TYPE,
		[InspectorName("目标处于自己前方扇形范围内")]
		IN_FORWARDAREA,
		[InspectorName("指定伤害ID")]
		CERTAIN_HITDAMAGEID,
		[InspectorName("场上有友方召唤物")]
		HAVE_FRIENDLY_SUMMONS,
		[InspectorName("自己为主控角色")]
		SELF_BE_MIANCONTROL,
		[InspectorName("自己为支援角色")]
		SELF_BE_ASSISTANT,
		[InspectorName("指定元素类型的支援角色驻场")]
		CERTAIN_TYPE_ASSISTANT_IN_BATTLE,
		[InspectorName("指定印记元素类型")]
		CERTAIN_MARK_ELMENT_TYPE,
		[InspectorName("大招能量百分比大于等于")]
		ULTIMATE_ENERGY_MOREOREQUAL_THAN,
		[InspectorName("自己血量百分比高于目标")]
		SELF_HP_PERCENT_MOREOREQUAL_THAN,
		[InspectorName("大招能量百分比小于等于")]
		ULTIMATE_ENERGY_LESSOREQUAL_THAN,
		[InspectorName("是否处于破韧状态")]
		IS_TOUGHNESS_BROKEN,
		[InspectorName("非普攻伤害")]
		DAMAGE_NOT_NORMAL,
		[InspectorName("指定目标弱点元素类型")]
		WEAKELEMENTTYPE,
		[InspectorName("指定印记类型")]
		CERTAIN_MARK_TYPE,
		[InspectorName("是否主控角色")]
		BE_MIANCONTROL,
		[InspectorName("是否支援角色")]
		BE_ASSISTANT,
		[InspectorName("指定伤害类型")]
		CERTAIN_DAMAGETYPE,
		[InspectorName("支援角色驻场")]
		ASSISTANT_IN_BATTLE
	}

	public enum effectType
	{
		[InspectorName("状态属性修改")]
		STATE_CAHNGE = 1,
		[InspectorName("技能冷却当前时间")]
		CURRENTCD = 2,
		[InspectorName("技能冷却最大值")]
		CD = 3,
		[InspectorName("添加Buff")]
		ADDBUFF = 6,
		[InspectorName("提升技能等级")]
		ADD_SKILL_LV = 7,
		[InspectorName("提升技能等级至")]
		SET_SKILL_LV = 8,
		[InspectorName("免疫Buff")]
		IMM_BUFF = 9,
		[InspectorName("增加技能使用层数")]
		ADDSKILLAMOUNT = 10,
		[InspectorName("恢复技能最大使用层数")]
		RESUMSKILLAMOUNT = 11,
		[InspectorName("属性修改")]
		ATTR_FIX = 12,
		[InspectorName("移除BUFF")]
		REMOVE_BUFF = 13,
		[InspectorName("效果当前冷却")]
		EFFECT_CD_FIX = 14,
		[InspectorName("效果最大冷却")]
		EFFECT_MAX_CD_FIX = 15,
		[InspectorName("攻击不消耗子弹")]
		AMEND_NO_COST = 16,
		[InspectorName("免疫次数伤害")]
		DAMAGE_IMM_ACC = 17,
		[InspectorName("同时触发效果")]
		EFFECT_MUL = 18,
		[InspectorName("回复生命值")]
		EFFECT_HP_RECOVRY = 19,
		[InspectorName("即死")]
		KILL_IMMEDIATELY = 21,
		[InspectorName("延长已有Buff持续时长")]
		ADD_BUFF_DURATION_EXISTING = 22,
		[InspectorName("伤害元素类型扩展")]
		HIT_ELEMENT_TYPE_EXTEND = 23,
		[InspectorName("效果起效几率")]
		CHANGE_EFFECT_RATE = 24,
		[InspectorName("添加标签")]
		ADD_TAG = 25,
		[InspectorName("恢复生命值至")]
		EFFECT_HP_REVERTTO = 27,
		[InspectorName("生命吸取")]
		EFFECT_HP_ABSORB = 28,
		[InspectorName("调整Buff单实例叠加上限")]
		CHANGE_BUFF_LAMINATEDNUM = 29,
		[InspectorName("调整Buff持续时间")]
		CHANGE_BUFF_TIME = 30,
		[InspectorName("特殊属性修改")]
		SPECIAL_ATTR_FIX = 34,
		[InspectorName("弹夹修正")]
		AMMO_FIX = 35,
		[InspectorName("怪物属性修改")]
		MONSTER_ATTR_FIX = 36,
		[InspectorName("玩家属性修改")]
		PLAYER_ATTR_FIX = 37,
		[InspectorName("免疫死亡")]
		IMMUNE_DEAD = 38,
		[InspectorName("进入遮蔽表现")]
		ENTER_TRANSPARENT = 39,
		[InspectorName("无法恢复能量")]
		UNABLE_RECOVER_ENERGY = 40,
		[InspectorName("清除怪物分支cd")]
		CLEAR_MONSTER_AI_BRANCH_CD = 41,
		[InspectorName("添加护盾")]
		ADD_SHIELD = 42,
		[InspectorName("根据当前生命扣除血量")]
		REDUCE_HP_BY_CURRENTHP = 43,
		[InspectorName("根据最大生命扣除血量")]
		REDUCE_HP_BY_MAXHP = 44,
		[InspectorName("击中时附加属性修改")]
		HITTED_ADDITIONAL_ATTR_FIX = 45,
		[InspectorName("属性赋予")]
		ATTR_ASSIGNMENT = 46,
		[InspectorName("释放区域效果")]
		CAST_AREAEFFECT = 47,
		[InspectorName("释放被动技能")]
		PASSIVE_SKILL = 48,
		[InspectorName("免疫指定伤害id的伤害")]
		IMM_CERTAIN_HITDAMAGEID = 49,
		[InspectorName("特殊状态属性生效次数")]
		STATE_AMOUNT = 50,
		[InspectorName("掉落物拾取半径修正")]
		DROP_ITEM_PICKUP_RANGE_FIX = 51,
		[InspectorName("元素类型组合属性修改")]
		ELEMENTTYPE_ATTR_FIX = 52,
		[InspectorName("伤害类型组合属性修改")]
		DAMAGETYPE_ATTR_FIX = 53,
		[InspectorName("击中时附加元素类型组合属性修改")]
		HITTED_ADDITIONAL_ELEMENTTYPE_ATTR_FIX = 54,
		[InspectorName("击中时附加伤害类型组合属性修改")]
		HITTED_ADDITIONAL_DAMAGETYPE_ATTR_FIX = 55,
		[InspectorName("元素类型组合属性百分比修改")]
		ELEMENTTYPE_ATTR_PERCENT_FIX = 56,
		[InspectorName("伤害类型组合属性百分比修改")]
		DAMAGETYPE_ATTR_PERCENT_FIX = 57,
		[InspectorName("击中时附加元素类型组合属性百分比修改")]
		HITTED_ADDITIONAL_ELEMENTTYPE_ATTR_PERCENT_FIX = 58,
		[InspectorName("击中时附加伤害类型组合属性百分比修改")]
		HITTED_ADDITIONAL_DAMAGETYPE_ATTR_PERCENT_FIX = 59,
		[InspectorName("元素类型组合属性赋予")]
		ELEMENTTYPE_ATTR_ASSIGNMENT = 60,
		[InspectorName("伤害类型组合属性赋予")]
		DAMAGETYPE_ATTR_ASSIGNMENT = 61,
		[InspectorName("元素类型组合属性百分比赋予")]
		ELEMENTTYPE_ATTR_PERCENT_ASSIGNMENT = 62,
		[InspectorName("伤害类型组合属性百分比赋予")]
		DAMAGETYPE_ATTR_PERCENT_ASSIGNMENT = 63
	}

	public enum stateAttributeType
	{
		[InspectorName("无")]
		NONE,
		[InspectorName("混乱")]
		CHAOS,
		[InspectorName("次级混乱")]
		CHAOS_WEAKENED,
		[InspectorName("霸体")]
		SUA,
		[InspectorName("冰冻")]
		FROZEN,
		[InspectorName("次级冰冻")]
		FROZEN_WEAKENED,
		[InspectorName("眩晕")]
		STUN,
		[InspectorName("次级眩晕")]
		STUN_WEAKENED,
		[InspectorName("伤害免疫")]
		DAMAGE_IMM,
		[InspectorName("束缚")]
		BONDAGE,
		[InspectorName("次级束缚")]
		BONDAGE_WEAKENED,
		[InspectorName("无法选定")]
		SEARCHED_IMMUNITY,
		[InspectorName("隐藏模型")]
		HIDE_MODEL,
		[InspectorName("关闭阻挡")]
		CLOSE_MOVE_BLOCK,
		[InspectorName("潜行")]
		SNEAK,
		[InspectorName("无敌")]
		INVINCIBLE,
		[InspectorName("免疫即死")]
		IMMUNE_KILL,
		[InspectorName("禁疗")]
		CURE_IMM,
		[InspectorName("致盲")]
		BLINDNESS,
		[InspectorName("次级致盲")]
		BLINDNESS_WEAKENED,
		[InspectorName("沉睡")]
		SLEEP,
		[InspectorName("次级沉睡")]
		SLEEP_WEAKENED,
		[InspectorName("魅惑")]
		CHARM,
		[InspectorName("次级魅惑")]
		CHARM_WEAKENED,
		[InspectorName("恐惧")]
		TERROR,
		[InspectorName("次级恐惧")]
		TERROR_WEAKENED,
		[InspectorName("嘲讽")]
		TAUNT,
		[InspectorName("次级嘲讽")]
		TAUNT_WEAKENED,
		[InspectorName("沉默")]
		SILENCE,
		[InspectorName("次级沉默")]
		SILENCE_WEAKENED,
		[InspectorName("视野遮蔽")]
		REDUCE_FOV,
		[InspectorName("免疫控制")]
		IMMUNE_CONTROL,
		[InspectorName("隐匿")]
		HIDE_OUT,
		[InspectorName("未参战")]
		BATTLE_OUT,
		[InspectorName("濒死霸体")]
		DYINGSUA,
		[InspectorName("闪避穿越障碍物")]
		DODGE_CROSS_OBSTACLE,
		[InspectorName("穿透")]
		PENETRATE,
		[InspectorName("禁止疾跑")]
		FORBIDDEN_RUSH,
		[InspectorName("无双")]
		UNPARALLELED,
		[InspectorName("塔防")]
		INDEFENSE,
		[InspectorName("闪避")]
		DODGE,
		[InspectorName("破韧")]
		TOUGHNESS_BORKEN,
		[InspectorName("最大数量")]
		MAX
	}

	public enum playerAttributeType
	{
		[InspectorName("支援能量获取效率")]
		ADD_ENERGY,
		[InspectorName("主控能量获取效率")]
		FRONT_ADD_ENERGY,
		[InspectorName("吸血鬼掉落物吸附距离修正")]
		ADSORPTION_CHANGE,
		[InspectorName("最大效果数量")]
		MAX
	}

	public enum monsterAttributeType
	{
		[InspectorName("怪物AI分支CD")]
		MONSTER_AIBRANCH_CD,
		[InspectorName("最大效果数量")]
		MAX
	}

	public enum parameterType
	{
		[InspectorName("基础值")]
		BASE_VALUE = 1,
		[InspectorName("百分比")]
		PERCENTAGE,
		[InspectorName("绝对值")]
		ABSOLUTE_VALUE
	}

	public enum specifyType
	{
		[InspectorName("特定槽位")]
		SPECIFIC_SLOT = 1,
		[InspectorName("特定ID")]
		SPECIFIC_ID,
		[InspectorName("特定Tag")]
		SPECIFIC_TAG,
		[InspectorName("特定组")]
		SPECIFIC_GROUP,
		[InspectorName("全部")]
		ALL,
		[InspectorName("受击时减少1层")]
		BEDAMEGE_REDUCE,
		[InspectorName("当前护盾值为0减少1层")]
		SHIELDVALUE_ZERO
	}

	public enum itemStype
	{
		[InspectorName("资源")]
		Res = 1,
		[InspectorName("道具")]
		Item = 2,
		[InspectorName("角色")]
		Char = 3,
		[InspectorName("体力")]
		Energy = 4,
		[InspectorName("世界等级经验")]
		WorldRankExp = 5,
		[InspectorName("角色碎片")]
		CharShard = 6,
		[InspectorName("星盘")]
		Disc = 8,
		[InspectorName("天赋强化素材")]
		TalentStrengthen = 9,
		[InspectorName("星盘强化素材")]
		DiscStrengthen = 12,
		[InspectorName("星盘升阶素材")]
		DiscPromote = 13,
		[InspectorName("等级称号")]
		LevelHonor = 15,
		[InspectorName("补给箱")]
		TreasureBox = 17,
		[InspectorName("装备补给箱")]
		GearTreasureBox = 18,
		[InspectorName("属性音符技能")]
		SubNoteSkill = 19,
		[InspectorName("角色技能升级素材")]
		SkillStrengthen = 24,
		[InspectorName("角色升阶素材")]
		CharacterLimitBreak = 25,
		[InspectorName("月卡")]
		MonthlyCard = 30,
		[InspectorName("体力道具")]
		EnergyItem = 31,
		[InspectorName("批量使用自选包")]
		ComCYO = 32,
		[InspectorName("星盘自选包")]
		OutfitCYO = 33,
		[InspectorName("随机掉落包")]
		RandomPackage = 34,
		[InspectorName("纹章素材")]
		Equipment = 35,
		[InspectorName("命运卡")]
		FateCard = 37,
		[InspectorName("装备经验道具")]
		EquipmentExp = 38,
		[InspectorName("星盘突破素材")]
		DiscLimitBreak = 40,
		[InspectorName("潜能")]
		Potential = 41,
		[InspectorName("特殊潜能")]
		SpecificPotential = 42,
		[InspectorName("称号")]
		Honor = 43,
		[InspectorName("角色自选包")]
		CharacterYO = 44,
		[InspectorName("头像")]
		PlayHead = 45,
		[InspectorName("角色皮肤")]
		CharacterSkin = 46,
		[InspectorName("纪念体力道具")]
		SouvenirEnergyItem = 47,
		[InspectorName("纪录")]
		Build = 48,
		[InspectorName("棋子")]
		Chess = 49,
		[InspectorName("后宅称号")]
		DormHonor = 50,
		[InspectorName("后宅家具")]
		DormFurniture = 51,
		[InspectorName("后宅套件")]
		DormKit = 52,
		[InspectorName("后宅场景")]
		DormScene = 53,
		[InspectorName("后宅皮肤")]
		DormSkin = 54,
		[InspectorName("后宅房间")]
		DormRoom = 55,
		[InspectorName("后宅布局")]
		DormLayout = 56,
		[InspectorName("词元道具")]
		TokenItem = 57
	}

	public enum targetType
	{
		[InspectorName("场上全体对象")]
		AllActor = 1,
		[InspectorName("玩家场上角色")]
		Player,
		[InspectorName("玩家全队角色")]
		PlayerGroup,
		[InspectorName("所有敌方怪物")]
		AllMonster,
		[InspectorName("所有陷阱")]
		AllTrap
	}

	public enum MonsterPosition
	{
		[InspectorName("近战")]
		Melee = 1,
		[InspectorName("远程")]
		Remote
	}

	public enum chapterType
	{
		[InspectorName("主线")]
		Mainline = 1,
		[InspectorName("支线")]
		Branchline,
		[InspectorName("活动")]
		Activity
	}

	public enum levelType
	{
		[InspectorName("主线")]
		Mainline = 1,
		[InspectorName("肉鸽")]
		FixedRoguelike,
		[InspectorName("区域领主")]
		RegionBoss,
		[InspectorName("旅人对决")]
		TravelerDuel,
		[InspectorName("星塔")]
		StarTower,
		[InspectorName("全部")]
		All,
		[InspectorName("剧情活动")]
		ActivityLevels,
		[InspectorName("周本BOSS")]
		WeeklyCopies,
		[InspectorName("吸血鬼")]
		VampireInstance,
		[InspectorName("无尽塔")]
		InfinityTower,
		[InspectorName("bossrush")]
		ScoreBoss,
		[InspectorName("总力战")]
		JointDrill,
		[InspectorName("卡带副本")]
		SkillInstance,
		[InspectorName("日常副本")]
		DailyInstance,
		[InspectorName("装备副本")]
		EquipmentInstance,
		[InspectorName("猎影合围")]
		TraceHunt
	}

	public enum levelEliteType
	{
		[InspectorName("通用")]
		Common = 1,
		[InspectorName("仅普通本")]
		Normal,
		[InspectorName("仅精英本")]
		Elite
	}

	public enum RegionType
	{
		[InspectorName("常规模式")]
		NormalRegion = 1,
		[InspectorName("真格模式")]
		HardCoreRegion
	}

	public enum factionRelationship
	{
		[InspectorName("友善")]
		Friendly = 1,
		[InspectorName("中立")]
		Neutrality,
		[InspectorName("敌对")]
		UnFriendly
	}

	public enum monsterSubType
	{
		[InspectorName("普通怪物")]
		Monster = 1,
		[InspectorName("陷阱")]
		Trap
	}

	public enum dropMode
	{
		[InspectorName("依次掉落")]
		Sequential = 1,
		[InspectorName("圆桌")]
		RoundTable
	}

	public enum weightMode
	{
		[InspectorName("放回")]
		Return = 1,
		[InspectorName("不放回")]
		Leave
	}

	public enum achievementType
	{
		[InspectorName("探索世界")]
		Others = 1,
		[InspectorName("摘星征途")]
		StarTower,
		[InspectorName("战果累累")]
		Battle,
		[InspectorName("百炼成金")]
		Growing,
		[InspectorName("社交网络")]
		SocialMedia,
		[InspectorName("总览（暂未使用）")]
		Overview
	}

	public enum questCompleteCondClient
	{
		[InspectorName("不被指定技能击中击杀指定怪物(Client)")]
		KillMonsterWithoutHitBySkill = 1,
		[InspectorName("不击杀指定怪物时击杀指定怪物(Client)")]
		KillMonsterWithoutKillSpecifiedMonster = 2,
		[InspectorName("与看板角色交互(Client)")]
		InteractL2D = 3,
		[InspectorName("一次攻击击杀X个怪物,限定Y角色完成(Client)")]
		KillMonsterWithOneAttack = 4,
		[InspectorName("X角色暴击(Client)")]
		CritCount = 6,
		[InspectorName("累计释放某个类型技能X次(Client)")]
		CastSkillTypeCount = 5,
		[InspectorName("释放Id为X的技能(Client)")]
		CastSkillCount = 7,
		[InspectorName("X角色触发极限闪避(Client)")]
		ExtremDodgeCount = 8,
		[InspectorName("消灭X级别的怪物,限定Y角色(Client)")]
		KillMonsterClass = 9,
		[InspectorName("触发X系印记(Client)")]
		TriggerTagElement = 10,
		[InspectorName("单次对敌伤害达到X点(Client)")]
		OneHitDamage = 11,
		[InspectorName("以血量低于x%状态通关(Client)")]
		ClearLevelWithHPBelow = 12,
		[InspectorName("累计击杀带有TAG[X]的怪物,限定Y角色(Client)")]
		KillMonsterWithTag = 13,
		[InspectorName("累计击杀X只MonsterSkin[Y]")]
		KillMonsterWithSkin = 14,
		[InspectorName("高达-破坏高达双手并击杀高达")]
		GaoDa_001 = 1305101,
		[InspectorName("高达-被高达的光束炮击中")]
		GaoDa_002 = 1305102,
		[InspectorName("高达-无伤击杀高达")]
		GaoDa_003 = 1305103,
		[InspectorName("野猪-中断万猪冲锋技能")]
		JiaMianYeZhu_001 = 1000501,
		[InspectorName("野猪-不被小猪攻击到")]
		JiaMianYeZhu_002 = 1000502,
		[InspectorName("野猪-单次万猪冲锋技能内被小野猪命中X次以上")]
		JiaMianYeZhu_003 = 1000503,
		[InspectorName("野猪-无伤击杀野猪王")]
		JiaMianYeZhu_004 = 1000504,
		[InspectorName("半身树-消灭半身树召唤的花苞X次")]
		BanShenShu_001 = 1050101,
		[InspectorName("半身树-不消灭花苞击杀半身树")]
		BanShenShu_002 = 1050102,
		[InspectorName("半身树-半身树死亡时场上有活着的土拨鼠")]
		BanShenShu_003 = 1050103,
		[InspectorName("半身树-无伤击杀半身树")]
		BanShenShu_004 = 1050104,
		[InspectorName("史莱姆王-阻止小史莱姆合体成史莱姆王")]
		ShiLaiMuWang_001 = 5008101,
		[InspectorName("史莱姆王-被史莱姆王击飞")]
		ShiLaiMuWang_002 = 5008102,
		[InspectorName("史莱姆王-在小史莱姆合体后，不被连环波浪命中")]
		ShiLaiMuWang_003 = 5008103,
		[InspectorName("史莱姆王-10S内击杀全部分裂出的中史莱姆和小史莱姆")]
		ShiLaiMuWang_004 = 5008104,
		[InspectorName("史莱姆王-中断史莱姆的滑行技能")]
		ShiLaiMuWang_005 = 5008105,
		[InspectorName("火塔楼-无伤击杀火塔楼")]
		HuoTaLou_001 = 5051101,
		[InspectorName("火塔楼-通过极限闪避躲过火塔楼的砸地板")]
		HuoTaLou_002 = 5051102,
		[InspectorName("鲨鲨-不被暗影毒池影响的情况下击败鲨鲨")]
		ShaSha_001 = 5050101,
		[InspectorName("鲨鲨-打断一次BOSS狂暴")]
		ShaSha_002 = 5050102,
		[InspectorName("鲨鲨-被地面水域减速累计X秒")]
		ShaSha_003 = 5050103,
		[InspectorName("跳舞机-无伤击败跳舞机")]
		TiaoWuJi_001 = 5052101,
		[InspectorName("跳舞机-遇到俄罗斯方块")]
		TiaoWuJi_002 = 5052102,
		[InspectorName("跳舞机-一场战斗中触发极限闪避到达X次")]
		TiaoWuJi_003 = 5052103,
		[InspectorName("跳舞机-10S内被跳舞机命中X次")]
		TiaoWuJi_004 = 5052104,
		[InspectorName("大罐子-在破韧状态下死亡")]
		DaGuanZi_001 = 5053101,
		[InspectorName("大罐子-小罐子形态下死亡")]
		DaGuanZi_002 = 5053102,
		[InspectorName("厨师-一场战斗中，场上刀叉数量到X")]
		ChuShi_001 = 5054101,
		[InspectorName("厨师-厨师没能收回任何一把刀叉")]
		ChuShi_002 = 5054102,
		[InspectorName("厨师-破坏场上刀叉X个")]
		ChuShi_003 = 5054103,
		[InspectorName("三剑客-跳过2阶段")]
		SanJianKe_001 = 5016101,
		[InspectorName("三剑客-3个变速刺客在间隔XX秒内被先后击杀")]
		SanJianKe_002 = 5016102,
		[InspectorName("繁荣实体-不被冲锋命中情况下击败BOSS")]
		FanRonShiTi_001 = 1001201,
		[InspectorName("繁荣实体-一场战斗中，被冲锋命中N次")]
		FanRonShiTi_002 = 1001202,
		[InspectorName("繁荣实体-中断繁荣实体的大招释放")]
		FanRonShiTi_003 = 1001203,
		[InspectorName("小高达-无伤击败BOSS")]
		FanRonShiTi_004 = 1001204,
		[InspectorName("小高达-无伤击败小高达")]
		XiaoGaoDa_001 = 1306101,
		[InspectorName("小高达-被小高达的三连冲锋全部命中")]
		XiaoGaoDa_002 = 1306102,
		[InspectorName("小高达-在小高达释放天降正义期间击杀BOSS")]
		XiaoGaoDa_003 = 1306103,
		[InspectorName("大阴影-击杀大阴影时，场上没有其他小怪存活")]
		DaYinYing_001 = 5010101,
		[InspectorName("大阴影-无伤击败大阴影")]
		DaYinYing_002 = 5010102,
		[InspectorName("通过旅人对决猫眼XX难度(系统难度）")]
		MaoYanLvRenBoss_001 = 7002101,
		[InspectorName("自选词条达到XX分通过旅人对决猫眼")]
		MaoYanLvRenBoss_002 = 7002102,
		[InspectorName("单局战斗内被猫眼击中XX次并成功击杀猫眼")]
		MaoYanLvRenBoss_003 = 7002103,
		[InspectorName("单场战斗内，保持与密涅瓦距离小于4M超过X秒钟")]
		MiNieWaZhuxian_001 = 1304101,
		[InspectorName("蜂鸟-在蜂鸟放大招期间前往大招区域的中心")]
		FengNiao_001 = 1551001,
		[InspectorName("蜂鸟-单场战斗中成功极限闪避蜂鸟的360度激光X次")]
		FengNiao_002 = 1551002,
		[InspectorName("蜂鸟-没有受到来自小蜂鸟与蜂鸟花的伤害")]
		FengNiao_003 = 1551003,
		[InspectorName("风草-最高难度下全场未被任何龙卷风命中")]
		FengCao_001 = 1651001,
		[InspectorName("风草-Boss处于大招期间被破韧")]
		FengCao_002 = 1651002,
		[InspectorName("风草-击败Boss时受到的伤害次数小于X")]
		FengCao_003 = 1651003,
		[InspectorName("风草-击败Boss时没有受到任何伤害")]
		FengCao_004 = 1651004,
		[InspectorName("自选词条最高分通过 旅人对决 - 火垂")]
		HuoChuiLvRenBoss_001 = 7003101,
		[InspectorName("在挑战模式下单场战斗使火垂破韧 x 次")]
		HuoChuiLvRenBoss_002 = 7003102,
		[InspectorName("在挑战模式下火垂热力阶段期间不受到伤害")]
		HuoChuiLvRenBoss_003 = 7003103,
		[InspectorName("自选词条最高分通过 旅人对决 - 花原")]
		HuaYuanLvRenBoss_001 = 7002201,
		[InspectorName("在雾中没有受到来自花原的伤害")]
		HuaYuanLvRenBoss_002 = 7002202,
		[InspectorName("挑战模式下通过 旅人对决 - 花原")]
		HuaYuanLvRenBoss_003 = 7002203,
		[InspectorName("猩猩-中断X次猩猩的爬行")]
		XingXing_001 = 5001101,
		[InspectorName("猩猩-在没有受到来自下落攻击伤害的条件下，击败1次猩猩")]
		XingXing_002 = 5001102,
		[InspectorName("累计消灭任意召唤物X个")]
		CanCha_001 = 5055101,
		[InspectorName("餐叉猪-不击杀小餐具情况下击杀BOSS")]
		CanCha_002 = 5055102,
		[InspectorName("餐叉猪-在X分钟内，击败餐叉猪")]
		CanCha_003 = 5055103,
		[InspectorName("不使用支援技和支援绝招完成肉鸽塔")]
		CharCommon_01 = 10001,
		[InspectorName("累计释放绝招X次")]
		CharCommon_02 = 10002,
		[InspectorName("累计释放支援技和支援绝招X次")]
		CharCommon_03 = 10003,
		[InspectorName("一个技能或绝招杀死X个以上敌人")]
		CharCommon_04 = 10004,
		[InspectorName("不使用闪避完成一次BOSS战")]
		CharCommon_05 = 10005,
		[InspectorName("不使用技能，必杀及支援技，支援绝招完成肉鸽塔")]
		CharCommon_06 = 10006,
		[InspectorName("指定角色在主控位完成X次战斗")]
		CharCommon_07 = 10007,
		[InspectorName("触发火系印记XX次")]
		CharCommon_08 = 10008,
		[InspectorName("触发水系印记XX次")]
		CharCommon_09 = 10009,
		[InspectorName("触发风系印记XX次")]
		CharCommon_10 = 10010,
		[InspectorName("触发暗系印记XX次")]
		CharCommon_11 = 10011,
		[InspectorName("触发光系印记XX次")]
		CharCommon_12 = 10012,
		[InspectorName("使用3名近战角色完成一次build")]
		CharCommon_13 = 10013,
		[InspectorName("使用3名远程角色完成一次build")]
		CharCommon_14 = 10014,
		[InspectorName("使用3名半C完成一次build")]
		CharCommon_15 = 10015,
		[InspectorName("使用3名辅助角色完成一次build")]
		CharCommon_16 = 10016,
		[InspectorName("使用3名C完成一次build")]
		CharCommon_17 = 10017,
		[InspectorName("第一次触发属性压制（红字伤害）")]
		CharCommon_18 = 10018,
		[InspectorName("连续触发X次暴击伤害")]
		CharCommon_19 = 10019,
		[InspectorName("无伤通过星塔")]
		CharCommon_20 = 10020,
		[InspectorName("通过星塔时剩余血量低于10%")]
		CharCommon_21 = 10021,
		[InspectorName("触发极限闪避XX次")]
		CharCommon_22 = 10022,
		[InspectorName("使用初始3名角色通关X难度的星塔")]
		CharCommon_23 = 10023,
		[InspectorName("使用3名火系角色完成build X次")]
		CharCommon_24 = 10024,
		[InspectorName("使用3名水系角色完成build X次")]
		CharCommon_25 = 10025,
		[InspectorName("使用3名光系角色完成build X次")]
		CharCommon_26 = 10026,
		[InspectorName("使用3名风系角色完成build X次")]
		CharCommon_27 = 10027,
		[InspectorName("使用3名暗系角色完成build X次")]
		CharCommon_28 = 10028,
		[InspectorName("指定难度，限定时间")]
		CharCommon_29 = 10029,
		[InspectorName("秒杀怪物累计XX次")]
		CharCommon_30 = 10030,
		[InspectorName("在build中获得指定角色所有潜能")]
		CharCommon_31 = 10031,
		[InspectorName("连续X次攻击不暴击")]
		CharCommon_32 = 10032,
		[InspectorName("单技能击杀N只怪物")]
		Amber_01 = 10301,
		[InspectorName("X秒内连续重置技能冷却")]
		Amber_02 = 10302,
		[InspectorName("普攻同时命中X个及以上目标")]
		Amber_03 = 10303,
		[InspectorName("作为援护角色时眩晕目标X次")]
		Amber_04 = 10304,
		[InspectorName("使用大招消灭任意首领")]
		Amber_05 = 10305,
		[InspectorName("使用大招命中且未消灭小怪")]
		Amber_06 = 10306,
		[InspectorName("连续普攻N次不换弹")]
		Amber_07 = 10307,
		[InspectorName("连续进行10次强化普攻")]
		Kasimira_01 = 10801,
		[InspectorName("一个支援技能连续命中同一敌人X次")]
		Kasimira_02 = 10802,
		[InspectorName("连续装弹N次")]
		Kasimira_03 = 10803,
		[InspectorName("连续N次不消耗弹药")]
		Kasimira_04 = 10804,
		[InspectorName("10秒内连续轰炸20次（触发2次潜能29）")]
		Kasimira_05 = 10805,
		[InspectorName("单次绝招对同一个目标命中N次")]
		Kasimira_06 = 10806,
		[InspectorName("连续眩晕目标X秒")]
		Kasimira_07 = 10807,
		[InspectorName("10秒内连续使用5次技能")]
		CatsEye_01 = 11401,
		[InspectorName("单个支援技杀死3名敌人")]
		CatsEye_02 = 11402,
		[InspectorName("单次风墙挡住X次子弹")]
		Ann_01 = 12301,
		[InspectorName("丰臀和所有友方角色同时在场作战累计X秒")]
		Ann_02 = 12302,
		[InspectorName("风墙被敌方子弹累计击破X次")]
		Ann_03 = 12303,
		[InspectorName("通过风墙累计击飞X次目标")]
		Ann_04 = 12304,
		[InspectorName("绝招累计摧毁X个飞行道具")]
		Ann_05 = 12305,
		[InspectorName("驾驶火狼累计奔跑100米")]
		Ann_06 = 12306,
		[InspectorName("风暴同时击飞3个及以上敌人，累计N次")]
		Ann_07 = 12307,
		[InspectorName("单次绝招累计触发N次风系印记")]
		Sandy_01 = 11201,
		[InspectorName("35秒内连续释放两次绝招")]
		Sandy_02 = 11202,
		[InspectorName("单次援护技造成10次及以上伤害")]
		Sandy_03 = 11203,
		[InspectorName("（风刃）累计击杀X个远处目标（>N米）")]
		Sandy_04 = 11204,
		[InspectorName("花瓣飞镖（X秒内）全部命中目标")]
		Hanahara_01 = 11901,
		[InspectorName("单次绝招期间，花原所有分身累计造成X次伤害")]
		Hanahara_02 = 11902,
		[InspectorName("单次技能期间，向日葵飞镖累计飞行X米")]
		Hanahara_03 = 11903,
		[InspectorName("单次技能期间，连续两次投掷向日葵飞镖的距离大于X米")]
		Hanahara_04 = 11904,
		[InspectorName("单次技能期间，花瓣飞镖累计造成X次伤害")]
		Hanahara_05 = 11905,
		[InspectorName("第一次触发摔跤")]
		Iris_01 = 11101,
		[InspectorName("书包累计抡死X名敌人")]
		Iris_02 = 11102,
		[InspectorName("5秒内对同一个目标造成N次伤害")]
		Iris_03 = 11103,
		[InspectorName("3秒内冻住5个敌人")]
		Iris_04 = 11104,
		[InspectorName("支援技范围内始终有3个及以上敌人")]
		Iris_05 = 11105,
		[InspectorName("暴风雪内存在友方角色累计100秒")]
		Iris_06 = 11106,
		[InspectorName("主控技急冻箭头一次命中N个敌人")]
		Iris_07 = 11107,
		[InspectorName("持续狂化30秒")]
		Freesia_01 = 12501,
		[InspectorName("单次狂化状态下消灭20个敌人")]
		Freesia_02 = 12502,
		[InspectorName("累计触发碎冰N次")]
		Freesia_03 = 12503,
		[InspectorName("2秒内对同一个目标造成N次伤害")]
		Freesia_04 = 12504,
		[InspectorName("支援角色驻场时间累计10分钟")]
		Freesia_05 = 12505,
		[InspectorName("旋风斩期间累计移动X米")]
		Freesia_06 = 12506,
		[InspectorName("单次旋风斩期间造成X次伤害")]
		Freesia_07 = 12507,
		[InspectorName("累计生成X朵冰花")]
		Freesia_08 = 12508,
		[InspectorName("累计消灭离自己距离超过X米的敌人Y个")]
		Donut_01 = 13001,
		[InspectorName("累计触发碎冰N次")]
		Donut_02 = 13002,
		[InspectorName("宠物消灭敌人XX个")]
		Donut_03 = 13003,
		[InspectorName("一次射击命中N个不同的目标")]
		Donut_04 = 13004,
		[InspectorName("战斗中连续60秒没有进行移动（战斗开始计时，战斗结束）")]
		Donut_05 = 13005,
		[InspectorName("绝招箭雨持续超过1X秒")]
		Donut_06 = 13006,
		[InspectorName("涟漪或波浪累计杀死敌人X个")]
		Teresa_01 = 12701,
		[InspectorName("任意友方角色连续在水域中超过X秒（测极限")]
		Teresa_02 = 12702,
		[InspectorName("特丽莎2秒内连续获得5次护盾")]
		Teresa_03 = 12703,
		[InspectorName("特丽莎生成的护盾连续存在30秒")]
		Teresa_04 = 12704,
		[InspectorName("特丽莎生成的护盾在1秒内破损")]
		Teresa_05 = 12705,
		[InspectorName("咖喱棒同时经过5个及以上的敌人和2个友方角色")]
		Teresa_06 = 12706,
		[InspectorName("一次雷圈对X名敌人产生影响")]
		LinJing_01 = 11701,
		[InspectorName("使用麒麟杀死BOSS")]
		LinJing_02 = 11702,
		[InspectorName("主控技能雷击对同一个目标连续暴击X次")]
		LinJing_03 = 11703,
		[InspectorName("璟麟的单次释放主控技能消灭X个及以上目标(极限测试")]
		LinJing_04 = 11704,
		[InspectorName("璟麟5秒内连续眩晕同一个目标3次")]
		LinJing_05 = 11705,
		[InspectorName("场上璟麟支援技召唤的雷圈数量大于等于3个")]
		LinJing_06 = 11706,
		[InspectorName("璟麟在2秒内消灭任意2个相互距离30米及以上的敌人")]
		LinJing_07 = 11707,
		[InspectorName("在单次技能期间承受XX点伤害")]
		Tilia_01 = 10701,
		[InspectorName("飞盾累计眩晕不同的目标X个")]
		Tilia_02 = 10702,
		[InspectorName("利用疾跑消灭X个敌人")]
		Tilia_03 = 10703,
		[InspectorName("利用主控技能免疫伤害累计X次")]
		Tilia_04 = 10704,
		[InspectorName("飞盾累计弹射1000次")]
		Tilia_05 = 10705,
		[InspectorName("缇莉娅为主控施加的护盾，未被打破累计Y次")]
		Tilia_06 = 10706,
		[InspectorName("单次技能使敌人持续击飞5秒")]
		Minerva_01 = 13201,
		[InspectorName("单次使用大招只杀死一名非BOSS敌人")]
		Minerva_02 = 13202,
		[InspectorName("普攻最后一段消灭敌人累计X个")]
		Minerva_03 = 13203,
		[InspectorName("支援技累计给X个敌人挂满4层星星")]
		Minerva_04 = 13204,
		[InspectorName("支援技（在挥洒星星时）直接消灭5个及以上敌人，累计X次")]
		Minerva_05 = 13205,
		[InspectorName("绝招大乱斗时自己或者主控角色也加入到混战中，累计参战100秒")]
		Minerva_06 = 13206,
		[InspectorName("使用火垂大招击杀高达BOSS（改投放）")]
		Firefly_01 = 11501,
		[InspectorName("10秒内对单个敌人造成100HIT")]
		Firefly_02 = 11502,
		[InspectorName("处于主控时强化普攻期间不使用闪避（1轮）")]
		Firefly_03 = 11503,
		[InspectorName("一次技能变形期间触发了N次印记")]
		Firefly_04 = 11504,
		[InspectorName("闪避期间累计消灭N个敌人（火垂本体）")]
		Firefly_05 = 11505,
		[InspectorName("火垂累计发射了1000发浮游刃")]
		Firefly_06 = 11506,
		[InspectorName("绝招单次射击命中N个敌人，累计N次")]
		Firefly_07 = 11507,
		[InspectorName("使用主控技暗影三连斩累计穿过N个敌人")]
		Firenze_01 = 11001,
		[InspectorName("主控情况下，累计发动联动攻击N次「普攻5+技能+潜能」")]
		Firenze_02 = 11002,
		[InspectorName("翡冷翠累计召唤N个暗影分身「主控+支援」")]
		Firenze_03 = 11003,
		[InspectorName("暗影分身通过暴击累计击杀N个的敌人「主控+支援」")]
		Firenze_04 = 11004,
		[InspectorName("单次绝招寂灭收割法阵生成时内部有超过10个敌人（生成的瞬间判断）")]
		Firenze_05 = 11005,
		[InspectorName("单次绝招寂灭收割累计造成50Hit，累计触发N次")]
		Firenze_06 = 11006,
		[InspectorName("雾雨的自爆幽灵累计被击杀X次")]
		Mistique_01 = 13501,
		[InspectorName("大头幽灵击杀眩晕的敌人X次")]
		Mistique_02 = 13502,
		[InspectorName("主控角色累计在幽灵之门中战斗X秒")]
		Mistique_03 = 13503,
		[InspectorName("（单个）自爆幽灵一次爆炸击杀6个敌人")]
		Mistique_04 = 13504,
		[InspectorName("绝招午夜幽灵所有攻击全部都命中敌人，累计X次")]
		Mistique_05 = 13505,
		[InspectorName("支援技幽灵之门累计生成X个自爆幽灵")]
		Mistique_06 = 13506,
		[InspectorName("暗影交错单次攻击命中9个以上敌人，累计X次")]
		Coronis_01 = 11801,
		[InspectorName("单轮暗影交错技能触发20次以上暗印记")]
		Coronis_02 = 11802,
		[InspectorName("骨牢禁锢成功击破X个敌人的韧性")]
		Coronis_03 = 11803,
		[InspectorName("骨牢禁锢成功拉扯敌人累计X次")]
		Coronis_04 = 11804,
		[InspectorName("通过「暗影飞镰」累计击杀敌人X次")]
		Coronis_05 = 11805,
		[InspectorName("绝招「寂灭收割」最终横斩累计击杀X名敌人")]
		Coronis_06 = 11806,
		[InspectorName("火蝴蝶连续存在20秒")]
		Hibiscus_01 = 12601,
		[InspectorName("一次惊吓魔盒同时恐惧X个小怪")]
		Hibiscus_02 = 12602,
		[InspectorName("返回的魔术帽命中X个目标，累计X次")]
		Hibiscus_03 = 12603,
		[InspectorName("累计生成X顶魔术帽")]
		Hibiscus_04 = 12604,
		[InspectorName("1秒内连续分裂出6只火蝶（包括潜能22分裂和死亡分裂）")]
		Hibiscus_05 = 12605,
		[InspectorName("凤凰蛋累计眩晕X个敌人")]
		Hibiscus_06 = 12606,
		[InspectorName("同时存在5只灰蝶时，主控角色连续N次伤害不暴击")]
		Hibiscus_07 = 12607,
		[InspectorName("N秒内旋转X圈（技能第1段）；执行Y次")]
		ShiMiao_01 = 11301,
		[InspectorName("N秒内施放技能第2段9次")]
		ShiMiao_02 = 11302,
		[InspectorName("伤害提升Buff叠满50层（潜能25）；执行Y次")]
		ShiMiao_03 = 11303,
		[InspectorName("累计发射最大号水剑500次")]
		ShiMiao_04 = 11304,
		[InspectorName("单次存续期间触发X次寒冷效果；执行Y次")]
		ShiMiao_05 = 11305,
		[InspectorName("单次绝招横扫期间，共命中X个目标；执行Y次")]
		ShiMiao_06 = 11306,
		[InspectorName("用绝招累计击杀500个「冰冻」状态目标")]
		ShiMiao_07 = 11307,
		[InspectorName("累计10秒内对敌人施加30次暗系印记")]
		Cosette_01 = 14201
	}

	public enum areaEffectOverLimitType
	{
		[InspectorName("替换")]
		Replace = 1,
		[InspectorName("不生成")]
		NotGenerate
	}

	public enum CharVoiceType
	{
		[InspectorName("抽卡首次获得")]
		GachaFirstGet = 1,
		[InspectorName("抽卡重复获得")]
		GachaGetAgain,
		[InspectorName("主界面L2D交互")]
		MainUITouch,
		[InspectorName("主界面CGL2D交互")]
		MainUICGTouch
	}

	public enum currencyType
	{
		[InspectorName("现金")]
		Cash = 1,
		[InspectorName("道具")]
		Item,
		[InspectorName("免费")]
		Free
	}

	public enum mallPackageRefreshType
	{
		[InspectorName("不刷新")]
		None,
		[InspectorName("日")]
		Day,
		[InspectorName("周")]
		Week,
		[InspectorName("月")]
		Month
	}

	public enum TitleType
	{
		[InspectorName("前缀")]
		Prefix = 1,
		[InspectorName("后缀")]
		Suffix
	}

	public enum VoResType
	{
		[InspectorName("主控角色")]
		MainCharacter = 1,
		[InspectorName("助战角色")]
		SupportCharacter,
		[InspectorName("队内随机角色")]
		RandomCharacter,
		[InspectorName("特定角色")]
		SpecificCharacter
	}

	public enum AttackHintType
	{
		[InspectorName("无")]
		Null,
		[InspectorName("常驻型")]
		Always,
		[InspectorName("技能激活型")]
		SkillOn
	}

	public enum AssistOnStageType
	{
		[InspectorName("进攻登场")]
		Attack = 1,
		[InspectorName("防御登场")]
		Defend
	}

	public enum AssistOnStageOrientation
	{
		[InspectorName("无")]
		None,
		[InspectorName("主控同向")]
		Same,
		[InspectorName("朝向主控")]
		LookAt,
		[InspectorName("背对主控")]
		BackOn
	}

	public enum errorShowType
	{
		[InspectorName("默认弹窗")]
		Window = 1,
		[InspectorName("飘字")]
		Tips,
		[InspectorName("返回登录")]
		Relogin
	}

	public enum activityType
	{
		[InspectorName("无")]
		None = 0,
		[InspectorName("周期任务组")]
		PeriodicQuest = 1,
		[InspectorName("登录奖励")]
		LoginReward = 2,
		[InspectorName("挖格子")]
		Mining = 3,
		[InspectorName("曲奇工坊")]
		Cookie = 4,
		[InspectorName("塔防")]
		TowerDefense = 5,
		[InspectorName("试玩")]
		Trial = 6,
		[InspectorName("总力战")]
		JointDrill = 7,
		[InspectorName("CG")]
		CG = 8,
		[InspectorName("关卡")]
		Levels = 9,
		[InspectorName("Avg")]
		Avg = 10,
		[InspectorName("活动任务")]
		Task = 11,
		[InspectorName("商店")]
		Shop = 12,
		[InspectorName("广告页")]
		Advertise = 13,
		[InspectorName("BD兑换活动")]
		BDConvert = 14,
		[InspectorName("打砖块")]
		Breakout = 15,
		[InspectorName("巅峰秀场")]
		TrekkerVersus = 16,
		[InspectorName("初见活动")]
		Story = 17,
		[InspectorName("企鹅牌")]
		PenguinCard = 18,
		[InspectorName("豪礼抛物线")]
		ThrowGift = 19,
		[InspectorName("黄金矿工")]
		GoldenSpy = 20,
		[InspectorName("双倍奖励")]
		Double = 21,
		[InspectorName("复刻活动")]
		HistoryStory = 22,
		[InspectorName("冰激凌餐车")]
		IceCream = 23,
		[InspectorName("关注社交媒体")]
		FollowSocialMedia = 24,
		[InspectorName("自走棋")]
		Soldier = 25,
		[InspectorName("回流活动")]
		Reengagement = 26,
		[InspectorName("速度与机擎")]
		MathParkour = 27,
		[InspectorName("邮箱绑定")]
		MailBind = 28,
		[InspectorName("活动剧情")]
		NewStory = 30,
		[InspectorName("付费签到")]
		MallLogin = 31,
		[InspectorName("签到奖励")]
		SignIn = 32
	}

	public enum activityOpenType
	{
		[InspectorName("无")]
		None,
		[InspectorName("初始开放")]
		Original,
		[InspectorName("日期开放")]
		Date,
		[InspectorName("触发条件开放")]
		Trigger
	}

	public enum activityEndType
	{
		[InspectorName("无")]
		None,
		[InspectorName("不结束")]
		NoLimit,
		[InspectorName("指定日期关闭")]
		Date,
		[InspectorName("开启一段时间后关闭")]
		TimeLimit
	}

	public enum activityPreLimit
	{
		[InspectorName("无")]
		None,
		[InspectorName("世界等级")]
		WorldClass,
		[InspectorName("主线进度")]
		questLimit
	}

	public enum specialAttributeType
	{
		[InspectorName("无")]
		NONE,
		[InspectorName("当前生命值")]
		HP,
		[InspectorName("当前韧性值")]
		TOUGHNESS_V,
		[InspectorName("当前护盾值")]
		SHIELD_V,
		[InspectorName("大招能量")]
		ENERGY,
		[InspectorName("最大效果数量")]
		MAX
	}

	public enum addressBookType
	{
		[InspectorName("无")]
		None,
		[InspectorName("抽卡角色")]
		Character,
		[InspectorName("npc")]
		NPC,
		[InspectorName("群聊")]
		GroupChat,
		[InspectorName("公众号")]
		OfficialAccount
	}

	public enum chatTriggerType
	{
		[InspectorName("无")]
		None,
		[InspectorName("立刻触发")]
		Immediately,
		[InspectorName("计时放出")]
		Time
	}

	public enum chatTriggerCond
	{
		[InspectorName("无")]
		None,
		[InspectorName("首次获得某角色")]
		CharacterAcquire,
		[InspectorName("首次通关剧情关卡")]
		ClearSpecifiedMainlineLevel,
		[InspectorName("特定角色好感度达到特定等级")]
		CharacterFavorabilityLevel,
		[InspectorName("特定角色等级达到特定等级")]
		CharacterLevel,
		[InspectorName("特等角色等级达到特定突破等级")]
		CharacterStarLevel,
		[InspectorName("世界等级达到X级")]
		WorldClass,
		[InspectorName("首次获得到特定星盘")]
		OutfitAcquire,
		[InspectorName("特定关卡达到3星")]
		LevelStar,
		[InspectorName("特定日期")]
		Date
	}

	public enum battlePassQuestType
	{
		[InspectorName("日")]
		DAY = 1,
		[InspectorName("周")]
		WEEK
	}

	public enum ArchType
	{
		[InspectorName("无")]
		None,
		[InspectorName("基础")]
		BaseType,
		[InspectorName("常规")]
		NormalType,
		[InspectorName("特殊")]
		SpecialType
	}

	public enum ArchVoiceType
	{
		[InspectorName("无")]
		None,
		[InspectorName("日常")]
		DailyVoice,
		[InspectorName("战斗")]
		BattlceVoice,
		[InspectorName("皮肤")]
		SkinVoice
	}

	public enum AmmoType
	{
		[InspectorName("主弹夹")]
		Main,
		[InspectorName("附加弹夹1")]
		Special1,
		[InspectorName("附加弹夹2")]
		Special2,
		[InspectorName("最大数量")]
		Max
	}

	public enum ammoParameterType
	{
		[InspectorName("最大容量基础修正")]
		MAX_BASE_VALUE = 1,
		[InspectorName("最大容量百分比修正")]
		MAX_PERCENTAGE,
		[InspectorName("最大容量绝对值修正")]
		MAX_ABSOLUTE_VALUE,
		[InspectorName("最大容量百分比设置")]
		SET_MAX_PERCENTAGE_VALUE,
		[InspectorName("最大容量绝对值设置")]
		SET_MAX_ABSOLUTE_VALUE,
		[InspectorName("当前容量百分比修正")]
		PERCENTAGE,
		[InspectorName("当前容量绝对值修正")]
		ABSOLUTE_VALUE,
		[InspectorName("当前容量百分比设置")]
		SET_PERCENTAGE_VALUE,
		[InspectorName("当前容量绝对值设置")]
		SET_ABSOLUTE_VALUE
	}

	public enum talentType
	{
		[InspectorName("关键节点")]
		KeyNode = 1,
		[InspectorName("普通节点")]
		OrdinaryNode
	}

	public enum talentSubType
	{
		[InspectorName("跃升天赋一")]
		Fate1 = 1,
		[InspectorName("跃升天赋二")]
		Fate2,
		[InspectorName("跃升天赋三")]
		Fate3,
		[InspectorName("跃升天赋四")]
		Fate4,
		[InspectorName("跃升天赋五")]
		Fate5
	}

	public enum levelTypeData
	{
		[InspectorName("无")]
		None,
		[InspectorName("潜能等级")]
		Exclusive,
		[InspectorName("角色等级")]
		Actor,
		[InspectorName("技能槽位")]
		SkillSlot,
		[InspectorName("突破次数")]
		BreakCount,
		[InspectorName("属性音符等级")]
		Note,
		[InspectorName("星盘技能等级")]
		DiscSkill,
		[InspectorName("构筑等级")]
		BuildLevel,
		[InspectorName("自走棋棋子等级")]
		SoldierLevel
	}

	public enum blockPriorityType
	{
		[InspectorName("无")]
		None = 0,
		[InspectorName("一档")]
		Priority1 = 1,
		[InspectorName("二档")]
		Priority2 = 2,
		[InspectorName("三档")]
		Priority3 = 3,
		[InspectorName("四档")]
		Priority4 = 4,
		[InspectorName("最高档")]
		PriorityHighest = 999
	}

	public enum equipmentType
	{
		[InspectorName("盾形")]
		Square = 1,
		[InspectorName("菱形")]
		Circle,
		[InspectorName("方形")]
		Pentagon
	}

	public enum equipmentAttrGroupType
	{
		[InspectorName("基础")]
		Normal = 1,
		[InspectorName("保底")]
		Guaranteed
	}

	public enum characterTagType
	{
		[InspectorName("力量风格")]
		PowerStyle = 1,
		[InspectorName("战术风格")]
		TacticalStyle,
		[InspectorName("所属势力")]
		AffiliatedForces
	}

	public enum noteGetComplete
	{
		[InspectorName("累计通关特定类型房间")]
		PassRoomType = 1
	}

	public enum starTowerStage
	{
		[InspectorName("第一阶段")]
		FirstStage = 1,
		[InspectorName("第二阶段")]
		SecondStage,
		[InspectorName("第三阶段")]
		ThirdStage
	}

	public enum dropItemType
	{
		[InspectorName("星塔币")]
		Coin = 1,
		[InspectorName("经验")]
		Exp,
		[InspectorName("命运卡")]
		FateCard,
		[InspectorName("音符")]
		Note
	}

	public enum dropEntityType
	{
		[InspectorName("吸血鬼经验")]
		VampireExp = 1,
		[InspectorName("吸血鬼宝箱")]
		VampireBox,
		[InspectorName("吸血鬼清屏")]
		VampireClear,
		[InspectorName("吸血鬼拾取")]
		VampireGet,
		[InspectorName("回血")]
		HP,
		[InspectorName("回能")]
		MP,
		[InspectorName("攻击力")]
		ATK
	}

	public enum BrickDropType
	{
		[InspectorName("火焰道具")]
		BrickFire = 1,
		[InspectorName("充能道具")]
		BrickEnergy,
		[InspectorName("积分金币")]
		BrickExpCoin,
		[InspectorName("回血道具")]
		BrickHp,
		[InspectorName("弹射版")]
		BrickPaddle,
		[InspectorName("炸弹")]
		BrickBoom,
		[InspectorName("炸弹球")]
		BrickBoomBall,
		[InspectorName("无敌星")]
		BrickInv,
		[InspectorName("分裂球")]
		BrickSplit,
		[InspectorName("传送门黑洞")]
		BrickPortal_Hole,
		[InspectorName("横激光球")]
		Brick_HorizontalLaser,
		[InspectorName("纵激光球")]
		Brick_VerticalLaser,
		[InspectorName("闪电球")]
		Brick_Lightning
	}

	public enum starTowerRoomType
	{
		[InspectorName("普通战斗")]
		BattleRoom = 0,
		[InspectorName("精英战斗")]
		EliteBattleRoom = 1,
		[InspectorName("普通Boss")]
		BossRoom = 2,
		[InspectorName("最终Boss")]
		FinalBossRoom = 3,
		[InspectorName("危险房间")]
		DangerRoom = 4,
		[InspectorName("高危房间")]
		HorrorRoom = 5,
		[InspectorName("商店房")]
		ShopRoom = 6,
		[InspectorName("事件房")]
		EventRoom = 7,
		[InspectorName("战斗房间")]
		UnifyBattleRoom = 15
	}

	public enum starTowerBattleType
	{
		[InspectorName("战斗房间")]
		Battle = 1,
		[InspectorName("危险房间")]
		Danger,
		[InspectorName("高危房间")]
		Horror
	}

	public enum fateCardServerEffect
	{
		[InspectorName("回血")]
		RecoveryHP = 5,
		[InspectorName("资源产出百分比修正")]
		ChangeResourceOutput,
		[InspectorName("潜能产出权重修正")]
		ChangePotentialOutput
	}

	public enum fateCardMethodMode
	{
		[InspectorName("客户端")]
		ClientFateCard = 1,
		[InspectorName("服务器")]
		ServerFateCard,
		[InspectorName("放出物脚本")]
		LuaFateCard,
		[InspectorName("房间buff")]
		FloorBuffFateCard
	}

	public enum fateCardTheme
	{
		[InspectorName("非特定")]
		NoType,
		[InspectorName("环火")]
		FireRing,
		[InspectorName("裂火")]
		FireWave,
		[InspectorName("陨火")]
		Meteor,
		[InspectorName("光击阵")]
		LightningBall,
		[InspectorName("闪电链")]
		ChainLightning,
		[InspectorName("火球")]
		FireBall,
		[InspectorName("闪电")]
		LightningBolt,
		[InspectorName("风刃")]
		WindBlade,
		[InspectorName("冰雹")]
		Blizzard,
		[InspectorName("旋风")]
		WhirlWind,
		[InspectorName("镰鼬")]
		WindEagle,
		[InspectorName("风领域")]
		WindArea,
		[InspectorName("电鬼")]
		LightingGhost,
		[InspectorName("鲨鱼")]
		Shark,
		[InspectorName("云朵瓶")]
		CloudBottle,
		[InspectorName("水领域")]
		FreezeArea,
		[InspectorName("岩突")]
		EarthSpike,
		[InspectorName("岩矛")]
		EarthSpear,
		[InspectorName("地震")]
		EarthQuake,
		[InspectorName("地裂")]
		EarthFissure,
		[InspectorName("暗刺")]
		NightPierce,
		[InspectorName("暗球")]
		ShadowSphere,
		[InspectorName("暗爆")]
		DarkBurst,
		[InspectorName("黑洞")]
		VoidVortex
	}

	public enum fateCardThemeRank
	{
		[InspectorName("基础")]
		Base = 1,
		[InspectorName("强化类型A")]
		ProA,
		[InspectorName("强化类型B")]
		ProB,
		[InspectorName("超级强化")]
		Super
	}

	public enum fateCardThemeTriggerType
	{
		[InspectorName("普攻")]
		NormalAttack = 1,
		[InspectorName("闪避")]
		Dodge,
		[InspectorName("技能")]
		CastSkill,
		[InspectorName("支援技能")]
		AssistSkill,
		[InspectorName("大招")]
		ExSkill,
		[InspectorName("受击")]
		Behit
	}

	public enum rglTheme
	{
		[InspectorName("非特定")]
		NoType,
		[InspectorName("环火")]
		FireRing,
		[InspectorName("裂火")]
		FireWave,
		[InspectorName("陨火")]
		Meteor,
		[InspectorName("光球")]
		LightningBall,
		[InspectorName("光链")]
		ChainLightning,
		[InspectorName("火球")]
		FireBall,
		[InspectorName("闪电")]
		LightningBolt,
		[InspectorName("风刃")]
		WindBlade,
		[InspectorName("冰雹")]
		Blizzard,
		[InspectorName("旋风")]
		WhirlWind,
		[InspectorName("风鹰")]
		WindEagle,
		[InspectorName("风领域")]
		WindArea,
		[InspectorName("电鬼")]
		LightingGhost,
		[InspectorName("鲨鱼")]
		Shark,
		[InspectorName("云朵瓶")]
		CloudBottle,
		[InspectorName("水领域")]
		FreezeArea
	}

	public enum perkType
	{
		[InspectorName("主题信条")]
		Theme = 1,
		[InspectorName("专属信条")]
		Exclusive,
		[InspectorName("回复信条")]
		Recover,
		[InspectorName("强化信条")]
		Strengthen,
		[InspectorName("特殊专属信条")]
		SpecificExclusive
	}

	public enum charperkType
	{
		[InspectorName("分支")]
		Branch = 1,
		[InspectorName("基础")]
		Basics
	}

	public enum perkSlot
	{
		[InspectorName("无")]
		Null,
		[InspectorName("普通攻击")]
		NormalAttack,
		[InspectorName("闪避")]
		Dodge,
		[InspectorName("释放技能")]
		CastSkill,
		[InspectorName("受击")]
		Behit
	}

	public enum MainOrSupport
	{
		[InspectorName("无")]
		NONE,
		[InspectorName("主控")]
		MAINCONTROL,
		[InspectorName("支援")]
		SUPPORT
	}

	public enum potentialDropType
	{
		[InspectorName("1号位潜能")]
		PotentialOf1 = 1,
		[InspectorName("2号位潜能")]
		PotentialOf2,
		[InspectorName("3号位潜能")]
		PotentialOf3
	}

	public enum charPotentialType
	{
		[InspectorName("特殊潜能")]
		Special = 1,
		[InspectorName("基础潜能")]
		Basics
	}

	public enum starTowerEventType
	{
		[InspectorName("无主的财富")]
		Treasure = 1,
		[InspectorName("强化房")]
		Strengthen,
		[InspectorName("资源轮换房")]
		Exchange,
		[InspectorName("基础事件")]
		Basics
	}

	public enum starTowerOptionsEffect
	{
		[InspectorName("获取星币")]
		GetStarCoin = 1,
		[InspectorName("获取潜能")]
		GetPotential = 3,
		[InspectorName("获取命运卡")]
		GetFateCard = 4,
		[InspectorName("消耗星币")]
		ExpendStarCoin = 5,
		[InspectorName("损失星币")]
		LossStarCoin = 6,
		[InspectorName("消耗潜能")]
		ExpendPotential = 9,
		[InspectorName("损失潜能")]
		LossPotential = 10,
		[InspectorName("损失命运卡")]
		LossFateCard = 11,
		[InspectorName("激活命运卡")]
		ActivateFateCard = 12,
		[InspectorName("强化潜能")]
		StrengthenPotential = 13,
		[InspectorName("恢复生命")]
		RecoveryHP = 14,
		[InspectorName("回收命运卡")]
		RecycleFateCard = 15,
		[InspectorName("无效果")]
		NoIssue = 16,
		[InspectorName("获得随机音符属性技能")]
		GetRandomSubNodeSkill = 17,
		[InspectorName("获得指定音符属性技能")]
		GetSpecificSubNodeSkill = 18,
		[InspectorName("移除随机音符属性技能")]
		LossRandomSubNodeSkill = 19
	}

	public enum force
	{
		[InspectorName("空白旅团")]
		Force1 = 1,
		[InspectorName("自由旅人")]
		Force2 = 2,
		[InspectorName("帝国卫队")]
		Force4 = 4,
		[InspectorName("白猫剧团")]
		Force5 = 5,
		[InspectorName("灰风俱乐部")]
		Force6 = 6,
		[InspectorName("万送屋")]
		Force7 = 7,
		[InspectorName("谷风家政")]
		Force8 = 8,
		[InspectorName("绯瞳传讯")]
		Force9 = 9,
		[InspectorName("恩赐意志")]
		Force10 = 10,
		[InspectorName("联合种业")]
		Force11 = 11,
		[InspectorName("花令旅团")]
		Force12 = 12,
		[InspectorName("地理协会")]
		Force13 = 13,
		[InspectorName("凤凰炒蛋")]
		Force14 = 14,
		[InspectorName("白泽公署")]
		Force15 = 15,
		[InspectorName("云笈文化")]
		Force16 = 16,
		[InspectorName("柔光会社")]
		Force17 = 17,
		[InspectorName("守夜人")]
		Force18 = 18
	}

	public enum bubbleDirection
	{
		[InspectorName("左")]
		Left = 1,
		[InspectorName("右")]
		Right
	}

	public enum attributeType
	{
		[InspectorName("基础属性类型")]
		BaseAttrType = 1,
		[InspectorName("玩家属性类型")]
		PlayerAttrType
	}

	public enum attributeSizeType
	{
		[InspectorName("高")]
		High = 1,
		[InspectorName("中")]
		Mid,
		[InspectorName("低")]
		Low,
		[InspectorName("无")]
		None
	}

	public enum potentialCornerType
	{
		[InspectorName("菱形")]
		Diamond = 1,
		[InspectorName("三角")]
		Triangle,
		[InspectorName("方块")]
		Round
	}

	public enum BranchType
	{
		[InspectorName("主控等级")]
		Master = 1,
		[InspectorName("援护等级")]
		Assist,
		[InspectorName("潜能等级")]
		Common
	}

	public enum giftTag
	{
		[InspectorName("火机")]
		Lighter = 1,
		[InspectorName("相机")]
		Camera,
		[InspectorName("美容")]
		Skincare,
		[InspectorName("降温")]
		Cooldown,
		[InspectorName("偶像")]
		Idol,
		[InspectorName("台灯")]
		Lamp,
		[InspectorName("甜品")]
		Dessert,
		[InspectorName("茶具")]
		Teacup,
		[InspectorName("节日")]
		Festival
	}

	public enum bulletType
	{
		[InspectorName("无")]
		Null,
		[InspectorName("手枪子弹")]
		Pistol,
		[InspectorName("步枪子弹")]
		Rifle,
		[InspectorName("霰弹枪子弹")]
		Shotgun,
		[InspectorName("火系霰弹枪子弹")]
		FireShotgun,
		[InspectorName("能量子弹")]
		EnergyGun
	}

	public enum ValueFormat
	{
		[InspectorName("整数")]
		Int = 1,
		[InspectorName("一位小数")]
		ODP,
		[InspectorName("两位小数")]
		TDP
	}

	public enum InfinityTowerMsgType
	{
		[InspectorName("每日")]
		Daily = 1,
		[InspectorName("突发")]
		Breakout,
		[InspectorName("快讯")]
		News
	}

	public enum InfinityTowerMsgConditions
	{
		[InspectorName("通过特定无尽塔关卡")]
		SpecialLv = 1
	}

	public enum AgentType
	{
		[InspectorName("紧急委托")]
		Emergency = 1,
		[InspectorName("社区帮手")]
		Construction,
		[InspectorName("生态调查")]
		Security,
		[InspectorName("魔物清剿")]
		Monster,
		[InspectorName("矿产勘探")]
		Excavate
	}

	public enum AgentRefreshType
	{
		[InspectorName("常驻")]
		Normal = 1,
		[InspectorName("每日")]
		Daily,
		[InspectorName("不刷新")]
		NonRefresh
	}

	public enum AgentMemberType
	{
		[InspectorName("旅人")]
		CharType = 1,
		[InspectorName("构筑")]
		BuildType
	}

	public enum DestructibleObjectType
	{
		[InspectorName("通用")]
		Common = 1,
		[InspectorName("水暗星塔")]
		WaterAndDarkTower,
		[InspectorName("火地星塔")]
		FireAndEarthTower,
		[InspectorName("风光星塔")]
		WindAndLightTower,
		[InspectorName("无属性星塔")]
		NoneTower
	}

	public enum DatingEventType
	{
		[InspectorName("人物开始约会事件")]
		Start = 1,
		[InspectorName("人物结束约会事件")]
		End,
		[InspectorName("地点事件")]
		Landmark,
		[InspectorName("人物常规事件")]
		Regular,
		[InspectorName("限定地点的角色事件")]
		LimitedLandmark,
		[InspectorName("分支A")]
		BranchA,
		[InspectorName("分支B")]
		BranchB,
		[InspectorName("分支前地点事件")]
		BeforeBranch,
		[InspectorName("分支后地点事件")]
		AfterBranch
	}

	public enum InfinityTowerLevelType
	{
		[InspectorName("普通")]
		Normal = 1,
		[InspectorName("首领")]
		Boss,
		[InspectorName("挑战")]
		Challenge
	}

	public enum InfinityTowerCond
	{
		[InspectorName("通关无尽塔关卡X")]
		LevelClearWithSpecificId = 1,
		[InspectorName("累计通关总层数达到X")]
		InfinityTowerWithSpecificLevelTotal,
		[InspectorName("任意X座擂台通关总层数达到Y")]
		AnyTowerWithSpecificTotalLevel,
		[InspectorName("擂台等级达到X")]
		BountyLevelSpecific,
		[InspectorName("主控角色属性为X")]
		MasterCharactersWithSpecificElementType,
		[InspectorName("角色属性为X的数量不小于Y")]
		ElementTypeWithSpecificQuantityNoLessThanQuantity,
		[InspectorName("角色属性为X的数量不大于Y")]
		ElementTypeWithSpecificQuantityNoMoreThanQuantity
	}

	public enum HonorTitleBgType
	{
		[InspectorName("椭圆背板")]
		Ellipse = 1,
		[InspectorName("四边形背板")]
		Parallelogram
	}

	public enum honorTabType
	{
		[InspectorName("成就")]
		Achieve = 1,
		[InspectorName("默契")]
		Character,
		[InspectorName("活动")]
		Activity
	}

	public enum OpenFuncType
	{
		[InspectorName("角色")]
		Char = 1,
		[InspectorName("招募")]
		Gacha,
		[InspectorName("邮件")]
		Mail,
		[InspectorName("星塔探索")]
		StarTower,
		[InspectorName("悬赏行动")]
		DailyInstance,
		[InspectorName("强敌讨伐")]
		RegionBoss,
		[InspectorName("巅峰揭幕")]
		TravelerDuel,
		[InspectorName("签到")]
		SignIn,
		[InspectorName("心危擂台")]
		InfinityTower,
		[InspectorName("卡带回收")]
		SkillInstance,
		[InspectorName("星塔排行榜")]
		StarTowerRank,
		[InspectorName("委托派遣")]
		Agent,
		[InspectorName("强敌讨伐挑战模式")]
		RegionBossChallenge,
		[InspectorName("巅峰揭幕挑战模式")]
		TravelerDuelChallenge,
		[InspectorName("灾变防线")]
		VampireSurvivor,
		[InspectorName("任务")]
		Quest,
		[InspectorName("手机")]
		Phone,
		[InspectorName("活动")]
		Activity,
		[InspectorName("材料合成")]
		Crafting,
		[InspectorName("积分boss")]
		ScoreBoss,
		[InspectorName("周本")]
		WeeklyCopies,
		[InspectorName("每日任务")]
		DailyQuest,
		[InspectorName("每日赠礼")]
		DailyReward,
		[InspectorName("角色宝石副本")]
		CharGemInstance,
		[InspectorName("角色邀约")]
		CharDating,
		[InspectorName("总力战")]
		JointDrill,
		[InspectorName("教学关")]
		TutorialLevel,
		[InspectorName("战令")]
		BattlePass,
		[InspectorName("昵称重置")]
		NickNameReset,
		[InspectorName("每周任务")]
		WeeklyQuest,
		[InspectorName("新手引导任务")]
		QuestNewbie,
		[InspectorName("围猎追踪")]
		TraceHunt,
		[InspectorName("干劲储藏")]
		EnergyBattery,
		[InspectorName("待办")]
		EventReminder,
		[InspectorName("后宅")]
		Dorm,
		[InspectorName("guideMission")]
		GuideMission,
		[InspectorName("尖兵陷阵")]
		Soldier,
		[InspectorName("活动回顾")]
		ActivityReview
	}

	public enum TowerQuestType
	{
		[InspectorName("核心任务")]
		Core = 1,
		[InspectorName("普通任务")]
		Normal
	}

	public enum poolType
	{
		[InspectorName("精英")]
		Elite = 1,
		[InspectorName("首领")]
		Boss
	}

	public enum starTowerNodeColor
	{
		[InspectorName("蓝")]
		Blue = 1,
		[InspectorName("黄")]
		Yellow,
		[InspectorName("橙")]
		Orange,
		[InspectorName("红")]
		Red,
		[InspectorName("绿")]
		Green
	}

	public enum vampireSurvivorType
	{
		[InspectorName("普通")]
		Normal = 1,
		[InspectorName("困难")]
		Hard,
		[InspectorName("轮换")]
		Turn
	}

	public enum vampireSurvivorMode
	{
		[InspectorName("单关")]
		Single = 1,
		[InspectorName("双关")]
		Double
	}

	public enum miningGridType
	{
		[InspectorName("已摧毁")]
		Destroyed,
		[InspectorName("脆弱")]
		Fragile,
		[InspectorName("普通")]
		Normal,
		[InspectorName("坚硬")]
		Hard,
		[InspectorName("超坚硬")]
		SuperHard,
		[InspectorName("格子类型最大值")]
		Max
	}

	public enum miningRewardType
	{
		[InspectorName("宝藏类型A")]
		RewardTypeA = 1,
		[InspectorName("宝藏类型B")]
		RewardTypeB,
		[InspectorName("宝藏类型C")]
		RewardTypeC,
		[InspectorName("宝藏类型D")]
		RewardTypeD
	}

	public enum miningRewardDir
	{
		[InspectorName("上")]
		Up = 1,
		[InspectorName("左上")]
		LeftUp,
		[InspectorName("左下")]
		LeftDown,
		[InspectorName("下")]
		Down,
		[InspectorName("右下")]
		RightDown,
		[InspectorName("右上")]
		RightUp
	}

	public enum BuffEffectType
	{
		[InspectorName("总体型持续伤害")]
		OnceDoT = 1,
		[InspectorName("单次型持续伤害")]
		NormalDoT
	}

	public enum miningRewardRarity
	{
		[InspectorName("传奇道具")]
		miningSSR = 1,
		[InspectorName("稀有道具")]
		miningSR
	}

	public enum miningQuestCond
	{
		[InspectorName("占位")]
		test = 1
	}

	public enum miningSupportEffect
	{
		[InspectorName("普通挖掘")]
		Dig = 1,
		[InspectorName("相邻格子被破坏")]
		NeighborDestroyed,
		[InspectorName("敲击时对随机相邻格子造成范围伤害")]
		AreaDamageOnDig,
		[InspectorName("概率不消耗道具")]
		ConsumePreserver,
		[InspectorName("进入当前层时转换格子")]
		ConverterOnEnterLayer,
		[InspectorName("找到宝藏时转换格子")]
		ConverterOnReceiveTreasure,
		[InspectorName("开启空格子时转换格子")]
		ConverterOnGridDestroyed,
		[InspectorName("概率伤害翻倍")]
		CriticalDamage,
		[InspectorName("开启空格子后标记宝藏格子")]
		TreasureMarkerOnGridDestroyed,
		[InspectorName("击破格子时, 对附近随机params[0]个格子造成params[1]点伤害")]
		Char134,
		[InspectorName("击破格子时, 有params[0]概率将随机params[1]个params[2]类型的格子转换成params[3]类型的格子")]
		Char156,
		[InspectorName("击破格子为空时, 对场上随机params[0]个格子造成params[1]点伤害")]
		Npc132,
		[InspectorName("击破格子为空时, 有params[0]概率不消耗铲子")]
		ProbRefundConsumeOnEmptyDigDestroy,
		[InspectorName("最大值标记")]
		Max
	}

	public enum scoreBossBehavior
	{
		[InspectorName("触发地系印记")]
		TriggerEarthTag = 1,
		[InspectorName("触发火系印记")]
		TriggerFireTag,
		[InspectorName("触发水系印记")]
		TriggerWaterTag,
		[InspectorName("触发风系印记")]
		TriggerWindTag,
		[InspectorName("触发光系印记")]
		TriggerLightTag,
		[InspectorName("触发暗系印记")]
		TriggerDarkTag,
		[InspectorName("Boss进入破韧状态")]
		TriggerToughnessBreakdown,
		[InspectorName("连续对Boss攻击5秒")]
		TriggerContinuousAttackFiveSeconds,
		[InspectorName("支援技命中Boss")]
		TriggerSupportSkillHitBoss,
		[InspectorName("大招命中Boss")]
		TriggerUltimateSkillHitBoss,
		[InspectorName("不被风草龙卷风命中")]
		TriggerFengCaoCyclonesMissPlayer,
		[InspectorName("风草召唤怪物存活时间不超过10秒")]
		TriggerFengCaoSummonLiveTenSeconds,
		[InspectorName("击破厨师的刀")]
		TriggerChuShiKillKnife,
		[InspectorName("厨师收回刀")]
		TriggerChuShiCallBackKnife,
		[InspectorName("不被鲨鲨地面裂隙命中")]
		TriggerShaShaFissureMissPlayer,
		[InspectorName("不被禁断丽容龙卷风命中")]
		TriggerJinDuanLiRongCyclonesMissPlayer,
		[InspectorName("不被禁断丽容梳子命中")]
		TriggerJinDuanLiRongCombsMissPlayer,
		[InspectorName("击破多个气球精灵")]
		TriggerFengShanJiKillBalloons,
		[InspectorName("不被风扇姬射击命中")]
		TriggerFengShanJiShootsMissPlayer,
		[InspectorName("击破蜂鸟花")]
		TriggerFengNiaoBeatFlower,
		[InspectorName("大招期间击破蜂鸟花")]
		TriggerFengNiaoBeatFlowerWhenUltraSkill,
		[InspectorName("不被蜂鸟花")]
		TriggerFengNiaoFlowerMissPlayer,
		[InspectorName("不被环绕灯泡命中")]
		TriggerTaiDengMissPlayer,
		[InspectorName("摧毁落地灯泡")]
		TriggerTaiDengKill,
		[InspectorName("通用通知1")]
		TriggerCommon1,
		[InspectorName("通用通知2")]
		TriggerCommon2,
		[InspectorName("通用通知3")]
		TriggerCommon3,
		[InspectorName("通用通知4")]
		TriggerCommon4
	}

	public enum scoreBossType
	{
		[InspectorName("通用")]
		WildCard = 1
	}

	public enum JointDrillBattleLvsToggle
	{
		[InspectorName("血量低于")]
		HpLessThan = 1
	}

	public enum JointDrillFloorType
	{
		[InspectorName("小怪关卡")]
		Monster = 1,
		[InspectorName("Boss关卡")]
		Boss
	}

	public enum JointDrill_2_BattleLvsToggle
	{
		[InspectorName("Boss死亡")]
		BossDeath = 1
	}

	public enum JointDrill_2_FloorType
	{
		[InspectorName("小怪关卡")]
		Monster = 1,
		[InspectorName("Boss关卡")]
		Boss
	}

	public enum mangaLoadingCondition
	{
		[InspectorName("无条件")]
		None = 1,
		[InspectorName("时间")]
		Time
	}

	public enum potentialBuild
	{
		[InspectorName("流派1")]
		PotentialBuild1 = 1,
		[InspectorName("流派2")]
		PotentialBuild2,
		[InspectorName("通用")]
		PotentialBuildCommon
	}

	public enum bannerType
	{
		[InspectorName("活动")]
		Activity = 1,
		[InspectorName("功能")]
		OpenFunc,
		[InspectorName("抽卡")]
		Gacha,
		[InspectorName("社区")]
		Community,
		[InspectorName("商城")]
		Mall,
		[InspectorName("商城皮肤")]
		MallSkin,
		[InspectorName("国服支付中心")]
		Payment,
		[InspectorName("限时功能")]
		TimeLimit_Func,
		[InspectorName("跳转至某链接")]
		JumpToUrl,
		[InspectorName("外服支付中心")]
		SeaPayment
	}

	public enum FrozenTimeHighlightUnit
	{
		[InspectorName("自己")]
		Self = 1,
		[InspectorName("自己和目标")]
		SelfAndTarget
	}

	public enum TowerDefGuideType
	{
		[InspectorName("角色")]
		Character = 1,
		[InspectorName("道具")]
		Item
	}

	public enum TowerDefQuestType
	{
		[InspectorName("通关塔防关卡X")]
		ClearLevel = 1,
		[InspectorName("塔防关卡X评分达到Y")]
		LevelScore
	}

	public enum CookiePackModel
	{
		[InspectorName("常规模式")]
		CookiePackNormalModel = 1,
		[InspectorName("流线模式")]
		CookiePackPathsModel,
		[InspectorName("节奏模式")]
		CookiePackRhythmlModel,
		[InspectorName("复合模式")]
		CookiePackComplexModel
	}

	public enum CookiePackType
	{
		[InspectorName("日常")]
		Daily = 1,
		[InspectorName("梦魇")]
		Complex
	}

	public enum CookieType
	{
		[InspectorName("圆")]
		Round = 1,
		[InspectorName("方")]
		Square,
		[InspectorName("五角星")]
		Star
	}

	public enum CookieRhythmlResult
	{
		[InspectorName("极致完美")]
		Excellent = 1,
		[InspectorName("完美")]
		Perfect,
		[InspectorName("极好")]
		Good,
		[InspectorName("失误")]
		Miss
	}

	public enum LevelQuestTargetType
	{
		[InspectorName("空任务")]
		Null,
		[InspectorName("击杀指定Id怪物")]
		KillMonster,
		[InspectorName("进行闪避")]
		CastDodgeSkill,
		[InspectorName("保持疾跑状态")]
		HoldRushState,
		[InspectorName("释放援护技能")]
		CastAssitSkill,
		[InspectorName("释放援护绝招")]
		CastAssitUltraSkill,
		[InspectorName("完成破韧")]
		BreakMonsterToughness,
		[InspectorName("收到指定交互行为Id")]
		ReceiveTriggerOpId,
		[InspectorName("释放指定Id技能")]
		CastSkill,
		[InspectorName("执行指定标签Combo")]
		UseCombo,
		[InspectorName("指定标签伤害击杀怪物")]
		KillMonsterByDamageTag,
		[InspectorName("指定标签伤害造成伤害")]
		DamagedByDamageTag,
		[InspectorName("指定Id角色绝招能量回满")]
		RecoverEnergy,
		[InspectorName("清理场上所有怪物")]
		KillAllMonster,
		[InspectorName("指定Id技能释放完毕")]
		CastSkillEnd,
		[InspectorName("指定数组内伤害Id造成伤害")]
		DamagedByDamageIdGroup,
		[InspectorName("击杀指定数量怪物")]
		KillMonsterCount
	}

	public enum TutorialLevelProcessType
	{
		[InspectorName("测试流程")]
		Test,
		[InspectorName("基础操作练习")]
		BasicOperation,
		[InspectorName("移动操作练习")]
		MoveOperation,
		[InspectorName("援护角色复习")]
		SupportOperation,
		[InspectorName("战斗机制教学-印记")]
		MarkMechanism,
		[InspectorName("战斗机制教学-元素属性强弱")]
		ElementMechanism,
		[InspectorName("星塔基础机制-选卡")]
		StarTowerCardMechanism,
		[InspectorName("星塔基础机制-音符")]
		StarTowerNoteMechanism,
		[InspectorName("怪物机制教学-韧性")]
		MonsterToughnessMechanism
	}

	public enum wordLinkType
	{
		[InspectorName("关键字")]
		Word = 1,
		[InspectorName("潜能")]
		Potential
	}

	public enum potentialIType
	{
		[InspectorName("5号潜能提升")]
		Potential5 = 5,
		[InspectorName("6号潜能提升")]
		Potential6 = 6,
		[InspectorName("7号潜能提升")]
		Potential7 = 7,
		[InspectorName("8号潜能提升")]
		Potential8 = 8,
		[InspectorName("9号潜能提升")]
		Potential9 = 9,
		[InspectorName("10号潜能提升")]
		Potential10 = 10,
		[InspectorName("11号潜能提升")]
		Potential11 = 11,
		[InspectorName("12号潜能提升")]
		Potential12 = 12,
		[InspectorName("13号潜能提升")]
		Potential13 = 13,
		[InspectorName("25号潜能提升")]
		Potential25 = 25,
		[InspectorName("26号潜能提升")]
		Potential26 = 26,
		[InspectorName("27号潜能提升")]
		Potential27 = 27,
		[InspectorName("28号潜能提升")]
		Potential28 = 28,
		[InspectorName("29号潜能提升")]
		Potential29 = 29,
		[InspectorName("30号潜能提升")]
		Potential30 = 30,
		[InspectorName("31号潜能提升")]
		Potential31 = 31,
		[InspectorName("32号潜能提升")]
		Potential32 = 32,
		[InspectorName("33号潜能提升")]
		Potential33 = 33,
		[InspectorName("41号潜能提升")]
		Potential41 = 41,
		[InspectorName("42号潜能提升")]
		Potential42 = 42,
		[InspectorName("43号潜能提升")]
		Potential43 = 43
	}

	public enum CharGemSlotPosition
	{
		[InspectorName("第一槽")]
		Slot1,
		[InspectorName("第二槽")]
		Slot2,
		[InspectorName("第三槽")]
		Slot3,
		[InspectorName("槽边界")]
		SlotBound
	}

	public enum CharGemType
	{
		[InspectorName("恩赐意志")]
		GemType_1 = 1,
		[InspectorName("地理协会")]
		GemType_2,
		[InspectorName("帝国卫队")]
		GemType_3
	}

	public enum CharGemAttrGroupType
	{
		[InspectorName("独有库")]
		UniqueAttrGroup = 1,
		[InspectorName("权重库")]
		CommonAttrGroup
	}

	public enum CharGemAttrTag
	{
		[InspectorName("属性")]
		ATTR = 1,
		[InspectorName("技能等级")]
		SILL,
		[InspectorName("前台潜能")]
		Potential_F,
		[InspectorName("后台潜能")]
		Potential_B,
		[InspectorName("通用潜能")]
		Potential_G
	}

	public enum GemASkillLevelType
	{
		[InspectorName("普通攻击等级提升")]
		NormalAtk = 1,
		[InspectorName("技能等级提升")]
		Skill,
		[InspectorName("支援技能等级提升")]
		AssistSkillI,
		[InspectorName("必杀等级提升")]
		Ultimate
	}

	public enum CharGemEffectType
	{
		[InspectorName("属性修改")]
		ATTR_FIX = 12,
		[InspectorName("玩家属性修改")]
		PLAYER_ATTR_FIX = 37,
		[InspectorName("技能等级提升")]
		SkillLevel = 7,
		[InspectorName("潜能等级提升")]
		Potential = 99
	}

	public enum TrialSectType
	{
		[InspectorName("主控流派1")]
		MainSect1 = 1,
		[InspectorName("主控流派2")]
		MainSect2,
		[InspectorName("支援流派1")]
		SupSect1,
		[InspectorName("支援流派2")]
		SupSect2,
		[InspectorName("皮肤试玩主控")]
		SkinMainSect,
		[InspectorName("皮肤试玩援护")]
		SkinSupSect
	}

	public enum activityGroupType
	{
		[InspectorName("无")]
		None,
		[InspectorName("中型")]
		Middle,
		[InspectorName("大型")]
		Huge,
		[InspectorName("打砖块")]
		BreakOut
	}

	public enum activityThemeType
	{
		[InspectorName("无")]
		None,
		[InspectorName("泳装主题")]
		Swim,
		[InspectorName("冬香活动")]
		OurRegiment_10101,
		[InspectorName("夏花活动")]
		Dream_10102,
		[InspectorName("打砖块一期")]
		BreakOut_30101,
		[InspectorName("圣诞菈露活动")]
		Christmas_20101,
		[InspectorName("翡冷翠活动")]
		Miracle_10103,
		[InspectorName("春节活动")]
		Spring_10104,
		[InspectorName("风影活动")]
		WinterNight_10105,
		[InspectorName("多娜活动")]
		Postal_10106,
		[InspectorName("乙叶活动")]
		SoloDance_20102,
		[InspectorName("火垂活动")]
		Viewfinder_10107,
		[InspectorName("打砖块二期")]
		BreakOut_30102,
		[InspectorName("泳装主题复刻")]
		Swim_11100,
		[InspectorName("斯帕克拉活动")]
		Tech_10108,
		[InspectorName("猫眼活动")]
		GunStorm_10109,
		[InspectorName("盛夏薇洛活动")]
		Summer_20103,
		[InspectorName("花铃活动")]
		Summer_10110,
		[InspectorName("埃莉诺活动")]
		CultivationManual_10111,
		[InspectorName("打砖块三期")]
		BreakOut_30103,
		[InspectorName("艾蕾活动")]
		LongestDay_10112,
		[InspectorName("打砖块四期")]
		BreakOut_30104,
		[InspectorName("周年尘沙活动")]
		DustDawn_20104,
		[InspectorName("优叶活动")]
		UnchartedMap_10113
	}

	public enum ActivityLevelType
	{
		[InspectorName("普通")]
		Explore = 1,
		[InspectorName("挑战")]
		Adventure,
		[InspectorName("剧情")]
		AVG,
		[InspectorName("困难")]
		HARD
	}

	public enum TutorialType
	{
		[InspectorName("旅人机制")]
		Character = 1,
		[InspectorName("战斗机制")]
		Battle,
		[InspectorName("星塔机制")]
		StarTower
	}

	public enum ActivityTaskTabType
	{
		[InspectorName("日常任务")]
		Tab1 = 1,
		[InspectorName("挑战任务")]
		Tab2,
		[InspectorName("冒险任务")]
		Tab3,
		[InspectorName("玩法任务")]
		Tab4,
		[InspectorName("活跃任务")]
		Tab5
	}

	public enum ActivityUseType
	{
		[InspectorName("无")]
		None = 1,
		[InspectorName("中型活动")]
		Middle
	}

	public enum PopUpType
	{
		[InspectorName("单活动")]
		Activity = 1,
		[InspectorName("活动组")]
		ActivityGroup,
		[InspectorName("独立公告")]
		OwnPopUP
	}

	public enum PopRefreshType
	{
		[InspectorName("期间首次登录")]
		WholeFirst = 1,
		[InspectorName("期间每日登录")]
		DailyFirst,
		[InspectorName("期间每周登录")]
		WeeklyFirst
	}

	public enum PopJumpType
	{
		[InspectorName("无跳转")]
		None = 1,
		[InspectorName("活动跳转")]
		ActivityJump,
		[InspectorName("常规跳转")]
		NormalJump,
		[InspectorName("跳转外部链接")]
		JumpToUrl
	}

	public enum PopUpOpenType
	{
		[InspectorName("无")]
		None,
		[InspectorName("初始开放")]
		Original,
		[InspectorName("日期开放")]
		Date
	}

	public enum PopUpEndType
	{
		[InspectorName("无")]
		None,
		[InspectorName("不结束")]
		NoLimit,
		[InspectorName("指定日期关闭")]
		Date,
		[InspectorName("开启一段时间后关闭")]
		TimeLimit
	}

	public enum PopUpSeqType
	{
		[InspectorName("无")]
		None = 0,
		[InspectorName("世界等级")]
		WorldClass = 1,
		[InspectorName("功能解锁")]
		FuncUnlock = 2,
		[InspectorName("每日签到")]
		DailyCheckIn = 3,
		[InspectorName("月卡")]
		MonthlyCard = 4,
		[InspectorName("打脸公告")]
		ActivityFaceAnnounce = 5,
		[InspectorName("活动登录")]
		ActivityLogin = 6,
		[InspectorName("聊天")]
		NewChat = 7,
		[InspectorName("通用弹窗")]
		MessageBox = 8,
		[InspectorName("回流活动弹窗")]
		Reengagement = 9,
		[InspectorName("回流欢迎AVG")]
		ReengagementAvg = 10,
		[InspectorName("星塔未保存Build")]
		StarTowerBuildSave = 12,
		[InspectorName("主界面引导")]
		MainViewGuide = 13
	}

	public enum MallItemType
	{
		[InspectorName("礼包")]
		Package = 1,
		[InspectorName("皮肤")]
		Skin,
		[InspectorName("家具")]
		Furniture
	}

	public enum MallItemSubType
	{
		[InspectorName("礼包")]
		Package = 1,
		[InspectorName("皮肤")]
		Skin,
		[InspectorName("家具")]
		Furniture,
		[InspectorName("家具套装")]
		FurnitureSet,
		[InspectorName("家具主题")]
		FurnitureTheme
	}

	public enum GetLinesType
	{
		[InspectorName("初次获得")]
		GachaNew = 1,
		[InspectorName("重复获得")]
		Gacha,
		[InspectorName("觉醒")]
		UnLockLook,
		[InspectorName("CG")]
		UnLockCG,
		[InspectorName("皮肤")]
		Skin
	}

	public enum storySetOpenCond
	{
		[InspectorName("[历史]达到X世界等级")]
		WorldClassSpecific = 71
	}

	public enum ElementMarkType
	{
		[InspectorName("全部火系印记")]
		Fire = 1,
		[InspectorName("全部水系印记")]
		Water = 2,
		[InspectorName("全部光系印记")]
		Light = 3,
		[InspectorName("全部暗系印记")]
		Dark = 4,
		[InspectorName("全部地系印记")]
		Earth = 5,
		[InspectorName("全部风系印记")]
		Wind = 6,
		[InspectorName("火系印记1")]
		FireMark1 = 11,
		[InspectorName("火系印记2")]
		FireMark2 = 12,
		[InspectorName("火系印记3")]
		FireMark3 = 13,
		[InspectorName("火系印记4")]
		FireMark4 = 14,
		[InspectorName("火系印记5")]
		FireMark5 = 15,
		[InspectorName("水系印记1")]
		WaterMark1 = 21,
		[InspectorName("水系印记2")]
		WaterMark2 = 22,
		[InspectorName("水系印记3")]
		WaterMark3 = 23,
		[InspectorName("水系印记4")]
		WaterMark4 = 24,
		[InspectorName("水系印记5")]
		WaterMark5 = 25,
		[InspectorName("光系印记1")]
		LightMark1 = 31,
		[InspectorName("光系印记2")]
		LightMark2 = 32,
		[InspectorName("光系印记3")]
		LightMark3 = 33,
		[InspectorName("光系印记4")]
		LightMark4 = 34,
		[InspectorName("光系印记5")]
		LightMark5 = 35,
		[InspectorName("暗系印记1")]
		DarkMark1 = 41,
		[InspectorName("暗系印记2")]
		DarkMark2 = 42,
		[InspectorName("暗系印记3")]
		DarkMark3 = 43,
		[InspectorName("暗系印记4")]
		DarkMark4 = 44,
		[InspectorName("暗系印记5")]
		DarkMark5 = 45,
		[InspectorName("地系印记1")]
		EarthMark1 = 51,
		[InspectorName("地系印记2")]
		EarthMark2 = 52,
		[InspectorName("地系印记3")]
		EarthMark3 = 53,
		[InspectorName("地系印记4")]
		EarthMark4 = 54,
		[InspectorName("地系印记5")]
		EarthMark5 = 55,
		[InspectorName("风系印记1")]
		WindMark1 = 61,
		[InspectorName("风系印记2")]
		WindMark2 = 62,
		[InspectorName("风系印记3")]
		WindMark3 = 63,
		[InspectorName("风系印记4")]
		WindMark4 = 64,
		[InspectorName("风系印记5")]
		WindMark5 = 65
	}

	public enum AdventureActorElementTriggerType
	{
		[InspectorName("无")]
		None = 0,
		[InspectorName("超燃")]
		FireElementTriggerType1 = 11,
		[InspectorName("灼炎")]
		FireElementTriggerType2 = 12,
		[InspectorName("寒冷")]
		WaterElementTriggerType1 = 21,
		[InspectorName("水系2暂无")]
		WaterElementTriggerType2 = 22,
		[InspectorName("落雷")]
		LightElementTriggerType1 = 31,
		[InspectorName("光系2暂无")]
		LightElementTriggerType2 = 32,
		[InspectorName("暗灼")]
		DarkElementTriggerType1 = 41,
		[InspectorName("暗锁")]
		DarkElementTriggerType2 = 42,
		[InspectorName("岩锥")]
		EarthElementTriggerType = 51,
		[InspectorName("地系2暂无")]
		EarthElementTriggerType2 = 52,
		[InspectorName("气旋")]
		WindElementTriggerType1 = 61,
		[InspectorName("绽放")]
		WindElementTriggerType2 = 62
	}

	public enum BdRequest
	{
		[InspectorName("bd评分大于等级X")]
		BdMaxLevel = 1,
		[InspectorName("bd内总音符数量大于X个")]
		BdNoteAllKindNum,
		[InspectorName("bd内有X个Y音符")]
		BdNoteOneKindNum,
		[InspectorName("bd内总潜能数量大于X个")]
		BdPotentialNum,
		[InspectorName("bd内有X个Y等级以上的潜能")]
		BdPotentialLevelNum,
		[InspectorName("主控角色为X元素角色")]
		BdMainCharElementNum,
		[InspectorName("bd中包含X个Y元素角色")]
		BdCharElementNum,
		[InspectorName("bd中包含X个Y定位角色")]
		BdCharJobNum,
		[InspectorName("bd中激活X个Y级以上协奏技能")]
		BdActivateSkillLevelNum,
		[InspectorName("bd中所有角色为X元素")]
		BdAllCharElement
	}

	public enum ActivityBreakoutLevelType
	{
		[InspectorName("入门")]
		Entry = 1,
		[InspectorName("新手")]
		Newbie,
		[InspectorName("进阶")]
		Advanced,
		[InspectorName("砖家")]
		Expert
	}

	public enum JointDrillMode
	{
		[InspectorName("总力战一型")]
		JointDrill_Mode_1 = 1,
		[InspectorName("总力战二型")]
		JointDrill_Mode_2
	}

	public enum PenguinBaseCardSuit
	{
		[InspectorName("火")]
		Red = 1,
		[InspectorName("冰")]
		Blue,
		[InspectorName("风")]
		Green
	}

	public enum PenguinCardTriggerPhase
	{
		[InspectorName("发牌阶段")]
		Dealing = 1,
		[InspectorName("翻牌阶段")]
		Flip,
		[InspectorName("结算阶段")]
		Settlement,
		[InspectorName("准备阶段")]
		Prepare,
		[InspectorName("全局升级前")]
		BeforeUpgrade,
		[InspectorName("全局升级后")]
		AfterUpgrade,
		[InspectorName("生命归零")]
		FatalDamage,
		[InspectorName("企鹅牌变化时")]
		PenguinCardChange,
		[InspectorName("翻牌结束时")]
		FlipEnd,
		[InspectorName("手动刷新BD牌时")]
		ManualRoll,
		[InspectorName("光环更新")]
		Aura,
		[InspectorName("进入新难度时")]
		NextLevel
	}

	public enum PenguinCardTriggerType
	{
		[InspectorName("无条件")]
		None = 1,
		[InspectorName("花色牌")]
		SuitCards,
		[InspectorName("花色数")]
		SuitCount,
		[InspectorName("牌型花色数")]
		HandRankSuitCount,
		[InspectorName("指定基础牌id")]
		BaseCardId,
		[InspectorName("回合内重复牌型")]
		RepeatHandRank,
		[InspectorName("牌型")]
		HandRank
	}

	public enum PenguinCardGrowthTriggerType
	{
		[InspectorName("无条件")]
		None = 1,
		[InspectorName("单牌x花色统计")]
		SuitCountInCard,
		[InspectorName("企鹅牌等级统计")]
		LevelCount,
		[InspectorName("牌型")]
		HandRank
	}

	public enum PenguinCardTriggerLimit
	{
		[InspectorName("无条件")]
		None = 1,
		[InspectorName("每轮x次")]
		Round,
		[InspectorName("每回合x次")]
		Turn,
		[InspectorName("每局x次")]
		Game,
		[InspectorName("每回合x次且单轮至多y次")]
		TurnAndRound
	}

	public enum PenguinCardGrowthType
	{
		[InspectorName("无")]
		None = 1,
		[InspectorName("全局养成")]
		FullGame,
		[InspectorName("单回合养成")]
		CurTurn
	}

	public enum PenguinCardEffectType
	{
		[InspectorName("更换基础牌")]
		ReplaceBaseCard = 1,
		[InspectorName("增加基础牌掉落权重")]
		AddBaseCardWeight,
		[InspectorName("基础筹码增加")]
		IncreaseBasicChips,
		[InspectorName("倍率增加")]
		IncreaseMultiplier,
		[InspectorName("倍率乘算")]
		MultiMultiplier,
		[InspectorName("升级费用打折百分比变化值x%")]
		UpgradeDiscount,
		[InspectorName("单回合发牌轮数+x")]
		AddRound,
		[InspectorName("免死")]
		BlockFatalDamage,
		[InspectorName("升级费用返利百分比x%")]
		UpgradeRebate,
		[InspectorName("增加BD卡n选一上限")]
		AddCardRollCount,
		[InspectorName("固定刷新目标BD牌")]
		RollSpecificCard,
		[InspectorName("升级费用打折百分比变化值x%光环")]
		UpgradeDiscountAura,
		[InspectorName("验牌次数变化值x光环")]
		CheckRoundAura,
		[InspectorName("发牌轮数变化值x光环")]
		AddRoundAura,
		[InspectorName("通关筹码百分比变化值x光环")]
		AimScoreAura,
		[InspectorName("x张企鹅牌等级变化值Y")]
		CardLevel,
		[InspectorName("HP变化值x")]
		ChangeHp,
		[InspectorName("助手资金变化值x%光环")]
		AideScoreAura,
		[InspectorName("重试限制")]
		RetryLimit
	}

	public enum PenguinCardQuestType
	{
		[InspectorName("x回合内累计获得x筹码")]
		Score = 1,
		[InspectorName("x回合内累计获得x个x花色")]
		SuitCount,
		[InspectorName("x回合内累计获得x次x牌型")]
		HandRank
	}

	public enum PenguinCardBuffDuration
	{
		[InspectorName("持续全局")]
		FullGame = 1,
		[InspectorName("计数x次")]
		Count,
		[InspectorName("持续x回合")]
		Turn,
		[InspectorName("持续x轮")]
		Round
	}

	public enum ThrowGiftSpawnPointType
	{
		[InspectorName("无")]
		None,
		[InspectorName("类型1")]
		Type1,
		[InspectorName("类型2")]
		Type2
	}

	public enum ThrowGiftSpawnCond
	{
		[InspectorName("完成其中一个")]
		Partial = 1,
		[InspectorName("全部完成")]
		All,
		[InspectorName("随机一个激活")]
		Random
	}

	public enum SpecialObstacleType
	{
		[InspectorName("获得积分")]
		Score = 1,
		[InspectorName("阻挡企鹅")]
		Obstacle,
		[InspectorName("鼓风机")]
		WindForce,
		[InspectorName("传送井")]
		Portal,
		[InspectorName("传送井出口")]
		PortalExit
	}

	public enum MallPackageRarity
	{
		[InspectorName("白")]
		White = 1,
		[InspectorName("绿")]
		Green,
		[InspectorName("金")]
		Gold,
		[InspectorName("粉")]
		Pink
	}

	public enum MallAdvRecommendItemType
	{
		[InspectorName("无")]
		None,
		[InspectorName("月卡")]
		MonthlyCard,
		[InspectorName("战令")]
		BattlePass,
		[InspectorName("礼包")]
		Package,
		[InspectorName("皮肤")]
		Skin,
		[InspectorName("家具")]
		Furniture
	}

	public enum StoryPreviewType
	{
		[InspectorName("敬请期待")]
		None,
		[InspectorName("主线")]
		MainlineStory,
		[InspectorName("故事集")]
		StorySet,
		[InspectorName("活动剧情")]
		ActivityStory
	}

	public enum ThrowGiftDifficulty
	{
		[InspectorName("新手区")]
		Easy = 1,
		[InspectorName("普通区")]
		Normal,
		[InspectorName("极速区")]
		Speed,
		[InspectorName("盲投区")]
		Blind
	}

	public enum ThrowGiftLevelCond
	{
		[InspectorName("投出X个礼物")]
		ThrowCount = 1,
		[InspectorName("投中X个礼物")]
		HitCount,
		[InspectorName("得到X分")]
		Score,
		[InspectorName("时间结束投出X个礼物")]
		ThrowCountAfterTime,
		[InspectorName("时间结束投中X个礼物")]
		HitCountAfterTime,
		[InspectorName("时间结束得到X分")]
		ScoreAfterTime
	}

	public enum AgentQuality
	{
		[InspectorName("品质一")]
		Quality1 = 1,
		[InspectorName("品质二")]
		Quality2,
		[InspectorName("品质三")]
		Quality3
	}

	public enum TravelerDuelHotValueItemType
	{
		[InspectorName("A类")]
		TypeA = 1,
		[InspectorName("B类")]
		TypeB,
		[InspectorName("C类")]
		TypeC
	}

	public enum CharPlotType
	{
		[InspectorName("旅人剧情")]
		CharPlot = 1,
		[InspectorName("皮肤剧情")]
		SkinPlot
	}

	public enum GoldenSpyLevelType
	{
		[InspectorName("普通关")]
		Normal = 1,
		[InspectorName("任务关")]
		Quest,
		[InspectorName("随机关")]
		Random,
		[InspectorName("捕鱼钩爪关")]
		FishingHook
	}

	public enum GoldenSpyBuffEffect
	{
		[InspectorName("X物品的价值增加Y")]
		AddScore = 1,
		[InspectorName("1级任务出现权重增加Y")]
		AddTaskWeight,
		[InspectorName("任务价值提升X%")]
		AddExScoreFactor,
		[InspectorName("X物品重量减轻Y")]
		ReduceItemWeight,
		[InspectorName("X技能使用次数增加Y")]
		AddSkillUseCount,
		[InspectorName("钩爪基础速度加快X")]
		SpeedUpHook,
		[InspectorName("X钩爪捕获半径增加X")]
		AddHookRadius,
		[InspectorName("钩爪抓取重物的系数k增加X")]
		AddHookK,
		[InspectorName("当前层时间增加X秒")]
		AddTimeInFloor,
		[InspectorName("带X标签的卡的在卡池中的权重提升Y%")]
		LabelAddPercentage,
		[InspectorName("增加buff刷新次数")]
		AddBuffRefreshCount
	}

	public enum GoldenSpyBuffQty
	{

	}

	public enum GoldenSpyBuffType
	{
		[InspectorName("临时增益")]
		TemporaryBuff = 1,
		[InspectorName("延迟增益")]
		DelayBuff,
		[InspectorName("永久增益")]
		PermanentBuff,
		[InspectorName("技能次数增益")]
		SkillCountBuff
	}

	public enum GoldenSpyItem
	{
		[InspectorName("公文包")]
		FileBag = 1,
		[InspectorName("家具")]
		Furniture,
		[InspectorName("宝石")]
		Gem,
		[InspectorName("情报卷轴")]
		IntelligenceScroll,
		[InspectorName("芯片装置")]
		ChipDevice,
		[InspectorName("保险箱")]
		SafeBox,
		[InspectorName("巡逻兵")]
		Patrol,
		[InspectorName("同行兵")]
		Companion,
		[InspectorName("爆炸物")]
		Boom,
		[InspectorName("Buff道具")]
		BuffItem
	}

	public enum GoldenSpyObstacle
	{
		[InspectorName("激光装置")]
		Laser = 1
	}

	public enum GoldenSpySkillType
	{
		[InspectorName("爆炸")]
		Boom = 1,
		[InspectorName("冰冻")]
		Frozen,
		[InspectorName("捕鱼钩爪")]
		FishingHook
	}

	public enum CharRechargeSpeed
	{
		[InspectorName("超高")]
		SupHigh = 1,
		[InspectorName("高")]
		High,
		[InspectorName("中")]
		Mid,
		[InspectorName("低")]
		Low
	}

	public enum CharEnergyCostSpeed
	{
		[InspectorName("超高")]
		SupHigh = 1,
		[InspectorName("高")]
		High,
		[InspectorName("中")]
		Mid,
		[InspectorName("低")]
		Low
	}

	public enum EnterMethod
	{
		[InspectorName("默认流程")]
		Default,
		[InspectorName("跳过编队")]
		JumpFormation,
		[InspectorName("跳过编队暂停")]
		JumpFormationPause
	}

	public enum MainlineMemoryNodeType
	{
		[InspectorName("无")]
		None,
		[InspectorName("唱片")]
		DiscType,
		[InspectorName("终局")]
		LastEndType
	}

	public enum ChessRarity
	{
		[InspectorName("白")]
		White = 1,
		[InspectorName("绿")]
		Green,
		[InspectorName("蓝")]
		Blue,
		[InspectorName("紫")]
		Purple,
		[InspectorName("橙")]
		Gold,
		[InspectorName("彩")]
		Color
	}

	public enum ChessType
	{
		[InspectorName("出战支援")]
		Balance,
		[InspectorName("出战")]
		Vanguard,
		[InspectorName("支援")]
		Support
	}

	public enum ChessAssistOnStageType
	{
		[InspectorName("进攻登场")]
		Front,
		[InspectorName("防御登场")]
		Back,
		[InspectorName("不登场")]
		NotAppearing
	}

	public enum ChessPartnerType
	{
		[InspectorName("空白旅团")]
		KongBaiLvTuan = 1,
		[InspectorName("万送屋")]
		WanSongWu,
		[InspectorName("花令旅团")]
		HuaLingLvTuan,
		[InspectorName("恩赐意志")]
		EnCiYiZhi,
		[InspectorName("机器人")]
		JiQiRen,
		[InspectorName("帝国卫队")]
		DiGuoWeiDui,
		[InspectorName("地理协会")]
		DiLiXieHui,
		[InspectorName("自由旅人")]
		ZiYouLvRen,
		[InspectorName("灰风俱乐部")]
		HuiFengJuLeBu,
		[InspectorName("联合种业")]
		LianHeZhongYe,
		[InspectorName("森林朋友")]
		SenLinPengYou,
		[InspectorName("夏洛克")]
		XiaLuoKe,
		[InspectorName("生存达人")]
		ShengCunDaRen,
		[InspectorName("沐浴恩典")]
		MuYuEnDian,
		[InspectorName("百步穿杨")]
		BaiBuChuanYang,
		[InspectorName("巅峰战士")]
		DianFengZhanShi,
		[InspectorName("魅力满溢")]
		MeiLiManYi,
		[InspectorName("人多势众")]
		RenDuoShiZhong,
		[InspectorName("摸鱼")]
		MoYu,
		[InspectorName("龙裔")]
		LongYi,
		[InspectorName("白猫剧团")]
		BaiMaoJuTuan,
		[InspectorName("沙蝎佣兵团")]
		ShaXieYongBingTuan,
		[InspectorName("黎明近卫")]
		LiMingJinWei,
		[InspectorName("航海家")]
		HangHaiJia,
		[InspectorName("王牌特工")]
		WangPaiTeGong,
		[InspectorName("指挥官")]
		ZhiHuiGuan,
		[InspectorName("绮丽魔法")]
		QiLiMoFa,
		[InspectorName("火力压制")]
		HuoLiYaZhi,
		[InspectorName("学富五车")]
		XueFuWuChe,
		[InspectorName("美食鉴赏家")]
		MeiShiJianShangJia,
		[InspectorName("骑士精神")]
		QiShiJingShen,
		[InspectorName("武器大师")]
		WuQiDaShi,
		[InspectorName("守夜人")]
		ShouYeRen,
		[InspectorName("搞个大新闻")]
		GaoGeDaXinWen,
		[InspectorName("千变忍者")]
		QianBianRenZhe,
		[InspectorName("忍道传承")]
		RenDaoChuanCheng,
		[InspectorName("本尊驾到")]
		BenZunJiaDao
	}

	public enum ActivityIceCreamLevelType
	{
		[InspectorName("教学")]
		Teaching = 1,
		[InspectorName("普通")]
		Common,
		[InspectorName("进阶")]
		Advanced,
		[InspectorName("无限")]
		Infinite
	}

	public enum IceBuffEffect
	{
		[InspectorName("时间")]
		Time = 1,
		[InspectorName("耐心")]
		Patience,
		[InspectorName("分数")]
		Score,
		[InspectorName("生命")]
		HP,
		[InspectorName("接单")]
		Order
	}

	public enum iceChar
	{
		[InspectorName("角色")]
		NormalChar = 1,
		[InspectorName("杂鱼")]
		Low,
		[InspectorName("特殊角色")]
		SpecialChar
	}

	public enum iceOption
	{
		[InspectorName("蛋筒")]
		Cone = 1,
		[InspectorName("冰淇淋球")]
		IceBall,
		[InspectorName("淋酱")]
		Topping
	}

	public enum soldierNodeType
	{
		[InspectorName("特殊事件")]
		Event = 1,
		[InspectorName("战斗")]
		Battle,
		[InspectorName("阶段Boss战")]
		MidBossBattle,
		[InspectorName("终局Boss战")]
		FinalBossBattle,
		[InspectorName("木桩关")]
		CheckStage
	}

	public enum soldierEventType
	{
		[InspectorName("终局Boss")]
		FinalBossBattle = 1,
		[InspectorName("阶段Boss")]
		MidBossBattle,
		[InspectorName("普通战斗")]
		NormalBattle,
		[InspectorName("解决争端")]
		BattleOptions,
		[InspectorName("性格剧情")]
		StoryPersonality,
		[InspectorName("代价剧情")]
		StoryCost,
		[InspectorName("木桩关")]
		CheckStage
	}

	public enum soldierLevelName
	{
		[InspectorName("简单")]
		Simple = 1,
		[InspectorName("中等")]
		Medium,
		[InspectorName("困难")]
		Difficult,
		[InspectorName("噩梦")]
		Nightmare
	}

	public enum soldierCardUnloadType
	{
		[InspectorName("通关X挑战关")]
		GradeChallengeClear = 1,
		[InspectorName("在X节点及以后")]
		FromNodeOnwards,
		[InspectorName("在X阶段")]
		AtStage,
		[InspectorName("在X阶段及以后")]
		FromStageOnwards
	}

	public enum SoldierPositionType
	{
		[InspectorName("出战位")]
		FightPosition = 1,
		[InspectorName("应援位")]
		SupportPosition
	}

	public enum TraceHuntLogType
	{
		[InspectorName("追踪开始")]
		TraceStart = 1,
		[InspectorName("追踪过程")]
		Tracing,
		[InspectorName("追踪结束前")]
		TraceBeforeEnd,
		[InspectorName("追踪结束")]
		TraceEnd,
		[InspectorName("追踪中断")]
		TraceInterrupt,
		[InspectorName("追踪重开")]
		TraceRestart,
		[InspectorName("讨伐开始前")]
		HuntBeforeStart,
		[InspectorName("讨伐开始")]
		HuntStart,
		[InspectorName("玩家讨伐")]
		HuntPlayer,
		[InspectorName("NPC讨伐")]
		HuntNPC,
		[InspectorName("玩家致命讨伐")]
		HuntPlayerFatal,
		[InspectorName("NPC致命讨伐")]
		HuntNPCFatal,
		[InspectorName("讨伐结束")]
		HuntEnd,
		[InspectorName("结算")]
		Settlement,
		[InspectorName("讨伐第一刀后")]
		HuntAfterStart,
		[InspectorName("讨伐中断")]
		HuntInterrupt
	}

	public enum TDLevelGamePlayType
	{
		[InspectorName("无")]
		None = 1,
		[InspectorName("炎热")]
		Hot,
		[InspectorName("光暗")]
		Dark
	}

	public enum SoldierPartnerNumType
	{
		[InspectorName("大于等于")]
		GE = 1,
		[InspectorName("等于")]
		EQ
	}

	public enum SoldierClientCond
	{
		[InspectorName("无")]
		None = 1,
		[InspectorName("X羁绊类型的棋子")]
		Partner,
		[InspectorName("X位置的棋子")]
		PositionType,
		[InspectorName("棋子上场X个")]
		SoldierCount,
		[InspectorName("棋子达到X星")]
		SoldierLevel,
		[InspectorName("X个Y属性最大的棋子")]
		SoldierAttr,
		[InspectorName("指定X棋子")]
		SoldierId,
		[InspectorName("已激活羁绊数量X个")]
		PartnerCount
	}

	public enum SoldierClientEffectTarget
	{
		[InspectorName("无")]
		None,
		[InspectorName("全员")]
		All,
		[InspectorName("X羁绊棋子")]
		Partner,
		[InspectorName("指定X棋子")]
		SoldierId
	}

	public enum SoldierClientEffect
	{
		[InspectorName("无")]
		None = 1,
		[InspectorName("X属性固定值提升Y")]
		AmendAttr,
		[InspectorName("X属性百分比提升Y")]
		PercentAmendAttr,
		[InspectorName("显示标签")]
		PartnerTag,
		[InspectorName("进战斗X属性减半")]
		BattleAttrHalve,
		[InspectorName("X属性基础固定值提升Y")]
		BaseAmendAttr,
		[InspectorName("X属性基础百分比提升Y")]
		BasePercentAmendAttr
	}

	public enum soldierEffectLifecycleType
	{
		[InspectorName("立即")]
		IMMEDIATE,
		[InspectorName("条件")]
		CONDITIONAL,
		[InspectorName("永久")]
		PERMANENT
	}

	public enum soldierBuffCond
	{
		[InspectorName("进入节点X次")]
		EnterNodeCountEqual = 1,
		[InspectorName("接下来X个Y类型节点")]
		NextNodeType,
		[InspectorName("战斗X次")]
		BattleCount,
		[InspectorName("战斗胜利X次")]
		BattleVictoryCount,
		[InspectorName("战斗失败X次")]
		BattleDefeatCount,
		[InspectorName("战斗连续胜利X次")]
		BattleContinuousVictoryCount,
		[InspectorName("战斗连续失败X次")]
		BattleContinuousDefeatCount,
		[InspectorName("商店刷新X次")]
		ShopRefreshCount,
		[InspectorName("商店购买X个Y棋子")]
		ShopPurchaseChess,
		[InspectorName("商店购买X个Y费棋子")]
		ShopPurchaseChessCost,
		[InspectorName("商店购买X个Y羁绊棋子")]
		ShopPurchaseChessPartner,
		[InspectorName("商店购买X个Y类型棋子")]
		ShopPurchaseChessType,
		[InspectorName("商店出售X个棋子")]
		ShopChessSell,
		[InspectorName("商店购买X次经验")]
		ShopPurchaseExpCount,
		[InspectorName("获得X资源Y数量")]
		ResAdd,
		[InspectorName("消耗X资源Y数量")]
		ResDeduct,
		[InspectorName("声望大于X")]
		HpGreaterThan,
		[InspectorName("声望小于X")]
		HpLessThan,
		[InspectorName("指定X棋子合成Y星")]
		ChessMergeSpecificStar,
		[InspectorName("合成X星Y费棋子")]
		ChessMergeSpecificStarWithCost,
		[InspectorName("合成X星Y类型棋子")]
		ChessMergeSpecificStarWithType,
		[InspectorName("合成X星Y羁绊棋子")]
		ChessMergeSpecificStarWithPartner,
		[InspectorName("接下来X个节点")]
		NextNode
	}

	public enum soldierBuffEffect
	{
		[InspectorName("获得X个Y资源")]
		GainItem = 1,
		[InspectorName("获得指定的棋子X")]
		ChessAdd,
		[InspectorName("随机获得X个Y羁绊的棋子")]
		ChessAddPartner,
		[InspectorName("增加X点声望")]
		HpAdd,
		[InspectorName("减少X点声望")]
		HpDeduct,
		[InspectorName("声望设置为X值")]
		HpSet,
		[InspectorName("商店有X概率获得Y次免费刷新")]
		ShopRandomFreeRefresh,
		[InspectorName("商店禁止购买")]
		ShopDisablePurchase,
		[InspectorName("商店禁止刷新")]
		ShopDisableRefresh,
		[InspectorName("已X倍价格出售场上所有棋子")]
		ChessDeploySell,
		[InspectorName("已经激活的羁绊达成计数加X")]
		PartnerActivateAddCount,
		[InspectorName("指定羁绊X计数加Y")]
		PartnerSpecificAddCount,
		[InspectorName("节点类型X变更为Y且对应Z事件池")]
		NodeTypeModify,
		[InspectorName("获得商店经验X")]
		ShopAddExp,
		[InspectorName("背包中资源X设置为Y值")]
		ResSet,
		[InspectorName("随机获得X个Y星级的棋子")]
		RandomChessAddByStar,
		[InspectorName("随机获得X个Y星级Z费用的棋子")]
		RandomChessAddByStarAndCost,
		[InspectorName("随机获得X个Y类型的棋子")]
		RandomChessAddByType,
		[InspectorName("商店刷新费用减X")]
		ShopRefreshDiscount,
		[InspectorName("商店购买经验费用减X")]
		ShopPurchaseExpDiscount,
		[InspectorName("后续每次获得X资源时变为Y倍")]
		GainResScale,
		[InspectorName("立即把当前持有的X资源变为Y倍")]
		HoldResScale,
		[InspectorName("商店随机品质权重翻倍")]
		ShopRandomRarityWeightDouble,
		[InspectorName("获取优势骰子")]
		GetTwoDice,
		[InspectorName("随机到的所有小buff卡均为X品质")]
		RandomStrategyCardSpecificRarity,
		[InspectorName("备战席最左侧的棋子随机变为等费等星的其他棋子")]
		LeftmostWaitingChessChange,
		[InspectorName("备战席左侧的X费棋子随机变为等费等星的其他棋子")]
		LeftmostWaitingChessSpecificCostChange,
		[InspectorName("使商店中随机角色变为高1费的另一个随机角色")]
		ShopRandomChessBecomeAnotherHigherCost,
		[InspectorName("交换声望和金币")]
		ExchangeHpAndGold,
		[InspectorName("商店X概率出现Y星棋子最多Z个")]
		ShopGoodsProbabilityBecomingHigherStar,
		[InspectorName("X羁绊棋子的权重提高Y")]
		ChessWeightUpWithSpecificPartner,
		[InspectorName("客户端属性效果")]
		ClientEffectAttr,
		[InspectorName("客户端丰收效果")]
		ClientEffectHarvest,
		[InspectorName("增加X点利息上限")]
		InterestLimitAdd,
		[InspectorName("增加X次祝福卡重随")]
		CardReRollAddCount,
		[InspectorName("骰子加成点数")]
		DiceAddPoint,
		[InspectorName("商店有X概率获得Y次临时免费刷新")]
		ShopRandomTempFreeRefresh,
		[InspectorName("羁绊增加商店经验")]
		PartnerAddShopExp,
		[InspectorName("获得指定资源并增加等量丰收")]
		HarvestAddRes,
		[InspectorName("根据连败次数获得资源和丰收")]
		HarvestBattleDefeatAddRes,
		[InspectorName("客户端加金币")]
		ClientEffectAddGold
	}

	public enum soldierBuffEvent
	{
		[InspectorName("进入节点")]
		EnterNode = 1,
		[InspectorName("血量变化")]
		HpChange,
		[InspectorName("战斗事件")]
		Battle,
		[InspectorName("棋盘变化")]
		Deploy,
		[InspectorName("商店购买")]
		ShopPurchase,
		[InspectorName("商店升级")]
		ShopUpgrade,
		[InspectorName("商店刷新")]
		ShopRefresh,
		[InspectorName("商店出售")]
		ShopSell,
		[InspectorName("资源变化")]
		ResChange,
		[InspectorName("棋子合成")]
		ChessMerge,
		[InspectorName("客户端事件(非配置值)")]
		Client
	}

	public enum soldierBuffState
	{
		[InspectorName("接下来X个节点")]
		NextNodes = 1,
		[InspectorName("仅当前节点")]
		CurrentNode,
		[InspectorName("仅当前阶段")]
		CurrentStage,
		[InspectorName("当前节点之后")]
		CurrentNodeAfter,
		[InspectorName("检查节点")]
		CheckNode,
		[InspectorName("检查阶段")]
		CheckStage,
		[InspectorName("检查节点类型")]
		CheckNodeType,
		[InspectorName("检查声望")]
		CheckHp,
		[InspectorName("检查代币")]
		CheckRes,
		[InspectorName("检查商店等级")]
		CheckShopLevel,
		[InspectorName("检查棋盘羁绊棋子数量")]
		CheckDeployChessByPartner,
		[InspectorName("检查棋盘类型棋子数量")]
		CheckDeployChessByType,
		[InspectorName("检查棋盘费用棋子数量")]
		CheckDeployChessByCost,
		[InspectorName("检查棋盘指定棋子数量")]
		CheckDeployChessById,
		[InspectorName("检查战斗结果")]
		CheckBattleResult,
		[InspectorName("检查战斗次数")]
		CheckBattleCount,
		[InspectorName("检查商店刷新次数")]
		CheckShopRefreshCount,
		[InspectorName("检查消耗资源数量")]
		CheckResConsume,
		[InspectorName("检查获得资源数量")]
		CheckResObtain
	}

	public enum PartnerLevelQuality
	{
		[InspectorName("无")]
		None,
		[InspectorName("铜")]
		Copper,
		[InspectorName("银")]
		Silver,
		[InspectorName("金")]
		Gold,
		[InspectorName("彩")]
		Color,
		[InspectorName("特殊")]
		Special
	}

	public enum SoldierCharacterType
	{
		[InspectorName("旅人")]
		Actor = 1,
		[InspectorName("怪物")]
		Monster
	}

	public enum ActivityPenguinCardLevelType
	{
		[InspectorName("普通")]
		Normal = 1,
		[InspectorName("无尽")]
		Endless
	}

	public enum EventReminderType
	{
		[InspectorName("真格挑战")]
		WeeklyCopies = 1,
		[InspectorName("灾变防线")]
		Vampire,
		[InspectorName("联合讨伐")]
		ScoreBoss,
		[InspectorName("星塔探索")]
		StarTower,
		[InspectorName("猎影合围")]
		TraceHunt
	}

	public enum CharGemInstanceRewardType
	{
		[InspectorName("基础")]
		General = 1,
		[InspectorName("增强")]
		Enhance
	}

	public enum CharGemInstanceDropGuarantee
	{
		[InspectorName("通关圆桌掉落保底")]
		RoundTableGuarantee = 1,
		[InspectorName("通关依次掉落保底")]
		SequentialGuarantee
	}

	public enum DormRoomType
	{
		[InspectorName("室外")]
		Outdoor,
		[InspectorName("室内")]
		Indoor
	}

	public enum DormRoomSizeType
	{
		[InspectorName("室外尺寸1")]
		OutdoorSize1,
		[InspectorName("室内尺寸1")]
		IndoorSize1
	}

	public enum DormFurType
	{
		[InspectorName("地上")]
		OnFloor,
		[InspectorName("墙上")]
		OnWall,
		[InspectorName("地毯")]
		Carpet,
		[InspectorName("海报")]
		Poster,
		[InspectorName("墙纸")]
		Wall,
		[InspectorName("地板")]
		Floor,
		[InspectorName("地上+地毯(水池)")]
		FloorCarpet,
		[InspectorName("地上+海报(电梯)")]
		FloorPoster
	}

	public enum DormFurFixedType
	{
		[InspectorName("无")]
		None,
		[InspectorName("墙纸")]
		Wall,
		[InspectorName("地板")]
		Floor,
		[InspectorName("娃娃机")]
		Doll,
		[InspectorName("饮料机")]
		Drink,
		[InspectorName("电梯")]
		Elevator
	}

	public enum DormFurRotate
	{
		[InspectorName("默认")]
		None,
		[InspectorName("转90")]
		Quarter,
		[InspectorName("转180")]
		Half,
		[InspectorName("转270")]
		Quarter3
	}

	public enum DormRoleType
	{
		[InspectorName("魔王")]
		MoWang,
		[InspectorName("旅人")]
		Character,
		[InspectorName("NPC")]
		NPC
	}

	public enum DormRewardType
	{
		[InspectorName("普通")]
		Normal,
		[InspectorName("体力")]
		Entry
	}

	public enum DormConditionType
	{
		[InspectorName("房间")]
		Room = 1,
		[InspectorName("家具")]
		Furniture,
		[InspectorName("角色")]
		Role
	}

	public enum DormInterType
	{
		[InspectorName("通用交互")]
		Common = 1,
		[InspectorName("专用交互")]
		Approproative
	}

	public enum DormAchievementType
	{
		[InspectorName("家具收集度")]
		FurnitureCollectionValue = 1
	}

	public enum ActivityStoryPreviewType
	{
		[InspectorName("无")]
		None,
		[InspectorName("主线")]
		MainlineStory,
		[InspectorName("故事集")]
		StorySet,
		[InspectorName("活动剧情")]
		ActivityStory
	}

	public enum MathParkourObjectType
	{
		[InspectorName("敌人")]
		Enemy = 1,
		[InspectorName("受困旅人")]
		TrappedActor,
		[InspectorName("加速传送带")]
		AccelerationConveyor,
		[InspectorName("减速传送带")]
		DecelerationConveyor,
		[InspectorName("特殊传送带")]
		SpecialConveyor,
		[InspectorName("增益道具")]
		BenefitItem,
		[InspectorName("Boss")]
		Boss,
		[InspectorName("墙")]
		Wall
	}

	public enum MathParkourBuffType
	{
		[InspectorName("火箭")]
		Rocket = 1,
		[InspectorName("钻头")]
		Drill,
		[InspectorName("锯子")]
		Saw,
		[InspectorName("护盾")]
		Shield,
		[InspectorName("旅人A")]
		ActorA,
		[InspectorName("旅人B")]
		ActorB,
		[InspectorName("旅人C")]
		ActorC,
		[InspectorName("红色按钮")]
		Boom
	}

	public enum TowerVitaOptionCategories
	{
		[InspectorName("潜能设置")]
		Potential = 1,
		[InspectorName("商店设置")]
		Shop,
		[InspectorName("事件选择")]
		Event
	}

	public enum TowerVitaOptionType
	{
		[InspectorName("开关")]
		Switch = 1,
		[InspectorName("多选一")]
		Selector,
		[InspectorName("下拉菜单")]
		DropList,
		[InspectorName("数量选择器")]
		NumberInput,
		[InspectorName("排序列表")]
		SortTableList
	}

	public enum SoldierTechNodeType
	{
		[InspectorName("无")]
		None,
		[InspectorName("核心机制")]
		Core,
		[InspectorName("属性提升")]
		Attribute,
		[InspectorName("魔王能力")]
		BossAbility
	}

	public enum SoldierTechBattleEffect
	{
		[InspectorName("无")]
		None,
		[InspectorName("最终伤害提升")]
		FinalDamageUp,
		[InspectorName("最终减伤提升")]
		FinalDamageReduceUp,
		[InspectorName("技能暴击率提升")]
		SkillCritRateUp,
		[InspectorName("技能伤害提升")]
		SkillFinalDamageUp
	}

	public enum ShopType
	{
		[InspectorName("无")]
		None,
		[InspectorName("常驻商店")]
		Resident,
		[InspectorName("GuideMission商店")]
		GuideMission
	}

	public enum SoldierTechBattleBuffTarget
	{
		[InspectorName("全体")]
		All,
		[InspectorName("我方")]
		Team,
		[InspectorName("敌方")]
		Enemy
	}

	public enum SoldierPersonalityGrade
	{
		[InspectorName("S")]
		PersonalityGrade_1 = 1,
		[InspectorName("A+")]
		PersonalityGrade_2,
		[InspectorName("A")]
		PersonalityGrade_3,
		[InspectorName("B+")]
		PersonalityGrade_4,
		[InspectorName("B")]
		PersonalityGrade_5,
		[InspectorName("C+")]
		PersonalityGrade_6,
		[InspectorName("C")]
		PersonalityGrade_7
	}

	public enum SoldierRolePersonality
	{
		[InspectorName("直觉")]
		Personality_Intuition = 1,
		[InspectorName("分析")]
		Personality_Analysis,
		[InspectorName("混沌")]
		Personality_Chaos
	}

	public enum SoldierRoleSkillType
	{
		[InspectorName("棋盘被动")]
		SoldierRoleSkillType_1 = 1,
		[InspectorName("棋盘主动")]
		SoldierRoleSkillType_2,
		[InspectorName("战场被动")]
		SoldierRoleSkillType_3,
		[InspectorName("战场主动")]
		SoldierRoleSkillType_4
	}

	public enum SoldierSeason
	{
		[InspectorName("无")]
		None,
		[InspectorName("一赛季")]
		S1
	}

	public enum SoldierStoryOptionCond
	{
		[InspectorName("魔王X维度达到Y级")]
		BossPersonalityGrade = 1,
		[InspectorName("本局内选择过前置选项X")]
		OptionChosenInRun,
		[InspectorName("X结局已解锁")]
		EndingUnlocked,
		[InspectorName("解锁段位X")]
		GradeLevelUnlocked,
		[InspectorName("拥有金币大于等于X")]
		CoinUnlocked,
		[InspectorName("理智大于X")]
		HpUnlocked
	}

	public enum SoldierStoryRewardType
	{
		[InspectorName("获得X资源Y个")]
		GainItem = 1,
		[InspectorName("获得X个Y星棋子；Z费权重提升A")]
		GainChessStarCostWeight,
		[InspectorName("获得X个Y费棋子")]
		GainChessByCost,
		[InspectorName("获得X个Y星棋子；Z羁绊棋子权重提升A")]
		GainChessStarPartnerWeight,
		[InspectorName("获得X个祝福，Y品质祝福权重提升A")]
		GainCardQualityWeight,
		[InspectorName("获得X个Y品质祝福")]
		GainCardByQuality,
		[InspectorName("恢复X点理智(上限100)")]
		RecoverHp,
		[InspectorName("获得隐形卡")]
		GainHiddenCard,
		[InspectorName("失去X点理智(不够不让选)")]
		LoseHp,
		[InspectorName("损失X资源Y个(不够不让选)")]
		LoseItem,
		[InspectorName("损失当前所有金币")]
		LoseAllCoin
	}

	public enum EndingCondition
	{
		[InspectorName("战胜终局BOSS")]
		FinalBossDefeated = 1,
		[InspectorName("未战胜终局BOSS")]
		FinalBossNotDefeated
	}

	public enum SoldierStoryCondFailMode
	{
		[InspectorName("隐藏")]
		Hide = 1,
		[InspectorName("置灰")]
		Disable
	}

	public enum SoldierStoryResultType
	{
		[InspectorName("默认结果")]
		Default = 1,
		[InspectorName("失败结果")]
		Fail
	}

	public enum PartnerCatalogue
	{
		[InspectorName("阵营")]
		Camp = 1,
		[InspectorName("流派")]
		Style
	}

	public enum EventOptionTag
	{
		[InspectorName("稳定")]
		Preservative = 1,
		[InspectorName("标准")]
		Standard,
		[InspectorName("激进")]
		Aggresive,
		[InspectorName("正确答案")]
		Correct,
		[InspectorName("普通潜能")]
		PotentialCommon,
		[InspectorName("稀有潜能")]
		PotentialRare,
		[InspectorName("主控潜能")]
		PotentialMain,
		[InspectorName("援护潜能")]
		PotentialAssist,
		[InspectorName("随机潜能")]
		PotentialRandom,
		[InspectorName("随机音符")]
		NoteRandom,
		[InspectorName("强攻之音")]
		Note90011,
		[InspectorName("幸运之音")]
		Note90012,
		[InspectorName("暴发之音")]
		Note90013,
		[InspectorName("体力之音")]
		Note90014,
		[InspectorName("专注之音")]
		Note90015,
		[InspectorName("技巧之音")]
		Note90016,
		[InspectorName("绝招之音")]
		Note90017,
		[InspectorName("辉光币")]
		Coin
	}
}

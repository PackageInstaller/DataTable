SysParamType = {}

-- 体力初始化值
SysParamType.STAMINA_INIT_COUNT = 1
-- 初始战员（首次进入游戏的默认第一个战员id）
SysParamType.FIRST_HERO_ID = 41
-- 玩家第2个获得的战员（首次进入游戏获得的第2个战员id）
SysParamType.TWO_HERO_ID = 69
-- 玩家第3个获得的战员（首次进入游戏获得的第3个战员id）
SysParamType.THIRD_HERO_ID = 71

-- 金币副本每日挑战次数上限
SysParamType.DUP_MONEY_LIMIT_COUNT = 4
-- 体力购买每日上限
SysParamType.STAMINA_BUY_LIMIT = 5
-- 玩家最大等级
SysParamType.MAX_LEVET = 6
-- 玩家对应可编辑队列的数量上限
SysParamType.EDIT_TEAM_COUNT = 7
-- 单日高级招募最大招募上限
SysParamType.RECRUIT_TOP_DAILY_MAX = 9
-- 英雄最大怒气
SysParamType.MAX_RATE = 10

-- 竞技场挑战消耗道具id
SysParamType.ARENA_CHALLENGE_COST_TID = 12
-- 竞技场挑战消耗道具数量
SysParamType.ARENA_CHALLENGE_COST_COUNT = 18
-- 竞技场每日免费次数
SysParamType.ARENA_CHALLENGE_FREE_TIMES = 13
-- 竞技场排行榜最大名次显示
SysParamType.ARENA_RANK_MAX_RANK = 15

-- 战员传记副本单个最大挑战次数
SysParamType.BIOGRAPHY_CHAPTER_CHALLENGE_TIMES = 19

-- 好友列表上限
SysParamType.MAX_FRIEND_COUNT = 23
-- "竞技场定时更新间隔，单位：秒"
SysParamType.ARENA_REFRESH_TIME = 25
-- 血清最大上限
SysParamType.MAX_STAMINA = 33

-- 新手招募总次数
SysParamType.RECRUIT_NEW_PLAYER_TIMES = 35

-- 竞技场pvp默认战斗场景id
SysParamType.ARENA_DEF_SCENE_ID = 36
-- 竞技场pvp默认背景音乐id
SysParamType.ARENA_DEF_MUSIC_ID = 37
-- 兑换码最大输入位数
SysParamType.EXCHANGE_CODE_LEN = 38
-- 玩家签名最大长度
SysParamType.PLAYER_AUTOGRAPH_LEN = 39
-- 玩家昵称最大长度
SysParamType.PLAYER_NAME_LEN = 40
-- 玩家昵称输入上限
SysParamType.PLAYER_NAME_INPUT_LIMIT = 81
-- 竞技场第x回合可跳过
SysParamType.ARENA_JUMP_ROUND = 43
-- 黑名单上限
SysParamType.MAX_BLACK_COUNT = 40
-- 通用战员能达到的最大品质
SysParamType.COMMON_HERO_MAX_COLOR = 44
-- D卡战员能达到的最大品质
SysParamType.D_CARD_HERO_MAX_COLOR = 45
-- 升星所需战员品质
SysParamType.HERO_STAR_UP_NEED_COLOR = 46

-- 剧情淡出时长
SysParamType.STORY_FADE_OUT_TIME = 52
-- 剧情淡入时长
SysParamType.STORY_FADE_IN_TIME = 53
-- 锁定对话时长
SysParamType.STORY_LOCK_TALK_TIME = 54

-- 多少秒内发过x句以上的文字或者图片视作刷屏行为
SysParamType.CHAT_FORBID_LEGAL_COUNT = 58
-- x秒内发过3句以上的文字或者图片视作刷屏行为
SysParamType.CHAT_FORBID_LEGAL_TIME = 59
-- 禁止发言时间
SysParamType.CHAT_FORBID_CD_TIME = 60
-- 背包武器上限
SysParamType.EQUIP_MAX_COUNT = 62
-- 队伍名称长度
SysParamType.FORMATION_TEAM_NAME_LEN = 66
-- 主线隐藏的副本id
SysParamType.MAIN_MAP_HIDE_STAGE_ID = 67
--资源副本停留的时间弱引导
SysParamType.WEAKGUIDE_DUPTIMEOUTTIME = 70
-- 商店单个商品最大购买数量
SysParamType.SHOP_MAX_BUY_NUM = 73
--芯片副本前端刷新时间点
SysParamType.DUPCHIP_REFRESH = 75
--聊天语音消息字数上限
SysParamType.CHAT_VOICE_CHARACTER_LIMIT = 76
--当玩家拥有x个大于等于y级的战员后（读取杂项），战员列表不再显示关于战员升级的红点提示
SysParamType.HERO_LV_UP_RED_ASTRICT = 83
--异响回渊生效技能id
SysParamType.DUO_APO_SKILLID = 84
--上阵弹窗额外减值判断
SysParamType.FORMATION_TIP_OTHER_JUG = 86
--资源副本弱引导的主线解锁副本id
SysParamType.WEAKGUIDE_MAINSTAGEID = 91
--上阵弹窗额外减值判断
SysParamType.FORMATION_LOCK = 92

--公测登录活动天数，单位：天数
SysParamType.OPEN_BETA_DAYS = 93
--公测登录活动领取条件，通关主线id
SysParamType.OPEN_BETA_MAINSTAGE_ID = 94
--7日补给礼包(体力周卡)
SysParamType.DIRECT_BUY_STAMINA = 100
--技能升级红点判断等级需求，大于等于这个等级后技能升级不需要红点提示
SysParamType.HERO_SKILL_UP_RED_ASTRICT = 106
--模组方案数量上限
SysParamType.EQUIP_PLAN_MAX_COUNT = 108
--模组方案名字长度
SysParamType.EQUIP_PLAN_NAME_MAX_COUNT = 109

--消消乐自动提示时间间隔
SysParamType.ELIMINATE_AUTO_TIP_TIME = 110

--无限城跳过回合数
SysParamType.DOUNDLESS_FIGHT_SKIP = 114

--通行证模型查看角色tid,序号
SysParamType.PERMIT_MODEL_INFO = 115

SysParamType.HERO_RESONANCE_NEEDLVL = 117
--试玩活动红点是否显示在主题活动那边
SysParamType.MAINACITIVITY_TYPE = 118

--抽卡会检测是否需要下载额外资源
SysParamType.RECRUIT_CHECK_STAGE_DOWNLOAD = 119
--道具使用会检测是否需要下载额外资源
SysParamType.PROP_SELECT_USE_CHECK_DOWNLOAD = 120

--主题活动那边关联的卡池id，如果为0则不显示按钮
SysParamType.MAINACTIVITY_TRIAL_RECRUITID = 124

--战员重置等级消耗配置
SysParamType.HERO_RESET_LV_COST = 196

--主界面弹脸7
SysParamType.MAIN_BANNER_PROMO4_ID = 197

-- 手环精炼上限
SysParamType.BRACELETS_UPPER_LIMIT = 506
-- 盟约声望最大等级
SysParamType.COVENANT_MAXLV = 710
-- 盟约声望最大等级
SysParamType.COVENANT_MAXLV = 710
-- 迷宫小模型tid
SysParamType.MAZE_MODEL_TID = 857

-- 号芯片对应安装槽位开启所需军阶
SysParamType.EQUIP_NEED_MILITART_LVL = 921

-- 最大战员助战数量
SysParamType.MAX_HERO_ASSIST_COUNT = 1401

-- 锚点空间遇怪效果帧数
SysParamType.MAIN_EXPLORE_FIGHT_EFFECT_TIME = 1709

-- 剧情加速 第一档
SysParamType.STORY_LOGNG_SPEED_1 = 1851
-- 剧情加速 第二档
SysParamType.STORY_LOGNG_SPEED_2 = 1852
-- 剧情加速 第三档
SysParamType.STORY_LOGNG_SPEED_3 = 1853
-- 剧情加速 第四档
SysParamType.STORY_LOGNG_SPEED_4 = 1854

--使用道具上限
SysParamType.MAX_USE_PROPS_COUNT = 1914
--单次选择上限
SysParamType.MAX_SELECT_COUNT = 1915

-- 装备强化材料一键添加的数量上限
SysParamType.EQUIP_MATERIAL_AUTO_COUNT = 2001
-- 完美格挡点击判定时间段，单位：毫秒
SysParamType.BLOCK_JUDGE_TIME = 3001
-- 格挡点击冷却时间，单位：毫秒
SysParamType.BLOCK_CD_TIME = 3003
-- 格挡成功慢镜头持续时间，单位：毫秒
SysParamType.BLOCK_CAMERA_TIME = 3005
-- 格挡成功慢镜头播放倍率，单位：万分比（0到10000之间）
SysParamType.BLOCK_SCALE_TIME = 3006
-- 格挡成功CD
SysParamType.BLOCK_SUCCESS_CD_TIME = 3009
-- 初始格挡值
SysParamType.BLOCK_INIT_VAL = 3010
-- 格挡值 普技能消耗
SysParamType.BLOCK_NOR_SKILL_EXPEND = 3011
-- 格挡值 终结消耗
SysParamType.BLOCK_MIX_SKILL_EXPEND = 3012
-- 格挡值 大招技能消耗
SysParamType.BLOCK_MAX_SKILL_EXPEND = 3013
-- 格挡值 普攻消耗
SysParamType.BLOCK_NOR_EXPEND = 3014
-- 普通格挡点击判定时间段，单位：毫秒
SysParamType.BLOCK_NOMAL_JUDGE_TIME = 3015
-- 中等格挡点击判定时间段，单位：毫秒
SysParamType.BLOCK_MEDIUM_JUDGE_TIME = 3017

-- 无限城放弃后再次挑战CD
SysParamType.CYCLE_ABANDON_RECHALLENGE_CD = 4511

--战斗默认设置
SysParamType.FIGHT_JUMP_CAMERA = 201
SysParamType.FIGHT_SHOW_HP = 202
SysParamType.FIGHT_SHOW_DAMAGE = 203
SysParamType.FIGHT_SHOW_UI = 204
SysParamType.FIGHT_QUEUE10 = 205
SysParamType.FIGHT_SHOW_PROFESSIONTYPE = 206
SysParamType.FIGHT_HIDE_INFO = 207

-- 资源本多倍挑战
SysParamType.DUP_MULTI = 401
-- 潜能本多倍挑战
SysParamType.DUP_POTENCY_MULTI = 402
-- 芯片本多倍挑战
SysParamType.DUP_CHIP_MULTI = 403
-- 资源副本多倍挑战数量和对应开启指挥官等级
SysParamType.DUP_ASSETS_MULTI = 405

-- 手环强化材料单次消耗的数量上限
SysParamType.BRACELET_MATERIAL_MAX_COUNT = 504
-- 手环强化材料一键添加的数量上限
SysParamType.BRACELET_MATERIAL_AUTO_COUNT = 505

-- 希望副本战员初始耐力
SysParamType.CODE_HOPE_HERO_MAX_STAMINA = 601
-- 大于关卡推荐等级*该系数则为安全，单位：万分比
SysParamType.CODE_HOPE_DANGER_NUM_1 = 603
-- 小于关卡推荐等级*该系数则为危险，单位：万分比
SysParamType.CODE_HOPE_DANGER_NUM_2 = 604

-- 每名盟约助手最多协助战员数
SysParamType.COVENANT_HELP_HERO_NUM = 702

-- 单次盟约派遣事件刷新消耗
SysParamType.COVENANT_REFLASH_PAY = 711
-- 模拟训练精英数据上限
SysParamType.TRAINING_MAX_ELITE = 901
-- 模拟训练收益存储上限分钟
SysParamType.TRAINING_MAX_MINUTE = 902
-- 模拟训练收益红点提示时间分钟
SysParamType.TRAINING_BUBBLE_TIP_TIME = 903
-- 亲密度上限
SysParamType.MAX_FAVORABLE_LV = 831
-- 主角自带迷雾光源范围
SysParamType.MAZE_PLAYER_FOG_LIGHT_RANGE = 853
-- 1到3格模型移动速率，百分比
SysParamType.MAZE_PLAYER_SPEED_RATE_3 = 854
-- 4到7格模型移动速率，百分比
SysParamType.MAZE_PLAYER_SPEED_RATE_7 = 855
-- 8格以上模型移动速率，百分比
SysParamType.MAZE_PLAYER_SPEED_RATE_8 = 856
--迷宫冰面移动速率,百分比
SysParamType.MAZE_PLAYER_SPEED_RATE_ICE = 858

-- 每周任务获取通行证经验上限（周一5点刷新）
SysParamType.PERMIT_UP_LIMIT_EXP = 861
-- 1级对应消耗x钻石
SysParamType.UP_NEED_DIAMOND = 862
-- 98元档直升等级
SysParamType.PERMIT_UP_LV_98 = 863
-- 98元档额外奖励包
SysParamType.PERMIT_UP_EXTRA_AWARD_98 = 864

-- 月卡持续天数
SysParamType.MONTY_CARD_DAYS = 871
-- 月卡限购数量
SysParamType.MONTY_CARD_LIMIT_BUY_TIMES = 872
-- 立即获得货币数量
SysParamType.MONTY_CARD_QUICKLY_GET = 873
-- 每日可领货币数量
SysParamType.MONTY_CARD_DAILY_GET = 874
-- 月卡不足天数时出现提示
SysParamType.MONTY_CARD_REMAIN_DAYS_TIP = 875
-- 月卡购买对应货币tid
SysParamType.MONTY_CARD_MONEY_TID = 876
-- 源晶辉锭道具ID
SysParamType.MONTY_CARD_QUICKLY_MONEY_ID = 877
-- 额外赠送的道具id
SysParamType.MONTY_CARD_EXTRAGIFT_TID = 878
-- 额外赠送的道具数量
SysParamType.MONTY_CARD_EXTRAGIFT_NUM = 879

-- 宿舍过载值
SysParamType.DORMITORY_QUOTA = 953
SysParamType.DORMITORY_BUBBLESHOWTIME = 962
SysParamType.DORMITORY_BUBBLECDTIME = 963
SysParamType.DORMITORY_MAXAURA = 5006
SysParamType.DORMITORY_INITAURA = 5005

--3倍速开启条件，指挥官等级
SysParamType.FIGHT_SETUP_TIMES_3 = 1207

--产能每日购买次数
SysParamType.CAPACITY_EVERDAY_BUY_TIMES = 1501
--产能单次购买数量
SysParamType.CAPACITY_ONCE_BUY_NUMS = 1502
--每产能抵消秒数
SysParamType.PER_CAPACITY_COST_SEC = 1503
--每多少秒恢复1点产能
SysParamType.CAPACITY_PERSECOND_RESTORE_NUMS = 1504
--原料背包上限
SysParamType.BAG_MATERIAL_CEILING_NUMS = 1505
--购买产能花费洛德币数量
SysParamType.CAPACITY_COST_NEED_NUMS = 1506
--产能上限
SysParamType.CAPACITY_MAXIMUMS_NUMS = 1507
--匹配时间下限
SysParamType.MATCHIMGTIME_MINTIME = 1601
--匹配时间上限
SysParamType.MATCHIMGTIME_MAXTIME = 1602

--巅峰竞技场购买材料
SysParamType.PVP_HELL_BUY_TID = 1615
--巅峰竞技场购买材料数量
SysParamType.PVP_HELL_BUY_NUM = 1616
--巅峰竞技场每日免费挑战次数
SysParamType.PVPHELL_TIMERS = 1617
--巅峰竞技场最大购买次数
SysParamType.PVP_HELL_MAX = 1633
--刷新时间
SysParamType.PVPHELL_REFRESH_TIMERS = 1634

--进入探索地图场景后保护时间，单位：秒
SysParamType.MAIN_EXPLORE_PROTECT_TIME = 1705
--进入地图场景后定时同步的时间间隔，单位：秒
SysParamType.MAIN_EXPLORE_SYNC_TIME = 1706
--进入探索地图场景后椭圆提示的半长轴
SysParamType.MAIN_EXPLORE_TIP_OVAL_BIG = 1707
--进入探索地图场景后椭圆提示的半短轴"
SysParamType.MAIN_EXPLORE_TIP_OVAL_SMALL = 1708

--模组改造最大可选属性数量
SysParamType.REMAAKE_MAX_SELECT_TYPE1 = 1916
--模组改造最大可选品质数量
SysParamType.REMAAKE_MAX_SELECT_TYPE2 = 1917

-- 基建疲劳上限
SysParamType.BUILD_BASE_STAMINA = 5001
-- 发电站生产效率【数量， 多少秒】
SysParamType.BUILD_BASE_PRODUCE = 5002
-- 无人机持有上限
SysParamType.UAVTOPLIMIT = 5003
-- 每点体力可购买无人机数量
SysParamType.UAVBUYNUM = 5004

--舒适度上限
SysParamType.COMFORTMAX = 5006
-- 工厂订单上限
SysParamType.FACPRODUCELIMIT = 5008
-- 无人机减少时间 s
SysParamType.UAVREDUCETIME = 5009
-- 无人机减少时间  array
SysParamType.MAXDISPATCHTIMES = 5010
-- 前端天赋等级上限判定
SysParamType.TALENTCEILING = 5101
-- 前端技能等级上限判定
SysParamType.SKILLCEILING = 5102
-- 前端R卡天赋等级上限判定
SysParamType.RCARDTALENTCEILING = 5103
-- 技能养成等级上限判定
SysParamType.SKILLREALYCEILING = 5104
--非普攻技能养成共鸣所附加的等级上线
SysParamType.NORMALSKILLREALYCEILING = 5105
-- 疲劳值大于时绿色
SysParamType.STAMINAHIGHT = 5011
-- 疲劳值小于时红色
SysParamType.STAMINALOW = 5012
-- 当控制中心到多少级开放一键入驻
SysParamType.OPEN_ONE_KEY_WORK = 5013
-- 手环通讯自动等待时间
SysParamType.AUTOWAIT = 5202
-- 1星彩源晶兑换N时装币
SysParamType.FASHION_ICAN_CONVERSION_RATIO = 5301
SysParamType.ACTIVE_DEADLINE_PROP = 5362
--活动期间会掉落活动币的关卡战斗类型
SysParamType.DUP_DROP_ACTIVITYMONEY_lIST = 5363
-- 每周可解锁支线次数
SysParamType.UNLOCK_FRAGMENT_TIME = 5371
-- 自动进入下一关
SysParamType.WAITFORNEXTLEVEL = 5421

--联盟创建消耗
SysParamType.GUILD_CREATECOST = 5441
--联盟改名消耗
SysParamType.GUILD_RENAMECOST = 5442

--联盟名称上限
SysParamType.GUILD_NAME_LIMIT = 5444
--联盟公告上限
SysParamType.GUILD_NOTICE_LIMIT = 5445

--刷新时间间隔
SysParamType.GUILD_REFRESH_LIMIT_TIME = 5446

--重新加入的时间
SysParamType.GUILD_LEAVE_TIME = 5450

--副会长上限
SysParamType.GUILD_CHAIRMAN_NUM = 5451
--弹劾之后倒计时
SysParamType.GUILD_IMPEACH_TIME = 5452
--弹劾需要倒计时
SysParamType.GUILD_IMPEACH_NEED_TIME = 5453

--公会Boss最大挑战次数
SysParamType.GUILDBOSS_MAXBATTLECOUNT = 5501
--工会Boss开启的时间
SysParamType.GUILDBOSS_OPENTIME = 5505
--工会Boss战斗跳过回合数
SysParamType.GUILDBOSS_FIGHT_SKIP = 5507

--沙盒NPC气泡随机间隔时间
SysParamType.SandPlayNPCBubbleinterval = 5551
--沙盒NPC气泡停留时间
SysParamType.SandPlayNPCBubbleShowTime = 5552
--沙盒默认场景ID
SysParamType.SandPlayDupId = 5553
--自动钓鱼所需要手动钓成功鱼的数里
SysParamType.SandPlayAutoFishCount = 5599

--开心农场默认场景Id
SysParamType.HappyFarmDupId = 5554

--是否是主线类型
SysParamType.MainActivityType = 5556
SysParamType.MainActivityChapter = 5557

--战区升级
SysParamType.WARUP1 = 5571
SysParamType.WARUP2 = 5572

--时装通行证需要
SysParamType.FASHIONPERMIT_UP_NEED_DIAMOND = 5581
--时装通行证tid id
SysParamType.FASHIONPERMIT_INFO = 5582

--时装通行证需要
SysParamType.FASHIONPERMIT_TWO_UP_NEED_DIAMOND = 5586
--时装通行证tid id
SysParamType.FASHIONPERMIT_TWO_INFO = 5587

--最大挑战次数
SysParamType.GUILD_SEEP_MAX_TIMES = 5602
--联盟围剿跳过
SysParamType.GUILD_SWEEP_SKIP = 5605
--总力战挑战次数
SysParamType.DISASTER_ALLTIMER = 5651
--总力战挑战次数
SysParamType.DISASTER_ROUNDTIMER = 5652

--总力战跳过回合数
SysParamType.DISASTER_FIGHT_SKIP = 5653

--体力月卡持续天数
SysParamType.STRENGTH_DAY = 5701
--体力月卡限购数量
SysParamType.STRENGTH_BUY_MAX_COUNT = 5702
--体力月卡立即获得星彩源晶
SysParamType.STRENGTH_NOW_GIT = 5703
--体力月卡不足3天时出现提示
SysParamType.STRENGTH_DAY_TIPS = 5704
--体力月卡赠送道具tid
SysParamType.STRENGTH_PROPS_TID = 5705
--体力月卡赠送道具数量
SysParamType.STRENGTH_PROPS_COUNT = 5706

--下载奖励包id
SysParamType.DOWN_LOAD_GIFT_ID = 5751
--所需庆典任务数里
SysParamType.CELEBRATION_TASK_AWARD_NEED_COUNT = 5761
--庆典累计奖励，丽丽拉皮肤
SysParamType.CELEBRATION_TASK_AWARD = 5762
--庆典任务的tid 和 时装id
SysParamType.CELEBRATION_TASK_FASHION_INFO = 5763
--庆典月卡激活奖励
SysParamType.SSR_OPTIONAL_AWARD = 5764

--海底跳过
SysParamType.SEABED_FIGHT_SKIP = 5776

--投资理财需要金额
SysParamType.ACTIVITY_INVEST_NEED_MONEY = 5791--新手活动- 投资理财
FUNC_ID_ACTIVITY_INVEST = 3404--活动期间充值达到金额
SysParamType.ACTIVITY_RECHARGE_NUM = 5781
-- 达标奖励
SysParamType.ACTIVITY_RECHARGE_AWARD = 5782
-- 充值好礼界面跳转
SysParamType.ACTIVITY_RECHARGE_LINK_ID = 5783
-- 狂欢好礼充值金额
SysParamType.ACTIVITY_CARIVAL_GIFT_MONEY = 5786
-- 狂欢好礼展示战员信息
SysParamType.ACTIVITY_CARIVAL_GIFT_SHOW_HERO_INFO = 5787
--阿尔戈特供显示时间
SysParamType.SUPERCIAL_NEED_TIME = 5796

--taptap活动结束时间
SysParamType.TAPTAP_ENDTIME = 5433

--纳源链接重置选择道具
SysParamType.RECRUIT_APP_ITEM = 5903
SysParamType.RECRUIT_SENIORAPP_ITEM = 5904

--公会图标修改消耗
SysParamType.GUILD_ICON_CHANGE_NEED = 5456

--联盟单人每日挑战次数
SysParamType.GUILDWAR_COUNT = 5801

--匹配需要时间
SysParamType.GUILDWAR_NEED_TIME = 5803
--进攻主城所需边城消耗血量
SysParamType.GUILDFIGHT_NEED_PRO = 5804 

--DNA蛋
--金色的卵孵化所需道具
SysParamType.DNA_INCUBATION_NEED_PROPS = 5906 
--功能开启所需要的战员军阶条件
SysParamType.DNA_FUNC_OPEN_PARAM = 5907 
--dna蛋背包容量
SysParamType.DNA_BAG_LIMIT_COUNT = 5907 

--报名需要建筑数量 类型3
SysParamType.GUILDWAR_NEED_TYPE3_COUNT = 5812
--报名需要建筑数量 类型1
SysParamType.GUILDWAR_NEED_TYPE1_COUNT = 5813
--报名需要建筑数量 类型2
SysParamType.GUILDWAR_NEED_TYPE2_COUNT = 5814

--活动可进入时间
SysParamType.GUILDWAR_OPEN_START_TIMER = 5819

--不同国家cv类型配置
SysParamType.CV_TYPE = 5921

----[[ 替换语言包自动生成，请勿修改！]]

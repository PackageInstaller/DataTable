--[[
-----------------------------------------------------
@filename       : LinkConst
@Description    : uicode id映射表
@date           : 2020-11-06 14:28:11
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
LinkUiType = {
    -- 全屏
    FULL_SCREEN = 1,
    -- 弹窗
    SUB_POP = 2,
}

LinkCode = {
    -- 主界面-冒险
    Adventure = 1,
    -- 主界面-竞技
    Pvp = 2,
    -- 主界面-日常
    Task = 3,
    -- 主界面-招募
    Recruit = 4,
    -- 主界面-战员
    Hero = 5,
    -- 主界面-背包
    Bag = 6,
    -- 主界面-好友
    Friend = 7,
    -- 主界面-商店
    Shop = 8,
    -- 主界面-邮件
    Mail = 9,
    -- 主界面-公告
    Bulletin = 10,
    -- 主界面-个人主页
    HomePage = 11,
    -- 聊天 12
    -- 体力购买
    StaminaBuy = 13,
    -- 金币购买
    CoinsBuy = 14,
    -- 主界面-福利
    HomeWelfare = 15,
    -- 无限城
    InfiniteCity = 16,
    -- 回主界面
    MainUI = 17,
    --主界面-成长基金
    GrowthFund = 31,
    --主界面-活动
    Activity = 34,
    --主界面-交易所
    Shopping = 35,
    -- 盟约
    Covenant = 32,
    -- 主界面-训练
    Training = 19,

    -- 主界面-新手目标
    ActivityTarget = 20,
    -- 宿舍
    Dormitory = 21,
    -- 购买
    Purchase = 22,

    -- 通行证
    Permit = 23,
    -- 登录界面
    Login = 24,
    -- 档案界面
    Manual = 25,
    -- 肉鸽
    RogueLike = 26,

    -- 迷你工厂
    MiniFacory = 27,
    -- 设置
    Setting = 28,

    -- 手环通讯
    Communication = 33,
    -- 主界面-首充
    FirstCharge = 36,

    -- 新人活动
    NoviceActivity = 38,

    --节日
    FESTIVAL = 39,
    --联盟
    Guild = 40,
    --回归
    Returned = 41,

    -- 主界面-时装通行证
    FashionPermit = 42,

    --主界面-总力战
    Disaster = 43,
    -- 主界面-周年庆
    Celebration = 44,
    --时装通行证2
    FashionPermitTwo = 45,
    --特供
    SpecialSupply = 46,
    -- 冒险-主线
    MainMap = 101,
    -- 冒险-行动
    DupDaily = 102,
    -- 冒险-挑战
    Challenge = 103,
    -- 冒险-支线剧情
    BranchStory = 104,
    -- 冒险-战员传记
    Biography = 105,
    -- 冒险-主线
    MainMap2 = 107,

    --冒险-芯片
    DupEquip = 106,

    -- 支线-备战试炼
    BranchStoryEquip = 151,
    -- 支线-战场异闻
    BranchStoryMain = 152,
    -- 支线-战术训练
    BranchTactivs = 153,

    -- 支线-立场训练
    BranchPower = 154,

    -- 竞技-竞技场
    PvpArena = 201,
    -- 竞技-巅峰竞技场
    PvpArenaHell = 202,

    -- 日常-日常
    TaskDaily = 301,
    -- 日常-周常
    TaskWeek = 302,

    -- 招募-高级招募
    RecruitSuper = 401,
    -- 招募-普通招募
    RecruitNomal = 402,
    -- 招募-新手招募
    RecruitNewPlayer = 403,
    -- 招募-手环研发
    RecruitBracelets = 404,
    --活动站员招募
    RecruitActivity = 405,
    --手环活动研发
    RecruitBraceletsActivity = 406,

    --战员定制
    RecruitAppActTop = 407,
    --手环定制
    RecruitAppBracelets = 408,

    -- 战员遣散
    HeroDismiss = 407,

    -- 战员-编队
    HeroTeam = 501,
    -- 战员-培养
    HeroCulture = 502,

    -- 背包-分解
    BagBreak = 601,

    --背包-烙痕
    BagBracelet = 604,

    -- 好友-发现
    FriendRecommend = 701,
    -- 好友-申请
    FriendApply = 702,

    -- 商店-交易所
    ShopNomal = 801,
    -- 商店-军械所
    ShopArm = 802,
    -- 商店-黑市
    ShopBlack = 803,
    -- 商店-兑换
    ShopConvert = 804,
    -- 商店-元件商店
    ShopDismiss = 805,
    -- 商店-碎片商店
    ShopFragments = 806,
    -- 商店-情报所-输出情报所
    ShopFragmentsOutput = 807,
    -- 商店-情报所-辅助情报所
    ShopFragmentsAssist = 808,
    -- 商店-宿舍商店
    ShopDormitory = 809,
    -- 商店-巅峰竞技场
    ShopArenaHell = 811,
    -- 商店-联盟
    ShopGuild = 812,
    -- 商店-情报所-情报中心
    ShopFragmentFragment = 813,

    --商店-联盟团战
    ShopGuildWar = 814,
    -- 商店-贸易战-特供物资-心智体
    ShopDna = 815,

    -- 兑换商店-装潢商店
    ShopDecoration = 80203,
    -- 兑换商店-无限城
    ShopDoundless = 80204,
    -- 兑换商店-总力战
    ShopDisaster = 80205,
    -- 兑换商店-无限城
    ShopRogueLike = 80402,
    -- 兑换商店-科研配给
    ShopCovenant = 80403,
    -- 兑换商店-异想回渊
    ShopDupApostles = 80404,

    --工会boss
    GuildBoss = 4001,

    --联盟扫荡
    GuildSweep = 4002,
    --联盟团战
    GuildWar = 4003,
    -- 问卷调查
    SurveyWebView = 1001,
    -- web页面
    WebView = 1002,

    -- 个人主页-头像
    HomeHead = 1101,
    -- 个人主页-成就
    HomeAchievement = 1102,
    -- 个人主页-头像框
    HomeFrame = 1103,
    -- 个人主页-称号
    HomeTitle = 1104,

    -- 主界面-签到
    HomeSignIn = 1501,

    --作战补给
    WelfareFightSupply = 1502,

    --金币祈愿
    WekfareGoldWising = 1503,
    --福利-七天登录
    WelfareOptSevenLoading = 1504,
    --福利-新人训练营
    WelfareOptNoviceGoal = 1506,
    --福利-七日目标
    WelfareOptSevenDayTarget = 1507,

    -- 盟约-研究所
    CovenantGraduateSchool = 1801,
    -- 盟约-总部
    CovenantHeadQuarter = 1802,
    -- 盟约-科技树
    CovenantScienceTree = 1803,
    -- 盟约-探索
    CovenantExplore = 1804,
    -- 盟约-加工厂
    CovenantFactory = 1805,

    --商店
    CovenantShop = 1806,
    --盟约技能
    CovenantSkill = 1807,

    --盟约-任务
    CovenantTask = 1808,

    -- 购买——直购礼包
    DirectBuy = 1901,
    -- 购买——月卡
    MonthCard = 1902,
    -- 购买——充值 (不用这个，用22)
    Recharge = 1903,
    -- 购买——皮肤商店
    FashionShop = 1904,
    -- 购买——等级礼包
    GradeGift = 1905,
    -- 购买——时装币商店
    FashionCionShop = 1906,
    --体力月卡
    StrengthCard = 1907,
    -- 战员时装-展示界面
    HeroFashionShow = 1908,
    --特供补给包-限时礼包
    ShopLimitGift = 1909,

    --阿尔戈特供
    Supercial = 1910,
    --商城组合商店
    SHOPCOMBO = 1911,
    --商城场景商店
    SHOPSCENE = 1912,
    --商城部件商店
    SHOPPAIRTS = 1913,
    -- 档案——怪物
    ManualMonster = 2001,
    -- 档案——战员
    ManualHero = 2007,
    --2.2小游戏-整理背包
    OrganizeBackpacks = 2123,
    --基建-加工厂2
    BuildBaseFactor2 = 3201,
    --基建-总生产线
    BuildBaseFactor = 3202,
    --基建-动力模块
    BuildBasePowerStation = 3203,
    --基建-派遣坞
    BuildBaseDispatchRoom = 3204,
    --基建-提纯车间
    BuildBaseSmelters = 3205,
    --基建-训练模块
    BuildBaseLaboratory = 3206,
    --基建-控制中心
    BuildBaseControllerCenter = 3207,

    --活动-充值好礼
    ActivityRechargeNiceGift = 3402,

    --新手活动-累计链接
    NoviceActivityRecruit = 3801,
    --新手活动-累计铸造
    NoviceActivityBracelects = 3802,
    --新手活动-升格计划
    NoviceActivityUpgradePlan = 3803,

    --新手活动-抽奖
    NoviceRafflePanel = 3805,
    --新手活动-累充
    NoviceRechargePanel = 3807,

    --特供-狂欢好礼
    ActivityCarnivaGift = 4602,

    --特供-自选礼包
    ActivitySelectBuy = 4604,
    --阵型 力场训练
    FormationPower = 50102,
    -- 战员培养-升级
    HeroLvUp = 50201,
    -- 战员培养-技能
    HeroSkill = 50202,
    -- 战员培养-进化
    HeroStar = 50203,
    -- 战员培养-芯片
    HeroEquip = 50204,
    -- 战员培养-芯片强化
    HeroEquipStrengthen = 50205,
    -- 战员培养-芯片改造
    HeroEquipReTrofit = 50206,
    -- 战员培养-芯片重构
    HeroEquipRefactor = 50207,
    -- 战员培养-芯片突破
    HeroEquipTupo = 50208,
    -- 战员培养-升品
    HeroColorUp = 50209,
    -- 战员培养-手环
    HeroBracelets = 50210,
    -- 战员培养-手环强化
    HeroBraceletsStrengthen = 50211,
    -- 战员培养-手环精炼
    HeroBraceletsRefine = 50212,
    -- 战员时装
    HeroFashion = 50213,
    -- 战员助战
    HeroAssist = 50216,
    -- 战员培养-突破
    HeroMilitaryRankUp = 50217,

    -- 战员时装-服饰
    HeroFashionClothes = 502131,
    -- 战员时装-武器
    HeroFashionWeapon = 502132,

    -- 战员-增幅
    HeroGrow = 50215,
    -- 战员-战员预览界面
    HeroPreview = 50223,

    -- 行动-瓦斯坦金矿
    DupMoney = 10201,
    -- 行动-全息训练
    DupExp = 10202,
    -- 行动-塞米肯加工厂
    DupEquipTupo = 10204,
    -- 行动-手环培养副本
    DupBracelets = 10211,
    -- 行动-战员晋升副本
    DupHeroStarUp = 10212,
    -- 行动-战员增幅副本
    DupHeroGrowUp = 10213,
    -- 行动-战员技能升级副本
    DupHeroSkillUp = 10214,
    --手环升级副本
    DupBraceletUp = 10215,
    --手环突破副本
    DupBraceletEvolve = 10216,
    -- 潜能副本-直击强化
    DupAttackHardening = 10217,
    -- 潜能副本-驰电畸点
    DupElectric = 10218,
    -- 潜能副本-轰炎
    DupFire = 10219,
    -- 潜能副本-寒霜
    DupIce = 10220,
    -- 潜能副本-生蕴
    DupLife = 10221,
    -- 潜能副本-量蚀
    DupCavitation = 10222,
    -- 潜能副本-直击强化(难度2)
    DupAttackHardening_2 = 10223,
    -- 潜能副本-驰电畸点(难度2)
    DupElectric_2 = 10224,
    -- 潜能副本-轰炎(难度2)
    DupFire_2 = 10225,
    -- 潜能副本-寒霜(难度2)
    DupIce_2 = 10226,
    -- 潜能副本-生蕴(难度2)
    DupLife_2 = 10227,
    -- 潜能副本-量蚀(难度2)
    DupCavitation_2 = 10228,
    -- 潜能副本-直击强化(难度3)
    DupAttackHardening_3 = 10229,
    -- 潜能副本-驰电畸点(难度3)
    DupElectric_3 = 10230,
    -- 潜能副本-轰炎(难度3)
    DupFire_3 = 10231,
    -- 潜能副本-寒霜(难度3)
    DupIce_3 = 10232,
    -- 潜能副本-生蕴(难度3)
    DupLife_3 = 10233,
    -- 潜能副本-量蚀(难度3)
    DupCavitation_3 = 10234,

    -- 挑战-巴弥尔要塞
    ChellengeTower = 10301,
    -- 挑战-代号·希望
    ChellengeCodeHope = 10302,
    -- 挑战-默示之境
    DupImplied = 10303,
    -- 挑战-移动迷宫
    DupMaze = 10304,
    -- 挑战-异响回渊
    DupApostlesWar = 10306,
    -- 挑战-元素塔
    ChellengeDeepTower = 10307,

    -- 挑战-无限城
    Cycle = 10308,
    -- 挑战-新无限次
    Doundless = 10309,
    --挑战-海底
    Seabed = 10310,

    -- 挑战-异响回渊BOSS信息界面
    DupApostlesWarInfo = 1030601,

    --芯片初级
    DupEquipLow = 10601,
    --芯片中级
    DupEquipMid = 10602,
    --芯片高级
    DupEquipHigh = 10603,

    -- 无限城-目标奖励
    InfiniteCityTarget = 1601,
    -- 无限城-夜市
    InfiniteCityShop = 1602,
    -- 无限城-无限榜
    InfiniteCityRank = 1603,
    -- 无限城-挑战入口
    InfiniteCityDup = 1604,
    -- 无限城-每日目标
    InfiniteCityDailyTarget = 160101,
    -- 无限城-活动目标
    InfiniteCityActivityTarget = 160102,

    -- 插画页面
    Ikcon = 1701,
    -- 排行榜
    RANK_MAIN = 1800,

    -- 主线探索
    MainExplore = 10304,
    --材料生产
    ProduceMaterial = 320201,

    -------------- 1.1活动-----------------------
    --主题活动
    MainActivity = 2101,
    --主题活动-骑兵补给
    MainActivitySign = 2104,
    --1.1 主题活动 商店
    MainActivityShop = 2103,
    --1.1 主题活动 任务
    MainActivityTask = 2102,
    --1.1 主题活动 试玩
    MainActivityTrial = 2106,
    --1.2 主题活动 超难关卡
    --MainActivityHell = 2109,
    --1.2 主题活动 鹿灵试炼
    MainActivityGameplay = 2110,
    --1.2 主题活动 鹿灵试炼地图界面
    MainActivityGameplayMap = 211001,

    ActiveDup = 2105,
    ActiveDeepDup = 2107,
    ActiveDeepHell = 2109,

    -- 矿工
    Mining = 2112,
    -- 消消乐
    Eliminate = 2114,
    --蛋壳
    DanKe = 2115,
    --跑酷2.0
    Gold = 2116,
    -------周年庆----------
    --周年庆典-SSR月卡自选
    CelebrationSsrOption = 4401,
    --周年庆典-庆典任务
    CelebrationTask = 4402,
    --周年庆典-庆典累充
    CelebrationAccRecharge = 4403,
    --周年庆典-庆典抽奖
    CelebrationRoundPrize = 4404,
    --周年庆典-庆典抽奖2
    CelebrationRoundPrizeTwo = 4405,
    --水管游戏
    Ciruit = 2117,

    --开心农场
    HappyFarm = 2121, --农场场景
    HappyFarm_Breed = 2118, ---农场养殖
    HappyFarm_Task = 2119, ---农场任务
    HappyFarm_Warehouse = 2120, ---农场仓库
    HappyFarm_Shop = 2122, --农场商店

    --痒了又痒
    ThreeSheep = 2124,
    --打砖块
    ShootBrick = 2125,
    --拼图游戏
    PutImage = 2127,

    --连连看
    Linklink = 2128,

    SandPlay = 2126,

    --taptap奖励
    TaptapAward = 99999,

}

--[[ 替换语言包自动生成，请勿修改！
]]

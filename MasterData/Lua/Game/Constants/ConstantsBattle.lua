--[[
    author:luqucheng
    time:2019-10-21 17:02:37
]]
---@class ConstantsBattle
local Constants = {

    ---@alias Constants.GameMode integer @ 当前游戏模式
    GameMode = {
        PVE       = 1,
        PVP       = 2,
        OnlinePVE = 3,
    },

    ---@alias Constants.PVPMode integer @ PVP战斗类型
    PVPMode = {
        None            = 0,
        Arena           = 1,
        Friend          = 2,
        LadderCompetion = 3,
        Annihilation    = 4,
    },
    
    ---@alias Constants.PlayMode integer @ 播放模式
    PlayMode = {
        Battle = 1,
        Replay = 2,
    },

    ---@alias Constants.InputMode integer
    InputMode = {
        Normal      = 1,
        Replay      = 2,
        ReplayNoLag = 3,
        AutoNoLag   = 4,
    },

    ---@alias Constants.BattleState integer
    BattleState = {
        None            = 0,
        Preloading      = 1,
        WaitingForStart = 2,
        Processing      = 3,
        End             = 4,
    },

    ---@alias Constants.IdleType number
    IdleType = {
        Normal       = 0,
        SpecialIdle1 = 0.5,
        AttackIdle   = 1,
        Weak         = 1.5,
    },

    ---@alias Constants.RoleSize integer
    RoleSize = {
        Small  = 1,
        Normal = 2,
        Big    = 3,
        Huge   = 4,
    },

    ---@alias Constants.SkillCameraType integer
    SkillCameraType = {
        None      = 0,
        Normal    = 1,
        ThreeStar = 2,
    },

    ---@alias Constants.CampPriority integer @ 出牌先后手
    CampPriority = {
        UserFirst   = 1, -- 玩家优先
        Random      = 2, -- 随机
        StrongFirst = 3, -- 战力优先
    },

    ---@alias Constants.SkillCardSlotType integer @ 出牌槽位类型
    SkillCardSlotType = {
        Camp            = 1, -- 阵营交替
        SingleSkillCard = 2, -- 技能牌交替
    },

    ---@alias Constants.AIType integer @ 阵营的行动和ai类型
    AIType = {
        Monster      = 1,
        SkillCardMgr = 2,
    },

    --最低暴击伤害
    MinCritDamage = 1.0,

    --战斗在敌方之前连续行动上限
    BattleContinualMaxCount = 2,

    --战斗行动值进入排序队列的百分比值
    BattleActionQueueValue = 0.98,

    --战斗内速度衰减的阈值
    BattleSpeedThreshold = 255,

    --速度条的最大里程，现在是固定值
    BattleMaxActionS = 600,

    -- --大招点数上限
    -- UltraPointMax = 6,

    --子弹随机分布范围
    BulletRandomOffsetEdge = 0.5,

    --反击人数修正
    CounterFixRate = {1, 3/4, 2/3, 1/2},

    --根据剩余人数来决定的卡牌组上限
    SkillCardMax = {4, 6, 8, 10, 10, 10, 10, 10},
    
    --合成卡牌的能量奖励
    UnitCardPoint = {1, 1, 1},

    --使用技能卡牌的能量奖励
    ReleaseCardPoint = {1, 1, 1},

    --最大的消耗点数
    MaxCardCost = 4,

    --穿透固定系数
    PenetrateRate = 0.7,

    --值转百分比
    ValueToPercent = 0.01,

    --技能子效果数量
    SkillSubEffectCount = 7,

    --技能前置子效果数量
    SkillPreSubEffectCount = 2,

    --特殊召唤物召唤位置
    SpecialSummonPosition = -1,

    --星级影响的伤害系数变化
    StarDamageRate = {1, 1.16, 1.33},

    --星级影响的治疗变化
    StarHealRate = {1, 1.1, 1.21},

    --连携伤害系数
    ComboRate = {1, 1.2, 1.5, 2},

    ---@alias Constants.BattleCommonFX integer @ 战斗的通用特效
    BattleCommonFX = {
        CreepEnter  = 12, -- 小怪进入
        CardUse     = 14, -- 使用卡牌
        -- SPMax       = 30023,    -- 大招点满
        SPMaxUR     = 30024,    -- 大招点满（UR皮肤）
        RoleDead    = 16, -- 角色死亡
        MonsterDead = 17, -- 怪物死亡

        -- MonsterDeadWithGoldenTreasure        = 1001,
        -- MonsterDeadWithGoldenTreasureAndCoin = 1002,
        -- MonsterDeadWithSilverTreasure        = 1003,
        -- MonsterDeadWithSilverTreasureAndCoin = 1004,
        -- MonsterDeadWithCopperTreasure        = 1005,
        -- MonsterDeadWithCopperTreasureAndCoin = 1006,
        -- MonsterDeadWithCoin                  = 1007,
    },

    ---@alias Constants.RoleClass integer
    RoleClass = {
        Hero  = 0,
        Creep = 1, -- 小怪
        Elite = 2, -- 菁英
        Boss  = 3, -- boss
    },

    ---@alias Constants.RoleType integer @ 角色类型
    RoleType = {
        Hero          = 1, -- 角色
        Monster       = 2, -- 怪物
        SpecialSummon = 3, -- 特殊召唤物
        NPC           = 4, -- npc
    },

    ---@alias Constants.TriggerCdType integer @ 触发器冷却类型
    TriggerCdType = {
        None           = 0, -- 无
        Round          = 1, -- 回合数
        CountInOnSkill = 2, -- 单技能触发次数
        CountInRound   = 3, -- 单回合次数
        CountInOnSkillPerTarget = 4, -- 单技能触发次数（对单个目标）
    },

    ---@alias Constants.TriggerClickType integer @ 触发后的主目标选取类型
    TriggerClickType = {
        Target            = 0,
        Owner             = 1,
        AI                = 2,
        SelectFirstTarget = 3,
    },

    ---@alias Constants.TriggerRule integer @ 技能所能生效的触发器类型
    TriggerRule = {
        AllTrigger     = 0,
        NoBeHitTrigger = 1,
        NoneTrigger    = 2,
    },

    ---@alias Constants.TargetType integer @ 目标选择类型
    TargetType = {
        All                         = 0,  -- 所有目标
        Select                      = 1,  -- 对点选的目标
        SelectAndRandomNum          = 2,  -- 对点选的目标，以及随机NUM1个目标
        RandomNum                   = 3,  -- 随机数量目标
        AttrMax                     = 10, -- 按某个属性ID最高到最低排
        AttrMin                     = 11, -- 按某个属性ID最低到最高排
        HPPercentMax                = 12, -- 血量百分比从高到低
        HPPercentMin                = 13, -- 血量百分比从低到高
        HPSmaller                   = 14, -- 血量小于等于
        HPBigger                    = 15, -- 血量大于
        Position                    = 20, -- 战斗位置
        Self                        = 30, -- 自身
        Side                        = 31, -- 边上的单位
        SideAndMiddle               = 32, -- 边上和中间的单位
        SelectCareer                = 41, -- 选择职业
        SelectElement               = 42, -- 选择元素属性
        SelectMonsterType           = 43, -- 怪物类型（1小怪， 2boss）
        SpecialSummon               = 44, -- 特殊召唤物
        CatType                     = 45, -- 选择猫种
        Race                        = 46, -- 选择种族
        God                         = 51, -- 上帝
        TypeId                      = 52, -- 某个角色的id
        CharacterId                 = 53, -- 某个人物
        HasSomeBuffLayerGreater     = 54, -- 身上某buffId层数大于一定层数的人
        HasSomeBuffLayerLess        = 55, -- 身上某buffId层数小于等于一定层数的人
        CampLeftOrRight             = 56, -- 最左边或者最右边的单位
        BuffOrDebuffMax             = 57, -- 拥有buff或debuff数量从最高到最低排
        BuffOrDebuffMin             = 58, -- 拥有buff或debuff数量从最低到最高排
        BuffIdLayerMinMax           = 59, -- 按某个buffid的层数（1从高到最低排,2从低到最高排）
        OriginAttrMax               = 60, -- 按某个战前属性ID最高到最低排
        OriginAttrMin               = 61, -- 按某个战前属性ID最低到最高排
        AttrMaxExceptMainTarget     = 62, -- 按某个属性ID最高到最低排，除了主目标
        AttrMinExceptMainTarget     = 63, -- 按某个属性ID最低到最高排，除了主目标
        ExceptSelect                = 64, -- 除了点选目标之外的全部敌人
    },

    ---@alias Constants.DamageType integer
    DamageType = {
        Heal          = -1, -- 治疗 有伤害波动
        HPChange      = 0,  -- 血量变更
        Normal        = 1,  -- 普通伤害 有伤害波动
        Real          = 2,  -- 真实伤害 跳过防御计算 有伤害波动
        FullPenetrate = 3,  -- 穿透伤害 跳过忍耐计算 有伤害波动
        Indirect      = 4,  -- 间接伤害
        Pure          = 5,  -- 纯粹伤害
    },

    ---@alias Constants.DamageTag integer
    DamageTag = {
        AntiShield        = 1,     -- 护盾伤害
        Pure              = 2,     -- 无视伤害变更效果
        AntiAbsorb        = 3,     -- 不吸血
        AntiCrit          = 4,     -- 不暴击
        AntiBounce        = 5,     -- 不反伤
        TriplePenetration = 6,     -- 3倍穿透
        DoubleCritDamage  = 7,     -- 双倍爆伤
        TripleCrit        = 8,     -- 3倍暴击率
        Execute           = 9,     -- 处决，无视锁血(伤害变更12356)
        Execute2          = 10,    -- 处决，无视锁血(伤害变更8,10)
        --                = 遗留效果
        Accurate          = 10000, -- 精准伤害
    },

    ---@alias Constants.TargetCamp integer @ 目标阵营类型
    TargetCamp = {
        All0                              = 0, -- 全体
        Friend                            = 1, -- 友方
        Enemy                             = 2, -- 敌方
        All                               = 3, -- 全体
        Self                              = 4, -- 自身
        FriendWithoutSelf                 = 5, -- 除自身外的队友
        FriendWithoutSpecialSummon        = 6, -- 友方除特殊召唤物外
        FriendWithoutSelfAndSpecialSummon = 7, -- 友方除特殊召唤物和自身外
    },

    ---@alias Constants.Camp integer @ 阵营
    Camp = {
        One = 1,
        Two = 2,
    },

    ---@alias Constants.SkillEffectMainType integer @ 效果主类型（对应mainEffectType）
    SkillEffectMainType = {
        None                    = 0,  -- 无
        DirectDamage            = 1,  -- 直接伤害
        DirectHeal              = 2,  -- 直接治疗
        ActionChange            = 3,  -- 行动槽变化
        AddBuff                 = 4,  -- 添加buff
        AddBuffEx               = 5,  -- 添加buff强化
        ClearBuff               = 6,  -- 清除buff
        StealBuff               = 7,  -- 偷取buff
        CardStarChange          = 8,  -- 技能卡的星级变化
        Death                   = 9,  -- 死亡
        SPChange                = 10, -- 大招点数变化
        BuffDurationChange      = 11, -- buff持续时间变化
        Summon                  = 12, -- 召唤
        CopyBuff                = 13, -- 复制buff
        HPChange                = 14, -- 单纯血量变更
        ElementChange           = 15, -- 元素属性变更
        CardPush                = 16, -- 添加卡牌
        SPGive                  = 17, -- SP点移动
        BuffChangeLayer         = 18, -- 改变buff层数
        RemoveRole              = 19, -- 移除角色
        SpecialSummon           = 20, -- 特殊召唤
        CardRemove              = 21, -- 移除卡牌
        TriggerSkill            = 22, -- 触发技能
        ShieldChange            = 23, -- 护盾消耗
        OperateSpecialRegister  = 24, -- 操作特殊寄存器
    },

    ---@alias Constants.StandRule integer[] @ 站位规则，根据人数选择站位情况
    StandRule = {
        [1] = {3},
        [2] = {2,3},
        [3] = {2,3,4},
        [4] = {1,2,3,4},
    },

    ---@alias Constants.BulletType integer
    BulletType = {
        OneWay = 1,
        Back   = 2,
    },

    ---@alias Constants.EffectType integer @ 技能子效果和触发器效果的类型
    EffectType = {
        Buff         = 1, -- buff
        SkillEffect  = 2, -- 技能效果，伤害等
        PassiveSkill = 3, -- 被动技能
        SkillCard    = 4, -- 技能牌
    },

    ---@alias Constants.GameOverCondition integer @ 战斗结束枚举
    GameOverCondition = {
        OverTurn                   = 1000, -- 超过回合限制数
        EnemyAllDead               = 1001, -- 敌方全体目标死亡
        EnemyBossDead              = 1002, -- Boss死亡
        SpecialIdDead              = 1003, -- 敌方特殊ID目标死亡
        KillEnemyNum               = 1004, -- 击杀敌方目标数量
        GiveEnemyDamageNum         = 1005, -- 对敌方目标造成伤害总量
        --MissionAllFailed         = 1006, -- 关卡条件全部任务判定失败
        --MissionAllSucceed        = 1007, -- 关卡条件全部任务判定成功
        SpecialIdAllDead           = 1006, -- 敌方特殊ID目标全部死亡
        --                         = 
        Win                        = 1007,
        SelfDeathNum               = 1008, -- 武装死亡数量
        AllSelfHpPerNotSmallerThan = 1009, -- 我方生命百分比都不低于
        --TotalGiveDamage          = 1010, -- 我方造成总伤害
        SomeElementTotalGiveDamage = 1011, -- 我方造成总伤害
        HasElementMemberNum        = 1012, -- 我方武装属性数量
        HasMemberNum               = 1013, -- 我方武装总数量
        HasCareerNum               = 1014, -- 我方职业数量
        HasSomeRareNum             = 1015, -- 我方某稀有度数量
        HasSomeCatTypeNum          = 1016, -- 我方某猫种数量
        SpecialSummonHpPercent     = 1017, -- 我方特殊召唤物血量百分比
        EnemyUseUltraSkill         = 1018, -- 敌方大招次数
        KillSomeElementEnemyNum    = 1019, -- 击杀某属性怪物数量
        KillSomeTypeEnemyNum       = 1020, -- 击杀某类型怪物数量
        SelfHitNum                 = 1021, -- 进攻技能总hit数量
        --                         = 
        SelfOneDead                = 2001, -- 友方一角色死亡
        SelfAllDead                = 2002, -- 友方全体目标死亡
        GiveSelfHealNum            = 2003, -- 对友方造成的治疗总量
        GiveSpecialIdHealNum       = 2004, -- 对友方特殊ID目标造成治疗总量
        --                         = 
        UseSomeElementCard         = 2005,
        UseSomeTypeSkill           = 2006,
        UnitCard                   = 2007,
        UnitSomeStarCards          = 2008,
        DischargeMergeSkill        = 2009,
        UseUltraSkill              = 2010,
        SkillElementAdvantage      = 2011,
        KillBossWithBreak          = 2012,
        --                         = 
        EnemyGiveHealNum           = 2013, -- 敌方的总治疗量
        ElementAdvantageDamageNum  = 2014, -- 我方造成的克制伤害总量
        TriggerSuccessTimes        = 2015, -- 触发器触发成功的累计次数
    },

    ---@alias Constants.BattleConditionJudgeTime integer
    BattleConditionJudgeTime = {
        BattleStart = 1, -- 战斗开始时
        DataUpdate  = 2, -- 数据刷新时
        GameOver    = 3, -- 结算时
    },

    ---@alias Constants.BattleConditionJudgeViaType integer
    BattleConditionJudgeViaType = {
        State = 1, -- 当前状态判定
        Count = 2, -- 累计总量
    },

    ---@alias Constants.BattleConditionRefreshType integer
    BattleConditionRefreshType = {
        None  = 0,
        Skill = 1,
        Round = 2,
    },

    ---@alias Constants.BattleConditionUsedTo integer
    BattleConditionUsedTo = {
        WinCondition       = 1,
        LoseCondition      = 2,
        ThreeStarCondition = 3,
    },

    ---@alias Constants.BattleConditionState integer
    BattleConditionState = {
        None    = 0,
        Process = 1,
        Succeed = 2,
        Fail    = 3,
    },

    ---@alias Constants.CardBehavior integer
    CardBehavior = {
        None        = 0,
        Search      = 1, -- 发现
        SwithchStar = 2, -- 变换
        Choose      = 3, -- 抉择
        Swallow     = 4, -- 吞噬
        Discard     = 5, -- 弃牌
        Upgrade     = 6, -- 升星
    },

    ---@alias Constants.CardBehaviorTrigger integer
    CardBehaviorTrigger = {
        None         = 0,
        AfterSwallow = 1, -- 吞噬后
        BeforeSearch = 2, -- 发现前
    },

    ---@alias Constants.CardBehaviorTriggerResultType integer
    CardBehaviorTriggerResultType = {
        None                            = 0,
        InsertAnotherCardWithRelateStar = 1, --补充一张牌，星级根据源头牌变化
        InsertAnotherCardWithConfigStar = 2, --补充一张固定星级牌
        ChangeDestCardStar              = 3, --发现或者抉择的牌变化星级
    },
    

    ---------------------------------------------------------------------------------
    -----------------------------------buff相关---------------------------------------

    ---@alias Constants.BuffState integer @ buff状态
    BuffState = {
        Active        = 1, -- 激活状态
        ReadyToRemove = 2, -- 即将被删除
        Inactive      = 3, -- 未激活状态
    },

    ---@alias Constants.BuffLayType integer @ 叠加方式
    BuffLayType = {
        Cover        = 1, -- 覆盖
        Independence = 2, -- 独立
        Stack        = 3, -- 叠加
        Reject       = 4, -- 互斥
    },

    ---@alias Constants.BuffType integer @ buff的类型(对应subEffectType)
    BuffType = {
        AttributeChange         = 1,    -- 属性变更
        Dot                     = 2,    -- 持续伤害
        Hot                     = 3,    -- 持续治疗
        Status                  = 4,    -- 状态变化（眩晕，沉默）
        Shield                  = 5,    -- 护盾
        DamageChange            = 6,    -- 伤害变更类
        Resist                  = 7,    -- 效果免疫
        HealChange              = 8,    -- 治疗改变类
        ScreenBuff              = 9,    -- 屏蔽buff
        ElementAdvantageChange  = 10,   -- 元素克制伤害系数改写类
        Special                 = 100,  -- 特殊类
    },

    ---@alias Constants.SpecialBuffType integer
    SpecialBuffType = {
        Taunt                   = 1,  -- 嘲讽
        Angry                   = 2,  -- 单嘲
        Expose                  = 3,  -- 暴露，嘲讽和单嘲无效
        WeakCooldown            = 9,  -- 弱点休眠
        WeakExpose              = 10, -- 弱点暴露
        Weak                    = 11, -- 弱点击破
        SpTypeChange            = 12, -- SP类型变更
        SkillCardCantGetSp      = 13, -- 携带者使用自身的Num1（1/2）号技能牌时无法获得sp
        ChangePushCardProb      = 14, -- 改变掉牌的概率
        MarkForSkillTag         = 15, -- 针对指定技能Tag的标记
        LockAttrNum             = 16, -- 锁定属性值
    },

    ---@alias Constants.ActionChangeType integer @ 行动条变化类型效果(对应subEffectType)
    ActionChangeType = {
        Percent = 1, -- 百分比变化
    },

    ---@alias Constants.BuffOrDebuff integer @ 增益或者减益（对应buffType）
    BuffOrDebuff = {
        Buff   = 1, --增益
        Debuff = 2, --减益
    },

    ---@alias Constants.ClearBuffType integer @ 清除buff类型
    ClearBuffType = {
        All    = 1,
        Buff   = 2,
        Debuff = 3,
        ID     = 4,
        Type   = 5,
    },

    ---@alias Constants.ClearBuffSelect integer @ 清除buff时候的获取类型
    ClearBuffSelect = {
        Number     = 1, -- 固定数量
        LeftNumber = 2, -- 清除层数但保留数层
    },

    ---@alias Constants.StealBuffType integer @ 偷取buff类型
    StealBuffType = {
        All    = 1,
        Buff   = 2,
        Debuff = 3,
        EffectType = 4,     -- 按效果类型
        ID     = 5,         -- 指定id
    },

    ---@alias Constants.StealBuffSelect integer @ 偷取buff选择类型
    StealBuffSelect = {
        Number = 1, -- 固定数量
        NumberAll = 2,  -- 全部数量
        Special1 = 3,   -- 特殊1 (当目标身上已经存在相同ID的覆盖或排斥类型buff或目标身上相同ID的可叠加类型buff已满层，跳过该buff，独立类型buff无脑继承)
    },

    ---@alias Constants.DotType integer @ DOT伤害公式的类型
    DotType = {
        Poison      = 1, -- 中毒
        Bleed       = 2, -- 流血、点燃、余震
        Curse       = 3, -- 诅咒
        Corrosion   = 4, -- 腐蚀
        Virus       = 5, -- 病毒
        Gale        = 6, -- 烈风
        Torrent     = 7, -- 激流
        --Burn      = 2, --灼伤
        --Infection = 3, --感染
    },

    ---@alias Constants.HotType integer
    HotType = {
        Hot1 = 1,
        Hot2 = 2,
        Hot3 = 3,
        Hot4 = 4,
    },

    ---@alias Constants.ResistType integer @ 效果抵抗类型
    ResistType = {
        ById   = 1,
        ByType = 2,
    },

    ---@alias Constants.DamageChangeType integer @ 伤害变更类型
    DamageChangeType = {
        UpperLimit                  = 1, -- 伤害上限固定值
        UpperLimitHPPercent         = 2, -- 伤害上限小于血量最大值的百分比
        LockHp                      = 3, -- 固定值锁血
        DamageShare                 = 4, -- 伤害转移
        LockPercentHp               = 5, -- 百分比锁血
        Perseverance                = 6, -- 根性
        ElementAdvantageEnhance     = 7, -- 属性克制增强（削弱）
        PerseverancePerSkill        = 8, -- 按技能计算根性
        UpperLimitHPPercentPerSkill = 9, -- 单次技能伤害上限
        PerseverancePerSkill2       = 10, -- 按技能计算根性2(当牌库里存在技能牌ID=Num3；Num4；Num5……的Num2星技能牌时才会生效)
    },

    ---@alias Constants.HealChangeType integer @ 治疗变更类
    HealChangeType = {
        OverflowToShield = 1, -- 溢出治疗转护盾(判断buff来源和治疗来源)
        OverflowToDamage = 2, -- 溢出治疗均分给敌方全体
        CriticalHeal     = 3, -- 治疗计算暴击爆伤
        OverflowToShield2= 4, -- 溢出治疗转护盾(不判断buff来源和治疗来源)
    },

    ---@alias Constants.SkillLabel integer @ 技能标签，该分类只带队非大招有效
    SkillLabel = {
        Buff            = 1, -- 增益型技能
        Attack          = 2, -- 伤害型技能
        Debuff          = 3, -- 减益型技能
        Heal            = 4, -- 治疗型技能
        AttackAndBuff   = 5, -- 进攻且增益
        AttackAndDebuff = 6, -- 进攻且减益
        Summoners       = 7, -- 召唤
    },

    ---@alias Constants.SkillClass integer @ 技能类型
    SkillClass = {
        Active  = 1, -- 主动
        Passive = 2, -- 被动
    },

    -----------------------------------buff相关---------------------------------------
    ---------------------------------------------------------------------------------


    ---------------------------------------------------------------------------------
    -----------------------------------触发器相关--------------------------------------

    ---@alias Constants.TriggerMainType integer @ 触发器主条件
    TriggerMainType = {
        Direct                   = 1,  -- 直接生效
        Attack                   = 10, -- 自己攻击时
        BeAttack                 = 20, -- 自己被攻击时
        SkillEnd                 = 11, -- 技能生效
        SkillStart               = 12, -- 技能开始时
        TurnStart                = 30, -- 轮次开始
        TurnEnd                  = 31, -- 轮次结束
        RoundStart               = 32, -- 回合开始
        RoundEnd                 = 33, --
        BeforeAction             = 34, -- 行动开始前
        Dead                     = 40, -- 角色死亡
        OtherDead                = 41, -- 其他角色死亡
        BeforeDead               = 42, -- 死亡之前
        BeforeOtherDead          = 43, -- 其他角色死亡之前
        BuffRemoved              = 50, -- buff消失时候
        BuffAdd                  = 51, -- buff施加时候
        BuffBeforeRemoved        = 52, -- buff即将移除
        ShieldBroken             = 53, -- 护盾被打破
        OtherAttack              = 54, -- 其他人技能命中
        OtherSkillEnd            = 55, -- 其他人技能结束
        OtherSkillStart          = 56, -- 其他人技能开始
        OtherBeAttack            = 57, -- 其他人被命中
        OtherAttack2             = 58, -- 其他人技能命中
        OtherSkillEnd2           = 59, -- 其他人技能结束
        OtherSkillStart2         = 60, -- 其他人技能开始
        OtherBeAttack2           = 61, -- 其他人被命中
        PoseMax                  = 60, -- 解体槽满的时候
        PoseBreak                = 61, -- 解体槽清空
        ResistBuff               = 62, -- 免疫buff时
        ResistSkillEffect        = 63, -- 免疫机能效果时
        GiveCardChangeEffect     = 64, -- 给予卡牌星级变化效果
        GameStart                = 65, -- 战斗开始时，在卡牌进入前
        BeforeRoundStart         = 66, -- 回合开始前（补牌前）
        GetHealed                = 67, -- 受到治疗
        GiveHeal                 = 68, -- 治疗
        SkillCardDischargeFailed = 69, -- 技能卡释放失败
        SPChange                 = 70, -- sp产生变化
        HPReduce                 = 71, -- 自身血量减少时（血量增加可以使用主条件67收到治疗）
        HPReduceEffectEnd        = 72, -- 血量消耗效果触发后
        BeforeRoundEnd           = 73, -- 回合结束前
        Dot                      = 74, -- Dot触发时
        ShieldBroken2            = 75, -- 打爆其他人的护盾
        SPChange2                = 76, -- 尝试修改变化，但是最终值没有发生变化
        PerseverancePerSkill     = 77, -- 每技能大毅力触发时
    },

    ---@alias Constants.TriggerSubType integer @ 触发器子条件
    TriggerSubType = {
        Direct                     = 0,   -- 直接生效
        Probability                = 1,   -- 概率触发
        OwnAttributeValue          = 10,  -- 目标的NUM1属性大于NUM2
        TargetHpPercent            = 11,  -- 目标的血量百分比大于
        OwnHpPercent               = 12,  -- 自身的血量百分比大于
        OwnBuffNumber              = 20,  -- 携带者身上的增益BUFF数量大于NUM1
        OwnDebuffNumber            = 31,  -- 携带者身上的减益BUFF数量大于NUM1
        TargetBuffNumber           = 32,  -- 目标身上的增益BUFF数量大于NUM1
        TargetDebuffNumber         = 33,  -- 目标身上的减益BUFF数量大于NUM1
        UltraPointNumber           = 34,  -- 目标的大招点大于某个值
        TargetBuffTypeNumber       = 35,  -- 目标身上有某种类型的buff数量
        OwnerBuffTypeNumber        = 36,  -- 自身身上有某种类型的buff数量
        OwnBuffID                  = 40,  -- 携带者身上有某个ID的BUFF
        BuffTurnOver               = 41,  -- buff是否自然移除
        IsBuffID                   = 42,  -- buff是哪个
        CheckBuffType              = 43,  -- 查看buff类型是否满足
        CheckBuffIsThisTrigger     = 44,  -- 判断目标buff是否是触发器自身
        SkillInCD                  = 50,  -- XXID的技能未冷却时
        TargetDead                 = 60,  -- 如果目标死亡
        IsHit                      = 70,  -- 如果命中
        IsMiss                     = 71,  -- 如果闪避
        IsCrit                     = 72,  -- 如果暴击
        EnemyAliveNumber           = 73,  -- 敌方存活数量
        FriendAliveNumber          = 74,  -- 友方存活数量（包括自己）
        BuffAddRound               = 75,  -- buff从开始到现在的轮数（轮数：回合数乘以2）
        IsSkillId                  = 76,  -- 技能id是否满足
        IsInputSkill               = 77,  -- 是否是主动释放的技能（非触发）
        IsFriend                   = 80,  -- 己方
        IsEnemy                    = 81,  -- 敌方
        IsSelf                     = 82,  -- 自身
        IsBuffType                 = 83,  -- 检测buff类型
        WeakRemain                 = 84,  -- 剩余可解体次数
        OwnUltraPointNumber        = 85,  -- 触发器持有者的sp点数
        IsUltra                    = 86,  -- 是否是大招
        TargetBuffLayNum           = 87,  -- 目标某buff层数
        SkillLabel                 = 88,  -- 如果此技能在技能表上的字段label = 条件参数1则触发（1、buff 2、进攻3、DEBUFF4、恢复）
        RoundOddOrEven             = 89,  -- 判定当前回合是否为奇数回合（偶数回合），1奇数，2偶数【判定为大回合数，并且为不受波次影响的总回合数】
        IsAoe                      = 90,  -- 判断技能主目标数量是否>1，如果是则触发
        IsAttackerElementAdvantage = 91,  -- 攻击者属性克制
        IsTargetElementAdvantage   = 92,  -- 攻击者属性被克制
        SkillStar                  = 93,  -- 判断客体释放的技能星级 条件1填写2进制数字，与技能生效星级规则相同
        TargetCareer               = 94,  -- 判断目标的职业
        MaxHpCompare               = 95,  -- 目标maxHp/自身maxHp>1+条件参数1
        IsCardUpgrade              = 96,  -- 卡牌变更效果时是否升星
        SelfCareer                 = 97,  -- 判断自身的职业
        SelfElement                = 98,  -- 判断自身属性
        IsHugeHit                  = 99,  -- 此段伤害/受伤害目标最大血量>条件参数1 则触发
        SkillHitCount              = 100, -- 技能段数>条件参数1，则触发
        NoAoeMark                  = 101, -- 技能上“isAoe”字段       = 0，则触发
        HasMyAngry                 = 102, -- 如果目标身上有主体触发的挑衅效果
        IsOwnerSkillMainTarget     = 103, -- 主体是否是技能的主效果目标
        TargetMonsterClass         = 104, -- 客体的怪物类型和num1是否相等
        SkillTags                  = 105, -- 触发技能的SkillTags标记是否包含num1
        RoundCount                 = 106, -- 当前回合数等于num1触发
        IsTargetSpecialSummon      = 107, -- 判断是否是特殊召唤物
        PseudoRandom               = 108, -- 伪随机概率触发
        TargetElement              = 109, -- 判断客体属性颜色
        IsSkillCardId              = 110, -- 判断技能卡id
        IsBuffStar                 = 111, -- buff星级是否等于参数
        IsBuffStarEqual            = 112, -- buff星级是否等于本触发器星级
        TargetCatType              = 113, -- 判断目标catType
        SelfCatType                = 114, -- 判断自身catType
        HasRoleId                  = 115, -- 判断是否有某个roleId的角色
        HasCharacterId             = 116, -- 判断是否有某个characterId的角色
        HasRace                    = 117, -- 判断是否有某个race的角色
        HasCatType                 = 118, -- 判断是否有某个catType的角色
        HasElement                 = 119, -- 判断是否有某个颜色的角色
        EveryRace                  = 120, -- 判断是否全为某个race的角色
        EveryCatType               = 121, -- 判断是否全为某个catType的角色
        EveryElement               = 122, -- 判断是否全为某个颜色的角色
        TargetRace                 = 123, -- 判断目标race
        SelfRace                   = 124, -- 判断自身race
        DamageType                 = 125, -- 判断伤害类型
        CompareHpPercent           = 126, -- 判断主体和客体的血量百分比
        IsSPSkill                  = 127, -- 判断是否是大招
        IsSPSkillMainEffect        = 128, -- 判断是否是大招主效果
        BuffIdTotalLayerNum        = 129, -- 指定id的Buff总层数
        BuffTypeTotalLayerNum      = 130, -- 指定类型的Buff总层数
        SPChangeSourceType         = 131, -- sp点数改变的来源类型 1技能 2合卡 3技能效果
        IsSPIncrease               = 132, -- sp点数是否增加了 取反为减少
        SkillEffectSourceType      = 133, -- 判断技能效果来源 0仅主效果 1仅子效果 2主效果和子效果
        IsSystemId                 = 134, -- 判断的本场战斗所属的系统功能id，是否为某一个指定的系统功能表id
        ProbabilityEnhanceByBuff   = 135, -- 受buff层数影响的概率
        RoleStar                   = 136, -- 角色星级
        CardId                     = 137, -- 角色卡牌id
        AnyBuffLayerNum            = 138, -- 任意buff层数
        AttrChange                 = 139, -- 属性变化
        OppoCampDebuffLayerNum     = 140, -- 主体对方阵营debuff层数
        OwnerCampBuffLayerNum      = 141, -- 主体阵营增益buff层数
        AttrChange1                = 142, -- 属性变化新（旧的大于小于的判断有问题）
        IsSameIdBuffCanStack       = 143, -- 同id的buff是否可以叠加
        CampRoleHasBuff            = 144, -- 指定阵营，指定角色，指定id的buff是否存在
        HasSameMaxLayerBuff        = 145, -- 是否存在相同id的buff，且达到最大层数
        NeighborBuffNum            = 146, -- 临近单位的buff数量
        ProbEnhanceByTargetBuff    = 147, -- 受目标单位buff影响的概率
        HasCardByStar              = 148, -- 是否有指定星级的卡牌
        SkillAttackerIsEnemy       = 149, -- 技能攻击者是buff拥有者的敌方
    },

    ---@alias Constants.TrigResultType integer @ 触发结果类型
    TrigResultType = {
        Effect = 1, -- 效果
        Skill  = 2, -- 技能
    },

    ---@alias Constants.BuffTriggerType integer @ Buff触发器类型
    BuffTriggerType = {
        Effect = 1, -- 效果触发器
        End    = 2, -- 结束触发器
    },

    -----------------------------------触发器相关--------------------------------------
    ---------------------------------------------------------------------------------

    ---@alias Constants.RecordType integer
    RecordType = {
        Skill                   = 1,
        Effect                  = 2,
        Damage                  = 3,
        AddBuff                 = 4,
        RemoveBuff              = 5,
        Trigger                 = 6,
        Action                  = 7,
        TurnStart               = 8,
        TurnEnd                 = 9,
        UnitCard                = 10,
        PushCard                = 11,
        MoveCard                = 12,
        UseCard                 = 13,
        SyncCard                = 14,
        DeleteCard              = 16,
        RequireInput            = 17,
        GameOver                = 18,
        Init                    = 15,
        SkillHit                = 19,
        SkillEnd                = 20,
        SkillStart              = 21,
        ChangeBuff              = 22,
        AIChooseSkill           = 23,
        UltraPointChange        = 24,
        ChangeCard              = 25,
        ChangeWave              = 26,
        ShieldChange            = 27,
        ElementBreak            = 28,
        WeakCooldown            = 29,
        WeakExpose              = 30,
        Weak                    = 31,
        CreateRole              = 32,
        SyncRole                = 33,
        InputFinished           = 34,
        SyncStatus              = 35,
        ChangeElement           = 36,
        ChangeWaveEnd           = 37,
        ChangeMergeSkillId      = 38,
        MissionUpdate           = 39,
        RoleDead                = 40,
        ChangeMaxHp             = 41,
        RoleExit                = 42,
        DodgeBuff               = 43,   -- 抵抗buff
        MissBuff                = 44,   -- buff未命中
        PlayerInput             = 45,   -- 玩家出牌操作
        ChangeQueueCard         = 46,   -- 修改释放队列中的卡
        SkillFailed             = 47,   -- 主动技能释放失败
        RoleRemove              = 48,   -- 角色死亡(用来在异步pvp中表现角色死亡)
        RoleEnter               = 49,   -- 角色入场表现
        PushCatCard             = 50,   -- 推送猫卡状态
        CreateSkillCat          = 51,   -- 创建猫球
        UltraPointMaxChange     = 52,   -- Sp点最大值变化
        SPTypeChange            = 53,   -- Sp类型变化
        RegisterValueChange     = 54,   -- 寄存器数值变化
    },

    ---@alias Constants.RecordTypeName string
    RecordTypeName = 
    {
        [1] = "Skill",
        [2] = "Effect",
        [3] = "Damage",
        [4] = "AddBuff",
        [5] = "RemoveBuff",
        [6] = "Trigger",
        [7] = "Action",
        [8] = "TurnStart",
        [9] = "TurnEnd",
        [10] = "UnitCard",
        [11] = "PushCard",
        [12] = "MoveCard",
        [13] = "UseCard",
        [14] = "SyncCard",
        [15] = "Init",
        [16] = "DeleteCard",
        [17] = "RequireInput",
        [18] = "GameOver",
        [19] = "SkillHit",
        [20] = "SkillEnd",
        [21] = "SkillStart",
        [22] = "ChangeBuff",
        [23] = "AIChooseSkill",
        [24] = "UltraPointChange",
        [25] = "ChangeCard",
        [26] = "ChangeWave",
        [27] = "ShieldChange",
        [28] = "ElementBreak",
        [29] = "WeakCooldown",
        [30] = "WeakExpose",
        [31] = "Weak",
        [32] = "CreateRole",
        [33] = "SyncRole",
        [34] = "InputFinished",
        [35] = "SyncStatus",
        [36] = "ChangeElement",
        [37] = "ChangeWaveEnd",
        [38] = "ChangeMergeSkillId",
        [39] = "MissionUpdate",
        [40] = "RoleDead",
        [41] = "ChangeMaxHp",
        [42] = "RoleExit",
        [43] = "DodgeBuff",
        [44] = "MissBuff",
        [45] = "PlayerInput",
        [46] = "ChangeQueueCard",
        [47] = "SkillFailed",
        [48] = "RoleRemove",
        [49] = "RoleEnter",
        [50] = "PushCatCard",
        [51] = "CreateSkillCat",
    },

    ---@alias Constants.StatusAbility string @ 状态能力值
    StatusAbility = {
        canAction          = 'isAction',           -- 是否可行动
        --canSkill         = 'isUseSkills',        -- 是否可放技能（不算普攻）
        --canCounter       = 'isCounterattack',    -- 是否处于可以反击的状态
        --canCombo         = 'isBatter',           -- 是否处于可以连击的状态
        canUseBuffSkill    = 'isUseSkillsBuff',    -- 是否能释放（非大招的BUFF类技能）
        canUseAttackSkill  = 'isUseSkillsAtk',     -- 是否能释放技能（非大招的进攻类技能）
        canUseDebuffSkill  = 'isUseSkillsDebuff',  -- 是否能释放（非大招的DEBUFF类技能）
        canUseHealSkill    = 'isUseSkillsTherapy', -- 是否能释放（非大招的恢复类技能）
        canUseSPSkill      = 'isUseSkillsSp',      -- 是否能释放大招
        canGetSPPoint      = 'isGetSp',            -- 是否能获得SP点
        canFriendClick     = 'isOwnClick',         -- 友方是否能点击选中
        canEnemyClick      = 'isEnemyClick',       -- 敌方是否能点击选中
        canBeSelected      = 'isEffectTarget',     -- 是否可以被选中
        canSkillGetSPPoint = 'isSkillGetSp',       -- 释放技能是否可以获得sp
    },
    
    ---@alias Constants.BattleParam string @ 战斗参数
    BattleParam = {
        EvadeDamageReduce  = 'evadeReducedDamage', -- 闪避之后的伤害修正
        EvadePoseReduce    = 'evadeReducedDisNum', -- 闪避之后的解体值修正
        LuckyValuePara     = 'luckyValuePara',     -- 幸运获得2星参数 LK*((pi^(1/2)*N)-1)/参数+0.02 该参数越小，同样幸运值达到100%越快，每缩小1半，加快1倍，幸运值每提升1倍，加快1倍
        CardWeightArray    = 'cardWeightArray',    -- 同角色手牌过多时候的权重减少值，当前有几张，下次权重减少多少
        CardMakeUpLimit    = 'cardMakeUpLimit',    -- 手卡中技能卡数量大于等于N时，对没有技能卡的角色进行必然补偿
        CardWeightValue    = 'cardWeightValue',    -- 同角色的每个技能获得概率为50%，每获得一个技能卡，则该技能卡概率降低N, 同时另外技能概率提升N
        LuckMultiplier     = 'luckMultiplier',     -- 幸运系数
        LuckAdd            = 'luckAdd',            -- 基础幸运概率
        BounceDamageTypeId = 'backDmgType',        -- 反伤伤害类型
        LinkDamageTypeId   = 'condectDmgType',     -- 伤害链伤害类型
        BuffDodgeParam     = 'crowdControlRatio',  -- 命中和抵抗用系数
        CombatDamageAmend  = 'combatDamageAmend',  -- 战力碾压系数
        FocusHPPer         = 'focusOnTargetAI',    -- 集火系数
        CombatValMax       = 'combatValMax',       -- 战力碾压最小值
        CombatDamageMin    = 'combatDamageMin',    -- 战力碾压最大值 
        SkillVoicePlayRate = 'skillVoicePlayRate', -- 技能语音播放几率
    },

    ---@alias Constants.SkillExtraRequireType integer @ 技能使用时候的额外需求
    SkillExtraRequireType = {
        BuffLay = 1, -- 某个buff是否有足够的层数
    },

    ---@alias Constants.SkillCostType integer @ 技能消耗的需求
    SkillCostType = {
        Mp      = 1, -- 蓝量消耗
        BuffLay = 2, -- 消耗一定层数的某buff
    },

    ---@alias Constants.ServerAttr string @ 从服务器过来的属性对照表
    ServerAttr = {
        hp   = 'Hp',
        atk  = 'Attack',
        def  = 'Defense',
        matk = 'MAttack',
        mdef = 'MDefense',
        lk   = 'Luck',
        crit = 'Critical',
        crid = 'CritDamage',
        hit  = 'Hit',
        dge  = 'Dodge',
        pen  = 'Penetration',
        bear = 'Bear',
    },

    ---@alias Constants.SkillShowType integer @ 技能表现类型
    SkillShowType = {
        Melee         = 1, -- 近战
        Shot          = 2, -- 远程
        Ultra         = 0, -- 大招
        Buff          = 3,
        TimelineUltra = 4, -- timeline大招
        SpecialShot   = 5, -- 无子弹特殊射击表现
    },

    ---@alias Constants.CardComboType integer @ 卡牌的连携枚举
    CardComboType = {
        A  = 1,
        B  = 2,
        C  = 3,
        D  = 4,
        SP = 0,
        X  = -1,
    },

    ---@alias Constants.FXType integer @ 特效类型
    FXType = {
        Bone     = 2, -- 绑定骨骼的特效
        Normal   = 1, -- 普通特效
        Ground   = 3, -- 地面特效
        Timeline = 4,
        Matcap   = 5,
        Special  = 6,
        HeadTop  = 7,   -- 头顶特效
    },

    ---@alias Constants.FXTypeSpecial integer
    FXTypeSpecial = {
        Invisible = 1, -- 隐身
        Freeze    = 2, -- 冰冻
        Unhurt    = 3, -- 不会受击
    },

    ---@alias Constants.HitType integer @ 命中动作类型
    HitType = {
        None   = 0,
        Normal = 1,
        Heavy  = 2,
        Float  = 3,
        Left   = 4,
        Right  = 5,
        Tiny   = 6,
        Down   = 7,
    },

    ---@alias Constants.AddSPType integer @ 增加技能点的来源类型
    AddSPType = {
        None        = 0,
        Skill       = 1,
        UnitCard    = 2,
        SkillEffect = 3,
    },

    --- 猫球技能表现类型对应的技能表现id
    SkillCatSkillViewIdMap = {
        [1] = 4030101,   -- 主动攻击
        [2] = 4330101,   -- 主动防御
        [3] = 4230101,   -- 被动
    },

    ---@alias Constants.HitFromType integer @ 主条件10、20的命中来源
    HitFromType = {
        SkillMainEffect         = 1,    -- 技能主效果
        SkillSubEffect          = 2,    -- 技能子效果
        DamageLink              = 3,    -- 伤害链接
    },
}
return Constants
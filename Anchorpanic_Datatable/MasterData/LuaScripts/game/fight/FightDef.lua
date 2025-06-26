local FightDef = {}

local ENUM_IDX = 0
local function _enumID()
    ENUM_IDX = ENUM_IDX + 1
    return ENUM_IDX
end

-- 战斗出手类型：正常开始战斗
FightDef.HAND_NORMAL = 0
-- 战斗出手类型：偷袭
FightDef.HAND_SNEAK_ATTACK = 1
-- 战斗出手类型：被偷袭
FightDef.HAND_BE_SNEAK_ATTACK = 2

FightDef.ATTACKER_SIDE = 1
FightDef.DEFEBDER_SIDE = 2

-- 战斗效果类型 BEGIN

--1).     % 伤害(伤害值)
FightDef.BATTLE_TYPE_DAMAGE = 1
--2).     % 闪避
FightDef.BATTLE_TYPE_EVADE = 2
--3).     % 暴击 (伤害值)
FightDef.BATTLE_TYPE_CRIT = 3
--4).     % 元素伤害(伤害值 值2:[元素类型, 是否暴击])
FightDef.BATTLE_TYPE_ELE_DAMAGE = 4
--5).     % 加buff(BuffId)(值2:[添加层数,剩余回合数])
FightDef.BATTLE_TYPE_BUFF_ADD = 5
--6).     % 爆裂 (伤害值)
FightDef.BATTLE_TYPE_BURST = 6
--7).     % 吞噬
FightDef.BATTLE_TYPE_SWALLOW = 7
--8).     % 死亡
FightDef.BATTLE_TYPE_DEAD = 8
--9).     % 技能行动分段开始,用来区分开多段伤害
FightDef.BATTLE_TYPE_ATT = 9
--10).    % buff触发(BuffId)
FightDef.BATTLE_TYPE_BUFF_TRIGGER = 10
--11).    % 移除buff(BuffId)(值2:[移除层数,剩余回合数])
FightDef.BATTLE_TYPE_BUFF_REMOVE = 11
--12).    % 直接伤害 (伤害值)
FightDef.BATTLE_TYPE_DIRECT_DAMAGE = 12
--13).    % 回血(治疗量)
FightDef.BATTLE_TYPE_CURE = 13
--14).    % 复活(复活后的血量)加到复活里面了
FightDef.BATTLE_TYPE_REVIVE = 14
--15).    % 新增当前回合出手顺序(最新位置下标,从1开始)
FightDef.BATTLE_TYPE_CURL_ORDER = 15
--16).    % 新增下一回合出手顺序(最新位置下标,从1开始)
FightDef.BATTLE_TYPE_NEXT_ORDER = 16
--17).    % 增加核能(变化值)
FightDef.BATTLE_TYPE_ADD_RAGE = 17
--18).    % 减少核能(变化值)
FightDef.BATTLE_TYPE_DEC_RAGE = 18
--19).    % 增加魂玉 (加值
FightDef.BATTLE_TYPE_ADD_SKILL_SOUL = 19
--20).    % 减少魂玉 (减值
FightDef.BATTLE_TYPE_DEC_SKILL_SOUL = 20
--21).    % 磁暴 - 清空感电 (伤害值)
FightDef.BATTLE_TYPE_CLEAR_ELECTROCUTE = 21
--22).    % 暗刺攻击(目标ID)
FightDef.BATTLE_TYPE_DARKTHORN = 22
--[[23).    % 被放逐
被命中的敌人会被附加放逐效果，该效果会使单个敌人从阵型中消失1回合，消失期间该角色无法攻击敌人，
也无法被敌人攻击。再次出现时会随机掉落在一个空缺的位置。如果敌方仅一人在场时会立即坠落。
--]]
FightDef.BATTLE_TYPE_EXILE = 23
--24).    % 放逐落下 (值2:[x,y])
FightDef.BATTLE_TYPE_EXILE_BACK = 24
--25).    % 护盾值 增加
FightDef.BATTLE_TYPE_SHIELD_ADD = 25
--26).    % 护盾值 减少
FightDef.BATTLE_TYPE_SHIELD_DEC = 26
--27).    % 被击飞(值2:[x,y]落点位置)
FightDef.BATTLE_TYPE_KNOCK_OFF = 27
--28).    % 反伤(伤害值)
FightDef.BATTLE_TYPE_ANTI_INJURY = 28
--29).    % 感电(伤害值)
FightDef.BATTLE_TYPE_ELECTROCUTE = 29
--30).    % 流血(伤害值)
FightDef.BATTLE_TYPE_BLEED = 30
--31).    % 灼烧(伤害值)
FightDef.BATTLE_TYPE_BURN = 31
--32).    % 格挡
FightDef.BATTLE_TYPE_BLOCK = 32
--33).    % 掷骰子(骰子点数)
--4件套：每回合开始前掷出一个骰子，角色会获得5% * 骰子点数的攻击力加成，当骰子为6时，额外获得20%的无视防御，持续1回合
FightDef.BATTLE_TYPE_DICE = 33
--34).    % 致盲效果导致攻击落空
FightDef.BATTLE_TYPE_BLIND = 34
--35).    % 剧情播放(剧情ID)
FightDef.BATTLE_TYPE_STORY = 35
--36).    % 剧情导致下场
FightDef.BATTLE_TYPE_STORY_HERO_OUT = 36
--37).    % 剧情导致血量直接变化(新血量)
FightDef.BATTLE_TYPE_STORY_CHANGE_HP = 37
--38).    % 变形(值2:[目标阵营,目标ID])
FightDef.BATTLE_TYPE_TRANSFORM = 38
--39    % 变形结束
FightDef.BATTLE_TYPE_TRANSFORM_END = 39
--40    % 血量最大值改变(值2:[新最大值, 新当前血量值])
FightDef.BATTLE_TYPE_MAX_HP_CHANGE = 40
--41    % 技能冷却剩余时间变化(值2:[技能ID, 新冷却剩余回合数])
FightDef.BATTLE_TYPE_SKILL_CD_CHANGE = 41
--42    % 元素反应(值2:[变化类型: 1添加,标记类型,层数|2移除,标记类型,层数|3反应,已有标记类型,新加标记类型])
FightDef.BATTLE_TYPE_ELE_REACTION = 42
--43    % qte力场值更新(最新值, 值2:[目标阵营])
FightDef.BATTLE_TYPE_QTE_ENERGY = 43
--45    % 被击退(值2:[x,y]新位置)
FightDef.BATTLE_TYPE_KNOCK_BACK = 45
--46    % 死亡角色位置变动(值2:[x,y]新位置)
FightDef.BATTLE_TYPE_DEAD_POS_CHANGE = 46
--47    % 盟约战场技能使用(值2:[释放阵营, 技能ID])
FightDef.BATTLE_TYPE_FORCES_SKILL = 47
--48    % 进入灵魂状态
FightDef.BATTLE_TYPE_GHOST = 48
--49).  % 技能消耗替换(值2:[技能ID, 新消耗值])
FightDef.BATTLE_TYPE_REPLACE_COST = 49
--50).  % 角色加入(值2:[角色阵营, 角色ID])
FightDef.BATTLE_TYPE_HERO_IN = 50
--51). % 技能冷却所需时间变化(值2:[技能ID, 新冷却所需回合数])
FightDef.BATTLE_TYPE_SKILL_NEED_CD = 51
--52). % 盟约技能能量更新(最新值)
FightDef.BATTLE_TYPE_FORCES_SKILL_ENERGY = 52
--53). % 怒气上限修改(值)
FightDef.BATTLE_TYPE_CHANGE_MAX_RAGE = 53
--54). % 格挡次数
FightDef.BATTLE_TYPE_QTE_COUNT = 54
--55). % buff层数同步
FightDef.BATTLE_TYPE_BUFF_LAYERS_COUNTS = 55

--60). % boss离场
FightDef.BATTLE_TYPE_HERO_OUT = 60

--61).    % 当前回合移除出手顺序
FightDef.BATTLE_TYPE_CURL_ORDER_DEL = 61
--62).    % 下一回合移除出手顺序
FightDef.BATTLE_TYPE_NEXT_ORDER_DEL = 62
--63).  % 战斗伤害扣护盾值(值)
FightDef.BATTLE_TYPE_HURT_ON_SHIELD = 63
--64).  % 被动技能效果表现
FightDef.BATTLE_TYPE_PASSIVE_SKILL = 64
--65).  % boss转阶段
FightDef.BATTLE_TYPE_CHANGE_STAGE = 65
--66).    % 硬直值更新(值:当前值)
FightDef.BATTLE_TYPE_HIT_STUN = 66
--67).  % 怪物表现变化(值2:效果配置的value值)
FightDef.BATTLE_TYPE_CHANGE_MON_DISPLAY = 67
--70). % boss血条状态值(值:最新值)
FightDef.BATTLE_TYPE_BOSS_STATE_SHOW_VALUE = 70
--71). % 效果换位(值2:[x, y])
FightDef.BATTLE_TYPE_CHANGE_POS = 71
--72).    % 硬直值最大值更新(值:最大值)
FightDef.BATTLE_TYPE_MAX_HIT_STUN = 72
--73)。% 副本boss承受伤害值 (公会战用)
FightDef.BATTLE_TYPE_BOSS_SUFFER_DAMAGE = 73
--75)。% 战斗加场地护盾值(值)
FightDef.BATTLE_TYPE_ADD_SCENE_SHIELD = 74
--75)。% 战斗伤害扣场地护盾值(值)
FightDef.BATTLE_TYPE_HURT_ON_SCENE_SHIELD = 75

--77).    % 闪蝶静电球放电
FightDef.BATTLE_TYPE_SHANDIE_ELE_CAMERA = 77

-- 战斗效果类型 END

-- 战斗元素类型
-- 401).   % 电属性
FightDef.ATTR_ELE_HURT_THUNDER = 401
-- 402).   % 火属性
FightDef.ATTR_ELE_HURT_FIRE = 402
-- 403).   % 冰属性
FightDef.ATTR_ELE_HURT_ICE = 403
-- 404).   % 自然
FightDef.ATTR_ELE_HURT_NATURE = 404
-- 405).   % 光
FightDef.ATTR_ELE_HURT_LIGHT = 405

-- 战斗回放的返回类型
-- 没有找到回放
FightDef.REPLAY_NONE = 1
-- 回放失效
FightDef.REPLAY_VSN = 2

-- 属于伤害的类型
FightDef.DAMAGE_TYPE_SET = {
    [FightDef.BATTLE_TYPE_DAMAGE] = true,
    [FightDef.BATTLE_TYPE_CRIT] = true,
    [FightDef.BATTLE_TYPE_ELE_DAMAGE] = true,
    [FightDef.BATTLE_TYPE_BURST] = true,
    [FightDef.BATTLE_TYPE_DIRECT_DAMAGE] = true,
    -- [FightDef.BATTLE_TYPE_ANTI_INJURY] = true,
    [FightDef.BATTLE_TYPE_CLEAR_ELECTROCUTE] = true,
    [FightDef.BATTLE_TYPE_BLEED] = true,
    [FightDef.BATTLE_TYPE_BURN] = true,
}

-- 伤害表现类型
FightDef.DAMAGE_HIT_ACTION_SET = {
    [FightDef.BATTLE_TYPE_DAMAGE] = true,
    [FightDef.BATTLE_TYPE_CRIT] = true,
    [FightDef.BATTLE_TYPE_ELE_DAMAGE] = true,
    [FightDef.BATTLE_TYPE_BURST] = true,
    [FightDef.BATTLE_TYPE_DIRECT_DAMAGE] = true,
    [FightDef.BATTLE_TYPE_ANTI_INJURY] = true,
    [FightDef.BATTLE_TYPE_CLEAR_ELECTROCUTE] = true,
    [FightDef.BATTLE_TYPE_BLEED] = true,
    [FightDef.BATTLE_TYPE_BURN] = true,
    [FightDef.BATTLE_TYPE_SHIELD_DEC] = true,
}

-- 需要飘字的类型
FightDef.FLY_TEXT_ACTION_SET = {
    [FightDef.BATTLE_TYPE_DAMAGE] = true,
    [FightDef.BATTLE_TYPE_CRIT] = true,
    [FightDef.BATTLE_TYPE_ELE_DAMAGE] = true,
    [FightDef.BATTLE_TYPE_BURST] = true,
    [FightDef.BATTLE_TYPE_DIRECT_DAMAGE] = true,
    [FightDef.BATTLE_TYPE_ANTI_INJURY] = true,
    [FightDef.BATTLE_TYPE_CLEAR_ELECTROCUTE] = true,
    [FightDef.BATTLE_TYPE_BLEED] = true,
    [FightDef.BATTLE_TYPE_BURN] = true,
    [FightDef.BATTLE_TYPE_CURE] = true,
    [FightDef.BATTLE_TYPE_SHIELD_ADD] = true,
    [FightDef.BATTLE_TYPE_HURT_ON_SHIELD] = true,
    [FightDef.BATTLE_TYPE_ADD_SCENE_SHIELD] = true,
    [FightDef.BATTLE_TYPE_HURT_ON_SCENE_SHIELD] = true,
}

-- 模型动作枚举
FightDef.ACT_ATTACK_1 = gs.Animator.StringToHash("atk01")
FightDef.ACT_ATTACK_2 = gs.Animator.StringToHash("atk02")
FightDef.ACT_SKILL_1 = gs.Animator.StringToHash("skill01")
FightDef.ACT_SKILL_2 = gs.Animator.StringToHash("skill02")
FightDef.ACT_SKILL_3 = gs.Animator.StringToHash("skill03")
FightDef.ACT_SKILL_MIX = gs.Animator.StringToHash("skillmix")
FightDef.ACT_SKILL_MAX = gs.Animator.StringToHash("skillmax")

FightDef.ACT_STAND = gs.Animator.StringToHash("stand")
FightDef.ACT_RUN = gs.Animator.StringToHash("run")
FightDef.ACT_GETUP = gs.Animator.StringToHash("getup")
FightDef.ACT_READY = gs.Animator.StringToHash("ready")
FightDef.ACT_EXIT = gs.Animator.StringToHash("exit")
FightDef.ACT_GOIN = gs.Animator.StringToHash("goin")
FightDef.ACT_WIN = gs.Animator.StringToHash("win")
FightDef.ACT_WALK = gs.Animator.StringToHash("walk")

FightDef.ACT_LEAVE = gs.Animator.StringToHash("leave")
FightDef.ACT_ENTER = gs.Animator.StringToHash("enter")
FightDef.ACT_ENTER_1 = gs.Animator.StringToHash("enter01")
FightDef.ACT_STANDBY = gs.Animator.StringToHash("standby")
FightDef.ACT_DIZZY = gs.Animator.StringToHash("dizzy")
FightDef.ACT_BERSERK = gs.Animator.StringToHash("berserk")
FightDef.ACT_CHANGE = gs.Animator.StringToHash("change")
FightDef.ACT_CHANGE_1 = gs.Animator.StringToHash("change01")
FightDef.ACT_CHANGE_2 = gs.Animator.StringToHash("change02")

FightDef.ACT_DIE = gs.Animator.StringToHash("die")
FightDef.ACT_HIT_1 = gs.Animator.StringToHash("hit01")
FightDef.ACT_HIT_2 = gs.Animator.StringToHash("hit02")
FightDef.ACT_HIT_3 = gs.Animator.StringToHash("hit03")
FightDef.ACT_HIT_4 = gs.Animator.StringToHash("hit04")
FightDef.ACT_HIT_5 = gs.Animator.StringToHash("hit05")
FightDef.ACT_HIT_6 = gs.Animator.StringToHash("hit06")

FightDef.ACT_SHOW_IDLE = gs.Animator.StringToHash("showidle")
FightDef.ACT_SHOW_IDLE_TIME_1 = gs.Animator.StringToHash("showidletime01")
FightDef.ACT_SHOW_IDLE_TIME_2 = gs.Animator.StringToHash("showidletime02")
FightDef.ACT_SHOW_IDLE_TIME_3 = gs.Animator.StringToHash("showidletime03")
FightDef.ACT_SHOW_IDLE_TIME_4 = gs.Animator.StringToHash("showidletime04")

FightDef.ACT_SHOW_TIME_1 = gs.Animator.StringToHash("showtime01")
FightDef.ACT_SHOW_TIME_2 = gs.Animator.StringToHash("showtime02")
FightDef.ACT_SHOW_TIME_3 = gs.Animator.StringToHash("showtime03")
FightDef.ACT_SHOW_TIME_4 = gs.Animator.StringToHash("showtime04")

FightDef.ACT_SHOW_STAND = gs.Animator.StringToHash("showstand")
FightDef.ACT_SHOW_STAND_TIME_1 = gs.Animator.StringToHash("showstandtime01")

FightDef.ACT_SHOW_READY = gs.Animator.StringToHash("showready")

-- 剧情相关
FightDef.ACT_STORY_A = gs.Animator.StringToHash("A")
FightDef.ACT_STORY_A_1 = gs.Animator.StringToHash("A-1")
FightDef.ACT_STORY_A_1_1 = gs.Animator.StringToHash("A-1-1")
FightDef.ACT_STORY_A_1_2 = gs.Animator.StringToHash("A-1-2")
FightDef.ACT_STORY_A_1_3 = gs.Animator.StringToHash("A-1-3")

FightDef.ACT_STORY_A_2 = gs.Animator.StringToHash("A-2")
FightDef.ACT_STORY_A_2_1 = gs.Animator.StringToHash("A-2-1")
FightDef.ACT_STORY_A_2_2 = gs.Animator.StringToHash("A-2-2")
FightDef.ACT_STORY_A_2_3 = gs.Animator.StringToHash("A-2-3")

FightDef.ACT_STORY_A_3 = gs.Animator.StringToHash("A-3")
FightDef.ACT_STORY_A_3_1 = gs.Animator.StringToHash("A-3-1")
FightDef.ACT_STORY_A_3_2 = gs.Animator.StringToHash("A-3-2")
FightDef.ACT_STORY_A_3_3 = gs.Animator.StringToHash("A-3-3")

FightDef.ACT_STORY_A_4 = gs.Animator.StringToHash("A-4")
FightDef.ACT_STORY_A_4_1 = gs.Animator.StringToHash("A-4-1")
FightDef.ACT_STORY_A_4_2 = gs.Animator.StringToHash("A-4-2")
FightDef.ACT_STORY_A_4_3 = gs.Animator.StringToHash("A-4-3")

FightDef.ACT_STORY_A_5 = gs.Animator.StringToHash("A-5")
FightDef.ACT_STORY_A_5_1 = gs.Animator.StringToHash("A-5-1")
FightDef.ACT_STORY_A_5_2 = gs.Animator.StringToHash("A-5-2")
FightDef.ACT_STORY_A_5_3 = gs.Animator.StringToHash("A-5-3")

FightDef.ACT_STORY_A_6 = gs.Animator.StringToHash("A-6")
FightDef.ACT_STORY_A_6_1 = gs.Animator.StringToHash("A-6-1")
FightDef.ACT_STORY_A_6_2 = gs.Animator.StringToHash("A-6-2")
FightDef.ACT_STORY_A_6_3 = gs.Animator.StringToHash("A-6-3")

FightDef.ACT_STORY_A_7 = gs.Animator.StringToHash("A-7")
FightDef.ACT_STORY_A_7_1 = gs.Animator.StringToHash("A-7-1")
FightDef.ACT_STORY_A_7_2 = gs.Animator.StringToHash("A-7-2")
FightDef.ACT_STORY_A_7_3 = gs.Animator.StringToHash("A-7-3")

FightDef.ACT_STORY_B = gs.Animator.StringToHash("B")
FightDef.ACT_STORY_B_1 = gs.Animator.StringToHash("B-1")
FightDef.ACT_STORY_B_1_1 = gs.Animator.StringToHash("B-1-1")
FightDef.ACT_STORY_B_1_2 = gs.Animator.StringToHash("B-1-2")
FightDef.ACT_STORY_B_1_3 = gs.Animator.StringToHash("B-1-3")

FightDef.ACT_STORY_B_2 = gs.Animator.StringToHash("B-2")
FightDef.ACT_STORY_B_2_1 = gs.Animator.StringToHash("B-2-1")
FightDef.ACT_STORY_B_2_2 = gs.Animator.StringToHash("B-2-2")
FightDef.ACT_STORY_B_2_3 = gs.Animator.StringToHash("B-2-3")

FightDef.ACT_STORY_B_3 = gs.Animator.StringToHash("B-3")
FightDef.ACT_STORY_B_3_1 = gs.Animator.StringToHash("B-3-1")
FightDef.ACT_STORY_B_3_2 = gs.Animator.StringToHash("B-3-2")
FightDef.ACT_STORY_B_3_3 = gs.Animator.StringToHash("B-3-3")

FightDef.ACT_STORY_B_4 = gs.Animator.StringToHash("B-4")
FightDef.ACT_STORY_B_4_1 = gs.Animator.StringToHash("B-4-1")
FightDef.ACT_STORY_B_4_2 = gs.Animator.StringToHash("B-4-2")
FightDef.ACT_STORY_B_4_3 = gs.Animator.StringToHash("B-4-3")

FightDef.ACT_STORY_B_5 = gs.Animator.StringToHash("B-5")
FightDef.ACT_STORY_B_5_1 = gs.Animator.StringToHash("B-5-1")
FightDef.ACT_STORY_B_5_2 = gs.Animator.StringToHash("B-5-2")
FightDef.ACT_STORY_B_5_3 = gs.Animator.StringToHash("B-5-3")

FightDef.ACT_STORY_B_6 = gs.Animator.StringToHash("B-6")
FightDef.ACT_STORY_B_6_1 = gs.Animator.StringToHash("B-6-1")
FightDef.ACT_STORY_B_6_2 = gs.Animator.StringToHash("B-6-2")
FightDef.ACT_STORY_B_6_3 = gs.Animator.StringToHash("B-6-3")

FightDef.ACT_STORY_B_7 = gs.Animator.StringToHash("B-7")
FightDef.ACT_STORY_B_7_1 = gs.Animator.StringToHash("B-7-1")
FightDef.ACT_STORY_B_7_2 = gs.Animator.StringToHash("B-7-2")
FightDef.ACT_STORY_B_7_3 = gs.Animator.StringToHash("B-7-3")

FightDef.ACT_TALK_MOUTH = gs.Animator.StringToHash("talk_mouth")
FightDef.ACT_0_MOUTH = gs.Animator.StringToHash("0_mouth")

-- 动作归属层，默认0
FightDef.ANI_BELONG_LAYER = {
    [FightDef.ACT_TALK_MOUTH] = 2,
    [FightDef.ACT_0_MOUTH] = 2,
}

--动作触发过渡条件定义
FightDef.TRANS_READY = gs.Animator.StringToHash("READY")
FightDef.TRANS_EXIT = gs.Animator.StringToHash("EXIT")
FightDef.TRANS_ATK01 = gs.Animator.StringToHash("ATK01")
FightDef.TRANS_ATK02 = gs.Animator.StringToHash("ATK02")
FightDef.TRANS_SKILL01 = gs.Animator.StringToHash("SKILL01")
FightDef.TRANS_SKILL02 = gs.Animator.StringToHash("SKILL02")
FightDef.TRANS_SKILL03 = gs.Animator.StringToHash("SKILL03")
FightDef.TRANS_SKILLMIX = gs.Animator.StringToHash("SKILLMIX")
FightDef.TRANS_SKILLMAX = gs.Animator.StringToHash("SKILLMAX")

FightDef.ANI_BOOL_TO_GETUP = gs.Animator.StringToHash("TO_GETUP")
FightDef.ANI_TRIGGER_TO_STAND = gs.Animator.StringToHash("TO_STAND")
FightDef.ANI_TRIGGER_TO_RUN = gs.Animator.StringToHash("TO_RUN")
FightDef.ANI_TRIGGER_TO_WALK = gs.Animator.StringToHash("TO_WALK")

FightDef.TRANS_STATES = {
    [FightDef.TRANS_READY] = FightDef.ACT_READY,
    [FightDef.TRANS_EXIT] = FightDef.ACT_EXIT,
    [FightDef.TRANS_ATK01] = FightDef.ACT_ATTACK_1,
    [FightDef.TRANS_ATK02] = FightDef.ACT_ATTACK_2,
    [FightDef.TRANS_SKILL01] = FightDef.ACT_SKILL_1,
    [FightDef.TRANS_SKILL02] = FightDef.ACT_SKILL_2,
    [FightDef.TRANS_SKILL03] = FightDef.ACT_SKILL_3,
    [FightDef.TRANS_SKILLMIX] = FightDef.ACT_SKILL_MIX,
    [FightDef.TRANS_SKILLMAX] = FightDef.ACT_SKILL_MAX,
    [FightDef.ANI_TRIGGER_TO_STAND] = FightDef.ACT_STAND,
    [FightDef.ANI_TRIGGER_TO_RUN] = FightDef.ACT_RUN,
    [FightDef.ANI_TRIGGER_TO_WALK] = FightDef.ACT_WALK,
}

--连线动画(需要预加载的)
FightDef.HashExitTimeAnimation = {
    [FightDef.ACT_SHOW_STAND_TIME_1] = FightDef.ACT_SHOW_STAND,
    [FightDef.ACT_GOIN] = FightDef.ACT_STAND,

    [FightDef.ACT_SHOW_TIME_1] = FightDef.ACT_SHOW_IDLE,
    [FightDef.ACT_SHOW_TIME_2] = FightDef.ACT_SHOW_IDLE,
    [FightDef.ACT_SHOW_TIME_3] = FightDef.ACT_SHOW_IDLE,
    [FightDef.ACT_SHOW_TIME_4] = FightDef.ACT_SHOW_IDLE,
    [FightDef.ACT_SHOW_IDLE_TIME_1] = FightDef.ACT_SHOW_IDLE,
    [FightDef.ACT_SHOW_IDLE_TIME_2] = FightDef.ACT_SHOW_IDLE,
    [FightDef.ACT_SHOW_IDLE_TIME_3] = FightDef.ACT_SHOW_IDLE,

    [FightDef.ACT_STORY_A_1] = FightDef.ACT_STORY_A,
    [FightDef.ACT_STORY_A_2] = FightDef.ACT_STORY_A,
    [FightDef.ACT_STORY_A_3] = FightDef.ACT_STORY_A,
    [FightDef.ACT_STORY_A_4] = FightDef.ACT_STORY_A,
    [FightDef.ACT_STORY_A_5] = FightDef.ACT_STORY_A,
    [FightDef.ACT_STORY_A_6] = FightDef.ACT_STORY_A,
    [FightDef.ACT_STORY_A_7] = FightDef.ACT_STORY_A,

    [FightDef.ACT_STORY_B_1] = FightDef.ACT_STORY_B,
    [FightDef.ACT_STORY_B_2] = FightDef.ACT_STORY_B,
    [FightDef.ACT_STORY_B_3] = FightDef.ACT_STORY_B,
    [FightDef.ACT_STORY_B_4] = FightDef.ACT_STORY_B,
    [FightDef.ACT_STORY_B_5] = FightDef.ACT_STORY_B,
    [FightDef.ACT_STORY_B_6] = FightDef.ACT_STORY_B,
    [FightDef.ACT_STORY_B_7] = FightDef.ACT_STORY_B,

    [FightDef.ACT_STORY_A_1_1] = FightDef.ACT_STORY_A_1_2,
    [FightDef.ACT_STORY_A_2_1] = FightDef.ACT_STORY_A_2_2,
    [FightDef.ACT_STORY_A_3_1] = FightDef.ACT_STORY_A_3_2,
    [FightDef.ACT_STORY_A_4_1] = FightDef.ACT_STORY_A_4_2,
    [FightDef.ACT_STORY_A_5_1] = FightDef.ACT_STORY_A_5_2,
    [FightDef.ACT_STORY_A_6_1] = FightDef.ACT_STORY_A_6_2,
    [FightDef.ACT_STORY_A_7_1] = FightDef.ACT_STORY_A_7_2,

    [FightDef.ACT_STORY_B_1_1] = FightDef.ACT_STORY_B_1_2,
    [FightDef.ACT_STORY_B_2_1] = FightDef.ACT_STORY_B_2_2,
    [FightDef.ACT_STORY_B_3_1] = FightDef.ACT_STORY_B_3_2,
    [FightDef.ACT_STORY_B_4_1] = FightDef.ACT_STORY_B_4_2,
    [FightDef.ACT_STORY_B_5_1] = FightDef.ACT_STORY_B_5_2,
    [FightDef.ACT_STORY_B_6_1] = FightDef.ACT_STORY_B_6_2,
    [FightDef.ACT_STORY_B_7_1] = FightDef.ACT_STORY_B_7_2,
}

-- 模型动作名
FightDef.ACTION_NAMEs = {
    [FightDef.ACT_STAND] = "stand",
    [FightDef.ACT_DIE] = "die",
    [FightDef.ACT_GETUP] = "getup",
    [FightDef.ACT_READY] = "ready",
    [FightDef.ACT_EXIT] = "exit",
    [FightDef.ACT_GOIN] = "goin",
    [FightDef.ACT_WIN] = "win",
    [FightDef.ACT_HIT_1] = "hit01",
    [FightDef.ACT_HIT_2] = "hit02",
    [FightDef.ACT_HIT_3] = "hit03",
    [FightDef.ACT_HIT_4] = "hit04",
    [FightDef.ACT_ATTACK_1] = "atk01",
    [FightDef.ACT_ATTACK_2] = "atk02",
    [FightDef.ACT_SKILL_1] = "skill01",
    [FightDef.ACT_SKILL_2] = "skill02",
    [FightDef.ACT_SKILL_3] = "skill03",
    [FightDef.ACT_SKILL_MIX] = "skillmix",
    [FightDef.ACT_SKILL_MAX] = "skillmax",
    [FightDef.ACT_SHOW_STAND] = "showstand",
    -- [FightDef.ACT_SHOW_CHANGE_1] = "showchange01",
    [FightDef.ACT_SHOW_READY] = "showready",
    [FightDef.ACT_SHOW_TIME_1] = "showtime01",
    [FightDef.ACT_SHOW_TIME_2] = "showtime02",
    [FightDef.ACT_SHOW_TIME_3] = "showtime03",
    [FightDef.ACT_SHOW_TIME_4] = "showtime04",
    [FightDef.ACT_SHOW_IDLE_TIME_1] = "showidletime01",
    [FightDef.ACT_SHOW_IDLE_TIME_2] = "showidletime02",
    [FightDef.ACT_SHOW_IDLE_TIME_3] = "showidletime03",
    [FightDef.ACT_SHOW_IDLE_TIME_4] = "showidletime04",
    [FightDef.ACT_RUN] = "run",
    [FightDef.ACT_LEAVE] = "leave",
    [FightDef.ACT_ENTER] = "enter",
    [FightDef.ACT_ENTER_1] = "enter01",
    [FightDef.ACT_STANDBY] = "standby",
    [FightDef.ACT_CHANGE] = "change",
    [FightDef.ACT_CHANGE_1] = "change01",
    [FightDef.ACT_CHANGE_2] = "change02",
    [FightDef.ACT_DIZZY] = "dizzy",
    [FightDef.ACT_BERSERK] = "berserk",
}
-- 编辑工具类型到真实数据的转换
FightDef.EDIT_ATK2HASH = {
    [1] = FightDef.TRANS_ATK01,
    [2] = FightDef.TRANS_ATK02,
    [3] = FightDef.TRANS_SKILL01,
    [4] = FightDef.TRANS_SKILL02,
    [5] = FightDef.TRANS_SKILL03,
    [6] = FightDef.TRANS_SKILLMIX,
    [7] = FightDef.TRANS_SKILLMAX,
}
-- 配置表字段到真实数据的转换
FightDef.TABLE_ATK2HASH = {
    ["atk01"] = FightDef.TRANS_ATK01,
    ["atk02"] = FightDef.TRANS_ATK02,
    ["skill01"] = FightDef.TRANS_SKILL01,
    ["skill02"] = FightDef.TRANS_SKILL02,
    ["skill03"] = FightDef.TRANS_SKILL03,
    ["skillmix"] = FightDef.TRANS_SKILLMIX,
    ["skillmax"] = FightDef.TRANS_SKILLMAX,
}
--场景中心挂点
FightDef.POINT_SCENE_CENTER = 0
--头顶挂点
FightDef.POINT_TOP = 1
--脚底挂点
FightDef.POINT_ROOT = 2
--受击挂点
FightDef.POINT_SPINE = 3
--左手武器挂点
FightDef.POINT_LWEAPON = 4
--右手武器挂点
FightDef.POINT_RWEAPON = 5
--相机挂点
FightDef.POINT_CAMERA = 6
--左手武器发射挂点
FightDef.POINT_LFIRE = 7
--右手武器发射挂点
FightDef.POINT_RFIRE = 8
--击飞挂点
FightDef.POINT_HIT = 9
-- 头部
FightDef.POINT_HEAD = 10


-- 跟随相机旋转挂点
FightDef.POINT_CAMERA_RT = 50
-- 跟随相机轨道挂点
FightDef.POINT_CAMERA_DT = 51
-- 跟随相机翻转挂点
FightDef.POINT_CAMERA_FT = 52

-------------- 技能主类型
-- 普攻
FightDef.SKILL_TYPE_NORMAL_ATTACK = 0
-- 主动技能
FightDef.SKILL_TYPE_ACTIVE_SKILL = 1
-- 终结技能
FightDef.SKILL_TYPE_FINAL_SKILL = 2
-- 奥义技能
FightDef.SKILL_TYPE_AOYI_SKILL = 3
-- 被动技能
FightDef.SKILL_TYPE_PASSIVE_SKILL = 4

--盟约主动技能
FightDef.SKILL_TYPE_FORCES = 6

-------------- 被动技能子类型
-- 普通被动技能
FightDef.PASSIVE_SKILL_SUB_TYPE_NORMAL = 0
-- 星级被动技能
FightDef.PASSIVE_SKILL_SUB_TYPE_STAR = 1
-- 军阶被动技能
FightDef.PASSIVE_SKILL_SUB_TYPE_MILITAY = 2

-- 战斗的自动模式
FightDef.BATTLE_AUTO1 = 1 --默认手动
FightDef.BATTLE_AUTO2 = 2 --默认自动
FightDef.BATTLE_AUTO_LOCK = false --是否锁定AUTO功能
-- 战斗的倍速模式
FightDef.BATTLE_SPEED1 = 1 --默认正常速度
FightDef.BATTLE_SPEED2 = 2 --默认两倍速度
FightDef.BATTLE_SPEED_LOCK = false --是否锁定速度变化

-- 战斗队列类型
FightDef.ACTION_TYPE_NOR = 1 -- 普通action
FightDef.ACTION_TYPE_END = 2 -- 回合结束
FightDef.ACTION_TYPE_EFFECT = 3 -- 添加效果
FightDef.ACTION_TYPE_WAVE = 4 -- 下一波
FightDef.ACTION_TYPE_ADD_HERO = 5 -- 加入战员
FightDef.ACTION_TYPE_RESULT = 6 -- 正常战斗结算
FightDef.ACTION_TYPE_RESULT_OVER = 7 -- 非正常结算
FightDef.ACTION_TYPE_WIN = 8 --战斗胜利

-- QTE
FightDef.BATTLE_QTE_NONE = 0 --没有触发
-- 完美格挡
FightDef.BATTLE_QTE_PERFECT = 1
-- 中等格挡
FightDef.BATTLE_QTE_MEDIUM = 2
-- 普通格挡
FightDef.BATTLE_QTE_NOMAL = 3

-- 电量上限
FightDef.MAX_POWER = 10

-- 反向受击类型
FightDef.HITTYPE_REVERSE = {
    [-198277795] = 1,
    [1831326951] = 2,
    [438363249] = 3,
    -- 音效资源未有以下受击音效
    -- [-2075889198] = 4,
    -- [-213696188] = 5,
    -- [1783238910] = 6,
}
-- 1:-198277795, 2:1831326951, 3:438363249, 4:-2075889198, 5:-213696188, 6:1783238910}

-- 自动战斗
FightDef.AUTO_FIGHT_ORDER = 0
-- 自动释放1技能
FightDef.AUTO_FIGHT_SKILL_1 = 2
-- 自动释放2技能
FightDef.AUTO_FIGHT_SKILL_2 = 3
-- 自动释放2技能
FightDef.AUTO_FIGHT_SKILL_RULE = {
    [FightDef.AUTO_FIGHT_ORDER] = 3,
    [FightDef.AUTO_FIGHT_SKILL_1] = 1,
    [FightDef.AUTO_FIGHT_SKILL_2] = 2
}

-------------- 技能类型名字
FightDef.GetSkillTypeName = function(skillType, skillSubType)
    local name = ""
    if (skillType == FightDef.SKILL_TYPE_NORMAL_ATTACK) then
        name = _TT(3031)
    elseif (skillType == FightDef.SKILL_TYPE_ACTIVE_SKILL) then
        name = _TT(3032)
    elseif (skillType == FightDef.SKILL_TYPE_FINAL_SKILL) then
        name = _TT(3033)
    elseif (skillType == FightDef.SKILL_TYPE_AOYI_SKILL) then
        name = _TT(3022) -- "原能爆发"
    elseif (skillType == FightDef.SKILL_TYPE_PASSIVE_SKILL) then
        name = _TT(3034)
        if (skillSubType == fight.FightDef.PASSIVE_SKILL_SUB_TYPE_NORMAL) then -- 普通被动技能
            name = _TT(3034)
        elseif (skillSubType == fight.FightDef.PASSIVE_SKILL_SUB_TYPE_STAR) then -- 星级被动技能
            name = _TT(3035)
        elseif (skillSubType == fight.FightDef.PASSIVE_SKILL_SUB_TYPE_MILITAY) then -- 军阶被动技能
            name = _TT(3036)
        end
    end
    return name
end

FightDef.CAMERA_MOVE_LEFT = 1
FightDef.CAMERA_MOVE_RIGHT = 2
FightDef.CAMERA_MOVE_FAR = 3
FightDef.CAMERA_MOVE_NEAR = 4
FightDef.CAMERA_MOVE_LEFT_ROTATION = 5
FightDef.CAMERA_MOVE_RIGHT_ROTATION = 6
FightDef.CAMERA_MOVE_CENTER = 7

-- GM POST 的DEBUG功能
FightDef.GM_POST1 = {txt = "POST脚本是否可用", val = nil}
FightDef.GM_POST2 = {txt = "POST总开关", val = nil}
FightDef.GM_POST3 = {txt = "POST的GLOW开关", val = nil}
FightDef.GM_POST4 = {txt = "POST的BLOOM开关", val = nil}
FightDef.GM_POST5 = {txt = "POST的TONE开关", val = nil}
FightDef.GM_POST6 = {txt = "POST的LUT开关", val = nil}
FightDef.GM_POST7 = {txt = "POST的RADIAL BLUR开关", val = nil}
FightDef.GM_POST8 = {txt = "POST的BLUR开关", val = nil}
FightDef.GM_POST9 = {txt = "POST的SUN SHAFT开关", val = nil}
FightDef.GM_POST10 = {txt = "POST的NOISE开关", val = nil}
FightDef.GM_POST11 = {txt = "POST的FXAA3开关", val = nil}
FightDef.GM_POST12 = {txt = "FIXED DIRECTION开关", val = nil}

-- GM performance setting

FightDef.TEMP_SETTING_DATAs = {
    {key = 5, title = "骨骼绑定权重", label = {"无", "四根", "两根"}},
    {key = 6, title = "HDR开关", label = {"无", "开", "关"}},
    {key = 7, title = "CommonBuff开关", label = {"无", "开", "关"}},
}

FightDef.TEMP_SETTING_BEABLE = function(tempSettingType)
    for _, data in ipairs(FightDef.TEMP_SETTING_DATAs) do
        if data[1] == tempSettingType then
            if data[4] and data[4] > 1 then
                return true
            end
            return false
        end
    end
    return false
end

FightDef.TEMP_SETTING_BEABLEIdx = function(tempSettingType)
    for _, data in ipairs(FightDef.TEMP_SETTING_DATAs) do
        if data[1] == tempSettingType then
            if data[4] and data[4] > 1 then
                return data[4]
            end
            return
        end
    end
end

return FightDef

--[[ 替换语言包自动生成，请勿修改！
语言包: _TT(3036):"军阶技能"
语言包: _TT(3035):"潜能技能"
语言包: _TT(3034):"被动技能"
语言包: _TT(3034):"被动技能"
语言包: _TT(3033):"终结技能"
语言包: _TT(3032):"主动技能"
语言包: _TT(3031):"普攻"
]]

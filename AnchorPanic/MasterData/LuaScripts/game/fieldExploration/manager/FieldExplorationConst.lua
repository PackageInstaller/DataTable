-- @FileName:   FieldExplorationConst.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-21 10:59:29
-- @Copyright:   (LY) 2023 雷焰网络

FieldExplorationConst = {}

FieldExplorationConst.DupNewOpenStr = "fieldExploration_NewDupOpen_"

--玩家移动模式
FieldExplorationConst.PlayerMoveType =
{
    None = "None", --不可移动
    Free_Mode = "Free_Mode", --自由
    Horizontal_Mode = "Horizontal_Mode", --推箱子横向
    Vertical_Mode = "Vertical_Mode", --推箱子纵向
    Lift_Mode = "Lift_Mode", --举箱子自由移动
}

--碰撞类型
FieldExplorationConst.Collider_Type =
{
    None = 0,
    CapsuleCollider = 1,
    BoxCollider = 2,
    SelfCollider = 3,
    SectorCollider = 4,
}

--碰撞标识
FieldExplorationConst.ColliderTag =
{
    Event = "EVENT",
    EventSkill = "EVENTSKILL",
    Player = "PLAYER",
    PlayerSkill = "PLAYERSKILL",
}

FieldExplorationConst.HERO_ACTION_STATE =
{
    STAND = "STAND",
    DODGE = "DODGE",
    IDLE = "IDLE",
    HIT = "HIT",
    MOVE = "MOVE",
    RUN = "RUN",
    VERTIGO = "VERTIGO", --眩晕
    GRAB = "GRAB", --抓取
    FLASH = "FLASH", --闪现
    LIFT = "LIFT", --举起
}

--不允许打断的状态
FieldExplorationConst.NoAllowForceActionState =
{
    FieldExplorationConst.HERO_ACTION_STATE.IDLE,
    FieldExplorationConst.HERO_ACTION_STATE.VERTIGO,
    FieldExplorationConst.HERO_ACTION_STATE.DODGE,
    -- FieldExplorationConst.HERO_ACTION_STATE.FLASH,
    FieldExplorationConst.HERO_ACTION_STATE.HIT,
}

--允许恢复到Stand的状态
FieldExplorationConst.AllowForceStandState =
{
    FieldExplorationConst.HERO_ACTION_STATE.MOVE,
    FieldExplorationConst.HERO_ACTION_STATE.VERTIGO,
    FieldExplorationConst.HERO_ACTION_STATE.DODGE,
    FieldExplorationConst.HERO_ACTION_STATE.HIT,
    -- FieldExplorationConst.HERO_ACTION_STATE.FLASH,
}

--动画名字
FieldExplorationConst.NAME_STAND = "Qstand"
FieldExplorationConst.NAME_BLINK = "Qblink"
FieldExplorationConst.NAME_DIE = "Qdie"
FieldExplorationConst.NAME_HIT = "Qhit"
FieldExplorationConst.NAME_MOVE = "Qmove"
FieldExplorationConst.NAME_RUN = "Qrun"
FieldExplorationConst.NAME_GOIN = "Qgoin"
FieldExplorationConst.NAME_ATK01 = "Qatk01"
FieldExplorationConst.NAME_PUSH = "Qpush"
FieldExplorationConst.NAME_PULL = "Qpull"
FieldExplorationConst.NAME_RSTAND = "QRstand"
FieldExplorationConst.NAME_BOXDOWN = "Qboxdown"
FieldExplorationConst.NAME_BOXSTAND = "Qboxstand"
FieldExplorationConst.NAME_BOXUP = "Qboxup"
FieldExplorationConst.NAME_BOXWALK = "Qboxwalk"

-- FieldExplorationConst.NAME_RDOWN = "QRdown"

--动画Hash
FieldExplorationConst.ACT_STAND = gs.Animator.StringToHash("Qstand")
FieldExplorationConst.ACT_BLINK = gs.Animator.StringToHash("Qblink")
FieldExplorationConst.ACT_DIE = gs.Animator.StringToHash("Qdie")
FieldExplorationConst.ACT_HIT = gs.Animator.StringToHash("Qhit")
FieldExplorationConst.ACT_MOVE = gs.Animator.StringToHash("Qmove")
FieldExplorationConst.ACT_RUN = gs.Animator.StringToHash("Qrun")
FieldExplorationConst.ACT_GOIN = gs.Animator.StringToHash("Qgoin")
FieldExplorationConst.ACT_ATK01 = gs.Animator.StringToHash("Qatk01")
FieldExplorationConst.ACT_WALK = gs.Animator.StringToHash("Qwalk")
FieldExplorationConst.ACT_PUSH = gs.Animator.StringToHash("Qpush")
FieldExplorationConst.ACT_PULL = gs.Animator.StringToHash("Qpull")
FieldExplorationConst.ACT_RSTAND = gs.Animator.StringToHash("QRstand")
FieldExplorationConst.ACT_BOXDOWN = gs.Animator.StringToHash("Qboxdown")
FieldExplorationConst.ACT_BOXSTAND = gs.Animator.StringToHash("Qboxstand")
FieldExplorationConst.ACT_BOXUP = gs.Animator.StringToHash("Qboxup")
FieldExplorationConst.ACT_BOXWALK = gs.Animator.StringToHash("Qboxwalk")

-- FieldExplorationConst.ACT_RDOWN = gs.Animator.StringToHash("QRdown")

--战员状态对应的动画
FieldExplorationConst.HERO_ACTIONSTATE_ACTHASH =
{
    [FieldExplorationConst.HERO_ACTION_STATE.STAND] = FieldExplorationConst.ACT_STAND,
    [FieldExplorationConst.HERO_ACTION_STATE.DODGE] = FieldExplorationConst.ACT_BLINK,
    [FieldExplorationConst.HERO_ACTION_STATE.IDLE] = FieldExplorationConst.ACT_DIE,
    [FieldExplorationConst.HERO_ACTION_STATE.HIT] = FieldExplorationConst.ACT_HIT,
    [FieldExplorationConst.HERO_ACTION_STATE.MOVE] = FieldExplorationConst.ACT_MOVE,
    [FieldExplorationConst.HERO_ACTION_STATE.RUN] = FieldExplorationConst.ACT_RUN,
    [FieldExplorationConst.HERO_ACTION_STATE.VERTIGO] = FieldExplorationConst.ACT_DIE,
    [FieldExplorationConst.HERO_ACTION_STATE.GRAB] = FieldExplorationConst.ACT_RSTAND,
    [FieldExplorationConst.HERO_ACTION_STATE.LIFT] = FieldExplorationConst.ACT_BOXSTAND,
    -- [FieldExplorationConst.HERO_ACTION_STATE.FLASH] = FieldExplorationConst.ACT_RDOWN,
}

--战员动画列表
FieldExplorationConst.HERO_ACT_LIST =
{
    FieldExplorationConst.ACT_STAND,
    FieldExplorationConst.ACT_BLINK,
    FieldExplorationConst.ACT_DIE,
    FieldExplorationConst.ACT_HIT,
    FieldExplorationConst.ACT_MOVE,
    FieldExplorationConst.ACT_RUN,
    FieldExplorationConst.ACT_PUSH,
    FieldExplorationConst.ACT_PULL,
    FieldExplorationConst.ACT_RSTAND,
    -- FieldExplorationConst.ACT_RDOWN,
}

--事件动画列表
FieldExplorationConst.EVENT_ACT_LIST =
{
    FieldExplorationConst.ACT_STAND,
    FieldExplorationConst.ACT_GOIN,
    FieldExplorationConst.ACT_ATK01,
    FieldExplorationConst.ACT_DIE,
}

--事件的触发类型
FieldExplorationConst.EVENT_TRIGGER_TYPE =
{
    DISABLE = -1, --不可触发
    HAND = 0, --手动碰撞触发
    AUTO = 1, ---计时器自动触发
    PASSIVE = 2, --被动触发
}

FieldExplorationConst.EVENT_REPEAT_TYPE =
{
    NOT_REPEAT_1 = 0, --不可重复触发，销毁模型
    REPEAT = 1, --可以重复触发
    NOT_REPEAT_2 = 2, --不可重复触发不销毁模型
}

--buff类型
FieldExplorationConst.Buff_Type =
{
    add_Speed = 100, --加减速
    time_Speed = 101, --持续加减速
    add_Life = 102, --加减血量
    vertigo = 103, --眩晕
    add_score = 104, --加减积分
    disorder = 105, --混乱
    add_energy = 106, --加减能量
    add_moneyGold = 107, --添加金币
    add_moneySilver = 108, --添加银币
    invincible = 1001, --无敌
    repel = 1002, --击退
    hit = 1003, --受击
}

--副本结算类型
FieldExplorationConst.Settlement_Type =
{
    Time_Over = 1, --时间结束
    Push_Box = 2, --推箱子-所有通路为空
    EventDie = 3, --场景里面某个事件为空
}

FieldExplorationConst.GetSkill = function (skill_id, trans)
    local skillConfig = fieldExploration.FieldExplorationManager:getEventSkillConfig(skill_id)
    if not skillConfig then
        logError("这个技能找不到配置哦~  麻烦曹爷曹老板修改下 id = " .. skill_id)
    end

    local skill = nil
    if skillConfig.type == FieldExplorationConst.EVENTSKILLTYPE_BOOMB then--炸弹
        skill = fieldExploration.FieldExplorationEventBoombSkill.new()
    elseif skillConfig.type == FieldExplorationConst.EVENTSKILLTYPE_SWAMP then--沼泽
        skill = fieldExploration.FieldExplorationEventSwampSkill.new()
    elseif skillConfig.type == FieldExplorationConst.EVENTSKILLTYPE_TORNADO then--龙卷风
        skill = fieldExploration.FieldExplorationEventTornadoSkill.new()
    elseif skillConfig.type == FieldExplorationConst.EVENTSKILLTYPE_PUSHBOX then--推箱子
        skill = fieldExploration.FieldExplorationEventPushBoxSkill.new()
    elseif skillConfig.type == FieldExplorationConst.EVENTSKILLTYPE_PASSAGE then--通路
        skill = fieldExploration.FieldExplorationEventPassageSkill.new()
    elseif skillConfig.type == FieldExplorationConst.EVENTSKILLTYPE_TOGGLE then--状态开关
        skill = fieldExploration.FieldExplorationEventToggleSkill.new()
    elseif skillConfig.type == FieldExplorationConst.EVENTSKILLTYPE_PTOGGLE then--压力开关
        skill = fieldExploration.FieldExplorationEventPToggleSkill.new()
    elseif skillConfig.type == FieldExplorationConst.EVENTSKILLTYPE_LIFT then--电梯
        skill = fieldExploration.FieldExplorationEventLiftSkill.new()
    elseif skillConfig.type == FieldExplorationConst.EVENTSKILLTYPE_PORTAL then--传送门
        skill = fieldExploration.FieldExplorationEventPortalSkill.new()
    elseif skillConfig.type == FieldExplorationConst.EVENTSKILLTYPE_SHOWANHIDE then--取反显隐
        skill = fieldExploration.FieldExplorationEventShowHideSkill.new()
    elseif skillConfig.type == FieldExplorationConst.EVENTSKILLTYPE_SHOWORHIDE then--单向显隐
        skill = fieldExploration.FieldExplorationEventShowOrHideSkill.new()
    elseif skillConfig.type == FieldExplorationConst.EVENTSKILLTYPE_LASERSHOOT then--激光发射
        skill = fieldExploration.FieldExplorationEventLasetShootSkill.new()
    elseif skillConfig.type == FieldExplorationConst.EVENTSKILLTYPE_ROTATE then-- - 旋转
        skill = fieldExploration.FieldExplorationEventRotateSkill.new()
    elseif skillConfig.type == FieldExplorationConst.EVENTSKILLTYPE_MOVE then-- 移动
        skill = fieldExploration.FieldExplorationEventMoveSkill.new()
    elseif skillConfig.type == FieldExplorationConst.EVENTSKILLTYPE_STEPGRID then-- 踩踏地板
        skill = fieldExploration.FieldExplorationEventStepGridSkill.new()
    else
        skill = fieldExploration.FieldExplorationEventMoneySkill.new()
    end

    if skill then
        skill:setData(skillConfig, trans)
    else
        logError("找不到这个技能  skill_id = " .. skill_id)
    end

    return skill
end

---------------------------------事件类型---------------
FieldExplorationConst.EventThing_Boom = 5 --炸弹
FieldExplorationConst.EventThing_Passage = 13 --通路
FieldExplorationConst.EventThing_PToggle = 101 --压力开关
FieldExplorationConst.EventThing_Lift = 103 --电梯
FieldExplorationConst.EventThing_Silver = 14 --银币
FieldExplorationConst.EventThing_Gold = 6 --金币
FieldExplorationConst.EventThing_Portal = 104 --传送门
-- FieldExplorationConst.EventThing_LaserShoot = 107 --激光发射器
-- FieldExplorationConst.EventThing_LaserReflex = 108 --激光反射
-- 109踩踏地板

---------------------------------战员技能
FieldExplorationConst.HERO_SKILL_DODGE = 1 --闪避
FieldExplorationConst.HERO_SKILL_INVINCIBLE = 2 --无敌金身
FieldExplorationConst.HERO_SKILL_FLASH = 3 --闪现
FieldExplorationConst.HERO_SKILL_GRAB = 4 --抓取
FieldExplorationConst.HERO_SKILL_LIFT = 5 --举起

-------------------------------事件技能类型
--沼泽
FieldExplorationConst.EVENTSKILLTYPE_SWAMP = 2
--龙卷风
FieldExplorationConst.EVENTSKILLTYPE_TORNADO = 3
--炸弹
FieldExplorationConst.EVENTSKILLTYPE_BOOMB = 101
--金币/银币
FieldExplorationConst.EVENTSKILLTYPE_MONEY = 102
--加减速水果
FieldExplorationConst.EVENTSKILLTYPE_SPEED_FRUIT = 103
--加血水果
FieldExplorationConst.EVENTSKILLTYPE_HP_FRUIT = 104
--混乱水果
FieldExplorationConst.EVENTSKILLTYPE_CF_FRUIT = 105
--推箱子技能
FieldExplorationConst.EVENTSKILLTYPE_PUSHBOX = 1001
--通络
FieldExplorationConst.EVENTSKILLTYPE_PASSAGE = 1002
--压力开关
FieldExplorationConst.EVENTSKILLTYPE_PTOGGLE = 201
--状态开关
FieldExplorationConst.EVENTSKILLTYPE_TOGGLE = 202
--电梯
FieldExplorationConst.EVENTSKILLTYPE_LIFT = 203
--传送门
FieldExplorationConst.EVENTSKILLTYPE_PORTAL = 204
--取反显隐
FieldExplorationConst.EVENTSKILLTYPE_SHOWANHIDE = 206
--单向显隐
FieldExplorationConst.EVENTSKILLTYPE_SHOWORHIDE = 207
--初始显隐
FieldExplorationConst.EVENTSKILLTYPE_INITSHOW = 208

--激光发射
FieldExplorationConst.EVENTSKILLTYPE_LASERSHOOT = 209 --目标事件，执行技能的事件id,执行事件身上的技能id（为空则全部执行）
--激光反射
FieldExplorationConst.EVENTSKILLTYPE_LASERREFLEX = 210 --无参数，做标识用
--旋转(技能的碰撞需要开起来，与事件碰撞分开，避免冲突)
FieldExplorationConst.EVENTSKILLTYPE_ROTATE = 211 -- {旋转角度,语言包id},{旋转角度,语言包id}
--移动(技能的碰撞需要开起来，与事件碰撞分开，避免冲突)
FieldExplorationConst.EVENTSKILLTYPE_MOVE = 212 --{{移动的X,移动的Y},语言包id},{{移动的X,移动的Y},语言包id}

--踩踏地板 (事件必须为可穿透)
FieldExplorationConst.EVENTSKILLTYPE_STEPGRID = 213 --{事件id，事件id}，{需要执行技能的事件id，需要执行事件身上的技能id（为空则全部执行）}

--荒野探索的特效路劲
FieldExplorationConst.getFieldExplorationFxPath = function(pathName)
    if string.NullOrEmpty(pathName) then return end
    
    return "arts/fx/3d/sceneModule/gold/" .. pathName
end

FieldExplorationConst.getFieldExplorationSoundPath = function(pathName)
    return "arts/audio/UI/fieldExploration/" .. pathName
end

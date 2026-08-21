-- @FileName:   DanKeConst.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-11-28 15:28:41
-- @Copyright:   (LY) 2023 雷焰网络

DanKeConst = {}

DanKeConst.LayerName =
{
    Scene_layer = "scene_layer",
    Props_layer = "props_layer",
    Monster_layer = "monster_layer",
    Boss_layer = "boss_layer",
    Player_layer = "player_layer",
    Player_bullet = "player_bullet",
    Enemy_bullet = "enemy_bullet",
}

DanKeConst.SpriteSortingLayerIndex =
{
    [DanKeConst.LayerName.Scene_layer] = 0,
    [DanKeConst.LayerName.Props_layer] = 1000,
    [DanKeConst.LayerName.Monster_layer] = 2000,
    [DanKeConst.LayerName.Boss_layer] = 3000,
    [DanKeConst.LayerName.Player_layer] = 4000,
    [DanKeConst.LayerName.Player_bullet] = 5000,
    [DanKeConst.LayerName.Enemy_bullet] = 6000,
}

DanKeConst.MonsterType =
{
    Normal = 1,
    Elite = 2,
}

DanKeConst.PlayerSkill_Type =
{
    Initiative = 1, --主动
    Passive = 2, --被动
}

DanKeConst.PlayerSkill_SubType =
{
    --主动
    FireBomb = 101, --燃烧弹
    Shield = 102, --盾牌
    Magnetic = 103, --AT磁场（范围伤害）
    FlyKnife = 108, --飞刀
    Whip = 109, --皮鞭
    Bumerang = 110, --回旋镖
    Parabolic = 113, --抛物子弹
    FallMine = 114, --落雷
    Potshoot = 212, --发散子弹
    --被动
    Energy = 303, --能源装置（每%s秒恢复%s血量）
    AddBulletSpeed = 304, --推进器(增加子弹飞行速度)
    AddAttackDamage = 305, --增加攻击伤害
    AddExp = 306, --增加经验获取
    Hit_reduce = 307, --受到伤害降低
    AddAttackRange = 308, --添加伤害范围
    AddMoveSpeed = 309, --添加移动速度
    AddMaxHp = 310, --增加血量上限
}

DanKeConst.MonsterSkillType =
{
    Dash1 = 1, --冲刺（冲至玩家边上）
    Shoot_2 = 2, --朝玩家发射子弹
    Shoot_3 = 3, --向四周同时发射子弹
    Shoot_4 = 4, --向四周依次发射子弹
    Dash2 = 5, --冲刺（固定距离冲撞）
}

DanKeConst.ColliderTag =
{
    Normal_Monster = "NORMAL_MONSTER",
    Elite_Monster = "ELITE_MONSTER",
    Player_Bullet = "PLAYER_BULLET",
    Enemy_Bullet = "ENEMY_BULLET",
    Player = "PLAYER",
    Drop = "DROP",
}

DanKeConst.Drop_type =
{
    Add_Hp = 1, --加血
    Kill_Normal = 2, --击杀全部小怪
    Get_AllDrop = 3, --获取范围内的道具
    Treasure_Box = 4, --宝箱再走一次技能选择
    Exp = 5, --大经验
}

DanKeConst.PlayerMaxSkillCount = 6

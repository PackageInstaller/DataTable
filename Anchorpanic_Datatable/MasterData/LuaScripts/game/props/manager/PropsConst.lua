-- 品质类型
ColorType = {
    -- 绿
    GREEN = 1,
    -- 蓝
    BLUE = 2,
    -- 紫
    VIOLET = 3,
    -- 橙
    ORANGE = 4,
    -- 红
    RED = 5
}

--改造品质
RemakeType = {
    None = -1, --未改造
    -- 绿
    GREEN = 1,
    -- 蓝
    BLUE = 2,
    -- 紫
    VIOLET = 3,
    -- 橙
    ORANGE = 4,
}

--星级
StarType = {
    ONE = 1,
    TWO = 2,
    THREE = 3,
    FOUR = 4,
    FIVE = 5,
    SIX = 6,
}

-- 道具类型
PropsType = {
    -- 货币类型（仅供显示）
    Money = 0,
    -- 普通道具类型
    NORMAL = 1,
    -- 装备类型
    EQUIP = 2,
    -- 战员类型（仅供显示）
    HERO = 3,
    -- 外观类型
    DECORATE = 4,
    -- 特殊类型
    SPECIAL = 5,
    -- 序列物
    ORDER = 6,
    -- 家具
    FURNITURE = 7,
    -- 战员碎片
    HERO_FRAGMENT = 8,
    --原料道具
    RAWMAT = 9,
    --时装
    FASHIONPERMIT = 10,

    --开心农场
    HAPPYFARM = 11,

    --战员蛋
    HEROEGG = 12,
}

-- 装备道具子类型
PropsEquipSubType = {
    -- 部位1
    SLOT_1 = 1,
    -- 部位2
    SLOT_2 = 2,
    -- 部位3
    SLOT_3 = 3,
    -- 部位4
    SLOT_4 = 4,
    -- 部位5
    SLOT_5 = 5,
    -- 部位6
    SLOT_6 = 6,
    -- 部位7
    SLOT_7 = 7,
}

-- 装备部位罗马数字
PropsEquipSubTypeStr = {"Ⅰ", "Ⅱ", "Ⅲ", "Ⅳ", "Ⅴ", "Ⅵ"}

-- 序列物道具子类型
PropsOrderSubType = {
    -- 攻击序列物
    ATTACK = 2,
    -- 防御序列物
    DEFENCE = 3,
    -- 效果序列物
    EFFECT = 4,
}

-- 英雄碎片道具子类型
HeroFragmentSubType = {
    -- 通用兑换材料
    NORMAL = 0,
}

-- 道具使用效果类型
UseEffectType = {
    -- 货币道具卡：元宝卡\银币卡\粮草卡\修炼卡等
    ADD_MONEY = 1,
    -- 礼包
    ADD_GIFT = 2,
    -- 增加装备经验
    ADD_EQUIP_EXP = 3,
    -- 战员激活，获得英雄
    ADD_HERO = 4,
    -- 增加玩家体力，也即是抗疫血清
    ADD_STAMINA = 5,
    -- 转换成战员等级提升所需要的经验值
    CONVERT_HERO_EXP = 6,
     --站员自选礼包
    ADD_FREE_HEROGIFT = 9,
    -- 增加手环经验
    ADD_BRACELET_EXP = 10,
    -- 增加盟约助手等级经验
    ADD_COVENANT_HELPER_EXP = 11,
    -- 礼物 增加战员好感度
    ADD_HERO_FAVORABLE = 12,
    -- 战员服饰时装激活
    ADD_HERO_FASHION_CLOTHES = 13,
    -- 战员武器时装激活
    ADD_HERO_FASHION_WEAPON = 14,
    -- 芯片礼包
    ADD_CHIP_GIFT = 18,
    --普通道具自选礼包
    ADD_FREE_PROPGIFT = 20,
    --晶耀供给凭证（月卡道具）
    ADD_MONTHLY_CARD = 21,
    --域行合约凭证（高级通行证解锁道具）
    ADD_PERMIT_EXPERT = 22,
    -- 合约扩充凭证（通行证直升十级道具）
    ADD_PERMIT = 23,
    -- 时装打折卡
    ADD_DISCOUNT_ITEM = 27,
    --获取战员蛋
    USE_GET_HEROEGG = 28,
}

-- 常用道具tid
PROPS_TID = {
    -- 金币
    GOLD_COIN = 1,
    -- 钛金石
    ITIANIUM = 3,
    -- 竞技币
    ARENA_COIN = 4,
    -- 装饰币
    DECORATE_COIN = 5,
    -- 战员亲密度
    INTIMACY = 9,
    -- 抗疫血清
    ANTIEPIDEMIC_SERUM = 10,
    -- 战员经验
    HERO_GLOBAL_EXP = 11,
    -- 指挥官经验
    PLAYER_EXP = 12,
    -- 皮肤打折卡 75折
    FASHION_DISCOUNT_CARE = 900,
}
--隐藏持有数量的道具（用于tips）
PROPS_HIDE_TID_LIST = {
    --活跃度（事务所）
    ActivityDegree = 25,
    --合约积分（事务所）
    ContractCredit = 26
}

--[[ 替换语言包自动生成，请勿修改！
]]

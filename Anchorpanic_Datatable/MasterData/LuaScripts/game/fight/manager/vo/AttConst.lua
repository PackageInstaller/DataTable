--[[    
    英雄属性常量表
    和服务器一一对应
    备注：
    1~100：整数型类型属性
    101~500：万分比类型属性
]]
local CLIENT_CUSTOM_IDX = 888888
local function _CIDX( )
    CLIENT_CUSTOM_IDX = CLIENT_CUSTOM_IDX+1
    return CLIENT_CUSTOM_IDX
end
AttConst = {}

----------------------------------基础属性
-- 当前生命（整数值）
AttConst.HP = 201
-- 当前怒气值(大招的能量（整数型）
AttConst.MP = 202

-- 生命上限（整数值）
AttConst.HP_MAX = 11
-- 攻击力（整数型）
AttConst.ATTACK = 12
-- 物理防御力（整数型）
AttConst.DEFENSE = 13
-- 速度（整数型）
AttConst.SPEED = 14

--自定属性 BEGIN
-- 怒气上限（整数值）
AttConst.MP_MAX = _CIDX() 
-- 当前电量
AttConst.SKILL_SOUL = _CIDX()
-- 是否远程攻击类型
AttConst.IS_FAR_TYPE = _CIDX()
-- 当前护盾值
AttConst.SHIELD = _CIDX()
-- 最大护盾值
AttConst.SHIELD_MAX = _CIDX()

-- 当前硬直
AttConst.STUN = _CIDX()
-- 硬直恢复量
AttConst.STUN_RESUME = _CIDX()
-- 最大硬直值
AttConst.STUN_MAX = _CIDX()
-- boss特殊状态积累值（波纹，狂暴...）
AttConst.BERSERK_NUM = _CIDX()

--自定属性 END

-- -- 攻速（万分比）
-- AttConst.ATT_SPEED = 106
-- -- 移速（万分比）
-- AttConst.MOVE_SPEED = 107
--------------------------------------高阶属性
-- 暴击率（万分比）
AttConst.CRIT = 101
-- 暴击抵抗（万分比）（降低被暴击几率）
AttConst.CRIT_DEFENSE = 102
-- 暴击伤害系数（万分比）
AttConst.CRIT_DAMAGE = 103
-- 暴击抗性（万分比）（降低被暴击伤害）
AttConst.CRIT_DAMAGE_REDUCE = 104

-- 闪避（万分比）
AttConst.EVADE = 105
-- 命中（万分比）
AttConst.HIT = 106
-- 格挡几率（万分比）
AttConst.BLOCK = 107
-- 破击几率（万分比）
AttConst.BREAK = 108

-- 伤害加成（万分比）
AttConst.DAMAGE_INC = 109
-- 伤害减免（万分比）
AttConst.DAMAGE_DEC = 110
-- 技能伤害加成（万分比）
AttConst.SKILL_DAMAGE_INC = 111
-- 元素伤害加成（万分比）
AttConst.ELEMENT_DAMAGE_INC = 112
-- 元素伤害减免（万分比）
AttConst.ELEMENT_DAMAGE_DEC = 113

-- 无视防御（万分比）
AttConst.IGNORE_DEF = 114

-- 效果命中（万分比）
AttConst.EFT_HIT = 115
-- 效果抵抗（万分比）
AttConst.EFT_DEF = 116
-- 生命加成（万分比）
AttConst.HP_INC = 151
-- 攻击加成（万分比）
AttConst.ATTACK_INC = 152
-- 防御加成（万分比）
AttConst.DEFENSE_INC = 153
-- 速度加成（万分比）
AttConst.SPEED_INC = 154

-- 基础生命加成（万分比）
AttConst.BASE_HP_INC = 161
-- 基础攻击加成（万分比）
AttConst.BASE_ATTACK_INC = 162
-- 基础防御加成（万分比）
AttConst.BASE_DEFENSE_INC = 163

-- 芯片生命加成（万分比）
AttConst.CHIP_HP_INC = 166
-- 芯片攻击加成（万分比）
AttConst.CHIP_ATTACK_INC = 167
-- 芯片防御加成（万分比）
AttConst.CHIP_DEFENSE_INC = 168

-- 动能核心生命加成（万分比）
AttConst.ENERGY_HP_INC = 171
-- 动能核心攻击加成（万分比）
AttConst.ENERGY_ATTACK_INC = 172
-- 动能核心防御加成（万分比）
AttConst.ENERGY_DEFENSE_INC = 173

---服用端开发使用的属性定义--------------------------------------------------------
-- ------------------------------------成长资质
-- 物理攻击成长资质（万分比）
AttConst.PHY_ATK_QUALITY = 511
-- 魔法攻击成长资质（万分比）
AttConst.MAG_ATK_QUALITY = 512
-- 物理防御成长资质（万分比）
AttConst.PHY_DEF_QUALITY = 513
-- 魔法抗性成长资质（万分比）
AttConst.MAG_DEF_QUALITY = 514
-- 生命成长资质（万分比）
AttConst.HP_MAX_QUALITY = 515

----------------------------------- 其它玩家属性
-- 玩家等级
AttConst.LV = 600
-- 玩家vip等级
AttConst.VIP_LV = 601
-- 玩家元宝
AttConst.GOLD = 602
-- 玩家银币
AttConst.SILVER_COIN = 603
-- 玩家名字
AttConst.PLAYER_NAME = 604

-- --------------------------------------稀有属性
-- -- 物理增伤（万分比）
-- AttConst.PHY_DAMAGE_INC = 133
-- -- 魔法增伤（万分比）
-- AttConst.MAG_DAMAGE_INC = 134
-- -- 物理减伤（万分比）
-- AttConst.PHY_DAMAGE_DEC = 135
-- -- 魔法减伤（万分比）
-- AttConst.MAG_DAMAGE_DEC = 136

-- ---------------------------------------状态类型
AttConst.STATE_BATTLE_EXILE = _CIDX() --被放走

-- ---------------------------------------未对接
-- -- 移速加成
-- AttConst.MOVE_SPEED_INC = 111
-- -- 移速降低
-- AttConst.MOVE_SPEED_DEC = 112

-- -- 攻速加成
-- AttConst.ATT_SPEED_INC = 114
-- -- 攻速降低
-- AttConst.ATT_SPEED_DEC = 115

-- -- 盾量
-- AttConst.SHIELD = 203

-- -- 攻击动能
-- AttConst.ATK_POW = 209


-- -- 无敌
-- AttConst.IMMUNE_ALL = 401
-- -- 物免
-- AttConst.IMMUNE_PHY = 402
-- -- 魔免
-- AttConst.IMMUNE_MAG = 403
-- -- 免疫控制效果
-- AttConst.IMMUNE_CTRL = 404

-- -- 状态属性
-- -- 睡眠
-- AttConst.STATUS_SLEEP = 501
-- -- 昏迷
-- AttConst.STATUS_COMA = 502
-- -- 眩晕
-- AttConst.STATUS_VERTIGO = 503
-- -- 不受攻击
-- AttConst.STATUS_VERTIGO = 504

-- -- 被打断
-- AttConst.STATUS_BE_BREAK = 505

-- 根据类型获取总属性名
AttConst.getName = function(cusKey)
    return fight.AttrManager:getAttName(cusKey)
end

-- 根据类型获取总属性en名
AttConst.getNameEn = function(cusKey)
    return fight.AttrManager:getAttNameEn(cusKey)
end

-- cusNum保留n位小数，不四舍五入
AttConst.getPreciseDecimal = function(cusNum, n)
    if type(cusNum) ~= "number" then
        return cusNum
    end
    n = n or 0
    n = math.floor(n)
    if n < 0 then
        n = 0
    end

    -- 临时处理精度问题（0.10086取精度会有问题）
    local nDecimal = 10 ^ n
    local value, matchCount = string.gsub(tostring(cusNum * nDecimal), "%.0", "")
    local nTemp = math.floor(tonumber(value))
    local nRet = nTemp / nDecimal
    return nRet

    -- 正常的精度计算（未测，阳阳说暂时还没遇到异常问题，先不处理）
    -- local rate = 1 / math.pow(10, n)
    -- return cusNum - cusNum % rate
end

-- 根据属性key和属性值获取属性值字符串
AttConst.getValueStr = function(cusKey, cusValue)
    if(AttConst.isAttrPercent(cusKey))then
        return AttConst.getPreciseDecimal(cusValue / 100, 2) .. "%"
    else
        return tostring(cusValue)
    end
end

-- 判断属性是否万分比
AttConst.isAttrPercent = function(cusKey)
    return fight.AttrManager:isPercentAttr(cusKey)
end

AttConst.sort = function(vo1, vo2) 
    if (vo1 and vo2) then
        -- 品质从小到大
        if (fight.AttrManager:getSort(vo1.key) < fight.AttrManager:getSort(vo2.key)) then
            return true
        end
        if (fight.AttrManager:getSort(vo1.key) > fight.AttrManager:getSort(vo2.key)) then
            return false
        end
    end
    return false
end

-- 获取属性类型
AttConst.getAttrType = function(cusKey)
    return fight.AttrManager:getType(cusKey)
end

-- 根据属性key获取属性类型名
AttConst.getTypeNameByKey = function(cusKey)
    local type = AttConst.getAttrType(cusKey)
    return AttConst.getTypeNameByType(type)
end

-- 根据属性类型获取属性类型名
AttConst.getTypeNameByType = function(cusType)
    local type = cusType
    local typeName = "xx"
    if(type == AttConst.AttrType.Baseic)then
        typeName = _TT(3029)
    elseif(type == AttConst.AttrType.Special)then
        typeName = _TT(3030)
    end
    return typeName
end

-- 根据属性类型获取属性类型英文名
AttConst.getTypeEngNameByType = function(cusType)
    local type = cusType
    local typeName = "xx"
    if(type == AttConst.AttrType.Baseic)then
        typeName = "BASIC ATTRIBUTSE"
    elseif(type == AttConst.AttrType.Special)then
        typeName = "SPECIAL ATTRIBUTSE"
    end
    return typeName
end

AttConst.AttrType = {
    -- 基础属性
    Baseic = 1,
    -- 特殊属性
    Special = 2,
    -- 元素属性
    Element = 3,
}

AttConst.AttrMainSecondaryType = {
    -- 都不是
    None = 0,
    -- 主属性
    Main = 1,
    -- 副属性
    Secondary = 2,
    -- 主+副属性
    MainSecondary = 3,
}
-------------------------------------------------------- 正式和后端对应的 --------------------------------------------------------
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(3030):	"特殊属性"
	语言包: _TT(3029):	"基础属性"
]]

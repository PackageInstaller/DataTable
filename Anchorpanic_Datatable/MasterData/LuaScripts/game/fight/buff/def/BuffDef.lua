local BuffDef = {}

--脚下挂点(即人的站立点)
BuffDef.POINT_FOOT = 1
--身体挂点
BuffDef.POINT_BODY = 2
--头部挂点
BuffDef.POINT_HEAD = 3

--影响行为
BuffDef.EVENT_BEHAVIOR = 1
--影响动作的
BuffDef.EVENT_ACTION = 2
--属性数据改变的偏差值
BuffDef.EVENT_ATTR_DATA = 3
--属性数据改变的最终值
BuffDef.EVENT_ATTR_ASSIGN = 4

-- buff效果类型(前端有使用的)
-- 眩晕
BuffDef.BUFF_TYPE_DIZZY = 4
-- 麻痹(目标无法使用技能和奥义)
BuffDef.BUFF_TYPE_PALSY = 23
-- 封技(无法使用普通技能)
BuffDef.BUFF_TYPE_FENGJI = 26
-- 封印(无法使用奥义)
BuffDef.BUFF_TYPE_FENGYIN = 27
-- 混乱(普攻自己队友)
BuffDef.BUFF_TYPE_CONFUSED = 40
-- 凝重(魂玉消耗增加)
BuffDef.BUFF_TYPE_SKILL_SOUL_COST_ADD = 41
-- 元素标记
BuffDef.BUFF_TYPE_ELE_MARK = 63
-- 新冰冻(控制类,每次受到攻击时有20%几率解除控制)
BuffDef.BUFF_TYPE_FROZE_INJURY_RAND_REMOVE = 72
-- 魂玉消耗减少
BuffDef.BUFF_TYPE_SKILL_SOUL_COST_CUT = 133
-- 魂玉消耗减少 不影响怒气计算
BuffDef.BUFF_TYPE_SKILL_SOUL_COST_CUT_2 = 134
-- 雷遁隐身
BuffDef.BUFF_TYPE_DEAL_HIT_MODEL = 256

-- 控制类型buff列表
BuffDef.BUFF_CONTROL_LIST = {
    BuffDef.BUFF_TYPE_DIZZY, BuffDef.BUFF_TYPE_PALSY, BuffDef.BUFF_TYPE_FENGJI,
    BuffDef.BUFF_TYPE_FENGYIN, BuffDef.BUFF_TYPE_CONFUSED, BuffDef.BUFF_TYPE_FROZE_INJURY_RAND_REMOVE, BuffDef.BUFF_TYPE_DEAL_HIT_MODEL
}

-- 是否为控制类型buff
BuffDef.checkIsControlBuff = function(buffFid)
    if table.indexof(BuffDef.BUFF_CONTROL_LIST, buffFid) ~= false then
        return true
    end
    return false
end

-- 模型表现效果（前端使用）
-- 冰冻效果
BuffDef.BUFF_MODEL_STATE_FROZE = 1
-- 金属封印
BuffDef.BUFF_MODEL_STATE_METAL = 2
-- 替换武器
BuffDef.BUFF_MODEL_STATE_CHANGE_WEAPON = 3
-- 弱点效果
BuffDef.BUFF_MODEL_STATE_WEEK = 4
-- 雷遁效果
BuffDef.BUFF_MODEL_STATE_HIT = 5



return BuffDef

--[[ 替换语言包自动生成，请勿修改！
]]
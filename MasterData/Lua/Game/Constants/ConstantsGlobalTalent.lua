---@class ConstantsGlobalTalent
local Constants = {}

---@alias Constants.GlobalTalentEffectId integer @ 全局天赋效果
Constants.GlobalTalentEffectId = {
    ---	param1对param2造成伤害提升_num_
    Id_1     = 1,     
    ---	param1受到param2伤害降低_num_
    Id_2     = 2,     
    ---	初始品质为param1的战斗员提供的助战位加成提升_num_
    Id_3     = 3,     
    ---	所有战斗员攻击力提升_num_
    Id_10101 = 10101, 
    ---	所有战斗员防御力提升_num_
    Id_10201 = 10201, 
    ---	所有战斗员生命值提升_num_
    Id_10301 = 10301, 
    ---	所有战斗员暴击伤害提升_num_
    Id_10703 = 10703, 
    ---	在param1玩法中造成伤害提升_num_
    Id_8     = 8,     
    ---	在param1玩法中受到伤害降低_num_
    Id_9     = 9,     
    ---	猫猫巴士骰子重置次数增加_num_
    Id_10    = 10,    
    ---	玩法param1门票上限数量提高_num_
    Id_11    = 11,    
    ---	外卖奖励产出提高_num_
    Id_12    = 12,    
    ---	外卖员消耗心情值减少_num_
    Id_13    = 13,    
    ---	副本消耗体力减少_num_
    Id_14    = 14,    
    ---	钓鱼中大鱼基础概率增加_num_
    Id_15    = 15,    
    ---	钓鱼中伤害提高_num_
    Id_16    = 16,    
    ---	中枢补给产出增加_num_
    Id_17    = 17,    
    ---	主线故事挑战模式每天可扫荡次数增加_num_
    Id_18    = 18,    
    ---	猫球寻宝产出增加_num_
    Id_19    = 19,    
    ---	离岛空运产出增加_num_
    Id_20    = 20,    
}


---@alias Constants.GlobalTalentConfEffectId integer @ 战略强化属性枚举表 对应的id
Constants.GlobalTalentConfEffectId = {
    Id_1	= 1, --- param1对param2造成伤害提升_num_
    Id_2	= 2, --- param1受到param2伤害降低_num_
    Id_3	= 3, --- 初始品质为param1的战斗员提供的助战位加成提升_num_
    Id_4	= 4, --- 所有战斗员攻击力提升_num_
    Id_5	= 5, --- 所有战斗员防御力提升_num_
    Id_6	= 6, --- 所有战斗员生命值提升_num_
    Id_7	= 7, --- 所有战斗员暴击伤害提升_num_
    Id_8	= 8, --- 在param1玩法中造成伤害提升_num_
    Id_9	= 9, --- 在param1玩法中受到伤害降低_num_
    Id_10	= 10, --- 猫猫巴士骰子重置次数增加_num_
    Id_11	= 11, --- 玩法param1门票上限数量提高_num_
    Id_12	= 12, --- 外卖奖励产出提高_num_
    Id_13	= 13, --- 外卖员消耗心情值减少_num_
    Id_14	= 14, --- 经验副本消耗体力减少_num_
    Id_15	= 15, --- 钓鱼中大鱼基础概率增加_num_
    Id_16	= 16, --- 钓鱼中伤害提高_num_
    Id_17	= 17, --- 粒子副本体力消耗减少_num_
    Id_18	= 18, --- 绿色晶片副本体力消耗减少_num_
    Id_19	= 19, --- 红色晶片副本体力消耗减少_num_
    Id_20	= 20, --- 蓝色晶片副本体力消耗减少_num_
    Id_21	= 21, --- 中枢补给产出增加_num_
    Id_22	= 22, --- _regionId_装备副本体力消耗降低_num_
    Id_23	= 23, --- 主线故事挑战模式每天可扫荡次数增加_num_
    Id_24	= 24, --- 猫球寻宝产出增加_num_
    Id_25	= 25, --- 离岛空运产出增加_num_
}

---@alias Constants.GlobalTalentSource integer @ 全局天赋来源
Constants.GlobalTalentSource = {
    Talent        = 1,  --- 天赋（战略强化）
    CheckIn       = 2,  --- 信息录入
    PrivilegeCard = 3,  --- 特权卡
    DailyInvest = 4,    --- 每日投资
}

---@alias Constants.GlobalTalentAddType integer @ 全局天赋加成类型
Constants.GlobalTalentAddType = {
    Base         = 1, --- 基础数值
    BaseAdd      = 2, --- 基础数值加成
    Percent      = 3, --- 百分比
    FinalAdd     = 4, --- 最终加成
    FinalPercent = 5, --- 最终加成百分比
}



return Constants
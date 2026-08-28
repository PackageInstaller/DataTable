--
-- Author:luqucheng
-- Date: 2019-10-23 17:02:06
--
local Skill = {}
Skill = Class("Skill")
local ParseUtils = CS.ParseUtils

--@RefType [Game.Battle.Entity.Role#Role]
Skill.owner = nil
Skill.nowCD = 0

function  Skill:__init(owner, skillId, star, lv)
    self.owner = owner

    self.skillId = nil
    self.lv = nil
    self.star = nil
    self.comboType = nil--连携位置（目前是4个位置，分别是A B C D，对应填写1 2 3 4与系统描述一致，当该招数为大招时，则填写为0）
    self.skillClass = nil--技能分类(1主动 2被动）
    self.skillType = nil--技能类型（1普攻2高级技能3大招4强化技）
    self.skillCondition = nil
    self.castConditionPara = nil
    self.clickType = nil--技能点选规则（1己方 2敌方 3全体）
    self.damageTarget = nil--伤害效果目标
    self.damageEffect = nil--伤害效果ID
    self.isCounterAttack = nil--是否触发反击（1触发,0不触发）
    self.isContinuousAttack = nil--是否连击（1触发,0不触发）
    -- self.effectCondition1 = nil
    -- self.effectTarget1 = nil
    -- self.effect1 = nil
    -- self.effectCondition2 = nil
    -- self.effectTarget2 = nil
    -- self.effect2 = nil
    -- self.effectCondition3 = nil
    -- self.effectTarget3 = nil
    -- self.effect3 = nil
    self.triggerRule = nil --触发类型（该会触发哪些触发器）	1类型施加时不会触发所有受击相关主条件（20，57，61类型）的触发器	2类型施加时不会触发n n 所有技能相关的主条件（10，11，12，20，54，55，56，57，58，59，60，61）的触发器。
    self.label = nil--标签（1、buff 2、进攻3、debuff 4、恢复）
    -- self.starEffect1 = nil--附加效果对于星级的要求
    -- self.starEffect2 = nil
    -- self.starEffect3 = nil
    self.extraCondition = nil--额外条件类型（此字段直接填写枚举的ID）
    self.castCondition = nil--消耗条件（此字段直接填写枚举的ID）
    self.cd = nil
    self.mp = nil
    self.disAtkNum = nil--解体槽伤害值
    self.powerNum = nil--战斗强化点消耗
    -- self.effectConditionPara1 = nil
    -- self.effectConditionPara2 = nil
    -- self.effectConditionPara3 = nil
    self.extraConditionPara = nil
    self.castConditionPara = nil
    -- self.stackTime1 = nil
    -- self.stackTime2 = nil
    -- self.stackTime3 = nil
    self.nowCD = 0
    self.hitRatio = nil
    self.isAoe = nil
    self.comboTargetSelectScript = nil --多段目标选择脚本
    self.comboTargetSelectParams = nil --多段目标选择参数

    --@RefType Game.Battle.Data.SkillSubEffectData#skillSubEffectData<>
    self.subEffects = nil

    self.ignoreTaunt = nil
    local data = Core:GetSkillData(skillId, star, lv, self)
    -- table.merge(self, data)
    -- printInfo(table.toString(self,"skill"))
end


function Skill:IsUltra(  )
    return self.skillType == Constants.SkillType.Final
end

function Skill:IsPassive(  )
    return self.skillClass == Constants.SkillClass.Passive
end

function Skill:IsInCD(  )
    return self.nowCD > 0
end

function Skill:Discharge(skillRec)
    --计算消耗
    --计算cd
    -- assert(self.nowCD <= 0, '释放技能，但是技能cd还没有好 '..table.toString(skillRec,'data'))
    -- self.nowCD = self.cd
end

--技能释放消耗
function Skill:HandleCost(  )
    if self:IsUltra() then
        --是大招的情况下，需要消耗能量点
        self.owner:SetUltraPoint(0, Constants.AddSPType.Skill)
    end
end

return  Skill
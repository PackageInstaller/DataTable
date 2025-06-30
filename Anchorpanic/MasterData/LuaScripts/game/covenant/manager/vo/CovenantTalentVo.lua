module("covenant.CovenantTalentVo", Class.impl())

function parseData(self,id,cusData)
    self.id = id
    --技能id
    self.skillId = cusData.skill_id
    --解锁盟约需要等阶
    self.needStage = cusData.need_stage
    --解锁前置天赋id 等级
    self.needTalent = cusData.need_talent
    --所在行
    self.line = cusData.line
    --所属列
    self.column = cusData.column
    --技能相关
    --self.skillLevelUp = cusData.skill_levelup
    self.mSkillLevelData = {}
    self:parseSkillData(cusData.skill_levelup)
end


function parseSkillData(self,dic)
    for k, v in pairs(dic) do
        local vo = covenant.CovenantSkillVo.new()
        vo:parseData(v)
        table.insert(self.mSkillLevelData,vo) 
    end
end

function getCostNum(self,level)
    for i =1 ,#self.mSkillLevelData do
        if self.mSkillLevelData[i].level == level then
            return self.mSkillLevelData[i]
        end
    end
end

function getCostGene(self,level)
    for i =1 ,#self.mSkillLevelData do
        if self.mSkillLevelData[i].level == level then
            return self.mSkillLevelData[i]
        end
    end
end

function getSkillMaxLv(self)
    return table.nums(self.mSkillLevelData)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]

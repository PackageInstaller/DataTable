module("fight.SkillVo", Class.impl())

function ctor(self)
    self.tid = 0
    self.lv = 1
    -- 用于创建技能的ID
    self.expressionId = 1
    -- 用于创建触发技能后, 角色的行为类的ID (ID为-1时, 用expressionId)
    self.m_roleExpressionID = -1
    self.dis = 100

    self.type = 1
    self.skillCd = 0
    self.calcType = SkillCalcType.PHYSICS
    self.limitTimes = 1

    self.damage_percent = 1000

    -- 可以被闪避（配置）
    self.canEvade = true
end

-- 用于创建触发技能后, 角色的行为类的ID (ID为-1时, 用expressionId)
function roleExpressionID(self)
    if self.m_roleExpressionID>0 then
        return self.m_roleExpressionID
    end
    return self.expressionId
end

function parseConfigData(self, cusId, cusData)
    self.id = cusId
    self.type = cusData.type
    self.skillCd = cusData.cd
    self.calcType = cusData.calcType
    self.limitTimes = cusData.limitTimes
    self.dis = cusData.dis
    self.m_roleExpressionID = 1
end

function needBreak(self)
    return false
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]

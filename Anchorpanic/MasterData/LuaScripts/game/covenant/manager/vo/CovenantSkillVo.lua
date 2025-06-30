module("covenant.CovenantSkillVo", Class.impl())

function parseData(self,cusData)
    --技能等级
    self.level = cusData.level
    --升级所需要天赋点
    self.point = cusData.point 
    --消耗货币id
    self.payId = cusData.pay_id
    --消耗货币数量
    self.payNum = cusData.pay_num
    --{属性id,类型,值} 类型：0为固定值(直接属性加成）
    --1为万分比（助手属性万分比加成）
    self.skillAttr = cusData.skill_attr
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]

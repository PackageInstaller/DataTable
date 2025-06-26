module("fight.UseSkillVo", Class.impl())

function ctor(self,cusSn,cusSkillVo,cusAttackerVo,cusTargetVo)
    self.sn = cusSn
    self.skillVo = cusSkillVo
    self.attackerVo = cusAttackerVo
    self.targetVo = cusTargetVo
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]

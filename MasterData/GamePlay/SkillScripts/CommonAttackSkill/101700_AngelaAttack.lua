local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_101700 = class("bs_101700", bs_1)
local base = bs_1
bs_101700.config = {
  effectId_trail = 101706,
  audioId1 = 202,
  audioId2 = 203,
  audioId5 = 204
}
bs_101700.config = setmetatable(bs_101700.config, {
  __index = base.config
})

function bs_101700:ctor()
end

function bs_101700:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_101700:RealPlaySkill(target, data)
  if self.caster.recordTable.Open == true and self.caster.recordTable.Skill_target ~= nil then
    local target1 = self.caster.recordTable.Skill_target
    self.caster:LookAtTarget(target1)
    return
  end
  base.RealPlaySkill(self, target, data)
end

function bs_101700:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_101700

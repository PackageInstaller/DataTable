local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_100500 = class("bs_100500", bs_1)
local base = bs_1
bs_100500.config = {
  effectId_1 = 100501,
  effectId_2 = 100502,
  audioId1 = 100501,
  audioId2 = 100502
}
bs_100500.config = setmetatable(bs_100500.config, {
  __index = base.config
})

function bs_100500:ctor()
end

function bs_100500:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_100500:RealPlaySkill(target, data)
  if self.caster.recordTable.skill == true then
    self.caster:LookAtTarget(target)
    return
  end
  base.RealPlaySkill(self, target, data)
end

function bs_100500:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_100500

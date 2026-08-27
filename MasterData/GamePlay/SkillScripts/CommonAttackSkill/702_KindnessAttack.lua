local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_525 = class("bs_525", bs_1)
local base = bs_1
bs_525.config = {
  effectId_1 = 10440,
  effectId_2 = 10441,
  audioId1 = 314,
  audioId2 = 315,
  audioId3 = 360
}
bs_525.config = setmetatable(bs_525.config, {
  __index = base.config
})

function bs_525:ctor()
end

function bs_525:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  LuaSkillCtrl:CallStartLocalScale(self.caster, Vector3.New(1.5, 1.5, 1.5))
end

function bs_525:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_525

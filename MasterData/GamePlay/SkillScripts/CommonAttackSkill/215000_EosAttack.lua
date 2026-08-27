local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_215000 = class("bs_215000", bs_1)
local base = bs_1
bs_215000.config = {
  effectId_1 = 215001,
  effectId_2 = 215001,
  effectId_hit_target = 215002,
  action1 = 1021,
  action2 = 1021
}
bs_215000.config = setmetatable(bs_215000.config, {
  __index = base.config
})

function bs_215000:ctor()
end

function bs_215000:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_215000:OnCasterDie()
  base.OnCasterDie(self)
  CS.BattleManager.Instance.CurEffectController:KillRoleEffect(self.caster)
end

return bs_215000

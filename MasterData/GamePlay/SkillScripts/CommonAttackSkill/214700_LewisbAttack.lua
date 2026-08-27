local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_214700 = class("bs_214700", bs_1)
local base = bs_1
bs_214700.config = {
  effectId_trail = 108614,
  action1 = 1001,
  action2 = 1001
}
bs_214700.config = setmetatable(bs_214700.config, {
  __index = base.config
})

function bs_214700:ctor()
end

function bs_214700:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_214700:OnCasterDie()
  base.OnCasterDie(self)
  CS.BattleManager.Instance.CurEffectController:KillRoleEffect(self.caster)
end

return bs_214700

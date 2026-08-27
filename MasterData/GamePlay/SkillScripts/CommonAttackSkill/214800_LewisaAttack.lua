local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_214800 = class("bs_214800", bs_1)
local base = bs_1
bs_214800.config = {
  effectId_start1 = 108611,
  effectId_start2 = 108611,
  action1 = 1001,
  action2 = 1001
}
bs_214800.config = setmetatable(bs_214800.config, {
  __index = base.config
})

function bs_214800:ctor()
end

function bs_214800:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_214800:OnCasterDie()
  base.OnCasterDie(self)
  CS.BattleManager.Instance.CurEffectController:KillRoleEffect(self.caster)
end

return bs_214800

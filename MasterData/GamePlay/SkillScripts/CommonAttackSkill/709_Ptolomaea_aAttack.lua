local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_709 = class("bs_709", bs_1)
local base = bs_1
bs_709.config = {
  effectId_trail = 210801,
  action1 = 1001,
  action2 = 1001,
  effectId_action_1 = 210802,
  effectId_action_2 = 210802,
  effectId_sign = 210201
}
bs_709.config = setmetatable(bs_709.config, {
  __index = base.config
})

function bs_709:ctor()
end

function bs_709:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_709", 1, self.OnAfterBattleStart)
end

function bs_709:OnAfterBattleStart()
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_sign, self)
end

function bs_709:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_709

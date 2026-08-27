local FireBase = require("GamePlay.SkillScripts.FunctionSkill.24Carnival.FireBase")
local bs_17312 = class("bs_17312", FireBase)
local base = FireBase
bs_17312.config = {}
bs_17312.config = setmetatable(bs_17312.config, {
  __index = base.config
})

function bs_17312:ctor()
end

function bs_17312:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_17312_3", 1, self.OnAfterHurt, self.caster, nil, nil, nil, nil, nil, nil, eSkillTag.commonAttack, false)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_17312_0", 1, self.OnAfterBattleStart)
end

function bs_17312:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and not isMiss and LuaSkillCtrl:CallRange(1, 1000) <= self.arglist[1] and target:GetBuffTier(self.NowFireBuff) > 0 then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, self.config.aoe_config)
    local damage = 0
    damage = self.arglist[2] * target:GetBuffTier(self.NowFireBuff)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, 38, {damage}, true)
    skillResult:EndResult()
  end
end

function bs_17312:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_17312

local FireBase = require("GamePlay.SkillScripts.FunctionSkill.24Carnival.FireBase")
local bs_17314 = class("bs_17314", FireBase)
local base = FireBase
bs_17314.config = {effectId = 12092}
bs_17314.config = setmetatable(bs_17314.config, {
  __index = base.config
})

function bs_17314:ctor()
end

function bs_17314:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetDeadHurtTrigger("bs_17314_2", 949, self.OnSetDeadHurt, self.caster, nil, nil, eBattleRoleBelong.enemy)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_17314_1", 1, self.OnAfterBattleStart)
end

function bs_17314:eventFunc(role)
  if role:GetBuffTier(self.NowFireBuff) > 0 then
    self:ActiveFireBuff(role, self.arglist[1])
  end
end

function bs_17314:OnRoleDie(killer, role)
  self:eventFunc(role)
end

function bs_17314:OnSetDeadHurt(context)
  local role = context.target
  self:eventFunc(role)
end

function bs_17314:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_17314

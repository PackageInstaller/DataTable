local Feature_1026 = class("Feature_1026", LuaSkillBase)
local base = LuaSkillBase
Feature_1026.config = {buffId = 2152}

function Feature_1026:ctor()
end

function Feature_1026:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddOnRoleDieTrigger("Feature_1026", 1, self.OnRoleDie, nil, nil, nil, eBattleRoleBelong.player, nil, nil, nil)
end

function Feature_1026:OnRoleDie(killer, role)
  if not self:IsReadyToTake() then
    return
  end
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, self.arglist[1], true)
  self:OnSkillTake()
end

function Feature_1026:OnCasterDie()
  base.OnCasterDie(self)
end

return Feature_1026

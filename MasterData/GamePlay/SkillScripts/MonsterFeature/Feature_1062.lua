local Feature_1062 = class("Feature_1062", LuaSkillBase)
local base = LuaSkillBase
Feature_1062.config = {buffId = 1509}

function Feature_1062:ctor()
end

function Feature_1062:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddOnRoleDieTrigger("Feature_1062", 1, self.OnRoleDie, nil, nil, nil, eBattleRoleBelong.player, nil, nil, nil)
  local cb = BindCallback(self, self.eventFunc)
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], cb, nil, -1)
end

function Feature_1062:eventFunc()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, false)
end

function Feature_1062:OnRoleDie(killer, role)
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, self.arglist[2], false, false)
end

function Feature_1062:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

return Feature_1062

local base = require("GamePlay.SkillScripts.RoleFSkill.FakeCommonPassive")
local bs_1034012 = class("bs_1034012", base)
bs_1034012.config = {effectId = 10459, buffId_179 = 103401}

function bs_1034012:ctor()
end

function bs_1034012:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.effectHalo = nil
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_1034012_1", 1, self.OnAfterBattleStart)
end

function bs_1034012:OnAfterBattleStart()
  if self.effectHalo == nil then
    self.effectHalo = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self)
  end
  local collisionEnter = BindCallback(self, self.OnCollisionEnter)
  local collisionExit = BindCallback(self, self.OnCollisionExit)
  self.times = 0
  self.halo_em = LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, self.caster, 100, 0, eColliderInfluenceType.Player, collisionEnter, nil, collisionExit, nil, false, false, nil, self.caster)
end

function bs_1034012:OnCollisionEnter(collider, index, entity)
  if entity:GetBuffTier(self.config.buffId_179) < 1 then
    LuaSkillCtrl:CallBuff(self, entity, self.config.buffId_179, 1, nil, true)
  end
end

function bs_1034012:OnCollisionExit(collider, entity)
  if entity:GetBuffTier(self.config.buffId_179) >= 1 then
    LuaSkillCtrl:DispelBuff(entity, self.config.buffId_179, 0, true)
  end
end

function bs_1034012:OnCasterDie()
  base.OnCasterDie(self)
  if self.effectHalo ~= nil then
    self.effectHalo:Die()
    self.effectHalo = nil
  end
  if self.halo_em ~= nil then
    self.halo_em:EndAndDisposeEmission()
    self.halo_em = nil
  end
end

function bs_1034012:LuaDispose()
  base.LuaDispose(self)
  self.effectHalo = nil
  self.halo_em = nil
end

return bs_1034012

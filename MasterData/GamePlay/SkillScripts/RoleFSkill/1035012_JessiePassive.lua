local base = require("GamePlay.SkillScripts.RoleFSkill.FakeCommonPassive")
local bs_1035012 = class("bs_1035012", base)
bs_1035012.config = {restBuffId = 103502, effectId = 103501}

function bs_1035012:ctor()
end

function bs_1035012:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_1035012_1", 1, self.OnAfterBattleStart)
end

function bs_1035012:OnAfterBattleStart()
  if self.effectHalo == nil then
    self.effectHalo = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self)
  end
  local collisionEnter = BindCallback(self, self.OnCollisionEnter)
  local collisionExit = BindCallback(self, self.OnCollisionExit)
  self.halo_em = LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, self.caster, 100, 0, eColliderInfluenceType.Player, collisionEnter, nil, collisionExit, nil, false, false, nil, self.caster)
end

function bs_1035012:OnCollisionEnter(collider, index, entity)
  if entity:GetBuffTier(self.config.restBuffId) < 1 then
    LuaSkillCtrl:CallBuff(self, entity, self.config.restBuffId, 1, nil, true)
  end
end

function bs_1035012:OnCollisionExit(collider, entity)
  if entity:GetBuffTier(self.config.restBuffId) >= 1 then
    LuaSkillCtrl:DispelBuff(entity, self.config.restBuffId, 0, true)
  end
end

function bs_1035012:OnCasterDie()
  if self.effectHalo ~= nil then
    self.effectHalo:Die()
    self.effectHalo = nil
  end
  if self.halo_em ~= nil then
    self.halo_em:EndAndDisposeEmission()
    self.halo_em = nil
  end
  base.OnCasterDie(self)
end

function bs_1035012:LuaDispose()
  base.LuaDispose(self)
  self.effectHalo = nil
  self.halo_em = nil
end

return bs_1035012

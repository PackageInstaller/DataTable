local bs_10282 = class("bs_10282", LuaSkillBase)
local base = LuaSkillBase
bs_10282.config = {
  effectId = 10905,
  effectId2 = 10908,
  buffDefenceId = 1192
}

function bs_10282:ctor()
end

function bs_10282:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10282_1", 1, self.OnAfterBattleStart)
  self.defence = self.caster.def
end

function bs_10282:OnAfterBattleStart()
  local emissionRadius = 100
  if self.caster.recordTable["30021_Flag"] then
    emissionRadius = 10000
    self.effect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId2, self)
  else
    self.effect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self)
  end
  local collisionEnter = BindCallback(self, self.OnCollisionEnter)
  local collisionExit = BindCallback(self, self.OnCollisionExit)
  self.emission = LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, self.caster, emissionRadius, 0, eColliderInfluenceType.Player, collisionEnter, nil, collisionExit, nil, false, false, nil, self.caster)
end

function bs_10282:OnCollisionEnter(collider, index, entity)
  if entity.belongNum ~= self.caster.belongNum or entity.roleType ~= 1 then
    return
  end
  local buffTier = math.max(1, self.defence * self.arglist[1] // 1000)
  if entity ~= self.caster then
    LuaSkillCtrl:CallBuff(self, entity, self.config.buffDefenceId, buffTier, nil, true)
  end
end

function bs_10282:OnCollisionExit(collider, entity)
  if entity.belongNum ~= self.caster.belongNum then
    return
  end
  LuaSkillCtrl:DispelBuff(entity, self.config.buffDefenceId, 0, nil, true)
end

function bs_10282:OnCasterDie()
  base.OnCasterDie(self)
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
  if self.emission ~= nil and self.emission.collider ~= nil then
    LuaSkillCtrl:ClearColliderOrEmission(self.emission.collider)
    self.emission = nil
  end
end

function bs_10282:LuaDispose()
  base.LuaDispose(self)
  self.emission = nil
  self.effect = nil
end

return bs_10282

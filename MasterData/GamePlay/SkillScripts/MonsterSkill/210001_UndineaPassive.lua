local bs_210001 = class("bs_210001", LuaSkillBase)
local base = LuaSkillBase
bs_210001.config = {buffId = 209801}

function bs_210001:ctor()
end

function bs_210001:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRealSummonerCaster, self.OnRealSummonerCaster)
end

function bs_210001:OnRealSummonerCaster(summonerEntity)
  if summonerEntity.belongNum == self.caster.belongNum then
    local collisionEnter = BindCallback(self, self.OnCollisionEnter)
    local collisionExit = BindCallback(self, self.OnCollisionExit)
    self.halo = LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, self.caster, 375, 0, eColliderInfluenceType.Player, collisionEnter, nil, collisionExit, nil, false, false, nil, self.caster)
  end
end

function bs_210001:OnCollisionEnter(collider, index, entity)
  if entity:GetBuffTier(self.config.buffId) < 1 then
    LuaSkillCtrl:CallBuff(self, entity, self.config.buffId, 1)
  end
end

function bs_210001:OnCollisionExit(collider, entity)
  if entity:GetBuffTier(self.config.buffId) >= 1 then
    LuaSkillCtrl:DispelBuff(entity, self.config.buffId, 1)
  end
end

function bs_210001:OnCasterDie()
  base.OnCasterDie(self)
  if self.halo ~= nil then
    self.halo:EndAndDisposeEmission()
    self.halo = nil
  end
end

function bs_210001:LuaDispose()
  base.LuaDispose(self)
  self.halo = nil
end

return bs_210001

local bs_606 = class("bs_606", LuaSkillBase)
local base = LuaSkillBase
bs_606.config = {buffId = 88}

function bs_606:ctor()
end

function bs_606:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRealSummonerCaster, self.OnAfterBattleStart)
end

function bs_606:OnAfterBattleStart(summonerEntity)
  if summonerEntity == self.caster then
    local collisionEnter = BindCallback(self, self.OnCollisionEnter)
    self.fireCollider = LuaSkillCtrl:CallGetCircleSkillCollider(self, 50, eColliderInfluenceType.Enemy, collisionEnter, nil, nil)
  end
end

function bs_606:OnCollisionEnter(collider, index, entity)
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0)
  LuaSkillCtrl:RemoveLife(self.caster.maxHp * 2, self, self.caster, true, nil, false, true)
  LuaSkillCtrl:ClearColliderOrEmission(collider)
end

function bs_606:OnCasterDie()
  base.OnCasterDie(self)
  self.fireCollider = nil
end

return bs_606

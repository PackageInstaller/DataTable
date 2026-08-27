local BrotatoMonsterDropHp = class("BrotatoMonsterDropHp", LuaSkillBase)
local base = LuaSkillBase
local CsFixed64
BrotatoMonsterDropHp.config = {
  effectId = 4,
  effecthpId = 60618,
  heal_config = {baseheal_formula = 3022}
}

function BrotatoMonsterDropHp:ctor()
end

function BrotatoMonsterDropHp:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnBrotatoMonsterDie, self.OnRoleDie)
  if CsFixed64 == nil then
    CsFixed64 = CS.TrueSync.Fix64
  end
  self.heralArgs = {
    self.arglist[1]
  }
end

function BrotatoMonsterDropHp:OnRoleDie(killer, role)
  if killer.belongNum == eBattleRoleBelong.player and role.recordTable.isCanDropHp == true then
    local target = LuaSkillCtrl:GetTargetWithGrid(role.x, role.y)
    local effect = LuaSkillCtrl:CallEffect(target, self.config.effectId, self)
    if not LuaSkillCtrl.IsInVerify then
      local localEffectPos = effect.lsObject.localPosition:ToVector3()
      localEffectPos = localEffectPos * 1000
      local x = math.ceil(localEffectPos.x)
      local z = math.ceil(localEffectPos.z)
      x = math.random(x - 250, x + 250) * 0.001
      z = math.random(z - 250, z + 250) * 0.001
      local vector3 = effect.lsObject.localPosition
      vector3.x = CsFixed64.FromFloat(x)
      vector3.z = CsFixed64.FromFloat(z)
      effect.lsObject.localPosition = vector3
    end
    local collisionEnter = BindCallback(self, self.OnCollisionEnter, effect)
    local range = self.caster.recordTable.brotatoDropRange
    if range == nil then
      self.caster.recordTable.brotatoDropRange = 50
      range = 50
    end
    LuaSkillCtrl:CallAddCircleColliderForEffect(effect, range, eColliderInfluenceType.Player, nil, collisionEnter)
  end
end

function BrotatoMonsterDropHp:OnCollisionEnter(effect, collider, index, entity)
  if effect ~= nil then
    effect:Die()
    effect = nil
  end
  LuaSkillCtrl:ClearColliderOrEmission(collider)
  if not LuaSkillCtrl.IsInVerify then
    AudioManager:PlayAudioById(1283)
  end
  LuaSkillCtrl:CallEffect(entity, self.config.effecthpId, self)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, entity)
  LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, self.heralArgs, true, false, true)
  skillResult:EndResult()
end

function BrotatoMonsterDropHp:OnCasterDie()
  base.OnCasterDie(self)
end

return BrotatoMonsterDropHp

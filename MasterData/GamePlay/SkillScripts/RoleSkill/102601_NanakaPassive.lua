local bs_102601 = class("bs_102601", LuaSkillBase)
local base = LuaSkillBase
bs_102601.config = {
  effectId_pass = 10725,
  effectId_pass_ex = 10726,
  effectId_pass_old = 10856,
  buffId_232 = 232,
  buffId_23202 = 23202,
  buffId_231 = 231,
  selectId = 47,
  heal_config = {baseheal_formula = 10088}
}

function bs_102601:ctor()
end

function bs_102601:InitSkill(isMidwaySkill)
  self.effectHalo = nil
  self.halo = nil
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.BuffDie, "bs_102601_11", 1, self.OnBuffDie)
  if LuaSkillCtrl:GetCasterSkinId(self.caster) ~= 302606 then
    self:AddAfterAddBuffTrigger("bs_102601_13", 1, self.OnAfterAddBuff, nil, nil, nil, nil, self.config.buffId_232)
  else
    self:AddAfterAddBuffTrigger("bs_102601_13", 1, self.OnAfterAddBuff, nil, nil, nil, nil, self.config.buffId_23202)
  end
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_102601_1", 1, self.OnAfterBattleStart)
  self:AddTrigger(eSkillTriggerType.BeforeBattleEnd, "bs_102601_3", 1, self.BeforeEndBattle)
end

function bs_102601:OnAfterBattleStart()
  if self.effectHalo == nil then
    self.effectHalo = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_pass, self)
  end
  local collisionEnter = BindCallback(self, self.OnCollisionEnter)
  local collisionExit = BindCallback(self, self.OnCollisionExit)
  self.halo = LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, self.caster, 175, 0, eColliderInfluenceType.Player, collisionEnter, nil, collisionExit, nil, false, false, nil, self.caster)
end

function bs_102601:OnCollisionEnter(collider, index, entity)
  if entity:GetBuffTier(self.config.buffId_231) < 1 then
    LuaSkillCtrl:CallBuff(self, entity, self.config.buffId_231, 1)
  end
end

function bs_102601:OnCollisionExit(collider, entity)
  if entity:GetBuffTier(self.config.buffId_231) >= 1 then
    LuaSkillCtrl:DispelBuff(entity, self.config.buffId_231, 0)
  end
end

function bs_102601:OnAfterAddBuff(buff, target)
  if (buff.dataId == self.config.buffId_232 or buff.dataId == self.config.buffId_23202) and target == self.caster then
    if self.effectHalo ~= nil then
      self.effectHalo:Die()
      self.effectHalo = nil
      self.effectHalo = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_pass_ex, self)
    end
    if self.halo ~= nil then
      LuaSkillCtrl:SetCircleColliderAndEffectRadius(self.halo.collider, 275, nil)
    end
  end
end

function bs_102601:OnBuffDie(buff, target, removeType)
  if (buff.dataId == self.config.buffId_232 or buff.dataId == self.config.buffId_23202) and target == self.caster then
    if self.effectHalo ~= nil then
      self.effectHalo:Die()
      self.effectHalo = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_pass_old, self)
    end
    if self.halo ~= nil then
      LuaSkillCtrl:SetCircleColliderAndEffectRadius(self.halo.collider, 175, nil)
    end
  end
end

function bs_102601:BeforeEndBattle()
  if self.loopAudio ~= nil then
    LuaSkillCtrl:StopAudioByBack(self.loopAudio)
    self.loopAudio = nil
  end
end

function bs_102601:OnCasterDie()
  base.OnCasterDie(self)
  if self.loopAudio ~= nil then
    LuaSkillCtrl:StopAudioByBack(self.loopAudio)
    self.loopAudio = nil
  end
  if self.effectHalo ~= nil then
    self.effectHalo:Die()
    self.effectHalo = nil
  end
  if self.halo ~= nil then
    self.halo:EndAndDisposeEmission()
    self.halo = nil
  end
end

function bs_102601:LuaDispose()
  base.LuaDispose(self)
  self.effectHalo = nil
  self.halo = nil
end

return bs_102601

local bs_10331 = class("bs_10331", LuaSkillBase)
local base = LuaSkillBase
bs_10331.config = {buffId = 2055, effectId = 10974}

function bs_10331:ctor()
end

function bs_10331:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_10331_3", 1, self.OnAfterHurt, self.caster)
  self:AddAfterAddBuffTrigger("bs_10331_2", 1, self.OnAfterAddBuff, self.caster)
  self:AddOnRoleDieTrigger("bs_10331_02", 1, self.OnRoleDie)
  self.countBuffEffect = {}
end

function bs_10331:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if skill.isCommonAttack and self:IsReadyToTake() and not isTriggerSet and LuaSkillCtrl:CallRange(1, 1000) <= self.arglist[2] then
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId, 1)
    self:OnSkillTake()
  end
end

function bs_10331:OnAfterAddBuff(buff, target)
  if buff.dataId == self.config.buffId and target ~= nil and target.hp > 0 then
    local buffTier1 = target:GetBuffTier(self.config.buffId)
    if buffTier1 == 1 then
      self.countBuffEffect[target.uid] = LuaSkillCtrl:CallEffect(target, self.config.effectId, self)
      LuaSkillCtrl:EffectSetCountValue(self.countBuffEffect[target.uid], buffTier1 - 1)
    elseif self.countBuffEffect[target.uid] ~= nil then
      LuaSkillCtrl:EffectSetCountValue(self.countBuffEffect[target.uid], buffTier1 - 1)
    end
  end
end

function bs_10331:OnRoleDie(killer, role)
  local newBuffTier = role:GetBuffTier(self.config.buffId)
  if self.countBuffEffect[role.uid] ~= nil then
    self.countBuffEffect[role.uid]:Die()
    self.countBuffEffect[role.uid] = nil
  end
end

function bs_10331:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_10331:LuaDispose()
  self.countBuffEffect = nil
  base.LuaDispose(self)
end

return bs_10331

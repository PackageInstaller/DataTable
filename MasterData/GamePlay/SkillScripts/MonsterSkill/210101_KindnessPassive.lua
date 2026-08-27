local bs_210101 = class("bs_210101", LuaSkillBase)
local base = LuaSkillBase
bs_210101.config = {
  buffId = 210101,
  buffId_speed = 210102,
  effectId_change1 = 210100,
  effectId_change = 210101
}

function bs_210101:ctor()
end

function bs_210101:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_210101_1", 1, self.OnAfterBattleStart)
  self:AddAfterHurtTrigger("bs_210101_2", 1, self.OnAfterHurt, self.caster, nil, nil, nil, nil, nil, nil, eSkillTag.commonAttack)
  self:AddAfterBuffRemoveTrigger("bs_210101_3", 4, self.AfterBuffRemove, self.caster, nil, self.config.buffId, nil)
  self.caster.recordTable.attack_id = 0
end

function bs_210101:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and skill.isCommonAttack and not isMiss then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, self.arglist[4], true)
    if self.caster.recordTable.attack_id == 1 then
      LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_change, self)
    elseif self.caster.recordTable.attack_id == 2 then
      LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_change1, self)
    end
  end
  if sender == self.caster and skill.isCommonAttack and isMiss and self.caster:GetBuffTier(self.config.buffId) > 0 then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 1)
  end
  local buffTier = sender:GetBuffTier(self.config.buffId)
  if 0 < buffTier then
    local scale = buffTier * 0.1 + 1
    LuaSkillCtrl:CallStartLocalScale(sender, Vector3.New(scale, scale, scale))
  else
    LuaSkillCtrl:CallStartLocalScale(sender, Vector3.New(1, 1, 1))
  end
end

function bs_210101:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_speed, 1)
end

function bs_210101:AfterBuffRemove(buffId, target, removeType)
  if target ~= nil and target == self.caster then
    local buffTier = target:GetBuffTier(buffId)
    if buffTier == 0 then
      LuaSkillCtrl:CallStartLocalScale(target, Vector3.New(1, 1, 1))
    end
  end
end

function bs_210101:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_210101

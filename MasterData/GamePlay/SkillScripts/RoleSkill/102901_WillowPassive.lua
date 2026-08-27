local bs_102901 = class("bs_102901", LuaSkillBase)
local base = LuaSkillBase
bs_102901.config = {
  buffId_blind = 3012,
  buffId_oldBlind = 115,
  buffId_attackSpeedUp = 102900,
  selectId_pass = 5,
  weaponLv = 0,
  selectId = 6,
  buff_pow = 102906,
  buff_skill_intensity = 102905
}

function bs_102901:ctor()
end

function bs_102901:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_102901_2", 1, self.OnAfterAddBuff, nil, nil, nil, 2, nil, 2)
  self:AddTrigger(eSkillTriggerType.BuffDie, "bs_102901_buffDie", 1, self.OnBuffDie)
  self:AddAfterHurtTrigger("bs_102901_3", 1, self.OnAfterHurt, self.caster)
  self.tiers = 0
  self.ExRate = 0
end

function bs_102901:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  local rate = self.arglist[2]
  if self.config.weaponLv >= 3 then
    rate = rate + self.arglist[8] + self.ExRate
  end
  if rate < LuaSkillCtrl:CallRange(1, 1000) then
    self.ExRate = self.ExRate + 100
    return
  end
  if sender == self.caster and skill.isCommonAttack == true and target ~= nil and target.hp > 0 and target.belongNum ~= self.caster.belongNum and target.intensity ~= 0 then
    self.ExRate = 0
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId_blind, 1, self.arglist[3])
    if self.config.weaponLv >= 3 then
      local targetList = LuaSkillCtrl:CallTargetSelect(self, self.config.selectId, 10)
      local role1 = targetList[0].targetRole
      local role2 = targetList[0].targetRole
      for i = 0, targetList.Count - 1 do
        if targetList[i].targetRole.skill_intensity > role1.skill_intensity then
          role1 = targetList[i].targetRole
        end
        if targetList[i].targetRole.pow > role2.pow then
          role2 = targetList[i].targetRole
        end
      end
      if role1 == role2 then
        role2 = nil
      end
      LuaSkillCtrl:CallBuff(self, role1, self.config.buff_skill_intensity, 1, self.arglist[10])
      LuaSkillCtrl:CallBuff(self, role2, self.config.buff_pow, 1, self.arglist[10])
    end
  end
end

function bs_102901:OnAfterAddBuff(buff, target, isOverlay)
  if buff.dataId == self.config.buffId_oldBlind or buff.dataId == 3012 then
    local tier = 0
    local targetList = LuaSkillCtrl:CallTargetSelect(self, self.config.selectId_pass, 10)
    if 0 < targetList.Count then
      for i = 0, targetList.Count - 1 do
        local role = targetList[i].targetRole
        if 0 < role:GetBuffTier(self.config.buffId_oldBlind) and role.belongNum ~= self.caster.belongNum then
          tier = tier + 1
        end
        if 0 < role:GetBuffTier(self.config.buffId_blind) and role.belongNum ~= self.caster.belongNum then
          tier = tier + 1
        end
      end
    end
    if 10 < tier then
      tier = 10
    end
    if tier ~= self.tiers then
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_attackSpeedUp, 0, true)
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_attackSpeedUp, tier, nil, true)
      self.tiers = tier
    end
  end
end

function bs_102901:OnBuffDie(buff, target, removeType)
  if (buff.dataId == self.config.buffId_oldBlind or buff.dataId == 3012) and removeType ~= eBuffRemoveType.Conflict then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_attackSpeedUp, 1, true)
    self.tiers = self.tiers - 1
  end
end

function bs_102901:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_102901

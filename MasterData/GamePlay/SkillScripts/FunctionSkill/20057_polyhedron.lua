local bs_20057 = class("bs_20057", LuaSkillBase)
local base = LuaSkillBase
bs_20057.config = {buffId = 1164}

function bs_20057:ctor()
end

function bs_20057:InitSkill(isMidwaySkill)
  self.flag = true
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_20057_1", 1, self.OnAfterBattleStart)
  self:AddAfterHurtTrigger("bs_20057_3", 1, self.OnAfterHurt, nil, nil, nil, 1)
  self:AddAfterHealTrigger("bs_20057_5", 2, self.OnAfterHeal, nil, nil, nil, 1)
end

function bs_20057:OnAfterBattleStart()
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
  if targetlist.Count <= 0 then
    return
  end
  for i = 0, targetlist.Count - 1 do
    local targetRole = targetlist[i].targetRole
    if targetRole.hp < 0.5 * targetRole.maxHp then
      self.flag = false
    end
  end
  if self.flag then
    for i = 0, targetlist.Count - 1 do
      local targetRole = targetlist[i].targetRole
      LuaSkillCtrl:CallBuff(self, targetRole, self.config.buffId, 1, nil, true)
    end
  else
    for i = 0, targetlist.Count - 1 do
      local targetRole = targetlist[i].targetRole
      LuaSkillCtrl:DispelBuff(targetRole, self.config.buffId, 0, true, true)
    end
    self.flag = true
  end
end

function bs_20057:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
  if targetlist.Count <= 0 then
    return
  end
  for i = 0, targetlist.Count - 1 do
    local targetRole = targetlist[i].targetRole
    if targetRole.hp < 0.5 * targetRole.maxHp then
      self.flag = false
    end
  end
  if self.flag then
    for i = 0, targetlist.Count - 1 do
      local targetRole = targetlist[i].targetRole
      LuaSkillCtrl:CallBuff(self, targetRole, self.config.buffId, 1, nil, true)
    end
  else
    for i = 0, targetlist.Count - 1 do
      local targetRole = targetlist[i].targetRole
      LuaSkillCtrl:DispelBuff(targetRole, self.config.buffId, 0, true, true)
    end
    self.flag = true
  end
end

function bs_20057:OnAfterHeal(sender, target, skill, heal, isStealHeal, isCrit, isTriggerSet)
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
  if targetlist.Count <= 0 then
    return
  end
  for i = 0, targetlist.Count - 1 do
    local targetRole = targetlist[i].targetRole
    if targetRole.hp < 0.5 * targetRole.maxHp then
      self.flag = false
    end
  end
  if self.flag then
    for i = 0, targetlist.Count - 1 do
      local targetRole = targetlist[i].targetRole
      LuaSkillCtrl:CallBuff(self, targetRole, self.config.buffId, 1, nil, true)
    end
  else
    for i = 0, targetlist.Count - 1 do
      local targetRole = targetlist[i].targetRole
      LuaSkillCtrl:DispelBuff(targetRole, self.config.buffId, 0, true, true)
    end
    self.flag = true
  end
end

function bs_20057:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20057

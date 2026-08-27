local bs_31006 = class("bs_31006", LuaSkillBase)
local base = LuaSkillBase
bs_31006.config = {
  buffId_miniFire = 110150,
  effectId = 12092,
  aoe_config = {
    effect_shape = 3,
    aoe_select_code = 5,
    aoe_range = 1
  },
  newBuffId_miniFire = 110152
}

function bs_31006:ctor()
end

function bs_31006:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_31006_1", 99, self.OnAfterBattleStart)
end

function bs_31006:OnAfterBattleStart()
  if self.caster.recordTable.miniFireBuff == nil then
    self.buffId = self.config.buffId_miniFire
  else
    self.buffId = self.config.newBuffId_miniFire
  end
  self:AddAfterAddBuffTrigger("bs_31006_2", 1, self.OnAfterAddBuff, nil, nil, nil, eBattleRoleBelong.enemy, self.buffId)
  self.maxTier = self.config.recordTable.miniFireBuffTier
end

function bs_31006:OnAfterAddBuff(buff, target)
  if buff.tier < self.maxTier - 1 then
    return
  end
  if buff.tier >= self.maxTier then
    self:ActiveBuff(buff, target)
    LuaSkillCtrl:DispelBuff(target, self.buffId, buff.tier * 500 // 1000, true, true)
  end
end

function bs_31006:loopActive(buff, target)
  local times = buff.tier * self.arglist[1] // 1000
  for i = 0, times - 1 do
    self:ActiveBuff(buff, target)
  end
end

function bs_31006:ActiveBuff(buff, target)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, self.config.aoe_config)
  local damage = 0
  if self.caster.recordTable.miniFireBuff == nil then
    damage = buff.tier * self.arglist[1] * target:GetBuffTier(self.config.buffId_miniFire)
  else
    damage = buff.tier * self.arglist[1] * target:GetBuffTier(self.config.newBuffId_miniFire)
  end
  if 0 < skillResult.roleList.Count then
    for i = 0, skillResult.roleList.Count - 1 do
      local targetRole = skillResult.roleList[i]
      local skillResult1 = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
      LuaSkillCtrl:HurtResultWithConfig(self, skillResult1, 38, {damage}, true)
      skillResult1:EndResult()
    end
  end
  skillResult:EndResult()
  LuaSkillCtrl:CallEffect(target, self.config.effectId, self)
end

function bs_31006:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_31006

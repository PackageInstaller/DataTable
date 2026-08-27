local bs_213302 = class("bs_213302", LuaSkillBase)
local base = LuaSkillBase
bs_213302.config = {buff_weak = 213301}

function bs_213302:ctor()
  self.issummon = false
end

function bs_213302:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_213302_1", 1, self.OnAfterHurt, self.caster, nil, nil, nil, nil, nil, nil, eSkillTag.commonAttack)
  self:AddAfterHealTrigger("bs_213302_2", 1, self.OnAfterHeal, nil, nil, nil, eBattleRoleBelong.player, nil)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRealSummonerCaster, self.SummonerCaster)
end

function bs_213302:SummonerCaster(summonerEntity)
  if summonerEntity == self.caster then
    self.issummon = true
  end
end

function bs_213302:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, isRealDmg, isTriggerSet)
  LuaSkillCtrl:CallBuff(self, target, self.config.buff_weak, 1, self.arglist[5])
end

function bs_213302:OnAfterHeal(sender, target, skill, heal, isStealHeal, isCrit, isTriggerSet)
  local num_weak = target:GetBuffTier(self.config.buff_weak)
  if target.belongNum == eBattleRoleBelong.player and 0 < num_weak then
    local num_dispel = math.min(num_weak, self.arglist[4])
    LuaSkillCtrl:DispelBuff(target, self.config.buff_weak, num_dispel)
  end
end

function bs_213302:OnCasterDie()
  self:KillEquipmentSummoner()
  self:RemoveSkillTrigger(eSkillTriggerType.AfterHurt)
  self:RemoveAllTimers()
  self:RemoveAllBreakKillEffects()
  self:RemoveAllLuaTrigger()
  self:RemoveAllHaleEmission()
  if self.caster.recordTable.lastSkill == self.dataID then
    self:OnSkillDamageEnd()
  end
end

return bs_213302

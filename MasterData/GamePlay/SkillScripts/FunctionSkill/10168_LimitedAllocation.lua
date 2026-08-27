local bs_10168 = class("bs_10168", LuaSkillBase)
local base = LuaSkillBase
bs_10168.config = {
  damageFormular = 1047,
  buffId1 = 1003,
  buffId2 = 1011
}

function bs_10168:ctor()
end

function bs_10168:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10168_1", 1, self.OnAfterBattleStart)
end

function bs_10168:OnAfterBattleStart()
  local sender = self.caster
  local damageNum = LuaSkillCtrl:CallFormulaNumberWithSkill(self.config.damageFormular, self.caster, self.caster, self)
  if damageNum < 1 then
    return
  end
  self:PlayChipEffect()
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 6, 0)
  if 0 >= targetList.Count then
    return
  end
  local target
  for i = 0, targetList.Count - 1 do
    local target_tmp = targetList[i].targetRole
    if target_tmp.y == self.caster.y and target_tmp.x == self.caster.x - 1 then
      target = targetList[i].targetRole
    end
  end
  if target == nil then
    return
  end
  local buffTier2 = self.arglist[1] // 10
  local buffTier1 = damageNum * 1000 // target.maxHp
  LuaSkillCtrl:CallBuff(self, sender, self.config.buffId2, buffTier2, nil, true)
  LuaSkillCtrl:CallBuff(self, target, self.config.buffId1, buffTier1, nil, true)
  LuaSkillCtrl:RemoveLife(damageNum, self, sender, true, nil, true, false, eHurtType.RealDmg)
  LuaSkillCtrl:CallHeal(damageNum, self, target)
end

function bs_10168:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10168

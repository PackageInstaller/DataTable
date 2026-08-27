local bs_6014 = class("bs_6014", LuaSkillBase)
local base = LuaSkillBase
bs_6014.config = {buffId_Taunt = 3002, buffId_fanshang = 601401}

function bs_6014:ctor()
end

function bs_6014:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_6014_13", 1, self.OnAfterPlaySkill)
  self:AddAfterHurtTrigger("bs_6014", 1, self.OnAfterHurt, nil, self.caster, eBattleRoleBelong.enemy, nil, nil, nil, nil, eSkillTag.commonAttack)
end

function bs_6014:OnAfterPlaySkill(skill, role)
  if skill.maker == self.caster and not skill.isCommonAttack then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_fanshang, 1, self.arglist[1])
    local rangeOffset = 1
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, rangeOffset)
    if targetList.Count > 0 then
      for i = 0, targetList.Count - 1 do
        if targetList[i].targetRole.intensity ~= 0 then
          LuaSkillCtrl:CallBuff(self, targetList[i].targetRole, self.config.buffId_Taunt, 1, self.arglist[1])
        end
      end
    end
  end
end

function bs_6014:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target.hp <= 0 then
    return
  end
  LuaSkillCtrl:RemoveLife(self.caster.maxHp * self.arglist[3] // 1000, self, sender, true, nil, true, false, eHurtType.RealDmg)
end

function bs_6014:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_6014

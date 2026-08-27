local bs_210002 = class("bs_210002", LuaSkillBase)
local base = LuaSkillBase
bs_210002.config = {buffId_1 = 210001}

function bs_210002:ctor()
end

function bs_210002:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_210002_1", 9, self.OnAfterHurt, self.caster, nil, nil, nil, nil, nil, nil, eSkillTag.commonAttack)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_210002_2", 1, self.OnAfterPlaySkill)
end

function bs_210002:OnAfterPlaySkill(skill, role)
  if role == self.caster and skill.isCommonAttack ~= true and role:GetBuffTier(self.config.buffId_1) < self.arglist[4] then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_1, 1)
  end
end

function bs_210002:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and skill.isCommonAttack == true and isMiss ~= true and isTriggerSet ~= true then
    local skil_1 = target:GetBattleSkillList()
    if skil_1 ~= nil then
      local skillCount = skil_1.Count
      if 0 < skillCount then
        for j = 0, skillCount - 1 do
          local curTotalCd = skil_1[j].totalCDTime * -1 * self.arglist[1] // 1000
          if not skil_1[j].isCommonAttack then
            LuaSkillCtrl:CallResetCDForSingleSkill(skil_1[j], curTotalCd)
          end
        end
      end
    end
    local skills = sender:GetBattleSkillList()
    if skills ~= nil then
      local skillCount = skills.Count
      if 0 < skillCount then
        for j = 0, skillCount - 1 do
          local curTotalCd = skills[j].totalCDTime * self.arglist[2] // 1000
          if not skills[j].isCommonAttack then
            LuaSkillCtrl:CallResetCDForSingleSkill(skills[j], curTotalCd)
          end
        end
      end
    end
  end
end

function bs_210002:PlaySkill(data)
end

function bs_210002:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_210002

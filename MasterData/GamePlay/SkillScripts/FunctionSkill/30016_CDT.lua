local bs_30016 = class("bs_30016", LuaSkillBase)
local base = LuaSkillBase
bs_30016.config = {buffId = 170}

function bs_30016:ctor()
end

function bs_30016:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_30016_2", 2, self.OnAfterPlaySkill)
end

function bs_30016:OnAfterPlaySkill(skill, role)
  local buffTier = self.caster:GetBuffTier(self.config.buffId)
  if 0 < buffTier then
    return
  end
  if skill.maker == self.caster and skill.isCommonAttack then
    local skills = self.caster:GetBattleSkillList()
    if skills ~= nil then
      local skillCount = skills.Count
      if 0 < skillCount then
        for j = 0, skillCount - 1 do
          local curTotalCd = skills[j].totalCDTime * self.arglist[1] // 1000
          LuaSkillCtrl:CallResetCDForSingleSkill(skills[j], curTotalCd)
        end
      end
    end
    self:PlayChipEffect()
  end
end

function bs_30016:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_30016

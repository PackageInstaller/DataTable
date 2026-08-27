local bs_10125 = class("bs_10125", LuaSkillBase)
local base = LuaSkillBase
bs_10125.config = {buffId = 170}

function bs_10125:ctor()
end

function bs_10125:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_10125_2", 2, self.OnAfterPlaySkill)
end

function bs_10125:OnAfterPlaySkill(skill, role)
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

function bs_10125:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10125

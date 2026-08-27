local bs_10274 = class("bs_10274", LuaSkillBase)
local base = LuaSkillBase
bs_10274.config = {effectId = 10164}

function bs_10274:ctor()
end

function bs_10274:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_10274_1", 2, self.OnAfterPlaySkill)
end

function bs_10274:OnAfterPlaySkill(skill, role)
  if skill.maker == self.caster and not skill.isCommonAttack then
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
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self)
  end
end

function bs_10274:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10274

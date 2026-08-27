local bs_15216 = class("bs_15216", LuaSkillBase)
local base = LuaSkillBase
bs_15216.config = {eatEffectId = 10735}

function bs_15216:ctor()
end

function bs_15216:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterPlaySkillTrigger("bs_15216_01", 1, self.OnAfterPlaySkill, nil, nil, eBattleRoleBelong.enemy, nil, nil, nil, nil, eSkillTag.normalSkill)
end

function bs_15216:OnAfterPlaySkill(skill, role)
  if not skill.isCommonAttack and role.belongNum == eBattleRoleBelong.enemy then
    local skills = self.caster:GetBattleSkillList()
    if skills ~= nil then
      local skillCount = skills.Count
      if 0 < skillCount then
        for j = 0, skillCount - 1 do
          local curTotalCd = skills[j].totalCDTime * self.arglist[1] // 1000
          if not skills[j].isCommonAttack then
            LuaSkillCtrl:CallResetCDForSingleSkill(skills[j], curTotalCd)
            LuaSkillCtrl:CallEffect(self.caster, self.config.eatEffectId, self)
          end
        end
      end
    end
  end
end

function bs_15216:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15216

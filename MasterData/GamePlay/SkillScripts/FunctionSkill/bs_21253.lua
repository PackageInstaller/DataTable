local bs_21253 = class("bs_21253", LuaSkillBase)
local base = LuaSkillBase
bs_21253.config = {effect = 12137}

function bs_21253:ctor()
end

function bs_21253:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddOnRoleDieTrigger("bs_21253", 1, self.OnRoleDie, self.caster, nil, nil, eBattleRoleBelong.neutral, nil, nil)
end

function bs_21253:OnRoleDie(killer, role)
  if killer ~= self.caster then
    return
  end
  local value = self.arglist[1] // 10
  if self.caster ~= nil then
    local skills = self.caster:GetBattleSkillList()
    if skills ~= nil then
      local count = skills.Count
      if 0 < count then
        for i = 0, count - 1 do
          local curCd = skills[i].totalCDTime * self.arglist[1] // 1000
          if not skills[i].isCommonAttack then
            LuaSkillCtrl:CallResetCDForSingleSkill(skills[i], curCd)
          end
        end
      end
    end
  end
end

function bs_21253:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_21253

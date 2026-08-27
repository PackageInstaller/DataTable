local bs_30042 = class("bs_30042", LuaSkillBase)
local base = LuaSkillBase
bs_30042.config = {}

function bs_30042:ctor()
end

function bs_30042:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_30042_10", 1, self.OnRoleDie)
end

function bs_30042:OnRoleDie(killer, role)
  if role.belongNum == self.caster.belongNum and role.roleType == 1 then
    self:PlayChipEffect()
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 6, 0)
    if 1 > targetlist.Count then
      return
    end
    for i = 0, targetlist.Count - 1 do
      local targetRole = targetlist[i].targetRole
      local skills = targetRole:GetBattleSkillList()
      if skills ~= nil then
        local skillCount = skills.Count
        if 0 < skillCount then
          for j = 0, skillCount - 1 do
            local curTotalCd = skills[j].totalCDTime
            LuaSkillCtrl:CallResetCDForSingleSkill(skills[j], curTotalCd)
          end
        end
      end
    end
  end
end

function bs_30042:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_30042

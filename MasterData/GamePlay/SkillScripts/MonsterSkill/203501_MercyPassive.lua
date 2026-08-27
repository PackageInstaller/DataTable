local bs_203501 = class("bs_203501", LuaSkillBase)
local base = LuaSkillBase
bs_203501.config = {}

function bs_203501:ctor()
end

function bs_203501:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_203501_11", 1, self.OnRoleDie)
end

function bs_203501:OnRoleDie(killer, role, killSkill)
  if role.belongNum == self.caster.belongNum and role.name ~= "仁慈-召唤" and self:IsReadyToTake() then
    local skills = self.caster:GetBattleSkillList()
    if skills ~= nil then
      local skillCount = skills.Count
      if 0 < skillCount then
        for j = 0, skillCount - 1 do
          local curTotalCd = skills[j].totalCDTime
          if not skills[j].isCommonAttack then
            LuaSkillCtrl:CallResetCDForSingleSkill(skills[j], curTotalCd)
            self:OnSkillTake()
          end
        end
      end
    end
  end
end

function bs_203501:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_203501

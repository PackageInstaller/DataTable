local bs_10179 = class("bs_10179", LuaSkillBase)
local base = LuaSkillBase
bs_10179.config = {}

function bs_10179:ctor()
end

function bs_10179:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.OnBreakShield, "bs_10179_22", 1, self.OnBreakShield)
end

function bs_10179:OnBreakShield(shieldType, sender, target)
  if target.belongNum ~= self.caster.belongNum then
    local skills = sender:GetBattleSkillList()
    if skills ~= nil then
      local skillCount = skills.Count
      if 0 < skillCount then
        for j = 0, skillCount - 1 do
          local curTotalCd = skills[j].totalCDTime
          if not skills[j].isCommonAttack then
            LuaSkillCtrl:CallResetCDForSingleSkill(skills[j], curTotalCd)
          end
        end
      end
    end
  end
end

function bs_10179:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10179

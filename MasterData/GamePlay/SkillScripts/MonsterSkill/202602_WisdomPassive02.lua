local bs_202602 = class("bs_202602", LuaSkillBase)
local base = LuaSkillBase
bs_202602.config = {effectId = 10611}

function bs_202602:ctor()
end

function bs_202602:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.RoleDie, "bs_202602_10", 1, self.OnRoleDie)
end

function bs_202602:OnRoleDie(killer, role)
  if killer == self.caster then
    local skills = self.caster:GetBattleSkillList()
    if skills ~= nil then
      for j = 0, skills.Count - 1 do
        if skills[j].isCommonAttack ~= true and skills[j].useLimitTime == 0 then
          local curTotalCd = skills[j].totalCDTime
          LuaSkillCtrl:CallResetCDForSingleSkill(skills[j], curTotalCd - 5)
          LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self)
          break
        end
      end
    end
  end
end

function bs_202602:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_202602

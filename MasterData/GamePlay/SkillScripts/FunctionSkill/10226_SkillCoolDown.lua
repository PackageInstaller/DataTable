local bs_10226 = class("bs_10226", LuaSkillBase)
local base = LuaSkillBase
bs_10226.config = {effectId = 10164}

function bs_10226:ctor()
end

function bs_10226:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_10226_1", 2, self.OnAfterPlaySkill)
end

function bs_10226:OnAfterPlaySkill(skill, role)
  if self.caster.recordTable["104502_active"] == false then
    return
  end
  if skill.maker == self.caster and not skill.isCommonAttack and self:IsReadyToTake() then
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
    self:OnSkillTake()
  end
end

function bs_10226:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10226

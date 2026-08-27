local bs_20014 = class("bs_20014", LuaSkillBase)
local base = LuaSkillBase
bs_20014.config = {}

function bs_20014:ctor()
end

function bs_20014:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_20014_1", 1, self.OnAfterBattleStart)
end

function bs_20014:OnAfterBattleStart()
  local skills = self.caster:GetBattleSkillList()
  if skills ~= nil then
    local count = skills.Count
    if 0 < count then
      for i = 0, count - 1 do
        local startCd = skills[i].CurCDTime
        LuaSkillCtrl:CallResetCDForSingleSkill(skills[i], -startCd)
      end
      self:PlayChipEffect()
    end
  end
end

function bs_20014:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20014

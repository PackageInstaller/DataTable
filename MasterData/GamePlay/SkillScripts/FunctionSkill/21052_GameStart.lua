local bs_21052 = class("bs_21052", LuaSkillBase)
local base = LuaSkillBase
bs_21052.config = {effectId = 10164}

function bs_21052:ctor()
end

function bs_21052:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_21052_1", 1, self.OnAfterBattleStart)
end

function bs_21052:OnAfterBattleStart()
  local skills = self.caster:GetBattleSkillList()
  if skills ~= nil then
    local count = skills.Count
    if 0 < count then
      for i = 0, count - 1 do
        local curCd = skills[i].totalCDTime
        if not skills[i].isCommonAttack then
          LuaSkillCtrl:CallResetCDForSingleSkill(skills[i], curCd)
        end
      end
      LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self)
    end
  end
end

function bs_21052:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_21052

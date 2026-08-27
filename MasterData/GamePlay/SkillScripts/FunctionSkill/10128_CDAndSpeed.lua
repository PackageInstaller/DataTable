local bs_10128 = class("bs_10128", LuaSkillBase)
local base = LuaSkillBase
bs_10128.config = {buffId = 1009, effectId = 10164}

function bs_10128:ctor()
end

function bs_10128:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10128_1", 1, self.OnAfterBattleStart)
end

function bs_10128:OnAfterBattleStart()
  self:PlayChipEffect()
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.arglist[1], self.arglist[2], true)
  local skills = self.caster:GetBattleSkillList()
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

function bs_10128:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10128

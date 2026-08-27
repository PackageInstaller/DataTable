local bs_10232 = class("bs_10232", LuaSkillBase)
local base = LuaSkillBase
bs_10232.config = {
  buffId = 1087,
  buffTier = 1,
  effectId = 10164
}

function bs_10232:ctor()
end

function bs_10232:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10232_1", 1, self.OnAfterBattleStart)
end

function bs_10232:OnAfterBattleStart()
  self:PlayChipEffect()
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier, self.arglist[2], true)
  local skills = self.caster:GetBattleSkillList()
  if skills ~= nil then
    local skillCount = skills.Count
    if 0 < skillCount then
      for j = 0, skillCount - 1 do
        local curTotalCd = skills[j].totalCDTime
        LuaSkillCtrl:CallResetCDForSingleSkill(skills[j], curTotalCd)
      end
    end
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self)
  end
end

function bs_10232:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10232

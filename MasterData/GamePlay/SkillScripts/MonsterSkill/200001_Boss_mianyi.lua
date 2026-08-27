local bs_200001 = class("bs_200001", LuaSkillBase)
local base = LuaSkillBase
bs_200001.config = {buffId_198 = 198}

function bs_200001:ctor()
end

function bs_200001:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_200001_1", 1, self.OnAfterBattleStart)
end

function bs_200001:OnAfterBattleStart()
  local breakComponent = self.caster:GetBreakComponent()
  if breakComponent == nil then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_198, 1, nil, true)
  end
end

function bs_200001:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_200001

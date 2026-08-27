local bs_10305 = class("bs_10305", LuaSkillBase)
local base = LuaSkillBase
bs_10305.config = {buffId = 1121}

function bs_10305:ctor()
end

function bs_10305:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10305_1", 1, self.OnAfterBattleStart)
end

function bs_10305:OnAfterBattleStart(isMidway)
  if isMidway and self.caster ~= nil then
    self:PlayChipEffect()
    LuaSkillCtrl:AddPlayerTowerMp(self.arglist[1])
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, self.arglist[2])
  end
end

function bs_10305:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10305

local bs_20018 = class("bs_20018", LuaSkillBase)
local base = LuaSkillBase
bs_20018.config = {buffId = 1112}

function bs_20018:ctor()
end

function bs_20018:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_20018_1", 1, self.OnAfterBattleStart)
end

function bs_20018:OnAfterBattleStart()
  if self.caster.belongNum == 2 then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
  end
end

function bs_20018:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20018

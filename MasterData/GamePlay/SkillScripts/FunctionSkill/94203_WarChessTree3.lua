local bs_94203 = class("bs_94203", LuaSkillBase)
local base = LuaSkillBase
bs_94203.config = {buffId = 110059}

function bs_94203:ctor()
end

function bs_94203:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_94203_1", 1, self.OnAfterBattleStart)
end

function bs_94203:OnAfterBattleStart()
  if self.caster.intensity >= 2 then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
  end
end

function bs_94203:OnAfterPlaySkill(skill, role)
end

function bs_94203:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_94203

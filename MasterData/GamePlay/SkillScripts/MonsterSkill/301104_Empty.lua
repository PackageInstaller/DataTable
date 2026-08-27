local bs_301104 = class("bs_301104", LuaSkillBase)
local base = LuaSkillBase
bs_301104.config = {effectId1 = 12031}

function bs_301104:ctor()
end

function bs_301104:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_301104_1", 1, self.OnAfterBattleStart)
end

function bs_301104:OnAfterBattleStart()
end

function bs_301104:OnCasterDie()
  base.OnCasterDie(self)
  if self.caster.roleDataId == 40030 then
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId1, self)
  end
end

return bs_301104

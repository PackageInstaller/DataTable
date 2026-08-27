local bs_16020 = class("bs_16020", LuaSkillBase)
local base = LuaSkillBase
bs_16020.config = {buff_skill = 111142}

function bs_16020:ctor()
end

function bs_16020:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_16020_1", 1, self.OnAfterBattleStart)
end

function bs_16020:OnAfterBattleStart()
  local list = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  for i = 0, list.Count - 1 do
    LuaSkillCtrl:CallBuff(self, list[i].targetRole, self.config.buff_skill, 1, nil, true)
  end
end

function bs_16020:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_16020

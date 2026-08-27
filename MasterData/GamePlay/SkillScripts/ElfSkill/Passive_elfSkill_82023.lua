local bs_82023 = class("bs_82023", LuaSkillBase)
local base = LuaSkillBase
bs_82023.config = {buff_ExSkill = 703}

function bs_82023:ctor()
end

function bs_82023:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_82023_1", 1, self.OnAfterBattleStart)
end

function bs_82023:OnAfterBattleStart()
  local highAttRole = LuaSkillCtrl:CallTargetSelect(self, 80, 20)
  if highAttRole ~= nil and highAttRole.Count > 0 and highAttRole[0] ~= nil then
    LuaSkillCtrl:CallBuff(self, highAttRole[0].targetRole, self.config.buff_ExSkill, 1, nil, true)
  end
end

function bs_82023:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_82023

local bs_20107 = class("bs_20107", LuaSkillBase)
local base = LuaSkillBase
bs_20107.config = {buffId = 1210}

function bs_20107:ctor()
end

function bs_20107:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_20107_1", 1, self.OnAfterBattleStart)
end

function bs_20107:OnAfterBattleStart()
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  if targetlist.Count <= 0 then
    return
  end
  for i = 0, targetlist.Count - 1 do
    local targetRole = targetlist[i].targetRole
    if targetRole.belongNum ~= 0 then
      LuaSkillCtrl:CallBuff(self, targetRole, self.config.buffId, 1, 15, true)
    end
  end
end

function bs_20107:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20107

local bs_30049 = class("bs_30049", LuaSkillBase)
local base = LuaSkillBase
bs_30049.config = {buffId = 110008}

function bs_30049:ctor()
end

function bs_30049:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_30049_1", 1, self.OnAfterBattleStart)
end

function bs_30049:OnAfterBattleStart(isMidway)
  if not isMidway then
    return
  end
  if self.caster == nil then
    return
  end
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 6, 50)
  if targetList == nil or targetList.Count < 1 then
    return
  end
  for i = 0, targetList.Count - 1 do
    LuaSkillCtrl:CallBuff(self, targetList[i].targetRole, self.config.buffId, 1, nil)
  end
end

function bs_30049:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_30049

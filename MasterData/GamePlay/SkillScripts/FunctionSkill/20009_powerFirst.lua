local bs_20009 = class("bs_20009", LuaSkillBase)
local base = LuaSkillBase
bs_20009.config = {buffId = 1098}

function bs_20009:ctor()
end

function bs_20009:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_20009_1", 1, self.OnAfterBattleStart)
end

function bs_20009:OnAfterBattleStart()
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
  if targetList.Count > 0 then
    for i = 0, targetList.Count - 1 do
      local target = targetList[i].targetRole
      if target.career ~= 5 then
        LuaSkillCtrl:CallBuff(self, target, self.config.buffId, 1, nil, true)
      end
    end
  end
end

function bs_20009:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20009

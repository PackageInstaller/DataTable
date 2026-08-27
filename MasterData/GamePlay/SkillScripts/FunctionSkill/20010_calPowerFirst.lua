local bs_20010 = class("bs_20010", LuaSkillBase)
local base = LuaSkillBase
bs_20010.config = {buffId = 1099}

function bs_20010:ctor()
end

function bs_20010:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_20010_1", 1, self.OnAfterBattleStart)
end

function bs_20010:OnAfterBattleStart()
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

function bs_20010:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20010

local bs_20067 = class("bs_20067", LuaSkillBase)
local base = LuaSkillBase
bs_20067.config = {buffId = 1166}

function bs_20067:ctor()
end

function bs_20067:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_20067_1", 1, self.OnAfterBattleStart)
  LuaSkillCtrl:StartTimer(nil, 150, function()
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 5, 0)
    if targetList ~= nil and 0 < targetList.Count then
      for i = 0, targetList.Count - 1 do
        local target = targetList[i].targetRole
        if 0 < target.intensity then
          LuaSkillCtrl:CallBuff(self, target, self.config.buffId, 1, nil, true)
        end
      end
    end
  end)
end

function bs_20067:OnAfterBattleStart()
end

function bs_20067:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20067

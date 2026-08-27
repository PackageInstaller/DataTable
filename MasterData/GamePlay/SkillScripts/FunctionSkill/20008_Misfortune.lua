local bs_20008 = class("bs_20008", LuaSkillBase)
local base = LuaSkillBase
bs_20008.config = {formula = 10106}

function bs_20008:ctor()
end

function bs_20008:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_20008_1", 1, self.OnAfterBattleStart)
  LuaSkillCtrl:StartTimer(nil, 150, function()
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 5, 0)
    if targetList ~= nil and 0 < targetList.Count then
      for i = 0, targetList.Count - 1 do
        local target = targetList[i].targetRole
        if 0 < target.intensity then
          local hurt = LuaSkillCtrl:CallFormulaNumberWithSkill(self.config.formula, self.caster, target, self)
          LuaSkillCtrl:RemoveLife(hurt, self, target, true, nil, true, false, eHurtType.RealDmg)
        end
      end
    end
  end)
end

function bs_20008:OnAfterBattleStart()
end

function bs_20008:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20008

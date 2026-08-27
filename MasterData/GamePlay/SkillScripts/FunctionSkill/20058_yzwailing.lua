local bs_20058 = class("bs_20058", LuaSkillBase)
local base = LuaSkillBase
bs_20058.config = {}

function bs_20058:ctor()
end

function bs_20058:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_20058_1", 1, self.OnAfterBattleStart)
end

function bs_20058:OnAfterBattleStart()
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  if targetlist.Count > 0 then
    for i = 0, targetlist.Count - 1 do
      local targetRole = targetlist[i].targetRole
      if targetRole.belongNum ~= 0 then
        local hurt = math.max(1, targetRole.maxHp * 3 // 10)
        LuaSkillCtrl:RemoveLife(hurt, self, targetRole, true, nil, true, false, eHurtType.RealDmg)
      end
    end
  end
end

function bs_20058:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20058

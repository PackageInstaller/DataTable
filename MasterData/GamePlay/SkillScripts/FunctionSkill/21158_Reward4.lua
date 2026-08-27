local bs_21158 = class("bs_21158", LuaSkillBase)
local base = LuaSkillBase
bs_21158.config = {buffId = 110033}

function bs_21158:ctor()
end

function bs_21158:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_21158_1", 1, self.OnAfterBattleStart)
end

function bs_21158:OnAfterBattleStart()
  local targetlist = LuaSkillCtrl:CallTargetSelectWithRange(self, 6, 1)
  if targetlist.Count > 0 then
    for i = 0, targetlist.Count - 1 do
      if targetlist[i].targetRole ~= self.caster and LuaSkillCtrl:IsRoleAdjacent(targetlist[i].targetRole, self.caster) then
        LuaSkillCtrl:CallBuff(self, targetlist[i].targetRole, self.config.buffId, 1, nil)
      end
    end
  end
end

function bs_21158:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_21158

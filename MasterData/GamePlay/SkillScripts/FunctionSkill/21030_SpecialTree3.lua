local bs_21030 = class("bs_21030", LuaSkillBase)
local base = LuaSkillBase
bs_21030.config = {buffId = 110021}

function bs_21030:ctor()
end

function bs_21030:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_21030_1", 1, self.OnAfterBattleStart)
end

function bs_21030:OnAfterBattleStart()
  local targetList
  local Num = 0
  targetList = LuaSkillCtrl:CallTargetSelectWithRange(self, 9, 1)
  if 1 <= targetList.Count then
    for i = 0, targetList.Count - 1 do
      if targetList[i].targetRole.belongNum == 0 and targetList[i].targetRole.intensity == 0 then
        Num = Num + 1
      end
    end
  end
  if 2 <= Num then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1)
    self.caster:UpdateHp()
  end
end

function bs_21030:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_21030

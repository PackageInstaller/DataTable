local bs_91020 = class("bs_91020", LuaSkillBase)
local base = LuaSkillBase
bs_91020.config = {buffId1 = 2031}

function bs_91020:ctor()
end

function bs_91020:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_91020_1", 1, self.OnAfterBattleStart)
  self.hp_value = 0
  self.highHpTarget = nil
end

function bs_91020:OnAfterBattleStart()
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 69, 10)
  if targetList.Count > 0 then
    self.highHpTarget = targetList[0].targetRole
    self.hp_value = targetList[0].targetRole.maxHp * self.arglist[1] * self.arglist[2] // 1000000
    LuaSkillCtrl:CallBuff(self, self.highHpTarget, self.config.buffId1, 1)
    self.highHpTarget:UpdateHp()
    self:PlayChipEffect()
  end
  local targetListAll = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
  if targetListAll.Count > 0 then
    for i = 0, targetListAll.Count - 1 do
      local targetRole = targetListAll[i].targetRole
      if targetRole ~= self.highHpTarget and targetRole.roleType ~= eBattleRoleType.realSummoner then
        LuaSkillCtrl:CallAddRoleProperty(targetRole, eHeroAttr.maxHp, self.hp_value, eHeroAttrType.Extra)
        targetRole:UpdateHp()
      end
    end
  end
end

function bs_91020:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_91020

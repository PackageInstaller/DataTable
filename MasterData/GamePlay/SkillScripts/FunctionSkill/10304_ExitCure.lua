local bs_10304 = class("bs_10304", LuaSkillBase)
local base = LuaSkillBase
bs_10304.config = {effectId = 10286}

function bs_10304:ctor()
end

function bs_10304:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10304_1", 1, self.OnAfterBattleStart)
end

function bs_10304:OnAfterBattleStart(isMidway)
  if isMidway and self.caster ~= nil then
    self:PlayChipEffect()
    LuaSkillCtrl:AddPlayerTowerMp(self.arglist[1])
  end
end

function bs_10304:OnCasterDie()
  if self.caster == nil then
    return
  end
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 52, 20, self.caster)
  if targetlist.Count < 1 then
    return
  end
  self:PlayChipEffect()
  local target = targetlist[0].targetRole
  local cureNum = target.maxHp * self.arglist[2] // 1000
  LuaSkillCtrl:CallEffect(targetlist[0].targetRole, self.config.effectId, self)
  LuaSkillCtrl:CallHeal(cureNum, self, target)
  base.OnCasterDie(self)
end

return bs_10304

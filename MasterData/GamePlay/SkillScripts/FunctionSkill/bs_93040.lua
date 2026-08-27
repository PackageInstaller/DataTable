local bs_93040 = class("bs_93040", LuaSkillBase)
local base = LuaSkillBase
bs_93040.config = {buffId = 2073}

function bs_93040:ctor()
end

function bs_93040:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_93040_1", 1, self.OnBattleStart)
end

function bs_93040:OnBattleStart()
  local value = LuaSkillCtrl:GetCacheGold() // self.arglist[1]
  local target1 = self:findMaxPow()
  local target2 = self:findMaxMagic()
  LuaSkillCtrl:CallBuff(self, target1.targetRole, self.config.buffId, 1, nil, false)
  LuaSkillCtrl:CallBuff(self, target2.targetRole, self.config.buffId, 1, nil, false)
end

function bs_93040:findMaxPow()
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 59, 10)
  local target
  local i = 0
  while target == nil or target.targetRole.roleType ~= eBattleRoleType.character do
    target = targetList[i]
    i = i + 1
  end
  return target
end

function bs_93040:findMaxMagic()
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 64, 10)
  local target
  local i = 0
  while target == nil or target.targetRole.roleType ~= eBattleRoleType.character do
    target = targetList[i]
    i = i + 1
  end
  return target
end

function bs_93040:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_93040

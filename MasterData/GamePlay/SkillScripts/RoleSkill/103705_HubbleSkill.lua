local bs_103704 = require("GamePlay.SkillScripts.RoleSkill.103704_HubbleSkill")
local bs_103705 = class("bs_103705", bs_103704)
local base = bs_103704
bs_103705.config = {
  weaponLv = 2,
  HurtConfig1 = 36,
  select_Id = 42
}
bs_103705.config = setmetatable(bs_103705.config, {
  __index = base.config
})

function bs_103705:ctor()
end

function bs_103705:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_103705:SkillEventFunc(effect, eventId, target)
  local skillrange = self.arglist[3]
  local Targetgrid = LuaSkillCtrl:GetTargetWithGrid(target.x, target.y)
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:StartTimer(nil, 11, function()
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      local countNum1 = self:CountNum(target, skillrange, eBattleRoleBelong.enemy, self.arglist[5])
      local dam1 = self.arglist[1] + countNum1 * self.arglist[4]
      LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfig1, {dam1})
      skillResult:EndResult()
    end, nil)
    LuaSkillCtrl:StartTimer(nil, 8, function()
      local targetnum = 0
      local countNum2 = self:CountNum(target, skillrange, eBattleRoleBelong.enemy, self.arglist[5])
      if countNum2 == 0 and 0 < target.targetRole.hp then
        self:OnAttackTrigger2(target, skillrange)
      else
        local targetList = LuaSkillCtrl:FindAllRolesWithinRange(Targetgrid, skillrange, false)
        for i = 0, targetList.Count - 1 do
          local tar = targetList[i]
          if tar ~= nil and tar ~= target and tar.belongNum == eBattleRoleBelong.enemy and not LuaSkillCtrl:RoleContainsBuffFeature(tar, eBuffFeatureType.NotBeSelected) then
            self:OnAttackTrigger2(tar, skillrange)
            targetnum = targetnum + 1
            break
          end
        end
        if 0 < countNum2 and 0 < target.targetRole.hp and targetnum == 0 then
          self:OnAttackTrigger2(target, skillrange)
        end
      end
    end, nil)
  end
end

function bs_103705:OnAttackTrigger2(target, skillrange)
  LuaSkillCtrl:PlayAuSource(target, self.config.audioId2)
  LuaSkillCtrl:CallEffectWithArg(target, self.config.effectId_skill, self, false, false, self.secondMeteorite, target, skillrange)
end

function bs_103705:secondMeteorite(target, skillrange, effect, eventId)
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:StartTimer(nil, 11, function()
      self.mainTarget = target
      local countNum2 = self:CountNum(target, skillrange, eBattleRoleBelong.enemy, self.arglist[5])
      local dam2 = (self.arglist[1] + countNum2 * self.arglist[4]) * self.arglist[6] // 1000
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfig1, {dam2})
      skillResult:EndResult()
      LuaSkillCtrl:StartTimer(nil, 1, function()
        self:OnSkillDamageEnd()
      end, nil)
    end, nil)
  end
end

function bs_103705:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_103705

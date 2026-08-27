local bs_108708 = class("bs_108708", LuaSkillBase)
local base = LuaSkillBase
bs_108708.config = {
  Role_id = 1087,
  buff_1 = 108708,
  effect_1 = 108707,
  effect_2 = 108711,
  hurtConfig = 55
}

function bs_108708:ctor()
end

function bs_108708:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_108708_01", 1, self.OnAfterBattleStart)
end

function bs_108708:OnAfterBattleStart()
  local caster = LuaSkillCtrl:GetOriginRole(self.config.Role_id)
  self.skillCasterTemp = caster
  if caster == nil or not caster.roleOnBench then
    return
  end
  self:AddHurtResultStartTrigger("bs_108708_2", 40, self.OnHurtResultStart, self.caster, nil, nil, eBattleRoleBelong.enemy, nil, nil, 108708)
  local ReduceTime = caster.crit // self.caster.recordTable.OliviaSkillArg9 * 15
  if ReduceTime > self.caster.recordTable.OliviaSkillArg10 then
    ReduceTime = self.caster.recordTable.OliviaSkillArg10
  end
  local cdNum = self.caster.recordTable.OliviaSkillArg5 - ReduceTime
  self.casterPow = caster.pow
  self.passive = LuaSkillCtrl:StartTimer(nil, cdNum, self.Callback, self, -1)
end

function bs_108708:Callback(data)
  local powTarget = LuaSkillCtrl:CallTargetSelect(self, 31, 20)
  local targetRole = powTarget[0].targetRole.recordTable.lastAttackRole
  if targetRole == nil or 0 >= targetRole.hp then
    local tempList = LuaSkillCtrl:CallTargetSelect(self, 19, 20)
    if tempList ~= nil and 0 < tempList.Count then
      targetRole = tempList[0].targetRole
    end
  end
  if targetRole == nil or 0 > targetRole.hp then
    return
  end
  LuaSkillCtrl:CallEffect(self.skillCasterTemp, self.config.effect_2, self)
  LuaSkillCtrl:CallEffectWithArgOverride(targetRole, self.config.effect_1, self, self.skillCasterTemp, nil, false, self.SkillEventFunc)
end

function bs_108708:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    target.targetRole:AddRoleProperty(eHeroAttr.def, -self.caster.recordTable.OliviaSkillArg7, eHeroAttrType.Ratio)
    LuaSkillCtrl:CallBuff(self, target.targetRole, self.config.buff_1, 1, self.arglist[4])
    LuaSkillCtrl:StartTimer(nil, self.caster.recordTable.OliviaSkillArg8, function()
      target.targetRole:AddRoleProperty(eHeroAttr.def, self.caster.recordTable.OliviaSkillArg7, eHeroAttrType.Ratio)
      LuaSkillCtrl:DispelBuff(target.targetRole, self.config.buff_1, 1)
    end, nil)
    local damageNum = self.casterPow * self.caster.recordTable.OliviaSkillArg6 // 1000
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.hurtConfig, {damageNum})
    skillResult:EndResult()
  end
end

function bs_108708:OnHurtResultStart(skill, context)
  if self.skillCasterTemp ~= nil then
    context.sender = self.skillCasterTemp
  end
end

function bs_108708:LuaDispose()
  base.LuaDispose(self)
  if self.passive ~= nil then
    self.passive:Stop()
    self.passive = nil
  end
  self.skillCasterTemp = nil
end

function bs_108708:OnCasterDie()
  base.OnCasterDie(self)
  if self.passive ~= nil then
    self.passive:Stop()
    self.passive = nil
  end
end

return bs_108708

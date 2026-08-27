local bs_305 = class("bs_305", LuaSkillBase)
local base = LuaSkillBase
bs_305.config = {effectId = 10137, buffId = 66}

function bs_305:ctor()
end

function bs_305:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_305:PlaySkill(data)
  self.monsterRecord = {}
  local targetListall = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  if targetListall.Count == 0 then
    return
  end
  for i = 0, targetListall.Count - 1 do
    self.monsterRecord[targetListall[i].targetRole] = 0
  end
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 1001, 10)
  if targetList.Count == 0 then
    return
  end
  self.caster:LookAtTarget(targetList[0].targetRole)
  self:CallCasterWait(30)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, targetList[0].targetRole, data)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, 1002, 1, 20, attackTrigger)
end

function bs_305:OnAttackTrigger(target, data)
  self.caster.recordTable["305_Time"] = 4
  LuaSkillCtrl:CallEffectWithArgOverride(target, self.config.effectId, self, nil, true, false, self.SkillEventFunc)
end

function bs_305:SkillEventFunc(effect, eventId, target)
  if effect.dataId == self.config.effectId and eventId == eBattleEffectEvent.Trigger and self.caster.recordTable["305_Time"] > 0 then
    local hurt = self.caster.pow * (self.arglist[1] - self.arglist[2] * (self.arglist[4] - self.caster.recordTable["305_Time"])) // 1000
    LuaSkillCtrl:RemoveLife(hurt, self, target)
    if self.caster.recordTable["305_Time"] == self.arglist[4] and 0 <= self.arglist[3] then
      LuaSkillCtrl:CallBuff(self, target.targetRole, 66, 1, 15)
    end
    self.caster.recordTable["305_Time"] = self.caster.recordTable["305_Time"] - 1
    self.monsterRecord[target.targetRole] = self.monsterRecord[target.targetRole] + 1
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 34, 2, target.targetRole)
    if targetList.Count == 0 then
      return
    end
    local targetRole
    for i = 0, targetList.Count - 1 do
      if 2 > self.monsterRecord[targetList[i].targetRole] then
        targetRole = targetList[i].targetRole
        break
      end
    end
    if targetRole ~= nil then
      LuaSkillCtrl:CallEffectWithArgOverride(targetRole, self.config.effectId, self, target.targetRole, true, false, self.SkillEventFunc)
    end
  end
end

function bs_305:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_305:LuaDispose()
  base.LuaDispose(self)
  self.monsterRecord = nil
end

return bs_305

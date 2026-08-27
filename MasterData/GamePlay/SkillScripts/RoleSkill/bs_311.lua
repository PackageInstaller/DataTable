local bs_311 = class("bs_311", LuaSkillBase)
local base = LuaSkillBase
bs_311.config = {
  effectId7 = 10148,
  effectId6 = 10147,
  effectId5 = 10146,
  effectId4 = 10145,
  effectId3 = 10144,
  effectId2 = 10143,
  effectId1 = 10142,
  effectId0 = 10149
}

function bs_311:ctor()
end

function bs_311:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_311:PlaySkill(data)
  self.caster.recordTable["311_FQ"] = 7
  self.monsterRecord = {}
  local targetListall = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  if targetListall.Count == 0 then
    return
  end
  for i = 0, targetListall.Count - 1 do
    self.monsterRecord[targetListall[i].targetRole] = 0
  end
  self:CallCasterWait(30)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, data)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, 1002, 1, 20, attackTrigger)
end

function bs_311:OnAttackTrigger(data)
  local effectconfig = self.config["effectId" .. tostring(self.caster.recordTable["311_FQ"])]
  LuaSkillCtrl:CallEffect(self.caster, effectconfig, self)
  LuaSkillCtrl:StartTimer(self, 7, self.callback, self, 6, 0)
end

function bs_311:callback()
  if self.caster.recordTable["311_FQ"] > 0 then
    self.caster.recordTable["311_FQ"] = self.caster.recordTable["311_FQ"] - 1
    local effectconfig = self.config["effectId" .. tostring(self.caster.recordTable["311_FQ"])]
    LuaSkillCtrl:CallEffect(self.caster, effectconfig, self)
  end
  local targetListR = LuaSkillCtrl:CallTargetSelect(self, 19, 10)
  if targetListR.Count ~= nil then
    LuaSkillCtrl:CallEffect(targetListR[0].targetRole, self.config.effectId0, self, self.SkillEventFunc)
  end
end

function bs_311:SkillEventFunc(effect, eventId, target)
  if effect.dataId == self.config.effectId0 and eventId == eBattleEffectEvent.Trigger then
    if self.monsterRecord[target.targetRole] > 1 and self.arglist[3] >= 0 then
      LuaSkillCtrl:RemoveLife(self.caster.pow * self.arglist[2] // 1000 * 130 // 100, self, target.targetRole)
    else
      LuaSkillCtrl:RemoveLife(self.caster.pow * self.arglist[2] // 1000, self, target.targetRole)
    end
    self.monsterRecord[target.targetRole] = self.monsterRecord[target.targetRole] + 1
  end
end

function bs_311:LuaDispose()
  base.LuaDispose(self)
  self.monsterRecord = nil
end

function bs_311:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_311

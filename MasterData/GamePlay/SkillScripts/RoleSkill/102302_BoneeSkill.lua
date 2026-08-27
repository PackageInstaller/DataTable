local bs_102302 = class("bs_102302", LuaSkillBase)
local base = LuaSkillBase
bs_102302.config = {
  effectId_Line = 102304,
  effectId_LineEnd = 102305,
  initHpKey = "102302_InitHp",
  action1 = 1002,
  buffId_willowpic = 102901,
  buffId_Defup = 102301,
  actionId = 1002,
  action_speed = 1,
  skill_time = 15,
  start_time = 14,
  selectId = 24,
  selectRange = 10,
  audioId1 = 239,
  audioId2 = 240
}

function bs_102302:ctor()
end

function bs_102302:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.effect = {}
  self.realTarget = nil
end

function bs_102302:PlaySkill(data)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, self.config.selectId, self.config.selectRange)
  if targetList.Count == 0 then
    LuaSkillCtrl:SetResetCdByReturnConfigOnce(self)
    return
  end
  if not LuaSkillCtrl:GetRoleBuffById(targetList[0].targetRole, self.config.buffId_willowpic) then
    self.realTarget = targetList[0].targetRole
  else
    self.realTarget = targetList[1].targetRole
  end
  self:CallCasterWait(self.config.skill_time)
  if self.realTarget ~= nil then
    local attackTrigger = BindCallback(self, self.OnAttackTrigger, self.realTarget)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.start_time, attackTrigger)
    LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId1)
    LuaSkillCtrl:StartTimer(self, 7, function()
      LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_Line, self, nil, nil, nil, true)
    end)
  end
end

function bs_102302:OnAttackTrigger(target)
  LuaSkillCtrl:CallEffectWithArg(target, self.config.effectId_LineEnd, self, false, false, self.SkillEventFunc, target)
end

function bs_102302:SkillEventFunc(target_role, effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:PlayAuSource(target, self.config.audioId2)
    local shieldValue = self.caster.skill_intensity * self.arglist[1] // 1000
    if target_role == self.caster then
      shieldValue = shieldValue * 2
    end
    if 0 < shieldValue then
      local targetRole = target_role
      LuaSkillCtrl:AddRoleShield(targetRole, eShieldType.Normal, shieldValue)
      if target_role == self.caster then
        LuaSkillCtrl:CallBuff(self, target_role, self.config.buffId_Defup, 2, self.arglist[2])
      else
        LuaSkillCtrl:CallBuff(self, target_role, self.config.buffId_Defup, 1, self.arglist[2])
      end
    end
  end
end

function bs_102302:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_102302

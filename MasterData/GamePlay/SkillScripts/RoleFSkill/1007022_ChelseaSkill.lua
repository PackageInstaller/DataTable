local bs_1007022 = class("bs_1007022", LuaSkillBase)
local base = LuaSkillBase
bs_1007022.config = {
  skill_time = 31,
  start_time = 15,
  actionId = 1002,
  action_speed = 1,
  Aoe_advance = {
    effect_shape = 3,
    aoe_select_code = 4,
    aoe_range = 2
  },
  HurtConfig = {
    hit_formula = 0,
    basehurt_formula = 3000,
    crit_formula = 0,
    crithur_ratio = 0
  },
  buffId_Back = 3007,
  buffId_Stun = 3006,
  effectId_hit = 100705,
  effectId_advance = 100704
}

function bs_1007022:ctor()
end

function bs_1007022:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_1007022:PlaySkill(data)
  local range = self.config.Aoe_advance
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_advance, self)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, range)
  self:CallCasterWait(self.config.skill_time)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.start_time, attackTrigger)
end

function bs_1007022:OnAttackTrigger(range)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster, range)
  if skillResult.roleList.Count > 0 then
    for i = 0, skillResult.roleList.Count - 1 do
      LuaSkillCtrl:CallEffect(skillResult.roleList[i], self.config.effectId_hit, self)
      if LuaSkillCtrl:IsAbleAttackTarget(self.caster, skillResult.roleList[i], 1) then
        local targetX = skillResult.roleList[i].x
        local targetY = skillResult.roleList[i].y
        local buffCheck = LuaSkillCtrl:CallBuff(self, skillResult.roleList[i], self.config.buffId_Back, 1, 3)
        if buffCheck ~= nil and skillResult.roleList[i].x == targetX and skillResult.roleList[i].y == targetY then
          LuaSkillCtrl:CallBuff(self, skillResult.roleList[i], self.config.buffId_Stun, 1, self.arglist[2])
        end
      end
    end
  end
  LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {
    self.arglist[1]
  })
  skillResult:EndResult()
  self:CancleCasterWait()
end

function bs_1007022:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_1007022

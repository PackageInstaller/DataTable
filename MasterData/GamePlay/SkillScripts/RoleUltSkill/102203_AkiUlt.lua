local bs_102203 = class("bs_102203", LuaSkillBase)
local base = LuaSkillBase
bs_102203.config = {
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 3000,
    def_formula = 9996,
    minhurt_formula = 9994,
    crit_formula = 0,
    crithur_ratio = 9995,
    correct_formula = 9989,
    lifesteal_formula = 1001,
    spell_lifesteal_formula = 1002,
    returndamage_formula = 1000,
    hurt_type = -1
  },
  effectId_Ult = 102201,
  select_Id = 45,
  selectRange = 10,
  audioIdStart = 102201,
  audioIdMovie = 102202,
  audioId_hit = 102203
}

function bs_102203:ctor()
end

function bs_102203:InitSkill(isMidwaySkill)
  self.hurteffect = nil
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_102203_1", 10, self.OnRoleDie)
end

function bs_102203:PlaySkill(data, selectTargetCoord, selectRoles, SelectRolesType)
  self:CallCasterWait(20)
  if selectTargetCoord ~= nil then
    local inputTarget = LuaSkillCtrl:GetTargetWithGrid(selectTargetCoord.x, selectTargetCoord.y)
    self.caster:LookAtTarget(inputTarget)
  end
  return self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute), SelectRolesType)
end

function bs_102203:CallSelectExecute(role)
  self:Hurt(role, self.caster)
  LuaSkillCtrl:StartTimer(self, 15, function()
    LuaSkillCtrl:CallRoleAction(self.caster, 100)
  end)
end

function bs_102203:Hurt(role, caster)
  if role ~= nil then
    LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId_hit)
    self.hurteffect = LuaSkillCtrl:CallEffectWithArgOverride(role, self.config.effectId_Ult, self, caster, false, nil, self.SkillEventFunc)
  end
end

function bs_102203:OnRoleDie(killer, role)
  if role == self.target_skill and role.hp == 0 and role ~= nil then
    if self.hurteffect ~= nil then
      self.hurteffect:Die()
      self.hurteffect = nil
    end
    LuaSkillCtrl:StartTimer(self, 5, function()
      local target = LuaSkillCtrl:CallTargetSelect(self, self.config.select_Id, 10)
      if target.Count > 0 then
        local role_new = target[0].targetRole
        self:Hurt(role_new, role)
      end
    end)
  end
end

function bs_102203:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    self.target_skill = target.targetRole
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    local num = (target.targetRole.maxHp - target.targetRole.hp) * 1000 // target.targetRole.maxHp // self.arglist[2] * self.arglist[3]
    local prob = self.arglist[1] * (1000 + num) // 1000
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {prob}, false)
    skillResult:EndResult()
    if target.hp ~= 0 then
      self.target_skill = nil
    end
  end
end

function bs_102203:PlayUltEffect()
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_102203:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005, 1)
end

function bs_102203:OnSkipUltView()
  base.OnSkipUltView(self)
end

function bs_102203:OnMovieFadeOut()
  LuaSkillCtrl:CallRoleAction(self.caster, 1006)
  self:RemoveSkillTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut)
  LuaSkillCtrl:CallBackViewTimeLine(self.caster, true)
  base.OnMovieFadeOut(self)
end

function bs_102203:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_102203:LuaDispose()
  base.LuaDispose(self)
  self.hurteffect = nil
end

return bs_102203

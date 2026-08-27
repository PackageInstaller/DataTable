local bs_104703 = class("bs_104703", LuaSkillBase)
local base = LuaSkillBase
bs_104703.config = {
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
  buffId_Speed = 104702,
  effectId_UltID = 104705,
  effectId_hit = 104706,
  movieEndRoleActionId = 1006,
  selectId = 6,
  selectRange = 10,
  audioIdStart = 104707,
  audioIdMovie = 104708,
  audioIdEnd = 104709,
  audioId_Hit = 101211
}

function bs_104703:ctor()
end

function bs_104703:InitSkill(isMidwaySkill)
end

function bs_104703:PlaySkill(data, selectTargetCoord, selectRoles)
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CallCasterWait(8)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  if selectTargetCoord ~= nil then
    local inputTarget = LuaSkillCtrl:GetTargetWithGrid(selectTargetCoord.x, selectTargetCoord.y)
    self.caster:LookAtTarget(inputTarget)
    LuaSkillCtrl:StartTimer(nil, 3, BindCallback(self, self.zhongzhuan, selectRoles, inputTarget), nil, 0)
  end
end

function bs_104703:zhongzhuan(selectRoles, inputTarget)
  self.caster:LookAtTarget(inputTarget)
  self:CallSkillExecute(selectRoles)
  LuaSkillCtrl:CallEffect(inputTarget, self.config.effectId_UltID, self, self.SkillEventFunc)
end

function bs_104703:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Die then
    local targetList = LuaSkillCtrl:CallTargetSelect(self, self.config.selectId, self.config.selectRange)
    if targetList ~= 0 then
      for i = 0, targetList.Count - 1 do
        LuaSkillCtrl:CallBuff(self, targetList[i].targetRole, self.config.buffId_Speed, 1, self.arglist[4], false)
      end
    end
  end
end

function bs_104703:CallSkillExecute(selectRoles)
  self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute))
end

function bs_104703:CallSelectExecute(role)
  if role == nil or role.hp <= 0 then
    return
  end
  if role.belongNum ~= self.caster.belongNum then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {
      self.arglist[1]
    }, false)
    LuaSkillCtrl:CallEffect(role, self.config.effectId_hit, self)
    LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId_Hit)
    skillResult:EndResult()
  end
end

function bs_104703:PlayUltEffect()
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_104703:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005, 1)
end

function bs_104703:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

function bs_104703:LuaDispose()
  base.LuaDispose(self)
  self.timer = nil
end

return bs_104703

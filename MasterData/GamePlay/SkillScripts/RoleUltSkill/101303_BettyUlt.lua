local bs_101303 = class("bs_101303", LuaSkillBase)
local base = LuaSkillBase
bs_101303.config = {
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 3000,
    crit_formula = 0,
    returndamage_formula = 0
  },
  effectId = 101307,
  buffId = 195,
  audioIdStart = 101306,
  audioIdMovie = 101307,
  audioIdEnd = 101308,
  movieEndRoleActionId = 1006
}

function bs_101303:ctor()
end

function bs_101303:InitSkill(isMidwaySkill)
end

function bs_101303:PlaySkill(data, selectTargetCoord, selectRoles)
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CallCasterWait(13)
  LuaSkillCtrl:StartTimer(nil, 3, BindCallback(self, self.CallSkillExecute, selectRoles))
  if selectTargetCoord ~= nil then
    local inputTarget = LuaSkillCtrl:GetTargetWithGrid(selectTargetCoord.x, selectTargetCoord.y)
    self.caster:LookAtTarget(inputTarget)
    self.caster.recordTable.lastAttackRole = nil
    LuaSkillCtrl:CallEffect(inputTarget, self.config.effectId, self)
  end
end

function bs_101303:CallSkillExecute(selectRoles)
  self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute))
end

function bs_101303:CallSelectExecute(role)
  if role ~= nil and role.belongNum ~= self.caster.belongNum and not role:IsUnSelect(self.caster) then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {
      self.arglist[1]
    })
    skillResult:EndResult()
    LuaSkillCtrl:CallBuff(self, role, self.config.buffId, self.arglist[2], self.arglist[3])
  end
end

function bs_101303:PlayUltEffect()
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_101303:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie, self)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005)
end

function bs_101303:OnSkipUltView()
  base.OnSkipUltView(self)
end

function bs_101303:OnMovieFadeOut()
  base.OnMovieFadeOut(self)
end

function bs_101303:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_101303

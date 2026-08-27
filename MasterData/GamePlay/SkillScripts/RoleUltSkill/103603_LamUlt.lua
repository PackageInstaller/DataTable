local bs_103603 = class("bs_103603", LuaSkillBase)
local base = LuaSkillBase
bs_103603.config = {
  hurt_config = {hit_formula = 0, basehurt_formula = 3024},
  effectId_startEffect = 10311,
  effectId_mainEffect = 10312,
  audioIdStart = 114,
  audioIdMovie = 115,
  audioIdEnd = 116,
  movieEndRoleActionId = 1006
}

function bs_103603:ctor()
end

function bs_103603:InitSkill(isMidwaySkill)
  self.hurt_config = {}
end

function bs_103603:PlaySkill(data, selectTargetCoord, selectRoles)
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CallCasterWait(13)
  if selectTargetCoord ~= nil then
    local inputTarget = LuaSkillCtrl:GetTargetWithGrid(selectTargetCoord.x, selectTargetCoord.y)
    self.caster:LookAtTarget(inputTarget)
    LuaSkillCtrl:CallRoleAction(self.caster, 1010)
    LuaSkillCtrl:StartTimer(self, 3, function()
      LuaSkillCtrl:CallRoleAction(self.caster, 1006)
      LuaSkillCtrl:CallEffect(inputTarget, self.config.effectId_mainEffect, self)
      self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute))
    end)
    self.caster.recordTable.lastAttackRole = nil
  end
end

function bs_103603:CallSelectExecute(role)
  if role ~= nil and role.belongNum ~= self.caster.belongNum and not role:IsUnSelect(self.caster) then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {
      self.arglist[1]
    })
    skillResult:EndResult()
  end
end

function bs_103603:PlayUltEffect()
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_103603:OnUltRoleAction()
  LuaSkillCtrl:StartTimerInUlt(self, 11, self.PlayUltMovie)
  base.OnUltRoleAction(self)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005)
end

function bs_103603:OnSkipUltView()
  base.OnSkipUltView(self)
end

function bs_103603:OnMovieFadeOut()
  base.OnMovieFadeOut(self)
end

function bs_103603:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_103603:LuaDispose()
  base.LuaDispose(self)
end

return bs_103603

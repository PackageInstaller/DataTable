local bs_102503 = class("bs_102503", LuaSkillBase)
local base = LuaSkillBase
bs_102503.config = {
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 3000,
    crit_formula = 0
  },
  effectId_start = 102501,
  effectId_end = 102502,
  effectId_hit = 102512,
  buff_fanhua = 102502,
  buffId_170 = 170,
  audioIdStart = 102501,
  audioIdMovie = 102502,
  audioIdEnd = 102503
}

function bs_102503:ctor()
end

function bs_102503:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_102503:PlaySkill(data, selectTargetCoord, selectRoles)
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CallCasterWait(13)
  LuaSkillCtrl:StartTimer(nil, 3, BindCallback(self, self.CallSkillExecute, selectRoles))
  if selectTargetCoord ~= nil then
    local inputTarget = LuaSkillCtrl:GetTargetWithGrid(selectTargetCoord.x, selectTargetCoord.y)
    self.caster:LookAtTarget(inputTarget)
    local buff_fanhua = LuaSkillCtrl:GetRoleBuffById(self.caster, self.config.buff_fanhua)
    if buff_fanhua ~= nil then
      local duration = buff_fanhua.curDurationTime
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff_fanhua, 1, duration + self.arglist[2], true)
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_170, 1, duration + self.arglist[2], true)
      LuaSkillCtrl:StopShowSkillDurationTime(self)
      LuaSkillCtrl:StartShowSkillDurationTime(self, duration + self.arglist[2])
    end
    LuaSkillCtrl:StartTimer(self, 12, function()
      LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_start, self)
    end)
    LuaSkillCtrl:CallEffect(inputTarget, self.config.effectId_end, self)
  end
end

function bs_102503:CallSkillExecute(selectRoles)
  LuaSkillCtrl:StartTimer(self, 3, function()
    self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute))
  end)
end

function bs_102503:CallSelectExecute(role)
  if role ~= nil and role ~= nil and role.belongNum ~= self.caster.belongNum then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {
      self.arglist[1]
    })
    skillResult:EndResult()
    LuaSkillCtrl:CallEffect(role, self.config.effectId_hit, self)
  end
end

function bs_102503:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005, 1)
end

function bs_102503:PlayUltEffect()
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_102503:OnSkipUltView()
  base.OnSkipUltView(self)
end

function bs_102503:OnMovieFadeOut()
  LuaSkillCtrl:CallRoleAction(self.caster, 1006)
  LuaSkillCtrl:CallBackViewTimeLine(self.caster, true)
  base.OnMovieFadeOut(self)
end

function bs_102503:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_102503

local bs_103803 = class("bs_103803", LuaSkillBase)
local base = LuaSkillBase
bs_103803.config = {
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
  effectId_start = 103801,
  effectId_end = 103802,
  effectId_hit = 103803,
  buffId_195 = 195,
  audioIdStart = 103801,
  audioIdMovie = 103802,
  audioIdEnd = 103803
}

function bs_103803:ctor()
end

function bs_103803:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_103803:PlaySkill(data, selectTargetCoord, selectRoles)
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CallCasterWait(13)
  if selectTargetCoord ~= nil then
    local inputTarget = LuaSkillCtrl:GetTargetWithGrid(selectTargetCoord.x, selectTargetCoord.y)
    self.caster:LookAtTarget(inputTarget)
    LuaSkillCtrl:StartTimer(nil, 3, BindCallback(self, self.CallSkillExecute, selectRoles))
    LuaSkillCtrl:CallEffect(inputTarget, self.config.effectId_end, self)
  end
end

function bs_103803:CallSkillExecute(selectRoles)
  LuaSkillCtrl:StartTimer(self, 3, function()
    self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute))
  end)
end

function bs_103803:CallSelectExecute(role)
  if role ~= nil and role ~= nil and role.belongNum ~= self.caster.belongNum then
    local skillResult = LuaSkillCtrl:CallEffect(role, self.config.effectId_hit, self)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
    local prob = self.arglist[1]
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {prob}, false)
    skillResult:EndResult()
    local tier = LuaSkillCtrl:CallRange(self.arglist[2], self.arglist[3])
    LuaSkillCtrl:CallBuff(self, role, self.config.buffId_195, tier, self.arglist[4])
  end
end

function bs_103803:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005, 1)
end

function bs_103803:PlayUltEffect()
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_start, self)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_103803:OnSkipUltView()
  base.OnSkipUltView(self)
end

function bs_103803:OnMovieFadeOut()
  base.OnMovieFadeOut(self)
end

function bs_103803:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_103803

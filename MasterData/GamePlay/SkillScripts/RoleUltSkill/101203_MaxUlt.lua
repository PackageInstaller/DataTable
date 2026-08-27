local bs_101203 = class("bs_101203", LuaSkillBase)
local base = LuaSkillBase
bs_101203.config = {
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 3026,
    def_formula = 9996,
    minhurt_formula = 9994,
    crit_formula = 0,
    crithur_ratio = 9995,
    correct_formula = 9989,
    lifesteal_formula = 1001,
    spell_lifesteal_formula = 1002,
    returndamage_formula = 1000,
    hurt_type = 2
  },
  buffId_66 = 66,
  buffId1 = 101201,
  effectId_UltID = 101212,
  effectId_Hurt = 101213,
  effect_hit = 101214,
  movieEndRoleActionId = 1006,
  audioIdStart = 101207,
  audioIdMovie = 101208,
  audioIdEnd = 101209,
  audioId_Hit = 101211
}

function bs_101203:ctor()
end

function bs_101203:InitSkill(isMidwaySkill)
end

function bs_101203:PlaySkill(data, selectTargetCoord, selectRoles)
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CallCasterWait(8)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  if selectTargetCoord ~= nil then
    local inputTarget = LuaSkillCtrl:GetTargetWithGrid(selectTargetCoord.x, selectTargetCoord.y)
    self.caster:LookAtTarget(inputTarget)
    LuaSkillCtrl:StartTimer(nil, 3, BindCallback(self, self.zhongzhuan, selectRoles, inputTarget), nil, 0)
    LuaSkillCtrl:StartTimer(self, 7, function()
      LuaSkillCtrl:CallEffect(inputTarget, self.config.effectId_Hurt, self)
    end)
  end
end

function bs_101203:zhongzhuan(selectRoles, inputTarget)
  self.caster:LookAtTarget(inputTarget)
  self:CallSkillExecute(selectRoles)
  LuaSkillCtrl:CallEffect(inputTarget, self.config.effectId_UltID, self)
end

function bs_101203:CallSkillExecute(selectRoles)
  self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute))
end

function bs_101203:CallSelectExecute(role)
  if role == nil or role.hp <= 0 then
    return
  end
  if role.belongNum ~= self.caster.belongNum then
    local times = self.arglist[3] // 15 - 1
    self.timer = LuaSkillCtrl:StartTimer(nil, 15, function()
      if role == nil or role.hp <= 0 then
        if self.timer ~= nil then
          self.timer:Stop()
          self.timer = nil
        end
        return
      end
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
      LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {
        self.arglist[1]
      }, false)
      LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId_Hit)
      LuaSkillCtrl:CallBuff(self, role, self.config.buffId1, 1, self.arglist[3])
      LuaSkillCtrl:CallBuff(self, role, self.config.buffId_66, 1, self.arglist[2])
      skillResult:EndResult()
    end, self, times, 12)
  end
end

function bs_101203:PlayUltEffect()
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_101203:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005, 1)
end

function bs_101203:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

function bs_101203:LuaDispose()
  base.LuaDispose(self)
  self.timer = nil
end

return bs_101203

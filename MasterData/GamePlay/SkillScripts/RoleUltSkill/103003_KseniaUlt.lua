local bs_103003 = class("bs_103003", LuaSkillBase)
local base = LuaSkillBase
bs_103003.config = {
  effect_start = 103011,
  effect_loop = 103012,
  effect_hit = 103013,
  buff_AtkSpeed2 = 103002,
  shieldFormula = 3021,
  audioIdStart = 103005,
  audioIdMovie = 103006,
  audioIdEnd = 103007
}

function bs_103003:ctor()
end

function bs_103003:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.OnBreakShield, "bs_103003_1", 99, self.OnBreakShield)
  self.hudunEffect = {}
end

function bs_103003:PlaySkill(data, selectTargetCoord, selectRoles)
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CallCasterWait(20)
  self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute))
  self.realtarget = selectRoles[0]
end

function bs_103003:CallSelectExecute(role)
  if role ~= nil and role.belongNum == self.caster.belongNum then
    local shieldValue = self.caster.skill_intensity * self.arglist[1] // 1000
    if 0 < shieldValue then
      LuaSkillCtrl:AddRoleShield(role, eShieldType.Normal, shieldValue)
    end
    LuaSkillCtrl:StartTimer(self, 3, function()
      LuaSkillCtrl:CallEffect(role, self.config.effect_start, self, nil, nil, 1, true)
    end)
    LuaSkillCtrl:StartTimer(self, 7, function()
      if self.hudunEffect[role] == nil then
        self.hudunEffect[role] = LuaSkillCtrl:CallEffect(role, self.config.effect_loop, self, nil, nil, 1)
      end
      LuaSkillCtrl:CallBuff(self, role, self.config.buff_AtkSpeed2, 1, self.arglist[2], false)
    end)
  end
end

function bs_103003:OnBreakShield(shieldType, sender, target)
  if shieldType == 0 and target == self.realtarget then
    self:Onover(target)
  end
end

function bs_103003:Onover(target)
  if self.hudunEffect[target] ~= nil then
    local effect = self.hudunEffect[target]
    effect:Die()
    self.hudunEffect[target] = nil
  end
end

function bs_103003:PlayUltEffect(data, selectTargetCoord, selectRoles)
  if selectRoles == nil or selectRoles.Count <= 0 then
    return true
  end
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_103003:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie, self)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005)
end

function bs_103003:OnSkipUltView()
  base.OnSkipUltView(self)
end

function bs_103003:OnMovieFadeOut()
  base.OnMovieFadeOut(self)
end

function bs_103003:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_103003:LuaDispose()
  base.LuaDispose(self)
  self.hudunEffect = nil
end

return bs_103003

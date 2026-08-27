local bs_106803 = class("bs_106803", LuaSkillBase)
local base = LuaSkillBase
bs_106803.config = {
  HurtConfigID1 = 35,
  HurtConfigID2 = 34,
  HurtConfigID3 = 33,
  HurtConfigID4 = 36,
  effectId_loop_1 = 106812,
  effectId_loop_2 = 106813,
  effectId_loop_3 = 106814,
  effectId_loop_4 = 106823,
  buffId_critdamage = 106802,
  audioIdStart = 106809,
  audioIdMovie = 106810
}

function bs_106803:ctor()
end

function bs_106803:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.MapBorder = LuaSkillCtrl:GetMapBorder()
end

function bs_106803:PlaySkill(data)
  self.num = 0
  self:CallCasterWait(20)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005, 1)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, data)
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
  if self.loop_atk ~= nil then
    self.loop_atk:Stop()
    self.loop_atk = nil
  end
  if self.clearEffect ~= nil then
    self.clearEffect:Stop()
    self.clearEffect = nil
  end
  if self.MapBorder.x == 6 then
    local effectGrid = LuaSkillCtrl:GetTargetWithGrid(2, 2)
    self.effect = LuaSkillCtrl:CallEffect(effectGrid, self.config.effectId_loop_3, self)
  elseif self.MapBorder.x == 7 then
    local effectGrid = LuaSkillCtrl:GetTargetWithGrid(3, 2)
    self.effect = LuaSkillCtrl:CallEffect(effectGrid, self.config.effectId_loop_1, self)
  elseif self.MapBorder.x == 10 then
    local effectGrid = LuaSkillCtrl:GetTargetWithGrid(4, 2)
    self.effect = LuaSkillCtrl:CallEffect(effectGrid, self.config.effectId_loop_2, self)
  else
    local effectGrid = LuaSkillCtrl:GetTargetWithGrid(12, 8)
    self.effect = LuaSkillCtrl:CallEffect(effectGrid, self.config.effectId_loop_4, self)
  end
  LuaSkillCtrl:StartTimer(nil, 3, attackTrigger, self, nil)
  self.clearEffect = LuaSkillCtrl:StartTimer(nil, self.arglist[1], function()
    if self.effect ~= nil then
      self.effect:Die()
      self.effect = nil
    end
    if self.loop_atk ~= nil then
      self.loop_atk:Stop()
      self.loop_atk = nil
    end
  end, nil)
end

function bs_106803:OnAttackTrigger(data)
  local loop = BindCallback(self, self.loopattack)
  self.loop_atk = LuaSkillCtrl:StartTimer(nil, 15, loop, nil, 4, 10)
end

function bs_106803:loopattack()
  self.pow = math.max(self.caster.pow, self.caster.skill_intensity)
  self.buffExtra2 = self:GetBuffExtra(self.caster, 2)
  self.buffExtra8 = self:GetBuffExtra(self.caster, 8)
  self.buffExtra9 = self:GetBuffExtra(self.caster, 9)
  local grid = LuaSkillCtrl:CallGetTotalEfcGrid()
  if grid.Count > 0 then
    for i = grid.Count - 1, 0, -1 do
      local target = grid[i]
      if target.gridType == 2 then
        target:GridLoseEffect()
        self.num = self.num + 1
      end
    end
    if 0 < self.num then
      local num = math.min(self.num, 5)
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_critdamage, num, self.arglist[3], true)
      self.num = 0
    end
  end
  local enemyList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  if enemyList.Count > 0 then
    for i = 0, enemyList.Count - 1 do
      local role = enemyList[i].targetRole
      self:DoDamage(role, self.arglist[2])
    end
  end
end

function bs_106803:DoDamage(target, damageRate)
  local pow_damage = self:CalculateDamage_pow(target)
  local skill_intensity_damage = self:CalculateDamage_skill_intensity(target)
  if pow_damage >= skill_intensity_damage then
    if self.caster.pow >= self.caster.skill_intensity then
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID1, {damageRate})
      skillResult:EndResult()
    else
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID2, {damageRate})
      skillResult:EndResult()
    end
  elseif self.caster.pow >= self.caster.skill_intensity then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID3, {damageRate})
    skillResult:EndResult()
  else
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID4, {damageRate})
    skillResult:EndResult()
  end
end

function bs_106803:CalculateDamage_pow(target)
  local def = math.max(target.def * (1 - self.buffExtra2 / 1000) - self.caster.sunder, -200)
  local atk = math.max(1, self.pow * math.max(0.1, 1000 / (def + 1000)) * 1)
  local Rate = math.max(0.1, 1 + (self.buffExtra8 - self:GetBuffExtra(target, 10)))
  local damage = atk * Rate
  return damage
end

function bs_106803:CalculateDamage_skill_intensity(target)
  local magic_res = math.max(target.magic_res * (1 - self.buffExtra2 / 1000) - self.caster.magic_pen, -200)
  local skill_intensity = math.max(1, self.pow * math.max(0.1, 1000 / (magic_res + 1000)) * 1)
  local Rate = math.max(0.1, 1 + (self.buffExtra9 - self:GetBuffExtra(target, 11)))
  local damage = skill_intensity * Rate
  return damage
end

function bs_106803:GetBuffExtra(target, num)
  local buffMger = target:GetBuffComponent()
  if buffMger ~= nil then
    return buffMger:GetExtraPropertyValue(num)
  end
end

function bs_106803:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005, 1)
end

function bs_106803:PlayUltEffect()
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_106803:OnSkipUltView()
  base.OnSkipUltView(self)
end

function bs_106803:OnMovieFadeOut()
  base.OnMovieFadeOut(self)
end

function bs_106803:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_106803:LuaDispose()
  base.LuaDispose(self)
  self.effect = nil
end

return bs_106803

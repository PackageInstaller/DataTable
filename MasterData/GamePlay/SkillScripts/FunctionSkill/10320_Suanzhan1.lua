local bs_10320 = class("bs_10320", LuaSkillBase)
local base = LuaSkillBase
bs_10320.config = {
  buffWKId = 1248,
  buffDuration = 60,
  buffDuration2 = 120,
  buffDamageTime = 15,
  aoe_config = {
    effect_shape = 3,
    aoe_select_code = 4,
    aoe_range = 1
  },
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 10185,
    crit_formula = 0
  },
  effectIdHit = 10939,
  effectIdXS = 10940
}

function bs_10320:ctor()
end

function bs_10320:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_10320_13", 1, self.OnAfterPlaySkill)
  self:AddBeforeBuffDispelTrigger("bs_10320_1", 1, self.BeforeBuffDispel, self.caster, nil, self.config.buffWKId)
  self:AddBuffDieTrigger("bs_10320_2", 1, self.OnBuffDie, self.caster, nil, self.config.buffWKId)
  self:AddAfterAddBuffTrigger("bs_10320_8", 1, self.OnAfterAddBuff, nil, self.caster, nil, nil, self.config.buffWKId)
  self.caster.recordTable.ishavetimer = false
end

function bs_10320:BeforeBuffDispel(targetRole, context)
  local buffTier = self.caster:GetBuffTier(self.config.buffWKId)
  if buffTier == 0 then
    if self.timer ~= nil then
      self.timer:Stop()
      self.timer = nil
    end
    self.caster.recordTable.ishavetimer = false
  end
end

function bs_10320:OnBuffDie(buff, target, removeType)
  local buffTier = self.caster:GetBuffTier(self.config.buffWKId)
  if buffTier == 0 then
    if self.timer ~= nil then
      self.timer:Stop()
      self.timer = nil
    end
    self.caster.recordTable.ishavetimer = false
  end
end

function bs_10320:OnAfterAddBuff(buff, target)
  if target == self.caster and not self.caster.recordTable.ishavetimer then
    self.caster.recordTable.ishavetimer = true
    local arriveCallBack = BindCallback(self, self.OnArriveAction)
    local damageTime = self.config.buffDuration2 // self.config.buffDamageTime
    if self.timer == nil then
      self.timer = LuaSkillCtrl:StartTimer(nil, self.config.buffDamageTime, arriveCallBack, nil, -1, self.config.buffDamageTime)
    else
      if self.timer ~= nil then
        self.timer:Stop()
        self.timer = nil
      end
      self.timer = LuaSkillCtrl:StartTimer(nil, self.config.buffDamageTime, arriveCallBack, nil, -1, self.config.buffDamageTime)
    end
  end
end

function bs_10320:OnAfterPlaySkill(skill, role)
  if not skill.isCommonAttack then
    if self.caster.recordTable["30056_WK"] then
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffWKId, self.arglist[1], self.config.buffDuration2)
    else
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffWKId, self.arglist[1], self.config.buffDuration)
    end
  end
end

function bs_10320:OnArriveAction()
  if self.timer ~= nil and self.timer:IsOver() then
    self.timer = nil
  end
  local tier = self.caster:GetBuffTier(self.config.buffWKId)
  if 0 < tier then
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 1, 10)
    if targetlist.Count == 0 then
      return
    end
    if targetlist[0].targetRole == nil then
      return
    end
    local targetRole = targetlist[0].targetRole
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {tier}, true)
    LuaSkillCtrl:CallEffect(targetRole, self.config.effectIdHit, self)
    skillResult:EndResult()
  else
    if self.timer ~= nil then
      self.timer:Stop()
      self.timer = nil
    end
    self.caster.recordTable.ishavetimer = false
  end
end

function bs_10320:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
  self.caster.recordTable.ishavetimer = false
end

function bs_10320:LuaDispose()
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
  base.LuaDispose(self)
end

return bs_10320

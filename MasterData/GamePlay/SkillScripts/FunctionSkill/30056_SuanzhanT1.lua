local bs_30056 = class("bs_30056", LuaSkillBase)
local base = LuaSkillBase
bs_30056.config = {
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

function bs_30056:ctor()
end

function bs_30056:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_30056_1", 1, self.OnAfterBattleStart)
  self:AddBeforeBuffDispelTrigger("bs_30056_1", 1, self.BeforeBuffDispel, self.caster, nil, self.config.buffWKId)
  self:AddBuffDieTrigger("bs_30056_2", 1, self.OnBuffDie, self.caster, nil, self.config.buffWKId)
  self.caster.recordTable["30056_WK"] = true
  self:AddAfterAddBuffTrigger("bs_30056", 1, self.OnAfterAddBuff, nil, self.caster, nil, nil, self.config.buffWKId)
  self.caster.recordTable.ishavetimer = false
end

function bs_30056:BeforeBuffDispel(targetRole, context)
  local buffTier = self.caster:GetBuffTier(self.config.buffWKId)
  if buffTier == 0 then
    if self.timer ~= nil then
      self.timer:Stop()
      self.timer = nil
    end
    self.caster.recordTable.ishavetimer = false
  end
end

function bs_30056:OnBuffDie(buff, target, removeType)
  local buffTier = self.caster:GetBuffTier(self.config.buffWKId)
  if buffTier == 0 then
    if self.timer ~= nil then
      self.timer:Stop()
      self.timer = nil
    end
    self.caster.recordTable.ishavetimer = false
  end
end

function bs_30056:OnAfterAddBuff(buff, target)
  if target == self.caster and not self.caster.recordTable.ishavetimer then
    self.caster.recordTable.ishavetimer = true
    local arriveCallBack2 = BindCallback(self, self.OnArriveAction2)
    local damageTime = self.config.buffDuration2 // self.config.buffDamageTime
    if self.timer == nil then
      self.timer = LuaSkillCtrl:StartTimer(nil, self.config.buffDamageTime, arriveCallBack2, nil, -1, self.config.buffDamageTime)
    else
      if self.timer ~= nil then
        self.timer:Stop()
        self.timer = nil
      end
      self.timer = LuaSkillCtrl:StartTimer(nil, self.config.buffDamageTime, arriveCallBack2, nil, -1, self.config.buffDamageTime)
    end
  end
end

function bs_30056:OnAfterBattleStart()
  local arriveCallBack = BindCallback(self, self.OnArriveAction)
  self.timer2 = LuaSkillCtrl:StartTimer(nil, self.arglist[1], arriveCallBack, nil, -1)
end

function bs_30056:OnArriveAction()
  if self.timer2 ~= nil and self.timer2:IsOver() then
    self.timer2 = nil
  end
  if self.caster.recordTable["30056_WK"] then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffWKId, self.arglist[2], self.config.buffDuration2)
  else
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffWKId, self.arglist[2], self.config.buffDuration)
  end
end

function bs_30056:OnArriveAction2()
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

function bs_30056:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
  if self.timer2 ~= nil then
    self.timer2:Stop()
    self.timer2 = nil
  end
  self.caster.recordTable.ishavetimer = false
end

function bs_30056:LuaDispose()
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
  if self.timer2 ~= nil then
    self.timer2:Stop()
    self.timer2 = nil
  end
  base.LuaDispose(self)
end

return bs_30056

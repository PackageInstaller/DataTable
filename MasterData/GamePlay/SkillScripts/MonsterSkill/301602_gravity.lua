local bs_301602 = class("bs_301602", LuaSkillBase)
local base = LuaSkillBase
bs_301602.config = {
  time = 3,
  loopTime = 30,
  buffId_gravity = 110140,
  gravityTime = 31,
  effectId1 = 12101,
  effectId2 = 12102,
  effectId3 = 12103,
  effectId4 = 12104,
  stunBuff = 110153
}

function bs_301602:ctor()
  self.gravityFunc = BindCallback(self, self.OnAttackTrigger)
  self.cancelGravityFunc = BindCallback(self, self.OnAttackTrigger1)
end

function bs_301602:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.gravityTime = nil
  self.cancleGravityTime = nil
  self.gravityEffect = nil
end

function bs_301602:PlaySkill(data)
  if self.gravityTime ~= nil then
    self.gravityTime:Stop()
    self.gravityTime = nil
  end
  if self.cancleGravityTime ~= nil then
    self.cancleGravityTime:Stop()
    self.cancleGravityTime = nil
  end
  if self.gravityEffect ~= nil then
    self.gravityEffect:Die()
    self.gravityEffect = nil
  end
  self.gravityTime = LuaSkillCtrl:StartTimer(self, self.config.time, self.gravityFunc)
  self.gravityEffect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId1, self)
  self.cancleGravityTime = LuaSkillCtrl:StartTimer(self, self.config.loopTime, self.cancelGravityFunc)
end

function bs_301602:OnAttackTrigger()
  local targetList = LuaSkillCtrl:FindRolesAroundRole(self.caster)
  if targetList == nil then
    return
  end
  if targetList.Count <= 0 then
    return
  end
  for i = 0, targetList.Count - 1 do
    LuaSkillCtrl:CallBuff(self, targetList[i], self.config.buffId_gravity, 1, self.config.gravityTime, true)
  end
end

function bs_301602:OnAttackTrigger1()
  if self.gravityEffect ~= nil then
    self.gravityEffect:Die()
    self.gravityEffect = nil
  end
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId2, self)
  local targetList = LuaSkillCtrl:FindRolesAroundRole(self.caster)
  if targetList == nil then
    return
  end
  if targetList.Count <= 0 then
    return
  end
  for i = 0, targetList.Count - 1 do
    if 0 < targetList[i]:GetBuffTier(self.config.buffId_gravity) then
      LuaSkillCtrl:CallBuff(self, targetList[i], self.config.stunBuff, 1, self.arglist[2], false)
      LuaSkillCtrl:CallEffect(self.caster, self.config.effectId3, self)
    end
  end
end

function bs_301602:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_301602:LuaDispose()
  base.LuaDispose(self)
  self.gravityEffect = nil
end

return bs_301602

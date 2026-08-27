local bs_302905 = class("bs_302905", LuaSkillBase)
local base = LuaSkillBase
bs_302905.config = {
  timeDelay = 30,
  deathTime = 150,
  configId = 5,
  effectId = 12091,
  buffFeature_ignoreDie = 6,
  buffFeature_Invinciable = 2,
  Exiled = 16
}

function bs_302905:ctor()
end

function bs_302905:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.arg1 = self.caster.recordTable.arg1
  self.arg2 = self.caster.recordTable.arg2
  self.arg3 = self.caster.recordTable.arg3
  local arriveCallBack = BindCallback(self, self.OnArriveAction)
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arg1, arriveCallBack, nil, -1, self.config.timeDelay)
  local arriveCallBack1 = BindCallback(self, self.OnArriveAction1)
  self.timer2 = LuaSkillCtrl:StartTimer(nil, self.arg3, arriveCallBack1, nil, -1)
end

function bs_302905:OnArriveAction1()
  if self.timer2 ~= nil and self.timer2:IsOver() then
    self.timer2 = nil
  end
  LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.OnSacrifice, self.caster, self.caster)
  local IfRoleCotainsIgnoreDieBuff = LuaSkillCtrl:RoleContainsBuffFeature(self.caster, self.config.buffFeature_ignoreDie)
  if IfRoleCotainsIgnoreDieBuff == true then
    local buff_ignoreDie = LuaSkillCtrl:GetRoleAllBuffsByFeature(self.caster, self.config.buffFeature_ignoreDie)
    if buff_ignoreDie.Count > 0 then
      for i = 0, buff_ignoreDie.Count - 1 do
        LuaSkillCtrl:DispelBuff(self.caster, buff_ignoreDie[i].dataId, 0, true)
        IfRoleCotainsIgnoreDieBuff = false
      end
    end
  end
  local IfRoleCotainsWudiBuff = LuaSkillCtrl:RoleContainsBuffFeature(self.caster, self.config.buffFeature_Invinciable)
  if IfRoleCotainsWudiBuff == true then
    local buff_Wudi = LuaSkillCtrl:GetRoleAllBuffsByFeature(self.caster, self.config.buffFeature_Invinciable)
    if buff_Wudi.Count > 0 then
      for i = 0, buff_Wudi.Count - 1 do
        LuaSkillCtrl:DispelBuff(self.caster, buff_Wudi[i].dataId, 0, true)
      end
    end
  end
  local IfRoleCotainsExiledBuff = LuaSkillCtrl:RoleContainsBuffFeature(self.caster, self.config.Exiled)
  if IfRoleCotainsExiledBuff == true then
    local buff_Exile = LuaSkillCtrl:GetRoleAllBuffsByFeature(self.caster, self.config.Exiled)
    if buff_Exile.Count > 0 then
      for i = 0, buff_Exile.Count - 1 do
        LuaSkillCtrl:DispelBuff(self.caster, buff_Exile[i].dataId, 0, true)
      end
    end
  end
  LuaSkillCtrl:RemoveLife(self.caster.maxHp * 2, self, self.caster, true, nil, false, true, 2, true)
end

function bs_302905:OnArriveAction()
  if self.timer ~= nil and self.timer:IsOver() then
    self.timer = nil
  end
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 7, 10)
  if targetlist.Count < 1 then
    return
  end
  local target = targetlist[0].targetRole
  if target == nil then
    return
  end
  self.caster:LookAtTarget(target)
  LuaSkillCtrl:CallEffect(target, self.config.effectId, self)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
  LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.configId, {
    self.arg2
  }, true, true)
  skillResult:EndResult()
end

function bs_302905:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
  if self.timer2 ~= nil then
    self.timer2:Stop()
    self.timer2 = nil
  end
end

function bs_302905:LuaDispose()
  base.LuaDispose(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
  if self.timer2 ~= nil then
    self.timer2:Stop()
    self.timer2 = nil
  end
end

return bs_302905

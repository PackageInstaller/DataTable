local bs_213601 = class("bs_213601", LuaSkillBase)
local base = LuaSkillBase
bs_213601.config = {
  effectId_2 = 107908,
  effectId_3 = 107920,
  effectId_cast = 107917,
  buffId_focusOnFiring = 107907,
  buffId = 3023,
  buffFeature_ignoreDie = 6,
  buffFeature_Invinciable = 2,
  Exiled = 16,
  actionId_02 = 1029
}

function bs_213601:ctor()
end

function bs_213601:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRealSummonerCaster, self.OnAfterBattleStart)
  self.arg1 = self.caster.recordTable.arg_1
end

function bs_213601:OnAfterBattleStart(summonerEntity)
  if summonerEntity == self.caster then
    local target
    local targets = LuaSkillCtrl:CallTargetSelect(self, 10001, 10)
    for i = targets.Count - 1, 0, -1 do
      local role = targets[i].targetRole
      if LuaSkillCtrl:IsObstacle(role) then
        targets:RemoveAt(i)
      end
    end
    if targets.Count > 0 then
      target = targets[0].targetRole
    end
    if target ~= nil then
      self.caster:LookAtTarget(target)
    end
    LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_02, 1)
    LuaSkillCtrl:StartShowSkillDurationTime(self, self.arg1)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
    self.effectLoop = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_cast, self)
    local targetList = LuaSkillCtrl:FindAllRolesWithinRange(self.caster, 1, false)
    if targetList.Count > 0 then
      for i = 0, targetList.Count - 1 do
        if targetList[i].belongNum ~= self.caster.belongNum then
          LuaSkillCtrl:CallBuff(self, targetList[i], self.config.buffId_focusOnFiring, 1, self.arg1, false, self.caster)
        end
      end
    end
    self.killer = LuaSkillCtrl:StartTimer(nil, self.arg1, function()
      local role = self.caster
      local IfRoleCotainsIgnoreDieBuff = LuaSkillCtrl:RoleContainsBuffFeature(role, self.config.buffFeature_ignoreDie)
      if IfRoleCotainsIgnoreDieBuff == true then
        local buff_ignoreDie = LuaSkillCtrl:GetRoleAllBuffsByFeature(role, self.config.buffFeature_ignoreDie)
        if buff_ignoreDie.Count > 0 then
          for i = 0, buff_ignoreDie.Count - 1 do
            LuaSkillCtrl:DispelBuff(role, buff_ignoreDie[i].dataId, 0, true)
            IfRoleCotainsIgnoreDieBuff = false
          end
        end
      end
      local IfRoleCotainsWudiBuff = LuaSkillCtrl:RoleContainsBuffFeature(role, self.config.buffFeature_Invinciable)
      if IfRoleCotainsWudiBuff == true then
        local buff_Wudi = LuaSkillCtrl:GetRoleAllBuffsByFeature(role, self.config.buffFeature_Invinciable)
        if buff_Wudi.Count > 0 then
          for i = 0, buff_Wudi.Count - 1 do
            LuaSkillCtrl:DispelBuff(role, buff_Wudi[i].dataId, 0, true)
          end
        end
      end
      local IfRoleCotainsExiledBuff = LuaSkillCtrl:RoleContainsBuffFeature(role, self.config.Exiled)
      if IfRoleCotainsExiledBuff == true then
        local buff_Exile = LuaSkillCtrl:GetRoleAllBuffsByFeature(role, self.config.Exiled)
        if buff_Exile.Count > 0 then
          for i = 0, buff_Exile.Count - 1 do
            LuaSkillCtrl:DispelBuff(role, buff_Exile[i].dataId, 0, true)
          end
        end
      end
      if 0 < role.hp and IfRoleCotainsIgnoreDieBuff == false then
        LuaSkillCtrl:RemoveLife(role.hp * 100, self, role, true, nil, false, false, eHurtType.RealDmg, true)
      end
    end, nil, 0, 0)
  end
end

function bs_213601:OnCasterDie()
  local Skin_ID
  local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  if targetList ~= nil then
    for i = 0, targetList.Count - 1 do
      if targetList[i].roleDataId == 1079 then
        Skin_ID = LuaSkillCtrl:GetCasterSkinId(targetList[i])
      end
    end
  end
  if Skin_ID == 307903 then
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_3, self, nil)
  else
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_2, self, nil)
  end
  LuaSkillCtrl:SetRoleVisible(self.caster, false)
  base.OnCasterDie(self)
  if self.killer ~= nil then
    self.killer:Stop()
    self.killer = nil
  end
  if self.effectLoop ~= nil then
    self.effectLoop:Die()
    self.effectLoop = nil
  end
end

return bs_213601

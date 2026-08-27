local bs_81005 = class("bs_81005", LuaSkillBase)
local base = LuaSkillBase
bs_81005.config = {buffId = 1215, effectId_start = 11006}

function bs_81005:ctor()
end

function bs_81005:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddOnRoleDieTrigger("bs_81005", 1, self.OnRoleDie)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_81005_1", 2, self.OnAfterBattleStart)
end

function bs_81005:OnAfterBattleStart()
  LuaSkillCtrl:StartAvgWithPauseGame("23winter_s20_2", nil, nil)
end

function bs_81005:OnRoleDie(killer, role)
  if role.roleDataId == 1003 then
    local jiji = BindCallback(self, self.Jiji)
    LuaSkillCtrl:StartTimer(nil, 30, jiji)
  end
end

function bs_81005:Jiji()
  LuaSkillCtrl:StartAvgWithPauseGame("23winter_s20_3", nil, nil)
  local dapao = BindCallback(self, self.Dapao)
  LuaSkillCtrl:StartTimer(nil, 30, dapao)
end

function bs_81005:Dapao()
  local targetlist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  if targetlist.Count < 1 then
    return
  end
  for i = targetlist.Count - 1, 0, -1 do
    local targetRole = targetlist[i]
    if targetRole.roleDataId == 40041 then
      LuaSkillCtrl:RemoveLife(targetRole.maxHp + 1, self, targetRole, true, nil, true, true)
      LuaSkillCtrl:CallEffect(targetRole, self.config.effectId_start, self)
    else
      local IfRoleCotainsIgnoreDieBuff = LuaSkillCtrl:RoleContainsBuffFeature(targetRole, self.config.buffFeature_ignoreDie)
      if IfRoleCotainsIgnoreDieBuff then
        local buff_ignoreDie = LuaSkillCtrl:GetRoleAllBuffsByFeature(targetRole, self.config.buffFeature_ignoreDie)
        if buff_ignoreDie.Count > 0 then
          for i = 0, buff_ignoreDie.Count - 1 do
            LuaSkillCtrl:DispelBuff(targetRole, buff_ignoreDie[i].dataId, 0)
          end
        end
      end
      local IfRoleCotainsInvinciableBuff = LuaSkillCtrl:RoleContainsBuffFeature(targetRole, self.config.buffFeature_Invinciable)
      if IfRoleCotainsInvinciableBuff and not targetRole.recordTable.equipSummoner then
        local buff_invinciable = LuaSkillCtrl:GetRoleAllBuffsByFeature(targetRole, self.config.buffFeature_Invinciable)
        if buff_invinciable.Count > 0 then
          for i = 0, buff_invinciable.Count - 1 do
            LuaSkillCtrl:DispelBuff(targetRole, buff_invinciable[i].dataId, 0)
          end
        end
      end
      LuaSkillCtrl:RemoveLife(targetRole.maxHp + 1, self, targetRole, true, nil, true, true)
    end
  end
  local battleEnd = BindCallback(self, self.BattleEnd)
  LuaSkillCtrl:StartTimer(nil, 30, battleEnd)
end

function bs_81005:BattleEnd()
  LuaSkillCtrl:ForceEndBattle(true)
end

function bs_81005:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_81005

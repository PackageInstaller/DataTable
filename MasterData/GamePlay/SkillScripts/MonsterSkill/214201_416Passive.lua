local bs_214201 = class("bs_214201", LuaSkillBase)
local base = LuaSkillBase
bs_214201.config = {buffId_crit = 105804}

function bs_214201:ctor()
end

function bs_214201:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_214201_1", 9999, self.OnSetHurt, nil, self.caster)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRealSummonerCaster, self.OnAfterBattleStart)
  self.arg1 = self.caster.recordTable.arg_1
end

function bs_214201:OnAfterBattleStart(summonerEntity)
  if summonerEntity == self.caster then
    self.caster.recordTable.arg2 = self.caster.recordTable.arg_2
  end
end

function bs_214201:OnSetHurt(context)
  if context.target == self.caster and context.hurt > 0 and context.isCrit == true then
    local shieldNum = LuaSkillCtrl:GetRoleAllShield(self.caster)
    context.hurt = 1 + shieldNum
  else
    context.hurt = 0
    local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
    local end_game = false
    if 0 < targetList.Count then
      for i = targetList.Count - 1, 0, -1 do
        local role = targetList[i]
        if role ~= nil and 0 < role.hp and role.roleDataId == 89 then
          end_game = true
        elseif role ~= nil and 0 < role.hp and role.roleDataId ~= 89 then
          end_game = false
          break
        end
      end
    end
    if end_game == true then
      local shieldNum = LuaSkillCtrl:GetRoleAllShield(self.caster)
      context.hurt = 1 + shieldNum
    end
  end
end

function bs_214201:OnCasterDie()
  local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  if targetList.Count > 0 then
    for i = targetList.Count - 1, 0, -1 do
      local role = targetList[i]
      if role ~= nil and 0 < role.hp and role.roleDataId == 1058 then
        LuaSkillCtrl:CallBuff(self, role, self.config.buffId_crit, 1, self.arg1)
        break
      end
    end
  end
  LuaSkillCtrl:SetRoleVisible(self.caster, false)
  base.OnCasterDie(self)
end

return bs_214201

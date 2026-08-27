local bs_80013 = class("bs_80013", LuaSkillBase)
local base = LuaSkillBase
bs_80013.config = {
  buffIdUp = 110056,
  buffIdDown = 110045,
  buffIdYS = 3004
}

function bs_80013:ctor()
end

function bs_80013:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_80013_1", 1, self.OnAfterBattleStart)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_80013_2", 1, self.OnRoleDie)
  self:AddBeforeAddBuffTrigger("bs_80013_4", 1, self.OnBeforeAddBuff, nil, nil, eBattleRoleBelong.player, eBattleRoleBelong.player)
  self.Num = 0
end

function bs_80013:OnAfterBattleStart()
  local targetListUp = LuaSkillCtrl:CallTargetSelect(self, 68, 10)
  local highHpTarget
  if targetListUp.Count > 0 then
    highHpTarget = targetListUp[0].targetRole
    LuaSkillCtrl:CallBuff(self, highHpTarget, self.config.buffIdUp, 1)
    LuaSkillCtrl:CallStartLocalScale(highHpTarget, Vector3.New(1.3, 1.3, 1.3), 0.2)
    highHpTarget:UpdateHp()
  end
  if highHpTarget ~= nil then
    local targetListAll = LuaSkillCtrl:GetAllFriendRolesRelative(self.caster.belongNum)
    if targetListAll.Count > 0 then
      for i = 0, targetListAll.Count - 1 do
        if targetListAll[i] ~= highHpTarget then
          local a = targetListAll[i]:GetBuffTier(self.config.buffIdUp)
          LuaSkillCtrl:CallBuff(self, targetListAll[i], self.config.buffIdDown, 1)
          LuaSkillCtrl:CallBuff(self, targetListAll[i], self.config.buffIdYS, 1)
        end
      end
    end
  end
end

function bs_80013:OnBeforeAddBuff(target, context)
  if (context.buff.buffCfg.MatShow == 16 or context.buff.buffCfg.MatShow == 1 or context.buff.buffCfg.MatShow == 14 or context.buff.buffCfg.MatShow == 7 or context.buff.buffCfg.MatShow == 12) and target:GetBuffTier(self.config.buffIdYS) > 0 then
    context.active = false
  end
end

function bs_80013:OnRoleDie(killer, role, killSkill)
  if role.belongNum == self.caster.belongNum and role.roleType == eBattleRoleType.character then
    local targetListAll = LuaSkillCtrl:GetAllFriendRolesRelative(self.caster.belongNum)
    if targetListAll.Count > 0 then
      for i = 0, targetListAll.Count - 1 do
        LuaSkillCtrl:DispelBuff(targetListAll[i], self.config.buffIdUp, 1)
        LuaSkillCtrl:DispelBuff(targetListAll[i], self.config.buffIdDown, 1)
        LuaSkillCtrl:DispelBuff(targetListAll[i], self.config.buffIdYS, 1)
      end
    end
  end
end

function bs_80013:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_80013

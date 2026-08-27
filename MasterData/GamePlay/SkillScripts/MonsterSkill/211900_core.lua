local bs_211900 = class("bs_211900", LuaSkillBase)
local base = LuaSkillBase
bs_211900.config = {
  buffId1 = 175,
  buffId2 = 1033,
  buffId3 = 198,
  buffId4 = 211900,
  effectId = 211900,
  effectId_tech = 511101
}

function bs_211900:ctor()
end

function bs_211900:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_211900_1", 1, self.OnAfterBattleStart)
  self:AddOnRoleDieTrigger("bs_211900_2", 1, self.OnRoleDie, nil, nil, nil, self.caster.belongNum)
  self.effectTable = {}
end

function bs_211900:OnAfterBattleStart()
  LuaSkillCtrl:StartTimer(nil, 7, BindCallback(self, self.TechEventFunc))
  local target
  local targets = LuaSkillCtrl:CallTargetSelect(self, 2, 10)
  if targets.Count > 0 then
    for i = 0, targets.Count - 1 do
      local role = targets[i].targetRole
      if role ~= nil and 0 < role.hp then
        LuaSkillCtrl:CallBuff(self, role, self.config.buffId4, 1, nil, true)
        self.effectTable[role] = LuaSkillCtrl:CallEffect(role, self.config.effectId, self)
      end
    end
  end
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId2, 1, nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId3, 1, nil, true)
end

function bs_211900:OnRoleDie(killer, role)
  if self.effectTable[role] ~= nil then
    self.effectTable[role]:Die()
    self.effectTable[role] = nil
  end
end

function bs_211900:TechEventFunc()
  local commander = LuaSkillCtrl:GetPlayerRoleEntity()
  if commander == nil then
    return
  end
  local per = commander.spell_life_steal
  local hurt = self.caster.maxHp * per // 1000
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_tech, self)
  LuaSkillCtrl:RemoveLife(hurt, self, self.caster, true, nil, true, true, eHurtType.RealDmg, true)
end

function bs_211900:OnCasterDie()
  base.OnCasterDie(self)
  local target
  local targets = LuaSkillCtrl:CallTargetSelect(self, 2, 10)
  if targets.Count > 0 then
    for i = 0, targets.Count - 1 do
      local role = targets[i].targetRole
      if role ~= nil and 0 < role.hp then
        LuaSkillCtrl:DispelBuff(role, self.config.buffId4, 1)
        if self.effectTable[role] ~= nil then
          self.effectTable[role]:Die()
          self.effectTable[role] = nil
        end
      end
    end
  end
end

function bs_211900:LuaDispose()
  self.effectTable = nil
  self.roleTable = nil
  base.LuaDispose(self)
end

return bs_211900

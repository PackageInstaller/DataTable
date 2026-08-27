local bs_7020 = class("bs_7020", LuaSkillBase)
local base = LuaSkillBase
bs_7020.config = {effectId = 11015, effectId2 = 11016}

function bs_7020:ctor()
end

function bs_7020:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_7020_1", 997, self.OnSetHurt, nil, nil, nil, self.caster.belongNum)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_7020_2", 1, self.OnAfterBattleStart)
  self:AddOnRoleDieTrigger("bs_7020_3", 1, self.OnRoleDie, nil, nil, nil, self.caster.belongNum)
  self.effectTable = {}
  self.effectTable2 = {}
end

function bs_7020:OnSetHurt(context)
  if context.target ~= self.caster and context.target.belongNum ~= context.sender.belongNum then
    context.hurt = 1
  end
end

function bs_7020:OnAfterBattleStart()
  local targets = LuaSkillCtrl:CallTargetSelect(self, 2, 10)
  if targets.Count > 0 then
    for i = 0, targets.Count - 1 do
      local role = targets[i].targetRole
      if role ~= nil and 0 < role.hp then
        LuaSkillCtrl:CallBuff(self, role, self.config.buffId4, 1, nil, true)
        self.effectTable[role] = LuaSkillCtrl:CallEffect(role, self.config.effectId, self)
        self.effectTable2[role] = LuaSkillCtrl:CallEffect(role, self.config.effectId2, self)
      end
    end
  end
end

function bs_7020:OnRoleDie(killer, role)
  if self.effectTable[role] ~= nil then
    self.effectTable[role]:Die()
    self.effectTable[role] = nil
  end
  if self.effectTable2[role] ~= nil then
    self.effectTable2[role]:Die()
    self.effectTable2[role] = nil
  end
end

function bs_7020:OnCasterDie()
  base.OnCasterDie(self)
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
        if self.effectTable2[role] ~= nil then
          self.effectTable2[role]:Die()
          self.effectTable2[role] = nil
        end
      end
    end
  end
end

function bs_7020:LuaDispose()
  base.LuaDispose(self)
  self.effectTable = nil
end

return bs_7020

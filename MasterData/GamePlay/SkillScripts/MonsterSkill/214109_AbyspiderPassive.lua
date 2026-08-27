local bs_214109 = class("bs_214109", LuaSkillBase)
local base = LuaSkillBase
bs_214109.config = {buff_id = 214101, buff_id_locked = 214102}

function bs_214109:ctor()
end

function bs_214109:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddBuffDieTrigger("bs_214109", 1, self.OnBuffDie, self.caster, nil, self.config.buff_id)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRolePhaseMoveStart, self.OnRolePhaseMoveStart)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRoleSplash, self.OnRoleSplash)
end

function bs_214109:OnBuffDie(buff, target, removeType)
  if removeType == eBuffRemoveType.Timeout then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff_id_locked, 1, 90)
    LuaSkillCtrl:CallBuffRepeated(self, entity, self.config.buffIdcx, 1, self.arglist[5] + 1, false, false, self.OnBuffExecute)
  end
end

function bs_214109:OnBuffExecute(buff, targetRole)
  local num = targetRole:GetBuffTier(self.config.buffIdcx)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
  local hurtnum = self.arglist[4] * num
  LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.configId, {hurtnum}, true)
  skillResult:EndResult()
end

function bs_214109:OnRoleSplash(role, grid)
  if role == self.caster and role.hp > 0 then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buff_id, 0)
  end
end

function bs_214109:OnRolePhaseMoveStart(role, luaskill)
  if role == self.caster and role.hp > 0 then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buff_id, 0)
  end
end

function bs_214109:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_214109

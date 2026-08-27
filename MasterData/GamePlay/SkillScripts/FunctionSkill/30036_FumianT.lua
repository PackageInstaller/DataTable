local bs_30036 = class("bs_30036", LuaSkillBase)
local base = LuaSkillBase
bs_30036.config = {buffId = 1199}

function bs_30036:ctor()
end

function bs_30036:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_30036_1", 1, self.OnAfterAddBuff, nil, nil, nil, nil, nil, eBuffType.Debeneficial)
  self:AddBeforeBuffDispelTrigger("bs_30036_2", 2, self.BeforeBuffDispel, nil, nil, nil, eBuffType.Debeneficial)
  self:AddAfterBuffRemoveTrigger("bs_30036_buff_die", 4, self.AfterBuffRemove, nil, nil, nil, eBuffType.Debeneficial)
end

function bs_30036:AfterBuffRemove(buffId, target, removeType)
  if target.belongNum ~= self.caster.belongNum then
    LuaSkillCtrl:DispelBuff(target, self.config.buffId, 0)
    local buffTier = self:GetDebuffNum(target)
    if 0 < buffTier then
      LuaSkillCtrl:CallBuff(self, target, self.config.buffId, buffTier, nil, true)
    end
  end
end

function bs_30036:OnAfterAddBuff(buff, target)
  if target.belongNum ~= self.caster.belongNum then
    LuaSkillCtrl:DispelBuff(target, self.config.buffId, 0)
    local buffTier = self:GetDebuffNum(target)
    if 0 < buffTier then
      LuaSkillCtrl:CallBuff(self, target, self.config.buffId, buffTier, nil, true)
    end
  end
end

function bs_30036:BeforeBuffDispel(targetRole, context)
  if targetRole.belongNum ~= self.caster.belongNum then
    LuaSkillCtrl:DispelBuff(targetRole, self.config.buffId, 0)
    local buffTier = self:GetDebuffNum(targetRole)
    if 0 < buffTier then
      LuaSkillCtrl:CallBuff(self, targetRole, self.config.buffId, buffTier, nil, true)
    end
  end
end

function bs_30036:OnBuffDie(buff, target, removeType)
  if target.belongNum ~= self.caster.belongNum then
    LuaSkillCtrl:DispelBuff(target, self.config.buffId, 0)
    local buffTier = self:GetDebuffNum(target)
    if 0 < buffTier then
      LuaSkillCtrl:CallBuff(self, target, self.config.buffId, buffTier, nil, true)
    end
  end
end

function bs_30036:GetDebuffNum(target)
  local debuffNum = 0
  local buffs = LuaSkillCtrl:GetRoleBuffs(target)
  if buffs == nil then
    return 0
  end
  if 0 < buffs.Count then
    for i = 0, buffs.Count - 1 do
      if buffs[i].buffType == 2 then
        debuffNum = debuffNum + 1
      end
    end
  end
  if 30 < debuffNum then
    debuffNum = 30
  end
  if 0 < debuffNum then
    return debuffNum
  else
    return 0
  end
end

function bs_30036:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_30036

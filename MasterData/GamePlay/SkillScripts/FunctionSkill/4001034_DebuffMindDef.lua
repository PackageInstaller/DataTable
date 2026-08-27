local bs_4001034 = class("bs_4001034", LuaSkillBase)
local base = LuaSkillBase
bs_4001034.config = {buffId = 2015}

function bs_4001034:ctor()
end

function bs_4001034:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_4001034_1", 1, self.OnAfterAddBuff, nil, nil, nil, nil, nil, eBuffType.Debeneficial)
  self:AddBeforeBuffDispelTrigger("bs_4001034_2", 2, self.BeforeBuffDispel, nil, nil, nil, eBuffType.Debeneficial)
  self:AddAfterBuffRemoveTrigger("bs_4001034_buff_die", 4, self.AfterBuffRemove, nil, nil, nil, eBuffType.Debeneficial)
end

function bs_4001034:AfterBuffRemove(buffId, target, removeType)
  if target.belongNum ~= eBattleRoleBelong.player then
    LuaSkillCtrl:DispelBuff(target, self.config.buffId, 0, true)
    local buffTier = self:GetDebuffNum(target)
    if 0 < buffTier then
      LuaSkillCtrl:CallBuff(self, target, self.config.buffId, 1, nil, true)
    end
  end
end

function bs_4001034:OnAfterAddBuff(buff, target)
  if target.belongNum ~= eBattleRoleBelong.player then
    LuaSkillCtrl:DispelBuff(target, self.config.buffId, 0, true)
    local buffTier = self:GetDebuffNum(target)
    if 0 < buffTier then
      LuaSkillCtrl:CallBuff(self, target, self.config.buffId, 1, nil, true)
    end
  end
end

function bs_4001034:BeforeBuffDispel(targetRole, context)
  if targetRole.belongNum ~= eBattleRoleBelong.player then
    LuaSkillCtrl:DispelBuff(targetRole, self.config.buffId, 0, true)
    local buffTier = self:GetDebuffNum(targetRole)
    if 0 < buffTier then
      LuaSkillCtrl:CallBuff(self, targetRole, self.config.buffId, 1, nil, true)
    end
  end
end

function bs_4001034:OnBuffDie(buff, target, removeType)
  if target.belongNum ~= eBattleRoleBelong.player then
    LuaSkillCtrl:DispelBuff(target, self.config.buffId, 0, true)
    local buffTier = self:GetDebuffNum(target)
    if 0 < buffTier then
      LuaSkillCtrl:CallBuff(self, target, self.config.buffId, 1, nil, true)
    end
  end
end

function bs_4001034:GetDebuffNum(target)
  local debuffNum = 0
  local buffs = LuaSkillCtrl:GetRoleBuffs(target)
  local flag = 0
  if buffs == nil then
    return 0
  end
  if 0 >= buffs.Count then
    return 0
  end
  if 0 < buffs.Count then
    for i = 0, buffs.Count - 1 do
      if buffs[i].buffType == 2 and buffs[i].buffId ~= self.config.buffId then
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

function bs_4001034:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4001034

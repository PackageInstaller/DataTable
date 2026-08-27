local bs_92085 = class("bs_92085", LuaSkillBase)
local base = LuaSkillBase
bs_92085.config = {
  buffId_fire = 1227,
  buffId_blood = 195,
  buffId_mindMagicDef = 2076,
  buffId_mindPhyDef = 2077
}

function bs_92085:ctor()
end

function bs_92085:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddBeforeAddBuffTrigger("bs_92085_1", 1, self.OnBeforeAddBuff, nil, nil, nil, eBattleRoleBelong.enemy)
  self:AddBuffDieTrigger("bs_92085_3", 1, self.OnBuffDie, nil, eBattleRoleBelong.enemy, self.config.buff_fire)
end

function bs_92085:OnBeforeAddBuff(target, context)
  if context.buff.dataId ~= self.config.buff_fire or context.buff.dataId ~= self.config.buff_blood then
    return
  end
  local buffTier_fire = target:GetBuffTier(self.config.buffId_fire)
  local buffTier_blood = target:GetBuffTier(self.config.buffId_blood)
  if target.recordTable.buffTier_fire == nil then
    target.recordTable.buffTier_fire = 0
  end
  if target.recordTable.buffTier_blood == nil then
    target.recordTable.buffTier_blood = 0
  end
  if buffTier_fire ~= target.recordTable.buffTier_fire then
    LuaSkillCtrl:DispelBuff(target, self.config.buffId_mindMagicDef, 0, true, true)
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId_mindMagicDef, buffTier_fire, nil, true)
    target.recordTable.buffTier_fire = buffTier_fire
  end
  if buffTier_blood ~= target.recordTable.buffTier_blood then
    LuaSkillCtrl:DispelBuff(target, self.config.buffId_mindPhyDef, 0, true, true)
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId_mindPhyDef, buffTier_blood, nil, true)
    target.recordTable.buffTier_blood = buffTier_blood
  end
end

function bs_92085:OnBuffDie(buff, target, removeType)
  if buff.dataId ~= self.config.buff_fire or buff.dataId ~= self.config.buff_blood then
    return
  end
  local buffTier_fire = target:GetBuffTier(self.config.buffId_fire)
  local buffTier_blood = target:GetBuffTier(self.config.buffId_blood)
  if target.recordTable.buffTier_fire == nil then
    target.recordTable.buffTier_fire = 0
  end
  if target.recordTable.buffTier_blood == nil then
    target.recordTable.buffTier_blood = 0
  end
  if buffTier_fire ~= target.recordTable.buffTier_fire then
    LuaSkillCtrl:DispelBuff(target, self.config.buffId_mindMagicDef, 0, true, true)
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId_mindMagicDef, buffTier_fire, nil, true)
    target.recordTable.buffTier_fire = buffTier_fire
  end
  if buffTier_blood ~= target.recordTable.buffTier_blood then
    LuaSkillCtrl:DispelBuff(target, self.config.buffId_mindPhyDef, 0, true, true)
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId_mindPhyDef, buffTier_blood, nil, true)
    target.recordTable.buffTier_blood = buffTier_blood
  end
end

function bs_92085:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_92085

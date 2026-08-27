local bs_25292 = class("bs_25292", LuaSkillBase)
local base = LuaSkillBase
bs_25292.config = {buffId_fire = 107101, buffId_down = 2146}

function bs_25292:ctor()
end

function bs_25292:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_25292", 1, self.OnAfterAddBuff, nil, nil, nil, eBattleRoleBelong.enemy, self.config.buffId_fire)
  self:AddBeforeBuffDispelTrigger("bs_25292_1", 1, self.BeforeBuffDispel, nil, eBattleRoleBelong.enemy, self.config.buffId_fire)
  self:AddBuffDieTrigger("bs_25292_2", 1, self.OnBuffDie, nil, eBattleRoleBelong.enemy, self.config.buffId_fire)
end

function bs_25292:OnAfterAddBuff(buff, target)
  local Tier = target:GetBuffTier(self.config.buffId_fire)
  if Tier ~= nil and 0 < Tier then
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId_down, 1, nil, true)
  else
    LuaSkillCtrl:DispelBuff(target, self.config.buffId_down, 0, true, true)
  end
end

function bs_25292:BeforeBuffDispel(targetRole, context)
  LuaSkillCtrl:DispelBuff(targetRole, self.config.buffId_down, 0)
end

function bs_25292:OnBuffDie(buff, target, removeType)
  if buff.dataId == self.config.buffId_fire then
    LuaSkillCtrl:DispelBuff(target, self.config.buffId_down, 0)
  end
end

function bs_25292:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_25292

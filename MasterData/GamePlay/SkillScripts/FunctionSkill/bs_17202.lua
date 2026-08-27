local bs_17202 = class("bs_17202", LuaSkillBase)
local base = LuaSkillBase
bs_17202.config = {
  DropRange = 200,
  roleID = 1078,
  buffId = 2200,
  roletag = 3
}

function bs_17202:ctor()
end

function bs_17202:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable.Kurisu_Mode = self.config.roletag
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_17202_1", 1, self.OnAfterBattleStart)
  self:AddTrigger(eSkillTriggerType.BeforeBattleEnd, "bs_17202_2", 1, self.BeforeEndBattle)
  self:AddTrigger(eSkillTriggerType.OnSelfStartMove, "bs_17202_3", 1, self.OnStartMove)
  self:AddTrigger(eSkillTriggerType.OnSelfAfterMove, "bs_17202_4", 1, self.OnAfterMove)
end

function bs_17202:OnAfterBattleStart()
  local skillCaster = LuaSkillCtrl:GetPlayerRoleEntity()
  skillCaster.recordTable.brotatoDropRange = self.config.DropRange
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, 999, true)
end

function bs_17202:OnStartMove()
  if self.caster:GetBuffTier(self.config.buffId) > 0 then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0, true)
  end
end

function bs_17202:OnAfterMove()
  if self.caster:GetBuffTier(self.config.buffId) < 1 then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
  end
end

function bs_17202:BeforeEndBattle()
  LuaSkillCtrl:AddCacheGold(self.arglist[2])
end

function bs_17202:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_17202

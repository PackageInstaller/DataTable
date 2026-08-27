local bs_15161 = class("bs_15161", LuaSkillBase)
local base = LuaSkillBase
bs_15161.config = {effectId = 12098, buffId = 2136}

function bs_15161:ctor()
end

function bs_15161:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_15161", 1, self.AfterBattleStart)
  self:AddAfterPlaySkillTrigger("bs_15161", 1, self.OnAfterPlaySkill, self.caster, nil, nil, nil, nil, nil, nil, eSkillTag.commonAttack)
end

function bs_15161:AfterBattleStart()
  local gold = LuaSkillCtrl:GetCacheGold()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, gold, nil, true)
end

function bs_15161:OnAfterPlaySkill(skill, role)
  if role ~= self.caster then
    return
  end
  local range = LuaSkillCtrl:CallRange(1, 1000)
  if range > self.arglist[2] then
    return
  end
  LuaSkillCtrl:AddCacheGold(self.arglist[3])
  LuaSkillCtrl:CallEffect(role, self.config.effectId, self)
  LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.OnAddMoneyInBattle)
end

function bs_15161:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15161

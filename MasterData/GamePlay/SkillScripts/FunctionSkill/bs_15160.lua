local bs_15160 = class("bs_15160", LuaSkillBase)
local base = LuaSkillBase
bs_15160.config = {buffId = 2135, effectId_1 = 12098}

function bs_15160:ctor()
end

function bs_15160:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_15160", 1, self.AfterBattleStart)
  self:AddSetDeadHurtTrigger("bs_15160", 1, self.OnSetDeadHurt, self.caster, nil, nil, eBattleRoleBelong.enemy)
end

function bs_15160:AfterBattleStart()
  local gold = LuaSkillCtrl:GetCacheGold()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, gold, nil, true)
end

function bs_15160:OnSetDeadHurt(context)
  if LuaSkillCtrl:CallRange(1, 1000) > self.arglist[2] then
    return
  end
  LuaSkillCtrl:AddCacheGold(self.arglist[3])
  LuaSkillCtrl:CallEffect(context.target, self.config.effectId_1, self)
  LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.OnAddMoneyInBattle)
end

function bs_15160:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15160

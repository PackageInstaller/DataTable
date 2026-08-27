local bs_15162 = class("bs_15162", LuaSkillBase)
local base = LuaSkillBase
bs_15162.config = {effectId = 12098}

function bs_15162:ctor()
end

function bs_15162:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_15162_1", 1, self.AfterBattleStart)
  self:AddTrigger(eSkillTriggerType.OnAfterShieldHurt, "bs_15162_2", 1, self.OnAfterShieldHurt)
  self.isNotFirstTime = false
end

function bs_15162:AfterBattleStart()
  local coins = LuaSkillCtrl:GetCacheGold()
  local sheild = self.arglist[1] * coins * self.caster.maxHp // 1000
  LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.Normal, sheild)
end

function bs_15162:OnAfterShieldHurt(context)
  if context.target.belongNum ~= eBattleRoleBelong.player then
    return
  end
  local value = LuaSkillCtrl:GetRoleAllShield(context.target)
  if value ~= nil and 0 < value then
    return
  end
  if self.isNotFirstTime then
    return
  end
  self.isNotFirstTime = true
  LuaSkillCtrl:AddCacheGold(self.arglist[2])
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self)
  LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.OnAddMoneyInBattle)
end

function bs_15162:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15162

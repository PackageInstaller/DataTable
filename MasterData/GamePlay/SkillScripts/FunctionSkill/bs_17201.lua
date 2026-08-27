local bs_17201 = class("bs_17201", LuaSkillBase)
local base = LuaSkillBase
bs_17201.config = {
  role_mode_tag = 2,
  summontag = 3,
  roletag = 2,
  buffid_counter = 107801
}

function bs_17201:ctor()
end

function bs_17201:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable.Kurisu_Mode = self.config.role_mode_tag
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_17201_1", 1, self.OnAfterBattleStart)
  self:AddSetHurtTrigger("bs_17201_2", 2, self.OnSetHurt, self.caster, nil, nil, eBattleRoleBelong.enemy)
  self.num = 0
end

function bs_17201:OnAfterBattleStart()
  self.num = LuaSkillCtrl:GetCacheGold() // self.arglist[3]
  self.damTimer = LuaSkillCtrl:StartTimer(nil, self.arglist[4], self.CallBack, self, -1)
end

function bs_17201:CallBack()
  local num = self.arglist[5] * self.num
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffid_counter, num, nil, false)
end

function bs_17201:OnSetHurt(context)
  if context.hurt_tag == self.config.summontag then
    context.hurt = context.hurt * (1000 + self.arglist[1]) // 1000
  else
    context.hurt = context.hurt * (1000 - self.arglist[2]) // 1000
  end
end

function bs_17201:OnCasterDie()
  base.OnCasterDie(self)
  if self.damTimer then
    self.damTimer:Stop()
    self.damTimer = nil
  end
end

return bs_17201

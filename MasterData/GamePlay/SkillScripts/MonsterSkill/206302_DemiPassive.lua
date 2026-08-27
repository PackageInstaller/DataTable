local bs_206302 = class("bs_206302", LuaSkillBase)
local base = LuaSkillBase
bs_206302.config = {buffId = 32}

function bs_206302:ctor()
end

function bs_206302:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_206302_2", 99, self.OnSetHurt, nil, self.caster)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_206302_1", 1, self.OnAfterBattleStart)
  self.flag650 = true
  self.flag400 = true
end

function bs_206302:OnSetHurt(context)
  if context.target == self.caster and context.hurt > self.caster.hp then
    context.hurt = 0
  end
  if context.target == self.caster then
    context.hurt = context.hurt * 1000 // 3500
  end
end

function bs_206302:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
  local arriveCallBack = BindCallback(self, self.OnArriveAction)
  LuaSkillCtrl:StartTimer(nil, 220, arriveCallBack)
end

function bs_206302:OnArriveAction()
  LuaSkillCtrl:ForceEndBattle(true)
end

function bs_206302:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_206302

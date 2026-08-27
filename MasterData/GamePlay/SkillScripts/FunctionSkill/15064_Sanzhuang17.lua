local bs_15064 = class("bs_15064", LuaSkillBase)
local base = LuaSkillBase
bs_15064.config = {
  effectIdLoop = 10956,
  effectIdHit = 10957,
  effectIdEnd = 10958,
  buffId = 1253
}

function bs_15064:ctor()
end

function bs_15064:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddBeforeAddBuffTrigger("bs_15064_2", 1, self.OnBeforeAddBuff, self.caster)
end

function bs_15064:OnBeforeAddBuff(target, context)
  if target ~= self.caster and context.buff.buffCfg.IsControl then
    local arriveCallBack = BindCallback(self, self.OnArriveAction, target)
    local damageTime = context.buff.durationTime // 15
    LuaSkillCtrl:StartTimer(nil, 15, arriveCallBack, nil, damageTime, 15)
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId, 1, context.buff.durationTime, true)
    local arriveCallBack2 = BindCallback(self, self.OnArriveAction2, target)
    LuaSkillCtrl:StartTimer(nil, context.buff.durationTime, arriveCallBack2)
  end
end

function bs_15064:OnArriveAction2(role)
  LuaSkillCtrl:CallEffect(role, self.config.effectIdEnd, self)
end

function bs_15064:OnArriveAction(role)
  local damageValue = self.caster.maxHp * self.arglist[1] // 1000
  LuaSkillCtrl:RemoveLife(damageValue, self, role, true, nil, true, false, eHurtType.RealDmg)
  LuaSkillCtrl:CallEffect(role, self.config.effectIdHit, self)
end

function bs_15064:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15064

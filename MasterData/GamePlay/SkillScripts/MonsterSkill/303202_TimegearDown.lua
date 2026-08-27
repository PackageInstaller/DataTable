local bs_303202 = class("bs_303202", LuaSkillBase)
local base = LuaSkillBase
bs_303202.config = {
  buffId_timedown = 110161,
  timedownTime = 5,
  effectId1 = 30320201
}

function bs_303202:ctor()
end

function bs_303202:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_303202_1", 1, self.OnAfterBattleStart)
end

function bs_303202:OnAfterBattleStart()
  local collisionEnter = BindCallback(self, self.OnCollisionEnter)
  local collisionExit = BindCallback(self, self.OnCollisionExit)
  LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, self.caster, 100, 0, 14, collisionEnter, nil, collisionExit, nil, false, false, nil, self.caster)
end

function bs_303202:OnCollisionEnter(collider, index, entity)
  LuaSkillCtrl:CallBuff(self, entity, self.config.buffId_timedown, 1, nil, false)
end

function bs_303202:OnCollisionExit(collider, entity)
  LuaSkillCtrl:DispelBuff(entity, self.config.buffId_timedown, 1, nil, false)
end

function bs_303202:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_303202:LuaDispose()
  base.LuaDispose(self)
end

return bs_303202

local bs_303201 = class("bs_303201", LuaSkillBase)
local base = LuaSkillBase
bs_303201.config = {
  buffId_timeup = 110160,
  timeupTime = 5,
  effectId1 = 30320101
}

function bs_303201:ctor()
end

function bs_303201:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_303201_1", 1, self.OnAfterBattleStart)
end

function bs_303201:OnAfterBattleStart()
  local collisionEnter = BindCallback(self, self.OnCollisionEnter)
  local collisionExit = BindCallback(self, self.OnCollisionExit)
  LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, self.caster, 100, 0, 14, collisionEnter, nil, collisionExit, nil, false, false, nil, self.caster)
end

function bs_303201:OnCollisionEnter(collider, index, entity)
  LuaSkillCtrl:CallBuff(self, entity, self.config.buffId_timeup, 1, nil, false)
end

function bs_303201:OnCollisionExit(collider, entity)
  LuaSkillCtrl:DispelBuff(entity, self.config.buffId_timeup, 1, nil, false)
end

function bs_303201:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_303201:LuaDispose()
  base.LuaDispose(self)
end

return bs_303201

local bs_15115 = class("bs_15115", LuaSkillBase)
local base = LuaSkillBase
bs_15115.config = {buffId = 1288}

function bs_15115:ctor()
end

function bs_15115:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_15115_1", 1, self.OnAfterBattleStart)
end

function bs_15115:OnAfterBattleStart()
  local collisionEnter = BindCallback(self, self.OnCollisionEnter)
  local collisionExit = BindCallback(self, self.OnCollisionExit)
  LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, self.caster, 200, 0, eColliderInfluenceType.Enemy, collisionEnter, nil, collisionExit, nil, false, false, nil, self.caster)
end

function bs_15115:OnCollisionEnter(collider, index, entity)
  if entity.intensity == 0 then
    return
  end
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
end

function bs_15115:OnCollisionExit(collider, entity)
  if entity.intensity == 0 then
    return
  end
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 1, nil, true)
end

function bs_15115:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15115

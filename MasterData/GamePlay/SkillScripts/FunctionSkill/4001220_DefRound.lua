local bs_4001220 = class("bs_4001220", LuaSkillBase)
local bs_4001220 = class("bs_4001220", base)
bs_4001220.config = {buffId = 2016}

function bs_4001220:ctor()
end

function bs_4001220:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_4001220_1", 1, self.OnAfterBattleStart)
end

function bs_4001220:OnAfterBattleStart()
  local collisionEnter = BindCallback(self, self.OnCollisionEnter)
  local collisionExit = BindCallback(self, self.OnCollisionExit)
  self.halo_em = LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, self.caster, 100, 0, eColliderInfluenceType.Enemy, collisionEnter, nil, collisionExit, nil, false, false, nil, self.caster)
end

function bs_4001220:OnCollisionEnter(collider, index, entity)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1)
end

function bs_4001220:OnCollisionExit(collider, entity)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, -1)
end

function bs_4001220:OnCasterDie()
  if self.halo_em ~= nil then
    self.halo_em:EndAndDisposeEmission()
    self.halo_em = nil
  end
  base.OnCasterDie(self)
end

function bs_4001220:LuaDispose()
  base.LuaDispose(self)
  self.halo_em = nil
end

return bs_4001220

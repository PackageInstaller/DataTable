local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_603 = class(" bs_603", bs_1)
local base = bs_1
bs_603.config = {
  effectId_pass = 60301,
  radius = 30,
  HurtConfigId = 1,
  hurtTime = 15
}
bs_603.config = setmetatable(bs_603.config, {
  __index = base.config
})

function bs_603:ctor()
end

function bs_603:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_603_1", 1, self.OnAfterBattleStart)
  self.hurtTimers = {}
end

function bs_603:OnAfterBattleStart()
  self.effectHalo = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_pass, self)
  local collisionEnter = BindCallback(self, self.OnCollisionEnter)
  local collisionExit = BindCallback(self, self.OnCollisionExit)
  self.halo = LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, self.caster, self.config.radius, 0, eColliderInfluenceType.Enemy, collisionEnter, nil, collisionExit, nil, false, false, nil, self.caster)
  self.hurt = self.caster.recordTable.hurt
  self.hurt = self.caster.pow * self.hurt // 1000
end

function bs_603:OnCollisionEnter(collider, index, entity)
  if entity.belongNum ~= self.caster.belongNum and self.hurtTimers[entity] == nil then
    self.hurtTimers[entity] = LuaSkillCtrl:StartTimer(nil, self.config.hurtTime, function()
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, entity)
      LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigId, {
        self.hurt
      })
      skillResult:EndResult()
    end, self, -1, self.config.hurtTime)
  end
end

function bs_603:OnCollisionExit(collider, entity)
  if self.hurtTimers[entity] ~= nil then
    self.hurtTimers[entity]:Stop()
    self.hurtTimers[entity] = nil
  end
end

function bs_603:RealPlaySkill(target, data)
  return
end

function bs_603:OnCasterDie()
  base.OnCasterDie(self)
  if self.effectHalo ~= nil then
    self.effectHalo:Die()
    self.effectHalo = nil
  end
  if self.halo ~= nil then
    self.halo:EndAndDisposeEmission()
    self.halo = nil
  end
  for k, v in pairs(self.hurtTimers) do
    v:Stop()
  end
  self.hurtTimers = {}
end

function bs_603:LuaDispose()
  base.LuaDispose(self)
  self.halo = nil
  self.effectHalo = nil
end

return bs_603

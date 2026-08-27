local base = require("GamePlay.SkillScripts.RoleUltSkill.104803_NoraUlt")
local bs_206928 = class("bs_206928", base)
bs_206928.config = {delayInvoke = 20, actionId_start = 1001}
bs_206928.config = setmetatable(bs_206928.config, {
  __index = base.config
})

function bs_206928:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable.EnemyBuffTime = 45
  self.caster.recordTable.BaseMissChance = 15
  self.NoEnemy = false
end

function bs_206928:PlaySkill(data, selectTargetCoord, selectRoles)
  local buffDown = LuaSkillCtrl:GetRoleBuffById(self.caster, self.config.buffId_down)
  if buffDown ~= nil then
    LuaSkillCtrl:CallRoleAction(self.caster, 1042, 1)
    LuaSkillCtrl:CallRoleAction(self.caster, 102, 1)
    LuaSkillCtrl:CallRoleAction(self.caster, 1040, 3)
  else
    LuaSkillCtrl:CallRoleAction(self.caster, 1008, 1)
  end
  self.invokeTimer = self:PlayMonsterUltSkill(40, self.config)
end

function bs_206928:InternalInvoke(data, role)
  base.PlaySkill(self, data)
end

function bs_206928:OnCasterDie()
  if self.invokeTimer ~= nil then
    self.invokeTimer:Stop()
    self.invokeTimer = nil
  end
  base.OnCasterDie(self)
end

return bs_206928

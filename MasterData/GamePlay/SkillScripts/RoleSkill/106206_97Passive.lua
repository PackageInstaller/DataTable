local bs_106204 = require("GamePlay.SkillScripts.RoleSkill.106204_97Passive")
local bs_106206 = class("bs_106206", bs_106204)
local base = bs_106204
bs_106206.config = {weaponLv = 3, buffId_live = 3009}
bs_106206.config = setmetatable(bs_106206.config, {
  __index = base.config
})

function bs_106206:ctor()
end

function bs_106206:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetDeadHurtTrigger("bs_106206_1", 950, self.OnSetDeadHurt, nil, self.caster)
  self.NoDeathTrigger = true
  self.tag = false
end

function bs_106206:OnSetDeadHurt(context)
  local NoDeath = LuaSkillCtrl:RoleContainsBuffFeature(context.target, eBuffFeatureType.NoDeath)
  if self:IsReadyToTake() and context.target == self.caster and context.target:GetBuffTier(self.config.nanaka_buffId) <= 0 and NoDeath == false and self.NoDeathTrigger then
    LuaSkillCtrl:CallBuff(self, context.target, self.config.buffId_live, 1, 1, true)
    self.tag = true
    local grid = LuaSkillCtrl:GetGridWithRole(self.caster)
    self:FlashEmptyGridOnDeath()
    self:Summon(grid, nil, true)
    self.NoDeathTrigger = false
    LuaSkillCtrl:StartTimer(self, self.arglist[15], function()
      self.NoDeathTrigger = true
    end)
  end
end

function bs_106206:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender.belongNum == self.caster.belongNum and isCrit and not isTriggerSet then
    self.num = self.num + 1
    if self.num >= self.arglist[1] and not self.caster.recordTable.IsInSkill1 and not LuaSkillCtrl:RoleContainsBuffFeature(self.caster, eBuffFeatureType.Stun) then
      self:Passive()
    end
  end
  if target == self.caster and self.tag then
    local num = (table.count(self.table) + 1) * self.caster.maxHp * self.arglist[16] // 1000
    LuaSkillCtrl:CallHeal(num, self, self.caster, true)
    self.tag = false
  end
end

function bs_106206:FlashEmptyGridOnDeath()
  local tempTable = {}
  local grids = LuaSkillCtrl:FindEmptyGridsWithinRange(self.caster.x, self.caster.y, 3)
  if grids == nil then
    return
  end
  for i = 0, grids.Count - 1 do
    local grid = grids[i]
    local pos = BattleUtil.XYCoord2Pos(grid.x, grid.y)
    if tempTable[pos] == nil then
      tempTable[pos] = LuaSkillCtrl:GetGridsDistance(grid.x, grid.y, self.caster.x, self.caster.y)
    end
  end
  local resultGridPos
  local minDis = 99
  for k, v in pairs(tempTable) do
    if v ~= nil then
      if v == 3 then
        resultGridPos = k
        minDis = v
        break
      elseif resultGridPos == nil or v < minDis then
        resultGridPos = k
        minDis = v
      end
    end
  end
  if resultGridPos ~= nil then
    local coordX, coordY = BattleUtil.Pos2XYCoord(resultGridPos)
    local resultGrid = LuaSkillCtrl:GetGridWithPos(coordX, coordY)
    LuaSkillCtrl:SetRolePos(resultGrid, self.caster, false)
    LuaSkillCtrl:StartTimer(self, 5, function()
      if self.caster.recordTable.lastAttackRole ~= nil then
        self.caster:LookAtTarget(self.caster.recordTable.lastAttackRole)
      end
    end, self)
  end
end

function bs_106206:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_106206

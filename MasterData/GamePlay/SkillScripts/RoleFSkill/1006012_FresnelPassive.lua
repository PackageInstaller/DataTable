local base = require("GamePlay.SkillScripts.RoleFSkill.FakeCommonPassive")
local bs_1006012 = class("bs_1006012", base)
bs_1006012.config = {
  effectId_up = 100606,
  effectId_down = 100607,
  buffId_invisible = 3004
}

function bs_1006012:ctor()
end

function bs_1006012:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_1006012_2", 1, self.OnSetHurt, nil, self.caster)
end

function bs_1006012:OnSetHurt(context)
  if context.hurt <= 0 then
    return
  end
  if 0 < self.caster:GetBuffTier(1214) then
    return
  end
  if not self:IsReadyToTake() then
    return
  end
  context.hurt = context.hurt * (1000 - self.arglist[1]) // 1000
  if context.hurt < 0 then
    context.hurt = 0
  end
  local grid
  if context.sender.belongNum ~= self.caster.belongNum and LuaSkillCtrl:GetRoleGridsDistance(self.caster, context.sender) == 1 then
    grid = self:findGrid(self.caster, context.sender)
  end
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_up, self)
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  if grid ~= nil then
    LuaSkillCtrl:SetRolePos(grid, self.caster)
  end
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_invisible, 1, self.arglist[2])
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_down, self)
  self:OnSkillTake()
end

function bs_1006012:findGrid(caster, sender)
  local grid
  if caster.x ~= 0 then
    grid = LuaSkillCtrl:FindEmptyGrid(function(x, y)
      return y == caster.y and x == caster.x - 1
    end)
    if grid ~= nil then
      return grid
    end
  end
  if grid == nil and caster.x == 0 then
    grid = LuaSkillCtrl:FindEmptyGrid(function(x, y)
      return x == caster.x and (y == caster.y - 1 or y == caster.y + 1)
    end)
    return grid
  end
  if caster.y & 1 == 0 then
    grid = LuaSkillCtrl:FindEmptyGrid(function(x, y)
      return x == caster.x - 1 and (y == caster.y - 1 or y == caster.y + 1)
    end)
  elseif caster.y & 1 == 1 then
    grid = LuaSkillCtrl:FindEmptyGrid(function(x, y)
      return x == caster.x and (y == caster.y - 1 or y == caster.y + 1)
    end)
  end
  return grid
end

function bs_1006012:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_1006012

local bs_100601 = class("bs_100601", LuaSkillBase)
local base = LuaSkillBase
bs_100601.config = {
  effectId_up = 100606,
  effectId_down = 100607,
  weaponLv = 0,
  buffId_invisible = 3004,
  buffId_attackUp = 100603
}

function bs_100601:ctor()
end

function bs_100601:InitSkill(isMidwaySkill)
  self:AddSetHurtTrigger("bs_100601_2", 1, self.OnSetHurt, nil, self.caster)
end

function bs_100601:OnSetHurt(context)
  if context.target == self.caster and self:IsReadyToTake() and context.hurt ~= 0 and self.caster:GetBuffTier(1214) == 0 then
    context.hurt = context.hurt * (1000 - self.arglist[1]) // 1000
    if context.hurt < 0 then
      context.hurt = 0
    end
    local debuffs = LuaSkillCtrl:GetRoleBuffs(self.caster)
    if 0 < debuffs.Count then
      for i = 0, debuffs.Count - 1 do
        if debuffs[i].buffType == 2 then
          LuaSkillCtrl:DispelBuff(self.caster, debuffs[i].dataId, 0)
        end
      end
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
    if 2 <= self.config.weaponLv then
      LuaSkillCtrl:CallReFillMainSkillCdForRole(self.caster)
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_attackUp, 1, self.arglist[4])
    end
    self:OnSkillTake()
  end
end

function bs_100601:findGrid(caster, sender)
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

function bs_100601:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_100601

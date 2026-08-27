local bs_4040 = class("bs_4040", LuaSkillBase)
local base = LuaSkillBase
bs_4040.config = {buffId = 40401}

function bs_4040:ctor()
end

function bs_4040:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRolePhaseMoveStart, self.OnRolePhaseMoveStart)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRoleSplash, self.OnRoleSplash)
  self.passiveCd = 0
end

function bs_4040:OnRoleSplash(role)
  if role.belongNum == self.caster.belongNum and role == self.caster then
    self:Dodamage()
  end
end

function bs_4040:OnRolePhaseMoveStart(role, luaskill)
  if role.belongNum == self.caster.belongNum and role == self.caster then
    self:Dodamage()
  end
end

function bs_4040:Dodamage()
  local battleCtrl = LuaSkillCtrl.battleCtrl
  local curFrame = battleCtrl.frame
  if curFrame < self.passiveCd then
    return
  end
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
  local grid = LuaSkillCtrl:GetGridWithRole(self.caster)
  if grid ~= nil then
    LuaSkillCtrl:CallCreateEfcGrid(grid.coord.x, grid.coord.y, 1138)
  end
  self.passiveCd = curFrame + self.arglist[2]
end

function bs_4040:LuaDispose()
  base.LuaDispose(self)
end

function bs_4040:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4040

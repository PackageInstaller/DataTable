local gs_1129 = class("gs_1129", LuaGridBase)
local base = LuaGridBase
gs_1129.config = {
  buffId_atrr = 210805,
  buffId_hitfly = 130,
  effect_atk = 210809,
  effect_buff = 210908
}

function gs_1129:ctor()
end

function gs_1129:OnGridBattleStart(role)
end

function gs_1129:__OnGridSkillInit()
  self.cskill = self.cEffectGrid.battleSkill
  self.caster = self.cskill.maker
  self.buff_num = 0
end

function gs_1129:OnGridEnterRole(role)
  if role.belongNum == eBattleRoleBelong.player then
    LuaSkillCtrl:CallEffect(role, self.config.effect_atk, self)
    LuaSkillCtrl:CallBuff(self, role, self.config.buffId_hitfly, 1, 15)
    local damage = role.maxHp * 300 // 1000
    LuaSkillCtrl:RemoveLife(damage, self, role, true, nil, true, true)
    self:GridLoseEffect()
  end
  if role.recordTable.ptolomaea == true then
    if self.atk ~= nil then
      self.atk:Stop()
      self.atk = nil
    end
    local tar_grid = LuaSkillCtrl:GetGridWithRole(role)
    local targrid = LuaSkillCtrl:GetTargetWithGrid(tar_grid.x, tar_grid.y)
    if self.buff_loop == nil then
      self.buff_loop = LuaSkillCtrl:CallEffect(targrid, self.config.effect_buff, self)
    end
    self.atk = LuaSkillCtrl:StartTimer(nil, 30, function()
      LuaSkillCtrl:CallBuff(self, role, self.config.buffId_atrr, 1, 300)
      self.buff_num = self.buff_num + 1
      if self.buff_num == 10 then
        self:GridLoseEffect()
        if self.atk ~= nil then
          self.atk:Stop()
          self.atk = nil
        end
        if self.buff_loop ~= nil then
          self.buff_loop:Die()
          self.buff_loop = nil
        end
      end
    end, nil, -1, 30)
  end
end

function gs_1129:OnGridExitRole(role)
  if self.atk ~= nil then
    self.atk:Stop()
    self.atk = nil
  end
  if self.buff_loop ~= nil then
    self.buff_loop:Die()
    self.buff_loop = nil
  end
  base.OnGridExitRole(self, role)
end

function gs_1129:LuaDispose()
  if self.atk ~= nil then
    self.atk:Stop()
    self.atk = nil
  end
  if self.buff_loop ~= nil then
    self.buff_loop:Die()
    self.buff_loop = nil
  end
  base.LuaDispose(self)
end

return gs_1129

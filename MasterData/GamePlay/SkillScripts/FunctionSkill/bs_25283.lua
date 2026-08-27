local bs_25283 = class("bs_25283", LuaSkillBase)
local base = LuaSkillBase
bs_25283.config = {buffId_1 = 2073}

function bs_25283:ctor()
end

function bs_25283:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_25283", 1, self.AfterBattleStart)
  self.grid = nil
  self.timer = nil
end

function bs_25283:AfterBattleStart()
  if self.caster.roleDataId == 116 then
    return
  end
  local gridCheck = BindCallback(self, self.checkLocation)
  self.grid = LuaSkillCtrl:GetGridWithRole(self.caster)
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], gridCheck, nil, -1)
end

function bs_25283:checkLocation()
  local grid_old = self.grid
  local grid_new = LuaSkillCtrl:GetGridWithRole(self.caster)
  if grid_old == nil or grid_new == nil then
    return
  end
  if grid_old ~= grid_new then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_1, 0, false, false)
    LuaSkillCtrl:CallStartLocalScale(self.caster, Vector3.New(1.0, 1.0, 1.0), 0.4)
    self.grid = grid_new
    return
  end
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_1, 1, nil, false)
  self.grid = grid_new
end

function bs_25283:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

function bs_25283:LuaDispose()
  base.LuaDispose(self)
  self.grid = nil
end

return bs_25283

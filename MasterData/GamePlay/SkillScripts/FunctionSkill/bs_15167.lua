local bs_15167 = class("bs_15167", LuaSkillBase)
local base = LuaSkillBase
bs_15167.config = {effect = 12095, buffId_1 = 2138}

function bs_15167:ctor()
end

function bs_15167:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_15167", 1, self.AfterBattleStart)
  self.grid = nil
  self.timer = nil
end

function bs_15167:AfterBattleStart()
  local gridCheck = BindCallback(self, self.checkLocation)
  self.grid = LuaSkillCtrl:GetGridWithRole(self.caster)
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], gridCheck, nil, -1)
end

function bs_15167:checkLocation()
  local grid_old = self.grid
  local grid_new = LuaSkillCtrl:GetGridWithRole(self.caster)
  if grid_old == nil or grid_new == nil then
    return
  end
  if grid_old ~= grid_new then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0, true, false)
    self.grid = grid_new
    return
  end
  LuaSkillCtrl:CallEffect(self.caster, self.config.effect, self)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_1, 1, nil, true)
  self.grid = grid_new
end

function bs_15167:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

function bs_15167:LuaDispose()
  base.LuaDispose(self)
  self.grid = nil
end

return bs_15167

local QiuSkillBase = require("GamePlay.SkillScripts.FunctionSkill.QiuSkillBase")
local bs_17328 = class("bs_17328", QiuSkillBase)
local base = QiuSkillBase
bs_17328.config = {effect_17328 = 12202, is_reducable = false}
bs_17328.config = setmetatable(bs_17328.config, {
  __index = base.config
})

function bs_17328:ctor()
end

function bs_17328:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_17328", 50, self.OnAfterBattleStart)
  self.grid = nil
  self.timer = nil
  self.effect_17328 = nil
end

function bs_17328:OnAfterBattleStart()
  local plist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  if plist == nil or plist.Count < 1 then
    return
  end
  for i = 0, plist.Count - 1 do
    if 1 < plist[i].attackRange then
      self.grid = {}
      self.grid.x = plist[i].x
      self.grid.y = plist[i].y
      break
    end
  end
  if self.grid == nil then
    self.grid = {}
    self.grid.x = plist[0].x
    self.grid.y = plist[0].y
  end
  self.ToCastBallSkill = BindCallback(self, self.RealCastSkillAUTOBall, self.grid.x, self.grid.y)
  if self.caster.recordTable.bs_30073 then
    self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1] - self.caster.recordTable.bs_30073_time, self.ToCastBallSkill, nil, -1, self.arglist[1] - 7)
  else
    self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], self.ToCastBallSkill, nil, -1, self.arglist[1] - 7)
  end
end

function bs_17328:RealCastSkillAUTOBall(x, y)
  if LuaSkillCtrl:CallRange(1, 1000) <= 200 then
    self:RealCastSkillWUDUBall(x, y)
  elseif LuaSkillCtrl:CallRange(1, 1000) <= 400 then
    self:RealCastSkillBOOMBall(x, y)
  elseif LuaSkillCtrl:CallRange(1, 1000) <= 600 then
    self:RealCastSkillSHANBall(x, y)
  elseif LuaSkillCtrl:CallRange(1, 1000) <= 800 then
    self:RealCastSkillDEFBall(x, y)
  else
    self:RealCastSkillATKBall(x, y)
  end
end

function bs_17328:OnCasterDie()
  base.OnCasterDie(self)
  if self.effect_17328 ~= nil then
    self.effect_17328:Die()
    self.effect_17328 = nil
  end
end

return bs_17328

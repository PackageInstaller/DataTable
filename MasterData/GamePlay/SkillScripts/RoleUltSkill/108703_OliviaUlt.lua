local bs_108703 = class("bs_108703", LuaSkillBase)
local base = LuaSkillBase
bs_108703.config = {
  buff_1 = 108706,
  buff_2 = 108707,
  effect_1 = 108709,
  audioIdStart = 108707,
  audioIdMovie = 108708,
  audioIdEnd = 108709
}

function bs_108703:ctor()
end

function bs_108703:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_108703:PlaySkill(data, selectTargetCoord, selectRoles)
  local list = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  for i = 0, list.Count - 1 do
    local role = list[i]
    LuaSkillCtrl:CallBuff(self, role, self.config.buff_1, 1, self.arglist[3])
    LuaSkillCtrl:CallBuff(self, role, self.config.buff_2, 1, self.arglist[3])
  end
  local centerPosGrid = LuaSkillCtrl:GetMapCenterPos()
  local centerTarget = LuaSkillCtrl:GetTargetWithGrid(centerPosGrid.x, centerPosGrid.y)
  self.effect = LuaSkillCtrl:CallEffect(centerTarget, self.config.effect_1, self)
  LuaSkillCtrl:StartTimer(nil, self.arglist[3], function()
    if self.effect ~= nil then
      self.effect:Die()
      self.effect = nil
    end
  end, self)
end

function bs_108703:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005, 1)
end

function bs_108703:PlayUltEffect()
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_108703:OnSkipUltView()
  base.OnSkipUltView(self)
end

function bs_108703:OnMovieFadeOut()
  base.OnMovieFadeOut(self)
end

function bs_108703:OnCasterDie()
  base.OnCasterDie(self)
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
end

function bs_108703:LuaDispose()
  base.LuaDispose(self)
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
end

return bs_108703

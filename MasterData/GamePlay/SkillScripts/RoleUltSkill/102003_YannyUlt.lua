local bs_102003 = class("bs_102003", LuaSkillBase)
local base = LuaSkillBase
bs_102003.config = {
  startEffect = 102007,
  buffId = 102003,
  fronttime = 7,
  movieEndRoleActionId = 1006,
  audioIdStart = 102006,
  audioIdMovie = 102007,
  audioIdEnd = 102008
}

function bs_102003:ctor()
end

function bs_102003:InitSkill(isMidwaySkill)
end

function bs_102003:PlaySkill(data)
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CallCasterWait(20)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  if targetList.Count <= 0 then
    return
  end
  local effectTarget = LuaSkillCtrl:GetTargetWithGrid(3, 2)
  LuaSkillCtrl:CallEffect(effectTarget, self.config.startEffect, self, nil, nil, 0.7)
  for i = 0, targetList.Count - 1 do
    LuaSkillCtrl:StartTimer(self, 5, function()
      targetList[i].targetRole.recordTable["102009_UltBuff"] = self.arglist[2]
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetList[i].targetRole)
      LuaSkillCtrl:CallBuff(self, targetList[i].targetRole, self.config.buffId, 1, self.arglist[1])
      skillResult:EndResult()
    end)
  end
end

function bs_102003:PlayUltEffect()
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_102003:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, self.config.fronttime, self.PlayUltMovie, self)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005)
end

function bs_102003:OnMovieFadeOut()
  base.OnMovieFadeOut(self)
end

function bs_102003:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_102003

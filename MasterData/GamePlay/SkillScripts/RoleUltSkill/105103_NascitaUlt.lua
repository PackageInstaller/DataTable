local bs_105103 = class("bs_105103", LuaSkillBase)
local base = LuaSkillBase
bs_105103.config = {
  actionId_end = 1009,
  end_time = 30,
  buffId_ult = 1051031,
  audioIdStart = 105110,
  audioIdMovie = 105111,
  audioIdEnd = 105112
}

function bs_105103:ctor()
end

function bs_105103:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable.ultSkill = self.arglist[4]
  self.caster.recordTable.ultPassive = self.arglist[3]
  self.caster.recordTable.ult_skill = false
end

function bs_105103:PlaySkill(data, selectTargetCoord, selectRoles)
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_ult, 1, self.arglist[1])
  self.caster.recordTable.ult_skill = true
end

function bs_105103:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005, 1)
end

function bs_105103:PlayUltEffect()
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_105103:OnSkipUltView()
  base.OnSkipUltView(self)
end

function bs_105103:OnMovieFadeOut()
  base.OnMovieFadeOut(self)
end

function bs_105103:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_105103:LuaDispose()
  base.LuaDispose(self)
end

return bs_105103

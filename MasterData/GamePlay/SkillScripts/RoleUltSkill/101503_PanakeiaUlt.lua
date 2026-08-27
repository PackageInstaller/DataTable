local bs_101503 = class("bs_101503", LuaSkillBase)
local base = LuaSkillBase
bs_101503.config = {
  buff_keyan = 101501,
  effect_start = 101515,
  effect_loop = 101516,
  audioIdStart = 101508,
  audioIdMovie = 101509,
  audioIdEnd = 101510
}

function bs_101503:ctor()
end

function bs_101503:InitSkill(isMidwaySkill)
end

function bs_101503:PlaySkill(data, selectTargetCoord, selectRoles)
  self:CallCasterWait(20)
  LuaSkillCtrl:StartTimer(self, 7, function()
    LuaSkillCtrl:CallEffect(self.caster, self.config.effect_start, self)
  end, nil)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff_keyan, 1, self.arglist[1], false)
  self.caster.recordTable.Ult_skill_up = self.arglist[3]
  self.caster.recordTable.Ult_pass_up = self.arglist[2]
end

function bs_101503:PlayUltEffect()
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_101503:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005, 1)
end

function bs_101503:OnSkipUltView()
  base.OnSkipUltView(self)
end

function bs_101503:OnMovieFadeOut()
  LuaSkillCtrl:CallBackViewTimeLine(self.caster, true)
  base.OnMovieFadeOut(self)
end

function bs_101503:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_101503:LuaDispose()
  base.LuaDispose(self)
end

return bs_101503

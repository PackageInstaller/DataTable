local bs_104003 = class("bs_104003", LuaSkillBase)
local base = LuaSkillBase
bs_104003.config = {
  buff_xinruo2 = 104002,
  buff_shenghua3 = 104003,
  effect_ZD = 104006,
  audioIdStart = 104004,
  audioIdMovie = 104005,
  audioIdEnd = 104006
}

function bs_104003:ctor()
end

function bs_104003:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_104003:PlaySkill(data, selectTargetCoord, selectRoles)
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CallCasterWait(20)
  local inputTarget = LuaSkillCtrl:GetTargetWithGrid(selectTargetCoord.x, selectTargetCoord.y)
  self.caster:LookAtTarget(inputTarget)
  self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute))
end

function bs_104003:CallSelectExecute(role)
  if role ~= nil then
    if role.belongNum == eBattleRoleBelong.player then
      LuaSkillCtrl:CallEffect(role, self.config.effect_ZD, self, self.SkillEventFuncPlayer)
    end
    if role.belongNum == eBattleRoleBelong.enemy then
      LuaSkillCtrl:CallEffect(role, self.config.effect_ZD, self, self.SkillEventFuncEnemy)
    end
  end
end

function bs_104003:SkillEventFuncPlayer(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:CallBuff(self, target.targetRole, self.config.buff_shenghua3, 1, self.arglist[1], false)
  end
end

function bs_104003:SkillEventFuncEnemy(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:CallBuff(self, target.targetRole, self.config.buff_xinruo2, 1, self.arglist[2], false)
  end
end

function bs_104003:PlayUltEffect()
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_104003:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005, 1)
end

function bs_104003:OnSkipUltView()
  base.OnSkipUltView(self)
end

function bs_104003:OnMovieFadeOut()
  LuaSkillCtrl:CallBackViewTimeLine(self.caster, true)
  base.OnMovieFadeOut(self)
end

function bs_104003:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_104003

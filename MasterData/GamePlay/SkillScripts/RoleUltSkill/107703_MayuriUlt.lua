local bs_107703 = class("bs_107703", LuaSkillBase)
local base = LuaSkillBase
bs_107703.config = {
  buffId_wupa = 107703,
  effectId_cast = 107708,
  audioIdStart = 107709,
  audioIdMovie = 107710,
  audioIdEnd = 107711,
  buffid = 107704
}

function bs_107703:ctor()
end

function bs_107703:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable.RecoverHeal_times = self.arglist[5]
end

function bs_107703:PlaySkill(data)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_cast, self)
  local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  if targetList.Count > 0 then
    for i = 0, targetList.Count - 1 do
      local role = targetList[i]
      if role ~= nil and 0 < role.hp and role.roleType ~= eBattleRoleType.realSummoner then
        LuaSkillCtrl:CallBuff(self, targetList[i], self.config.buffId_wupa, 1)
      end
    end
  end
  LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.OnMayuriUlt, self.arglist[1], self.arglist[2])
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffid, 1, nil, true)
end

function bs_107703:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005, 0.8)
end

function bs_107703:PlayUltEffect()
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_107703:OnSkipUltView()
  base.OnSkipUltView(self)
end

function bs_107703:OnMovieFadeOut()
  base.OnMovieFadeOut(self)
end

function bs_107703:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_107703:LuaDispose()
  base.LuaDispose(self)
end

return bs_107703

local bs_109303 = class("bs_109303", LuaSkillBase)
local base = LuaSkillBase
bs_109303.config = {
  buffId_1 = 109303,
  buffId_stun = 109304,
  effectId_cast = 109307,
  audioIdStart = 109305,
  audioIdMovie = 109306,
  audioIdEnd = 109307
}

function bs_109303:ctor()
end

function bs_109303:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_109303:PlaySkill(data)
  self:CallCasterWait(5)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_cast, self)
  local role_list = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  local shieldValue = self.caster.pow * self.arglist[1] // 1000
  if 0 < shieldValue and (role_list ~= nil or 0 < role_list.Count) then
    for i = 0, role_list.Count - 1 do
      local role = role_list[i]
      if role ~= nil and 0 < role.hp and role.roleType == eBattleRoleType.character then
        shieldValue = self.caster.pow * self.arglist[1] // 1000
        local rate = 1 + (self.caster.heal + role.treatment) / 1000
        if rate < 0.1 then
          rate = 0.1
        end
        shieldValue = shieldValue * rate * 1000 // 1000
        LuaSkillCtrl:AddRoleShield(role, eShieldType.Normal, shieldValue)
      end
    end
  end
  local enemyList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  if 0 < enemyList.Count then
    for i = 0, enemyList.Count - 1 do
      local role = enemyList[i].targetRole
      local num = role._curHp * self.arglist[2] // 1000
      if 0 < num then
        LuaSkillCtrl:RemoveLife(num, self, role, true, nil, false, true, eHurtType.RealDmg, true)
        LuaSkillCtrl:AddRoleShield(role, eShieldType.Normal, num)
      end
      LuaSkillCtrl:CallBuff(self, role, self.config.buffId_1, 1, self.arglist[4])
      LuaSkillCtrl:CallBuff(self, role, self.config.buffId_stun, 1, self.arglist[4])
    end
  end
end

function bs_109303:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005, 0.8)
end

function bs_109303:PlayUltEffect()
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_109303:OnSkipUltView()
  base.OnSkipUltView(self)
end

function bs_109303:OnMovieFadeOut()
  base.OnMovieFadeOut(self)
end

function bs_109303:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_109303:LuaDispose()
  base.LuaDispose(self)
end

return bs_109303

local bs_10803 = class("bs_10803", LuaSkillBase)
local base = LuaSkillBase
bs_10803.config = {
  effectId_start = 101808,
  buff_Up = 101804,
  actionId_start = 1005,
  movieEndRoleActionId = 1002,
  audioIdStart = 101806,
  audioIdMovie = 101807,
  audioIdEnd = 101808
}

function bs_10803:ctor()
end

function bs_10803:InitSkill(isMidwaySkill)
end

function bs_10803:PlaySkill(data, selectTargetCoord, selectRoles, selectRolesType)
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CallCasterWait(20)
  selectRolesType = selectRolesType or SelectRolesType.CsBattleRoleList
  local role
  if selectRolesType == SelectRolesType.CsBattleRoleList then
    if selectRoles == nil or selectRoles.Count <= 0 then
      return
    end
    role = selectRoles[0]
  else
    role = selectRoles
  end
  LuaSkillCtrl:StartTimer(self, 3, function(selectRole)
    if selectRole ~= nil then
      LuaSkillCtrl:CallEffect(selectRole, self.config.effectId_start, self, nil, nil, 1, true)
    end
  end, role)
  self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute), selectRolesType)
end

function bs_10803:CallSelectExecute(role)
  if role == nil or role.hp <= 0 then
    return
  end
  if role.belongNum == self.caster.belongNum then
    local hurt = role.hp * self.arglist[2] // 1000
    if hurt < role.hp and hurt ~= 0 then
      LuaSkillCtrl:RemoveLife(hurt, self, role, false, nil, false, true, eHurtType.RealDmg)
    end
    LuaSkillCtrl:CallBuff(self, role, self.config.buff_Up, 1, self.arglist[1], false)
  end
end

function bs_10803:PlayUltEffect()
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_10803:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie, self)
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_start)
end

function bs_10803:OnSkipUltView()
  base.OnSkipUltView(self)
end

function bs_10803:OnMovieFadeOut()
  base.OnMovieFadeOut(self)
end

function bs_10803:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10803

local bs_108603 = class("bs_108603", LuaSkillBase)
local base = LuaSkillBase
bs_108603.config = {
  HurtConfigID = 3,
  buffId = 108603,
  effectId_cast = 108609,
  effectId_hit = 108608,
  effectId_hit02 = 108616,
  audioIdStart = 108608,
  audioIdMovie = 108609,
  audioIdEnd = 108610
}

function bs_108603:ctor()
end

function bs_108603:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_108603:PlaySkill(data, selectTargetCoord, selectRoles)
  self:CallCasterWait(20)
  self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute))
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_cast, self)
end

function bs_108603:CallSelectExecute(role)
  if role ~= nil and role.belongNum ~= self.caster.belongNum and not role:IsUnSelect(self.caster) then
    self:RealPlaySkill(role)
  end
end

function bs_108603:RealPlaySkill(target)
  local playerList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  if playerList.Count > 0 then
    for i = 0, playerList.Count - 1 do
      local role = playerList[i]
      if role ~= nil and 0 < role.hp then
        LuaSkillCtrl:CallBuff(self, role, self.config.buffId, 1, self.arglist[5])
      end
    end
  end
  local playerList1 = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  local extra = 0
  if playerList1.Count > 0 and playerList.Count > playerList1.Count then
    extra = math.min(playerList.Count - playerList1.Count, self.arglist[3])
  end
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
  LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID, {
    self.arglist[1] + extra * self.arglist[2]
  })
  skillResult:EndResult()
  LuaSkillCtrl:CallEffect(target, self.config.effectId_hit, self)
end

function bs_108603:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005, 0.8)
end

function bs_108603:PlayUltEffect()
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_108603:OnSkipUltView()
  base.OnSkipUltView(self)
end

function bs_108603:OnMovieFadeOut()
  base.OnMovieFadeOut(self)
end

function bs_108603:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_108603:LuaDispose()
  base.LuaDispose(self)
end

return bs_108603

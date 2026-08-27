local bs_105303 = class("bs_105303", LuaSkillBase)
local base = LuaSkillBase
bs_105303.config = {
  effectId = 105315,
  effectId_end = 105317,
  buffId = 105302,
  HurtConfigID = 3,
  audioIdStart = 105309,
  audioIdMovie = 105316,
  audioIdEnd = 105306
}

function bs_105303:ctor()
end

function bs_105303:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable.energy_Ult = self.arglist[4]
  self:AddBuffDieTrigger("bs_105303_buff_die", 1, self.OnBuffDie, nil, nil, self.config.buffId)
end

function bs_105303:PlaySkill(data, selectTargetCoord, selectRoles)
  self:CallCasterWait(20)
  self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute))
end

function bs_105303:CallSelectExecute(role)
  if role ~= nil and role.belongNum ~= self.caster.belongNum and not role:IsUnSelect(self.caster) then
    self:RealPlaySkill(role)
  end
end

function bs_105303:RealPlaySkill(target)
  LuaSkillCtrl:CallEffect(target, self.config.effectId, self)
  LuaSkillCtrl:CallBuffRepeated(self, target, self.config.buffId, 1, self.arglist[1], false, false, self.OnBuffExecute)
end

function bs_105303:OnBuffExecute(buff, targetRole)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
  LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID, {
    self.arglist[2] + self.caster.recordTable.energy_num * self.arglist[3]
  })
  skillResult:EndResult()
end

function bs_105303:OnBuffDie(buff, target, removeType)
  if buff.dataId == self.config.buffId then
    LuaSkillCtrl:CallEffect(target, self.config.effectId_end, self)
  end
end

function bs_105303:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005, 1)
end

function bs_105303:PlayUltEffect()
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_105303:OnSkipUltView()
  base.OnSkipUltView(self)
end

function bs_105303:OnMovieFadeOut()
  base.OnMovieFadeOut(self)
end

function bs_105303:OnCasterDie()
  self:CancleCasterWait()
  base.OnCasterDie(self)
end

function bs_105303:LuaDispose()
  base.LuaDispose(self)
end

return bs_105303

local bs_108103 = class("bs_108103", LuaSkillBase)
local base = LuaSkillBase
bs_108103.config = {buffid = 108104, effect_start = 108109}

function bs_108103:ctor()
end

function bs_108103:InitSkill(isMidwaySkill)
end

function bs_108103:PlaySkill(data, selectTargetCoord, selectRoles)
  self:CallCasterWait(20)
  self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute))
end

function bs_108103:CallSelectExecute(role)
  if role ~= nil and role.belongNum == self.caster.belongNum and not role:IsUnSelect(self.caster) then
    self:RealPlaySkill(role)
  end
end

function bs_108103:RealPlaySkill(target)
  LuaSkillCtrl:CallEffect(target, self.config.effect_start, self)
  LuaSkillCtrl:CallBuff(self, target, self.config.buffid, 1, nil)
end

function bs_108103:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005, 1)
end

function bs_108103:PlayUltEffect()
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_108103:OnSkipUltView()
  base.OnSkipUltView(self)
end

function bs_108103:OnMovieFadeOut()
  base.OnMovieFadeOut(self)
end

function bs_108103:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_108103:LuaDispose()
  base.LuaDispose(self)
end

return bs_108103

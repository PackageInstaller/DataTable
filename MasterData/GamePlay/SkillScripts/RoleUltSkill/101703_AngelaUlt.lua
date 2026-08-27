local bs_101703 = class("bs_101703", LuaSkillBase)
local base = LuaSkillBase
bs_101703.config = {
  effectMap = 101708,
  effectBuff = 101712,
  buffExile = 279,
  buffDragon = 101702,
  movieEndRoleActionId = 1006,
  audioIdStart = 346,
  audioIdMovie = 347,
  audioIdEnd = 348,
  buffId = 3014
}

function bs_101703:ctor()
end

function bs_101703:InitSkill(isMidwaySkill)
  if LuaSkillCtrl.IsInTDBattle and LuaSkillCtrl.cluaSkillCtrl ~= nil then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 1, true, true)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
  end
end

function bs_101703:PlaySkill(data, selectTargetCoord, selectRoles)
  self:CallCasterWait(20)
  self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute))
end

function bs_101703:CallSelectExecute(role)
  if role ~= nil and role.belongNum ~= self.caster.belongNum and not role:IsUnSelect(self.caster) then
    self:RealPlaySkill(role)
  end
end

function bs_101703:RealPlaySkill(target)
  local effectTarget = LuaSkillCtrl:GetTargetWithGrid(3, 2)
  self.effectMap = LuaSkillCtrl:CallEffect(effectTarget, self.config.effectMap, self)
  LuaSkillCtrl:StartTimer(self, self.arglist[1], function()
    if self.effectMap ~= nil then
      self.effectMap:Die()
      self.effectMap = nil
    end
  end)
  LuaSkillCtrl:CallEffect(target, self.config.effectBuff, self)
  LuaSkillCtrl:CallBuff(self, target, self.config.buffDragon, self.arglist[3], self.arglist[1])
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  if targetList ~= nil and targetList.Count > 0 then
    for i = 0, targetList.Count - 1 do
      if targetList[i].targetRole ~= target and targetList[i].targetRole.belongNum ~= eBattleRoleBelong.neutral then
        LuaSkillCtrl:CallBuff(self, targetList[i].targetRole, self.config.buffExile, 1, self.arglist[1])
      end
    end
  end
end

function bs_101703:PlayUltEffect()
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_101703:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 15, self.PlayUltMovie, self)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005)
end

function bs_101703:OnMovieFadeOut()
  base.OnMovieFadeOut(self)
end

function bs_101703:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_101703:LuaDispose()
  base.LuaDispose(self)
  self.effectMap = nil
end

return bs_101703

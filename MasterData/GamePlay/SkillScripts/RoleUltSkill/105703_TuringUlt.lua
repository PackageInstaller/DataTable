local bs_105703 = class("bs_105703", LuaSkillBase)
local base = LuaSkillBase
bs_105703.config = {
  buffId_skill_intensity_Shield = 105704,
  buffId_pow_Shield = 105703,
  effectId = 105712,
  audioIdStart = 105709,
  audioIdMovie = 105710,
  audioIdEnd = 105711
}

function bs_105703:ctor()
end

function bs_105703:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_105703:PlaySkill(data, selectTargetCoord, selectRoles)
  self:CallCasterWait(20)
  self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute))
end

function bs_105703:CallSelectExecute(role)
  if role ~= nil and role.belongNum ~= self.caster.belongNum and not role:IsUnSelect(self.caster) then
    self:RealPlaySkill(role)
  end
end

function bs_105703:RealPlaySkill(target)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self, nil)
  local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  if targetList.Count > 0 then
    if target.skill_intensity > target.pow then
      for i = 0, targetList.Count - 1 do
        if targetList[i].recordTable.WillowPic ~= true then
          LuaSkillCtrl:CallBuff(self, targetList[i], self.config.buffId_skill_intensity_Shield, 1, self.arglist[1])
          local shieldValue = self.caster.skill_intensity * self.arglist[2] // 1000
          if 0 < shieldValue then
            LuaSkillCtrl:AddRoleShield(targetList[i], eShieldType.Normal, shieldValue)
          end
        end
      end
    else
      for i = 0, targetList.Count - 1 do
        if targetList[i].recordTable.WillowPic ~= true then
          LuaSkillCtrl:CallBuff(self, targetList[i], self.config.buffId_pow_Shield, 1, self.arglist[1])
          local shieldValue = self.caster.skill_intensity * self.arglist[2] // 1000
          if 0 < shieldValue then
            LuaSkillCtrl:AddRoleShield(targetList[i], eShieldType.Normal, shieldValue)
          end
        end
      end
    end
  end
end

function bs_105703:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005, 0.8)
end

function bs_105703:PlayUltEffect()
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_105703:OnSkipUltView()
  base.OnSkipUltView(self)
end

function bs_105703:OnMovieFadeOut()
  base.OnMovieFadeOut(self)
end

function bs_105703:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_105703:LuaDispose()
  base.LuaDispose(self)
end

return bs_105703

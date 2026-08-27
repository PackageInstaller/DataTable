local bs_109103 = class("bs_109103", LuaSkillBase)
local base = LuaSkillBase
bs_109103.config = {
  buff_stun = 109102,
  effectId_hit1 = 109109,
  effectId_hit2 = 109110,
  HurtConfigId = 25,
  audioIdStart = 109107,
  audioIdMovie = 109108,
  audioIdEnd = 109109
}

function bs_109103:ctor()
end

function bs_109103:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.OnBtRoleBreakStateEnter, "bs_109103_01", 1, self._OnEnterBreak)
  self.skillMode = false
end

function bs_109103:PlaySkill(data, selectTargetCoord, selectRoles)
  self.skillMode = true
  self:CallCasterWait(5)
  if selectTargetCoord ~= nil then
    local targetGrid = LuaSkillCtrl:GetTargetWithGrid(selectTargetCoord.x, selectTargetCoord.y)
    LuaSkillCtrl:CallEffect(targetGrid, self.config.effectId_hit1, self)
    local targetlist = LuaSkillCtrl:FindAllRolesWithinRange(targetGrid, 1, true)
    if targetlist ~= nil and targetlist.Count > 0 then
      for i = 0, targetlist.Count - 1 do
        local role = targetlist[i]
        if role.belongNum ~= eBattleRoleBelong.player then
          LuaSkillCtrl:CallBuff(self, role, self.config.buff_stun, 1, self.arglist[2])
          local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
          LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigId, {
            self.arglist[1]
          })
          skillResult:EndResult()
          local breakComponent = role:GetBreakComponent()
          if breakComponent == nil then
            self:ExtraDamage(role)
          end
        end
      end
    end
    self.skillMode = false
  end
end

function bs_109103:_OnEnterBreak(role)
  if role.belongNum == eBattleRoleBelong.enemy and role.hp > 0 and self.skillMode then
    self:ExtraDamage(role)
  end
end

function bs_109103:ExtraDamage(role)
  LuaSkillCtrl:CallEffect(role, self.config.effectId_hit2, self)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
  LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigId, {
    self.arglist[3]
  })
  skillResult:EndResult()
end

function bs_109103:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005)
end

function bs_109103:OnMovieFadeOut()
  base.OnMovieFadeOut(self)
end

function bs_109103:PlayUltEffect()
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_109103:OnSkipUltView()
  base.OnSkipUltView(self)
end

function bs_109103:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_109103:LuaDispose()
  base.LuaDispose(self)
end

return bs_109103

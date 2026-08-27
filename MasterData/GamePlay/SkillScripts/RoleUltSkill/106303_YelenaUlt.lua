local bs_106303 = class("bs_106303", LuaSkillBase)
local base = LuaSkillBase
bs_106303.config = {
  effect_trail = 106319,
  effectId = 106321,
  effectId_hit = 106320,
  effectId_hit2 = 106322,
  effectId_mark = 106323,
  HurtConfigID = 25,
  HurtConfigID_1 = 17,
  audioIdStart = 106312,
  audioIdMovie = 106313,
  audioIdEnd = 106314
}

function bs_106303:ctor()
end

function bs_106303:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_106303_1", 1, self.OnAfterBattleStart)
  self:AddTrigger(eSkillTriggerType.BeforeBattleEnd, "bs_106303_2", 1, self.OnBeforeBattleEnd)
end

function bs_106303:OnAfterBattleStart()
  self._OnUltSkillClick = BindCallback(self, self.OnUltSkillClick)
  MsgCenter:AddListener(eMsgEventId.OnUltSkillClick, self._OnUltSkillClick)
end

function bs_106303:OnBeforeBattleEnd()
  MsgCenter:RemoveListener(eMsgEventId.OnUltSkillClick, self._OnUltSkillClick)
end

function bs_106303:PlaySkill(data, selectTargetCoord, selectRoles)
  self:CallCasterWait(20)
  self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute))
end

function bs_106303:OnUltSkillClick(skill)
  if skill == self.cskill then
    local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
    for i = 0, targetList.Count - 1 do
      local tar = targetList[i]
      local hpRate = tar._curHp * 1000 // tar.maxHp
      if targetList[i] ~= nil and hpRate <= self.arglist[1] and tar.intensity ~= 3 and tar.intensity ~= 4 then
        LuaSkillCtrl:CallEffect(targetList[i], self.config.effectId_mark, self)
      end
    end
  end
end

function bs_106303:CallSelectExecute(role)
  if role ~= nil and role.belongNum ~= self.caster.belongNum and not role:IsUnSelect(self.caster) then
    self:RealPlaySkill(role)
  end
end

function bs_106303:RealPlaySkill(target)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self)
  LuaSkillCtrl:CallEffectWithArgOverride(target, self.config.effect_trail, self, self.caster, nil, nil, self.SkillEventFunc)
end

function bs_106303:SkillEventFunc(effect, eventId, target)
  if effect.dataId == self.config.effect_trail and eventId == eBattleEffectEvent.Trigger then
    local tar = target.targetRole
    local hpRate = tar._curHp * 1000 // tar.maxHp
    if tar.intensity ~= 3 and tar.intensity ~= 4 and hpRate <= self.arglist[1] then
      LuaSkillCtrl:CallEffect(target, self.config.effectId_hit, self)
      local IfRoleCotainsIgnoreDieBuff = LuaSkillCtrl:RoleContainsBuffFeature(tar, self.config.buffFeature_ignoreDie)
      if IfRoleCotainsIgnoreDieBuff == true then
        local buff_ignoreDie = LuaSkillCtrl:GetRoleAllBuffsByFeature(tar, self.config.buffFeature_ignoreDie)
        if buff_ignoreDie.Count > 0 then
          for i = 0, buff_ignoreDie.Count - 1 do
            LuaSkillCtrl:DispelBuff(tar, buff_ignoreDie[i].dataId, 0)
            IfRoleCotainsIgnoreDieBuff = false
          end
        end
      end
      if 0 < tar.hp and IfRoleCotainsIgnoreDieBuff == false then
        LuaSkillCtrl:RemoveLife(tar.hp, self, tar, true, nil, false, true, eHurtType.RealDmg, true)
      end
    else
      local pow = self.caster.pow
      local skill_intensity = self.caster.skill_intensity
      if pow >= skill_intensity then
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, tar)
        LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID, {
          self.arglist[2]
        })
        skillResult:EndResult()
        LuaSkillCtrl:CallEffect(target, self.config.effectId_hit2, self)
      else
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, tar)
        LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID_1, {
          self.arglist[2]
        })
        skillResult:EndResult()
        LuaSkillCtrl:CallEffect(target, self.config.effectId_hit2, self)
      end
    end
  end
end

function bs_106303:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005, 1)
end

function bs_106303:PlayUltEffect()
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_106303:OnSkipUltView()
  base.OnSkipUltView(self)
end

function bs_106303:OnMovieFadeOut()
  base.OnMovieFadeOut(self)
end

function bs_106303:OnCasterDie()
  MsgCenter:RemoveListener(eMsgEventId.OnUltSkillClick, self._OnUltSkillClick)
  self:CancleCasterWait()
  base.OnCasterDie(self)
end

function bs_106303:LuaDispose()
  base.LuaDispose(self)
end

return bs_106303

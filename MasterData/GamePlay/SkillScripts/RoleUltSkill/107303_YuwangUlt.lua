local bs_107303 = class("bs_107303", LuaSkillBase)
local base = LuaSkillBase
bs_107303.config = {
  effectId_up = 107309,
  effectId_down = 107310,
  buffId_1000 = 1000,
  buffId_3004 = 3004,
  buffid_stun = 65,
  hurtconfig = 5,
  audioIdStart = 107306,
  audioIdMovie = 107307
}
bs_107303.AbandonTakeFeature = {
  eBuffFeatureType.NotBeSelected,
  eBuffFeatureType.CtrlImmunity,
  eBuffFeatureType.Exiled
}

function bs_107303:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_107303:PlaySkill(data, selectTargetCoord, selectRoles)
  self.targetGrid = LuaSkillCtrl:GetGridWithPos(selectTargetCoord.x, selectTargetCoord.y)
  return self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute))
end

function bs_107303:CallSelectExecute(role)
  if role ~= nil and self.targetGrid ~= nil and role.belongNum == eBattleRoleBelong.enemy then
    LuaSkillCtrl:CallEffect(role, self.config.effectId_up, self)
    LuaSkillCtrl:CallBreakAllSkill(role)
    self:TryResetMoveState(role)
    LuaSkillCtrl:CallBuff(self, role, self.config.buffId_1000, 1, 5, true)
    LuaSkillCtrl:SetRolePos(self.targetGrid, role)
    LuaSkillCtrl:CallEffect(role, self.config.effectId_down, self)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_3004, 1, 5, true)
    local targetlist_enemy = LuaSkillCtrl:FindAllRolesWithinRange(role, 1, true)
    local skill, sender, buffID, tier, decade
    if role ~= nil or role.hp >= 0 then
      local targetbuffs = LuaSkillCtrl:GetRoleBuffs(role)
      for i = 0, targetbuffs.Count - 1 do
        local buff = targetbuffs[i]
        if buff.dataId == 107101 then
          skill = buff.battleSkill
          sender = buff.maker
          buffID = buff.dataId
          tier = buff.tier
          decade = buff.totalTime
        end
      end
    end
    if 0 < targetlist_enemy.Count then
      for i = 0, targetlist_enemy.Count - 1 do
        local targetRole = targetlist_enemy[i]
        if targetRole.belongNum == eBattleRoleBelong.enemy or targetRole.belongNum == eBattleRoleBelong.neutral and not targetRole:IsUnSelect(self.caster) then
          if targetRole ~= role and skill ~= nil then
            LuaSkillCtrl:CallBuffWithOriginSkill(skill, targetRole, buffID, tier, decade, false)
          end
          if targetRole.belongNum ~= eBattleRoleBelong.neutral then
            LuaSkillCtrl:CallBuff(self, targetRole, self.config.buffid_stun, 1, self.arglist[1])
            local buffs = LuaSkillCtrl:GetRoleBuffs(targetRole)
            if buffs ~= nil or 1 <= buffs.Count then
              for i = 0, buffs.Count - 1 do
                local aimbuff = buffs[i]
                if aimbuff.buffType == eBuffType.Beneficial then
                  LuaSkillCtrl:DispelBuff(targetRole, aimbuff.dataId, 0, false)
                end
              end
            end
          end
          local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetlist_enemy[i])
          LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.hurtconfig, {
            self.arglist[2]
          })
          skillResult:EndResult()
        end
      end
    end
  end
end

function bs_107303:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005, 1)
end

function bs_107303:PlayUltEffect(data, selectTargetCoord, selectRoles)
  if selectRoles == nil or selectRoles.Count ~= 1 then
    return true
  end
  local role = selectRoles[0]
  if role ~= nil and 0 < role.hp then
    for i = 1, #self.AbandonTakeFeature do
      if (self.AbandonTakeFeature[i] ~= eBuffFeatureType.AbandonMove or role.recordTable.IngnoreStopMove ~= true) and LuaSkillCtrl:RoleContainsBuffFeature(role, self.AbandonTakeFeature[i]) then
        return true
      end
    end
  end
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_107303:OnSkipUltView()
  base.OnSkipUltView(self)
end

function bs_107303:OnMovieFadeOut()
  base.OnMovieFadeOut(self)
end

function bs_107303:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_107303:LuaDispose()
  base.LuaDispose(self)
  self.targetGrid = nil
end

return bs_107303

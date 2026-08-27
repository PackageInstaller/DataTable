local bs_105203 = class("bs_105203", LuaSkillBase)
local base = LuaSkillBase
bs_105203.config = {
  actionId_start = 1005,
  buffId_Super = 196,
  buff_abandonUlt = 105205,
  buff_efc = 105204,
  effectId_line = 105215,
  speical_ultHeroEffect = "helix/skill/FXP_UltimateSkill_helix",
  audioIdStart = 105212,
  audioIdMovie = 105213,
  audioIdEnd = 105214
}

function bs_105203:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnUltSkillPlayed, self.OnUltSkillPlayed)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_105203_start", 1, self.OnAfterBattleStart)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_105203_start_02", 1, self.OnRoleDie)
  self.lastUltRole = nil
end

function bs_105203:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff_abandonUlt, 1, nil)
  MsgCenter:Broadcast(eMsgEventId.OnCreatSpecialUltHearoEffect, self.cskill.dataId, self.config.speical_ultHeroEffect, true, self.caster.roleDataId)
end

function bs_105203:OnRoleDie(killer, role)
  if role == self.lastUltRole then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff_abandonUlt, 1, nil)
  end
end

function bs_105203:OnUltSkillPlayed(role)
  local isLastUltRoleUltTaked = role == self.lastUltRole
  if role.belongNum == self.caster.belongNum and role ~= self.caster and role.roleType ~= eBattleRoleType.skillCaster then
    self.lastUltRole = role
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buff_abandonUlt, 1)
    if not LuaSkillCtrl.IsInVerify then
      LuaSkillCtrl.cUltSkillCtrl:UpdateUIForce()
    end
    if self.lastUltMp ~= nil then
      local curValue = LuaSkillCtrl:GetUltHMp()
      self.cost = self.cost + self.lastUltMp - curValue
      self.lastUltMp = curValue
      if (isLastUltRoleUltTaked or curValue < ConfigData.game_config.ultMpCost) and self.isShowActiveEff then
        MsgCenter:Broadcast(eMsgEventId.OnHideSpeicalUltHearoEffect, self.cskill.dataId, self.lastUltRole.roleDataId)
        self.isShowActiveEff = false
      end
    end
  end
end

function bs_105203:PlaySkill()
  if self.lastUltRole == nil or self.lastUltRole.hp <= 0 then
    return
  end
  local ultSkill = self.lastUltRole:GetSkillComponent().ultSkill
  if ultSkill == nil then
    return
  end
  ultSkill:ResetCDTimeRatio(100)
  LuaSkillCtrl:CallEffect(self.lastUltRole, self.config.effectId_line, self)
  LuaSkillCtrl:CallBuff(self, self.lastUltRole, self.config.buff_efc, 1, self.arglist[1])
  MsgCenter:Broadcast(eMsgEventId.OnShowSpeicalUltHearoEffect, self.cskill.dataId, self.lastUltRole.roleDataId)
  self.isShowActiveEff = true
  LuaSkillCtrl:CallAddPlayerHmp(ConfigData.game_config.ultMpCost)
  self.lastUltMp = LuaSkillCtrl:GetUltHMp()
  self.cost = self.cost or 0
  if self.returnHmpTimer ~= nil then
    self.returnHmpTimer:Stop()
    self.returnHmpTimer = nil
  end
  self.returnHmpTimer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], function()
    if self.cost < ConfigData.game_config.ultMpCost then
      local subValue = ConfigData.game_config.ultMpCost - self.cost
      self.lastUltMp = nil
      self.cost = nil
      LuaSkillCtrl:CallAddPlayerHmp(-subValue)
    end
    if self.isShowActiveEff then
      MsgCenter:Broadcast(eMsgEventId.OnHideSpeicalUltHearoEffect, self.cskill.dataId, self.lastUltRole.roleDataId)
      self.isShowActiveEff = false
    end
  end)
end

function bs_105203:PlayUltEffect()
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_105203:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 15, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005)
end

function bs_105203:OnMovieFadeOut()
  LuaSkillCtrl:CallBackViewTimeLine(self.caster, true)
  base.OnMovieFadeOut(self)
end

function bs_105203:OnCasterDie()
  base.OnCasterDie(self)
  self.lastUltRole = nil
  self.cost = nil
  if self.returnHmpTimer ~= nil then
    self.returnHmpTimer:Stop()
    self.returnHmpTimer = nil
  end
end

function bs_105203:LuaDispose()
  base.LuaDispose(self)
  self.lastUltRole = nil
  self.lastUltMp = nil
end

return bs_105203

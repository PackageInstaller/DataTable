local bs_20283 = class("bs_20283", LuaSkillBase)
local base = LuaSkillBase
bs_20283.config = {
  MakiseId = 1078,
  HurtBarAdd = 250,
  effect_hit = 1000,
  effect_overCorrode = 12110,
  Makise_Self_Talk = {
    52,
    53,
    54
  },
  Not_Set_Makise = {41, 42},
  Failed_Talk = {
    46,
    47,
    48,
    49,
    51,
    52
  },
  Hitted_Talk = {
    {38, 39},
    {40, 41},
    {42, 43}
  },
  corrod_duration = 60,
  corrod_add = 20,
  effectId_up = 501101,
  effectId_down = 501102,
  buff_xuanyun = 66,
  effect_coorde = 12119,
  CorrodeEffect = 10913,
  CorrodingEffect = 12119
}

function bs_20283:ctor()
end

function bs_20283:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.Makise = self:FindMakise()
  self:AddAfterHurtTrigger("bs_20283", 1, self.OnMakiseHurt, nil, self.Makise, eBattleRoleBelong.enemy, nil, nil, nil, nil, nil, nil)
  self.barProgress = 0
  LuaSkillCtrl:SetGameScoreAcitve(4, true)
  self:GetInitBar()
  LuaSkillCtrl:SetGameScoreValue(4, self.barProgress)
  self.isProtected = false
  if not LuaSkillCtrl.IsInVerify then
    local BuffList = ExplorationManager.dynPlayer.epBuffList
    self.isProtected = false
    for _, Buff in ipairs(BuffList) do
      if Buff.dataId == 21243 then
        self.isProtected = true
        break
      end
    end
  end
  if not self.isProtected then
    self.timer = LuaSkillCtrl:StartTimer(nil, self.config.corrod_duration, BindCallback(self, self.AddBarProcess, self.config.corrod_add), nil, -1)
  end
  self.isAcceptHitDialog = true
  self.effect_corrode = nil
  if self.Makise then
    self.effect_corrode = LuaSkillCtrl:CallEffect(self.Makise, self.config.CorrodingEffect, self)
  end
  self.timer_talk = LuaSkillCtrl:StartTimer(nil, 75, BindCallback(self, self.timer_event), nil, -1)
end

function bs_20283:FindMakise()
  if self.Makise ~= nil then
    return self.Makise
  end
  local target_role
  local roles = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  for i = 0, roles.Count - 1 do
    local roleDataId = roles[i].roleDataId
    if roleDataId == self.config.MakiseId then
      target_role = roles[i]
      break
    end
  end
  if target_role == nil then
    self:PlayerNotSetMisaki()
    return nil
  else
    return target_role
  end
end

function bs_20283:timer_event()
  local isTrue = LuaSkillCtrl:CallRange(0, 1) == 1
  if isTrue then
    local rand = LuaSkillCtrl:CallRange(1, #self.config.Makise_Self_Talk)
    local word = self.config.Makise_Self_Talk[rand]
    LuaSkillCtrl:CallPlayEpTipDialogInBattle(word)
  end
end

function bs_20283:muteAll()
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
  if not LuaSkillCtrl.IsInVerify then
    self.uiBattle = UIManager:GetWindow(UIWindowTypeID.Battle)
    if self.uiBattle ~= nil then
      self.uiBattle:OnSpeedUpChange(1)
    end
  end
  if not LuaSkillCtrl.IsInVerify then
    self.win = UIManager:ShowWindow(UIWindowTypeID.Battle)
    if self.win ~= nil then
      self.win:SetUltAuto(false)
    end
  end
  local costurlnum = 0 - LuaSkillCtrl:GetUltHMp()
  LuaSkillCtrl:CallAddPlayerHmp(costurlnum)
  if self.timer_HMP ~= nil then
    self.timer_HMP:Stop()
    self.timer_HMP = nil
  end
  local pList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  for i = 0, pList.Count - 1 do
    LuaSkillCtrl:CallBuff(self, pList[i], self.config.buff_xuanyun, 1, nil, false, nil, false)
  end
end

function bs_20283:OnMakiseHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if isMiss or target.roleDataId ~= self.config.MakiseId then
    return
  end
  if self.isAcceptHitDialog then
    local rand = LuaSkillCtrl:CallRange(1, #self.config.Hitted_Talk)
    local words = self.config.Hitted_Talk[rand]
    for key, word in ipairs(words) do
      LuaSkillCtrl:StartTimer(nil, 15 * key - 15, function()
        LuaSkillCtrl:CallPlayEpTipDialogInBattle(word)
      end)
    end
    self.isAcceptHitDialog = false
    LuaSkillCtrl:StartTimer(nil, 90, function()
      self.isAcceptHitDialog = true
    end)
  end
  self:OnHurtChangeScreen()
  self:AddBarProcess(self.config.HurtBarAdd)
  LuaSkillCtrl:CallEffect(self.Makise, self.config.CorrodeEffect, self)
end

function bs_20283:GetInitBar()
  local bar = 0
  LuaSkillCtrl:StartTimer(nil, 6, function()
    if self.caster.recordTable.croode_degree ~= nil then
      bar = self.caster.recordTable.croode_degree * 100
    end
    self:AddBarProcess(bar)
  end)
end

function bs_20283:AddBarProcess(add)
  if self.barProgress == nil then
    self.barProgress = 0
  end
  if self.isProtected then
    return
  end
  self.barProgress = self.barProgress + add
  LuaSkillCtrl:SetGameScoreValue(4, self.barProgress)
  local num = 0.6 * self.barProgress / 1000
  LuaSkillCtrl:ShowCameraEffectFunction(7, 0.6)
  if not LuaSkillCtrl.IsInVerify and self.barProgress > 500 then
    self.audio = AudioManager:PlayAudioById(7013)
  end
  if self.barProgress > 999 then
    self:ExtraFailed()
  end
end

function bs_20283:CloseHurtScreen()
  LuaSkillCtrl:CloseCameraEffectFunction(7, nil)
end

function bs_20283:OnHurtChangeScreen()
  LuaSkillCtrl:CallBattleCamShakeByParam(0, 1, 0.5, 50)
end

function bs_20283:ExtraFailed()
  self:muteAll()
  if self.Makise ~= nil then
    LuaSkillCtrl:CallEffect(self.Makise, self.config.effect_overCorrode, self)
    LuaSkillCtrl:CallRoleAction(self.Makise, 1058, 1)
  else
  end
  LuaSkillCtrl:ForceEndBattle(false)
end

function bs_20283:PlayerNotSetMisaki()
end

function bs_20283:LuaDispose()
  base.LuaDispose(self)
  self:CloseHurtScreen()
end

function bs_20283:OnCasterDie()
  base.OnCasterDie(self)
  self:CloseHurtScreen()
  if self.effect_corrode ~= nil then
    self.effect:Die()
    self.effect_corrode = nil
  end
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
  if self.timer_talk ~= nil then
    self.timer_talk:Stop()
    self.timer_talk = nil
  end
  if self.audio ~= nil then
    AudioManager:StopAudioByBack(self.audio)
    self.audio = nil
  end
end

return bs_20283

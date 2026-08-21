_class("UIBattleTeamStateEnter", UICustomWidget)
UIBattleTeamStateEnter = UIBattleTeamStateEnter

function UIBattleTeamStateEnter:Constructor()
  self._sldSpriteNames = {
    Normal = {
      "thread_jingdu1_frame",
      "thread_jingdu2_frame",
      "thread_jingdu3_frame"
    },
    Fire = {
      "thread_jingdu4_frame",
      "thread_jingdu5_frame",
      "thread_jingdu6_frame"
    },
    Stun = {
      "thread_jingdu1_frame",
      "thread_jingdu7_frame",
      "thread_jingdu8_frame"
    },
    Benumb = {
      "thread_jingdu9_frame",
      "thread_jingdu10_frame",
      "thread_jingdu3_frame"
    }
  }
end

function UIBattleTeamStateEnter:OnShow()
  self._hpFill = self:GetUIComponent("Image", "hpFill")
  self._shieldFill = self:GetUIComponent("Image", "shieldFill")
  self._damageFill = self:GetUIComponent("Image", "damageFill")
  self._overfillShieldFill = self:GetUIComponent("Image", "overfillShield")
  self._overfillShieldAnchor = self:GetUIComponent("RectTransform", "overfillShieldAnchor")
  self._sldTeamState = self:GetUIComponent("Slider", "sldTeamState")
  self._imgSldBG = self:GetUIComponent("Image", "imgSldBG")
  self._imgSldFill = self:GetUIComponent("Image", "imgSldFill")
  self._imgSldFollow = self:GetUIComponent("Image", "imgSldFollow")
  self._teamStateTxt = self:GetUIComponent("UILocalizationText", "TeamStateText")
  self._teamStateNumberTxt = self:GetUIComponent("UILocalizationText", "TeamStateNumberText")
  self._imgLogo = self:GetUIComponent("RawImageLoader", "imgLogo")
  self._teamStateGO = self:GetGameObject("TeamState").transform.parent
  self._atlas = self:GetAsset("UIBattle.spriteatlas", LoadType.SpriteAtlas)
  self._tnr = nil
  self._changeTeamLeaderImage = self:GetUIComponent("Image", "ChangeTeamLeader")
  self._changeTeamLeaderCountTxt = self:GetUIComponent("UILocalizationText", "count")
  self.enableFakeInput = true
  local leftCount = ConfigServiceHelper.GetChangeTeamLeaderCount()
  self._changeTeamLeaderCount = leftCount
  local strCount = tostring(self._changeTeamLeaderCount)
  if leftCount == -1 then
    strCount = "∞"
  end
  self._changeTeamLeaderCountTxt:SetText(strCount)
  self._changeTeamLeaderCountTxtGO = self:GetGameObject("count")
  self._burnEff1 = self:GetGameObject("eff_hong_lizi")
  self._burnEff2 = self:GetGameObject("uieff_hong_huo")
  self._burnMesh = self:GetGameObject("uieff_hong")
  self._burnEff1:SetActive(false)
  self._burnEff2:SetActive(false)
  self._burnMesh:SetActive(false)
  self._stunEff = self:GetGameObject("uieff_lan_lizi")
  self._stunMesh = self:GetGameObject("uieff_lan")
  self._stunEff:SetActive(false)
  self._stunMesh:SetActive(false)
  self._benumbEff = self:GetGameObject("eff_light_lizi")
  self._benumbMesh = self:GetGameObject("uieff_huang")
  self._benumbEff:SetActive(false)
  self._benumbMesh:SetActive(false)
  self._autoFightState = false
  self._autoFightForbiddenStr = StringTable.Get("str_battle_forbidden_operation_in_autofight")
  self:AttachEvent(GameEventType.TeamHPChange, self.OnTeamHPChange)
  self:AttachEvent(GameEventType.AutoFight, self._AutoFight)
  self:AttachEvent(GameEventType.UIChangeTeamLeaderLeftCount, self._ChangeTeamLeaderLeftCount)
  local l_MatchEnterData = self:GetModule(MatchModule)
  local nLeaderModuleId = GameModuleID.MD_ChangeLeader
  if l_MatchEnterData:GetMatchType() == MatchType.MT_ResDungeon then
    nLeaderModuleId = GameModuleID.MD_ResChangeLeader
  end
  local l_RoleModule = self:GetModule(RoleModule)
  if l_RoleModule:CheckModuleUnlock(nLeaderModuleId) == false then
    self._changeTeamLeaderImage.sprite = self._atlas:GetSprite("thread_junei_icon13")
    self._changeTeamLeaderCountTxtGO:SetActive(false)
  else
    self._changeTeamLeaderImage.sprite = self._atlas:GetSprite("thread_junei_icon12")
    self._changeTeamLeaderCountTxtGO:SetActive(true)
  end
end

function UIBattleTeamStateEnter:OnHide()
  self:DetachEvent(GameEventType.TeamHPChange, self.OnTeamHPChange)
  self:DetachEvent(GameEventType.AutoFight, self._AutoFight)
  self:DetachEvent(GameEventType.UIChangeTeamLeaderLeftCount, self._ChangeTeamLeaderLeftCount)
  if self._tnr then
    self._tnr:Kill(false)
    self._tnr = nil
  end
end

function UIBattleTeamStateEnter:SetTeamLeader(petData)
  self._leaderPetData = MatchPet:New(petData)
  self._imgLogo:LoadImage(self._leaderPetData:GetPetLogo())
end

function UIBattleTeamStateEnter:Init(pet_list, teamBuffList)
  local initHp = 0
  local initCurHP = 0
  local petModule = self:GetModule(PetModule)
  local matchType = GameGlobal:GetInstance().GetModule(MatchModule):GetMatchType()
  for i = 1, #pet_list do
    local petID = pet_list[i].pet_pstid
    if petID ~= FormationPetPlaceType.FormationPetPlaceType_None then
      local pet = MatchPet:New(pet_list[i])
      initHp = initHp + pet:GetPetHealth()
      initCurHP = initCurHP + pet:GetPetCurHealth()
      if matchType == MatchType.MT_SeasonMaze then
        break
      end
    end
  end
  self._teamBuffList = teamBuffList
  local teamHealthBlock = {
    isLocalTeam = true,
    currentHP = initCurHP,
    maxHP = initHp,
    shield = 0,
    hitpoint = initCurHP
  }
  self:OnTeamHPChange(teamHealthBlock)
  self._teamStateTxt:SetText(StringTable.Get("str_battle_state_normal"))
  self._teamStateNumberTxt:SetText("100%")
  self._leaderPetData = MatchPet:New(pet_list[1])
  self._imgLogo:LoadImage(self._leaderPetData:GetPetLogo())
  if matchType == MatchType.MT_Maze or matchType == MatchType.MT_SeasonMaze then
    local per = initCurHP / initHp
    if per <= 0 then
      per = 0
    elseif per <= 0.01 then
      per = 1
    else
      per = math.floor(per * 100 + 0.5)
    end
    local perText = per .. "%"
    self._teamStateNumberTxt:SetText(perText)
  end
  self:CorrectFollowPos(initCurHP, initHp)
end

function UIBattleTeamStateEnter:ShowChangeTeamLeaderData()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UIShowChangeTeamLeaderData)
end

function UIBattleTeamStateEnter:TeamStateOnClick()
  GameGlobal.GameRecorder():RecordAction(GameRecordAction.UIInput, {
    ui = "UIBattleTeamStateEnter",
    input = "TeamStateOnClick",
    args = {}
  })
  if self._autoFightState then
    ToastManager.ShowToast(self._autoFightForbiddenStr)
    return
  end
  self:ShowDialog("UIBattleTeamState", self._leaderPetData, self._teamStateGO, self.curHP, self.maxHP, self._teamBuffList)
end

function UIBattleTeamStateEnter:OnTeamHPChange(teamHealthBlock)
  if teamHealthBlock.isLocalTeam then
    self:_RefreshTeamUIHP(teamHealthBlock)
    self:_RefreshTeamShield(teamHealthBlock)
  end
end

function UIBattleTeamStateEnter:_RefreshTeamUIHP(teamHealthBlock)
  local nHP = teamHealthBlock.currentHP
  local nMaxHP = teamHealthBlock.maxHP
  local nHitpoint = teamHealthBlock.hitpoint
  if nHP < 0 then
    nHP = 0
  end
  if nMaxHP < nHP then
    nHP = nMaxHP
  end
  self.maxHP = nMaxHP
  self.curHP = nHP
  local hpPercent = math.floor(nHP / nMaxHP * 100 + 0.5)
  hpPercent = hpPercent - hpPercent % 1
  if hpPercent == 0 and 0 < nHP then
    hpPercent = 1
  end
  self.hpPercent = hpPercent
  self._hpFill.fillAmount = hpPercent * 0.01
  self:CorrectEffValue()
  self._teamStateNumberTxt:SetText(string.format("%d%%", hpPercent))
  local hitpointPercent = nHitpoint / nMaxHP
  if hitpointPercent < 0.01 then
    hitpointPercent = 0.01
  end
  self._damageFill:DOFillAmount(hitpointPercent, 0.3)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowHideLowHpWarning, hpPercent <= BattleConst.LowHpWarningPercent)
end

function UIBattleTeamStateEnter:_RefreshTeamShield(teamHealthBlock)
  local nHP = teamHealthBlock.currentHP
  local nMaxHP = teamHealthBlock.maxHP
  local nShield = teamHealthBlock.shield or 0
  local nOverfillShield = math.max(0, nHP + nShield - nMaxHP)
  if nOverfillShield <= 0 then
    self._shieldFill.fillAmount = math.max((nHP + nShield) / nMaxHP, 0.01)
    self._overfillShieldFill.fillAmount = 0
  else
    self._shieldFill.fillAmount = 1
    local anchorVal = math.max(nHP / nMaxHP, 0.01)
    local sizeDelta = self._overfillShieldAnchor.sizeDelta
    self._overfillShieldAnchor.sizeDelta = Vector2(anchorVal * BattleConst.UIBattleTeamStateEnter_ShieldBarWidth, sizeDelta.y)
    local fillVal = 1
    if nHP > nOverfillShield then
      fillVal = 1 - (nHP - nOverfillShield) / nMaxHP
    end
    self._overfillShieldFill.fillAmount = fillVal
  end
end

function UIBattleTeamStateEnter:OnChangeBuff(teamBuffList)
  if teamBuffList == nil then
    return
  end
  self._teamBuffList = teamBuffList
  local i = 1
  self:StartTask(function(TT)
    YIELD(TT)
    if #self._teamBuffList <= 0 then
      self.curEffectType = nil
      self._teamStateTxt:SetText(StringTable.Get("str_battle_state_normal"))
      self._imgSldBG.sprite = self._atlas:GetSprite(self._sldSpriteNames.Normal[1])
      self._imgSldFill.sprite = self._atlas:GetSprite(self._sldSpriteNames.Normal[2])
      self._imgSldFollow.sprite = self._atlas:GetSprite(self._sldSpriteNames.Normal[3])
      self:SetEffectActive()
    elseif #self._teamBuffList == 1 then
      self:FlushSldImg(1)
    else
      if self._tnr then
        self._tnr:Kill(true)
      end
      self._tnr = self._imgSldFollow:DOFade(1, 1):SetLoops(-1, DG.Tweening.LoopType.Restart):OnStepComplete(function()
        self:FlushSldImg(i)
        if i < #self._teamBuffList then
          i = i + 1
        else
          i = 1
        end
      end)
    end
  end, self)
end

function UIBattleTeamStateEnter:_AutoFight(enable)
  self._autoFightState = enable
end

function UIBattleTeamStateEnter:FlushSldImg(idx)
  if not self._teamBuffList then
    return
  end
  if #self._teamBuffList <= 0 then
    return
  end
  local buffViewInstance = self._teamBuffList[idx]
  if not buffViewInstance then
    return
  end
  local curEffectType = buffViewInstance:GetBuffEffectType()
  local stBuffState = StringTable.Get("str_battle_state_desc") .. StringTable.Get(buffViewInstance:GetBuffName())
  self.curEffectType = curEffectType
  if curEffectType == BuffEffectType.Burn then
    self._imgSldBG.sprite = self._atlas:GetSprite(self._sldSpriteNames.Fire[1])
    self._imgSldFill.sprite = self._atlas:GetSprite(self._sldSpriteNames.Fire[2])
    self._imgSldFollow.sprite = self._atlas:GetSprite(self._sldSpriteNames.Fire[3])
  elseif curEffectType == BuffEffectType.Stun then
    self._imgSldBG.sprite = self._atlas:GetSprite(self._sldSpriteNames.Stun[1])
    self._imgSldFill.sprite = self._atlas:GetSprite(self._sldSpriteNames.Stun[2])
    self._imgSldFollow.sprite = self._atlas:GetSprite(self._sldSpriteNames.Stun[3])
  elseif curEffectType == BuffEffectType.Poison then
    self._imgSldBG.sprite = self._atlas:GetSprite(self._sldSpriteNames.Fire[1])
    self._imgSldFill.sprite = self._atlas:GetSprite(self._sldSpriteNames.Fire[2])
    self._imgSldFollow.sprite = self._atlas:GetSprite(self._sldSpriteNames.Fire[3])
  elseif curEffectType == BuffEffectType.Benumb then
    self._imgSldBG.sprite = self._atlas:GetSprite(self._sldSpriteNames.Benumb[1])
    self._imgSldFill.sprite = self._atlas:GetSprite(self._sldSpriteNames.Benumb[2])
    self._imgSldFollow.sprite = self._atlas:GetSprite(self._sldSpriteNames.Benumb[3])
  end
  self._teamStateTxt:SetText(stBuffState)
  self:SetEffectActive()
  self:CorrectEffValue()
end

function UIBattleTeamStateEnter:CorrectFollowPos(hp, maxHp)
  if hp <= 0 or maxHp <= hp then
    self._imgSldFollow.gameObject:SetActive(false)
  else
    self._imgSldFollow.gameObject:SetActive(true)
  end
end

function UIBattleTeamStateEnter:SetEffectActive()
  self._burnEff1:SetActive(self.curEffectType == BuffEffectType.Burn or self.curEffectType == BuffEffectType.Poison)
  self._burnEff2:SetActive(self.curEffectType == BuffEffectType.Burn or self.curEffectType == BuffEffectType.Poison)
  self._burnMesh:SetActive(self.curEffectType == BuffEffectType.Burn or self.curEffectType == BuffEffectType.Poison)
  self._stunEff:SetActive(self.curEffectType == BuffEffectType.Stun)
  self._stunMesh:SetActive(self.curEffectType == BuffEffectType.Stun)
  self._benumbEff:SetActive(self.curEffectType == BuffEffectType.Benumb)
  self._benumbMesh:SetActive(self.curEffectType == BuffEffectType.Benumb)
end

function UIBattleTeamStateEnter:CorrectEffValue()
  local hpPercent = self.hpPercent or 0
  local value = hpPercent / 100
  if self.curEffectType == BuffEffectType.Burn then
    self._burnMesh.transform.localScale = Vector3(1, value, 0)
  elseif self.curEffectType == BuffEffectType.Stun then
    self._stunMesh.transform.localScale = Vector3(1, value, 0)
  elseif self.curEffectType == BuffEffectType.Poison then
    self._burnMesh.transform.localScale = Vector3(1, value, 0)
  elseif self.curEffectType == BuffEffectType.Benumb then
    self._benumbMesh.transform.localScale = Vector3(1, value, 0)
  end
end

function UIBattleTeamStateEnter:ChangeTeamLeaderOnClick()
  if self._autoFightState then
    return
  end
  if self._changeTeamLeaderCount <= 0 and self._changeTeamLeaderCount ~= -1 then
    local text = StringTable.Get("str_battle_left_change_teamleader_count_invlaid")
    ToastManager.ShowToast(text)
    return
  end
  local l_MatchEnterData = self:GetModule(MatchModule)
  local nLeaderModuleId = GameModuleID.MD_ChangeLeader
  if l_MatchEnterData:GetMatchType() == MatchType.MT_ResDungeon then
    nLeaderModuleId = GameModuleID.MD_ResChangeLeader
  end
  local l_RoleModule = self:GetModule(RoleModule)
  if l_RoleModule:CheckModuleUnlock(nLeaderModuleId) == false then
    local functionLockCfg = Cfg.cfg_module_unlock[nLeaderModuleId]
    ToastManager.ShowToast(StringTable.Get(functionLockCfg.Tips))
    return
  end
  local coreGameStateID = GameGlobal:GetInstance():CoreGameStateID()
  local enableInput = GameGlobal:GetInstance():IsInputEnable()
  if coreGameStateID == GameStateID.WaitInput and enableInput == true then
    self:ShowChangeTeamLeaderData()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ToggleTeamLeaderChangeUI, true)
  end
end

function UIBattleTeamStateEnter:_ChangeTeamLeaderLeftCount(count)
  self._changeTeamLeaderCount = count
  local strLeft = tostring(self._changeTeamLeaderCount)
  if count == -1 then
    strLeft = "∞"
  end
  self._changeTeamLeaderCountTxt:SetText(strLeft)
end

function UIBattleTeamStateEnter:_GetDisplayHPPercent(curHP, maxHP)
  local displayPct = curHP / maxHP * 100
  displayPct = displayPct - displayPct % 1
  if displayPct < 1 then
    displayPct = 1
  end
  return displayPct
end

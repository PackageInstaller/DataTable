_class("UIBossHPInfo", UICustomWidget)
UIBossHPInfo = UIBossHPInfo

function UIBossHPInfo:Constructor()
  self._pstId = 0
  self._tplId = 0
  self._rawPosition = Vector2.zero
end

function UIBossHPInfo:SwitchRes(hpType)
  self._bossUIHPType = hpType
  local imageWhiteBackgroundGO = self:GetGameObject("WhiteBackground")
  imageWhiteBackgroundGO:SetActive(false)
  local imageWhiteBackgroundSPGO = self:GetGameObject("WhiteBackgroundSP")
  imageWhiteBackgroundSPGO:SetActive(false)
  local sldRedHp = self:GetGameObject("sldRedHp")
  sldRedHp:SetActive(false)
  local sldRedHpSP = self:GetGameObject("sldRedHpSP")
  sldRedHpSP:SetActive(false)
  local shieldImg = self:GetGameObject("shield")
  shieldImg:SetActive(false)
  self._hpShieldSPGO = self:GetGameObject("HPShieldSP")
  self._hpShieldSPGO:SetActive(false)
  if hpType == BossUIHPType.Normal then
    imageWhiteBackgroundGO:SetActive(true)
    sldRedHp:SetActive(true)
    self._sldRedHp = self:GetUIComponent("Slider", "sldRedHp")
    self._sldRedHpRectTransform = self:GetUIComponent("RectTransform", "sldRedHp")
    local energyLayerRootGO = self:GetGameObject("energyLayerRoot")
    energyLayerRootGO.transform.localPosition = Vector3(energyLayerRootGO.transform.localPosition.x, -40, energyLayerRootGO.transform.localPosition.z)
    self._rawPosition.x = energyLayerRootGO.transform.localPosition.x
    self._rawPosition.y = energyLayerRootGO.transform.localPosition.y
  elseif hpType == BossUIHPType.Gold then
    imageWhiteBackgroundSPGO:SetActive(true)
    sldRedHpSP:SetActive(true)
    self._hpShieldSPGO:SetActive(true)
    self._sldRedHp = self:GetUIComponent("Slider", "sldRedHpSP")
    self._sldRedHpRectTransform = self:GetUIComponent("RectTransform", "sldRedHpSP")
    self._hpShieldSPLineGO = self:GetGameObject("ShieldSPLine")
    self._hpShieldSPStarGO = self:GetGameObject("ShieldSPStar")
    self._hpShieldSPEffGO = self:GetGameObject("ShieldSPEff")
    self._hpShieldSPEffGO = self:GetGameObject("ShieldSPEff")
    self._shieldSPAnim = self:GetUIComponent("Animation", "HPShieldSP")
    self._hpShieldSPRenderers = self._hpShieldSPEffGO:GetComponentsInChildren(typeof(UnityEngine.Renderer))
    local energyLayerRootGO = self:GetGameObject("energyLayerRoot")
    energyLayerRootGO.transform.localPosition = Vector3(energyLayerRootGO.transform.localPosition.x, -60, energyLayerRootGO.transform.localPosition.z)
    self._rawPosition.x = energyLayerRootGO.transform.localPosition.x
    self._rawPosition.y = energyLayerRootGO.transform.localPosition.y
  end
end

function UIBossHPInfo:OnShow()
  self._go = self:GetGameObject()
  self._txtBoss = self:GetUIComponent("UILocalizationText", "txtBoss")
  self._txtBossName = self:GetUIComponent("UILocalizationText", "txtBossName")
  self._rtRect = self:GetUIComponent("RectTransform", "txtBossName")
  self._revolvingText = self:GetUIComponent("RevolvingTextWithDynamicScroll", "RevolvingText")
  self._revolvingTextGo = self:GetGameObject("RevolvingText")
  self._sldWhiteHp = self:GetUIComponent("Slider", "sldWhiteHp")
  self._imgFillRed = self:GetUIComponent("Image", "imgFillRed")
  self._txtHpPercent = self:GetUIComponent("UILocalizationText", "txtHpPercent")
  self._imgElement = self:GetUIComponent("Image", "imgElement")
  self._imgIcon = self:GetUIComponent("RawImageLoader", "head")
  self._rawImage = self:GetUIComponent("RawImage", "head")
  self._monsterType = self:GetUIComponent("Image", "monsterType")
  self._bossLayoutGroup = self:GetGameObject("BossLayoutGroup")
  self._bossLayoutGroupRectTransform = self:GetUIComponent("RectTransform", "BossLayoutGroup")
  self._uiBattleAtlas = self:GetAsset("InnerUI.spriteatlas", LoadType.SpriteAtlas)
  self.atlasProperty = self:GetAsset("Property.spriteatlas", LoadType.SpriteAtlas)
  self._tnrWhiteHP = nil
  self:AttachEvent(GameEventType.UpdateBossRedHp, self.UpdateBossRedHp)
  self:AttachEvent(GameEventType.UpdateBossWhiteHp, self.UpdateBossWhiteHp)
  self:AttachEvent(GameEventType.UpdateBossShield, self.UpdateBossShield)
  self:AttachEvent(GameEventType.ChangeBossHPLock, self.ChangeBossHpLock)
  self:AttachEvent(GameEventType.ChangeBossHPBuffButtonRayCast, self.ChangeBossHPBuffButtonRayCast)
  self:AttachEvent(GameEventType.UpdateBossNameAndElement, self.UpdateBossNameAndElement)
  self:AttachEvent(GameEventType.UpdateWorldBossHP, self.UpdateWorldBossHP)
  self:AttachEvent(GameEventType.TeamHPChange, self.UpdateTeamHPChange)
  self:AttachEvent(GameEventType.UpdateBossElement, self.UpdateBossElement)
  self:AttachEvent(GameEventType.UpdateAntiActiveSkill, self.UpdateAntiActiveSkill)
  self:AttachEvent(GameEventType.BossSwitchMultiHP, self.UpdateBossMultiHP)
  self._multiHPSeq = nil
  self.buttonOpenBuff = self:GetUIComponent("Button", "buttonOpenBuff")
  self._buttonImage = self:GetUIComponent("Graphic", "buttonOpenBuff")
  self.buffWindowRoot = self:GetGameObject("buffWindowRoot")
  self.buffWindowRootPath = self:GetUIComponent("UISelectObjectPath", "buffWindowRoot")
  self.buffWindowRootPath:SpawnObjects("UIBossBuffInfo", 1)
  local buffRootPath = self:GetUIComponent("UISelectObjectPath", "buffRoot")
  if buffRootPath then
    self._uiBossHPBuffInfo = buffRootPath:SpawnObject("UIHPBuffInfo")
  end
  local energyLayerRoot = self:GetUIComponent("UISelectObjectPath", "energyLayerRoot")
  if energyLayerRoot then
    self._uiBossHPEnergyInfo = energyLayerRoot:SpawnObject("UIBossHPEnergyInfo")
  end
  local eliteRootPath = self:GetUIComponent("UISelectObjectPath", "eliteRoot")
  if eliteRootPath then
    self._uIBossHPEliteInfo = eliteRootPath:SpawnObject("UIBossHPEliteInfo")
  end
  self._harmReductionRoot = self:GetGameObject("harmReductionRoot")
  self._harmReductionRootPath = self:GetUIComponent("UISelectObjectPath", "harmReductionRoot")
  self._shieldImg = self:GetUIComponent("Image", "shield")
  self.worldBossGO = self:GetGameObject("WorldBoss")
  if self.worldBossGO then
    self.worldBossGO:SetActive(false)
    self.sldYellowHpGO = self:GetGameObject("sldYellowHp")
    self.sldYellowHpGO:SetActive(false)
    self._imageWhiteBackground = self:GetUIComponent("Image", "WhiteBackground")
    self._imageRedBackground = self:GetUIComponent("Image", "RedBackground")
    self._txtTotalDamageNum = self:GetUIComponent("UILocalizationText", "totalDamageNumText")
    self._totalDamageNum = 0
    self._txtTotalDamageNum:SetText("0")
    self._txtTotalDamageNumGray = self:GetUIComponent("UILocalizationText", "totalDamageNumTextGray")
    self._txtTotalDamageNumGray:SetText(UIActivityHelper.AddZeroFrontNum(8, self._totalDamageNum))
    self._txtCurStageNum = self:GetUIComponent("UILocalizationText", "curStageNumText")
    self._txtCurStageNum:SetText("x1")
    self._imgFillWhite = self:GetUIComponent("Image", "imgFillWhite")
    self._imgFillYellow = self:GetUIComponent("Image", "imgFillYellow")
    self._sldYellowHp = self:GetUIComponent("Slider", "sldYellowHp")
    self.sldWhiteHpGO = self:GetGameObject("sldWhiteHp")
    self._uiAtlas = self:GetAsset("UIBattle.spriteatlas", LoadType.SpriteAtlas)
  end
  self._sldGreyHp = self:GetUIComponent("Slider", "sldGreyHp")
  self:AttachEvent(GameEventType.UpdateBossGreyHP, self.UpdateBossGreyHP)
  self._sldCurseHpBgRect = self:GetUIComponent("RectTransform", "sldCurseHpBg")
  self._sldCurseHpBgGo = self:GetGameObject("sldCurseHpBg")
  self._curseHpGo = self:GetGameObject("curseHp")
  self._curseHpRect = self:GetUIComponent("RectTransform", "curseHp")
  self:AttachEvent(GameEventType.UpdateBossCurseHP, self.UpdateBossCurseHP)
  self._passiveSkillInfoIconGO = self:GetGameObject("infoIcon")
  self._passiveSkillInfoIconGO:SetActive(false)
  self._hasPassiveSkillInfo = false
  self.passiveSkillInfoWinRoot = self:GetGameObject("passiveSkillInfoWinRoot")
  self.passiveSkillInfoWinRootPath = self:GetUIComponent("UISelectObjectPath", "passiveSkillInfoWinRoot")
  self.passiveSkillInfoWinRootPath:SpawnObjects("UIMonsterPassiveInfo", 1)
  self._antiActiveSkillRoot = self:GetGameObject("AntiActiveSkillRoot")
  if self._antiActiveSkillRoot then
    self._antiActiveSkillRoot:SetActive(false)
    self._txtAntiActiveSkillCount = self:GetUIComponent("UILocalizationText", "antiActiveSkillCount")
  end
end

function UIBossHPInfo:OnHide()
  self:DetachEvent(GameEventType.UpdateBossRedHp, self.UpdateBossRedHp)
  self:DetachEvent(GameEventType.UpdateBossWhiteHp, self.UpdateBossWhiteHp)
  self:DetachEvent(GameEventType.UpdateBossShield, self.UpdateBossShield)
  self:DetachEvent(GameEventType.ChangeBossHPLock, self.ChangeBossHpLock)
  self:DetachEvent(GameEventType.UpdateBossNameAndElement, self.UpdateBossNameAndElement)
  self:DetachEvent(GameEventType.ChangeBossHPBuffButtonRayCast, self.ChangeBossHPBuffButtonRayCast)
  self:DetachEvent(GameEventType.UpdateWorldBossHP, self.UpdateWorldBossHP)
  self:DetachEvent(GameEventType.UpdateBossElement, self.UpdateBossElement)
  self:DetachEvent(GameEventType.UpdateBossGreyHP, self.UpdateBossGreyHP)
  self:DetachEvent(GameEventType.UpdateBossCurseHP, self.UpdateBossCurseHP)
  self:DetachEvent(GameEventType.UpdateAntiActiveSkill, self.UpdateAntiActiveSkill)
  self:DetachEvent(GameEventType.BossSwitchMultiHP, self.UpdateBossMultiHP)
end

function UIBossHPInfo:SetActive(state)
  self._go:SetActive(state)
end

function UIBossHPInfo:Flush(t, isWorldBoss)
  self._pstId = t.pstId
  self._go:SetActive(true)
  if t.isVice then
    self._imgFillRed.color = Color.gray
  else
    self._imgFillRed.color = Color.white
  end
  self:SwitchRes(t.UIBossHPType or BossUIHPType.Normal)
  self:UpdateBossNameAndElement(t.tplId, t.HPBarType, self._pstId, t.matchPet, t.curElement, t.hpEnergyVal, t.maxHPEnergyVal)
  local percent = t.percent or 1
  local hpShieldType = InnerGameHelperRender.GetHPShieldType(self._pstId)
  if self._hpShieldType ~= hpShieldType then
    self._hpShieldType = hpShieldType
    self:SetHPShieldImg()
  end
  self:UpdateBossRedHp(self._pstId, percent)
  self:UpdateBossWhiteHp(self._pstId, percent, true)
  self:UpdateBossHpPercent(self._pstId, percent, t.hP, t.maxHP, t.attack)
  self:UpdateBossShield(self._pstId, t.shieldValue, t.hP, t.maxHP)
  self:UpdateBossGreyHP(self._pstId, t.greyVal, t.hP, t.maxHP)
  self:UpdateBossCurseHP(self._pstId, t.showCurseHp, t.curseHpVal, t.hP, t.maxHP)
  self._hpLockSepList = t.sepHPList
  self._hpLockUnlockedList = t.sepHpUnlockedList or {}
  if self._hpLockSepList then
    local Redgo = self:GetGameObject("Fill Area")
    local hpMaxWidth = Redgo.transform.rect.width
    self._lockList = self:GetUIComponent("UISelectObjectPath", "lockList")
    self._lockList:SpawnObjects("UICustomWidget", #self._hpLockSepList)
    local lockGOList = self._lockList:GetAllSpawnList()
    for i = 1, #self._hpLockSepList do
      local sepPer = self._hpLockSepList[i]
      local offsetX = 0
      if 50 <= sepPer then
        offsetX = (sepPer - 50) * hpMaxWidth / 100
      else
        offsetX = (50 - sepPer) * hpMaxWidth / 100 * -1
      end
      local go = lockGOList[i]:GetGameObject()
      go.transform.localPosition = Vector3(offsetX, 0, 0)
      local uiview = go:GetComponent("UIView")
      local lockGO = uiview:GetGameObject("Lock")
      local bLock = true
      if self._hpLockUnlockedList and table.icontains(self._hpLockUnlockedList, i) then
        bLock = false
      end
      lockGO:SetActive(bLock)
      local unlockGO = uiview:GetGameObject("UnLock")
      unlockGO:SetActive(not bLock)
    end
  end
  if self._uiBossHPBuffInfo and t.pstId then
    self._uiBossHPBuffInfo:SetBossData(t.pstId)
  end
  if isWorldBoss then
    self:InitWorldBossHP(t)
  end
  self:FlushPassiveSkillInfo(t.tplId)
end

function UIBossHPInfo:FlushPassiveSkillInfo(tplID)
  local monsterConfigData = ConfigServiceHelper.GetMonsterConfigData()
  local have = monsterConfigData:IsHasPassiveSkillInfo(tplID)
  self._passiveSkillInfoIconGO:SetActive(have)
  self._hasPassiveSkillInfo = have
  local lst = self.passiveSkillInfoWinRootPath:GetAllSpawnList()
  if lst and table.count(lst) > 0 then
    lst[1]:SetCanvasShow(false)
  end
end

function UIBossHPInfo:ChangeBossHpLock(index, state)
  if self._lockList then
    local lockGOList = self._lockList:GetAllSpawnList()
    if lockGOList == nil or lockGOList[index] == nil then
      return
    end
    local go = lockGOList[index]:GetGameObject()
    local uiview = go:GetComponent("UIView")
    local lockGO = uiview:GetGameObject("Lock")
    lockGO:SetActive(state)
    local unlockGO = uiview:GetGameObject("UnLock")
    unlockGO:SetActive(not state)
  end
end

function UIBossHPInfo:UpdateBossRedHp(entityID, redHpPercent)
  if entityID ~= self._pstId then
    return
  end
  if self._multiHPSeq then
    self._multiHPSeq:Complete()
  end
  self._sldRedHp.value = redHpPercent
end

function UIBossHPInfo:SetSPShieldLen(left, right)
  for i = 0, self._hpShieldSPRenderers.Length - 1 do
    local render = self._hpShieldSPRenderers[i]
    render.sharedMaterial:SetFloat("_left", left)
    render.sharedMaterial:SetFloat("_ringht", right)
  end
end

function UIBossHPInfo:SetSPShieldStarAndLine(left, right, isOverFlow)
  local hpMaxWidth = self._sldRedHpRectTransform.rect.width
  local param = self._sldRedHpRectTransform.rect.width / 2 * -1
  local starParam = 10
  local hpMaxWidth = self._sldRedHpRectTransform.rect.width
  if isOverFlow then
    self._hpShieldSPLineGO.transform.localPosition = Vector3(hpMaxWidth * right + param + 5, 0, 0)
    self._hpShieldSPStarGO.transform.localPosition = Vector3(hpMaxWidth * left + param + starParam, 0, 0)
  else
    self._hpShieldSPLineGO.transform.localPosition = Vector3(hpMaxWidth * left + param + 5, 0, 0)
    self._hpShieldSPStarGO.transform.localPosition = Vector3(hpMaxWidth * right + param + 5, 0, 0)
  end
end

function UIBossHPInfo:UpdateBossShield(entityID, shieldValue, redhp, maxhp, isInitShield)
  if not self._shieldImg then
    return
  end
  if entityID ~= self._pstId then
    return
  end
  if self._bossUIHPType == BossUIHPType.Gold then
    self._shieldValue = shieldValue
    if shieldValue == nil or shieldValue <= 0 then
      self._shieldSPAnim:Play("uianim_BossHp_all_02")
    elseif isInitShield then
      self._shieldSPAnim:Play("uianim_BossHp_all_03")
    else
      self._shieldSPAnim:Play("uianim_BossHp_all_01")
    end
  end
  if shieldValue == nil or shieldValue <= 0 then
    self._shieldImg.gameObject:SetActive(false)
    self._hpShieldSPGO:SetActive(false)
    return
  end
  local shieldRectTransform = self._shieldImg.rectTransform
  local greenRectTransform = self._sldRedHpRectTransform
  local hpMaxWidth = self._sldRedHpRectTransform.rect.width
  local hpMaxHeight = shieldRectTransform.rect.height
  local shieldPercent = shieldValue / maxhp
  if 1 < shieldPercent then
    shieldPercent = 1
  end
  local shieldWidth = shieldPercent * hpMaxWidth
  local hpPercent = redhp / maxhp
  local hpWidth = hpPercent * hpMaxWidth
  local hpAndShield = redhp + shieldValue
  if self._bossUIHPType == BossUIHPType.Normal then
    self._shieldImg.gameObject:SetActive(true)
    shieldRectTransform.sizeDelta = Vector2(shieldWidth, hpMaxHeight)
    if maxhp > hpAndShield then
      local posX = -hpMaxWidth / 2 + hpWidth
      shieldRectTransform.localPosition = Vector3(posX, 0, 0)
    else
      local posX = -hpMaxWidth / 2 + (hpMaxWidth - shieldWidth)
      shieldRectTransform.localPosition = Vector3(posX, 0, 0)
    end
  elseif self._bossUIHPType == BossUIHPType.Gold then
    self._hpShieldSPGO:SetActive(true)
    if maxhp >= hpAndShield then
      self:SetSPShieldLen(hpPercent, hpAndShield / maxhp)
      self:SetSPShieldStarAndLine(hpPercent, hpAndShield / maxhp, false)
    else
      self:SetSPShieldLen(1 - shieldPercent, 1)
      self:SetSPShieldStarAndLine(1 - shieldPercent, 1, true)
    end
  end
  self._shieldValue = shieldValue
end

function UIBossHPInfo:UpdateBossElement(element, entityID)
  if entityID ~= self._pstId then
    return
  end
  local spriteStr = Cfg.cfg_pet_element[element].Icon
  if spriteStr then
    self._imgElement.sprite = self.atlasProperty:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(spriteStr .. "_battle"))
    self._imgElement.gameObject:SetActive(true)
  else
    self._imgElement.gameObject:SetActive(false)
  end
end

function UIBossHPInfo:UpdateBossNameAndElement(tplId, hpBarType, entityID, matchPet, curElement, hpEnergyVal, maxEnergyVal)
  if entityID ~= self._pstId then
    return
  end
  local name, elementType, icon = self:GetNameAndElement(tplId, hpBarType, matchPet)
  if curElement then
    elementType = curElement
  end
  local bossElement = 0
  self._hpBarType = hpBarType
  if hpBarType == HPBarType.EliteBoss or hpBarType == HPBarType.Boss or hpBarType == HPBarType.NormalMonster or hpBarType == HPBarType.EliteMonster or HPBarType.BlackFist then
    self._tplId = tplId
    if self._txtBossName then
      self._txtBossName.text = StringTable.Get(name)
      local width = self._txtBossName.preferredWidth
      local rootWdth = 254
      self._rtRect.sizeDelta = Vector2(width, 50)
      if width <= 124 then
        rootWdth = 254
      elseif 244 <= width then
        rootWdth = 376
      else
        rootWdth = width + 130
      end
      self._bossLayoutGroupRectTransform.sizeDelta = Vector2(rootWdth, 99)
      if self._revolvingText then
        self._revolvingText:OnRefreshRevolving()
      end
    end
    bossElement = elementType
    self._imgIcon:LoadImage(icon)
    if hpBarType == HPBarType.EliteBoss or hpBarType == HPBarType.Boss then
      self._monsterType.color = Color(1.0, 0.047058823529411764, 0.00784313725490196, 1)
      self._txtBoss.color = Color(1.0, 0.047058823529411764, 0.00784313725490196, 1)
      self._txtBoss:SetText(StringTable.Get("str_battle_boss"))
    elseif hpBarType == HPBarType.EliteMonster then
      self._monsterType.color = Color(0.6823529411764706, 0.30980392156862746, 1.0, 1)
      self._txtBoss.color = Color(0.6823529411764706, 0.30980392156862746, 1.0, 1)
      self._txtBoss:SetText(StringTable.Get("str_battle_elite"))
    elseif hpBarType == HPBarType.NormalMonster then
      self._monsterType.color = Color(0.6039215686274509, 0.6039215686274509, 0.6039215686274509, 1)
      self._txtBoss.color = Color(0.6039215686274509, 0.6039215686274509, 0.6039215686274509, 1)
      self._txtBoss:SetText(StringTable.Get("str_battle_monster"))
    elseif hpBarType == HPBarType.BlackFist then
      self._monsterType.color = Color(0.6823529411764706, 0.30980392156862746, 1.0, 1)
      self._txtBoss.color = Color(0.6823529411764706, 0.30980392156862746, 1.0, 1)
      self._txtBoss:SetText(StringTable.Get("str_battle_pet"))
    end
  end
  self:UpdateBossElement(bossElement, entityID)
  if self._uiBossHPBuffInfo and self._pstId then
    self._uiBossHPBuffInfo:SetBossData(self._pstId)
  end
  self._uIBossHPEliteInfo:OnHide()
  local eliteInfoWidth = BattleConst.UIBossHPEliteInfoDefaultWidth
  if hpEnergyVal and maxEnergyVal then
    eliteInfoWidth = eliteInfoWidth - maxEnergyVal * BattleConst.UIBossHPEnergyItemWidth
    self._uiBossHPEnergyInfo:SetData(entityID, hpEnergyVal, maxEnergyVal)
  end
  if self._uIBossHPEliteInfo and (hpBarType == HPBarType.EliteBoss or hpBarType == HPBarType.EliteMonster) then
    self._uIBossHPEliteInfo:SetWidth(eliteInfoWidth, false)
    local eliteIDArray = BattleStatHelper.GetEliteIDArray(entityID, tplId)
    self._uIBossHPEliteInfo:OnSetData(eliteIDArray)
  end
  local harmReductionInstance = InnerGameHelperRender.GetSingleBuffByBuffEffect(self._pstId, BuffEffectType.HarmReduction)
  local coffinMusumeInstance = InnerGameHelperRender.GetSingleBuffByBuffEffect(self._pstId, BuffEffectType.CoffinMusume)
  local coffinMusumeAtkDefInstance = InnerGameHelperRender.GetSingleBuffByBuffEffect(self._pstId, BuffEffectType.CoffinMusumeAtkDef)
  local showHarmReduction = harmReductionInstance ~= nil or coffinMusumeInstance ~= nil or coffinMusumeAtkDefInstance ~= nil
  self._harmReductionRoot.gameObject:SetActive(showHarmReduction)
  if showHarmReduction then
    self._harmReductionRootPath:SpawnObject("UIBossHarmReductionInfo")
  end
  if self._bossLayoutGroup then
    UIHelper.RefreshLayout(self._bossLayoutGroup:GetComponent("RectTransform"))
  end
  self:FlushPassiveSkillInfo(tplId)
end

function UIBossHPInfo:RefreshBossEnergy(entityID)
  local max = self._uiBossHPEnergyInfo._max
  local cur = max - self._multiHPStage + 1
  self._uiBossHPEnergyInfo:UpdateBossHPEnergy(entityID, cur)
end

function UIBossHPInfo:UpdateBossMultiHP(entityID, whiteHpPercent, switchCount, newMultiHPStage)
  if entityID ~= self._pstId then
    return
  end
  if self._multiHPSeq and not self._multiHPSeq:IsComplete() then
    self._multiHPSeq:Complete()
    self:RefreshBossEnergy(entityID)
  end
  self._multiHPStage = newMultiHPStage
  self._multiHPSeq = DG.Tweening.DOTween.Sequence()
  while 0 < switchCount do
    self._multiHPSeq:Append(self._sldWhiteHp:DOValue(0, 0.3):OnPlay(function()
      self._sldRedHp.value = 0
    end):OnComplete(function()
      self._sldRedHp.value = 1
      self._sldWhiteHp.value = 1
      self._uiBossHPEnergyInfo:SubHPEnergy(entityID, 1)
    end))
    switchCount = switchCount - 1
  end
  self._multiHPSeq:Append(self._sldWhiteHp:DOValue(whiteHpPercent, 0.3):OnPlay(function()
    self._sldRedHp.value = whiteHpPercent
  end):OnComplete(function()
    self.whiteHpPercent = math.floor(whiteHpPercent * 100)
    self._sldRedHp.value = whiteHpPercent
    self._sldWhiteHp.value = whiteHpPercent
    self:UpdateBossHpPercent(entityID)
    self:GreyName(whiteHpPercent)
  end))
end

function UIBossHPInfo:UpdateBossWhiteHp(entityID, whiteHpPercent, isInit)
  if entityID ~= self._pstId then
    return
  end
  if self._multiHPSeq and not self._multiHPSeq:IsComplete() then
    self._multiHPSeq:Complete()
    self:RefreshBossEnergy(entityID)
  end
  if self._tnrWhiteHP then
    self._tnrWhiteHP:Complete()
  end
  if 0 < whiteHpPercent and whiteHpPercent < 0.01 then
    whiteHpPercent = 0.01
  end
  if isInit then
    self._sldWhiteHp.value = whiteHpPercent
  else
    self._tnrWhiteHP = self._sldWhiteHp:DOValue(whiteHpPercent, 0.3)
  end
  self.whiteHpPercent = math.floor(whiteHpPercent * 100)
  self:UpdateBossHpPercent(entityID)
  self:GreyName(whiteHpPercent)
end

function UIBossHPInfo:UpdateBossHpPercent(entityID)
  if entityID ~= self._pstId then
    return
  end
  local match = GameGlobal.GetModule(MatchModule)
  local enterData = match:GetMatchEnterData()
  local chessGroup = self:GetGameObject("chessHPGroup")
  if chessGroup then
    chessGroup:SetActive(false)
  end
  self._txtHpPercent:SetText(table.concat({
    self.whiteHpPercent,
    "%"
  }))
end

function UIBossHPInfo:GetWhiteHpPercent()
  return self.whiteHpPercent
end

function UIBossHPInfo:GreyName(hpPercent)
  if self._rawImage then
    if hpPercent <= 0 then
      self._rawImage.material:SetFloat("_LuminosityAmount", 1)
    else
      self._rawImage.material:SetFloat("_LuminosityAmount", 0)
    end
  end
end

function UIBossHPInfo:buttonOpenBuffOnClick()
  GameGlobal.GameRecorder():RecordAction(GameRecordAction.UIInput, {
    ui = "UIBossHPInfo",
    input = "buttonOpenBuffOnClick",
    args = {}
  })
  local lst = self.buffWindowRootPath:GetAllSpawnList()
  if lst and table.count(lst) > 0 then
    lst[1]:Init(self._pstId, self._tplId, self._hpBarType)
  end
end

function UIBossHPInfo:ChangeBossHPBuffButtonRayCast(state)
  self._buttonImage.raycastTarget = state
end

function UIBossHPInfo:GetImageSp(imageName)
  return self._uiAtlas:GetSprite(imageName)
end

function UIBossHPInfo:SetRedHPImage(imageName)
  self._imgFillRed.sprite = self:GetImageSp(imageName)
end

function UIBossHPInfo:SetYellowHPImage(imageName)
  self._imgFillYellow.sprite = self:GetImageSp(imageName)
end

function UIBossHPInfo:GetImageName(imageID)
  local cfg = Cfg.cfg_world_boss_hp_image[imageID]
  if not cfg then
    Log.fatal("ImageID :", imageID, "invalid not in cfg_world_boss_hp_image")
  end
  return cfg.ImageName
end

function UIBossHPInfo:InitWorldBossHP(t)
  self._isCurWorldBossStyle = true
  local redHPImageID = t.worldBossCurImageID
  local yellowHPImageID = t.worldBossPreImageID
  local redImageName = self:GetImageName(redHPImageID)
  local yellowImageID = self:GetImageName(yellowHPImageID)
  self:SetRedHPImage(redImageName)
  self:SetYellowHPImage(yellowImageID)
  self.sldYellowHpGO:SetActive(true)
  self.worldBossGO:SetActive(true)
  self._sldYellowHp.value = 1
  self._sldRedHp.value = 0
  self._txtHpPercent.text = "0%"
  self._sldWhiteHp.value = 0
  self.sldWhiteHpGO:SetActive(false)
  if self._harmReductionRoot.gameObject.activeSelf then
    self.worldBossGO.gameObject.transform.localPosition = Vector3(0, -50, 0)
  end
end

function UIBossHPInfo:SwitchWorldBossHPStage(newRedImageID, newYellowImageID)
  local redImageName = self:GetImageName(newRedImageID)
  local yellowImageID = self:GetImageName(newYellowImageID)
  Log.fatal("RedImage:", redImageName, " YellowImage:", yellowImageID)
  self:SetRedHPImage(redImageName)
  self:SetYellowHPImage(yellowImageID)
  self._sldWhiteHp.value = 0
  self._sldRedHp.value = 0
  self._txtHpPercent.text = "0%"
end

function UIBossHPInfo:UpdateWorldBossHP(pstID, changeInfoList, damage, stage)
  if pstID ~= self._pstId then
    return
  end
  self._totalDamageNum = self._totalDamageNum + damage
  local showNum = HelperProxy:GetInstance():SMazeDamageUnit(self._totalDamageNum)
  self._txtTotalDamageNum:SetText(showNum)
  local grayTex = ""
  local addZeroTex = UIActivityHelper.AddZeroFrontNum(8, self._totalDamageNum)
  if addZeroTex == tostring(self._totalDamageNum) then
    grayTex = showNum
  else
    grayTex = addZeroTex
  end
  self._txtTotalDamageNumGray:SetText(grayTex)
  self._txtCurStageNum:SetText("x" .. tostring(stage))
  for index, info in ipairs(changeInfoList) do
    if info.redHP > 0 and info.redHP < 0.01 then
      info.redHP = 0.01
    end
    self._sldRedHp.value = info.redHP
    local percent = math.floor(info.redHP * 100)
    self._txtHpPercent.text = percent .. "%"
    if info.changeStage then
      self:SwitchWorldBossHPStage(info.redImageID, info.yellowImageID)
    end
  end
end

function UIBossHPInfo:UpdateBossGreyHP(entityID, value, redhp, maxHP)
  if entityID ~= self._pstId then
    return
  end
  value = value or 0
  redhp = redhp or 0
  maxHP = maxHP or 1
  self._sldGreyHp.value = (value + redhp) / maxHP or 0
end

function UIBossHPInfo:UpdateBossCurseHP(entityID, bShow, value, redhp, maxHP)
  if entityID ~= self._pstId then
    return
  end
  if not self._sldCurseHpBgGo then
    return
  end
  if not value then
    bShow = false
    value = 0
  end
  value = value or 0
  redhp = redhp or 0
  maxHP = maxHP or 1
  self._sldCurseHpBgGo:SetActive(bShow)
  self._curseHpGo:SetActive(bShow)
  local percent = value / maxHP
  if 1 < percent then
    percent = 1
  end
  local hpMaxWidth = self._sldRedHpRectTransform.rect.width
  local hpMaxHeight = self._sldRedHpRectTransform.rect.height
  local curseHpWidth = percent * hpMaxWidth
  self._curseHpRect.sizeDelta = Vector2(curseHpWidth, hpMaxHeight)
  local curseHpBgLeftOff = 31
  local curseHpBgWidth = curseHpWidth + curseHpBgLeftOff
  local curseHpBgMaxHeight = self._sldCurseHpBgRect.rect.height
  self._sldCurseHpBgRect.sizeDelta = Vector2(curseHpBgWidth, curseHpBgMaxHeight)
end

function UIBossHPInfo:GetNameAndElement(tplId, type, matchPet)
  if type == HPBarType.EliteMonster or type == HPBarType.NormalMonster or type == HPBarType.Boss or type == HPBarType.EliteBoss then
    local monsterConfigData = ConfigServiceHelper.GetMonsterConfigData()
    local cfgMonsterObject = monsterConfigData:GetMonsterObject(tplId)
    local cfgMonsterClass = monsterConfigData:GetMonsterClass(tplId)
    if cfgMonsterObject then
      local name = cfgMonsterClass.Name
      local element = cfgMonsterObject.ElementType
      local icon = cfgMonsterClass.HeadIcon
      return name, element, icon
    end
  elseif type == HPBarType.BlackFist then
    local petcfg = Cfg.cfg_pet[tplId]
    local element = matchPet:GetPetFirstElement()
    local headIconName = matchPet:GetPetHead(PetSkinEffectPath.HEAD_ICON_CHAIN_SKILL_PREVIEW)
    return petcfg.Name, element, headIconName
  end
end

function UIBossHPInfo:UpdateTeamHPChange(args)
  if args.isLocalTeam then
    return
  end
  local maxHP = args.maxHP
  local redHP = args.currentHP / maxHP
  if args.currentHP > 0 and redHP < 0.01 then
    redHP = 0.01
  end
  local whiteHP = args.hitpoint / maxHP
  local shieldValue = args.shield
  local entityID = args.entityID
  self:UpdateBossRedHp(entityID, redHP)
  self:UpdateBossWhiteHp(entityID, whiteHP)
  self:UpdateBossShield(entityID, shieldValue, args.currentHP, maxHP)
  self:UpdateBossCurseHP(entityID, args.showCurseHp, args.curseHpVal, args.currentHP, maxHP)
end

function UIBossHPInfo:buttonOpenPassiveSkillInfoOnClick()
  if not self._hasPassiveSkillInfo then
    return
  end
  GameGlobal.GameRecorder():RecordAction(GameRecordAction.UIInput, {
    ui = "UIBossHPInfo",
    input = "buttonOpenPassiveSkillInfoOnClick",
    args = {}
  })
  local lst = self.passiveSkillInfoWinRootPath:GetAllSpawnList()
  if lst and table.count(lst) > 0 then
    lst[1]:Init(self._pstId, self._tplId)
  end
end

function UIBossHPInfo:UpdateAntiActiveSkill(entityID, showCD)
  if entityID ~= self._pstId then
    return
  end
  local antiSkillEnabled = InnerGameHelperRender.GetEntityAttribute(entityID, "AntiSkillEnabled")
  local maxCount = InnerGameHelperRender.GetEntityAttribute(entityID, "MaxAntiSkillCountPerRound")
  local antiCD = InnerGameHelperRender.GetEntityAttribute(entityID, "WaitActiveSkillCount")
  local show = maxCount ~= 0 and antiSkillEnabled == 1 or showCD ~= nil
  self._antiActiveSkillRoot.gameObject:SetActive(show)
  if not show then
    return
  end
  local originalCount = InnerGameHelperRender.GetEntityAttribute(entityID, "OriginalWaitActiveSkillCount")
  self._txtAntiActiveSkillCount.gameObject:SetActive(originalCount ~= 1)
  if showCD then
    antiCD = showCD
  end
  self._txtAntiActiveSkillCount:SetText(antiCD)
  self:_EnergyXAdaptive(show)
end

function UIBossHPInfo:PreviewSetWorldBossHP(info)
  if info.pstId ~= self._pstId then
    return
  end
  self._sldGreyHp.value = 0
  self:SwitchWorldBossHPStage(info.worldBossCurImageID, info.worldBossPreImageID)
  self._totalDamageNum = info.worldBossTotalDamage
  self._txtTotalDamageNum:SetText(tostring(self._totalDamageNum))
  self._txtTotalDamageNumGray:SetText(UIActivityHelper.AddZeroFrontNum(8, self._totalDamageNum))
  self._txtCurStageNum:SetText("x" .. tostring(info.worldBossCurStage))
  if 0 < info.worldBossCurStageHpPercent and info.worldBossCurStageHpPercent < 0.01 then
    info.worldBossCurStageHpPercent = 0.01
  end
  self._sldRedHp.value = info.worldBossCurStageHpPercent
  local percent = math.floor(info.worldBossCurStageHpPercent * 100)
  self._txtHpPercent.text = percent .. "%"
end

function UIBossHPInfo:PreviewRevertWorldBossStyle()
  if not self._isCurWorldBossStyle then
    return
  end
  local redImageName = "thread_bosstiao2_frame"
  local yellowImageID = "thread_bosstiao3_frame"
  self:SetRedHPImage(redImageName)
  self:SetYellowHPImage(yellowImageID)
  self.sldYellowHpGO:SetActive(false)
  self.worldBossGO:SetActive(false)
  self.sldWhiteHpGO:SetActive(true)
end

function UIBossHPInfo:SetHPShieldImg()
  if self._hpShieldType == HPShieldType.Lava then
    self._shieldImg.sprite = InnerGameHelperRender:GetInstance():GetImageFromInnerUI("thread_junei_rongyan01")
  elseif self._hpShieldType == HPShieldType.Normal then
    self._shieldImg.sprite = InnerGameHelperRender:GetInstance():GetImageFromInnerUI("thread_junei_xuetiao5")
  end
end

function UIBossHPInfo:_EnergyXAdaptive(anti)
  local rect = self:GetUIComponent("RectTransform", "energyLayerRoot")
  if anti then
    rect.anchoredPosition = Vector3(self._rawPosition.x - 53, self._rawPosition.y - 3, rect.anchoredPosition.z)
  else
    rect.anchoredPosition = Vector3(self._rawPosition.x, self._rawPosition.y, rect.anchoredPosition.z)
  end
end

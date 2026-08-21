_class("UIBattleChessHPInfo", UICustomWidget)
UIBattleChessHPInfo = UIBattleChessHPInfo
UIBattleChessHPInfo.UIComponentsRegistry = {
  {
    Type = "UILocalizationText",
    ViewName = "txtBoss",
    CodeName = "_txtBoss"
  },
  {
    Type = "UILocalizationText",
    ViewName = "txtBossName",
    CodeName = "_txtBossName"
  },
  {
    Type = "RectTransform",
    ViewName = "txtBoss",
    CodeName = "_rtRect"
  },
  {
    Type = "RevolvingTextWithDynamicScroll",
    ViewName = "RevolvingText",
    CodeName = "_revolvingText"
  },
  {
    Type = "GameObject",
    ViewName = "RevolvingText",
    CodeName = "_revolvingTextGo"
  },
  {
    Type = "Slider",
    ViewName = "sldWhiteHp",
    CodeName = "_sldWhiteHp"
  },
  {
    Type = "Slider",
    ViewName = "sldRedHp",
    CodeName = "_sldRedHp"
  },
  {
    Type = "Slider",
    ViewName = "sldRedHp2",
    CodeName = "_sldRedHp2"
  },
  {
    Type = "Slider",
    ViewName = "sldGreenHp1",
    CodeName = "_sldGreenHp1"
  },
  {
    Type = "Slider",
    ViewName = "sldGreenHp2",
    CodeName = "_sldGreenHp2"
  },
  {
    Type = "Slider",
    ViewName = "sldWhiteHpForRed2",
    CodeName = "_sldWhiteHpForRed2"
  },
  {
    Type = "Slider",
    ViewName = "sldWhiteHpForGreen",
    CodeName = "_sldWhiteHpForGreen"
  },
  {
    Type = "Slider",
    ViewName = "sldWhiteHpForGreen2",
    CodeName = "_sldWhiteHpForGreen2"
  },
  {
    Type = "RectTransform",
    ViewName = "sldRedHp",
    CodeName = "_sldRedHpRectTransform"
  },
  {
    Type = "Image",
    ViewName = "imgFillRed",
    CodeName = "_imgFillRed"
  },
  {
    Type = "UILocalizationText",
    ViewName = "txtHpPercent",
    CodeName = "_txtHpPercent"
  },
  {
    Type = "Image",
    ViewName = "imgElement",
    CodeName = "_imgElement"
  },
  {
    Type = "RawImageLoader",
    ViewName = "head",
    CodeName = "_imgIcon"
  },
  {
    Type = "RawImage",
    ViewName = "head",
    CodeName = "_rawImage"
  },
  {
    Type = "Image",
    ViewName = "monsterType",
    CodeName = "_monsterType"
  },
  {
    Type = "GameObject",
    ViewName = "BossLayoutGroup",
    CodeName = "_bossLayoutGroup"
  },
  {
    Type = "RectTransform",
    ViewName = "BossLayoutGroup",
    CodeName = "_bossLayoutGroupRectTransform"
  },
  {
    Type = "Button",
    ViewName = "buttonOpenBuff",
    CodeName = "buttonOpenBuff"
  },
  {
    Type = "Graphic",
    ViewName = "buttonOpenBuff",
    CodeName = "_buttonImage"
  },
  {
    Type = "GameObject",
    ViewName = "buffWindowRoot",
    CodeName = "buffWindowRoot"
  },
  {
    Type = "UISelectObjectPath",
    ViewName = "buffWindowRoot",
    CodeName = "buffWindowRootPath"
  },
  {
    Type = "GameObject",
    ViewName = "harmReductionRoot",
    CodeName = "_harmReductionRoot"
  },
  {
    Type = "UISelectObjectPath",
    ViewName = "harmReductionRoot",
    CodeName = "_harmReductionRootPath"
  },
  {
    Type = "Image",
    ViewName = "shield",
    CodeName = "_shieldImg"
  },
  {
    Type = "GameObject",
    ViewName = "WorldBoss",
    CodeName = "worldBossGO"
  },
  {
    Type = "GameObject",
    ViewName = "sldYellowHp",
    CodeName = "sldYellowHpGO"
  },
  {
    Type = "Image",
    ViewName = "WhiteBackground",
    CodeName = "_imageWhiteBackground"
  },
  {
    Type = "Image",
    ViewName = "RedBackground",
    CodeName = "_imageRedBackground"
  },
  {
    Type = "UILocalizationText",
    ViewName = "totalDamageNumText",
    CodeName = "_txtTotalDamageNum"
  },
  {
    Type = "UILocalizationText",
    ViewName = "totalDamageNumTextGray",
    CodeName = "_txtTotalDamageNumGray"
  },
  {
    Type = "UILocalizationText",
    ViewName = "curStageNumText",
    CodeName = "_txtCurStageNum"
  },
  {
    Type = "Image",
    ViewName = "imgFillWhite",
    CodeName = "_imgFillWhite"
  },
  {
    Type = "Image",
    ViewName = "imgFillYellow",
    CodeName = "_imgFillYellow"
  },
  {
    Type = "Slider",
    ViewName = "sldYellowHp",
    CodeName = "_sldYellowHp"
  },
  {
    Type = "GameObject",
    ViewName = "sldWhiteHp",
    CodeName = "sldWhiteHpGO"
  },
  {
    Type = "UISelectObjectPath",
    ViewName = "ScaleRulerGreen1",
    CodeName = "_scaleRulerGreen1"
  },
  {
    Type = "UISelectObjectPath",
    ViewName = "ScaleRulerGreen2",
    CodeName = "_scaleRulerGreen2"
  },
  {
    Type = "UISelectObjectPath",
    ViewName = "ScaleRulerGreen1",
    CodeName = "scaleRulerGreen1"
  },
  {
    Type = "UISelectObjectPath",
    ViewName = "ScaleRulerRed1",
    CodeName = "_scaleRulerRed1"
  },
  {
    Type = "UISelectObjectPath",
    ViewName = "ScaleRulerRed2",
    CodeName = "_scaleRulerRed2"
  }
}

function UIBattleChessHPInfo:Constructor()
  self._pstId = 0
  self._tplId = 0
  self._go = nil
  self._uiBattleAtlas = nil
  self.atlasProperty = nil
  self._sequenceWhiteHP = nil
  self._components = {}
end

function UIBattleChessHPInfo:OnShow()
  self._go = self:GetGameObject()
  self:FetchUIComponents()
  self._uiBattleAtlas = self:GetAsset("InnerUI.spriteatlas", LoadType.SpriteAtlas)
  self.atlasProperty = self:GetAsset("Property.spriteatlas", LoadType.SpriteAtlas)
  self.buffWindowRootPath:SpawnObjects("UIBossBuffInfo", 1)
  self._uiBossHPBuffInfo = self:GetUIComponent("UISelectObjectPath", "buffRoot"):SpawnObject("UIHPBuffInfo")
  self._uIBossHPEliteInfo = self:GetUIComponent("UISelectObjectPath", "eliteRoot"):SpawnObject("UIBossHPEliteInfo")
  self._harmReductionRootPath = self:GetUIComponent("UISelectObjectPath", "harmReductionRoot")
  self._harmReductionRootPath:SpawnObject("UIBossHarmReductionInfo")
  self.worldBossGO:SetActive(false)
  self.sldYellowHpGO:SetActive(false)
  self._totalDamageNum = 0
  self._txtTotalDamageNum:SetText("0")
  self._txtTotalDamageNumGray:SetText(UIActivityHelper.AddZeroFrontNum(8, self._totalDamageNum))
  self._txtCurStageNum:SetText("x1")
  self._uiAtlas = self:GetAsset("UIBattle.spriteatlas", LoadType.SpriteAtlas)
  self:SetActive(false)
  self:AttachUIEvents()
end

local function mtIndex(t, k)
  return rawget(UIBattleChessHPInfo, k) or rawget(t._components, k)
end

UIBattleChessHPInfo.__index = mtIndex

function UIBattleChessHPInfo:AttachUIEvents()
  self:AttachEvent(GameEventType.UpdateBossRedHp, self.UpdateBossRedHp)
  self:AttachEvent(GameEventType.UpdateBossWhiteHp, self.UpdateBossWhiteHp)
  self:AttachEvent(GameEventType.UpdateBossShield, self.UpdateBossShield)
  self:AttachEvent(GameEventType.ChangeBossHPLock, self.ChangeBossHpLock)
  self:AttachEvent(GameEventType.ChangeBossHPBuffButtonRayCast, self.ChangeBossHPBuffButtonRayCast)
  self:AttachEvent(GameEventType.UpdateBossNameAndElement, self.UpdateBossNameAndElement)
  self:AttachEvent(GameEventType.UpdateWorldBossHP, self.UpdateWorldBossHP)
  self:AttachEvent(GameEventType.TeamHPChange, self.UpdateTeamHPChange)
  self:AttachEvent(GameEventType.UpdateBossElement, self.UpdateBossElement)
  self:AttachEvent(GameEventType.ShowBossHp, self.ShowBossHp)
  self:AttachEvent(GameEventType.HideBossHp, self.HideBossHp)
  self:AttachEvent(GameEventType.PreviewMonsterReplaceHPBar, self.ShowPreviewMonsterReplaceHPBar)
  self:AttachEvent(GameEventType.RevokePreviewMonsterReplaceHPBar, self.RevokePreviewMonsterReplaceHPBar)
end

function UIBattleChessHPInfo:OnEventUpdateBossRedHp(entityID, redHpPercent, hpVal, maxHP)
  if entityID ~= self._pstId then
    return
  end
  self:UpdateBossRedHp(redHpPercent, hpVal, maxHP)
end

function UIBattleChessHPInfo:OnEventUpdateBossWhiteHp(entityID, whiteHpPercent, whiteHpVal, maxHP)
  if entityID ~= self._pstId then
    return
  end
  self:UpdateBossWhiteHp(whiteHpPercent, whiteHpVal, maxHP, false)
end

function UIBattleChessHPInfo:FetchUIComponents()
  for _, registryItem in ipairs(UIBattleChessHPInfo.UIComponentsRegistry) do
    local t = registryItem.Type
    local vname = registryItem.ViewName
    local cname = registryItem.CodeName
    if t == "GameObject" then
      self._components[cname] = self:GetGameObject(vname)
    else
      self._components[cname] = self:GetUIComponent(t, vname)
    end
  end
end

function UIBattleChessHPInfo:ShowBossHp(bossIds, isWorldBoss)
  local info = bossIds:GetAt(1)
  if self._bossEntityID == info.pstId then
    return
  end
  self._bossEntityID = info.pstId
  self._haveBoss = true
  self:SetActive(true)
  self._isBossLive = true
  self._isCurrentBoss = true
  self:Flush(bossIds:GetAt(1), isWorldBoss)
end

function UIBattleChessHPInfo:HideBossHp(entityID)
  if entityID ~= self._bossEntityID then
    return
  end
  self:ShowHideBossHp2(false)
end

function UIBattleChessHPInfo:ShowHideBossHp2(isShow)
  if self._haveBoss then
    self._isBossLive = false
    self:SetActive(isShow)
  end
end

function UIBattleChessHPInfo:ShowPreviewMonsterReplaceHPBar(info)
  if self._haveBoss then
    if info.pstId == self._bossEntityID and self._isCurrentBoss then
      return
    end
    self._isCurrentBoss = false
    self:SetActive(false)
  else
    self:SetActive(true)
  end
  self:Flush(info)
end

function UIBattleChessHPInfo:RevokePreviewMonsterReplaceHPBar()
  if self._haveBoss then
    self._isCurrentBoss = true
    self:SetActive(self._isBossLive)
  else
    self:SetActive(false)
  end
end

function UIBattleChessHPInfo:SetActive(state)
  self._go:SetActive(state)
end

function UIBattleChessHPInfo:Flush(t, isWorldBoss)
  self._pstId = t.pstId
  self._tplId = t.tplId
  self._hpBarType = t.HPBarType
  self._go:SetActive(true)
  self:UpdateBossNameAndElement(t.tplId, t.HPBarType, self._pstId, t.matchPet, t.curElement)
  local percent = t.percent or 1
  self._hp = t.HP
  self._maxHP = t.maxHP
  self._hpBarGroup = self:InitializeHPBarGroup(self._hpBarType)
  self:UpdateBossRedHp(percent, t.HP, t.maxHP)
  self:UpdateBossWhiteHp(percent, t.HP, t.maxHP, true)
  self:UpdateBossHpPercent(self._pstId, percent, t.HP, t.maxHP, t.attack)
  self:UpdateBossShield(self._pstId, t.shieldValue, t.HP, t.maxHP)
  self:GenerateHPLockSep(t.sepHPList)
  if self._uiBossHPBuffInfo and t.pstId then
    self._uiBossHPBuffInfo:SetBossData(t.pstId)
  end
  if isWorldBoss then
    self:InitWorldBossHP(t)
  end
end

function UIBattleChessHPInfo:GenerateHPLockSep(hpLockSepList)
  if not hpLockSepList then
    return
  end
  local hpMaxWidth = self:GetGameObject("Fill Area").transform.rect.width
  self._lockList = self:GetUIComponent("UISelectObjectPath", "lockList")
  self._lockList:SpawnObjects("UICustomWidget", #hpLockSepList)
  local lockGOList = self._lockList:GetAllSpawnList()
  for i = 1, #hpLockSepList do
    local sepPer = hpLockSepList[i]
    local offsetX = 0
    if 50 <= sepPer then
      offsetX = (sepPer - 50) * hpMaxWidth / 100
    else
      offsetX = (50 - sepPer) * hpMaxWidth / 100 * -1
    end
    local go = lockGOList[i]:GetGameObject()
    go.transform.localPosition = Vector3(offsetX, 0, 0)
    local uiview = go:GetComponent("UIView")
    uiview:GetGameObject("Lock"):SetActive(true)
    uiview:GetGameObject("UnLock"):SetActive(false)
  end
end

function UIBattleChessHPInfo:ChangeBossHpLock(index, state)
  if self._lockList then
    local lockGOList = self._lockList:GetAllSpawnList()
    if lockGOList == nil or lockGOList[index] == nil then
      return
    end
    local uiview = lockGOList[index]:GetGameObject():GetComponent("UIView")
    uiview:GetGameObject("Lock"):SetActive(state)
    uiview:GetGameObject("UnLock"):SetActive(not state)
  end
end

function UIBattleChessHPInfo:UpdateBossRedHp(redHpPercent, hpVal, maxHP)
  if maxHP <= BattleConst.HUDUI_ChessHPSecondBarThreshold then
    self._hpBarGroup.sliderHP1.value = redHpPercent
    self._hpBarGroup.sliderHP2.value = 0
    self._hpBarGroup.sliderWhiteHP2.value = 0
  else
    local value1 = math.max(0, math.min(BattleConst.HUDUI_ChessHPSecondBarThreshold, hpVal) / BattleConst.HUDUI_ChessHPSecondBarThreshold)
    local value2 = math.max(0, (hpVal - BattleConst.HUDUI_ChessHPSecondBarThreshold) / BattleConst.HUDUI_ChessHPSecondBarThreshold)
    self._hpBarGroup.sliderHP1.value = value1
    self._hpBarGroup.sliderHP2.value = value2
  end
  self:ShowChessHPScale(maxHP)
end

function UIBattleChessHPInfo:UpdateBossShield(entityID, shieldValue, redhp, maxhp)
  if not self._shieldImg then
    return
  end
  if entityID ~= self._pstId then
    return
  end
  if shieldValue == nil or shieldValue <= 0 then
    self._shieldImg.gameObject:SetActive(false)
    return
  end
  self._shieldImg.gameObject:SetActive(true)
  local shieldRectTransform = self._shieldImg.rectTransform
  local greenRectTransform = self._sldRedHpRectTransform
  local hpMaxWidth = self._sldRedHpRectTransform.rect.width
  local hpMaxHeight = shieldRectTransform.rect.height
  local shieldPercent = shieldValue / maxhp
  if 1 < shieldPercent then
    shieldPercent = 1
  end
  local shieldWidth = shieldPercent * hpMaxWidth
  shieldRectTransform.sizeDelta = Vector2(shieldWidth, hpMaxHeight)
  local hpPercent = redhp / maxhp
  local hpWidth = hpPercent * hpMaxWidth
  local hpAndShield = redhp + shieldValue
  if maxhp > hpAndShield then
    local posX = -hpMaxWidth / 2 + hpWidth
    shieldRectTransform.localPosition = Vector3(posX, 0, 0)
  else
    local posX = -hpMaxWidth / 2 + (hpMaxWidth - shieldWidth)
    shieldRectTransform.localPosition = Vector3(posX, 0, 0)
  end
end

function UIBattleChessHPInfo:UpdateBossElement(element, entityID)
  if entityID ~= self._pstId then
    return
  end
  if not Cfg.cfg_pet_element[element] then
    Log.fatal("元素属性不存在:  ", tostring(element), "entityID=", tostring(entityID))
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

function UIBattleChessHPInfo:UpdateBossNameAndElement(tplId, hpBarType, entityID, matchPet, curElement)
  if entityID ~= self._pstId then
    return
  end
  local name, elementType, icon = self:GetNameAndElement(tplId, hpBarType, matchPet)
  if curElement then
    elementType = curElement
  end
  local bossElement = 0
  self._txtBossName.text = StringTable.Get(name)
  local width = self._txtBossName.preferredWidth
  local rootWdth = 254
  self._rtRect.sizeDelta = Vector2(width, 50)
  self._revolvingText:OnRefreshRevolving()
  self:UpdateBossElement(elementType, entityID)
  self._imgIcon:LoadImage(icon)
  if self._uiBossHPBuffInfo and self._pstId then
    self._uiBossHPBuffInfo:SetBossData(self._pstId)
  end
  self._uIBossHPEliteInfo:OnHide()
  if self._uIBossHPEliteInfo and (hpBarType == HPBarType.EliteBoss or hpBarType == HPBarType.EliteMonster) then
    local eliteIDArray = BattleStatHelper.GetEliteIDArray(entityID, tplId)
    self._uIBossHPEliteInfo:OnSetData(eliteIDArray)
  end
  local harmReductionInstance = InnerGameHelperRender.GetSingleBuffByBuffEffect(self._pstId, BuffEffectType.HarmReduction)
  self._harmReductionRoot.gameObject:SetActive(harmReductionInstance ~= nil)
  if self._bossLayoutGroup then
    UIHelper.RefreshLayout(self._bossLayoutGroup:GetComponent("RectTransform"))
  end
end

function UIBattleChessHPInfo:UpdateBossWhiteHp(whiteHpPercent, whiteHpVal, maxHP, isInit)
  if self._sequenceWhiteHP then
    self._sequenceWhiteHP:Complete()
    self._sequenceWhiteHP = nil
  end
  if maxHP <= BattleConst.HUDUI_ChessHPSecondBarThreshold then
    local sliderWhite = self._hpBarGroup.sliderWhiteHP1
    if 0 < whiteHpPercent and whiteHpPercent < 0.01 then
      whiteHpPercent = 0.01
    end
    if isInit then
      sliderWhite.value = whiteHpPercent
    else
      self._sequenceWhiteHP:Append(self._hpBarGroup.SliderWhiteHP1:DOValue(whiteHpPercent, 0.3))
    end
  else
    local value1 = math.max(0, math.min(BattleConst.HUDUI_ChessHPSecondBarThreshold, whiteHpVal) / BattleConst.HUDUI_ChessHPSecondBarThreshold)
    local value2 = math.max(0, (whiteHpVal - BattleConst.HUDUI_ChessHPSecondBarThreshold) / BattleConst.HUDUI_ChessHPSecondBarThreshold)
    if isInit then
      self._hpBarGroup.sliderWhiteHP1.value = value1
      self._hpBarGroup.sliderWhiteHP2.value = value2
    else
      self._sequenceWhiteHP = DG.Tweening.DOTween.Sequence()
      self._sequenceWhiteHP:Append(self._hpBarGroup.SliderWhiteHP2:DOValue(value2, 0.15))
      self._sequenceWhiteHP:Append(self._hpBarGroup.SliderWhiteHP1:DOValue(value1, 0.15))
    end
  end
  self.whiteHpPercent = math.floor(whiteHpPercent * 100)
  self:GreyName(whiteHpPercent)
end

function UIBattleChessHPInfo:UpdateBossHpPercent(entityID, percent, hp, maxHp, attack)
  if entityID ~= self._pstId then
    return
  end
  local match = GameGlobal.GetModule(MatchModule)
  local enterData = match:GetMatchEnterData()
  self:GetGameObject("txtHpPercent"):SetActive(false)
  local chessGroup = self:GetGameObject("chessHPGroup")
  chessGroup:SetActive(true)
  local chessHPText = self:GetUIComponent("UILocalizationText", "chessHPText")
  chessHPText:SetText(table.concat({
    hp,
    " / ",
    maxHp
  }))
  local chessAtkText = self:GetUIComponent("UILocalizationText", "chessAtkText")
  chessAtkText:SetText(attack)
end

function UIBattleChessHPInfo:GetWhiteHpPercent()
  return self.whiteHpPercent
end

function UIBattleChessHPInfo:GreyName(hpPercent)
  if self._rawImage then
    if hpPercent <= 0 then
      self._rawImage.material:SetFloat("_LuminosityAmount", 1)
    else
      self._rawImage.material:SetFloat("_LuminosityAmount", 0)
    end
  end
end

function UIBattleChessHPInfo:buttonOpenBuffOnClick()
  GameGlobal.GameRecorder():RecordAction(GameRecordAction.UIInput, {
    ui = "UIBattleChessHPInfo",
    input = "buttonOpenBuffOnClick",
    args = {}
  })
  local lst = self.buffWindowRootPath:GetAllSpawnList()
  if lst and table.count(lst) > 0 then
    lst[1]:Init(self._pstId, self._tplId, self._hpBarType)
  end
end

function UIBattleChessHPInfo:ChangeBossHPBuffButtonRayCast(state)
  self._buttonImage.raycastTarget = state
end

function UIBattleChessHPInfo:SetRedHPImage(imageName)
  self._imgFillRed.sprite = self._uiAtlas:GetSprite(imageName)
end

function UIBattleChessHPInfo:SetYellowHPImage(imageName)
  self._imgFillYellow.sprite = self._uiAtlas:GetSprite(imageName)
end

function UIBattleChessHPInfo:GetImageName(imageID)
  local cfg = Cfg.cfg_world_boss_hp_image[imageID]
  if not cfg then
    Log.fatal("ImageID :", imageID, "invalid not in cfg_world_boss_hp_image")
  end
  return cfg.ImageName
end

function UIBattleChessHPInfo:InitWorldBossHP(t)
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
end

function UIBattleChessHPInfo:SwitchWorldBossHPStage(newRedImageID, newYellowImageID)
  local redImageName = self:GetImageName(newRedImageID)
  local yellowImageID = self:GetImageName(newYellowImageID)
  Log.fatal("RedImage:", redImageName, " YellowImage:", yellowImageID)
  self:SetRedHPImage(redImageName)
  self:SetYellowHPImage(yellowImageID)
  self._sldWhiteHp.value = 0
  self._sldRedHp.value = 0
  self._txtHpPercent.text = "0%"
end

function UIBattleChessHPInfo:UpdateWorldBossHP(pstID, changeInfoList, damage, stage)
  if pstID ~= self._pstId then
    return
  end
  self._totalDamageNum = self._totalDamageNum + damage
  self._txtTotalDamageNum:SetText(tostring(self._totalDamageNum))
  self._txtTotalDamageNumGray:SetText(UIActivityHelper.AddZeroFrontNum(8, self._totalDamageNum))
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

local enemyHPBarType = {
  [HPBarType.EliteMonster] = true,
  [HPBarType.NormalMonster] = true,
  [HPBarType.Boss] = true,
  [HPBarType.EliteBoss] = true
}

function UIBattleChessHPInfo:GetNameAndElement(tplId, type, matchPet, elementType)
  if enemyHPBarType[type] then
    local monsterConfigData = ConfigServiceHelper.GetMonsterConfigData()
    local cfgMonsterObject = monsterConfigData:GetMonsterObject(tplId)
    local cfgMonsterClass = monsterConfigData:GetMonsterClass(tplId)
    if cfgMonsterObject then
      local name = cfgMonsterClass.Name
      local element = cfgMonsterObject.ElementType
      local icon = cfgMonsterClass.HeadIcon
      return name, element, icon
    end
  elseif type == HPBarType.ChessPet then
    local cfgChessPet = Cfg.cfg_chesspet[tplId]
    local element = cfgChessPet.ElementType
    local cfgChessPetClass = Cfg.cfg_chesspet_class[cfgChessPet.ClassID]
    local icon = cfgChessPetClass.HeadIcon
    local name = cfgChessPetClass.Name
    return name, element, icon
  end
end

function UIBattleChessHPInfo:UpdateTeamHPChange(args)
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
  self:UpdateBossRedHp(redHP, args.currentHP)
  self:UpdateBossWhiteHp(whiteHP, args.hitpoint)
  self:UpdateBossShield(entityID, shieldValue, args.currentHP, maxHP)
end

function UIBattleChessHPInfo:ShowChessHPScale(maxHP)
  local scaleRuler1 = self._hpBarGroup.scaleHP1
  local scaleRuler2 = self._hpBarGroup.scaleHP2
  local hpMaxWidth = self:GetGameObject("Fill Area").transform.rect.width
  if maxHP <= 50 then
    local tScaleMark1 = scaleRuler1:SpawnObjects("UICustomWidget", maxHP - 1)
    self:_FixScaleMarkers(tScaleMark1, hpMaxWidth, maxHP)
  else
    local tScaleMark1 = scaleRuler1:SpawnObjects("UICustomWidget", 49)
    self:_FixScaleMarkers(tScaleMark1, hpMaxWidth, 50)
    local tScaleMark2 = scaleRuler2:SpawnObjects("UICustomWidget", 49)
    self:_FixScaleMarkers(tScaleMark2, hpMaxWidth, 50)
  end
end

local function fixScaleMarkers(self, tScaleMark, maxWidth, maxHP)
  local halfHPMaxWidth = 0.5 * maxWidth
  local offset = maxWidth / maxHP
  for i = 1, #tScaleMark do
    local offsetX = i * offset - halfHPMaxWidth
    local go = tScaleMark[i]:GetGameObject()
    go.transform.localPosition = Vector3(offsetX, 0, 0)
  end
end

UIBattleChessHPInfo._FixScaleMarkers = fixScaleMarkers

function UIBattleChessHPInfo:InitializeHPBarGroup(hpBarType)
  local t = {}
  if hpBarType == HPBarType.ChessPet then
    t.sliderHP1 = self._sldGreenHp1
    t.sliderHP2 = self._sldGreenHp2
    t.sliderWhiteHP1 = self._sldWhiteHpForGreen
    t.sliderWhiteHP2 = self._sldWhiteHpForGreen2
    t.scaleHP1 = self._scaleRulerGreen1
    t.scaleHP2 = self._scaleRulerGreen2
  else
    t.sliderHP1 = self._sldRedHp
    t.sliderHP2 = self._sldRedHp2
    t.sliderWhiteHP1 = self._sldWhiteHp
    t.sliderWhiteHP2 = self._sldWhiteHpForRed2
    t.scaleHP1 = self._scaleRulerRed1
    t.scaleHP2 = self._scaleRulerRed2
  end
  self:SetHPBarActive(hpBarType)
  return t
end

function UIBattleChessHPInfo:SetHPBarActive(hpBarType)
  if hpBarType == HPBarType.ChessPet then
    self._sldGreenHp1.gameObject:SetActive(true)
    self._sldGreenHp2.gameObject:SetActive(true)
    self._sldWhiteHpForGreen.gameObject:SetActive(true)
    self._sldWhiteHpForGreen2.gameObject:SetActive(true)
    self._sldRedHp.gameObject:SetActive(false)
    self._sldRedHp2.gameObject:SetActive(false)
    self._sldWhiteHp.gameObject:SetActive(false)
    self._sldWhiteHpForRed2.gameObject:SetActive(false)
  else
    self._sldGreenHp1.gameObject:SetActive(false)
    self._sldGreenHp2.gameObject:SetActive(false)
    self._sldWhiteHpForGreen.gameObject:SetActive(false)
    self._sldWhiteHpForGreen2.gameObject:SetActive(false)
    self._sldRedHp.gameObject:SetActive(true)
    self._sldRedHp2.gameObject:SetActive(true)
    self._sldWhiteHp.gameObject:SetActive(true)
    self._sldWhiteHpForRed2.gameObject:SetActive(true)
  end
end

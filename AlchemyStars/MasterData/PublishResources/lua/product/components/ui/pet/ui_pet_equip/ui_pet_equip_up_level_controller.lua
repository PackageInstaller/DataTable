_class("UIPetEquipUpLevelController", UIController)
UIPetEquipUpLevelController = UIPetEquipUpLevelController

function UIPetEquipUpLevelController:Constructor()
  self._petModule = self:GetModule(PetModule)
  self._roleModule = self:GetModule(RoleModule)
  self._atlas = self:GetAsset("UIPetEquip.spriteatlas", LoadType.SpriteAtlas)
  self._type2icon = {
    [1] = "spirit_xiangqing_icon3",
    [2] = "spirit_xiangqing_icon4",
    [3] = "spirit_xiangqing_icon5"
  }
  self._waitTimeAnim = 4800
  self._waitTime = Cfg.cfg_global.shakeWaitTime.IntValue or 2000
  self._shakeX = Cfg.cfg_global.shakeOffsetX.IntValue or 10
  self._shakeY = Cfg.cfg_global.shakeOffsetY.IntValue or 10
  self._needGold = false
  self._needGoldCount = 0
  self._upEffState = 0
  self._upEffDurationState1 = 4700
  self._upEffDurationState2 = 2033
  self._upEffDurationCanJump = 300
  self._upEffEndTime = 0
  self._upEffCanJumpTime = 0
end

function UIPetEquipUpLevelController:OnShow(uiParams)
  self:_GetComponents()
  self._petData = uiParams[1]
  self._petId = self._petData:GetTemplateID()
  self._pstId = self._petData:GetPstID()
  self._currentEquipLv = self._petData:GetEquipLv()
  self._showEquipLv = self._currentEquipLv
  self._elem = self._petData:GetPetFirstElement()
  self._equipMaxLv = 0
  local cfg_equip = Cfg.cfg_pet_equip({
    PetID = self._petId
  })
  if cfg_equip and 0 < #cfg_equip then
    for k, subCfg in pairs(cfg_equip) do
      if subCfg.Level > self._equipMaxLv then
        self._equipMaxLv = subCfg.Level
      end
    end
  else
    Log.fatal("###[UIPetEquipUpLevelController] cfg_pet_equip is nil ! id --> ", self._petId)
  end
  self:_OnValue()
  self:SetArrowBtnVisible()
  self:AttachEvent(GameEventType.ItemCountChanged, self._FlushItemsCount)
  self:AttachEvent(GameEventType.OnOpenGiftsSucc, self._ShowHideUpLvPanel)
  self:AttachEvent(GameEventType.CloseUIBackPackBox, self._ShowHideUpLvPanel)
  local jumpData = GameGlobal.GetModule(SerialAutoFightModule):GetJumpData()
  jumpData:Track_Pet(self._pstId)
  jumpData:Track_From(self:GetName())
end

function UIPetEquipUpLevelController:_GetComponents()
  self._icon = self:GetUIComponent("RawImageLoader", "icon")
  self._iconRaw = self:GetUIComponent("RawImage", "icon")
  self._tipLv = self:GetUIComponent("UILocalizationText", "tipLv")
  self._itemPool = self:GetUIComponent("UISelectObjectPath", "items")
  self._lvFrom = self:GetUIComponent("UILocalizationText", "lvFrom")
  self._lvTo = self:GetUIComponent("UILocalizationText", "lvTo")
  self._skillName = self:GetUIComponent("UILocalizationText", "skillName")
  self._skillGrowth = self:GetGameObject("skillGrowth")
  self._skillGrowthRt = self:GetUIComponent("RectTransform", "skillGrowth")
  self._attGrowth = self:GetGameObject("attGrowth")
  self._attGrowthRt = self:GetUIComponent("RectTransform", "attGrowth")
  self._attGrowthPool = self:GetUIComponent("UISelectObjectPath", "attGrowthPool")
  self._elemGrowthPool = self:GetUIComponent("UISelectObjectPath", "elemGrowthPool")
  self._upLevelTips = self:GetGameObject("upLevelTips")
  self._upLevelTips:SetActive(false)
  local sop = self:GetUIComponent("UISelectObjectPath", "mainmenu")
  self.currencyMenu = sop:SpawnObject("UICurrencyMenu")
  self.currencyMenu:SetData({
    RoleAssetID.RoleAssetGold
  })
  self._consumeRect = self:GetUIComponent("RectTransform", "xiaohaobi")
  self._leftLine = self:GetUIComponent("Graphic", "leftLine")
  self._consumeName = self:GetUIComponent("Graphic", "consumeName")
  self._coinBg = self:GetUIComponent("Graphic", "coin")
  self._needcoin = self:GetUIComponent("Graphic", "needcoin")
  self._rightLine = self:GetUIComponent("Graphic", "rightLine")
  self._goldNeedText = self:GetUIComponent("UILocalizationText", "needcoin")
  self._goldGo = self:GetGameObject("consume")
  self._upAnim = self:GetUIComponent("Animation", "Center")
  self._openGiftTips = self:GetGameObject("openGiftTips")
  self._canLevelupGo = self:GetGameObject("canLevelup")
  self._cannotLevelupGo = self:GetGameObject("cannotLevelup")
  self._leftArrowBtnGo = self:GetGameObject("leftArrowBtn")
  self._rightArrowBtnGo = self:GetGameObject("rightArrowBtn")
  self._dynamicBgSkill = self:GetUIComponent("RectTransform", "dynamicBgSkill")
  self._dynamicBgAttr = self:GetUIComponent("RectTransform", "dynamicBgAttr")
  self._skipUpEffectGo = self:GetGameObject("skipUpEffect")
  local backBtns = self:GetUIComponent("UISelectObjectPath", "backBtns")
  self._backBtns = backBtns:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    self:CloseDialog()
  end, nil, nil, true)
end

function UIPetEquipUpLevelController:_OnValue()
  self:_ShowHideUpLvPanel()
  local cfg = Cfg.cfg_pet_equip_view[self._petId]
  if cfg then
    local icon = cfg.Icon
    self._icon:LoadImage(icon)
  else
    Log.error("###[UIPetEquipUpLevelController]cfg is nil ! id --> ", self._petId)
  end
end

function UIPetEquipUpLevelController:_ShowHideUpLvPanel()
  self:_ShowUpLv(self._currentEquipLv)
end

function UIPetEquipUpLevelController:_ShowUpLv(level)
  local isCurrentLevel = level == self._currentEquipLv
  self._canLevelupGo:SetActive(isCurrentLevel)
  self._cannotLevelupGo:SetActive(not isCurrentLevel)
  self._growthSkill = self:_GrowthSkill(level)
  self._attGrowth:SetActive(not self._growthSkill)
  self._skillGrowth:SetActive(self._growthSkill)
  if self._growthSkill then
    self:_ShowSkillGrowth(level)
    if isCurrentLevel then
      self._skillGrowthRt.anchoredPosition = Vector2(29, 212)
    else
      self._skillGrowthRt.anchoredPosition = Vector2(29, 95)
    end
  else
    self:_ShowAttGrowth(level)
    if isCurrentLevel then
      self._attGrowthRt.anchoredPosition = Vector2(4, 178)
    else
      self._attGrowthRt.anchoredPosition = Vector2(4, 58)
    end
  end
  if isCurrentLevel then
    self._dynamicBgAttr.sizeDelta = Vector2(1169, 431)
    self._dynamicBgSkill.sizeDelta = Vector2(1169, 431)
  else
    self._dynamicBgAttr.sizeDelta = Vector2(1169, 251)
    self._dynamicBgSkill.sizeDelta = Vector2(1169, 251)
  end
  self._lvFrom:SetText(StringTable.Get("str_pet_equip_Lv") .. level)
  self._lvTo:SetText(StringTable.Get("str_pet_equip_Lv") .. level + 1)
  if isCurrentLevel then
    self:_ShowItems(level)
    self:CheckOpenGift()
  else
    self._openGiftTips:SetActive(false)
  end
end

function UIPetEquipUpLevelController:GoldDOShakePosition()
  if self._goldTweer and self._goldTweer:IsPlaying() then
    return
  end
  if self._goldTweer then
    self._goldTweer:Kill()
    self._consumeRect.anchoredPosition = Vector2(0, 0)
  end
  self:SetColor(false)
  self._goldTweer = self._consumeRect:DOShakePosition(1, Vector3(self._shakeX, self._shakeY, 0)):OnComplete(function()
    self:StartTimer()
  end)
end

function UIPetEquipUpLevelController:StartTimer()
  if self.goldEvent then
    GameGlobal.Timer():CancelEvent(self.goldEvent)
    self.goldEvent = nil
  end
  self.goldEvent = GameGlobal.Timer():AddEvent(self._waitTime, function()
    self:SetColor(true)
  end)
end

function UIPetEquipUpLevelController:SetColor(isDefaultColor)
  local color
  if isDefaultColor then
    color = Color(0.96, 0.81, 0.14)
  else
    color = Color(1, 0.4, 0.32)
  end
  if color ~= nil then
    self._leftLine.color = color
    self._consumeName.color = color
    self._coinBg.color = color
    self._needcoin.color = color
    self._rightLine.color = color
  end
end

function UIPetEquipUpLevelController:_ShowItems(level)
  local cfg_equip = Cfg.cfg_pet_equip({
    PetID = self._petId,
    Level = level + 1
  })
  if cfg_equip then
    local mats_tmp = cfg_equip[1].NeedItem
    local mats = {}
    local goldItem
    for i = 1, #mats_tmp do
      local mat_tmp = mats_tmp[i]
      if mat_tmp[1] ~= RoleAssetID.RoleAssetGold then
        mats[#mats + 1] = mat_tmp
      else
        goldItem = mat_tmp
      end
    end
    self._itemPool:SpawnObjects("UIPetEquipUpLvItem", #mats)
    self._items = self._itemPool:GetAllSpawnList()
    for i = 1, #mats do
      local widget = self._items[i]
      widget:SetData(mats[i])
    end
    if goldItem then
      self._goldGo:SetActive(true)
      self._needGold = true
      self._needGoldCount = goldItem[2]
      self._goldNeedText:SetText(goldItem[2])
    else
      self._needGold = false
      self._goldGo:SetActive(false)
    end
  end
end

function UIPetEquipUpLevelController:_FlushItemsCount()
  if self._items then
    for i = 1, #self._items do
      local widget = self._items[i]
      widget:FlushCount()
    end
  end
end

function UIPetEquipUpLevelController:upReqBtnOnClick()
  if self:_CheckMats() then
    if self._needGold then
      local bagNum = self._roleModule:GetGold()
      if bagNum < self._needGoldCount then
        self:GoldDOShakePosition()
        return
      end
    end
    self:Lock("UIPetEquipUpLevelController:upReqBtnOnClick")
    GameGlobal.TaskManager():StartTask(self._OnUpReqBtnOnClick, self)
  elseif self._giftEnough then
    local title = StringTable.Get("str_pet_config_equip_open_gift_title")
    self:ShowDialog("UIOpenGiftGetMatController", self._giftDatas, title)
  end
end

function UIPetEquipUpLevelController:CheckOpenGift()
  local show = false
  local goldEnough = false
  if self._needGold then
    local bagNum = self._roleModule:GetGold()
    if bagNum < self._needGoldCount then
      goldEnough = false
    else
      goldEnough = true
    end
    if not goldEnough then
      self._openGiftTips:SetActive(false)
      return
    end
  end
  if not self:_CheckMats(true) then
    local needList = self:GetNeedList()
    local giftEnough, giftDatas = HelperProxy:GetInstance():GetGiftsFromNeedMat(needList)
    if giftEnough then
      show = true
    end
    self._giftEnough = giftEnough
    self._giftDatas = giftDatas
  end
  self._openGiftTips:SetActive(show)
end

function UIPetEquipUpLevelController:GetNeedList()
  local needList = {}
  for i = 1, #self._items do
    local item = self._items[i]
    local mat = item:GetGapsCount()
    if mat then
      table.insert(needList, mat)
    end
  end
  return needList
end

function UIPetEquipUpLevelController:_CheckMats(noAnim)
  local enough = true
  for i = 1, #self._items do
    local widget = self._items[i]
    if not widget:CheckEnough() then
      enough = false
      if not noAnim then
        goto lbl_17
      end
      do break end
      ::lbl_17::
      widget:Blink()
      break
    end
  end
  return enough
end

function UIPetEquipUpLevelController:OnHide()
  if self._goldTweer then
    self._goldTweer:Kill()
    self._goldTweer = nil
  end
  if self._event then
    GameGlobal.Timer():CancelEvent(self._event)
    self._event = nil
  end
  if self.goldEvent then
    GameGlobal.Timer():CancelEvent(self.goldEvent)
    self.goldEvent = nil
  end
  local jumpData = GameGlobal.GetModule(SerialAutoFightModule):GetJumpData()
  jumpData:Track_From()
  jumpData:Track_Pet()
end

function UIPetEquipUpLevelController:UpLevelSucc()
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundEquipUpLevel)
  local nowMs = GameGlobal:GetInstance():GetCurrentTime()
  self._upEffState = 1
  self._upEffEndTime = nowMs + self._upEffDurationState1
  self._upEffCanJumpTime = nowMs + self._upEffDurationCanJump
  self._tipLv:SetText(StringTable.Get("str_pet_equip_Lv") .. self._currentEquipLv)
  self._upAnim:Play("uieff_PetEquipLevel_LevelUp")
  local state = self._upAnim:get_Item("uieff_PetEquipLevel_LevelUp")
  state.normalizedTime = 0
  if not self._growthSkill then
    self:ItemsAnim()
  end
  self._skipUpEffectGo:SetActive(true)
end

function UIPetEquipUpLevelController:OnUpdate(dms)
  if self._growthElems then
    for i = 1, #self._growthElems do
      local item = self._growthElems[i]
      if item then
        item:Update(dms)
      end
    end
  end
  if self._growthAtts then
    for i = 1, #self._growthAtts do
      local item = self._growthAtts[i]
      if item then
        item:Update(dms)
      end
    end
  end
  if self._upEffState == 1 or self._upEffState == 2 then
    local nowMs = GameGlobal:GetInstance():GetCurrentTime()
    if nowMs > self._upEffCanJumpTime then
      if self._upEffState == 1 then
        if nowMs > self._upEffEndTime then
          self._upEffState = 2
          self._upEffEndTime = nowMs + self._upEffDurationState2
          self._upLevelTips:SetActive(true)
        end
      elseif self._upEffState == 2 and nowMs > self._upEffEndTime then
        self._upEffState = 0
        self._upLevelTips:SetActive(false)
        self._skipUpEffectGo:SetActive(false)
        if self._currentEquipLv >= self._equipMaxLv then
          self:CloseDialog()
        else
          self:_ShowHideUpLvPanel()
        end
      end
    end
  end
end

function UIPetEquipUpLevelController:PlayShaderAnim()
  local mat = self._iconRaw.material
  mat:SetFloat("_Intensity", 0)
  local seq = DG.Tweening.DOTween.Sequence()
  local tween_1 = mat:DOFloat(0.5, "_Intensity", 0.1)
  seq:Append(tween_1)
  local tween_2 = mat:DOFloat(3.48, "_Intensity", 1.333)
  seq:Append(tween_2)
  local tween_3 = mat:DOFloat(0.831, "_Intensity", 0.033)
  seq:Append(tween_3)
  local delayedTimer = 0.633
  seq:AppendInterval(delayedTimer)
  local tween_4 = mat:DOFloat(0, "_Intensity", 0.333)
  seq:Append(tween_4)
end

function UIPetEquipUpLevelController:ItemsAnim()
  for i = 1, #self._growthElems do
    local item = self._growthElems[i]
    item:UpLevelAnim()
  end
  for i = 1, #self._growthAtts do
    local item = self._growthAtts[i]
    item:UpLevelAnim()
  end
end

function UIPetEquipUpLevelController:_OnUpReqBtnOnClick(TT)
  local res = self._petModule:ReqUpEquipLv(TT, self._pstId)
  self:UnLock("UIPetEquipUpLevelController:upReqBtnOnClick")
  if res:GetSucc() then
    self._currentEquipLv = self._petData:GetEquipLv()
    self._showEquipLv = self._currentEquipLv
    self:SetArrowBtnVisible()
    self:UpLevelSucc()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnEquipDataChanged)
  else
    local result = res:GetResult()
    Log.error("###[UIPetEquipUpLevelController] RequestPetEquipUpGrade fail , result --> ", result)
    local errorStr = ""
    if result == PET_RESULT_CODE.PET_EQUIP_NOT_OPEN then
      errorStr = StringTable.Get("str_pet_equip_PET_EQUIP_NOT_OPEN")
    elseif result == PET_RESULT_CODE.PET_EQUIP_ITEM_NOT_ENOUGH then
      errorStr = StringTable.Get("str_pet_equip_PET_EQUIP_ITEM_NOT_ENOUGH")
    elseif result == PET_RESULT_CODE.PET_EQUIP_NOT_CFG then
      errorStr = StringTable.Get("str_pet_equip_PET_EQUIP_NOT_CFG")
    elseif result == PET_RESULT_CODE.PET_EQUIP_LV_MAX then
      errorStr = StringTable.Get("str_pet_equip_PET_EQUIP_LV_MAX")
    end
    ToastManager.ShowToast(errorStr)
  end
end

function UIPetEquipUpLevelController:_GrowthSkill(level)
  local nextLv = level + 1
  if nextLv > self._equipMaxLv then
    nextLv = self._equipMaxLv
  end
  local cfg_pet_equip = Cfg.cfg_pet_equip({
    PetID = self._petId,
    Level = nextLv
  })
  if cfg_pet_equip then
    if cfg_pet_equip[1].IsParamImprove == 1 then
      return true
    end
    return false
  else
    Log.fatal("###[UIPetEquipUpLevelController] cfg_pet_equip is nil ! id --> ", self._petId, "| lv --> ", nextLv)
  end
end

function UIPetEquipUpLevelController:_ShowSkillGrowth(level)
  local nextLv = level + 1
  local skillID = self._petData:GetPetPassiveSkill()
  local cfg = BattleSkillCfg(skillID)
  if cfg then
    local descStr = HelperProxy:GetInstance():GetEquipSkillDesc(cfg.Desc, self._petData:GetTemplateID(), nextLv, skillID)
    if not self._skillInfo then
      local skillInfoPool = self:GetUIComponent("UISelectObjectPath", "skillInfo")
      self._skillInfo = skillInfoPool:SpawnObject("UIPetEquipLevelupSkill")
    end
    self._skillInfo:SetData(cfg.Icon, descStr)
  end
end

function UIPetEquipUpLevelController:_ShowAttGrowth(level)
  local cfg_pet_equip = Cfg.cfg_pet_equip({
    PetID = self._petId,
    Level = level
  })
  if not cfg_pet_equip then
    Log.fatal("###[UIPetEquipUpLevelController]cfg_pet_equip is nil ! id --> ", self._petId, "|level --> ", level)
    return
  end
  local cfg_pet_equip_next_lv = Cfg.cfg_pet_equip({
    PetID = self._petId,
    Level = level + 1
  })
  if not cfg_pet_equip_next_lv then
    Log.fatal("###[UIPetEquipUpLevelController]cfg_pet_equip_next_lv is nil ! id --> ", self._petId, "|level --> ", level + 1)
    return
  end
  local cfgData = cfg_pet_equip[1]
  local nextData = cfg_pet_equip_next_lv[1]
  local growthAtts = {}
  if nextData.Attack and cfgData.Attack then
    local attType = 1
    local attFrom = cfgData.Attack
    local attTo = nextData.Attack
    local sprite = self._atlas:GetSprite(self._type2icon[attType])
    local attInfo = UIPetEquipGrowthAttInfo:New(attType, attFrom, attTo, sprite)
    growthAtts[#growthAtts + 1] = attInfo
  else
    Log.fatal("###[UIPetEquipUpLevelController] {if nextData.Attack and cfgData.Attack then} false ! id --> ", self._petId, "| lv --> ", level)
  end
  if nextData.Defence and cfgData.Defence then
    local attType = 2
    local attFrom = cfgData.Defence
    local attTo = nextData.Defence
    local sprite = self._atlas:GetSprite(self._type2icon[attType])
    local attInfo = UIPetEquipGrowthAttInfo:New(attType, attFrom, attTo, sprite)
    growthAtts[#growthAtts + 1] = attInfo
  else
    Log.fatal("###[UIPetEquipUpLevelController] {if nextData.Defence and cfgData.Defence then} false ! id --> ", self._petId, "| lv --> ", level)
  end
  if nextData.Health and cfgData.Health then
    local attType = 3
    local attFrom = cfgData.Health
    local attTo = nextData.Health
    local sprite = self._atlas:GetSprite(self._type2icon[attType])
    local attInfo = UIPetEquipGrowthAttInfo:New(attType, attFrom, attTo, sprite)
    growthAtts[#growthAtts + 1] = attInfo
  else
    Log.fatal("###[UIPetEquipUpLevelController] {if nextData.Health and cfgData.Health then} false ! id --> ", self._petId, "| lv --> ", level)
  end
  self._attGrowthPool:SpawnObjects("UIPetEquipGrowthAttItem", #growthAtts)
  self._growthAtts = self._attGrowthPool:GetAllSpawnList()
  for i = 1, #growthAtts do
    local att = self._growthAtts[i]
    att:SetData(growthAtts[i])
  end
  local growthElems = {}
  if nextData.PropertyRestraint and cfgData.PropertyRestraint then
    local attFrom = cfgData.PropertyRestraint
    local attTo = nextData.PropertyRestraint
    local elemInfo = UIPetEquipGrowthElemInfo:New(self._elem, attFrom, attTo)
    growthElems[#growthElems + 1] = elemInfo
  else
    Log.fatal("###[UIPetEquipUpLevelController] {if nextData.PropertyRestraint and cfgData.PropertyRestraint then} false ! id --> ", self._petId, "| lv --> ", level)
  end
  self._elemGrowthPool:SpawnObjects("UIPetEquipGrowthElemItem", #growthElems)
  self._growthElems = self._elemGrowthPool:GetAllSpawnList()
  for i = 1, #growthElems do
    local elem = self._growthElems[i]
    elem:SetData(growthElems[i])
  end
end

function UIPetEquipUpLevelController:upInfoBtnOnClick()
  if self._growthSkill then
    local skillID = self._petData:GetPetPassiveSkill()
    self:ShowDialog("UIPetEquipUpLvInfoController", self._petData, self._currentEquipLv, skillID)
  else
    self:ShowDialog("UIPetEquipUpLvInfoController", self._petData, self._currentEquipLv)
  end
end

function UIPetEquipUpLevelController:UpInfoBtn2OnClick()
  self:upInfoBtnOnClick()
end

function UIPetEquipUpLevelController:LeftArrowBtnOnClick()
  if self._showEquipLv > self._currentEquipLv then
    self._showEquipLv = self._showEquipLv - 1
    self:_ShowUpLv(self._showEquipLv)
    self:SetArrowBtnVisible()
  end
end

function UIPetEquipUpLevelController:RightArrowBtnOnClick()
  if self._showEquipLv < self._equipMaxLv - 1 then
    self._showEquipLv = self._showEquipLv + 1
    self:_ShowUpLv(self._showEquipLv)
    self:SetArrowBtnVisible()
  end
end

function UIPetEquipUpLevelController:SetArrowBtnVisible()
  self._leftArrowBtnGo:SetActive(self._showEquipLv > self._currentEquipLv)
  self._rightArrowBtnGo:SetActive(self._showEquipLv < self._equipMaxLv - 1)
end

function UIPetEquipUpLevelController:SkipUpEffectOnClick()
  local nowMs = GameGlobal:GetInstance():GetCurrentTime()
  if nowMs > self._upEffCanJumpTime and self._upEffState == 1 then
    self._upEffEndTime = 0
    local state = self._upAnim:get_Item("uieff_PetEquipLevel_LevelUp")
    state.normalizedTime = 1
  end
end

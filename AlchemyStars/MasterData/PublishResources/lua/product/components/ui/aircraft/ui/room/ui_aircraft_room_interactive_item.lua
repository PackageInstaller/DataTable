_class("UIAircraftRoomInteractiveItem", UICustomWidget)
UIAircraftRoomInteractiveItem = UIAircraftRoomInteractiveItem

function UIAircraftRoomInteractiveItem:OnShow(uiParams)
  self._tipsIsShow = false
  self._levelLabel = self:GetUIComponent("UILocalizationText", "Level")
  self._favoribleTimes = self:GetUIComponent("UILocalizationText", "FavorableTimes")
  self._nameLabel = self:GetUIComponent("UILocalizationText", "Name")
  self._favorableLabel = self:GetUIComponent("UILocalizationText", "Favorable")
  self._favorableBarImg1 = self:GetUIComponent("Slider", "FavorableBar1")
  self._favorableBarImg2 = self:GetUIComponent("Slider", "FavorableBar2")
  self._addedFavorableLabel = self:GetUIComponent("UILocalizationText", "AddedFavorable")
  self._addedFavorableRectTran = self:GetUIComponent("RectTransform", "AddedFavorable")
  self._tipsGo = self:GetGameObject("tips")
  self._addedFavorableRectTran.gameObject:SetActive(false)
  self:AttachEvent(GameEventType.AircraftAddPetFavorable, self.FavorableChanged)
  self:AttachEvent(GameEventType.PetDataChangeEvent, self.FavorableChangedUnPlayHud)
end

function UIAircraftRoomInteractiveItem:OnHide()
  self._tipsIsShow = false
  self:DetachEvent(GameEventType.AircraftAddPetFavorable, self.FavorableChanged)
  self:DetachEvent(GameEventType.PetDataChangeEvent, self.FavorableChangedUnPlayHud)
end

function UIAircraftRoomInteractiveItem:Update(deltaTimeMS)
  if self._curLevel ~= self._targetLevel or self._curFavorable ~= self._targetFavorable then
    local targetPercent = 1
    if self._targetLevel == self._curLevel then
      self._curMaxFavorable = self._targetMaxFavorable
      targetPercent = self._targetFavorable / self._targetMaxFavorable
    end
    local added = deltaTimeMS / 1000 * self._barSpeed
    local curValue = self._favorableBarImg1.value
    curValue = curValue + added
    if targetPercent > curValue then
      self._favorableBarImg1.value = curValue
      self._favorableBarImg2.value = curValue
    elseif self._curLevel ~= self._targetLevel then
      self._curLevel = self._curLevel + 1
      self._curFavorable = 0
      self._favorableBarImg1.value = 0
      self._favorableBarImg2.value = 0
      if self._curLevel == self._targetLevel and self._curFavorable == self._targetFavorable then
        self._favorableBarImg1.value = targetPercent
        self._favorableBarImg2.value = targetPercent
        self._curFavorable = self._targetFavorable
        self:_RefreshPetInfo()
      end
    else
      self._favorableBarImg1.value = targetPercent
      self._favorableBarImg2.value = targetPercent
      self._curFavorable = self._targetFavorable
      self:_RefreshPetInfo()
    end
  end
  if self._isPlayHud then
    self._hudTimer = self._hudTimer + deltaTimeMS / 1000
    if self._hudTimer > self._hudDuration then
      self._hudTimer = self._hudDuration
      self._addedFavorableRectTran.gameObject:SetActive(false)
      self._isPlayHud = false
    end
    local percent = self._hudTimer / self._hudDuration
    self._addedFavorableLabel.transform.localScale = Vector3.Lerp(self._hudInitScale, self._hudTargetScale, percent)
    self._addedFavorableLabel.color = Color.Lerp(self._hudInitCol, self._hudTargetCol, percent)
    self._addedFavorableRectTran.anchoredPosition = Vector2.Lerp(self._hudInitPos, self._hudTargetPos, percent)
  end
  if self._tipsIsShow then
    local mouse = GameGlobal.EngineInput().mousePresent
    if mouse then
      if GameGlobal.EngineInput().GetMouseButtonDown(0) then
        self:CloseTips()
      end
    else
      local touchCount = GameGlobal.EngineInput().touchCount
      if 0 < touchCount then
        local touch0 = GameGlobal.EngineInput().GetTouch(0)
        if touch0 and touch0.phase == TouchPhase.Began then
          self:CloseTips()
        end
      end
    end
  end
end

function UIAircraftRoomInteractiveItem:Refresh(room, targetPet)
  self._targetPet = targetPet
  self._petData = targetPet:GetPetData()
  self._room = room
  self._curLevel = nil
  self._curFavorable = nil
  self._curMaxFavorable = nil
  self._targetLevel = nil
  self._targetFavorable = nil
  self._targetMaxFavorable = nil
  self._barSpeed = 1.5
  self._hudTimer = 0
  self._hudDuration = 0.8
  self._isPlayHud = false
  if not self._addedFavorableRectTran then
    self._addedFavorableRectTran = self:GetUIComponent("RectTransform", "AddedFavorable")
  end
  self._addedFavorableRectTran.gameObject:SetActive(false)
  self:_GetPetData()
  self:_RefreshPetInfo()
end

function UIAircraftRoomInteractiveItem:_GetPetData()
  self._maxLevel = self._petData:GetPetAffinityMaxLevel()
  self._curLevel = self._petData:GetPetAffinityLevel()
  self._curFavorable = self._petData:GetPetAffinityExp() - Cfg.cfg_pet_affinity_exp[self._curLevel].NeedAffintyExp
  self._curMaxFavorable = self._petData:GetPetAffinityMaxExp(self._curLevel)
  self._targetLevel = self._curLevel
  self._targetFavorable = self._curFavorable
  self._targetMaxFavorable = self._curMaxFavorable
end

function UIAircraftRoomInteractiveItem:_RefreshPetInfo()
  if self._petData == nil then
    return
  end
  local percent = self._curFavorable / self._curMaxFavorable
  self._nameLabel.text = StringTable.Get(self._petData:GetPetName())
  self._levelLabel.text = self._curLevel
  local expText
  if self._curLevel == self._maxLevel then
    expText = "MAX"
    percent = 1
  else
    expText = self._curFavorable .. "/" .. self._curMaxFavorable
  end
  self._favorableBarImg1.value = percent
  self._favorableBarImg2.value = percent
  self._favorableLabel.text = expText
  if not self._petModule then
    self._petModule = GameGlobal.GetModule(PetModule)
  end
  local remainAffinityCount = self._petModule:GetLeftAffinityAddCount()
  self._favoribleTimes.text = remainAffinityCount .. "/" .. self._petModule:GetMaxAffinityAddCount()
end

function UIAircraftRoomInteractiveItem:FavorableChangedUnPlayHud()
  self:FavorableChanged()
end

function UIAircraftRoomInteractiveItem:FavorableChanged(addValue)
  self._targetLevel = self._petData:GetPetAffinityLevel()
  self._targetFavorable = self._petData:GetPetAffinityExp() - Cfg.cfg_pet_affinity_exp[self._targetLevel].NeedAffintyExp
  self._targetMaxFavorable = self._petData:GetPetAffinityMaxExp(self._targetLevel)
  if addValue then
    self._hudTimer = 0
    local color = self._addedFavorableLabel.color
    self._hudInitScale = Vector3(0.16, 0.16, 0.16)
    self._hudInitCol = Color(color.r, color.g, color.b, 0.3)
    self._hudInitPos = Vector2(0, 0)
    self._hudTargetPos = Vector2(0, 30)
    self._hudTargetCol = Color(color.r, color.g, color.b, 1)
    self._hudTargetScale = Vector3(1, 1, 1)
    if self._curLevel == self._maxLevel then
      self._addedFavorableLabel.text = StringTable.Get("str_affinity_max_en")
    else
      self._addedFavorableLabel.text = "+" .. addValue
    end
    self._addedFavorableLabel.transform.localScale = self._hudInitScale
    self._addedFavorableLabel.color = self._hudInitCol
    self._addedFavorableRectTran.anchoredPosition = self._hudInitPos
    self._addedFavorableRectTran.gameObject:SetActive(true)
    self._isPlayHud = true
  end
end

function UIAircraftRoomInteractiveItem:_GetAddedFavorableExp()
  return self._targetFavorable - self._curFavorable
end

function UIAircraftRoomInteractiveItem:BtnReturnOnClick(go)
  self:GetGameObject():SetActive(false)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.InteractiveViewSwitchToRoomView, self._room, self._targetPet)
end

function UIAircraftRoomInteractiveItem:exclamationIconOnClick()
  self:ShowTips()
end

function UIAircraftRoomInteractiveItem:ShowTips()
  self._tipsGo:SetActive(true)
  self._tipsIsShow = true
end

function UIAircraftRoomInteractiveItem:CloseTips()
  self._tipsIsShow = false
  self._tipsGo:SetActive(false)
end

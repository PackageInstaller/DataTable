_class("UIDispatchRewardItem", UICustomWidget)
UIDispatchRewardItem = UIDispatchRewardItem

function UIDispatchRewardItem:OnShow(uiParams)
  self._uiCommonAtlas = self:GetAsset("UICommon.spriteatlas", LoadType.SpriteAtlas)
  self._iconImg = self:GetUIComponent("RawImageLoader", "icon")
  self._countLabel = self:GetUIComponent("UILocalizationText", "count")
  self._desLabel = self:GetUIComponent("UILocalizationText", "des")
  self._desPanel = self:GetGameObject("despanel")
  self._newGo = self:GetGameObject("new")
  self._maxGo = self:GetGameObject("max")
  self._qualityImg = self:GetUIComponent("Image", "quality")
  self._qualityGo = self:GetGameObject("quality")
  self._timerHandler = nil
  self._timer = 0
  self._totalTime = 200
  self._delayTime = 50
  self._curCount = 0
  self._targetCount = 0
end

function UIDispatchRewardItem:OnHide()
  self._uiCommonAtlas = nil
  if self._timerHandler then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
    self._timerHandler = nil
  end
end

function UIDispatchRewardItem:Refresh(itemInfo, callback, isPlayAnim)
  self._itemInfo = itemInfo
  local ItemTempleate = Cfg.cfg_item[itemInfo.id]
  self._iconImg:LoadImage(ItemTempleate.Icon)
  self._maxGo:SetActive(itemInfo.isMax)
  self._newGo:SetActive(itemInfo.isNew)
  if itemInfo.des then
    self._desPanel:SetActive(true)
    self._desLabel.text = itemInfo.des
  else
    self._desPanel:SetActive(false)
  end
  if itemInfo.isBook == false and itemInfo.isFuniture == false then
    if self._timerHandler then
      GameGlobal.Timer():CancelEvent(self._timerHandler)
      self._timerHandler = nil
    end
    if isPlayAnim then
      if type(itemInfo.count) == "number" then
        self._timer = 0
        self._curCount = self._targetCount
        self._targetCount = itemInfo.count
        if self._currentCount ~= self._targetCount then
          self._timerHandler = GameGlobal.Timer():AddEventTimes(self._delayTime, TimerTriggerCount.Infinite, function()
            self:_OnUpdateAnmim()
          end)
        else
          self._countLabel.text = itemInfo.count
          if itemInfo.isExtraReward then
            self._countLabel.text = itemInfo.count .. "/" .. itemInfo.maxCount
          end
        end
      else
        self._countLabel.text = itemInfo.count
        self._curCount = 0
        self._targetCount = 0
      end
    else
      self._countLabel.text = itemInfo.count
      if type(itemInfo.count) == "number" then
        self._curCount = itemInfo.count
        self._targetCount = self._curCount
        if itemInfo.isExtraReward then
          self._countLabel.text = itemInfo.count .. "/" .. itemInfo.maxCount
        end
      else
        self._curCount = 0
        self._targetCount = self._curCount
      end
    end
  end
  if itemInfo.isBook then
    self._countLabel.text = StringTable.Get("str_dispatch_room_book")
    self._curCount = 0
    self._targetCount = self._curCount
  end
  if itemInfo.isFuniture then
    self._countLabel.text = StringTable.Get("str_dispatch_room_funiture")
    self._curCount = 0
    self._targetCount = self._curCount
  end
  local qualityName = UIEnum.ItemColorFrame(ItemTempleate.Color)
  if qualityName ~= "" then
    self._qualityGo:SetActive(true)
    self._qualityImg.sprite = self._uiCommonAtlas:GetSprite(qualityName)
  else
    self._qualityGo:SetActive(false)
  end
  self._callback = callback
end

function UIDispatchRewardItem:_OnUpdateAnmim()
  self._timer = self._timer + self._delayTime
  local percent = self._timer / self._totalTime
  if self._timer > self._totalTime then
    percent = 1
    self._curCount = self._targetCount
    if self._timerHandler then
      GameGlobal.Timer():CancelEvent(self._timerHandler)
      self._timerHandler = nil
    end
  end
  local phyRec = DG.Tweening.DOVirtual.EasedValue(self._curCount, self._targetCount, percent, DG.Tweening.Ease.OutQuad)
  if self._itemInfo.isExtraReward then
    self._countLabel.text = math.floor(phyRec) .. "/" .. self._itemInfo.maxCount
  else
    self._countLabel:SetText(math.floor(phyRec))
  end
end

function UIDispatchRewardItem:MaskOnClick(go)
  self._newGo:SetActive(false)
  if self._callback then
    self._callback()
  end
end

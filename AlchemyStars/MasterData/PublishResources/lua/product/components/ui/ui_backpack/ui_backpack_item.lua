_class("UIBackPackItem", UICustomWidget)
UIBackPackItem = UIBackPackItem

function UIBackPackItem:OnShow(uiParams)
  self._loginModule = GameGlobal.GetModule(LoginModule)
  self._svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  self._rect = self:GetUIComponent("RectTransform", "rect")
  local sop = self:GetUIComponent("UISelectObjectPath", "uiitem")
  self.uiItem = sop:SpawnObject("UIAsset")
  self._index = -1
  self._itemCount = ""
  self._lessTimeGo = self:GetGameObject("lessTimeGo")
  self._timeDownGo = self:GetGameObject("timeDownGo")
  self._timeTexRoot = self:GetGameObject("timeTexRoot")
  self._timeTex = self:GetUIComponent("UILocalizationText", "timeTex")
  self._transform = self:GetGameObject().transform
  self._canvasGroup = self:GetUIComponent("CanvasGroup", "uiitem")
  self._collection = self:GetGameObject("collection")
  self._collectionLoader = self:GetUIComponent("RawImageLoader", "collection")
  self._collectionRect = self:GetUIComponent("RectTransform", "collection")
  self._chooseGO = self:GetGameObject("choose")
  self._anim = self:GetUIComponent("Animation", "anim")
  self._canvasGroup = self:GetUIComponent("CanvasGroup", "anim")
  self._btnImage = self:GetUIComponent("Image", "btn")
  self._uiCommonAtlas = self:RootUIOwner():GetAsset("UICommon.spriteatlas", LoadType.SpriteAtlas)
end

function UIBackPackItem:Select(select, noAnim)
  if self._chooseGO then
    self._chooseGO:SetActive(select)
    if select then
      if noAnim then
        return
      end
      if self._tweener then
        self._tweener:Kill(true)
      end
      self._tweener = self._transform:DOPunchScale(Vector3(0.1, 0.1, 0.1), 0.2)
    end
  end
end

function UIBackPackItem:BtnOnClick()
  self:itemOnClick()
end

function UIBackPackItem:PlayFadeInAnim()
  self._anim:Play("uieff_BackpackItem_FadeIn")
end

function UIBackPackItem:ResetInAnim()
  self._canvasGroup.alpha = 1
end

function UIBackPackItem:SetBtnImage(bImage)
  if bImage then
    self._btnImage.sprite = self._uiCommonAtlas:GetSprite("spirit_dikuang10_frame")
  else
    self._btnImage.sprite = self._uiCommonAtlas:GetSprite("spirit_dikuang1_frame")
  end
end

function UIBackPackItem:HideCount()
  self.uiItem:SetItemData(nil)
  if self.redComponent then
    self.redComponent:SetNew(false)
  end
  self:SetBtnImage(false)
end

function UIBackPackItem:SelectImg(isOn, noAnim)
  self:Select(isOn, noAnim)
end

function UIBackPackItem:ResetData()
  self._item_data = nil
  self._lessTimeGo:SetActive(false)
  self._timeDownGo:SetActive(false)
  self._canvasGroup.alpha = 1
  self._timeTexRoot:SetActive(false)
end

function UIBackPackItem:SetData(itemInfo, index, clickCallback, getSaveRed, removeSaveRed)
  self._item_data = itemInfo
  self._index = index
  if not self._item_data then
    self._lessTimeGo:SetActive(false)
    self._timeDownGo:SetActive(false)
    self._canvasGroup.alpha = 1
    self._timeTexRoot:SetActive(false)
    return
  end
  self._templateData = self._item_data:GetTemplate()
  self._itemCount = self._item_data:GetCount()
  local itemId = self._templateData.ID
  self._clickCallback = clickCallback
  self._getSaveRed = getSaveRed
  self._removeSaveRed = removeSaveRed
  local _showNew = false
  local pstid = itemInfo:GetID()
  if self._item_data:IsNew() or self._getSaveRed(pstid) then
    local cfg_item = Cfg.cfg_item[itemId]
    if cfg_item and cfg_item.ShowNew and cfg_item.ShowNew == 1 then
      _showNew = true
    end
  end
  self.uiItem:SetData(itemId)
  self.redComponent = self.uiItem:AddComponent(UIAssetComponentNew)
  self.uiItem:SetItemData({
    text = self._itemCount,
    icon = self._templateData.Icon,
    quality = self._templateData.Color
  })
  self.redComponent:SetNew(_showNew)
  self:SetBtnImage(true)
  self:InitTimeLess()
end

function UIBackPackItem:InitTimeLess()
  local itemId = self._templateData.ID
  local cfg_item = Cfg.cfg_item[itemId]
  if not cfg_item then
    Log.error("###[UIBackPackItem] cfg is nil ! id --> ", itemId)
  end
  self._lessTimeStr = cfg_item.DeadTime
  if string.isnullorempty(self._lessTimeStr) then
    self._lessTimeStr = cfg_item.CompulsiveDeadTime
  end
  self._isTimeItem = true
  if string.isnullorempty(self._lessTimeStr) then
    self._isTimeItem = false
  end
  self._lessTimeGo:SetActive(self._isTimeItem)
  self._timeDownGo:SetActive(false)
  self._canvasGroup.alpha = 1
  self._timeTexRoot:SetActive(false)
  self._timeDown = false
  if self._isTimeItem then
    self._timeType = Enum_DateTimeZoneType.E_ZoneType_ServerTimeZone
    if cfg_item.TimeTransform and cfg_item.TimeTransform == 0 then
      self._timeType = Enum_DateTimeZoneType.E_ZoneType_GMT
    end
    local lessTime = math.floor(self._loginModule:GetTimeStampByTimeStr(self._lessTimeStr, self._timeType))
    local nowTime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
    local gapTime = lessTime - nowTime
    if gapTime <= 0 then
      if self._timer then
        GameGlobal.Timer():CancelEvent(self._timer)
        self._timer = nil
      end
      self._timeDownGo:SetActive(true)
      self._canvasGroup.alpha = 0.5
      self._timeDown = true
    else
      self:ShowTimeLess()
      self._timeTexRoot:SetActive(true)
      if self._timer then
        GameGlobal.Timer():CancelEvent(self._timer)
        self._timer = nil
      end
      self._timer = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
        self:ShowTimeLess()
      end)
    end
  elseif self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
    self._timer = nil
  end
end

function UIBackPackItem:ShowTimeLess()
  local lessTime = math.floor(self._loginModule:GetTimeStampByTimeStr(self._lessTimeStr, self._timeType))
  local nowTime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  local gapTime = lessTime - nowTime
  if 0 < gapTime then
    local timeTex = HelperProxy:GetInstance():Time2Tex(gapTime)
    self._timeTex:SetText(timeTex)
  else
    if self._timer then
      GameGlobal.Timer():CancelEvent(self._timer)
      self._timer = nil
    end
    self._timeDownGo:SetActive(true)
    self._canvasGroup.alpha = 0.5
    self._timeDown = true
    self._timeTexRoot:SetActive(false)
  end
end

function UIBackPackItem:itemOnClick()
  if not self._item_data then
    return
  end
  if self.event then
    GameGlobal.Timer():CancelEvent(self.event)
  end
  self.event = GameGlobal.Timer():AddEvent(150, function()
    if self._item_data then
      local pstid = self._item_data:GetID()
      if self._getSaveRed(pstid) then
        self._removeSaveRed(pstid)
        self.redComponent:SetNew(false)
      elseif self._item_data:IsNew() then
        self:StartTask(function(TT)
          local itemModule = self:GetModule(ItemModule)
          itemModule:SetItemUnnew(TT, self._item_data:GetID())
        end)
      end
    end
  end)
  self._clickCallback(self._index)
end

function UIBackPackItem:OnHide()
  if self.event then
    GameGlobal.Timer():CancelEvent(self.event)
    self.event = nil
  end
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
    self._timer = nil
  end
end

function UIBackPackItem:FormatItemCount()
  return HelperProxy:GetInstance():FormatItemCount(self._itemCount)
end

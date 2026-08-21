_class("UICN7N36TotalLoginAwardCell", UICustomWidget)
UICN7N36TotalLoginAwardCell = UICN7N36TotalLoginAwardCell

function UICN7N36TotalLoginAwardCell:Constructor()
  self._animInfo = {
    name = "uieff_Activity_Eve_LoginAward_Cell_Get",
    len = 333
  }
end

function UICN7N36TotalLoginAwardCell:OnShow(uiParams)
  self:AttachEvent(GameEventType.OnActivityTotalAwardGot, self.OnActivityTotalAwardGot)
  self:AttachEvent(GameEventType.OnActivityTotalAwardCellSelect, self.OnActivityTotalAwardCellSelect)
  self:InitWidget()
  self._timeEvent = GameGlobal.RealTimer():AddEvent(1, function()
    if self._rootAnim then
      self._rootAnim:Play("uieff_Activity_Eve_LoginAward_Cell_In")
    end
  end)
end

function UICN7N36TotalLoginAwardCell:OnHide()
  self:DetachEvent(GameEventType.OnActivityTotalAwardGot, self.OnActivityTotalAwardGot)
  self:DetachEvent(GameEventType.OnActivityTotalAwardCellSelect, self.OnActivityTotalAwardCellSelect)
  if self._timeEvent then
    GameGlobal.RealTimer():CancelEvent(self._timeEvent)
    self._timeEvent = nil
  end
  if self._resF then
    self._resF:Dispose()
    self._resF = nil
  end
  if self._resB then
    self._resB:Dispose()
    self._resB = nil
  end
end

function UICN7N36TotalLoginAwardCell:OnActivityTotalAwardGot(days)
  if self._data._dayNum == days then
    self._data._state = ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_RECVED
    self:SetState(self._data._state)
    self:_PlayGetAnim()
  end
end

function UICN7N36TotalLoginAwardCell:OnActivityTotalAwardCellSelect(days)
  if self._data._dayNum == days then
    self:SetSelected(true)
  else
    self:SetSelected(false)
  end
end

function UICN7N36TotalLoginAwardCell:InitWidget()
  self._rootAnim = self:GetUIComponent("Animation", "Root")
  self._dayNumText = self:GetUIComponent("UILocalizationText", "DayNumText")
  self._specialDayNumText = self:GetUIComponent("UILocalizationText", "SpecialDayNumText")
  self._selectCellBorder = self:GetUIComponent("Image", "SelectCellBorder")
  self._stateLockedImg = self:GetUIComponent("Image", "StateLockedImg")
  self._bgNormalGo = self:GetGameObject("BgNormal")
  self._bgSpecialGo = self:GetGameObject("BgSpecial")
  self._dayAreaGo = self:GetUIComponent("Image", "DayArea")
  self._specialDayAreaGo = self:GetUIComponent("Image", "SpecialDayArea")
  self._bgNormalImg = self:GetUIComponent("RawImage", "BgNormal")
  self._bgNormalImgLoader = self:GetUIComponent("RawImageLoader", "BgNormal")
  self._bgSpecialImg = self:GetUIComponent("RawImage", "BgSpecial")
  self._bgSpecialImgLoader = self:GetUIComponent("RawImageLoader", "BgSpecial")
  self._dayText = self:GetUIComponent("UILocalizationText", "DayText")
  self._specialDayText = self:GetUIComponent("UILocalizationText", "SpecialDayText")
  self._setAlphaArea = self:GetUIComponent("CanvasGroup", "SetAlphaArea")
  self._specialNum = self:GetUIComponent("Image", "SpecialDayNumImage")
  self._num = self:GetUIComponent("Image", "DayNumImage")
  self._selectStateAreaGo = self:GetGameObject("SelectStateArea")
  self._stateArea = self:GetGameObject("StateArea")
  self._stateGot = self:GetGameObject("StateGot")
  self._stateCanGet = self:GetGameObject("StateCanGet")
  self._stateLocked = self:GetGameObject("StateLocked")
  self._cellState = 1
  self._stateAreaGroup = {
    [ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_RECVED] = self._stateGot,
    [ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_CAN_RECV] = self._stateCanGet,
    [ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_LOCK] = self._stateLocked
  }
  self._item1 = self:GetUIComponent("UISelectObjectPath", "Item1")
  self._item2 = self:GetUIComponent("UISelectObjectPath", "item2")
  self._items = {
    self._item1,
    self._item2
  }
  self._itemGo1 = self:GetGameObject("Item1")
  self._itemGo2 = self:GetGameObject("item2")
  self._itemGos = {
    self._itemGo1,
    self._itemGo2
  }
  self._itemWidgetTb = {}
  self._stateGotText = self:GetUIComponent("UILocalizationText", "StateGotText")
  local gotStr = StringTable.Get("str_activity_intro_got")
  self._stateGotText:SetText(gotStr)
  self._stateCanGetText = self:GetUIComponent("UILocalizationText", "StateCanGetText")
  local canGetStr = StringTable.Get("str_activity_intro_get")
  self._stateCanGetText:SetText(canGetStr)
  self._eff_front = self:GetGameObject("eff_front")
  self._eff_back = self:GetGameObject("eff_back")
  self._dayNum = 1
  self:SetSelected(false)
end

function UICN7N36TotalLoginAwardCell:SetData()
end

function UICN7N36TotalLoginAwardCell:_PlayGetAnim()
  if self._rootAnim then
    self:Lock("UICN7N36TotalLoginAwardCell:_PlayGetAnim")
    if self._rootAnim then
      self._rootAnim:Play(self._animInfo.name)
    end
    self:StartTask(function(TT)
      YIELD(TT, self._animInfo.len)
      self:UnLock("UICN7N36TotalLoginAwardCell:_PlayGetAnim")
    end, self)
  end
end

function UICN7N36TotalLoginAwardCell:_SetAlpha(alpha)
  self._setAlphaArea.alpha = alpha
  do return end
  self._bgSpecialImg.color = Color(self._bgSpecialImg.color.r, self._bgSpecialImg.color.g, self._bgSpecialImg.color.b, alpha)
  self._dayText.color = Color(self._dayText.color.r, self._dayText.color.g, self._dayText.color.b, alpha)
  self._dayNumText.color = Color(self._dayNumText.color.r, self._dayNumText.color.g, self._dayNumText.color.b, alpha)
  self._specialDayText.color = Color(self._specialDayText.color.r, self._specialDayText.color.g, self._specialDayText.color.b, alpha)
  self._specialDayNumText.color = Color(self._specialDayNumText.color.r, self._specialDayNumText.color.g, self._specialDayNumText.color.b, alpha)
  for index, value in ipairs(self._itemWidgetTb) do
    value:_SetAlpha(alpha)
  end
end

function UICN7N36TotalLoginAwardCell:SetSelected(isSelected)
  self._selectStateAreaGo:SetActive(isSelected)
end

function UICN7N36TotalLoginAwardCell:_CellOnClick()
  if self._data:CanReceive() and self._getRewardCallback then
    self._getRewardCallback(self._data._dayNum)
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnActivityTotalAwardCellSelect, self._data._dayNum)
end

function UICN7N36TotalLoginAwardCell:BgAreaOnClick(go)
  self:_CellOnClick()
end

function UICN7N36TotalLoginAwardCell:BgNormalOnClick(go)
  self:_CellOnClick()
end

function UICN7N36TotalLoginAwardCell:BgSpecialOnClick(go)
  self:_CellOnClick()
end

function UICN7N36TotalLoginAwardCell:StateCanGetBgOnClick(go)
  self:_CellOnClick()
end

function UICN7N36TotalLoginAwardCell:SetState(state)
  self._cellState = state
  if self._cellState == ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_Expired or self._cellState == ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_UNKNOW then
    self._cellState = ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_LOCK
  end
  for index, value in ipairs(self._stateAreaGroup) do
    value:SetActive(index == self._cellState)
  end
  self:_CheckEff()
end

function UICN7N36TotalLoginAwardCell:_SetBg(isSpecial)
  self._bgNormalGo:SetActive(isSpecial == false)
  self._bgSpecialGo:SetActive(isSpecial == true)
  self._dayAreaGo.gameObject:SetActive(isSpecial == false)
  self._specialDayAreaGo.gameObject:SetActive(isSpecial == true)
end

function UICN7N36TotalLoginAwardCell:_FillUi()
  self:_SetBg(self._data._isSpecial)
  self:SetState(self._data._state)
  local rootRT = self:GetUIComponent("RectTransform", "RootRT")
  if self._data._dayNum % 2 == 0 then
    rootRT.anchoredPosition = Vector2(-477, 84)
  else
    rootRT.anchoredPosition = Vector2(-356, 84)
  end
  local num = "n36_xljqd_sz" .. self._data._dayNum
  local atlas = self:GetAsset("XiaoLinJia.spriteatlas", LoadType.SpriteAtlas)
  self._specialNum.sprite = atlas:GetSprite(num)
  self._num.sprite = atlas:GetSprite(num)
  self._dayNumText:SetText(self._data._dayNum)
  self._specialDayNumText:SetText(self._data._dayNum)
  for index, value in ipairs(self._items) do
    if self._data._items[index] then
      value:SpawnObject("UICN7N36TotalLoginAwardItem")
      local widgets = value:GetAllSpawnList()
      for indexWidget, valueWidget in ipairs(widgets) do
        valueWidget:SetData(self._data._items[index], self._itemInfoCallback, self._islast)
        table.insert(self._itemWidgetTb, valueWidget)
      end
      self._itemGos[index]:SetActive(true)
    else
      self._itemGos[index]:SetActive(false)
    end
  end
  if self._cfg_data then
    if self._cfg_data.NormalTextColor and #self._cfg_data.NormalTextColor == 3 then
      local r = self._cfg_data.NormalTextColor[1]
      local g = self._cfg_data.NormalTextColor[2]
      local b = self._cfg_data.NormalTextColor[3]
      self._dayNumText.color = Color(r / 255, g / 255, b / 255, self._dayNumText.color.a)
      self._dayText.color = Color(r / 255, g / 255, b / 255, self._dayText.color.a)
    end
    if self._cfg_data.SpecialTextColor and #self._cfg_data.SpecialTextColor == 3 then
      local r = self._cfg_data.SpecialTextColor[1]
      local g = self._cfg_data.SpecialTextColor[2]
      local b = self._cfg_data.SpecialTextColor[3]
      self._specialDayNumText.color = Color(r / 255, g / 255, b / 255, self._specialDayNumText.color.a)
      self._specialDayText.color = Color(r / 255, g / 255, b / 255, self._specialDayText.color.a)
    end
    self._bgNormalImgLoader:LoadImage(self._cfg_data.NormalBg)
    self._bgSpecialImgLoader:LoadImage(self._cfg_data.SpecialBg)
    if not self._resF then
      self._resF = ResourceManager:GetInstance():SyncLoadAsset(self._cfg_data.AwardParticecleF, LoadType.GameObject)
    end
    if self._resF then
      local goF = self._resF.Obj
      goF.transform:SetParent(self._eff_front.transform)
      local rect = goF:GetComponent("RectTransform")
      rect.anchoredPosition = Vector2(0, 0)
      rect.localScale = Vector3(1, 1, 1)
      goF:SetActive(true)
    else
      Log.error("###[UICN7N36TotalLoginAwardCell] self._resF is nil !")
    end
    if not self._resB then
      self._resB = ResourceManager:GetInstance():SyncLoadAsset(self._cfg_data.AwardParticecleB, LoadType.GameObject)
      Log.debug("###[UIActivityTotalLoginAwardController] ourceManager:GetInstance():SyncLoadAsset")
    end
    if self._resB then
      local goB = self._resB.Obj
      goB.transform:SetParent(self._eff_back.transform)
      local rect = goB:GetComponent("RectTransform")
      rect.anchoredPosition = Vector2(0, 0)
      rect.localScale = Vector3(1, 1, 1)
      goB:SetActive(true)
    else
      Log.error("###[UICN7N36TotalLoginAwardCell] self._resB is nil !")
    end
  else
    Log.error("###[UICN7N36TotalLoginAwardCell] self._cfg_data is nil !")
  end
end

function UICN7N36TotalLoginAwardCell:InitData(data, cfg_data, itemInfoCallback, getRewardCallback, islast)
  self._data = data
  self._cfg_data = cfg_data
  self._itemInfoCallback = itemInfoCallback
  self._getRewardCallback = getRewardCallback
  self._islast = islast
  self:_FillUi()
end

function UICN7N36TotalLoginAwardCell:_CheckEff()
  local canShowEff = true
  if self._cellState == ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_RECVED then
    canShowEff = false
  end
  self._eff_front:SetActive(self._data._isSpecial and canShowEff)
  self._eff_back:SetActive(self._data._isSpecial and canShowEff)
end

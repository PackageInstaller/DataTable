_class("UIHomelandAccelerate", UIController)
UIHomelandAccelerate = UIHomelandAccelerate

function UIHomelandAccelerate:Constructor()
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._homelandModule = GameGlobal.GetModule(HomelandModule)
  self._uiHomelandModule = GameGlobal.GetUIModule(HomelandModule)
  self._itemModule = GameGlobal.GetModule(ItemModule)
  self._homelandClient = self._uiHomelandModule:GetClient()
  self._buildManager = self._homelandClient:BuildManager()
  self._timeRefreshInterval = 0
  self._maxCount = 100
  self._curCount = 0
end

function UIHomelandAccelerate:OnShow(uiParams)
  self._titleStr = uiParams[1]
  self._remainTime = uiParams[2]
  self._itemID = uiParams[3]
  self._itemTime = uiParams[4]
  self._callBack = uiParams[5]
  self._helpAllTime = uiParams[6]
  self:_GetComponents()
  self:_OnValue()
end

function UIHomelandAccelerate:_GetComponents()
  self._title = self:GetUIComponent("UILocalizationText", "Title")
  self._remainTimeText = self:GetUIComponent("UILocalizationText", "RemainTime")
  self._resultTime = self:GetUIComponent("UILocalizationText", "ResultTime")
  self._itemIcon = self:GetUIComponent("RawImageLoader", "ItemIcon")
  self._totalCount = self:GetUIComponent("UILocalizationText", "TotalCount")
  self._remainCount = self:GetUIComponent("UILocalizationText", "RemainCount")
  self._itemName = self:GetUIComponent("UILocalizationText", "ItemName")
  self._slider = self:GetUIComponent("Slider", "Slider")
  self._countValue = self:GetUIComponent("UILocalizationText", "CountValue")
  self._slider.wholeNumbers = true
  self._slider.onValueChanged:AddListener(function()
    self._curCount = math.min(self._maxCount, math.ceil(self._slider.value))
    self._countValue:SetText(self._curCount)
    self._remainCount:SetText(self._packageCount - self._curCount)
  end)
  self._helpTime = self:GetUIComponent("UILocalizationText", "helpTime")
  self._helpTimeParent = self:GetGameObject("helpTimeParent")
end

function UIHomelandAccelerate:_OnValue()
  self._cfg = Cfg.cfg_item[self._itemID]
  local packageCount = self._itemModule:GetItemCount(self._cfg.ID)
  self._packageCount = packageCount
  local remainTime = self._remainTime - self._svrTimeModule:GetServerTime() * 0.001
  local maxCount = math.ceil(remainTime / self._itemTime)
  self._maxCount = math.min(maxCount, packageCount)
  self._slider.maxValue = self._maxCount
  self._curCount = 0
  self._title:SetText(self._titleStr)
  self._remainTimeText:SetText(HomelandBreedTool.GetTimeStr(remainTime))
  self._resultTime:SetText(HomelandBreedTool.GetTimeStr(0))
  self._itemIcon:LoadImage(self._cfg.Icon)
  self._totalCount:SetText(self._packageCount)
  self._remainCount:SetText(self._packageCount)
  self._itemName:SetText(StringTable.Get(self._cfg.Name))
  self:_RefreshSlider()
  if self._helpAllTime then
    self._helpTime.gameObject:SetActive(true)
    local hour = math.ceil(self._helpAllTime / 3600)
    self._helpTime:SetText(StringTable.Get("str_homeland_visit_help_time", hour))
    self._helpTimeParent:SetActive(true)
  else
    self._helpTimeParent:SetActive(false)
  end
end

function UIHomelandAccelerate:ReduceBtnOnClick(go)
  self._curCount = math.max(0, self._curCount - 1)
  self:_RefreshSlider()
end

function UIHomelandAccelerate:AddBtnOnClick(go)
  self._curCount = math.min(self._curCount + 1, self._maxCount)
  self:_RefreshSlider()
end

function UIHomelandAccelerate:CloseBtnOnClick(go)
  self:CloseDialog()
end

function UIHomelandAccelerate:_RefreshSlider()
  self._slider.value = self._curCount
  self._countValue:SetText(self._curCount)
  self._remainCount:SetText(self._packageCount - self._curCount)
end

function UIHomelandAccelerate:Update(deltaTime)
  self._timeRefreshInterval = self._timeRefreshInterval + deltaTime
  if self._timeRefreshInterval >= 1000 then
    self._timeRefreshInterval = 0
    self:_RefreshTime()
  end
end

function UIHomelandAccelerate:_RefreshTime()
  if self._cfg then
    local remainTime = self._remainTime - self._svrTimeModule:GetServerTime() * 0.001
    if 0 <= remainTime then
      self._remainTimeText:SetText(HomelandBreedTool.GetTimeStr(remainTime))
      local itemTime = self._itemTime * self._curCount
      local surplusTime = math.floor(itemTime - remainTime)
      if 0 < surplusTime then
        local surplusCount = math.floor(surplusTime / self._itemTime)
        if 0 < surplusCount then
          self._curCount = math.max(0, self._curCount - surplusCount)
          self._maxCount = self._curCount
          self._slider.maxValue = self._maxCount
          itemTime = self._itemTime * self._curCount
          self:_RefreshSlider()
        end
      end
      self._resultTime:SetText(HomelandBreedTool.GetTimeStr(remainTime - itemTime))
    else
      self._curCount = 0
      self:_RefreshSlider()
      self._resultTime:SetText(HomelandBreedTool.GetTimeStr(0))
    end
  end
end

function UIHomelandAccelerate:OnSureBtnOnClick(go)
  if self._curCount <= 0 then
    return
  end
  local remainTime = self._remainTime - self._svrTimeModule:GetServerTime() * 0.001
  local resultTime = self._curCount * self._itemTime
  if remainTime < resultTime then
    if 0 < remainTime then
      if self._callBack then
        self._callBack(self._itemID, self._curCount)
        self:CloseDialog()
      end
    else
      self:CloseDialog()
    end
  elseif self._callBack then
    self._callBack(self._itemID, self._curCount)
    self:CloseDialog()
  end
end

function UIHomelandAccelerate:_PopBox()
  local title = ""
  local desc = StringTable.Get("str_homeland_breed_selectitem_desc")
  local leftBtn = {
    StringTable.Get("str_common_cancel"),
    function(param)
    end
  }
  local rightBtn = {
    StringTable.Get("str_common_ok"),
    function(param)
      if self._callBack then
        self._callBack(self._itemID, self._curCount)
        self:CloseDialog()
      end
    end
  }
  self:ShowDialog("UIHomelandMessageBox", title, desc, leftBtn, rightBtn, true)
end

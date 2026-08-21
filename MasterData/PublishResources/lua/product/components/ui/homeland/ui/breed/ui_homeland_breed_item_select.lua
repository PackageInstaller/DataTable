_class("UIHomelandBreedItemSelect", UIController)
UIHomelandBreedItemSelect = UIHomelandBreedItemSelect

function UIHomelandBreedItemSelect:Constructor()
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._itemModule = GameGlobal.GetModule(ItemModule)
  self._homelandModule = GameGlobal.GetModule(HomelandModule)
  self._timeRefreshInterval = 0
  self._itemWidget = nil
  self._cfgSpeedItem = nil
  self._cfg = nil
  self._packageCount = 0
  self._count = 0
end

function UIHomelandBreedItemSelect:OnShow(uiParams)
  self._buildingPstId = uiParams[1]
  self._breedInfo = uiParams[2]
  self._callback = uiParams[3]
  self:_GetComponents()
  self:_OnValue()
end

function UIHomelandBreedItemSelect:_GetComponents()
  self._remainTime = self:GetUIComponent("UILocalizationText", "RemainTime")
  self._resultTime = self:GetUIComponent("UILocalizationText", "ResultTime")
  self._itemName = self:GetUIComponent("UILocalizationText", "ItemName")
  self._itemIcon = self:GetUIComponent("RawImageLoader", "ItemIcon")
  self._totalCount = self:GetUIComponent("UILocalizationText", "TotalCount")
  self._remainCount = self:GetUIComponent("UILocalizationText", "RemainCount")
  self._countValue = self:GetUIComponent("UILocalizationText", "CountValue")
  self._fillRect = self:GetUIComponent("RectTransform", "Fill")
  self._countRect = self:GetUIComponent("RectTransform", "Count")
end

function UIHomelandBreedItemSelect:_OnValue()
  self._cfgSpeedItem = self:_FilterSpeedItem()
  if self._cfgSpeedItem then
    self._cfg = Cfg.cfg_item[self._cfgSpeedItem.ID]
    self._packageCount = self._itemModule:GetItemCount(self._cfg.ID)
    self._itemName:SetText(StringTable.Get(self._cfg.Name))
    self._itemIcon:LoadImage(self._cfg.Icon)
  end
  self._totalCount:SetText(self._packageCount)
  self._remainCount:SetText(self._packageCount)
  self._countValue:SetText(self._count)
  self._fillRect.localScale = Vector3(self._count / self._packageCount, 1, 1)
  self._countRect.localPosition = Vector3((self._count / self._packageCount - 0.5) * 945, self._countRect.localPosition.y, 0)
  self:_RefreshTime()
end

function UIHomelandBreedItemSelect:Update(deltaTime)
  self._timeRefreshInterval = self._timeRefreshInterval + deltaTime
  if self._timeRefreshInterval >= 1000 then
    self._timeRefreshInterval = 0
    self:_RefreshTime()
  end
end

function UIHomelandBreedItemSelect:_RefreshTime()
  if self._breedInfo and self._cfgSpeedItem then
    local remainTime = self._homelandModule:GetLandEndTime(self._breedInfo) - self._svrTimeModule:GetServerTime() * 0.001
    if 0 <= remainTime then
      self._remainTime:SetText(HomelandBreedTool.GetTimeStr(remainTime))
      local itemTime = self._cfgSpeedItem.Time * self._count
      local surplusTime = math.floor(itemTime - remainTime)
      if 0 < surplusTime then
        local surplusCount = math.floor(surplusTime / self._cfgSpeedItem.Time)
        self._count = math.max(0, self._count - surplusCount)
        itemTime = self._cfgSpeedItem.Time * self._count
        self._countValue:SetText(self._count)
        self._fillRect.localScale = Vector3(self._count / self._packageCount, 1, 1)
        self._countRect.localPosition = Vector3((self._count / self._packageCount - 0.5) * 945, self._countRect.localPosition.y, 0)
        self._remainCount:SetText(self._packageCount - self._count)
      end
      self._resultTime:SetText(HomelandBreedTool.GetTimeStr(remainTime - itemTime))
    else
      self._count = 0
      self._countValue:SetText(self._count)
      self._fillRect.localScale = Vector3(self._count / self._packageCount, 1, 1)
      self._countRect.localPosition = Vector3((self._count / self._packageCount - 0.5) * 945, self._countRect.localPosition.y, 0)
      self._remainCount:SetText(self._packageCount - self._count)
    end
  end
end

function UIHomelandBreedItemSelect:_ItemOnClick()
end

function UIHomelandBreedItemSelect:_FilterSpeedItem()
  local cfg = Cfg.cfg_item_cultivation({})
  for _, value in pairs(cfg) do
    if value.ItemAttrType == CultivationItemType.E_ACCELERATION then
      return value
    end
  end
  return nil
end

function UIHomelandBreedItemSelect:ClearBtnOnClick(go)
  self:_SetCount(0)
end

function UIHomelandBreedItemSelect:ReduceBtnOnClick(go)
  self:_SetCount(self._count - 1)
end

function UIHomelandBreedItemSelect:AddBtnOnClick(go)
  self:_SetCount(self._count + 1)
end

function UIHomelandBreedItemSelect:MaxBtnOnClick(go)
  if not self._breedInfo or not self._cfgSpeedItem then
    return
  end
  local remainTime = self._homelandModule:GetLandEndTime(self._breedInfo) - self._svrTimeModule:GetServerTime() * 0.001
  local count = math.ceil(remainTime / self._cfgSpeedItem.Time)
  if count > self._packageCount then
    count = self._packageCount
  end
  self:_SetCount(count)
end

function UIHomelandBreedItemSelect:_SetCount(count)
  if count < 0 or count > self._packageCount then
    return
  end
  self._count = count
  self._countValue:SetText(self._count)
  self._fillRect.localScale = Vector3(self._count / self._packageCount, 1, 1)
  self._countRect.localPosition = Vector3((self._count / self._packageCount - 0.5) * 945, self._countRect.localPosition.y, 0)
  self._remainCount:SetText(self._packageCount - self._count)
  self._timeRefreshInterval = 0
  self:_RefreshTime()
end

function UIHomelandBreedItemSelect:CancleBtnOnClick(go)
  self:CloseDialog()
end

function UIHomelandBreedItemSelect:OnSureBtnOnClick(go)
  if self._count <= 0 then
    return
  end
  local remainTime = self._homelandModule:GetLandEndTime(self._breedInfo) - self._svrTimeModule:GetServerTime() * 0.001
  local resultTime = self._count * self._cfgSpeedItem.Time
  if remainTime < resultTime then
    if 0 < remainTime then
      PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, nil, StringTable.Get("str_homeland_breed_selectitem_desc"), function()
        self:_UseSpeedItem()
      end, nil)
    else
      self:CloseDialog()
    end
  else
    self:_UseSpeedItem()
  end
end

function UIHomelandBreedItemSelect:_UseSpeedItem()
  self:Lock("UIHomelandBreedSelectItem")
  self:StartTask(function(TT)
    local roleAsset = RoleAsset:New()
    roleAsset.assetid = self._cfg.ID
    roleAsset.count = self._count
    local res = self._homelandModule:HandleAccelerateCultivation(TT, self._buildingPstId, roleAsset)
    if res:GetSucc() then
      self:CloseDialog()
      if self._callback then
        self._callback()
      end
    else
      Log.fatal("Breed accelerate failed:", res:GetResult())
      ToastManager.ShowHomeToast(StringTable.Get("str_homeland_breed_error_" .. res:GetResult()))
    end
    self:UnLock("UIHomelandBreedSelectItem")
  end, self)
end

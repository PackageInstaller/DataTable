_class("UIN23Shop", UIActivityShopControllerBase)
UIN23Shop = UIN23Shop

function UIN23Shop:Constructor()
  UIN23Shop.super.Constructor(self)
  UIActivityShopControllerBase.ItemGroupHeight = 682
  self.mCampaign = self:GetModule(CampaignModule)
  self.data = self.mCampaign:GetN23Data()
  self.strsLeftTime = {
    "str_n23_shop_open_left_time_d_h",
    "str_n23_shop_open_left_time_d",
    "str_n23_shop_open_left_time_h_m",
    "str_n23_shop_open_left_time_h",
    "str_n23_shop_open_left_time_m"
  }
  self._animInfo = {
    name = "uieff_UIN23Shop_out",
    len = 167
  }
end

function UIN23Shop:OnShow(uiParams)
  N23Data.SetPrefsShop()
  self.txtEggCount = self:GetUIComponent("RollingText", "txtEggCount")
  self.txtCountLow = self:GetUIComponent("UILocalizationText", "txtCountLow")
  self.txtCount = self:GetUIComponent("UILocalizationText", "txtCount")
  self.info = self:GetGameObject("info")
  self.info:SetActive(false)
  UIN23Shop.super.OnShow(self, uiParams)
  self:LoadSpine()
  self:ReplayIdle()
  self:FlushEgg()
end

function UIN23Shop:OnHide()
  self._endTimeText = nil
  UIN23Shop.super.OnHide(self)
end

function UIN23Shop:_OnGetShopItemGroupCell(scrollview, index)
  local item = scrollview:NewListViewItem("CellItem")
  local cellPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    cellPool:SpawnObjects("UIActivityShopItemGroup", 1)
  end
  local rowList = cellPool:GetAllSpawnList()
  local itemWidget = rowList[1]
  if itemWidget then
    local itemIndex = index + 1
    itemWidget:InitData(self._showShopItemGroupData[itemIndex])
    if itemIndex > self._itemGroupCount then
      itemWidget:GetGameObject():SetActive(false)
    end
    item:GetComponent("RectTransform").sizeDelta = itemWidget:GetRealSize() + Vector2(150, 0)
  end
  return item
end

function UIN23Shop:DefaultBackFunc()
  self.mCampaign:CampaignSwitchState(true, UIStateType.UIN23Main, UIStateType.UIMain, nil, self._campaign._id)
end

function UIN23Shop:_RefreshCurrency()
  if not self._currencyId then
    self._currencyId = self._commonCfg.CurrencyId
  end
  local count = self:GetModule(ItemModule):GetItemCount(self._currencyId) or 0
  local preZero = UIActivityHelper.GetZeroStrFrontNum(7, count)
  local fmtStr = string.format("<color=#827B78>%s</color><color=#FFE65A>%s</color>", preZero, tostring(count))
  self.txtCountLow:SetText(preZero .. count)
  self.txtCount:SetText(fmtStr)
  if self.pointIcon then
    local currencyIcon = ""
    local cfgItem = Cfg.cfg_item[self._currencyId]
    if cfgItem then
      currencyIcon = cfgItem.Icon
      self.pointIcon:LoadImage(currencyIcon)
    end
  end
end

function UIN23Shop:_ShowRemainingTime()
  if self._endTimeText then
    UIForge.FlushCDText(self._endTimeText, self._shopCloseTime, self.strsLeftTime, true)
  end
end

function UIN23Shop:FlushEgg()
  local unlockCount, total = self.data:GetEggCount()
  self.txtEggCount:RefreshText(StringTable.Get("str_n23_strange_replay_count", unlockCount, total))
end

function UIN23Shop:BtnBackOnClick(go)
  self:BackBtnFunc()
  AudioHelperController.PlayBGM(self._lastBGMResName, AudioConstValue.BGMCrossFadeTime)
end

function UIN23Shop:BtnHomeOnClick(go)
  self:SwitchState(UIStateType.UIMain)
end

function UIN23Shop:BtnInfoOnClick(go)
  self.info:SetActive(true)
end

function UIN23Shop:ImgInfoOnClick(go)
  self.info:SetActive(false)
end

function UIN23Shop:BtnReplayOnClick(go)
  self:ShowDialog("UIN23Replay", self)
end

function UIN23Shop:OnActivityShopBuySuccess(exchangeId)
  UIN23Shop.super.OnActivityShopBuySuccess(self, exchangeId)
  local replay = self.data:GetReplayByExchangeId(exchangeId)
  if replay then
    self:Replay(replay.id)
  end
  self:FlushEgg()
end

function UIN23Shop:LoadSpine()
  self.spines = {}
  for index, replay in ipairs(self.data.replays) do
    local viewSpine = replay:ViewSpine()
    local spineLoader = self:GetUIComponent("SpineLoader", viewSpine)
    self.spines[viewSpine] = spineLoader
    if replay:ViewHideOnLoad() then
      spineLoader.gameObject:SetActive(false)
    end
  end
end

function UIN23Shop:Replay(id)
  local replay = self.data:GetReplayById(id)
  local viewSpine = replay:ViewSpine()
  local spineLoader = self.spines[viewSpine]
  local viewPlaySequence = replay:ViewPlaySequence()
  self:ReplayAnim(viewSpine, viewPlaySequence)
end

function UIN23Shop:ReplayAnim(spineName, viewPlaySequence)
  local spineLoader = self:GetUIComponent("SpineLoader", spineName)
  self:StartTask(function(TT)
    local key = "UIN23ShopReplayAnim" .. spineName
    self:Lock(key)
    for index, data in ipairs(viewPlaySequence) do
      if data.ShowSpine then
        spineLoader.gameObject:SetActive(true)
      end
      if data.anim then
        local spineSkeleton = spineLoader.CurrentSkeleton
        spineSkeleton = spineSkeleton or spineLoader.CurrentMultiSkeleton
        if spineSkeleton then
          spineSkeleton.AnimationState:SetAnimation(0, data.anim, false)
        end
        if data.time then
          YIELD(TT, data.time)
        end
      end
      if data.HideSpine then
        spineLoader.gameObject:SetActive(false)
      end
    end
    self:UnLock(key)
  end, self)
end

function UIN23Shop:ReplayIdle()
  local spineName = "n23_store_1_spine_idle"
  local spineLoader = self:GetUIComponent("SpineLoader", spineName)
  local spineSkeleton = spineLoader.CurrentSkeleton
  spineSkeleton = spineSkeleton or spineLoader.CurrentMultiSkeleton
  local entry = spineSkeleton.AnimationState:SetAnimation(0, "door_idle", false)
  entry.MixDuration = 0
end

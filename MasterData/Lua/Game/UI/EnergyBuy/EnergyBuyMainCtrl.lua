local EnergyBuyMainCtrl = class("EnergyBuyMainCtrl", BaseCtrl)
local LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
EnergyBuyMainCtrl._mapNodeConfig = {
  goWindow = {},
  animWindow = {sNodeName = "goWindow", sComponentName = "Animator"},
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Energy_Buy_Title"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  goBatteryEnergy = {},
  goBuyItem = {},
  txtBuyName = {
    sComponentName = "TMP_Text",
    sLanguageId = "Energy_Buy_Desc"
  },
  txtBatteryEnergy = {
    sComponentName = "TMP_Text",
    sLanguageId = "Energy_Battery_Title"
  },
  txtBatteryValue = {
    sComponentName = "TMP_Text",
    sLanguageId = "Energy_Left"
  },
  txtBatteryValueNumber = {sComponentName = "TMP_Text"},
  txtBuyLimit = {
    sComponentName = "TMP_Text",
    sLanguageId = "Energy_Buy_Limit"
  },
  txtBuyLimitValue = {sComponentName = "TMP_Text"},
  imgEnergyBg = {},
  txtBuyCount = {sComponentName = "TMP_Text"},
  btnBuy = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Buy"
  },
  btnUseBattery = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_UseBattery"
  },
  btnBuyGray = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_BuyGray"
  },
  btnBatteryGray = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_UseBatteryGray"
  },
  txtBuyButton = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Energy_Item_Use_Btn_Text"
  },
  txtBuyButtonGray = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Energy_Item_Use_Btn_Text"
  },
  imgBuyCoin = {sComponentName = "Image"},
  txtBuyCost = {sComponentName = "TMP_Text"},
  goItemContent = {sComponentName = "Transform"},
  rtItemContent = {
    sNodeName = "goItemContent",
    sComponentName = "RectTransform"
  },
  goItem = {},
  goItemList = {
    sComponentName = "RectTransform"
  }
}
EnergyBuyMainCtrl._mapEventConfig = {
  [EventId.CoinResChange] = "RefreshEnergyBuy",
  RefreshEnergyBuyCount = "RefreshEnergyBuy",
  RefreshEnergyItemList = "RefreshEnergyItem",
  [EventId.IsNewDay] = "OnEventNewDay",
  [EventId.UpdateEnergyBattery] = "RefreshEnergyBattery"
}

function EnergyBuyMainCtrl:Awake()
end

function EnergyBuyMainCtrl:OnEnable()
  self.tbItemCtrl = {}
end

function EnergyBuyMainCtrl:OnDisable()
  for _, v in ipairs(self.tbItemCtrl) do
    local obj = v.gameObject
    self:UnbindCtrlByNode(v)
    destroy(obj)
  end
  self.tbItemCtrl = {}
end

function EnergyBuyMainCtrl:OnDestroy()
end

function EnergyBuyMainCtrl:ShowPanel()
  local nEnergyBatteryUIEnable = ConfigTable.GetConfigNumber("EnergyBatteryUIEnable")
  local bUnlock = PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.EnergyBattery)
  self._mapNode.goBatteryEnergy.gameObject:SetActive(0 < nEnergyBatteryUIEnable and bUnlock)
  self._mapNode.goItem.gameObject:SetActive(false)
  self._mapNode.animWindow:Play("t_window_04_t_in")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
  self:RefreshEnergyBuy()
  self:RefreshEnergyItem()
end

function EnergyBuyMainCtrl:OnEventNewDay()
  self:RefreshEnergyBuy()
end

function EnergyBuyMainCtrl:RefreshEnergyBattery()
  local nCurEnergyBattery = PlayerData.Base:GetCurEnergyBattery().nEnergyBattery
  NovaAPI.SetTMPText(self._mapNode.txtBatteryValueNumber, string.format("%s/%s", nCurEnergyBattery, ConfigTable.GetConfigNumber("EnergyBatteryMax")))
  self._mapNode.btnBatteryGray.gameObject:SetActive(nCurEnergyBattery <= 0)
  self._mapNode.btnUseBattery.gameObject:SetActive(0 < nCurEnergyBattery)
end

function EnergyBuyMainCtrl:RefreshEnergyBuy()
  local nCurBuyCount = PlayerData.Base:GetEnergyBuyCount()
  local nBuyCountLimit = PlayerData.Base:GetEnergyBuyLimit()
  local nCurEnergyBattery = PlayerData.Base:GetCurEnergyBattery().nEnergyBattery
  NovaAPI.SetTMPText(self._mapNode.txtBuyLimitValue, string.format("%s/%s", nBuyCountLimit - nCurBuyCount, nBuyCountLimit))
  NovaAPI.SetTMPText(self._mapNode.txtBatteryValueNumber, string.format("%s/%s", nCurEnergyBattery, ConfigTable.GetConfigNumber("EnergyBatteryMax")))
  self._mapNode.btnBuyGray.gameObject:SetActive(nCurBuyCount >= nBuyCountLimit)
  self._mapNode.btnBatteryGray.gameObject:SetActive(nCurEnergyBattery <= 0)
  self._mapNode.btnUseBattery.gameObject:SetActive(0 < nCurEnergyBattery)
  self._mapNode.btnBuy.gameObject:SetActive(nCurBuyCount < nBuyCountLimit)
  self._mapNode.imgEnergyBg.gameObject:SetActive(nCurBuyCount < nBuyCountLimit)
  if nCurBuyCount < nBuyCountLimit then
    local mapBuyEnergyCfg = ConfigTable.GetData("EnergyBuy", nCurBuyCount + 1)
    if nil ~= mapBuyEnergyCfg then
      self:SetSprite_Coin(self._mapNode.imgBuyCoin, mapBuyEnergyCfg.CurrencyItemId)
      NovaAPI.SetTMPText(self._mapNode.txtBuyCost, mapBuyEnergyCfg.CurrencyItemQty)
      NovaAPI.SetTMPText(self._mapNode.txtBuyCount, "+" .. mapBuyEnergyCfg.EnergyValue)
      local hasCount = PlayerData.Coin:GetCoinCount(mapBuyEnergyCfg.CurrencyItemId)
      NovaAPI.SetTMPColor(self._mapNode.txtBuyCost, hasCount < mapBuyEnergyCfg.CurrencyItemQty and Red_Unable or Blue_Normal)
    end
  end
end

function EnergyBuyMainCtrl:RefreshEnergyItem()
  self.tbItems = {}
  local tbItems = PlayerData.Item:GetItemsByStype(GameEnum.itemStype.EnergyItem)
  local curTime = CS.ClientManager.Instance.serverTimeStamp
  local tbResident = {}
  tbResident[81003] = false
  tbResident[81004] = false
  for _, v in ipairs(tbItems) do
    local itemCfg = ConfigTable.GetData_Item(v.Tid)
    if nil ~= itemCfg then
      local useCfg = decodeJson(itemCfg.UseArgs)
      local nEnergyValue = 0
      for itemId, count in pairs(useCfg) do
        local checkItemCfg = ConfigTable.GetData_Item(tonumber(itemId))
        if nil ~= checkItemCfg and checkItemCfg.Stype == GameEnum.itemStype.Energy then
          nEnergyValue = count
        else
          printLog(string.format("体力道具使用参数配置错误！！！请检查！itemId = [%s]", v.Tid))
        end
      end
      if 0 < nEnergyValue then
        for nExpire, mapExpiresData in pairs(v.mapExpires) do
          if 0 < nExpire and 0 < nExpire - curTime or nExpire == 0 then
            local mapItem = {
              nTid = v.Tid,
              mapId = mapExpiresData.mapId,
              nExpire = nExpire,
              nTimeLimit = 0 < nExpire and 1 or 0,
              nCount = mapExpiresData.nTotalCount,
              nEnergyValue = nEnergyValue,
              nSort = 0
            }
            table.insert(self.tbItems, mapItem)
            if nil ~= tbResident[v.Tid] then
              tbResident[v.Tid] = true
            end
          end
        end
      end
    end
  end
  for id, bHas in pairs(tbResident) do
    if not bHas then
      local itemCfg = ConfigTable.GetData_Item(id)
      if nil ~= itemCfg then
        local useCfg = decodeJson(itemCfg.UseArgs)
        local nEnergyValue = 0
        for itemId, count in pairs(useCfg) do
          local checkItemCfg = ConfigTable.GetData_Item(tonumber(itemId))
          if nil ~= checkItemCfg and checkItemCfg.Stype == GameEnum.itemStype.Energy then
            nEnergyValue = count
          else
            printLog(string.format("体力道具使用参数配置错误！！！请检查！itemId = [%s]", id))
          end
        end
        local mapItem = {
          nTid = id,
          mapId = 0,
          nExpire = 0,
          nTimeLimit = 0,
          nCount = 0,
          nEnergyValue = nEnergyValue,
          nSort = -1
        }
        table.insert(self.tbItems, mapItem)
      end
    end
  end
  table.sort(self.tbItems, function(a, b)
    if a.nSort == b.nSort then
      if a.nTimeLimit == b.nTimeLimit then
        if a.nExpire == b.nExpire then
          return a.nTid < b.nTid
        end
        return a.nExpire < b.nExpire
      end
      return a.nTimeLimit > b.nTimeLimit
    end
    return a.nSort > b.nSort
  end)
  for _, v in ipairs(self.tbItemCtrl) do
    v.gameObject:SetActive(false)
  end
  for k, v in ipairs(self.tbItems) do
    if nil == self.tbItemCtrl[k] then
      local obj = instantiate(self._mapNode.goItem, self._mapNode.goItemList)
      obj.gameObject:SetActive(true)
      local objCtrl = self:BindCtrlByNode(obj, "Game.UI.EnergyBuy.EnergyBuyItemCtrl")
      objCtrl:SetItem(v)
      self.tbItemCtrl[k] = objCtrl
    else
      self.tbItemCtrl[k].gameObject:SetActive(true)
      self.tbItemCtrl[k]:SetItem(v)
    end
  end
  LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.rtItemContent)
end

function EnergyBuyMainCtrl:Close()
  self._mapNode.animWindow:Play("t_window_04_t_out")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function EnergyBuyMainCtrl:OnBtnClick_Close()
  EventManager.Hit("CloseEnergyBuyPanel")
end

function EnergyBuyMainCtrl:OnBtnClick_Buy()
  local nCurEnergy = PlayerData.Base:GetCurEnergy().nEnergy
  if nCurEnergy >= self._panel.nMaxEnergy then
    local sTip = ConfigTable.GetUIText("Energy_Use_Tip_2")
    EventManager.Hit(EventId.OpenMessageBox, {
      nType = AllEnum.MessageBox.Tips,
      sContent = sTip
    })
    return
  end
  EventManager.Hit("ChangeEnergyBuyPanel", AllEnum.EnergyPanelType.BuyConfirm)
end

function EnergyBuyMainCtrl:OnBtnClick_BuyGray()
  local sTip = ConfigTable.GetUIText("Energy_Use_Tip_3")
  EventManager.Hit(EventId.OpenMessageBox, {
    nType = AllEnum.MessageBox.Tips,
    bPositive = true,
    sContent = sTip
  })
end

function EnergyBuyMainCtrl:OnBtnClick_UseBattery()
  local nBatteryEnergy = PlayerData.Base:GetCurEnergyBattery().nEnergyBattery
  if nBatteryEnergy <= 0 then
    local sTip = ConfigTable.GetUIText("Energy_Use_Tip_6")
    EventManager.Hit(EventId.OpenMessageBox, {
      nType = AllEnum.MessageBox.Tips,
      sContent = sTip
    })
    return
  end
  local nCurEnergy = PlayerData.Base:GetCurEnergy().nEnergy
  if nCurEnergy >= self._panel.nMaxEnergy then
    local sTip = ConfigTable.GetUIText("Energy_Use_Tip_2")
    EventManager.Hit(EventId.OpenMessageBox, {
      nType = AllEnum.MessageBox.Tips,
      sContent = sTip
    })
    return
  end
  EventManager.Hit("ChangeEnergyBuyPanel", AllEnum.EnergyPanelType.BatteryUse)
end

function EnergyBuyMainCtrl:OnBtnClick_UseBatteryGray()
  local sTip = ConfigTable.GetUIText("Energy_Use_Tip_1")
  EventManager.Hit(EventId.OpenMessageBox, {
    nType = AllEnum.MessageBox.Tips,
    bPositive = true,
    sContent = sTip
  })
end

return EnergyBuyMainCtrl

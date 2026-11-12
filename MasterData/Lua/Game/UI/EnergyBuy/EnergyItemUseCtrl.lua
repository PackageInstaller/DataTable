local EnergyItemUseCtrl = class("EnergyItemUseCtrl", BaseCtrl)
local LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
EnergyItemUseCtrl._mapNodeConfig = {
  goWindow = {},
  animWindow = {sNodeName = "goWindow", sComponentName = "Animator"},
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Energy_Item_Use_Title"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  btnItem = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Item"
  },
  ctrlItem = {
    sNodeName = "goItem",
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl"
  },
  txtItemName = {sComponentName = "TMP_Text"},
  txtItemDesc = {sComponentName = "TMP_Text"},
  txtHaveCount = {
    sComponentName = "TMP_Text",
    sLanguageId = "Energy_Item_Count_Text"
  },
  txtHaveCountValue = {sComponentName = "TMP_Text"},
  txtAddValue = {sComponentName = "TMP_Text"},
  txtLeftTime = {
    sComponentName = "TMP_Text",
    sLanguageId = "Energy_Item_Left_Time"
  },
  txtLeftTimeValue = {sComponentName = "TMP_Text"},
  imgLeftTime = {sComponentName = "GameObject", nCount = 3},
  txtPermanent = {
    sComponentName = "TMP_Text",
    sLanguageId = "Energy_Item_Permanent_Time"
  },
  txtStock = {
    sComponentName = "TMP_Text",
    sLanguageId = "Energy_Item_Use_Count"
  },
  goQuantitySelector = {
    sNodeName = "tc_quantity_selector",
    sCtrlName = "Game.UI.TemplateEx.TemplateQuantitySelectorCtrl"
  },
  txtHave = {
    sComponentName = "TMP_Text",
    sLanguageId = "Energy_Buy_Confirm_Text"
  },
  imgArrow = {},
  txtBeforeValue = {sComponentName = "TMP_Text"},
  txtAfterValue = {sComponentName = "TMP_Text"},
  goMaxValue = {},
  txtMaxValue = {
    sComponentName = "TMP_Text",
    sLanguageId = "Energy_Count_Max"
  },
  rtCountBg = {
    sNodeName = "imgCountBg",
    sComponentName = "RectTransform"
  },
  btnConfirm2 = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Confirm"
  },
  txtConfirmBtn = {
    sComponentName = "TMP_Text",
    sLanguageId = "Energy_Item_Use_Btn_Text"
  }
}
EnergyItemUseCtrl._mapEventConfig = {}

function EnergyItemUseCtrl:Awake()
end

function EnergyItemUseCtrl:OnEnable()
end

function EnergyItemUseCtrl:ShowPanel()
  self.mapItemData = self._panel.mapItemData
  self.bBlur = self._panel.bBlur
  self.nUseCount = 1
  self.nMaxCount = 0
  self.nMinCount = 0
  self._mapNode.animWindow:Play("t_window_04_t_in")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
  self:RefreshItem()
  
  local function callback(nCount)
    self.nUseCount = nCount
    self:RefreshAddCount()
  end
  
  self._mapNode.goQuantitySelector:Init(callback, self.nUseCount, self.nUseCountLimit)
  self:RefreshAddCount()
end

function EnergyItemUseCtrl:OnDisable()
end

function EnergyItemUseCtrl:OnDestroy()
end

function EnergyItemUseCtrl:RefreshItem()
  local itemId = self.mapItemData.nTid
  self._mapNode.ctrlItem:SetItem(itemId, nil, nil, nil, nil, nil, nil, true, nil, true)
  local mapItemCfg = ConfigTable.GetData_Item(itemId)
  if mapItemCfg then
    NovaAPI.SetTMPText(self._mapNode.txtItemName, mapItemCfg.Title)
    NovaAPI.SetTMPText(self._mapNode.txtItemDesc, mapItemCfg.Desc)
  end
  NovaAPI.SetTMPText(self._mapNode.txtHaveCountValue, self.mapItemData.nCount)
  self.nMaxCount = self.mapItemData.nCount
  NovaAPI.SetTMPText(self._mapNode.txtAddValue, string.format("+%s", self.mapItemData.nEnergyValue))
  local nExpire = self.mapItemData.nExpire
  self._mapNode.txtLeftTimeValue.gameObject:SetActive(0 < nExpire)
  self._mapNode.txtPermanent.gameObject:SetActive(nExpire == 0)
  if nExpire ~= 0 then
    local sTimeStr = ""
    local curTime = CS.ClientManager.Instance.serverTimeStamp
    local remainTime = nExpire - curTime
    if 86400 <= remainTime then
      local day = math.floor(remainTime / 86400)
      local hour = math.floor((remainTime - day * 86400) / 3600)
      if hour == 0 then
        day = day - 1
        hour = 24
      end
      sTimeStr = orderedFormat(ConfigTable.GetUIText("Energy_LeftTime_Day"), day, hour)
    elseif 3600 <= remainTime then
      local hour = math.floor(remainTime / 3600)
      local min = math.floor((remainTime - hour * 3600) / 60)
      if min == 0 then
        hour = hour - 1
        min = 60
      end
      sTimeStr = orderedFormat(ConfigTable.GetUIText("Energy_LeftTime_Hour"), hour, min)
    else
      sTimeStr = ConfigTable.GetUIText("Energy_LeftTime_LessThenHour")
    end
    NovaAPI.SetTMPText(self._mapNode.txtLeftTimeValue, sTimeStr)
    self._mapNode.imgLeftTime[1]:SetActive(86400 <= remainTime)
    self._mapNode.imgLeftTime[2]:SetActive(remainTime < 86400 and 3600 <= remainTime)
    self._mapNode.imgLeftTime[3]:SetActive(remainTime < 3600)
  end
  self.nUseCountLimit = 0
  local nCurEnergy = PlayerData.Base:GetCurEnergy().nEnergy
  for i = 1, self.nMaxCount do
    nCurEnergy = nCurEnergy + self.mapItemData.nEnergyValue
    self.nUseCountLimit = i
    if nCurEnergy >= self._panel.nMaxEnergy then
      break
    end
  end
end

function EnergyItemUseCtrl:RefreshAddCount()
  local nCurEnergy = PlayerData.Base:GetCurEnergy().nEnergy
  NovaAPI.SetTMPText(self._mapNode.txtBeforeValue, nCurEnergy)
  local nAfterValue = nCurEnergy + self.mapItemData.nEnergyValue * self.nUseCount
  NovaAPI.SetTMPText(self._mapNode.txtAfterValue, nAfterValue)
  self._mapNode.imgArrow.gameObject:SetActive(self.nUseCount > 0)
  self._mapNode.txtAfterValue.gameObject:SetActive(self.nUseCount > 0)
  self._mapNode.goMaxValue.gameObject:SetActive(nAfterValue >= self._panel.nMaxEnergy)
  LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.rtCountBg)
end

function EnergyItemUseCtrl:Close()
  self._mapNode.animWindow:Play("t_window_04_t_out")
  EventManager.Hit("ConsumableUsed")
end

function EnergyItemUseCtrl:OnBtnClick_Close()
  EventManager.Hit("CloseEnergyBuyPanel")
end

function EnergyItemUseCtrl:OnBtnClick_Confirm()
  if self.nUseCount <= 0 then
    return
  end
  local nExpire = self.mapItemData.nExpire
  local curTime = CS.ClientManager.Instance.serverTimeStamp
  local remainTime = nExpire - curTime
  if remainTime < 0 and 0 < nExpire then
    EventManager.Hit(EventId.OpenMessageBox, {
      nType = AllEnum.MessageBox.Tips,
      sContent = ConfigTable.GetUIText("Energy_Use_Tip_4")
    })
    EventManager.Hit("CloseEnergyBuyPanel")
    return
  end
  local itemList = {}
  local nUseCount = 0
  for id, count in pairs(self.mapItemData.mapId) do
    if nUseCount < self.nUseCount then
      local tbItem = {}
      tbItem.Tid = self.mapItemData.nTid
      tbItem.Id = id
      if nUseCount + count > self.nUseCount then
        tbItem.Qty = self.nUseCount - nUseCount
      else
        tbItem.Qty = count
      end
      table.insert(itemList, tbItem)
    else
      break
    end
    nUseCount = nUseCount + count
  end
  local nMaxCount = 0
  local nCurEnergy = PlayerData.Base:GetCurEnergy().nEnergy
  for i = 1, self.nUseCount do
    nMaxCount = i
    nCurEnergy = nCurEnergy + self.mapItemData.nEnergyValue
    if nCurEnergy >= self._panel.nMaxEnergy then
      break
    end
  end
  if nMaxCount < self.nUseCount then
    local sTip = ConfigTable.GetUIText("Energy_Use_Tip_2")
    EventManager.Hit(EventId.OpenMessageBox, {
      nType = AllEnum.MessageBox.Tips,
      sContent = sTip,
      bBlur = false
    })
    return
  end
  if nil ~= next(itemList) then
    local function msgCallback()
      EventManager.Hit(EventId.OpenPanel, PanelId.ReceivePropsTips, {
        {
          id = AllEnum.CoinItemId.Energy,
          
          count = self.mapItemData.nEnergyValue * self.nUseCount
        }
      })
      EventManager.Hit("CloseEnergyBuyPanel")
      EventManager.Hit("RefreshEnergyItemList")
    end
    
    PlayerData.Item:SendUseItemMsg(itemList, msgCallback)
  end
end

function EnergyItemUseCtrl:OnBtnClick_Item(btn)
  local mapData = {
    nTid = self.mapItemData.nTid,
    bShowDepot = true,
    bShowJumpto = false
  }
  EventManager.Hit(EventId.OpenPanel, PanelId.ItemTips, btn.transform, mapData)
end

return EnergyItemUseCtrl

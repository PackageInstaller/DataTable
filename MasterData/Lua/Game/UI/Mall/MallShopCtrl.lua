local MallShopCtrl = class("MallShopCtrl", BaseCtrl)
MallShopCtrl._mapNodeConfig = {
  sv = {
    sComponentName = "LoopScrollView"
  },
  cgSv = {
    sNodeName = "sv",
    sComponentName = "CanvasGroup"
  },
  tab = {},
  trTab = {sComponentName = "Transform"},
  svTab = {sComponentName = "ScrollRect"},
  goRefresh = {},
  txtRefreshCn = {sComponentName = "TMP_Text"},
  txtRefreshTime = {sComponentName = "TMP_Text"}
}
MallShopCtrl._mapEventConfig = {MallOrderClear = "Refresh"}

function MallShopCtrl:Refresh(bResetPos)
  if self._panel.nCurTog ~= AllEnum.MallToggle.Shop then
    return
  end
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.cgSv, 0)
  
  local function callback(tbList, nTime)
    self:RefreshData(tbList)
    self:RefreshTab()
    self:RefreshList(bResetPos)
    self:SetTimer(nTime)
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.cgSv, 1)
  end
  
  PlayerData.Mall:SendMallShopListReq(callback)
end

function MallShopCtrl:RefreshData(tbList)
  local tbPage = PlayerData.Mall:GetExchangeShop()
  local tbGoodsToPage = {}
  for _, v in pairs(tbList) do
    local mapCfg = ConfigTable.GetData("MallShop", v.sId)
    local nGroupId = mapCfg.GroupId
    if not tbGoodsToPage[nGroupId] then
      tbGoodsToPage[nGroupId] = {}
    end
    table.insert(tbGoodsToPage[nGroupId], v)
  end
  self.tbGoodsPage, self.tbPages = {}, {}
  for _, v in pairs(tbPage) do
    if tbGoodsToPage[v.Id] then
      table.insert(self.tbGoodsPage, tbGoodsToPage[v.Id])
      local mapSample = tbGoodsToPage[v.Id][1]
      table.insert(self.tbPages, {
        Id = v.Id,
        Name = v.Name,
        ShopCoin = v.ShopCoin,
        RefreshTime = mapSample.nNextRefreshTime
      })
    end
  end
  self.nPageCount = #self.tbPages
  local nTab
  if self._panel.nDefaultId then
    for k, v in ipairs(self.tbPages) do
      if v.Id == self._panel.nDefaultId then
        nTab = k
        self._panel.nDefaultId = nil
        break
      end
    end
  end
  if nTab == nil and self.nSelectPage then
    for k, v in ipairs(self.tbPages) do
      if v.Id == self.nSelectPage then
        nTab = k
        break
      end
    end
  end
  self.nCurTab = nTab or 1
  self.nSelectPage = self.tbPages[self.nCurTab].Id
end

function MallShopCtrl:RefreshTab()
  self._mapNode.svTab.gameObject:SetActive(true)
  NovaAPI.SetScrollHorizontal(self._mapNode.svTab, self.nPageCount > 4)
  self.ctrlTab = {}
  delChildren(self._mapNode.trTab)
  for i = 1, self.nPageCount do
    local goTab = instantiate(self._mapNode.tab, self._mapNode.trTab)
    goTab:SetActive(true)
    local btn = goTab.transform:Find("btnTab"):GetComponent("UIButton")
    local func_Handler = ui_handler(self, self.OnBtnClick_ChangeSheet, goTab, i)
    btn.onClick:AddListener(func_Handler)
    self.ctrlTab[i] = self:BindCtrlByNode(goTab, "Game.UI.TemplateEx.TemplateTabCtrl")
    self.ctrlTab[i]:SetText(self.tbPages[i].Name)
  end
  for i = 1, self.nPageCount do
    local nState = self:GetTabState(i)
    self.ctrlTab[i]:SetSelect(i == self.nCurTab, nState)
    EventManager.Hit("MallChangeTopCoin", self.tbPages[self.nCurTab].ShopCoin)
    if i == self.nCurTab and 1 < i then
      self.ctrlTab[i - 1]:SetLine(false)
    end
  end
end

function MallShopCtrl:SetTimer(nTime)
  if self.timer ~= nil then
    self.timer:Cancel(false)
    self.timer = nil
  end
  if 0 < nTime then
    self.timer = self:AddTimer(1, nTime, function()
      self:Refresh(true)
      EventManager.Hit(EventId.CloseMessageBox)
      EventManager.Hit("MallCloseDetail")
    end, true, true, false)
  end
end

function MallShopCtrl:GetTabState(nCurTab)
  local nState = 2
  if nCurTab == 1 then
    nState = 1
  elseif nCurTab == self.nPageCount then
    nState = 3
  end
  return nState
end

function MallShopCtrl:RefreshList(bResetPos)
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  local tbCur = self.tbGoodsPage[self.nCurTab]
  self._mapNode.sv:SetAnim(0.04)
  self._mapNode.sv:Init(#tbCur, self, self.OnGridRefresh, self.OnGridBtnClick, not bResetPos)
  local mapShop = self.tbPages[self.nCurTab]
  self.nRemainTime = mapShop.RefreshTime == 0 and 0 or mapShop.RefreshTime - CS.ClientManager.Instance.serverTimeStamp
  if self.timerCountDown == nil then
    self.timerCountDown = self:AddTimer(0, 1, "RefreshTime", false, true, false)
  end
  if self.nRemainTime > 0 then
    self._mapNode.goRefresh:SetActive(true)
    self:RefreshTime()
    self.timerCountDown:Pause(false)
  else
    self._mapNode.goRefresh:SetActive(false)
    self.timerCountDown:Pause(true)
  end
end

function MallShopCtrl:OnGridRefresh(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local mapData = self.tbGoodsPage[self.nCurTab][nIndex]
  local nInstanceID = goGrid:GetInstanceID()
  if not self.tbGridCtrl[nInstanceID] then
    self.tbGridCtrl[nInstanceID] = self:BindCtrlByNode(goGrid, "Game.UI.Mall.MallShopItemCtrl")
  end
  self.tbGridCtrl[nInstanceID]:Refresh(mapData)
end

function MallShopCtrl:OnGridBtnClick(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local mapData = self.tbGoodsPage[self.nCurTab][nIndex]
  local mapCfg = ConfigTable.GetData("MallShop", mapData.sId)
  local tbCoin = mapCfg and {
    mapCfg.ExchangeItemId
  } or {}
  EventManager.Hit(EventId.OpenPanel, PanelId.MallPopup, AllEnum.MallToggle.Shop, mapData, tbCoin)
end

function MallShopCtrl:RefreshTime()
  self._mapNode.goRefresh:SetActive(true)
  self.nRemainTime = self.nRemainTime - 1
  if self.nRemainTime > 0 then
    NovaAPI.SetTMPText(self._mapNode.txtRefreshCn, ConfigTable.GetUIText("Shop_NextRefresh"))
    local sTime = ""
    if self.nRemainTime <= 60 then
      local sec = math.floor(self.nRemainTime)
      sTime = orderedFormat(ConfigTable.GetUIText("Shop_NextRefresh_Sec") or "", sec)
    elseif self.nRemainTime > 60 and self.nRemainTime <= 3600 then
      local min = math.floor(self.nRemainTime / 60)
      local sec = math.floor(self.nRemainTime - min * 60)
      if sec == 0 then
        min = min - 1
        sec = 60
      end
      sTime = orderedFormat(ConfigTable.GetUIText("Shop_NextRefresh_Min") or "", min, sec)
    elseif self.nRemainTime > 3600 and self.nRemainTime <= 86400 then
      local hour = math.floor(self.nRemainTime / 3600)
      local min = math.floor((self.nRemainTime - hour * 3600) / 60)
      if min == 0 then
        hour = hour - 1
        min = 60
      end
      sTime = orderedFormat(ConfigTable.GetUIText("Shop_NextRefresh_Hour") or "", hour, min)
    elseif self.nRemainTime > 86400 then
      local day = math.floor(self.nRemainTime / 86400)
      local hour = math.floor((self.nRemainTime - day * 86400) / 3600)
      if hour == 0 then
        day = day - 1
        hour = 24
      end
      sTime = orderedFormat(ConfigTable.GetUIText("Shop_NextRefresh_Day") or "", day, hour)
    end
    NovaAPI.SetTMPText(self._mapNode.txtRefreshTime, sTime)
  else
    self.timerCountDown:Pause(true)
  end
end

function MallShopCtrl:ResetTab()
  if not self.ctrlTab then
    return
  end
  if self.nCurTab and self.nCurTab > 1 then
    local nState = self:GetTabState(self.nCurTab)
    self.ctrlTab[self.nCurTab]:SetSelect(false, nState)
    self.ctrlTab[self.nCurTab - 1]:SetLine(true)
  end
  self.nCurTab = 1
  self.ctrlTab[self.nCurTab]:SetSelect(true, 1)
  self.nSelectPage = self.tbPages[self.nCurTab] and self.tbPages[self.nCurTab].Id or nil
end

function MallShopCtrl:Awake()
  self.tbGridCtrl = {}
  self._mapNode.svTab.gameObject:SetActive(false)
  self._mapNode.goRefresh:SetActive(false)
end

function MallShopCtrl:OnEnable()
end

function MallShopCtrl:OnDisable()
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  self.tbGridCtrl = {}
  if self.ctrlTab then
    for nTab, objCtrl in pairs(self.ctrlTab) do
      self:UnbindCtrlByNode(objCtrl)
      self.ctrlTab[nTab] = nil
    end
    self.ctrlTab = nil
  end
end

function MallShopCtrl:OnDestroy()
end

function MallShopCtrl:OnBtnClick_ChangeSheet(btn, nIndex)
  if nIndex == self.nCurTab then
    return
  end
  local nState = self:GetTabState(self.nCurTab)
  self.ctrlTab[self.nCurTab]:SetSelect(false, nState)
  if self.nCurTab > 1 then
    self.ctrlTab[self.nCurTab - 1]:SetLine(true)
  end
  nState = self:GetTabState(nIndex)
  self.ctrlTab[nIndex]:SetSelect(true, nState)
  if 1 < nIndex then
    self.ctrlTab[nIndex - 1]:SetLine(false)
  end
  self.nCurTab = nIndex
  self.nSelectPage = self.tbPages[self.nCurTab].Id
  EventManager.Hit("MallChangeTopCoin", self.tbPages[self.nCurTab].ShopCoin)
  self:RefreshList(true)
end

return MallShopCtrl

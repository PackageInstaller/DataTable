local DepotCtrl = class("DepotCtrl", BaseCtrl)
local DepotData = require("GameCore.Data.DataClass.DepotData")
DepotCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  aniRoot = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "Animator"
  },
  sv = {
    sComponentName = "LoopScrollView"
  },
  trSv = {sNodeName = "sv", sComponentName = "Transform"},
  imgEmpty = {},
  txtEmptyTitle = {sComponentName = "TMP_Text"},
  ItemList = {
    sNodeName = "---ItemList---"
  },
  ItemInfo = {
    sNodeName = "---ItemInfo---"
  },
  tog = {
    nCount = 6,
    sComponentName = "UIButton",
    callback = "OnBtnClick_ChangeSheet"
  },
  ctrlTog = {
    nCount = 6,
    sNodeName = "tog",
    sCtrlName = "Game.UI.TemplateEx.TemplateToggleCtrl"
  },
  goTitle = {
    sCtrlName = "Game.UI.DepotEx.DepotItemTitleCtrl"
  },
  goInfoList = {
    sCtrlName = "Game.UI.DepotEx.DepotItemInfoCtrl"
  },
  btnDetail = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Detail"
  },
  txtDetail = {
    sComponentName = "TMP_Text",
    sLanguageId = "Depot_Btn_Info"
  },
  btnUse = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Use"
  },
  txtUse = {
    sComponentName = "TMP_Text",
    sLanguageId = "Depot_Btn_Use"
  },
  goListBtn = {
    sCtrlName = "Game.UI.DepotEx.DepotSortCtrl"
  }
}
DepotCtrl._mapEventConfig = {
  ConsumableUsed = "OnEvent_RefreshDepot",
  CraftingSuccess = "OnEvent_RefreshDepot",
  DepotChangeSort = "OnEvent_ChangeSort",
  RefreshTogTimeLimit = "OnEvent_RefreshTogTimeLimit"
}

function DepotCtrl:SwitchTog()
  self._mapNode.goListBtn:RefreshSort(self.nCurTog)
  self:RefreshListData()
  self:RefreshEmpty()
  self:RefreshItemList()
  self:RefreshBottom()
  self:RefreshInfo()
end

function DepotCtrl:RefreshListData(bSort)
  local mapSort = self._mapNode.goListBtn:GetSortCfg(self.nCurTog)
  local tbFilter = self._mapNode.goListBtn:GetFilterCfg(self.nCurTog)
  self.DepotData:Init(self.nCurTog)
  local tbItem = self.DepotData:GetSortedList(self.nCurTog, mapSort, tbFilter)
  self.nItemCount = self.DepotData:GetGridCount(self.nCurTog)
  self.nSortCount = #tbItem
  if self.nSortCount > 0 then
    self.tbItem = tbItem
  else
    self.tbItem = {}
  end
  if bSort then
    self.mapSelect = nil
  end
  self:SetSelectData()
  self:RefreshInfo()
end

function DepotCtrl:SetSelectData()
  if self.mapSelect then
    for i, mapData in pairs(self.tbItem) do
      if mapData.nId == self.mapSelect.nId and mapData.nExpire == self.mapSelect.nExpire then
        self.mapSelect = mapData
        self.nSelectIndex = i
        return
      end
    end
    self.mapSelect = nil
  end
  self.nSelectIndex = 1
  self.mapSelect = self.tbItem[self.nSelectIndex]
end

function DepotCtrl:RefreshEmpty()
  self._mapNode.imgEmpty:SetActive(self.nItemCount <= 0)
  NovaAPI.SetTMPText(self._mapNode.txtEmptyTitle, ConfigTable.GetUIText("Depot_Empty"))
end

function DepotCtrl:RefreshListWithPos(bReset)
  if bReset then
    self.nPos = nil
  else
    self.nPos = self._mapNode.sv:GetScrollPos()
  end
  self:RefreshItemList()
end

function DepotCtrl:RefreshItemList()
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  self._mapNode.ItemList:SetActive(self.nItemCount > 0)
  self._mapNode.sv.gameObject:SetActive(0 < self.nSortCount)
  if 0 < self.nSortCount then
    self._mapNode.sv:Init(self.nSortCount, self, self.OnGridRefresh, self.OnGridBtnClick, self.nPos ~= nil)
  end
end

function DepotCtrl:OnGridRefresh(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local mapItem = self.tbItem[nIndex]
  local nInstanceID = goGrid:GetInstanceID()
  if not self.tbGridCtrl[nInstanceID] then
    self.tbGridCtrl[nInstanceID] = self:BindCtrlByNode(goGrid, "Game.UI.TemplateEx.TemplateItemCtrl")
  end
  self.tbGridCtrl[nInstanceID]:SetItem(mapItem.nTid, mapItem.nRarity, mapItem.nCount, mapItem.nExpire)
  self.tbGridCtrl[nInstanceID]:SetSelect(self.nSelectIndex == nIndex)
end

function DepotCtrl:OnGridBtnClick(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local nInstanceID = goGrid:GetInstanceID()
  if self.nSelectIndex then
    local goSelect = self._mapNode.trSv:Find("Viewport/Content/" .. self.nSelectIndex - 1)
    if goSelect then
      self.tbGridCtrl[goSelect.gameObject:GetInstanceID()]:SetSelect(false)
    end
  end
  self.tbGridCtrl[nInstanceID]:SetSelect(true)
  self.nSelectIndex = nIndex
  self.mapSelect = self.tbItem[nIndex]
  self:RefreshInfo()
end

function DepotCtrl:RefreshBottom()
  self._mapNode.btnDetail.gameObject:SetActive(false)
  self._mapNode.btnUse.gameObject:SetActive(self.nCurTog == GameEnum.packMark.Consumables)
end

function DepotCtrl:RefreshInfo()
  self._mapNode.ItemInfo:SetActive(self.nSortCount > 0)
  if self.mapSelect then
    self._mapNode.goTitle:SetItemTitle(self.nCurTog, self.mapSelect)
    self._mapNode.goInfoList:SetItemInfo(self.nCurTog, self.mapSelect)
    local nSelectTid = self.mapSelect.nTid
    local mapItemCfgData = ConfigTable.GetData_Item(nSelectTid)
    if not mapItemCfgData then
      return
    end
    self._mapNode.btnUse.gameObject:SetActive(mapItemCfgData.UseMode == GameEnum.useMode.UseModeManual)
  else
    self._mapNode.btnUse.gameObject:SetActive(false)
  end
end

function DepotCtrl:SetDefaultTog()
  self.DepotData:Init()
  if type(self.nCurTog) ~= "number" or self.nCurTog <= 0 then
    self.nCurTog = nil
    for _, tog in ipairs(self.TogSort) do
      if 0 < self.DepotData:GetGridCount(tog) then
        self.nCurTog = tog
        break
      end
    end
    if self.nCurTog == nil then
      self.nCurTog = self.TogSort[1]
    end
  end
  for i = 1, 6 do
    self._mapNode.tog[i].gameObject:SetActive(false)
  end
  for _, tog in ipairs(self.TogSort) do
    local i = table.keyof(self.TogSort, tog)
    self._mapNode.ctrlTog[i]:SetDefault(tog == self.nCurTog)
    self._mapNode.tog[i].gameObject:SetActive(true)
  end
  self:SwitchTog()
end

function DepotCtrl:RefreshTogTimeLimit()
  local nCurTime = CS.ClientManager.Instance.serverTimeStamp
  for k, tog in ipairs(self.TogSort) do
    if self._mapNode.tog[k] ~= nil then
      local imgTimeLimit = self._mapNode.tog[k].transform:Find("AnimRoot/AnimSwitch/goBg/unSelect/imgTimeLimit")
      local imgRemainTime1 = imgTimeLimit.transform:Find("imgRemainTime1")
      local imgRemainTime2 = imgTimeLimit.transform:Find("imgRemainTime2")
      local imgRemainTime3 = imgTimeLimit.transform:Find("imgRemainTime3")
      local txtTimeLimit = imgTimeLimit.transform:Find("txtTimeLimit"):GetComponent("TMP_Text")
      local nMinExpire = -1
      local tbItems = self.DepotData:GetSortedList(tog)
      if tbItems ~= nil then
        for _, v in ipairs(tbItems) do
          if v.nExpire ~= 0 and (nMinExpire == -1 or nMinExpire > v.nExpire) and nCurTime < v.nExpire then
            nMinExpire = v.nExpire
          end
        end
      end
      imgTimeLimit.gameObject:SetActive(0 < nMinExpire)
      local remainTime = nMinExpire - nCurTime
      if 86400 <= remainTime then
        local day = math.floor(remainTime / 86400)
        local hour = math.floor((remainTime - day * 86400) / 3600)
        if hour == 0 then
          day = day - 1
          hour = 24
        end
        NovaAPI.SetTMPText(txtTimeLimit, string.format("%s%s%s%s", day, ConfigTable.GetUIText("Depot_LeftTime_Day"), hour, ConfigTable.GetUIText("Depot_LeftTime_Hour")))
      elseif 3600 <= remainTime then
        local hour = math.floor(remainTime / 3600)
        local min = math.floor((remainTime - hour * 3600) / 60)
        if min == 0 then
          hour = hour - 1
          min = 60
        end
        NovaAPI.SetTMPText(txtTimeLimit, string.format("%s%s%s%s", hour, ConfigTable.GetUIText("Depot_LeftTime_Hour"), min, ConfigTable.GetUIText("Depot_LeftTime_Min")))
      else
        local min = math.max(math.floor(remainTime / 60), 1)
        NovaAPI.SetTMPText(txtTimeLimit, string.format("%s%s", min, ConfigTable.GetUIText("Depot_LeftTime_Min")))
      end
      imgRemainTime1.gameObject:SetActive(86400 <= remainTime)
      imgRemainTime2.gameObject:SetActive(remainTime < 86400 and 3600 <= remainTime)
      imgRemainTime3.gameObject:SetActive(remainTime < 3600)
    end
  end
end

function DepotCtrl:RefreshTogText()
  for _, v in ipairs(self.TogSort) do
    self._mapNode.ctrlTog[table.keyof(self.TogSort, v)]:SetText(self:GetTogTextByType(v))
  end
end

function DepotCtrl:GetTogTextByType(nMark)
  local text = ""
  
  local function foreachItemPackMark(mapData)
    if mapData.PackMark == nMark then
      text = mapData.Name
    end
  end
  
  ForEachTableLine(DataTable.ItemPackMark, foreachItemPackMark)
  return text
end

function DepotCtrl:ResetTogData()
  self.mapSelect = nil
  self.nSelectIndex = nil
  self.nPos = nil
end

function DepotCtrl:SortItemPackMark()
  local tbItemPackMark = {}
  
  local function foreachItemPackMark(mapData)
    table.insert(tbItemPackMark, mapData)
  end
  
  ForEachTableLine(DataTable.ItemPackMark, foreachItemPackMark)
  table.sort(tbItemPackMark, function(a, b)
    return a.Sort < b.Sort
  end)
  self.TogSort = {}
  for i = 1, #tbItemPackMark do
    self.TogSort[i] = tbItemPackMark[i].PackMark
  end
end

function DepotCtrl:JumpDetail()
end

function DepotCtrl:FadeIn(bPlayFadeIn)
  EventManager.Hit(EventId.SetTransition)
  self._mapNode.aniRoot:Play("depot_t_in")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function DepotCtrl:Awake()
  self:ResetTogData()
  self.nCurTog = nil
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    self.nCurTog = tbParam[1]
  end
  self:SortItemPackMark()
  self:RefreshTogText()
end

function DepotCtrl:OnEnable()
  self.tbGridCtrl = {}
  self.tbItem = nil
  self.DepotData = DepotData.new()
  self:SetDefaultTog()
  self:RefreshTogTimeLimit()
end

function DepotCtrl:OnDisable()
  self.DepotData:Clear()
  self.DepotData = nil
  self.tbItem = nil
  if self.nSortCount and self.nSortCount > 0 then
    self.nPos = self._mapNode.sv:GetScrollPos()
  end
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  self.tbGridCtrl = {}
end

function DepotCtrl:OnDestroy()
  self:ResetTogData()
  self.nCurTog = nil
end

function DepotCtrl:OnBtnClick_ChangeSheet(btn, nIndex)
  local nSelectTog = self.TogSort[nIndex]
  if nSelectTog == self.nCurTog then
    return
  end
  self._mapNode.ctrlTog[nIndex]:SetTrigger(true)
  self._mapNode.ctrlTog[table.keyof(self.TogSort, self.nCurTog)]:SetTrigger(false)
  self.nCurTog = nSelectTog
  self:ResetTogData()
  self:SwitchTog()
  self:RefreshTogTimeLimit()
end

function DepotCtrl:OnBtnClick_Detail(btn)
  self._mapNode.aniRoot:Play("depot_t_out")
  self:AddTimer(1, 0.1, "JumpDetail", true, true)
end

function DepotCtrl:OnBtnClick_Use(btn)
  if self.mapSelect ~= nil then
    local nSelectTid = self.mapSelect.nTid
    local mapItemCfgData = ConfigTable.GetData_Item(nSelectTid)
    if not mapItemCfgData then
      return
    end
    if mapItemCfgData.Stype == GameEnum.itemStype.EnergyItem or mapItemCfgData.Stype == GameEnum.itemStype.SouvenirEnergyItem then
      local mapItemCahceData = PlayerData.Item:GetItemCacheDataByID(self.mapSelect.nTid)
      if not mapItemCahceData then
        return
      end
      local nCurEnergy = PlayerData.Base:GetCurEnergy().nEnergy
      local nMaxEnergy = ConfigTable.GetConfigNumber("EnergyObtainLimit")
      if nCurEnergy >= nMaxEnergy then
        local sTip = ConfigTable.GetUIText("Energy_Use_Tip_2")
        EventManager.Hit(EventId.OpenMessageBox, {
          nType = AllEnum.MessageBox.Tips,
          sContent = sTip
        })
        return
      end
      local useCfg = decodeJson(mapItemCfgData.UseArgs)
      local nEnergyValue = 0
      for itemId, count in pairs(useCfg) do
        local checkItemCfg = ConfigTable.GetData_Item(tonumber(itemId))
        if nil ~= checkItemCfg and checkItemCfg.Stype == GameEnum.itemStype.Energy then
          nEnergyValue = count
        else
          printLog(string.format("体力道具使用参数配置错误！！！请检查！itemId = [%s]", itemId))
        end
      end
      local mapItem = {
        nTid = mapItemCahceData.Tid,
        mapId = mapItemCahceData.mapExpires[self.mapSelect.nExpire].mapId,
        nExpire = self.mapSelect.nExpire,
        nTimeLimit = 0 < self.mapSelect.nExpire and 1 or 0,
        nCount = mapItemCahceData.mapExpires[self.mapSelect.nExpire].nTotalCount,
        nEnergyValue = nEnergyValue
      }
      EventManager.Hit(EventId.OpenPanel, PanelId.EnergyBuy, AllEnum.EnergyPanelType.ItemUse, mapItem, true)
    elseif mapItemCfgData.Stype == GameEnum.itemStype.TokenItem then
      local mapItemCacheData = PlayerData.Item:GetItemCacheDataByID(nSelectTid)
      local mapExpireData = mapItemCacheData and mapItemCacheData.mapExpires[self.mapSelect.nExpire]
      if not mapExpireData or 0 >= mapExpireData.nTotalCount then
        return
      end
      local nCurToken = PlayerData.StarTowerAutoPlan:GetTokenCount()
      local nMaxToken = ConfigTable.GetConfigNumber("TowerVitaEnergyMax")
      if nCurToken >= nMaxToken then
        local sTip = ConfigTable.GetUIText("TokenBuy_HitLimit")
        EventManager.Hit(EventId.OpenMessageBox, {
          nType = AllEnum.MessageBox.Tips,
          sContent = sTip
        })
        return
      end
      local mapUseCfg = decodeJson(mapItemCfgData.UseArgs) or {}
      local nTokenValue = tonumber(mapUseCfg[tostring(AllEnum.CoinItemId.AutoDecisionToken)] or mapUseCfg[AllEnum.CoinItemId.AutoDecisionToken]) or 0
      if nTokenValue <= 0 then
        printError(string.format("Invalid token item UseArgs: itemId = [%s]", nSelectTid))
        return
      end
      local mapItem = {
        nTid = nSelectTid,
        mapId = mapExpireData.mapId,
        nCount = mapExpireData.nTotalCount,
        nTokenValue = nTokenValue
      }
      EventManager.Hit(EventId.OpenPanel, PanelId.StarTowerTokenBuyPanel, AllEnum.TokenBuyPanelType.ItemUse, mapItem, true)
    elseif mapItemCfgData.Stype == GameEnum.itemStype.ComCYO or mapItemCfgData.Stype == GameEnum.itemStype.OutfitCYO or mapItemCfgData.Stype == GameEnum.itemStype.RandomPackage then
      EventManager.Hit(EventId.OpenPanel, PanelId.Consumable, {
        self.mapSelect.nTid
      })
    elseif mapItemCfgData.Stype == GameEnum.itemStype.CharacterYO then
      EventManager.Hit(EventId.OpenPanel, PanelId.CharConsumablePanel, self.mapSelect.nTid)
    end
  end
end

function DepotCtrl:OnEvent_ChangeSort(bReset)
  self:RefreshListData(true)
  self:RefreshListWithPos(bReset)
end

function DepotCtrl:OnEvent_RefreshDepot()
  self.DepotData:Init()
  self:SwitchTog()
  self:RefreshTogTimeLimit()
end

return DepotCtrl

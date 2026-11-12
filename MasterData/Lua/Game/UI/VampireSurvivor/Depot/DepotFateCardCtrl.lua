local DepotFateCardCtrl = class("DepotFateCardCtrl", BaseCtrl)
local LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
DepotFateCardCtrl._mapNodeConfig = {
  rtItemListContent = {
    sComponentName = "RectTransform"
  },
  goFateCardItem = {},
  goDepotItem = {},
  goItemList = {},
  FateCardList = {
    sNodeName = "FateCardList_",
    nCount = 5
  },
  txtFateCard = {
    sComponentName = "TMP_Text",
    nCount = 5,
    sNodeName = "txtFateCard_"
  },
  txtHas = {
    sComponentName = "TMP_Text",
    nCount = 5,
    sNodeName = "txtHas_"
  },
  txtAll = {
    sComponentName = "TMP_Text",
    nCount = 5,
    sNodeName = "txtAll_"
  },
  imgPackageIcon = {
    sComponentName = "Image",
    nCount = 5,
    sNodeName = "imgPackageIcon_"
  },
  imgSubIcon = {
    sComponentName = "Image",
    nCount = 5,
    sNodeName = "imgSubIcon_"
  },
  rtFateCard = {
    sComponentName = "Transform",
    nCount = 5,
    sNodeName = "rtFateCard_"
  },
  ItemInfo = {
    sNodeName = "---ItemInfo---"
  },
  goItemL = {
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl"
  },
  txtItemName = {sComponentName = "TMP_Text"},
  txtCountCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Depot_Info_QTY"
  },
  txtItemCount = {sComponentName = "TMP_Text"},
  txtDescribeTitle1 = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Depot_Info_Desc"
  },
  txtItemDesc = {sComponentName = "TMP_Text"},
  Content = {
    sComponentName = "RectTransform"
  },
  FateCardInfo = {
    sNodeName = "---FateCardInfo---"
  },
  goFateCardInfo = {
    sCtrlName = "Game.UI.VampireSurvivor.Depot.DepotFateCardItemCtrl"
  },
  txtFateCardName = {sComponentName = "TMP_Text"},
  imgEffect = {nCount = 3},
  txtEffect1 = {
    sComponentName = "TMP_Text",
    sLanguageId = "VampireDepot_ReminTime"
  },
  txtEffect2 = {
    sComponentName = "TMP_Text",
    sLanguageId = "VampireDepot_ReminTime_None"
  },
  txtEffect3 = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_FateCard_Unable"
  },
  txtEffectCount = {sComponentName = "TMP_Text"},
  txtDescribeTitle2 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Depot_Describe"
  },
  txtFateCardDesc = {sComponentName = "TMP_Text"},
  imgEmpty = {},
  txt_EmptyTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Item_List_Empty"
  }
}
DepotFateCardCtrl._mapEventConfig = {}
DepotFateCardCtrl._mapRedDotConfig = {}
local item_type = {FateCard = 1, Item = 2}

function DepotFateCardCtrl:InitPackage(nLevelId)
  self.nLevelId = nLevelId
  local mapLevelData = ConfigTable.GetData("VampireSurvivor", nLevelId)
  if mapLevelData == nil then
    return
  end
  local tbBundle = mapLevelData.FateCardBundle
  self.tbBundle = clone(tbBundle)
  self.tbExFateCard = decodeJson(mapLevelData.SpeciaFateCard)
  if self.tbExFateCard == nil then
    self.tbExFateCard = {}
  end
  for i = 1, 5 do
    if self.tbBundle[i] == nil then
      self._mapNode.FateCardList[i].gameObject:SetActive(false)
    else
      local mapBundleCfgData = ConfigTable.GetData("StarTowerBookFateCardBundle", self.tbBundle[i])
      self.tbFateCardCtrl[i] = {}
      if mapBundleCfgData ~= nil then
        NovaAPI.SetTMPText(self._mapNode.txtFateCard[i], mapBundleCfgData.Name)
        self:SetPngSprite(self._mapNode.imgPackageIcon[i], mapBundleCfgData.Icon .. AllEnum.FateCardBundleIcon.S)
        self:SetAtlasSprite(self._mapNode.imgSubIcon[i], "05_language", mapBundleCfgData.Text)
        NovaAPI.SetImageNativeSize(self._mapNode.imgSubIcon[i])
      end
    end
  end
end

function DepotFateCardCtrl:RefreshFateCard(mapFateCard)
  self.mapFateCard = {}
  for nId, v in pairs(mapFateCard) do
    local mapBundleCfgData = ConfigTable.GetData("StarTowerBookFateCard", nId)
    local nBundleIdx = 0
    local bEx = false
    if mapBundleCfgData ~= nil then
      local nBundleId = mapBundleCfgData.BundleId
      nBundleIdx = table.indexof(self.tbBundle, nBundleId)
    end
    if nBundleIdx < 1 then
      bEx, nBundleIdx = self:isExFateCard(nId)
    end
    if 5 < nBundleIdx or nBundleIdx < 1 then
      printError("无法获取Bundle索引")
      nBundleIdx = 1
    end
    table.insert(self.mapFateCard, {
      nTid = nId,
      nCount = v,
      bEx = bEx,
      nBundleIdx = nBundleIdx
    })
  end
  local tbCount = {
    0,
    0,
    0,
    0,
    0
  }
  if #self.mapFateCard == 0 then
    self._mapNode.ItemInfo.gameObject:SetActive(false)
    self._mapNode.FateCardInfo.gameObject:SetActive(false)
    self._mapNode.imgEmpty:SetActive(true)
    self._mapNode.goItemList:SetActive(false)
    return
  end
  self._mapNode.imgEmpty:SetActive(false)
  self._mapNode.goItemList:SetActive(true)
  table.sort(self.mapFateCard, function(a, b)
    if a.nBundleIdx ~= b.nBundleIdx then
      return a.nBundleIdx < b.nBundleIdx
    end
    if a.nCount * b.nCount == 0 and a.nCount + b.nCount ~= 0 then
      return a.nCount ~= 0
    end
    if a.bEx ~= b.bEx then
      return a.bEx
    end
    return a.nTid < b.nTid
  end)
  local nFirstId = 0
  if #self.mapFateCard > 0 then
    nFirstId = self.mapFateCard[1].nTid
  end
  for _, tbItemCtrl in ipairs(self.tbFateCardCtrl) do
    for _, v in ipairs(tbItemCtrl) do
      v.gameObject:SetActive(false)
    end
  end
  for k, v in ipairs(self.mapFateCard) do
    local itemObj
    local nBundleIdx = v.nBundleIdx
    local bEx = v.bEx
    tbCount[nBundleIdx] = tbCount[nBundleIdx] + 1
    if nil == self.tbFateCardCtrl[nBundleIdx] then
      self.tbFateCardCtrl[nBundleIdx] = {}
    end
    local nIdx = tbCount[nBundleIdx]
    if self.tbFateCardCtrl[nBundleIdx][nIdx] == nil then
      itemObj = instantiate(self._mapNode.goFateCardItem, self._mapNode.rtFateCard[nBundleIdx])
      itemObj.gameObject:SetActive(true)
      local itemCtrl = self:BindCtrlByNode(itemObj, "Game.UI.VampireSurvivor.Depot.DepotFateCardItemCtrl")
      itemCtrl:InitFateCard(v.nTid, v.nCount, bEx)
      table.insert(self.tbFateCardCtrl[nBundleIdx], itemCtrl)
    else
      itemObj = self.tbFateCardCtrl[nBundleIdx][nIdx].gameObject
      itemObj:SetActive(true)
      self.tbFateCardCtrl[nBundleIdx][nIdx]:InitFateCard(v.nTid, v.nCount)
    end
    local btnSelect = itemObj.transform:Find("btnItem"):GetComponent("UIButton")
    btnSelect.onClick:RemoveAllListeners()
    
    local function func_select()
      self:SelectItem(item_type.FateCard, nBundleIdx, nIdx, k)
    end
    
    btnSelect.onClick:AddListener(func_select)
    if nFirstId == v.nTid then
      self:SelectItem(item_type.FateCard, nBundleIdx, nIdx, k)
    end
  end
  for nIdx, tbItem in pairs(self.tbFateCardCtrl) do
    self._mapNode.FateCardList[nIdx]:SetActive(0 < tbCount[nIdx])
    NovaAPI.SetTMPText(self._mapNode.txtHas[nIdx], tbCount[nIdx])
  end
end

function DepotFateCardCtrl:SelectItem(nType, nBundleIdx, nIndex, nIdx)
  self._mapNode.ItemInfo.gameObject:SetActive(false)
  self._mapNode.FateCardInfo.gameObject:SetActive(false)
  if nil ~= self.nSelectIndex and self.nSelectType == item_type.FateCard then
    self.tbFateCardCtrl[self.nSelectBundleIdx][self.nSelectIndex]:SetChoose(false)
  end
  self.nSelectType = nType
  self.nSelectBundleIdx = nBundleIdx
  self.nSelectIndex = nIndex
  if self.nSelectType == item_type.FateCard then
    self._mapNode.FateCardInfo.gameObject:SetActive(true)
    self.tbFateCardCtrl[self.nSelectBundleIdx][self.nSelectIndex]:SetChoose(true)
    self:SetFateCardInfo(nIdx)
  end
end

function DepotFateCardCtrl:SetItemInfo()
  local mapSelect = self.mapItem[self.nSelectIndex]
  local mapCfg = ConfigTable.GetData_Item(mapSelect.nTid)
  self._mapNode.goItemL:SetItem(mapSelect.nTid)
  NovaAPI.SetTMPText(self._mapNode.txtItemCount, mapSelect.nCount)
  if mapCfg ~= nil then
    NovaAPI.SetTMPText(self._mapNode.txtItemName, mapCfg.Title)
    NovaAPI.SetTMPText(self._mapNode.txtItemDesc, mapCfg.Desc)
  end
end

function DepotFateCardCtrl:SetFateCardInfo(nIdx)
  local mapSelect = self.mapFateCard[nIdx]
  if nil ~= mapSelect then
    local itemCfg = ConfigTable.GetData_Item(mapSelect.nTid)
    local fateCardCfg = ConfigTable.GetData("FateCard", mapSelect.nTid)
    if nil == fateCardCfg then
      printError(string.format("获取FateCard表格配置失败！！！id = [%s]", mapSelect.nTid))
      return
    end
    NovaAPI.SetTMPText(self._mapNode.txtFateCardName, fateCardCfg.Name)
    local sDesc = UTILS.ParseParamDesc(fateCardCfg.Desc2, fateCardCfg)
    NovaAPI.SetTMPText(self._mapNode.txtFateCardDesc, sDesc)
    self._mapNode.goFateCardInfo:InitFateCard(mapSelect.nTid, mapSelect.nCount, false)
    for _, v in ipairs(self._mapNode.imgEffect) do
      v.gameObject:SetActive(false)
    end
    if mapSelect.nCount == 0 then
      self._mapNode.imgEffect[3].gameObject:SetActive(true)
    elseif mapSelect.nCount < 0 then
      self._mapNode.imgEffect[2].gameObject:SetActive(true)
    else
      self._mapNode.imgEffect[1].gameObject:SetActive(true)
      NovaAPI.SetTMPText(self._mapNode.txtEffectCount, orderedFormat(ConfigTable.GetUIText("VampireDepot_ReminTime_Sec"), mapSelect.nCount))
    end
  end
end

function DepotFateCardCtrl:Awake()
  self.tbFateCardCtrl = {}
  self.nSelectIndex = nil
  self.nSelectType = 0
  self._mapNode.goFateCardItem.gameObject:SetActive(false)
  self._mapNode.goDepotItem.gameObject:SetActive(false)
end

function DepotFateCardCtrl:ClearFateCard()
  for _, tbItemCtrl in ipairs(self.tbFateCardCtrl) do
    for _, v in ipairs(tbItemCtrl) do
      self:UnbindCtrlByNode(v)
    end
  end
  self.tbFateCardCtrl = {}
end

function DepotFateCardCtrl:OnDestroy()
  self:ClearFateCard()
end

function DepotFateCardCtrl:isExFateCard(nFateCardId)
  for i, tbExFateCard in ipairs(self.tbExFateCard) do
    if table.indexof(tbExFateCard, nFateCardId) > 0 then
      return true, i
    end
  end
  return false, 0
end

return DepotFateCardCtrl

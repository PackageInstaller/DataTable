local DepotItemListCtrl = class("DepotItemListCtrl", BaseCtrl)
local LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
DepotItemListCtrl._mapNodeConfig = {
  rtItemListContent = {
    sComponentName = "RectTransform"
  },
  goFateCardItem = {},
  goDepotItem = {},
  txtFateCard = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Depot_FateCard_Title"
  },
  txtItem = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Depot_Item_Title"
  },
  goItemList = {},
  FateCardList = {},
  rtFateCard = {
    sComponentName = "RectTransform"
  },
  ItemList = {},
  rtItem = {
    sComponentName = "RectTransform"
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
    sCtrlName = "Game.UI.StarTower.Depot.DepotFateCardItemCtrl"
  },
  txtFateCardName = {sComponentName = "TMP_Text"},
  imgEffect = {nCount = 3},
  txtEffect1 = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_FateCard_Effect_Count"
  },
  txtEffect2 = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_FateCard_Effect"
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
DepotItemListCtrl._mapEventConfig = {}
DepotItemListCtrl._mapRedDotConfig = {}
local item_type = {FateCard = 1, Item = 2}

function DepotItemListCtrl:RefreshItemList(mapFateCard, mapItem, nParam)
  self._mapNode.ItemInfo.gameObject:SetActive(false)
  self._mapNode.FateCardInfo.gameObject:SetActive(false)
  local bFateCard = mapFateCard ~= nil and next(mapFateCard) ~= nil
  self._mapNode.FateCardList.gameObject:SetActive(bFateCard)
  if bFateCard then
    self:RefreshFateCard(mapFateCard)
  end
  local bItem = mapItem ~= nil and next(mapItem) ~= nil
  self._mapNode.ItemList.gameObject:SetActive(bItem)
  if bItem then
    self:RefreshItem(mapItem)
  end
  self._mapNode.goItemList.gameObject:SetActive(bFateCard or bItem)
  self._mapNode.imgEmpty.gameObject:SetActive(not bFateCard and not bItem)
  local nSelectType, nSelectIndex
  if bFateCard then
    nSelectType = item_type.FateCard
    nSelectIndex = 1
  elseif bItem then
    nSelectType = item_type.Item
    nSelectIndex = 1
  end
  if nil ~= nParam then
    local mapItemCfg = ConfigTable.GetData_Item(nParam)
    if mapItemCfg ~= nil then
      if mapItemCfg.Stype == GameEnum.itemStype.FateCard then
        nSelectType = item_type.FateCard
        for k, v in ipairs(self.mapFateCard) do
          if v.nTid == nParam then
            nSelectIndex = k
            break
          end
        end
      else
        nSelectType = item_type.Item
        for k, v in ipairs(self.mapItem) do
          if v.nTid == nParam then
            nSelectIndex = k
            break
          end
        end
      end
    end
  end
  if nil ~= nSelectType then
    self:SelectItem(nSelectType, nSelectIndex)
  end
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.rtItemListContent)
  end
  
  cs_coroutine.start(wait)
end

function DepotItemListCtrl:RefreshFateCard(mapFateCard)
  self.mapFateCard = {}
  for nId, v in pairs(mapFateCard) do
    local nCount = math.max(v[1], v[2])
    nCount = nCount == -1 and 999 or nCount
    table.insert(self.mapFateCard, {
      nTid = nId,
      nCount = nCount,
      nSort = 0 < nCount and 1 or 0
    })
  end
  table.sort(self.mapFateCard, function(a, b)
    if a.nSort == b.nSort then
      if a.nCount == b.nCount then
        return a.nTid < b.nTid
      end
      return a.nCount < b.nCount
    end
    return a.nSort > b.nSort
  end)
  for _, v in ipairs(self.tbFateCardCtrl) do
    v.gameObject:SetActive(false)
  end
  for k, v in ipairs(self.mapFateCard) do
    local itemObj
    if nil == self.tbFateCardCtrl[k] then
      itemObj = instantiate(self._mapNode.goFateCardItem, self._mapNode.rtFateCard)
      itemObj.gameObject:SetActive(true)
      local itemCtrl = self:BindCtrlByNode(itemObj, "Game.UI.StarTower.Depot.DepotFateCardItemCtrl")
      itemCtrl:InitFateCard(v.nTid, v.nCount)
      table.insert(self.tbFateCardCtrl, itemCtrl)
    else
      itemObj = self.tbFateCardCtrl[k].gameObject
      itemObj:SetActive(true)
      self.tbFateCardCtrl[k]:InitFateCard(v.nTid, v.nCount)
    end
    local btnSelect = itemObj.transform:Find("btnItem"):GetComponent("UIButton")
    btnSelect.onClick:RemoveAllListeners()
    
    local function func_select()
      self:SelectItem(item_type.FateCard, k)
    end
    
    btnSelect.onClick:AddListener(func_select)
  end
end

function DepotItemListCtrl:RefreshItem(mapItem)
  self.mapItem = {}
  for nId, v in pairs(mapItem) do
    local itemCfg = ConfigTable.GetData_Item(nId)
    if itemCfg ~= nil and itemCfg.Stype ~= GameEnum.itemStype.SubNoteSkill then
      table.insert(self.mapItem, {nTid = nId, nCount = v})
    end
  end
  for _, v in ipairs(self.tbItemCtrl) do
    v.gameObject:SetActive(false)
  end
  for k, v in ipairs(self.mapItem) do
    local itemObj
    if nil == self.tbItemCtrl[k] then
      itemObj = instantiate(self._mapNode.goDepotItem, self._mapNode.rtItem)
      itemObj.gameObject:SetActive(true)
      local itemCtrl = self:BindCtrlByNode(itemObj, "Game.UI.TemplateEx.TemplateItemCtrl")
      itemCtrl:SetItem(v.nTid, nil, v.nCount, nil, nil, nil, nil, true)
      table.insert(self.tbItemCtrl, itemCtrl)
    else
      itemObj = self.tbItemCtrl[k].gameObject
      itemObj:SetActive(true)
      self.tbItemCtrl[k]:SetItem(v.nTid, nil, v.nCount, nil, nil, nil, nil, true)
    end
    local btnSelect = itemObj.transform:Find("btnItem"):GetComponent("UIButton")
    btnSelect.onClick:RemoveAllListeners()
    
    local function func_select()
      self:SelectItem(item_type.Item, k)
    end
    
    btnSelect.onClick:AddListener(func_select)
  end
end

function DepotItemListCtrl:SelectItem(nType, nIndex)
  self._mapNode.ItemInfo.gameObject:SetActive(false)
  self._mapNode.FateCardInfo.gameObject:SetActive(false)
  if nil ~= self.nSelectIndex then
    if self.nSelectType == item_type.FateCard then
      self.tbFateCardCtrl[self.nSelectIndex]:SetChoose(false)
    elseif self.nSelectType == item_type.Item then
      self.tbItemCtrl[self.nSelectIndex]:SetSelect(false)
    end
  end
  self.nSelectType = nType
  self.nSelectIndex = nIndex
  if self.nSelectType == item_type.FateCard then
    self._mapNode.FateCardInfo.gameObject:SetActive(true)
    self.tbFateCardCtrl[self.nSelectIndex]:SetChoose(true)
    self:SetFateCardInfo()
  elseif self.nSelectType == item_type.Item then
    self._mapNode.ItemInfo.gameObject:SetActive(true)
    self.tbItemCtrl[self.nSelectIndex]:SetSelect(true)
    self:SetItemInfo()
  end
end

function DepotItemListCtrl:SetItemInfo()
  local mapSelect = self.mapItem[self.nSelectIndex]
  local mapCfg = ConfigTable.GetData_Item(mapSelect.nTid)
  self._mapNode.goItemL:SetItem(mapSelect.nTid)
  NovaAPI.SetTMPText(self._mapNode.txtItemCount, mapSelect.nCount)
  if mapCfg ~= nil then
    NovaAPI.SetTMPText(self._mapNode.txtItemName, mapCfg.Title)
    NovaAPI.SetTMPText(self._mapNode.txtItemDesc, mapCfg.Desc)
  end
end

function DepotItemListCtrl:SetFateCardInfo()
  local mapSelect = self.mapFateCard[self.nSelectIndex]
  if nil ~= mapSelect then
    local itemCfg = ConfigTable.GetData_Item(mapSelect.nTid)
    local fateCardCfg = ConfigTable.GetData("FateCard", mapSelect.nTid)
    if nil == fateCardCfg then
      printError(string.format("获取FateCard表格配置失败！！！id = [%s]", mapSelect.nTid))
      return
    end
    NovaAPI.SetTMPText(self._mapNode.txtFateCardName, fateCardCfg.Name)
    local sDesc = UTILS.ParseParamDesc(fateCardCfg.Desc, fateCardCfg)
    NovaAPI.SetTMPText(self._mapNode.txtFateCardDesc, sDesc)
    self._mapNode.goFateCardInfo:InitFateCard(mapSelect.nTid, mapSelect.nCount)
    for _, v in ipairs(self._mapNode.imgEffect) do
      v.gameObject:SetActive(false)
    end
    if mapSelect.nCount <= 0 then
      self._mapNode.imgEffect[3].gameObject:SetActive(true)
    elseif mapSelect.nCount == 999 then
      self._mapNode.imgEffect[2].gameObject:SetActive(true)
    else
      self._mapNode.imgEffect[1].gameObject:SetActive(true)
      NovaAPI.SetTMPText(self._mapNode.txtEffectCount, orderedFormat(ConfigTable.GetUIText("StarTower_FateCard_Effect_Count_Value"), mapSelect.nCount))
    end
  end
end

function DepotItemListCtrl:Clear()
end

function DepotItemListCtrl:Awake()
  self.tbFateCardCtrl = {}
  self.tbItemCtrl = {}
  self.nSelectIndex = nil
  self.nSelectType = 0
  self._mapNode.goFateCardItem.gameObject:SetActive(false)
  self._mapNode.goDepotItem.gameObject:SetActive(false)
end

function DepotItemListCtrl:OnDestroy()
  for _, v in ipairs(self.tbFateCardCtrl) do
    self:UnbindCtrlByNode(v)
  end
  self.tbFateCardCtrl = {}
  for _, v in ipairs(self.tbItemCtrl) do
    self:UnbindCtrlByNode(v)
  end
  self.tbItemCtrl = {}
end

return DepotItemListCtrl

local MallRecommendItemCtrl = class("MallRecommendItemCtrl", BaseCtrl)
local dbResName = {
  [1] = "db_giftpack_1",
  [2] = "db_giftpack_2",
  [3] = "db_giftpack_3",
  [4] = "db_giftpack_4"
}
MallRecommendItemCtrl._mapNodeConfig = {
  go_Empty = {},
  go_Package = {},
  btn_Package = {
    sNodeName = "go_Package",
    sComponentName = "UIButton",
    callback = "OnBtnClick_Package"
  },
  bg = {sComponentName = "Image"},
  txt_title = {sComponentName = "TMP_Text"},
  icon = {sComponentName = "Image"},
  txt_name = {sComponentName = "TMP_Text"},
  svItem = {
    sComponentName = "LoopScrollView"
  },
  ItemList = {},
  item = {
    nCount = 2,
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl"
  },
  sale = {},
  txt_sale = {sComponentName = "TMP_Text"},
  txt_sale_1 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Mall_Package_Recommend"
  },
  txt_Time = {sComponentName = "TMP_Text"},
  itemPrice = {},
  icon_res = {sComponentName = "Image"},
  txt_itemPrice = {sComponentName = "TMP_Text"},
  price = {},
  txt_price = {sComponentName = "TMP_Text"},
  txt_Empty = {
    sComponentName = "TMP_Text",
    sLanguageId = "Mall_Recommend_Empty"
  }
}
MallRecommendItemCtrl._mapEventConfig = {}

function MallRecommendItemCtrl:OnEnable()
  self.tbGridCtrl = {}
end

function MallRecommendItemCtrl:OnDisable()
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  self.tbGridCtrl = {}
end

function MallRecommendItemCtrl:Refresh(groupConfig, sPackageId)
  if sPackageId == "" or groupConfig == nil then
    self._mapNode.go_Empty:SetActive(true)
    self._mapNode.go_Package:SetActive(false)
    return
  else
    self._mapNode.go_Empty:SetActive(false)
    self._mapNode.go_Package:SetActive(true)
  end
  self.sPackageId = sPackageId
  NovaAPI.SetTMPText(self._mapNode.txt_title, groupConfig.Name)
  local mapCfg = ConfigTable.GetData("MallPackage", sPackageId)
  if mapCfg == nil then
    return
  end
  self:SetPngSprite(self._mapNode.bg, "UI/big_sprites/" .. dbResName[mapCfg.Rarity])
  self:SetPngSprite(self._mapNode.icon, mapCfg.Icon)
  NovaAPI.SetTMPText(self._mapNode.txt_name, mapCfg.Name)
  self._mapNode.txt_sale_1.gameObject:SetActive(false)
  if mapCfg.SaleRate > 0 then
    self._mapNode.sale:SetActive(true)
    self._mapNode.txt_sale.gameObject:SetActive(true)
    NovaAPI.SetTMPText(self._mapNode.txt_sale, string.format("%s%%", mapCfg.SaleRate))
  elseif mapCfg.SaleRate == -1 then
    self._mapNode.sale:SetActive(true)
    self._mapNode.txt_sale_1.gameObject:SetActive(true)
    self._mapNode.txt_sale.gameObject:SetActive(false)
  else
    self._mapNode.sale:SetActive(false)
    self._mapNode.txt_sale.gameObject:SetActive(false)
  end
  local mapData = PlayerData.Mall:GetMallPackageData(sPackageId)
  self._mapNode.txt_Time.gameObject:SetActive(false)
  if mapData ~= nil then
    local bDisposable = mapCfg.RefreshType == GameEnum.mallPackageRefreshType.None
    local bTime = 0 < mapData.nNextRefreshTime and bDisposable
    if bTime then
      if 0 < mapData.nNextRefreshTime then
        local sPrefix
        local nRemaining = mapData.nNextRefreshTime - CS.ClientManager.Instance.serverTimeStamp
        if nRemaining <= 3600 then
          sPrefix = ConfigTable.GetUIText("Mall_Package_WithinHour")
        elseif 3600 < nRemaining and nRemaining <= 86400 then
          sPrefix = orderedFormat(ConfigTable.GetUIText("Mall_Package_Hour") or "", math.floor(nRemaining / 3600))
        elseif 86400 < nRemaining then
          sPrefix = orderedFormat(ConfigTable.GetUIText("Mall_Package_Day") or "", math.floor(nRemaining / 86400))
        end
        NovaAPI.SetTMPText(self._mapNode.txt_Time, sPrefix .. ConfigTable.GetUIText("Mall_Package_Delist"))
        self._mapNode.txt_Time.gameObject:SetActive(true)
      end
    else
      NovaAPI.SetTMPText(self._mapNode.txt_Time, ConfigTable.GetUIText("CharacterSkin_GotoBuy"))
      self._mapNode.txt_Time.gameObject:SetActive(true)
    end
  end
  local tbItem = decodeJson(mapCfg.Items)
  self.tbShow = {}
  for k, v in pairs(tbItem) do
    local nId = tonumber(k)
    table.insert(self.tbShow, {
      nId = nId,
      nCount = v,
      nRarity = ConfigTable.GetData_Item(nId).Rarity
    })
  end
  table.sort(self.tbShow, function(a, b)
    if a.nRarity ~= b.nRarity then
      return a.nRarity < b.nRarity
    else
      return a.nId < b.nId
    end
  end)
  if #self.tbShow >= 3 then
    self._mapNode.ItemList:SetActive(false)
    self._mapNode.svItem.gameObject:SetActive(true)
    self._mapNode.svItem:Init(#self.tbShow, self, self.OnGridRefresh, self.OnGridBtnClick)
  else
    self._mapNode.svItem.gameObject:SetActive(false)
    self._mapNode.ItemList:SetActive(true)
    for i = 1, 2 do
      if i <= #self.tbShow then
        self._mapNode.item[i].gameObject:SetActive(true)
        local itemCtrl = self._mapNode.item[i]
        itemCtrl:SetItem(self.tbShow[i].nId, self.tbShow[i].nRarity, self.tbShow[i].nCount)
        local btn = self._mapNode.item[i].gameObject.transform:Find("btnGrid"):GetComponent("UIButton")
        btn.onClick:RemoveAllListeners()
        btn.onClick:AddListener(function()
          UTILS.ClickItemGridWithTips(self.tbShow[i].nId, btn.transform, true, true, false)
        end)
      else
        self._mapNode.item[i].gameObject:SetActive(false)
      end
    end
  end
  if mapCfg.CurrencyType == GameEnum.currencyType.Cash then
    self._mapNode.itemPrice.gameObject:SetActive(false)
    self._mapNode.price.gameObject:SetActive(true)
    local result = string.gsub(mapCfg.CurrencyShowPrice, "%s+", "")
    NovaAPI.SetTMPText(self._mapNode.txt_price, tostring(result))
  elseif mapCfg.CurrencyType == GameEnum.currencyType.Item then
    self._mapNode.itemPrice.gameObject:SetActive(true)
    self._mapNode.price.gameObject:SetActive(false)
    self:SetPngSprite(self._mapNode.icon_res, ConfigTable.GetData_Item(mapCfg.CurrencyItemId).Icon2)
    NovaAPI.SetTMPText(self._mapNode.txt_itemPrice, tostring(mapCfg.CurrencyItemQty))
  end
end

function MallRecommendItemCtrl:OnGridRefresh(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local mapData = self.tbShow[nIndex]
  local nInstanceID = goGrid:GetInstanceID()
  if not self.tbGridCtrl[nInstanceID] then
    self.tbGridCtrl[nInstanceID] = self:BindCtrlByNode(goGrid, "Game.UI.TemplateEx.TemplateItemCtrl")
  end
  self.tbGridCtrl[nInstanceID]:SetItem(mapData.nId, mapData.nRarity, mapData.nCount)
end

function MallRecommendItemCtrl:OnGridBtnClick(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local itemId = self.tbShow[nIndex].nId
  UTILS.ClickItemGridWithTips(itemId, goGrid.transform:Find("btnGrid").transform, true, true, false)
end

function MallRecommendItemCtrl:OnBtnClick_Package(btn)
  local mapCfg = ConfigTable.GetData("MallPackage", self.sPackageId)
  if mapCfg == nil then
    return
  end
  local mapData = PlayerData.Mall:GetMallPackageData(self.sPackageId)
  if mapData == nil then
    return
  end
  if mapCfg.Tag == GameEnum.MallItemType.Furniture then
    EventManager.Hit(EventId.OpenPanel, PanelId.MallPopup, AllEnum.MallToggle.Furniture, mapData, {
      AllEnum.CoinItemId.Furniture
    })
  else
    EventManager.Hit(EventId.OpenPanel, PanelId.MallPopup, AllEnum.MallToggle.Package, mapData, {
      AllEnum.CoinItemId.FREESTONE
    })
  end
end

return MallRecommendItemCtrl

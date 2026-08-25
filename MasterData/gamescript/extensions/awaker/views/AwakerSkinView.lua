local AwakerSkinView, Super = NewViewComponent("AwakerSkinView")

function AwakerSkinView:ctor(uiNode, view, awakerTid, shopData, previewSkinTid, isMyAwaker)
  print("AwakerSkinView:ctor, uiNode=%s, view=%s, awakerTid=%s", uiNode, view, awakerTid)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Awaker_Popup_Whole_BodyResource(uiNode)
  self.awakerTid = awakerTid
  self.shopData = shopData
  self.shopItemTid = shopData and shopData.tid
  self.previewSkinTid = previewSkinTid
  self.isMyAwaker = isMyAwaker
  self.selectedSkinId = nil
  self:InitSkinList()
end

function AwakerSkinView:InitSkinList()
  if self.previewSkinTid then
    self.skinList = {
      cd.DefaultSkinTid,
      self.previewSkinTid
    }
    self.selectedSkinId = self.previewSkinTid
  elseif self.shopItemTid then
    self.skinList = {
      AwakerSkinUtils.GetSkinByShopItem(self.shopItemTid)
    }
    self.selectedSkinId = self.skinList[1]
  elseif self.isMyAwaker then
    self.skinList = AwakerSkinUtils.GetAwakerSkinListWithDefault(self.awakerTid)
    if AwakerDataUtils.HasOwnedAwaker(self.awakerTid) then
      self.selectedSkinId = AwakerSkinUtils.GetAwakerDressedSkin(self.awakerTid) or CommonDefine.DefaultSkinTid
    else
      self:SortSkinList()
      for i, skinId in ipairs(self.skinList) do
        if skinId ~= CommonDefine.DefaultSkinTid and AwakerSkinUtils.IsOwnSkin(skinId, self.awakerTid) then
          self.selectedSkinId = skinId
          break
        end
      end
      if not self.selectedSkinId then
        self.selectedSkinId = self.skinList[1]
      end
    end
  else
    self.skinList = AwakerSkinUtils.GetAwakerSkinListWithDefault(self.awakerTid)
    self.selectedSkinId = self.skinList[1]
  end
  self:SortSkinList()
  self:ClearNewSkinTag()
end

function AwakerSkinView:SortSkinList()
  local isCheckOwnedSkin = false
  if self.isMyAwaker then
    isCheckOwnedSkin = true
  end
  table.sort(self.skinList, function(a, b)
    if a == CommonDefine.DefaultSkinTid then
      return true
    end
    if b == CommonDefine.DefaultSkinTid then
      return false
    end
    if isCheckOwnedSkin then
      local isOwnedA = AwakerSkinUtils.IsOwnSkin(a, self.awakerTid)
      local isOwnedB = AwakerSkinUtils.IsOwnSkin(b, self.awakerTid)
      if isOwnedA ~= isOwnedB then
        return isOwnedA
      end
    end
    local skinCfgA = AwakerSkinUtils.GetSkinConfig(a)
    local skinCfgB = AwakerSkinUtils.GetSkinConfig(b)
    local qualityWeightA = AwakerSkinDefine.SkinQualityStarNum[skinCfgA.Quality]
    local qualityWeightB = AwakerSkinDefine.SkinQualityStarNum[skinCfgB.Quality]
    if qualityWeightA ~= qualityWeightB then
      return qualityWeightA < qualityWeightB
    end
    if skinCfgA.SortID ~= skinCfgB.SortID then
      return skinCfgA.SortID < skinCfgB.SortID
    end
    return a < b
  end)
end

function AwakerSkinView:OnBuildComponent()
  self:AddButtonClickListener(self.ui.Button_Dress, System.fn(self, self.OnClickDress))
  self:AddButtonClickListener(self.ui.Button_Buy, System.fn(self, self.OnClickBuy))
  self:AddButtonClickListener(self.ui.Button_GotoShop, System.fn(self, self.OnClickGotoShop))
  self:AddButtonClickListener(self.ui.Button_Left, System.fn(self, self.OnClickLeft))
  self:AddButtonClickListener(self.ui.Button_Right, System.fn(self, self.OnClickRight))
  self:SetText(self.ui.Text_Dress, "ChangeDress")
  self:SetText(self.ui.Text_GotoShop, "GoGetWord")
  self:SetText(self.ui.Text_Buy, "Shop_Buy_Btn")
  self:SetText(self.ui.Text_OffSell, "OffSell")
  self:SetText(self.ui.Text_OwnSkin, "Owned")
  self:SetText(self.ui.Text_Dressing, "DressingWord")
  self:SetText(self.ui.Text_UnGot, "UnGotStr")
end

function AwakerSkinView:RegisterNotifications()
  self:RegisterNotify(NotifyId.OnAwakerSkinClick, System.fn(self, self._OnSkinClicked))
  self:RegisterNotify(NotifyId.OnBagItemDataChanged, self.OnItemDataChanged, self)
end

function AwakerSkinView:RegisterEvents()
end

function AwakerSkinView:OnEnterComponent()
  self:RefreshView()
end

function AwakerSkinView:OnItemDataChanged()
  self:RefreshBtns()
end

function AwakerSkinView:RefreshView()
  self:RefreshSkinItemComps()
  self:RefreshSkinDesc()
  self:RefreshBtns()
end

function AwakerSkinView:OnClickLeft()
  local selectedIndex = self:GetSelectedIndex() - 1
  if selectedIndex < 1 then
    selectedIndex = #self.skinList
  end
  self.selectedSkinId = self.skinList[selectedIndex]
  self:RefreshSkinItemComps()
  self:Notify(NotifyId.OnAwakerSkinClick, self.selectedSkinId)
end

function AwakerSkinView:OnClickRight()
  local selectedIndex = self:GetSelectedIndex() + 1
  if selectedIndex > #self.skinList then
    selectedIndex = 1
  end
  self.selectedSkinId = self.skinList[selectedIndex]
  self:RefreshSkinItemComps()
  self:Notify(NotifyId.OnAwakerSkinClick, self.selectedSkinId)
end

function AwakerSkinView:GetSelectedIndex()
  for i, skinId in ipairs(self.skinList) do
    if skinId == self.selectedSkinId then
      return i
    end
  end
  return 1
end

function AwakerSkinView:RefreshSkinItemComps()
  local skinItemObjList = {
    self.ui.UI_Awaker_Item_Skin_1,
    self.ui.UI_Awaker_Item_Skin_2,
    self.ui.UI_Awaker_Item_Skin_3
  }
  local middleIndex = 2
  local selectedIndex = self:GetSelectedIndex()
  for i = 1, 3 do
    local gameObject = skinItemObjList[i]
    local deltaIndex = i - middleIndex
    local skinId = self.skinList[selectedIndex + deltaIndex]
    if skinId then
      self:SetActive(gameObject, true)
      self:AddViewComponentOnce(gameObject, AwakerSkinViewItem, self.awakerTid, skinId, self:IsBuyingSkinItem(), self.isMyAwaker)
    else
      self:SetActive(gameObject, false)
    end
  end
  self:SetActive(self.ui.Button_Left, #self.skinList > 2)
  self:SetActive(self.ui.Button_Right, #self.skinList > 2)
end

function AwakerSkinView:RefreshSkinDesc()
  if self.selectedSkinId == CommonDefine.DefaultSkinTid then
    self:SetText(self.ui.Text_Desc, "")
  else
    local itemTid = AwakerSkinUtils.GetItemTidBySkin(self.selectedSkinId)
    local itemCfg = itemTid and ItemDataUtils.GetItemConfig(itemTid)
    if itemCfg then
      self:SetText(self.ui.Text_Desc, itemCfg.Desc)
    else
      self:SetText(self.ui.Text_Desc, "")
    end
  end
  local height = StrUtils.SetPreferredHeight(self.ui.Text_Desc)
  local sizeDelta = self.ui.Content.transform.sizeDelta
  local Vector2 = CS.UnityEngine.Vector2(0, 0)
  Vector2.x = sizeDelta.x
  Vector2.y = height
  self.ui.Content.transform.sizeDelta = Vector2
end

function AwakerSkinView:RefreshBtns()
  local isBuying = self:IsBuyingSkinItem() and self.selectedSkinId ~= CommonDefine.DefaultSkinTid
  local isOwnSkin = AwakerSkinUtils.IsOwnSkin(self.selectedSkinId, self.awakerTid)
  local isOwnedAwaker = self:IsOwnedAwaker()
  local isDressing = AwakerSkinUtils.IsDressing(self.selectedSkinId, self.awakerTid)
  local isOffSell = AwakerSkinUtils.IsOffSell(self.selectedSkinId)
  local isSellInShop = AwakerSkinUtils.IsSellInShop(self.selectedSkinId)
  print(string.format("AwakerSkinView:RefreshBtns, isBuying=%s, isOwnSkin=%s, isOwnedAwaker=%s, isDressing=%s, isOffSell=%s", isBuying, isOwnSkin, isOwnedAwaker, isDressing, isOffSell))
  self:SetActive(self.ui.Button_Buy, isBuying and not isOwnSkin)
  self:SetActive(self.ui.Button_Dress, not isBuying and isOwnSkin and not isDressing and isOwnedAwaker)
  self:SetActive(self.ui.Button_GotoShop, not isBuying and not isOwnSkin and not isOffSell and isSellInShop)
  self:SetActive(self.ui.Button_OffSell, not isBuying and not isOwnSkin and isOffSell)
  self:SetActive(self.ui.Group_OwnSkin, isOwnSkin and (not isOwnedAwaker or isBuying))
  self:SetActive(self.ui.Group_Dressing, not isBuying and isDressing and isOwnedAwaker)
  if not isOwnSkin and not isSellInShop and not isBuying and not isOffSell then
    self:SetActive(self.ui.Button_UnGot, true)
  else
    self:SetActive(self.ui.Button_UnGot, false)
  end
end

function AwakerSkinView:IsBuyingSkinItem()
  return self.shopItemTid ~= nil
end

function AwakerSkinView:ClearNewSkinTag()
  if self:IsBuyingSkinItem() then
    return
  end
  if not self:IsOwnedAwaker() then
    return
  end
  if not AwakerSkinUtils.IsOwnSkin(self.selectedSkinId) then
    return
  end
  if self.selectedSkinId == CommonDefine.DefaultSkinTid then
    return
  end
  AwakerSkinUtils.ClearNewSkinTag(self.selectedSkinId)
end

function AwakerSkinView:IsOwnedAwaker()
  do return AwakerDataUtils.HasOwnedAwaker end
  return AwakerDataUtils.HasOwnedAwaker, self.awakerTid
end

function AwakerSkinView:_OnSkinClicked(skinId)
  Logger.Info("OnClickSkin, skinId=%s", skinId)
  self.selectedSkinId = skinId
  self:ClearNewSkinTag()
  self:RefreshView()
end

function AwakerSkinView:OnClickDress()
  local dressedSkinTid = AwakerSkinUtils.GetAwakerDressedSkin(self.awakerTid)
  if self.selectedSkinId == dressedSkinTid then
    print("---------OnClickDress, 已穿戴", self.selectedSkinId)
    return
  end
  local skinItemTid = AwakerSkinUtils.GetItemTidBySkin(self.selectedSkinId) or 0
  ProtoManager.Instance:ReqServer("GameRequest", "OnChangeSkin", function(errcode, data)
    Logger.Info("OnChangeSkin, data=%s, errcode=%s", table.tostring(data), table.tostring(errcode))
    self:RefreshView()
  end, function(errcode)
    Logger.Error("OnChangeSkin, errcode=%s", errcode)
  end, self.awakerTid, skinItemTid)
end

function AwakerSkinView:OnClickBuy()
  local costItemTid, costAmount = MainShopDataUtils.GetCfgCostItemAndAmount(self.shopData.tid)
  if costItemTid and not MainShopDataUtils.CheckPayMoneyEnough(costItemTid, costAmount, true) then
    return
  end
  MainShopDataUtils.AlertBuyItem(self.shopData.uid, 1, function(data)
    MainShopDataUtils.OnUpdateShopGoods(data)
  end, costItemTid, costAmount)
  local costData = {tid = costItemTid, num = costAmount}
  Alert.ShowCoin({costItemTid}, true, costData)
end

function AwakerSkinView:OnClickGotoShop()
  MainShopDataUtils.OnOpenShop(cd.MainShopTypeTag.ClothersShop)
end

function AwakerSkinView:OnExitView()
  Super.OnExitView(self)
end

return AwakerSkinView

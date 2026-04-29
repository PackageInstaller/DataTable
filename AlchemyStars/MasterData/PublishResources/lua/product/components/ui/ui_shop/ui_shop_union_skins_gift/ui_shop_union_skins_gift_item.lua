_class("ShopUnionSkinsGiftItem", Object)
ShopUnionSkinsGiftItem = ShopUnionSkinsGiftItem

function ShopUnionSkinsGiftItem:Constructor(skinData, giftData)
  self._skinData = skinData
  self._giftData = giftData
  self._id = 0
  self._order = 0
  if self._skinData ~= nil then
    self._id = self._skinData:GetId()
    local cfgv = Cfg.cfg_shop_common_goods[self._id]
    if cfgv ~= nil then
      self._order = cfgv.SequenceId
    end
  end
  if self._giftData ~= nil then
    self._id = self._giftData:GetId()
    local cfgv = Cfg.cfg_shop_giftmarket_goods[self._id]
    if cfgv ~= nil then
      self._order = cfgv.SequenceId
    end
  end
end

function ShopUnionSkinsGiftItem:GetId()
  return self._id
end

function ShopUnionSkinsGiftItem:GetOrder()
  return self._order
end

function ShopUnionSkinsGiftItem:IsResident()
  if self._skinData ~= nil then
    return self._skinData:IsResident()
  end
  if self._giftData ~= nil then
    return false
  end
  return false
end

function ShopUnionSkinsGiftItem:HasSoldOut()
  if self._skinData ~= nil then
    return self._skinData:HasSoldOut()
  end
  if self._giftData ~= nil then
    return false
  end
  return false
end

function ShopUnionSkinsGiftItem:GetTabID()
  if self._skinData ~= nil then
    return self._skinData:GetTabID()
  end
  if self._giftData ~= nil then
    local isShow, idTab = self._giftData:IsShowInSkinsTab()
    return idTab
  end
  return nil
end

function ShopUnionSkinsGiftItem:GetSkinData()
  return self._skinData
end

function ShopUnionSkinsGiftItem:GetGiftData()
  return self._giftData
end

function ShopUnionSkinsGiftItem:GetSkinID()
  if self._skinData then
    return self._skinData._skinId
  else
    if self._giftData then
      local awards = self._giftData:GetAwardsImmediately()
      if awards and next(awards) then
        for index, value in ipairs(awards) do
          local tmpid = value._templateId
          local idx = string.find(tostring(tmpid), "40")
          local isSkin = idx and idx == 1
          if isSkin then
            return tmpid - 4000000
          end
        end
      end
    end
    return nil
  end
end

function ShopUnionSkinsGiftItem:IsNew(newList)
  for key, value in pairs(newList) do
    if value == self:GetId() then
      return true
    end
  end
  return false
end

_class("UIShopUnionSkinsGiftItem", UICustomWidget)
UIShopUnionSkinsGiftItem = UIShopUnionSkinsGiftItem

function UIShopUnionSkinsGiftItem:Constructor()
  self._dataItem = nil
  self._uiSkinItem = nil
  self._uiGiftItem = nil
end

function UIShopUnionSkinsGiftItem:OnShow(uiParams)
  self._UIShopSkinsItem = self:GetUIComponent("UISelectObjectPath", "UIShopSkinsItem")
  self._UIShopGiftPackItem = self:GetUIComponent("UISelectObjectPath", "UIShopGiftPackItem")
  self.animation = self:GetGameObject():GetComponent("Animation")
end

function UIShopUnionSkinsGiftItem:OnHide()
end

function UIShopUnionSkinsGiftItem:Flush(dataItem, fnSkinFlush, fnGiftFlush)
  self._dataItem = dataItem
  local dataSkin = self._dataItem:GetSkinData()
  local dataGift = self._dataItem:GetGiftData()
  if self._uiSkinItem ~= nil then
    self._uiSkinItem:GetGameObject():SetActive(false)
  end
  if self._uiGiftItem ~= nil then
    self._uiGiftItem:GetGameObject():SetActive(false)
  end
  if dataSkin ~= nil and fnSkinFlush ~= nil then
    self._uiSkinItem = self._UIShopSkinsItem:SpawnObject("UIShopSkinsItem")
    self._uiSkinItem:GetGameObject().name = 0
    self._uiSkinItem:GetGameObject():SetActive(true)
    fnSkinFlush(self._uiSkinItem)
  end
  if dataGift ~= nil and fnGiftFlush ~= nil then
    self._uiGiftItem = self._UIShopGiftPackItem:SpawnObject("UIShopGiftPackItemContainer")
    self._uiGiftItem:GetGameObject().name = 0
    self._uiGiftItem:GetGameObject():SetActive(true)
    fnGiftFlush(self._uiGiftItem)
  end
end

function UIShopUnionSkinsGiftItem:JumpItem()
  if self._dataItem:GetSkinData() ~= nil and self:GetUISkinItem() ~= nil then
    self:GetUISkinItem():BgOnClick()
  end
  if self._dataItem:GetGiftData() ~= nil and self:GetUIGiftItem() ~= nil then
    self:GetUIGiftItem():OpenUIShopGiftPackDetail()
  end
end

function UIShopUnionSkinsGiftItem:GetDataItem()
  return self._dataItem
end

function UIShopUnionSkinsGiftItem:GetUISkinItem()
  return self._uiSkinItem
end

function UIShopUnionSkinsGiftItem:GetUIGiftItem()
  return self._uiGiftItem
end

function UIShopUnionSkinsGiftItem:PlayInAnimation()
  if self.animation.gameObject.activeInHierarchy then
    self.animation:Play("uieff_UIShopUnionSkinsGiftItem_In")
  end
  return 1040
end

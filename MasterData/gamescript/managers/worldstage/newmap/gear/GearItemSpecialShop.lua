local GearItemSpecialShop, Super = System.NewClass("GearItemSpecialShop", GearItemShop)

function GearItemSpecialShop:OnTriggerChild(svrData)
  Super.OnTriggerChild(self, svrData)
end

function GearItemSpecialShop:EnterShop(data, gearItemType)
  ShopDataUtils.OnShopData(data)
  local viewData = {
    shopUid = self:GetUid(),
    closeCb = function()
      self:AfterTrigger()
      self:ReqGearItemHandle(self:GetUid(), {closeWindow = true})
    end,
    mapNodeTid = self:GetTid()
  }
  UIManager.Instance:Show(Urls.CopySpecialShopView, viewData)
end

return GearItemSpecialShop

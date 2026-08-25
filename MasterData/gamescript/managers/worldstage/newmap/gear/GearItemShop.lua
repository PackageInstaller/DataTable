local GearItemShop, Super = System.NewClass("GearItemShop", GearItemBase)

function GearItemShop:OnTriggerChild(svrData)
  self:AudioPlay(self)
  self:EnterShop(svrData.data, svrData.type)
end

function GearItemShop:EnterShop(data, gearItemType)
  ShopDataUtils.OnShopData(data)
  local nodeTypeCfg = self:GetNodeTypeConfig()
  local shopName = nodeTypeCfg.Name
  UIManager.Instance:Show(Urls.WorldStageNewShopPanel, self:GetUid(), function()
    self:AfterTrigger()
    self:ReqGearItemHandle(self:GetUid(), {closeWindow = true})
  end, gearItemType, shopName)
end

function GearItemShop:AfterTrigger()
  Super.AfterTrigger(self)
end

return GearItemShop

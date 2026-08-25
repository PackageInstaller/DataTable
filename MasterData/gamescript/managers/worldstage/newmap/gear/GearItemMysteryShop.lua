local GearItemMysteryShop, Super = System.NewClass("GearItemMysterShop", GearItemBase)

function GearItemMysteryShop:OnTriggerChild(svrData)
  self:EnterShop(svrData.data)
end

function GearItemMysteryShop:EnterShop(data)
  ShopDataUtils.OnShopData(data)
  self:AfterTrigger()
end

function GearItemMysteryShop:AfterTrigger()
  Super.AfterTrigger(self)
  ProtoManager.Instance:ReqServer("WorldRequest", "OnGearClose", function(data)
  end, nil, self:GetUid())
end

return GearItemMysteryShop

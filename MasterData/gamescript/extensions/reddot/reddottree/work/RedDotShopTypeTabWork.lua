local RedDotShopTypeTabWork, Super = System.NewPoolClass("RedDotShopTypeTabWork", RedDotSingleFlow)

function RedDotShopTypeTabWork:ctor(shopTypeTid)
  Super.ctor(self, "商店类型Tab红点")
  self.shopTypeTid = shopTypeTid
end

function RedDotShopTypeTabWork:Execute()
  return RedDotDefine.OldRedAttrType2RedDotTypeDict[RedPointDataUtils.GetShopTypeRed(self.shopTypeTid)]
end

return RedDotShopTypeTabWork

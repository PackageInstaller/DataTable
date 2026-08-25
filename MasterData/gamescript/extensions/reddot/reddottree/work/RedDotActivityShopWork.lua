local RedDotActivityShopWork, Super = System.NewPoolClass("RedDotActivityShopWork", RedDotSingleFlow)

function RedDotActivityShopWork:ctor(activityTid)
  Super.ctor(self, "活动商店红点")
  self.activityTid = activityTid
end

function RedDotActivityShopWork:Execute()
  local shopTypeList = ShopExtModel.Instance:GetShopTypeListByActivityTid(self.activityTid)
  if not shopTypeList then
    return false
  end
  return RedDotDefine.OldRedAttrType2RedDotTypeDict[RedPointDataUtils.GetShopRedByShopTypes(shopTypeList)]
end

return RedDotActivityShopWork

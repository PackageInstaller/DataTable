local RedDotConversionRemainWork, Super = System.NewClass("RedDotConversionRemainWork", RedDotSingleFlow)

function RedDotConversionRemainWork:ctor(conversionIdList)
  Super.ctor(self, "炼金剩余次数红点")
  self.conversionIdList = conversionIdList
end

function RedDotConversionRemainWork:Execute()
  for _, conversionId in pairs(self.conversionIdList) do
    local itemTid
    if AlchemyCompositeExtModel.Instance.compositeItemList then
      for _, data in pairs(AlchemyCompositeExtModel.Instance.compositeItemList) do
        if data.conversionId == conversionId then
          itemTid = data.itemTid
          break
        end
      end
    end
    if itemTid and AlchemyCompositeExtModel.Instance:IsCompositeRemainShowRed(itemTid, conversionId) then
      return RedDotDefine.RedDotType.Red
    end
  end
  return nil
end

return RedDotConversionRemainWork

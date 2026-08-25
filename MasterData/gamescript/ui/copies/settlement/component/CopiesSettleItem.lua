local CopiesSettleItem, Super = System.NewComponent("CopiesSettleItem")

function CopiesSettleItem:ctor(res, configId, num, effectNum, awardType)
  Super.ctor(self)
  self.ui = Item_Approach_ListResource(res)
  self.configId = Vue.ref(configId)
  self.num = Vue.ref(num)
  self.effectNum = Vue.ref(effectNum)
  self.awardType = Vue.ref(awardType)
end

function CopiesSettleItem:OnBind(binder)
  self.binder = binder
  binder:BindToText(self.ui.Text_GetType, function()
    if self.awardType.value == CopiesData.ItemAwardType.First then
      return DT.TipConfig[1000].Text
    elseif self.awardType.value == CopiesData.ItemAwardType.Loot then
      do return LT.Text end
      return LT.Text, "CopiesAccount_05"
    elseif self.awardType.value == CopiesData.ItemAwardType.Extra then
      do return LT.Text end
      return LT.Text, "CopiesAccount_06"
    end
    return ""
  end)
  binder:BindToVisible(self.ui.Image_GetType, function()
    return self.awardType.value < CopiesData.ItemAwardType.Normal
  end)
  local numText = string.format("%d(+%d)", self.num.value, self.effectNum.value)
  if 0 == self.effectNum.value then
    numText = self.num.value
  end
  binder:BindComponent(ItemPublicArticle(self.ui.Item_Public_Article, self.configId.value, numText, false, true, true))
end

function CopiesSettleItem:Reset(configId, num, effectNum, awardType)
  self.configId.value = configId
  self.num.value = num
  self.effectNum.value = effectNum
  self.awardType.value = awardType
end

return CopiesSettleItem

_class("UIN17LotteryAwardBoxCell", UICustomWidget)
UIN17LotteryAwardBoxCell = UIN17LotteryAwardBoxCell

function UIN17LotteryAwardBoxCell:Constructor()
  self.listInited = false
  self.rowCellItemNum = 3
  self.rowCellCount = 0
end

function UIN17LotteryAwardBoxCell:OnShow(uiParams)
  self:_GetComponents()
end

function UIN17LotteryAwardBoxCell:_GetComponents()
  self._contentRect = self:GetUIComponent("RectTransform", "Content")
end

function UIN17LotteryAwardBoxCell:InitData(data, itemInfoCallBack, playJackpotAnim)
  self._data = data
  self._itemInfoCallback = itemInfoCallBack
  self._playJackpotAnim = playJackpotAnim
  self:_SetDynamicList()
end

function UIN17LotteryAwardBoxCell:_SetDynamicList()
  self._contentRect.anchoredPosition = Vector2(0, 0)
  self._infos = self._data.itemGroup
  if not self._dynamicListHelper then
    self._dynamicListHelper = UIActivityDynamicListHelper:New(self, self:GetUIComponent("UIDynamicScrollView", "AwardList"), "UIN17LotteryAwardRowCell", function(listItem, itemIndex)
      local delayTime = 0
      if self._playJackpotAnim then
        delayTime = itemIndex
      end
      listItem:InitData(self._data.itemGroup[itemIndex], self._itemInfoCallback, delayTime)
    end)
  end
  local itemCount = #self._infos
  local itemCountPerRow = 3
  self._dynamicListHelper:Refresh(itemCount, itemCountPerRow)
end

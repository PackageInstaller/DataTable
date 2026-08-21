_class("UIN37ExchangeCell", UICustomWidget)
UIN37ExchangeCell = UIN37ExchangeCell

function UIN37ExchangeCell:SetData(bigItemData, smallItemData, component, tipsCallback)
  self._bigItemData = bigItemData
  self._smallItemData = smallItemData
  self._component = component
  self._tipsCallback = tipsCallback
end

function UIN37ExchangeCell:SetShow(cellIdx)
  self:GetGameObject():SetActive(true)
  self._index = cellIdx
  local bigData, smallData = self:_GetCurData(cellIdx, self._bigItemData, self._smallItemData)
  self:_SetList(bigData, smallData)
end

function UIN37ExchangeCell:SetHide()
  self:GetGameObject():SetActive(false)
end

function UIN37ExchangeCell:_GetCurData(cellIdx, bigItemData, smallItemData)
  local totalCount = 8
  local startIdx = (cellIdx - 1) * totalCount + 1
  local big = {}
  local small = {}
  local count = 0
  local len_big = #bigItemData
  for i, v in ipairs(bigItemData) do
    if startIdx <= i * 2 and totalCount > count then
      table.insert(big, v)
      count = count + 2
    end
  end
  for i, v in ipairs(smallItemData) do
    if startIdx <= i + len_big * 2 and totalCount > count then
      table.insert(small, v)
      count = count + 1
    end
  end
  return big, small
end

function UIN37ExchangeCell:_SetList(bigItemData, smallItemData)
  local className = "UIN37ExchangeItem"
  local bigItems = UIWidgetHelper.SpawnObjects(self, "_bigItems", className, #bigItemData)
  local smallItems = UIWidgetHelper.SpawnObjects(self, "_smallItems", className, #smallItemData)
  local data = {}
  table.appendArray(data, bigItemData)
  table.appendArray(data, smallItemData)
  local objs = {}
  table.appendArray(objs, bigItems)
  table.appendArray(objs, smallItems)
  for i, v in ipairs(objs) do
    local smallIdx = i - #bigItems
    local isShowBg = 0 < smallIdx and smallIdx % 2 == 1
    v:SetData(i, data[i], self._component, self._tipsCallback, isShowBg)
  end
  self:_PlayAnim(bigItems, smallItems)
end

function UIN37ExchangeCell:_PlayAnim(bigItems, smallItems)
  local wait = 110
  local index = 0
  for _, v in ipairs(bigItems) do
    index = index + 1
    v:PlayAnimationInSequence(index, "Big", wait)
  end
  for _, v in ipairs(smallItems) do
    index = index + 0.5
    v:PlayAnimationInSequence(math.ceil(index), "Small", wait)
  end
end

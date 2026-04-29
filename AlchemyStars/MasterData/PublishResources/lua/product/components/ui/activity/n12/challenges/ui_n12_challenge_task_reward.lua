_class("UIN12ChallengeTaskReward", UIController)
UIN12ChallengeTaskReward = UIN12ChallengeTaskReward

function UIN12ChallengeTaskReward:Constructor()
  self._itemCountPerRow = 5
end

function UIN12ChallengeTaskReward:OnShow(uiParams)
  self._rewardList = uiParams[1] or {}
  self:_GetComponent()
  self:_OnValue()
end

function UIN12ChallengeTaskReward:_GetComponent()
  self._scrollView = self:GetUIComponent("UIDynamicScrollView", "ScrollView")
end

function UIN12ChallengeTaskReward:_OnValue()
  self:_InitScrollView()
end

function UIN12ChallengeTaskReward:_InitScrollView()
  self._scrollView:InitListView(self:_CalcTotalRow(), function(scrollView, index)
    return self:_InitListView(scrollView, index)
  end)
end

function UIN12ChallengeTaskReward:_InitListView(scrollView, index)
  local rowItem = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", rowItem.gameObject)
  local gridLayoutGroup = rowItem.gameObject:GetComponent("GridLayoutGroup")
  if rowItem.IsInitHandlerCalled == false then
    rowItem.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UIN12ChallengeTaskRewardItem", self._itemCountPerRow)
  end
  local rowList = rowPool:GetAllSpawnList()
  local padding = 0
  for i = 1, self._itemCountPerRow do
    local item = rowList[i]
    local itemIndex = index * self._itemCountPerRow + i
    if itemIndex > #self._rewardList then
      item:GetGameObject():SetActive(false)
      padding = padding + 1
    else
      item:GetGameObject():SetActive(true)
      item:SetData(self._rewardList[itemIndex])
    end
  end
  if 0 < padding then
    gridLayoutGroup.padding.left = (gridLayoutGroup.cellSize.x + gridLayoutGroup.spacing.x) / 2 * padding
  end
  return rowItem
end

function UIN12ChallengeTaskReward:_CalcTotalRow()
  local rowCount = #self._rewardList / self._itemCountPerRow
  local integral, fractional = math.modf(rowCount)
  if 0 < fractional then
    rowCount = integral + 1
  end
  return rowCount
end

function UIN12ChallengeTaskReward:ConfirmBtnOnClick(go)
  self:CloseDialog()
end

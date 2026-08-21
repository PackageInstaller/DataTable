_class("UiSortRowLayer", UICustomWidget)
UiSortRowLayer = UiSortRowLayer

function UiSortRowLayer:Constructor()
  self._rowSortBtnPos = {
    [1] = 0,
    [2] = 210,
    [3] = 338,
    [4] = 466
  }
end

function UiSortRowLayer:OnShow()
end

function UiSortRowLayer:SetBtnPos(index)
  return self._rowSortBtnPos[index]
end

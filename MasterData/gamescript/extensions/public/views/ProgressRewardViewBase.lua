local ProgressRewardViewBase, Super = NewClass("ProgressRewardViewBase", BaseView)
ProgressRewardViewBase.uiResCls = UI_Chaper_Popup_Award_OptimizedResource
local TYPEOF_RectTransform = typeof(CS.UnityEngine.RectTransform)

function ProgressRewardViewBase:ctor()
  Super.ctor(self)
  self.rewardList = {}
end

function ProgressRewardViewBase:OnBuildView()
end

function ProgressRewardViewBase:RegisterEvents()
  self:_CreateRewardTableView()
  self:AddButtonClickListener(self.ui.Btn_OneKey, System.fn(self, self._OnClickOneKey))
end

function ProgressRewardViewBase:OnEnterView()
  self:_RefreshView()
end

function ProgressRewardViewBase:_RefreshView()
  self:SetBgComp()
  self:_RefreshRewardList(true)
end

function ProgressRewardViewBase:SetBgComp()
  local commonPopupConfirmTipsData = {
    sizeType = CommonDefine.PopupTipsType.L,
    clickFunc = System.fn(self, self._OnClickClose)
  }
  self:AddViewComponentOnce(self.ui.UI_Common_Popup_Tips_L, CompPublicPopupTips, commonPopupConfirmTipsData)
end

function ProgressRewardViewBase:_CreateRewardTableView()
  local cellRT = self.ui.UI_Dungeous_Item_Popup_Award:GetComponent(TYPEOF_RectTransform)
  local width, height = cellRT.sizeDelta.x, cellRT.sizeDelta.y
  self.progressRewardTableView = self:CreateTableview(self.ui.ScrollView_Popup_Award, function()
    if not self.progressDataList then
      return 0
    end
    return #self.progressDataList
  end, function(view, index)
    do return self._ProgressCellAtIndex, self, view end
    return self._ProgressCellAtIndex, self, view, index
  end, function()
    return width, height
  end)
end

function ProgressRewardViewBase:_GetProgressDataList()
end

function ProgressRewardViewBase:_RefreshRewardList(needReload)
  if IsNil(self.progressRewardTableView) then
    return
  end
  if needReload then
    self.progressDataList = self:_GetProgressDataList()
    self:_SortRewardList()
    self.progressRewardTableView:ReloadData()
  else
    self:_SortRewardList()
    self.progressRewardTableView:Refresh()
  end
  self:SetActive(self.ui.Btn_OneKey, self:IsHaveChildOneKeyFunc())
  local isCanOneKey = self:IsHaveReward() and self:IsHaveChildOneKeyFunc()
  self:SetButtonState(self.ui.Btn_OneKey, isCanOneKey and CommonDefine.BtnType.High or CommonDefine.BtnType.Unclickable)
end

function ProgressRewardViewBase:IsHaveReward()
  local progressDataList = self.progressDataList
  for _, progressData in ipairs(progressDataList) do
    if not progressData.isGet and progressData.isAttach then
      return true
    end
  end
end

function ProgressRewardViewBase:MarkRewardGet()
  local progressDataList = self.progressDataList
  for _, progressData in ipairs(progressDataList) do
    if not progressData.isGet and progressData.isAttach then
      progressData.isGet = true
    end
  end
end

function ProgressRewardViewBase:_OnClickOneKey()
  if not self:IsHaveReward() then
    return
  end
  if not self:IsHaveChildOneKeyFunc() then
    return
  end
  EventMgr.Instance.OpenReqMask:Dispatch()
  self:ReqOneKeyReward(function()
    EventMgr.Instance.CloseReqMask:Dispatch()
    self:MarkRewardGet()
    self:_RefreshRewardList()
  end)
end

function ProgressRewardViewBase:IsHaveChildOneKeyFunc()
  return self.ReqOneKeyReward ~= ProgressRewardViewBase.ReqOneKeyReward
end

function ProgressRewardViewBase:ReqOneKeyReward(callback)
end

function ProgressRewardViewBase:_SortRewardList()
  table.sort(self.progressDataList, function(a, b)
    local aNeedStar = a.needStar
    local bNeedStar = b.needStar
    local aIsGet = a.isGet and 1 or 0
    local bIsGet = b.isGet and 1 or 0
    if aIsGet == bIsGet then
      return aNeedStar < bNeedStar
    end
    return aIsGet < bIsGet
  end)
end

function ProgressRewardViewBase:_ProgressCellAtIndex(view, index)
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(self.ui.UI_Dungeous_Item_Popup_Award)
  local progressData = self.progressDataList[index]
  self:AddViewComponentOnce(cell.gameObject, CompPublicProgressRewardItem, progressData)
  return cell
end

function ProgressRewardViewBase:_OnClickClose()
  self:Close()
end

function ProgressRewardViewBase:OnExitView()
  Super.OnExitView(self)
end

return ProgressRewardViewBase

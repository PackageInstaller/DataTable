local BackTrackAwardPreviewView, Super = NewClass("BackTrackAwardPreviewView", BaseView)
BackTrackAwardPreviewView.uiResCls = UI_Awaker_Popup_Preview_TipResource
local T_ScrollRect = typeof(CS.UnityEngine.UI.ScrollRect)
local T_HorizontalLayoutGroup = typeof(CS.UnityEngine.UI.HorizontalLayoutGroup)

function BackTrackAwardPreviewView:ctor(itemList)
  Super.ctor(self)
  self._itemList = itemList
  self._awardTableView = nil
end

function BackTrackAwardPreviewView:RegisterEvents()
  self:AddButtonClickListener(self.ui.UI_Common_Btn_Back1, System.fn(self, self.Close))
end

function BackTrackAwardPreviewView:OnEnterView()
  Super.OnEnterView(self)
  self:_BuildAwardListView()
  self:_RefreshLayout()
end

function BackTrackAwardPreviewView:OnExitView()
  Super.OnExitView(self)
end

function BackTrackAwardPreviewView:_BuildAwardListView()
  local prefab = self.ui.UI_Common_Item_WuPin_Type2
  local cellW, cellH = prefab.transform.sizeDelta.x, prefab.transform.sizeDelta.y
  self._awardCellPrefab = prefab
  self._awardTableView = self:CreateTableview(self.ui.ScrollView, function()
    return #(self._itemList or {})
  end, function(view, idx)
    do return self._OnAwardCellAtIndex, self, view end
    return self._OnAwardCellAtIndex, self, view, idx
  end, function()
    return cellW, cellH
  end)
  self._awardTableView:ReloadData()
end

function BackTrackAwardPreviewView:_OnAwardCellAtIndex(view, idx)
  local itemData = self._itemList[idx]
  if not itemData then
    return nil
  end
  local cell = self:DequeueCell(view, self._awardCellPrefab)
  self:AddViewComponentOnce(cell.gameObject, CompPublicIconItemType2, itemData)
  return cell
end

function BackTrackAwardPreviewView:_RefreshLayout()
  local content = self.ui.ScrollView:GetComponent(T_ScrollRect).content
  local groupCom = content:GetComponent(T_HorizontalLayoutGroup)
  if groupCom then
    if #(self._itemList or {}) < 5 then
      self:BindTimer(0.01, 0, nil, function()
        content.sizeDelta = CS.UnityEngine.Vector2(860, content.sizeDelta.y)
      end)
      groupCom.enabled = true
    else
      groupCom.enabled = false
    end
  end
end

return BackTrackAwardPreviewView

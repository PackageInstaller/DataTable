local EmojGroupComp, Super = NewViewComponent("EmojGroupComp")
EmojGroupComp.uiResCls = UI_Bag_Item_EmojGroupResource

function EmojGroupComp:ctor(uiNode, view)
  Super.ctor(self, uiNode, view)
  self.ui = self.uiResCls(uiNode)
  self._emojList = nil
  self._tabIndex = nil
  self._prefab = nil
  self._nowId = nil
  self._interactable = nil
  self._outerScrollRect = nil
end

function EmojGroupComp:OnEnterComponent()
  self:_CreateItemTableview()
end

function EmojGroupComp:OnExitComponent()
  self._emojList = nil
  Super.OnExitComponent(self)
end

function EmojGroupComp:Refresh(groupId, emojList, tabIndex, prefab, nowId, interactable, outerScrollRect)
  local commonIdCfg = DT.CommonID[groupId]
  self:SetText(self.ui.Text_EmojiType, LT.Text(commonIdCfg and commonIdCfg.Desc or ""))
  self._emojList = emojList
  self._tabIndex = tabIndex
  self._prefab = prefab
  self._nowId = nowId
  self._interactable = interactable
  self._outerScrollRect = outerScrollRect
  if self._itemTableView then
    self._itemTableView:ReloadData()
  end
  self.ui.Emoji_GroupList.transform.sizeDelta = CS.UnityEngine.Vector2(self.ui.Emoji_GroupList.transform.sizeDelta.x, self._prefab.transform.sizeDelta.y * math.ceil((self._emojList and #self._emojList or 0) / 6))
end

function EmojGroupComp:_CreateItemTableview()
  self._itemTableView = self.view:CreateTableview(self.ui.Emoji_GroupList, function()
    return self._emojList and #self._emojList or 0
  end, function(view, idx)
    local cell = self.view:DequeueCell(view, self._prefab)
    self:RemoveViewComponentOnce(cell.gameObject, AppearanceItemComp)
    self:AddViewComponent(cell.gameObject, AppearanceItemComp, self._emojList[idx], {
      tabIndex = self._tabIndex
    }, self._nowId, self._interactable, self._outerScrollRect)
    return cell
  end, function()
    local rt = self._prefab.transform
    return rt.sizeDelta.x, rt.sizeDelta.y
  end)
end

return EmojGroupComp

local GuideNotePermTrainingView, Super = NewClass("GuideNotePermTrainingView", BaseView)
GuideNotePermTrainingView.uiResCls = "UI/UI_GuideNote/UI_GuideNote_Prefab/UI_GuideNote_Panel_PermTrain.prefab"
local PERM_TRAIN_ITEM_CLASSES = {
  GuideNotePermTrainingItemPvp,
  GuideNotePermTrainingItemRotationMode,
  GuideNotePermTrainingItemAbyss,
  GuideNotePermTrainingItemDailyChallenge,
  GuideNotePermTrainingItemRailyWay
}

function GuideNotePermTrainingView:ctor()
  Super.ctor(self)
end

function GuideNotePermTrainingView:OnBuildView()
  Super.OnBuildView(self)
  for _, cls in ipairs(PERM_TRAIN_ITEM_CLASSES) do
    self:AddViewComponentOnce(self.root, cls)
  end
end

function GuideNotePermTrainingView:RegisterEvents()
  Super.RegisterEvents(self)
  self:BindEvent(EventMgr.Instance.CloseUIPanel, System.fn(self, self._OnPanelClosed))
end

function GuideNotePermTrainingView:OnEnterView()
  Super.OnEnterView(self)
  self:_RequestRankInfoBatch()
  self:_SortPermTrainingItems()
end

function GuideNotePermTrainingView:RefreshOnRendered()
  for _, cls in ipairs(PERM_TRAIN_ITEM_CLASSES) do
    local comp = self:GetViewComponent(self.root, cls)
    if comp then
      comp:OnEnterComponent()
    end
  end
  self:_RequestRankInfoBatch()
  self:_SortPermTrainingItems()
end

function GuideNotePermTrainingView:_RequestRankInfoBatch()
  GuideNotePermTrainingRankUi.RequestRankInfoBatch()
end

function GuideNotePermTrainingView:OnExitView()
  Super.OnExitView(self)
end

function GuideNotePermTrainingView:_OnPanelClosed()
  for _, cls in ipairs(PERM_TRAIN_ITEM_CLASSES) do
    local comp = self:GetViewComponent(self.root, cls)
    if comp and comp.Refresh then
      comp:Refresh()
    end
  end
  self:_SortPermTrainingItems()
end

function GuideNotePermTrainingView:_RefreshView(callerItem)
  if callerItem and callerItem.Refresh then
    callerItem:Refresh()
  end
end

function GuideNotePermTrainingView:_SortPermTrainingItems()
  if not self.root then
    return
  end
  local sortList = {}
  for _, cls in ipairs(PERM_TRAIN_ITEM_CLASSES) do
    local comp = self:GetViewComponent(self.root, cls)
    if comp then
      local entry = comp:GetSortEntry()
      if entry and entry.tf then
        table.insert(sortList, entry)
      end
    end
  end
  table.sort(sortList, function(a, b)
    if a.left == b.left then
      return a.sortKey < b.sortKey
    end
    return a.left < b.left
  end)
  for index, entry in ipairs(sortList) do
    entry.tf:SetSiblingIndex(index - 1)
  end
end

return GuideNotePermTrainingView

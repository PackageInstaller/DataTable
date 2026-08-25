local UICompCopyBattleStatisticBattleList, Super = NewViewComponent("UICompCopyBattleStatisticBattleList")
local BattleCellTag = {Awaker = 1, Single = 2}

function UICompCopyBattleStatisticBattleList:ctor(uiNode, view, viewModel)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Dungeons_Panel_CopyStatisticsResource(uiNode)
  self._viewModel = viewModel
  self._tableView = nil
  self._rowList = {}
end

function UICompCopyBattleStatisticBattleList:OnEnterComponent()
  self:_CreateTableView()
  self:Refresh()
end

function UICompCopyBattleStatisticBattleList:Refresh()
  self._rowList = self._viewModel:GetBattleRows()
  if self._tableView then
    self._tableView:ReloadData()
  end
end

function UICompCopyBattleStatisticBattleList:_CreateTableView()
  local owner = self.ui.BattleStatisticsView
  if not owner then
    Logger.Error("UICompCopyBattleStatisticBattleList: missing BattleStatisticsView ScrollRect.")
    return
  end
  local templateGo = self.ui.UI_Dungeous_Item_BattleStatistics
  if not templateGo then
    Logger.Error("UICompCopyBattleStatisticBattleList: missing UI_Dungeous_Item_BattleStatistics template.")
    return
  end
  local cellRT = templateGo.transform
  local width, height = cellRT.sizeDelta.x, cellRT.sizeDelta.y
  self._tableView = self:CreateTableview(owner, function()
    return self._rowList and #self._rowList or 0
  end, System.fn(self, self._CellAtIndex), function()
    return width, height
  end)
end

function UICompCopyBattleStatisticBattleList:_CellAtIndex(view, index)
  local row = self._rowList and self._rowList[index]
  local isSingleSkill = row and 0 ~= self._viewModel.selectedOwnerId and not row._isSingleSummary
  local template = isSingleSkill and self.ui.UI_Dungeous_Item_StatisticsSingle or self.ui.UI_Dungeous_Item_BattleStatistics
  local tag = isSingleSkill and BattleCellTag.Single or BattleCellTag.Awaker
  local cell = self.view:DequeueCellByTag(view, tag, template)
  if row then
    if isSingleSkill then
      local parentOwnerRow = self._viewModel:GetSelectedOwnerRow()
      self:AddViewComponentOnce(cell.gameObject, UICompCopyBattleStatisticSingleItem, row, self._viewModel._mo, parentOwnerRow)
    else
      self:AddViewComponentOnce(cell.gameObject, UICompCopyBattleStatisticAwakerItem, row, self._viewModel._mo)
    end
  end
  return cell
end

return UICompCopyBattleStatisticBattleList

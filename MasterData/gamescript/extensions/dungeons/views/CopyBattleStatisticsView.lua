local CopyBattleStatisticsView, Super = NewClass("CopyBattleStatisticsView", BaseView)
CopyBattleStatisticsView.uiResCls = UI_Dungeons_Panel_CopyStatisticsResource
local TabIndex = CopyBattleStatisticViewModel.TabIndex
local SortDim = CopyBattleStatisticViewModel.SortDim
local SortDir = CopyBattleStatisticViewModel.SortDir

function CopyBattleStatisticsView:ctor(mo)
  Super.ctor(self)
  self._mo = mo or DungeonStatisticMO()
  self._viewModel = CopyBattleStatisticViewModel(self._mo)
  self._filterBar = nil
  self._battleList = nil
  self._roundList = nil
  self._teamHeaderComp = nil
end

function CopyBattleStatisticsView:OnBuildView()
  Super.OnBuildView(self)
end

function CopyBattleStatisticsView:OnEnterView()
  self._viewModel.selectedOwnerId = 0
  self:_EnsureSubComponents()
  self:_ApplySelectedOwnerVisual()
  self:_SetTab(TabIndex.Battle)
  self:_RefreshSortButtons()
end

function CopyBattleStatisticsView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Close, System.fn(self, self.Close))
  self:AddZ1ToggleValueChangedListener(self.ui.Tab_BattleStatistics, System.fn(self, self._OnBattleTabChanged))
  self:AddZ1ToggleValueChangedListener(self.ui.Tab_RoundStatistics, System.fn(self, self._OnRoundTabChanged))
  self:AddZ1ToggleValueChangedListener(self.ui.Btn_Sort_Damage, System.fn(self, self._OnClickSortDamage))
  self:AddZ1ToggleValueChangedListener(self.ui.Btn_Sort_Shield, System.fn(self, self._OnClickSortShield))
  self:AddZ1ToggleValueChangedListener(self.ui.Btn_Sort_Heal, System.fn(self, self._OnClickSortHeal))
  self:_EnsureSubComponents()
end

function CopyBattleStatisticsView:_EnsureSubComponents()
  if not self._filterBar then
    self._filterBar = self:AddViewComponentOnce(self.ui.uiNode, UICompCopyBattleStatisticFilterBar, self._viewModel, System.fn(self, self._OnFilterChanged))
  end
  if not self._battleList then
    self._battleList = self:AddViewComponentOnce(self.ui.uiNode, UICompCopyBattleStatisticBattleList, self._viewModel)
  end
  if not self._roundList then
    self._roundList = self:AddViewComponentOnce(self.ui.uiNode, UICompCopyBattleStatisticRoundList, self._viewModel)
  end
end

function CopyBattleStatisticsView:_OnBattleTabChanged(isOn)
  if isOn then
    self:_SetTab(TabIndex.Battle)
  end
end

function CopyBattleStatisticsView:_OnRoundTabChanged(isOn)
  if isOn then
    self:_SetTab(TabIndex.Round)
  end
end

function CopyBattleStatisticsView:_SetTab(idx)
  self._viewModel:SetTab(idx)
  self:SetZ1Toggle(self.ui.Tab_BattleStatistics, self._viewModel.tabIndex == TabIndex.Battle, true)
  self:SetZ1Toggle(self.ui.Tab_RoundStatistics, self._viewModel.tabIndex == TabIndex.Round, true)
  self:SetActive(self.ui.Group_BattleStatistics, self._viewModel.tabIndex == TabIndex.Battle)
  self:SetActive(self.ui.Group_RoundStatistics, self._viewModel.tabIndex == TabIndex.Round)
  if self._filterBar then
    self._filterBar:HideAllDropdowns()
  end
  self:_RefreshAll()
end

function CopyBattleStatisticsView:_SetSelectedOwnerId(ownerId)
  self._viewModel:SetSelectedOwnerId(ownerId)
  self:_ApplySelectedOwnerVisual()
  self:_RefreshLists()
  self:_RefreshTeamHeader()
end

function CopyBattleStatisticsView:_ApplySelectedOwnerVisual()
  if self._teamHeaderComp then
    self._teamHeaderComp:SyncBySelectedOwnerId(self._viewModel.selectedOwnerId)
  elseif self.ui.Tab_AllAwaker then
    self:SetZ1Toggle(self.ui.Tab_AllAwaker, 0 == self._viewModel.selectedOwnerId, true)
  end
end

function CopyBattleStatisticsView:_OnTeamHeaderSelectOwnerId(ownerId)
  self:_SetSelectedOwnerId(ownerId)
end

function CopyBattleStatisticsView:_OnClickSort(dim)
  self._viewModel:ToggleSort(dim)
  self:_RefreshSortButtons()
  self:_RefreshBattleList()
  self:_RefreshTeamHeader()
end

function CopyBattleStatisticsView:_OnClickSortDamage()
  self:_OnClickSort(SortDim.Damage)
end

function CopyBattleStatisticsView:_OnClickSortShield()
  self:_OnClickSort(SortDim.Shield)
end

function CopyBattleStatisticsView:_OnClickSortHeal()
  self:_OnClickSort(SortDim.Heal)
end

function CopyBattleStatisticsView:_RefreshSortButtons()
  self:_RefreshSortButton(self.ui.Btn_Sort_Damage, SortDim.Damage)
  self:_RefreshSortButton(self.ui.Btn_Sort_Shield, SortDim.Shield)
  self:_RefreshSortButton(self.ui.Btn_Sort_Heal, SortDim.Heal)
end

function CopyBattleStatisticsView:_RefreshSortButton(btnGo, dim)
  if not btnGo then
    return
  end
  if self._viewModel.sortDim == dim and self._viewModel.sortDir == SortDir.Desc then
    self:_SetSortButtonZ1ToggleState(btnGo, true, true)
  elseif self._viewModel.sortDim == dim and self._viewModel.sortDir == SortDir.Asc then
    self:_SetSortButtonZ1ToggleState(btnGo, false, true)
  else
    self:_SetSortButtonZ1ToggleState(btnGo, false, false)
  end
end

function CopyBattleStatisticsView:_SetSortButtonZ1ToggleState(btnGo, isOn, isUnlocked)
  self:SetZ1Toggle(btnGo, isOn, true)
  self:SetZ1ToggleUnlock(btnGo, isUnlocked)
end

function CopyBattleStatisticsView:_OnFilterChanged()
  self:_RefreshAll()
end

function CopyBattleStatisticsView:_RefreshAll()
  if self._filterBar then
    self._filterBar:Refresh()
  end
  self._viewModel:RebuildFocusOwnerList()
  self:_RefreshLists()
  self:_RefreshTeamHeader()
end

function CopyBattleStatisticsView:_RefreshLists()
  self:_RefreshBattleList()
  self:_RefreshRoundList()
end

function CopyBattleStatisticsView:_RefreshBattleList()
  if self._battleList then
    self._battleList:Refresh()
  end
end

function CopyBattleStatisticsView:_RefreshRoundList()
  if self._roundList then
    self._roundList:Refresh()
  end
end

function CopyBattleStatisticsView:_RefreshTeamHeader()
  local roundOwnerColorMap = self._roundList and self._roundList:GetRoundIndicatorColorMap() or {}
  if not self._teamHeaderComp then
    self._teamHeaderComp = self:AddViewComponentOnce(self.ui.uiNode, UICompCopyBattleStatisticTeamHeader, self._viewModel.focusOwnerList, self._viewModel.selectedOwnerId, System.fn(self, self._OnTeamHeaderSelectOwnerId), self._viewModel.tabIndex == TabIndex.Round, roundOwnerColorMap)
    return
  end
  self._teamHeaderComp:Refresh(self._viewModel.focusOwnerList, self._viewModel.selectedOwnerId, self._viewModel.tabIndex == TabIndex.Round, roundOwnerColorMap)
end

return CopyBattleStatisticsView

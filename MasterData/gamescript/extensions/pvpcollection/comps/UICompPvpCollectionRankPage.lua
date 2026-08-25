local PvpCollectionRankType = RankDefine.RankType
local UICompPvpCollectionRankPage, Super = NewViewComponent("UICompPvpCollectionRankPage")
RankPaginationMixin.Inject(UICompPvpCollectionRankPage)

function UICompPvpCollectionRankPage:ctor(uiNode, view)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Pvp_Panel_Collection_RankResource(uiNode)
  self:InitRankPagination()
  self:_InitViewData()
end

function UICompPvpCollectionRankPage:OnBuildComponent()
  self:_CreateTableView()
end

function UICompPvpCollectionRankPage:OnEnterComponent()
  self:_RefreshRankData()
  self:SetZ1Toggle(self.ui.Btn_TotalWins, true)
end

function UICompPvpCollectionRankPage:RegisterEvents()
  self:AddZ1ToggleValueChangedListener(self.ui.Btn_TotalWins, System.fn(self, self._OnToggleTotalWins))
  self:AddZ1ToggleValueChangedListener(self.ui.Btn_SeasonWins, System.fn(self, self._OnToggleSeasonWins))
  self:BindEvent(EventMgr.Instance.PvpCollectionSelect, System.fn(self, self._OnPvpCollectionSelect))
  self:BindEvent(EventMgr.Instance.PvpCollectionPageChanged, System.fn(self, self._OnPvpCollectionPageChanged))
end

function UICompPvpCollectionRankPage:_OnPvpCollectionPageChanged(page)
  if page == CommonDefine.PVPCollectionDetailTab.Rank then
    self:_RefreshRankData()
  end
end

function UICompPvpCollectionRankPage:_OnPvpCollectionSelect()
  self:_RefreshRankData()
end

function UICompPvpCollectionRankPage:_OnToggleTotalWins(isOn)
  if not isOn then
    return
  end
  self:_SetSelectRankType(PvpCollectionRankType.PVPCollect)
end

function UICompPvpCollectionRankPage:_OnToggleSeasonWins(isOn)
  if not isOn then
    return
  end
  self:_SetSelectRankType(PvpCollectionRankType.PVPCollectMonthly)
end

function UICompPvpCollectionRankPage:_InitViewData()
  self._selectRankType = RankDefine.RankType.PVPCollect
  self._rankUidList = {}
end

function UICompPvpCollectionRankPage:_UpdateRankUidList()
  local targetCollectionTid = PvpCollectionModel.Instance:GetSelectCollectionTid()
  self._rankUidList = RankModel.Instance:GetRankSequence(self._selectRankType, targetCollectionTid)
end

function UICompPvpCollectionRankPage:_RefreshRankData()
  if self._rankIsRequesting then
    return
  end
  self:_ClearRank()
  self:_ResetRankPagination()
  self:_CheckAndShowFirstLoadTip()
  self:_RequestRankPage()
  self:_ResetRankScroll(self._rankListView)
end

function UICompPvpCollectionRankPage:_SetSelectRankType(rankType)
  if rankType == self._selectRankType then
    return
  end
  self._selectRankType = rankType
  self:_UpdateRankUidList()
  self:_RefreshView()
  self:_ResetRankPagination()
  self:_RequestRankPage()
  self:_ResetRankScroll(self._rankListView)
end

function UICompPvpCollectionRankPage:_ClearRank()
  local collectionTid = PvpCollectionModel.Instance:GetSelectCollectionTid()
  RankModel.Instance:ClearRank(PvpCollectionRankType.PVPCollect, collectionTid)
  RankModel.Instance:ClearRank(PvpCollectionRankType.PVPCollectMonthly, collectionTid)
end

function UICompPvpCollectionRankPage:_DoRequestRankData(startIndex, count, onSuccess, onFail)
  local targetCollectionTid = PvpCollectionModel.Instance:GetSelectCollectionTid()
  local endIdx = startIndex + count - 1
  local targetTotalLength = RankModel.Instance:GetRankLength(self._selectRankType, targetCollectionTid)
  if targetTotalLength then
    endIdx = math.min(endIdx, targetTotalLength)
  end
  if startIndex > endIdx then
    onFail()
    return
  end
  PvpCollectionController.Instance:ReqCollectionRanks(self._selectRankType, targetCollectionTid, startIndex, endIdx, onSuccess, onFail)
end

function UICompPvpCollectionRankPage:_GetRankListCount()
  return #self._rankUidList
end

function UICompPvpCollectionRankPage:_OnRankPageSuccess()
  self:_UpdateRankUidList()
  self:_RefreshView()
end

function UICompPvpCollectionRankPage:_OnRankPageFail()
  self:_RefreshView()
end

function UICompPvpCollectionRankPage:_RefreshView()
  self:_RefreshCollectionName()
  self:_RefreshEmptyState()
  self:_RefreshMyRank()
  self:_RefreshRankList()
end

function UICompPvpCollectionRankPage:_RefreshRankList()
  self._rankListView:ReloadData()
end

function UICompPvpCollectionRankPage:_RefreshMyRank()
  local targetCollectionTid = PvpCollectionModel.Instance:GetSelectCollectionTid()
  local rankMO = RankModel.Instance:GetRankMO(self._selectRankType, targetCollectionTid, PlayerDataUtils.GetPlayerUid())
  local needShowMyRank = nil ~= rankMO and rankMO:GetRankIdx() and 0 ~= rankMO:GetRankIdx()
  self:SetActive(self.ui.Group_MyRank, needShowMyRank)
  if needShowMyRank then
    self:_FillRankItemCell(self.ui.MyRankItem, rankMO)
  end
end

function UICompPvpCollectionRankPage:_RefreshEmptyState()
  if self._rankIsRequesting then
    return
  end
  local isEmpty = not table.next(self._rankUidList)
  self:SetActive(self.ui.Group_Null_Black, isEmpty)
  if self.ui.Text_C_NoTask then
    self:SetText(self.ui.Text_C_NoTask, isEmpty and LT.Text("RankDataNull") or "")
  end
end

function UICompPvpCollectionRankPage:_RefreshCollectionName()
  local targetCollectionTid = PvpCollectionModel.Instance:GetSelectCollectionTid()
  self:SetText(self.ui.Text_Name_Role, LT.Text(PvpCollectCfgUtils.GetCollectionName(targetCollectionTid)))
end

function UICompPvpCollectionRankPage:_CheckAndShowFirstLoadTip()
  if self.ui.Group_Null_Black then
    self:SetActive(self.ui.Group_Null_Black, true)
  end
  if self.ui.Text_C_NoTask then
    self:SetText(self.ui.Text_C_NoTask, LT.Text("RankDataFirstLoadTip"))
  end
  if self.ui.Group_MyRank then
    self:SetActive(self.ui.Group_MyRank, false)
  end
end

function UICompPvpCollectionRankPage:_CreateTableView()
  local sizeDelta = self.ui.UI_Pvp_Item_Collection_Rank.transform.sizeDelta
  local w, h = sizeDelta.x, sizeDelta.y
  self._rankListView = self:CreateTableview(self.ui.ScrollView_Rank, function()
    return #self._rankUidList
  end, function(view, index)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(self.ui.UI_Pvp_Item_Collection_Rank)
    local uid = self._rankUidList[index]
    local targetCollectionTid = PvpCollectionModel.Instance:GetSelectCollectionTid()
    local rankMO = RankModel.Instance:GetRankMO(self._selectRankType, targetCollectionTid, uid)
    self:_FillRankItemCell(cell.gameObject, rankMO)
    return cell
  end, function()
    return w, h
  end)
  self:_SetupRankScroll(self._rankListView)
end

function UICompPvpCollectionRankPage:_FillRankItemCell(cellGO, rankMO)
  if not rankMO then
    return
  end
  local cellUI = UI_Pvp_Item_Collection_RankResource(cellGO)
  self:SetText(cellUI.Text_Rank, rankMO:GetRankIdx())
  self:SetText(cellUI.Text_Name, rankMO:GetPlayerName())
  self:SetText(cellUI.Text_Uid, rankMO:GetUid())
  self:SetText(cellUI.Text_WinCount, rankMO:GetWinCount())
  self:SetText(cellUI.Text_C_Uid, "UID:")
  self:AddViewComponentOnce(cellUI.UI_Common_Head, CompHeadItem, {
    headIcon = ItemDataUtils.GetAvatarIcon(rankMO:GetPlayerIcon()),
    frameIcon = ItemDataUtils.GetItemIcon(rankMO:GetPlayerFrame()),
    clickCb = function()
      SocialDataUtils.OpenPlayerInfoPanel(SocialDefine.PlayerInfoPage.Overview, rankMO:GetUid())
    end
  })
end

return UICompPvpCollectionRankPage

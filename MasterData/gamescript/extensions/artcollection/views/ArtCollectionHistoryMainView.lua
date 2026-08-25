local ArtCollectionHistoryMainView, Super = NewClass("ArtCollectionHistoryMainView", BaseView)
ArtCollectionHistoryMainView.uiResCls = UI_Collection_Panel_HistoryResource

function ArtCollectionHistoryMainView:ctor()
  Super.ctor(self)
end

function ArtCollectionHistoryMainView:OnBuildView()
  self:_CreateStoryTableView()
  self:_CreateHistoryDetailComp()
end

function ArtCollectionHistoryMainView:OnEnterView()
  self:_InitViewData()
  self:_RefreshView()
end

function ArtCollectionHistoryMainView:RegisterEvents()
  self:AddViewComponent(self.ui.UI_Common_Btn_Back3, UICompBtnCloseItem, System.fn(self, self._OnClickBtnBack))
end

function ArtCollectionHistoryMainView:_OnClickBtnBack()
  if self:_GetSelectHistoryTid() then
    self:_SetSelectHistoryTid(nil)
  else
    self:Close()
  end
end

function ArtCollectionHistoryMainView:_InitViewData()
  local storyCollectionTidList = ArtCollectionModel.Instance:GetStoryCollectionTidList()
  table.sort(storyCollectionTidList, function(a, b)
    local aBaseSortTid = CollectionHallCfgUtils.GetCfgField("BaseSortID", a)
    local bBaseSortTid = CollectionHallCfgUtils.GetCfgField("BaseSortID", b)
    return aBaseSortTid < bBaseSortTid
  end)
  self._storyCollectionTidList = storyCollectionTidList
  self._selectHistoryTid = nil
end

function ArtCollectionHistoryMainView:_SetSelectHistoryTid(tid)
  self._selectHistoryTid = tid
  self:_RefreshHistoryDetail()
  self:_RefreshHistoryTableView()
end

function ArtCollectionHistoryMainView:_GetSelectHistoryTid()
  return self._selectHistoryTid
end

function ArtCollectionHistoryMainView:_RefreshView()
  self:_RefreshHistoryDetail()
  self:_RefreshCollectProgress()
  self:_RefreshHistoryTableView()
end

function ArtCollectionHistoryMainView:_RefreshCollectProgress()
  self:AddViewComponentOnce(self.ui.Image_Mail, CollectionRewardCom, self:_GetRewardType(), function()
    do return ArtCollectionController.Instance.CollectCnt, ArtCollectionController.Instance, CommonDefine.FeatureId.CollectionStory end
    return ArtCollectionController.Instance.CollectCnt, ArtCollectionController.Instance, CommonDefine.FeatureId.CollectionStory, CommonDefine.WorldStorySubFeature.History
  end)
end

function ArtCollectionHistoryMainView:_GetRewardType()
  return ArtCollectionDefine.RewardType.None
end

function ArtCollectionHistoryMainView:_RefreshHistoryTableView()
  if self:_GetSelectHistoryTid() then
    self:SetActive(self.ui.HistoryView, false)
    return
  end
  self:SetActive(self.ui.HistoryView, true)
  self._historyTableView:ReloadData()
end

local childTag = {Down = 1, Up = 2}

function ArtCollectionHistoryMainView:_CreateStoryTableView()
  local sizeDelta = self.ui.Item_History_1.transform.sizeDelta
  local w, h = sizeDelta.x, sizeDelta.y
  self._historyTableView = self:CreateTableview(self.ui.HistoryView, function()
    return #self._storyCollectionTidList
  end, function(view, index)
    local cell
    if 1 == index % 2 then
      cell = self:DequeueCellByTag(view, childTag.Down, self.ui.Item_History_2)
    else
      cell = self:DequeueCellByTag(view, childTag.Up, self.ui.Item_History_1)
    end
    local targetCollectTid = self._storyCollectionTidList[index]
    local viewData = {
      collectTid = targetCollectTid,
      clickCb = function()
        self:_SetSelectHistoryTid(targetCollectTid)
      end
    }
    self:AddViewComponentOnce(cell.gameObject, CollectHistoryItem, viewData)
    return cell
  end, function()
    return w, h
  end)
end

function ArtCollectionHistoryMainView:_CreateHistoryDetailComp()
  local targetPrefab = self:LoadAsset(UI_Collection_History_DetailsResource.assetPath)
  local targetGo = GameObject.Instantiate(targetPrefab, self.ui.uiNode.transform)
  self._historyDetailComp = self:AddViewComponentOnce(targetGo, CollectHistryDetailCom)
end

function ArtCollectionHistoryMainView:_RefreshHistoryDetail()
  local selectHistoryTid = self:_GetSelectHistoryTid()
  if not selectHistoryTid then
    self._historyDetailComp:Hide()
    return
  end
  self._historyDetailComp:Show()
  self._historyDetailComp:UpdateViewData(selectHistoryTid)
  self._historyDetailComp:RefreshView()
end

function ArtCollectionHistoryMainView:RegisterNotifications()
end

return ArtCollectionHistoryMainView

local ArtCollectionOSTView, Super = NewClass("ArtCollectionOSTView", BaseView)
ArtCollectionOSTView.uiResCls = UI_Collection_Item_MusicResource

function ArtCollectionOSTView:ctor()
  Super.ctor(self)
  self.feature = CommonDefine.FeatureId.CollectionPicture
  self.ostDataList = {}
end

function ArtCollectionOSTView:OnBuildView()
  Super.OnBuildView(self)
  self:CreateTableView()
  self:InitCloseBtn()
end

function ArtCollectionOSTView:OnEnterView()
  Super.OnEnterView(self)
  self:UpdateOstList()
  self:_RefreshProgress()
  ArtCollectionRewardModel.Instance:UpdateTaskData()
end

function ArtCollectionOSTView:OnExitView()
  Super.OnExitView(self)
end

function ArtCollectionOSTView:InitCloseBtn()
  self.closeBtn = self:AddViewComponent(self.ui.UI_Common_Btn_Back3, UICompBtnCloseItem, System.fn(self, self.Close))
end

function ArtCollectionOSTView:CreateTableView()
  local sizeDelta = self.ui.UI_Collection_Panel_Music.transform.sizeDelta
  local w, h = sizeDelta.x, sizeDelta.y
  self.ostTableView = self:CreateTableview(self.ui.ScrollView, function()
    return #self.ostDataList
  end, function(view, index)
    local cell = self:DequeueCell(view, self.ui.UI_Collection_Panel_Music)
    self:AddViewComponentOnce(cell.gameObject, OSTCom, self.ostDataList[index], index)
    return cell
  end, function()
    return w, h
  end)
  
  function self.ostTableView.reloadFinishCallback()
  end
end

function ArtCollectionOSTView:UpdateOstList()
  local ostDataList = ArtCollectionModel.Instance:GetAllOstData()
  self.ostDataList = {}
  if ostDataList then
    local serverTime = TimeUtils.GetServerTime()
    for i = 1, #ostDataList do
      local cfg = DT.CollectionHall[ostDataList[i].groupId]
      if cfg and (not cfg.CollectionDisplayDate or serverTime > cfg.CollectionDisplayDate) then
        table.insert(self.ostDataList, ostDataList[i])
      end
    end
  end
  table.sort(self.ostDataList, function(a, b)
    local cfgA = ArtCollectionModel.Instance:GetCfg(a.groupId)
    local cfgB = ArtCollectionModel.Instance:GetCfg(b.groupId)
    return cfgA.BaseSortID < cfgB.BaseSortID
  end)
  self.ostTableView:ReloadData()
end

function ArtCollectionOSTView:_RefreshProgress()
  self:AddViewComponentOnce(self.ui.Image_Mail, CollectionRewardCom, self:_GetRewardType(), function()
    do return ArtCollectionModel.Instance.GetTotalOstProgress end
    return ArtCollectionModel.Instance.GetTotalOstProgress, ArtCollectionModel.Instance
  end)
end

function ArtCollectionOSTView:_GetRewardType()
  return ArtCollectionDefine.RewardType.Music
end

return ArtCollectionOSTView

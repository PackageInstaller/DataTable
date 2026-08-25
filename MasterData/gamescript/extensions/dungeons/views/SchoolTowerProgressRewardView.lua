local MAX_SHOW_ITEM_NUM = 4
local SchoolTowerProgressRewardView, Super = NewClass("SchoolTowerProgressRewardView", ProgressRewardViewBase)
SchoolTowerProgressRewardView.uiResCls = UI_Chaper_Popup_Award_OptimizedResource

function SchoolTowerProgressRewardView:ctor(data)
  Super.ctor(self)
  self.progressDrops = data.progressDrops
  self.star = data.star
  self.stageGroupTid = data.stageGroupTid
  self:_UpdateViewData()
end

function SchoolTowerProgressRewardView:OnBuildView()
  Super.OnBuildView(self)
end

function SchoolTowerProgressRewardView:RegisterEvents()
  Super.RegisterEvents(self)
  self:BindEvent(EventMgr.Instance.OnAwardProgressDataChanged, System.fn(self, self._OnAwardProgressDataChanged))
end

function SchoolTowerProgressRewardView:_OnAwardProgressDataChanged()
  self:_UpdateViewData()
  self:_RefreshView()
end

function SchoolTowerProgressRewardView:_UpdateViewData()
  local awawrdProgress = SchoolTowerModel.Instance:GetStageGroupAwardProgressDict(self.stageGroupTid)
  self.schoolTowerProgressList = CopyDataUtils.GetShowRewardItemGroup(self.progressDrops, self.star, awawrdProgress, self.stageGroupTid)
  for idx, progressInfo in pairs(self.schoolTowerProgressList) do
    function progressInfo.gainRewardFunc()
      ProtoManager.Instance:ReqServer("StageRequest", "AwardGet", function()
        SchoolTowerModel.Instance:SetStageGroupAwardProgress(self.stageGroupTid, progressInfo.needStar, true)
        
        local needStar = progressInfo.needStar
        self:OnProgressAwardGet(needStar)
      end, nil, progressInfo.groupTid, progressInfo.needStar)
    end
    
    self.schoolTowerProgressList[idx] = progressInfo
  end
  self:SortProgressList()
end

function SchoolTowerProgressRewardView:SortProgressList()
  if not self.schoolTowerProgressList then
    return
  end
  if #self.schoolTowerProgressList > MAX_SHOW_ITEM_NUM then
    table.sort(self.schoolTowerProgressList, function(a, b)
      local aNeedStar = a.needStar
      local bNeedStar = b.needStar
      local aIsGet = a.isGet and 1 or 0
      local bIsGet = b.isGet and 1 or 0
      if aIsGet == bIsGet then
        return aNeedStar < bNeedStar
      end
      return aIsGet < bIsGet
    end)
  else
    table.sort(self.schoolTowerProgressList, function(a, b)
      return a.needStar < b.needStar
    end)
  end
end

function SchoolTowerProgressRewardView:RegisterNotifications()
end

function SchoolTowerProgressRewardView:OnEnterView()
  Super.OnEnterView(self)
end

function SchoolTowerProgressRewardView:OnProgressAwardGet(needStar)
  local changedProgress
  for _, progressInfo in pairs(self.schoolTowerProgressList) do
    if progressInfo.needStar == needStar then
      changedProgress = progressInfo
    end
  end
  if not changedProgress then
    return
  end
  changedProgress.isGet = true
  local newGroup = table.deepclone(self.schoolTowerProgressList)
  for key, val in pairs(newGroup) do
    if val.needStar == changedProgress.needStar then
      newGroup[key].isGet = true
    end
    if val.reqGetAwardFunc then
      setmetatable(newGroup[key], ReactiveFlags.SKIP)
    end
  end
  self.schoolTowerProgressList = newGroup
  self:SortProgressList()
  self:_RefreshRewardList(true)
end

function SchoolTowerProgressRewardView:_GetProgressDataList()
  return self.schoolTowerProgressList
end

return SchoolTowerProgressRewardView

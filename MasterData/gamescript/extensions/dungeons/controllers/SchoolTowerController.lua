local SchoolTowerController, Super = NewClass("SchoolTowerController", BaseController)
local StageGroupType = CommonDefine.StageGroupType

function SchoolTowerController:OnInit()
  self.model = SchoolTowerModel.Instance
end

function SchoolTowerController:OpenTowerShop()
  MainShopDataUtils.OnOpenShop(CommonDefine.MainShopTypeTag.TowerShop)
end

function SchoolTowerController:ReqDisposableTowerAwardProgressForGuideNote()
  local towerDataList = SchoolTowerDataUtils.GetTowerDataByStageGroupType(StageGroupType.DisposableSchoolTower)
  for _, towerData in ipairs(towerDataList or {}) do
    local stageGroupTid = towerData.stageGroupId
    if stageGroupTid and self.model:GetStageGroupAwardProgressDict(stageGroupTid) == nil then
      ProtoManager.Instance:ReqServer("StageRequest", "AwardProgress", function(data)
        self.model:SetStageGroupAwardProgressDict(stageGroupTid, data or {})
        EventMgr.Instance.OnAwardProgressDataChanged:Dispatch(stageGroupTid)
      end, function()
        self.model:SetStageGroupAwardProgressDict(stageGroupTid, {})
        EventMgr.Instance.OnAwardProgressDataChanged:Dispatch(stageGroupTid)
      end, stageGroupTid)
    end
  end
end

function SchoolTowerController:OpenTowerDetailView(stageGroupTid)
  local featureId = SchoolTowerModel.Instance.featureId
  if not self.model:GetTowerFeatureUnlock(stageGroupTid) then
    PlayerDataUtils.AlertLockedTips(featureId, stageGroupTid)
    return
  end
  UIManager.Instance:Reopen(Urls.SchoolTowerDetailView, stageGroupTid)
end

function SchoolTowerController:OpenProgressFirstRewardView(stageGroupTid)
  local stageGroupCfg = DT.StageGroup[stageGroupTid]
  local star = SchoolTowerDataUtils.GetTowerProgressStars(stageGroupTid)
  local stageDataList = self.model:GetStageDataList(stageGroupTid)
  local maxStar = self.model:GetStageGroupAwardMaxProgressStar(stageGroupTid)
  if star > maxStar then
    ProtoManager.Instance:ReqServer("StageRequest", "AwardProgress", function(data)
      SchoolTowerModel.Instance:SetStageGroupAwardProgressDict(stageGroupTid, data)
      EventMgr.Instance.OnAwardProgressDataChanged:Dispatch(stageGroupTid)
    end, nil, stageGroupTid)
  end
  local viewData = {
    progressDrops = stageGroupCfg.StageGroupDrop,
    star = star,
    stageGroupTid = stageGroupTid,
    stageDataList = stageDataList
  }
  UIManager.Instance:Reopen(Urls.SchoolTowerProgressFristRewardView, viewData)
end

return SchoolTowerController

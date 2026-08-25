local CopyStageAchievementView, Super = NewClass("CopyStageAchievementView", BaseView)
CopyStageAchievementView.uiResCls = UI_Chaper_Popup_StageAchieve_ViewResource

function CopyStageAchievementView:ctor(stageGroupId)
  Super.ctor(self)
  self.stageGroupId = stageGroupId
  self.compList = {}
  CopyStageDetailModel.Instance:SetGroupId(self.stageGroupId)
end

function CopyStageAchievementView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Mask, System.fn(self, self.Close))
  self:AddButtonClickListener(self.ui.UI_Common_Btn_Back1, System.fn(self, self.Close))
  self:AddButtonClickListener(self.ui.Btn_OneKey, System.fn(self, self.GainStageGroupAchievementRw))
  self:BindEvent(EventMgr.Instance.AchieveRewarded, System.fn(self, self._RefreshOnekeyBtnState))
end

function CopyStageAchievementView:OnEnterView()
  Super.OnEnterView(self)
  self.ContentRect = self.ui.ScrollView:GetComponent(typeof(CS.UnityEngine.RectTransform))
  self.stageAchieveList = CopyStageDetailModel.Instance:GetStageAchieveData(self.stageGroupId)
  self.stageAchieveView = self:CreateTableview(self.ui.ScrollView, function()
    if not self.stageAchieveList then
      return 0
    end
    return #self.stageAchieveList
  end, function(view, index)
    do return self.StageAchieveCellByIndex, self, view end
    return self.StageAchieveCellByIndex, self, view, index
  end, function(view, index)
    do return self.StageAchieveCellSize, self, view end
    return self.StageAchieveCellSize, self, view, index
  end)
  self:_RefreshUI()
  self:_RefreshOnekeyBtnState()
  
  function self.stageAchieveView.reloadFinishCallback()
    self:_RefreshData()
    self.stageAchieveView.reloadFinishCallback = nil
  end
end

function CopyStageAchievementView:OnExitView()
  Super.OnExitView(self)
end

function CopyStageAchievementView:_RefreshData()
  local firstFinishGroupIdx, firstNotAchievedGroupIdx = 0, 0
  for idx, stageData in ipairs(self.stageAchieveList) do
    local stageCfg = DT.Stage[stageData.stageID]
    for _, taskId in pairs(stageCfg.LevelAchieve) do
      local state = stageData.achivement[taskId]
      if state == CommonDefine.MainCopyAchieveState.IsFinish and 0 == firstFinishGroupIdx then
        firstFinishGroupIdx = idx
      elseif state == CommonDefine.MainCopyAchieveState.NotAchieved and 0 == firstNotAchievedGroupIdx then
        firstNotAchievedGroupIdx = idx
      end
    end
  end
  local jumpIdx = 0
  if 0 ~= firstFinishGroupIdx then
    jumpIdx = firstFinishGroupIdx
  elseif 0 ~= firstNotAchievedGroupIdx then
    jumpIdx = firstNotAchievedGroupIdx
  end
  if 0 ~= jumpIdx then
    self.stageAchieveView:MoveCellInView(jumpIdx - 1)
  end
end

function CopyStageAchievementView:_IsHaveReward()
  for idx, stageData in ipairs(self.stageAchieveList) do
    local stageCfg = DT.Stage[stageData.stageID]
    for _, taskId in pairs(stageCfg.LevelAchieve) do
      local state = stageData.achivement[taskId]
      if state == CommonDefine.MainCopyAchieveState.IsFinish then
        return true
      end
    end
  end
end

function CopyStageAchievementView:GainStageGroupAchievementRw()
  if not self:_IsHaveReward() then
    return
  end
  CopyStageDetailController.Instance:GainStageGroupAchievementRw(self.stageGroupId, function()
    self:_RefreshUI()
  end)
end

function CopyStageAchievementView:StageAchieveCellByIndex(view, index)
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(self.ui.UI_Chapter_Item_StageAchieve)
  local stageAchieveData = self.stageAchieveList[index]
  local comp = self.compList[cell.gameObject]
  if not comp then
    comp = self:AddViewComponentOnce(cell.gameObject, CopyStageAchieveCell, stageAchieveData)
    self.compList[cell.gameObject] = comp
  else
    comp:RefreshData(stageAchieveData)
  end
  return cell
end

function CopyStageAchievementView:StageAchieveCellSize(view, index)
  local stageAchieveData = self.stageAchieveList[index]
  local stageCfg = DT.Stage[stageAchieveData.stageID]
  local achivementCount = table.length(stageCfg.LevelAchieve)
  local height = 126 * achivementCount + 60
  return 1591, height
end

function CopyStageAchievementView:_RefreshUI()
  self.stageAchieveList = CopyStageDetailModel.Instance:GetStageAchieveData(self.stageGroupId)
  self.stageAchieveView:ReloadData()
  self:_RefreshOnekeyBtnState()
end

function CopyStageAchievementView:_RefreshOnekeyBtnState()
  self:SetButtonState(self.ui.Btn_OneKey, self:_IsHaveReward() and CommonDefine.BtnType.High or CommonDefine.BtnType.Unclickable)
end

return CopyStageAchievementView

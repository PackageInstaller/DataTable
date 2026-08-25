local CopyStageAchieveLevelCell, Super = NewViewComponent("CopyStageAchieveLevelCell")
local MAX_REWARD_COUNT = 4

function CopyStageAchieveLevelCell:ctor(uiNode, view, data, taskId)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Chapter_Item_Success_ListResource(uiNode)
  self.stageData = data
  self.stageId = self.stageData.stageID
  self.taskId = taskId
  self.state = self.stageData.achivement[self.taskId]
end

function CopyStageAchieveLevelCell:OnEnterComponent()
  Super.OnEnterComponent(self)
  local taskCfg = DT.Task[self.taskId]
  self:SetText(self.ui.Text_Finish_Title, LT.Text(taskCfg.Name))
  self:SetText(self.ui.Text_Finish_Tips, LT.Text(taskCfg.Desc))
  self:_RefreshUI()
  self:_RefreshReward()
end

function CopyStageAchieveLevelCell:OnExitComponent()
  Super.OnExitComponent(self)
end

function CopyStageAchieveLevelCell:_RefreshUI()
  self:AddButtonClickListener(self.ui.Btn_Get, System.fn(self, self._OnClickGainStageAchieve))
  self:SetButtonText(self.ui.Btn_Get, LT.Text("StoryLineTask_String_Available"))
  self:SetButtonRedPoint(self.ui.Btn_Get, self._RefreshRedPoint)
  self.ui.Text_Lost:SetActive(self.state == CommonDefine.MainCopyAchieveState.NotAchieved)
  self.ui.Btn_Get:SetActive(self.state == CommonDefine.MainCopyAchieveState.IsFinish)
  self.ui.Image_Got_Icon:SetActive(self.state == CommonDefine.MainCopyAchieveState.IsGot)
  self.ui.Image_Bg_Got:SetActive(self.state == CommonDefine.MainCopyAchieveState.IsGot)
  self:_RefreshReward()
end

function CopyStageAchieveLevelCell:_RefreshRedPoint()
  return RedPointDataUtils.RedAttrType.Red
end

function CopyStageAchieveLevelCell:_RefreshReward()
  local rewards = {}
  local taskCfg = DT.Task[self.taskId]
  for itemTid, itemCount in table.iteraDouble(taskCfg.CompleteAward or {}) do
    table.insert(rewards, {
      tid = itemTid,
      type = CommonDefine.ItemAwardType.Normal,
      num = itemCount,
      isGot = self.state == CommonDefine.MainCopyAchieveState.IsGot
    })
  end
  for index = 1, MAX_REWARD_COUNT do
    local obj = self.ui["WuPin_Type_" .. index]
    local rewardData = rewards[index]
    if rewardData then
      local itemData = {
        itemTid = rewardData.tid,
        itemCount = rewardData.num
      }
      self:AddViewComponentOnce(obj.gameObject, CompPublicIconItemType2, itemData)
    end
    obj:SetActive(rewardData)
  end
end

function CopyStageAchieveLevelCell:_OnClickGainStageAchieve()
  ProtoManager.Instance:ReqServer("GameRequest", "GainStageAchievementRw", function(_)
    if self.stageData.achivement then
      self.stageData.achivement[self.taskId] = CommonDefine.MainCopyAchieveState.IsGot
      self.state = CommonDefine.MainCopyAchieveState.IsGot
      EventMgr.Instance.AchieveRewarded:Dispatch()
      self:_RefreshUI()
    end
  end, nil, self.stageId, self.taskId)
end

return CopyStageAchieveLevelCell

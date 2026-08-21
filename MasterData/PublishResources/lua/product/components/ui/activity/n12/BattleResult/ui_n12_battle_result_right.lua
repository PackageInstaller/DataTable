_class("UIN12BattleResultRight", UICustomWidget)
UIN12BattleResultRight = UIN12BattleResultRight

function UIN12BattleResultRight:Constructor()
  self._campaignModule = self:GetModule(CampaignModule)
end

function UIN12BattleResultRight:OnShow(uiParams)
  self:_GetComponent()
end

function UIN12BattleResultRight:_GetComponent()
  self._leftValue = self:GetUIComponent("UILocalizationText", "LeftValue")
  self._rightValue = self:GetUIComponent("UILocalizationText", "RightValue")
  self._arrowRect = self:GetUIComponent("RectTransform", "Arrow")
  self._animation = self:GetUIComponent("Animation", "Animation")
end

function UIN12BattleResultRight:SetData(isWin)
  local localProcess = self._campaignModule:GetCampaignLocalProcess(ECampaignType.CAMPAIGN_TYPE_N12)
  local leftScore = localProcess:GetCurScore()
  if not isWin then
    leftScore = 0
  end
  local curLevelIndex = N12ToolFunctions.GetLocalDBInt(N12OperationRecordKey.HardLevelIndex, 1)
  local rightScore = localProcess:GetRecordScore(curLevelIndex)
  self._leftValue:SetText(leftScore)
  self._rightValue:SetText(rightScore)
  if leftScore < rightScore then
    self._arrowRect.localRotation = Quaternion.Euler(0, -180, 0)
  end
  local oldMaxScore = rightScore
  local newMaxScore = localProcess:GetRecordScore(curLevelIndex)
  self:Lock("ShowChallengeTaskRewards")
  self:StartTask(function(TT)
    YIELD(TT, 2000)
    if rightScore > leftScore then
      self._animation:Play("uieff_N12_Result_Right")
    else
      self._animation:Play("uieff_N12_Result_Left")
    end
    local key = N12OperationRecordKey.ShowChallengeTaskRewards .. curLevelIndex
    if newMaxScore > oldMaxScore then
      N12ToolFunctions.SetLocalDBInt(key, 1)
      N12ToolFunctions.SetLocalDBInt(N12OperationRecordKey.OldMaxScore, oldMaxScore)
      N12ToolFunctions.SetLocalDBInt(N12OperationRecordKey.NewMaxScore, newMaxScore)
    else
      N12ToolFunctions.SetLocalDBInt(key, 0)
      N12ToolFunctions.SetLocalDBInt(N12OperationRecordKey.OldMaxScore, 0)
      N12ToolFunctions.SetLocalDBInt(N12OperationRecordKey.NewMaxScore, 0)
    end
    self:UnLock("ShowChallengeTaskRewards")
  end)
end

local StageFsmBeforeStory, Super = System.NewClass("StageFsmBeforeStory", LinearFsmState)

function StageFsmBeforeStory:ctor(...)
  Super.ctor(self, ...)
end

function StageFsmBeforeStory:GetStoryId()
  local storyId = self.entity:GetStartStoryId()
  if not self.entity:IsRecover() then
    return storyId
  end
  local recoverStoryId = AvgStoryManager.Instance:GetRecoverStoryId()
  if recoverStoryId and storyId == recoverStoryId then
    return storyId
  end
end

function StageFsmBeforeStory:Enter()
  UIAudioManager.Instance:SetMainSceneMusicState(false)
  UIManager.Instance:CloseByUrl(Urls.CopyStageDetailView)
  if not self.entity:IsStoryStage() then
    UIManager.Instance:CloseAllExcept()
  end
  self:EnterStory()
end

function StageFsmBeforeStory:ShowHighDifficultTips(callback)
  UIManager.Instance:Reopen(Urls.HighDifficultTips, callback)
end

function StageFsmBeforeStory:EnterStory()
  local storyId = self:GetStoryId()
  if self.entity:IsStoryStage() then
    storyId = self.entity:GetStartStoryId()
  end
  
  local function startStoryFunc()
    if not storyId then
      self:SetFinish()
      return
    end
    local isHold = self.entity:IsStoryStage()
    AvgStoryManager.Instance:StartStoryById(storyId, nil, function()
      self:SetFinish()
    end, function()
      if self.entity:IsStoryStage() then
        if not self.entity:GetEndStoryId() and not MainCopyDataUtils.IsPlayChapterFinishPlay(self.entity.stageData.stageId) then
          local timer = TimerManager.Instance:CreateTimer(CommonDefine.AvgConst.EndFadeTime - 0.2, 0, nil, function()
            AudioManager.Instance:PostSoundEvent("CHAPTER_WIN_MUSIC")
          end)
        end
        ProtoManager.Instance:ReqServer("WorldRequest", "OnPlotEnd", function()
        end)
      end
    end)
  end
  
  local stageCfg = DT.Stage[self.entity.stageData.stageId] or {}
  local isHighDiff = 1 == stageCfg.StageHighDifficulty
  if isHighDiff and not self.entity:IsRecover() then
    self:ShowHighDifficultTips(startStoryFunc)
  elseif storyId then
    startStoryFunc()
  else
    self:SetFinish()
  end
end

return StageFsmBeforeStory

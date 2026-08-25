local DisplayUGUI = CS.RenderHeads.Media.AVProVideo.DisplayUGUI
local EventType = CS.RenderHeads.Media.AVProVideo.MediaPlayerEvent.EventType
local UIAnimationController = CS.Z1Client.UIAnimationController
local AvgFinishPanel, Super = System.NewClass("AvgFinishPanel", UIBasePanel)
AvgFinishPanel.uiResCls = UI_Story_Popup_Curtain_CallResource

function AvgFinishPanel:ctor(stageId, finishCallback)
  Super.ctor(self)
  self.stageId = stageId
  self.finishCallback = finishCallback
end

function AvgFinishPanel:OnBind(binder)
  self.binder = binder
  self.isForbidClick = true
  self:PrepareAndPlayVideo(function()
    self:PlayEnterAnim(function()
      self.isForbidClick = false
    end)
  end)
  local stageGroupID = MainCopyDataUtils.GetStageGroupID(self.stageId)
  if stageGroupID then
    local stageGroupCfg = MainCopyDataUtils.GetStageGroupCfg(stageGroupID)
    local indexStr = ""
    if stageGroupCfg.Type == CommonDefine.StageGroupType.MainCopy then
      indexStr = CopyDataUtils.GetStageGroupIndexName(stageGroupID)
      indexStr = indexStr .. " "
    end
    binder:SetText(self.ui.Text_Chapter, string.format("%s%s", indexStr, LT.Text(stageGroupCfg and stageGroupCfg.Name or "")))
  end
  binder:BindButtonClick(self.ui.Btn_Click, function()
    if not self.isForbidClick then
      local uiAnimCtr = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
      uiAnimCtr:PlayState("UI_Story_Popup_Curtain_Call_Close", function()
        self:Close()
      end)
    end
  end)
end

function AvgFinishPanel:PrepareAndPlayVideo(callback)
  local videoUrl = "Vx/Story_CurtainCall.mp4"
  self.videoPlayer = GameVideoPlayer(self.ui.MediaPlayer, self.ui.VideoPlayer)
  
  local function onLoginStarted()
    if self.videoPlayer then
      self.videoPlayer:RemoveAllListeners()
    end
    FrameWaiter.OnNextFrame(function()
      callback()
    end)
  end
  
  local function onLoginPrepareCompleted()
    if self.videoPlayer then
      self.videoPlayer:Play()
    end
  end
  
  self.videoPlayer.preparedCallback = onLoginPrepareCompleted
  self.videoPlayer.startedCallabck = onLoginStarted
  
  function self.videoPlayer.finishedCallback(errorOccued)
    if errorOccued then
      if self.videoPlayer then
        self.videoPlayer:RemoveAllListeners()
      end
      self:Close()
    end
  end
  
  self.videoPlayer:OpenMedia(videoUrl)
end

function AvgFinishPanel:PlayEnterAnim(callback)
  local uiAnimCtr = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  uiAnimCtr:PlayState("UI_Story_Popup_Curtain_Call_Open", function()
    if callback then
      callback()
    end
  end)
end

function AvgFinishPanel:OnUnbind()
  Super.OnUnbind(self)
  if self.videoPlayer then
    self.videoPlayer:Dispose()
    self.videoPlayer = nil
  end
  if self.finishCallback then
    self.finishCallback()
  end
  self.finishCallback = nil
end

return AvgFinishPanel

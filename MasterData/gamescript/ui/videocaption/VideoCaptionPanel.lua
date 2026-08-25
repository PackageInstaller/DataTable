local VideoCaptionPanel, Super = System.NewClass("VideoCaptionPanel", UIBasePanel)
VideoCaptionPanel.uiResCls = UI_Story_Video_CaptionResource

function VideoCaptionPanel:ctor(captionKey)
  Super.ctor(self)
  self.captionKey = captionKey
  self.content = Vue.ref(nil)
  self.isCaptionBgShow = false
  self.curTime = 0
  self.captionCfg = DT.AvgVideoCaption[self.captionKey] or {}
  self.startTime = TimerManager.totalTime
  self.jumpTime = 0
  self.captionIndex = 0
  self.isCaptionEnd = false
end

function VideoCaptionPanel:OnBind(binder)
  self.binder = binder
  self.bgCanvasGroup = self.ui.Image_Dialog_Bg:GetComponent(typeof(CS.UnityEngine.CanvasGroup))
  self.contentCanvasGroup = self.ui.Text_Content:GetComponent(typeof(CS.UnityEngine.CanvasGroup))
  if not self.captionCfg.data_list then
    self.binder:BindTimer(0, 0, nil, function()
      self:Close()
    end)
    return
  end
  self.isCanClick = 1 == self.captionCfg.data_list[1].CanClick
  self.ui.Group_Btn_Skip:SetActive(false)
  self.ui.Image_Dialog_Bg:SetActive(true)
  self.ui.Btn_Comment:SetActive(AvgStoryManager.Instance:GetCommentId() ~= nil)
  self.binder:SetCanvasGroup(self.ui.Image_Dialog_Bg, 0)
  binder:BindButtonClick(self.ui.Btn_Comment, function()
    CommentController.Instance:OpenCommentListView({
      commentId = AvgStoryManager.Instance:GetCommentId()
    })
  end)
  binder:BindButtonClick(self.ui.Btn_Bottom, function()
    self:OnClickBottom()
  end)
  binder:BindButtonClick(self.ui.Group_Btn_Skip, function()
    if AvgStoryManager.Instance:IsPlaying() then
      EventMgr.Instance.StorySkip:Dispatch()
    else
      self:Close()
    end
  end)
  binder:BindToRaw(function(_, content)
    self:OnCaptionContentChange(content)
  end, function()
    return self.content.value
  end)
  binder:BindTimer(0.05, -1, function()
    self:Update()
  end)
  self:InitUIBothSidesUI(binder)
  if AvgStoryManager.Instance:IsLooping() then
    local commentListPanel = UIManager.Instance:GetWindow(Urls.CommentListView)
    if commentListPanel and commentListPanel.ui and commentListPanel.ui.uiNode then
      commentListPanel.ui.uiNode.transform:SetAsLastSibling()
    end
  end
end

function VideoCaptionPanel:Update()
  self.curTime = TimerManager.totalTime - self.startTime + self.jumpTime
  local curCfg = self.captionCfg.data_list[self.captionIndex]
  local endTime = self:GetTime(curCfg and curCfg.EndTime)
  if endTime then
    local fadeTime = self:GetFadeOutTime()
    if endTime <= self.curTime + fadeTime then
      self.content.value = nil
    else
      return
    end
  end
  local nextCfg = self.captionCfg.data_list[self.captionIndex + 1]
  if not nextCfg then
    self.isCaptionEnd = true
    return
  end
  local captionStartTime = self:GetTime(nextCfg and nextCfg.StartTime)
  if captionStartTime and captionStartTime <= self.curTime then
    self.captionIndex = self.captionIndex + 1
    self.content.value = nextCfg.Content
  end
end

function VideoCaptionPanel:GetFadeInTime()
  local curCfg = self.captionCfg.data_list[self.captionIndex] or {}
  return curCfg.FadeInTime or self:GetDefaultFadeTime()
end

function VideoCaptionPanel:GetFadeOutTime()
  local curCfg = self.captionCfg.data_list[self.captionIndex] or {}
  return curCfg.FadeOutTime or self:GetDefaultFadeTime()
end

function VideoCaptionPanel:GetDefaultFadeTime()
  local curCfg = self.captionCfg.data_list[self.captionIndex]
  local startTime = self:GetTime(curCfg and curCfg.StartTime)
  local endTime = self:GetTime(curCfg and curCfg.EndTime)
  local fadeTime = 0.3
  if startTime and endTime then
    local dura = endTime - startTime
    local readTime = 2
    fadeTime = math.max((dura - readTime) / readTime, 0.3)
  end
  return fadeTime
end

function VideoCaptionPanel:OnCaptionContentChange(content)
  if content then
    local curCfg = self.captionCfg.data_list[self.captionIndex]
    if curCfg and curCfg.DialogType then
      self.ui.uiNode:SetActive(false)
      local startTime = self:GetTime(curCfg and curCfg.StartTime)
      local endTime = self:GetTime(curCfg and curCfg.EndTime)
      EventMgr.Instance.VideoCaption:Dispatch(true, curCfg, endTime - startTime)
    else
      self.ui.uiNode:SetActive(true)
    end
    self.binder:SetText(self.ui.Text_Content, StrUtils.ReplaceAvgContent(content or ""))
    self:TweenShowCaptionContent()
    self:TweenShowCaptionBg()
  else
    local curCfg = self.captionCfg.data_list[self.captionIndex]
    if curCfg and curCfg.DialogType then
      EventMgr.Instance.VideoCaption:Dispatch(false)
    else
      self:TweenHideCaptionContent()
      local contentOfNext2Second = self:GetContentBetween(self.curTime, self.curTime + 2)
      if not contentOfNext2Second then
        self:TweenHideCaptionBg()
      end
    end
  end
end

function VideoCaptionPanel:OnClickBottom()
  self.ui.Group_Btn_Skip:SetActive(true)
  if self.isCanClick then
    local nextCfg = self.captionCfg.data_list[self.captionIndex + 1]
    local totalTime = TimerManager.totalTime
    local curTime = totalTime - self.startTime + self.jumpTime
    local nextStartTime = self:GetTime(nextCfg and nextCfg.StartTime)
    if nextStartTime and curTime < nextStartTime then
      self.jumpTime = self.jumpTime + nextStartTime - curTime
    end
    if self.isCaptionEnd then
      EventMgr.Instance.NextDialog:Dispatch()
    end
  end
  if self._reHideSkipTimer then
    self.binder:StopTimer(self._reHideSkipTimer)
  end
  self._reHideSkipTimer = self.binder:BindTimer(5, 0, nil, function()
    self.ui.Group_Btn_Skip:SetActive(false)
  end)
end

function VideoCaptionPanel:GetContentBetween(startTime, endTime)
  local captionCfg = DT.AvgVideoCaption[self.captionKey]
  for index = 1, #captionCfg.data_list do
    local curCfg = captionCfg.data_list[index]
    local captionStartTime = self:GetTime(curCfg.StartTime)
    if startTime < captionStartTime and endTime > captionStartTime then
      return curCfg.Content
    end
    if endTime < captionStartTime then
      return
    end
  end
end

function VideoCaptionPanel:TweenShowCaptionBg()
  self:StopTween()
  self.bgTween = self.bgCanvasGroup:DOFade(1, self:GetFadeInTime())
end

function VideoCaptionPanel:TweenHideCaptionBg()
  self:StopTween()
  self.bgTween = self.bgCanvasGroup:DOFade(0, self:GetFadeOutTime())
end

function VideoCaptionPanel:TweenShowCaptionContent()
  self:StopContentTween()
  self.contentCanvasGroup.alpha = 0
  self.contentTween = self.contentCanvasGroup:DOFade(1, self:GetFadeInTime())
end

function VideoCaptionPanel:TweenHideCaptionContent()
  self:StopContentTween()
  self.contentTween = self.contentCanvasGroup:DOFade(0, self:GetFadeOutTime())
end

function VideoCaptionPanel:StopContentTween()
  if self.contentTween then
    self.contentTween:Kill()
  end
end

function VideoCaptionPanel:StopTween()
  if self.bgTween then
    self.bgTween:Kill()
    self.bgTween = nil
  end
  if self.hideTweenTimer then
    self.binder:StopTimer(self.hideTweenTimer)
    self.hideTweenTimer = nil
  end
end

function VideoCaptionPanel:GetTime(timeStr)
  if not timeStr then
    return
  end
  if string.contains(timeStr, ":") then
    local timeList = string.split(timeStr, ":")
    local second = timeList[#timeList]
    if string.contains(second, ",") then
      local list = string.split(second, ",")
      second = tonumber(list[1]) + tonumber(list[2]) / 1000
    else
      second = tonumber(second)
    end
    local minute = tonumber(timeList[#timeList - 1])
    local hour = tonumber(timeList[#timeList - 2])
    return hour * 3600 + minute * 60 + second
  else
    do return tonumber end
    return tonumber, timeStr, tonumber(timeList[#timeList - 1]), tonumber(timeList[#timeList - 2]), hour * 3600 + minute * 60 + second, minute * 60
  end
end

function VideoCaptionPanel:OnTodoFunc()
end

function VideoCaptionPanel:InitUIBothSidesUI(binder)
  local leftUIGroup = {}
  local rightUIGroup = {
    [self.ui.DialogMenuPanel] = 0
  }
  leftUIGroup, rightUIGroup = UIManager.Instance:InitBothSidesUIOriPos(leftUIGroup, rightUIGroup)
  UIManager.Instance:UIBothSidesAdaptation(leftUIGroup, rightUIGroup, CommonDefine.BothSideUILimitDeltaLen.AvgDialogPanelNew)
end

function VideoCaptionPanel:OnUnbind()
  if not AvgStoryManager.Instance:IsLooping() then
    AvgStoryManager.Instance:SetCommentId(nil)
  end
  Super.OnUnbind(self)
end

return VideoCaptionPanel

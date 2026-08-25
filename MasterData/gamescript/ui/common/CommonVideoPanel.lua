local CanvasGroup = CS.UnityEngine.CanvasGroup
local VideoPlayer = CS.UnityEngine.Video.VideoPlayer
local DOTween = CS.DG.Tweening.DOTween
local CommonVideoPanel, Super = System.NewClass("CommonVideoPanel", UIBasePanel)
CommonVideoPanel.uiResCls = UI_Common_Panel_VideoResource

function CommonVideoPanel:ctor(url, videoCallback)
  Super.ctor(self)
  self.videoUrl = url
  self.videoCallback = videoCallback
  self.visible = Vue.ref(false)
end

function CommonVideoPanel:CheckUrlValid()
  return self.videoUrl and self.videoUrl ~= ""
end

function CommonVideoPanel:OnBind(binder)
  self.binder = binder
  local videoPlayer = self.ui.VideoPlayer:GetComponent(typeof(VideoPlayer))
  self.BtnSkipCanvasGroup = self.ui.UI_Story_Item_Btn_01:GetComponent(typeof(CanvasGroup))
  if not self:CheckUrlValid() or not videoPlayer then
    Logger.Debug("数据错误, url:%s, videoPlayer:", self.videoUrl, videoPlayer)
    return
  end
  self.BtnSkipCanvasGroup.alpha = 0
  binder:BindButtonClick(self.ui.Btn_Mask, function()
    if self.ui.UI_Story_Item_Btn_01.activeInHierarchy then
      self:ShowSkipBtnInVideo()
      return
    end
    binder:SetActive(self.ui.UI_Story_Item_Btn_01, true)
    self:ShowSkipBtnInVideo()
  end)
  binder:BindButtonClick(self.ui.UI_Story_Item_Btn_01, function()
    if self.showSeq then
      self.showSeq:Kill()
      self.showSeq = nil
    end
    if self.hideSeq then
      self.hideSeq:Kill()
      self.hideSeq = nil
    end
    self:ClearSkipHideTimer()
    self:OnVideoEnd()
  end)
  binder:BindToVisible(self.ui.VideoPlayer, function()
    return self.visible.value
  end)
  videoPlayer.url = self.videoUrl
  videoPlayer:loopPointReached("-", System.fn(self, self.OnVideoEnd))
  videoPlayer:loopPointReached("+", System.fn(self, self.OnVideoEnd))
  videoPlayer.targetTexture:Release()
  self.visible.value = true
end

function CommonVideoPanel:ShowSkipBtnInVideo()
  local function DoFadeHide()
    DOTween.Kill(self.ui.BtnSkipCanvasGroup)
    
    self.hideSeq = DOTween.Sequence(self)
    self.hideSeq:Append(self.BtnSkipCanvasGroup:DOFade(0, 1):OnComplete(function()
      if self.hideSeq then
        self.hideSeq:Kill()
        self.hideSeq = nil
      end
      self.binder:SetActive(self.ui.UI_Story_Item_Btn_01, false)
    end))
  end
  
  local function BindSkipHideTimer()
    self:ClearSkipHideTimer()
    self.skipBtnAlphaTimer = self.binder:BindTimer(2, 0, nil, function()
      self:ClearSkipHideTimer()
      DoFadeHide()
    end)
  end
  
  local function DoFadeShow()
    DOTween.Kill(self.ui.BtnSkipCanvasGroup)
    self:ClearSkipHideTimer()
    if self.showSeq then
      self.showSeq:Kill()
      self.showSeq = nil
    end
    if self.hideSeq then
      self.hideSeq:Kill()
      self.hideSeq = nil
    end
    self.showSeq = DOTween.Sequence(self)
    self.showSeq:Append(self.BtnSkipCanvasGroup:DOFade(1, 1):OnComplete(function()
      if self.showSeq then
        self.showSeq:Kill()
        self.showSeq = nil
      end
      BindSkipHideTimer()
    end))
  end
  
  DoFadeShow()
end

function CommonVideoPanel:ClearSkipHideTimer()
  if self.skipBtnAlphaTimer then
    TimerManager.Instance:StopTimer(self.skipBtnAlphaTimer)
    self.skipBtnAlphaTimer = nil
  end
end

function CommonVideoPanel:OnVideoEnd()
  self.visible.value = false
  if self.videoCallback then
    self.videoCallback()
  end
  self:ClosePanel()
end

function CommonVideoPanel:ClosePanel()
  self:Close()
end

return CommonVideoPanel

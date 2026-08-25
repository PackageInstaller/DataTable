local AvgActionLongCaption, Super = System.NewClass("AvgActionLongCaption", AvgActionBase)

function AvgActionLongCaption:ctor(...)
  Super.ctor(self, ...)
  self.ui.UI_Story_Long_Caption:SetActive(false)
  self.bgCanvasGroup = self.ui.UI_Story_Long_Caption:GetComponent(typeof(CS.UnityEngine.CanvasGroup))
  self.captionUI = UI_Story_Long_CaptionResource(self.ui.UI_Story_Long_Caption)
  self.uiAnimController = self.ui.UI_Story_Long_Caption:GetComponent(typeof(CS.Z1Client.UIAnimationController))
  self.binder:LoadAllLangFont(self.captionUI.Text_Content)
  self.binder:BindButtonClick(self.captionUI.Btn_Next, function()
    self:ClickNext()
  end)
end

function AvgActionLongCaption:DoAction(_, content)
  if not self.avgModel:IsDialogType(CommonDefine.AvgDialogType.LongCaption) then
    self.ui.UI_Story_Long_Caption:SetActive(false)
    self:FinishAction()
    return
  end
  self.ui.UI_Story_Long_Caption:SetActive(true)
  self:TweenShowCaptionBg()
  self.binder:SetText(self.captionUI.Text_Content, StrUtils.ReplaceAvgContent(content))
  self.waitingForRead = true
  local duration = self:_GetAutoPlayDuration()
  self.avgModel:SetLongCapAutoDuration(nil)
  self.binder:BindTimer(duration, 0, nil, function()
    self.waitingForRead = false
  end)
  EventMgr.Instance.OnStoryClickNext:RegisterEvent(System.fn(self, self.ClickNext))
end

function AvgActionLongCaption:_GetAutoPlayDuration()
  local duration = self.avgModel:GetLongCapAutoDuration() or DT.GetOriginalConstant("AvgLongCapAutoDefaultDuration")
  local playSpeed = self.avgPanel.playSpeed.value
  return duration / playSpeed
end

function AvgActionLongCaption:ClickNext()
  if self.waitingForRead then
    return
  end
  EventMgr.Instance.OnStoryClickNext:RemoveEvent(System.fn(self, self.ClickNext))
  self:TweenHideCaptionBg(function()
    self.ui.UI_Story_Long_Caption:SetActive(false)
    self.avgModel:NextDialog()
  end)
end

function AvgActionLongCaption:TweenShowCaptionBg()
  self:StopTween()
  self.bgCanvasGroup.alpha = 1
  self.uiAnimController:PlayState("UI_Story_Panel_Main_Long_Caption")
end

function AvgActionLongCaption:TweenHideCaptionBg(onComplete)
  self:StopTween()
  if self.ui.UI_Story_Long_Caption.activeSelf then
    self.uiAnimController:StopPlayableGraph()
  end
  self.tween = self.bgCanvasGroup:DOFade(0, 0.5):OnComplete(function()
    if onComplete then
      onComplete()
    end
  end)
end

function AvgActionLongCaption:StopTween()
  if self.tween then
    self.tween:Kill()
    self.tween = nil
  end
end

return AvgActionLongCaption

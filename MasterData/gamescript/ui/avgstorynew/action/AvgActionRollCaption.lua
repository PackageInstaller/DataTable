local TMPTypewriter = CS.TMPTypewriter
local TimeUtil = CS.Framework.TimeUtil
local AvgActionRollCaption, Super = System.NewClass("AvgActionRollCaption", AvgActionBase)

function AvgActionRollCaption:ctor(...)
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

function AvgActionRollCaption:DoAction(_, content)
  if not self.avgModel:IsDialogType(CommonDefine.AvgDialogType.RollCaption) then
    self.ui.UI_Story_Long_Caption:SetActive(false)
    self:FinishAction()
    return
  end
  self.ui.UI_Story_Long_Caption:SetActive(true)
  self.binder:SetText(self.captionUI.Text_Content, "")
  self:TweenShowCaptionBg(function()
    self:TypeWriter(content)
  end)
  self.waitingForRead = true
  EventMgr.Instance.OnStoryClickNext:RegisterEvent(System.fn(self, self.ClickNext))
end

function AvgActionRollCaption:TypeWriter(content)
  self.binder:SetText(self.captionUI.Text_Content, content)
  self.compTMPTypewriter = TMPTypewriter.Get(self.captionUI.Text_Content)
  self.compTMPTypewriter.chAppearSpeed = tonumber(DT.GetConstant("AvgDialog_OneWordTime")) or 0.05
  self.compTMPTypewriter.chFadeInSpeed = 0.5
  self.compTMPTypewriter.showErrCode = false
  self.compTMPTypewriter.chAppearPace = TimeUtil.GetTimeScale()
  
  function self.compTMPTypewriter.onAppearedFinished()
    self.waitingForRead = false
  end
  
  self.compTMPTypewriter:StartPrinting()
end

function AvgActionRollCaption:ClickNext()
  if self.waitingForRead then
    return
  end
  EventMgr.Instance.OnStoryClickNext:RemoveEvent(System.fn(self, self.ClickNext))
  self:TweenHideCaptionBg(function()
    self.ui.UI_Story_Long_Caption:SetActive(false)
    self.avgModel:NextDialog()
  end)
end

function AvgActionRollCaption:TweenShowCaptionBg(callback)
  self:StopTween()
  self.bgCanvasGroup.alpha = 1
  self.uiAnimController:PlayState("UI_Story_Panel_Main_Roll_Caption", callback)
end

function AvgActionRollCaption:TweenHideCaptionBg(onComplete)
  self:StopTween()
  self.uiAnimController:StopPlayableGraph()
  self.tween = self.bgCanvasGroup:DOFade(0, 0.5):OnComplete(function()
    if onComplete then
      onComplete()
    end
  end)
end

function AvgActionRollCaption:StopTween()
  if self.tween then
    self.tween:Kill()
    self.tween = nil
  end
end

return AvgActionRollCaption

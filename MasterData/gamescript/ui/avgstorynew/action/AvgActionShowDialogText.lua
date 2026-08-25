local AvgActionShowDialogText, Super = System.NewClass("AvgActionShowDialogText", AvgActionBase)

function AvgActionShowDialogText:ctor(...)
  Super.ctor(self, ...)
  self.binder:BindEvent(EventMgr.Instance.VideoCaption, System.fn(self, self.OnVideoCaption))
end

function AvgActionShowDialogText:OnVideoCaption(isShow, captionCfg, duration)
  if not isShow then
    self.avgPanel.textComp:ClearDialogText()
    return
  end
  self.avgPanel.textComp:SetDialogText(captionCfg.Content, true, duration)
end

function AvgActionShowDialogText:DoAction(_, showText, finishCb)
  self:_StopProtectTimer()
  self:_StopDelayTimer()
  if self.avgModel:IsCaption() or self.avgModel:IsAvgNovel() then
    finishCb()
    return
  end
  local dialogInfo = self.avgModel:GetDialogInfo()
  if 0 == dialogInfo.DialogAnim then
    if dialogInfo.Content then
      Logger.Warn("配了隐藏对话框，又要显示文本，请检查 : " .. dialogInfo.Content)
    end
    finishCb()
    return
  end
  local bgTrans = self.avgModel:GetBgTransAnim()
  local delay = bgTrans and AvgDefine.BgTransTypewriterDelay[bgTrans] or nil
  if delay and delay > 0 then
    local timeScale = self.avgPanel.funcBtnComp and self.avgPanel.funcBtnComp:GetTimeScale() or 1
    if timeScale and timeScale > 0 then
      delay = delay / timeScale
    end
    self.avgPanel.textComp:ClearDialogText()
    self._delayTimer = self.binder:BindTimer(delay, 0, nil, function()
      self:_StopDelayTimer()
      self.avgPanel.textComp:SetDialogText(showText or "")
      self:_SetProtectTimer()
    end)
  else
    self.avgPanel.textComp:SetDialogText(showText or "")
    self:_SetProtectTimer()
  end
end

function AvgActionShowDialogText:_SetProtectTimer()
  self:_StopProtectTimer()
  self._protectTimer = self.binder:BindTimer(10, 0, nil, function()
    self:_StopProtectTimer()
    self.avgModel:FinishAction(CommonDefine.AvgAction.ShowDialogText)
  end)
end

function AvgActionShowDialogText:_StopProtectTimer()
  if self._protectTimer then
    self._protectTimer = self.binder:StopTimer(self._protectTimer)
    self._protectTimer = nil
  end
end

function AvgActionShowDialogText:_StopDelayTimer()
  if self._delayTimer then
    self._delayTimer = self.binder:StopTimer(self._delayTimer)
    self._delayTimer = nil
  end
end

return AvgActionShowDialogText

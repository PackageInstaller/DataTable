local CommonFloatTipsPanel, Super = System.NewClass("CommonFloatTipsPanel", UIBasePanel)
CommonFloatTipsPanel.uiResCls = UI_Common_Floating_Words_TipsResource

function CommonFloatTipsPanel:ctor()
  Super.ctor(self)
  self.showTipsTimer = 0
  self.curShowTipsList = Vue.ref({})
  self.waitShowTipsList = Vue.ref({})
  self.finishCnt = 0
end

function CommonFloatTipsPanel:OnBind(binder)
  self.binder = binder
  binder:BindRawTable(function()
    return self.curShowTipsList.value
  end, function(childBinder, sDesc, oldValue, key)
    if nil == childBinder then
      return
    end
    childBinder:BindNewComponent(self.ui.Content, CommonFloatTipsComponent, UI_Common_Floating_WordsResource, sDesc)
  end)
  binder:BindEvent(EventMgr.Instance.CSSendEvent, System.fn(self, self.OnCSSendEvent))
end

function CommonFloatTipsPanel:OnCSSendEvent(eventName, eventValue)
  if "OnStartGrabScreen" == eventName and 1 == tonumber(eventValue) then
    self:Close()
  end
end

function CommonFloatTipsPanel:CountingShowTips()
  self.finishCnt = self.finishCnt + 1
end

function CommonFloatTipsPanel:ClosePanel()
  self:Close()
end

function CommonFloatTipsPanel:GetAllTipsCnt()
  return self.finishCnt + #self.curShowTipsList.value + #self.waitShowTipsList.value
end

function CommonFloatTipsPanel:AddCommonTips(sDesc)
  if self:GetAllTipsCnt() >= CommonDefine.ShowCommonTipsLimit then
    return
  end
  table.insert(self.waitShowTipsList.value, sDesc)
end

function CommonFloatTipsPanel:ExecShowTips()
  local item = table.remove(self.waitShowTipsList.value)
  table.insert(self.curShowTipsList.value, item)
end

function CommonFloatTipsPanel:ShowCommonTips(sDesc)
  self:AddCommonTips(sDesc)
  if not self:InShowingTipsInterval() then
    self:ExecShowTips()
    self:_DelayShowNextTips()
  end
end

function CommonFloatTipsPanel:InShowingTipsInterval()
  return self.showTipsTimer ~= nil and 0 ~= self.showTipsTimer
end

function CommonFloatTipsPanel:_DelayShowNextTips()
  if self.showTipsTimer == nil or 0 == self.showTipsTimer then
    self.showTipsTimer = self.binder:BindTimer(0.21, -1, function()
      self:ContinueShowTips()
    end)
  end
end

function CommonFloatTipsPanel:ContinueShowTips()
  local waitlist = self:GetWaitShowTipslist()
  local curShowList = self:GetCurShowTipslist()
  local curShowCnt = #curShowList
  if #waitlist > 0 then
    if curShowCnt < CommonDefine.ShowCommonTipsLimit then
      self:ExecShowTips()
    end
  else
    self:StopShowTipsTimer()
  end
end

function CommonFloatTipsPanel:CheckFinish()
  if self:IsFinishAllTips() then
    self:StopShowTipsTimer()
    self:ClearShowTips()
    self:ClosePanel()
  end
end

function CommonFloatTipsPanel:ClearShowTips()
  self.curShowTipsList.value = {}
  self.finishCnt = 0
end

function CommonFloatTipsPanel:GetWaitShowTipslist()
  return self.waitShowTipsList.value
end

function CommonFloatTipsPanel:GetCurShowTipslist()
  return self.curShowTipsList.value
end

function CommonFloatTipsPanel:IsFinishAllTips()
  return self.finishCnt == #self.curShowTipsList.value and 0 == #self.waitShowTipsList.value
end

function CommonFloatTipsPanel:GetShowingTipsCnt()
  return #self.curShowTipsList.value - self.finishCnt
end

function CommonFloatTipsPanel:GetFinishTipsCnt()
  return self.finishCnt
end

function CommonFloatTipsPanel:StopShowTipsTimer()
  if self.showTipsTimer ~= nil then
    self.binder:StopTimer(self.showTipsTimer)
    self.showTipsTimer = nil
  end
end

return CommonFloatTipsPanel

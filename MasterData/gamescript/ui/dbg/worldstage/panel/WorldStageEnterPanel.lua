local WorldStageEnterPanel, Super = System.NewClass("WorldStageEnterPanel", UIBasePanel)
WorldStageEnterPanel.uiResCls = UI_Dbgcopy_Popup_ydbj_yty_01Resource

function WorldStageEnterPanel:ctor(callFunc)
  Super.ctor(self)
  self.callFunc = callFunc
end

function WorldStageEnterPanel:OnBind(binder)
  self.binder = binder
  local animator = self.ui.uiNode:GetComponent(typeof(CS.UnityEngine.Animator))
  self.ui.uiNode:GetComponent(typeof(CS.UnityEngine.RectTransform)).anchoredPosition = CS.UnityEngine.Vector2(0, 300)
  if animator then
    AnimatorUtils.SetStateEndInBehavior(animator, "end", System.fn(self, self.CloseAndExecCallback))
  end
  animator:Update(0)
  binder:BindEvent(EventMgr.Instance.CSSendEvent, System.fn(self, self.OnCSSendEvent))
end

function WorldStageEnterPanel:OnCSSendEvent(eventName, eventValue)
  if "OnStartGrabScreen" == eventName and 1 == tonumber(eventValue) then
    self:CloseAndExecCallback()
  end
end

function WorldStageEnterPanel:CloseAndExecCallback()
  self:Close()
  if self.callFunc then
    self.callFunc()
  end
end

return WorldStageEnterPanel

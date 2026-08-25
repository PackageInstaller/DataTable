local Animator = CS.UnityEngine.Animator
local PopMsgView, Super = NewClass("PopMsgView", BaseView)
PopMsgView.uiResCls = UI_PopMsgResource

function PopMsgView:ctor(str, durtion, callback)
  Super.ctor(self)
  self._text = str
  self._durtion = durtion
  self._callback = callback
end

function PopMsgView:OnBuildView()
  Super.OnBuildView(self)
  self:LoadAllLangFont(self.ui.Text_Msg)
  self._animator = self.ui.uiNode:GetComponent(typeof(Animator))
end

function PopMsgView:RegisterNotifications()
end

function PopMsgView:RegisterEvents()
end

function PopMsgView:OnEnterView()
  Super.OnEnterView(self)
  self:SetText(self.ui.Text_Msg, LT.Text(self._text, true))
  local showTime = self._durtion and self._durtion or CS.Framework.UIUtilTool.GetClipTimeByName(self._animator, "UA_CommonTips")
  self:BindTimer(showTime, 0, nil, function()
    if self._callback then
      self._callback()
      self._callback = nil
    end
    self:Close()
  end)
end

function PopMsgView:OnExitView()
  Super.OnExitView(self)
end

return PopMsgView

local PopMsgPanel, Super = System.NewClass("PopMsgPanel", UIBasePanel)
PopMsgPanel.uiResCls = UI_PopMsgResource

function PopMsgPanel:ctor(str, durtion, callback)
  Super.ctor(self)
  self.durtion = durtion
  self.callback = callback
  self.text = str
end

function PopMsgPanel:OnBind(binder)
  Super.OnBind(self, binder)
  binder:LoadAllLangFont(self.ui.Text_Msg)
  self.animator = self.ui.uiNode:GetComponent(typeof(CS.UnityEngine.Animator))
  binder:BindToText(self.ui.Text_Msg, function()
    do return LT.Text, self.text end
    return LT.Text, self.text, true
  end)
  local showTime = self.durtion and self.durtion or CS.Framework.UIUtilTool.GetClipTimeByName(self.animator, "UA_CommonTips")
  binder:BindTimer(showTime, 0, nil, function()
    if self.callback ~= nil then
      self.callback()
    end
    self:Close()
  end)
end

return PopMsgPanel

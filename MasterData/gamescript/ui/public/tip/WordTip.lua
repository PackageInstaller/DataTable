local RectTransform = CS.UnityEngine.RectTransform
local typeof = _ENV.typeof
local Button = CS.UnityEngine.UI.Button
local WordTip, Super = System.NewClass("WordTip", UIBasePanel)
WordTip.uiResCls = UI_Common_Func_Tips_WordResource

function WordTip:ctor(data)
  Super.ctor(self)
  self.data = data
end

function WordTip:OnBind(binder)
  self.binder = binder
  if self.data.rootGameObject then
    TipsGenerateUtils.AdjustPosition(self.data.rootGameObject, self.ui.uiNode)
    self.button = self.data.rootGameObject:GetComponent(typeof(Button))
    self.button.enabled = false
  end
  binder:SetText(self.ui.Text_Title, self.data.title or "")
  binder:SetText(self.ui.Text_Desc_1, self.data.desc or "")
  binder:BindEvent(EventMgr.Instance.TouchBeginEvent, function()
    self:Close()
  end)
end

function WordTip:OnUnbind()
  if self.button then
    self.button.enabled = true
  end
end

function WordTip:OnMaskClicked()
  self.binder:teardown()
end

return WordTip

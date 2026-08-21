_class("UIWakeUpInfoSimple", UICustomWidget)
UIWakeUpInfoSimple = UIWakeUpInfoSimple

function UIWakeUpInfoSimple:OnShow()
  self._go = self:GetGameObject("go")
end

function UIWakeUpInfoSimple:SetData(friendid, fwakeup)
  self._go:SetActive(false)
end

function UIWakeUpInfoSimple:BtnOnClick(go)
end

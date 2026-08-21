_class("UIWakeUpSign", UICustomWidget)
UIWakeUpSign = UIWakeUpSign

function UIWakeUpSign:OnShow()
  self._go = self:GetGameObject("go")
  self:SetData()
end

function UIWakeUpSign:SetData()
  self._go:SetActive(false)
end

function UIWakeUpSign:WakeUpOnClick(go)
end

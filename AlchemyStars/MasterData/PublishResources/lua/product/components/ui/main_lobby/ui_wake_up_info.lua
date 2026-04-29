_class("UIWakeUpInfo", UICustomWidget)
UIWakeUpInfo = UIWakeUpInfo

function UIWakeUpInfo:OnShow()
  self._go = self:GetGameObject("go")
end

function UIWakeUpInfo:SetData(friendid, fwakeup)
  self._go:SetActive(false)
end

function UIWakeUpInfo:WakeUpOnClick(go)
end

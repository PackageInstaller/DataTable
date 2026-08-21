_class("UIWakeUpFriend", UICustomWidget)
UIWakeUpFriend = UIWakeUpFriend

function UIWakeUpFriend:OnShow()
  self._go = self:GetGameObject("go")
end

function UIWakeUpFriend:SetData(friendData, mgr, txtWidth)
  self._go:SetActive(false)
end

function UIWakeUpFriend:BtnOnClick(go)
end

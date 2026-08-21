_class("UIHeartItemStar", UICustomWidget)
UIHeartItemStar = UIHeartItemStar

function UIHeartItemStar:Constructor()
end

function UIHeartItemStar:SetData(sp)
  self._starImg = self:GetUIComponent("Image", "img")
  self._starImg.sprite = sp
end

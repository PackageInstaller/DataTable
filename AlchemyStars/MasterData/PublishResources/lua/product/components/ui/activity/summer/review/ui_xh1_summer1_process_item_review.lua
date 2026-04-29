_class("UIXH1Summer1ProcessItemReview", UICustomWidget)
UIXH1Summer1ProcessItemReview = UIXH1Summer1ProcessItemReview

function UIXH1Summer1ProcessItemReview:OnShow()
  self._hasGet = self:GetGameObject("HasGet")
  self._lastCanGet = self:GetGameObject("LastCanGet")
  self._unComplete = self:GetGameObject("UnComplete")
end

function UIXH1Summer1ProcessItemReview:SetData(summer, data)
  self._summer = summer
  self._data = data
  self._hasGet:SetActive(false)
  self._lastCanGet:SetActive(false)
  self._unComplete:SetActive(false)
  if self._data.status == 1 then
    self._hasGet:SetActive(true)
  elseif self._data.status == 2 then
    self._lastCanGet:SetActive(true)
  elseif self._data.status == 3 then
    self._unComplete:SetActive(true)
  end
end

function UIXH1Summer1ProcessItemReview:CanGetOnClick()
end

function UIXH1Summer1ProcessItemReview:LastCanGetOnClick()
end

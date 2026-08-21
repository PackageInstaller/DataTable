_class("UIWidgetPopStarMarkInfo", UICustomWidget)
UIWidgetPopStarMarkInfo = UIWidgetPopStarMarkInfo

function UIWidgetPopStarMarkInfo:OnShow()
  self._rtMark = self:GetGameObject().transform
  self._markInfo = self:GetGameObject("markInfo")
  self._markedInfo = self:GetGameObject("markedInfo")
  self._txtMarkScore = self:GetUIComponent("UILocalizationText", "txtMarkScore")
  self._txtMarkedScore = self:GetUIComponent("UILocalizationText", "txtMarkedScore")
  self._baseNum = 0
  self._passed = false
end

function UIWidgetPopStarMarkInfo:Init(posX, num)
  local tmpPos = self._rtMark.anchoredPosition3D
  tmpPos.x = posX
  self._rtMark.anchoredPosition3D = tmpPos
  self._txtMarkScore:SetText(tostring(num))
  self._txtMarkedScore:SetText(tostring(num))
  self._baseNum = num
  self._passed = false
end

function UIWidgetPopStarMarkInfo:RefreshPassState(num)
  if self._passed == true then
    return
  end
  if num >= self._baseNum then
    self._markInfo:SetActive(false)
    self._markedInfo:SetActive(true)
  end
end

function UIWidgetPopStarMarkInfo:ResetNum(num)
  self._txtMarkScore:SetText(tostring(num))
  self._txtMarkedScore:SetText(tostring(num))
  self._baseNum = num
  self._passed = false
  self._markInfo:SetActive(true)
  self._markedInfo:SetActive(false)
end

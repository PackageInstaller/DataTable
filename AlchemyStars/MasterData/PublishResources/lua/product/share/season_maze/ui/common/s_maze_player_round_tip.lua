_class("UISeasonMazeRoundTip", UICustomWidget)
UISeasonMazeRoundTip = UISeasonMazeRoundTip

function UISeasonMazeRoundTip:OnShow()
  self._root = self:GetGameObject("Root")
  self._transform = self:GetUIComponent("RectTransform", "Root")
  self._text = self:GetUIComponent("UILocalizationText", "count")
  self._rect = self._transform.parent
  self._offset = Vector2(0, 20)
  self._uiCam = GameGlobal.UIStateManager():GetControllerCamera(self.uiOwner:GetName())
  self:DoHide()
end

function UISeasonMazeRoundTip:OnHide()
  self:DoHide()
end

function UISeasonMazeRoundTip:UpdatePos(playerPos)
  local point = self._mainCam:WorldToScreenPoint(playerPos)
  local res, pos = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(self._rect, point, self._uiCam, nil)
  self._transform.anchoredPosition = pos + self._offset
end

function UISeasonMazeRoundTip:ChangeRound(round)
  self._text:SetText(round)
end

function UISeasonMazeRoundTip:DoShow(mainCam, playerPos, count)
  self._mainCam = mainCam
  self:UpdatePos(playerPos)
  self:ChangeRound(count)
  self._root:SetActive(true)
end

function UISeasonMazeRoundTip:DoHide()
  self._mainCam = nil
  self._root:SetActive(false)
end

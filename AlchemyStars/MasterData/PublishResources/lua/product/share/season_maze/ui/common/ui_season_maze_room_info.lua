_class("UISeasonMazeRoomInfo", UICustomWidget)
UISeasonMazeRoomInfo = UISeasonMazeRoomInfo

function UISeasonMazeRoomInfo:InitWidget()
  self._titleTex = self:GetUIComponent("UILocalizationText", "title")
  self._descTex = self:GetUIComponent("UILocalizationText", "desc")
  self._panel = self:GetUIComponent("RectTransform", "panel")
  self._Pos = self:GetUIComponent("RectTransform", "Pos")
  self._rect = self:GetUIComponent("RectTransform", "UISeasonMazeRoomInfo")
  self._Go = self:GetGameObject("Go")
  self._Go:SetActive(false)
  self._isOpen = false
  self._anim = self:GetUIComponent("Animation", "UISeasonMazeRoomInfo")
end

function UISeasonMazeRoomInfo:OnShow(uiParams)
  self:InitWidget()
end

function UISeasonMazeRoomInfo:SetData(pos, title, desc)
  self._pos = pos
  self._titleTex:SetText(StringTable.Get(title))
  self._descTex:SetText(StringTable.Get(desc))
  local pivot
  local offset = Vector2(0, 0)
  if 0 < pos.x and 0 < pos.y then
    pivot = Vector2(1, 1)
  elseif 0 > pos.x and 0 > pos.y then
    pivot = Vector2(0, 0)
  elseif 0 < pos.x and 0 > pos.y then
    pivot = Vector2(1, 0)
  else
    pivot = Vector2(0, 1)
  end
  self._panel.pivot = pivot
  self._panel.anchoredPosition = offset
  self._Pos.anchoredPosition = self._pos
  self._Go:SetActive(true)
  self._isOpen = true
  self._anim:Play("uieffanim_UISeasonMazeRoomInfo_in")
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
  end
  self:Lock("UISeasonMazeRoomInfo:InAnim")
  self._timer = GameGlobal.Timer():AddEvent(333, function()
    self:UnLock("UISeasonMazeRoomInfo:InAnim")
  end)
end

function UISeasonMazeRoomInfo:OnHide()
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
  end
  self:UnLock("UISeasonMazeRoomInfo:InAnim")
  self:UnLock("UISeasonMazeRoomInfo:OutAnim")
end

function UISeasonMazeRoomInfo:PassEventOnClick(go)
  self._anim:Play("uieffanim_UISeasonMazeRoomInfo_out")
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
  end
  self:Lock("UISeasonMazeRoomInfo:OutAnim")
  self._timer = GameGlobal.Timer():AddEvent(333, function()
    self:UnLock("UISeasonMazeRoomInfo:OutAnim")
    self._Go:SetActive(false)
    self._isOpen = false
  end)
end

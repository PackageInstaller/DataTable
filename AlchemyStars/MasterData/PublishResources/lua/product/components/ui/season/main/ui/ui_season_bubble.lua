_class("UISeasonBubble", UIController)
UISeasonBubble = UISeasonBubble

function UISeasonBubble:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UISeasonBubble:OnShow(uiParams)
  self._bubbles = uiParams[1]
  self._eventPoint = uiParams[2]
  self._callBack = uiParams[3]
  self._offsetX = 128
  self._index = 1
  self:_GetComponents()
  self:_OnValue()
end

function UISeasonBubble:_GetComponents()
  self._animation = self:GetUIComponent("Animation", "Animation")
  self._dialogLeftGO = self:GetGameObject("DialogLeft")
  self._dialogLeftRect = self:GetUIComponent("RectTransform", "DialogLeft")
  self._contentLeft = self:GetUIComponent("UILocalizationText", "ContentLeft")
  self._dialogRightGO = self:GetGameObject("DialogRight")
  self._dialogRightRect = self:GetUIComponent("RectTransform", "DialogRight")
  self._contentRight = self:GetUIComponent("UILocalizationText", "ContentRight")
end

function UISeasonBubble:_OnValue()
  self._seasonManager = self:GetUIModule(SeasonModule):SeasonManager()
  self._player = self._seasonManager:SeasonPlayerManager():GetPlayer()
  self._camera = self._seasonManager:SeasonCameraManager():Camera()
  self:_RefershText()
end

function UISeasonBubble:_RefershText()
  local bubble = self._bubbles[self._index]
  if bubble then
    local text = bubble.text
    local bubbleType = bubble.type
    local offset = Vector2(0, 0)
    if bubble.offset then
      offset.x = bubble.offset.x or 0
      offset.y = bubble.offset.y or 0
    end
    local bubbleObject, dialogGO, dialogRect, content
    if bubbleType == SeasonBubbleObjectType.EventPoint then
      bubbleObject = self._eventPoint
      if self._eventPoint:Position().x >= self._player:Position().x then
        offset.x = offset.x + self._offsetX
        dialogGO = self._dialogLeftGO
        dialogRect = self._dialogLeftRect
        content = self._contentLeft
        self._dialogRightGO:SetActive(false)
      else
        offset.x = offset.x - self._offsetX
        dialogGO = self._dialogRightGO
        dialogRect = self._dialogRightRect
        content = self._contentRight
        self._dialogLeftGO:SetActive(false)
      end
    else
      bubbleObject = self._player
      if self._player:Position().x >= self._eventPoint:Position().x then
        offset.x = offset.x + self._offsetX
        dialogGO = self._dialogLeftGO
        dialogRect = self._dialogLeftRect
        content = self._contentLeft
        self._dialogRightGO:SetActive(false)
      else
        offset.x = offset.x - self._offsetX
        dialogGO = self._dialogRightGO
        dialogRect = self._dialogRightRect
        content = self._contentRight
        self._dialogLeftGO:SetActive(false)
      end
    end
    local point = self._camera:WorldToScreenPoint(bubbleObject:Position())
    local res, pos = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(dialogRect.parent.parent, point, GameGlobal.UIStateManager():GetControllerCamera("UISeasonBubble"), nil)
    dialogRect.anchoredPosition = pos + offset
    content:SetText(StringTable.Get(text))
    dialogGO:SetActive(true)
  end
end

function UISeasonBubble:NextBtnOnClick(go)
  self._index = self._index + 1
  if self._index <= #self._bubbles then
    self:_RefershText()
  else
    self:Close()
  end
end

function UISeasonBubble:Close()
  self:Lock("UISeasonBubbleClose")
  self:StartTask(function(TT)
    self._animation:Play("uianim_UISeasonBubble_out")
    YIELD(TT, 500)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UISeasonBubble)
    self:CloseDialog()
    if self._callBack then
      self._callBack({})
    end
    self:UnLock("UISeasonBubbleClose")
  end)
end

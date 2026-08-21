_class("UIGuideModelController", UIController)
UIGuideModelController = UIGuideModelController

function UIGuideModelController:Constructor()
end

function UIGuideModelController:OnShow(uiParams)
  self.fingerRect = self:GetUIComponent("RectTransform", "finger")
  self.btn = self:GetUIComponent("RectTransform", "btn")
  self.target = uiParams[1]
  self.entityId = uiParams[2]
  self.entityType = uiParams[3]
  local onShowEnd = uiParams[4]
  if not self.entityId then
    return
  end
  self:ResetPos()
  if onShowEnd then
    onShowEnd()
  end
  self:AttachEvent(GameEventType.UIBlackChange, self.ResetPos)
end

function UIGuideModelController:ResetPos()
  local pos = self:ConvertScreentPos(self.target)
  self.fingerRect.anchoredPosition = pos
  self.btn.anchoredPosition = pos
end

function UIGuideModelController:ConvertScreentPos(target)
  local screenPos = InnerGameHelperRender.WorldPos2ScreenPos(target.position)
  local sw = ResolutionManager.ScreenWidth()
  local rw = ResolutionManager.RealWidth()
  local factor = rw / sw
  local sx, sy = screenPos.x * factor, screenPos.y * factor
  screenPos = Vector2(sx, sy)
  return screenPos
end

function UIGuideModelController:OnHide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.FinishGuideStep, GuideType.Entity)
end

function UIGuideModelController:BtnOnClick()
  if self.entityType == GuideModelType.Monster then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideChangeGhostLayer)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideMonsterClick, self.entityId)
  elseif self.entityType == GuideModelType.Trap then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideChangeGhostLayer)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UITrapSkillVisible, true, self.entityId)
  elseif self.entityType == GuideModelType.ChessPet then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideChangeGhostLayer)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideChessClick, self.entityId)
  elseif self.entityType == GuideModelType.ChessMonster then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideChangeGhostLayer)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideChessClick, self.entityId)
  end
  self:CloseDialog()
end

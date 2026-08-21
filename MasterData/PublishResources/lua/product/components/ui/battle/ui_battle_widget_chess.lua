local ChessPanelState = {
  Move = 1,
  Attack = 2,
  Skip = 3,
  FinishTurnOnly = 4,
  HideAll = 5,
  Recover = 6,
  MAX = 9
}
_enum("UIBattleWidgetChessState", ChessPanelState)
_class("UIBattleWidgetChess", UICustomWidget)
UIBattleWidgetChess = UIBattleWidgetChess

function UIBattleWidgetChess:_SubscribeGameEvent()
  self:AttachEvent(GameEventType.ChessUIStateTransit, self._OnStateTransit)
  self:AttachEvent(GameEventType.ChessUIStateBlockRaycast, self._OnBlockRaycast)
end

function UIBattleWidgetChess:_UnsubscribeGameEvent()
  self:DetachEvent(GameEventType.ChessUIStateTransit, self._OnStateTransit)
  self:DetachEvent(GameEventType.ChessUIStateBlockRaycast, self._OnBlockRaycast)
end

function UIBattleWidgetChess:FetchGameObjects()
  self._goMoveBtn = self:GetGameObject("MoveBtn")
  self._goAttackBtn = self:GetGameObject("AttackBtn")
  self._goSkipBtn = self:GetGameObject("SkipBtn")
  self._goFinishTurnBtn = self:GetGameObject("FinishTurnBtn")
  self._csCanvasGroup = self:GetGameObject():GetComponent("CanvasGroup")
  self._goTextAttack = self:GetGameObject("TextAttack")
  self._goTextRecover = self:GetGameObject("TextRecover")
end

function UIBattleWidgetChess:MoveBtnOnClick()
  if not self._responseClickEvent then
    Log.info(self._className, "MoveBtnOnClick skipped because self._responseClickEvent is false. ")
    return
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ChessUIInputMoveAction)
end

function UIBattleWidgetChess:AttackBtnOnClick()
  if not self._responseClickEvent then
    Log.info(self._className, "AttackBtnOnClick skipped because self._responseClickEvent is false. ")
    return
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ChessUIInputAttackAction)
end

function UIBattleWidgetChess:SkipBtnOnClick()
  if not self._responseClickEvent then
    Log.info(self._className, "SkipBtnOnClick skipped because self._responseClickEvent is false. ")
    return
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ChessUIInputSkipAction)
end

function UIBattleWidgetChess:FinishTurnBtnOnClick()
  if not self._responseClickEvent then
    Log.info(self._className, "FinishTurnBtnOnClick skipped because self._responseClickEvent is false. ")
    return
  end
  PopupManager.Alert("UIChessEndRoundMessageBox", PopupPriority.Normal, function()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ChessUIInputFinishTurnAction)
  end)
end

function UIBattleWidgetChess:_OnStateTransit(state)
  if state == UIBattleWidgetChessState.Move then
    self._goMoveBtn:SetActive(true)
    self._goAttackBtn:SetActive(false)
    self._goSkipBtn:SetActive(false)
    self._goFinishTurnBtn:SetActive(true)
  elseif state == UIBattleWidgetChessState.Attack then
    self._goMoveBtn:SetActive(false)
    self._goAttackBtn:SetActive(true)
    self._goSkipBtn:SetActive(false)
    self._goFinishTurnBtn:SetActive(true)
    self._goTextAttack:SetActive(true)
    self._goTextRecover:SetActive(false)
  elseif state == UIBattleWidgetChessState.Recover then
    self._goMoveBtn:SetActive(false)
    self._goAttackBtn:SetActive(true)
    self._goSkipBtn:SetActive(false)
    self._goFinishTurnBtn:SetActive(true)
    self._goTextAttack:SetActive(false)
    self._goTextRecover:SetActive(true)
  elseif state == UIBattleWidgetChessState.Skip then
    self._goMoveBtn:SetActive(false)
    self._goAttackBtn:SetActive(false)
    self._goSkipBtn:SetActive(true)
    self._goFinishTurnBtn:SetActive(true)
  elseif state == UIBattleWidgetChessState.FinishTurnOnly then
    self._goMoveBtn:SetActive(false)
    self._goAttackBtn:SetActive(false)
    self._goSkipBtn:SetActive(false)
    self._goFinishTurnBtn:SetActive(true)
  elseif state == UIBattleWidgetChessState.HideAll then
    self._goMoveBtn:SetActive(false)
    self._goAttackBtn:SetActive(false)
    self._goSkipBtn:SetActive(false)
    self._goFinishTurnBtn:SetActive(false)
  end
end

function UIBattleWidgetChess:_OnBlockRaycast(isBlockRaycast)
  if not self._csCanvasGroup then
    return
  end
  self._responseClickEvent = isBlockRaycast
  Log.info(self._className, "responseClickEvent changed from ", tostring(self._responseClickEvent), " to ", tostring(isBlockRaycast))
end

function UIBattleWidgetChess:OnShow(params)
  self:FetchGameObjects()
  self:_SubscribeGameEvent()
  self._goMoveBtn:SetActive(false)
  self._goAttackBtn:SetActive(false)
  self._goSkipBtn:SetActive(false)
  self._responseClickEvent = true
end

function UIBattleWidgetChess:OnHide()
  self:_UnsubscribeGameEvent()
end

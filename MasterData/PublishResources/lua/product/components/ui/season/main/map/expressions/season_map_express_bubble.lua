_class("SeasonMapExpressBubble", SeasonMapExpressBase)
SeasonMapExpressBubble = SeasonMapExpressBubble

function SeasonMapExpressBubble:Constructor(cfg, eventPoint)
  self._content = self._cfg.Bubble
  self._autoBinder = AutoEventBinder:New(GameGlobal.EventDispatcher())
end

function SeasonMapExpressBubble:Update(deltaTime)
end

function SeasonMapExpressBubble:Dispose()
  self.super.Dispose(self)
  self._autoBinder:UnBindAllEvents()
end

function SeasonMapExpressBubble:OnPlay()
  self._state = SeasonExpressState.Playing
  local topui = GameGlobal.UIStateManager():IsTopUI(UISeasonHelper.CurSeasonSceneUI())
  if topui then
    self:_ShowBubble()
  else
    self._autoBinder:BindEvent(GameEventType.SeasonTryShowEventBubble, self, self._ShowBubble)
    local uiSeasonModule = GameGlobal.GetUIModule(SeasonModule)
    uiSeasonModule:AppendWaitShowBubbleCallback(self)
  end
end

function SeasonMapExpressBubble:_ShowBubble()
  self._autoBinder:UnBindAllEvents()
  GameGlobal.UIStateManager():ShowDialog("UISeasonBubble", self._content, self._eventPoint, function()
    self:Next()
  end)
end

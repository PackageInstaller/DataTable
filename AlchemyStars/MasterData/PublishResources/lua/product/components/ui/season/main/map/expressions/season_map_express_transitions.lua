_class("SeasonMapExpressTransitions", SeasonMapExpressBase)
SeasonMapExpressTransitions = SeasonMapExpressTransitions

function SeasonMapExpressTransitions:Constructor(cfg, eventPoint)
  self._content = self._cfg.Transitions
  self._seasonManager = GameGlobal.GetUIModule(SeasonModule):SeasonManager()
  self._controllerName = "UISeasonTransitions"
  self._controller = nil
end

function SeasonMapExpressTransitions:Update(deltaTime)
end

function SeasonMapExpressTransitions:OnPlay()
  if self._content ~= nil then
    self._controller = nil
    self._state = SeasonExpressState.Playing
    if self._content == true then
      GameGlobal.UIStateManager():ShowDialog(self._controllerName, function()
        self:Next()
      end)
    elseif self._content == false then
      self._controller = GameGlobal.UIStateManager():GetController(self._controllerName)
      if self._controller then
        self._controller:Close(function()
          self._controller:CloseDialog()
          self._controller = nil
          self:Next()
        end)
      end
    end
  end
end

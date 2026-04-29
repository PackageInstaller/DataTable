_class("SeasonMapExpressUI", SeasonMapExpressBase)
SeasonMapExpressUI = SeasonMapExpressUI

function SeasonMapExpressUI:Constructor(cfg, eventPoint)
  self._content = self._cfg.UI
  self._seasonManager = GameGlobal.GetUIModule(SeasonModule):SeasonManager()
end

function SeasonMapExpressUI:Update(deltaTime)
end

function SeasonMapExpressUI:OnPlay()
  if self._content then
    self._state = SeasonExpressState.Playing
    GameGlobal.UIStateManager():ShowDialog(self._content, self._eventPoint, function(success)
      self:_OnCallBack(success)
    end)
  end
end

function SeasonMapExpressUI:_OnCallBack(success)
  if success then
    self:Next()
  else
    self._eventPoint:InterruptExpress()
  end
end

_class("SeasonMapExpressFunction", SeasonMapExpressBase)
SeasonMapExpressFunction = SeasonMapExpressFunction

function SeasonMapExpressFunction:Constructor(cfg, eventPoint)
  self._content = self._cfg.Function
  self._seasonManager = GameGlobal.GetUIModule(SeasonModule):SeasonManager()
end

function SeasonMapExpressFunction:Update(deltaTime)
end

function SeasonMapExpressFunction:OnPlay()
  if self._content then
    local signType = self._content.type
    if signType == SeasonExpressTiming.Play then
      local seasonUI = self._seasonManager:SeasonUIManager():UI()
      local show = self._content.show
      if show then
        seasonUI:AddFunction(self._eventPoint, self)
      else
        seasonUI:RemoveFunction(self._eventPoint)
      end
    end
    self:Next()
  end
end

_class("SeasonMapExpressSign", SeasonMapExpressBase)
SeasonMapExpressSign = SeasonMapExpressSign

function SeasonMapExpressSign:Constructor(cfg, eventPoint)
  self._content = self._cfg.Sign
  self._seasonManager = GameGlobal.GetUIModule(SeasonModule):SeasonManager()
end

function SeasonMapExpressSign:Update(deltaTime)
end

function SeasonMapExpressSign:OnPlay()
  if self._content then
    local signType = self._content.type
    if signType == SeasonExpressTiming.Play then
      local seasonUI = self._seasonManager:SeasonUIManager():UI()
      local show = self._content.show
      if show then
        seasonUI:AddSign(self._eventPoint, self)
      else
        seasonUI:RemoveSign(self._eventPoint)
      end
    end
    self:Next()
  end
end
